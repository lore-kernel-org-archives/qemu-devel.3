Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BFECCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mx6-0003dC-Tp; Thu, 16 Oct 2025 08:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mwa-0002NS-9h
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:58 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MwV-0008Tf-RI
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:18:55 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42701b29a7eso254815f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617125; x=1761221925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P7blmDCF8sM42OmGl4/6ogMGKaMzc2e24JLbAyfldN8=;
 b=Phv/ulrzrHjFanZnyN990jjGvRQ2rsNnglkEdZPOzW0GGBuSQ+mskJ5mwutlp7UraK
 LK672t2fQNCl57ViWspK7OkOk0ulfFm1u1vk3Ahh4/oiUQ+xFEU2VDkA0S4OCoRnYWsR
 uOiyRy6NeX1yfezcaCDuYnix46xHfR+wZcmzCT1kbZ1wdJUJLOfdCz3UR7QzdpiGQsXj
 9YFDh3YHK1am3tsxh0ghtSbRNgEN2vy6os6XFYyE0Vji3Znz194t6gwlRKtvAIaM3sZ5
 r5yjJD7DZOikQkCHi200O+R/nd8/7YotUiMskmzRIt82L7lNfMgedC9y6HCSqNdsGqse
 /2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617125; x=1761221925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P7blmDCF8sM42OmGl4/6ogMGKaMzc2e24JLbAyfldN8=;
 b=axTe1uWZEm99WdfgafTE22ZXjp2VCTqjIYxvEdJJiuaxSrQN3rTQ66fw8uFShcriC6
 CvGiV9/QkBprc8IWz2CuSO49I6ZIbK3nQdRs4nidlPOEzannD63LsE4YudDGCO5k+Xxu
 YJJBpHdsb7k+Gj+xW9hJ/PEqjYjuFaSCDHke8TvCI+Jw5fb0p1PayJFNoBGHy245jfdn
 ufhe7XZe1ryec8n+uZ+K1QB5O+lqzy77jfRIm9ad9hNkTazBcyyZxGe6KTEoNudeN1TO
 ropDbvE3HoHGR3FzM1bogu33mXlCKQqzV6XRHk4cQJfhldGWQ3ALUOscmAUBLvzK/TQq
 HLyw==
X-Gm-Message-State: AOJu0YwrwxrHNkHOu5aB+8kkreWOKex3vKIslmT4FpxF9ihuW/IClcrH
 bD5V1PGpbUamcK1dRIbyC3x4LH0jauHIBAUk+xmWrE+6s9d4R5yVn6+zcsejy/jvkxeXyDgzkca
 KNSjQZoA=
X-Gm-Gg: ASbGncvTG6+QM36f9bCEo7kPXUa/WoDn4EnLTIeJSmkn1BCDlxrlIkmvatVmWhuDSG1
 1KV9vr86nCe5cI0dJ2KQyfgO4jkN8BB7BLSvjt6XvtH8abLaRAeuA+IRsBzONGMjaqZgpSC2i9T
 wMdKKo140o1orJOfpbUtzl1VanlWmVTsGAHkyDy49QpCL4VGBU7jCxIkZHuaJZr+MSE48Ueum8K
 BpdnTfDwRaYC3O/NVdZjG9sbVsfl0sCDujU1rGc+/w5u+hgBoWfPksa0ZUCLRHNjz3Bs0bGZAyk
 H+nTzUdhtDbdEL2eQJW8HXBabifRK5DCFTwxUJ+2LzBiuNKL67ohRD3LjQJGMnff45D5K6LNqza
 p/73QjoDFcOSEazkEiDO22MUnEa9HYYnmSXrIoT3E5kMdCrRdBnhy6mNrTRU3OhsKspO6MVG6W3
 hkYKtVah7XFK19469RdagxGjB9Bejd0gmungE3IbRz5AZEE1ECOoYYcA==
X-Google-Smtp-Source: AGHT+IHcXQUpI4FtgE/qAVc9LGgOPMskwWaC4SljugD3J9veTmb6B7Rk4ZcbgMtjgxNFM3RhSp/8QA==
X-Received: by 2002:a05:6000:2c06:b0:3e9:54d1:e708 with SMTP id
 ffacd0b85a97d-426fb7ab8abmr2235135f8f.20.1760617124909; 
 Thu, 16 Oct 2025 05:18:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42704141cd0sm1034058f8f.11.2025.10.16.05.18.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:18:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/75] target/riscv: Replace HOST_BIG_ENDIAN #ifdef with if()
 check
Date: Thu, 16 Oct 2025 14:14:57 +0200
Message-ID: <20251016121532.14042-42-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Replace preprocessor-time #ifdef with a compile-time check
to ensure all code paths are built and tested. This reduces
build-time configuration complexity and simplifies code
maintainability.

No functional change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20251010134226.72221-14-philmd@linaro.org>
---
 target/riscv/vector_helper.c            | 32 ++++++++++++-------------
 target/riscv/insn_trans/trans_rvv.c.inc | 16 ++++++-------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 41ea2231067..2de3358ee86 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -235,26 +235,26 @@ vext_continuous_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
                         void *vd, uint32_t evl, uint32_t reg_start, void *host,
                         uint32_t esz, bool is_load)
 {
-#if HOST_BIG_ENDIAN
-    for (; reg_start < evl; reg_start++, host += esz) {
-        ldst_host(vd, reg_start, host);
-    }
-#else
-    if (esz == 1) {
-        uint32_t byte_offset = reg_start * esz;
-        uint32_t size = (evl - reg_start) * esz;
-
-        if (is_load) {
-            memcpy(vd + byte_offset, host, size);
-        } else {
-            memcpy(host, vd + byte_offset, size);
-        }
-    } else {
+    if (HOST_BIG_ENDIAN) {
         for (; reg_start < evl; reg_start++, host += esz) {
             ldst_host(vd, reg_start, host);
         }
+    } else {
+        if (esz == 1) {
+            uint32_t byte_offset = reg_start * esz;
+            uint32_t size = (evl - reg_start) * esz;
+
+            if (is_load) {
+                memcpy(vd + byte_offset, host, size);
+            } else {
+                memcpy(host, vd + byte_offset, size);
+            }
+        } else {
+            for (; reg_start < evl; reg_start++, host += esz) {
+                ldst_host(vd, reg_start, host);
+            }
+        }
     }
-#endif
 }
 
 static void vext_set_tail_elems_1s(target_ulong vl, void *vd,
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index f4b5460340e..2a487179f63 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -3351,19 +3351,19 @@ static void load_element(TCGv_i64 dest, TCGv_ptr base,
 /* offset of the idx element with base register r */
 static uint32_t endian_ofs(DisasContext *s, int r, int idx)
 {
-#if HOST_BIG_ENDIAN
-    return vreg_ofs(s, r) + ((idx ^ (7 >> s->sew)) << s->sew);
-#else
-    return vreg_ofs(s, r) + (idx << s->sew);
-#endif
+    if (HOST_BIG_ENDIAN) {
+        return vreg_ofs(s, r) + ((idx ^ (7 >> s->sew)) << s->sew);
+    } else {
+        return vreg_ofs(s, r) + (idx << s->sew);
+    }
 }
 
 /* adjust the index according to the endian */
 static void endian_adjust(TCGv_i32 ofs, int sew)
 {
-#if HOST_BIG_ENDIAN
-    tcg_gen_xori_i32(ofs, ofs, 7 >> sew);
-#endif
+    if (HOST_BIG_ENDIAN) {
+        tcg_gen_xori_i32(ofs, ofs, 7 >> sew);
+    }
 }
 
 /* Load idx >= VLMAX ? 0 : vreg[idx] */
-- 
2.51.0


