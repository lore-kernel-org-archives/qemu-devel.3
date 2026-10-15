Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF052C2D0A6
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtJ-0003nq-VB; Thu, 15 Oct 2026 14:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtG-0003n5-53
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtD-00011A-H1
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:16 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a02718da81so45039455e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087754; x=1792692554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=clRJ7OpA3xdDXw1e+6Z25EeQ0NzG9+VFgE9Zlctk0Qo=;
 b=XU8LrqvDEYK6qHyd7IuXkLUB7TqAIkY3iy0uCdRVcWumzEOh8NACIa2ZZXXYbLWpmu
 1q+Dx7bAKSXKmZmHm9tsP+wihKbBTkZ4cnXrtm8gEy9Hdu1iW5aPLd/XnBbTf1Ket4iX
 hMFRoAGS8LddZRCgnXBjyXsMvwoermHze0XdHUrxb4OMmeQTPS+FbBEdyISoMEcpuglY
 BLvSU9Hnn99m891s8c1UkbG6iCsvfk4wYXP4C1fm8AqwUOfIU6NgIws+DEy6xlxtmqoX
 Q6+vjs89+LpQS5Q0k3Ujmd4WS+9jTxmL9HCzkYSUEiXjcVz8IyNGA2mV6W438llUYN+u
 mp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087754; x=1792692554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=clRJ7OpA3xdDXw1e+6Z25EeQ0NzG9+VFgE9Zlctk0Qo=;
 b=l6cmdd0U8Q8RBU68uJggCaeJeEszwagonrV9OymEXI3mqlrRbbRRQVZaVwEkLoVoxW
 WohqqXMQKn4OPDYDK83/hF3+Q21nHo5mrYfKsdRox9daYqEaAc9bWK37y0b6rUwp9omO
 bCDCh5xpia+QWhDk33FTjqzTrhP9JvSsmpIO7pOsvehbngRsH24iTVEyPMfUzza76LgG
 +aP70EBLHcCAcTNQ5ORSHV0WbwwKpfpweGSHn1tyD+63Cbk84LJXWkLcEshk5hDUg/sa
 5UwQcMaapqLCpg4Gy0dPr9cDEK6ygJgnZjN0lR+wZX/ExyJtaHzvn2KhsaxPtslKmNKi
 vDyw==
X-Gm-Message-State: AFq9FYK5z4eEiOPyDXOLOx6GryLpdTYe6GPtdqWE4AQRXT4xyMiwCCJr
 AXUZ7EzwmDztQnUBCXV2PsiefKtSXUA5sAZ/WfYMcv/fEXNQiyFKnbjyt0LyUvFXcLMp5rQubsv
 NuVfqMTE=
X-Gm-Gg: AYBFou1bgNHhEh7uAwPq2oNmM2mG8pygNVrw0NTbW1Pp4iHBw8M/OCoVq1fZ9A9TwTw
 Hdf0au7xdV9dCbPIFEwIwr1r1Mmju19xrw33q9oGERYvnziF489EkaO8wTvcuJnwXgvul19QxZY
 OdEyQ9X292nQi6u31g0ypN9f++nSbPIMV3UmPmtdQdGd+lSff6Qep+mx7/82p7DD0uTL6zvzbWd
 XMQ6DUwc7G6MKeOXUTfeEB99u01d7eu6b0cbo5YztS0PGmfSq+0GvDmzsMWvrnGws8rAlKLnnKr
 HxNXXc+gIfHlnmnMeDu8p1zy8jiYlV3TsJWHk47oEDTMkCUA/kAEsS5vNth5j4NSmti0WU9BdyC
 1pdBhYEm7jbO3c5IK6eDFjbu3IpA3Y1N11Rafo9QLIhhgAKhwLUf7qKDyZ9C7H/LgTmDa7xu3dh
 RMEgScBl8F/lsS3EiZAUpL+yCbMIo+skM2dWfyewTjYxj96p2aGMhrWGo1fn8FvTdDRpxQTAPbX
 Fse0zTisofARB6oxIN3zpuKq/VCmjFNWEKWk+9683GkMg2CB/Vnmd1chp7NOibxrTp9WuJSSreQ
 7W8=
X-Received: by 2002:a05:600c:3e07:b0:4a1:a009:9724 with SMTP id
 5b1f17b1804b1-4a1a00997f1mr237366175e9.7.1792087753845; 
 Thu, 15 Oct 2026 11:09:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/16] target/arm: Enable writes to SCR_EL3.TID{3,5}
Date: Thu, 15 Oct 2026 19:08:52 +0100
Message-ID: <20261015180858.1863407-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261010070952.323466-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 target/arm/cpu.h          | 2 ++
 target/arm/helper.c       | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 2fc1bf02cbe..96ec12f64f4 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1408,6 +1408,11 @@ static inline bool isar_feature_aa64_idst(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, IDS) != 0;
 }
 
+static inline bool isar_feature_aa64_idte3(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64MMFR2, IDS) >= 2;
+}
+
 static inline bool isar_feature_aa64_half_evt(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64MMFR2, EVT) >= 1;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 06ebed4a8fd..a0355ba9e1a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1811,6 +1811,8 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define SCR_EASE              (1ULL << 19)
 #define SCR_NMEA              (1ULL << 20)
 #define SCR_FIEN              (1ULL << 21)
+#define SCR_TID3              (1ULL << 22)
+#define SCR_TID5              (1ULL << 23)
 #define SCR_ENSCXT            (1ULL << 25)
 #define SCR_ATA               (1ULL << 26)
 #define SCR_FGTEN             (1ULL << 27)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ff8a8fcca41..4cd418b962a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -960,6 +960,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_rng_trap, cpu)) {
             valid_mask |= SCR_TRNDR;
         }
+        if (cpu_isar_feature(aa64_idte3, cpu)) {
+            valid_mask |= SCR_TID5 | SCR_TID3;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
-- 
2.43.0


