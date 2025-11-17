Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9B9CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 01:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKoEh-0002Wf-Qb; Sun, 16 Nov 2025 20:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vKoEX-0002US-Eu
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 20:40:45 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vKoEV-0005wj-1f
 for qemu-devel@nongnu.org; Sun, 16 Nov 2025 20:40:44 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4ed82e82f0fso36225851cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 17:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763343641; x=1763948441; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uEEiFqFe8mk24F2K087eNTYDl+wsLQIIoRXEos/1iZU=;
 b=aURUlRWWhtAU47L/nXCfR2rs355H4zi8HcWVDrxiVFzUeOxCaS4Gb1NDknFI5fHP4K
 ePqIsRtLZ3iRxVXDde0qsLDER9XYSKZKGSh4zCYi+e8TMIGw/OqySBcPuQwCH9ycaWn+
 Xxxg59hqUmx+nulJvVAScI1Ato/O+fBi80p4Bc1EvP58PoVBdMzqTVpZbXW3TESiFZUt
 OE6zch+VL2+spR5GCsotfyx40+5CsBNi+fM8tQKENe+AUpS1k2OMxCc/EKNUKSjtZd5E
 jDAwjPS0izXAJMVqaQwDIS/0Nf16+VealzUFRfDX0DAtwwLnl/xJGjtHDIYEB6oCXJC0
 GlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763343641; x=1763948441;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uEEiFqFe8mk24F2K087eNTYDl+wsLQIIoRXEos/1iZU=;
 b=o09WE8WIh2o7QYrZiYHEr3ZN0Lazx511YiKEZdDT57a1spZD1lv4s/Kn41S4XJ7Bqc
 4IRcOAJJDnEWLZ+DX94VGOL9l2HTMiYOLTKsuzO0UlvMEOEdF6FLBMPX/YR4kcUiKEQ+
 F7FSE5kjA2bSpIz05W0c8C2q/ZNS7PQWkzW0p01WyGCPsy9IUDloWiQp/3qQsMQheyrP
 vbDsIDZI3qSVOcA0ckwAifFAZQ0LFlr28qginokxgerXwWqA6+snvzUJt3OvibVUmzKv
 mZAn0Pf/fG5rx3cyYl0CKIA4DQV9xclk0NyHYk1wUhr5onp6fetKdjt3VD2+Y3NzdVwH
 1q5g==
X-Gm-Message-State: AOJu0Yx3UgCZlofkXhyKD4RD3lgekRhu9fwfGhak1VggtIcL4oChkQ5+
 PmYhVHxDwAd36ptfSE/BLT8aS58VYPCMIlMYAY4DZBe5RrpFPNX+3f1F
X-Gm-Gg: ASbGnctSsUi4otYkuO2twvvAl3qEnJ4ny0Z+f+bfY31yVJBUHBlXcuFw3+VkUQwmpkB
 2BsXg7CO/3MDRHncbWcdYiwY9QPCkJnShDaELKZHPaWedygEInfKVWsZMPa7Tz3BwYbeQcfjXXx
 jVfPR7qOB4Ll6UIFR1uhG6d/GT5/iJ2M+WIkXK6wt/ecvx4tmzYOOBnD89m+9eGe9UD2mP829K9
 e5MZcK2YFWDik9zCgv86DEAbvvCv0NDhz8F/zi3d81+YSGy8FhQ/h2z7jQjOorzKRIHPT/rARdo
 QZxEjFXIwkndblyqkkjbz5Qmo+3WQG7RIwsminBBua+ZrqvREcDw198eHsamGfF2PxSxILjpbvw
 mpp+mYgdNHdh6g1t9rSsNn9T8JTwsXDpyvr20WE2RjL+YGOf4YCSyQ+kFKdAX1Bbw5aTN6VocwT
 TAQSVtXJUYa8DWoqmKxmc3ylVV6cboiQ==
X-Google-Smtp-Source: AGHT+IFYZMapw/AltwVkTGtpEoMfdCwAYd3kNUcv47oxXn7v6+HAXJF0VMIKs500QE2FTh7R8WZIRQ==
X-Received: by 2002:a05:622a:349:b0:4ed:6782:12c4 with SMTP id
 d75a77b69052e-4edf20a904fmr153834401cf.33.1763343641392; 
 Sun, 16 Nov 2025 17:40:41 -0800 (PST)
Received: from [10.0.0.22] ([185.213.193.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee1c21ea34sm18246551cf.30.2025.11.16.17.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 17:40:40 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Subject: [PATCH RFC v2 00/10] target/arm: add support for MTE4
Date: Sun, 16 Nov 2025 20:40:17 -0500
Message-Id: <20251116-feat-mte4-v2-0-9a7122b7fa76@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAF9GmkC/02MwQrCMBAFf6Xs2UgS29R6EgQ/wKv0EOKmXTCNJ
 CUoJf9uiBeP8+YxG0QMhBFOzQYBE0XySwG5a8DMepmQ0aMwSC47IfjALOqVuRVbpvqWa1UEHg9
 Q/q+Alt61dYfb9QJjGWeKqw+f2k+iql9KiL9UEoyzXqLtjJW9ssN5cpqee+MdjDnnL9aom8+nA
 AAA
X-Change-ID: 20251109-feat-mte4-6740a6202e83
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763343639; l=2808;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=yaMmec54r9aWfnLvH2zuBqAlw4r90lBdRpvP/BaAc2g=;
 b=H0P0b91vwmrKKuAyIEke6eZOsfigTlk0/X+GXpaFUsY9IWXc16fALsMCYOWftwptQUgDet4fE
 OZzzoqmgaw5D5xeDa0oiOdb9+gkIFbvhyBuoAHaHU6zG+UoZ11VLqg7
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This patch implements ARM's Enhanced Memory Tagging Extension (MTE4).
MTE4 guarantees the presence of several subfeatures:
FEAT_MTE_CANONICAL_TAGS, FEAT_MTE_TAGGED_FAR, FEAT_MTE_STORE_ONLY,
FEAT_MTE_NO_ADDRESS_TAGS, and FEAT_MTE_PERM, none of which are
currently implemented in QEMU.

According to the ARM ARM, the presence of any of these features (except
FEAT_MTE_PERM) implies the presence of all the others. For simplicity  
and ease of review, I plan to introduce them one at a time. This patch
handles all features except FEAT_MTE_PERM, with the plan to introduce
FEAT_MTE_PERM in the next iteration of the patch.

Testing:
  - To test this code, I used the tests included, plus modifications to
    enable the EL1 control bits for the features being tested. These
    features rely on EL1 control bits, which cannot be set in user-mode.
    Please advise on the preferred strategy for testing EL1-dependent
    behavior in user-mode tests.

The next version of this patch will include the MTE_PERM feature, since
MTE4 guarantees its existence.

Thanks,
Gabriel Brookman

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3116
---
Changes in v2:
- Added tests for STORE_ONLY.
- Refined commit messages.
- Added FEAT_MTE_CANONICAL_TAGS and FEAT_MTE_NO_ADDRESS_TAGS + tests.
- fixed TCSO bit macro names.
- Link to v1: https://lore.kernel.org/qemu-devel/20251111-feat-mte4-v1-0-72ef5cf276f9@gmail.com

---
Gabriel Brookman (10):
      target/arm: explicitly disable MTE4 for max
      tests/tcg: added test for MTE FAR
      target/arm: add TCSO bitmasks to SCTLR
      target/arm: add FEAT_MTE_STORE_ONLY logic
      tests/tcg: added test for MTE write-only
      target/arm: add canonical and no-address tag logic
      target/arm: ldg on canonical tag loads the tag
      target/arm: storing to canonical tags faults
      tests/tcg: added test for MTE canonical and NAT
      docs: added MTE4 features to docs

 docs/system/arm/emulation.rst     |  4 ++
 target/arm/cpu.h                  |  2 +
 target/arm/helper.c               |  4 +-
 target/arm/internals.h            | 40 +++++++++++++++++
 target/arm/tcg/cpu64.c            |  8 ++++
 target/arm/tcg/mte_helper.c       | 95 ++++++++++++++++++++++++++++++++++++++-
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/aarch64/mte-10.c        | 55 +++++++++++++++++++++++
 tests/tcg/aarch64/mte-11.c        | 46 +++++++++++++++++++
 tests/tcg/aarch64/mte-9.c         | 48 ++++++++++++++++++++
 10 files changed, 299 insertions(+), 5 deletions(-)
---
base-commit: 9febfa94b69b7146582c48a868bd2330ac45037f
change-id: 20251109-feat-mte4-6740a6202e83

Best regards,
-- 
Gabriel Brookman <brookmangabriel@gmail.com>


