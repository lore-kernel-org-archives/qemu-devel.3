Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6636CD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7nE-0000J3-MK; Thu, 21 May 2026 14:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7n7-0000HU-Qc
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:42 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7n6-00028v-0h
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:41 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e4004a4a6fso6228908a34.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386799; x=1779991599; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=38pL5UNkdtia0wsGoAP1ij7zit+GjIsJMptplUGSK8U=;
 b=NSf/c7jiIY5IlPi7enZ+oq6uDXjaOno9yJK5vsFNTtyR0Gv7pslu1KR79qwENn/BH4
 X6qklP8dCi6nYaHZdUeU5kD66q072LVvAQ10iCmrJKkpEWCrt+VzsJknsTlR+XK1P/w5
 6v7nULjzkqQaYJkGrrT6/We6YxZ/QFQsEpQL3lo10qZ7WNjb2GuGPSy/ZE/fzFqL6VC4
 Sd+sGMqgiNrQNTl9SJ4rEI/crNbjdgSSqa4kvzE1QA9xomKfANk8YEHjRottUVi6S8/I
 RfGJaVAhE8GqhnFE+tH088Hb51rcdZkd0jISm7Xiu4iI2vOysvP3lznknDfqx0D8jLeW
 VO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386799; x=1779991599;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=38pL5UNkdtia0wsGoAP1ij7zit+GjIsJMptplUGSK8U=;
 b=OXPx05N5EAtTQ4a0F8XM+mCK0PmB90UpsSEveXieyJFs1aWGPiwrAiOqSV4v1TVvvB
 LVOsJ98lekE/jxSzMlA92o8s0UWq7OQPDyBoxaLBxerwYa475sP9K4tDbMsLXZvRCj42
 Qs80WCejOQN25neK2ws9Ub/Hq/b99DI4B0wlWdF0S/diVjnvA06yM2ajYg15bw4o/CKM
 45VLFkdJvDjj5Pgf/ukGlAJYGWkOw9fdlyHoUdqJ9+kK2AF6i8E1mLreFxWAsYgfL2bB
 US0xB9CNgBoFHvNG+MwaGXUkckH0rvTBJX6CokxJmmleRRmCkgFZBN186gFNZlGafDdy
 mXZA==
X-Gm-Message-State: AOJu0YxiuoYuIp84KpPEBksZMEzarUClp2jzGbdrxO+6Ej3sVI6kHPyj
 93A+a24+qxp0HlVO/eSmDaPqUlB8Iag8VUjiLiz0L1586wCubq9EcAt3
X-Gm-Gg: Acq92OE+4Jeu2CqNzrDw8IwqHtyBfu0XKJ9FOX7/zNJRWWu1KaLcz7cYlxnSsTwn+f8
 hv+fSufM6OqXFEk2jKBsMjtOSqKsFSOuQmaXE0TSaMkx6i8QZHYg6IZIsA0E1lI2DfCDn/tC4il
 uBz96G291PjhUshJh1tRWjwA8+m/PXn6pIw+LZuxytqIge898QNmQGLRxjWwboWdfRbjAvbvImp
 45493O/HRq1q1kMcEZ6jE/Ur2MkITgM8mM7KQIivZQw+MRRiABsIK/rk8TS2J39beqhVzEzqLN8
 lAO9k7+b6FMPt5bxkGuLKnWqzoQgaJuvSJ46oZomhO5lOusZcoJoJhIJ5mLHjxteoydn8wDo5k2
 BUCewd0uaAAbjcPnUNREC0TrvncHIEyr0VcdRe4athFZogDmXn/vrH595u2j2NKfHuVRqLivdxA
 krhV0Qtpwym1JhL+5j/S2YJIeARvlDrgGV1NXVhDxC+nacsvQ9Qv57kK/chQoGNVnuvE30bfDM6
 nw0PlBho/oXE4NPtp1DAjaz3ifGqsX7zmStZiXEgXwjlIJqtvNSYonclsb6D+RgM5if
X-Received: by 2002:a05:6830:452a:b0:7d9:7209:4378 with SMTP id
 46e09a7af769-7e5fee23f0bmr171676a34.17.1779386799003; 
 Thu, 21 May 2026 11:06:39 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6ee286fsm903089a34.25.2026.05.21.11.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 12:06:15 -0600
Subject: [PATCH v13 22/22] tests/tcg/mips: cover Octeon QMAC instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v13-22-5a4cb8ec9cd3@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32a.google.com
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
---
Changes v12 -> v13:
  - Add QMAC/QMACS smoke coverage.
---
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index d41115aab6..072e95c1c9 100644
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
@@ -339,6 +376,9 @@ int main(void)
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


