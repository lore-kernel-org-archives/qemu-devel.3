Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D6ECA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOE2-0006Ux-6C; Sat, 30 Aug 2025 12:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usER4-0007Mh-FG
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:37 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usER1-0004xi-U6
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:47:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-248cb0b37dfso26141245ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532850; x=1757137650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tTRSZKjd08qJnO8hiUHZqz18pN5N0JYxSN7ixmWuuxk=;
 b=I5Y9CUvckqy/Stjd0OEIO/RIlCzDNyeysyH8sBpRzdgio2Tn7ACNH5/rQF2zqXS0wC
 Ht1ZwAlNbSfjzEgQr8dojjF95xHpTFFhH0of0orahrT/Ybldc67PFbR7GXiQdDNmFSjO
 NNSioScIVgm17BrywJpaZX34bZRRCaFWONDqohAmRLLdB1ti2enKUiEV2xP7o/ya3MY+
 fvhgmd+k36RJCy6W4uYT3GHQpZGStiHNCk2gvNiIg1hDGXuwzbEu6UnsuVXZDIwGKoIk
 XkQEg1r4jF5eBCFJuQ0s7JY0NJuFyKDI6DnC8DfrEGwEkiBGYy8VPe74Ov8f2Rrdb/Oa
 0fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532850; x=1757137650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tTRSZKjd08qJnO8hiUHZqz18pN5N0JYxSN7ixmWuuxk=;
 b=p07wRWQQJ6Ay2e2YAKDciqDxq/DQ0oW0vmWYzrNJjNWRjKLB95i7QanhUqGyoP3JHA
 c28VTolJ/MpZXWMIxrEZxxs8hkQ/GZyh4IiOOxN3OdkfGn7Pg7uAW73S/d1u2FWae6XD
 RtFfGPxFZsX2GzR5x+QJE4ECS49gHeVC0OZEiC3EyBsikw6BD2BkPrX2Bw0gXNdNXMnL
 qEmZPA4xVdjDk2lfjdXc4IxIAwnmhm345gKIYNH22cwcMJxCPNLDHiO/A/parugvajs+
 8Dzem9oD9OdCaf0JO+EzC/J2PqbioT3NEApmzlt1DFCczMHPY7ulTPPA2KHS/CZqmlNu
 MDzA==
X-Gm-Message-State: AOJu0YylEOfG7TTlPJN+dS+mPp1bJWIFod6pxbldaL/groRJzn3Pq6aa
 I23A76QUyuRi5dYypVFQktIM3GouitEVvCHU7HKC14rrv8+BJsJ+6fT50oRXyhT/FMv0AeYbTXp
 JqxnvHJE=
X-Gm-Gg: ASbGncsgZxReUcEF1GJKEy9oAEyvH1a9QNENNGm4OkzbEOnNsJrGbrLQBpHz9JBPs26
 nydRQ7bCAz2yR+K8tBX9s8mf3XpBBwtnbvdNHIw+JIxD63rME+QQy8Fck9M3AwPSpdgMkB91xEY
 jRzOrAmtG5hYNCeXnRPqRntglo4OGXveZ33sdpr8MI9T+Ya/zTFxAvKjLQvBDRj7R8lcczkZt2U
 eL5VT0WOvc2D+SDVxk/jeq30sPMkQ3WbGhBFXrHe/Wz/CJL6PUngYHpe3v4vq0fTUC4Jz+xzb76
 5pdfX17SkLn/03MrFVUJLRWkh9IenCN/jFQw906mCxrnzkpYl4NJwkZ89wXdBZmORZQKo5wxO9e
 jsxCKeO5lRpx6UiySL/IwKqBk0BQwASpGe3rIi8MDn/qj4rCuudyoroqPZEmO7LI=
X-Google-Smtp-Source: AGHT+IFM8bU2f8sac4hJOsb8+1+l+chFmJCysVPKXmRNZAkNnZxmmqzqRud2f5YXHl1rzTbF+WSNDg==
X-Received: by 2002:a17:902:e5cf:b0:246:ace5:e1db with SMTP id
 d9443c01a7336-24944aa23a3mr13952825ad.28.1756532850546; 
 Fri, 29 Aug 2025 22:47:30 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:47:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 62/84] target/arm: Implement GCSPOPX
Date: Sat, 30 Aug 2025 15:41:06 +1000
Message-ID: <20250830054128.448363-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            |  1 +
 target/arm/cpregs-gcs.c        |  3 +++
 target/arm/tcg/translate-a64.c | 35 ++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 3d76afd20b..084ea00e51 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -50,6 +50,7 @@ enum {
     ARM_CP_GCSPUSHM              = 0x0008,
     ARM_CP_GCSPOPM               = 0x0009,
     ARM_CP_GCSPUSHX              = 0x000a,
+    ARM_CP_GCSPOPX               = 0x000b,
 
     /* Flag: reads produce resetvalue; writes ignored. */
     ARM_CP_CONST                 = 1 << 4,
diff --git a/target/arm/cpregs-gcs.c b/target/arm/cpregs-gcs.c
index c688d0c391..2d39b17188 100644
--- a/target/arm/cpregs-gcs.c
+++ b/target/arm/cpregs-gcs.c
@@ -116,6 +116,9 @@ static const ARMCPRegInfo gcs_reginfo[] = {
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 4,
       .access = PL1_W, .accessfn = access_gcspushx, .fgt = FGT_NGCSEPP,
       .type = ARM_CP_GCSPUSHX },
+    { .name = "GCSPOPX", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 7, .opc2 = 6,
+      .access = PL1_W, .type = ARM_CP_GCSPOPX },
 };
 
 void define_gcs_cpregs(ARMCPU *cpu)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e5d9a6e837..b0a1a62a91 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2560,6 +2560,33 @@ static void gen_gcspushx(DisasContext *s)
     clear_pstate_bits(PSTATE_EXLOCK);
 }
 
+static void gen_gcspopx(DisasContext *s)
+{
+    TCGv_i64 gcspr = cpu_gcspr[s->current_el];
+    int mmuidx = core_gcs_mem_index(s->mmu_idx);
+    MemOp mop = finalize_memop(s, MO_64 | MO_ALIGN);
+    TCGv_i64 addr = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGLabel *fail_label =
+        delay_exception(s, EXCP_UDEF, syn_gcs_data_check(GCS_IT_GCSPOPX, 31));
+
+    /* The value at top-of-stack must be an exception token. */
+    tcg_gen_qemu_ld_i64(tmp, gcspr, mmuidx, mop);
+    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, 0b1001, fail_label);
+
+    /*
+     * The other three values in the exception return record
+     * are ignored, but are loaded anyway to raise faults.
+     */
+    tcg_gen_addi_i64(addr, gcspr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(addr, addr, 8);
+    tcg_gen_qemu_ld_i64(tmp, addr, mmuidx, mop);
+    tcg_gen_addi_i64(gcspr, addr, 8);
+}
+
 /* MRS - move from system register
  * MSR (register) - move to system register
  * SYS
@@ -2855,6 +2882,14 @@ static void handle_sys(DisasContext *s, bool isread,
             gen_gcspushx(s);
         }
         return;
+    case ARM_CP_GCSPOPX:
+        /* Choose the CONSTRAINED UNPREDICTABLE for UNDEF. */
+        if (rt != 31) {
+            unallocated_encoding(s);
+        } else if (s->gcs_en) {
+            gen_gcspopx(s);
+        }
+        return;
     default:
         g_assert_not_reached();
     }
-- 
2.43.0


