Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD00BC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ZOU-00054J-W6; Wed, 23 Apr 2025 08:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7ZOR-00053Y-WA
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:40:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7ZOP-0004eA-Rz
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745411996;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=wvRBJvs4ci5b3FxM8rmAIPcxB0Hq6vFu6Tgl/VZMPsI=;
 b=J3YGGy3DumjsE9Fy5B+J++HHk54Rnt3ar2vSGMsTK9qOXjCiS6SdOMv2dNJ06Dd5s9Qtip
 IF0E6vC/4WWrfjwcj3/2WClRSLHKvoCzPjVjwPVHSAT9I1x6R/LvKquKjj3rL3kwAiouAK
 HHkbXQT7h+HeI2Tj5STmqb3V/50vff8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-o0-HoM46PIuYBo-0o0TRcQ-1; Wed,
 23 Apr 2025 08:39:55 -0400
X-MC-Unique: o0-HoM46PIuYBo-0o0TRcQ-1
X-Mimecast-MFC-AGG-ID: o0-HoM46PIuYBo-0o0TRcQ_1745411994
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE5B419560AE; Wed, 23 Apr 2025 12:39:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.34])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A646D19560A3; Wed, 23 Apr 2025 12:39:52 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:39:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/9] vnc: h264: send additional frames after the
 display is clean
Message-ID: <aAjflDpA9pi7mvNd@redhat.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-4-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418112953.1744442-4-dietmar@proxmox.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Fri, Apr 18, 2025 at 01:29:47PM +0200, Dietmar Maurer wrote:
> The H264 implementation only sends frames when it detects changes in
> the server's framebuffer. This leads to artifacts when there are no
> further changes, as the internal H264 encoder may still contain data.
> 
> This patch modifies the code to send a few additional frames in such
> situations to flush the H264 encoder data.
> 
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
> ---
>  ui/vnc.c | 25 ++++++++++++++++++++++++-
>  ui/vnc.h |  3 +++
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/ui/vnc.c b/ui/vnc.c
> index aed25b0183..badc7912c0 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -3239,7 +3239,30 @@ static void vnc_refresh(DisplayChangeListener *dcl)
>      vnc_unlock_display(vd);
>  
>      QTAILQ_FOREACH_SAFE(vs, &vd->clients, next, vn) {
> -        rects += vnc_update_client(vs, has_dirty);
> +        int client_dirty = has_dirty;
> +        if (vs->h264) {
> +            if (client_dirty) {
> +                vs->h264->keep_dirty = VNC_H264_KEEP_DIRTY;
> +            } else {
> +                if (vs->h264->keep_dirty > 0) {
> +                    client_dirty = 1;
> +                    vs->h264->keep_dirty--;
> +                }
> +            }
> +        }
> +
> +        int count = vnc_update_client(vs, client_dirty);
> +        rects += count;
> +
> +        if (vs->h264 && !count && vs->h264->keep_dirty) {
> +            VncJob *job = vnc_job_new(vs);
> +            int height = pixman_image_get_height(vd->server);
> +            int width = pixman_image_get_width(vd->server);
> +            vs->job_update = vs->update;
> +            vs->update = VNC_STATE_UPDATE_NONE;
> +            vnc_job_add_rect(job, 0, 0, width, height);
> +            vnc_job_push(job);
> +        }
>          /* vs might be free()ed here */

This comment is telling you that 'vnc_update_client' may have
released 'vs', and yet this code is referencing 'vs->...'
and so will be liable to crash.

>      }
>  

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


