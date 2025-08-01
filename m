Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B75C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvSB-0006TM-9r; Fri, 01 Aug 2025 15:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtrM-0005RS-Jy
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:48:26 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtrI-00076y-Pd
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:47:57 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e8fe5f3f340so662442276.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070475; x=1754675275; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xY6Y9nx+hQ/ERDfqonR/TdqAPh1AZ7zBhoDKYRPfHpA=;
 b=zAQCvgiiQZkHhzOr8gYD/KLkdunEBDsBsvTA6/IRAjm/1rFAkwj5p+n1zGrjFe1SjW
 njj1v/5bB3r+K53rAQ2HU1UV6nNCXlCZuOdMTPjicvWe/AltJKLL4aM+JGtdz8c08i1I
 IHM6KI9aKs3dtG4DN9v3ea0obF/As63WrAsktWnHAB+piQMB6G9NdmDvIJ4uU0z4fmvj
 ZvTahLfG9MumNtbqSMeg3xUnQVAdPGwqrUciXyD2KH/421xyeTqwuodgeeYk4URWmHto
 M5wkKO/i3Eh1wEV1HsiFpcVKGoWOrb7BNGYCLE+Vwz1bL05cP8Qaazt/8TwJUpZKv0g7
 +PvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070475; x=1754675275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xY6Y9nx+hQ/ERDfqonR/TdqAPh1AZ7zBhoDKYRPfHpA=;
 b=hwc4JLNTr1yStCA3YTW9j9B1goDB716Uh5Asm2VdgU7fO+Pu7bH/D0jzFAE4wMS4zD
 uxw0gELU1FNTCRiCjWM6q8+2jgmUnRhDulPQwhg55EnEjPTLK3gECfQ9y/swjz3pDnSi
 2DqaiUl3ItcYS8dqDIb2sAQjYolg5uLmmWBFA+9kFQkMIgHxvcBnHipmgEWFMDr8gnKE
 jKKpbVvtZE0l3Fz6VpJGfzHdf8AiCw/Dc4fzpFs6VChgBuKDmYOoTaz33VfTbnAFAJgU
 7fSXIklKlON7VOp91Mxh5Hk/28fS+EkjiGBm481kTGDQZNhDL0q29rHltrlrLq+E70w0
 zwcQ==
X-Gm-Message-State: AOJu0YyDII8+tdEUx8z99BLr5gNHSWgKeSHqeBwM7q/AXAk8QPeNKR4q
 OtvRuSRMD4J3+ZCZyEYpx5SJwFV54cnQwsByXwuHMbXMBJNTNlCvFkXI5d7owVXnqjx92wfzo/U
 dYirAedkut8334bKOvSJ+7pLe8IoBBJ1VHlhZKuGtjg==
X-Gm-Gg: ASbGncvRdjtp9pTh9EhG2os/IRwfD2jKvUwD+eKLUzkueB8ksNvpBdNKi8b0CNXN0Qo
 k4vDVluGl+b+posQSNRINqk2GbGOFMnSwaXDXabVFN+e7whklP49D5YTdrS4xlQwSDA7Fsj+HZg
 Ts8KjlC11S54EpPTMsULRf5VIxVR8dY+VisBy7eExNvFWSx2a3dA1qZpEOt4RAY49FgsFWNsrq4
 lEL/kVT
X-Google-Smtp-Source: AGHT+IHqtzqq4ySdXEJi61ZeGKpkshPsdwWSYDBimi1kQJCgK89pL21Y8XPZahLjpvtVuU8KsSzU5my0Y6QoXaxGK70=
X-Received: by 2002:a05:690c:110:b0:71a:1c50:887c with SMTP id
 00721157ae682-71b7ef5b35bmr8331827b3.11.1754070475204; Fri, 01 Aug 2025
 10:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-48-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-48-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:47:43 +0100
X-Gm-Features: Ac12FXw3txLujIYfaT8lSj4KoFjfnEEp9yYEeih_yWPWHNKNQZT-EzU4rsLt-l4
Message-ID: <CAFEAcA9ON9AqDtJdfELxF+n22fu-uDAdKiWHfdScAiGKOV3HfQ@mail.gmail.com>
Subject: Re: [PATCH 47/89] linux-user/mips: Split out target_coredump.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Wed, 30 Jul 2025 at 01:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c                    | 46 +------------------------
>  linux-user/mips/target_coredump.c.inc   | 46 +++++++++++++++++++++++++
>  linux-user/mips64/target_coredump.c.inc |  1 +
>  3 files changed, 48 insertions(+), 45 deletions(-)
>  create mode 100644 linux-user/mips/target_coredump.c.inc
>  create mode 100644 linux-user/mips64/target_coredump.c.inc
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

