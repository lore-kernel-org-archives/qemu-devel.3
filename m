Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0533DC79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ali-0002y0-Bh; Mon, 07 Sep 2026 10:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3alg-0002uy-SL
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3alf-0001jz-Az
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788792978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6fC4NBMZFTC/aEcsP28QjvYR9RfzpgFrw9mQ9aSPQK0=;
 b=QxEV6Osd1bY8zf7E9eoYDhELFOsWRCFWPEIMP51z3Zsu1a9liRrZzAQxQL0TlkgGE7LWkR
 9YnT+lY+zlYEh+RsBth/wPleL+cCPffECOxeMjvBEj9Ff+loTfgxjUQQ574YgFy5FJXvO8
 soDoAtceiejn1PT2bR14+SpDKqYqyeA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-iMy_4FyjNqKf_UPOA57rDA-1; Mon, 07 Sep 2026 10:56:17 -0400
X-MC-Unique: iMy_4FyjNqKf_UPOA57rDA-1
X-Mimecast-MFC-AGG-ID: iMy_4FyjNqKf_UPOA57rDA_1788792976
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-485866e0066so2003528f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 07:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788792976; x=1789397776; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6fC4NBMZFTC/aEcsP28QjvYR9RfzpgFrw9mQ9aSPQK0=;
 b=d6+Id8rJ5uuh731KBXeAYGyaAFlYp9vPeFxM18nfxXjOQKEpv9hOIj4VzPjbAkpMIj
 rQvONK5uLh1ZlKjqIqJayZvc+MN0dimCDDjeZ05BY9AQ7nV9L7Fi3zfMYNzvrPkCqMW7
 HXlKP4jFe5raHxhEdnQp/zsLxvmXIYmtNLgt9yNQrItBr5yzUw1k+0gyPuHDQfqM2r1d
 mGlxFvlWvlP7nQgXsM5S4I1NcUMzqaxC2vdGGivPHjUSoU8dSeNiUtTQxmGxc3u6XYSk
 zKsjwZkvNrADHWvppNkBx2SLy3qUTV2FHpBs+TMwk3bBrl8hUSztU6QS37iKfFGxsadh
 b6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788792976; x=1789397776;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6fC4NBMZFTC/aEcsP28QjvYR9RfzpgFrw9mQ9aSPQK0=;
 b=QJyCGcKDgyqDfmZsUz0/wYS6FP+XBb8zfGB9IJ9DW6Wec5zHOaXUZ+FMnRxfmW9Hay
 jzJBGW7G/ZqeMkWKNnKjpIMLlr2yTQP+BenEgLre/5hnCEv0B3HhQkaNcZoIGZ9EY4jE
 OYSA6o4+MlYQGwKE5US1KrLEZHx9pEGoW7CC7xNeOw/mfrFQ1ejZFC6QrUgGhyIQyzka
 ELHrxln2TEIzELVLlAgpxvD2JZ7CFiHUhUKaNb9nc7Rp3vDtIVdsxzuvyiujmPsktEJG
 J26YumFkb+IGDeflMYoTRcbrJlsIrF/Wfi1qzMaZcDgqQU8nBDfvxT9Bf8K0irFBmE4J
 mX9w==
X-Gm-Message-State: AFuF++mm4LhrpcAYMJWRmZtQu/NsbpDfQDL0SeDIw1gIjEIiSP7BHLNE
 c67hrc03mHqjz+lAK/z1UwL2cq/OZ7+DSsLBWP5AdHNUBP69AWDzJkp9S+6qWB7n6cmQLg/QA8c
 ly++k/fdCd0LG7UqBbPSqNdLzn+sdlJI7eC/DluPhrDTEFgw8V2pokShR
X-Gm-Gg: AYBFou38Vs0UuvrcDfpEP0rS6o+HagpX7o0dXuz1tFaDL4PYBNAsBfr6MOjYH39Kiq6
 CjxRq0LsREHD04Vy6Uj7Lwkskmj/M2MZRyiZF7kFrKhyMCk8Qkbd6V8jkaGM7Ynulgo6lv3zE9e
 CrgkMXGjMMOre8Q4DuhEJUAHRfudhtx3WDyQ6gxAlm77BKoVAQXqnEj1ofFi5IgcJXjJbEzA3Gz
 zu77XiqznxU2CIJ28IB/jlX38Pf9cGZJSODYPxns2vH7UnDEtz7hX7vzf1xtTLQ1VWm7DgmSqbw
 X8IrKD+5hogmLn7eY3rXlG/EK5CLtvbCweTeO0gO2mLdp/hyfmXP6w7Pnp+bWb6sZYw1bDdem7a
 9NC05XxCudpDrwTpxwkPgJz/EKD9xE6YML8ng8OLYya0xsw==
X-Received: by 2002:a05:600c:4e49:b0:49c:fa20:cc05 with SMTP id
 5b1f17b1804b1-49cfa20ccd2mr214036985e9.28.1788792976159; 
 Mon, 07 Sep 2026 07:56:16 -0700 (PDT)
X-Received: by 2002:a05:600c:4e49:b0:49c:fa20:cc05 with SMTP id
 5b1f17b1804b1-49cfa20ccd2mr214036615e9.28.1788792975725; 
 Mon, 07 Sep 2026 07:56:15 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7740d44sm692396245e9.15.2026.09.07.07.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:56:15 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:56:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v4 07/10] vhost: make vhost_dev_cleanup() safe on a
 partially initialized device
Message-ID: <ap7IX4xa8nXsWkJU@sgarzare-redhat>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-8-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820113955.509478-8-andrey.drobyshev@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 20, 2026 at 02:39:52PM +0300, Andrey Drobyshev wrote:
>A device which only went through vhost_dev_init_backend() has its VQs
>not yet initialized, so vq->dev is NULL and vhost_virtqueue_cleanup()
>would crash dereferencing it.  Check vq->dev before use, so that
>vhost_dev_cleanup() can be called to release a device whose full
>vhost_dev_init() never ran or failed along the way.

Is this a fix for a current issue, a defensive programming measure, or 
something that might happen with future patches?

Stefano

>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index f9b54c46f93..2bb9a23fee4 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1648,7 +1648,7 @@ fail_call:
> static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
> {
>     event_notifier_cleanup(&vq->masked_notifier);
>-    if (vq->dev->vhost_ops->vhost_set_vring_err) {
>+    if (vq->dev && vq->dev->vhost_ops->vhost_set_vring_err) {
>         event_notifier_set_handler(&vq->error_notifier, NULL);
>         event_notifier_cleanup(&vq->error_notifier);
>     }
>-- 
>2.47.1
>


