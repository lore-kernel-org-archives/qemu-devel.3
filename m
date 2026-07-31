Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A9DC55171
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wposO-0004su-GW; Fri, 31 Jul 2026 11:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wposM-0004sJ-Ly
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 11:10:18 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wposL-0003mC-7u
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 11:10:18 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1EDA342DF6;
 Fri, 31 Jul 2026 15:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5271F000E9;
 Fri, 31 Jul 2026 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785510608;
 bh=vRB6H1gCepGHckPzvKjsxfuEiZldwtlECVNiwH1edRg=;
 h=From:To:Cc:Subject:Date;
 b=TEhWy6lRUoDATpm8NNABL6SXaWCGobsUUPzYzyEBJe6Fu2JzQi7WCcLzSIGex3jz9
 k/rfzM8l32sy1PRwrTmqjjbJyTfeQ+ftrUOujoXcBjkfUxAq/RKyWKag18xYH3F9+T
 IAzp7aHAUgMQXMby7Rk33wDyQH5fTKBVFOahvsRPkEMhL07aPcLw3XgRg5Cau14FJ0
 qD597Vz4sspfPg42wM9Tb9Z/XLoP/j8bgfTMQuFL+L/2VFrE/xCMq8WTsmSKuKcntX
 aPbR6DzoIy3UScVHPLhpLsE5I6w06tOSj5kOdjCdQsYctDIIsUnOhnAJ18l9VdpkJZ
 /E3IwMI12TzaQ==
From: Helge Deller <deller@kernel.org>
To: Christoph Hellwig <hch@infradead.org>,
 linux-abi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH] [RFC] UAPI: Add QEMU linux-user emulation flag
Date: Fri, 31 Jul 2026 17:09:49 +0200
Message-ID: <20260731150949.5536-1-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

For some userspace applications it's useful to know if they currently
run on QEMU's linux-user emulation. Such programs are for example the
LTP testsuite, which could avoid testing specific testcases, or systemd
which should avoid use of specific syscalls.

This RFC is about adding a QEMU_LINUX_USER flag to the personality()
syscall which would be injected by qemu-user binary.
Applications may then call personality(-1), and check the
QEMU_LINUX_USER flag to determine if they are running on qemu-user.
Adding this flag seems for me to be the least invasive change. No
changes to uname strings which would need to be parsed or other
modifications to the emulation.

As this patch is just an RFC, maybe people come up with other ideas?

Signed-off-by: Helge Deller <deller@gmx.de>
---
 include/uapi/linux/personality.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/personality.h b/include/uapi/linux/personality.h
index 243f5f80a7b8..ba6ddaef8954 100644
--- a/include/uapi/linux/personality.h
+++ b/include/uapi/linux/personality.h
@@ -9,6 +9,7 @@
  * These occupy the top three bytes.
  */
 enum {
+	QEMU_LINUX_USER =	0x0010000,	/* Qemu linux-user emulation */
 	UNAME26	=               0x0020000,
 	ADDR_NO_RANDOMIZE = 	0x0040000,	/* disable randomization of VA space */
 	FDPIC_FUNCPTRS =	0x0080000,	/* userspace function ptrs point to descriptors
-- 
2.54.0


