Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3411C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbi0D-0008Ig-8Z; Sat, 25 Jan 2025 10:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbi0C-0008IQ-Da
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:23:16 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbi0A-0003dY-QQ
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:23:16 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2166360285dso53037535ad.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737818593; x=1738423393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6kGHbCIrWWepeuO1jUl4iXa4/i1eaZ8ib8nutSHYkPc=;
 b=bVP1n7MqMHtzGhA4reWphJ1UGXqN/HUQcotNmglfq6hGJElNnIDiaaKSLLrkj6Z/uo
 iJMQPo0xmqJY4Pioqq3upJ3C9YDISzE7AnCant+ieZyTBBHcrI533lr/nvwRMDOzMFgg
 7r6GlsnBEqoYoc4UoB/Y/KpNec1P09e8Fb7eYYkIEfl+mxrcSu0dTRkmZETE48sRz2zZ
 NMDxFECcKuOQhMyyKx5AwrDOa1d4sdtc7lpsuAoReFdngo4e4pEnDkgggFkWuNapizLO
 gdILkLlFdC5Tm4EMhKToEahVgBDOzVu/IbZJFX69sKlhwYQwAY33kuTAL2ij06VvlooQ
 Z5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818593; x=1738423393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6kGHbCIrWWepeuO1jUl4iXa4/i1eaZ8ib8nutSHYkPc=;
 b=DAunlgp2xX+A5QxA6U5KVWgGLEfNan4O5/cX1okIepaDJ43EI42y48zEAqq+RxDZkR
 Rt6ZzJxgpZbBB+187STkhRzazMmp1bo0d20quq6WYG9wiCL7vOCzMff3cOK0W9kNmsjf
 b2ez13nVdq1b3YnLMn7Hih+pwRZoTujmDC//WJDr5/UzQiA/xyDtd4/LuRc1UXz0CZA9
 7nXautS42zykAFcMkpHJutrA3oLV61jYd6c0/tFw5HuJg7Le3QPKEmC6+i6rfZdV+cxZ
 9aoFcgboUy/7NIEibTb7fHaXX89OpOMrGbvAmIQPNsPNTMvu5QXjKc2vby16wv0FsTY5
 OkoQ==
X-Gm-Message-State: AOJu0YxfMd0AQQMDTFRQ84EP5RRJgDU1Tlk7zqzZKExXYSXAs4ue+fsv
 tOY9zHsqN72xig6YpL/iisSo/Sj1XdcSiSMTc+w5FpKuj2ZlT9bkFpKYBnMNFdRAVDuu+uFoSib
 g
X-Gm-Gg: ASbGnctJXjJqY1bmqtOFbHcfv8hFbpC2l1ma/BiCMlOWnow969KBwQAqARqbo9Fuhvu
 mmLU3UfJtL81oePWvYjibKurG2swTgQvX7ec2gHCZEsgk4e+1w3/OHRMVpZIrGqskBiz3tsjt6T
 DEGOeVyhpIGrwQh3lJ2UcIzJr0A/vDSrffJxTR0GS3HH0WU2rKO31uYqSF8Dql10zDYgTWpaioq
 vATrqKPRFwQ7dXDLFzi7oH8UblFqsf7+7Hw2SNrh1DU/NiLm6wDPZaueyUwFTzXTay6y9FU3vNV
 I9GTUUpZD/BtUWA7290Ufw==
X-Google-Smtp-Source: AGHT+IEFWjWgUg8IOZZECiafwoYGRd56euTJRaEpJuYc/Xi2iaJYSwUJ5CRs2iJEnKKJJA4M9ZsJcw==
X-Received: by 2002:a17:903:2cf:b0:218:a5a8:431a with SMTP id
 d9443c01a7336-21c3560f7d9mr515005285ad.49.1737818593287; 
 Sat, 25 Jan 2025 07:23:13 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9e092sm33780385ad.28.2025.01.25.07.23.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:23:12 -0800 (PST)
Message-ID: <62d9afbe-73ee-43bd-972d-8eb83c875a9e@linaro.org>
Date: Sat, 25 Jan 2025 07:23:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/76] target/arm: Use FPST_FPCR_F16_A32 in A32 decoder
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-17-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> In the A32 decoder, use FPST_FPCR_F16_A32 rather than FPST_FPCR_F16.
> By doing an automated conversion of the whole file we avoid possibly
> using more than one fpst value in a set_rmode/op/restore_rmode
> sequence.
> 
> Patch created with
>    perl -p -i -e 's/FPST_FPCR_F16(?!_)/FPST_FPCR_F16_A32/g' target/arm/tcg/translate-vfp.c
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-vfp.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

