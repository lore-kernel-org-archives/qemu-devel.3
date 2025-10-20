Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91926CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArEB-0000fg-Ts; Mon, 20 Oct 2025 10:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArE9-0000dD-8T
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:51:13 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArE6-0004SZ-2X
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:51:12 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-71d71bcac45so47272477b3.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760971868; x=1761576668; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pnUo0H7vcYpXWxH62kAs5qwIR2CbIDJcmu735FNcVQA=;
 b=AN0izEJcOjgV62IFR82aU1kOxmeeaHwXTB/AR1dAq1L8zLrMZZWza6WcQddLcKPVFG
 ykp3ODRJrr6EbmcZFLarC8FdXuDCqaIHR8jRyvyIZ0H8zz3BIgpYgCgDOsWG5aIe60i5
 UKEgoXj8EKoouuUWNPJQkBZS6AfqjRKhnSpp3I2UEuTmUcQkay1igHAaT67hH/QNEGH8
 j6nMuMM9tIWuV3HL5cmR5LR2NIXRVrmrJaC96LRuGDNfsexgsDx0z+7UQh+ot9zAxk1z
 t1yw0x+XJ2kmzy+whqR5UzZ/qHNn1/6z1oeHA3mI+1ZZpPdN7c28tsfeR1pLyq/Uicxq
 Yhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760971868; x=1761576668;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pnUo0H7vcYpXWxH62kAs5qwIR2CbIDJcmu735FNcVQA=;
 b=fPZi73Mbid9FG2l2rcifMnwJerUfWcOwOCvYPh8J6ySjB7vysfQScoOdRG/k88V7Qd
 lrjiklUIU7YeW+NZN8jAzzQigTF6xd2ZFjh3mJNPNxyKeUMN99ip5+E1AIV5FL6H3chO
 2UCEHmE33axmT1fVi7JvhOvwrXng2guAwZ98RgnRQq2rIYvtfhjyw5gFsEVcqQs+N7FK
 ZlFlN/ABMmCelWsUrS5ysgIdzOzji+tDKNcd/hBPYDwir9hq7hteNHLI3LX+rfAADXMG
 3Ac4w4U8Iai7dr6QmFx+vEW5euej20sd3NzeEx7UDKVOUmbjA8D7n/B0ivoQcd0PsND/
 MLaA==
X-Gm-Message-State: AOJu0YzrR6kY9hkQWq7RAPHjULU8C19xziERLnKyoetC6lDx1GKOJHqq
 XALlvkNW/soLo3lIR7Ev3k5/XMexVpAO0lgLzShtdMZ59gWi4rRyGCYYspzBosuINnrfZFtfWjX
 JXLhGXMEgCYPXgrOloxYbOn3NUv/7hHdcC6MMdulz+M/kItGA2UHn
X-Gm-Gg: ASbGnctmuKDLrC0kf9getxixcN8OJoI/i6hVBXdpN9G9y6t4yyt/d4ztKUwmRlUWUv7
 OvFK82h/DAOnh/jUCqGYz+sxj1q5Pv945WwgxzBnRr3Sf/Nn44hT3nbf/kIECwUulB4nsrRf0jK
 FHw2MZ+Y0PGvG9PdLwYM9CX2VFjxkGE3CZAE862aZaOp/6yzUQBvYw8pmRffACiAgskyda+HRVJ
 42u4DjKYG8Ilf4Y3tB1Xpt/YgA2fa2Toe7eQ4oVcGCchN8TeedrLWXx8mm7YZk22IwJAmbH
X-Google-Smtp-Source: AGHT+IHBublffbeLsUla2pmH05IR6VDlmfVJy23SzY/ANJRGA5FHIAWg87UNSITA/1iwCoQxr+IhRf3sSIvYp7opftU=
X-Received: by 2002:a05:690e:11cc:b0:63e:1943:ce46 with SMTP id
 956f58d0204a3-63e1943d20cmr11713280d50.38.1760971867960; Mon, 20 Oct 2025
 07:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-32-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 15:50:56 +0100
X-Gm-Features: AS18NWC5asMGk64F-C3lPXS65sBdJGycRyxbFDy80R05cLZM540sUQYgoj4vDyk
Message-ID: <CAFEAcA-h5QXVdacxK=Mz2y9jp0TKcSaQ+ry=ZjvL8ZP0jOeUhg@mail.gmail.com>
Subject: Re: [PATCH v2 31/37] target/arm: Implement TLBIP RVA{L}E3{IS,OS}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Tue, 14 Oct 2025 at 21:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/tlb-insns.c | 53 ++++++++++++++++++++++++++++----------
>  1 file changed, 39 insertions(+), 14 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

