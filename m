Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5B6C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiJ23-00054W-Eb; Sat, 02 Aug 2025 16:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ1p-0004pq-JB
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:40:29 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ1o-00064E-1x
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:40:29 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-718409593b9so29511437b3.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754167227; x=1754772027; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xHLlVwxbOTeM3X7VtX+54L4tuBSgvWWsKZD17J4syB8=;
 b=bei/I8r5VnkptJlseHs5FGzySVPl/DqxGIFzJXsnPiBUIlnk2dmuGcc/YvRCVZBeTI
 cSrcZ7bVIKmKh3QFIqFo8qde1XWi9Pa7azM7tuxWE30GdnrMridKydPshkdmXVAzoHkA
 pgA7wNTysDutea/fHTxveiEfKaTJfuFYHC92m34YTIkgKRX/E79Np6pxnGsvq7fX09u9
 eJwfxl7Mm/fgH8M29BY92Ad0RTdGMo3ZMYJ/EvdoLFOkx/ha0lyt/KPsJUjHFiEd/afw
 3kUjNZ0GnpEu+MtDctSFr9pqoOlVmtrvrtX0xb1XDaUtJc48SXecWD88RobrqHdZacMR
 tW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754167227; x=1754772027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xHLlVwxbOTeM3X7VtX+54L4tuBSgvWWsKZD17J4syB8=;
 b=d3fnM+fkAYsAb9Rehh/dEGxieisXZB8ddl602CLISbAQrkbyzOg4X6cEYnEzfjmpcC
 0z6+uD/6dv3qrg++9fNW4P6b5HtxEnVNAbcOPIWy7b0w5KxJsP2Wxnx4SVWuuor4Mpkp
 ob0iaUZtg65g9PdVicdTHIVF2kzFJp7osaIeUeSKiIVdasawLOe5UWhbjCcOd0c0FPnr
 VEjj3luP7dQlQ65jW+t+CUdrAAh5d0Kr6Ov3VmbgPDVXGb9Tsf8M5PM33k1RtK0T/nzk
 avn+LfmVuV7Jkfn58PE0UNy82vwKLv1avqJjQxJ4rnqmKUu/BhzjUcHiVcwXi2q5uPEC
 6B6A==
X-Gm-Message-State: AOJu0Yx0rZd7AG/ppoIY4oo1f88MahA7DefuNzNg8igXkTmySDRUte+X
 Cp6w0wCsiUk2f6Z8BxmULiLvAtAd4JwEcb+e9I8jNc54va4raEFofsSdU69J3iXfr0qveZYkoRG
 VQa5O+OTPeAp7575AimgQociVkDItDkAxvFJ7UEoNDku3IYHr1Cre
X-Gm-Gg: ASbGncv+iigPXAInLbduxRVRJpO/S49SZDvBAw3GDpZUlw2vz4Gar1NTg6oBHens2RR
 4F405jhMBQxMIEoSCHm+RhBGl+aC6p69lXbhCWLnH8tmRSJFcDyg0hC/ewudeHiQmoMkapxiumM
 fiJ0/e4hh4I3j1yXIxEX8pHBSHxgc5BphfNa9rH7Ovx+31dG0O1VCZ4nzlK+yDC8j8tqF5nlFaD
 hqd5nQw
X-Google-Smtp-Source: AGHT+IG2ZXAgTHy5CNS7/CI6IVodjttuIEe5Njo8PdcQtE/ZwMT2sAcyfAyDlA/SuXiIhZPpjo7xCZmNt60SmMurbYk=
X-Received: by 2002:a05:690c:288a:b0:70c:a854:8384 with SMTP id
 00721157ae682-71b7f5f7138mr33159817b3.11.1754167226958; Sat, 02 Aug 2025
 13:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-87-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-87-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:40:15 +0100
X-Gm-Features: Ac12FXx02rLhkcK4UA3uErHgfXPk-RgWMRXbxJFkZs_VF-4QcLeKPPc3EBsWSjE
Message-ID: <CAFEAcA_Ep-M=BHr_h7EwpG_aCz_shsH2Bch8X11TnwbZoHFOQA@mail.gmail.com>
Subject: Re: [PATCH 86/89] linux-user/microblaze: Move target_pt_regs to
 signal.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Wed, 30 Jul 2025 at 01:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This structure is part of the microblaze signal frame.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

