Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75208C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 03:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsZW1-0004dS-Vi; Wed, 12 Mar 2025 23:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZW0-0004cd-2W
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:48 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tsZVt-0007ll-A6
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 23:45:47 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2232aead377so10696455ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 20:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741837534; x=1742442334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2yvAttg4yOZzhAQUiX0ynuUEgMnPWdV1Ar+AqZm3qI=;
 b=zjXQy8/RLUzlKFtpIBCNRYzbngrxlUraOA6Hwn25x58mXQJ0vV96h9gNFJwB0hAwu1
 Z08AuLFSoWZgFJUu3yWdvBJ2RT7JZ1wgDhd1hlngF1LyLWRiMrkSpCa/WUC3pOPEdjQo
 g23/Fx9SzKqidTouuzngAxhYfWU7CgcemeiyB/HYBBiMrZrPcjxIkyv751O2Hv3qf1CU
 3b98cn9UWlA3lPtZ7w6KFALf3LejvrlS3TKOPGHdQ/2u/aI1XYeJy0qhbYm8Cxlyw459
 t9l15QuQZyEhIZ46Hl/i7CO/Cak+r0jzYxxoexRXRN8JTWEiGJYycq+425EccW5JmEHl
 E/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741837534; x=1742442334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2yvAttg4yOZzhAQUiX0ynuUEgMnPWdV1Ar+AqZm3qI=;
 b=rvTTVR6Zl57mFoPwjk9ZqXn1GTW06L38+pfJ7GVm1cLg7olAsalHtP+VqyoBXAE5Iv
 u6FIk6NWhaniiHTvyIEt4gs9lrFISSXWhcFqFw3v+6sRJ3H3C/+dy4QIBLg6KohzT0lT
 IyyZAsCqo77fjzQruDOB7/vHclsVJQtupQE103R2EJXR5nK9UIV1mTIQDoUvUKEMXByw
 5yl945C+WPJ3FZ7QTBTr3Ua2H74lxOD01Rp70lYkpxaBrtxCGRSaj6QAsy1choOnajwq
 DViIBiTZ3YtXOlQ5AEvX055WDrX23VZLIptwtOO8brRBiD1JPVokM6DahVSJ74cmEb5k
 oQpw==
X-Gm-Message-State: AOJu0YzNN3LxOZRwEDh64OAUDMJ6Erg/w/+HvPeuZey1B/hyBdNa47TE
 3oTTpqLyMMlh5+zhL30yQo0LjgrxqUHY++6lloYDWXGHPnr5YRddAV9mEmf/OfDX0NrTY3pzJQS
 O
X-Gm-Gg: ASbGncvM2U1QgoP8zqBmGW6+BJo2SF7zpN0bp7uWSxlxMN3MfoCvFruFD+JlyAb7u4F
 FxNz2MMqPBegp4+J6ZOXuVvQB6OIaH87eACDAihkokCOysthrGvrDFAHN10JzBnjOSLcj+iBAt1
 OOSvfYanyt7STjcOkT/gRjDPB+w0IcjQVtN7pSVT1W0vTg5XaSaxwstyvliHtnhOTkZqudbMpfh
 sJnN52WEEWDcF1mlMTwcpM5jpKKzyuv9lbdwzE0wt7SgVDRem6ZMsl6xmkb5kjUXijoT2zE/2pT
 jBR9CpnXA8MgcRunmcb8R5+CVKQbEHRDiKsE5zn3nrBYXYjic6D9rNDStJA4tll55VRagoiuPGw
 rGisyteLxfgA=
X-Google-Smtp-Source: AGHT+IHvTqPujbhCGAu/VgB7GxMLMwSGsPuzcamkXyjPCXgRkEJlJdCouF2tH8B/knpDOESs7/EruA==
X-Received: by 2002:a05:6a20:93a1:b0:1f5:6c94:2cc9 with SMTP id
 adf61e73a8af0-1f56c9432d3mr27222804637.22.1741837534246; 
 Wed, 12 Mar 2025 20:45:34 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167def8sm316781b3a.90.2025.03.12.20.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 20:45:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH 10/37] accel/tcg: Use cpu_ld*_code_mmu in translator.c
Date: Wed, 12 Mar 2025 20:44:50 -0700
Message-ID: <20250313034524.3069690-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313034524.3069690-1-richard.henderson@linaro.org>
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Cache the mmu index in DisasContextBase.
Perform the read on host endianness, which lets us
share code with the translator_ld fast path.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h |  1 +
 accel/tcg/translator.c    | 57 ++++++++++++++++++---------------------
 2 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index d70942a10f..205dd85bba 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -73,6 +73,7 @@ struct DisasContextBase {
     int max_insns;
     bool plugin_enabled;
     bool fake_insn;
+    uint8_t code_mmuidx;
     struct TCGOp *insn_start;
     void *host_addr[2];
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 0260fb1915..64fa069b51 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -11,10 +11,9 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
+#include "exec/cpu-ldst-common.h"
 #include "exec/translator.h"
-#include "exec/cpu_ldst.h"
 #include "exec/plugin-gen.h"
-#include "exec/cpu_ldst.h"
 #include "exec/tswap.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-target.h"
@@ -142,6 +141,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->host_addr[1] = NULL;
     db->record_start = 0;
     db->record_len = 0;
+    db->code_mmuidx = cpu_mmu_index(cpu, true);
 
     ops->init_disas_context(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
@@ -457,55 +457,50 @@ bool translator_st(const DisasContextBase *db, void *dest,
 
 uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
-    uint8_t raw;
+    uint8_t val;
 
-    if (!translator_ld(env, db, &raw, pc, sizeof(raw))) {
-        raw = cpu_ldub_code(env, pc);
-        record_save(db, pc, &raw, sizeof(raw));
+    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
+        MemOpIdx oi = make_memop_idx(MO_UB, db->code_mmuidx);
+        val = cpu_ldb_code_mmu(env, pc, oi, 0);
+        record_save(db, pc, &val, sizeof(val));
     }
-    return raw;
+    return val;
 }
 
 uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
-    uint16_t raw, tgt;
+    uint16_t val;
 
-    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
-        tgt = tswap16(raw);
-    } else {
-        tgt = cpu_lduw_code(env, pc);
-        raw = tswap16(tgt);
-        record_save(db, pc, &raw, sizeof(raw));
+    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
+        MemOpIdx oi = make_memop_idx(MO_UW, db->code_mmuidx);
+        val = cpu_ldw_code_mmu(env, pc, oi, 0);
+        record_save(db, pc, &val, sizeof(val));
     }
-    return tgt;
+    return tswap16(val);
 }
 
 uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
-    uint32_t raw, tgt;
+    uint32_t val;
 
-    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
-        tgt = tswap32(raw);
-    } else {
-        tgt = cpu_ldl_code(env, pc);
-        raw = tswap32(tgt);
-        record_save(db, pc, &raw, sizeof(raw));
+    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
+        MemOpIdx oi = make_memop_idx(MO_UL, db->code_mmuidx);
+        val = cpu_ldl_code_mmu(env, pc, oi, 0);
+        record_save(db, pc, &val, sizeof(val));
     }
-    return tgt;
+    return tswap32(val);
 }
 
 uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
-    uint64_t raw, tgt;
+    uint64_t val;
 
-    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
-        tgt = tswap64(raw);
-    } else {
-        tgt = cpu_ldq_code(env, pc);
-        raw = tswap64(tgt);
-        record_save(db, pc, &raw, sizeof(raw));
+    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
+        MemOpIdx oi = make_memop_idx(MO_UL, db->code_mmuidx);
+        val = cpu_ldq_code_mmu(env, pc, oi, 0);
+        record_save(db, pc, &val, sizeof(val));
     }
-    return tgt;
+    return tswap64(val);
 }
 
 void translator_fake_ld(DisasContextBase *db, const void *data, size_t len)
-- 
2.43.0


