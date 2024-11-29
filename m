Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323E5D6EC15
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 14:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH29Q-0003Kk-3H; Fri, 29 Nov 2024 09:39:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tH29M-0003Id-6y
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:39:16 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tH29K-0005yw-Ri
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 09:39:15 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D50B4A43F1D;
 Fri, 29 Nov 2024 14:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF6BC4CECF;
 Fri, 29 Nov 2024 14:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732891147;
 bh=dFdJHS2fcUNzhLS8OVysMDJhrwIxQcz7Tz5F4UM1A7c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pIoVefoRLtOjsGktSRMnw0TUTMYFRspdF8uKkw9scauf+1aFAliOs1iDNchCdq+sE
 s9eVT9EznlVG9YsUZ7x2IgO1JmGsMFYuz9O0qOwPm/tKgACsKDzmBKO4dzGrIHYAz1
 0yVq7x1f62li9qoE35Pw4JcWRWZcA0HtnZIHBx1gIbGoaKvwrP+ILkgt9NvCEHYxFP
 ApxcgEnBOM4enB/5BF/WE8mnfpRjQSfd1jzx7HEV2tiBVmLtd+ey8zt4Nsaj/hD1YB
 Up6a7KZDA5zRGBEVPh1O8WIXpzVwB+8rS8kiel2mtSd+ZSQoA5bQmSL1pnJbksMFXT
 /ua4JCX44kuug==
From: deller@kernel.org
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 2/6] linux-user: Use unique error messages for cmsg parsing
Date: Fri, 29 Nov 2024 15:38:57 +0100
Message-ID: <20241129143901.11291-3-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241129143901.11291-1-deller@kernel.org>
References: <20241129143901.11291-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=deller@kernel.org; helo=nyc.source.kernel.org
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

Avoid using the same error message for two different code paths
as it complicates determining the one which actually triggered.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1ce4c79784..494323efba 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1825,7 +1825,7 @@ static inline abi_long target_to_host_cmsg(struct msghdr *msgh,
                 *dst = tswap32(*dst);
             }
         } else {
-            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
+            qemu_log_mask(LOG_UNIMP, "Unsupported target ancillary data: %d/%d\n",
                           cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(data, target_data, len);
         }
@@ -2047,7 +2047,7 @@ static inline abi_long host_to_target_cmsg(struct target_msghdr *target_msgh,
 
         default:
         unimplemented:
-            qemu_log_mask(LOG_UNIMP, "Unsupported ancillary data: %d/%d\n",
+            qemu_log_mask(LOG_UNIMP, "Unsupported host ancillary data: %d/%d\n",
                           cmsg->cmsg_level, cmsg->cmsg_type);
             memcpy(target_data, data, MIN(len, tgt_len));
             if (tgt_len > len) {
-- 
2.47.0


