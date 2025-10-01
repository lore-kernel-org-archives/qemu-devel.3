Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540B5CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 11:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3uZF-0001GG-L9; Wed, 01 Oct 2025 07:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3uZB-0001Bw-02
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3uZ1-0001mp-CQ
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 07:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759316398;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VvCinWwgJp5H1kvSqWagLQ5faZb6vvNkITJrOQKPhDE=;
 b=VU1PENi8kidA8r0ZmN5JEpvU2djYehAAhYsjQU+VyPOaLF0hwKPSs03UUtmmEPDpqJH4fI
 MB1XjwYSm4bMAP86bJF8CpylKiOcjtMNkg/7WicNM68Ls+FcqboDKiRW7+54CFh2ehoeE1
 dkCgkj1toiK4ZJGKzrLveIXwK8WlTjQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-bNH9KcqtNlitMQi6wNftYQ-1; Wed,
 01 Oct 2025 06:59:52 -0400
X-MC-Unique: bNH9KcqtNlitMQi6wNftYQ-1
X-Mimecast-MFC-AGG-ID: bNH9KcqtNlitMQi6wNftYQ_1759316390
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBD531956095; Wed,  1 Oct 2025 10:59:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C9B419560B4; Wed,  1 Oct 2025 10:59:41 +0000 (UTC)
Date: Wed, 1 Oct 2025 11:59:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Eric Blake <eblake@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 03/27] target/i386/mshv: Add x86 decoder/emu
 implementation
Message-ID: <aN0JmdP6tEwzpsDB@redhat.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-4-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916164847.77883-4-magnuskulke@linux.microsoft.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 16, 2025 at 06:48:23PM +0200, Magnus Kulke wrote:
> The MSHV accelerator requires a x86 decoder/emulator in userland to
> emulate MMIO instructions. This change contains the implementations for
> the generalized i386 instruction decoder/emulator.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  include/system/mshv.h           |  25 +++
>  target/i386/cpu.h               |   2 +-
>  target/i386/emulate/meson.build |   7 +-
>  target/i386/meson.build         |   2 +
>  target/i386/mshv/meson.build    |   7 +
>  target/i386/mshv/x86.c          | 297 ++++++++++++++++++++++++++++++++
>  6 files changed, 337 insertions(+), 3 deletions(-)
>  create mode 100644 include/system/mshv.h
>  create mode 100644 target/i386/mshv/meson.build
>  create mode 100644 target/i386/mshv/x86.c
> 

> diff --git a/target/i386/mshv/meson.build b/target/i386/mshv/meson.build
> new file mode 100644
> index 0000000000..8ddaa7c11d
> --- /dev/null
> +++ b/target/i386/mshv/meson.build
> @@ -0,0 +1,7 @@
> +i386_mshv_ss = ss.source_set()
> +
> +i386_mshv_ss.add(files(
> +  'x86.c',
> +))
> +
> +i386_system_ss.add_all(when: 'CONFIG_MSHV', if_true: i386_mshv_ss)

FYI, we expect the SPDX-License-Identifier to be present on
all new files[1] added to git, even if they're relatively simple
in some cases like this meson.build. 

If you run the series though checkpatch.pl it should tell
you which files you've missed.

With regards,
Daniel

[1] exception for non-plain text files, or if there's some reason it
    would cause problems.
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


