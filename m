Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743B5C021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwQl-0006tb-Ju; Mon, 17 Feb 2025 03:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwQk-0006tN-Cr
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:24:42 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwQi-0001jq-9V
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:24:42 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394a823036so42515435e9.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739780678; x=1740385478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y3NXWf3J3RePVDlzty9DnneLv3a16LKp8XCPEWIy3dk=;
 b=LnzKQ5koiiNVPei/hWxWE2zUEXkzk63kj0Vv58Y9x1Qi3WZiTnl/cPOQSfkVeGh083
 RNFvbbyrze4XqVLaDdL/EPL2myINPBgWuZ61eed0JzOKKkGyNiCN7JNqSC2TjGQuUGri
 XtdP48dMa4VRasfxzr37xkirJt2tj8mH2ZWr2JSpxoTogkqFzB74AyU/oad5uxmwFuro
 EeLyAs+7nRo37sRryfsH/nzzI1EucKAQrllGknqS/sKpqFJ/cBFqOPiU344YgSWteCtT
 HlHWPbT/n6YJ16tlSv3oJs8CFQZs677KCT+Gcnrk0OXubuxtDzUJcRoqMQoK4PTeQRyN
 2N4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780678; x=1740385478;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y3NXWf3J3RePVDlzty9DnneLv3a16LKp8XCPEWIy3dk=;
 b=wNNczXyEPQd0+qw3o6EqPuB1r/wfoCSPUwEeHd8KULieh2QsVm3QZWen3Wi6qBNkkr
 B9QbAVdeNYA/9MYiqR/u+YF5SREEjXgaS4soFTOYuBRM41aiXMt68BMEZ2UvAzDeyCzu
 WlL1XLmEHZ/rBm1/LBkIb52jMgjw1ES2f/0sj+woj7AELz9GABtBO+HFH9B7Of/Ut6K6
 RyvOCBHI0G7ooIxOcSSc6rUNHRSqmPqWtK8l3N+kNDmsygegZ+cxYX8fClgWG/Av5cLY
 bi6yL4tIFbF4Z2NQtCfedVna6/KbcAP0oflcfpcvVZD395Esw92Lu4QnHIWnzQKDiGpi
 DrWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwdI7xpKHE/AWGo9XRIv018c8tiACEWmXz6/RD9iKGKTM+/gbddzdjYnAFhB7PJmDD6JZKG8oSQg+C@nongnu.org
X-Gm-Message-State: AOJu0Yz8qlCl6SEJ3aCe+0bHOeIKVESCaMNw7kxFf31pkWhpC0Idn8Vz
 bRvZR6pvfQ/TtU5/Kk2goG52MgbGc3p/D2LHOV4UlqafJjuGrL27ci9Kk18rd+U=
X-Gm-Gg: ASbGncu13RNmMl5bfMsIPJTZiBQGoODpaESWyWGQ9nqRNGLjcVtBV7xogNcYS2ztVIH
 /267bW/zxl4bmTW/7sNi4fTFMSn8sdFY+7gxzAlALhoSxFCoOr5GXMaL051xQYMAIhrZFVK0A9b
 I9F42l9St0ejBpWJ5l+chO/nIX34WAtoRLWqgZ2pz2NUEHdefbLQMom8j6ZfJWwbPEIFAZn/Oy0
 uoZp7Lbp8TDHeElJUAyW1gvSXiUWWxHBo2bVcAYFFg+a9+DqBAy6KD1XJI8RwwqVQOUwBOkc31K
 pAJCifUx+YY0pr/NVfXvsDz6+3s7nw==
X-Google-Smtp-Source: AGHT+IFikZZr1jLpv2G5fnXXDzZwcXjfkEqfh207dArC3RTvs7aCNKWbCdoPm5+nD16Bm09lVP8JZw==
X-Received: by 2002:a05:600c:1c9e:b0:439:88bb:d013 with SMTP id
 5b1f17b1804b1-43988bbd395mr10395235e9.7.1739780678334; 
 Mon, 17 Feb 2025 00:24:38 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258f0597sm11388537f8f.42.2025.02.17.00.24.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:24:37 -0800 (PST)
Message-ID: <6208dcf0-457f-4632-b952-a565f682d4ac@linaro.org>
Date: Mon, 17 Feb 2025 09:24:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 154/162] tcg: Merge INDEX_op_ld*_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-155-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-155-richard.henderson@linaro.org>
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

On 17/2/25 00:10, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    | 19 +++++-------
>   tcg/optimize.c           | 27 ++++++++---------
>   tcg/tcg-op.c             | 24 +++++++--------
>   tcg/tcg.c                | 64 ++++++++++++++--------------------------
>   tcg/tci.c                | 43 +++++++++++----------------
>   tcg/tci/tcg-target.c.inc | 28 +++++++-----------
>   6 files changed, 83 insertions(+), 122 deletions(-)


>   static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg val, TCGReg base,
>                          intptr_t offset)
>   {
> -    switch (type) {
> -    case TCG_TYPE_I32:
> -        tcg_out_ldst(s, INDEX_op_ld_i32, val, base, offset);
> -        break;
> -#if TCG_TARGET_REG_BITS == 64
> -    case TCG_TYPE_I64:
> -        tcg_out_ldst(s, INDEX_op_ld_i64, val, base, offset);
> -        break;
> -#endif
> -    default:
> -        g_assert_not_reached();
> +    TCGOpcode op = INDEX_op_ld;
> +
> +    if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
> +        op = INDEX_op_ld32u;
>       }
> +    tcg_out_ldst(s, op, val, base, offset);
>   }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


