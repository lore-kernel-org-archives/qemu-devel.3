Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABCCC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Zff-0006i4-OA; Wed, 23 Apr 2025 08:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7ZfN-0006Wt-Ky
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:57:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u7ZfJ-0006XW-TH
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745413043;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OF7d6Xj9XeVKZb/X7Vn4mHNZGIZLJSHTFs0DzB/li8s=;
 b=Q71xoH0QHYvvJ2QLS7GQUGywOj2RdOl2I3ZdI/IhUt1bFVPeHAZkEFSl/qGRJGX59bRhP2
 lo+Fa6mVrr/lTfziGKbSrRNskyI42HFBSAJvvJzcgWN5aEvvbYruKvTbPernYsNYYYM3/0
 sB418lNdEhVq0knZ7n1taqIy3JvjYA0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-7zxjq_HePMWAv5i4PnTM8w-1; Wed,
 23 Apr 2025 08:57:21 -0400
X-MC-Unique: 7zxjq_HePMWAv5i4PnTM8w-1
X-Mimecast-MFC-AGG-ID: 7zxjq_HePMWAv5i4PnTM8w_1745413041
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F308719560B1; Wed, 23 Apr 2025 12:57:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.34])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6950B19560A3; Wed, 23 Apr 2025 12:57:18 +0000 (UTC)
Date: Wed, 23 Apr 2025 13:57:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 9/9] h264: register shutdown notifiers, stop pipeline
 in destroy_encoder_context
Message-ID: <aAjjq1wJcVfHhDVm@redhat.com>
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-10-dietmar@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250418112953.1744442-10-dietmar@proxmox.com>
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

On Fri, Apr 18, 2025 at 01:29:53PM +0200, Dietmar Maurer wrote:
> Some encoders can hang indefinetly (i.e. nvh264enc) if
> the pipeline is not stopped before it is destroyed
> (Observed on Debian bookworm).
> 
> Signed-off-by: Dietmar Maurer <dietmar@proxmox.com>
> ---
>  ui/vnc-enc-h264.c | 50 ++++++++++++++++++++++++++++++++++++++---------
>  ui/vnc.h          |  1 +
>  2 files changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/ui/vnc-enc-h264.c b/ui/vnc-enc-h264.c
> index 840674dbdb..9dbfba3a16 100644
> --- a/ui/vnc-enc-h264.c
> +++ b/ui/vnc-enc-h264.c
> @@ -23,6 +23,8 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "system/runstate.h"
> +
>  #include "vnc.h"
>  
>  #include <gst/gst.h>
> @@ -114,13 +116,33 @@ static GstElement *create_encoder(const char *encoder_name)
>      return encoder;
>  }
>  
> -static void destroy_encoder_context(VncState *vs)
> +static void destroy_encoder_context(VncH264 *h264)
>  {
> -    gst_clear_object(&vs->h264->source);
> -    gst_clear_object(&vs->h264->convert);
> -    gst_clear_object(&vs->h264->gst_encoder);
> -    gst_clear_object(&vs->h264->sink);
> -    gst_clear_object(&vs->h264->pipeline);
> +    GstStateChangeReturn state_change_ret;
> +
> +    g_assert(h264 != NULL);
> +
> +    VNC_DEBUG("Destroy h264 context.\n");
> +
> +    /*
> +     * Some encoders can hang indefinetly (i.e. nvh264enc) if
> +     * the pipeline is not stopped before it is destroyed
> +     * (Observed on Debian bookworm).
> +     */
> +    if (h264->pipeline != NULL) {
> +        state_change_ret = gst_element_set_state(
> +            h264->pipeline, GST_STATE_NULL);
> +
> +        if (state_change_ret == GST_STATE_CHANGE_FAILURE) {
> +            VNC_DEBUG("Unable to stop the GST pipeline\n");
> +        }
> +    }
> +
> +    gst_clear_object(&h264->source);
> +    gst_clear_object(&h264->convert);
> +    gst_clear_object(&h264->gst_encoder);
> +    gst_clear_object(&h264->sink);
> +    gst_clear_object(&h264->pipeline);
>  }
>  
>  static bool create_encoder_context(VncState *vs, int w, int h)
> @@ -132,7 +154,7 @@ static bool create_encoder_context(VncState *vs, int w, int h)
>  
>      if (vs->h264->sink) {
>          if (w != vs->h264->width || h != vs->h264->height) {
> -            destroy_encoder_context(vs);
> +            destroy_encoder_context(vs->h264);
>          }
>      }
>  
> @@ -239,10 +261,16 @@ static bool create_encoder_context(VncState *vs, int w, int h)
>      return TRUE;
>  
>   error:
> -    destroy_encoder_context(vs);
> +    destroy_encoder_context(vs->h264);
>      return FALSE;
>  }
>  
> +static void shutdown_h264(Notifier *n, void *opaque)
> +{
> +    VncH264 *h264 =  container_of(n, VncH264, shutdown_notifier);
> +    destroy_encoder_context(h264);
> +}
> +
>  bool vnc_h264_encoder_init(VncState *vs)
>  {
>      char *encoder_name;
> @@ -259,6 +287,8 @@ bool vnc_h264_encoder_init(VncState *vs)
>  
>      vs->h264 = g_new0(VncH264, 1);
>      vs->h264->encoder_name = encoder_name;
> +    vs->h264->shutdown_notifier.notify = shutdown_h264;
> +    qemu_register_shutdown_notifier(&vs->h264->shutdown_notifier);

This is broken - in some configurations, when a guest shutdown is
actioned, QEMU will merely pause guest CPU execution. The mgmt
app can then reset the machine and resume CPU execution. IOW you
can't assume QEMU is about to exit from a shutdown notifier.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


