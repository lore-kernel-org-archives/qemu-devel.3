Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6E2C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 07:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWrmA-0008It-1d; Wed, 02 Jul 2025 03:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWrlz-0008HB-Bf
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:20:53 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWrll-00059p-SB
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:20:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-453634d8609so45813195e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 00:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751440833; x=1752045633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j2I1ifejFRnHNAXmWr768gorPCYwltuOTHlQzOWSgTI=;
 b=SRJU/OgIDhhpPN0xOpugARNRBeIs/dOfoiz1/wAPsWTcNOckQj9i3Vxqjt2SzoUnbh
 +zmaAxn3XarmDY9TrBaWQPs7PIgNNU8VChr1jANhWjWT48WZJKtG3h3Fpl+dGNjp9Ys8
 4BIFQIF/T+e/gA8h4eT+b7s5HhTVmVTP1I7snJ/V4cg55HTSjxqBLzpVp3of35tb8N94
 DwAP2MjnEgk4IkegsWiSczwxcDPEEiJFTu9JrxGmuh+pW2kMQ6mCbl3fKirES0M7TcPW
 aheMwypGp9Hr0Ij9BhIzZ7P7WZJ8v0i48ByHwi/48+Hc2dFm9KLFJY/9mK4q/HjSsZUx
 9hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751440833; x=1752045633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j2I1ifejFRnHNAXmWr768gorPCYwltuOTHlQzOWSgTI=;
 b=WGx1La6mSQPSwtYv6VpLC/Ty3xrlhFgS4Wbj76jJUF+yD64Bcp0X3ipVPwv0BvGgBt
 Ln0ypFmngcgiGACwWV6JwZgcrbX5//wKvI/jPsRQIxp8uqjtvmGK/JtsPzXR+Aobmnno
 YSWLaTeic/qSNj2MBqaE89RpObMV/wkwJ8wS90RICaTmbvWky2kH8D8LWXe+toWZriGp
 RHqI49iHyBP/O50GUxWFAlFLrp5yjurQuaMP8owRve54P8Av9VHfscA1E7pY+Vmqi5gu
 3pitZb1hcgQyQoHscVRNMJAyNYLhX2/mFgdOq7agyZFudVi353Zlh4VK8u/2xmr83R9v
 12JA==
X-Gm-Message-State: AOJu0Yy8YPYctyJtD3NKNIA1DPIHRFkmbi6lkBqZSjNdRpelVUuq3oK8
 xeOuV6p34nHj8XhNkMreUj5AHUkwekYZKXvXPocpfwpFSBa3kflVR04hEvzI/oNVTs2yJg9P4RL
 RAydM
X-Gm-Gg: ASbGncsJvVvzhTvPke5hDoan4wY2SjF8kRqH3r0mYlHwlyZY0owA1GKQbtjWQL6aZNt
 AUAU1c4xXIE4jTnXS/cdnJ+1Zn0CcSfmas98s1qwp0ifi3h7p9+Va5AOifLCYPPeDQB/dhKxf1p
 9BVB1dRcbTxdwxeipYKT1m/3IwknWMtdYJsRrSqb8ZovNXsklTwqvP35SR1HAbeCHH24Fnym3uq
 BtqKdkmSZymniC548zcXf9oLMgbUcgxz6Y4LJeuDEDB8dZhKGjb8QcVhbFehBXDaARXpfy8Q0MA
 qtfR3naQo+eoq04QfrndlmPqqDYgjkRFTWooiAij3+1s6qbrZmgWKFbMgB/WLcnnZPFBMJEx+UA
 1IBDtwTS9O5uysCUlOUFv+uWrLeHuWg==
X-Google-Smtp-Source: AGHT+IGXioDeQeaiVsYjVzazWZvpCecWAoMIiVXPCprhSFEIKzD+WAlfVQaq4prjRvaRdKoLVMhhWg==
X-Received: by 2002:a05:600c:1d09:b0:453:1058:f8c1 with SMTP id
 5b1f17b1804b1-454a36dc7bemr20979875e9.3.1751440832976; 
 Wed, 02 Jul 2025 00:20:32 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3a6716sm189692215e9.11.2025.07.02.00.20.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 00:20:31 -0700 (PDT)
Message-ID: <f7319740-882c-49f5-90ae-79832d99996b@linaro.org>
Date: Wed, 2 Jul 2025 09:20:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/68] accel/whpx: Convert
 ops::synchronize_pre_resume() -> pre_resume_vm()
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-22-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250701144017.43487-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/7/25 16:39, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/whpx/whpx-accel-ops.h | 1 -
>   target/i386/whpx/whpx-accel-ops.c | 1 -
>   target/i386/whpx/whpx-all.c       | 3 ++-
>   3 files changed, 2 insertions(+), 3 deletions(-)

> diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
> index b8bebe403c9..011810b5e50 100644
> --- a/target/i386/whpx/whpx-accel-ops.c
> +++ b/target/i386/whpx/whpx-accel-ops.c
> @@ -95,7 +95,6 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
>       ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
>       ops->synchronize_state = whpx_cpu_synchronize_state;
>       ops->synchronize_pre_loadvm = whpx_cpu_synchronize_pre_loadvm;
> -    ops->synchronize_pre_resume = whpx_cpu_synchronize_pre_resume;
>   }

> @@ -2703,6 +2703,7 @@ static void whpx_accel_class_init(ObjectClass *oc, const void *data)
>       AccelClass *ac = ACCEL_CLASS(oc);
>       ac->name = "WHPX";
>       ac->init_machine = whpx_accel_init;
> +    ac->pre_resume_vm = whpx_pre_resume_vm;
>       ac->allowed = &whpx_allowed;
>   
>       object_class_property_add(oc, "kernel-irqchip", "on|off|split",

If preferred I can squash 20-22. The point here is this method does not
belong to AccelOpsClass (with vcpu argument) but AccelClass because only
requiring the (unique) AccelState argument.

