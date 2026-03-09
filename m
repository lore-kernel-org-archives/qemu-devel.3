Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AA8F3C265
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaxc-000438-UW; Mon, 09 Mar 2026 09:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxS-0003yJ-7y
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:47 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxO-000679-4B
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:41 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9812E600AE
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB210C2BC86
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773064036;
 bh=Q/dSbHczdz4sFIvaB36AMEBCEZDprQsZ7Vlhqrv2Nk8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=Fy+TST8YDpRlh0MOTDGShsM31MoAV/Yu5o5zc5iw7W1xvTwh0cS68/sGdsLyDcXjT
 txNxwlTROBGCvWHv4vTGGa14or3k0AoEDhfr66dT0RnKlqNLkOrOfcM0ia+ZUfp7zf
 pcX7fCsI0FwPSCylMYQphlivF84X7qG32rQY8GMpycfVrMRWye7/qi93HGnOfSgkgB
 gKOAoK9GY/1uV3iU5SJONk5Qx78j62cJi3CluksR6qPcX9+Z/qsuUoTVObHMgRkyr1
 hYCISttrzH4NWq60lzy2dWv4bvAZFBNJ9nC/SVcRTSG6l+2HyOXNbQIX4F8mH3DkCQ
 sa9iv1kJsHvJw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/10] linux-user: properly check flags in openat2
Date: Mon,  9 Mar 2026 14:47:03 +0100
Message-ID: <20260309134711.5312-3-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309134711.5312-1-deller@kernel.org>
References: <20260309134711.5312-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Andreas Schwab <schwab@suse.de>

target_to_host_bitmask truncates the bitmask to int.  Check that the upper
half of the flags do not have any bits set.

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 99e1ed97d9..064bc604c9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8831,6 +8831,10 @@ static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
         }
         return ret;
     }
+    if (tswap64(how.flags) >> 32) {
+        return -TARGET_EINVAL;
+    }
+
     pathname = lock_user_string(guest_pathname);
     if (!pathname) {
         return -TARGET_EFAULT;
-- 
2.53.0


