Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF757D6EC13
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 14:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH29Q-0003Km-NL; Fri, 29 Nov 2024 09:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tH29N-0003JK-1d
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:39:17 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tH29L-0005z6-Nx
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:39:16 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 26780A43F21;
 Fri, 29 Nov 2024 14:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25FFC4CED2;
 Fri, 29 Nov 2024 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732891148;
 bh=Z3ILH7yeOybgi1/CJ1rwkFp19U43yvxFnde7k2lHHz8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YZHbfxSPXvPUMX4Z22/xErwwFsIIZPWdny72PArWUQPCvyRwxBVm6sgFS34GB46i3
 fgoQ310jTspZi2huDZoJ4/Y76KJ/DNcYuYRkhbXH573sCR2XgG8/2qZDkDbfFWTPEP
 XQmwZWLIbtZsNQ01nXs8cr/gE7npSaetBRi51NmJpGXt5/jN2MeUpeD4Wl3eFQ0vTY
 bEbaxT46Buir6vV8Z4KXJ/G+ExJUVc/IaiGsie+mK40ws1DKU2PROJ5SkHzMeGZEHN
 HciMztBdZlvbiT2kxt9dy9Puhm+vtqxLCmnXGrEhRDnVu8LMZiq3rRYqDBqVKUKpCc
 yBDFf4LGbaqNA==
From: deller@kernel.org
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 3/6] linux-user: netlink: Add IP_PKTINFO cmsg parsing
Date: Fri, 29 Nov 2024 15:38:58 +0100
Message-ID: <20241129143901.11291-4-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129143901.11291-1-deller@kernel.org>
References: <20241129143901.11291-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Fixes those warnings:
 Unsupported host ancillary data: 0/8

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 494323efba..bbe2560927 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1996,6 +1996,18 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
                     (void *) &errh->offender, sizeof(errh->offender));
                 break;
             }
+            case IP_PKTINFO:
+            {
+                struct in_pktinfo *pkti = data;
+                struct in_pktinfo *target_pkti = target_data;
+
+                __put_user(pkti->ipi_ifindex, &target_pkti->ipi_ifindex);
+                host_to_target_sockaddr((unsigned long) &target_pkti->ipi_spec_dst,
+                    (void *) &pkti->ipi_spec_dst, sizeof(pkti->ipi_spec_dst));
+                host_to_target_sockaddr((unsigned long) &target_pkti->ipi_addr,
+                    (void *) &pkti->ipi_addr, sizeof(pkti->ipi_addr));
+                break;
+            }
             default:
                 goto unimplemented;
             }
-- 
2.47.0


