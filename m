Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BEB6CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNvH-0004Em-Lo; Sat, 30 Aug 2025 11:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEMP-00065y-Js
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:45 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEMN-0004Dw-7h
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:45 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b482fd89b0eso2394029a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532562; x=1757137362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkmMxKsmWKq3Irpj/N+FmNwynILAG2P025dwAc8eVWU=;
 b=WhFUgx8YQDOBOWfJu5wk1/PNW2LOSgRgnybXmRLe3s2X3Bk7tGPSLSbNAl9hTrThUl
 ZPiCrG2xLSKxJ/NyCZOYpaiXOL2GRp7ndcFRZ8n1giTbmDwSVZ/rOKyzar26Vq3+s6L4
 rbIq19uB9lALj0HvJayXd7ZZFrE06ceirkWBSzzn8W1fPa/4RKro4ciP6mRrW+g/6sNH
 TQ6WWRCQ5OMZZnf1NsiRvEA9dM1J1Mfo58dPP4QniZxr6wjG40LBZVKrRz3SJJaL3ktc
 a7MoAkbqpc8Rxc5SNSKm2YZrkes+vXA0LfIOF5o4Cn/5CCsoT73jBfXEgmZ0fqU+nz5l
 XlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532562; x=1757137362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RkmMxKsmWKq3Irpj/N+FmNwynILAG2P025dwAc8eVWU=;
 b=Kb9wOv4OtIll8TROBPObmo4BfoY8p0jX8R6e3x0ODd2SEeZWsT4pkASGXMs1Fs2wJj
 UMV4LwVCQEDYKvuI9ZRzjOkzJaLr7q+B0sbBcas2EfuA/lnYvH/IkIBGy2lYsusN7Va3
 XhoAKChAFv+HPPwQDmPILK1TUyWgSEjdAqiHaB/Hk3AQOvnt3UNqO4gKQEQE3TpE9usD
 OsdtdFAvV9t6mBlK49OM2UyCHhY3WuCQS2tO2AGWJpkMGQ7wewFbS7QGCKN+hrMQ+mlM
 kxzo/Bj51ufUYWFvkNIzsvGx5yZNsg1xZih1+53I/gg+5QUPu9Bm60OgIiIY3FqPgTb0
 V/Ww==
X-Gm-Message-State: AOJu0YwxQvRU0Ne8nBNvp8PAQjqyq/3tlR3e7EC5Ye48dM20W6aqfNqC
 rsEJinXcFQWIBv3LTJhKmqYLbPSr+XicIe9J21+HnK/niqwEqg0d8jYW79bMOnwtaXWnKqV8PfB
 cjRzOfk4=
X-Gm-Gg: ASbGnctwUR+uE/qW8TEVTLd2gwnAX12vF/3NJPtnlPOjP7LKwP+Tn/tBqoeceWDswcl
 bhGShsuqGG08N3oEcGOWltFJF58dOq3haunvYwM7hPih+2Yr3U5C3yB1g7tExN1Skv5zt83jSmt
 NVlTIKY9zxptBJRgMy7oERptU1p0T6DBpPthOswLnEPh1HFphCxSzx+U6Xew7Zg2cRUHDn1ElsV
 b31xBHmryg58zLg88U5L0IsVvpMhgWijy5eJFWpD/3UVD99KIv6adT57nXNWV3Q6lQWkbZXGv4w
 hkz683/jASYZQy2WwyIX7xz4dfwllqy1kdvaPHjwU01s6XJ9Smj84vXOOUGqkrF9ck32uoq8lDp
 1SxJ7MhnFzn29UqmI8M4Mf9H3yx6JVzBYward19J72q8viJxDKK2shGv6c3nW3fgl+a1zG8I=
X-Google-Smtp-Source: AGHT+IE2cN3MXmVubhw779QDlzhGx7t0hD/HV2rzToKMUcyZF206nYAkv7kYO3g8Uu48sJ4Dzhw4Dg==
X-Received: by 2002:a05:6a21:32a0:b0:243:b125:16c5 with SMTP id
 adf61e73a8af0-243d6f581f5mr1542218637.49.1756532561862; 
 Fri, 29 Aug 2025 22:42:41 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:42:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 24/84] target/arm: Implement dirtybit check for PIE
Date: Sat, 30 Aug 2025 15:40:28 +1000
Message-ID: <20250830054128.448363-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
index 1d60a4ff7d..889669c67c 100644
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
index 7ddae90f69..2b753b1319 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2306,6 +2306,22 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
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


