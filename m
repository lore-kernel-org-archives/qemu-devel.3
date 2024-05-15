Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC09C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 20:24:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7LAH-0001Bm-B5; Wed, 15 May 2024 16:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LA6-00012H-A0
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:42 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LA3-0004Eu-PJ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:42 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a5a1054cf61so263046666b.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715804618; x=1716409418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EdBn9/w6xK9M1sFB0icOMFme4YLRx+rfsRWreCCtfys=;
 b=rYPeUeMxwciamNNMSym5eY/B5Xg2L+jol5qaL+A5LqmCNwnQrbEreoJTk1rKmkJ3Y7
 W2aLPf7SO1utOS/absAcVK0+lTZq142mzDjuzxY107fPEI937UscLR2/pCJeZdafDjux
 vdY//boFVSS2LgKxsI5b+LUcGFRMDt9txvoart5ht1733La+AMJFGdfVwoV7rvzPpssx
 eClRRuDwkSeZfK7fo8wsy8kp7/nBuM0eBcFt+xxRBuQZ7c6El+RJzXKCS4DwE2DdRLII
 s+7AKux9+/EoxcjfVVfs7XTmT5mphhBXJFg8KRVkFjyZhVUihT/nsbwGp0kijc5hsnx2
 yciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715804618; x=1716409418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EdBn9/w6xK9M1sFB0icOMFme4YLRx+rfsRWreCCtfys=;
 b=oy5IPAPAejsE5WmG7OMObdHVCOeCgB0aLQm+TiwiV/Q+FovM65M4rHrw0k+T1LoyqZ
 3bPIWoO+QBGAw8IX6Vg9C3dmHl0bbbQm2Y8cQWlR/VYgXMH5uwWmPrm9T610s+/NLkIB
 vaqUNCtuL7K7H5LgsOMdT9pQbxZ6ZEywsWKKR03TBVaFIxhL795UOVrNgIcAxZMjgbVC
 ZWmTqGNHp8rOjLKmCy7LZgaQPTpubs89P5YtsakvVYSeN1NPJeLQAFOdjW45G5ThBTfK
 3IQI4xYu96lqBKwhR6k2gPt4ch+3HJAr2IxQ3p1oieMUQtl+TUrhQ/9zV4K5O1Ig0LYW
 Zc/w==
X-Gm-Message-State: AOJu0YwIfogXjQQrTupB7HzNsiscD9xzHSKpWUfYmuxRoaR3UNafs6Gt
 4B6Uc/YauSIVnevJdWIceF9MulPiMw+y8QLrPJwNzp5eOS5ylB5C8hxXVn57fNk=
X-Google-Smtp-Source: AGHT+IGradQMdTOddCYAY8LMmZsRloihTEg16qhbzyq67YlVTktVB8M48hdFGts8h+AvBSX44I2c8A==
X-Received: by 2002:a17:906:6043:b0:a59:d2ac:3856 with SMTP id
 a640c23a62f3a-a5a2d572c19mr1765463066b.22.1715804617940; 
 Wed, 15 May 2024 13:23:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781cfb2sm894427766b.24.2024.05.15.13.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 13:23:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1D2515FA1C;
 Wed, 15 May 2024 21:23:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 05/11] plugins: add new inline op STORE_U64
Date: Wed, 15 May 2024 21:23:28 +0100
Message-Id: <20240515202334.710324-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515202334.710324-1-alex.bennee@linaro.org>
References: <20240515202334.710324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240514174253.694591-6-alex.bennee@linaro.org>

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


