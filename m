Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AAAE7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVeAE-0004C9-Dl; Wed, 08 Jan 2025 17:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tVeAD-0004BZ-0O
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:04:33 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tVeAB-0006OH-5B
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:04:32 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5DC60A41C22;
 Wed,  8 Jan 2025 22:02:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42429C4CED3;
 Wed,  8 Jan 2025 22:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736373867;
 bh=AftUXuUWx9ZD4I5XBHONp6je4n2JUSbFwJicQRR9IxY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tcUjr9HpugWPifjH2RIWX6ml6H8DX2pPEAaxPg3fnT/gucEJgv+tM0QeCl9B/UfcA
 REBhlQ2pMqcPrXB5+A/o6oVYKc7ScTf5mLrfkTgpphClHO62CwETjH+ijSRAhkj/mP
 PkhGaPceY2qNfHGKzdXAVAqHReCXTsJI91Ir8kTr5Kr4EYnhuYUp55/usImqswHWZ/
 EsCoFI/L0cYgEuHe6boQCwvbXssuKoNIMlbKMJSpev8fT1aM+lJybGVh1iK/k5H69O
 06bT8uXuL2WhU1cfHCcR8yF0tE4CU0SETxSCrp//3KeZExhrCWc0IKqqBHV/5fzh4K
 yjsxsJL68rPtg==
From: deller@kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PULL v2 1/6] linux-user: netlink: Add missing IFA_PROTO to
 host_to_target_data_addr_rtattr()
Date: Wed,  8 Jan 2025 23:04:17 +0100
Message-ID: <20250108220422.169967-2-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108220422.169967-1-deller@kernel.org>
References: <20250108220422.169967-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Fixes this warning:
 Unknown host IFA type: 11

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/fd-trans.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
index c04a97c73a..a86ed2f4b4 100644
--- a/linux-user/fd-trans.c
+++ b/linux-user/fd-trans.c
@@ -1140,6 +1140,7 @@ static abi_long host_to_target_data_addr_rtattr(struct rtattr *rtattr)
     /* binary: depends on family type */
     case IFA_ADDRESS:
     case IFA_LOCAL:
+    case IFA_PROTO:
         break;
     /* string */
     case IFA_LABEL:
-- 
2.47.0


