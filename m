Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4215C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7t2-0004LP-JL; Wed, 12 Aug 2026 08:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7sx-0004Aw-2e
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7su-0008UT-Gk
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:16:42 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so7805135e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786536998; x=1787141798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vzS6y8XpaW+frb4VvL7Cx5yE0FqW3fkEmCswuTl3ppo=;
 b=JGN4yUhuxoPkLvNS6toQiftmTbR2n1BPUl5whSHPiVtl7JPDMRDOnxSjq4ITnS0IEz
 4IWamydmsFMNwaY07nr2i5gquzrBQtV9V3m441Zn6XQAWJXLYxJ3Oax4JS61j2ANUOLv
 bwSaeflk/z7a0blhzkeCVqNY/dltgeNOwloPgOHYsPZUUfzKAp7QGTZDRlEA5PRuNsuV
 hTOUxg559/EjHJ8a/OxRFytJmYooP4v2/BLZ5nf4sOmsLuLk2dbU5moDfXvpoTwxH7qW
 z8YsTR53Ihwq+R0rarcqdPhKfpNHYMKgymfeA5eAUuB/Jpkgwr+Kkx8fuEDVtz9G0FmG
 IfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536998; x=1787141798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vzS6y8XpaW+frb4VvL7Cx5yE0FqW3fkEmCswuTl3ppo=;
 b=ghtsQPbms1v5Y6RSh47MM7AY7o/1h4GUsycY5Z5pC4bcDTdclxVREwik/+S+SxSj0i
 BUQdM5t2FOexr8hM+jOIQUvmZFLJO02EBIqUtSD4gykPb+zFih5k/nCQm5unuHqUPIOE
 rZ17fCEJrYmQ5Ux4rUXNReEJXN/OM5hMMhHYxjH+b5/eBimIzMOGW0JURHqB2ZXBiLTa
 d1E2zDnJ87hCTpWOcvqw1f6SikcKLvVtxVxJ+d23cbrMj6guM0+kwx30tP4HLIXtiLB8
 YvUYkpOD0iKeryKiHgPstsUizzmLEcbguNcoBEWM2y1/PpndJjEORYh3EINi3yn3x/Xx
 0G2w==
X-Gm-Message-State: AOJu0Yya5RNyblcag3MXuDUA8mE+aj6JvCygJ3vjUlOKbBunLQUFUMsn
 aU73htOY1sHBhAwqbKP3y8+n7sCJF60fnJZ8EWBOhNNfb8AFsu+7oMg0HSGKKf0CG0mqCHDQ3ld
 +YrkK
X-Gm-Gg: AR+sD11rZV1I1RXjMwK1THKntOq/AuoIrwZZJW6B1S10Upireq/UPRk3SLFkYJCBrQL
 HylpjBPx05+fXgOzwivuIcwrUuJtzgDLiTusffkHxlpw/xVVlzsYBTyxvQpBJ4+Kvgmor2hY2qh
 qlFkTlAHXR0Mc7aRP8wt/xwr0dK1exMWtzI4H2up2MymeLAi53jybiBaXYYppIoefJr/YE+Ag4K
 AXSuzzRDN1pCJMiq3Nz7CY6u5rNSdQLPAaUcrNdQc6OKV84LVfByTTz408NSg9VbfKbaTovcr/+
 9PmnPeXmC8fxm0W1xLgQ4NLvw0pxut8WxVSAZH7oPGiBVUpvxgskYNOsJuLBoSfPhgOdUbjh6Vv
 wNesVOSYsBIsaHkNxuz52/IN/WiAgDsgO1awMmVxWNIQgLGPwr7AVGQ4k8bldKkZIDNTA8VI7OO
 sTONej9xHm11xNzNI/jgwXVM/ypEiKfNW99Rcq2K3S6FiIU5U22eU5tG5qrmku2Ct24M/EzUz4Z
 R4iSFGlWHJy0OeyNcuT7rlDapvfGfbAn3l5+ndQn08lN9/LR0oz9EjScjlwOzy0Wa3g/w==
X-Received: by 2002:a05:600c:a41:b0:496:c378:6420 with SMTP id
 5b1f17b1804b1-4997c105cbbmr60208765e9.8.1786536992230; 
 Wed, 12 Aug 2026 05:16:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.16.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:16:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/26] target/arm: Implement BFTMOPA (widening)
Date: Wed, 12 Aug 2026 13:16:00 +0100
Message-ID: <20260812121622.649730-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260713230244.70174-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h |  2 ++
 target/arm/tcg/sme.decode        |  2 ++
 target/arm/tcg/sme_helper.c      | 54 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  3 ++
 4 files changed, 61 insertions(+)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index 224de45294..f05b53f412 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -408,3 +408,5 @@ DEF_HELPER_FLAGS_4(sme_usmop4s_dh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_6(sme_bftmopa_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sme_ftmopa_hh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_6(sme_ftmopa_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_6(sme_bftmopa_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index f0f9b3f61d..49af8fd19e 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1145,3 +1145,5 @@ USMOP4_dh       1010 0001 110. ...0 0000 00.. ..0. 1...         @mop4_o3
 BFTMOPA_hh      1000 0001 011 ..... 000 ... .... .. 100 .       @tmop_o1
 FTMOPA_hh       1000 0001 010 ..... 000 ... .... .. 100 .       @tmop_o1
 FTMOPA_ss       1000 0000 010 ..... 000 ... .... .. 00 ..       @tmop_o2
+
+BFTMOPA_sh      1000 0001 010 ..... 000 ... .... .. 00 ..       @tmop_o2
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index e57c56d5f2..91447d9c0e 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2679,6 +2679,50 @@ static void sme_tmop(void *vza, void *vzn, void *vzm, uint64_t *zk,
     }
 }
 
+/*
+ * Sparse outer product, widening 2-way, 16 to 32-bit.
+ */
+static void sme_tmop_2way_sh(uint32_t *za, uint16_t *zn0, uint32_t *zm,
+                             uint64_t *zk, void *fn_opaque, uint32_t desc,
+                             void (*fn)(void *, void *, void *, void *))
+{
+    intptr_t oprsz = simd_maxsz(desc);
+    intptr_t dim = oprsz >> MO_32;
+    intptr_t index = simd_data(desc);
+    intptr_t ctrl_base = (index * oprsz) >> 1;
+    uint16_t *zn1 = zn0 + sizeof(ARMVectorReg) / 2;
+
+    for (intptr_t row = 0; row < dim; row++) {
+        uint32_t *za_row = za + tile_vslice_offset(row);
+
+        for (intptr_t col = 0; col < dim; col++) {
+            uint32_t *e2 = zm + H4(col);
+            uint32_t *e3 = za_row + H4(col);
+            uint32_t e1 = 0;
+
+            /*
+             * Four control bits select two elements.  The two elements
+             * may be non-contiguous, so assemble them locally into e1.
+             * Pseudo-code has a double loop running forward, with a
+             * test for (i < 2) to limit construction to 2 elements.
+             * Easier to run a single loop backward, shifting extra
+             * elements off the top of our uint32_t.
+             */
+            uint64_t this_ctrl = extractn(zk, ctrl_base + col * 4, 4);
+            for (int i = 3; i >= 0; i--) {
+                if (this_ctrl & (1 << i)) {
+                    bool e = i & 1;
+                    bool r = i & 2;
+                    uint16_t *p = (r ? zn1 : zn0) + H2(2 * row + e);
+                    e1 = (e1 << 16) | *p;
+                }
+            }
+
+            fn(e3, &e1, e2, fn_opaque);
+        }
+    }
+}
+
 static void inner_fmop4a_hh(void *vd, void *vn, void *vm, void *vinfo)
 {
     float16 *d = vd, *n = vn, *m = vm;
@@ -2893,6 +2937,16 @@ void HELPER(sme_bfmop4a_sh)(void *vza, void *vzn, void *vzm,
                                 : inner_bfmop4a_sh);
 }
 
+void HELPER(sme_bftmopa_sh)(void *vza, void *vzn, void *vzm, void *vzk,
+                            CPUArchState *env, uint32_t desc)
+{
+    float_status fpst;
+
+    sme_tmop_2way_sh(vza, vzn, vzm, vzk, &fpst, desc,
+                     is_ebf(env, &fpst) ? inner_ebf_bfmop4a_sh
+                                        : inner_bfmop4a_sh);
+}
+
 static void inner_bfmop4s_sh(void *vd, void *vn, void *vm, void *vinfo)
 {
     float32 *d = vd;
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 04e1550c05..66bba48d99 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -2162,3 +2162,6 @@ TRANS_FEAT(FTMOPA_hh, aa64_sme_tmop_f16f16, do_tmop_fp,
            a, MO_16, FPST_ZA_F16, gen_helper_sme_ftmopa_hh)
 TRANS_FEAT(FTMOPA_ss, aa64_sme_tmop, do_tmop_fp,
            a, MO_32, FPST_ZA, gen_helper_sme_ftmopa_ss)
+
+TRANS_FEAT(BFTMOPA_sh, aa64_sme_tmop, do_tmop_fp,
+           a, MO_32, FPST_ENV, gen_helper_sme_bftmopa_sh)
-- 
2.43.0


