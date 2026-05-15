Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9001BCD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtUm-0006iS-9P; Fri, 15 May 2026 10:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtUL-0005xQ-Cn
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:26:05 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtUG-00010y-W3
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:26:04 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so4969004f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855156; x=1779459956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sbEPi44KKLT30E1Ya7Xgq7lsZNIAggwXePt17au81Fc=;
 b=Y4rKCy4yMlvd3j9Pzz9hP55AuKtCx20xPo4/D3HUSetEqdRBMZDF7VudGwVUq41hQs
 HtKYNV3uIi6QRwATjm05FFYLxd7u3pQE0ljTM8H/Z+iG1X3rLxlkyeqHhsTiyMnYdsjR
 2lNXYXfjRg8DYkFQLkqvFvvGg+ZcnO051sDjz54pv0rI6rUGkzrWoTiZbMNwr9lyxMmK
 NeDIFVDynYMAhvg1ztovqhhpTLkppTxwxYdK39eTmMk7Z0bF4X0/+jgIuJXvPoGX/sfl
 4szHzC4IchEvtkdSx8bSZvAzHdCe2sqth23do0q1LT+K49sLJQaVdNuhemoSFf+XLOOU
 sIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855156; x=1779459956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=sbEPi44KKLT30E1Ya7Xgq7lsZNIAggwXePt17au81Fc=;
 b=nrgcY4Dg2Obqx2YaXWQbqH1+rqkCjuwId3cmGkugREnDkrIMu0w5ijCbFQWWmCaVBN
 5XeTb7Ofi1MXzHyc4wtP8y6P7dJ+FK0ybAWInrRgmSCUyr/b2isZZWAFzDYIihLWQl3c
 UKB548PyAba0ABZs7zWytH7NDzeYMP8Zc4EhwgL3Ytduam7x/dNii+1etpVWqMqr69UQ
 VwB6xP1WYsJ7shOWB4j9sPZgRJDC4ej295ZbL0jdomdmP5XCEEj3oxvizNXZP22tCdYA
 pKJfJNk63rOnPt2SYwkXRKa8rBvxvlsc5djPBDfGt7BmdXemVTpo4mE1g43d88B4dudh
 Tqsw==
X-Forwarded-Encrypted: i=1;
 AFNElJ868h+p3BYIHOLjQSCmlOfZE6mEq6vqbMytHbwcfbnVG9NjKK69KAVgErj3zPhR4NOGuvbAK5Vb/30G@nongnu.org
X-Gm-Message-State: AOJu0YwkT6fm5pma6PgQKXz5QFC1uw+EW/tzwNkjZdzxLBzK0qDHuno8
 BbSpElCPRihfBmayvyneYsXzGok+Cxt+LJS8jVSUjbQrgTbJeIwhNi4/YwVszBzVQ2Cjv1Ukp7g
 XQool
X-Gm-Gg: Acq92OH+v7DRnNT9T9ZJLpdULkbHGjXWjpU8sI0rt8zAmNykI80QhefBfnwWNMGbIDH
 HfrsCrjmaw6plTSAPjtr0E9jNQFh+882sLe3GcvxnI5z+/Jm6XhzaGDJgaYfNgUG4tzyVcbupwG
 S+MkXvTyvOp+kaiRjQnG5wSs5ALIgAYSCeaWgnxDt+LGHf+cwQjOIMiuSDlEAgIH0gnfp9AcCi/
 cJYNT2zjnQogpxtIoFIbXTsHjCJkqZ6hQBzkR/XmNk0tvDEM5mIdLvDA3zmVn+4iSH4NKEMqfuY
 RjJHbRWVYd8oAs0ZwEfGj7rjNlPGEM6VPzI3wLv/9HXo2xz//v4/xQrtB81fSXV9xHB3EM2PiQA
 cKueOojUo8zQP0+tEPOwdZe8I24f/6TEzsxOPKtk7qPFXV+nnXjji2yPvOaWm+B29Jd/HzVzxuk
 4rLTaE0/s9M/1RLwBLF5BS8Zya+wGPNrCoN8gw4Sfb7CavEYDUU4Lnj2wYAT4POhsQXzP5jx22V
 +YcNGHtWUdVSMydGaP1VanuOepsifYYVdT6tj1eDw==
X-Received: by 2002:a5d:5d10:0:b0:45a:dd7a:e33c with SMTP id
 ffacd0b85a97d-45e5c596c14mr5570592f8f.33.1778855155760; 
 Fri, 15 May 2026 07:25:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm13560603f8f.36.2026.05.15.07.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:25:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 13/14] target/arm/ptw: Flip sense of get_phys_addr_for_at
 return value
Date: Fri, 15 May 2026 15:25:40 +0100
Message-ID: <20260515142541.571911-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515142541.571911-1-peter.maydell@linaro.org>
References: <20260515142541.571911-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h     |  2 ++
 target/arm/ptw.c           |  2 +-
 target/arm/tcg/cpregs-at.c | 12 ++++++------
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 3edc15c7b4..7fd8312477 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1526,6 +1526,8 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
  *
  * Similar to get_phys_addr, but for use by AccessType_AT, i.e.
  * system instructions for address translation.
+ *
+ * Returns: false on translation failure, true on success.
  */
 bool get_phys_addr_for_at(CPUARMState *env, vaddr address, unsigned prot_check,
                           ARMMMUIdx mmu_idx, ARMSecuritySpace space,
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index ea036a541c..6a002c25e1 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3851,7 +3851,7 @@ bool get_phys_addr_for_at(CPUARMState *env, vaddr address,
      * check is handled or bypassed by .in_prot_check) and "memop = MO_8"
      * bypasses any alignment check.
      */
-    return !get_phys_addr_nogpc(env, &ptw, address,
+    return get_phys_addr_nogpc(env, &ptw, address,
                                MMU_DATA_LOAD, MO_8, result, fi);
 }
 
diff --git a/target/arm/tcg/cpregs-at.c b/target/arm/tcg/cpregs-at.c
index 53dd67375d..1c819c1cdb 100644
--- a/target/arm/tcg/cpregs-at.c
+++ b/target/arm/tcg/cpregs-at.c
@@ -31,17 +31,17 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     bool format64 = false;
     ARMMMUFaultInfo fi = {};
     GetPhysAddrResult res = {};
-    bool ret = get_phys_addr_for_at(env, value, prot_check,
-                                    mmu_idx, ss, &res, &fi);
+    bool ok = get_phys_addr_for_at(env, value, prot_check,
+                                   mmu_idx, ss, &res, &fi);
 
     /*
      * ATS operations only do S1 or S1+S2 translations, so we never
      * have to deal with the ARMCacheAttrs format for S2 only.
      * (Note that res fields are only valid on ptw success.)
      */
-    assert(ret || !res.cacheattrs.is_s2_format);
+    assert(!ok || !res.cacheattrs.is_s2_format);
 
-    if (ret) {
+    if (!ok) {
         /*
          * Some kinds of translation fault must cause exceptions rather
          * than being reported in the PAR.
@@ -144,7 +144,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
     if (format64) {
         /* Create a 64-bit PAR */
         par64 = (1 << 11); /* LPAE bit always set */
-        if (!ret) {
+        if (ok) {
             par64 |= res.f.phys_addr & ~0xfffULL;
             if (!res.f.attrs.secure) {
                 par64 |= (1 << 9); /* NS */
@@ -169,7 +169,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
          * translation table format (with WnR always clear).
          * Convert it to a 32-bit PAR.
          */
-        if (!ret) {
+        if (ok) {
             /* We do not set any attribute bits in the PAR */
             if (res.f.lg_page_size == 24
                 && arm_feature(env, ARM_FEATURE_V7)) {
-- 
2.43.0


