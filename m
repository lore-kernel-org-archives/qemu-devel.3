Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E32DCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4dD-0006Ou-2d; Tue, 26 Aug 2025 21:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4d1-0005S5-6k
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:09 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cr-0007TV-P2
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:05 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-771e1e64fbbso3799370b3a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256815; x=1756861615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWdqEh5/ACt1jGQsPrkt1Z/Ikir05hx1pOmvaHv8O0w=;
 b=s+p2zbizL5ZeGmfKnP4WvW9cN2kOgQ/okOAImHlU/0bqwvHU7qIZ1tbwFE2KBfetP5
 nyTUQIELskT21/1m2ziEvBpryWfNdPu+qnov1vTo/4v6Nq58M2Z1/me+66tH5ZuXGhkU
 zyk5bnHxsgpMpsCIqFrhNNf47WlkcAKcUjwsB1JwwUIulyd0uS9lz7Pihmuly2xacDjy
 z2g5YfFSPquHRLNnRWzqkbBKe+6xVDP2SxpLyXIRNAVCcq7qySxIPNhHMDhgqCh1hEpt
 RpVEhO7iuxkxpLcEHHpNT8EFvhziaIF4QZtS7JFSfdPC2uBm2Z1yzmmL8XncX9o+xt50
 Zshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256815; x=1756861615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dWdqEh5/ACt1jGQsPrkt1Z/Ikir05hx1pOmvaHv8O0w=;
 b=Zvh2PUdWdJaIvQZJjwyrE+f9KXfG09EGO2wQnvHqXlCkuYplTqxdUdzWauSI1FAQda
 p4Jd6JEXrtck3cnHrMQpPKZw9ZiVLgPB+22AaDt8pkyUxB2LlYknPy9RrgBajG0p1iQ8
 dul+qGhAwNi0rj9b0FtLOQokolCuSd0hV5u976XRcvDcK48UsheJxCqiXAuWFA1QCW9J
 7cLb632d4VxxTH/jfCnfDRiDDZ0lQvHSYO9iNHJXNGUTEZ7yYHGBHz5VQq7nyD1W0vNd
 7umxTL1pm3tzgnlezUHEsqmda+XvvDtB0Upnoe/DDvK2pLNrIaFew+fCaENa2CSKJ58F
 u7Gw==
X-Gm-Message-State: AOJu0Yww0+UBQUFDfybjH3iXlxHQ3qtOaLSgl6Wp6d3oIUKIif+eERuC
 jaT3r693tueXHP3a3c1IWPxRL59zwvKFtb87LrDW1iVJmMxghUip3kRcxL6k5mTPSIi62pSo3CI
 FKseFQI4=
X-Gm-Gg: ASbGncv6XVWWkf2exKF7Uwk8j2XMoh85Sfxce/1FDRgraUSS4Hq655nbz1wcP8j8bwN
 A033BmT+E8al/cgAqSOPedALx9+eD8pKJ2Fd78ZEBuZ4jsW84HHxOmS25bVOLCI+9H0hGxdxiaB
 BgYh3NKwxwyrnRNzdxbw6xvaR7XnZWnVRMcn9Ok+uBGPRjfZJQhbrAc3+EmPRKwJje+w6bqj/NP
 3cd4WC7buTjy9POpSMGACU6ndow21LlZlG7Vs19l6ALQ97b88HIXoMOgE8b6J/2f+Ht4eTd3l5H
 eIqW2B+r0ZjxPeMNXmTLWoIEhGF02SLwVuSTL5JU6HnpRRfnnnV5tA77kolCDhxvMixXygeSM9X
 6OsfBZEgnsZu+LTEGxQ2x9Xpz4w==
X-Google-Smtp-Source: AGHT+IGPfxa6uWH1k9DRO5IgpAYHvZQmz0jSVuT0PU0u2Ugqn7t6TA1o1cN98zJy4CLGKCouNUUqig==
X-Received: by 2002:a05:6a00:170d:b0:771:e50c:99c0 with SMTP id
 d2e1a72fcca58-771e50c9e2bmr8211682b3a.26.1756256815185; 
 Tue, 26 Aug 2025 18:06:55 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:06:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 20/61] target/arm: Split out add_cpreg_to_hashtable_aa{32,64}
Date: Wed, 27 Aug 2025 11:04:11 +1000
Message-ID: <20250827010453.4059782-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

The nesting level for the inner loop of define_one_arm_cp_reg
was overly deep.  Split out that code into two functions, for
the AArch32 and AArch64 paths separately.  Simplify the innermost
loop to a switch statement over r->state.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 147 +++++++++++++++++++++++---------------------
 1 file changed, 76 insertions(+), 71 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b48b669a6a..7ce03336fe 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7458,6 +7458,66 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     g_hash_table_insert(cpu->cp_regs, (gpointer)(uintptr_t)key, r2);
 }
 
+static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
+                                        int crm, int opc1, int opc2)
+{
+    /*
+     * Under AArch32 CP registers can be common
+     * (same for secure and non-secure world) or banked.
+     */
+    char *name;
+
+    assert(!(r->type & ARM_CP_ADD_TLBI_NXS)); /* aa64 only */
+
+    switch (r->secure) {
+    case ARM_CP_SECSTATE_S:
+    case ARM_CP_SECSTATE_NS:
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
+                               r->secure, crm, opc1, opc2, r->name);
+        break;
+    case ARM_CP_SECSTATE_BOTH:
+        name = g_strdup_printf("%s_S", r->name);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
+                               ARM_CP_SECSTATE_S, crm, opc1, opc2, name);
+        g_free(name);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
+                               ARM_CP_SECSTATE_NS, crm, opc1, opc2, r->name);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
+                                        int crm, int opc1, int opc2)
+{
+    if ((r->type & ARM_CP_ADD_TLBI_NXS) &&
+        cpu_isar_feature(aa64_xs, cpu)) {
+        /*
+         * This is a TLBI insn which has an NXS variant. The
+         * NXS variant is at the same encoding except that
+         * crn is +1, and has the same behaviour except for
+         * fine-grained trapping. Add the NXS insn here and
+         * then fall through to add the normal register.
+         * add_cpreg_to_hashtable() copies the cpreg struct
+         * and name that it is passed, so it's OK to use
+         * a local struct here.
+         */
+        ARMCPRegInfo nxs_ri = *r;
+        g_autofree char *name = g_strdup_printf("%sNXS", r->name);
+
+        assert(nxs_ri.crn < 0xf);
+        nxs_ri.crn++;
+        if (nxs_ri.fgt) {
+            nxs_ri.fgt |= R_FGT_NXS_MASK;
+        }
+        add_cpreg_to_hashtable(cpu, &nxs_ri, ARM_CP_STATE_AA64,
+                               ARM_CP_SECSTATE_NS, crm, opc1, opc2, name);
+    }
+
+    add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64, ARM_CP_SECSTATE_NS,
+                           crm, opc1, opc2, r->name);
+}
 
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
 {
@@ -7485,14 +7545,12 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
      * bits; the ARM_CP_64BIT* flag applies only to the AArch32 view of
      * the register, if any.
      */
-    int crm, opc1, opc2;
     int crmmin = (r->crm == CP_ANY) ? 0 : r->crm;
     int crmmax = (r->crm == CP_ANY) ? 15 : r->crm;
     int opc1min = (r->opc1 == CP_ANY) ? 0 : r->opc1;
     int opc1max = (r->opc1 == CP_ANY) ? 7 : r->opc1;
     int opc2min = (r->opc2 == CP_ANY) ? 0 : r->opc2;
     int opc2max = (r->opc2 == CP_ANY) ? 7 : r->opc2;
-    CPState state;
 
     /* 64 bit registers have only CRm and Opc1 fields */
     assert(!((r->type & ARM_CP_64BIT) && (r->opc2 || r->crn)));
@@ -7589,75 +7647,22 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
         }
     }
 
-    for (crm = crmmin; crm <= crmmax; crm++) {
-        for (opc1 = opc1min; opc1 <= opc1max; opc1++) {
-            for (opc2 = opc2min; opc2 <= opc2max; opc2++) {
-                for (state = ARM_CP_STATE_AA32;
-                     state <= ARM_CP_STATE_AA64; state++) {
-                    if (r->state != state && r->state != ARM_CP_STATE_BOTH) {
-                        continue;
-                    }
-                    if ((r->type & ARM_CP_ADD_TLBI_NXS) &&
-                        cpu_isar_feature(aa64_xs, cpu)) {
-                        /*
-                         * This is a TLBI insn which has an NXS variant. The
-                         * NXS variant is at the same encoding except that
-                         * crn is +1, and has the same behaviour except for
-                         * fine-grained trapping. Add the NXS insn here and
-                         * then fall through to add the normal register.
-                         * add_cpreg_to_hashtable() copies the cpreg struct
-                         * and name that it is passed, so it's OK to use
-                         * a local struct here.
-                         */
-                        ARMCPRegInfo nxs_ri = *r;
-                        g_autofree char *name = g_strdup_printf("%sNXS", r->name);
-
-                        assert(state == ARM_CP_STATE_AA64);
-                        assert(nxs_ri.crn < 0xf);
-                        nxs_ri.crn++;
-                        if (nxs_ri.fgt) {
-                            nxs_ri.fgt |= R_FGT_NXS_MASK;
-                        }
-                        add_cpreg_to_hashtable(cpu, &nxs_ri, state,
-                                               ARM_CP_SECSTATE_NS,
-                                               crm, opc1, opc2, name);
-                    }
-                    if (state == ARM_CP_STATE_AA32) {
-                        /*
-                         * Under AArch32 CP registers can be common
-                         * (same for secure and non-secure world) or banked.
-                         */
-                        char *name;
-
-                        switch (r->secure) {
-                        case ARM_CP_SECSTATE_S:
-                        case ARM_CP_SECSTATE_NS:
-                            add_cpreg_to_hashtable(cpu, r, state,
-                                                   r->secure, crm, opc1, opc2,
-                                                   r->name);
-                            break;
-                        case ARM_CP_SECSTATE_BOTH:
-                            name = g_strdup_printf("%s_S", r->name);
-                            add_cpreg_to_hashtable(cpu, r, state,
-                                                   ARM_CP_SECSTATE_S,
-                                                   crm, opc1, opc2, name);
-                            g_free(name);
-                            add_cpreg_to_hashtable(cpu, r, state,
-                                                   ARM_CP_SECSTATE_NS,
-                                                   crm, opc1, opc2, r->name);
-                            break;
-                        default:
-                            g_assert_not_reached();
-                        }
-                    } else {
-                        /*
-                         * AArch64 registers get mapped to non-secure instance
-                         * of AArch32
-                         */
-                        add_cpreg_to_hashtable(cpu, r, state,
-                                               ARM_CP_SECSTATE_NS,
-                                               crm, opc1, opc2, r->name);
-                    }
+    for (int crm = crmmin; crm <= crmmax; crm++) {
+        for (int opc1 = opc1min; opc1 <= opc1max; opc1++) {
+            for (int opc2 = opc2min; opc2 <= opc2max; opc2++) {
+                switch (r->state) {
+                case ARM_CP_STATE_AA32:
+                    add_cpreg_to_hashtable_aa32(cpu, r, crm, opc1, opc2);
+                    break;
+                case ARM_CP_STATE_AA64:
+                    add_cpreg_to_hashtable_aa64(cpu, r, crm, opc1, opc2);
+                    break;
+                case ARM_CP_STATE_BOTH:
+                    add_cpreg_to_hashtable_aa32(cpu, r, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa64(cpu, r, crm, opc1, opc2);
+                    break;
+                default:
+                    g_assert_not_reached();
                 }
             }
         }
-- 
2.43.0


