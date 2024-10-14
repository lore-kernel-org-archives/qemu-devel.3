Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B82D1812F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 16:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0O8l-0006jS-NX; Mon, 14 Oct 2024 12:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0O8j-0006ii-M5
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:41:49 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0O8h-0001gy-Ex
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 12:41:49 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539eb97f26aso1808917e87.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 09:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728924105; x=1729528905; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YLnPlc8Wk82BERYeTM5I4JDtZk08l5fkN3/0TnAiXD4=;
 b=XC4MFCkrBDPAasjoLWDpGd2jXaPqTwAA3Crrl9/mWLR7COgUi+HaiTS4FTeOw/zUDS
 qMis008yuGDDJy9P6W1PxIvmkyo3OY6bQqJIbM66r3t+iXgE39zJ/aeF8EHHeAdPp89+
 EePiTUKnRD+6CIgyTyvjIxDRGJWECw98vsy6fCiMYOthAHbLOS1O6OXEJJ3cLPhSmhXd
 5dyoSUGTETslMcIlYvYLEBCzq6usSr8NJhqtklX7OKpUeSYz9WmvfFnn7IXFe4xflmwG
 NL+zC5oplGQO4KFg3TBvnhHClqaPUcSb/jPYZVyloeQwDJVEfvuZlMVTZKTxiZKY6eby
 NTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728924105; x=1729528905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YLnPlc8Wk82BERYeTM5I4JDtZk08l5fkN3/0TnAiXD4=;
 b=iChBplREHspGNfUgmMVHy8ThN53U8DIUj3vKP+jkH9YHaVzz59nlzTMpAkXD7ReLEY
 pvC6Nsn1bAxdO2ZWK3HItqDFiYlCGgJCjYNJyYOjjQvd7ibekHE96Cwz5sIMNgjCos5X
 QCaG2s/d3fc6DcECFzX/YERNAqbHVq+Rblq0PS3PzleO1q93/viM9vobDDp9n68ETUUd
 7ZAU4MOGmDujcc9/EJgKfAjQPeRBMIty1CxncshJOOKknEc5wwwUhnhIRmZ8rHot1rph
 LCzQz7lhiSCFdOgaqyZG44UmXI9kVAvPS387sNg9xx+Jk0bfgOGz+5tgOMCkEzfjn5L8
 gRuw==
X-Gm-Message-State: AOJu0YzdFyLcafrLaHZrypdf2/UmBIKhPUEuJYwJkUadas1Q0/uyYJmh
 z8tWFO+tqOYBWGDfeVNKRizhJERuRgXwi+8ryuzSwAZ47clD+B2obra/OC/ABL3vGSBP1UUnelY
 EzdcNbb40KTW0fQM8Lk/M7t3pISI2XdVjtA5yzw==
X-Google-Smtp-Source: AGHT+IGdfx6z94YVij4gPRIVNToH6x326iVhZ99UECBx7p4qCkpNyHE8iEfkn1hY6xiBzaVL2wVnJtcttDpxI1uI10s=
X-Received: by 2002:a05:6512:3f02:b0:536:5625:511a with SMTP id
 2adb3069b0e04-539da59516cmr6020488e87.47.1728924105049; Mon, 14 Oct 2024
 09:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
In-Reply-To: <20241014-arm-feat-xs-v1-0-42bb714d6b11@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 17:41:33 +0100
Message-ID: <CAFEAcA_SYtVHjf2LmOkHZPHET=8r9BSCsir1R=PWLM55L3O4aQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] No-op support for Arm FEAT_XS, feedback needed
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Mon, 14 Oct 2024 at 11:50, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> This series is an initial incomplete attempt at adding support for the
> FEAT_XS feature in aarch64 TCG. This feature was introduced in ARMv8.7:
> it adds a new memory attribute XS which indicates that a memory access
> could take longer than usual to complete and also adds instruction
> variants for TLBI maintenance and DSB.
>
> These variants are implemented as no-ops, since QEMU TCG doesn't
> implement caching.
>
> This is my first foray into TCG and certain things weren't clear to me:
>
> 1. How to make sure the feature is implemented properly. Since we model
>    cache maintenance as no-ops my understanding is the only
>    functionality we need to provide is to expose the FEAT_XS feature bit
>    and also make sure the nXS variants trap properly if configured with
>    fine-grained traps.

We also need to make HCRX_EL2 writes allow read and write of the
new FGTnXS and FnXS bits. (hcrx_write() constructs a valid_mask
and only allows those bits to be written, so the mask needs updating.)

> 2. Is there a point in adding a TCG test? If I read the manual
>    correctly, the nXS variants should trap to the undefined instruction
>    vector if unimplemented.
>
> These patches lack support for FGT for now.

We will need the FGT support, but I think it should be
straightforward to add:
 * add a new entry NXS to the FIELD() definitions of FGT in cpregs.h
   with the meaning "honour HCR_EL2.FGTnXS to suppress FGT",
   and in access_check_cp_reg skip the trap-check if NXS is
   set and arm_hcrx_el2_eff() has the FGTnXS bit set
 * when we add the new ARMCPRegInfo stanzas for the new NXS,
   make the .fgt fields be
     .fgt = FGT_TLBIwhatever | FGT_NXS
   so we apply the NXS logic to those ones
   (or if you like use macro magic in cpreg.h to define
   FGT_TLBIVAE1OSNXS as being FGT_TLBIVAE1OS | FGT_NXS,
   like what we do for including FGT_REV in the FGT_ constants)

-- PMM

