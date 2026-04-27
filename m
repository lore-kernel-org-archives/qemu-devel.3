Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2F2FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFAX-00060B-7d; Mon, 27 Apr 2026 02:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFAU-0005kz-2v
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:10:06 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFAR-0000v9-1a
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:10:05 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35da9692ec3so8365184a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777270201; x=1777875001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBcVT+obBYS91zplWsOFxFkEBOsc1m6WJh1ih9s8+dw=;
 b=iyGDXtmGNRTx/gw6lI2o8XHOKykPLRUQdTTbvQ53xR0Xjt7zZdTR4hjLM/j2PJahcS
 s1gk7vyoHSyYlkjEzNF2GiwRfuPrgiE0IyOJ07GIrv5MMxwzW4BETB9D5co2AmIG7Hpm
 PbxA0anzT3l4Ohn7+gdQQnlTqXLaTbM9HAakJAQDPhbuwWynlxA+tXcI4atR7bAI92bJ
 VSP23+++DdInsDuxfozKL/tptAbtos2O4ZN2Bkr2UqOH03lm0s6JxWB3WLdYAg1CiKEs
 ZWtBJY4rcX5gKyMgXmnWm+4tv4RWCS2BInQGDjZDHixv/UqK1WLD/SNsPEzKk73UGakQ
 OrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777270201; x=1777875001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TBcVT+obBYS91zplWsOFxFkEBOsc1m6WJh1ih9s8+dw=;
 b=htTOEt4HVRjgUpuhETv1awYvP1ObBUgC5vb480Wt6G/XdtNJHtciwBZ+OMUyCC97kr
 oubw1MxXBqGZTHmvT5aHQDz3wStCbK60f726qey2GWI+6eZ1V4hZT8hHMdENda8Ppu/9
 9O1NXGe/9IK5MFkodbr7s7vgOuXUWdZu78KOsjUH7jy4YnonqbkHRsDGVyc2oI/tax/V
 Bxx8w/lajwhe/dtbjzhrwjMj6AZPFN9fF4Nlxn/uCVcn8PRW8ICjAZqUvDlnw6BVHsIS
 /Ow/4u/YgV27F418uDsZFtAaRdQaALZlvyM1vGNeoKLwDGSxH/qFBD3kRGQPjdVjPCxr
 tuYg==
X-Gm-Message-State: AOJu0Yy8nwpUfKd7j4S1xLq/kzyrBN4/kIev4XmFaID8hFSA3Zt3ANqz
 qecrup9Rv60cuABf8RU3iiQ/T0uJM8snZUnRAsfbvVp0sV0sc7pRjr2UgnD8bRLuTr2GK49Ra3p
 /YX2+n/Cvu+lHE9x1EzyGo5W+eNFCPq11wHupRknx6TNaDOLS+P2MCt9R2yQxQ5kVzJ+/EFf8B5
 B5FaG9jr5+b68jOpVnYQq5XuMrawOlouhsIFO0AXk=
X-Gm-Gg: AeBDietGAoVQUiSSN+C223W5OeX5+641KWR66+e0dyyTZUiCXahfg0FzgbxVVgWsrRZ
 wlmFFubBNU4gpXxBCMMcm/JzVEQJZwPcmo+XMKDju2nzBkpik57jrwRvpxCqktgKBThQcmLMVtD
 YWLybDYJ+PpS1nuDIczRuYsKzL0p7I4BJlniTPsU3Tl3SR//zA7Vck9z/VCM5G8s4MCRI62xoGP
 RvVP8O9bxR2/PGd3M59e0UoGOn6cTeWh7Q4IUE+E5NTwtx3nW3k2yq47Q3cHsQ96SSprHTgzQvs
 kl4uE5gpmE+IRynFAB8KbHieLRiSRH5oNy07dCLJknOIM81fv0fzQ6cOszPtGfLAq1ke3v5x+NE
 3hewdGKjY2qwGfJ03o6ZcrJVKG4+/ij3SaSUuGIwsjG4fDEsroBKEGZmgfpmwTU6iCaVey/zUsl
 OQOx8Xj6ywB/uaVZ1u6ZxE+DLcugBiXgSOS6EYAmuG5imMr2HbnLwgFOZo9G3kij2IlDha8vvku
 CAOl8YUMH/+5a2BzHxe9IkrKs5jcJHviqtjxA==
X-Received: by 2002:a17:90b:4b87:b0:35b:9b77:d7c with SMTP id
 98e67ed59e1d1-36140469b55mr43668382a91.14.1777270201239; 
 Sun, 26 Apr 2026 23:10:01 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410bac6dsm30290710a91.14.2026.04.26.23.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:10:01 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v5 9/9] disas/riscv: Add support of Zvfofp8min extension
Date: Mon, 27 Apr 2026 14:09:28 +0800
Message-ID: <20260427060928.2322570-10-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427060928.2322570-1-max.chou@sifive.com>
References: <20260427060928.2322570-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1031.google.com
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

This patch adds support to disassemble Zvfofp8min instructions.

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/disas/riscv.c b/disas/riscv.c
index d416a4d6b3..8a169deba0 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -985,6 +985,9 @@ typedef enum {
     rv_op_ssamoswap_d = 953,
     rv_op_c_sspush = 954,
     rv_op_c_sspopchk = 955,
+    rv_op_vfncvtbf16_sat_f_f_w = 956,
+    rv_op_vfncvt_f_f_q = 957,
+    rv_op_vfncvt_sat_f_f_q = 958,
 } rv_op;
 
 /* register names */
@@ -2255,6 +2258,9 @@ const rv_opcode_data rvi_opcode_data[] = {
       rv_op_sspush, 0 },
     { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
       rv_op_sspopchk, 0 },
+    { "vfncvtbf16.sat.f.f.w", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vfncvt.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
+    { "vfncvt.sat.f.f.q", rv_codec_v_r, rv_fmt_vd_vs2_vm, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -3631,7 +3637,10 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 21: op = rv_op_vfncvt_rod_f_f_w; break;
                     case 22: op = rv_op_vfncvt_rtz_xu_f_w; break;
                     case 23: op = rv_op_vfncvt_rtz_x_f_w; break;
+                    case 25: op = rv_op_vfncvt_f_f_q; break;
+                    case 27: op = rv_op_vfncvt_sat_f_f_q; break;
                     case 29: op = rv_op_vfncvtbf16_f_f_w; break;
+                    case 31: op = rv_op_vfncvtbf16_sat_f_f_w; break;
                     }
                     break;
                 case 19:
-- 
2.52.0


