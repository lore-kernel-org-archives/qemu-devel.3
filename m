Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68916D3B7DE
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 09:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSXxy-0003dr-H1; Mon, 08 Dec 2025 04:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXxf-0003Iw-Ss
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:55:20 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXxc-0000pB-OI
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:55:18 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477b1cc8fb4so29437965e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 01:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765187713; x=1765792513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O5p3P88asgX3isYIctIqTzOI021/60ExJ7c37sl9ugY=;
 b=HSMgVcg/5sz5MTWi5iOpf36+/z3hFYU2OZLpGCTSekm2dif+3UzfhN9g8Kk//FOBNL
 O4u+ezZXTAg4ZAhiEZEuf3VBWDVTDrHTByTfOQnhhWYBR4ct77YQ25dUdTTCLuUgNnSJ
 kTMo/FviaoKlSZHaUPiOyZVvz+Pi9Pyiv18TuBYuSMk04Te7on2xtfQnVjsCRWPefll2
 4ZkpbvcidekngviRgXeUmNlSi2v70mt/qhIbCBKrdDSHG7HdE1zauf1wtpGUyMBbZaBE
 mRuqVSd3HfhZUPhMQL63Hq+8+MnxkInaYry3cVwM6zH36JU5iFYqFpZb95QfROW+5NOp
 3c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765187713; x=1765792513;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O5p3P88asgX3isYIctIqTzOI021/60ExJ7c37sl9ugY=;
 b=lCSEEaiKPaTq+PdG2YK4lgrHNKqNIbYzqG9587tIulpxIT4rDbMDftOf1JDSBPp/4o
 A9HaRD0Doo8hZPl8FoaXLCBR9AMM+h8JG5uw5G2z02yTW8FKI59O0sjSHBTMooEdi8bC
 CsgRbFPfGH+lnpQBXVZ4Lat/pbCRppJqMR3LVuC0zpUsKBdUsZJL00azPsTVntXOMY/m
 KIKglNbFfo9w/4sB+aV2W2l1sjArcAsqFtmiWEUVD5eIHGWdcqjyrlaUbv48sYLdGGAe
 hueks06yLHg7en/90TPIO8KYsaw1jj1h/T33yZ/smG12oclDKa6scvggxqeyBX9bjFr/
 b8ag==
X-Gm-Message-State: AOJu0YzRL5g7Yhd19C54sOimehA7/Kepnd3SbpGyDnRuTQmi9F4x3Uoh
 XNSXmovND/BEf656VRsLAJCqOV3MhzQOxhH8P7HZlqYdXVNTLNw0Cd/6XqRui8+yRl5V4W7NFzS
 Rs+8Sop0=
X-Gm-Gg: ASbGncttlsI/M6lLPs1ZMysCVIXlPFdrIs7cD7ypEoIWpjq3cGewoco9XBqtiz4KoiS
 Q9RNXifzDN+ah0ZJcf3NeEU8vXV3j7EpsYCWt7EaHwlxoUrUSqYUsqa362XWzJt4e5EDFm2zav7
 GilybpEsMaM/y42ATuxNlw3dRsuM3m4La0RdLKls2jvwV2JwVtTQzWAWmudvQQWCfqNUSNfpenV
 +fgvFmIHr7eYJsOZVaKE/f85wxJ36skFWXCN0R76nFVBN74cnJhxIbceYCVKgulv7Mn58M1GHPr
 x9DPt+8+tseY5Ws25f4kvmSy8fVqFoaVS5X+PRoi2czoetZ6SyK42QnVZxyvmCGNRyKG2Ugm3Uo
 UhGGQjJBRWDvyFjHWey6pP62af1JyBGohoDTicOKW1coHixedxXSE6U1NUqpwWvmkm+75gKjSW3
 kYCtJDUkqfv25Mvd1JNVcdhDL52BGWHn6U9MZ4fN09zhqHS9RKfcG/ttrZ62H+zcVY
X-Google-Smtp-Source: AGHT+IEkWIDlbgnFcoORAW+fj5Af8G4U9XlTvHKN/+GwGF+r3kHvrGvqFCom9/P8VvBozhJHTFfs1w==
X-Received: by 2002:a05:600c:524a:b0:477:b734:8c22 with SMTP id
 5b1f17b1804b1-47939dfb06cmr64911445e9.8.1765187713058; 
 Mon, 08 Dec 2025 01:55:13 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479308cd87csm247131245e9.0.2025.12.08.01.55.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 01:55:12 -0800 (PST)
Message-ID: <669b6d4b-425f-4193-ae8c-1806060bdabb@linaro.org>
Date: Mon, 8 Dec 2025 10:55:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2 v2 2/2] tcg/loongarch64: Support every TCGCond
 for cmp_vec ops
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Bingwu Zhang <xtexchooser@duck.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 WANG Xuerui <git@xen0n.name>
References: <20251208095354.25898-1-philmd@linaro.org>
 <20251208095354.25898-3-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251208095354.25898-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 8/12/25 10:53, Philippe Mathieu-Daudé wrote:
> From: WANG Xuerui <git@xen0n.name>
> 
> Support for TCGCond's in loongarch64 cmp_vec codegen is not uniform: NE
> is not supported at all and will trip over assertions, and legalization
> (currently just operand-swapping) is not done for reg-imm comparisons.
> Since the TCG middle-end will not legalize the comparison conditions for
> us, we have to do it ourselves like other targets.
> 
> Because EQ/LT/LTU/LE/LEU are natively supported, we only have to keep
> the current operand swapping treatment for GT/GTU/GE/GEU but ensure it
> is done for both reg-reg and reg-imm cases, and use a bitwise NOT to
> help legalize NE.
> 
> Fixes: d8b6fa593d2d ("tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3237
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reported-by: Bingwu Zhang <xtexchooser@duck.com>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> Message-ID: <20251207055626.3685415-1-i.qemu@xen0n.name>
> [PMD: Split of bigger patch, part 2/2]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 45 +++++++++++++++++++++++++-------
>   1 file changed, 35 insertions(+), 10 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

