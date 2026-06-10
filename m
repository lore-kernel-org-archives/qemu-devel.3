Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D47CD98C6
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXw-0008TR-Ur; Wed, 10 Jun 2026 12:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXX-0007ir-GG
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:27 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXV-0005Ve-0q
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45fd45e596cso3508154f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107943; x=1781712743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UMFz/wTxxI7oQFZcEHYclGTYYq23TFNxjCedezj/4kg=;
 b=oos2XZGFOe3VMtrm/DB9mPfZ3jZ5YgAmUowUYPKymj2MTkui1tWoK3XQmWOQawXQnU
 oYJsMHotoAopx7KZAOTBOyw1qgk6n2TH8/FlhP/Hv2OR3L2DV1bbWhTs4NlrCc3wVCxt
 SZMRwECTQFn4mHtnduorP/xC9gSI+cQb+A98w0ueZnSAdTS5xCbtuGIpemOed/JqPVpR
 bwGw3aX769VkY9zWiLDbOtxx/8OFRlb0tml9BD/dhFJ6Fc+ApurF7to1zef+9UDVmVaa
 TZBQQc6x1N9lGpPdpyUFzbMScTTYHggDh7NDgA0BsxiU4lkju5joJuKxg+pyHgW3/nvF
 B1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107943; x=1781712743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UMFz/wTxxI7oQFZcEHYclGTYYq23TFNxjCedezj/4kg=;
 b=HWSm9FHUuTW385OrWdL8DQT7NVCaKQQNzHj3C2dMk7khI6j+IRw8MXyrc3zhLNGT58
 UiZv+VzK+XunrbFS0Uft2B7GzcRyGzOSceMhNl9ZOG87ttquDNIwX3yU2LZvN4sw2ORW
 K4CgnysU8KszGAhSuMzvMVUv5diFvVtzw8+oZqlBL31yBKoPDBM3VSyAATNpE2LSdTgq
 wizdQx3DsMnplR5BHnulWGugCz7IgcLDzPW+bhDe92Cr6caulpz7B6PDoeYNkMOL1EVb
 lCSsLcd+JTkUD9+hj4yhfbQUVtmT3NtnR5EaszEjqgflCskYZXzk26MGF3tGHd5goBSk
 gzEQ==
X-Gm-Message-State: AOJu0YwaZxUcPySYN9qPgZ8LRC0Oc2fDrd0rZXrmGsbfS8tHfohTzI8a
 RT6AtGMpOV/Gq3gt7wMQDYwDU2JFeaDcrG6SB9t7hvMsM1WFxRw6PBpKkbjo/xXB8IzRBZ97Z69
 iTELR
X-Gm-Gg: Acq92OHK5GPsgK1H3hbzC0kQ+btcgAxR3nWFeK0qEO1bIuz3gJkEgaczf4g8nEmUiNA
 m0VfcJN3RJTkmziPBEyw+V1czkDp4C584QOCoHaNwCZK0a8+fQaNfo77U+zI1FdK5q6zGokef42
 JMkFJ+oCCq1gJzbr+n3RoFVchvWmFaBcjqM3ZBuCZxPL1Fa1CPeC6OcynTChuSWzseSbiCR9H8f
 eJ6D8yhtzmIM2Mj8FtaFn/8gHRsBSOUsy0vvEHY5mQzcwWaUjd8W11Alrir1c2+mCnRsk2Esrfj
 ZfngL93Km6gkPv3B4TfJIlbMV1D5CehDNZplSA9SS9c6ZYaRIKiAauzzBhQViUSc7WBVc5KRFGq
 C5kA4rav8eadxoo8XSwcNY4zrXgWim0cqNofR+PLhQ6ouRI2xQSPiYhOmP8boKOZJ+9q1RW/HmP
 vn13ODUmt5TMwh8uuMCt/3SrL72t9uEA2JyIksHwFq7aQEuWc751nffZHgj1TSbFGG0L4c8MadO
 sZ1jWW+quZPeqLEMv/sbcrFfByCoacdqnRJuPhO56g=
X-Received: by 2002:a05:6000:4a09:b0:45e:779a:302c with SMTP id
 ffacd0b85a97d-460566c94ddmr9731723f8f.29.1781107943500; 
 Wed, 10 Jun 2026 09:12:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/71] docs: add MTE4 features to docs
Date: Wed, 10 Jun 2026 17:11:05 +0100
Message-ID: <20260610161202.2235298-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Gabriel Brookman <brookmangabriel@gmail.com>

The implemented MTE4 features are now present in
docs/system/arm/emulation.rst

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260529-feat-mte4-v7-13-ccbd3c14eb3c@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 5 +++++
 target/arm/tcg/cpu64.c        | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 18c6355967..df82b7f44b 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -114,6 +114,11 @@ the following architecture extensions:
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
 - FEAT_MTE_ASYM_FAULT (Memory tagging asymmetric faults)
 - FEAT_MTE_ASYNC (Asynchronous reporting of Tag Check Fault)
+- FEAT_MTE_CANONICAL_TAGS (Canonical tag checking)
+- FEAT_MTE_NO_ADDRESS_TAGS (Address tagging disabled)
+- FEAT_MTE_PERM (NoTagAccess memory attribute)
+- FEAT_MTE_STORE_ONLY (Store-only tag checking)
+- FEAT_MTE_TAGGED_FAR (Full address reporting of Tag Check Fault)
 - FEAT_NMI (Non-maskable Interrupt)
 - FEAT_NV (Nested Virtualization)
 - FEAT_NV2 (Enhanced nested virtualization support)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 1a4f50486d..c7b1dd2e90 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1296,10 +1296,15 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR1, CSV2_FRAC, 0); /* FEAT_CSV2_3 */
     t = FIELD_DP64(t, ID_AA64PFR1, NMI, 1);       /* FEAT_NMI */
     t = FIELD_DP64(t, ID_AA64PFR1, GCS, 1);       /* FEAT_GCS */
+    /* FEAT_MTE_NO_ADDRESS_TAGS + FEAT_MTE_CANONICAL_TAGS */
+    t = FIELD_DP64(t, ID_AA64PFR1, MTEX, 1);
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64PFR2);
     t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* FEAT_FPMR */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEFAR, 1);    /* FEAT_MTE_TAGGED_FAR */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTESTOREONLY, 1);   /* FEAT_MTE_STORE_ONLY */
+    t = FIELD_DP64(t, ID_AA64PFR2, MTEPERM, 1);    /* FEAT_MTE_PERM */
     SET_IDREG(isar, ID_AA64PFR2, t);
 
     t = GET_IDREG(isar, ID_AA64MMFR0);
-- 
2.43.0


