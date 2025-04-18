Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7836C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pz2-0003tr-Ix; Fri, 18 Apr 2025 13:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5pyf-0003fP-76
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:58:13 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5pyc-0003jo-Kk
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:58:12 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso1935822b3a.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744999088; x=1745603888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e8RD3N4hnZT2MTJBn+tY+u8entBUePp5nIC5K+qsDLI=;
 b=QtYYwdXcI/nNdb3fl0qB+38O7M7lHFsI1CTy8oWOUsaUJxZe/1mfPC4imt5JHBONgM
 ffXFJ1onEKDlWEfT1ty6lcgp64Xf+filXC68+7yKjW2R7PnBmkMB0yNXbrqUPnzzomkA
 qh1a3krSwVcSeYmtf+8C8FTRdyiZZCKPf/iPi3KEc1OAwh3lW4ggtZbLMUvh2HnxPtKV
 uwR6rYDWRyMXm/WZI852YIvZGhbIsMpsrV0rvorYGwthOrHQwpcfLWV6MjeRTRaseSIq
 AYHPDYkRVkYkgYWFYpVwX9qZS/4Fi+Hf0OOgXotDUiZQTuDslqPAMrqN0TxtIhvEBZ4P
 DZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744999088; x=1745603888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e8RD3N4hnZT2MTJBn+tY+u8entBUePp5nIC5K+qsDLI=;
 b=CLpuhY3Hii3UmxKR2hzLzh9GVcgBZHPnQ0mDUPpSvMTR4gBcLlky4llBZ8SvgARoLS
 +CXpMnvJlZvl39ofKy/8z+SU4A7kjdKQ+n6dYeo0BEaKlC9+P/UMYsUCBJjG2IcHZOyk
 d6q78dVG66YUTJbQc/n6GhhVcLR3l1PS8QHBuDjb0Yades9wtkcN7EmZ4vZeXzNiotCw
 vwAssRdhoncG/5s6rpbIvDTcjJ6SFB2YyMhXz/4TQIFXWIa+JDy69sjFBzEFPwkrlePK
 kkmeHq2+lkzeyVdUccyvhDOOqc13o3KROIRI0xvw2RK39U9dXhC8aDwceS5l1aeP2erq
 7pdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg7ObT/vMR0O7ta9JCnBMLjxD1viD2MKxKHrK6B2XHRotmF8qHePk8+fFBhqc18vEtOnzsnuTihJhO@nongnu.org
X-Gm-Message-State: AOJu0YwTy4UAJJMItth9MSVLg1BCMimRRZgOTGm9YII1GNMs2cD1t1st
 TRWlUJN7wpPmSv8YoUbyslSdHLqtQHfyfVEpswtxGjhd7DosX+MPot/OHGBRD3M=
X-Gm-Gg: ASbGncvYkRbMqy79S0an3UyNH8qURYkN+OG+2l3f/vPrinFezKSo5NWeX62YCdtR1kp
 C8pM7FAs9Vqk2TL9CkZqiW41ia3AZwrHTx4cSMcshGaKTVmeFGjXe8mk+dvdfIZrm73Ry3d42wq
 VBYqFd8UInLRXv0s4AMPVTDjsD6b3XssDkqgD0uw3X6F3AU9lGEwMIshrHa8DC52i47r+6JQ7cK
 2iWvl2xm6UgdB32CzW8CCj1I5gauSqKWHkTyUchMbp23wr2+uwE31GyRXOwbZ17zM3fNpb2Jxnv
 rdTmb0gln+2yYPJMF+7GPfl2LuZJC+23w8EGDCjwtEj5HSWftlb20gFEMRHqB5+37Jy6Hr1Idqa
 bz1FfOkM=
X-Google-Smtp-Source: AGHT+IGko/n7ki1kTBVykxovzc4S+S6IHqKZxusY+B/Xr3rNGuCVj0Q3Wy/ELz2lEsS6zbbTmg6UUg==
X-Received: by 2002:a05:6a00:279f:b0:736:8c0f:7758 with SMTP id
 d2e1a72fcca58-73dc1497ebbmr4099849b3a.10.1744999088537; 
 Fri, 18 Apr 2025 10:58:08 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8bf802sm1947768b3a.13.2025.04.18.10.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:58:08 -0700 (PDT)
Message-ID: <8a33a8b0-68e9-4df5-958e-96b184ffcd75@linaro.org>
Date: Fri, 18 Apr 2025 10:58:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] hw/microblaze: Evaluate TARGET_BIG_ENDIAN at compile
 time
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250417131004.47205-1-philmd@linaro.org>
 <20250417131004.47205-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250417131004.47205-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/17/25 06:10, Philippe Mathieu-Daudé wrote:
> Rather than evaluating TARGET_BIG_ENDIAN at preprocessing
> time via #ifdef'ry, do it in C at compile time
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/microblaze/petalogix_ml605_mmu.c | 12 ++++++------
>   hw/microblaze/xlnx-zynqmp-pmu.c     | 12 ++++++------
>   2 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

