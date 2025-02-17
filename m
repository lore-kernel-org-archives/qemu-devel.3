Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E914C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 07:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjw1y-0000TM-Nd; Mon, 17 Feb 2025 02:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjw1w-0000Su-Av
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:59:04 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjw1u-0007Yl-OT
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 02:59:04 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso25540195e9.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 23:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739779141; x=1740383941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vAQwiAil8js4pUsyGXXrfgZQcb/03wrpfQWR4NzQaJw=;
 b=BCXnHP8uS8zerbDSapT01b7lfYpy522/UkjchrNW9tPn4Ei75VmDfY625RXj48J4SP
 EsPM3OTlsFuOQRDfZPxCD3iZIdlTfdPc54iFdbQX/AlWxuaAWKn5/oaDQcXRzm1MVjtY
 /wnvS19UrVqOYD67gSOeKv7hG1Z3+FwuaMKDV3q6DG79aWE0gt859BcNK+/vwmbJi3xC
 AbSsITsYP8PsJW3mQCLC5ewsK/T/ejD392vqO2XZSw8GYpABx1epTRMKoRj1M29OqM5W
 ZBjZHywvGpWhHjjB/nKUjx92R0UcW5Aq9ZYeSZFGQsd6IroGlJBgx7BH53gcZzbHYI+a
 FzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739779141; x=1740383941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vAQwiAil8js4pUsyGXXrfgZQcb/03wrpfQWR4NzQaJw=;
 b=POtr1Ssz9IQf+fTtsXmBUta268x7OGSUfeI7LGQI/2X149dcMURl5Mx385hbcNBamY
 5o3hhkXgbW9q3ZZrbgQV1sxhUErgvnpLV6y7FluPB9wQoGDRtF4xiYFHnfiphVBdM+f/
 YhazQacGBZRoOwoA1RYzBSYJnznLHgbxX2Ffj64LWuXP2T3MEAVk6S+FNBBHqkLJkF59
 VHjeZVwgoECjSqOlkNbS1XaSL1EN36Krsw4Xnyk9+pQw4cgjWcJlqCP2lSixcid4pRFT
 R/UoKxYv0DL5eVhqqRTX6gNvIRePA5UznSDQZr//6psWlZfv+lz5cs8nfey+vXQIgiUq
 9kug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe10+qtLLwi8jEGlawOjMwjpmEh1Yn1/2Lb34aJ1tD1tl+oDHz9+Ql28tFJZMqaCOJQTa11BCq3OmX@nongnu.org
X-Gm-Message-State: AOJu0YzBjTCQL/usckcxOhX17IJWXBVDd+PZzXWcZhaj+PnQitgUHuBW
 qRlnpCVMRzmYGYDTRCogHzMPq6XDyrM5qv9z7h4DiTCd0fRPtESERgBtfqsMlIQ=
X-Gm-Gg: ASbGncvOTDkvyCZcwtHA2i2Tx7TW74K33s+gGoFBx1qxw+y7L4CJVSx6fpoA7PdvGe2
 Nn8fisSD38gcxptRIra3c0rdGKm6nh77Zm031pQXGLlH1ISp8oJiKK0RiZ86t/f8Ybcsb9FB3LA
 YBs+te9k5QpHAgk3topVxPUXVEIBoo3lmdz1B7iW5/ITtiIVkxrptlbcYV2dnJuYMZxuMvY4p4p
 4eBtO3DgdErgx1hX5odzHjAXyCZI7ZjzFi/xQLT4ymZz2I0d2TjPQzahOzKViMY/UJS+y/gSuIX
 VWbUv0L+gaHxpSZu0YK6sPxl6j9dSA==
X-Google-Smtp-Source: AGHT+IHABilw/xHGVnlInIxgp69UiQT4KE5WtU9L5A7pYSSCJFncWsTMtFstiABbnNv/tErzf8FdYg==
X-Received: by 2002:a05:600c:3582:b0:439:3dc0:29b6 with SMTP id
 5b1f17b1804b1-4396e6b2439mr59414525e9.2.1739779140964; 
 Sun, 16 Feb 2025 23:59:00 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d94acsm11694983f8f.75.2025.02.16.23.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 23:59:00 -0800 (PST)
Message-ID: <34d46437-60ae-4e66-aa73-822cd243452d@linaro.org>
Date: Mon, 17 Feb 2025 08:58:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 062/162] tcg: Merge INDEX_op_clz_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-63-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-63-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 17/2/25 00:08, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 10 +++++-----
>   tcg/tcg-op.c             | 22 ++++++++++------------
>   tcg/tcg.c                |  6 ++----
>   tcg/tci.c                |  4 ++--
>   docs/devel/tcg-ops.rst   |  2 +-
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 22 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


