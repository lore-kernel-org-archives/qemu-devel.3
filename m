Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B16CC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 12:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhTlo-000216-Sp; Tue, 05 Mar 2024 07:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTlC-0000VJ-7t
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:19:07 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhTkx-0003GT-28
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 07:19:04 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412e66bc492so11906055e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 04:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709641129; x=1710245929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTlUHz/zzEA+4dY7VR66jAMvQofhd2ytbNOVYam0lP4=;
 b=seuoJ+fveKWfvkRyKiL0wojf14LWb8M/g3lbbt/immUTRNWqSbKBR6aOFak6Zj1ZmD
 i6Bs+Lg8/fjwEW+qQ+CVvDrpY8MWu3pFsU81HXcGRJZOQ0+Z4fZaLKmgzeAjWzz3gQJ/
 yuJrH3t3THpbGoe/egKXjaYClMpcDzIRyfg0xPpMAybjUduXwrbvTIy3JzHBZveRdFH3
 upha149wxeqItubtjHEE1fYS4XjSdSorPN6gewJL2C5Km2pqBgS3aqRuauFs4M1w7K2B
 GlZPEiCdmHzCOU4cTrNeVBuTEZzL/qML05BM965zI1z8G9smP9rLb/tb/v5NqJ9U0Hdd
 7r8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709641129; x=1710245929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTlUHz/zzEA+4dY7VR66jAMvQofhd2ytbNOVYam0lP4=;
 b=q2VTOq36qkN6jNrXa6EzWClqiK8hyJxTMp4m/MJQjZImbwrF4MMqhIC9/mBL0+S3R+
 wHTQZR2vIOCXKd/rdDSjTjRTB3LWDFRTB+JB2FYcKQJ/9M8Kvj8rG878mxokCH8GKGpk
 lxlnabDaY9Q5qZmoJGG3VdMXtTk5glLBm0IK4kH2gvn3gsUB19eh6RuqCo+8P3zgn0yT
 kwcLW2Nu0jcUk6gFsgq77VYJP1n0fPzwQBWdn80QbYrAzCnog6oPxkjg+HxvafeiYd5s
 mkiS2bSpk7u5+nxNYubIgMES7iCjrGDVKVF1aWA8Qe1Fk1YcpP6oRIL+gajhiQi0bJXa
 1CdA==
X-Gm-Message-State: AOJu0YxaW0Qwrp5XGy6Xlwgfu1ticsafVk8VciHi0Pgjz79wu05vzIlJ
 9O+auPUDexv/aBMafeOtnqIU4nb3Wmnfi5w6pagrsaDK+v9tOcRCI4kYPV/CpSA=
X-Google-Smtp-Source: AGHT+IGPLa83unvzaHEFRsDi8vlTQkhtloNhPgsJ1xAFKV+ZZDRwNnlPHFgxZrTxfM9gf1RWrICDzQ==
X-Received: by 2002:a05:600c:c1a:b0:412:b8ce:fa32 with SMTP id
 fm26-20020a05600c0c1a00b00412b8cefa32mr9113006wmb.11.1709641128899; 
 Tue, 05 Mar 2024 04:18:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ck4-20020a5d5e84000000b0033e431950c5sm1119001wrb.97.2024.03.05.04.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 04:18:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C954F5F9FA;
 Tue,  5 Mar 2024 12:10:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Warner Losh <imp@bsdimp.com>, qemu-riscv@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 25/29] plugins: cleanup codepath for previous inline operation
Date: Tue,  5 Mar 2024 12:10:01 +0000
Message-Id: <20240305121005.3528075-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305121005.3528075-1-alex.bennee@linaro.org>
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240304130036.124418-13-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/plugin.h       |  5 -----
 accel/tcg/plugin-gen.c | 13 ++++---------
 plugins/core.c         | 29 ++++-------------------------
 3 files changed, 8 insertions(+), 39 deletions(-)

diff --git a/plugins/plugin.h b/plugins/plugin.h
index f6fa10a0f56..7c34f23cfcb 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -68,11 +68,6 @@ struct qemu_plugin_ctx {
 
 struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id);
 
-void plugin_register_inline_op(GArray **arr,
-                               enum qemu_plugin_mem_rw rw,
-                               enum qemu_plugin_op op, void *ptr,
-                               uint64_t imm);
-
 void plugin_register_inline_op_on_entry(GArray **arr,
                                         enum qemu_plugin_mem_rw rw,
                                         enum qemu_plugin_op op,
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 47e05ec6347..8028786c7bb 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -440,15 +440,10 @@ static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
                                TCGOp *begin_op, TCGOp *op,
                                int *unused)
 {
-    char *ptr = cb->userp;
-    size_t elem_size = 0;
-    size_t offset = 0;
-    if (!ptr) {
-        /* use inline entry */
-        ptr = cb->inline_insn.entry.score->data->data;
-        elem_size = g_array_get_element_size(cb->inline_insn.entry.score->data);
-        offset = cb->inline_insn.entry.offset;
-    }
+    char *ptr = cb->inline_insn.entry.score->data->data;
+    size_t elem_size = g_array_get_element_size(
+        cb->inline_insn.entry.score->data);
+    size_t offset = cb->inline_insn.entry.offset;
 
     op = copy_ld_i32(&begin_op, op);
     op = copy_mul_i32(&begin_op, op, elem_size);
diff --git a/plugins/core.c b/plugins/core.c
index 7852590da88..11ca20e6267 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -316,22 +316,6 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
     return &g_array_index(cbs, struct qemu_plugin_dyn_cb, cbs->len - 1);
 }
 
-void plugin_register_inline_op(GArray **arr,
-                               enum qemu_plugin_mem_rw rw,
-                               enum qemu_plugin_op op,
-                               void *ptr,
-                               uint64_t imm)
-{
-    struct qemu_plugin_dyn_cb *dyn_cb;
-
-    dyn_cb = plugin_get_dyn_cb(arr);
-    dyn_cb->userp = ptr;
-    dyn_cb->type = PLUGIN_CB_INLINE;
-    dyn_cb->rw = rw;
-    dyn_cb->inline_insn.op = op;
-    dyn_cb->inline_insn.imm = imm;
-}
-
 void plugin_register_inline_op_on_entry(GArray **arr,
                                         enum qemu_plugin_mem_rw rw,
                                         enum qemu_plugin_op op,
@@ -494,15 +478,10 @@ void qemu_plugin_flush_cb(void)
 
 void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
 {
-    char *ptr = cb->userp;
-    size_t elem_size = 0;
-    size_t offset = 0;
-    if (!ptr) {
-        /* use inline entry */
-        ptr = cb->inline_insn.entry.score->data->data;
-        elem_size = g_array_get_element_size(cb->inline_insn.entry.score->data);
-        offset = cb->inline_insn.entry.offset;
-    }
+    char *ptr = cb->inline_insn.entry.score->data->data;
+    size_t elem_size = g_array_get_element_size(
+        cb->inline_insn.entry.score->data);
+    size_t offset = cb->inline_insn.entry.offset;
     uint64_t *val = (uint64_t *)(ptr + offset + cpu_index * elem_size);
 
     switch (cb->inline_insn.op) {
-- 
2.39.2


