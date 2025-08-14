Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB097CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXYd-0002SX-2y; Thu, 14 Aug 2025 08:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYD-0001xD-VA
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:29 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXY9-0004M0-Vs
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:25 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-b471aaa085aso315465a12.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176358; x=1755781158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TtfdJAKHkhBXVVur9KnTeJdEj0NKkUPLOFyccsCQyeU=;
 b=u6Wj8GbZjd7NG2WsqcDGmtczA2EVdZ7lKtYcglKN8Gn9xPmkUnXPT0z2T4+WDnCKYV
 qCPbcNP6Qg+e9zB1nSMwoFEWW035op+XbRhWHYmi47A+G6tFuBibkCTCejSnC2cbiCwy
 1KWlOgEKhKtlSzHtNvdTLgLdiCf+pjUEGRpHukHLI0Is8WyoFwue29GfOTs+w1bdxigh
 huU8fS4Zd1Rt4hecxCk6xBpLvbdeTE0FlBefSHQnPiJn74PB8lO5chGHRLOvxj46adwW
 Ent1otspFQ6IRQJ3EDGWJR6wh/cropbGDV5qQPRZJ4uwL9qauveORK+29CxH3kIhThy8
 xPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176358; x=1755781158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TtfdJAKHkhBXVVur9KnTeJdEj0NKkUPLOFyccsCQyeU=;
 b=J48mtQNfQlDVoHQ7IXClNVajTVims9YGndsxk50LnHnCLRT79uaZfoyGbrqyFTfiA5
 rSZ89znk52cAcfwmvwpZwZW5T4J8VNNJpF6KCB+l1awLOUaLc+FPSXY0HPrKEmvmvkjp
 nMbLJH95lAzH4/XrRuJTbOgCz0vj4K982xD82zt8Wi/J0KKwGX4Y6CEflMya+3cH40kc
 QRBhx/Um8p58gcbD98AFYhw9ssIuMEmKbXbP9G/8T6lUNCaudRC6FmzV+8XN1TgOhfIU
 m8mRuKpRhgRrTcx1CGdH9tyP0aYKwg5dIgHCuGdGVcy1Ac2sXQg+4kLwTxQCifzzQ8w0
 ZkKQ==
X-Gm-Message-State: AOJu0YyRUxXBNiapRbtlqaGpimQ2ZXoQDgkukkttHHOadmq5joMApP50
 6n+S06JZzS1DyF3a34FTFDW1Z2KUjx9mjh10iuDeEQmMjnz2uOfuMfiSlNaaF/iBY2g4yWyJGs8
 3zZLfakY=
X-Gm-Gg: ASbGncsDZJpxR/d3hh2TEhfNAxHxfu+635zUqCeiDp4r8jJld0hxeR0dx1d4RtiCYUe
 EWMCNxB6sK8oZMpcOg1ADoqfmcBvbOMvVsKz6YQkxwKnH3IaEf+ov017bbX4ZvHnZ+dO3u0i/FY
 UrHHPil++IM1v3jNE/N0zzytL/Zyn8Pp/i5Ej2iV54VESvAEv9wH1KR+OSNF239itvOOFi3hVHo
 jpScYT4x8knUec9EcyzxQRvpKSXEpGwJ6PNvbp2qPbXRMGemgXZWdQuwpuikgMJvmpmbsUxIVNK
 rvF5gKoLaNotGW1rH/aOtn8qsTxFPqtDLlMFzSduuwe7DxdNjMEvMGpKMnWQq/0cgmTIFAtbZKF
 xi6cuDgDZk5v35yv7NEqtNsh2uPifmGkRW4KE+rZOey90P3g=
X-Google-Smtp-Source: AGHT+IHUu2SKS6s2twlsSDcYkb1o2jT1mppq37RTXokyeHNTId+wXbr6ypQy3cDGYWATr6Qh3lLSVQ==
X-Received: by 2002:a17:90b:1e01:b0:321:d5e8:ec9a with SMTP id
 98e67ed59e1d1-323297ac230mr3513698a91.16.1755176358111; 
 Thu, 14 Aug 2025 05:59:18 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:59:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 24/85] target/arm: Implement dirtybit check for PIE
Date: Thu, 14 Aug 2025 22:56:51 +1000
Message-ID: <20250814125752.164107-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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
index fc82dd65e8..b6499683cc 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -754,6 +754,7 @@ struct ARMMMUFaultInfo {
     bool s1ptw;
     bool s1ns;
     bool ea;
+    bool dirtybit;  /* FEAT_S1PIE, FEAT_S2PIE */
 };
 
 /**
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 323fc8052d..820d5e65a0 100644
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


