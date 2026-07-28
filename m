Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8760C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woi7X-0004kh-GT; Tue, 28 Jul 2026 09:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woi7V-0004jt-Ko
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:45:21 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woi7T-0000D5-CK
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:45:21 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-664e3ed58bcso1308522d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:45:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785246318; cv=none;
 d=google.com; s=arc-20260327;
 b=Gf/f1RUDonm39CfMwKdNplHJc9vNsYh9+y9FGdI7pDCDRU8jM1XIqxNMmK10zNe6yn
 4J9hBgsEg4Qf/ReVEyicCy88FzrfB/E2/P4gHB3cWEsdY9sgPqPaiRA1xlr+b0C6d1A/
 3yFUNXcpCR6ASbAja5Emd+GGr9k4cAyANhOe7CxIIvWcTqdoBSwl8mohFY81CT2LSFbJ
 7IH1y+V38rgEdQxYFbCsHeFpQOO+ZGDOJP7f6MaD5spKiOzEqViu5r9XA990Bmf9/QFT
 4nQSfO0AnZNTtq/rAJzyiq/JWg8BJ/gKZFV+bHVYrWrYRBw4m4GXQnZLguotlneqcuEE
 qTYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oWTksGYluHomzQY+4oVvYnKF49euD6wn1i5gDGA+5sM=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=WDMXrPZyFVmEEVxyRj8IOY5zN/qELvZhaviJpf28o6dlEo3kVpCNyEXHwexapIYDxT
 2Vsc1A51Dh+XVjIKVzIIF9vuEhJI+3lRfHglGVYcAV1qRSjew1cCeFqmNBJu6D2JiNFk
 eifVH26oh2whwihn8Xl8edmHD9DsDnXVljwpmEeot+sr6i4m/kNA6xu3tBsjhiVnw68I
 6ruAj5AzepNGY5VrWCOQ0Tfb/gSuutiuk3Eq73Q+1mVybEqgOyhh9UqALyswj1o4+Eur
 HdtJv3KB+Ws62he/BoUKHtFsvgJSOpNXUoidv1E6bkLH6ljpIPLR8jerP1iYAHQGXu2i
 t1gA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785246318; x=1785851118; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oWTksGYluHomzQY+4oVvYnKF49euD6wn1i5gDGA+5sM=;
 b=wtOnVKakbta3mYkDAFWWsBk8/Iq7JIBGgDVD5BUfBzhnDgZXeQ7n+WgPe70WxHdKC4
 sfET12KYgfikm9wtkhLn+SOBdb9woYlb8afWNa7Zn53F6hSu1IGYeU1FjPcQi8oLpOLM
 t5oZpKUXVNQLNQ1eah5aAtsMWVpL2LUtRZ+oBIt2zTW9YxZ5PzPHKR5raReHvOZR/XH/
 DkZPQYmxd1RLfGgh7f9sSS93+6PSAIK/6/lOCNV2cZAwKW/jAgs9S/CsYkm7DcG+oimp
 uNjCByU5WjJpJ/PF+Xd9uVmhe3YS6/lmS2vLAqC9GORUeY4hDAEOsA0AAoxHBJ7EY4H2
 t5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785246318; x=1785851118;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oWTksGYluHomzQY+4oVvYnKF49euD6wn1i5gDGA+5sM=;
 b=sDrlaWuAmmnsTusUJWOZpo12BA4AKEtp3ypEy6B19aDI/F2XbZYxk+93/0IawT3kR8
 yBBZmS80Eg27FLGtmHdrvJq4Vl8QuphSBdrycGJorOBaYNmslrhCNHyu5BG6HTJFhA16
 /D1IrIaSGJnciXdCvPvNOyBdZ39G92orlZSkNoD9qwBJhomaFomv3xIE/KiMlmYb57tD
 uIay/vXl6V5QUe49gtyx51BniPINohpCsSQJQsU07NUx6H6SMDeVV6Z5Ukh3v/Y5U7FH
 EaS6sw0VH5Q/qQ9B9A/A5Nei8Dkidb6H3Gojx+7l8Xtagd2Lphz8x6ihxJvRO3woY+RB
 EY6A==
X-Gm-Message-State: AOJu0YzFeOOnuWvnvCs5L9qGySz8D7OjWVHiFhoLJ/O3om+eyRfwUIsU
 1Pwxl/lJMG+6dH+bNP9nLGtnfllYOPN0n/pdo3JTWFSG3ulTmSUsdiRpOGOSTAUJcTdP/8dVcOQ
 4kYoXjHKQJP4CqS7D+oczOx76IKp0Da5Zp0pk8V7iWjwXBiR1EZi6
X-Gm-Gg: AR+sD13uev5S5ruxw2f6eYBRP/OIDiuRWPyXzdLaBJZfK/sfk9Dvllel95Akt+EBXE/
 /xO3s0NNH1caMXZmD4v2N1SbqvtF8g5K1VaMO8rBcDkA0ur5TWHNEcjj9fcV7OmxUfG8quvDVVi
 NPkVrpUKs6ETV+kMsohBpY3Zos8N1ARgVAWDqtzGmlnL8alhoNCtiLB4ezPStRbkGFz1zAw98pB
 bU8PJ6R6UYh8fYcaSqdQ1b8rS/qOlP4NjQtOsT/+9SaONO9DAV0MEYm6Mqo4JbDQlEL4coLzEgN
 fPtOJ9BnWsciyYwbG2+mMjl9/KJGvh/HOT7CgOuoduIVlF/uX/t3RX/L
X-Received: by 2002:a53:d84a:0:b0:664:d5ff:2856 with SMTP id
 956f58d0204a3-669056b8a34mr666743d50.14.1785246318099; Tue, 28 Jul 2026
 06:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260719174905.420725-1-richard.henderson@linaro.org>
In-Reply-To: <20260719174905.420725-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:45:05 +0100
X-Gm-Features: AUfX_mxz5GDWY3ReeGESaqLV6Gu7iHT0MPVjE7kafcNEYuK5GM82NcdI1dAJwYw
Message-ID: <CAFEAcA9sSHOFU8A5Z39dSc2KiytHm7NQtPWtZiqxgxQCc3Ah0w@mail.gmail.com>
Subject: Re: [PATCH for-11.2 0/6] target/arm: Implement FEAT_SME2p2
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 19 Jul 2026 at 18:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: 20260713230244.70174-1-richard.henderson@linaro.org
> ("[PATCH for-11.2 00/10] target/arm: Implement FEAT_SME_TMOP")
>
> One final pair of insns, FMUL (multiple and single vectors) and
> FMUL (multiple vectors), which are not covered by a sub-feature.
>
> Finishing SME2p2 allows us to finally enable SVE2p2 in -cpu max.
>
>
> r~
>
>
> Richard Henderson (6):
>   target/arm: Split zdn in do_z2z_n1 and do_z2z_n1_fpst
>   target/arm: Split zdn in do_z2z_nn and do_z2z_nn_fpst
>   target/arm: Fix b16b16 feature test for SME2 BFCLAMP, BFMAX, BFMIN
>   target/arm: Split decode of BFloat SME FMAX/FMIN
>   target/arm: Implement FMUL (multiple/multiple and single vectors)
>   target/arm: Enable FEAT_SVE2p2 and FEAT_SME2p2 for -cpu ma

Given your reply to patch 4 I assume you'll respin this at
some point, so I won't look at 4 or 5 until then.

-- PMM

