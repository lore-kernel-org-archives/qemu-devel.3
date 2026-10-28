Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD97606A322
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TiQO5PwU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM8Mu-0005c8-GK; Wed, 28 Oct 2026 14:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xM8Ml-0005aj-Vm
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:27:17 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xM8Mc-0003J3-WF
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:27:12 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 92219407F1;
 Wed, 28 Oct 2026 18:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523A81F01825;
 Wed, 28 Oct 2026 18:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793212019;
 bh=ncuZGiDq7qjELiRW4lF+A0ExaCCvEQiV272wfgrMbWQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TiQO5PwUMaqY3e+DWoF6yN5pKMeSBdAZnp2Y4wyoFLWKCNESk1IIpta3UxMuEAECQ
 Nvb92a5r9J9N272cWXe8bleupG0wlPijkTF+jhboHwMc8kx0P1pAMj52nkDr4GhoiP
 ydUlCtVHiA/n2qaC13CLV6AOoM5ltEyO2jI2Mrl5uh6XVJMbann8hhFa4ouhV75A7j
 l6At5uHp0pMqEoS+9Zs5bw2doeTN91REilQKx+71/V1nuN1pBTIjR5QvkAw4/cWrAZ
 w420J8rX8ukUJfGUUUxJM0J7YyhawISNbNDEoDUTx5qCPorLz05SUlgGcZyXmc7DcK
 nGZjk5FAv4hmg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 3/9] target/hppa: Only allow 8 BTLB entries for HP-UX 9.05
Date: Wed, 28 Oct 2026 19:26:45 +0100
Message-ID: <20261028182651.5950-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261028182651.5950-1-deller@kernel.org>
References: <20261028182651.5950-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

The physical PA100LC and PA7300LC CPUs implement 8 BTLB entries only.
HP-UX 9.05 seems to have problems if more are available, so reduce the
number to 8 entries to allow HP-UX 9.05 to boot.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index c0ba787974..da48a78569 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -248,7 +248,7 @@ typedef struct CPUArchState {
      * ??? The number of entries isn't specified by the architecture.
      * BTLBs are not supported in 64-bit machines.
      */
-#define PA10_BTLB_FIXED         16
+#define PA10_BTLB_FIXED         8
 #define PA10_BTLB_VARIABLE      0
 #define HPPA_TLB_ENTRIES        256
 
-- 
2.54.0


