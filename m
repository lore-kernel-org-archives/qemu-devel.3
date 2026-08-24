Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C337C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNaq-0004WL-W7; Mon, 24 Aug 2026 01:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaF-00048W-W6
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaE-0002YR-0V
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:59 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2d560775ca2so24630725ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550656; x=1788155456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3+CQdeS4ZDd2cPsyFQmittENkduVaoRgr67sy9mGB6w=;
 b=mNwyBWXKfF8yREt1GxwpTuTfakK2RarG+nwqHKC5noqTYJpnt3z45s4fjZcktCC/Bp
 E17jWGg70IxhSc3nixVw3cn3hnA/XJbKTsrz6ZC4N1IGjs4EkQ8FaSBNmJCj2Wcy+JX+
 hd0C7pqALYAGFGQac0Jf/YrlpT2WaHLRX62QKKDGk8hdve/RdBhzbWlrsFi3oZ3lrTBW
 yRwzOJ8l6CR92/yo3s/JILmnvVEBiR3HcdY6Hg7jnyoTG3sh7sxNNyfWpyaieyN09nhe
 V/r+F8WhVhoEKdbDHMqTSxQvjcwHR3iHwmEz+7SyXrVrq+e8pYm2w9SDSaiyHnMudDFS
 AICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550656; x=1788155456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3+CQdeS4ZDd2cPsyFQmittENkduVaoRgr67sy9mGB6w=;
 b=PZpU9g7nHSHp5cxvo9pyTV36ZqU8TretTEJFSpTL5qGZ4cPOqfMYKrk2emaB8vWNn8
 8pbasmsHDiyN3sjngc7w3XECQcpPz+zWE/YDsxZPNAc/JYh4krESV5NieXgQ+TxYZior
 P8xJ2IehtDNsDbEvYerD0VMrV4fv4yjF4JycgqsnjowuApLIVkt9lnesDiCRzHH6fOWQ
 yuJuIvecgLq+9QAfFu66sQH/KOx7gL+ywgEq0wIJIwOSdsj8+4mIJs+RZ/W42ffs+lTA
 pgeTUNlA8xJjyZhqNjKhkvKFtAGJedgXm7XE2Xy1zXXK6YtVWQOAaTYtYeIHm1flIwNA
 GGYg==
X-Gm-Message-State: AFuF++lrKtddfCqljBtGPU+GWqvdInVq/Qpow1gwVRUrpgFdKtYj4miy
 yahwcfo8ryFP1sYSp4e0JhT4oE2+6lx9FDo6JYFADf+b1PuVzrCwBRiP8cRgYA==
X-Gm-Gg: AR+sD13NYWToUuCCvaHFMiMXQzZjb8aWm+eIBgGtW3mL/hIExOpx/OXuOdD8l+RvrTE
 E+O0OdIZFGcBTLsVJXq8JzNjGdzuPohiPqZxI17L/oPkl1gb0zB0ei9So6IK0EwasLNkiHeh1Qo
 zvA+WSrm0mMykpRSNRQGKsp/atx7j4+kqydo4f4kWR2PbujtiDuAbosx22fZuE76otP2xIqbUqb
 RuJe53NgWdL8au1YyBVHYEGWHxRIFcHMrWdKXuY6iDch8bEbosiOK7RUWWMmdUGkvOT1b33Noo5
 xOubORBDmmSzYZWFwr/YBSIpe/7vmAyr79RvMiKbEUC+PzKTsvAeDO1qYr82P3VcEtBGIvEsq63
 uN1PNAqvj9oeg6nxpfODq/rttyLgV6J8RocxaHn+ig7yA3O20GvpPYKCmu6kQ/OX1ABqh5d5bR2
 Gw1Y077iE4pA5RKBwA2RP8Vsd3VfqFLIK+32GZKb2c3nYbc0prtr+leQFhr26Lf9I5kcFkmfxZu
 Ukx2A==
X-Received: by 2002:a17:90b:524b:b0:38f:7f60:ba35 with SMTP id
 98e67ed59e1d1-395deec4953mr30451578a91.5.1787550656544; 
 Sun, 23 Aug 2026 22:50:56 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:50:56 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 51/96] disas/riscv: Do not recognize c.{addw, subw} with rv32
Date: Mon, 24 Aug 2026 15:47:21 +1000
Message-ID: <20260824054806.2790041-52-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

These code points are reserved with RV32.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-19-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 77347b557d..ddc2f73eae 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3060,8 +3060,16 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 1: op = rv_op_c_xor; break;
                 case 2: op = rv_op_c_or; break;
                 case 3: op = rv_op_c_and; break;
-                case 4: op = rv_op_c_subw; break;
-                case 5: op = rv_op_c_addw; break;
+                case 4:
+                    if (isa != rv32) {
+                        op = rv_op_c_subw;
+                    }
+                    break;
+                case 5:
+                    if (isa != rv32) {
+                        op = rv_op_c_addw;
+                    }
+                    break;
                 case 6: op = rv_op_c_mul; break;
                 case 7:
                     switch ((inst >> 2) & 0b111) {
-- 
2.54.0


