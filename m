Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BF2C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rc-00044k-Ad; Wed, 15 May 2024 03:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79RW-000416-IJ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:52:54 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79RU-0001Xg-Cv
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:52:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-420180b59b7so19010495e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759570; x=1716364370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z538Yc8eAgdGOVrA7CuXrxetPsi8c98l/ZVNOYY/ekc=;
 b=rbIGEI0skirPterv4lC1c/VgpG+Stm1r7anoDncO/nrsE08PVyL3Sn3HR69kbTqtRW
 Vh7MN45bEk52eGXqtKBvvRAap0N4eaSaEXg7IXDZMbx3OZH5Uvrrv/tXxuZeH6xWdPvL
 v7GsJ/9zF/MA/SV6IROanLELuWnXmdXB0uPh4+iH8S08LbhjRCG1jWHhZwmIio308Nms
 bER55cGB9Mx3L0d3zr4c10kfFpbVwoxDFFK8xuSBFjQepPWmlnx33uGOFuxh00wRYscx
 Lncv/XafPQPSC13Ja1yrNPYEsAhUroJeaMCeFKMmNZ1nGLt1uiQTIRD6JgxXjGRCr/mE
 UIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759570; x=1716364370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z538Yc8eAgdGOVrA7CuXrxetPsi8c98l/ZVNOYY/ekc=;
 b=AQkH9PbLLSGetfGCOROJGdFfP4/VQ2PWIbJmFpV3ezHy5bsYy0YlYqgPrTd/nLCIsF
 pjOc+gJ7SRDbwhTTI7Yh+IFhF8Ex1YT3BlOLNsITJJmf40UdRlb/vFoOljdJoDUrP9TS
 CR1thv9y2fYuR6MVHHAdyvcfLRlgbgPgycZ81OgDIU67hRj8IiMqNq8cOdsgAnulDYi/
 qt3yMKTAMJAnNzq+f3stMb6eozfowk3F7EhhGPT3XSQ+mmMaIj/Em1dvsgSZ+axe4qE5
 IChDZV+Sa4E31FlWolCdLEC5K3jfkZR75nmvOJQyEqkW1SjPFGqkSl4/M5M57Lpl+hQA
 2/Rg==
X-Gm-Message-State: AOJu0YyKvJGAFqq8ODYcBlxAcLVHKpxYJsiBnMbaetOELZ5gvD74M1nr
 EUqjq9Jnv6V6jYdlKZjkibgmKTGIERfWpc508ZJh8ssoj2Nq6ozbyfDjTuCQ4Dc5NviVOe8ZTiZ
 n1gQ=
X-Google-Smtp-Source: AGHT+IG1U6YTY8AVHQlYaO5GHa5ARMrKpCDIDiNT40r+epYIN7BXehIIWzWY1KmPeSNuGZxDZ/jV7Q==
X-Received: by 2002:a05:600c:4752:b0:41b:fc7a:e7ee with SMTP id
 5b1f17b1804b1-41fea539719mr111013675e9.0.1715759570310; 
 Wed, 15 May 2024 00:52:50 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:52:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/34] accel/tcg: Pass DisasContextBase to translator_fake_ldb
Date: Wed, 15 May 2024 09:52:16 +0200
Message-Id: <20240515075247.68024-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h    | 5 +++--
 accel/tcg/translator.c       | 2 +-
 target/s390x/tcg/translate.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 212362f5a0..348985c3a3 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -222,15 +222,16 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
 
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
 
 #ifdef COMPILING_PER_TARGET
 /*
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 53225290b1..3456455fa5 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -375,7 +375,7 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
     return ret;
 }
 
-void translator_fake_ldb(uint8_t insn8, vaddr pc)
+void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8)
 {
     plugin_insn_append(pc, &insn8, sizeof(insn8));
 }
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 90a74ee795..6d7f6e7064 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6203,7 +6203,7 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s)
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


