Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBA1C5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 03:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuM6B-0001z7-Ei; Wed, 12 Aug 2026 23:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wuM68-0001yq-OD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 23:27:16 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wuM66-0000Ak-9f
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 23:27:16 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso1093919a12.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 20:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786591632; x=1787196432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xtMucBLIsypxqX0LKfF2YVgc26j6UtWYxPBlPYxAVu8=;
 b=fFprFauryXNhDUiUm1ywoS0hkJdCIOX2yoS9HbhS3Rap9KirzcvIn3SxBMlFk9XVsU
 QYmwpZkND4dNlUHDrqKv9t/qf3sJj+BDsFht5BBk8lF42xNBRZR9zY3ChmLdV84kTwGO
 SrT7sWpt4W3QWpJfxxrAbx8pkY1FtuecAWVIQjr0ZbhLnq8BC7tjZjUM550z3la9fjvl
 +U6uJkqozjH+iflIwrI6Dan7wGsvL7RWiCyTJY/e0SqI62ZMCjSbxr5HyOY+SA4LHJIu
 d5CdgJ86CKbgU/b14FY4n9apa6GsH7ayeJtlCqXav7YcSW6qrw2XPzGCKZmV05KYVhws
 rKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786591632; x=1787196432;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xtMucBLIsypxqX0LKfF2YVgc26j6UtWYxPBlPYxAVu8=;
 b=LV2zFlMPmErqXd5SSx++9ptysfmNYQQT/f/isHznV8jIXIaFxv0zqPTf0ak8wfeFX2
 CfuW7CfTZa4tmOu/hZx6O7NshmIjzRbLhx5KO5Qc5NeLXcL4DJuLSdkWwapRmVNHewcg
 +qfL6+kYOxLTt+oYe9YHbghdqaBnvCi+7zIBdC6o/zXSf3iFaSWngMBvTEc3KxzFCqUs
 1NQXhwacNcCu/MndCKthd7Z7c3QshvrWYK8TA4D/V4cjAMjhSMa9htQkCR85q1sbtqZg
 GxaIqMnovi4VGCG5JLa+X3eXcFq16qzVBBU3N98MfpW1ATBMSFfFoaQukpgfGnjBsvsa
 +6ow==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNu2LvcAdsH17Tx6Dnk0RlkjhQikjxlqzEezEVKbMLRRO0tyGyMrKVsAmNJRvryDF6RjGebVCHahsS@nongnu.org
X-Gm-Message-State: AOJu0YzzX3cNbDuW52Xtp8BaRIqtuCU9ZnpZsioDikRr4zi2CtMwUvEk
 104N/MPOn1MWf9kUlhX3a+zh8i9GOL/7HuwByucI/sjIh8POPaWj/xxQ
X-Gm-Gg: AR+sD10IKTLduTz876kHzkPpw7KqiGMpih7sfqDlHQGsVXZm726xZ9GWAhWWNRGFiZ5
 vdOi5Gqc/i8hB7XLViTO8bzaEXR6obdwUVp9dOeflqIpQBAjHuk5lOcRK/LBPpmcg72qxGq0K4k
 JmmwvWKN/WZXcAdXhb+9mLE8RIDRMhZSL6YkAVWkabqAY7NGbLxtW8wpzha8KXb/WE5LBBFIer4
 lYxfCwRLQWAURONIMN6bRz08b2GdpktKuiBoEWt56kOYtPn1n6fWfo0OiLMcarpr59tH/WBaFRc
 Fg5I6YhZeIGz+82QdtK//10PUTkv0TRjk1IIqrXssQ971iXwWFq1wRCbm7E6Tni4YxZQYJxKW5v
 wqivRFXDKogOJnlz+ofpf73JVh0iCtyxnACs3umDnNhqY4j2DFKgYOOvJMXHe0Xxa+yjfdoa0BT
 M0zc9sEwd6VLJ4VhfuXImGBO2m0JEmpfl801rqMpHz7JnoK/j0Xa4dSJOqg/F4yk6H2mN/ytQzC
 M69Uwz69SZPobAc7S0PBmOHx9KNIkgTP8tHOMi/FY1tk4bxgnrAj54Z202cWuOfa4nSG3GeD818
 4H5Q+nkhAKP9pqKIIOP7zjlL/x5IKilnbmS3W4uSrr7kSESOY8wsdACfoBpt/3sDEg==
X-Received: by 2002:a05:6a21:3204:b0:3b7:807b:3cd3 with SMTP id
 adf61e73a8af0-3cc55397c0bmr4079142637.23.1786591632218; 
 Wed, 12 Aug 2026 20:27:12 -0700 (PDT)
Received: from donnager-debian.. (pa49-178-218-204.pa.nsw.optusnet.com.au.
 [49.178.218.204]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31eb99e2556sm2708493eec.0.2026.08.12.20.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 20:27:11 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Anton Johansson <anjo@rev.ng>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] target/riscv: Restore register dump zero padding
Date: Thu, 13 Aug 2026 12:54:14 +0930
Message-ID: <20260813032421.54438-1-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The register values lost their leading zeroes when the underlying type
was changed, resulting in mismatched padding and harder to read output.

Print with a runtime field width based on MXL, so values are 16 hex
digits on rv64 and 8 on rv32, matching the csr and fp dump. This avoids
adding target_ulong back into the dump.

Fixes: c4e6bc63853c ("target/riscv: Fix size of gpr and gprh")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
before:

 mvendorid     0000000000000000
 marchid       000000000000002a
 mimpid        0000000000000000
 mhartid       0000000000000000
 mconfigptr    0000000000000000
 x0/zero  0 x1/ra    ffffffff803f10f6 x2/sp    ff2000000000bc70 x3/gp    ffffffff805c94c0
 x4/tp    ff60000000c78000 x5/t0    ffffffff803f132c x6/t1    0 x7/t2    20646e65205b2d2d
 x8/s0    ff2000000000bc80 x9/s1    708 x10/a0   270f x11/a1   8
 x12/a2   0 x13/a3   120 x14/a4   14992a1 x15/a5   ffffffffffffffff
 x16/a6   fffff079 x17/a7   79 x18/s2   0 x19/s3   7d0
 x20/s4   ffffffff805ca228 x21/s5   31 x22/s6   ff60000000e15000 x23/s7   ffffffff804228c8
 x24/s8   0 x25/s9   ffffffff804e3e90 x26/s10  0 x27/s11  0
 x28/t3   ff60000000c60f00 x29/t4   ff60000000c60f00 x30/t5   ff60000000c60000 x31/t6   ff2000000000bc28
 fflags        0000000000000000
 frm           0000000000000000
 fcsr          0000000000000000
 f0/ft0   ffffffff00000000 f1/ft1   ffffffff00000000 f2/ft2   ffffffff00000000 f3/ft3   ffffffff00000000
 f4/ft4   ffffffff00000000 f5/ft5   ffffffff00000000 f6/ft6   ffffffff00000000 f7/ft7   ffffffff00000000
 f8/fs0   ffffffff00000000 f9/fs1   ffffffff00000000 f10/fa0  ffffffff00000000 f11/fa1  ffffffff00000000
 f12/fa2  ffffffff00000000 f13/fa3  ffffffff00000000 f14/fa4  ffffffff00000000 f15/fa5  ffffffff00000000
 f16/fa6  ffffffff00000000 f17/fa7  ffffffff00000000 f18/fs2  ffffffff00000000 f19/fs3  ffffffff00000000
 f20/fs4  ffffffff00000000 f21/fs5  ffffffff00000000 f22/fs6  ffffffff00000000 f23/fs7  ffffffff00000000
 f24/fs8  ffffffff00000000 f25/fs9  ffffffff00000000 f26/fs10 ffffffff00000000 f27/fs11 ffffffff00000000
 f28/ft8  ffffffff00000000 f29/ft9  ffffffff00000000 f30/ft10 ffffffff00000000 f31/ft11 ffffffff00000000

after:

 mvendorid     0000000000000000
 marchid       000000000000002a
 mimpid        0000000000000000
 mhartid       0000000000000000
 mconfigptr    0000000000000000
 x0/zero  0000000000000000 x1/ra    ffffffff803f10f6 x2/sp    ff2000000000bc70 x3/gp    ffffffff805c94c0
 x4/tp    ff60000000c78000 x5/t0    ffffffff803f132c x6/t1    0000000000000000 x7/t2    20646e65205b2d2d
 x8/s0    ff2000000000bc80 x9/s1    0000000000000e10 x10/a0   000000000000270f x11/a1   0000000000000008
 x12/a2   0000000000000000 x13/a3   0000000000000120 x14/a4   0000000002575fd6 x15/a5   ffffffffffffffff
 x16/a6   00000000fffff079 x17/a7   0000000000000079 x18/s2   0000000000000001 x19/s3   0000000000000ed8
 x20/s4   ffffffff805ca228 x21/s5   0000000000000060 x22/s6   ff60000000e15000 x23/s7   ffffffff804228c8
 x24/s8   0000000000000000 x25/s9   ffffffff804e3e90 x26/s10  0000000000000000 x27/s11  0000000000000000
 x28/t3   ff60000000c60f00 x29/t4   ff60000000c60f00 x30/t5   ff60000000c60000 x31/t6   ff2000000000bc28
 fflags        0000000000000000
 frm           0000000000000000
 fcsr          0000000000000000
 f0/ft0   ffffffff00000000 f1/ft1   ffffffff00000000 f2/ft2   ffffffff00000000 f3/ft3   ffffffff00000000
 f4/ft4   ffffffff00000000 f5/ft5   ffffffff00000000 f6/ft6   ffffffff00000000 f7/ft7   ffffffff00000000
 f8/fs0   ffffffff00000000 f9/fs1   ffffffff00000000 f10/fa0  ffffffff00000000 f11/fa1  ffffffff00000000
 f12/fa2  ffffffff00000000 f13/fa3  ffffffff00000000 f14/fa4  ffffffff00000000 f15/fa5  ffffffff00000000
 f16/fa6  ffffffff00000000 f17/fa7  ffffffff00000000 f18/fs2  ffffffff00000000 f19/fs3  ffffffff00000000
 f20/fs4  ffffffff00000000 f21/fs5  ffffffff00000000 f22/fs6  ffffffff00000000 f23/fs7  ffffffff00000000
 f24/fs8  ffffffff00000000 f25/fs9  ffffffff00000000 f26/fs10 ffffffff00000000 f27/fs11 ffffffff00000000
 f28/ft8  ffffffff00000000 f29/ft9  ffffffff00000000 f30/ft10 ffffffff00000000 f31/ft11 ffffffff00000000

I also wrote a patch to align the first column of register values, but
that creates the dilemma between aligning the numbers vs keeping the
spacing between the registers and their value within a row. Aside from
avoiding bikeshedding, it wastes more columns for an already wide
output, so opted not to 'fix' that.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 target/riscv/cpu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 19b93f9c9794..c50dd5ee8771 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -650,6 +650,9 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
+    bool rv32 = riscv_cpu_is_32bit(cpu);
+    int width = rv32 ? 8 : 16;
+    uint64_t mask = rv32 ? UINT32_MAX : UINT64_MAX;
     int i, j;
     uint8_t *p;
 
@@ -664,7 +667,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         qemu_fprintf(f, " %-13s %d\n", "elp", env->elp);
     }
 #endif
-    qemu_fprintf(f, " %-13s %" PRIx64 "\n", "pc", env->pc);
+    qemu_fprintf(f, " %-13s %0*" PRIx64 "\n", "pc", width, env->pc & mask);
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
         int csrno = i;
@@ -691,8 +694,8 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #endif
 
     for (i = 0; i < 32; i++) {
-        qemu_fprintf(f, " %-8s %" PRIx64,
-                     riscv_int_regnames[i], env->gpr[i]);
+        qemu_fprintf(f, " %-8s %0*" PRIx64,
+                     riscv_int_regnames[i], width, env->gpr[i] & mask);
         if ((i & 3) == 3) {
             qemu_fprintf(f, "\n");
         }
-- 
2.47.3


