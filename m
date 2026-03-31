Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B51610F9302
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 21:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7gZ3-0002ct-3k; Tue, 31 Mar 2026 17:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7gZ1-0002cj-6a
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 17:23:55 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7gYz-0005ZQ-Fy
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 17:23:54 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-650158138d9so5829702d50.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 14:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774992232; cv=none;
 d=google.com; s=arc-20240605;
 b=Zw8jBuHzOwP39bcTT/67A490yEpGZaiwwSuy2eyJeU0CZWyUOISYNtMYgORfKBB4QS
 pjJ/d1kizLNQ4pMw/p8YeeHhXpRS6+zduKOHr1V4nQOmNYEcUG/3MZHZ3dNswy3guAMH
 VuqqiWmlA7kofim42ZOUwGCAQG9FjYwpzc1tQG9vD6Clfkn3BeRrA1qsqpk+yetAkh17
 AahHIU51cCrVYXSM8GShPfV+fn2MCKdYpZ2MKc/7z0yBYsC1SApHkWsPPQ1Fbv0Vf14S
 590nlf0+mCAOnL8SCwlfqi3Mn1N6+1y9uS5xBxhQ/yZnjV7Ul0KYZr2gXmbJ9N31vc98
 xV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xBqqA+8ie79ohzw6gmtTigjb4M+BviUv5Py3F1oZaso=;
 fh=YinF2UPEkBqrxRYhqZZPDzzOha0Tmq/mOCzr2LcTxXg=;
 b=hYlAV5y+FYslJZ0ULDT8b6sMG41VMQI3CL6yqERaSW96EF09DdbHW8q6kUtoIYRsjQ
 ScUOgXsRZuSytOtFOsqHywPsq/QKIHbPHasHCUWTN67p98P57zBlsNDpu61sM7s7m1r+
 fTxOlfuinogSRoBFwpvAWUTr1DQaWPBYzZ8PZDDBM3lA4KRfgq+XKMh7qV1g2D+sQrr4
 1ZM+hM4UWYvCVe/x5fBG4Y0Y9GlUo3H8THShRGW5o5s8avwJceB4GcM5eZYlz1mEK0qo
 E6wrMV26kYjawiey0Ln8932Hv3g4VahUWiJxCjk7zOk4VF+BC2C2bWKc4TIx0FooWV+l
 ERAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774992232; x=1775597032; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xBqqA+8ie79ohzw6gmtTigjb4M+BviUv5Py3F1oZaso=;
 b=LvPgDOHYtkZ1FtGEokkoW2NJ+D2IHzf8an3wlMl5X3lOh8Z9ATyVfd2uferM0DRu+6
 Zp9QbWcUnF2TQJ5VSFwQcO/WAeBI8cVQefEnLzHN7AXWnTq8V/H83nqzE9BFNKwGqxFX
 vLeM969v0EzWU7/W4fXFOT00Fkgge3Ify2poT2pVHD5dYA/12jVkrYhAY3DCVDBlCL/d
 pM1BdbohwwIN6LtI3gE2NS5i28QerUiqHn07SkvizAm7EUlBfUwb71YqlEyCAYN28fuX
 BYvB8jpobpgbQAPJCCArWZ21izGeRIXGMsI4z1W7iIxVdJ4HaekN4LlbLandZzouq6OG
 jITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774992232; x=1775597032;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xBqqA+8ie79ohzw6gmtTigjb4M+BviUv5Py3F1oZaso=;
 b=D5oef0LfK+kvkUK+sgitGKAkOHRcPUETsNTFaO6V14FWX/Fghj/y9vNrXDT7R2JfIB
 jVQVJ0mwGSrq/phH3t5BepItJqbaYV/6GhmbFsjR0DvFmBNOCbh/9Sf67mzI74P4Z/6U
 nvXV6eo/Z5CMTs8pNUe/Kbk3s+je5F8mJoSjQysm7l5opENyqL6pcmrPHW+qe/UO0M0M
 h+aWEUtJIJPDpfXBBy+xeQN0gD5lVGOv9kUXBGNkNBd7booyFRx1fFLlHiLZkrYow0Wh
 BO3ahsfFtwbGmGkQleikxqqFPrF4fN0Al0L3m0DoNYuvu/23l9VeY5Bctk6FrQaq64Ee
 mTJw==
X-Gm-Message-State: AOJu0YyIDLMNmYqJbWl1TMeLgA2flKPFtmDep702IMo9F6khH1thONKT
 d6gobPTLJU90xZPypwZmOBMECGyLXGAWNUCFx1bvAwtUFhK2SEVgZhX7IzvXAZEpx1vVICh0nvr
 NozsZpntWisLhIzg0iIHZk0Lk8i6pMdxnblZgV1nQYQ==
X-Gm-Gg: ATEYQzwFqAzIj10Q2Gvuh88GqxNCe3+b3ujxECtwjswgirpfk917G6OaYBxpQAPHd7H
 lbM2NPoGWlDVP7UWdQyQbfeV/QAGS3J4mqG7x8CMX+fGDbCuNLUOPwcYAkcKOJt6SMHeTWURvoK
 dnAbGSnmUIbIfP111Nq6xTPA6hJhLNAdfz02aQKvn+YwkZhP8eluLeSb1H3OZF8ug5mNvR6ooOV
 ezDqLHgZZr64SyVha86V0q2H1RuvpAib5UeXHiZQRAAg7Zn1aTSoEoKM/YP8Ih24fnXCF2VbstN
 XYYRKGLpZ5X+PnpO9QewVwba6NHCAhu146KS2IRYg+tZIHJHmFTi3BfPyvuI1tKE8Po=
X-Received: by 2002:a53:ebc7:0:b0:650:1485:26c6 with SMTP id
 956f58d0204a3-6502fdc0f0dmr721780d50.19.1774992231744; Tue, 31 Mar 2026
 14:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260331185219.12187-1-deller@kernel.org>
In-Reply-To: <20260331185219.12187-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 22:23:40 +0100
X-Gm-Features: AQROBzA05MB1s-6HwSEMyYTnq7kF9Dhl4ZGyCxaxXZO6EgCvnvlNc6fwad7CoLI
Message-ID: <CAFEAcA-3uu1sf2qa6+QgzV727sFo_TN0+=6doBudWR-GCfxofA@mail.gmail.com>
Subject: Re: [PULL 0/8] Hppa more v11 fixes patches
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Tue, 31 Mar 2026 at 19:53, Helge Deller <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit 770f50c14f098717fd40ae6e826a495681152447:
>
>   Merge tag 'pull-nvme-20260326' of https://gitlab.com/birkelund/qemu into staging (2026-03-26 10:26:39 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/hppa-more-v11-fixes-pull-request
>
> for you to fetch changes up to bf758751aa4d088f8d7bead7d335d028bcbb89d6:
>
>   target/hppa: Update SeaBIOS-hppa to version 24 (2026-03-31 20:24:24 +0200)
>
> ----------------------------------------------------------------
> HPPA patches for qemu-v11
>
> A few late fixes for the HPPA architecture for QEMU v11:
> - graphics support was broken for 64-bit machines. This series adds
>   support for VGA graphics for Linux guests
> - the various memory ranges were not correctly implemented
> - TOC/NMI was not working on 64-bit machines
> - minor 64-bit HP-UX boot fixes (but HP-UX 64-bit still crashes)
>
> ----------------------------------------------------------------
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

