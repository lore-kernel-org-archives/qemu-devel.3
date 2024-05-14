Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17653C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 17:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6wBo-0004yf-7s; Tue, 14 May 2024 13:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wBY-0004s2-8l
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:39 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wBN-0004tg-Dk
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:24 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51ffff16400so9766354e87.2
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 10:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715708578; x=1716313378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zg7uO0Rw5DQZHLZd3hROnnvwozpRBqkVuZQLTUMEUA=;
 b=myzcTwcQqS+F1Kj28V6Zh/ZflK3ZgAQiq/9KRfwFLuGllEjtqAN/I2zItqC6do1hot
 u2JoO4Ie90PcXAksKjqS+UcuEg532qUdbyaNnWwRzzDa3l3KgD3DyX7sOUKCmbE0RRGW
 RWAlsq4Nvt33LkfZ4ClHgBDtEvu0oFv6OpXchWtmNOWVzjNpmhpRC7MbiMlk7tS6bblO
 QHiCwkcw+mz2bblGsXbVxhrHJtDGcCu00y22HZGjQHJmR9FKdOlEBT6W1KA1FIIqDePl
 CCnWBJT8KJ5aXirOHmO8BW1/Xp3zUkIpeF811lZY/lL1w/Iouo7DohB3Hm2L8S5ffskw
 77Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715708578; x=1716313378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/zg7uO0Rw5DQZHLZd3hROnnvwozpRBqkVuZQLTUMEUA=;
 b=HOzAyf1hA48D371iXTHxYXy6gZ7HZQPeK4qJFW1oeTuvwzdn4KrRswS1joBp/PW0UN
 BTB5cy1cQgCCUyuTAnd8d2AKPw+8ezPrIDxG67DNiqzAKTXvRetYYD89068AxvNLK/fy
 qpbYAkxWbhBVGFl4jKUBSSoTWFTdnYrhuWPYVk99PQw+IaZcd1j2D37W1FaaZRbDFUxI
 1VPtD/+zfRVM7hL5sKeK4tQmYZsNk79P411jLHZqyRopfCY3vjcZSesj7UikNdli/8te
 E7hD1AM7aCDbLUumxt6wPgEVHjfq7R1C9PUzip89puLJZmrF0W5N4mlsc80Chz5qyGxU
 eIAQ==
X-Gm-Message-State: AOJu0YwOkA2KXQ6fK3lK5cjamoowZjiqd0uXXNCLj1Q8GND4Pcp7xWll
 z/sUsleehViNJ5+szGE9vluoMp7NKJPvJcb0HXUuczU5go7xVOkl8uOCvxToe7c=
X-Google-Smtp-Source: AGHT+IH6A1HB7vCDJy26wwBz7znP4dC4mU2BgQrIWTo2niU1hr2ScFs51bzHxpOfkjjdOWQ+wzB79Q==
X-Received: by 2002:ac2:4a84:0:b0:51d:9aa7:23e with SMTP id
 2adb3069b0e04-52210475801mr10982112e87.65.1715708578415; 
 Tue, 14 May 2024 10:42:58 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b0125bsm755843566b.143.2024.05.14.10.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 10:42:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 66CF15FA1C;
 Tue, 14 May 2024 18:42:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 05/11] plugins: add new inline op STORE_U64
Date: Tue, 14 May 2024 18:42:47 +0100
Message-Id: <20240514174253.694591-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240514174253.694591-1-alex.bennee@linaro.org>
References: <20240514174253.694591-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This new operation can store an immediate u64 value to a given
scoreboard.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240502211522.346467-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/plugin.h      |  1 +
 include/qemu/qemu-plugin.h |  4 ++--
 accel/tcg/plugin-gen.c     | 13 +++++++++++++
 plugins/core.c             |  6 ++++++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 93da98b76c..6c21a30105 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -70,6 +70,7 @@ enum plugin_dyn_cb_type {
     PLUGIN_CB_REGULAR,
     PLUGIN_CB_MEM_REGULAR,
     PLUGIN_CB_INLINE_ADD_U64,
+    PLUGIN_CB_INLINE_STORE_U64,
 };
 
 /*
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 4fc6c3739b..c5cac897a0 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -305,12 +305,12 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
  * enum qemu_plugin_op - describes an inline op
  *
  * @QEMU_PLUGIN_INLINE_ADD_U64: add an immediate value uint64_t
- *
- * Note: currently only a single inline op is supported.
+ * @QEMU_PLUGIN_INLINE_STORE_U64: store an immediate value uint64_t
  */
 
 enum qemu_plugin_op {
     QEMU_PLUGIN_INLINE_ADD_U64,
+    QEMU_PLUGIN_INLINE_STORE_U64,
 };
 
 /**
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 97868781fe..88976289eb 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -145,6 +145,16 @@ static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
     tcg_temp_free_ptr(ptr);
 }
 
+static void gen_inline_store_u64_cb(struct qemu_plugin_dyn_cb *cb)
+{
+    TCGv_ptr ptr = gen_plugin_u64_ptr(cb->inline_insn.entry);
+    TCGv_i64 val = tcg_constant_i64(cb->inline_insn.imm);
+
+    tcg_gen_st_i64(val, ptr, 0);
+
+    tcg_temp_free_ptr(ptr);
+}
+
 static void gen_mem_cb(struct qemu_plugin_dyn_cb *cb,
                        qemu_plugin_meminfo_t meminfo, TCGv_i64 addr)
 {
@@ -170,6 +180,9 @@ static void inject_cb(struct qemu_plugin_dyn_cb *cb)
     case PLUGIN_CB_INLINE_ADD_U64:
         gen_inline_add_u64_cb(cb);
         break;
+    case PLUGIN_CB_INLINE_STORE_U64:
+        gen_inline_store_u64_cb(cb);
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/plugins/core.c b/plugins/core.c
index 59771eda8f..848d482fc4 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -321,6 +321,8 @@ static enum plugin_dyn_cb_type op_to_cb_type(enum qemu_plugin_op op)
     switch (op) {
     case QEMU_PLUGIN_INLINE_ADD_U64:
         return PLUGIN_CB_INLINE_ADD_U64;
+    case QEMU_PLUGIN_INLINE_STORE_U64:
+        return PLUGIN_CB_INLINE_STORE_U64;
     default:
         g_assert_not_reached();
     }
@@ -535,6 +537,9 @@ void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
     case QEMU_PLUGIN_INLINE_ADD_U64:
         *val += cb->inline_insn.imm;
         break;
+    case QEMU_PLUGIN_INLINE_STORE_U64:
+        *val = cb->inline_insn.imm;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -562,6 +567,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                                    vaddr, cb->userp);
             break;
         case PLUGIN_CB_INLINE_ADD_U64:
+        case PLUGIN_CB_INLINE_STORE_U64:
             exec_inline_op(cb, cpu->cpu_index);
             break;
         default:
-- 
2.39.2


