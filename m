Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A88DCCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 00:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIz52-0004NP-2d; Tue, 11 Nov 2025 19:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vIz50-0004Jf-1v
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:51:22 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brookmangabriel@gmail.com>)
 id 1vIz4y-0005nu-5D
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 19:51:21 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-882399d60baso2775366d6.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 16:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762908678; x=1763513478; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ARNbVFBkKf8NAUvEUK+ZcTKvc61KFuP7xijw4qB45gs=;
 b=VS6sIIgOi4ouUffqBWcg/twzzuzH34CchH1jlPi9E0FwRssBwHYEUzlmncU+Gde97q
 M+H/4vwqOdbajo7DaBUY7ywdh4Eo6PbmCtCq1s841lyIgXYbG1+UskLOiaSQrbW+qp8+
 ezhEEk+m39OrCHVhkL8fVDTTRd565sL5PmN7bWf7PZyNp2sXa+tTTtBt0XhhCXmVOYDi
 zIBh8Tx2WsX8S6ndQSdm6uzG9BMvbnW4nYyXRsnET9PU2YYSCaI7hPEjIG/k99r5g19m
 OSgY87+2bCiR8icBtQgji67yH37WtHpxG52BtxxTJ84H8tHf2TYaENe9vfuZ8WeliiTK
 YUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762908678; x=1763513478;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARNbVFBkKf8NAUvEUK+ZcTKvc61KFuP7xijw4qB45gs=;
 b=Uv4xrb2YRmzY++XxjfqkvogyrAyA/NANbxVgBZpHI+jbtIzUoRfTvE3IqlBkNHysEO
 uyn+HD+TA4/csJsKG6DDny97O0MCnoUsFBfcS4MnpA6K3g/373I+9anGyHI5mBbmeCTS
 OdRnfrClWoCzsBU9T71fuChI6cIWKTw/hR4mMuA8JbBVmqbNBTqFCDqhMk7/t1KXrxZv
 WPFmWcTqEUMrTlSllyiHh0HVLSTRNgPBffnDL1w4gygnrpeaJWHRwbjvx8nCrHOfmm79
 ft3TaZblnA6jSDmudM+Hb6AvmFtvMJpVAplaeoTYeRuyCIT51h62d0BuZH0DlDoIQ9bK
 EQLA==
X-Gm-Message-State: AOJu0Yx0Yvn36OTG4YAni3+2kApnTCoPOzgicnq8jAgjE4cl3JELYoY1
 6jYogn6/NxgqW89yY9lDiBIMeYx7jRkPbp+lSNPtrWqppp3EHY8Ek7yt
X-Gm-Gg: ASbGnctf7QFH5AQX0nQ15GK55HJC8goO/0vdhFH5EaZiky/QziS7WaUv+3VMNYUKA7y
 uflFGrOpdusdmcnHLSg1EpqY0fAHzoBP0w0G2/h/DJR1M9InHTTVKRAniQHqxIWbNutDTrv4Zcg
 /673Jv5I4GkQhaDjt5I6lZjw/fPeWiiWSMxPYiAEtcXm/BlaY1aQLjBuLr2ZZRUXaTUjHcjlW2J
 GKdfMT0c+f7EwFQjjhHbDEi3khTWA8L2xSK8QhxXHgoKjYJzeTL+JzJC6yEbvcSHzsTOz3HlIlr
 +KVoC++RhVekOfp4NXPZtdmdpSC5YTU6IOAOfAFffADTNnYSSbb06sP+x33wJt6Ob0XW074qeR/
 j3CdXqr+70HWHFTJajWrdR3qTC2Xv5dpspIkf3CjuqCQghKCDLmtXLumXlRNuv+1SlL8c9xUrHy
 eINZ9Qinh3
X-Google-Smtp-Source: AGHT+IGcSKh5ExZwbTVKB0AQ+5h34epIOos/E7g1fYp2q2E0lkMlfKgrhIgvITFeh+39LuN/SsTlEw==
X-Received: by 2002:ad4:4eed:0:b0:880:4695:464a with SMTP id
 6a1803df08f44-88271988a2amr17786946d6.24.1762908678176; 
 Tue, 11 Nov 2025 16:51:18 -0800 (PST)
Received: from [10.0.0.22] ([185.213.193.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8823892a79fsm81445096d6.4.2025.11.11.16.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 16:51:17 -0800 (PST)
From: Gabriel Brookman <brookmangabriel@gmail.com>
Subject: [PATCH RFC 0/5] target/arm: add support for MTE4
Date: Tue, 11 Nov 2025 19:50:49 -0500
Message-Id: <20251111-feat-mte4-v1-0-72ef5cf276f9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOnZE2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwNL3bTUxBLd3JJUE10zcxODRDOgRKqFsRJQfUFRalpmBdisaKUgN2e
 l2NpaAEohnWNgAAAA
X-Change-ID: 20251109-feat-mte4-6740a6202e83
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org, 
 Gabriel Brookman <brookmangabriel@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762908676; l=3528;
 i=brookmangabriel@gmail.com; s=20251009; h=from:subject:message-id;
 bh=WoMWB8mSoYwa7AUlOW915FMNbnAzZg2S1yjfQbbqmqE=;
 b=6HL1qfjazhRSydxttzAH4SElrWpJwDA20aKM6AIUMHWGfotr2YMNkXGQu/vGKosilbM0yOcUA
 1TCpMBhDLZ0AQWLt+odFEMPOwH2RkScy08DVgNFzwN2i7bANIv4CG1w
X-Developer-Key: i=brookmangabriel@gmail.com; a=ed25519;
 pk=m9TtPDal6WzoHNnQiHHKf8dTrv3DUCPUUTujuo8vNrw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=brookmangabriel@gmail.com; helo=mail-qv1-xf2d.google.com
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

This patch, when complete, will implement ARM's Enhanced Memory
Tagging Extension (MTE4). MTE4 guarantees the presence of several
subfeatures: FEAT_MTE_CANONICAL_TAGS, FEAT_MTE_TAGGED_FAR,
FEAT_MTE_STORE_ONLY, FEAT_MTE_NO_ADDRESS_TAGS, and FEAT_MTE_PERM,
none of which are currently implemented in QEMU.

According to the ARM ARM, the presence of any of these features (except
FEAT_MTE_PERM) implies the presence of all the others. For simplicity  
and ease of review, I plan to introduce them one at a time. This patch
handles FEAT_MTE_TAGGED_FAR and FEAT_MTE_STORE_ONLY, with the plan to
introduce FEAT_MTE_CANONICAL_TAGS, FEAT_MTE_NO_ADDRESS_TAGS, and
FEAT_MTE_PERM in later versions of the patch, although I'm submitting
in pieces for ease of review.

FEAT_MTE_TAGGED_FAR guarantees that the full fault address (including
tag bits) is reported after a SEGV_MTESERR, and exposes itself in the
ID_AA64PFR2_EL1 register. QEMU already reports the full address in this
case, so this change only advertises the feature by setting the
appropriate field in ID_AA64PFR2_EL1. My previous version also unset
the feature when MTE was disabled, but looking at the way that similar
features (e.g. MTE_ASYNC) are not unset in this case, I changed my
design to be consistent with them.

FEAT_MTE_STORE_ONLY, when enabled, skips tag checks for memory reads (it
keeps them for writes). I implemented this by creating a helper that
reads the appropriate control registers to determine whether or not this
feature is enabled, and introduced a conditional at the start of
mte_check that skips the check if it's a read and if the feature is
enabled. The conditional only hinges on the contents of the control
register for this feature, not whether or not the feature is actually
implemented on the chosen cpu. I would appreciate feedback about whether
or not I should explicitly check for cpu implementation of this feature.

Testing:
- For FEAT_MTE_TAGGED_FAR, I wrote a test for this functionality that is
  now included as mte-9.c, as per Gustavo's suggestion.
- For FEAT_MTE_STORE_ONLY, I wrote a test for this functionality, but
  since the feature requires setting a SCTLR_EL1 bit to be enabled, I
  was only able to pass this test successfully after I manually set the
  bit in question. It's not clear to me how I should go about submitting
  this test, since I don't see a way to set this SCTLR_EL1 bit from
  within a user-mode test. Some guidance here would be useful.

Follow-up patches will implement the remaining MTE4 subfeatures listed
above.

Thanks,
Gabriel Brookman

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
---
Gabriel Brookman (5):
      target/arm: explicitly disable MTE4 for max
      tests/tcg: added test for MTE FAR
      target/arm: add TCSO bitmasks to SCTLR
      target/arm: add FEAT_MTE_STORE_ONLY logic
      docs: added MTE4 features to docs

 docs/system/arm/emulation.rst     |  2 ++
 target/arm/cpu.h                  |  2 ++
 target/arm/helper.c               |  4 ++--
 target/arm/tcg/cpu64.c            |  8 +++++++
 target/arm/tcg/mte_helper.c       | 22 ++++++++++++++++++
 tests/tcg/aarch64/Makefile.target |  2 +-
 tests/tcg/aarch64/mte-9.c         | 48 +++++++++++++++++++++++++++++++++++++++
 7 files changed, 85 insertions(+), 3 deletions(-)
---
base-commit: 593aee5df98b4a862ff8841a57ea3dbf22131a5f
change-id: 20251109-feat-mte4-6740a6202e83

Best regards,
-- 
Gabriel Brookman <brookmangabriel@gmail.com>


