Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B296ECD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkeK-0004Qn-9G; Wed, 20 May 2026 13:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkeI-0004PU-QB
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:02 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkeH-0003a5-4F
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:02 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-44a14580111so3824523f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297840; x=1779902640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6pNcfHaTRa/5b8aBOv11Qwh7sxl5E8W3OHi3uNH/pc=;
 b=tkEa2sHAvsvaRYFSJi08ueymuJb0+Hqx5ZKJ20EFoG3TQ3oAHCCr5Nsyk41I9NL4Gw
 30FosGabh7rIdr/EjuUIe2j1MAfW8+cdxb/X/bFovzt9no9fVVA2zWfRuAJHKEYI0xv0
 vKqigI1pUbUfk5hTWL6Q6VuKWbcc3ZaL8p926i3PO+blgwD6k0SiqIsViYeYXIQiJtTv
 echHIkDohO5p6wKAx/Q6TEFhtyiNCigT75pzgxw3m3V6WFlk8n1cs7mGRjsSkCSAPn/h
 vzCGiC9lBPwg2JxxHsUEFD7BhDUAHyYIi191PjQy0jfvXcgD9Wl53HVPxbpXIncsffhG
 DZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297840; x=1779902640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y6pNcfHaTRa/5b8aBOv11Qwh7sxl5E8W3OHi3uNH/pc=;
 b=dkVAv9E/saGOoig8p1ZjYRIyCSm3MdbjG7DQj/11O0TrgdQd8tKoc147kredgSkUqt
 7yIjkIek2a55JkrLrv+46eZxnXxeSJ9G20bMAtpzeAQsMEcaJhSFeletcWZuD51ezXHz
 92tehtihf7MKj8XQCalhGDJ8oLR+i88snIFzlg/d8WtF6kZbQ6K6owBhKckMrqgh2aet
 OsMrZLGDp5usz/IXhQj3+NvI5wciZ944lgznLOYmfS3iKTXPhmJe6yZqPtvrZ6e4on8A
 7ubwPWy6LWaDOLGAKKnfMt5PqNc0HDZ+kVoijqnVT+CxfZc+0qgwYzR2nzGAYYKhMZvW
 dueg==
X-Gm-Message-State: AOJu0Yy6RqikhazSykyPAeuaKaKJSCO+OQQUFLGP0zCjgDm+r7rdicdv
 PByYDumAtTqI7plvgZRUUd0ntY04qg3zWoHodwB8sTW8WjV3/EwYW93CIY/+F1QDgPxIj2r9PvO
 hMueEiYc=
X-Gm-Gg: Acq92OHKVy0hlKtPsn6QwJarf1VV5OcMrKAhicJQseGQvuOWoiRCrjyKyuE9y+Jy+4R
 j06NzJUay8//FujBEP1AQbjv1b7fP5H9A01x265ILgVFwnTOwckrs+zpHBbyUGaaIi8Bwy7eDXy
 +e6JB8Qca55gMt6wY2I1lwOiZujXrWw1/loT7X8pI3Df5LU98jrdESCKZrssadYM01yqFDVXsfH
 OwSZUXaC6lYOT5EFEYXrUKZ62IaJCFkpreC4aQA/VLIMKG9PhoO734qhAvXWOzspu3s1eiXZoum
 +cW/cbxrJhxwWxW5UFImPlZqs4vmQ5zU6xz+jqEZs21TfibDQM/+sBrMjaSxBgUcxpFbID1DPET
 JCgfs57+JRHDIsHugfbu+IW9tD3LbKQ+RrhWvKEfN5CLo/QnqXHGN5xJlJpmsE/TxBps9+fq3cP
 pKIuEshZEToY/+/j4is17fa6r7804YbnqQbVw2YSH2ugmKMwykFVsJNe0E1fQ/h7gtqv7gj+Rzn
 c02zS/Z7u4=
X-Received: by 2002:a05:6000:2c11:b0:44d:261:54c5 with SMTP id
 ffacd0b85a97d-45e5c608d36mr40905565f8f.30.1779297839615; 
 Wed, 20 May 2026 10:23:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768acesm59494711f8f.7.2026.05.20.10.23.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:23:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 06/24] target/mips: fix Octeon arithmetic destination
 handling
Date: Wed, 20 May 2026 19:22:54 +0200
Message-ID: <20260520172313.23777-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

BADDU and DMUL write their results to rd, not rt.  Route writes through
gen_store_gpr() so rd == $zero is handled consistently.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon_translate.c            | 16 +++------
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 35 +++++++++++++++++++
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index e1f52d444aa..4dd76268350 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -45,18 +45,14 @@ static bool trans_BADDU(DisasContext *ctx, arg_BADDU *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
     tcg_gen_add_i64(t0, t0, t1);
-    tcg_gen_andi_i64(cpu_gpr[a->rd], t0, 0xff);
+    tcg_gen_andi_i64(t0, t0, 0xff);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
@@ -64,17 +60,13 @@ static bool trans_DMUL(DisasContext *ctx, arg_DMUL *a)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    tcg_gen_mul_i64(cpu_gpr[a->rd], t0, t1);
+    tcg_gen_mul_i64(t0, t0, t1);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index aef23fb9465..b7610db812e 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -7,7 +7,42 @@
 #include <assert.h>
 #include <stdint.h>
 
+static uint64_t octeon_baddu(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095028\n\t" /* baddu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_dmul(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095003\n\t" /* dmul $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
+    assert(octeon_baddu(0x123, 0x0f0) == 0x13);
+    assert(octeon_dmul(0x12345678, 0x10) == 0x123456780);
+
     return 0;
 }
-- 
2.53.0


