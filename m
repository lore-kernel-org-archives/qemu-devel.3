Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A020C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvg7-0000l1-Cc; Fri, 01 Aug 2025 15:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhu9S-0000ik-4T
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:06:42 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhu9Q-0002Ly-E1
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:06:41 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71b49bbb95cso12003067b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754071599; x=1754676399; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CvmaC4XQKpqGDFUWg+/EJ0SFGXbPB6hYDMLmdbA+MGw=;
 b=Fh7j3ljg44BivufscuWpIAps88o6rYUNzP7Iv7GZKTtsvBZ719Q+b7s4cEdJbPLcVC
 JUt9K1i3K65mPEvwsJkaHhjrMvfjvS2jtSoei8mydk6WiyiyYnsfUNkmHjKrIl8mDQ6Y
 yhJm9esQbVBkB2w6QgaWbhaKmE79WJogzuJK0iibT+0Pzwl4W5ahluowBQBcQAHMweFW
 7eT2qP/lJmRVNty6qwOLoNoe6pgqCB1uGPR2DF4UHNbRIRWRlTWbKkXjxgDEoTmt9/i7
 v1GdrK9LG0BYy7ym9ypu7Qc2URD9rkQPlRl9OR2L/f6tzWcUXhMxyS54dv6rLuYAJ+y8
 0efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754071599; x=1754676399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CvmaC4XQKpqGDFUWg+/EJ0SFGXbPB6hYDMLmdbA+MGw=;
 b=CnXZsZZB/CelZ1GBUMg16/MYHyh/G5Sr9rhzt6Ul7avu8OQskfzzJQzhl1R8VdjRpY
 jucIiI97Fb6GcPYMo/cEZFo/345dfwVqCCrcgi6tEFgmku5QGEyNs+gGXhcwpIoxBp3Z
 jn2T+E9a1+8HgsIELCJjrLcn+0HzVNuZC0CZQ3fOB66RnVAylhQ93PlnQOMUJugWlHS7
 MBQprZ23Ch5OBK1vi3nt1KI1dPQtnPhjwBfgTTVSg4ynk/Bb9atTI/Is7RJ3TcZcE19+
 Zl9nJoUwdFqBqlpS7z5Yhwd0O9UnbH0+Xq8OmrnMrRYKdOPwzBCnQ3TtsT/SHj8Op0CG
 HwDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk5gE7CLcYO09MiJ9/GAeCUVwR98gvUAvlEApFFlGE6XOY18bmhMZLcydCiLF4s6MIOnKeL79Lgp44@nongnu.org
X-Gm-Message-State: AOJu0YyVT2NFzfwGwOPy8hxgtWWh/5VNdY7bHS2q7DWtFA5eUfTCKTZ8
 iq8U8ldsdRVW3NEuSX8excmdgRqj0fkUM3nv+qpBJd1/MHeBzy2+8cFXBGBQdu7DqkFiYLiw8xn
 4xY6X1TEpu23tosqMrG3R21DTTCvWrcN9fNUc5O+aMg==
X-Gm-Gg: ASbGncsigu0G+m+/9oX5rpiP+rrH6NapByteEa296uzJK4GcyRb5uiJ36DZemebundv
 4xXKF9ng4ekqO5Eo38Gq8h+P2eRBdGilFeiaSC0PM3Gk5L92BOkEDCMAorWRUEejqCus9wnKbtY
 tXBmK/T599f0vvHDypfCuzgZB4gGErT2Rdbv8tfPMMXgp/jYbB7dijacTA0vkEum9nxvRmo9qCH
 PQNsshDm89/tMzyuBk=
X-Google-Smtp-Source: AGHT+IHO2d5uuv6wbLsNM5EVO8eSLzn4fKdRPJSCp7C8E1uwXW72C71a6X18kpe8arBI6AlQXi/JU+Ay9lrjaK+sGA8=
X-Received: by 2002:a05:690c:6802:b0:71a:23b3:13af with SMTP id
 00721157ae682-71b7ef57a09mr9667387b3.13.1754071599004; Fri, 01 Aug 2025
 11:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-38-richard.henderson@linaro.org>
 <0128c452-8bde-4bdd-b73c-330a7bd619a1@linaro.org>
 <e275dc71-2d48-4b48-9b7f-dae2c8934d64@linaro.org>
In-Reply-To: <e275dc71-2d48-4b48-9b7f-dae2c8934d64@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 19:06:24 +0100
X-Gm-Features: Ac12FXxdGMGjJsFFiZ2jTuvGmdPN0N7YJcXl_iIZArAv4vvdEi5xc566xiYQ8Ww
Message-ID: <CAFEAcA_b0dwepMFpSaY31fCUd749mpU5M2ZVymonPPBAEsTLpA@mail.gmail.com>
Subject: Re: [PATCH 37/82] target/arm: Convert regime_is_user from switch to
 table
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Fri, 1 Aug 2025 at 04:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/31/25 07:21, Pierrick Bouvier wrote:
> >>   #include "mmuidx-internal.h"
> >> -#define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK)
> >> +#define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK | \
> >> +                ((X == 0) << R_MMUIDXINFO_USER_SHIFT))
> >>   #define REL(X) ((X << R_MMUIDXINFO_REL_SHIFT) | R_MMUIDXINFO_RELVALID_MASK)
> >>   #define R2     R_MMUIDXINFO_2RANGES_MASK
> >>   #define PAN    R_MMUIDXINFO_PAN_MASK
> >> +#define USER   R_MMUIDXINFO_USER_MASK
> >>   const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
> >>       /*
> >> @@ -33,7 +35,7 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
> >>       [ARMMMUIdx_Stage2_S]        = REL(2),
> >>       [ARMMMUIdx_Stage2]          = REL(2),
> >> -    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2,
> >> +    [ARMMMUIdx_Stage1_E0]       = REL(1) | R2 | USER,
> >>       [ARMMMUIdx_Stage1_E1]       = REL(1) | R2,
> >>       [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2 | PAN,
> >
> > Maybe I missed something, but what about other entries that were initially treated in the
> > switch?
> > - ARMMMUIdx_E.0_0
> > - ARMMMUIdx_M*User
>
> See the change to EL().
>
> I'm not sure why ARMMMUIdx_Stage1_* is excluded from arm_mmu_idx_to_el(), but I don't
> change that in this patch series.

It's always been that way through various refactorings
of the mmu index, back to commit c1e3781090b9d36 when
the function was added.

In practice we only use arm_mmu_idx_to_el() to get back to
the EL from the MMU index that we put into the TB flags.
So we know it's always one of the "complete translation"
index values, not a Stage1-only, Stage2-only or Phys index.

My guess is I originally put in the assert that enforced
that you don't call it with either a Stage2-only or a
Stage1-only mmuidx because I knew that couldn't happen and
it meant I could implement the idx-to-EL code for the
valid cases as "mmu_idx & 3" and didn't need to add
extra code to handle a Stage1-only index the function
would never see.

thanks
-- PMM

