Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB526CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 18:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBduO-0004qs-9P; Wed, 22 Oct 2025 14:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBduM-0004pa-Vw
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 14:50:03 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBduK-0004Sg-Od
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 14:50:02 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c3e996f8faso290378a34.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761158998; x=1761763798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qqN4/upzK52KatKo8oHnixekDO2T4nKpFGS9uYP3RUw=;
 b=zj4FdgU+tS/QYU8mIm9GcuqqlOAL6FVH+H0qr8txlfGeMnW6XY3RipahHvMKdOhoPn
 E6f1zmwWkkQQwQFL7t7hEFnBTxhBFfrxDEviUEMARvgGVSSPDqfVALPhyJ2ayk9G4Lj3
 iuF99j07BFzlBEYGUA5p6jqSKNlwiOPsBRHRuSUpgJ0X17iq9G7T0k9AqFTTUDfTb4Hi
 vXwj+Gq5L7zRyxzUSeNJ12vkg8O8D3vtaP2fL0bwE6Y6M+4gtlacYwKiBXSYYPk8w9Yn
 bmMWMy2JI38QKx6cmj5i6hHNl1PDpujBgDBZNabh4bFzenlrYnEsIwe4RFbVOdrxbH/0
 SJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761158998; x=1761763798;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qqN4/upzK52KatKo8oHnixekDO2T4nKpFGS9uYP3RUw=;
 b=o8qAOROIvwW9j8B4hkAMGtxMHSN1TS63pbz+WryAWyvI6ri+EzmlQn9Cb1ONWBbm9W
 N0kIv/DosTnVZTSkhs++RDlH4xJZvLHkhRtjqQxJuGE7kbjMKcIQQfPODPe2IpXQpeBm
 MDni6fqQs+IKZrjM2/DYQcC6gK/WZaKfHI0JC+LBK7l8ZAyc7mi04CNAuvAX81qZDeAO
 X7hA1NrVTPAidjwZdMfjuGLsFZnOOMQQdqxBy88KdSlplai9eGPEkL7gtqfdKB4A3ZcQ
 LWer3EpyVVP4i/IFxAZZhxM8qczTyxoVAAMQ07gm+GSW2gPRQ9JsZlV7x9mNjWj9gU0O
 TqQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1D74JjBojwOVqNYjtNnDekU/Sbel8vk+4afEhM2K6cRTGq6TkV4Byo/4D1/unpiFlNGzXDVqgBc9p@nongnu.org
X-Gm-Message-State: AOJu0YzSlBfClmLrGwrpGrDznbRa6GJ2OtLoA6uubIj/8e+4G/xtbvEo
 irfYIs13jBKetzrHMGbTjO4BKPP0N4Lwtn6h8l7KLw/UQErGrXzNjVFHLPmMd8xAsys=
X-Gm-Gg: ASbGncv0u1B7HhmEGBEqI8nMCgo30zjvKGD1aXyXBnd9XsOQQBjfZjbJHQWmznfKv1I
 6wUg0yoR8P6+39qBNa685QniWKlXdMKlvXpkZH7vJC0asgaRljOfyd3CaMduzIBDbrVi/9GkK8X
 2ue/3fJhzhYhpW9YmxFtNW6eOTjZdNXxXfjJVGLFdalx8gzRl3/YB+IcNg5qxGoigZkxXzfditO
 yNnfc5A7QC1qklzoJGEbEz+6psPTi3Pa7KMhDx+lCEwSt5dZ3mfvn9tka349XdT/RYazNgEg80z
 w8hxHcJFn4iLVXnGJXP9Etml6aVrgKRbm2YsYWok+gkR3Nm5D0D8X3XtJyfSMnVXe+2KIKSto+e
 B07LkVj9FtG9sRlDa0v0n52hMJlMhgYgkaQu9JeM2QJYAFvPn0guF58GnEk9XI2ffOgoVOeupsx
 0GaPPWpRyW/XxI2GIJ73hSfvIrP1gTe75wx0zFJQF4vX3XDJq5IrIIQNb/OpYDAAH4haGE6hc=
X-Google-Smtp-Source: AGHT+IEv6Wvb1md+0ttC8J6QarTIq0WCxBPsMT/nZYXniuGP3yO3/W2xF9ZgJVuvHrm9uVRpdcjQZg==
X-Received: by 2002:a05:6830:6684:b0:7c2:9b8b:53d9 with SMTP id
 46e09a7af769-7c3e53c4d3fmr1259173a34.14.1761158998555; 
 Wed, 22 Oct 2025 11:49:58 -0700 (PDT)
Received: from ?IPV6:2607:fb90:5ec2:421a:7b72:4f29:1f36:27f3?
 ([2607:fb90:5ec2:421a:7b72:4f29:1f36:27f3])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c288932b2dsm4855441a34.30.2025.10.22.11.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 11:49:57 -0700 (PDT)
Message-ID: <f652907c-d6a4-476c-a1be-703ec13a451d@linaro.org>
Date: Wed, 22 Oct 2025 13:49:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] hw/scsi: Add config option for new ncr710 driver
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
References: <20251017200653.23337-1-deller@kernel.org>
 <20251017200653.23337-5-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017200653.23337-5-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

On 10/17/25 15:06, deller@kernel.org wrote:
> From: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>
> 
> Add config option and wire up in meson makefile.
> 
> Signed-off-by: Soumyajyotii Ssarkar<soumyajyotisarkar23@gmail.com>
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   hw/scsi/Kconfig     | 5 +++++
>   hw/scsi/meson.build | 1 +
>   2 files changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

