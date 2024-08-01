Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72343C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWYD-0007tP-4J; Thu, 01 Aug 2024 10:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZWY7-0007b2-QP
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:12:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZWY5-0000hf-G5
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722521575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YN6t44olBJkAs3gBbnsGS+20yQACTXBPBaWC6An01Vg=;
 b=R57/7/lIhmr7Wu9lPYUny2LRTaKvznPBHSXcQnUREVhgna8tgevtnIAjbi2P7tfd/waCCe
 51UTcVunbuL1birGb/pkk9zSEv5AQfxslYJHHzV0G1OJdmraejNdylgBzR9RwB4hLUgs5H
 MFpPwJGQ1alX5lPG0xrspsBUjeMJm6Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-ar-pjWX_PHuZWLUPCheRgw-1; Thu, 01 Aug 2024 10:12:53 -0400
X-MC-Unique: ar-pjWX_PHuZWLUPCheRgw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7ab50e6735so359519066b.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 07:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722521572; x=1723126372;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YN6t44olBJkAs3gBbnsGS+20yQACTXBPBaWC6An01Vg=;
 b=rqgLm1rnzGgTHtl1pw0eF1a5jLpFn611xDhbYcX9DRb1OwVNddBpp6Bmv9lmY7jsXW
 SasIXFZWzwx8c8cwdTxx2FjARVLWGZLbgU/oZf70W8cLA9TxQquY2g3SQ3tbKNZimQi7
 flUp2CylARNPOltwBSbP0jVWVP3WLlQ+HMeNN3HRYshRzhdv/g7T2GmzGZ7ER+6ymxLU
 9q+7ahXhKaFQKyr59TORhFCpyLC8AR68DxzqscVqCs3l5+YB6mVPdbcvyovRTXrfTlZK
 fswPWrrxMjqR1njUtWeUyRDy1+qdzZUwWd8sxnRJvNLJByhxNfQeqGzij1y8fBGBoWfs
 yjNw==
X-Gm-Message-State: AOJu0YyfjKePcyS98o7Nd4uNSuwaejflIWovKRIGS7RorMYlqnFV+MD3
 PqrZ3Oh747j1M6ygF0Dbz3yxRp0ye7Hp56CGYDwzSQauN2EvBlFcFF9RoexbU/68ZR339hAy/jR
 AyQGZF47Ft2nYQC1TkBX6ElCY0koRY1HHRN6xAIeqTLCOykevktVfNsXVkO5e
X-Received: by 2002:a17:907:96a1:b0:a77:e1fb:7dea with SMTP id
 a640c23a62f3a-a7dc4d90171mr26706566b.2.1722521572348; 
 Thu, 01 Aug 2024 07:12:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNvQkExyCi1efXPU4aP8xm0jpxex/WSn/wzEsPIoPbP8+yEvcaSZOQJjMt6l/18GQNqyCXlA==
X-Received: by 2002:a17:907:96a1:b0:a77:e1fb:7dea with SMTP id
 a640c23a62f3a-a7dc4d90171mr26702666b.2.1722521571568; 
 Thu, 01 Aug 2024 07:12:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acac615c0sm903674766b.97.2024.08.01.07.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 07:12:50 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:12:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BillXiang <xiangwencheng@dayudpu.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3] vhost-user: Do not wait for reply for not sent
 VHOST_USER_SET_LOG_BASE
Message-ID: <20240801101210-mutt-send-email-mst@kernel.org>
References: <20240801124540.38774-1-xiangwencheng@dayudpu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801124540.38774-1-xiangwencheng@dayudpu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 01, 2024 at 08:45:40PM +0800, BillXiang wrote:
> From: BillXiang <xiangwencheng@dayudpu.com>
> 
> Currently, we have added VHOST_USER_SET_LOG_BASE to 
> vhost_user_per_device_request in commit 7c211eb078c4 
> ("vhost-user: Skip unnecessary duplicated VHOST_USER_SET_LOG_BASE requests"), 
> as a result, VHOST_USER_SET_LOG_BASE will be sent only once 
> when 'vq_index == 0'.
> In this patch we add the check of 'vq_index == 0' before 
> vhost_user_read, such that we do not wait for reply for not
> sent VHOST_USER_SET_LOG_BASE.
> 
> Signed-off-by: BillXiang <xiangwencheng@dayudpu.com>
> ---
>  hw/virtio/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 00561daa06..fd12992d15 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -460,7 +460,7 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
>          return ret;
>      }
>  
> -    if (shmfd) {
> +    if (shmfd && (dev->vq_index == 0)) {
>          msg.hdr.size = 0;
>          ret = vhost_user_read(dev, &msg);
>          if (ret < 0) {



How do things work now after 7c211eb078c4 then?

> -- 
> 2.30.0


