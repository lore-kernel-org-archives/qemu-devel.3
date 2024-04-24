Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E17AC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldL-0003hM-Tm; Wed, 24 Apr 2024 19:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldK-0003gg-Bl
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:34 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldI-0002ce-Lw
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:34 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ee13f19e7eso425352b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999751; x=1714604551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58RO24HbGZXsQzLPlVmO4lYrlwiy6xL20O90riCGy0c=;
 b=Oe1FTZeIGB2MNV9MpJ3CftUfJV+nVNz71bZD68BGH1TVCLhfQEFnTN8FongbC1A7aG
 lgjNxjJJEEIP5UyUOBbTwp4mrD4NfN5tBJKrCTIr87aHED2sLZNCdvRf16oJzXBDYDm+
 D5BtNTIP33Cu8yY2heCLTkblD1+K86s0EdD9SCwuTtSvDgngVnu080bUC7N1VEMRZhv+
 4EQDcQSJp+YmaPu+yGY1e3Qo2/iGZbnellOiSKEg/n5TdHPmQC4dgHVYvnTyh8w0BfyO
 f05j1Mn/f6gBt0ougJs9nMEv0JQH0VhLSPkhU8aatfXZUXdX7o0w3V3yPzEU6vBq4cGL
 gM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999751; x=1714604551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=58RO24HbGZXsQzLPlVmO4lYrlwiy6xL20O90riCGy0c=;
 b=t+hWH6c7wNDjzn11ctEK2atbMxp3f0XTSOzdgcwJ59EZpMrhlFbN01ufqnmU2hCXai
 G/e2GkwrVcBmoBosUJq443q790aKj8QyWwjA67kGuffZZVwjFRFKTj09JRaYCPUUN2Ls
 tv/7oSzdv9zJPai+YUkn4wLeDfEIcs6MIYabaQGlQjRqBABRjE12hd6zhbf8r3iK1W32
 D165dnppYm38i42pd2Wjb1rDFS5TdG9BfdAdKIcqMK/Izr4H6LXQz0qQ+F4rwBTCcY4M
 QEq46GKxBcwIWXd2o2KTv5Tp3pbqOtwk+Eg3+AEwtqdE63QUWkO/CxMjmbcrrSTGSFPY
 4iXA==
X-Gm-Message-State: AOJu0YxFAy+IG+BcuVl2H3L1Hi4mMbm6NEn28FjxjXyI2monAOHEgmhH
 mCU0tE/SdwK8iFb4ta9rDNL5irhtJFPPCzG9Ib1PFRrQZlf0sBs4amtcC3nfZNtV5+edw4myE+a
 m
X-Google-Smtp-Source: AGHT+IExGK+EfVaEOzQSS96jqVONqksRgtEsJATSaK5vXWxK1Ck//avTyjiKnzXnqiuY/jclQcZSZQ==
X-Received: by 2002:a05:6a21:2d09:b0:1a9:694b:cfbd with SMTP id
 tw9-20020a056a212d0900b001a9694bcfbdmr4639880pzb.5.1713999751196; 
 Wed, 24 Apr 2024 16:02:31 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 04/20] plugins: Move function pointer in qemu_plugin_dyn_cb
Date: Wed, 24 Apr 2024 16:02:08 -0700
Message-Id: <20240424230224.941028-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

The out-of-line function pointer is mutually exclusive
with inline expansion, so move it into the union.
Wrap the pointer in a structure named 'regular' to match
PLUGIN_CB_REGULAR.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  | 4 +++-
 accel/tcg/plugin-gen.c | 4 ++--
 plugins/core.c         | 8 ++++----
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 12a96cea2a..143262dca8 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -84,13 +84,15 @@ enum plugin_dyn_cb_subtype {
  * instance of a callback to be called upon the execution of a particular TB.
  */
 struct qemu_plugin_dyn_cb {
-    union qemu_plugin_cb_sig f;
     void *userp;
     enum plugin_dyn_cb_subtype type;
     /* @rw applies to mem callbacks only (both regular and inline) */
     enum qemu_plugin_mem_rw rw;
     /* fields specific to each dyn_cb type go here */
     union {
+        struct {
+            union qemu_plugin_cb_sig f;
+        } regular;
         struct {
             qemu_plugin_u64 entry;
             enum qemu_plugin_op op;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index cd78ef94a1..4b488943ff 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -425,7 +425,7 @@ static TCGOp *append_udata_cb(const struct qemu_plugin_dyn_cb *cb,
     }
 
     /* call */
-    op = copy_call(&begin_op, op, cb->f.vcpu_udata, cb_idx);
+    op = copy_call(&begin_op, op, cb->regular.f.vcpu_udata, cb_idx);
 
     return op;
 }
@@ -473,7 +473,7 @@ static TCGOp *append_mem_cb(const struct qemu_plugin_dyn_cb *cb,
 
     if (type == PLUGIN_GEN_CB_MEM) {
         /* call */
-        op = copy_call(&begin_op, op, cb->f.vcpu_udata, cb_idx);
+        op = copy_call(&begin_op, op, cb->regular.f.vcpu_udata, cb_idx);
     }
 
     return op;
diff --git a/plugins/core.c b/plugins/core.c
index 4487cb7c48..837c373690 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -342,7 +342,7 @@ void plugin_register_dyn_cb__udata(GArray **arr,
 
     dyn_cb->userp = udata;
     /* Note flags are discarded as unused. */
-    dyn_cb->f.vcpu_udata = cb;
+    dyn_cb->regular.f.vcpu_udata = cb;
     dyn_cb->type = PLUGIN_CB_REGULAR;
 }
 
@@ -359,7 +359,7 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
     /* Note flags are discarded as unused. */
     dyn_cb->type = PLUGIN_CB_REGULAR;
     dyn_cb->rw = rw;
-    dyn_cb->f.generic = cb;
+    dyn_cb->regular.f.vcpu_mem = cb;
 }
 
 /*
@@ -511,8 +511,8 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
         }
         switch (cb->type) {
         case PLUGIN_CB_REGULAR:
-            cb->f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
-                           vaddr, cb->userp);
+            cb->regular.f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
+                                   vaddr, cb->userp);
             break;
         case PLUGIN_CB_INLINE:
             exec_inline_op(cb, cpu->cpu_index);
-- 
2.34.1


