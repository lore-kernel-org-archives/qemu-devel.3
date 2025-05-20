Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AB3C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLYR-00022w-Fw; Tue, 20 May 2025 07:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHLYP-00022Z-BT
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHLYJ-0005L2-6y
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747742072;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SJJWNR3bcnYg4okhSNPb/Sxrjx87jHP8hiRZewbimuI=;
 b=S7vogzvx5WwVhMPipo2jUq3YCgYjTBWqqRgxtmMZRQD2nsy6sYX9He7pQQdbezoSMMuEBJ
 dXFDAYPPgj9HSpxXsHhAqlNs2R3Oj/G9o63b5aqSK3NDUFhb2DVDKbQV1V4bt8mWjLp1BE
 HRLsHM+ZohCPxugH6aza3xiBuyES9Jk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-aIuPCfthMEqEyI5M7n-Edg-1; Tue,
 20 May 2025 07:54:29 -0400
X-MC-Unique: aIuPCfthMEqEyI5M7n-Edg-1
X-Mimecast-MFC-AGG-ID: aIuPCfthMEqEyI5M7n-Edg_1747742067
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6998C180034E; Tue, 20 May 2025 11:54:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CB2B1800268; Tue, 20 May 2025 11:54:22 +0000 (UTC)
Date: Tue, 20 May 2025 12:54:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC PATCH 03/25] target/i386/mshv: Add x86 decoder/emu
 implementation
Message-ID: <aCxtas556Sg9i21n@redhat.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-4-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250520113018.49569-4-magnuskulke@linux.microsoft.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 20, 2025 at 01:29:56PM +0200, Magnus Kulke wrote:
> The MSHV accelerator requires a x86 decoder/emulator in userland to
> emulate MMIO instructions. This change contains the implementations for
> the generalized i386 instruction decoder/emulator.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  include/system/mshv.h           |  32 ++++
>  target/i386/cpu.h               |   2 +-
>  target/i386/emulate/meson.build |   7 +-
>  target/i386/meson.build         |   2 +
>  target/i386/mshv/meson.build    |   7 +
>  target/i386/mshv/x86.c          | 330 ++++++++++++++++++++++++++++++++
>  6 files changed, 377 insertions(+), 3 deletions(-)
>  create mode 100644 include/system/mshv.h
>  create mode 100644 target/i386/mshv/meson.build
>  create mode 100644 target/i386/mshv/x86.c
> 
> diff --git a/include/system/mshv.h b/include/system/mshv.h
> new file mode 100644
> index 0000000000..8380b92da2
> --- /dev/null
> +++ b/include/system/mshv.h
> @@ -0,0 +1,32 @@
> +/*
> + * QEMU MSHV support
> + *
> + * Copyright Microsoft, Corp. 2025
> + *
> + * Authors:
> + *  Ziqiao Zhou       <ziqiaozhou@microsoft.com>
> + *  Magnus Kulke      <magnuskulke@microsoft.com>
> + *  Jinank Jain       <jinankjain@microsoft.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.

FYI, for new files we now require use of SPDX-License-Identifier,
and omission of any manually written license boilerplate text.

checkpatch.pl is supposed to be warning about this, but it is
buggy & incomplete right now, but fixes for that are pending
to correctly warn about this.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


