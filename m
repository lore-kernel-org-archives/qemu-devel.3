Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A91CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvXK-0000Pp-6c; Mon, 17 Nov 2025 04:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKvXI-0000PI-DW
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:28:36 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vKvXG-000497-RF
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:28:36 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42b3ac40ae4so2329152f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 01:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763371713; x=1763976513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PA2nuFX61j/IuNtMkRIbPWbXMumEq3e6l12jyUI2qUg=;
 b=JdRIUu8c591dbEFLEfLzVlKozaD/e3iqOwEOiGi3RjP13nKFx6up9pm9E87iiv0c0h
 cpg+jO0v8w83OWwiDOWzCwfQcQm3sdb3AkkuqxALrmSywaVT+c5BKIIma8n2jOMBrN6L
 uOm8NdRTswurxCwQI/hhoEsiBwqhoTNY2OR6xWx66eOaunWT+neQcCyL4MkV6b1SaqyD
 Fb87jiumI+HeZq6efPGih6lYXm2ypkIv2YHT8B0FiEypWvJnV21GnmlN5aDa2tYTcCnY
 awe5rTyll/6vk6PH3XQEW295gEMHh7vrdwfKvz7jO/VEw29BCaSxF5nrJUxN7SjuhL1u
 W4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763371713; x=1763976513;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PA2nuFX61j/IuNtMkRIbPWbXMumEq3e6l12jyUI2qUg=;
 b=K4pGBCg5F+A0KVOMN939eviERiImde2h45xrEelUPYJ5K9H5Ml5X5Ud8PsHjzoepYX
 c4ZpogR1BDZ9fjvMoZwBD+SNW9ffL+3kEj8OtWeEvULHr2PKjJt6LZO2D+TLfh52Pspw
 Ujx5E1LziiqnOX0d2X8YuYpSN+OimgENBkuy07WcvRF47tVtVktw+qzoKfFnL4ICCBHg
 kbZUmnv3XeJjGkRziIvaLl1Ez5EyRSrH78EGQztbepHaHNK9btxRQGPTiluoWrLVbM2L
 rrqlbH+z+HbM5qrPKbP1yORq4z9OnbbXk3lNRst1MrIQPfrcM7lahNrwQJ0ur+Azzqf9
 c8cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu/NDJgd3lGwgVc8c6787r+DnlZSneAtHrI1gZghVhgs+cauorwYw+82sx/tOT8MBKtW+30FfkhYi7@nongnu.org
X-Gm-Message-State: AOJu0Yyf1kaO5zfEEi7yCczRjvZs7SoqAgAnvz9mZEvZ2Z9b/zkGD372
 +Wq0/857Bq/1Nc7Ozjy72B2ukt/Oe5M+a2jtaJcHO8dkRaeP7x20tTPkZAS9vCtN+V0=
X-Gm-Gg: ASbGncs0MmbKXhN/rQ+CrWUBhkpJVWT4yoA4o5KsKqyW/ecXOTMjox6/7naybhbThYY
 0/oDoPXZ91FRked7pSU0R3ddF1XsJqBIkcYwgHitMSNI+EtF4zfKT3AgG5Pb+oReaxKfypELZ5U
 hfLN+i570ykeV/Jhq3qY+yQF8m7JQkS1ib83IAE97mv1bw4UYwxWxjvNvMYayvISQjMaLapvQdY
 tsXssZqD5bJcJk8eZbhwL1uO4G+AZMpfuSMin6uhgcxjVXu/Lh4BH7sjOWu3xmNe6345GQRcpQi
 YKJLddR6B999u+vh38aMC3ta4tDhwsU9oItypaswtNPdU5Mz4MW/qSv2dz1DF5G1xm5Ea9JpS+H
 4bmgbwCtTdQQdnY830diLnFm9F4AH0gSx1J091ZUIclLaqIHXEFH1l94t2ECgscSnIgTToRcUTa
 L1cU4OS8oiaMRVx5CsqXaWwDkRRxdo4FbHnd7HGM66pXjNHA+/+rebAQ==
X-Google-Smtp-Source: AGHT+IEKW0hLVNxe6DrYPYvF/KvEIh0uOdopKILN+kYlhh/c7A68yWavZcGe7kOSoz5vWmL6aIj5TA==
X-Received: by 2002:a05:6000:2509:b0:3fb:aca3:d5d9 with SMTP id
 ffacd0b85a97d-42b5933916bmr10801852f8f.1.1763371712867; 
 Mon, 17 Nov 2025 01:28:32 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f19aa0sm25233395f8f.37.2025.11.17.01.28.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 01:28:32 -0800 (PST)
Message-ID: <d3323b18-5822-431e-aad6-cbe4470d1a2d@linaro.org>
Date: Mon, 17 Nov 2025 10:28:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Clean up end-of-instruction processing
Content-Language: en-US
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Hi Taylor,

On 15/11/25 00:00, Taylor Simpson wrote:
> The changes to packet processing have made some of the end-of-instruction
> processing obsolete.  With the addition of gen_analyze_funcs.py and the
> ability to short-circuit a packet commit, we no longer need to "log" the
> register writes of each instruction.
> 
> Taylor Simpson (4):
>    Hexagon (target/hexagon) Remove gen_log_reg_write
>    Hexagon (target/hexagon) s/gen_log_pred_write/gen_pred_write
>    Hexagon (target/hexagon) s/gen_log_vreg_write/gen_vreg_write
>    Hexagon (target/hexagon) s/log_write/gen_write

I fail to apply your series, what is the base commit?

Thanks,

Phil.

