Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC513C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 15:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tib4z-0006MV-Jo; Thu, 13 Feb 2025 10:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tib4y-0006ME-Nb
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:24:40 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tib4v-0007f2-L5
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:24:40 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ab7f838b92eso179920266b.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 07:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739460275; x=1740065075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8tfJRT45b1e3R6ukg2Fbu/yVEjxkCWVWD91D3kg7YMQ=;
 b=cQLIiqatKvh6MbBdSVAEaan7nEVqrzuaNFJKNIGLmU5ZCdAyvVTTPumDcf0Mrai0/E
 JW4hMkY+g3nl4K6UlcKgCUuK2xU35e09D2aNjKsmHWGargrEBJqtaa1Hm1En+r1DsdWX
 Xv+wR69q0+Gext14DIIDy+Dl8jjDKjmWnBvMs+O2MjmOrfMKF4Ikd/dw+wIp0UfzQ9ur
 uDURhVVi+rb0ZbOAbBP1JWsuTJuI2EI+yvV1BHN256lw/hTW/a9XRGXCkDPE88OeFDZT
 SbWvhpB2puS7iBcQPZcA/z5u0FZ9hhQxdyd7L4QsEMHsW/i1eeAIzfsmpxYVvWV+rsSf
 tJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739460275; x=1740065075;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8tfJRT45b1e3R6ukg2Fbu/yVEjxkCWVWD91D3kg7YMQ=;
 b=BRa+1bnfyAafRcd9/En+45bcRhs4Zh9hTa6nPRxwAbCRlslTigNK54Ny4eVVfIpnSC
 SybWT6oqNhgpTgr/iQ8YQWFWHu0ml1Zu0YNayPtWIXuiarw6i3MPtAJmLdp+TvlMfOvx
 KRaiv7eUIqkcjrMQXHUgwNFtvxtl0rabp73/5LynmhBKDbX39Z2wlrKwRR7AptXU1/lc
 /Cq5asBFRCC3oLAIwxgx9V5NitQLOIoYvLikjsHq+4mraKYPqfxnwEBScWP8QLEE27OM
 NanbAum+HWhJiKf9lNExBhoMuwnq8nx99pItM0z/yL0tyRaq/1f+zhUlPB6/ffrjEybL
 EtDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNskWdDMl8Hfzyqz4TtWzlwqR22ndjZ+EzHrTNyGq/YZnmY4eavr2INDiCsCXKK5NGPuIokZ68awRC@nongnu.org
X-Gm-Message-State: AOJu0YwNpJY2ziGigp9dJ5kFrzd5d9IlbNhb6MUgRdBsXaYmbgb68HID
 Pw/JsLVViKrYGr6Uf3mF3iAD1F56S/acQuk7SWyOKnbUwDM1b9vkz5Mw/FqquJu7DGfZomxHwQR
 4xAA=
X-Gm-Gg: ASbGncvDADB6hM6yg+qPyfw6spKFU0fikWwrCvMfI8AXrtZlKM+mByehBOlbiPpMwmE
 Ozus9qRYvYMRZG9+UExfw3JCBT9D0FuEdjepSCyttQ5kdEnSpu34fT9ndzvbCVRd9G1BW5b2cpF
 zV1cNfG0c8VooLtIjOg9XWONd+DWk6q28PYmFeEwzh08wp8tPM5OR319N20UP3x0Ubr4BJSzCfz
 kjQlVcHyCBk+jX6oL/0AAKy3SFKUF1qx+7TJf4VEWgqPyR2k4FfEqTYhU/GEA6FXYzINCIvnMgo
 aJ6hN3Jg8doSlomblx/R2P9qI8b9heHyC848f2JEqofdOi0fVj8nSsutnZXieS/FGg2qsj9FXoW
 maSM=
X-Google-Smtp-Source: AGHT+IFOGtnard8tH6phivXZfwCMQpYQytIcrL3uGxE8g5uGGIgUJsrY7/Kw4DsJy6orXQoHVPHrJQ==
X-Received: by 2002:a17:907:3d8c:b0:ab7:4632:e3df with SMTP id
 a640c23a62f3a-aba4ebfb569mr410617966b.31.1739460275189; 
 Thu, 13 Feb 2025 07:24:35 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba532585edsm151465466b.48.2025.02.13.07.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 07:24:34 -0800 (PST)
Message-ID: <53e891f0-1c3b-48fc-985e-4b0e8f0b5802@linaro.org>
Date: Thu, 13 Feb 2025 16:24:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/virtio-nsm: Respond with correct length
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 Vikrant Garg <vikrant1garg@gmail.com>, qemu-stable@nongnu.org
References: <20250213114541.67515-1-graf@amazon.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250213114541.67515-1-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 13/2/25 12:45, Alexander Graf wrote:
> When we return a response packet from NSM, we need to indicate its
> length according to the content of the response. Prior to this patch, we
> returned the length of the source buffer, which may confuse guest code
> that relies on the response size.
> 
> Fix it by returning the response payload size instead.
> 
> Fixes: bb154e3e0cc715 ("device/virtio-nsm: Support for Nitro Secure Module device")
> Reported-by: Vikrant Garg <vikrant1garg@gmail.com>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>   hw/virtio/virtio-nsm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c
> index 098e1aeac6..b22aa74e34 100644
> --- a/hw/virtio/virtio-nsm.c
> +++ b/hw/virtio/virtio-nsm.c
> @@ -1596,7 +1596,7 @@ static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
>       g_free(req.iov_base);
>       g_free(res.iov_base);
>       virtqueue_push(vq, out_elem, 0);
> -    virtqueue_push(vq, in_elem, in_elem->in_sg->iov_len);
> +    virtqueue_push(vq, in_elem, sz);
>       virtio_notify(vdev, vq);
>       return;
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and per 
https://lore.kernel.org/qemu-devel/CAKXOwk2Eba8qnqKQqCN+=2+N=WRPzAwx3LkoccEwR-3xgt32uw@mail.gmail.com/:
Tested-by: Vikrant Garg <vikrant1garg@gmail.com>

