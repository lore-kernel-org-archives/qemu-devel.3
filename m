Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0766C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgQM-0006AW-Nf; Mon, 23 Jun 2025 08:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTgQ7-00066o-4J
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:37:09 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTgQ1-0003My-BA
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:37:06 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-70e447507a0so30421867b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750682219; x=1751287019; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jUoZsJuvj2FCDZwX3CsHC7kQH3TPYRhwBJ/pwpxe6s4=;
 b=n8jhTvq/2JI5GKrlBCNA9zK4U12HHkJ9hHmRWo1YSIMGbhKhRULumCLhkAK9e6nNWA
 VB9i6HDcfX+MnfdrTzwmxSufw6stmGl9nFI1DC0Ava7FY5wxvUgvP+qaddoIsqlc0ft1
 oCnU9a0iDas4Ri4Y3jEzxWfE9fbN8If6oHjItMZ31S6YUVRVdQg07gIlIuC/Tg87yCrF
 qyU798NkAU+fqQUTRuLGWT7JUjrjZ47mKQoQLJMAaovLuHDjK8UJQ7spq5BNY3Lf5dwe
 AnUNYrsaFjwTiPmDHiM8BeKXjOhbusq9kBhk2lO/XZbB9sflqKW/91l9UP/J9PIS6A0/
 852Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750682219; x=1751287019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jUoZsJuvj2FCDZwX3CsHC7kQH3TPYRhwBJ/pwpxe6s4=;
 b=i8qgNF0umXMvCrPbkoeD2d22obTsHykeblE6/A+692kjTSaCNFOumlMET1TJR59qTx
 Q5pGFL1dnl6CzMi1V9KDyOu5jGXTRHd65juNiVTWtONcqcEbfdZNyuedKXzGl2b62xFi
 sJF4+7iVc+xafJcV+4vEuYFTzgGS7Pi+3BlzIhsOMoQqlV6JXaQcOpN02o++kqD+VgrY
 iZe5uW6TV8o58fiMntc8Uk1TyXOoCuGx25htZ+oTgO7CZ4Wv1nmijRvH8+v+Q1FnBplO
 RmoaN8wze+BL4rV1YAkcVJcRtk/k7ZwSP0n4TbYFyb3BQvgRfuzQLapBDThaD9enjAEI
 He3Q==
X-Gm-Message-State: AOJu0Yz2r3XZ9i7/htRN3UxoeOx7wq1wSan5DGl3YJznZ1VXUl1S1NnG
 gvYU64fUd1Z/b0MH5kSFGxYnhIeap7NSCCUF+03bGxTT8TZgDmWzk1jKAe8wo6hxa+UpSWVGbqo
 ILu0dSRZuN2Ju7+IUnSc6ili++Zqy1JB1t3vqNEeo3+cfbIs6+yRB
X-Gm-Gg: ASbGncsQRnB49M9tlRkzH4QeEBuKb2pKKKR63Q4p/tbby2e1kIL85NqXChbD/ZrZE3m
 4dfUsmV18ti7y3oXhaBL14NKF8t458L5snG1x0a9KDvZXR4Tuz39+2wUxDYxC447ihVbnHek4ys
 yt6gC8au6sbTzbUkCYoSuykHgwtYF6AN1+3Otpf1asNtPwJ10+sMT6oac=
X-Google-Smtp-Source: AGHT+IFEWZxxRxzfvCZKe3SfC16TBreeK0LGqrBl3upLOur3/lYjDaNLmK/Zo9x3yP95tQg0OFYT3oByyD0WQLk//7g=
X-Received: by 2002:a05:690c:a082:10b0:70d:ed41:f979 with SMTP id
 00721157ae682-712c6389affmr112166987b3.1.1750682218984; Mon, 23 Jun 2025
 05:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-23-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 13:36:47 +0100
X-Gm-Features: AX0GCFutpjJuhPt6wSlw5dMKYi5VpfVXRSS7HiUiiJbA8LGw15vOnHSmqwSv8tk
Message-ID: <CAFEAcA-ixEmkSFPSf4pjBXLZsM6hPeXb3TropJZP00eSeBSK5w@mail.gmail.com>
Subject: Re: [PATCH v2 022/101] target/arm: Rename MOVA for translate
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Sun, 22 Jun 2025 at 00:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Prepare for more kinds of MOVA from SME2 by renaming the
> existing SME1 MOVA to indicate tile to/from vector.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 12 +++++-----
>  target/arm/tcg/sme.decode      | 42 +++++++++++++++++-----------------
>  2 files changed, 27 insertions(+), 27 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

