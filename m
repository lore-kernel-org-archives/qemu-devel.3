Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2901BC4829A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 10:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXIw1-0006wl-PO; Tue, 06 Feb 2024 05:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIvz-0006vg-SV
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:44:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIvx-0003DW-Gf
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707216241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEW/TtszoO0nHfwcNqAzABmv9qoplOiNeag/V+k8BeE=;
 b=GA25EbVw1cm1Dlenm+2Z4rVEHx2u4+r6RUTCP9EwYEZg9eZCeunaRCRYvVsgDotjlp771/
 ugARJTl3jq/UsiGqQ4tpUN5+WzuCcAfQxlRQzs4dxERNxmgipoLQpQYUgyi7b5C//4ZNI3
 9hZGJmoVvQYAewGunAN5j88DDlJiMxI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-tUG88vZlOdSiexLqLjLUvg-1; Tue, 06 Feb 2024 05:43:59 -0500
X-MC-Unique: tUG88vZlOdSiexLqLjLUvg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F421F10193AE;
 Tue,  6 Feb 2024 10:43:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A913C492BF0;
 Tue,  6 Feb 2024 10:43:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Subject: [PULL 05/12] target/s390x: Emulate CVB, CVBY and CVBG
Date: Tue,  6 Feb 2024 11:43:40 +0100
Message-ID: <20240206104347.238825-6-thuth@redhat.com>
In-Reply-To: <20240206104347.238825-1-thuth@redhat.com>
References: <20240206104347.238825-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Convert to Binary - counterparts of the already implemented Convert
to Decimal (CVD*) instructions.
Example from the Principles of Operation: 25594C becomes 63FA.

Co-developed-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240205205830.6425-3-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/helper.h            |  2 +
 target/s390x/tcg/insn-data.h.inc |  4 ++
 target/s390x/tcg/int_helper.c    | 76 ++++++++++++++++++++++++++++++++
 target/s390x/tcg/translate.c     | 16 +++++++
 4 files changed, 98 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 332a9a9c63..cc1c20e9e3 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -88,6 +88,8 @@ DEF_HELPER_FLAGS_3(tcxb, TCG_CALL_NO_RWG_SE, i32, env, i128, i64)
 DEF_HELPER_FLAGS_2(sqeb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(sqxb, TCG_CALL_NO_WG, i128, env, i128)
+DEF_HELPER_3(cvb, void, env, i32, i64)
+DEF_HELPER_FLAGS_2(cvbg, TCG_CALL_NO_WG, i64, env, i128)
 DEF_HELPER_FLAGS_1(cvd, TCG_CALL_NO_RWG_SE, i64, s32)
 DEF_HELPER_FLAGS_1(cvdg, TCG_CALL_NO_RWG_SE, i128, s64)
 DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 388dcb8dbb..e7d61cdec2 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -293,6 +293,10 @@
     D(0xec73, CLFIT,   RIE_a, GIE, r1_32u, i2_16u, 0, 0, ct, 0, 1)
     D(0xec71, CLGIT,   RIE_a, GIE, r1_o, i2_16u, 0, 0, ct, 0, 1)
 
+/* CONVERT TO BINARY */
+    C(0x4f00, CVB,     RX_a,  Z,   la2, 0, 0, 0, cvb, 0)
+    C(0xe306, CVBY,    RXY_a, LD,  la2, 0, 0, 0, cvb, 0)
+    C(0xe30e, CVBG,    RXY_a, Z,   la2, 0, r1, 0, cvbg, 0)
 /* CONVERT TO DECIMAL */
     C(0x4e00, CVD,     RX_a,  Z,   r1_o, a2, 0, 0, cvd, 0)
     C(0xe326, CVDY,    RXY_a, LD,  r1_o, a2, 0, 0, cvd, 0)
diff --git a/target/s390x/tcg/int_helper.c b/target/s390x/tcg/int_helper.c
index 121e3006a6..2af970f2c8 100644
--- a/target/s390x/tcg/int_helper.c
+++ b/target/s390x/tcg/int_helper.c
@@ -25,6 +25,7 @@
 #include "exec/exec-all.h"
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
+#include "exec/cpu_ldst.h"
 
 /* #define DEBUG_HELPER */
 #ifdef DEBUG_HELPER
@@ -98,6 +99,81 @@ Int128 HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al, uint64_t b)
     tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
 }
 
+void HELPER(cvb)(CPUS390XState *env, uint32_t r1, uint64_t dec)
+{
+    int64_t pow10 = 1, bin = 0;
+    int digit, sign;
+
+    sign = dec & 0xf;
+    if (sign < 0xa) {
+        tcg_s390_data_exception(env, 0, GETPC());
+    }
+    dec >>= 4;
+
+    while (dec) {
+        digit = dec & 0xf;
+        if (digit > 0x9) {
+            tcg_s390_data_exception(env, 0, GETPC());
+        }
+        dec >>= 4;
+        bin += digit * pow10;
+        pow10 *= 10;
+    }
+
+    if (sign == 0xb || sign == 0xd) {
+        bin = -bin;
+    }
+
+    /* R1 is updated even on fixed-point-divide exception. */
+    env->regs[r1] = (env->regs[r1] & 0xffffffff00000000ULL) | (uint32_t)bin;
+    if (bin != (int32_t)bin) {
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+    }
+}
+
+uint64_t HELPER(cvbg)(CPUS390XState *env, Int128 dec)
+{
+    uint64_t dec64[] = {int128_getlo(dec), int128_gethi(dec)};
+    int64_t bin = 0, pow10, tmp;
+    int digit, i, sign;
+
+    sign = dec64[0] & 0xf;
+    if (sign < 0xa) {
+        tcg_s390_data_exception(env, 0, GETPC());
+    }
+    dec64[0] >>= 4;
+    pow10 = (sign == 0xb || sign == 0xd) ? -1 : 1;
+
+    for (i = 1; i < 20; i++) {
+        digit = dec64[i >> 4] & 0xf;
+        if (digit > 0x9) {
+            tcg_s390_data_exception(env, 0, GETPC());
+        }
+        dec64[i >> 4] >>= 4;
+        /*
+         * Prepend the next digit and check for overflow. The multiplication
+         * cannot overflow, since, conveniently, the int64_t limits are
+         * approximately +-9.2E+18. If bin is zero, the addition cannot
+         * overflow. Otherwise bin is known to have the same sign as the rhs
+         * addend, in which case overflow happens if and only if the result
+         * has a different sign.
+         */
+        tmp = bin + pow10 * digit;
+        if (bin && ((tmp ^ bin) < 0)) {
+            tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+        }
+        bin = tmp;
+        pow10 *= 10;
+    }
+
+    g_assert(!dec64[0]);
+    if (dec64[1]) {
+        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
+    }
+
+    return bin;
+}
+
 uint64_t HELPER(cvd)(int32_t reg)
 {
     /* positive 0 */
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index c2fdc920a5..325b25959d 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2223,6 +2223,22 @@ static DisasJumpType op_csp(DisasContext *s, DisasOps *o)
 }
 #endif
 
+static DisasJumpType op_cvb(DisasContext *s, DisasOps *o)
+{
+    TCGv_i64 t = tcg_temp_new_i64();
+    tcg_gen_qemu_ld_i64(t, o->addr1, get_mem_index(s), MO_TEUQ);
+    gen_helper_cvb(tcg_env, tcg_constant_i32(get_field(s, r1)), t);
+    return DISAS_NEXT;
+}
+
+static DisasJumpType op_cvbg(DisasContext *s, DisasOps *o)
+{
+    TCGv_i128 t = tcg_temp_new_i128();
+    tcg_gen_qemu_ld_i128(t, o->addr1, get_mem_index(s), MO_TE | MO_128);
+    gen_helper_cvbg(o->out, tcg_env, t);
+    return DISAS_NEXT;
+}
+
 static DisasJumpType op_cvd(DisasContext *s, DisasOps *o)
 {
     TCGv_i64 t1 = tcg_temp_new_i64();
-- 
2.43.0


