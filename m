Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50ED2CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 19:38:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQVgR-0001mQ-O9; Fri, 22 May 2026 15:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVgQ-0001lL-7H
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:22 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQVgK-0000aT-HX
 for qemu-devel@nongnu.org; Fri, 22 May 2026 15:37:19 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4854166e1efso1830785b6e.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779478635; x=1780083435; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W8sf8OT+nsg957PRY3OZR99qZCzK1VlYe1z4gwGaMBA=;
 b=EOuXGbOrHBJWhKfeAloUHvb/MnwOWbfwPjbEK+gJEPN/xCIAqXiplBLLjtwJ5xaDsK
 LmcISTT8zM34aW1IViPlE0wgWJY8ryPEFJ7bv7+rXx6TNYGOdt4isvJqgOdJjdy7SePb
 4CJ9KrvrlmDKmjebCZPG0qxAX6ErdGyEaey+ei2i1xh3klFyoXUdPmETDIkCzN7AuIgY
 H9KpifxTKiHwk5xnsSnIywBiUicmzjKP7hK3m3166pQV8F/9skwY5tBx7XksDh21LqJQ
 yzVVH7wjVMD8aPEx1ZD/J97yP+QYV15Y90IMW46NEOeaKQoudMcjE+0vMIoC3AMam7qv
 9sTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779478635; x=1780083435;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W8sf8OT+nsg957PRY3OZR99qZCzK1VlYe1z4gwGaMBA=;
 b=CEukrb0VI12gI2eL5Mz8J8GZTm9D9OxmMvrnnfwjd8tGrOJ9bdR5jvJnrhXaNUgn1Z
 noTnqvzC30Leolk4L5Ecb+FBCPUArqc8OkkVzJ5GUDXze1gg0e8a94hke3fW2zHwwgXM
 BLNyanaZsRWjwRg/zrBDBa9kluPuIEVwvXnBlaNHJ9rHqPbXQW6v9k6N3MaM8eczZdrH
 f8AeLhdN2ZDMKdoNsSLwN/qDqNRM/JMaeKkWXwFKN2utXqBcyydfEBskRrT87ouMztb6
 dWDJgShl6y3bdNr+M76RON/cHKxad7KFtIZK3EPGLZVabwtmRBEW9x5mwYYm9CEvROKm
 RjZg==
X-Gm-Message-State: AOJu0YyDKMWyeAihuKj/eXFvDV9l0SkfsI8YSsdLENnu3uNK7RJO7Cw8
 Ww/Q0WI7igjfdUYr1jGO3cUnTq+JHmiCF9NDrS7fciYOlScms8JtRQ/6
X-Gm-Gg: Acq92OHnAjl4ifLTs2+GRbhWb/WuCvBp9y6fsVdwDIA7fzSI0a5M4LKbUeE8A9Nr/x7
 oaU3yddJ7lb7PnEm+VEfEBxg6DPr2X13FuNXyjMwq9aVc4aL+FNVh6J3HPyjy8pGlKGGS6bmL80
 miACAh3y8y21s/9XbRoFGXgVS/xXy/ug69783PhBS2j7ufGdBY8oOGrchqymLxTFAEsUzTDEFK1
 HfsEn8qZFH17xmKZHqyTnbOeDpY3y17u2zcCblmVOjBpuXNr7QM7dLHm/dUp0lAh13Hh3HBPemu
 Ko+mwZyt+EHMT7EUM41JtiAffD4JuIOFCQErTV+hkFlDtGlcJ9ItjQPFeMFzYCNgWbSN4xX9FU1
 FDd8rHD3HBlMPOizVu/2c+1Y+SmcdQZo2QzhhmRWrKo3faVU85aL9TqoaP9LUCOG1SiOJ8OKAi7
 exYyjG3TLOmEK2lDDMdU7i2qJmRHvThsXbK+0BOswrXJDpdeXtnJDFqaA/LQNjs1nXnnDHjjHU+
 mJ0ZpPW2Plpro/yuSM02IuHH9eY66wIYPVRqa7iTG+ByI03xo1bgiF6G3RJkQIiPgZ7xLO1nUWF
 d9Q=
X-Received: by 2002:a05:6808:2220:b0:485:1173:2e4b with SMTP id
 5614622812f47-4854a2aca09mr2948066b6e.37.1779478634658; 
 Fri, 22 May 2026 12:37:14 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-48554757d5dsm995297b6e.15.2026.05.22.12.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 12:37:14 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 22 May 2026 13:36:53 -0600
Subject: [PATCH v15 22/22] tests/tcg/mips: cover Octeon QMAC instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-mips-octeon-missing-insns-v2-v15-22-f8731a588dc2@gmail.com>
References: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
In-Reply-To: <20260522-mips-octeon-missing-insns-v2-v15-0-f8731a588dc2@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x229.google.com
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

Add smoke coverage for Octeon QMAC and QMACS fixed-point accumulator
instruction paths.

The coverage exercises normal accumulation, saturating accumulation, and
the sticky saturation flag.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Changes v12 -> v13:
  - Add QMAC/QMACS smoke coverage.
---
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 6480c8532a..6fffc82010 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -129,6 +129,43 @@ static uint64_t octeon_vmm0(uint64_t mpl0, uint64_t p0,
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
 static uint64_t octeon_vmm0_zeroes_mpl1(void)
 {
     uint64_t rd;
@@ -355,6 +392,9 @@ int main(void)
     assert(octeon_seq(0xabc, 0xdef) == 0);
     assert(octeon_sne(0xabc, 0xabc) == 0);
     assert(octeon_sne(0xabc, 0xdef) == 1);
+    assert(octeon_qmac_lo(0x0003000000000000ULL, 2, 1) == 13);
+    assert(octeon_qmacs_state(1, 1, 0x7ffffffe) == 0x17fffffffULL);
+    assert(octeon_qmacs_state(0x8000, 0x8000, 0) == 0x17fffffffULL);
     assert(octeon_vmulu(5, 7, 11) == 46);
     assert(octeon_vmm0(5, 13, 7, 11) == 59);
     assert(octeon_vmm0_zeroes_mpl1() == 0);

-- 
2.54.0


