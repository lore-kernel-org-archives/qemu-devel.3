Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253C0CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 09:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64PY-0000Mg-Cw; Tue, 07 Oct 2025 05:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64PW-0000JY-Ea
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:55:10 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64PU-0003oL-Ps
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 05:55:10 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71d6051aeafso64188807b3.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 02:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759830908; x=1760435708; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rCIvTZGGGTDqzmDo1tWcfqGgWXa3PVzNi04H2DduP7g=;
 b=ABGJbpROkNsgJR547+7XwhXLUf8VZaJW83oWLsu5LwRhOToqTh5V4J48joKqd2JBOg
 TzSqlm5bOQk9RcZkSikY+T3DjVU9G3B6MCqD2KI9vjI93maaCL+FmkcroJJNYAA/BVgK
 ueN7AzDY432Enuag+7QeA+JLDRu4pSXLmbs6LHLSIauCeFotCqTc0TX0UlPnrxQXQSnH
 0SWiLM9g33TpROAeKLeew3PYOpVXBq+k5P22WGIZ9eacYJS9aiLYodxHEJO0CLxeJajW
 37w4QrZ/4EDHlUVzRURDSOUgULAQb3+hiKx2PNE7MGxkRYC7czeH3IHgworMPYUPk3Em
 XGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759830908; x=1760435708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rCIvTZGGGTDqzmDo1tWcfqGgWXa3PVzNi04H2DduP7g=;
 b=RJnb6v/FlJ7Fhg/c+Mt6gQk4qWzR4iXFqzaWeydK02zDDo2kSnz6WSVloQacloBFIf
 mQypwaX8FEIoc5BTq9/XLAbQDcZD3FPubslL+fkdRQGngfIJZC/910aECauQnla32xTM
 dSl1bCQYTrfBodAYkR8UKMBYphfDeOR88cSCeBiqRb6QtNed2kUNrs20wNT68Z87LFG0
 /L926ISHLXkbV4iOsY8Xv81o6efSaG5qVY8VELKBjnu5enSjk6xChzBbgpz72EaEXPfP
 uq7rxv/WMVtepIPV2ZNRHFV7kPQ9XOpbV/G2jeDnrBBtFBHuXWLdAxwbkZPTu22r6y+r
 wsWA==
X-Gm-Message-State: AOJu0YwxLq/t3k+tVmXFNAs+WRNZEkFUdt2hxh7zx3WYDt/P5wm+AeiR
 ecZichdpMXc6mtsfOyvVmlpMtIKzKbW8JKC4Ov1gDFpvtkC/rnFw5tjWyNP1gn6/qe7ZbRdhIbz
 iZsxbbm4cFHF+9XT83j1+7Sajs9/TMIR6MtpKXHYikWa7mZTJFi5Y
X-Gm-Gg: ASbGnct5wMa2CPrg7DC5TCSw4pW8NFogXMZKbCDpewtW8qQ9xp6rvQvd/WCTdYsfnP+
 7mjG8q1C4Jlkg53NHjEI9nv0NiGpxLheBN9ijfg3Qzu7ghDE50yz6F9ZqT1Uu2ii/JGCkpqWWEO
 7nUpj7js1UL9MyO5NtFVpfdOaBsbagYVOF6vWFC4pAa9uH9D+GR+XBdEtBAAKXany9AjJ6nlLXJ
 jN0qmh2pjBsgUZWGQmWJdnRba5jxOQWM7f7u9TWx4tVLHQ=
X-Google-Smtp-Source: AGHT+IESDk5ZPp4UAdQuLEt5Uno382eWPQYMajQ8ytcaRfUTj+tCMf0ivEYmH/2zS2hy9AGyevo85f+5A7z+etLh/i8=
X-Received: by 2002:a05:690e:ec8:b0:633:a260:14a1 with SMTP id
 956f58d0204a3-63b9a07c6b6mr12020483d50.18.1759830907412; Tue, 07 Oct 2025
 02:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251003170800.997167-1-richard.henderson@linaro.org>
 <20251003170800.997167-35-richard.henderson@linaro.org>
In-Reply-To: <20251003170800.997167-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 10:54:56 +0100
X-Gm-Features: AS18NWD_-HpjFXl_4LKhUYfMysKMFdgnj3jisOUCBe_jibOEOfpFbkh-YEpuWXE
Message-ID: <CAFEAcA_vn2hLx=PzEW3z8-BFZoq75Hs04FLyPD_zsrmfAyvyPQ@mail.gmail.com>
Subject: Re: [PATCH v6 34/73] target/arm: Make helper_exception_return
 system-only
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Fri, 3 Oct 2025 at 18:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-a64.h    | 5 ++++-
>  target/arm/tcg/helper-a64.c    | 2 ++
>  target/arm/tcg/translate-a64.c | 8 ++++++++
>  3 files changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

