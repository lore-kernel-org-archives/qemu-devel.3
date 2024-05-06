Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB6EC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3woT-0003eq-SV; Mon, 06 May 2024 07:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wms-0002Hv-6M
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:44 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmn-00024u-8v
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y5M4mmYouEfYYTQYVwtEst5GlagcgUaUVsX9+atwWag=; b=1iwXMLliFz1iZ7jZX7STosT1/h
 H8rWdYsYmUaBxDyuR+i5VTzQMzG9A+HalnfRiUZrFd1ftcb9doeb1Vg0l5ddAA/5LSFbBpep6SFgD
 UOZB7Hm2Qwn2Ht8oeCTnV5SR22wApFRqXfOsK4blCsFFYQYWDh2TBNt7KTt9YzUur1lCdAEFzT8YL
 P0Sdzq0WtltPorQFRMjjdgkabpm2O8mGQDezoDzZosM6OZxF9+L3iBvUHrtPdOr2j8uAunaRFSN3J
 ornR2Z0qcp5/RtwPgxb4MNfb7yoOco1jWyc5U22tL58XIAMnVQvnQd6LcXNgTK0W8zHV9/fnaaDPw
 WufwGBGBY221Dq+siYxVuh+LNJJ+HJSQXknBSIVEqeSkTURfpkoPWldGP07pcm2TOHBPH9LeUA9Vj
 vJYMYUfvBONt+zzkpaSS0uZlv7IotuphSG6n3TruhjZUoV2qiHUfqGfPJ4AWo6N4YsWtdJaM66xAJ
 0SR6XiwWde3mmJTjfR96M8OIWasufILf9uEnXotANwJDK41lsG1LBWzai+B7kjb8JsEDsSVeYSkY1
 WxBVSrZcUf71f8FgJOuChkBN4fuMW8PUniJs1qLJ9O4bLzRIjL3J4LZvgrexL8d1oacT+lg2jMIRl
 mjVjauCcdWuK+nkg4beOp7XHhmKGE1y7OJMOOFWqw=;
Received: from [2a00:23c4:8bb4:4000:b60d:a162:d698:c802]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wle-0005pA-RQ; Mon, 06 May 2024 12:44:30 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Date: Mon,  6 May 2024 12:44:47 +0100
Message-Id: <20240506114451.331311-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
References: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:b60d:a162:d698:c802
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 08/12] target/sparc: Fix FMUL8x16
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

This instruction has f32 as source1, which alters the
decoding of the register number, which means we've been
passing the wrong data for odd register numbers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240502165528.244004-4-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/helper.h     |  2 +-
 target/sparc/translate.c  | 21 ++++++++++++++++++++-
 target/sparc/vis_helper.c |  9 +++++----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 57ab755ffd..27dc604cac 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -95,7 +95,7 @@ DEF_HELPER_FLAGS_2(fdtox, TCG_CALL_NO_WG, s64, env, f64)
 DEF_HELPER_FLAGS_2(fqtox, TCG_CALL_NO_WG, s64, env, i128)
 
 DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
 DEF_HELPER_FLAGS_2(fmul8x16al, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8x16au, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index dfcfe855a1..c4adc148d2 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4583,6 +4583,26 @@ TRANS(FSUBs, ALL, do_env_fff, a, gen_helper_fsubs)
 TRANS(FMULs, ALL, do_env_fff, a, gen_helper_fmuls)
 TRANS(FDIVs, ALL, do_env_fff, a, gen_helper_fdivs)
 
+static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
+                   void (*func)(TCGv_i64, TCGv_i32, TCGv_i64))
+{
+    TCGv_i64 dst, src2;
+    TCGv_i32 src1;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    func(dst, src1, src2);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FMUL8x16, VIS1, do_dfd, a, gen_helper_fmul8x16)
+
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -4600,7 +4620,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
     return advance_pc(dc);
 }
 
-TRANS(FMUL8x16, VIS1, do_ddd, a, gen_helper_fmul8x16)
 TRANS(FMUL8x16AU, VIS1, do_ddd, a, gen_helper_fmul8x16au)
 TRANS(FMUL8x16AL, VIS1, do_ddd, a, gen_helper_fmul8x16al)
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index db2e6dd6c1..7728ffe9c6 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -94,16 +94,17 @@ uint64_t helper_fpmerge(uint64_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fmul8x16(uint64_t src1, uint64_t src2)
+uint64_t helper_fmul8x16(uint32_t src1, uint64_t src2)
 {
-    VIS64 s, d;
+    VIS64 d;
+    VIS32 s;
     uint32_t tmp;
 
-    s.ll = src1;
+    s.l = src1;
     d.ll = src2;
 
 #define PMUL(r)                                                 \
-    tmp = (int32_t)d.VIS_SW64(r) * (int32_t)s.VIS_B64(r);       \
+    tmp = (int32_t)d.VIS_SW64(r) * (int32_t)s.VIS_B32(r);       \
     if ((tmp & 0xff) > 0x7f) {                                  \
         tmp += 0x100;                                           \
     }                                                           \
-- 
2.39.2


