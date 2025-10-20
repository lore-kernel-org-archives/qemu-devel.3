Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA48ECCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAzTy-0007nB-Ht; Mon, 20 Oct 2025 19:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAzTw-0007mG-Cj
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:40:04 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAzTu-0001Xu-Bn
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:40:03 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b6271ea3a6fso3215827a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761003599; x=1761608399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IwBtYzNUfDJzGm83MEhycUupDJg6ryKcQcfhK3mDxaM=;
 b=vOuag9z1XIIET9BGJxVG0iZ8PaPg0NtwYXARnSxcZvOsUFBHChYoaZA8I5qy4OJUHw
 a7shVeHeyTvVgjIUKfw2sNsfcYV7VG3rC/QulQWcEozCmo7zTh4Ty4qg2pM0tWRMRD6e
 E74ME2jNoAYgC/3w1VnL0lqILt8IZ7gYK4LXnqCrvkLH00UoX3dacwzLu3UVt9Vif3Xk
 eOosORuWLjIMwBd43xpyIB8+jcpO/S98J03A2uc8iXaLDn96qogysNxUPKBx+4qNrf5N
 lUhHjqA8MpTc4HZ6LjAPGLImwtap1zy8cirDxX9Lf5RqNQX9FpDRr6TEikxpyMOGmVSF
 2ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761003599; x=1761608399;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IwBtYzNUfDJzGm83MEhycUupDJg6ryKcQcfhK3mDxaM=;
 b=luFKJeVDkaVIrlp7+mFJirdlKbj8JI4LKSVsn8Bu8Wr8sQq1HqyE42Lp5L//jcbaFO
 PKMHRe0jsigMHoUbCG0XREmrftG3tzAnPPTB90stPQBPU70xznpwPxSpkVDXBgZny/hn
 uUO/8/QxmzOU16iXDvZQEzrjQg3YHCJ5nLY1j2/xSbYHmjEkRoDSfUH8rfD63UDsYbCK
 oMejgXQqjgIHKuOKZ/8T+ruSJi+8VY1CkAKb/VoE2BXHnEdYh4IaHspv2ufHOayOM9n8
 fiJtZ/pIO84JVeO1L6RRh5dLE515EGSSYQYjlu5I+x8g2Bi0pli/lsYBZATGJ55JHqw3
 P8XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU7AcNa8D99EFyKY/FjfV8iWxHPmFOsDS5AxXcNUekcHR607EhfRpBM92pkL2FtRLLzgImybuI4ud7@nongnu.org
X-Gm-Message-State: AOJu0YziVAdkWKobV7RLL+3NuVTT8hX6ap2ZOtKFUy165lW5RKYxDn9B
 Mr74W3D1CTUMmlJQeA6rt2Qi+U3IEYLXJ8ldafiHZ9VOFVFVSCDeqNfaPE4QFQKDrUg=
X-Gm-Gg: ASbGncvFNtqRWbeVEjkgzu9vuzRu3U9bZYPg+wfd+R1EryZLWq7ICwoM3HfkY6pbD6r
 sKZFjSHhccmd1KzEbwUlVSoBafRey+XiUP4Rovp75epgdko6qW9U4c/JrtgBUN1hivlCVJehAAK
 jVnaoRtCM3EF3qQSsJ0/Q8LUxtC8/tpHBu/Z6WjVB4Q5MhdGKKKpU0GuLaAD6vwvG/fA172bbEJ
 Uel7TqNAldr6toQJcDwDO+kWx4UPs2zeIleGx6847uG28011PHucf+iRGiGIWC5ru9pS7tCfNyw
 90Bc8/FMdDhlUtOb0xffhlXepaYdUfoYQcIc0N0vkHAU1/ZeXpjOJDi9Tc89i+F6ZqUDFXvycgg
 ukRWRYKZMlNS5mkq2tlGTqU9rO1K2hb8uFyEStjRpHcMhQxyd2NQZhprtnrcGKozD0/xUFz5MrW
 jc2D1Lxh1lF64AJcNaeokrKYNx
X-Google-Smtp-Source: AGHT+IG3qW/73MkrtiQiIQ7dEorifELi1QS4vqEtx8fS9jF/8Ro67dZgobaz642FwYUuiDlajfBCVQ==
X-Received: by 2002:a17:902:ce12:b0:24c:7b94:2f53 with SMTP id
 d9443c01a7336-290c9c8a765mr166336435ad.6.1761003599606; 
 Mon, 20 Oct 2025 16:39:59 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebcf67sm91566325ad.15.2025.10.20.16.39.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 16:39:59 -0700 (PDT)
Message-ID: <3a68e872-93c2-4ee5-8936-2441a34fc19c@linaro.org>
Date: Mon, 20 Oct 2025 16:39:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 25/30] hw/arm/sbsa-ref: Build only once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Luc Michel <luc.michel@amd.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020222010.68708-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251020222010.68708-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52b.google.com
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

On 2025-10-20 15:20, Philippe Mathieu-Daudé wrote:
> Since previous commit allowed the use of accelerator definitions
> in common code, we can now move sbsa-ref.c to arm_common_ss[].
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


