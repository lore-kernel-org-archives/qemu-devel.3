Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009FAC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzRzF-0007UQ-05; Thu, 27 Aug 2026 00:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRzC-0007OX-Cg
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:45:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRz9-0005t7-La
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:45:09 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-84862b0d5f8so1843721b3a.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787805906; x=1788410706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Qjk02ZAxBbTb8ZjUG+NiP95daHxNguBm9x44gRcP40=;
 b=GhkB+4nLZZFSSffccWLiOIXfCN2pQu8ZODOaCSTOrCONnv082M1Pf3827DU/iv5Hbf
 svwjQ+hdZhNUA6WeSaf+WseEsCnA2wAsdYJw/Mc0vav8uvXOjCBzSVK+6M4Kyvm8Jg5C
 Kdxifosg95CWkCQvEWrrwRG4RAjTeW3AxuE1Qf6QbFR2NWNsknheJG24b/r6uBXHPO3u
 JZgPnH2Bl1g9Cn1wqx5zeTz8giws3JUnUysomOB1115GDcHwG8aSn/WYBA2EcuPaMTrd
 QPERtwzOAjixRYYa+n5a1lHrVndKWTrHQyjsB8rdpgceKfSlv7wGJojaLq9gIMqtNTs2
 94Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787805906; x=1788410706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Qjk02ZAxBbTb8ZjUG+NiP95daHxNguBm9x44gRcP40=;
 b=e5rPgY61eiluzVZ/VG3yFm/DPbJdggaElWcLHLZHZqBR95BUYWba7n24hyDWKu6U0R
 OjZYaik4LgmfOK+5kOUS56+lUULlfFEQwhzsvVTYcOBZ9hpII75tbwztdQSHk0Q/6Saw
 elP2ZZoXi8J5nsAqIFMTf6Mb4onfOcab0wyvy9T3+Ac2b5CpSdnFJHgT8bHu5Slnhtlp
 mGWmldU+cwt1HwDy6yiCT4eayL3ggDvMglNdmqtLDOaJ7fRwWy2sgVX5W4ljV2g9/1vP
 xHCRd8pvKhBQ4jj7ufO5DUXy8V/+B4lNNm9rCi0K7YfQIh+TrpG0e6gV3Y02ZG8w62m0
 ntew==
X-Gm-Message-State: AFuF++lFvdy/N1Toh8d+z6/zfKj3ptB2XA+kxBj9ObZfJVpCutsK5Xit
 j4GoERqBS9BqDcZ5Os2JkwlwK4Pkj1zWuVbNtIwM3YW+ez6ninih0cgtIlji66sVOK8AYOAsCrZ
 2Wr4Cndk=
X-Gm-Gg: AR+sD12rznoMWsUwoTTSHjTf3lvtaeRy5YT3DJUqZOc8gI7qVCPLYTwlNEmU0UXjoms
 ZKm6c8psI2ofUp4VK5GCHR6ooMBB+rNKuR+GSJLX+kc3DMCSWBIHfGsmH+aShZxfleyDi/xlmAT
 NfVBlZ11lCBuwJ9hYs7N7rAxe7oAuZNySOx3iTXmB/WBiVio4+Myj4Vrep6I/S0nM74Yqst+5Bz
 b7eWoAmzgCF2vsOX/KO5ghivWiZWertszlBrL52fqG0THCZ2LpoU8TCdADG3yJ83aeoukbnXtX/
 NzQ0MI3SyOQovxZs9KePevidwcHWpDkT2LunE399zo+6uoIVIayZd7LpLd1TqXGByyO0GNJr3MT
 31gldbh718dfMBlmA0h4HL8iFltHh1wKqPqRhjXk9mhEmzX+i9qMezCv//znKC6CK13eJBnLCjL
 WHwsIOI49mXxFHP+KwRKaU+DA2dFZ3QNoFwDoWDkz5wBy1ga1P0KVeXZOaeS+ng9g3cEFQqvjO3
 yd87pdXN9AN6HkKLw==
X-Received: by 2002:a05:6a00:ccf:b0:845:ba94:a56 with SMTP id
 d2e1a72fcca58-8537259ed94mr21088723b3a.5.1787805906021; 
 Wed, 26 Aug 2026 21:45:06 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm1606003b3a.44.2026.08.26.21.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 21:45:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: yujun <yujun@kylinos.cn>
Subject: [PULL 3/4] tcg/aarch64: Use tgen_brcondi in tcg_out_qemu_ldst_i128
Date: Wed, 26 Aug 2026 21:45:01 -0700
Message-ID: <20260827044502.778915-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827044502.778915-1-richard.henderson@linaro.org>
References: <20260827044502.778915-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Allow tgen_brcondi to choose between TBNZ and TST+B.cond for
implementing a particular mask.

Suggested-by: yujun <yujun@kylinos.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 1e64c5994e0..4ebdef7e077 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1916,23 +1916,18 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
     use_pair = h.aa.atom < MO_128 || have_lse2;
 
     if (!use_pair) {
-        tcg_insn_unit *branch = NULL;
+        TCGLabel *label = NULL;
         TCGReg ll, lh, sl, sh;
-
         /*
-         * If we have already checked for 16-byte alignment, that's all
-         * we need. Otherwise we have determined that misaligned atomicity
-         * may be handled with two 8-byte loads.
+         * Check for 16-byte alignment, taking into consideration the
+         * alignment that has already been checked.
          */
-        if (h.aa.align < MO_128) {
-            /*
-             * TODO: align should be MO_64, so we only need test bit 3,
-             * which means we could use TBNZ instead of ANDS+B_C.
-             */
-            tcg_out_logicali(s, Ilogic_imm_ANDSI, 0, TCG_REG_XZR, addr_reg,
-                             15);
-            branch = s->code_ptr;
-            tcg_out_insn(s, bcond_imm, B_C, TCG_COND_NE, 0);
+        int a_mask = 16 - (1 << h.aa.align);
+
+        if (a_mask > 0) {
+            label = gen_new_label();
+            tgen_brcondi(s, TCG_TYPE_I32, TCG_COND_TSTNE,
+                         addr_reg, a_mask, label);
             use_pair = true;
         }
 
@@ -1971,7 +1966,7 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
         if (use_pair) {
             /* "b .+8", branching across the one insn of use_pair. */
             tcg_out_insn(s, branch, B, 2);
-            reloc_pc19(branch, tcg_splitwx_to_rx(s->code_ptr));
+            tcg_out_label(s, label);
         }
     }
 
-- 
2.53.0


