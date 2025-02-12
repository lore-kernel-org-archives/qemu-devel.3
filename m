Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910FEC021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiE6j-00019W-V4; Wed, 12 Feb 2025 09:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiE6h-00016U-80
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:52:55 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiE6f-0002wa-Bb
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 09:52:54 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394820123dso21305575e9.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 06:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739371970; x=1739976770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PhIRQKB0sRk/nGimbBk5DhJP37IVykDYH/DyEQv6kP8=;
 b=oLkrzWw1CyLZy1YWlK4yBvFsLaYOekQ8d0n2rOpKhXXieezJajhrQwWPA5xEuGxhdR
 fZ4jKSUnUCqhITHKm/jJXGP0KE/e0cO8xwu8TfIshEEuOLQ9dM37kscGJP+qEaIny+O5
 KGcLyCE9l9D/rl1sn8GXmqk/xcprNnQxuNWhFmMjq772NWRMkD0Xt/qfH3Q+T9tsXxMa
 jPkidDwAHo9leSRtQFF0tu+JRyx1XX3jJbsmbvv9NlWxRdXibnivApkSkJTRURycW3ts
 C7Y1IgpowkY7OJ4ADWqYpvoinmeG4xmSoS1mTrizGmf3PUH7Y1sLLpUz+Yd/aBYvsQlx
 C12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739371970; x=1739976770;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PhIRQKB0sRk/nGimbBk5DhJP37IVykDYH/DyEQv6kP8=;
 b=Hwrq12bPO3ELYpkbfHSw5KhXqmqLL8XFdqHViI+FjdSU6aIVFn8A75TopFGbe3GinH
 WAffiH8emRpCww5Nnzr/VTbADgkUG57gL5Ff8fJ0xrNFwWqjjka0ie6q8Ub8kC0Qy5gS
 rmKbcz9YPkl0RNRf8HMHwM+n7kD+rPWlVcUF4ngWKUjFwAu2Yma3+dTrMGbnzBMvQEa0
 kMWeof9H6S//lagbt6LdQTXCMs4grn3FoUdJ5qkXH4mTNo9n9f7xO5If1n/oOcRVCQAD
 WZSvJyKjfsm+W9nUWvIuPpTNy4UnoSNG/AQHHMmOXGAEeayLbJTe0w2XdEf2ItN9V/pu
 Ay8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnMF5vOCrecnzm3QVk8WxdDWEumGTBtZWBdTSw34YjKcUoTjmLLOdgNXj7AH4CGqknDEjM4Xl5CskD@nongnu.org
X-Gm-Message-State: AOJu0YzjiUiNtHgF+xP6RN+ip4pZ9WfY2dVApZcBsR8ZlDhThyWXrGVu
 xNH3YfQYvVRqrqiWNbpd6kbyo4ul6oBvBA0gMemn0KUow74pGVGurAyHsQZ43Kg=
X-Gm-Gg: ASbGncsqghVe6tgzzjj4AQJZPadq9vJIpeN+yJ4pc2Eg9hZNkoduHWBmr0qwbnyY/bN
 fIFg2+Y2f2VRFPK1b4PRBjJE25EhcDPfkPZMF3X3UhnfB+ojRFph0mqXQuM0akm6y7b+7Dl/TG4
 OOSQy69obB//bVSCP2AY5jqyQjYxu5RQGuyMWmJzYNSJuJAUf1DY5+nFYFsha0il5A2l/2Bf94o
 MZml1Arjv0W31NvI9dB42MXqjMgSUtrcd5guDr84Ja4niqeUQu2Gc0TodalU3PCjptFXf6uGMQ0
 3fB7OaS2ZFzcC0Ka9sHniiwzfmstJpLSKQGnvwyYHebm6C7PZ8SmChwqtog=
X-Google-Smtp-Source: AGHT+IHg9KfY3UsQ4Ti5V1ctxnCzm/0NECg94cIh33Os+aQOOnCuXay6D9Q24rP2gJ3u/82zMPkT0w==
X-Received: by 2002:a05:600c:4509:b0:438:da66:fdf9 with SMTP id
 5b1f17b1804b1-43958192070mr33546955e9.18.1739371970244; 
 Wed, 12 Feb 2025 06:52:50 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04ee2fsm21922575e9.4.2025.02.12.06.52.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 06:52:49 -0800 (PST)
Message-ID: <bbee3d53-ac82-407b-91a5-b7e4c3f464bf@linaro.org>
Date: Wed, 12 Feb 2025 15:52:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vdpa: Allow vDPA to work on big-endian machine
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, eperezma@redhat.com
Cc: mst@redhat.com, sgarzare@redhat.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org
References: <20250211161923.1477960-1-kshk@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250211161923.1477960-1-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/2/25 17:19, Konstantin Shkolnyy wrote:
> Add .set_vnet_le() function that always returns success, assuming that
> vDPA h/w always implements LE data format. Otherwise, QEMU disables vDPA and
> outputs the message:
> "backend does not support LE vnet headers; falling back on userspace virtio"
> 
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> ---
>   net/vhost-vdpa.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 231b45246c..7219aa2eee 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -270,6 +270,11 @@ static bool vhost_vdpa_has_ufo(NetClientState *nc)
>   
>   }
>   
> +static int vhost_vdpa_set_vnet_le(NetClientState *nc, bool is_le)
> +{
> +    return 0;
> +}
> +
>   static bool vhost_vdpa_check_peer_type(NetClientState *nc, ObjectClass *oc,
>                                          Error **errp)
>   {
> @@ -437,6 +442,7 @@ static NetClientInfo net_vhost_vdpa_info = {
>           .cleanup = vhost_vdpa_cleanup,
>           .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
>           .has_ufo = vhost_vdpa_has_ufo,
> +        .set_vnet_le = vhost_vdpa_set_vnet_le,

Dubious mismatch with set_vnet_be handler.

>           .check_peer_type = vhost_vdpa_check_peer_type,
>           .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
>   };


