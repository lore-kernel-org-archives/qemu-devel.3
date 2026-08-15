Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76163C5CFC1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvL8n-0008LP-7l; Sat, 15 Aug 2026 16:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8k-0008Hz-Jn
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:38:02 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvL8c-0008IZ-Kx
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:38:02 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso39727895ad.0
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786826267; x=1787431067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qu9I9gYRpkRKcID2nB2noN8+9kKxwJxKEmAKtZFUHmw=;
 b=EjDb1tj9zvVUGif3IKDwtpBQhM7He/hNsJZ15qLP1/Qr3kG5K2YR2Z9LgfxxmfNnWn
 R+R4TajeXLLYdkH0q+M+g/jpekHOyubILQl7E+WSrxjz6ooKomhluujxNZyNR8leXp0I
 XBIs197btzYt0B/xQhpd+QTevrxhkNZoV9IEyTQr44+p56fvGUyq5ajwid6sNMaLMmr5
 6XEB1gFzlTHhF6+3urTOi8WuVEyKL3Keq0Qo5fH8xtGhovZknQTxQqnbVHPHDlrSQKsl
 eFaDv3AcE+BEIRrcLVbk/fvhZzszipUAL/spw780pLtMVEuZexbGwW10sX48e9YNkB8v
 Bx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786826267; x=1787431067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qu9I9gYRpkRKcID2nB2noN8+9kKxwJxKEmAKtZFUHmw=;
 b=lHl7bRG0/VgfDlkMIdNi9mCscrhtdSFZD1jyuHhC4iTiFKf7Gi+5QmQ5Xx9rCFfg/f
 74c+YZJgTFeEiZG3UfoI9GpDtEoFSgV4a8r/xHSxO1NNrZblngNNTLqiIIExhAqYLpi7
 Vjik9TdMCedo+JS9aumlkAayP24fQr2FRtbZaOlbLPaY2QKCmZr0D44OHzfQTXBQMnow
 pimhFeNY1YdAPUUZ8XwOq0aA9zhbdTphep2tOzsafhq7pRSQsBdk9fGcnrqeBazQiL0+
 TOhk6s+f2PMZoHWtN9Rj/PLJRAElTRsKMDeVlJLVdEXiRdzM7yQX+pC+d1h4J5GvboOW
 ceDg==
X-Gm-Message-State: AOJu0YzzQHy80T5NP/5uMTwB68XGd9mymXN40l7/CQrdNGhRya0lLXlz
 HmBJh6nYdDySXIgbxLMV+QINzL0UfBTrSZORBlJjlYabNlEyAprPiw/0xgVi+a487ti1ulcvE7H
 eHlpu
X-Gm-Gg: AR+sD126wLHZtdsXVjDgVTq+2zXBL5wHFVGEg4Sgv3nbLibSYvaNS9rHaqsnK2y4mke
 kP9+dA3ObSwqMlmag30hwyKJ4tFMYirZrR42ZFdUenfgNwdYwkoaCO9tyzVS2xuefdPMU6azSVa
 7u7SvQAwiS1yYum9ck4f02SCxVpGs8hmE5k7WWIHOz20xx/Jt1Hl1WIfGtM5u7w2REM2iBL9DMc
 7SQG7U3xUTB5lWXFgBi1Qbxycr9y2nVuaZ/1GjiWtNrQgjodqVi0MUJ9juDcLX58VgR3ehvmdd9
 ArQutaDJ/TNdFdVvAEaaOBNbXul9bDuaX25YxCzOmrdzkZBd+5s0WTHpiXNGZLqA0CJYhw9y/CE
 yxJSo+rTZiwrMcdEbr7qZsqJ1y55OTpZqvLDYK4TIe6ulQAmfZ/EVYbokhRG3+OaSsZPyPyqC1u
 vUgVvuVKwzk/uUlLLzWxZPduRF4Qr00lok8uKcQHZa9/7i0JhByOGP6LCN81cJ0TNYozIMuBMtD
 vc+KbK+8+O5/cdw9cam
X-Received: by 2002:a17:90b:574d:b0:38e:5828:a446 with SMTP id
 98e67ed59e1d1-3933b1091eemr11924186a91.19.1786826266554; 
 Sat, 15 Aug 2026 13:37:46 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea97207fsm7066853a91.1.2026.08.15.13.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 13:37:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC PATCH 09/18] accel/tcg: Allow phost to be NULL in
 probe_access_flags
Date: Sat, 15 Aug 2026 13:37:21 -0700
Message-ID: <20260815203730.1468365-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815203730.1468365-1-richard.henderson@linaro.org>
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Do not require the caller to create a dummy variable.
The one instance so far is riscv check_zicbom_access.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/probe.h    | 3 ++-
 accel/tcg/cputlb.c           | 4 +++-
 accel/tcg/user-exec.c        | 5 ++++-
 target/riscv/tcg/op_helper.c | 3 +--
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/accel/tcg/probe.h b/include/accel/tcg/probe.h
index 06faf1269d..477320c88d 100644
--- a/include/accel/tcg/probe.h
+++ b/include/accel/tcg/probe.h
@@ -68,7 +68,8 @@ static inline void *probe_read(CPUArchState *env, vaddr addr, int size,
  *   - if @nonfault is false, raise an exception at @addr
  *   - otherwise return TLB_INVALID_MASK.
  *
- * Otherwise, return the TLB_FLAGS_MASK for the page, and set @phost:
+ * Otherwise, return the TLB_FLAGS_MASK for the page,
+ * and, if @phost is not NULL, set @phost:
  *   - host address for @addr, if direct host accesses are allowed,
  *   - otherwise NULL.
  *
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a192c50e90..c2ea31a397 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1465,6 +1465,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, vaddr first, vaddr last,
                        bool nonfault, void **phost, uintptr_t retaddr)
 {
     CPUTLBEntryFull *full;
+    void *discard_host;
     int flags;
 
     assert(first <= addr);
@@ -1473,7 +1474,8 @@ int probe_access_flags(CPUArchState *env, vaddr addr, vaddr first, vaddr last,
 
     flags = probe_access_internal(env_cpu(env), addr, last - addr + 1,
                                   access_type, mmu_idx, nonfault,
-                                  phost, &full, retaddr, true);
+                                  phost ? phost : &discard_host,
+                                  &full, retaddr, true);
 
     /* Handle clean RAM pages. */
     if (unlikely(flags & TLB_NOTDIRTY)) {
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 44e9f7fa1a..3578282a3d 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -801,7 +801,10 @@ int probe_access_flags(CPUArchState *env, vaddr addr, vaddr first, vaddr last,
     assert(((first ^ last) & TARGET_PAGE_MASK) == 0);
 
     flags = probe_access_internal(env, addr, access_type, nonfault, ra);
-    *phost = (flags & TLB_INVALID_MASK) ? NULL : g2h_vaddr(env_cpu(env), addr);
+    if (phost) {
+        *phost = (flags & TLB_INVALID_MASK ? NULL
+                  : g2h_vaddr(env_cpu(env), addr));
+    }
     return flags;
 }
 
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index b18bf683f4..9c0cfd35fc 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -232,7 +232,6 @@ static void check_zicbom_access(CPURISCVState *env,
     RISCVCPU *cpu = env_archcpu(env);
     int mmu_idx = riscv_env_mmu_index(env, false);
     uint16_t cbomlen = cpu->cfg.cbom_blocksize;
-    void *phost;
     int ret;
 
     /* Mask off low-bits to align-down to the cache-block. */
@@ -251,7 +250,7 @@ static void check_zicbom_access(CPURISCVState *env,
      * permitted to access the cache block is UNSPECIFIED."
      */
     ret = probe_access_flags(env, address, address, address + cbomlen - 1,
-                             MMU_DATA_LOAD, mmu_idx, true, &phost, ra);
+                             MMU_DATA_LOAD, mmu_idx, true, NULL, ra);
     if (ret != TLB_INVALID_MASK) {
         /* Success: readable */
         return;
-- 
2.43.0


