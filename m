Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF82C369D3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 10:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9M53-0001ow-Mg; Mon, 28 Apr 2025 06:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1u9M51-0001ml-G9
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:51:19 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1u9M4x-0007Bt-M3
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:51:19 -0400
Received: from DESKTOP-2KAPMGM.corp.microsoft.com (unknown [108.142.230.59])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8DF222020950;
 Mon, 28 Apr 2025 03:51:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8DF222020950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1745837472;
 bh=Ex8BfWVinQpGxwfXw/KpfTC8RxhddmU7Hpfd9A+LMxQ=;
 h=From:To:Cc:Subject:Date:From;
 b=jvLovneb2hpZY+Zyew/Oy0YB4RcBPPMQiVCYdl60jMe0H0b+/GdQpNKhf/oXNhex6
 cgvJMTLfE+5lwEaJYycbAWQXYilzG+2VhyScejN41s1T6ZbGpTNz7dcnmrBiRnbOCK
 GGtFr0RHHrMg1rrXolN5nNT+ilwhum5wyveU3wx8=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2] i386/emulate: remove rflags leftovers
Date: Mon, 28 Apr 2025 12:51:08 +0200
Message-Id: <20250428105108.196762-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In c901905 rflags have been removed from `x86_decode`, but there were
some leftovers.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/emulate/x86_decode.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 7fee219687..7efa2f570e 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -1408,7 +1408,7 @@ struct decode_tbl _2op_inst[] = {
 };
 
 struct decode_x87_tbl invl_inst_x87 = {0x0, 0, 0, 0, 0, false, false, NULL,
-                                       NULL, decode_invalid, 0};
+                                       NULL, decode_invalid};
 
 struct decode_x87_tbl _x87_inst[] = {
     {0xd8, 0, 3, X86_DECODE_CMD_FADD, 10, false, false,
@@ -1456,8 +1456,7 @@ struct decode_x87_tbl _x87_inst[] = {
      decode_x87_modrm_st0, NULL, decode_d9_4},
     {0xd9, 4, 0, X86_DECODE_CMD_INVL, 4, false, false,
      decode_x87_modrm_bytep, NULL, NULL},
-    {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, NULL, NULL,
-     RFLAGS_MASK_NONE},
+    {0xd9, 5, 3, X86_DECODE_CMD_FLDxx, 10, false, false, NULL, NULL, NULL},
     {0xd9, 5, 0, X86_DECODE_CMD_FLDCW, 2, false, false,
      decode_x87_modrm_bytep, NULL, NULL},
 
@@ -1478,20 +1477,17 @@ struct decode_x87_tbl _x87_inst[] = {
      decode_x87_modrm_st0, NULL},
     {0xda, 3, 3, X86_DECODE_CMD_FCMOV, 10, false, false, decode_x87_modrm_st0,
      decode_x87_modrm_st0, NULL},
-    {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
-     RFLAGS_MASK_NONE},
+    {0xda, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
     {0xda, 4, 0, X86_DECODE_CMD_FSUB, 4, false, false, decode_x87_modrm_st0,
      decode_x87_modrm_intp, NULL},
     {0xda, 5, 3, X86_DECODE_CMD_FUCOM, 10, false, true, decode_x87_modrm_st0,
      decode_decode_x87_modrm_st0, NULL},
     {0xda, 5, 0, X86_DECODE_CMD_FSUB, 4, true, false, decode_x87_modrm_st0,
      decode_x87_modrm_intp, NULL},
-    {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
-     RFLAGS_MASK_NONE},
+    {0xda, 6, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
     {0xda, 6, 0, X86_DECODE_CMD_FDIV, 4, false, false, decode_x87_modrm_st0,
      decode_x87_modrm_intp, NULL},
-    {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
-     RFLAGS_MASK_NONE},
+    {0xda, 7, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
     {0xda, 7, 0, X86_DECODE_CMD_FDIV, 4, true, false, decode_x87_modrm_st0,
      decode_x87_modrm_intp, NULL},
 
@@ -1511,8 +1507,7 @@ struct decode_x87_tbl _x87_inst[] = {
      decode_x87_modrm_intp, NULL, NULL},
     {0xdb, 4, 3, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL,
      decode_db_4},
-    {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL,
-     RFLAGS_MASK_NONE},
+    {0xdb, 4, 0, X86_DECODE_CMD_INVL, 10, false, false, NULL, NULL, NULL},
     {0xdb, 5, 3, X86_DECODE_CMD_FUCOMI, 10, false, false,
      decode_x87_modrm_st0, decode_x87_modrm_st0, NULL},
     {0xdb, 5, 0, X86_DECODE_CMD_FLD, 10, false, false,
-- 
2.34.1


