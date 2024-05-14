Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAF8C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 17:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6wBq-00050D-Cn; Tue, 14 May 2024 13:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wBP-0004pv-IE
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:29 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6wB4-0004tI-UZ
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:43:18 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a59a5f81af4so53742666b.3
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715708577; x=1716313377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zexNE7+uW9d8NGaakrN2CoV9FHrOXshpTBEtpvAtcDk=;
 b=k2TCqUdLVAnTNyysHznG7uoK+s7XR0QBP1CMF/bv9CDfQGR5Eqe1YNC5tZeq12Ruqf
 1a3vOmnR2KPBh7HszGWEQVLGDmq3zIxHw1CE1Zq9FafANmxWm8f2jswbXXmaa5hWGXzu
 QfEA1x5ecaWk561lqdDSC879MUI4F3CPSon6C+aiAjL9jTxRN830NKuyjYPc3jrbnrzU
 xCTkGhmfMqUwXM+slJqX2KyvP+AA/7eIBRQ9Is32/f+7xsJhz4NCgYWuGGMfNc0Id7+u
 PfGIZB96NwocyoCNLCgdaVyjePGBPDrczAuO3hiUgxqJ3MDAUCdY4Y99n+l+UzYCGJGM
 xKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715708577; x=1716313377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zexNE7+uW9d8NGaakrN2CoV9FHrOXshpTBEtpvAtcDk=;
 b=QIgyOgcqqs+x0/+ZA633KdsL16IxgV97byE9BnA52whp8WQwIfEjI2B/rJ1VYif1B9
 0yMI/yRv603+Dn53zjnoBy0qHqfsgyg65en8XVjJ1JqROp0MaXqqjHLCBWFFYkLhJJYx
 /jNIhjtpRSvun9tNgHOiflq+xwEpuOY2EkDRVLV1OEw5MnbSyJtnGpP24NXXyfyO36VG
 HEon+6Y+bI+O7Cyyn9cA3sQGaTRVwMk+zAlPt2fvORD5R896dBtp7xYCLroA1xqCx5UV
 c6CVpEFiyYMXiGqGxIr38FeoUfhDj9NJ08Ut+SU67o/H4EiERvlU37077sz6nUvB62D8
 b5ew==
X-Gm-Message-State: AOJu0YwYMtSHBwxZxNstmw16ys9Z74Z1yNgzJ3hud45n5OsV5XjWXbPq
 S0M/pP1Gj4EjUqlTMlJUy0e7wZyJJmsWGLGWCPauM7+4fdcqVKTSWNxF612aG/8=
X-Google-Smtp-Source: AGHT+IFxWfN6Qqh8V1byiOLu5h+xzlwYzTWSLVfAdj6WVVcsOXPeyCPRaCknR7DqU6wEMfMpTE76mw==
X-Received: by 2002:a17:906:6bd8:b0:a59:a977:a157 with SMTP id
 a640c23a62f3a-a5a2d6a38f6mr991890066b.73.1715708576681; 
 Tue, 14 May 2024 10:42:56 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a51eea36dsm493937566b.58.2024.05.14.10.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 10:42:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 373635FA1A;
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
Subject: [PATCH 03/11] plugins: prepare introduction of new inline ops
Date: Tue, 14 May 2024 18:42:45 +0100
Message-Id: <20240514174253.694591-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240514174253.694591-1-alex.bennee@linaro.org>
References: <20240514174253.694591-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Until now, only add_u64 was available, and all functions assumed this or
were named uniquely.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240502211522.346467-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/plugin.h  |  2 +-
 accel/tcg/plugin-gen.c |  6 +++---
 plugins/core.c         | 14 ++++++++++++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index b535bfd5de..93da98b76c 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -69,7 +69,7 @@ union qemu_plugin_cb_sig {
 enum plugin_dyn_cb_type {
     PLUGIN_CB_REGULAR,
     PLUGIN_CB_MEM_REGULAR,
-    PLUGIN_CB_INLINE,
+    PLUGIN_CB_INLINE_ADD_U64,
 };
 
 /*
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 49f5d1c2e4..4069d51daf 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -113,7 +113,7 @@ static void gen_udata_cb(struct qemu_plugin_dyn_cb *cb)
     tcg_temp_free_i32(cpu_index);
 }
 
-static void gen_inline_cb(struct qemu_plugin_dyn_cb *cb)
+static void gen_inline_add_u64_cb(struct qemu_plugin_dyn_cb *cb)
 {
     GArray *arr = cb->inline_insn.entry.score->data;
     size_t offset = cb->inline_insn.entry.offset;
@@ -158,8 +158,8 @@ static void inject_cb(struct qemu_plugin_dyn_cb *cb)
     case PLUGIN_CB_REGULAR:
         gen_udata_cb(cb);
         break;
-    case PLUGIN_CB_INLINE:
-        gen_inline_cb(cb);
+    case PLUGIN_CB_INLINE_ADD_U64:
+        gen_inline_add_u64_cb(cb);
         break;
     default:
         g_assert_not_reached();
diff --git a/plugins/core.c b/plugins/core.c
index 1e58a57bf1..59771eda8f 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -316,6 +316,16 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
     return &g_array_index(cbs, struct qemu_plugin_dyn_cb, cbs->len - 1);
 }
 
+static enum plugin_dyn_cb_type op_to_cb_type(enum qemu_plugin_op op)
+{
+    switch (op) {
+    case QEMU_PLUGIN_INLINE_ADD_U64:
+        return PLUGIN_CB_INLINE_ADD_U64;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 void plugin_register_inline_op_on_entry(GArray **arr,
                                         enum qemu_plugin_mem_rw rw,
                                         enum qemu_plugin_op op,
@@ -326,7 +336,7 @@ void plugin_register_inline_op_on_entry(GArray **arr,
 
     dyn_cb = plugin_get_dyn_cb(arr);
     dyn_cb->userp = NULL;
-    dyn_cb->type = PLUGIN_CB_INLINE;
+    dyn_cb->type = op_to_cb_type(op);
     dyn_cb->rw = rw;
     dyn_cb->inline_insn.entry = entry;
     dyn_cb->inline_insn.op = op;
@@ -551,7 +561,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
             cb->regular.f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
                                    vaddr, cb->userp);
             break;
-        case PLUGIN_CB_INLINE:
+        case PLUGIN_CB_INLINE_ADD_U64:
             exec_inline_op(cb, cpu->cpu_index);
             break;
         default:
-- 
2.39.2


