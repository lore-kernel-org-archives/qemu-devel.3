Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2172C83F34
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 22:15:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uctMJ-0007TC-Tw; Fri, 18 Jul 2025 18:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucsol-0000Q0-1H
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:40:35 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ucsoi-0006dI-VO
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 17:40:34 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b390d09e957so2712694a12.1
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 14:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752874831; x=1753479631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kpWEL+oIBRkXXREO5H7+6ZRqM0yIeGKJXKkplL+mXBw=;
 b=KU1d10b9hx4s3ul0TdRq+RWO7fyPBKYt5AjIK4qchpZbkmsjv3+2rkLZ7BKo2nw4kz
 ixyZ+2Wf4secnl0EgvuoOZv73qOnqPtpESmbayHVmsuMgeuPJkdOwf+CorR0Av1X+oMx
 iJfj9zKiAD6vtk1w+hng9vTAgjNqA17foZP2iXI1ipRRscNXX9vmtclw496fjHFHLYTx
 lxao9+INj95wVvKHLCol1myWkTtnnl68nnMQz03U+5ry73Z5090dRL6Ws4F84tIaRL05
 DpOnP/oNBXy7qZCy3SUO2JZnVS9+R2+2ohukrofXHMOk1pqB9UBJBxf0qKkjBitidjSC
 iCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752874831; x=1753479631;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kpWEL+oIBRkXXREO5H7+6ZRqM0yIeGKJXKkplL+mXBw=;
 b=SHZo7q18rciJKp5mkn9e+h9txDQ+zTZ4tQtsLQkrgxJoPPdZEIXWel9mX2qFh47Sbm
 Y24VEbCmQUndWi6Srt7FH0PqeuzCZqeoY87g7EbwzO5MjprEeGuHKdRUHWLCsb7HQFm3
 w3S9yJ+2Lo/ic9HndprSuQqbRZtK7vEi9k1FkaC6IJ5BvCC/2waxPnIXWRZsxTupyHw0
 uTj3dJZ1RtFP1V/XzpfWCNwYpVPwVnGY5T/tcspuLEnS1kbvbrXguEa9EPUO+ucMZ1yR
 8gHYpe5VP7zideBMsPpGkBsrltB2WyqU+Ns0R08lQNUiEOEhyevv+tY3lrrtLBglISES
 q4IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrmbfWgXNibWyT12O4MLFYWsr+wnEfUxCgNwzb6hBXoK9mGcGhi77r0lXNG3NQswwQQFYchPqq4Vb2@nongnu.org
X-Gm-Message-State: AOJu0Yw5jxT0CksSTPEnvhkzRsmWvOqnM2mmLkTZeDTLsrydUoomUDj8
 qY6KcZ6+eNJfUorpIGJv/UDpfxxLiMgVdmCow3JwigwVx5zLkLiA7nycyP9NxXAJEE0=
X-Gm-Gg: ASbGnct6PO8QetSFmpPpcxe2ws6jriUENdPCmNcqg4uJpal+90GDF6vomHvQ/QTPh4O
 n1ELeHn8R+p+1bCjc51julMN1ui+JOmV9A105HAmE3Sb+YJbR+9lztA1oPG5CSRuCivgD+Gohkw
 riwhIAa8TuarnEiUneyQTogQeNz2BovOnAG772WThNIByzffK/qcRFSTVF4sAeW8bssnrX8Tc1z
 hhKHsuhMz4MOc7wZFJQBWtP6fBpJhzzOyOwXVapuav3KAYWAPfllXCFfPK0l3Pinwhvkrjkywc4
 bjrCySqW+3UPDXAIjqMOR7Mmsir0HOc545EAlF4XFBLZ1QPnxKwmt77mKZ5m1bbZf9UbwS5q35r
 zG0kej3CXeOIjxwkeo3eQ+HH2QCuest9onlqFQ5te+Q==
X-Google-Smtp-Source: AGHT+IEdC971+ajMyBjhbgy6pVg/Le9rgWTDmQIXcjuukdCGhvt3o1sVh6mJOhEie9hy43CHJ7BY5w==
X-Received: by 2002:a17:902:ce8b:b0:235:ea0d:ae10 with SMTP id
 d9443c01a7336-23e256b5636mr195701845ad.12.1752874831449; 
 Fri, 18 Jul 2025 14:40:31 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f2fe8f4fdsm1690764a12.27.2025.07.18.14.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 14:40:30 -0700 (PDT)
Message-ID: <c07b0e3a-2bcf-4be6-a6f2-f328718eda1b@linaro.org>
Date: Fri, 18 Jul 2025 14:40:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 05/10] target/arm: Add BFMLA, BFMLS (vectors)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250718173032.2498900-1-peter.maydell@linaro.org>
 <20250718173032.2498900-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250718173032.2498900-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 7/18/25 10:30, Peter Maydell wrote:
> FEAT_SVE_B16B16 adds bfloat16 versions of the FMLA and FMLS insns in
> the "SVE floating-point multiply-accumulate writing addend" group,
> encoded as sz=0b00.
> 
> Fixes: 7b1613a1020d2942 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-sve.h    | 14 +++++++
>   target/arm/tcg/sve_helper.c    | 69 ++++++++++++++++++++++++++++++++++
>   target/arm/tcg/translate-sve.c | 21 ++++++++---
>   3 files changed, 98 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

