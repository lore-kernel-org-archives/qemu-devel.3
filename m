Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF54CD1296
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWA8-00021m-Mp; Thu, 04 Apr 2024 19:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWA4-0001zi-IG
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:24 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWA1-0007iP-PQ
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:23 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so2065555a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712271980; x=1712876780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58RO24HbGZXsQzLPlVmO4lYrlwiy6xL20O90riCGy0c=;
 b=F/YGyKYMdw9yo7OEs9Dl37IM3w7+Uy2y5Mwmg0ili8ueYCz/CvHvtAo1zDBCnj7KRS
 cQTyOIUDYaPt+NeRTjxypz1ugvwOlBxbC3Si/n3oCQeYjBgh/azXTTMjW4pRFqvNpGEl
 JRTGarEhVptlve1iv3Vzx4uwgnS5SYmaS5Vl4hlMn+0i/h8Y3/QMfV38JMHRbVJh/kyS
 eXvyJHLZRq9oO9XHQb4VDOHNdGzD3lhI2UOa/stRdiDYj0weJalum+ZtHC62cC64tOeA
 ow+AfWWMMMhwlUSK6ihZ/Rr3EaW6/BZqWEEI4rxdilXp0aSFElpZRJn0VLNU9Z70vKTA
 1lkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712271980; x=1712876780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=58RO24HbGZXsQzLPlVmO4lYrlwiy6xL20O90riCGy0c=;
 b=H+GHHUJEKkRw9itBfc9BFFrR2i8zQvspTh8uIG6VM8qmS4P7EVIDQwb1aLC2ZhltKV
 rScXquF/l8Ddotuoh/hdu1ZYTzvPxGJRI7FuCujtg3b7TuIVQAuIVTYClr4GKsZQkPr4
 TMktZiv68hGM+zC+lAQdsvf4e0PE1xXpQudXe/z4muAahZYAr8ybZcygrpCwp9PO7Qb8
 XYxlgStQeSSMM6f45M5FqM1lQsllu4gV4sR4jqjU2r+R08q1eSWcjm8KvxWC+6+vhhP6
 CuWkgcZSA9XmlQJRbrC+jw3HdizYDaUHp63fUcaC973r43srWg0liQFbubuHDlQFAACO
 jeTg==
X-Gm-Message-State: AOJu0Yys49Unq1BIZNx7fErGaUNdQj9TJNRb93+KwZQLpOefh5RyT2l/
 zBVOmNcfDxbYbjh9juPbtJ+aqXDMf8PgB2Coqb19nz+jX5FEourBCauICRVBaP0yCaCCG6Dbm7T
 F
X-Google-Smtp-Source: AGHT+IGl/QIsy2WfO7ck/Sl1Kx4NUDfGjNEJALjfh8F/4tcg/AB97XjMM69ZnlYZBSXr8jtIb73VFA==
X-Received: by 2002:a17:90b:305:b0:2a2:b732:42f1 with SMTP id
 ay5-20020a17090b030500b002a2b73242f1mr1141568pjb.8.1712271980423; 
 Thu, 04 Apr 2024 16:06:20 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 05/21] plugins: Move function pointer in qemu_plugin_dyn_cb
Date: Thu,  4 Apr 2024 13:05:55 -1000
Message-Id: <20240404230611.21231-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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


