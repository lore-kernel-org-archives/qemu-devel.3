Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F237C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqin-0000B3-3R; Tue, 13 May 2025 10:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEqil-0008W6-33
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uEqij-0008EG-8r
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747146900;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=FjeP5uamtaabe/ZeZC10KsaNZwk5FGaquTM1+X8OlNw=;
 b=AmVmzV9epb34yoDfJWB3logoHNjw/+5ZRGcPEeO6zvVcjFB5NmN+82DHmU7Vq4G36v3BEv
 jU0ImbeYCKSH8KjiM7to0sl2ZMKCUtJxPRddbka57TLtPl5ye8Pl01A70qw6k9LxQtzgTo
 B6xhsE86f/BdDard5A8aoHTYIKLenY8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-_6UdslWGN1SH5cxrWtUuYA-1; Tue,
 13 May 2025 10:34:55 -0400
X-MC-Unique: _6UdslWGN1SH5cxrWtUuYA-1
X-Mimecast-MFC-AGG-ID: _6UdslWGN1SH5cxrWtUuYA_1747146894
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D797195FCD0; Tue, 13 May 2025 14:34:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F8D41801490; Tue, 13 May 2025 14:34:51 +0000 (UTC)
Date: Tue, 13 May 2025 15:34:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 7/7] h264: stop gstreamer pipeline before destroying,
 cleanup on exit
Message-ID: <aCNYhxD4tn0f5_i5@redhat.com>
References: <20250430072524.3650582-1-dietmar@proxmox.com>
 <20250430072524.3650582-8-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250430072524.3650582-8-dietmar@proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Apr 30, 2025 at 09:25:24AM +0200, Dietmar Maurer wrote:
> Some encoders can hang indefinitely (i.e. nvh264enc) if
> the pipeline is not stopped before it is destroyed
> (Observed on Debian bookworm).
> 
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
> ---
>  include/system/system.h |  1 +
>  include/ui/console.h    |  1 +
>  system/runstate.c       |  2 ++
>  system/vl.c             |  7 +++++++
>  ui/vnc-enc-h264.c       | 18 ++++++++++++++++++
>  ui/vnc.c                | 15 +++++++++++++++
>  6 files changed, 44 insertions(+)
> 

> diff --git a/ui/vnc.c b/ui/vnc.c
> index c707b9da37..578d9eea32 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -4368,6 +4368,21 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
>      return 0;
>  }
>  
> +void vnc_cleanup(void)
> +{
> +    VncDisplay *vd;
> +    VncState *vs;
> +
> +    QTAILQ_FOREACH(vd, &vnc_displays, next) {
> +        QTAILQ_FOREACH(vs, &vd->clients, next) {
> +#ifdef CONFIG_GSTREAMER
> +            /* correctly close all h264 encoder pipelines */
> +            vnc_h264_clear(vs);
> +#endif

How is this safe to do ?

If we have an active client, we have to assume that the jobs
thread may be in the middle of processing an update, and thus
the jobs thread wil be using the h264 encoder. If we blindly
tear down the encoder I think we're liable to trigger
non-deterministic crashes in QEMU in the vnc jobs thread
accessing free'd memory.

> +        }
> +    }
> +}
> +
>  static void vnc_register_config(void)
>  {
>      qemu_add_opts(&qemu_vnc_opts);
> -- 
> 2.39.5
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


