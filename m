Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76086C369D8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RYn-0008HG-7l; Fri, 25 Apr 2025 18:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8RYI-0007gn-Bp
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:29:46 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8RYF-0005Nh-AH
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:29:44 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso31655975e9.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745620181; x=1746224981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cf4+/CdYwzijGRSgVX4J5vw4Y/4lSgoERhZ/aiXDoVc=;
 b=iLuVByuPZgQRWo9KfnGjGAI0Yk8irTGBS+wThDeiYAtrlz/PlrdIFVSpLnUhVn5axt
 Nzi4YfOaNkp5e1lPbTQ6X+IERbJy9ujVC+cKJerAOM4cPG40+3R3FvLdg4mONuqCPvBv
 gSfp9D7fAWSyBZELFye6qf3AUdtSgbQ9/bD/XifZl9AU7pLeZMKkyayEsSScA/Wuf8Xg
 +xbo8eQwh0tNlLOsqWcyv4iUO89os40E1RtjEI7U+5+U68SzxJbEDACp6riqcKhz/RP6
 weYMQ1AqOrJWL1/AvqguTAXa2y1sVoZbGFJxrW37Z8Xqb77WgEqgJvWhdy1D099B0Pjh
 Jm6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745620181; x=1746224981;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cf4+/CdYwzijGRSgVX4J5vw4Y/4lSgoERhZ/aiXDoVc=;
 b=neNYVzBeuyYCx1/3bFvsFdiD3H6N2MOh7wbETOgAiSN9P0pirIuFeQnvmedRmMtbnn
 J3hVJNZwcOfAkoLjzz2M+NIZovans8eVP5RopNpr3md+dlxBBx+CLe8yqzqd9qx36C+D
 BzhgHEf7Q1ShYXl2JoahN34OtSmUmvBTJ1u88AjudjoHYtK6ruANX5rzKYrw1Hr4YZEB
 wrGwysCrXPVyNfQfY9Ao69UyzDGOIPZGnge8ekO06F9nlijY2NifvaCpJVSDBaUZUhWv
 b3ZfPPuA8xLgGCJu8GH3/oOU8B7LbJzGfkfhPuNy9A8+85rlpOAK99n7sRm0G/JlhAB7
 jXMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPgK70bLc69SyyCrfURPi3XLmOkXOwOo0h2F0R2pgmpIbZd7PKBeZEXbFDCGeNjh0CNJ7vGJB4Ge0C@nongnu.org
X-Gm-Message-State: AOJu0YxjSXq3lYeNorOu5Vghd+/ip8KxUBp9GvGHv3ahWzQHQkjY8I1i
 TWmth5FYA79TprdT1x+1Ct3ybgT+5rvzx9FVHOs2LnJ55h208YBSJg+O0t4yVy1Jn6gRH2eTFiV
 Q
X-Gm-Gg: ASbGncuudGX1+jwRoijovqsxe+D3CVscuhh4ly3qmcFmP0rIaMRipbVDRmfrkv5HLtE
 Pd3oemLEuub2oHM6nnkEoyQxhXCdOdxb4cB8nO5Tbp0NzQ4hSIR3k0F4/tE+MP1cs4VcZ/labIc
 a/Vo+210gOABi8LzGbAtWLMDa15PzGSElhQGes/Z09WQgV0NQ/YHWeA7OW2LawIVLUEOCJDjBUt
 cK3XhhgcHPa72LwhoVBiKUtr3OrJPGOjn4GepB/xSRGU6vSgJE6tnXtGRTI3MqS3S3K8LWS9jvV
 gXbytWGmjrMTK8wXb/Cl0ng+yWxv2hchbTvnCg/uqqkXjceWrondTvEJaVpym0SAq+60eRtu3Gr
 xK1jgDU2A
X-Google-Smtp-Source: AGHT+IGl8GUtc9+3VQ5ZmZKcYC2znXkgv2+3ZwCUhP9TAPp6umWEzQIyQPH2gK2115+WuEH3xBI3NQ==
X-Received: by 2002:a05:600c:3111:b0:43c:ee3f:2c3 with SMTP id
 5b1f17b1804b1-440a64c179emr33010265e9.7.1745620181609; 
 Fri, 25 Apr 2025 15:29:41 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2ad112sm69845665e9.24.2025.04.25.15.29.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 15:29:40 -0700 (PDT)
Message-ID: <d7aa9804-0c74-4394-b147-2e32c72b4d32@linaro.org>
Date: Sat, 26 Apr 2025 00:29:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] target/riscv: Pass ra to riscv_csrrw_do128
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, dbarboza@ventanamicro.com
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250425152311.804338-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 25/4/25 17:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/csr.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

