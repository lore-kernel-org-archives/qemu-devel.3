Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FB9C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5Y-0005oa-Pn; Wed, 24 Apr 2024 19:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5U-0005lQ-6T
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:41 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5R-0003QB-Kh
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:39 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5e152c757a5so277183a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001496; x=1714606296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRmmyNWVRI8wLkGl56IuznCDWl3kVq+6+02gTlw1Wzo=;
 b=tJQfICG8G6HdUVHbOmhaEalCDVsl0KEbvbkGJKnRn1cPfg6NGm6nCFIu/393XUZ/0X
 erMcHS3v9iZf0V9+wN4zFD0jPiYCsA2EvSDkf19PYYZhp9lIAz6I47Mh7MNEwVQb9tak
 CD+bjLuRYp5GWdJpGPaRo0yrJ/u24X5X/Jlj+kPxVhiG30VYWYjlkpnBAxJx5oaLVgBd
 fDOvBuZRHAaoRkoYZZJv4F+YLq6HoP9bwvYP6IZrAIS8SeVg7Ozs5Hwbc717ecZE60Oc
 gZfJXicGHnkcS9nN8eUbUkNSWQZ6ryqimFfAS8Vze2isanqHYhL7XZilA4g33wkdPLbN
 S4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001496; x=1714606296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KRmmyNWVRI8wLkGl56IuznCDWl3kVq+6+02gTlw1Wzo=;
 b=ViLp+9QR1Ll4CR+TLb+5ADRVTEWq008NH76yjyaOZS9jklPz6XBar2z9XsRq4ZKLjo
 ovbNe3JPk4aRFwacQik5prkYfSl6X9EpPNrFW65zlc3uKZBe/HKxP+1pFGLEE3ZMjGTs
 yNZPSlbmy+rZjIBYrl7aD2EyLPsT6VaP5ak9P0pbWwAux+1T2ZMf6xbx60r9zk9ZufYA
 w7zB78TDggAXUlnz1GO3noJFTfgqBVEF8wdsjxp8aYdutj5MgjpdQeFaRLvqo7ZHBnC/
 LkSji4vjcPS2fdAXHgGWJSKyklpmDXaAvXfpAlGyaKZrJbT8ENNgtiVo33RlYKPQuV/+
 x/sg==
X-Gm-Message-State: AOJu0YysAH7fOF5TykT3pjBWFC8xdRL2xe8QovzBW2kAgUyqbz2uF1C/
 GU9DqYjU0CcZ7R3vZfmP0HthTIhmOL2JpWVsWSgIvHL3pN7TYx/SM3b6AjU7K8qdYOPXPeu46k/
 O
X-Google-Smtp-Source: AGHT+IGjQF+hOWd84COxqQtgCixoKVRnq2QtUXAgmhTeCCFEnXVPZ8O2KyJLMfuEqcwc1Pe5Y9r9pg==
X-Received: by 2002:a17:90a:a391:b0:2ac:f010:b1c0 with SMTP id
 x17-20020a17090aa39100b002acf010b1c0mr3610554pjp.22.1714001495935; 
 Wed, 24 Apr 2024 16:31:35 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/33] accel/tcg: Pass DisasContextBase to
 translator_fake_ldb
Date: Wed, 24 Apr 2024 16:31:01 -0700
Message-Id: <20240424233131.988727-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
index c6a9e4b69a..83fe66cba0 100644
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
 
 #ifdef NEED_CPU_H
 /*
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 42fa977e45..92eb77c3a0 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -374,7 +374,7 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
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


