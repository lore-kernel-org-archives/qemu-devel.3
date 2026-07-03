Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5277AC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfaBt-0004pW-Cj; Fri, 03 Jul 2026 05:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfaBr-0004oq-K8
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:28:07 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfaBq-0007fA-3w
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:28:07 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6649ffb1d01so578213d50.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783070885; cv=none;
 d=google.com; s=arc-20260327;
 b=WJZHPL1pSxnUqPEh4gWeiMMK3bSMoIhfPRLXFCA9CTq3VvNNltXpeETBzUibL3QZTZ
 2qEWbeuG4cfYUEz+h/ZsdX5L1FdzNPhrpFcUd7zNloD75mEZ/06QJak3Gu6eiI6LbtRk
 dmvnXriQ7oPH/AKnG8+yAVic7Zr5LWzcShKg0gzMpFa8+8ZqGCL2w4645M7UoeBKZLNx
 S2+0qFBG4odPDfIZNo9UWErt5hRjBRQ5rUYaetN4UFfiqMa83r8RW/LPuqQ9V7VhwNSF
 YOlA5elCoTBYoAWRZ64HtxSdkdd8zoo+L3SnKvG1KP6IM9OI0qg69nyNT5bEb79IxchD
 GGbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VIeqffjGpU/iFP8bZYqFwZot2E/hD0BF0vHSKPooctM=;
 fh=NP6+VVjFmBFcC37+pkDoGTPTdPXHT3cE2pn2b7K03nE=;
 b=l2gNjZ4hrEHPlChWrOO87DOnOwlQxJNDQ6A0b5U33LFDgChvJK9eKko5tY+KJDuVYO
 Lh3RDER0EC+jV9Pq7aFSGOuwO06RC65n9fD9gW+ufZV8A1NvpFdHmoRqoE4t9iJJx8UZ
 1AN30hTnHiGpzZQr+wb0eCj+qCZ4Oa4tqDmIY78Xvd8PI9aALVPwYwjwej2/uMR+x7VY
 mWPEmZIuLo1+ei2KQBeZz7rd+A496oN45RcEZ1JOQwOMMDjFlqITdzaOMDrYYh1dbqyl
 aREeGlKBQDNepe405fC/sMABzLCyAXpkwoA1h+tT6WLX1yfuy/EeYrerm3q2jXfiPGjd
 sYOg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783070885; x=1783675685; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VIeqffjGpU/iFP8bZYqFwZot2E/hD0BF0vHSKPooctM=;
 b=Xg93E9KpXWYeT7qL178d+mDBX4OtIlkSh6tCMVfoTpqqDgbD/6CAmAxlkm3ZxCke6F
 VOrGjK9P5MMoo15iJQKNBcgng6EEmEsvYATGJb/BTGbZKb5AwOdI31dmz5/cvJ7rRsGc
 YwgMbZJdaxuH36WO5rdcbHYlvGzABI6qJVnE8O5XZ/DcOfUu8aUS8OeY8vdE7RRNhy8R
 smtezRcC0MUH3+B6r866/ewLcOT2jP7lu/xHVIVqiNGHpRBSr4eJoPf2qgbLuDRVGPsx
 OU14r91W1SGDRioC9/aX7E3e/K08gYzgVj7SGYMszTwAeyRWjnFmcF/07wP+eGWl467Y
 WB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783070885; x=1783675685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VIeqffjGpU/iFP8bZYqFwZot2E/hD0BF0vHSKPooctM=;
 b=geQE5hujJTH66yufaRPIgydWLf3tro19JPnOluJRWMV0Vm7otpO4Lnq3BjNNDKa3nL
 mEhqlmQTT38cguKef0vzF3Ims1eILRRT0JyfDMAO2NTjpjT9NtVbtibwLFghkQ1u9Gu7
 lhJsmMDl5HWHdVBrAlnW9DvUJo455hbhiMfia8BRQTqybFIpp92RpY0IsZJu/3MmeYXc
 xVChKUmlJLmGHVNz6pqkfU5+kQEDsKXh4FS+Br5JOjUC0n2sF1wBDeV5rB58+eY8B5PO
 uIERw2Nloacm/gN1eNu/KIPV7FVCGk2a6FRTDR6PYELRiQ3dyIBZcjJJG7YKC/xanID/
 LG5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1T1TkfOx8/DJnADpC3cfF++OIo/rv/hVGMQo8+iWIiE964x2gIZo4fRpCudavBPMhSoxep01e5Q9l@nongnu.org
X-Gm-Message-State: AOJu0YxLr46jGNPlFbahAGrYTHIRHz0LAJrg92FKdvYOfgSTH6DPbRx7
 xmv//V8Wl4iLSY8oQwKENVkZtNy1whqqUuDikwHKx2szllVkY/wNou933s7agzDQz+KRXdbhhuJ
 n3wIWT3u2TMMZZMpMT0RPqhX7OcR9tMu2qDBkdIrNag==
X-Gm-Gg: AfdE7ckSUKlR4YsEzOnRw1aAmjCjmsRDs0cxHX0UuY2l177vhW5h8AxDo8ColhDZ3V8
 BOMarQeq4qSHFFUx3gJK87jLT9qKWAbtm1II0Zzf2xA3sX1Xida1GJxMf+Bn6h9XtrFjKB7PtPA
 usAMrmVTA07RJdt/YzLka9LwcXOkEOBwTms49hAIIQJ+L/4tNIWuYG7wqKzBA6JGTkv416y9giL
 RR7MpgaPHQUZmurMCNbGJppHKodHAHBdze0P4VfsBJ38tbsGKIT9CARzf2ODYjr8f9la1pOy4MC
 7+1EwSHDpK7ZuSRU6Pm8cZ7M+h153PfuK1oWlVqAxCGQpl3bYvlS4Jsq
X-Received: by 2002:a05:690e:191c:b0:664:aa85:a7e2 with SMTP id
 956f58d0204a3-665219b9badmr9431449d50.28.1783070884686; Fri, 03 Jul 2026
 02:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260626231738.947317-1-oupton@kernel.org>
In-Reply-To: <20260626231738.947317-1-oupton@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 10:27:52 +0100
X-Gm-Features: AVVi8CdrAH9hTW7Uw_FFbG2yd6d1M-n2ipw5SzsSLISmeK-a9z-qtPnyupq1Vxs
Message-ID: <CAFEAcA8ry3ZZp0DrjcTwacf+znjrvv7d_bmF4iC0pTrhYSX3bw@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Only evaluate SCR_EL3.PIEN if
 ARM_FEATURE_EL3 is present
To: Oliver Upton <oupton@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Sat, 27 Jun 2026 at 00:17, Oliver Upton <oupton@kernel.org> wrote:
>
> Running KVM with (as of writing, out-of-tree) support for FEAT_S2PIE
> on -cpu max gets stuck in an infinite loop of stage-2 permission faults
> due to the PTW incorrectly using an effective value of 0 for S2PIR_EL2.
>
> Similar to how S1PIE is handled, only use the IMPLEMENTATION SPECIFIC
> value of 0 for S2PIR_EL2 if EL3 is implemented and PIEN=0.
>
> Fixes: a811c5dafb ("target/arm: Implement get_S2prot_indirect")
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Oliver Upton <oupton@kernel.org>
> ---
>  target/arm/ptw.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 1470de3010..51affba0bf 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -1414,9 +1414,14 @@ static int get_S2prot_indirect(CPUARMState *env, GetPhysAddrResult *result,
>                    PAGE_READ | PAGE_WRITE },
>      };
>
> -    uint64_t pir = (env->cp15.scr_el3 & SCR_PIEN ? env->cp15.s2pir_el2 : 0);
> -    int s2pi = extract64(pir, pi_index * 4, 4);
> +    uint64_t pir = env->cp15.s2pir_el2;
> +    int s2pi;
>
> +    if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_PIEN)) {
> +       pir = 0;

There's a hardcoded tab lurking here. checkpatch.pl will
warn you about those.

> +    }
> +
> +    s2pi = extract64(pir, pi_index * 4, 4);
>      result->f.prot = perm_table[s2pi][2];
>      return perm_table[s2pi][s1_is_el0];
>  }


Applied to target-arm.next, thanks. I added a Cc:stable tag
so we backport it to the stable branches later.

-- PMM

