Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E6CC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHG6-0000ML-RQ; Thu, 03 Jul 2025 06:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXHG4-0000Ko-6P
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:33:36 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXHFv-0008O6-HC
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:33:35 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70e5d953c0bso88257277b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751538806; x=1752143606; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jJM8tLaU5xnHHK1n7aXPHkWtlPGa+f4/E1Z4BGUerHs=;
 b=iZ1tcNm7EukfZG86s0pIvdkaMwZ4fcEZ9jwr/69w1aSEd35DkqhsqsOBXuE8STvfcr
 pdlmCv29M2QescUP9TRWiBppCsk3sUFGQ1R0vfgR4EuBW68bmuAxYteZO91vY8VHj769
 MFfSKeIUtuWuOSVBGHPeGD/zBJ2ljrT24BWa4dS2XF6JZxnORuY/aXRzWmSszY5QpC7w
 c5pp/ATc3G5a8jiwhQrsR1pBT/cv+DhLC6ldEFF1d0oLaxo+bVt9Mjt4xrWJ6yECyIg1
 nTnSUplzOCFu4QQkZFTq9Ew+5gZQ20MHXRaTgZBM3VAPwerJr/MvSxN3e5cxte3K83x8
 r2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751538806; x=1752143606;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jJM8tLaU5xnHHK1n7aXPHkWtlPGa+f4/E1Z4BGUerHs=;
 b=LuS3W2SLY8MM84saDQnCz4FsKJu/ErM2gBB7uf7FDKhtpBzI7HrSo7I8tGWNN9GhBP
 BMz/ZVbD4du8LT/racG6yDOBCL2EJ9yXn8Zy67ubnRXJaZyU7jlxM2nPzZDVHGhOHjS/
 OtzOgCQqzMElMXlXz6WSTGgqs+75RjElfOnvZvSNO4pWvXVxCoxvAC4HQOvHFwTwtkkw
 aKHpxM+JHye2mZNDTt4eKrb4yoLLy8xgpwsOtbVDoI6wnz0Uid1Y/gBmVj99cA1CA5K1
 vXILXR7r7QI9NZIJVrFF8w6dBKUHqQdU3HtZP15Xte9YAtje6jKhlSgA/Jxg6qLPk9nv
 /ruA==
X-Gm-Message-State: AOJu0YwNKVsGquu8X9+0rJCQZHQbQhmumBuKFc30AfxlruQ65sZtfWgZ
 vNGg4Kj9vngW/Z88riPuzXlKZHherZCZr+364roYF4DqKdaXb8hk0b/BM6uMAmCRNr+FCi6bLXx
 owoXaROF/0lf4Bh9lhPiAuRuqxzfK1ov4PCqsH1fsR0BbEOsy0Y8D
X-Gm-Gg: ASbGncvoHYCSg7PEPRFRMFq94rxdQ35NUkyWVROAS+z/v27E7sFO6lTvavGHhFU3BKj
 HjdOltWG+IH4XqQ+k7Rfdsjx2nkbPKqh54nrJn7YsUPmH3KUiNDf9SXYOobdqu/lLj2i1ghKUhK
 ZHhEpZm7mnb/yzLIP9P/iU8hjmCw9cN3vBJ2k49vxlJIU1
X-Google-Smtp-Source: AGHT+IGiOfBEaygutdm7xNmeaE0wTqzKEHJTjV8yi9om5bwXV+kcYSCPHw6T3FeQyOXKR0UyOgRADGpNilfzD+S9fJ0=
X-Received: by 2002:a05:690c:f87:b0:70e:5eda:4940 with SMTP id
 00721157ae682-716590cb34dmr44031177b3.25.1751538806027; Thu, 03 Jul 2025
 03:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-60-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-60-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 11:33:14 +0100
X-Gm-Features: Ac12FXwVUooZ5XwGI_pdqxyAHUqbUHgfVGGxGfELI-6N6_BxAoaOMuQI3hYKxCs
Message-ID: <CAFEAcA-LePcpBVD_Wty5BFnn-kJMcwtdZbyXVjF9EOFwQuECHw@mail.gmail.com>
Subject: Re: [PATCH v3 59/97] target/arm: Implement SME2p1 Multiple Zero
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 20 ++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 23 +++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

