Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD7CC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16SX-0001uK-SO; Sat, 05 Apr 2025 12:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u16SV-0001tj-FM
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:33:27 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u16ST-0000CZ-TY
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:33:27 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso2542519b3a.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743870804; x=1744475604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X/bu1T4kxjZxytYgVV8Tdp/yz80C5H6AUdP131sjjw8=;
 b=Zj2RkpRi5r95W/ukNMAwVzjGaaGzaK+H6sJhs7zdatiEDcKwk90eQWD6SzPkFcI8Dd
 Ibg3gNXcpZblFxTsfTkXC2P+DuHXle/qbiWWXNGei274OaCY7W3lcelgqROQ/qhgjBbo
 8hkQjI58ESd0XPcKWxJw3n4gAmBNTa98ieAMk7bKsS5Eh5ttEpxwAT/vGDpT28U35FsY
 m5N1b1eh+wwCdJHC/JYn8/D69Xt8qXtN7Y0dErJZlR8oCJ1gFihVI17BwOEBiHuAMHn1
 nF3ja/FohkirAQog3U81lpuct/TJwkGyAiMOXl7CwYuwZn3KbMbqDyDtB/ZR7SWaxSGw
 mWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743870804; x=1744475604;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X/bu1T4kxjZxytYgVV8Tdp/yz80C5H6AUdP131sjjw8=;
 b=wBUR2HslVs9ETyKgaRRUwBg00eZ7coWpz5dzQeTw5oPd4zicIyi3MPjOsH+rYg2KPF
 2OsK2bh5AIapJ8Fl+8o711S76P/xBppLUxxxsBq7Rva/s6DxRbcytcM8jrYmBJ5IZU1g
 NQLx3gMLMRrdpE+Bi87aEsfl/R6Y8DvwbWmTeNf/LJax4nRtimnbZGbg0conjeyuaarO
 3Ag2/7T5R0paDfJSSstjR9ZqFcCCmNIM0u6DH8NfqFdf4B6beacqSZ/xOLGvPU2sGLFL
 y/6jwI1E6izZollZbpRPMDUxINzg45YMgoAh+kC+Qwexxd5SIk7N89eREfNiMZ7yWyZi
 m7xA==
X-Gm-Message-State: AOJu0YxEenLbbCDcpuQQkid2zNdRN3QHeeSqu+B7cYyZcSYZaxABSWEk
 eextCZfuMq2rxBzC0HbI/cbrt0Ym3Tv5VEmFKqnDa7KyYTiYaiohKt0+nVTMUWpfUjEtxDLuW09
 G
X-Gm-Gg: ASbGncsyIOiD17X1QcrAjBJpW6kWloRaHe2ByP5pvX5BeOKk8udriwrRLVrDeJFv9yh
 HLvX47ZCiCTeB4IpsXisHc/3KIvwe9w6ClhdOOdX+d+2XPaLWF/nlpuw99/fCFdSncjogQOSReV
 ka0AiSuhtH+L96dZWr2FEuNjONZ67rUNVczA2IA/njXMiEVq+nZybhBeTJhK+go2eCcifzUTwaL
 5EMhvSBcQiYLff1rks6ELLiQwCD39zYjensCbiF4cqblaNfu3m7QD/2Z8xdL9om7+HWkqJbxGHg
 VPNGbc24nciesgdZMsSux/Gwwo8RrgbM/rhG+63WT5DtfLp08zrnf4meCJESp2hg
X-Google-Smtp-Source: AGHT+IHsxqFNX0Hr7aFE2VjL4NxjSpOqoUsxmUvLf46+gmknj0UvE23Bah57j/O/r55arSfByGkh8g==
X-Received: by 2002:a05:6a21:9201:b0:1f3:36f7:c0d2 with SMTP id
 adf61e73a8af0-20104769bb7mr11319187637.41.1743870804443; 
 Sat, 05 Apr 2025 09:33:24 -0700 (PDT)
Received: from [192.168.122.15] ([173.164.107.234])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af9bc2cfa92sm4686008a12.1.2025.04.05.09.33.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 09:33:24 -0700 (PDT)
Message-ID: <09b4a20d-5345-4b2d-974e-4e7cd71f0596@linaro.org>
Date: Sat, 5 Apr 2025 09:33:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 7/9] target/arm/mte: Restrict MTE declarations
To: qemu-devel@nongnu.org
References: <20250404223521.38781-1-philmd@linaro.org>
 <20250404223521.38781-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250404223521.38781-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 4/4/25 15:35, Philippe Mathieu-Daudé wrote:
> Move MTE declarations out of "internals.h" to TCG "mte.h".
> Include "mte.h" when necessary.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/internals.h             | 121 --------------------
>   target/arm/tcg/mte.h               | 124 ++++++++++++++++++++
>   target/arm/tcg/sve_ldst_internal.h |   1 +
>   target/arm/tcg/helper-a64.c        |   1 +
>   target/arm/tcg/mte.c               | 175 +++++++++++++++++++++++++++++
>   target/arm/tcg/mte_helper.c        | 160 +-------------------------
This moves more than declarations...


r~

