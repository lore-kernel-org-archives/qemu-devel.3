Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E27CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWz8J-0000aj-Ow; Tue, 09 Jun 2026 12:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz8G-0000aT-TD
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:16:53 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWz8E-0000UP-HR
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:16:52 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-68b482888c3so9180388a12.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781021809; cv=none;
 d=google.com; s=arc-20240605;
 b=AwIYF2VNS4dIyQaVu0KcKVUhTgq76KTy0bKHrt3Gczc1lFJN2AdEbyXjmYSb6jyNfA
 1bzuiUMFOOCJYtkmtqBSd8ho7nKe1gHaWedvcLnySObo9/8J4Ep8Df8VktTv/BeqPqKQ
 8/fhH8VIWGhtnjRgRPc8phoa01OPxrtBgyqriGVqnIQAbFmDHRjzfpvAos0EP8MQ7apw
 LTHhuhmAyk8W7labV29E970pjLlzobvYp7fbdpvhykogoV4ZPVLFo1rmTnsFuDtTpMhi
 7C2YfHN/CqJDP3rwwlwkLznz9+tunKQ1IIdjAbPQ16kKDsxSxAGcSy7SfJlE/48utAbN
 EQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BEqauq72TLGkjzw9cT0OndMnZkUOXqb47KY3x9X+n2I=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=URZ7yl3B4sVvuMeEqirorqFe8TG7erHLg6jyslf8B+iF5vDsJE1qp7gLwtHUnegeaP
 CH9A13QvpkpCGOhKgWPiJuNM/LaGS/w7WhAr+0dfNeSJcJBU60LQT+1kIQniEdZX/6c6
 Ik9KQ2qQ298jkr8eSItXLpS4fIZxjimOYZ8QYq7QPEv45H5IS1lByNpuLzmGyzvZDDy0
 RL/DK1U6d2Pne5uxNE1ejl0LV4JamHdAdnGSlvfJohZWUGn7xBWf03MCNdoCar8KU4sM
 CaPsLFcjD6PZU9SqXYQY2uPLZNiHtHoBbinmW2S0H2HSOWTrS3tvoAWHu0zEKZuhV79X
 aLVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781021809; x=1781626609; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BEqauq72TLGkjzw9cT0OndMnZkUOXqb47KY3x9X+n2I=;
 b=Zq0XExNxBOWfPPRLkFfPK4+/YuMTNtTOewTFF2FDHiDY2pzV0YOp6/yi1LkcMCM8Lk
 IPdYHGKKsKJiMT+4mG0RiBx0U4/HnoOIy1jlDTFSZYYIWn0aweebb4EFLfLA0+MJooHG
 w9xwoI95XGC3sqWxrOamiXX1r1jcsBwJVFKkF7Un/H4UO1k+alSpPjF/+7PY5sBsf0j/
 q7lQPxurGDWOVqw2Q6ZzxIwAsbZW9Kvbody0NGRSCfo5PdtmEsJo3plLO4r8bZ/3DiCz
 IT1KWEW01m8eKTvD+RRsZqWLug1R3b0hnp0Rhendfhy0vhBv2yb/6ez1X0qZVZ6pP7H4
 yjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781021809; x=1781626609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEqauq72TLGkjzw9cT0OndMnZkUOXqb47KY3x9X+n2I=;
 b=i7KYRMu8fzJIuFrW6go+5EkzOqa3o/DVeplFrmn8ozeVzGPjCNtoo23vGoq9gPxH93
 66PS+9BTZzX9uM4xzSmPmijtbgwhID2WOeIgj2ghdU/AWqsmL3by7mBTJkim5sxToP5+
 avQT+cWv8sjigz+A4zR3z/M7RJZ7nQ57xD+G/ZK8uGFYcXGc6wL7A9J8TS82518AwoJE
 ADCCWjUahUZ8xbinjDrroT+ldxtfW/s2liDEYZ+XlIMMGNlccqbExBQvGOXPJO4wHFXG
 ES6a4QpfmMNuecNngj0Cg77H9WDsiIRvMo8L/ZSsnEO7fmOu1Hg/PerbClsK+uToEMfe
 S5zA==
X-Gm-Message-State: AOJu0YyXDYlrTEN1GX/CZ9XWKsXl/7qC43cpdIpdAzIj8Bc1K0p1JWig
 dDYBrDuJT3WB8Dkk9LV6CAyEqXb/CnFTuqcCacEmFjQYHll/5wwiNoMCYDzwOfkLX2nGmKKSi8f
 pv/hxwPv5pDD8+PhbjLuIrm8bxsirRMTjErDuAOqR9Q==
X-Gm-Gg: Acq92OFzNcNL0ij7/5pFDr3FtIYE5vSMjt8Nqa/zsrfu8UAH9eLpvUW/AUWizY1dk2X
 qxdn7QqM/VWzJvaOnkaNj5J/UigIMOZNTJGLZTozUU42VeECc2cbLgeFIv0NeM1z9wYxwtXmKI3
 cLh2JFxeT0INEyt2xrnP5O/2q6wSSunfvUyVzLI1ov3auLbRq12R+DnTpydmQKiwbbH36rdN29W
 HWRCCy1D12bTOqn0h/xkgWTSGiwZEBYfuekmMobgpHRChUtoGAwRnh8zI6RuhL3+OXSvVUrSoE5
 LcmhcmIsDAwaEVjr/HgdqKeGixz0NqbxxcIH1/X7PigbjpNeK1qUoGSn18aIifwvC3+7YB2bo6N
 mPg==
X-Received: by 2002:a17:907:a4a:b0:bee:7c9b:fbd1 with SMTP id
 a640c23a62f3a-bf3a68ee6f6mr846975666b.1.1781021808726; Tue, 09 Jun 2026
 09:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-38-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-38-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:16:34 +0100
X-Gm-Features: AVVi8CfPTYJBhk1Wajx3ZkHr89Mjyjll8BC-2Yfm3-rKEJYXEC7ITeVYzY-9aXQ
Message-ID: <CAFEAcA8AjjV8iCR4WjOhYGCnxFPdr1JAa26=LAfdP9E5NRZg2Q@mail.gmail.com>
Subject: Re: [PATCH v9 37/45] target/arm: Implement FDOT (FP8 to FP16) for
 AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 3 Jun 2026 at 04:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h        |  5 ++++
>  target/arm/tcg/helper-fp8-defs.h |  3 +++
>  target/arm/tcg/fp8_helper.c      | 39 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-a64.c   |  2 ++
>  target/arm/tcg/a64.decode        |  2 ++
>  5 files changed, 51 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

