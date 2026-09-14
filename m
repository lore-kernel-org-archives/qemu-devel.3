Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C46C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x68Ri-0003xz-Sg; Mon, 14 Sep 2026 11:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x68Rh-0003xf-5g
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:18:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x68Rf-00023W-Jc
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789399090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GS9eUqO7p/HuRp+PCiJRBduEpbk5WGGnRVVf5gt6+F8=;
 b=Fq61n4ssuDPvbZFG+IGt/iU+KEdSu+epnQDZP2P5nD3Mad8YLSC/uCrVbya35Yjt0aa+8B
 YQaVkDnifjOYBa5IYX/X++3jxrJoHZbf8L+bpxiDOeqybKUN2QZQMClFKREMh9RLOCypGe
 OKQVZBp9Hz5HwSR+Dx9b4ZbtD0hIN+M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-TSIBN6xcP2yUTMqcDw8VZA-1; Mon, 14 Sep 2026 11:18:09 -0400
X-MC-Unique: TSIBN6xcP2yUTMqcDw8VZA-1
X-Mimecast-MFC-AGG-ID: TSIBN6xcP2yUTMqcDw8VZA_1789399088
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49cd74fc1aaso16323085e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789399088; x=1790003888; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GS9eUqO7p/HuRp+PCiJRBduEpbk5WGGnRVVf5gt6+F8=;
 b=gc4PFPCZrYwIqwxMr++BNYr5lBHiNL0YRlEuSQTLO5t7F/e7M82EQzPLJVQ7ollBGf
 UcBog4ZkqVspQHieMbI5u+QF392b95q+FC+G6FXn4eAzfemfCZS2NRNQRRIRV/Ev3GYl
 MkuikAujhkuwQwoL8lTMaFJzsbqJPVYS/oYkt08bJ31LYcU/sVoysPLab3tigb/cCH2e
 Drow+x8qhldopW/aG5cjJhsY2kL51deQY1Rl0prWdkLELwvIcTcOqCy0NAV1RTkhFRPG
 IVOYJ8SpWRsC2yATMQij0aR3CmQB8ctY86a/thl/Z3/Ww2EfkBPwEDAbcmhRNCk43auP
 EUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789399088; x=1790003888;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GS9eUqO7p/HuRp+PCiJRBduEpbk5WGGnRVVf5gt6+F8=;
 b=DD3b/IZDqN/Ei/NTmWrws2lBzf0P5tZ6SNQMcoWPtpy8aTDBCw6HOP+vesjlvtoKp3
 R1TTIrw43ueXSSnxGufiLthGFObF55YLStCgG1boWVisiFIH3BKDxr0ZGY4C2N5XRX0X
 vHuUj5lcMLNqrxeNns2l+xP3021KlOZgZWbrrqVGsvzyr7Im/9ZtDDD4UP79qXGefabj
 tFlnQSigiSuGjXfuyxDxTaYQw78i1RiqNhZPMKISbJKx4m6bsCFELg8ymG+/TuN7raur
 /WbGngswcpENMs5l7nXwMrJJOoxpnZYm6Pxw8wDziQAP9gL2DMJm5gaNjJ/5Yqg1CKRl
 An3A==
X-Gm-Message-State: AFuF++m/2tUYgL+zz4raJA+3CEw/yV9zOS4TO9YQ/GYCY6tuYVNek5LQ
 zXpd5pmEoTVHotn9Im451chQ2jr9aLAY1zg/DYcYWISwSUEaJes7GpOvyjOixYnMgqy0EHwCd2f
 64IL4qX1KCX+0FXmexC0igQF0NfXd2xmHttgTesdk4oJjyuP4AjsJGQyjp1Lr2f+f
X-Gm-Gg: AYBFou0QEHwgHRKnhnGgp8gFPPe1sRp860bopzVw8fjYOZbz0mPLOeyODEJnrSXFcXP
 qeUo90Q6CvVNKB4nPmsnYcyS3mZ9fl4nD4FkOQmnvgsaFLr4JxCczP0AGSlZxInou77A4QTVFfU
 XzVVVgUAYZ6vX5G1jHbbtF0VBdhVDmzzPwQQhUGqAL24gkE4j4qCUlZMjOns+AEe/eYoXV8d2So
 kqgFoYbXMN9QlVkCl7Nm2dJf9vJKyI70tBaeYQoEU/X4Uu2eUc3kqH6+toALxZ7THNYVWicoCl1
 EFEmxwT7xM4gaEXYY/Zx9s7y9VKJ+5GkTNRt0Qxmgho4ZeBxw1Kv+5m9gQ2shAsfo85qe6j2lTY
 fztwfSlK2Fnh5zKEtRA6/ykzu41otLVZVWJHWsKs1c/dluw==
X-Received: by 2002:a05:600c:3583:b0:49e:645e:2616 with SMTP id
 5b1f17b1804b1-49e7a637631mr50343055e9.5.1789399088044; 
 Mon, 14 Sep 2026 08:18:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3583:b0:49e:645e:2616 with SMTP id
 5b1f17b1804b1-49e7a637631mr50342345e9.5.1789399087566; 
 Mon, 14 Sep 2026 08:18:07 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c2a419sm453015025e9.7.2026.09.14.08.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 08:18:07 -0700 (PDT)
Date: Mon, 14 Sep 2026 17:18:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, 
 farosas@suse.de, peterx@redhat.com, clg@redhat.com, dongli.zhang@oracle.com
Subject: Re: [PATCH v5 11/14] vhost: make vhost_dev_cleanup() safe on a
 partially initialized device
Message-ID: <aqgQI9BPXTTjN_tq@sgarzare-redhat>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
 <20260914-up-vsock-vhost-v5-v5-11-d17423589f48@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260914-up-vsock-vhost-v5-v5-11-d17423589f48@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 14, 2026 at 11:37:42AM +0300, Andrey Drobyshev wrote:
>A device which only went through vhost_dev_init_backend() has its VQs
>not yet initialized, so vq->dev is NULL and vhost_virtqueue_cleanup()
>would crash dereferencing it.  Check vq->dev before use, so that
>vhost_dev_cleanup() can be called to release a device whose full
>vhost_dev_init() never ran or failed along the way.
>
>As of now, there's no way for the cleanup path to be reached with
>vq->dev uninitialized.  However after a subsequent patch adding CPR
>support for vhost-vsock this'll become a possibility, so let's prevent
>such a crash beforehand.
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

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
>
>-- 
>2.47.1
>


