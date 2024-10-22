Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96EBD2C546
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 12:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3E1w-0008Dl-8p; Tue, 22 Oct 2024 08:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziyao@disroot.org>) id 1t3E1n-0008DK-Dm
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:30:23 -0400
Received: from layka.disroot.org ([178.21.23.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziyao@disroot.org>) id 1t3E1l-0000JH-1k
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 08:30:22 -0400
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 1384F251F6;
 Tue, 22 Oct 2024 14:30:17 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TQFzeQXmZylN; Tue, 22 Oct 2024 14:30:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1729600216; bh=a/YZcW8YxjOmYvsTZ0iL4/J2bJunSuzWS/3qnVKHepM=;
 h=From:To:Cc:Subject:Date;
 b=SY11+tcoqgVsJ+5pwh9qOK3orL9KEDTNBZafxlEMmg/gqR5YxdAx/vDLJ0fT6cbcN
 w0CNOG3npxrHum2H80l7DkKNFFF9r4cBehTsqjsVJ/2FAvdHCjYfv8eP96JBQABRSn
 zQmqn+oHbrlJEaD8L/1N9PjbVbdf4vXr9dV+4m0p5RgrmaOwgbnBBnthcIR8Sn1U/f
 Ya/tuzLZFwJ0cG+JQrFsUwoXLXF1FLQzIJ1HulNXzyMPOaGAVSLEd8QV8iDBuneTU4
 Qi0Vsi9ytPKkZOUa4PaA+XDtBDVpSMnaoRRgFLT/A0IrNu2FC3TgSVUBiufMdi3eJh
 nMUnue7VROjSA==
From: Yao Zi <ziyao@disroot.org>
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Cc: Michael Vogt <mvogt@redhat.com>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH] linux-user: Fix build failure caused by missing __u64 on musl
Date: Tue, 22 Oct 2024 12:29:30 +0000
Message-ID: <20241022122929.17465-2-ziyao@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.21.23.139; envelope-from=ziyao@disroot.org;
 helo=layka.disroot.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Commit 9651cead2f ("linux-user: add openat2 support in linux-user")
ships a definition of struct open_how_ver0 while assuming type __u64 is
available in code, which is not the case when building QEMU on musl.
Let's replaces __u64 with uint64_t.

Fixes: 9651cead2f ("linux-user: add openat2 support in linux-user")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 linux-user/syscall_defs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 0ade83745e..0e08dfae3e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2750,9 +2750,9 @@ struct target_sched_param {
 
 /* from kernel's include/uapi/linux/openat2.h */
 struct open_how_ver0 {
-    __u64 flags;
-    __u64 mode;
-    __u64 resolve;
+    uint64_t flags;
+    uint64_t mode;
+    uint64_t resolve;
 };
 struct target_open_how_ver0 {
     abi_ullong flags;
-- 
2.46.2


