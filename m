Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AF3C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsgl9-0005zb-IS; Fri, 05 Apr 2024 06:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl1-0005x9-Gc
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:15 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgkw-0004Y3-Dl
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:15 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-22a1e72f683so1049302fac.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312705; x=1712917505; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=F7a3sqe7T7/4TgllKlNheahf88h9/zMntHlNSh3e9Z4=;
 b=awc6rhn6WZxOFYvcmrgFgjRMw3veSI1HLtDxm1uddPlxfKDItTFlT+GHTxjtJWTrD1
 ewIe3sBsY/EUl3vymh5al/Pzw3leiAC04x95ZphUBSQpi+VariYNzD/YCBClbRlF6IZb
 i2ktPkumIgV3Q19YxE2mCjydY/W3TAqg7qAxDYAdAVIi/WdEJoa6rLBJizUIW+UZqmTa
 ow3WazLQK9fetBFu4DvueImFc8lDy4Z/puP1K/tDVzGrfGAgBeiIvqBySY8eaAvS7Ozh
 zJ/1WSkQfBPDOrqpl+4m9WZAty/iLYnaFGoxgN6GVCRtPaQLE1mcoTJ6LHPLJhTNwxsA
 LpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312705; x=1712917505;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7a3sqe7T7/4TgllKlNheahf88h9/zMntHlNSh3e9Z4=;
 b=IpHXDOPQAWqMqXo0lh17OcPGNm+a7jG4kN3WHE9Q7oCC43K8b3nQ/35UX1Bw3/4cM6
 a42m8KunSHUrj/6V6IpBcMW5aRT4tSBxU03d9b3ChgxIgW4WmxX5TmFrhiQ2EGPq44D0
 521dCBYkkQbbUXxBTQNbjqAOuU7PhidBG8bRUx77+U4ODn6/CMmkGxwhDA5r+IQceeY8
 yVHFgqRsC2x7JbCHoq9e+iuYQXo5h5M6iNc88ry8GSkNw4hytY5L/ZUf5hrRGzwCK2lw
 tCI12KUwHvAtXWyLg6pZgTDo9N5O0/w2pQtq4vp9QCmoFc8kQjYYOdcblVjaDfU+Vtde
 GtKw==
X-Gm-Message-State: AOJu0YzfXNB42TSs/Htq03AEA+v25M9GkubbK+jXAHRb47YCNRRCzg32
 Egs7HXCsukk27ZRMKLXnQCgu8T8AlaaEA5IBgEma9VLvVq1qfUtHcNuzvF3b2mJwR1xvLesYN8a
 k
X-Google-Smtp-Source: AGHT+IHpPcUACOSRqgX50N5GT5KHNv4WwBcYwHb3JdObmBfUuh0n3g4Plb/X+zFwpPXF3GX0YXaReQ==
X-Received: by 2002:a05:6870:9726:b0:22e:be32:9e6 with SMTP id
 n38-20020a056870972600b0022ebe3209e6mr1266169oaq.14.1712312705626; 
 Fri, 05 Apr 2024 03:25:05 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/32] accel/tcg: Pass DisasContextBase to translator_fake_ldb
Date: Fri,  5 Apr 2024 00:24:30 -1000
Message-Id: <20240405102459.462551-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h    | 5 +++--
 accel/tcg/translator.c       | 2 +-
 target/s390x/tcg/translate.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 185ab5c374..65d0c6489a 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -220,15 +220,16 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
 
 /**
  * translator_fake_ldb - fake instruction load
- * @insn8: byte of instruction
+ * @db: Disassembly context
  * @pc: program counter of instruction
+ * @insn8: byte of instruction
  *
  * This is a special case helper used where the instruction we are
  * about to translate comes from somewhere else (e.g. being
  * re-synthesised for s390x "ex"). It ensures we update other areas of
  * the translator with details of the executed instruction.
  */
-void translator_fake_ldb(uint8_t insn8, vaddr pc);
+void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8);
 
 #ifdef NEED_CPU_H
 /*
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 9ac0f52b47..64cfa4e003 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -371,7 +371,7 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
     return ret;
 }
 
-void translator_fake_ldb(uint8_t insn8, vaddr pc)
+void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8)
 {
     plugin_insn_append(pc, &insn8, sizeof(insn8));
 }
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 57b7db1ee9..8282936559 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6204,7 +6204,7 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s)
         /* Register insn bytes with translator so plugins work. */
         for (int i = 0; i < ilen; i++) {
             uint8_t byte = extract64(insn, 56 - (i * 8), 8);
-            translator_fake_ldb(byte, pc + i);
+            translator_fake_ldb(&s->base, pc + i, byte);
         }
         op = insn >> 56;
     } else {
-- 
2.34.1


