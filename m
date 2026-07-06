Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7C5C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggio-0007Rn-LO; Mon, 06 Jul 2026 06:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiF-000701-Bd
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:10 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiD-0003GU-46
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:06 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so28924035e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334283; x=1783939083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bAvW1IPTU6EfP0gh4hmPVnQQil1eg3LocjPyetNdf2A=;
 b=XzcriO0hqff1zqAS+J8h1TCaqoSkak1qE+p+zVxzjCm1hQac0gafMIx/nZb3yojjAY
 XIOrYm4Q+XKE666ivJRuYtxjR9Ur7ku5gGDrTyjjG00kMi9PHgiUrZ5MOAjA8J9qJXVS
 Nj4sc8CtHK5nR+kILyMrHcKP6y//JKAT1wHjsFq4j+slbV2EazR+6gHTeJ2PsAI4+C74
 yBNhi96jqepgtSFnw9PmsdLldGcdK8zsy0P6mNP17jbHxeS5bPXGdPjDCzDNrMNfpGO5
 n63e9NDrgV53+KmeQNtM71mxhgyGAV5SzCut90L7NnspkmUkjVXroYjNBluf4GXc1WXx
 4zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334283; x=1783939083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bAvW1IPTU6EfP0gh4hmPVnQQil1eg3LocjPyetNdf2A=;
 b=KaktaOADGUaH+cHSb/NP8hDAYWaxfwX83FHK0zhuhhqSoZg+8q6201B+K44bOvHpGn
 Agt/v52YxOtxtm/3iixkpUX2qwwNfyRu22eaGZGHNlo8cCWfkAFhgz/ZSsBlFFn4odrx
 GpSaUHRwLyQ0Xovc5EuUSLpM9KKwPvnojF0UBb7YvxMg/U4Aiqc5aPnmkSO2q0QVBGoe
 g70rRDzGdam5h4AuxjJ7LZvs4q85jelv6IrZpDMiMrechPWhfx/4sGudo0x1jTl1rn+5
 V9jSpl05bCfS+YhJ532h3BC1BAEqxUVd54IcHt0SSUnE9/aGpUwYpUkPQcN1jMSBHlp0
 68fg==
X-Gm-Message-State: AOJu0YyvMGI+UGxq/nQgZvEWs9dnHGtZQ6LQXszH7J8NZP4OecVg5tG3
 PDYQL7JnQf6pmvBcCflQwxgC6qodxEhHUaGNUd4hcm6pG+hQ/yUBXNT16FoxC7mHBZzvkoOEUU5
 vlkL/RGhflQ==
X-Gm-Gg: AfdE7ckJqRUw5cXT2ltmUYkFP+qxI7ALhCogPQsSIRatVHmQClcPYPoFof7DwOU6kvi
 IkCCpgmlvIYt74KCbblR8ODluSz9SShNCpDqxPRWiUNMZNTRCzOuoepKfsEdSqEbqOW4yfFvJ7Y
 q4+wJR8mCr7Kzon8W7VQd5VRN4g2J3AtmvEelrxBjrcRpdXMzzvyxYdSCryxmmfZv4d2ld0LPR3
 uAlRcwNDzNd7a2ZgpSnfY7WGJVbqdwbge2iid/bAoDoCG2rNe33A8Uxz8DtD5ENXHcWBFW6PJUP
 MwtzEOsmJLVSQGs0LUX4xpXGS8vLtzirfm98JLFuV0g6FK7l2p2l3T3Hw4iDdKPh38kG1ViGpSj
 x6vafT/O7Q0E73rk+efnkMS5W3o2aWKNGeFUvzWhhqs5xID3nkxGG2twEVcVK+zS46QFaC1C6xn
 9PeCbc7bVbv++/xwbIQu3P0NtBN80W4ctHIGf8dea4cgmfRJKTUnnHTRZAWhG+ngbXsikjJ0Ebr
 5Vu8DaQGr4E+23Obq8CKw==
X-Received: by 2002:a05:600c:3f0a:b0:492:4a50:41fe with SMTP id
 5b1f17b1804b1-493d11f05a3mr111330895e9.22.1783334283299; 
 Mon, 06 Jul 2026 03:38:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/49] tests/tcg/arm: Tests for new FPRCVT instructions
Date: Mon,  6 Jul 2026 11:37:12 +0100
Message-ID: <20260706103752.320511-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Jim MacArthur <jim.macarthur@linaro.org>

We autodetect the presence of FPRCVT in the test cross compiler,
which is a recent feature in GCC and not supported by many distros
yet. If this is in place, we compile the existing fcvt.c test with
an extra compiler flag which uses the new SIMD instructions; the
output from the test is unchanged.

The existing [US]CVTF instructions do not have a test, so no new
tests are added for the SIMD versions. They have been tested manually
to check the new SIMD versions produce the same numerical results as
the existing versions.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20260630-jmac-fprcvt-v3-6-f4840d5e0a7f@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/Makefile.target | 14 +++++++++++++-
 tests/tcg/arm/fcvt.c              |  7 +++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 6203ac9b51..32f2689273 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -28,9 +28,21 @@ config-cc.mak: Makefile
 	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
 	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
 	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
-	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fnia, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
+	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fnia, CROSS_AS_HAS_ARMV9_SME); \
+	    $(call cc-option,-march=armv9-a+fprcvt,         CROSS_CC_HAS_ARMV9_FPRCVT)) 3> config-cc.mak
 -include config-cc.mak
 
+ifneq ($(CROSS_CC_HAS_ARMV9_FPRCVT),)
+AARCH64_TESTS += fcvt-fprcvt
+fcvt-fprcvt: LDFLAGS += -lm
+fcvt-fprcvt: CFLAGS += $(CROSS_CC_HAS_ARMV9_FPRCVT) -DFPRCVT
+fcvt-fprcvt: fcvt.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+run-fcvt-fprcvt: fcvt-fprcvt
+	$(call run-test,$<,$(QEMU) $<)
+	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
+endif
+
 ifneq ($(CROSS_CC_HAS_ARMV8_2),)
 AARCH64_TESTS += dcpop
 dcpop: CFLAGS += $(CROSS_CC_HAS_ARMV8_2)
diff --git a/tests/tcg/arm/fcvt.c b/tests/tcg/arm/fcvt.c
index ecebbb0247..7c0cc4367e 100644
--- a/tests/tcg/arm/fcvt.c
+++ b/tests/tcg/arm/fcvt.c
@@ -171,8 +171,14 @@ static void convert_single_to_integer(void)
 #if defined(__arm__)
         /* asm("vcvt.s32.f32 %s0, %s1" : "=t" (output) : "t" (input)); */
         output = input;
+#else
+#ifdef FPRCVT
+        asm("fcvtzs d0, %s1\r\n"
+            "fmov %0, d0" :
+            "=r" (output) : "w" (input));
 #else
         asm("fcvtzs %0, %s1" : "=r" (output) : "w" (input));
+#endif
 #endif
         print_int64(i, output);
     }
@@ -425,6 +431,7 @@ int main(int argc, char *argv[argc])
     convert_double_to_integer();
     convert_half_to_integer();
 
+
     /* And now with ARM alternative FP16 */
 #if defined(__arm__)
     asm("vmrs r1, fpscr\n\t"
-- 
2.43.0


