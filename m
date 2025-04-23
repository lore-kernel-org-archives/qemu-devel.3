Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D670C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ZYd-00034I-5g; Wed, 23 Apr 2025 08:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7ZYb-00033l-7b
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:50:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7ZYZ-0005wL-EC
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745412626;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=UOqMnGtAD0lTJdI183CFavq2pTBTxswM584NTKX/td4=;
 b=h6oItMd+LnDVNJGnE1Dd/aVVXE8be7UIhV/VHudzvmJ4FVsaIvKzFRMqtvMDc7F4BeAvEK
 AR9FqdP/JvBC9cWy8z67uIJEdZGqw4IgUux6uljmTmBODu6L+z4iybcJ/dPo8lRK6Nj+2Z
 QGn+JWbbxSc/ZhJmPE+8sE4/bOKMheU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-GkCJMVmDPPWYb7_EBp_oDg-1; Wed,
 23 Apr 2025 08:50:23 -0400
X-MC-Unique: GkCJMVmDPPWYb7_EBp_oDg-1
X-Mimecast-MFC-AGG-ID: GkCJMVmDPPWYb7_EBp_oDg_1745412622
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61CB4180010A; Wed, 23 Apr 2025 12:50:22 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.34])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9F5B1800361; Wed, 23 Apr 2025 12:50:20 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:50:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 7/9] h264: do not reduce vnc update speed while we
 have an active h264 stream
Message-ID: <aAjiCKCxhSzIf6lS@redhat.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-8-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418112953.1744442-8-dietmar@proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On Fri, Apr 18, 2025 at 01:29:51PM +0200, Dietmar Maurer wrote:

...the $SUBJECT says what it does, but the comment message ought
to describe why it is doing this too.

> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
> ---
>  ui/vnc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index feab4c0043..6db03a1550 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3222,6 +3222,7 @@ static void vnc_refresh(DisplayChangeListener *dcl)
>      VncDisplay *vd = container_of(dcl, VncDisplay, dcl);
>      VncState *vs, *vn;
>      int has_dirty, rects = 0;
> +    bool keep_dirty = false;
>  
>      if (QTAILQ_EMPTY(&vd->clients)) {
>          update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_MAX);
> @@ -3249,6 +3250,9 @@ static void vnc_refresh(DisplayChangeListener *dcl)
>                      vs->h264->keep_dirty--;
>                  }
>              }
> +            if (vs->h264->keep_dirty > 0) {
> +                keep_dirty = true;
> +            }
>          }
>  
>          int count = vnc_update_client(vs, client_dirty);
> @@ -3266,7 +3270,7 @@ static void vnc_refresh(DisplayChangeListener *dcl)
>          /* vs might be free()ed here */
>      }
>  
> -    if (has_dirty && rects) {
> +    if ((has_dirty && rects) || keep_dirty) {
>          vd->dcl.update_interval /= 2;
>          if (vd->dcl.update_interval < VNC_REFRESH_INTERVAL_BASE) {
>              vd->dcl.update_interval = VNC_REFRESH_INTERVAL_BASE;
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


