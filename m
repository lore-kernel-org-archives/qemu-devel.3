Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72372CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CrU-0001fT-G3; Fri, 10 Oct 2025 09:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cqz-0008DB-Jn
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:14 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpm-000451-3L
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:11 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso2102466f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101613; x=1760706413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iY66G+dXvVwT2/23NgUCSTZGeIdhb8BRsuHUZ+x/2Yg=;
 b=r2z2PCQaoql4zIlvV7+OyWTkisBwEvShonDpE22jJo1bw5x1iR8sT65MQn9kPN39Vb
 5SHQT0dMQrL9MCCn6fiG7gRyCPerH02GOD5cOaRsqi0hLUfSAseHhWSp9COH5es/B/2V
 CvG6jU7U3h0nbWXYXd86Bfx57JCHCC2TpCgljBzzTHOwJdiS8OTl7R587W/0XLb61T9J
 l2xKkTddG7dOa5wdQjAMQ8ovSDNYJqQTHpA4m9LRwwASQcdwYvf/hfFZFRUh+MjNFFQn
 HrMgNigBhvsDD8otPdHrTWfPMkd2wIbw3H3AbwS8eUqYE7Uk5XSmmNSFnvPRgMMVYKn5
 i5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101613; x=1760706413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iY66G+dXvVwT2/23NgUCSTZGeIdhb8BRsuHUZ+x/2Yg=;
 b=Nkg5pRqHNKPE4hubTVBj0xrdt3a3LYbL6c3crsfY3HwobjP/kbWpovlikGFSwV6K4D
 GNc7pAmYRXOKsZyWXmFubuh/bEoE3N4zSgVHnG1S/vy9NIeXDoPmQyZBUHmBOFX1pXu4
 oQFTypz0eLAv8uGhNkjgimjkwy3wZtTY/Vkj/fD7Y2EoSB/91sJSrvuzodNsE0rDYumA
 vjq15FgwsggFWOVAeum5Jyxf0h9BsePv5QFNA48WC7xankDturXYJuoGd/TE1pixkfYb
 z9LOTz+azv9XaWhtI2YxpM9ASCjz2gEcJZshvDAYJL+edYcKxmCIciURfXJcqE83q72G
 SVmg==
X-Gm-Message-State: AOJu0Yxx81f4xdRXlN1xlUKbiALwJraFYnEiZgb2CSk6/2GvbneCsPm1
 g90A5kAp2lFhYulItaE5s3RiUmGD9zlwP4oBYQV9q6smY/MJvRRYxhQHl75fDIdWz/adDDrIjpS
 hiS4b
X-Gm-Gg: ASbGncvVGVJe7Hx2n3K3SOoKhTCN/4QA+TX+ROXV1hqC+iQSYg8WY4MZBqtFEtinJpk
 nEl7f4tX5e5V891YyDo665vR2EWqClaD/KZUlii8R8ap7D2xV4IAkiBFT96+YJw6JOWIumOvT4W
 ZRVGRLi0dIkuxj51cLg4P85VDRwatJiZwbgngGV76oQ9uU2lLzAIs2X/iHG5+SWHDb3N87tW3WH
 gOF0jNZFryg0E32Qxt9ejq74BAe0daRrsNOYJj8aue3raEk2D67cPVT1n+vKUy7beilgmP2nTf8
 /W/YS1UrwsoF46LpQYXU2zkFNJ9w326m+vuSO2Ur7nHyofkwkbopSFmRYhhs58A8lWn8Bw1kdJp
 Lvqvl+KMa+8J4FYAg/fuGAg0+TeFrEytiOMSckhHp2aRCm8X5QgHb3kxlQF/1Qw==
X-Google-Smtp-Source: AGHT+IGI1fzmmj8GRvBC0NP1eU9rQm2gr4Ow4sGvkoOf7WOsrBQmtgNrXU7MS909AH7RgoJAhuj+uA==
X-Received: by 2002:a05:6000:24ca:b0:3ea:15cd:ac3b with SMTP id
 ffacd0b85a97d-4266e7e15eemr6682087f8f.30.1760101612818; 
 Fri, 10 Oct 2025 06:06:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 76/76] target/arm: Enable FEAT_MEC in -cpu max
Date: Fri, 10 Oct 2025 14:05:27 +0100
Message-ID: <20251010130527.3921602-77-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Advertise FEAT_MEC in AA64MMFR3 ID register for the Arm64 cpu max as a
first step to fully support FEAT_MEC.

The FEAT_MEC is an extension to FEAT_RME that implements multiple
Memory Encryption Contexts (MEC) so the memory in a realm can be
encrypted and accessing it from the wrong encryption context is not
possible. An encryption context allow the selection of a memory
encryption engine.

At this point, no real memory encryption is supported, but software
stacks that rely on FEAT_MEC should work properly.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20251006001018.219756-4-gustavo.romero@linaro.org
Message-ID: <20250711140828.1714666-7-gustavo.romero@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 3 +++
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 4 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 4496178c48e..bf81da124a0 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -94,6 +94,9 @@ the following architecture extensions:
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LSE128 (128-bit Atomics)
 - FEAT_LVA (Large Virtual Address space)
+- FEAT_MEC (Memory Encryption Contexts)
+
+  * This is a register-only implementation without encryption.
 - FEAT_MixedEnd (Mixed-endian support)
 - FEAT_MixedEndEL0 (Mixed-endian support at EL0)
 - FEAT_MOPS (Standardization of memory operations)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index cc42dfdf561..1bffe66e81c 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1327,6 +1327,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = GET_IDREG(isar, ID_AA64MMFR3);
     t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
     t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
+    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);        /* FEAT_MEC */
     t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
     t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* FEAT_S1PIE */
     t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* FEAT_S2PIE */
-- 
2.43.0


