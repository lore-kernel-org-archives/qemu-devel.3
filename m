Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5ADFF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 14:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wH0fm-0003nR-MU; Sun, 26 Apr 2026 10:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wH0fk-0003nD-4b
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 10:41:24 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wH0fe-000602-NS
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 10:41:23 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 648D642D72;
 Sun, 26 Apr 2026 14:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674EFC2BCAF;
 Sun, 26 Apr 2026 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777214469;
 bh=RGFCWm9KH7plp2uNjeNKr1qL9a+1babhLh6rW8L8g9w=;
 h=From:To:Cc:Subject:Date:From;
 b=ryDF3m/9tPQVhHPplSfwEGBma117rpsyTgGocGWkMlpPOBJOBe6UVe+lgzCUOs4Id
 2yc3v7ctPyB/p28mXH1L+CWawZhzBxd29//gZdyWS/HyMssr3ambOVjX4zb2C7/hIX
 rvQM3M6s2XDSvm2wwOVgK69Ozhfx/1d0G5V5oGtEGJ0tWIJrSq4/WRJpWcMfUz0ARH
 dHr/yLZ82lsyu7P7BMvkWdIY4tX+FkoLmjha2OCU4CJdxesFIkT/AQQKmNLBIHrbrv
 FHXDMXIF8IH+XZOZNW0fQUZnmCZpAWPTEYtAzl1YhQpHpI5t7vBL6jA6zaZve602TC
 xcUzr2a7N1xDA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Warner Losh <imp@bsdimp.com>
Subject: [PATCH] linux-user: Flush errors by using exit() instead of _exit()
 in error path
Date: Sun, 26 Apr 2026 16:41:00 +0200
Message-ID: <20260426144100.4037-1-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
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

Similiar to previous patch - ensure that we always flush I/O by using
exit() instead of _exit().

Reported by: Tobias Bergkvist
Reviewed-by: Warner Losh <imp@bsdimp.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2544
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 84e110dfe9..86d04cca3c 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -975,7 +975,7 @@ int main(int argc, char **argv, char **envp)
                       info, &bprm);
     if (ret != 0) {
         printf("Error while loading %s: %s\n", exec_path, strerror(-ret));
-        _exit(EXIT_FAILURE);
+        exit(EXIT_FAILURE);
     }
 
     for (wrk = target_environ; *wrk; wrk++) {
-- 
2.53.0


