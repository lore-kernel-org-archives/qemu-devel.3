Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A34FC88E66
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5uFQ-00033y-DI; Sun, 13 Sep 2026 20:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFL-00032W-Vj
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:32 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5uFK-0006tC-5u
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 20:08:31 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso4137777a91.2
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 17:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789344509; x=1789949309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jCURvq3peylDGPhQ7UrlrETYmQ0E5EKE8owoGQOGrkg=;
 b=AaEMwBHhEJUuslsmQlIcMTw2wgY3Pzewif6wf9RDFat0B9IkYyQbJ07OZG5BM5/jSM
 0c6EumQDBqVMiKtkH0MPirma2e3L1URCcn53Ejm+kAzxJ70MHsLeCk7nzVRqtAn3km18
 17tWUfQVDHeabbY5BxpaMwGe2P27YbWSifIGFiP5HWrUVFaO3+dZK6ijl56Wsig02jR1
 IQXK7q3ivRe247HK1r3ycpxuGhy+fwMRaKeVDJ9+YSDV9NYI8cbww9y/VKI21Ik099Ts
 g9jI3uaLf8gg9PLDBHV7u8jg01V4IZSCOG1OOSPPk+SIYwoD/T9AI34CuNndc/qg83b6
 GcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789344509; x=1789949309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jCURvq3peylDGPhQ7UrlrETYmQ0E5EKE8owoGQOGrkg=;
 b=oaGr2O8ilg/RlvkKZzSXy5ToOSK8/0krdvsQxGxDlO1h5qKZ9wO9npy9g80S5ABrjz
 9X7YcBmLGc86NTOua7g7kUgqy9tD4jgHD+BdIEKRhg4jnEjuWQSeIRs/Rm4OUVl20GzR
 bGAGHcGVBfWn7z3REOWPQL8OUlof7pmGQwaU8zbc33yqlBSlgnl9wyMjhO1E0EdofSUU
 R0YN/MSWc7OtvRWMzo78jaa6tMbUva7a47SnBSAXT4jSUU67qfLdE4yRI59XVK3wVurY
 ZFep9Ulo/FAixh5AsWknfAXNV77oKi3piGRuCxX0yH5XGNhO4gBdDB+snitTep7BkN+X
 fvng==
X-Gm-Message-State: AFuF++lj20ImQK7jcGm2QwB5a8aaVh3Kzhr1alvkT1uHaqXWbW6sDJo4
 hHSBl/YlG8zjt6AuV+2/BGXHXSOljCp+kIn1E3+x0ii+kM2C308pKmakrswzYkbtgIj1p/dM0pr
 udqa5RHw=
X-Gm-Gg: AYBFou0cqsw2cfmhTpU+PWiBgHfKLnMoVeeUEZkVFua40pAUciNoGv1iRsgIg8p0jDI
 dfqRVS/yGjBFXvQeCxhuANTZUQnXKezDtKE3uCyQq6Oe4bNsLDuo/fxAbaZvAJ9tE6FLEAfObe7
 uJ9fufbwmTWDL6/+YPo537L6sYS4RtdJEKtuXEoPagNIVvMy3uqNtyRpJpgYjbY+xB+ip838Kmp
 XTBR/jAPUWQtKOPcMUXAH6PFAHu5YDYvM7GtFeSkKYMnB+HykczWEj5xxS72IMhYiK7KuP0EVt0
 wF+dha1TZoC9bGLs3S+VybW01Q+1eK011kI9IsdI7sfFFI8eG8pcbRV31UmoCu/IDZOoz5Jkz9j
 bmntvqw+5dtJgRJFRA6IrVlXJQp6K1YKpNqNKv/RXiV6JW5kHq3uKw4j4TLBqCoL5Yo4pNSXVEZ
 xp13KJGG5c3CoW+boJM+L7muQ9GvO74uI/mc7ZU77UeiunbKBIPrqMgdWpGI9lNKr7P+ZMSZjdj
 fObyFAk4tC03F4eDQ==
X-Received: by 2002:a17:90b:2885:b0:398:9be5:b419 with SMTP id
 98e67ed59e1d1-39dec0bf165mr583034a91.20.1789344508633; 
 Sun, 13 Sep 2026 17:08:28 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:1665:91c0:9a80:f870])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14382741839sm4937677c88.6.2026.09.13.17.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:08:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com, palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com,
 Alistair.Francis@wdc.com, philmd@oss.qualcomm.com
Subject: [PATCH v3 08/11] tcg/riscv64: Return success from encode_bimm
Date: Sun, 13 Sep 2026 14:08:11 -1000
Message-ID: <20260914000814.785155-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914000814.785155-1-richard.henderson@linaro.org>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Centralize the range test for this encoding.
Directly OR into the insn value.
Assert success in encode_b.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv64/tcg-target.c.inc | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 09bfce79bb7..e8e1480016c 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -478,22 +478,25 @@ static tcg_insn_unit encode_s(RISCVInsn opc, TCGReg rs1,
 
 /* Type-B */
 
-static tcg_insn_unit encode_bimm12(tcg_target_long imm)
+static bool encode_bimm12(tcg_insn_unit *insn, tcg_target_long imm)
 {
-    tcg_insn_unit ret = 0;
-
-    ret |= (imm & 0x1000) << 19;
-    ret |= (imm & 0x7e0) << 20;
-    ret |= (imm & 0x1e) << 7;
-    ret |= (imm & 0x800) >> 4;
-
-    return ret;
+    if ((imm & 1) == 0 && imm == sextract32(imm, 0, 12)) {
+        *insn |= ((imm & 0x1000) << 19
+                  | (imm & 0x7e0) << 20
+                  | (imm & 0x1e) << 7
+                  | (imm & 0x800) >> 4);
+        return true;
+    }
+    return false;
 }
 
 static tcg_insn_unit encode_b(RISCVInsn opc, TCGReg rs1,
                               TCGReg rs2, tcg_target_long imm)
 {
-    return opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20 | encode_bimm12(imm);
+    tcg_insn_unit insn = opc | (rs1 & 0x1f) << 15 | (rs2 & 0x1f) << 20;
+    bool ok = encode_bimm12(&insn, imm);
+    tcg_debug_assert(ok);
+    return insn;
 }
 
 /* Type-U */
@@ -626,12 +629,7 @@ static bool reloc_bimm12(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     intptr_t offset = (intptr_t)target - (intptr_t)src_rx;
 
     tcg_debug_assert((offset & 1) == 0);
-    if (offset == sextreg(offset, 0, 12)) {
-        *src_rw |= encode_bimm12(offset);
-        return true;
-    }
-
-    return false;
+    return encode_bimm12(src_rw, offset);
 }
 
 static bool reloc_jimm20(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
-- 
2.53.0


