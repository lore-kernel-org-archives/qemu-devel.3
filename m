Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D95C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 18:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmXR-0004mj-Uq; Wed, 07 Feb 2024 13:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXJ-0004jI-5P
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:41 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rXmXH-00085H-IF
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 13:20:40 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C2815CE1A10;
 Wed,  7 Feb 2024 18:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7FFC433F1;
 Wed,  7 Feb 2024 18:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707330028;
 bh=IvNlnF9mYMcbkeCT+SaYzUm45YczldzSE/Voy2+FLk4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eX/P7WNlMFcBE51lz+nsCTMushfvIyTB9hQmv6XR4LD9QkCRD/PSJcbF5cEYZt37R
 LvYFgFjwD+/RSbwsr4GJIv1KeT++bEN48sryXmxMdS5N65hQyCl8gwJL9NrI6ndV/+
 owRyKuxjs9asOIq8Y3TlwYtXrk2mXrzbIv7lFEWYNIqfR3eFa7k9VBAn+89KsjgJ6J
 VOpzSUCWL0bfPDqTmrX0jEPo0iWS9irPq9WzrSgz9/S9ZOKfiGdPD0I2Wlo8g7G8u4
 t1NILuk1XjC6Qc36HRZM5Z9SSEJU+ckCCt0e8chyhJpQ3UIcociH1uppkwM9lAzBv9
 dtfD8d4kCJR2w==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 01/13] disas/hppa: Add disassembly for qemu specific
 instructions
Date: Wed,  7 Feb 2024 19:20:11 +0100
Message-ID: <20240207182023.36316-2-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207182023.36316-1-deller@kernel.org>
References: <20240207182023.36316-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add disassembly of opcodes for "HALT QEMU", "RESET QEMU" and
"RESTORE SHR" (restore shadow registers).

Signed-off-by: Helge Deller <deller@gmx.de>
---
 disas/hppa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/disas/hppa.c b/disas/hppa.c
index cce4f4aa37..22dce9b41b 100644
--- a/disas/hppa.c
+++ b/disas/hppa.c
@@ -1609,6 +1609,10 @@ static const struct pa_opcode pa_opcodes[] =
 { "call",	0xe800a000, 0xffe0e000, "nW", pa10, FLAG_STRICT},
 { "ret",	0xe840d000, 0xfffffffd, "n", pa20, FLAG_STRICT},
 
+/* Opcodes assigned to QEMU, used by SeaBIOS firmware and Linux kernel */
+{ "HALT QEMU",	0xfffdead0, 0xfffffffd, "n", pa10, FLAG_STRICT},
+{ "RESET QEMU",	0xfffdead1, 0xfffffffd, "n", pa10, FLAG_STRICT},
+{ "RESTORE SHR",0xfffdead2, 0xfffffffd, "n", pa10, FLAG_STRICT},
 };
 
 #define NUMOPCODES ((sizeof pa_opcodes)/(sizeof pa_opcodes[0]))
-- 
2.43.0


