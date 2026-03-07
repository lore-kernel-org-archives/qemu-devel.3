Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD969F55102
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 19:35:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyxQe-0004tO-7h; Sat, 07 Mar 2026 14:35:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyxQc-0004tG-Hd
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:35:10 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vyxQW-0006CP-EY
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 14:35:05 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F1784403E;
 Sat,  7 Mar 2026 19:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB6CC19422;
 Sat,  7 Mar 2026 19:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772912094;
 bh=iLgVWhB/TsC5r5zIEl2ocO7gnuTYhna8kv+GAWad4Oo=;
 h=From:To:Cc:Subject:Date:From;
 b=exUFgmBwco8rEbz31McdA0r1bVBxUYFP1LTsWkbtN8Vvko7BnIJpMPW+YodLM+hGr
 HlKLtlnKckHSyn429/CCXATKddtY5gilywj664hgBu8OLveicoz6gy056zORL/wwsh
 OyRb5+QxwsmLePrefZeaRhd2rfEh9ETj0ix8iCfomF2o9LCZFA0pbiPn8o75pScWmA
 FeHxy4KbMw1SuWVmEhsMXDSgbylXrybbmUmmFxvpHjk5IxnGHiMiHCjF0GpnLkGCDH
 EXysRb0/GFRUILgEIYECYA0YVJmdxEn+SQ1n+dP09Fhk//u85rDR5yBQs/V6so751Q
 q3/nbjqd6d/vg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH] linux-user: Improve formatting for mremap()
Date: Sat,  7 Mar 2026 20:34:47 +0100
Message-ID: <20260307193447.7873-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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

From: Helge Deller <deller@gmx.de>

Improve slightly the strace output for mremap().
Print the old_address and new_address as hex values, old_size and
new_size as unsigned, and the flags as integer.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/strace.list | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.list b/linux-user/strace.list
index 51b5ead969..35f001fecd 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -641,7 +641,7 @@
 { TARGET_NR_mq_unlink, "mq_unlink" , NULL, print_mq_unlink, NULL },
 #endif
 #ifdef TARGET_NR_mremap
-{ TARGET_NR_mremap, "mremap" , NULL, NULL, NULL },
+{ TARGET_NR_mremap, "mremap" , "%s(%#x,%u,%u,%d,%#x)", NULL, NULL },
 #endif
 #ifdef TARGET_NR_msgctl
 { TARGET_NR_msgctl, "msgctl" , NULL, NULL, NULL },
-- 
2.53.0


