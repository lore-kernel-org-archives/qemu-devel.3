Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B128C4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Feb 2024 12:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZ8xg-00068E-HZ; Sun, 11 Feb 2024 07:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xe-00067H-At
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:30 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rZ8xa-0006F0-4g
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 07:29:29 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A9ECACE0D8B;
 Sun, 11 Feb 2024 12:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9642FC433C7;
 Sun, 11 Feb 2024 12:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707654554;
 bh=vx4xC5M+DPAKkeJWujimrHUf61MEn29t9idgCCP1zPY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZMGeVWXw/swr9HHmP4u1QJbNc+E65RvxgCTkgqdpFZ0xDPouDPn4GX6RQeKwmiSGW
 9Le4m1LcV9s6ImAvbSp62hIH4mRSBQzb07qIgRicwzG8+OyHMU6XyqIkJYA4c7PkxD
 ao++5bDoRwOQry7dQaYyT+etYUcxEEa6Q3n982EPlWq7IoMT/0HQDVnxR6rk9vwg1w
 cb4bQOgLVDNQZ0uLc+50MxaCqsd8yJeXCpKpTtKzDW+8lewPy1C2O7xw6BndQhDwK+
 rvm1hUMYJU1cu2blMR+284aeSBjZO2ASBANayhR3cKgJx7J0ZW2rUTfYi5w/xVYZPp
 7HM8g9q4tdHcg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 01/12] disas/hppa: Add disassembly for qemu specific
 instructions
Date: Sun, 11 Feb 2024 13:28:58 +0100
Message-ID: <20240211122909.5807-2-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211122909.5807-1-deller@kernel.org>
References: <20240211122909.5807-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


