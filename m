Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B17C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 20:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7LAH-0001Be-Qx; Wed, 15 May 2024 16:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LA6-00012F-9C
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:42 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s7LA2-0004Ei-W8
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:23:41 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2e34e85ebf4so66723551fa.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 13:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715804616; x=1716409416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kB5gGwnuRcBvcHMtm7HRQ/5WRfkIxSeeWZ+La37eaL0=;
 b=xEm4uQzj7ZYlpsYDENuOnkMerAV51yLMLsK4bW+rN/swKvrCOxpZWWU3g72i1+PajW
 DmQ9sZgtwTl+j7eTKkM6uMp/WzOsTuw8x1ms6UESmrLiH69usWDfZSuTSaPI97NZsZRb
 DAd8MT1LDBwkO1VwXtvfeEYKqkrGz1Z2FzdxCErTk6/s7/uWYOlZNr7ky964F4c/6kun
 dnU+pQdyaLG62XiHi7kLPDn2vmYZ7yUl5k22iABQCPdjxFM1LpDfkKcjGlZQ7Zq0ucP3
 3sRJZbSxfFm9uc2n8BUQWxvDb44O05tACFAacN36tyxpqmCX9pUBiBeZ2BkcFJgUvog6
 CVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715804616; x=1716409416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kB5gGwnuRcBvcHMtm7HRQ/5WRfkIxSeeWZ+La37eaL0=;
 b=FosxHQ0ELHvDgHyVcHpCkUwwK0XCXbe14vnFLV7pMzmzjr7p8TEmtaVFhuh2WKHLEU
 wAFCaHv5htARzrX9lvqg3IwZyjLHm9kObD4F3RrioFMNTGga0udl7C2kMwbWh9hiqGjg
 RTwH99JWpUS4WdOZxj+zOtRmXNPFj2V2JF7mOYVGlQgdEEJMN7KGmoloWkGNpWK8Lr/W
 QGeV+hg5BURWkjyJqQjTJbIv30mkJPe4ph8wRh0/QDwMuFtQZbFrdmq9/0pzYd6MuHDF
 OOIJJUaC7mwS8i1hP/yZ+N3qyqOC0RXyamIuH9w0v90Nd2kU2zlbq61yghhU2YMKVDxO
 dEPQ==
X-Gm-Message-State: AOJu0Yw6bbUe6H/txacenG1LvRB3M6Yw/bHSZiUqYfrZsfUuRy2J4xMT
 H4UKrLefcChgO7PWGkWo+EIS4OMafrzlfFd6fsiUXdEveB/XfsBWR1IYpyN5Am0=
X-Google-Smtp-Source: AGHT+IFfj2GcwpaVBh6u0MZCghnC+t7dbF1yixwhNaGIO5E8KvnfoILEiV+K2bpL8uWmqn6G/Q20rw==
X-Received: by 2002:a2e:8506:0:b0:2e1:cb22:a4d with SMTP id
 38308e7fff4ca-2e52028b155mr124235551fa.36.1715804616031; 
 Wed, 15 May 2024 13:23:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-574ebdf46cesm2346787a12.37.2024.05.15.13.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 13:23:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E1F825FA1A;
 Wed, 15 May 2024 21:23:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 03/11] plugins: prepare introduction of new inline ops
Date: Wed, 15 May 2024 21:23:26 +0100
Message-Id: <20240515202334.710324-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515202334.710324-1-alex.bennee@linaro.org>
References: <20240515202334.710324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22c.google.com
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

Until now, only add_u64 was available, and all functions assumed this or
were named uniquely.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240514174253.694591-4-alex.bennee@linaro.org>

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


