Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7626DCCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jHb-0001u1-W4; Fri, 03 Oct 2025 13:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jHZ-0001tD-Qa
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:25 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGW-0006G3-DM
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:09:24 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b62e7221351so42482a12.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511292; x=1760116092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fk0M7+H7OSU4hjsFazXAnMbgIuwLl8ecHreaXxde3sg=;
 b=jm7vPmo86NdVL0TrR7RvhIFXk1xEfkOdP8zgYoXpsxWIT5kPAF0nnGFZ8pw0TK6GV+
 /beo65WW+OpZ4LL7Hr2cnmrULF6LZ8pEUrhKWs38P3C9f7cozHB4AW+aJ02DXYFTWYFF
 EmMHGi2vz881xiuEeQAnFHF+SGGxmLbe10NUi2RXQ/YASFm9JEexS25O19S7tBVMCY07
 ytPvIGHUNyfo5z/8bVhKUVDlrwQmrsJ6epgosVcylQ151HaNaCKuAnBUwm5GWALcfQat
 LXNOEUU3vf9C1Sq5uLrtF5MDh5cCeSBEdNfpHmrLF8gzIQm/p2yRHSXpFyzZL6JxHDJa
 O8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511292; x=1760116092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fk0M7+H7OSU4hjsFazXAnMbgIuwLl8ecHreaXxde3sg=;
 b=aYKsuaUSW1MvB0budB+sCE6EWfePO3ceoPraWsLJ3AE/cIhyMY5vIEHkDKYEiv8sac
 yrfpIa/Zn1zAcvVU2RvcVXmXHMqosQHLceKTdXBwNjrOJzI1/uMKdfrcz4EXehSxEprZ
 g09gmi+SrRHLpZQsI+1rwtzjkkpktZS08txAzr30/a7YXYTDvgB77CpyHanIavdIprzR
 +V2CQTjdoT2e4i0uulAgkW5+QekG6GCuIn9F1gQCO3Ie66ZpKW3/bVX9LS9eXP50e/+l
 c0/UNxCKqWDFiMgs2s8a0Y7DkfprzZMrVu/E9nx3mxLIzXgc5KiTWXQnxTTfHV3bp0Xr
 /ZQA==
X-Gm-Message-State: AOJu0Yy4he0WfD9QIn/FbIK3LWTXHUtY7eLkTVXDsa8+aDOVeZdn8Ih4
 dF4n6y2N+iG7UTTnzWD5WWGFp9APWAi1GzCPhHWC3A3Kqpm4Hv5l+69S9PJU26G2M6kV42Cfyk1
 1y3cKkLg=
X-Gm-Gg: ASbGncuZRvgARuUSZNdZGYPDumzxR8TyibcvSovzOB8oQ6h/8WJEYuiEJej6xdMBFJb
 Zp1rdKFvSmi+bEejhUtA06mrKyAHUR/AR2+vwv0uBklpr660EErHHdH9/TkjNotw2W+fXdRBrXF
 NUIPbipX422TsxXjcGxiAiVTeqBR3CFipsjSrxig8B9z6lWE9Xx7lub63YhqDaTE3aZciqPNR62
 XFhz3pASMp+OmpxW7DRHW6MJYjBvGYgj3Z5cXmaANRTwaBhXbI+zo7/GEouRhYmrPjNOEg+S+Jv
 zyIKa4Gfu9LhQ1Jz6komxkDAxcn/1Ih+mUOmDCt99peLWBWzb3TsoApxP+PbdkEofJ2T3i3U5k+
 d5GlIBlDNXhSOn/GR4f7fUlS5ts2R2eECvUPaiIpHH02V875IY/yqyC2N
X-Google-Smtp-Source: AGHT+IFmK29FNwIxJE4EQieOE2WOhwFTE36Jwax8lab3+fKoAGYrsJ0xOebjGNFmyakuSTY8XU9Hpw==
X-Received: by 2002:a17:903:2f8e:b0:267:b0e4:314e with SMTP id
 d9443c01a7336-28e9a58cebbmr43091605ad.23.1759511292482; 
 Fri, 03 Oct 2025 10:08:12 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 12/73] target/arm: Implement dirtybit check for PIE
Date: Fri,  3 Oct 2025 10:06:59 -0700
Message-ID: <20251003170800.997167-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
index 6dcd3adbdf..be3629a745 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2311,6 +2311,22 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
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


