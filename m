Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDB3C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgpa-0005TO-28; Thu, 30 May 2024 10:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgpX-0005LL-Ff
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:32:36 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCgpW-0006Ls-2D
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:32:35 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-35dce6102f4so139541f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 07:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717079552; x=1717684352; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6PQk8GLJL82FyKYm9CCZMTar4iu7k3Wi/T+veQwExR8=;
 b=lwiCeE5QdrbmSU0bTkanLv57V5XDraytSX5jBCTZSMW2ulDP3imXDd9wVfCI+Q5LzK
 cYA5ab+2LEa/N6nDggLtS6nGWthIEHIlW4FOfqBu4JwbQ1f9rvDh7bijw1zCsjCdUvii
 +qLybtFlBEcOJhkrTJgP08NsoDz7gic/1Gc34Om4NJ3eul2eoJcRBOIj6HimXp57WIQP
 Sn1khbGdqBeszXbxceVkWkhB2jYPG3O1RooHhRwNL85xJA9xuJ/OpkJMiQ1DMKOoBpSv
 9aJeHqs7CkVVBucPxfpVr0pOzse0NUXy4EvrvqpWDPkx0gNB7Drw79PlwmYr3isFreEo
 tg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717079552; x=1717684352;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6PQk8GLJL82FyKYm9CCZMTar4iu7k3Wi/T+veQwExR8=;
 b=eqbuSLMq6wz2BBKTfStvlBovvlMwXK036qODB4voK6OXZhApJuxLPydzJvXw1V9aI6
 fubAvTx+I89YS3F0oG0VDhr8Gp4GvuVrkmWV/wVsYtTE9f4UzbYHi3jJmFVIwJma5z/J
 IMGNDq1AKOwqvUpFhZNr1nrBPeJ18Kgbwf3DBSEEcCU7iG51DHuDOxtTkhaEub3FBcBU
 97emzfxWj71YfJsFY9pOC1wgDMjOKIhi3FIwJk/TVlZxDWnXGb+aXjshjBqeWfx4uDMh
 K+FQEJ/cpGAb/Lmhpr3b/mkVd+75PSR1rweL1dFuMJ6PWUvEE6lHv0RHUDKA/TaG5e83
 h0Bg==
X-Gm-Message-State: AOJu0YzxTXxGGahk5FqdVEQT4768JJEQl6bQ9/MQ3+TuQFdMZw4SkIL/
 C3GD58qsdQ1+a44hJf6Q6BDSs/XShB61EATzsM/TEIyd25rp94F1igPxT0Hc6q2IDzC/Ht2aXHg
 mqwCdKCTG5G81har5a++cMq9x/3FKnkpHVka2rODJaIXCrCcp
X-Google-Smtp-Source: AGHT+IGvkbMgICG2ttwqhQcfcoDsnvr+e3uEpusvvGS4DhrAsE8rI6msvhCC/vrENiTqqiiRU+U48VnyIP78fKcSTCU=
X-Received: by 2002:adf:ff86:0:b0:35b:9ab1:ea77 with SMTP id
 ffacd0b85a97d-35dc00c99f0mr1727012f8f.53.1717079552645; Thu, 30 May 2024
 07:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240528203044.612851-1-richard.henderson@linaro.org>
In-Reply-To: <20240528203044.612851-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 15:32:21 +0100
Message-ID: <CAFEAcA9pGM6R89LzAfEaN9TVrbj0oWeBrO9xBRn7hSx+OpphLQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/33] target/arm: Convert a64 advsimd to decodetree
 (part 1b)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

On Tue, 28 May 2024 at 21:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v3:
>   * Reword prefetch unpredictable patch.
>   * Validate vector length when qc is an implied operand.
>   * Adjust some legacy decode based on review.
>   * Apply r-b.
>
> Patches needing review:
>   01-target-arm-Diagnose-UNPREDICTABLE-operands-to-PLD.patch
>   03-target-arm-Assert-oprsz-in-range-when-using-vfp.q.patch
>   04-target-arm-Convert-SUQADD-and-USQADD-to-gvec.patch
>   10-target-arm-Convert-SRSHL-and-URSHL-register-to-gv.patch
>   12-target-arm-Convert-SQSHL-and-UQSHL-register-to-gv.patch
>   31-target-arm-Convert-SQDMULH-SQRDMULH-to-decodetree.patch
>   32-target-arm-Convert-FMADD-FMSUB-FNMADD-FNMSUB-to-d.patch


Applied 2-33 to target-arm.next, thanks. (Dropped the PLD
patch for the reasons we discussed in the other thread.)

-- PMM

