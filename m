Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E147C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2ArO-0002Dq-EQ; Thu, 03 Sep 2026 13:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x2ArN-0002DM-5j
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:04:21 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x2ArH-0004yP-Ip
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 13:04:20 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so185587a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788455054; x=1789059854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yr1xuAHbIhRQR2HquIZ+fNcRwi6DyU7KLH9171HGnOo=;
 b=E3pwl69YcLZ2Z8uHqSLhiiCstkbbFPVtau0dZjekdLHBdgVOgvVD5MBqYt6Y/Uwm0n
 SXl0j8D/KI5rEEKbs7SN7juBnOCfOIaMLfKjZvQuZCjJVPGtDOLqw2q49V019RAY+FUp
 ajcyonI13PI7hjQCyF2J9JMdvb8NO/lQitc0AO47IQFN+kSFQjf5sHAhgre0tdWa33dO
 7qdof4IWN6Q0VJx8kjjA3b6AZnWpLxtJk9GjXBaMVL3Ymyv/ivSYJBQRJCuL7ZHo1LEz
 49uVUccmVC8RiDqEsL/jemqCt8WHJG3M8S7w1xf3XMZkK3oqI8TenXqfZDUkE4CitH1p
 5lmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788455054; x=1789059854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yr1xuAHbIhRQR2HquIZ+fNcRwi6DyU7KLH9171HGnOo=;
 b=hfB7mmuO7ERA6C/ii+YBTDXrgm0lKvh4pUUbO8teCl4OEzikzA94Rn3HdNcz1ojPei
 8sTMkRrYiED3xqZS3WPh4K96sXitqGrAE9Lc/3YMk9veu3KiwWGKbYFyJHVYZsgw4WNR
 CgdF2CyPQV/UkB7YU3HhqPbh8WT4v361Esvv7oUSH6088Gvmxv8mZdH57jEheRQ5tsDG
 KqbQfE3l9o/KRdfhJe3qLDrJnYGASDKiVmqnUlC5Gu60i8wEudD/1TTByoxu1TwJgdK9
 B6MVbdTAUEY6L3ZHxdXEfU6eKSuTqc05Z6d4WHYPSqJFuMrcoJDqswEMvwn1WT2IfPvc
 qA2Q==
X-Gm-Message-State: AFuF++lAaM6I7WYaa9wF0/ACnC0fqtJovDs3eXAu2zA170STvoOCBkr6
 Z8FzeYBzQ3MSn5QU2RnnmQI58DAKfKB8S4tk+kl7iuhhLQpi3WSJ3jpVoDOc42xSAjGneN4Y0yh
 rJjWecRVp5aDesqDTMFoeNaDpgsNWJtCWpk+lCJFe5Vanu7ySNiqQgQwnPWqx1MaojzEwO1UvnI
 I6Ev4x3X0Z5X1nb6KAxfA/wgxNrYcMo/fB8a3NhU6HNA==
X-Gm-Gg: AYBFou0M2RCA2shPWlgJptz7dCAdIZQNCtEYSxkE9inIrzSOYSLTZqsGrkCPfUGOU+5
 WSe66F/CERp/z7DLlhfJrp5TErdImvqm3jl9vtdezu09b0gXtpgHXcDtnZgMjcghNAwOf+qSjOZ
 HBEgz7ffUVCElKz8DHnWP2etLGVgFj3ZSsBaR3wWv4LMKbyCQXpONa6OsfZLtUQDIPTdW5D4O2k
 ynPA2T/l9AExDk5VDNk2R1kz8gMRY2GcKVdVBa5uhZIFpkNA0wRiusiDpimh5A5pdudcj5VBSWH
 kTRXx+aMDIEw6c3eYzqpoGwqwHTK60tLJY+4CAwP3snwTwHKWoo6dmCBrHUIMcZSSA795AMVe0I
 O/aY0WXGT5tot19EA9Pa9g2F5wUwIpr1IrMh/ZxIxIHfpwJhLih6WVRrpgvto8zta6jEOQd2COp
 ntAr0rhGX3fVtTGzRHjo2JQJ+cNtIGGbwPsjd2yy8wfG4oGgLf1AgjWxGMiMFZoNM/Cqw4dyolL
 yLEr0hZgG3PBmrnXBmIMQCBXSIrWLx8YbydMcof0VcHtJhuYuWJdUwDsNN+qoo=
X-Received: by 2002:a05:6a20:2d22:b0:3d3:aec2:4dcb with SMTP id
 adf61e73a8af0-3d9b051aa7dmr24391920637.23.1788455053803; 
 Thu, 03 Sep 2026 10:04:13 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc43d39e4ddsm1227860a12.5.2026.09.03.10.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 10:04:13 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH 1/2] tcg/riscv64: Validate AUIPC relocation range
Date: Fri,  4 Sep 2026 01:04:04 +0800
Message-ID: <20260903170405.3632015-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903170405.3632015-1-max.chou@sifive.com>
References: <20260903170405.3632015-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x532.google.com
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

reloc_call splits a PC-relative offset into a signed 12-bit low
immediate and an AUIPC contribution. When the low immediate carries into
bit 31, the existing 32-bit arithmetic can accept an unencodable
positive 0x80000000 AUIPC contribution.

Keep the split in pointer-width arithmetic and reject it unless the
rounded upper contribution is representable as signed 32-bit. Factor
this validation into split_auipc_offset so reloc_call retains its
existing failure contract.

Fixes: dfa8e74f9463 ("tcg/riscv: Add the relocation functions")
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 tcg/riscv64/tcg-target.c.inc | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index a439ba5c20e..1c41f8ffade 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -634,14 +634,31 @@ static bool reloc_jimm20(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     return false;
 }
 
-static bool reloc_call(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+static bool split_auipc_offset(tcg_insn_unit *src_rw,
+                               const tcg_insn_unit *target,
+                               intptr_t *hi, intptr_t *lo)
 {
     const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
     intptr_t offset = (intptr_t)target - (intptr_t)src_rx;
-    int32_t lo = sextreg(offset, 0, 12);
-    int32_t hi = offset - lo;
+    intptr_t low = sextreg(offset, 0, 12);
+    intptr_t high = offset - low;
+
+    /* AUIPC sign-extends its 20-bit immediate after shifting by 12. */
+    if (high != sextreg(high, 0, 32)) {
+        return false;
+    }
+
+    *hi = high;
+    *lo = low;
+
+    return true;
+}
+
+static bool reloc_call(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+{
+    intptr_t hi, lo;
 
-    if (offset == hi + lo) {
+    if (split_auipc_offset(src_rw, target, &hi, &lo)) {
         src_rw[0] |= encode_uimm20(hi);
         src_rw[1] |= encode_imm12(lo);
         return true;
-- 
2.43.7


