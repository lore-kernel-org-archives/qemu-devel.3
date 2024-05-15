Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7578C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 08:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rr-0004Ho-Lh; Wed, 15 May 2024 03:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Ri-00048y-8y
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:06 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rf-0001bh-ST
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:05 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41ffad242c8so34399915e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759582; x=1716364382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nWXlcFf/ukN+q7QhzDqXIa8CiZT41OLDlcvMAkUxKU=;
 b=Owl7Idi+7wiWepcHO2p4+lD4wKLgH8tIeQ4gksJZbpHh8r59nvIrA84op+sF3e16pr
 8uas5g+eyJnqsaarKUOnhtiM7KLOxOKcjwmDMqx6Ln9W0RWLWeC9WvKiJU7tyqEpNe7w
 9bMdzTVQKTXzClyfcaF1InqzaThND0DIgXFdMNPPuUmCz2nqRkdYIgUyIchHNZHrjgIn
 0/u1NW2ksn1CVpht7NjT5IquQFak4JJXrQylhuNgLgJAMkjkuOHu5/+VEsjjaeChYGUu
 kCzmaWeJL6B24W1X+3/6oZ6fSRhmVgbJMzoO583N/Ss+xX1OgOw43bpccC+1IVp8FlMI
 TtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759582; x=1716364382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1nWXlcFf/ukN+q7QhzDqXIa8CiZT41OLDlcvMAkUxKU=;
 b=ThClyNEZuwTkMGPtFn8nJGykICS0kQ8wTZzx9mQo/WkoJrtsa+L1yiGzwN4yjrDyXh
 C7PJ/o5k0Am0NWQcIbxVSQdlynNDy4PnBWVxaxWW+nbQ6fUohV5po4+2IYudWngrtNJU
 fZ8B3prtiTBNfUh4RzU0badon7Hh+egh3qYz9NEaobWeaELG6NCJL1qhkve4/Kbhx7/b
 21PgiEGYSayxHRdXtXDF1k8ADizFH/OXxPpMVjcZV3d1iB1JlAo/OaeIoiNsRJZaBkUc
 /eQe8jvzfAfZfpdt3bVjUDE80KtleQ6D6oM4j9K8PRPrKDlmtcoPv3bWSJL8gz5a6TkE
 LgrQ==
X-Gm-Message-State: AOJu0YyScalGK9EkbLYGaVAvcukXSYRs4D2+HzLsaVErIPJ+hg48yGMv
 DunhvEEzPZ2+LHcQpVcEYUk3D0wPz9XD8MujKGctdmgawYZ53thlPtfTgEF0KDx7B3DQX5szaqp
 jyng=
X-Google-Smtp-Source: AGHT+IEBXBsdsOVUurlJskDFvZfci4VJNr7GGfOAVHe/3jNky1+oL3FfYoyhpOFZpydqSSrRIyGkPw==
X-Received: by 2002:a05:600c:3ca3:b0:41a:908c:b841 with SMTP id
 5b1f17b1804b1-41feac55671mr146826585e9.32.1715759582400; 
 Wed, 15 May 2024 00:53:02 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:53:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/34] accel/tcg: Introduce translator_fake_ld
Date: Wed, 15 May 2024 09:52:33 +0200
Message-Id: <20240515075247.68024-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

Replace translator_fake_ldb, which required multiple calls,
with translator_fake_ld, which can take all data at once.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h    | 8 ++++----
 accel/tcg/translator.c       | 5 ++---
 target/s390x/tcg/translate.c | 8 ++++----
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 411ce2b47e..25004dfb76 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -234,17 +234,17 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
 }
 
 /**
- * translator_fake_ldb - fake instruction load
+ * translator_fake_ld - fake instruction load
  * @db: Disassembly context
- * @pc: program counter of instruction
- * @insn8: byte of instruction
+ * @data: bytes of instruction
+ * @len: number of bytes
  *
  * This is a special case helper used where the instruction we are
  * about to translate comes from somewhere else (e.g. being
  * re-synthesised for s390x "ex"). It ensures we update other areas of
  * the translator with details of the executed instruction.
  */
-void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8);
+void translator_fake_ld(DisasContextBase *db, const void *data, size_t len);
 
 /**
  * translator_st
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 00322c6fd9..c56967eecd 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -468,9 +468,8 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
     return tgt;
 }
 
-void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8)
+void translator_fake_ld(DisasContextBase *db, const void *data, size_t len)
 {
-    assert(pc >= db->pc_first);
     db->fake_insn = true;
-    record_save(db, pc, &insn8, sizeof(insn8));
+    record_save(db, db->pc_first, data, len);
 }
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index d74939389a..2eb787e401 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6191,6 +6191,8 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s)
     const DisasInsn *info;
 
     if (unlikely(s->ex_value)) {
+        uint64_t be_insn;
+
         /* Drop the EX data now, so that it's clear on exception paths.  */
         tcg_gen_st_i64(tcg_constant_i64(0), tcg_env,
                        offsetof(CPUS390XState, ex_value));
@@ -6200,10 +6202,8 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s)
         ilen = s->ex_value & 0xf;
 
         /* Register insn bytes with translator so plugins work. */
-        for (int i = 0; i < ilen; i++) {
-            uint8_t byte = extract64(insn, 56 - (i * 8), 8);
-            translator_fake_ldb(&s->base, pc + i, byte);
-        }
+        be_insn = cpu_to_be64(insn);
+        translator_fake_ld(&s->base, &be_insn, ilen);
         op = insn >> 56;
     } else {
         insn = ld_code2(env, s, pc);
-- 
2.34.1


