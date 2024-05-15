Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F796C25B7B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rk-0004B6-7A; Wed, 15 May 2024 03:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Rb-00044o-Hq
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:00 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79RZ-0001Yr-5s
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:52:59 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41ffad2426eso48853725e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759574; x=1716364374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqU8ItNdi4m1XZTYvDwRO0vv7Nr1dGEj2Szzh23jUJo=;
 b=oJ1tXAq1cmxTT+P3SsDtAGK7w69uZvAZqT5xlZn2XaXMGkU0W+1Dgm53Nm9MUSC1w6
 oxQKE1ybxaDfGmrkGYhji1XUQz09lqs2JBxwzrRzIdtAXQBku8FYkjNhyT7+84z3Zl8d
 I2B+rMaV0j4HHfy/zsGxvCZPEr7Gfp1ah5h7UKr3rI1lxVnKVELeVShxFIP0R64zTJp6
 PWUuIiXQfWZGuPbK5uJjQU4ONDB9nENCrp1cA5tTLZbfj5J2N89Ho1h33zHvepWBur67
 qzg8AA8c/SZfgG9KIpU6ToOWvkt6QfZfcFLqLZCRmmINcoLUi9zLBI2IAP/AZRftCGT8
 +QAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759574; x=1716364374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqU8ItNdi4m1XZTYvDwRO0vv7Nr1dGEj2Szzh23jUJo=;
 b=J6nnbNOQ9QFSPUPdMLJsmb5m2E4SWkkBrqto+r05/2GujW9htNleGPQUYLwT5NczJm
 D1Emx7fPVZf6e6HVb+VKuGgMG2FH3njNQCxIQffLNLdEV3sstRpA9wqAdi7e+ct7JxeK
 rqg94/xfdFjKhyIqF6NUOM+nFStPokk41yUQKAqx+rp52egDR0g/o0SLrqa60zArIwEw
 CMnrAIJ7F44IXSW2WDPj51OsylpEmoOe0QJ9hVmQs4+KGf+rO8n6k4Mmuji06RD+ipID
 vv+wyXg4iEQR4jTF8kASnFgoNX+BA98jibV8cZOFvao0KsghJLnMXkMwqCmMJ1aJgu0Z
 6H9w==
X-Gm-Message-State: AOJu0Yxk2QLt80geGmG0PPZhboDIzMuNFAl/sOJQseTVfY7JXH7V4FDT
 wPuVprZ7pJqvSzqklt1DVRvJmEfZ4z1M/ZGTtRlYSe6R+FJgaXs9Vn9gOkt+gUvVwLznCnGv3UR
 M1v4=
X-Google-Smtp-Source: AGHT+IHEbxIPwdrzJMO9q2gwXYeDQd77ATDKAt6/xn1pjSBHJAuyqRGE3BptY36EBAWgEuYAQt2XUQ==
X-Received: by 2002:a05:600c:444e:b0:41b:e244:164a with SMTP id
 5b1f17b1804b1-41fea9324cemr156127495e9.6.1715759574662; 
 Wed, 15 May 2024 00:52:54 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:52:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/34] accel/tcg: Record when translator_fake_ldb is used
Date: Wed, 15 May 2024 09:52:20 +0200
Message-Id: <20240515075247.68024-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

Remove left-over comment from commit dcd092a063
("accel/tcg: Improve can_do_io management").

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 3 ++-
 accel/tcg/translator.c    | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 4a86907ecc..70cef2c0be 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -72,8 +72,8 @@ typedef enum DisasJumpType {
  * @num_insns: Number of translated instructions (including current).
  * @max_insns: Maximum number of instructions to be translated in this TB.
  * @singlestep_enabled: "Hardware" single stepping enabled.
- * @saved_can_do_io: Known value of cpu->neg.can_do_io, or -1 for unknown.
  * @plugin_enabled: TCG plugin enabled in this TB.
+ * @fake_insn: True if translator_fake_ldb used.
  * @insn_start: The last op emitted by the insn_start hook,
  *              which is expected to be INDEX_op_insn_start.
  *
@@ -88,6 +88,7 @@ typedef struct DisasContextBase {
     int max_insns;
     bool singlestep_enabled;
     bool plugin_enabled;
+    bool fake_insn;
     struct TCGOp *insn_start;
     void *host_addr[2];
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 86a1fe17a0..aa9f36aaa0 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -130,6 +130,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->max_insns = *max_insns;
     db->singlestep_enabled = cflags & CF_SINGLE_STEP;
     db->insn_start = NULL;
+    db->fake_insn = false;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
     db->record_start = 0;
@@ -434,6 +435,7 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
 void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8)
 {
     assert(pc >= db->pc_first);
+    db->fake_insn = true;
     record_save(db, pc, &insn8, sizeof(insn8));
     plugin_insn_append(pc, &insn8, sizeof(insn8));
 }
-- 
2.34.1


