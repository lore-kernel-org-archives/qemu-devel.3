Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8B0C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3wov-00057w-AW; Mon, 06 May 2024 07:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wnD-0002bJ-J8
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:46:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmw-00026A-57
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+nWXIBRD4JwFRlPQUPhOrXxE5sdDw1a50waOf4VxWsU=; b=g/WoWmHSHwrT15PtlpLQHgXNfk
 N7oWyHjeAvTGjV+vLX2JMPs22ZbiI9Cvra0d4nHYGsbFd6uGIA0WS0WfA4oDlYKMADgaoG8FAev2f
 9L0peKwqDHh259QItx543UWjdSUBOwjdMHMFs0S7a+ipst8SHuV44oKkwPN0cZdEhMJH700MmdrUj
 fm6I1hr/YeMg9juejLRlHa3wQm3W9TLlLla8mmTjEtOkfI5uPmTSBLlL6irhSm2Yk2OHlI9HJRorH
 OPbCkZRAoPsneCKpTC+arQmhXoMwX9PwqD5/QWP8z8oYZyXc6JH6RtN5Z2HhJss+qeubx3b6uCo3+
 h46esu6Q5OjSIrtBAvlJPsdyWlcOrpisVIX6yD0H6VN9L3ZF9I/zO0uByFGytq/808l1QlJWZaOgw
 Xm9J08eh9PQlO/Bjgl8yz7StsSTRwFnyYKUjzrL6k/BVZpE0xmCSBVZE3BPItNk6ahHRjiPxJPN3Y
 2moUbqVDk7AzLMbykNX+H+32mwPZBBTalnYK1DnBjdzzQOiFOKTrLHzR7Vo/sdBKiAkeKpu+Dov7a
 MAEl3WEq0NDCw5ms6oxsI6epLEU4nvHCzBNWEerIRPBsgDnFfYb/vJwpOBSOmVlu5O3S7ilxqhcZM
 lwxOkXfFd2Px981cojTYJOe04+51hMUScgA7b+CpM=;
Received: from [2a00:23c4:8bb4:4000:b60d:a162:d698:c802]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wln-0005pA-LB; Mon, 06 May 2024 12:44:39 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Date: Mon,  6 May 2024 12:44:50 +0100
Message-Id: <20240506114451.331311-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
References: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:b60d:a162:d698:c802
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 11/12] target/sparc: Fix FPMERGE
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

This instruction has f32 inputs, which changes the decode
of the register numbers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240502165528.244004-7-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/helper.h     |  2 +-
 target/sparc/translate.c  |  2 +-
 target/sparc/vis_helper.c | 27 ++++++++++++++-------------
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index fcb9c617b7..97fbf6f66c 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -94,7 +94,7 @@ DEF_HELPER_FLAGS_2(fstox, TCG_CALL_NO_WG, s64, env, f32)
 DEF_HELPER_FLAGS_2(fdtox, TCG_CALL_NO_WG, s64, env, f64)
 DEF_HELPER_FLAGS_2(fqtox, TCG_CALL_NO_WG, s64, env, i128)
 
-DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
 DEF_HELPER_FLAGS_2(fmul8x16a, TCG_CALL_NO_RWG_SE, i64, i32, s32)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 8a2894bb9f..99c6f3cc72 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4656,6 +4656,7 @@ TRANS(FMUL8x16AU, VIS1, do_dff, a, gen_op_fmul8x16au)
 TRANS(FMUL8x16AL, VIS1, do_dff, a, gen_op_fmul8x16al)
 TRANS(FMULD8SUx16, VIS1, do_dff, a, gen_op_fmuld8sux16)
 TRANS(FMULD8ULx16, VIS1, do_dff, a, gen_op_fmuld8ulx16)
+TRANS(FPMERGE, VIS1, do_dff, a, gen_helper_fpmerge)
 
 static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i32, TCGv_i64))
@@ -4696,7 +4697,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
 
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
 TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
-TRANS(FPMERGE, VIS1, do_ddd, a, gen_helper_fpmerge)
 
 TRANS(FPADD16, VIS1, do_ddd, a, tcg_gen_vec_add16_i64)
 TRANS(FPADD32, VIS1, do_ddd, a, tcg_gen_vec_add32_i64)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 61c61c7fea..14c665cad6 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -74,22 +74,23 @@ typedef union {
     float32 f;
 } VIS32;
 
-uint64_t helper_fpmerge(uint64_t src1, uint64_t src2)
+uint64_t helper_fpmerge(uint32_t src1, uint32_t src2)
 {
-    VIS64 s, d;
+    VIS32 s1, s2;
+    VIS64 d;
 
-    s.ll = src1;
-    d.ll = src2;
+    s1.l = src1;
+    s2.l = src2;
+    d.ll = 0;
 
-    /* Reverse calculation order to handle overlap */
-    d.VIS_B64(7) = s.VIS_B64(3);
-    d.VIS_B64(6) = d.VIS_B64(3);
-    d.VIS_B64(5) = s.VIS_B64(2);
-    d.VIS_B64(4) = d.VIS_B64(2);
-    d.VIS_B64(3) = s.VIS_B64(1);
-    d.VIS_B64(2) = d.VIS_B64(1);
-    d.VIS_B64(1) = s.VIS_B64(0);
-    /* d.VIS_B64(0) = d.VIS_B64(0); */
+    d.VIS_B64(7) = s1.VIS_B32(3);
+    d.VIS_B64(6) = s2.VIS_B32(3);
+    d.VIS_B64(5) = s1.VIS_B32(2);
+    d.VIS_B64(4) = s2.VIS_B32(2);
+    d.VIS_B64(3) = s1.VIS_B32(1);
+    d.VIS_B64(2) = s2.VIS_B32(1);
+    d.VIS_B64(1) = s1.VIS_B32(0);
+    d.VIS_B64(0) = s2.VIS_B32(0);
 
     return d.ll;
 }
-- 
2.39.2


