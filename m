Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C79CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqZ1-00087h-9m; Mon, 18 May 2026 01:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqYL-0006wx-0a
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:09 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqYG-0003aW-RG
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:08 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-479d37e7d7fso472961b6e.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082201; x=1779687001; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v7rp6+rNMIEclIzKubuq6lCqztB2uEmsOX6adbP8QUw=;
 b=hbRmc55nYI2L5S6QkxpDGkZRSrNbPuWDNrerEY0RAuCQCJ75wAQzpwLyguMUYkRWqY
 op+fHMOQWhbotHVxKguIawoaOPP0CuSoJtgmJRa/XUbFY/9OCBS5xk4JBsCJfKVQ9mnI
 v54OEdHJwInadL/zqH2acSKT3mWoGTjeAZwxXgLnpVsPimscEUCXv+HQrPxrn/IlIplS
 HozZ722R43BXGKRSLyHP0y2+j1Pqmgcc4t4h7fHPv/4xS/eqYzY7yO/r+rFyZJmRg/Ir
 jz3cmWXLCvx58JG1tAEjedIavFOfD+mBSxglI9hDWMUrxmDNs/oaDGtNHHEEMUUo8d6x
 VEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082201; x=1779687001;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v7rp6+rNMIEclIzKubuq6lCqztB2uEmsOX6adbP8QUw=;
 b=E823VxsnZx+emJvvztEWJXRJlXMKl4iqulj0ohMCNDYSADjN1pLa4DgBAjafWmeTe6
 U9roi+EN1sOBNAc9MLAH/fVs39weUF0dFEg+6RMN8Uzzi/fDC2Hy8g9oBfym8oa6yWGp
 tupkDXAd8bkQrrGN3IfGKcY4pPzt8Qsozb/Moy/Lu1PZVlviofW5odzHZb8zqYLR3KPO
 LQ1OuKksim9k75h28PipxC/aMY90676jhiKqkUIvhSwlAq5XZ9fD+JrPeWjfmGOyJE0w
 FNHhog0G82ZMnUwSeh5Juo0tlrtE4Pk6i6jSQvAyQRlJ2zEzQAqRIQOY9JAnYykR0Ihr
 sLuw==
X-Gm-Message-State: AOJu0YzNgE2G5su8Wsxr3Y7DSTo3AUK+I+suDNfKoPNssBViLz3ir2Ac
 k7bGks0wwTxC0I4pjqGzhayEzHSRvvSo4XRdfVRaP4gefACEkimfpnA2
X-Gm-Gg: Acq92OH8NG3hLwo+1riHbmIdjj+60iEARnSluMcy2lI+jgNp6sZLJgSuU4X10Sl4NNk
 XBXClwlV4IL4SHsy1TPfx7kb6N06ibD1xS6JR2AstZez60TYqxhEo3VaQ7BKaOG2Dg1+Z7q3oYR
 Ep2sTxMafVSVQZC7qz9f2jakqwduaXNScvz2q9BkrDU53+cVT40m8A0LckKaiWbJ8E5NUbfq/xM
 RoiytmH1dG6wyg6yBxpkcg4GdDmRCfgDRmXmORpBg3c+wSku6ZGxgISf2/oEg71LBCkipmahALK
 +/cT1RIjEppn4c+2ydn8gbiSunTESqavTVDsZqEefL3j+P8trrxyscVq1uhMcdEfIOyrkWZoyBX
 +RgZnYli/9gIlGce5UiGZE81LCGspjt8hc7jL7+R5YLoEwVNBPJFN3PqBmdSlRtnEsA9QtoFLfa
 b5EInGRvYDrx4cnxeJQCQosdnt1K4p7s5kyvx0vmVBWfmXc8tAvVyPqAwGlPCdhG/ulACBMP01f
 WfPmmqE8hNyHH859ahW6JLMdXAiB/p2mgPj2MNABgdHbnW7IVpBKrRnukcEzhNi+IAdRiDbGDM6
 NByU7w==
X-Received: by 2002:a05:6808:124e:b0:479:ac7d:6da8 with SMTP id
 5614622812f47-482e56310e9mr8215926b6e.18.1779082201245; 
 Sun, 17 May 2026 22:30:01 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:30:00 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:31 -0600
Subject: [PATCH v8 34/35] tests/tcg/mips: cover Octeon QMAC and CvmCount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-34-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22f.google.com
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

Extend the Octeon linux-user smoke test with QMAC/QMACS fixed-point
accumulator checks and an RDHWR $31 monotonicity check.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v5 -> v6:
  - New patch.
---
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 57 +++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 435ccfa347..1dbdd9f52a 100644
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
@@ -259,6 +312,10 @@ int main(void)
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

-- 
2.54.0


