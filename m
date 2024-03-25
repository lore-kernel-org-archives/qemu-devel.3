Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC9DC54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 08:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rogAj-0003p8-GC; Mon, 25 Mar 2024 04:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rogAf-0003oV-5k
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 04:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rogAd-0000Ja-Hf
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 04:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711357146;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TmnZwaZFKh8dM4EA8hMyleLduJ1AkTcDMTsM0Skr6Oc=;
 b=Bqz/zj4stgwoq5uj/fr941O+Fc26B6nGZGhPsmYtK+/l3aN3+W9st9wdW4bBB67PsynThT
 UqAkLm+uVdgVxZ4Nh+z2mYwmYs/2n+i6mDiBh7SQ+8cQG7iBayrYD0JdrrTMzC8ZfcBWzw
 5uTGeHcilrpY/I4MBBqvDFMVgfyPSeM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-XB1tzSA4Mbm-DEHPu1KLUw-1; Mon, 25 Mar 2024 04:59:04 -0400
X-MC-Unique: XB1tzSA4Mbm-DEHPu1KLUw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08147811E81;
 Mon, 25 Mar 2024 08:59:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00CF33C20;
 Mon, 25 Mar 2024 08:59:02 +0000 (UTC)
Date: Mon, 25 Mar 2024 08:58:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, michael.roth@amd.com,
 david@redhat.com
Subject: Re: [PATCH 11/26] runstate: skip initial CPU reset if reset is not
 actually possible
Message-ID: <ZgE8wBkz-G-cBYCp@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
 <20240322181116.1228416-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240322181116.1228416-12-pbonzini@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Mar 22, 2024 at 07:11:01PM +0100, Paolo Bonzini wrote:
> Right now, the system reset is concluded by a call to
> cpu_synchronize_all_post_reset() in order to sync any changes
> that the machine reset callback applied to the CPU state.
> 
> However, for VMs with encrypted state such as SEV-ES guests (currently
> the only case of guests with non-resettable CPUs) this cannot be done,
> because guest state has already been finalized by machine-init-done notifiers.
> cpu_synchronize_all_post_reset() does nothing on these guests, and actually
> we would like to make it fail if called once guest has been encrypted.
> So, assume that boards that support non-resettable CPUs do not touch
> CPU state and that all such setup is done before, at the time of
> cpu_synchronize_all_post_init().
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  system/runstate.c | 15 ++++++++++++++-
>  roms/edk2         |  2 +-
>  2 files changed, 15 insertions(+), 2 deletions(-)

Accidental submodule change here :

> diff --git a/roms/edk2 b/roms/edk2
> index edc6681206c..819cfc6b42a 160000
> --- a/roms/edk2
> +++ b/roms/edk2
> @@ -1 +1 @@
> -Subproject commit edc6681206c1a8791981a2f911d2fb8b3d2f5768
> +Subproject commit 819cfc6b42a68790a23509e4fcc58ceb70e1965e
> -- 
> 2.44.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


