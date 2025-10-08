Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF878CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6c9o-0004A7-U9; Wed, 08 Oct 2025 17:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9m-00049R-Pv
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:10 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c95-0006eV-UA
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:10 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3304dd2f119so294997a91.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960583; x=1760565383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNEq7tf22h55P79weG8h1uGDuCjZ7MVsDsPwVEVDLf8=;
 b=hujiBAkp0I72H0T77fDmgHpVDYvgoAr7zs/1z41bx6f5WUtGIwmlTK1gC4RPpWXrLC
 fQDwIL8YgvMrFVnELnP5pOBQTc4FfS7RONs+/Bp+oYCrrbE3qsZ630faL+xnrlplukJ4
 c8ucHvnOEjopewmkRkxaTxcj3OgEQA0Jf54xRc4NIHc+xoh5k5n7QVf+l5FoTdrl/sfV
 XHRdqzlWFzeHs8OOHQWRZWfYUb++tUNWO4Ggaza1U5ELQ+1pHMVRzNaKL4dpJZE+cUot
 LeBRii9pB8TN+cg1zDZF2kiLD89hl5BvlVR8UDb7zbk4I+0IlsRouXEyeICw2ZRZvJvp
 F7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960583; x=1760565383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNEq7tf22h55P79weG8h1uGDuCjZ7MVsDsPwVEVDLf8=;
 b=Sk+vTGJfJC0d6ZdhhZBjYahxWKxPVUSlT3Jxh6ZCpCQM7wyXZ5cPBk5HOBoU2+ek/e
 +1qHwI1WILWkXXpLPlfMZhBEA/WezXAujh+UK5DMw4s7jJ7sJGuH2D7jzrDLri2juspf
 zSIAQAKeBVVZF6WgUijryTMWKqm1lVIhCOmuM9ZXTUVTVXYF5gHEen8UuRj8LuMboClN
 /DHTHtsR4MIAUJtAwlWTUsV+l/WVlbO+qFR7JrXt453SCSzAkP29AbNnFO6dxWgFlg6d
 21Bepq1KVMkX+TJWoBmLS1t4hVV3WXMuE03TCUS5rWr/ODDOfGeJSQcZFqXGZyUoocAf
 7jGg==
X-Gm-Message-State: AOJu0YykmLpObbc3dDPuNZMvsRy6Mly/jwJl2QOq4yx/oIWsv2Lxn108
 wiWAOfi7tlNyF9mYPNnteyP8OcRGvY9szjTovQ3+RKOM429+ubCrn430bL3hmJs+kf4B6GLJHB1
 /hw+ikgI=
X-Gm-Gg: ASbGncvtK3DscvYgGXlLPw871OL4k6LYY0rqTzlhav3y48WlPGzEfs7aPOMovLAMcR+
 rbbfi72p4swT5xcKxlQbZfMOn/htXtXRs5PwDjYZC0UplMsWR9aMK1y1lPPHen0S9/pQC09AhXM
 vS6l91gS4rN+nFoZ+sKxjK0cRNPjDT7paMQARwgiu6pGId5oLMOiBUSd0dfBs+vkDXwA6HsTrXb
 UTEKuMu4M8kQiWbizjO7IYGeCVJydqu18yV9rw9DnRChTK2eKOzaO1OLmHH66xYVeIyl5Mfjd+Q
 MHv7ZABmnWduijslnndp+/QVW/Tf8KIHNkhPziGQU6RPVp6ayDC44jNv6mdIUwNjVNxMP6SYx7D
 uz0jnqcxBy8EZDLqe0vQzP7QU7iTEfjaGZtUjUGxkwyKe0d/wpMDqBHqGhuF89JY4koY=
X-Google-Smtp-Source: AGHT+IHnSxXlu4kFisQfT2vMCInjCaTQ93M3a7q+wK22gggnRpU71GiqBfCx1Y9IbzvqLAkhaqyhTg==
X-Received: by 2002:a17:902:f612:b0:269:8072:5be7 with SMTP id
 d9443c01a7336-29027303931mr68312465ad.56.1759960582854; 
 Wed, 08 Oct 2025 14:56:22 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 12/73] target/arm: Implement dirtybit check for PIE
Date: Wed,  8 Oct 2025 14:55:12 -0700
Message-ID: <20251008215613.300150-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Both S1PIE and S2PIE have a bit to make software tracking
of dirty pages easier.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      |  1 +
 target/arm/ptw.c            | 16 ++++++++++++++++
 target/arm/tcg/tlb_helper.c | 12 +++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index b59650959e..69eb1df617 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -752,6 +752,7 @@ struct ARMMMUFaultInfo {
     bool s1ptw;
     bool s1ns;
     bool ea;
+    bool dirtybit;  /* FEAT_S1PIE, FEAT_S2PIE */
 };
 
 /**
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2e026a7c59..21540a1ec3 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2343,6 +2343,22 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         goto do_fault;
     }
 
+    /* S1PIE and S2PIE both have a bit for software dirty page tracking. */
+    if (access_type == MMU_DATA_STORE && param.pie) {
+        /*
+         * For S1PIE, bit 7 is nDirty and both HA and HD are checked.
+         * For S2PIE, bit 7 is Dirty and only HD is checked.
+         */
+        bool bit7 = extract64(attrs, 7, 1);
+        if (regime_is_stage2(mmu_idx)
+            ? !bit7 && !param.hd
+            : bit7 && !(param.ha && param.hd)) {
+            fi->type = ARMFault_Permission;
+            fi->dirtybit = true;
+            goto do_fault;
+        }
+    }
+
     /* If FEAT_HAFDBS has made changes, update the PTE. */
     if (new_descriptor != descriptor) {
         new_descriptor = arm_casq_ptw(env, descriptor, new_descriptor, ptw, fi);
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 23c72a99f5..ae2acd6727 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -24,13 +24,13 @@ bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
     return regime_using_lpae_format(env, mmu_idx);
 }
 
-static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
+static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
                                             ARMMMUFaultInfo *fi,
                                             unsigned int target_el,
                                             bool same_el, bool is_write,
                                             int fsc)
 {
-    uint32_t syn;
+    uint64_t syn;
 
     /*
      * ISV is only set for stage-2 data aborts routed to EL2 and
@@ -75,6 +75,10 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
         /* Merge the runtime syndrome with the template syndrome.  */
         syn |= template_syn;
     }
+
+    /* Form ISS2 at the top of the syndrome. */
+    syn |= (uint64_t)fi->dirtybit << 37;
+
     return syn;
 }
 
@@ -176,7 +180,9 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
     int target_el = exception_target_el(env);
     int current_el = arm_current_el(env);
     bool same_el;
-    uint32_t syn, exc, fsr, fsc;
+    uint32_t exc, fsr, fsc;
+    uint64_t syn;
+
     /*
      * We know this must be a data or insn abort, and that
      * env->exception.syndrome contains the template syndrome set
-- 
2.43.0


