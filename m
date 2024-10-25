Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EE5D0C616
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4L47-0004Kn-Dd; Fri, 25 Oct 2024 10:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L40-0004Cj-GN
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:16 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4L3s-0007qw-Iq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:13:16 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d41894a32so1613395f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729865587; x=1730470387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3N7Gh5ykD6QxUXP4fouNsk3DmkKRJ2QzcoWCfXISHI=;
 b=VkHiDTtkl6/xjD7vf7wRv6vPMshw+ZerzlexMzsF9ivpAYZdnYNEmlD5fYaA1UivxW
 2EppflRwN20n291OyRg4MJcQTdRfD47bHJECxXK4LRCht5gCnfrWXE+qEcp+qW6pyfd1
 k+NJB5/hfscgXIxmGdRVVaYA/HDNHWWmwTztGUpC+5jgT9xPgv4B0hYPNCf1dC8pW4Pb
 xKpAKpzvanmJJ++seOIv2/o7VS3uirtsMw+yJWmV1VRD8GKYJO2PoTLvcDNiuMIL8wEo
 OosJYc0baW5VNq64Unsux3tE6P9ya706IOffWX23HlAcfpuz03NFFMBkNFPmPkN+s15k
 +5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865587; x=1730470387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3N7Gh5ykD6QxUXP4fouNsk3DmkKRJ2QzcoWCfXISHI=;
 b=A0e4RCdeTvWclCIsL0nVOQq6r/4iyFCkgCSeU+5mbGd25MLJckMFw30V6sEaY5vk40
 1QHAVO2NjB53pLu6v2e5Tm2IJ8h42iR3f6OhrGYHTu743D+fiq6a0oBVkfe7NGdp5xGJ
 LVXh6sQumMubWRb5qFon16whyHGuXZ7LYB+yHOCUBMDsGWy1APpAfroTHyzOxG6kX3n+
 lzE2XWQVl+Cd+ENCTVtA/QD5ytUc+qW9fw299E7jzO0PppucvWU6Je78kmM/3sUvmy+/
 r/Wi4iGnMtU4J6HyZohHV1WsqLRWie3O/3kOtLuKI4RTID0760aMVHCR+2rIezhmEgEC
 l5Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWgz9ITntkNMX3jUDSb1ASV59LbrVvwqWSWFs+PmaRaJ7b93CZnUMSXa4x2keKUMS0ORl6jLt3SG0E@nongnu.org
X-Gm-Message-State: AOJu0Yz7zhoMH9i0d/3DqoYwlRrvjpoJF6TVCKL2ZRQpemZJO98myL+7
 V+EwNDWUFYLz14f26bI4WsPwLWOrfFH4qV4ftfFhtdSTPZdIVW5Ynv6ctN0NdZc=
X-Google-Smtp-Source: AGHT+IFELKEdswjTGifEl1YHesJLSbvwyrbGh5IhwQ+SHELG0FMMmzYmcW2PCs8GDLSYanzPnyZ5mg==
X-Received: by 2002:a05:6000:d0b:b0:374:bd00:d1e with SMTP id
 ffacd0b85a97d-3803abc2879mr4856955f8f.3.1729865586918; 
 Fri, 25 Oct 2024 07:13:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm50104535e9.42.2024.10.25.07.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 12/21] target/sparc: Explicitly set 2-NaN propagation rule
Date: Fri, 25 Oct 2024 15:12:45 +0100
Message-Id: <20241025141254.2141506-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025141254.2141506-1-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Set the NaN propagation rule explicitly in the float_status
words we use.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/cpu.c             |  8 ++++++++
 target/sparc/fop_helper.c      | 10 ++++++++--
 fpu/softfloat-specialize.c.inc |  6 ++----
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e7f4068a162..dd7af86de73 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -26,6 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "qapi/visitor.h"
 #include "tcg/tcg.h"
+#include "fpu/softfloat.h"
 
 //#define DEBUG_FEATURES
 
@@ -807,6 +808,13 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     env->version |= env->def.nwindows - 1;
 #endif
 
+    /*
+     * Prefer SNaN over QNaN, order B then A. It's OK to do this in realize
+     * rather than reset, because fp_status is after 'end_reset_fields' in
+     * the CPU state struct so it won't get zeroed on reset.
+     */
+    set_float_2nan_prop_rule(float_2nan_prop_s_ba, &env->fp_status);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index b6692382b3b..6f9ccc008a0 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -497,7 +497,10 @@ uint32_t helper_flcmps(float32 src1, float32 src2)
      * Perform the comparison with a dummy fp environment.
      */
     float_status discard = { };
-    FloatRelation r = float32_compare_quiet(src1, src2, &discard);
+    FloatRelation r;
+
+    set_float_2nan_prop_rule(float_2nan_prop_s_ba, &discard);
+    r = float32_compare_quiet(src1, src2, &discard);
 
     switch (r) {
     case float_relation_equal:
@@ -518,7 +521,10 @@ uint32_t helper_flcmps(float32 src1, float32 src2)
 uint32_t helper_flcmpd(float64 src1, float64 src2)
 {
     float_status discard = { };
-    FloatRelation r = float64_compare_quiet(src1, src2, &discard);
+    FloatRelation r;
+
+    set_float_2nan_prop_rule(float_2nan_prop_s_ba, &discard);
+    r = float64_compare_quiet(src1, src2, &discard);
 
     switch (r) {
     case float_relation_equal:
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 226632a4d10..8bc95187178 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -404,11 +404,9 @@ static int pickNaN(FloatClass a_cls, FloatClass b_cls,
     || defined(TARGET_RISCV) || defined(TARGET_SH4) \
     || defined(TARGET_TRICORE) || defined(TARGET_ARM) || defined(TARGET_MIPS) \
     || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA) \
-    || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K)
+    || defined(TARGET_S390X) || defined(TARGET_PPC) || defined(TARGET_M68K) \
+    || defined(TARGET_SPARC)
         g_assert_not_reached();
-#elif defined(TARGET_SPARC)
-        /* Prefer SNaN over QNaN, order B then A. */
-        rule = float_2nan_prop_s_ba;
 #elif defined(TARGET_XTENSA)
         /*
          * Xtensa has two NaN propagation modes.
-- 
2.34.1


