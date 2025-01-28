Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEB1C02194
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 16:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcoF0-0005LZ-4i; Tue, 28 Jan 2025 11:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcoEx-0005J3-Qw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:15:04 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcoEv-0002ca-Sn
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:15:03 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C3EAB5C5B0B;
 Tue, 28 Jan 2025 16:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CC0C4CED3;
 Tue, 28 Jan 2025 16:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738080896;
 bh=WbGGD4NOS2h1QHYyZLIzVRv+R3c/kYBil40V5zV5alc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=uLAYYnymqtjbXdLzzVK8euyo9Bz2mlKKn3MtUKTV4slgmonvGL0FTtfAlrph2U+oE
 ZaUCezAP7gyOjHgF5Y20AfqC/KJLyQwDzi3mbZ2uTjiwblZtTpv2Dkgm1FGMxgHSoO
 1l7WWgBx8xivjaW3qS3CsfvRLXVDeY1xRYmEfk8K4K9cHGmRf22uu2XKF/ybFtVTBY
 +9CsbuJEGcf7eDDKlxlwmYMQ+NSyIhWYpSX4oscEdLJchd7EMTTYmXvRzk6J5TQeDv
 6/c3yqKw+0hS/qTqojkY5y1rI7UN+0AKxUCOpGZIPFhg7M+ZIXufLvdUKLOZTNEj1J
 hXeJuynkFciRg==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/5] disas/hppa: implement mfdiag/mtdiag disassembly
Date: Tue, 28 Jan 2025 17:14:47 +0100
Message-ID: <20250128161450.12975-3-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250128161450.12975-1-deller@kernel.org>
References: <20250128161450.12975-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Helge Deller <deller@gmx.de>

The various PA-RISC CPUs implement different CPU-specific diag
instructions (mfdiag, mtdiag, mfcpu, mtcpu, ...) to access CPU-internal
diagnose/configuration registers, e.g. for cache control, managing space
register hashing, control front panel LEDs and read status of the
hardware reset button.

Those instructions are mostly undocumented, but are used by ODE, HP-UX
and Linux.

This patch adds some neccessary instructions for PCXL and PCXU CPUs.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 disas/hppa.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/disas/hppa.c b/disas/hppa.c
index 49e2231ae6..2b58434966 100644
--- a/disas/hppa.c
+++ b/disas/hppa.c
@@ -606,7 +606,7 @@ struct pa_opcode
 
    In the args field, the following characters are unused:
 
-	'  "         -  /   34 6789:;    '
+	'  "         -  /   34 678 :;    '
 	'@  C         M             [\]  '
 	'`    e g                     }  '
 
@@ -650,6 +650,7 @@ Also these:
    |	6 bit field length at 19,27:31 (fixed extract/deposit)
    A    13 bit immediate at 18 (to support the BREAK instruction)
    ^	like b, but describes a control register
+   9	like b, but describes a diagnose register
    !    sar (cr11) register
    D    26 bit immediate at 31 (to support the DIAG instruction)
    $    9 bit immediate at 28 (to support POPBTS)
@@ -1322,13 +1323,19 @@ static const struct pa_opcode pa_opcodes[] =
 { "fdce",	0x040012c0, 0xfc00ffdf, "cZx(b)", pa10, 0},
 { "fdce",	0x040012c0, 0xfc003fdf, "cZx(s,b)", pa10, 0},
 { "fice",	0x040002c0, 0xfc001fdf, "cZx(S,b)", pa10, 0},
-{ "diag",	0x14000000, 0xfc000000, "D", pa10, 0},
 { "idtlbt",	0x04001800, 0xfc00ffff, "x,b", pa20, FLAG_STRICT},
 { "iitlbt",	0x04000800, 0xfc00ffff, "x,b", pa20, FLAG_STRICT},
 
+/* completely undocumented, but used by ODE, HP-UX and Linux: */
+{ "mfcpu_pcxu",	0x140008a0, 0xfc9fffe0, "9,t", pa20, 0}, /* PCXU: mfdiag */
+{ "mtcpu_pcxu",	0x14001840, 0xfc00ffff, "x,9", pa20, 0},
+
 /* These may be specific to certain versions of the PA.  Joel claimed
    they were 72000 (7200?) specific.  However, I'm almost certain the
    mtcpu/mfcpu were undocumented, but available in the older 700 machines.  */
+{ "mfcpu_c",    0x14000600, 0xfc00ffff, "9,x", pa10, 0}, /* PCXL: for dr0 and dr8 only */
+{ "mfcpu_t",    0x14001400, 0xfc9fffe0, "9,t", pa10, 0}, /* PCXL: all dr except dr0 and dr8 */
+{ "mtcpu_pcxl",	0x14000240, 0xfc00ffff, "x,9", pa11, 0}, /* PCXL: mtcpu for dr0 and dr8 */
 { "mtcpu",	0x14001600, 0xfc00ffff, "x,^", pa10, 0},
 { "mfcpu",	0x14001A00, 0xfc00ffff, "^,x", pa10, 0},
 { "tocen",	0x14403600, 0xffffffff, "", pa10, 0},
@@ -1336,6 +1343,9 @@ static const struct pa_opcode pa_opcodes[] =
 { "shdwgr",	0x14402600, 0xffffffff, "", pa10, 0},
 { "grshdw",	0x14400620, 0xffffffff, "", pa10, 0},
 
+/* instead of showing D only, show all other registers too */
+{ "diag",	0x14000000, 0xfc000000, "D  x,9,t", pa10, 0},
+
 /* gfw and gfr are not in the HP PA 1.1 manual, but they are in either
    the Timex FPU or the Mustang ERS (not sure which) manual.  */
 { "gfw",	0x04001680, 0xfc00ffdf, "cZx(b)", pa11, 0},
@@ -1801,6 +1811,12 @@ fput_creg (unsigned reg, disassemble_info *info)
   (*info->fprintf_func) (info->stream, "%s", control_reg[reg]);
 }
 
+static void
+fput_dreg (unsigned reg, disassemble_info *info)
+{
+  (*info->fprintf_func) (info->stream, "dr%d", reg);
+}
+
 /* Print constants with sign.  */
 
 static void
@@ -2007,6 +2023,9 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
 		case '^':
 		  fput_creg (GET_FIELD (insn, 6, 10), info);
 		  break;
+		case '9':
+		  fput_dreg (GET_FIELD (insn, 6, 10), info);
+		  break;
 		case 't':
 		  fput_reg (GET_FIELD (insn, 27, 31), info);
 		  break;
-- 
2.47.0


