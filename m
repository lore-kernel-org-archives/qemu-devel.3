Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77277C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5uFY-00035s-MJ; Sun, 13 Sep 2026 20:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFO-00033S-6k
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:34 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFM-0006tW-Fb
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:33 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4aa0f1a94so930264a12.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 17:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789344511; x=1789949311; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2z9m/YOpcToSgBJOfPpTljwJ75aRrsoL4rxY7if3/dA=;
 b=aMAOmfTL4llwsw+oeDpKpEi75dFGGqduynKqTQzJXH23zQm0EilY1ukfn/IWCLIVJu
 Ftata7/aFNePz9QL/lpO4xe9N0KwCCICKo6yjnI/q5jRbsw6u8gksJoAVeOZTzMjgoHa
 qIoeK+B7Rzvnq7Q/otWpTcRRZgs9qUcMYTM7fuphcbdOc9CLOudL+b+xS9hTVT08kbfv
 ofKIob2am+Uy2E41B3uBx6qNeDeD1lH9bjHKPlRdowT4rrNW1GSy1PsDaS6HXj6Vhbnp
 psexLrk6WGkCf26771uMGAHtpOz7b+OGXdC75GYqxWfRwUs+SLRUA6u1tjphJ2t5I7z7
 yp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344511; x=1789949311;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2z9m/YOpcToSgBJOfPpTljwJ75aRrsoL4rxY7if3/dA=;
 b=hJxnMtrR9lVIQrux7mSNZWygnaXNkgghqYRP0zAIjBvvWEgAo1wHbovCbY5G80k3Mr
 XdfNblxxWX6OjbrEqEBqCqm+ZUFR/sLVy42Hs2/jmAejnUQE33pJk+W26wp4Lx4Fxns7
 eVtrR8e7h4pVBjaxLmT+gfZaRMOYgSxu3ZL8zAOtGyvb8erFas6upvxFIVeOoFM3NP7+
 0LYCQqpvnubiEs1YLYm4ctYXFw+IjvAayeJCNwDh3lIiGVWswMvQ64MIU9zSCsg1sOzf
 5I+uQMah70EPVmAh6oki92UHrj7DG8/NssPmGVdD7WZdwqYUNjEs4yLYJx1+2dS+ZqvS
 BGlQ==
X-Gm-Message-State: AFuF++kpUNd61OKgS+k/FW/NfrnZRtrGVAgGwES2iMoguN/iN4aBvrOY
 be+dL3AyQygXgp4x1FXx/knn5NZRdZhOXxoET2St1wkOS+SwgufCmSmInJgmJPZTyruDTADBifA
 TUuMDHHI=
X-Gm-Gg: AYBFou0v0cK5voENRg9O8FvjCDKpzE9kInP4DL7GQ0DWRbzQorTIqZCh5MOIPmt5BvS
 F6e9+5IkTc3P7/xOkmjY2epi5jLHoFFgxZ1jYa8iZmNuum+XWHz/VBfeYN9Ht/TWbJt2Smi6huY
 OKsiAvrlnXtS4eHxkYxjtEShcueb/oP+axYhGofoIQgJiKtXhcHwdGWnBVr/UQ4ynjO0PRiMW35
 9AZyd8q2h56pBvHvPbbnfcEbwy1VC32tZmwywQ87DB3bJ7/LkHq83ikcqAUhTY9bX/mJNXdpZTm
 zUpPr6lAVJz/41AUduYWdMY2SyU4NXCV+HOkO1uU8S1p2l6wRqXv2ueL6+j4h44fjx7mi2fr1VZ
 Ql5aMhyBu3c8TRrAw6mPxzticj5aM5fL7mnuqUO6nqRFxTRoHXQ2C895X+/0TOZzVkf0bpmwEZ3
 U8I57GwpVpAltgLXS1fOC3UozH5MtoSh2a4TDl+uv6vbZYpg5vqSAEUMDOdrxGUqf4LUvSRRzIV
 PWVgrE=
X-Received: by 2002:a05:6a20:72a4:b0:3da:1e7b:ea27 with SMTP id
 adf61e73a8af0-3db0e485bb5mr16576419637.21.1789344511079; 
 Sun, 13 Sep 2026 17:08:31 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14382741839sm4937677c88.6.2026.09.13.17.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:08:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com, palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com,
 Alistair.Francis@wdc.com, philmd@oss.qualcomm.com
Subject: [PATCH v3 10/11] tcg/riscv64: Validate AUIPC relocation range
Date: Sun, 13 Sep 2026 14:08:13 -1000
Message-ID: <20260914000814.785155-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914000814.785155-1-richard.henderson@linaro.org>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Max Chou <max.chou@sifive.com>

reloc_call splits a PC-relative offset into a signed 12-bit low
immediate and an AUIPC contribution. When the low immediate carries
into bit 31, the existing 32-bit arithmetic can accept an unencodable
positive 0x80000000 AUIPC contribution.

Keep the split in pointer-width arithmetic and reject it unless the
rounded upper contribution is representable as signed 32-bit. Factor
this validation into split_auipc_offset so reloc_call retains its
existing failure contract.

Fixes: dfa8e74f9463 ("tcg/riscv: Add the relocation functions")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
[rth: Pass target as intptr_t to split_auipc_offset.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index c167ff5237a..7754bcf39f2 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -643,14 +643,28 @@ static bool reloc_jimm20(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     return encode_jimm20(src_rw, offset);
 }
 
-static bool reloc_call(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+static bool split_auipc_offset(tcg_insn_unit *src_rw, intptr_t target,
+                               int32_t *ret_hi, int32_t *ret_lo)
 {
     const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
-    intptr_t offset = (intptr_t)target - (intptr_t)src_rx;
-    int32_t lo = sextreg(offset, 0, 12);
-    int32_t hi = offset - lo;
+    intptr_t offset = target - (intptr_t)src_rx;
+    int32_t lo = sextract32(offset, 0, 12);
+    intptr_t hi = offset - lo;
 
-    if (offset == hi + lo) {
+    /* AUIPC sign-extends its 20-bit immediate after shifting by 12. */
+    if (hi == (int32_t)hi) {
+        *ret_lo = lo;
+        *ret_hi = hi;
+        return true;
+    }
+    return false;
+}
+
+static bool reloc_call(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+{
+    int32_t lo, hi;
+
+    if (split_auipc_offset(src_rw, (intptr_t)target, &hi, &lo)) {
         src_rw[0] |= encode_uimm20(hi);
         src_rw[1] |= encode_imm12(lo);
         return true;
-- 
2.53.0


