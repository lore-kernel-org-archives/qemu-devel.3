Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCAEC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whjI9-0002i6-T2; Thu, 09 Jul 2026 03:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1whjI7-0002hJ-M9
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 03:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1whjI4-0003aA-L9
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 03:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783582522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F3TbgBxexNvJhwYsMNXXM+HsJSNWjWtxpQ3oWKMBQSA=;
 b=ey+1pdtJGFWeee/nlPu0pmiCtJ1gCWpkJoGHBqRm/1TU6abMDBz5avsUWeMD+ZkUwvBjYT
 rQ9MCeoBRbHpQtKifQFXrtRE/Cgq9Itzxiz+3i0nF3tx7tGShh3ARC3ReWmeWZqD4V7Ut7
 AAlcogS+hlbnWLAvUlX0Vw5aa7qYitI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-ix_Y-ICpNxiVTJ_wnng-9A-1; Thu, 09 Jul 2026 03:35:21 -0400
X-MC-Unique: ix_Y-ICpNxiVTJ_wnng-9A-1
X-Mimecast-MFC-AGG-ID: ix_Y-ICpNxiVTJ_wnng-9A_1783582520
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-493ee369b47so831225e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 00:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783582520; x=1784187320; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F3TbgBxexNvJhwYsMNXXM+HsJSNWjWtxpQ3oWKMBQSA=;
 b=BTylDN5qYvxsUqlvLXDPqaAxzX9WsvgYRBrRkOuuldgWoGc9a+KDaNE1h49WqzSq3o
 3dIr7gVAfeyvjDbNFHWFaLfC5LeQm6XFxJPZWMtJNVUr26vOcjKD/BDG6Ir2mpYgdkda
 JfgzLLmegrevuSdTXQNpth5ub1Lro9wZpQ80ek1TyJoDXmfuSj+pBJBkFelprJVZSD4G
 sdy+OfTYO5vgCqyNgauekhj2fO6mEioOFcCo0vEKkTopu341fmyqd00rw3NXUMkduIlv
 IXDm5VUvNs55HpUtQgfqm2JEYF6doUtSsXCuOkeiuppcJzaNelVXgL8JQVRfB5b9yAIH
 t7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783582520; x=1784187320;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F3TbgBxexNvJhwYsMNXXM+HsJSNWjWtxpQ3oWKMBQSA=;
 b=WkgOdTIGVXrc+IXcIet4NXMRVh9BAJNHPCycM+Gj4DDMgvXcTEtnIn8AdbTp8LzyPx
 PhaGwQU2IcEydQ9Y96xDRDReMyAdm3KUI0oCo6uvaX51+Gs0JgQYR0y4Eu8B3xEa/qmt
 +HWbjedlzYrdm/dCm1skoCZHmNZXCb85IcJnbGtHPdCUKs8nbOvx2/vIsZGiIjR/uO2d
 pywPGJcSfY2T45iNw3nDvNDP92sYLCSYe3sH8a/vp8gKDcQLGSQmP8lu9cBv3V0ISipt
 c6KrGeOrydin+14/RTW+BbIX+l+vaQU/BXPiSUoWAM4x2Vx7sbIPR/1fMpASyd9OK1MQ
 t/WA==
X-Gm-Message-State: AOJu0YxeztCJTN9MTxRUdJvjn/ln8fAAGHbxqPGNQRYoe9i05NDBlvQS
 S99C0In02ZEp/xmU4/uEiFyFFWpzxT82MYn8J3UV+wJhjvsy2gZ4B63eYrcBIpK047lV/DDXvqF
 4s+QwJLcnNq1fkHGFuFLthohFpqCv5Y3qiXdhShsrC4O64cIApnUdXftZ
X-Gm-Gg: AfdE7ckvw3J61cC/i5a2D2ZxrV/d6m+yII8krn6ugpSxj6phHkIhB7Byqze8OtRropP
 lujd4STM3Tt670MJ73vRXdJ5KzM0X9dK5tUtylGzixYd33bnYWoCxPUOWpvfP+E6aSFiIj0OsZr
 fbYwr8deXZ9uYez0NQz4ZpLe9AU6gQdNoYSDXg7AOeEU1fCsrosoNdKQlu22u4eadM4UCa8uPx3
 2FaiXfpls9WqLUzc3qtuRhKn6WHCTbbKyHDKKXu5N6Ri1oBoIbGHlemzzSaHCV0TdaVYukPacUC
 z+kY5VLkt3XV5InbKA3efJQKuusEtX3BaBGVKojhn8FDv6/lF+Xj9GPppvzD+Kaq/BbX2/n346y
 YRhNA4E51Km3b1eZH1sMLEoLVjLU508nC
X-Received: by 2002:a05:600c:c48f:b0:493:b811:e549 with SMTP id
 5b1f17b1804b1-493e8dfe724mr32304395e9.29.1783582520206; 
 Thu, 09 Jul 2026 00:35:20 -0700 (PDT)
X-Received: by 2002:a05:600c:c48f:b0:493:b811:e549 with SMTP id
 5b1f17b1804b1-493e8dfe724mr32304115e9.29.1783582519724; 
 Thu, 09 Jul 2026 00:35:19 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ff6casm49509805e9.5.2026.07.09.00.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 00:35:18 -0700 (PDT)
Date: Thu, 9 Jul 2026 03:35:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhaoguohan@kylinos.cn
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] hw/virtio/vdpa-dev: pass set_config buffer to vhost
 backend
Message-ID: <20260709033448-mutt-send-email-mst@kernel.org>
References: <20260709073225.2341642-1-zhaoguohan@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709073225.2341642-1-zhaoguohan@kylinos.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Thu, Jul 09, 2026 at 03:32:25PM +0800, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> vhost_vdpa_device_set_config() receives the updated config buffer, but
> forwards s->config to the vhost backend. Since s->config is refreshed by
> get_config(), it may contain stale backend state.
>


could you be a bit more specific pls? a real scenario where you
see an issue? thanks!
 
> Pass the supplied config buffer to vhost_dev_set_config() instead.
> 
> Fixes: b430a2bd2303 ("vdpa: add vdpa-dev support")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>  hw/virtio/vdpa-dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
> index 089a77f4d0b9..6dc684ab096a 100644
> --- a/hw/virtio/vdpa-dev.c
> +++ b/hw/virtio/vdpa-dev.c
> @@ -212,7 +212,7 @@ vhost_vdpa_device_set_config(VirtIODevice *vdev, const uint8_t *config)
>      VhostVdpaDevice *s = VHOST_VDPA_DEVICE(vdev);
>      int ret;
>  
> -    ret = vhost_dev_set_config(&s->dev, s->config, 0, s->config_size,
> +    ret = vhost_dev_set_config(&s->dev, config, 0, s->config_size,
>                                 VHOST_SET_CONFIG_TYPE_FRONTEND);
>      if (ret) {
>          error_report("set device config space failed");
> -- 
> 2.43.0


