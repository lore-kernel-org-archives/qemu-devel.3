Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65479C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUX-0007JW-UF; Wed, 12 Aug 2026 18:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUV-0007H8-Px
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:07 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUQ-0000z1-1m
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:07 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cbedf6a6fe8so124854a12.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573921; x=1787178721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SCuV3C+7clgJdLkynfMUM6QYtPO3WJDVL5JJ6lS4dYs=;
 b=tV/0xvyrcTN+Ua7lzDcP3MaWCAFq/mM9azqPkQibGCs8/YDZgmyKjcaF3u+7fS6aWm
 TOUBvSfE5LH3fdDl2mNwxoZ847SfsL3Jb2Ljds7WdX2Ziov8zeKDDoliReJXW4BB+d75
 CU0qQ2BrPMmcps/Ipzzn2HDwcQ1oaalAXtGeoh7KsZOMhjDQyFkNQkKBSgi/kqJLOhy4
 yTYj3aXIOxT2K151jSuIgb4MeasRZND09nMwWUH+Jkwf86Igd1wHPNXcegTGS6wS76ME
 KHbn5yprsnpKzYsfpvk4FRmf+g0tQ97wy1TyV6mPJbgew4F6C15wi2/HPvglON+VqHXP
 tzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573921; x=1787178721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SCuV3C+7clgJdLkynfMUM6QYtPO3WJDVL5JJ6lS4dYs=;
 b=tFxSxu90HGxUBvWyQaWh1TB4DZaZmM/tCQKDFfYHVTqxuwe2hJbzEfc3swEneVWww6
 9Fff/JThXoqOIR+ztBVD5vDMvo/BGOKMjL9rfaVF/29gRZkGTh/is7bAtgDDfvRI5x5Y
 hmo/shKjLylN8Llknv5bu6TzGqLgIXhSd2v+3BRwQxRqlhjyQqf5BciXHYtwVFod2mMP
 aY21jaoGmtc3RarqViu5TVnhY0Y3bK9YjnfaRNvGbLmCLps4klo+nxRWMcbQXsk9H980
 u03hbjOpRx5mAm6bYlJoZa4gOh75cxylgZH6kmA5z6sjADzxuUk0VzE1KlGvc3OfjZxd
 KCvg==
X-Gm-Message-State: AOJu0YyHiIAK2jFQbWP5B65+Jq57cZmHf1OFQpLHAtWCun+VhxMBHeHi
 ZZ/o85HivnfcIDtQ+PkBJTmznUotG1nmeFDhKqqlHmGhQpnoak3D8Z92wUgcaH7u/ugJ6KpDh83
 wQe+H
X-Gm-Gg: AR+sD10/xOFx83kiemSz4izSY0M8LP1pxk8ubpoxisqxbdr9jkuSEhOo2218l+Wv9RO
 i2XNnMkjSmdcwndGvozDnP5SrH4yTKYZVrGkW0IB0ZOd/zkHSNT0qjnQGRzOipCqS7qji7pJSzt
 yD/p0LbaST+8v5HU/gqOLy1LokrZ2iaUu24Q8i/gQabuYo4Rb67C2X3Iyxns+ca9YWXPTM9Wmcy
 7dWYu3rLipphg3zv14N6CbrHtqkGBs1CQIxreCsd55jxu2vJaO72ExKLWKwSYY5F5ffYY3xQWoj
 w45PthgRSu5JXH9oDhDI/z1TIB2Bi2DuIWd3OyIkTx5izuXtHXHb8IHKgUovC8C9mflmens5crd
 9pXTIyF0QWwZcjZsWc4wKV2sga+sNJzYx4o9e1pjKbaxQxLrZ0NyT6Rj+ZuGdmJ5Kbqp09fJ+UX
 AvGZCUxWJA9fOwyvmHXMO51mzY1v4vDLb36UZGqIQ1uaSCTpP3hd+tNwTwodKeTV1YxEUVt9rKY
 jmumWaBkKPgJ15BdDdy
X-Received: by 2002:a05:6a21:e8a:b0:3c4:1c9f:d7e with SMTP id
 adf61e73a8af0-3cc54f3e681mr2401606637.6.1786573920697; 
 Wed, 12 Aug 2026 15:32:00 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 15/52] disas/riscv: Handle c.lui imm != 0 during decode
Date: Wed, 12 Aug 2026 15:31:05 -0700
Message-ID: <20260812223142.349142-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7978ffb378..d6fbb3bca6 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1902,9 +1902,9 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.li", rv_codec_ci_li, rv_fmt_rd_rs1_imm, NULL, rv_op_addi, rv_op_addi,
       rv_op_addi },
     { "c.addi16sp", rv_codec_ci_16sp, rv_fmt_rd_rs1_imm, NULL, rv_op_addi,
-      rv_op_addi, rv_op_addi, rvcd_imm_nz },
+      rv_op_addi, rv_op_addi },
     { "c.lui", rv_codec_ci_lui, rv_fmt_rd_uimm, NULL, rv_op_lui, rv_op_lui,
-      rv_op_lui, rvcd_imm_nz },
+      rv_op_lui },
     { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli,
       rv_op_srli, rv_op_srli, rvcd_imm_nz },
     { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai,
@@ -3032,9 +3032,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     break;
                 }
             }
-            switch ((inst >> 7) & 0b11111) {
-            case 2: op = rv_op_c_addi16sp; break;
-            default: op = rv_op_c_lui; break;
+            if (inst & ((1 << 12) | (0x1f << 2))) {
+                switch ((inst >> 7) & 0b11111) {
+                case 2: op = rv_op_c_addi16sp; break;
+                default: op = rv_op_c_lui; break;
+                }
             }
             break;
         case 4:
-- 
2.43.0


