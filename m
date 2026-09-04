Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99360C79F83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Ph1-0005JW-V6; Fri, 04 Sep 2026 04:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x2Ph0-0005In-Rf
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:54:38 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x2Pgz-0007Xy-Bp
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 04:54:38 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-398d2b28acfso562240a91.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 01:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788512076; x=1789116876; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cKiuKxyyWJSuIyXVWzlv/wqmaebtjtdx2ZKx6moBL3s=;
 b=RYT0FlQNJP46fqe03scRbKcEC9+0OBt6bJIRVblBS+Kv1EDmG4yL4ES5aS/mPEctnV
 V+Y0KVC8G1cn44uSABooreoAs+aWS6kgCERHUIgaCktQ94D2dk5QSwBMG038HC4zx1V1
 SrQM+Z0N1+aRdMdy+66ZwyHrs+Nq3e20ulX0IUXXBmRhI4j0DOPMYFiGhnVrt2HZyXtw
 yn1zvvlgos8sVuviO/Zp9KdaZA9xgkNdq4OnAUuIB4eVf2IaJrJZmnBe/osIOQA6LLra
 HaPtQqk7e7EP4tgHKWuKwHRBEoTLwmmkgSgps6Pk//Qear+0xxr+ov/FpRteDEs3xwED
 AAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788512076; x=1789116876;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cKiuKxyyWJSuIyXVWzlv/wqmaebtjtdx2ZKx6moBL3s=;
 b=BXovTJxprOPQUlVvAEick32onOllo6Ic5wjKgTAo70weLxA+v46UFAJAzbni4nghaX
 o/pgfrRI0d8b/DV7TbSJZhnrtutD2wn3cKyRO5dr6beoAfMo0Klxs88nffGj8oEbfHIW
 rlIEzuCLCNLd5xYtFPqjSsfg+TI4thJ46WOOAexPCEoSA6bbv7QPApLDvmt2eIsCJqmJ
 /HFZJ2u554VUEEGh1r0S6n6tYQUoGITXB9HvGka6Y3v52aXSk4wat8FrvQsRgylm4L34
 HhRtU5YZZDUkKchb98bvD7nNoBm0FzxcyQc+KxwtCC1QHtF5GsZcsJ3UulSxvD5V+9IQ
 jBSA==
X-Gm-Message-State: AFuF++lllXMfWnElHsQ97Gq5EVCcgSd3jPchfuhktA60iKEpYswr6kWN
 j9/XGjcNDykqYWeTrlvbBhqrAtrdi+bie009XmLp8IhPJKPWIx+HQdEjeONFsavMkZN575GKJez
 DZ9MBksmIXZ48HsRk6E9Ca77qcwuDQnfjFe/9ZUSKcqnEYfhRu9uUS1Luw6ayBcNoIdFJS/DaSz
 6eFhsixw+61WyF8IcVGxPpKFRWJnIQyzQr+BFy3y5CNQ==
X-Gm-Gg: AYBFou1YGwO45Gg1azE3dnyDiFFx/RTkAjPix3w8IbvQ59NoQde5eTiJjgHSyWr0oY0
 qN10cwYkAcuiJ6gQtNDBPzFLF+sQMGFdzds5CXYYXCNjByOBQMVqHcukwLWcwUItq/hGa+bljOL
 tR4zVq68NNnbeM4GHjut8Juuk5a+T7V3o5kTOXgPaGJaR/pgNZSgbdB81ouGHHQLQtRf+Bu7Ml6
 swgKoFKu07EQpowA2KIsOS8yQ5RSo7RMp8Jf9pMFsj6b72t01yyVyijbnmHSWSmiz/a/VJuqGBV
 iNG0cUSDhfyPsHiQXBxSE/8dk8Ju0oOckg3ZFTYrGjeRVNKrJ/96UM2EoY8tjmYnHcGFnUgFWVJ
 qxUeD1I71CCKiIlDTZkNIB7FH05kXn7GXaB2wOiWlpSClkpkhZZmDK9Mv2JfFcmK+TyFCJ+ex4Z
 8mi/6UoRGve5bAhuWUfizqb/nZcyhseFPZ1ZRuX+9Rp/PwurGG+4DGaF8r7xRoH41Rr3JSPoNJA
 Qn9/HEPcil76NOMy9tI4/Hd+wPV1/nmPPJvIjWl6aHPUKxLfz6Vn5teEyNs9pA=
X-Received: by 2002:a17:90b:4c4e:b0:399:1b64:e0d7 with SMTP id
 98e67ed59e1d1-39b262aaf32mr7108644a91.19.1788512075489; 
 Fri, 04 Sep 2026 01:54:35 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39ae8f1448esm4782912a91.4.2026.09.04.01.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 01:54:35 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Chou <max.chou@sifive.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 1/2] tcg/riscv64: Validate AUIPC relocation range
Date: Fri,  4 Sep 2026 16:54:25 +0800
Message-ID: <20260904085426.3686492-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904085426.3686492-1-max.chou@sifive.com>
References: <20260904085426.3686492-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

reloc_call splits a PC-relative offset into a signed 12-bit low
immediate and an AUIPC contribution. When the low immediate carries into
bit 31, the existing 32-bit arithmetic can accept an unencodable
positive 0x80000000 AUIPC contribution.

Keep the split in pointer-width arithmetic and reject it unless the
rounded upper contribution is representable as signed 32-bit. Factor
this validation into split_auipc_offset so reloc_call retains its
existing failure contract.

Fixes: dfa8e74f9463 ("tcg/riscv: Add the relocation functions")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 tcg/riscv64/tcg-target.c.inc | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 2ce9d47a633..76db0de94c3 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -641,14 +641,31 @@ static bool reloc_jimm20(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     return false;
 }
 
-static bool reloc_call(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+static bool split_auipc_offset(tcg_insn_unit *src_rw,
+                               const tcg_insn_unit *target,
+                               uint32_t *hi, uint32_t *lo)
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
+    *hi = (uint32_t)high;
+    *lo = (uint32_t)low;
+
+    return true;
+}
+
+static bool reloc_call(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+{
+    uint32_t hi, lo;
 
-    if (offset == hi + lo) {
+    if (split_auipc_offset(src_rw, target, &hi, &lo)) {
         src_rw[0] |= encode_uimm20(hi);
         src_rw[1] |= encode_imm12(lo);
         return true;
-- 
2.43.0


