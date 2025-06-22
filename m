Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D84C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9wi-00040X-9j; Sat, 21 Jun 2025 21:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9we-00040I-PN
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:56:32 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9wZ-0005fF-TR
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:56:32 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-747fc7506d4so2304301b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750557380; x=1751162180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wToqb93izKncZf2VklmJVrr9zAa3a6y34uTY5H2YPws=;
 b=ZQCHEXYir4KmlqxNnlDammEE1vYsyRAldzBNj3/4IojQKNkQIqYNMf9/mzLtCKflG4
 rEq7FBcXhk/EgE+eBxhgCljfmq05ScQLKhbE+GCgcelYui63bWAcp4TCRFPJakEKF7b0
 503UCdAkgmJJb8AWvXivN/LQdkXeRxnnQyOn1yTh8WDhJ081GX0CJD5tuhrcyDJsE5Qj
 3CrJn35AarfSRVibAUYO41McDS+OiYfg8j0jTLxidmZ8lDBe6I+WeAZC8HhD3NRoAfns
 W0+MUo7ILPywbF3Uojf1ClmUfLEwEsC+W54l33LaZlHVmMxV1crfjDaPEcyrrp5eC46u
 2yeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750557380; x=1751162180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wToqb93izKncZf2VklmJVrr9zAa3a6y34uTY5H2YPws=;
 b=b7RvFBtKZ/icmkseXz/EQzDNdVEb+dWy/9mEnefW3O8HPQ+Fhz0TUffeCm9uOtB9Ns
 J3ewE7ixIazl/XwuL+sXEbU7M2tcuyCbwi3PTshmb9xAngfYGnO0K/qExdn5y8g8NFlO
 wuvOGMC5INLEt/TNF00u/L86+NNfgbFMgf3+Y0BizFuRKTFBIom7tX+G9UsNJw2sL2ND
 PD7nb4eT71FoIgVELzMv2mPDR/bGrFtds5flBkbV+2go2JnIQAV+GCIYwjay5vDLEsoo
 6w+j4KIoXAdPUgjFHIhlJHEALQxyeafkim/bkE7QI4Jp+olyEdfYkcEnHn+8S9ECqb5N
 g8bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXioWmGGujtDmm9nK0Tb4VfO0Kg3pLX71c6oT1JJkM2MELKU5ZU0TgRyVbHT5XydgN5+IIk+4XlzEJ1@nongnu.org
X-Gm-Message-State: AOJu0YzGcI3YyGuqcStxDB4phUg11Waj9FKulP6+8FR/K5QoCqX6Edkc
 Iql4GmTMjuzLImbiEmDlKlx63Z77+KYiSPBBPxgX8t1zNRG/GF46vUOFPnnZM9hUtuV7fX0b24W
 q4qiinzU=
X-Gm-Gg: ASbGnctpATnzkXXLkQFv4OG7pdZSAh5XYZrdwQhulqN/EZ88/i+nWZi1hu9m3lcSwhN
 kadnxjcqmejsXveOxuq5VTlqEof8gzL+V86uUu1H73ajdAkbUNFn1bjEToNaiZ77acy+fbmJvBQ
 JTMv2e/pWpaIZIpOKLJtoVcucO1nU/f0O6eqQqyzSFeSj9Kczg7xBlVzS3N/tYjZm5NQ9vseCOu
 nfwVOSez/Two6lJ0mvpLBrawcAAB/AIXeNql2L8zGXZM2rFZTROECbzk+u57r1mmqKY19YhLfvq
 sUQf2p+rjtHRk/X3PIGWNKf3A4eMphdc1Sd92h5heaGu4Uip1JoVQnSTplrqvwzm6+so12krdBf
 yr6ThEUYyfouuRuqr/DRJuz1DdEvU
X-Google-Smtp-Source: AGHT+IFA4KUhPGnsTlnutCecfTbYeNocAYhYH4gYsZUJE/n+ZERjbxYi7IUfjBu4L3XvGz8yd/ODqQ==
X-Received: by 2002:a05:6a00:9286:b0:740:6f69:f52a with SMTP id
 d2e1a72fcca58-7490d56157dmr10754157b3a.0.1750557380000; 
 Sat, 21 Jun 2025 18:56:20 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b497sm4983113b3a.6.2025.06.21.18.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:56:19 -0700 (PDT)
Message-ID: <7188fdc2-f677-415f-8fde-d65fd8d9fd3e@linaro.org>
Date: Sat, 21 Jun 2025 18:56:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 29/48] accel: Factor accel_create_vcpu_thread() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-30-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-30-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> Factor accel_create_vcpu_thread() out of system/cpus.c
> to be able to access accel/ internal definitions.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/accel.h |  2 ++
>   accel/accel-common.c | 19 +++++++++++++++++++
>   system/cpus.c        |  4 +---
>   3 files changed, 22 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

