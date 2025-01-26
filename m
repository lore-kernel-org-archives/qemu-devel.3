Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDBEC02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2a6-0000HS-OP; Sun, 26 Jan 2025 08:21:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2Zx-0000Fr-66
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:21:33 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2Zu-00037V-25
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:21:31 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166651f752so67833775ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737897688; x=1738502488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y8jJvWPboxIq5w+yA/4967xX0MPc8x1+Qf2vBIAIbqw=;
 b=WOtfhM9r8Zje3BEbw2QCvDF5fbfg/gubqp3OYSVkPsxRqBHcy/6UoOiX5NDX4AmGgT
 npvREbDaLpX+3RiUidp/PZ9656vkm9+uRzfeNkpwj1Ul3rm7uOHYBmBk04AEWq/lo7i6
 gYRreUShCRy9g92/VhagmwhFM6sZn7Jqnl0pML5bbSRPQM2OszuwNPnGh3xH0zOAvw7I
 S4m2WHllqP6wuDs3wiVcUlKodi5p03WK2EdjVC8bDzS+sWaVsRbWLkqNhKKGogoDEzIR
 TNRGeiJO09XfureaOgCaWO2lGMORPV0aOPz+h7POhgry/FxT8YmNfa0/1xBnStff4xp3
 dajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737897688; x=1738502488;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y8jJvWPboxIq5w+yA/4967xX0MPc8x1+Qf2vBIAIbqw=;
 b=CqQc/ibrME23NS9OP6/jGFfMYL8tjEpXzEGp6XbD0br9hYIrkPKQTB8leixOQq0I1x
 7Q6xWT7ROr+b0Fh6z5jW6/dccRaoandh2vw2FJhzx8eONvKgIQS9gRsQYaV6y5qmKPOl
 RnEogCtKvOqnn9aSYTFDcGDkDgKgDnLTwEvmPQcDFgsDFGJeoMBv9erHWcQtfDlrlgBR
 t83AIFXCxCZJ4JQVrR9tAmpqKfH3CcBlZ6ug2Hg5vgzoRPkIPojjNmLk+eMNeQIopvQr
 DCGQ7BKCfjZiBzoqq+3XCy3qP3q5Jaunxeoi/yMVYThed892vnO4fBnx005ay4A7dPaE
 vv7w==
X-Gm-Message-State: AOJu0Yw78JNMGDXhldMNLbZUXUvbvmeZUo+9QWEuEi74y0ivCJq/i+fV
 ckkLi/4bJXdmq9O9pT85BMGc4jHs/l0wp2iaueidRfWw18CLikD6VCQS1ru2vBwhxNJI+L1M/Jz
 4
X-Gm-Gg: ASbGncugBX3AW94OgLLMSvZLgleqVF2X+dOTYKI0Dhm+ipd0VzlXjo6PNHHdH7Ua76s
 WKhl/TWpc6/wo4G0itjmjpOoTA75f5RBnOQG4xMXI+vJPkv4HwyB9NX8Os8sakCmumhDVhRt0KT
 f5xNlbqvYyoZhSGIyu/DIPp0fNsG+cQt3TJ8+e7ocFdO+73T9kqaegc1g2YDdsr9iFzE4Hu975F
 Mrk7+DsBmimC8Eu2LhB5oIFPGxq3dgz/x8c+3vzRj6o3JRPyS4el/kItCPNt5+/Qqpfjfmab1wM
 oOqxZDEPGwADmO/HPJHR+d20vgImkIOp8A==
X-Google-Smtp-Source: AGHT+IG2hKAVTxy5dtKt5t+eFqLrJsfKUFUw3SK/hoYjoEyvp7pI034rx8dgEN71AaQE67NkWB54VA==
X-Received: by 2002:a05:6a00:4fd3:b0:728:e1e3:3d88 with SMTP id
 d2e1a72fcca58-72daf9bec6amr54182061b3a.7.1737897688609; 
 Sun, 26 Jan 2025 05:21:28 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a69fbfasm5359178b3a.16.2025.01.26.05.21.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:21:28 -0800 (PST)
Message-ID: <4acce861-8881-4c3b-9eff-52465ed0353e@linaro.org>
Date: Sun, 26 Jan 2025 05:21:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 67/76] target/arm: Handle FPCR.AH in SVE FTMAD
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-68-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-68-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> The negation step in the SVE FTMAD insn mustn't negate a NaN when
> FPCR.AH is set.  Pass FPCR.AH to the helper via the SIMD data field
> and use that to determine whether to do the negation.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/sve_helper.c    | 21 +++++++++++++++------
>   target/arm/tcg/translate-sve.c |  3 ++-
>   2 files changed, 17 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

