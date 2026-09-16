Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DCAC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6mRo-0008An-2B; Wed, 16 Sep 2026 06:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRc-00086o-Re
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:50 -0400
Received: from qs-2003h-snip6-3.eps.apple.com ([2a01:b747:3006:204::4c]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRW-0005DT-Fj
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:45 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPS id
 5D18218009F5; Wed, 16 Sep 2026 10:00:37 +0000 (UTC)
X-ICL-RepId: 01a0a9a9-4287-744a-971c-1eaf631e3b42
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0ISxMFUgddTVYNRw9YHlwUFwlAQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wLSAFbB1IDRghIA10FWhxHCkABWBpYHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789552841; x=1792144841;
 bh=5gD9T2JNnhAfwEF4HwlMjEqcrc+zMBpch1LWxK38wpE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=iOjeBAnYqG6sa/nibF4RhX0zkxffKjUjMIsvhOY+n6DCvkxxNyGmymPaXaCuUzYdbbysaJsYYLpdgYZutgEH/mUQRQB1a7rIeh0NAYkaUn3L8zZMbURBpA3qjzu8dYgbAoABySZ8E7I/Z4fVZ9I59MENrgagjSxsMVXEieJbQVr9+o/kzHlrW+2p4Gbvkc21llwR/El3d2Sj7O2aTD/pcrbta9IxoRtaVOPHPHgYnGGUAbmhVVfSTX/HdpoY9b1waZI77vgn0jfpyMzTaYdD3ua7LsFEqCgS85kiHsVHQQTy7N6VpYsBl8uWfStzFUsV+IeXgcm1n0eI9nLp+1JoIg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPSA id
 D94EF18009F6; Wed, 16 Sep 2026 10:00:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Lucas Amaral <lucaaamaral@gmail.com>
Subject: [RFC PATCH v8 02/10] target/arm/emulate: add load/store register
 offset
Date: Wed, 16 Sep 2026 12:00:10 +0200
Message-ID: <20260916100021.73825-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916100021.73825-1-mohamed@unpredictable.fr>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 984moXqKJIxSqw5wEwh9pePK8liwt0Aa
X-Proofpoint-ORIG-GUID: 984moXqKJIxSqw5wEwh9pePK8liwt0Aa
X-Authority-Info-Out: v=2.4 cv=EfPFgfmC c=1 sm=1 tr=0 ts=6aaa68c7
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=6j-v74XZrVUtoDfXaNsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzMCBTYWx0ZWRfXxudNgzkt9DV2
 jpRHOgSKWUTby3E5fLd0CDgZl7u99FwKrX+Uk195vHwrSihJrZMYINzfZMIsPzTl4nNDX4fl9bC
 83OfaQf2vYcXymxveEu81DHjyFyANtx4ur5yTtW1Wvvap8smQxsXewDEj3T6Wa23MDD+OGwwVeJ
 Ba7S4d3F0rzVcf48OmQEmHkRKZ3UYRACUTxWjvgtNY86X328QSEd1rCV5qPeJ/ExXeDRp3FMI+h
 /cjZaEZjlWGHK3/nzFvPO7vUwdcGYkzW8WiXCVI+v+KCb8X08F8iDVO2g22Ki5fBRRTph7igtSQ
 kfB/Mu19+1mPsiDys97zXrTXV1JiwU+1/QvtVPtOIeeQsUnURF1kOEC9IO0BO8=
X-JNJ: AAAAAAABh99Pw5na1q9WV0vOrxmCBWTghzXk1lf5TxLshNvCGlt04zpYadJuJOruNcemy9SqRDPTMgpT9b3Wp96t7PFGqeM2CFqVMd4wTe8FFBxM8TMLL4UjWpZE2NYOosZIho+WR+2oF25dNUdgNqjRatHdmvwEo0e9SJOPztjKU72PsZcuLGhyQCKxNV5KH89d4oR0rxPPykIaA8ypEZPXirmEB6l2ogtarlAgy3DbKZnHaBoexUlp2fd7l6P7YMOUnDmE2G4Id+EtdvtCGTrYMLi/aZx41TAaXG/Al+tg7xU9Zg54+Ni4qSs++f13o1EHkRC3XNBxx4IrJV5P7PNfTDNfwY0R7U11h5Zf4Pw1BFIZqckXCsIjipupaX+YcVhDp7EOdvHop/q8XJcbSkAYDd3W0JscRyXy7Ab0dzXCXRolG/abAXYgflpMno4yL3HonjSrS4OkHoBIphl0DR4vnIwHS50Kz6kwRJQ3EwJHRW6lxqIOUIriMCmQ/sUmIJu3urbxzzJVFoW08+TxL2Pl6k99hvDSkW6t4vqF4OUzXsGge0rN7xtEhmEJ55m1/BIwxVWcfnb7XXf+t08164+K1CXXp9hn8Ep+mIvQm76Bu5pfjHs+IkRjk+hBBLUvzBsTu/cE2jtmF9tsDFnz3R/Im+wLiZoJPReRWIcF3DP9xBIeR9xomLA8BZzKMxULO9s5OJvboCUzci2JjSGdNdoje19Ih+QjEkyPf9f0HB6ESlQMXQ7RXfPeDck+vZzhK3OTtxjcCni3+2lovlSUEekaD97XfogsqJaaPJMesOAue1M7G0QoWSTViecBucAKRk4oTee5OxDBjEBzMO4QyWqt
Received-SPF: pass client-ip=2a01:b747:3006:204::4c;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

From: Lucas Amaral <lucaaamaral@gmail.com>

Add emulation for load/store register offset addressing mode
(DDI 0487 C3.3.9).  The offset register value is extended via
UXTB/UXTH/UXTW/UXTX/SXTB/SXTH/SXTW/SXTX and optionally
shifted by the element size.

Instruction coverage:
  - STR/LDR (GPR): register offset with extend, all sizes
  - STR/LDR (SIMD/FP): register offset with extend, 8-128 bit
  - PRFM register offset: NOP

Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
---
 target/arm/emulate/a64-ldst.decode |  29 ++++++++
 target/arm/emulate/arm_emulate.c   | 103 +++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/target/arm/emulate/a64-ldst.decode b/target/arm/emulate/a64-ldst.decode
index c887dcba7d..af6babe14a 100644
--- a/target/arm/emulate/a64-ldst.decode
+++ b/target/arm/emulate/a64-ldst.decode
@@ -10,6 +10,9 @@
 # 'u' flag: 0 = 9-bit signed immediate (byte offset), 1 = 12-bit unsigned (needs << sz)
 &ldst_imm       rt rn imm sz sign w p unpriv ext u
 
+# Load/store register offset
+&ldst           rm rn rt sign ext sz opt s
+
 ### Format templates
 
 # Load/store immediate (9-bit signed)
@@ -21,6 +24,9 @@
 # Load/store unsigned offset (12-bit, handler scales by << sz)
 @ldst_uimm      .. ... . .. .. imm:12 rn:5 rt:5        &ldst_imm u=1 unpriv=0 p=0 w=0
 
+# Load/store register offset
+@ldst           .. ... . .. .. . rm:5 opt:3 s:1 .. rn:5 rt:5   &ldst
+
 ### Load/store register — unscaled immediate (LDUR/STUR)
 
 # GPR
@@ -122,6 +128,29 @@ STR_v_i         00 111 1 01 10 ............ ..... .....         @ldst_uimm sign=
 LDR_v_i         sz:2 111 1 01 01 ............ ..... .....       @ldst_uimm sign=0 ext=0
 LDR_v_i         00 111 1 01 11 ............ ..... .....         @ldst_uimm sign=0 ext=0 sz=4
 
+### Load/store register — register offset
+
+# GPR
+STR             sz:2 111 0 00 00 1 ..... ... . 10 ..... .....  @ldst sign=0 ext=0
+LDR             00 111 0 00 01 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=1 sz=0
+LDR             01 111 0 00 01 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=1 sz=1
+LDR             10 111 0 00 01 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=1 sz=2
+LDR             11 111 0 00 01 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=0 sz=3
+LDR             00 111 0 00 10 1 ..... ... . 10 ..... .....    @ldst sign=1 ext=0 sz=0
+LDR             01 111 0 00 10 1 ..... ... . 10 ..... .....    @ldst sign=1 ext=0 sz=1
+LDR             10 111 0 00 10 1 ..... ... . 10 ..... .....    @ldst sign=1 ext=0 sz=2
+LDR             00 111 0 00 11 1 ..... ... . 10 ..... .....    @ldst sign=1 ext=1 sz=0
+LDR             01 111 0 00 11 1 ..... ... . 10 ..... .....    @ldst sign=1 ext=1 sz=1
+
+# PRFM — register offset
+NOP             11 111 0 00 10 1 ----- -1- - 10 ----- -----
+
+# SIMD/FP
+STR_v           sz:2 111 1 00 00 1 ..... ... . 10 ..... .....  @ldst sign=0 ext=0
+STR_v           00 111 1 00 10 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=0 sz=4
+LDR_v           sz:2 111 1 00 01 1 ..... ... . 10 ..... .....  @ldst sign=0 ext=0
+LDR_v           00 111 1 00 11 1 ..... ... . 10 ..... .....    @ldst sign=0 ext=0 sz=4
+
 ### System instructions — DC cache maintenance
 
 # SYS with CRn=C7 covers all data cache operations (DC CIVAC, CVAC, etc.).
diff --git a/target/arm/emulate/arm_emulate.c b/target/arm/emulate/arm_emulate.c
index 02fefc30bf..bf09e2a67b 100644
--- a/target/arm/emulate/arm_emulate.c
+++ b/target/arm/emulate/arm_emulate.c
@@ -211,6 +211,109 @@ static bool trans_LDR_v_i(DisasContext *ctx, arg_ldst_imm *a)
     return true;
 }
 
+/* Register offset extension (DDI 0487 C6.2.131) */
+
+static uint64_t extend_reg(uint64_t val, int option, int shift)
+{
+    switch (option) {
+    case 0: /* UXTB */
+        val = (uint8_t)val;
+        break;
+    case 1: /* UXTH */
+        val = (uint16_t)val;
+        break;
+    case 2: /* UXTW */
+        val = (uint32_t)val;
+        break;
+    case 3: /* UXTX / LSL */
+        break;
+    case 4: /* SXTB */
+        val = (int64_t)(int8_t)val;
+        break;
+    case 5: /* SXTH */
+        val = (int64_t)(int16_t)val;
+        break;
+    case 6: /* SXTW */
+        val = (int64_t)(int32_t)val;
+        break;
+    case 7: /* SXTX */
+        break;
+    }
+    return val << shift;
+}
+
+/*
+ * Load/store single -- register offset (GPR)
+ * STR / LDR (DDI 0487 C3.3.9)
+ */
+
+static bool trans_STR(DisasContext *ctx, arg_ldst *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int shift = a->s ? a->sz : 0;
+    uint64_t rm_val = gpr_read(ctx, a->rm);
+    uint64_t offset = extend_reg(rm_val, a->opt, shift);
+    uint64_t va = base_read(ctx, a->rn) + offset;
+
+    uint64_t val = gpr_read(ctx, a->rt);
+    mem_write(ctx, va, &val, esize);
+    return true;
+}
+
+static bool trans_LDR(DisasContext *ctx, arg_ldst *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int shift = a->s ? a->sz : 0;
+    uint64_t rm_val = gpr_read(ctx, a->rm);
+    uint64_t offset = extend_reg(rm_val, a->opt, shift);
+    uint64_t va = base_read(ctx, a->rn) + offset;
+    uint64_t val = 0;
+
+    if (mem_read(ctx, va, &val, esize) != 0) {
+        return true;
+    }
+
+    val = load_extend(val, a->sz, a->sign, a->ext);
+    gpr_write(ctx, a->rt, val);
+    return true;
+}
+
+/*
+ * Load/store single -- register offset (SIMD/FP)
+ * STR_v / LDR_v (DDI 0487 C3.3.10)
+ */
+
+static bool trans_STR_v(DisasContext *ctx, arg_ldst *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int shift = a->s ? a->sz : 0;
+    uint64_t rm_val = gpr_read(ctx, a->rm);
+    uint64_t offset = extend_reg(rm_val, a->opt, shift);
+    uint64_t va = base_read(ctx, a->rn) + offset;
+    uint8_t buf[16];
+
+    fpreg_read(ctx, a->rt, buf, esize);
+    mem_write(ctx, va, buf, esize);
+    return true;
+}
+
+static bool trans_LDR_v(DisasContext *ctx, arg_ldst *a)
+{
+    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
+    int shift = a->s ? a->sz : 0;
+    uint64_t rm_val = gpr_read(ctx, a->rm);
+    uint64_t offset = extend_reg(rm_val, a->opt, shift);
+    uint64_t va = base_read(ctx, a->rn) + offset;
+    uint8_t buf[16];
+
+    if (mem_read(ctx, va, buf, esize) != 0) {
+        return true;
+    }
+
+    fpreg_write(ctx, a->rt, buf, esize);
+    return true;
+}
+
 /* PRFM, DC cache maintenance -- treated as NOP */
 static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
 {
-- 
2.54.0 (Apple Git-157)


