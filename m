Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A577CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYhV-0001bA-JA; Wed, 20 May 2026 00:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYh7-0001Jx-JR
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:09 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYh5-0003wE-LL
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:09 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dbe07d3ec3so2217207a34.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251886; x=1779856686; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GRdGcVcmD73AG+5UsKzlv7TQ8d5Mbm0MWUprBW0Q8bw=;
 b=Fz8s1gU4/OMSU861mNHYJnq9oU07Q8mca5m7mgqv/FStL8fb1KF5pSED+N78uzaQv3
 HShYmCQs++hnLrjtY2oUECslx7su+ZrK/NR0w9S/UtdPph8mO5xSNfkKd3STEaatD9A4
 D3pSsdf2/VI9vbIAOTHSd9feMaL2cSCQVvbEWkldo2o+KJNNyl0CTksF9UkfP6zowzt5
 iGa/EV1emr6ODIuIH55VP5u1zuhonMtx/rlsIdAJyL3QOgXLe3QreTdhudukoc8j7D7m
 9hDBMwit6E4SKED2S/1coGlDRodf5k4Cmts8i9i7dhYN9LMjN5KYwAh7ZvTpc/IKRA43
 TP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251886; x=1779856686;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GRdGcVcmD73AG+5UsKzlv7TQ8d5Mbm0MWUprBW0Q8bw=;
 b=k2Mh282+tPjETzrtj/xQaDAMv4J6FB7tCl/k8uQsXiLMDLUflr7cK3AxMv8MB0c/aF
 UXJ0CFY5fqTyq12xXAJ9VbETWkat66CTwUOiSt1UkTWJxRIrDyxcVwEKvG647+LnrGIv
 JUa1GpPN/V3QcpylHHRetevlnJiS9+PxFAV1yQs5fkvI/g5wmlmQbSd73AaHuDzGLE0C
 HPMr/EDvpMxkdH654Bpgeczzz04k3KCslQ5aW+A5+1yTxKMm5JxLyLFqC8UPxBGj6ov9
 bRmSYea6RGWvu4L5tzdqZ3gwrfVUllnnDfqZAF/d8CpJ3sbUBkcjJ5I9I3Oj8ngzGbKV
 6x2A==
X-Gm-Message-State: AOJu0YwGbSjyDG2XJfsIiNgEcbY8QauilEbs9pAED5aMzIqd59zu+CeG
 XG5NjygvTHIT8A4wPqnB9a0iftm1SrSV6WWdlXspV/J7pxW8hLUU6wmdzYZyFWV9
X-Gm-Gg: Acq92OHax0UIG7hInScxwpaXD4sAfkMR30o5hDh5W4Dvyu7aNYci56VcUprExnxRKtw
 4UjbXsW+Xyk+xvWMHNXf7OW/iYzW7jX0rqlmLm5mg680d1SGxUSip6UDRSi0mLYMACHepuAG/8v
 CT6DtQfaVjBxwQaZUOVjqhwQHRzDNxv1WMDabCqEo55gOt3VzmdlpOn9xeXxiq0yasNdBnp17do
 m+2a8WM72f6dZosEWgvY6ZWdBPkVxjQgokmpYd+O9TK955jHnUtgSkQeqJ0mER7GprxrG3c+z7U
 +LF3Bmt2uuOIrtRLIj768XUYIuEMZruDDTK11GxQOUVGjJhLdwLGWgHZTq7Vi7iNCLoS3ajs/I+
 72cdXqzwyGO1xj9ynx8qvjD1hOsaGdsjnLkVbJrvbWvOK9ZZL+awfXJFXMkx+8C2D9oEj/K9Id/
 Rf1EbhTsyq23L9zLZ88kSvaXc194lyWc3ubbeCEXmkSODuBC30Usoey8Rc81vTLXmpBL33s2XY5
 VtX1rZN+TFzHspktyY/VOPuitSjybqz/Uluz25O+k/0hVJBkoDHxzSy1uqfyLtpB3vk
X-Received: by 2002:a05:6830:448d:b0:7d7:fb03:f6ba with SMTP id
 46e09a7af769-7e4f2bc83e7mr17117888a34.21.1779251886429; 
 Tue, 19 May 2026 21:38:06 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:38:05 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:38 -0600
Subject: [PATCH v10 44/45] tests/tcg/mips: cover Octeon COP2, QMAC and CvmCount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-44-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Extend the Octeon linux-user smoke test with AES key and key-length
DMTC2/DMFC2 readback checks, QMAC/QMACS fixed-point accumulator checks,
and an RDHWR $31 monotonicity check.

The COP2 readback cases exercise the explicit COP2 decodetree entries
and direct TCG register-transfer paths. The QMAC and CvmCount cases keep
the fixed-point accumulator and RDHWR paths covered by the same Octeon
smoke binary.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Combine the v8 COP2 selector readback and QMAC/CvmCount test patches.
  - Fix the commit message to refer to RDHWR $31.

Changes v7 -> v8:
  - Split AES COP2 selector readback coverage out of the COP2 crypto core
    patch.

Changes v5 -> v6:
  - Add QMAC/QMACS and CvmCount smoke coverage.
---
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 128 ++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 9153e37e9e..1dbdd9f52a 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -129,6 +129,59 @@ static uint64_t octeon_vmm0(uint64_t mpl0, uint64_t p0,
     return rd;
 }
 
+static uint64_t octeon_qmac_lo(uint64_t rs, uint64_t rt, uint64_t lo)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        "mtlo %[lo]\n\t"
+        "mthi $0\n\t"
+        ".word 0x710904d2\n\t" /* qmac.03 $8, $9 */
+        "mflo %[rd]\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt), [lo] "r" (lo)
+        : "$8", "$9");
+
+    return rd;
+}
+
+static uint64_t octeon_qmacs_state(uint64_t rs, uint64_t rt, uint64_t lo)
+{
+    uint64_t hi, rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        "mtlo %[lo]\n\t"
+        "mthi $0\n\t"
+        ".word 0x71090012\n\t" /* qmacs.00 $8, $9 */
+        "mfhi %[hi]\n\t"
+        "mflo %[rd]\n\t"
+        : [hi] "=r" (hi), [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt), [lo] "r" (lo)
+        : "$8", "$9");
+
+    return ((hi & 1) << 32) | (rd & 0xffffffff);
+}
+
+static uint64_t octeon_rdhwr31_non_decreasing(void)
+{
+    uint64_t first, second;
+
+    asm volatile(
+        ".word 0x7c08f83b\n\t" /* rdhwr $8, $31 */
+        ".word 0x7c09f83b\n\t" /* rdhwr $9, $31 */
+        "move %[first], $8\n\t"
+        "move %[second], $9\n\t"
+        : [first] "=r" (first), [second] "=r" (second)
+        :
+        : "$8", "$9");
+
+    return second >= first;
+}
+
 static uint64_t octeon_vmm0_zeroes_mpl1(void)
 {
     uint64_t rd;
@@ -186,6 +239,70 @@ static uint64_t octeon_mtp0_zeroes_p1(void)
     return rd;
 }
 
+static uint64_t octeon_cop2_key0_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80104\n\t" /* dmtc2 $8, AES_KEY0 selector */
+        ".word 0x482a0104\n\t" /* dmfc2 $10, AES_KEY0 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_key2_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80106\n\t" /* dmtc2 $8, AES_KEY2 selector */
+        ".word 0x482a0106\n\t" /* dmfc2 $10, AES_KEY2 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_key3_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80107\n\t" /* dmtc2 $8, AES_KEY3 selector */
+        ".word 0x482a0107\n\t" /* dmfc2 $10, AES_KEY3 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_keylength_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80110\n\t" /* dmtc2 $8, AES_KEYLENGTH selector */
+        ".word 0x482a0110\n\t" /* dmfc2 $10, AES_KEYLENGTH selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
@@ -195,10 +312,21 @@ int main(void)
     assert(octeon_seq(0xabc, 0xdef) == 0);
     assert(octeon_sne(0xabc, 0xabc) == 0);
     assert(octeon_sne(0xabc, 0xdef) == 1);
+    assert(octeon_qmac_lo(0x0003000000000000ULL, 2, 1) == 13);
+    assert(octeon_qmacs_state(1, 1, 0x7ffffffe) == 0x17fffffffULL);
+    assert(octeon_qmacs_state(0x8000, 0x8000, 0) == 0x17fffffffULL);
+    assert(octeon_rdhwr31_non_decreasing());
     assert(octeon_vmulu(5, 7, 11) == 46);
     assert(octeon_vmm0(5, 13, 7, 11) == 59);
     assert(octeon_vmm0_zeroes_mpl1() == 0);
     assert(octeon_mtp0_zeroes_p1() == 0);
+    assert(octeon_cop2_key0_readback(0x1122334455667788ULL) ==
+           0x1122334455667788ULL);
+    assert(octeon_cop2_key2_readback(0x8877665544332211ULL) ==
+           0x8877665544332211ULL);
+    assert(octeon_cop2_key3_readback(0x0102030405060708ULL) ==
+           0x0102030405060708ULL);
+    assert(octeon_cop2_keylength_readback(0xa5) == 0xa5);
 
     return 0;
 }

-- 
2.54.0


