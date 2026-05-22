Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7EFCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQYYW-0004Ve-BA; Fri, 22 May 2026 18:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQYYU-0004Uw-HE
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:41:22 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQYYT-00041o-1L
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:41:22 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-36a7bbb9698so722004a91.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779489679; x=1780094479; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+KjY9TLvJYr+Jq2FQcT4Wu8LDoRRKXiiYoaGbOdeSUI=;
 b=W12YxBqWQ0yJxKTvRPo+qgqGiZHXg0Py68uYzC8huNqxNEBGRe2bvq/5VjRFQTg5hI
 z+tQpUicbPOHhbDJhOmPL9lAaQNzRHQ0KA0JvzkyIKJTP/j/xKqrjl1J30d1lgNgA/ap
 LT5EziJG1ZW7daRVrfmUVXkeqRJF+XWFcEuLlf/L/RZzt6AmrmV8hrzogoy61ayiSSGo
 VCuug3we+aP7jC33Wsj2lo/kRs6+l8mVmRyEuvhN4gZujcwB7OkCqcbXLDr9bEnp4YDp
 C8PtlQr42yTVLe41R1ahRQjGbKrOcQwKyorP/VAILIs1fKlFSOL6KXc8IozhCOsOuukS
 NNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779489679; x=1780094479;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+KjY9TLvJYr+Jq2FQcT4Wu8LDoRRKXiiYoaGbOdeSUI=;
 b=eNmwk4EOJ3zFZt13cFmf/a8dXlf/IxDB5EYkxUdQHZFhQotmezkg3nhlA5Bgjfs53S
 p7qbA0Hk57Kr+i2yO1+LKIY9HAnWxZR69M7xkpmJNs4fEk1DPt/gBACnyQfZ8XOqZiKs
 3+Y/1+WopancQWrRy8und7u69C0Lc2qwCvFJaAMBM1cq6CyFfabkqqf1iVuY0z2dS/St
 JA7WZyrMIPWL098H7HNDWhFbQqa/MrJelR5yM9V0vyw6jeKv28+ejFqj11VkYcqkjms7
 D8VT9ehYRmo3xhwnx24s6rGzQFH+dENUf6WnltU+/MPmHdkWAe2Cp8tLWevgTaoSWpO4
 hq6Q==
X-Gm-Message-State: AOJu0YzBSwjMeTSp+s3ayhsnvVKx9oSN49vGKF/szIfxBTDsJbmkIacM
 EfUcQB8QF9/NTc3YEqdEay/W2lnKBORt697BVopal/r1fERrbBxfdvSFnyNL4c87mNha2e2YBea
 Esdhs
X-Gm-Gg: Acq92OFFTqKttao2/BfYlWcrSHynWGyvQ9KbKIP9Stw/MxykLR2Zced0W+D+nBbaNBz
 SrhBps1LkKao9jcIJJ3og/maRQZ/cpJ/d9Jk2mplApaicebjhLvgtV57AijuBM5Ci2/ptf1BaTZ
 xiefEHq+CqWrztjh+VxyWfl7z1bBL2raikthoIguIK9lKaCyS4p/TuLn2QhN1CvodJRPpbKnB3R
 6tmuknWAwhKvkAjf64Yqoom5l/XCtkuNyVKOIbRPqUtscqaAoYu4CmHQqoSaJHoir9xV8ySjm46
 Ak4snZzEVjNUwVs15mjRnaq8ZY9vyuMHxMnCvmu6dz+M5JALJJ8QoQU0PpbiGz5VRqzy2uxEyxs
 W65Sk39zInJDoB0U8cDj9K/nelNy6AKybsqBrDC7pj5nA+66yP1xYS2B5k6BBueG9X8y5+Qyhi9
 pUCKacYemTJoPNGzlcDGgJ+TWogIcWaG9flBU75EI1indJ90Z9tbs=
X-Received: by 2002:a17:90b:3c0b:b0:366:4782:1376 with SMTP id
 98e67ed59e1d1-36a67686c43mr5366832a91.21.1779489679295; 
 Fri, 22 May 2026 15:41:19 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a7212aa06sm1684724a91.3.2026.05.22.15.41.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 15:41:18 -0700 (PDT)
Message-ID: <1db5c791-0cb3-433c-bfb7-abac815ef10f@linaro.org>
Date: Fri, 22 May 2026 15:41:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/14] configs/target: Implement per-binary TargetInfo
 structure for riscv
To: qemu-devel@nongnu.org
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
 <20260520-hw-riscv-cpu-int-v3-5-d1123ea63d9c@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-5-d1123ea63d9c@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/20/26 06:12, Anton Johansson via qemu development wrote:
> Defines TargetInfo for 32- and 64-bit riscv binaries.
> 
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   configs/targets/riscv32-softmmu.c | 26 ++++++++++++++++++++++++++
>   configs/targets/riscv64-softmmu.c | 26 ++++++++++++++++++++++++++
>   configs/targets/meson.build       |  1 +
>   3 files changed, 53 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

