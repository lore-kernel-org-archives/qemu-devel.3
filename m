Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2DF10D14AD
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 12:55:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7C8o-0006So-Ju; Mon, 30 Mar 2026 08:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7C8n-0006ST-KZ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 08:54:49 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7C8k-0001Fb-Mf
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 08:54:47 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6501d242e3fso1360705d50.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 05:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774875285; cv=none;
 d=google.com; s=arc-20240605;
 b=KbTUHdLrZ2SpTLXUEEOCrdb53TzmgmqstkFmqtF9Xee/mK/4e1vW3Edwb9KDobvuJF
 7/G/BLvzhqP7GbqL1XlNwJoG5yoxIa3JGzBZlRB8PsXD7MSL3Oa/Ql5H0rw3Gr7MnUtg
 A3hp2I+5xd66PGUmPeWLCyg1JxOdfo1TzFRO4j4fRb11nM0rVjRKMFZSE6DRYmJs289E
 59l0wooZJszcQXJaitnfpNhhEGbgt5it5mxBHjlLHwp8CNFbidBkP0XDKalWt4j+D4yq
 qIWUbJ29uXhLf3OiLidrl0vJIZakAieoEFCmIRQ0BLnFFXkLX5lVrJJUNfZp+uf9BZCM
 bWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=S1wCI8O0Q/dMkwH4iUBbg5E8nkpHphA7yLZ40n6XoeE=;
 fh=gffcMCOUXtBOrrjZQMiDLavK++hmBvO7zO0yh09tQqI=;
 b=OMEgiZQ/1ABvrm0LdGXm1ArvS28YBjX5vplb2Zpc+lVInyuPKqFtMMFIJSDx+bejKz
 bkWNbXTKwD4GR65jlIGnvIlnEeT6tUGQBKDF0s3udrva/ygbXbrEi615JYWtS9vRt3Y9
 q08B2n5ZgYhiZqlMiJfqQK48uIuKepIoJCfBmHs7cGgtdGOM36BDxBnW5+xmU0tDDcE4
 3s0izv57k1Wg5Htogl+dZnHpBjo6eJ+ULo+o8o1VnpTGznGPtkouUyj7XlZrX/FGgm7x
 RURUqhZ6IzWeVmdVdrcFFNeMC9TVnj2pppEwAHKS+cBFq4NB6aGBCwL9MYTTqSLvmPF2
 gs1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774875285; x=1775480085; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S1wCI8O0Q/dMkwH4iUBbg5E8nkpHphA7yLZ40n6XoeE=;
 b=GRLJg20+dz0GrbiQnekQRa/sVvRN9lv09wXF5TnmGTJUG5npEOuL77oLCoZUFh72G2
 4oHhKhGfwRCBIA0NaxFA5p/1iBCXrLpvrEKvB4amkIzukSJ2xyhUQHFiUF7d2fd9Ekar
 7mypV6Rii6Qz5oN/33up+hxqu+OQy/OqKbvrwQfTG5l1ybC4gaWL3mOp6zdGOpILUN78
 rJJAfPRPIfQOt2hy3OhNRjBDAOJ8rX31TbUEzeTeL78PaAqJirnPu5PEQ+5dIpV2dFxz
 gdxqgY26vzxSRI+tOcX6IVGYG/oGjA9TCvDAunXIs9RquPQQni5vYBdrqrOgnNLlb4gI
 /4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774875285; x=1775480085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1wCI8O0Q/dMkwH4iUBbg5E8nkpHphA7yLZ40n6XoeE=;
 b=PGvPfbtpF3iKqDl+2d5HI1BcXsohdtpkepDrbyH82bL4/8Tpy2eL3NZK+ZbcSDLYrT
 O78G6WaeorCt3HaRQfPulPq3W9KvO+DCic5oZF/TDsLcZz1AmV3Wi852gHuCIfT6VAZn
 QwQjmiHErr6600A5Kh6wUHpBnhpo+7haMMXKcBjErr0+5Hskmv3ltWAlyxOb1pcAF/WN
 Fld1MCKmgzAnfTxMWzPMnQnoKrI4Exg6hSTJkOiKcPW9jVfABRauptdxpzGZTv8hC4aa
 5TLm/1X0BXJRoaVVijSo6Bop2cFrYWBSVcNZPR2tauGldxMTDWoVg/WPe9yRQ8jSw01E
 jSqA==
X-Gm-Message-State: AOJu0YzH8ph6481ksjGZJ2vJORUiNWYLnn8te47gRHZOGHfgIPWrYXje
 3uyLAEyLX+T1S/5bmzJQrLF6cAgokfPT6q44IFX0H/98UA7H1Hjz4pnU/blb5y+G+KvDHI4Sdtv
 vertciYk7nPXTNhkV2p1j9giaGXhVTZEeJQwS4+RTGg==
X-Gm-Gg: ATEYQzzrz6C9QiON37uEvnEcOh80kl3FVnkVlWi3P5O/CA+DYR+iobegykXjLM9Fwi2
 h3TKoS8hdRML6S+MmrXF2HBWQxxAOSAm/Qn5p/VVh+zG1czWMJFKwMNQ2ixHmWtk5+XNZr+QtsD
 de8+qEtqHP51yN4eSAlygKU4lHOEaQm59DRB79hLsnIECy2E8Ot3dZrZ0oN18V9fmb3sdKaHrpC
 /zAs7GQPHGwTHT9wzp9gVY6TaCH7a2VhQJuw7OAgZTdiMPDbCcmNfoj1t1f4FnUDoRXKhUilM0c
 URr4DgoHEAClbbuZNDwUREP6wF6FdGbQUm2fo3MYORfYwf5WJaovH1mN8sFOaGTOfIo=
X-Received: by 2002:a05:690e:b4b:b0:650:1724:f63c with SMTP id
 956f58d0204a3-6501724fe4bmr4475886d50.20.1774875284698; Mon, 30 Mar 2026
 05:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260330102815.6759-1-thuth@redhat.com>
In-Reply-To: <20260330102815.6759-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2026 13:54:33 +0100
X-Gm-Features: AQROBzDCxjQSHSXj6tdV61BxIUA4tEyjbHMaIi6Pdof9M2-BtMNVj4M0Yyoanx4
Message-ID: <CAFEAcA8KHCd6QkHwXj8yeMczX7ei5=v11UAcXU_X5HdJ0HLM+g@mail.gmail.com>
Subject: Re: [PULL 0/7] Fixes for QEMU v11.0-rc2
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Mon, 30 Mar 2026 at 11:28, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit 770f50c14f098717fd40ae6e826a495681152447:
>
>   Merge tag 'pull-nvme-20260326' of https://gitlab.com/birkelund/qemu into staging (2026-03-26 10:26:39 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2026-03-30
>
> for you to fetch changes up to c0eaf14d93135e13d8b003f7cb41187e3510373d:
>
>   tests/functional/migration.py: Skip migration_with_exec() if socat is not available (2026-03-30 12:21:09 +0200)
>
> ----------------------------------------------------------------
> * Fix some warnings from pylint in the functional tests
> * Fix migration of the isa-cirrus-vga device
> * Remove obsolete linuxboot.bin prebuilt blob
> * Fix migration functional test to check for socat instead of ncat now



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

