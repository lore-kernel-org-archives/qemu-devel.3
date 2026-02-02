Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B3DE73172
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 13:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmu40-0006jc-QV; Mon, 02 Feb 2026 08:34:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu3y-0006ia-IG
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:33:58 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vmu3w-0002Yx-VE
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 08:33:58 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so49467315e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770039235; x=1770644035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0rsLQHfkt+GPdAT7yQgKfwI2KEz04duTHQNYObD6NnE=;
 b=DINPjNmLlxeIlQBR5y2pVAu0GNjiopeMBe7Qftg1LklkupEty+ZEZIF2d8VIzhHDz6
 4B1UKfxN+uihqBEG8mTDMd3/3SjY6E9nkIOSl2K1zNJ89bK838UJmpB08DtD5PODOVKh
 Z0j2UDDlw4YPcmNqa1jUlHXV7t6aFTI4nNKr2EEkcoZ3bXjL7XYGjKhJ/vULmFW6Bxy0
 SgevAyGUQc0vZ8yzzkdbBaud3dEMq/ndYEXHfl5/X/NCzBLdEU6BYc4N3vay1nsrp+Py
 PtDDjpwW/UZkcRJhbdqAl7TwiRo+Rj7zRF/Dv01re9GT4/x5AO/y4YgI7Z8zqS/H3G7h
 zuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770039235; x=1770644035;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0rsLQHfkt+GPdAT7yQgKfwI2KEz04duTHQNYObD6NnE=;
 b=vnfbvfh0A7TxQx+ApVcSmsB59tFsh5uulqEXdC48AEKAJPR6CsLfpR+BcmEuyFa/Zl
 IDvINQwstWi2NpATDRDdA2k+VNuBrP68eaNYhoM9QafvLiOd9BnAGC5Jrndj4H0H4I5C
 wAwg+dFy+UTzWBipsk7N50Cc2p1d2XRULc1suUQ74p9DbaIs2u8srTAfEeQVFR4oHZsN
 BEnaUygXzkWSvx9ErLHJTfdbwbtM5C6NDhGLoT68H7J+amiGwrIBVmPkXdfB8HGBt5EO
 XqgDf1rVa8f9/YXu8aXxXmC8P4tCi2h7KBtc/aCjBWyRRvnlz9+v49fFoBIERRVO/04f
 wiWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXch2Jzz3frvV7WZFGXF1zeT3+1yfumIdX+5h1rp0wHmx+A18PaayOUVAOx04MQtrK9BRMWM7JCieDp@nongnu.org
X-Gm-Message-State: AOJu0YztBSKR5QlPYKIgfQ9mT4oz3G4+tjat61yj6JKMfsASVykprj2r
 K0PS75z8Ce28SZG5bbqH0lyPSvw1a3ZlivS8SIhH+Ux3jHGUuGbs3iGHDMNEJ4ay6KjTYzmK9+i
 ++T3X
X-Gm-Gg: AZuq6aJ1T/9nxSWVBoTqMMwBUr+hnTZjy9v7d/xF0cPoFZBdV+Y3H2uO40j4InKCs5x
 pKz1MoFhluoRwHKk1de1rNLt7g6sV5GG7z1Pp9YURegW1YG+LLiy53DkkNywVYBYRj+Fz35PZ8D
 CrjWLPM1SbV7amw6czCkuSA3jALU49oNgRKh0zq6gtAV4KCDh+hkn+cToXkXOcYy22/TEzYFDrT
 nIxmM19fP0naRucTfP36bRKBD2U2flzmITMJkfXsEZ/8St96AW+wCCBgDpkPYiQjMp4eADBR5d9
 TPsWJz/+AYMwTCebr7nMoiY19nuxqMA4Zc2Tx/KyhUuTpUi57WQcfCLNRrzczcGHvm+3yKvRiiI
 8znIF7g8I2KLvcq/GjVAb5QUYOc9BPLrj1htTEnpkK6Cc9/uTDqH0H0IlPkmDrMnxnclM4mCVWg
 y8UVR9jTZqkMEF7G+Nrtowc8SZ1TlHj0dMpDHUydeZ
X-Received: by 2002:a05:600c:608e:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-482db45fcc0mr146590005e9.10.1770039235208; 
 Mon, 02 Feb 2026 05:33:55 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm478054495e9.14.2026.02.02.05.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 05:33:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 00/15] target/arm: Allow SME-only TCG CPUs
Date: Mon,  2 Feb 2026 13:33:38 +0000
Message-ID: <20260202133353.2231685-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

These patches add support to TCG for a CPU with SME but not SVE.  We
originally prevented users from doing that in the run-up to a
release, in commit f7767ca30179 ("target/arm: Disable SME if SVE is
disabled") by forcing SME to off if SVE wasn't implemented.  This was
a simple way to avoid users hitting an assertion failure.

Doing something more than "basically no testing" led me to
realize that we needed also to fix a lot of places in
translate-sve.c that currently check the aa64_sve CPU feature
but which ought to be checking for "SVE || SME". I also spotted
a few more issues in the process of doing that work, some of
which are only relevant on an SME-only CPU and some of which
are bugs that show up even with an SVE+SME CPU. Those fixes are
at the front of the series and cc: to stable.

Changes since v2:
 * new patch 3 fixing a bug where we were checking arm_sve but
   should have been checking arm_sve2
 * new patch 4 fixing a bug where we forgot to allow RAX1 in
   streaming mode for SME2p1 and above
 * new patch 5 fixing a bug where "sme=on" accidentally downgrades an
   SME2 CPU to SME1
 * new patches 8 - 12 which correct various feature checks
   in translate-sve.c Patch 9 is big but somewhat mechanical
   (and IMHO best reviewed by checking the post-patch source file)
 * new patch 13 which corrects the existing "clear AA64ZFR0 if
   CPU doesn't have SVE" to only clear the SVE-specific fields;
   we clear the whole register only when we have neither SVE
   nor SME

Patches 1, 2, 6, 7, 14, 15 have been reviewed; patches 3, 4, 5, 8 - 13
need review.

thanks
-- PMM

Peter Maydell (15):
  target/arm: Account for SME in aarch64_sve_narrow_vq() assertion
  target/arm: Report correct vector width in gdbstub when SME present
  target/arm: Fix feature check in DO_SVE2_RRX, DO_SVE2_RRX_TB
  target/arm/tcg: Allow SVE RAX1 in SME2p1 streaming mode
  target/arm: Don't let 'sme=on' downgrade SME
  target/arm: Handle SME-only CPUs in sve_vqm1_for_el_sm()
  target/arm: Handle SME-without-SVE on change of EL
  target/arm: Add aa64_sme_or_sve, aa64_sme_or_sve2 features
  target/arm/tcg: Drop unnecessary aa64_sve check from do_trans_pmull()
  target/arm/tcg: Use "or SME" feature checks where needed
  target/arm/tcg: Correct SVE/SME I8MM checks
  target/arm/tcg: Correct SVE/SME BF16 checks
  target/arm: Don't squash all ID_AA64ZFR0_EL1 fields for non-SVE
  target/arm: Squash FEAT_SME_FA64 if FEAT_SVE is not present
  target/arm: Permit configurations with SME but not SVE

 docs/system/arm/cpu-features.rst |  20 +-
 target/arm/cpu-features.h        |  27 +-
 target/arm/cpu.c                 |  10 -
 target/arm/cpu64.c               |  36 +-
 target/arm/gdbstub64.c           |  12 +-
 target/arm/helper.c              |  14 +-
 target/arm/internals.h           |   9 +
 target/arm/tcg/translate-sve.c   | 891 ++++++++++++++++---------------
 8 files changed, 551 insertions(+), 468 deletions(-)

-- 
2.43.0


