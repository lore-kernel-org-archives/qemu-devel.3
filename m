Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F09E7719B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVeAE-0004CU-Tz; Wed, 08 Jan 2025 17:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tVeAE-0004Bk-2U
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:04:34 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tVeAC-0006Of-Ew
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:04:33 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id E6A7FA41C6E;
 Wed,  8 Jan 2025 22:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6556C4CED3;
 Wed,  8 Jan 2025 22:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736373871;
 bh=Z3ILH7yeOybgi1/CJ1rwkFp19U43yvxFnde7k2lHHz8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZKWM+MLuEU/a8oEkOER/TYfv9+Tqd3J3XKY+jk/L5+Yc4WmybjVtTE1nhkn57XOOW
 VqXMlyf6pInC9rUU2BOXKSX3kCa74YcgVs07V5rFeslLf0t0PQX9yxDDfYAzvOj999
 Pzuyb6DESRnqs90A2YWsS8Q6UI/wnZxqOHq3PaC53VVlLfJahUjZhKZj1g2YiynzSF
 Ejc1D367RowHpw4Aavo1BUJfR8ccoGevYd8FoqABLDu+lIR0NhcTXd/4o0U10BovCH
 EnMJL4zAyKd8i2FT7ub8pkyph+Mh4nGNgfP1lpSdPNaM260R99igbwMJSXtZp7g79n
 M2mNsS9aH08jA==
From: deller@kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PULL v2 3/6] linux-user: netlink: Add IP_PKTINFO cmsg parsing
Date: Wed,  8 Jan 2025 23:04:19 +0100
Message-ID: <20250108220422.169967-4-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250108220422.169967-1-deller@kernel.org>
References: <20250108220422.169967-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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


