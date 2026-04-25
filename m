Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C196FF885C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 14:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGeJj-0001qa-Hy; Sat, 25 Apr 2026 10:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGeJf-0001q2-EE
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 10:49:07 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wGeJd-0008Eu-UV
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 10:49:07 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 155A044445;
 Sat, 25 Apr 2026 14:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35012C2BCB0;
 Sat, 25 Apr 2026 14:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777128543;
 bh=Y2jfW2n5SXWlVYI4a1aoFFMe9VI36vJwyPaPM10gar0=;
 h=From:To:Cc:Subject:Date:From;
 b=nen1BdWBwcMEXquLTXqIbUm4IbFtrLHj9vrw1SrzQK+jwi9PBdph9FGqNVLauE1li
 /DrJVN7WuJqFy3tbGZXsvEa1yUaEpDJJdiYtINiTjsVL/TkWBFO+fPaE4eXtFITN0w
 YZaTgpZz8lQmRaxawe4ygwytu7HoFDWUZQWzhxz7ZUIsckqe0vcEHZT7Wm0jjDM5Y0
 6Rd+E5LG3jvZIP5K2xbOWtyLUky9ma1N0dNDccHH6FP6TFmTpCe+oEe+aUeDqAn+t2
 ZyOi+wol++rehqKt5eeNnZh5T7mRwIJ9JXYKqNOaXNWoqTvj0Isg+w85U0Z2K7y4dg
 BatmRgx5tnzqQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH] linux-user: Flush errors by using exit() instead of _exit()
 in error path
Date: Sat, 25 Apr 2026 16:48:52 +0200
Message-ID: <20260425144852.46590-1-deller@kernel.org>
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

Qemu user mode does not properly flushes error messages related to bad
arguments when exiting (at least when the output is piped to a file
instead of running on a terminal).
Ensure that we always flush by using exit() instead of _exit().

Reported by: Tobias Bergkvist
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2544
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index c49d1e91d2..84e110dfe9 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -767,7 +767,7 @@ int main(int argc, char **argv, char **envp)
         execfd = open(exec_path, O_RDONLY);
         if (execfd < 0) {
             printf("Error while loading %s: %s\n", exec_path, strerror(errno));
-            _exit(EXIT_FAILURE);
+            exit(EXIT_FAILURE);
         }
     }
 
-- 
2.53.0


