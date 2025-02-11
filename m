Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF5FC021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 13:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thq9F-0004Pu-A0; Tue, 11 Feb 2025 08:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thq91-0004OL-9T
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 08:17:46 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thq8z-0001A6-07
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 08:17:42 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e53a91756e5so4668290276.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 05:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739279859; x=1739884659; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wPHK2/7y7lM2DRSfC8k131Pk3pYOMVGZdLEWYS2YOm0=;
 b=NZ9soloPmbf73At8HVBAgMxU7p/u6fY5tBks6OdH6K28H98jMeYXtGCAn5VqGl+l5w
 mmJ34o1hKR+hHZ0Z50Sa89X0b4uiGIRR4uJCCNdiEeCAb2FgcwYRMv7ikcrvAuB9ZJfU
 HHo/FY81r9PbbX6lIHSUcb1rIs5X0cvIHURIRe2mo3EiO2b6gAqkz4NwY1U97dLiXQTZ
 t/IJC+ZhqbwGALOJ0ki2NHlzL2cMRwopYauiV/HyFi8y4TDDW3ReQ7gLeawvSFykkdBq
 uUKEayGrYOZXTZKiR4Q89CrFHUlyCLV6/B1yBPEHm8RoEq74lwkQo0VWR5rfke0rnsmu
 xy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739279859; x=1739884659;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wPHK2/7y7lM2DRSfC8k131Pk3pYOMVGZdLEWYS2YOm0=;
 b=W/Hv9NjrzXrhXigRZbPQ2Zi+v/SmRvNNLeQ0zTkS17bYxPEKpWP4XvfAw8ufRJHKr8
 wTV00RV+M+ylryx16db88kmJf4QXcuPBqjgVM6M07kFeivn0aEZiVyewsXIXpG3muqq9
 ceqoNePTOHcK0iDlJOG2Hy5oJz1FCe7Kmrw+ofL4leHDv9vUwZ7MI2fB4RjoxBS9aB4h
 5p0Tsw7m/vyELG83wMO5bUX2YhCAZvLeh5GA3KrF631bX2vIy+Ccfl1PDmSaE7pfPUuC
 UtKh4/tB1tDI3I2On8XqtqOfX9LmtG+mlE6pXi3tkH6piVUZPYvqdGz8S8W+QdFXAwO/
 gctw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7RKhujveNO44DT+7jvze88mQdZqOEmzotA5Np3qfU6nG8PcnCBbudQ+Z2rxV5qxxUmcF027rdK9kx@nongnu.org
X-Gm-Message-State: AOJu0YxzFYVJPZN8wwYNCpY9ljw9LIU5ehvpkW4j3xYojyqCtriLaG7q
 AFN9Zm5Zq614vC56i2NxNZOafHqOkARqssM6rBbp3Hz0DG4EFdCJglp/fQOpGOiG/x0y0kGzZR8
 zx4kNEuzSGmKo+x9WIEOUZfYr4jrbzqmasCEX4A==
X-Gm-Gg: ASbGncvxkaigTe9RS0lRuzPA8+gaw1jCBR13A5kql01KeO8n/K+/JedPnxo4IGDHL2U
 e0OSrYYlPQ1vja3VngQklkPTn8OjuFH17fQCbocSbbqGE+hsS+FU1z5tc36xGGNsp8tGTPq9VIA
 ==
X-Google-Smtp-Source: AGHT+IFWgXw06kU2v3NB/dBqscculj6CIFJt+G7rZlwWWbuG8LMkti1QUxsVbOxFSXKIJXjUgsKPr8MdB6gZHgCQ2/o=
X-Received: by 2002:a05:6902:844:b0:e57:34ee:398c with SMTP id
 3f1490d57ef6-e5d93d30d43mr4307512276.44.1739279858897; Tue, 11 Feb 2025
 05:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
 <20250201164012.1660228-9-peter.maydell@linaro.org>
In-Reply-To: <20250201164012.1660228-9-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2025 13:17:25 +0000
X-Gm-Features: AWEUYZldTfeBYFfbgHhQAEo2iFBAa1hCmddkzDFrihaVNPYzs7CA0bUbzp0lrBA
Message-ID: <CAFEAcA9QHK1HcvSEW+p=dGTJ0NjUKTq3C-+-Lr-rwGJpXTYKsg@mail.gmail.com>
Subject: Re: [PATCH v2 08/69] target/arm: Adjust FP behaviour for FPCR.AH = 1
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Sat, 1 Feb 2025 at 16:40, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> When FPCR.AH is set, various behaviours of AArch64 floating point
> operations which are controlled by softfloat config settings change:
>  * tininess and ftz detection before/after rounding
>  * NaN propagation order
>  * result of 0 * Inf + NaN
>  * default NaN value
>
> When the guest changes the value of the AH bit, switch these config
> settings on the fp_status_a64 and fp_status_f16_a64 float_status
> fields.
>
> This requires us to make the arm_set_default_fp_behaviours() function
> global, since we now need to call it from cpu.c and vfp_helper.c; we
> move it to vfp_helper.c so it can be next to the new
> arm_set_ah_fp_behaviours().
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

This turns out to need this tweak folding in to avoid compile
failures on the kvm-only config:

 #include "exec/helper-proto.h"
 #include "internals.h"
 #include "cpu-features.h"
+#include "fpu/softfloat.h"
 #ifdef CONFIG_TCG
 #include "qemu/log.h"
-#include "fpu/softfloat.h"
 #endif


(Once this has landed I'm tempted to clean up vfp_helper.c
so that e.g. the tcg-only parts get moved into tcg/ rather
than almost all of the file being inside an ifdef.)

-- PMM

