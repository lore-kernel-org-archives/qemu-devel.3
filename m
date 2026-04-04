Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA2AE88D77
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 01:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8ph9-0001UY-Ti; Fri, 03 Apr 2026 21:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1w8ph6-0001SY-5Z
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 21:21:00 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1w8ph3-0007Ak-Ej
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 21:20:59 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-82cf83bf375so955772b3a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 18:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775265655; cv=none;
 d=google.com; s=arc-20240605;
 b=YZEDa5OKCe2Qif4SHj3tRspHkYb6JNTAAppTrs0JmVYZKkIUvd9ECMlNp1WaeFrS7Z
 TZiXTDFKJiL9Y4w0IzcuCSNumaI59L/c7tHBautQchtIGlOIi7Hft6lnkJd+akiwduc/
 EhhOql7vfivYMJ9lXlQ09kPdTGaKOJ/ZUT1IvVOJ7QJCCY7211k1axG4OWo/p/3i9UHf
 AQmOKnO8T+5zQgFi6KMM2gzzegQ4/3u+JT/xyTO/qPuKx1V+Wblbmqif8Vjrt6XaBnZd
 7OlntBkOvovLp77YyGxYklScyIfKCixnL9ZsahdbqMz2hMSWyEeCv2kNO3AaQMh1fwf6
 ORig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TU56CpD/bUIsLCO+ssIVA0ELn2ozWGbl9JCsr/6X3UU=;
 fh=2TDBjVMD+El9erPlJq4BlPCiiYd67h1A2X29+rqbJSI=;
 b=dDPHPdFL8toQ3y8weYOww1XIiufjb2fiaZVNtmVCIeGsTNVeWSjYIa6ouKFaVRc6f1
 wo7SAFNuDxYwzSNiVxAS7Tm53gzdHvLu+/QuqHBlmgRWreOLoYg82314p9edsDgo1BnR
 vvIo8U7fBrwzSBgZkk83W8F1pAmE7cI1qHXAzgiJ+jR39K5F2+vxk4frILhgY9LLmyRs
 9LN18tpgOsRdIHGZ1ylkJ8RVSVu+lIofOrIgqSYoJL3Nl8v/X9dd4TI6VIQUvWHcU6H8
 phTrhr/8+WCSxTqCkNxL//XZ2lAZiApFsBisMwU8eeU1n/FVeYW0R7UzZwa/e7PLxWRi
 KT/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775265655; x=1775870455; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TU56CpD/bUIsLCO+ssIVA0ELn2ozWGbl9JCsr/6X3UU=;
 b=LxFb4oMEy2R1I+JRYGFl9ZJiQu742qi+7ktNKUg6+qVABRAujZ/v2TOwn8uz/nf1Qm
 m+0uLPyx4uPknWDbTzJHXuiZaPu8h0yNh/XPGwDmjFdZfO2sGi5m7tyYHF9yO1Dc9HZL
 GjXCyJsLLYwKt4qkJzwx1GYE55Ma54Sndtrec9w/SKz22M3s7Dglq6UAu9TYrB7zeqLw
 qAKJ86eqlJ3B7wJcC8+Y/bqBD75KWBpve13Ny5QxssWNgKNeMfVps65jUdEpOHBDYJI/
 DGksiFi/OtxHUtHkgwrJTyde+uiAJ4YrAqGJM8dwy4wVaC46YDe0mMw7ueQ6THxiLWsY
 C4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775265655; x=1775870455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TU56CpD/bUIsLCO+ssIVA0ELn2ozWGbl9JCsr/6X3UU=;
 b=VoHvVeb0F3Oa//+Bs4MMjiSsVmMb3H14DztOKOu7RTPi9Ku7iejWiOgIhm1aaKZ8/A
 6nhIehEgizON7UvS3UHUakVkw7MvgUvl53iWQGEsfuQFzsVdJX8NPxLn562jntenx+CC
 bEmUfsQqsIn+woT16DMeFDPXfcJaAAbjCP+rJyAsl2IR2PF2xLHZ5k/VfOAa+YqmpUj5
 qU+GdFiUyMRZ9a1+KiobL7SsL5h1S9u7/dCPN2FXHq8qAykErixKtsYdflHKYLXmp0WV
 MfECd2n6s6PTxkbxyRn3e/JQX6sb8b404Kdh1wPJMPcr//3pZeO3nRLNQNSPRIkEbPcw
 Hujw==
X-Gm-Message-State: AOJu0Yx7W0cfSfkg2SeX5zF3rD0OKY4dSEPSO4pGxFTXpWOfwq6Okooo
 s42BnYjMZRBY65lXAD0WdzXjp2hSpJ/cuDSAM3tZPKF+QhbTOv+KiPxjSQ+MXM/rA00RVAKdxaf
 pVFtTj1RlfPN7zW459wzpIhERrcZJXbCTMHYO
X-Gm-Gg: AeBDietxCqiHWvXQT+4j9Pkgumnk7MXnuNBFkYYSZiiHvrjbfA6NFZXV5rYDzNnKyiQ
 fad4ivnslC/p20TN4ngP6ioJ0E4PV3mGquJansNdy/8opbhGaL/pf0dLv1sS8y2Sz4vmoPyNEV+
 iNG0UB9E6m4ZilhBSrjph4cWeXvwDbf8LkiAUXx/pN8Z53y8XcnSZ1YejuNyg59EbQuC1mSnwf3
 4XAyvXCsv1mMqed3M/sTSSm2eNv2PU8GeKWZ2DR+yQEAVMsrhW40f/bpJgVYD5e1dTenVfb3OAP
 ndNfk7yfzw==
X-Received: by 2002:a05:6a20:430b:b0:398:6ea8:21d2 with SMTP id
 adf61e73a8af0-39f2ed8d9e7mr4910109637.19.1775265655184; Fri, 03 Apr 2026
 18:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
In-Reply-To: <20260309-feat-mte4-v4-0-daaf0375620d@gmail.com>
From: Gabriel Brookman <brookmangabriel@gmail.com>
Date: Fri, 3 Apr 2026 21:20:43 -0400
X-Gm-Features: AQROBzCWaxYDWGWKJcXyLohHjWQjQ5Qxfu1DJW8a_H6bSkQOgxsYW082IQjCIDw
Message-ID: <CA+1f7BD11AnJgPqMPyxHYx+y6egw33mCz4R0Hqft51mNWCvPVQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] target/arm: add support for MTE4
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=brookmangabriel@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Ping.

https://lore.kernel.org/qemu-devel/20260309-feat-mte4-v4-0-daaf0375620d@gma=
il.com/

On Mon, Mar 9, 2026 at 6:00=E2=80=AFPM Gabriel Brookman
<brookmangabriel@gmail.com> wrote:
>
> This series implements ARM's Enhanced Memory Tagging Extension
> (MTE4). MTE4 implies the presence of several subfeatures:
> FEAT_MTE_CANONICAL_TAGS, FEAT_MTE_TAGGED_FAR, FEAT_MTE_STORE_ONLY,
> FEAT_MTE_NO_ADDRESS_TAGS, and FEAT_MTE_PERM, none of which are
> currently implemented in QEMU. This patch implements all five.
>
> Testing:
>   - Included for FAR and STORE_ONLY.
>   - The MTE_CANONICAL/NAT test from the previous email, modified so
>     MTE_CANONICAL is enabled in user mode.
>   - A bare-metal testsuite that sets up page tables for S1 and S2
>     translation, to test the Tagged NoTagAccess fault.
>   - The bare-metal testsuite also was used to test LDGM and similar
>     instructions not permitted in user-mode.
>   - The bare-metal testsuite also was used to test the mtx related
>     patches.
>
> Thanks,
> Gabriel Brookman
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3116
> Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
> ---
> Changes in v4:
> - MTX now interacts with PAuth.
> - Canonical tag checking only takes place in canonically tagged regions
> - MTX bits enable tag checking
> - MTX bits are placed in MTEDESC for access in mte_check helper
> - Separate feature bits are used to delineate each feature
> - PRCTL functions renamed and refactored as per Richard's suggestion
> - Link to v3: https://lore.kernel.org/qemu-devel/20260105-feat-mte4-v3-0-=
86a0d99ef2e4@gmail.com
>
> Changes in v3:
> - Added prctl for MTE_STORE_ONLY to linux-user
> - mte_check is no longer generated on read when STORE_ONLY enabled
> - Implemented LDGM instruction
> - Removed "long" datatype as per Richard's suggestion
> - Implemented masking for VA range checks when MTX bit enabled
> - Implemented MTE_PERM, with NoTagAccess attribute
> - Removed user-mode test for MTE_CANONICAL, since can't enable in
>   user-mode.
> - Removed TBI from mte_check generation logic
> - Link to v2: https://lore.kernel.org/qemu-devel/20251116-feat-mte4-v2-0-=
9a7122b7fa76@gmail.com
>
> Changes in v2:
> - Added tests for STORE_ONLY.
> - Refined commit messages.
> - Added FEAT_MTE_CANONICAL_TAGS and FEAT_MTE_NO_ADDRESS_TAGS + tests.
> - fixed TCSO bit macro names.
> - Link to v1: https://lore.kernel.org/qemu-devel/20251111-feat-mte4-v1-0-=
72ef5cf276f9@gmail.com
>
> ---
> Gabriel Brookman (13):
>       target/arm: implement MTE_PERM
>       target/arm: add TCSO bitmasks to SCTLR
>       target/arm: mte_check unemitted on STORE_ONLY load
>       linux-user: add MTE_STORE_ONLY to prctl
>       target/arm: tag check emitted when MTX and not TBI
>       target/arm: add canonical tag check logic
>       target/arm: ldg on canonical tag loads the tag
>       target/arm: storing to canonical tag faults
>       target/arm: with MTX, no tag bit bounds check
>       target/arm: with MTX, tag is not a part of PAuth
>       docs: add MTE4 features to docs
>       tests/tcg: add test for MTE FAR
>       tests/tcg: add test for MTE_STORE_ONLY
>
>  docs/system/arm/emulation.rst        |   5 ++
>  linux-user/aarch64/mte_user_helper.c |  11 ++-
>  linux-user/aarch64/mte_user_helper.h |  14 +--
>  linux-user/aarch64/target_prctl.h    |   6 +-
>  target/arm/cpu-features.h            |  15 ++++
>  target/arm/cpu.h                     |   5 ++
>  target/arm/gdbstub64.c               |   2 +-
>  target/arm/helper.c                  |  36 ++++++--
>  target/arm/internals.h               |  47 +++++++++-
>  target/arm/ptw.c                     |  53 +++++++++--
>  target/arm/tcg/cpu64.c               |   8 ++
>  target/arm/tcg/helper-a64.c          |   9 +-
>  target/arm/tcg/hflags.c              |  25 +++++-
>  target/arm/tcg/mte_helper.c          | 164 +++++++++++++++++++++++++++++=
+++++-
>  target/arm/tcg/pauth_helper.c        |  14 ++-
>  target/arm/tcg/translate-a64.c       |  15 +++-
>  target/arm/tcg/translate.h           |   3 +
>  tests/tcg/aarch64/Makefile.target    |   2 +-
>  tests/tcg/aarch64/mte-10.c           |  49 +++++++++++
>  tests/tcg/aarch64/mte-9.c            |  48 ++++++++++
>  tests/tcg/aarch64/mte.h              |   7 +-
>  21 files changed, 497 insertions(+), 41 deletions(-)
> ---
> base-commit: de61484ec39f418e5c0d4603017695f9ffb8fe24
> change-id: 20251109-feat-mte4-6740a6202e83
>
> Best regards,
> --
> Gabriel Brookman <brookmangabriel@gmail.com>
>

