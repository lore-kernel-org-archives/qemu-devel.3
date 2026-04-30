Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49150FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wILgN-0003a9-Pd; Thu, 30 Apr 2026 03:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wILgM-0003Z6-DB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:19:34 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wILgJ-00012y-F2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 03:19:34 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2AD246111B;
 Thu, 30 Apr 2026 07:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936EDC2BCB3;
 Thu, 30 Apr 2026 07:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777533568;
 bh=YYJ3K4vj89HsrgIOawl8CF/AyDRKlWRjLCis0xBu3b4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DBEZkbrmCPcnLsSLuEtbr0trBbmqLmdUDf1W2eVUjs4n8nvs0KS5zfM/MThcEPjVW
 DbglYFbjql/a9w0MXUCqqsNezq/JwDbuVploLCzZiDXHchXo7nw2w3i341YLzesKz/
 gNwZw0ty7tn1i1KNhQhQx3oHL9PRzONAc4LTjL3AXMPgbishJWOvXIDfrrveMZcsrc
 I/qPpNBfEz/J6NzrWMm1eg6yGRuyp1Btw6HgZhm0/PmNfQqtY5bPv9pihpuJac8YFm
 8kigE9QMe3IUqUt0nlO1HihRzeDkVW2mnsGvrixLBJQSRgCCXSYGsDgGQ3+0DFUH33
 8b14HsGQHNQYA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>
Subject: [PULL 2/4] linux-user: Flush errors by using exit() instead of
 _exit() in error path
Date: Thu, 30 Apr 2026 09:19:20 +0200
Message-ID: <20260430071922.15341-3-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430071922.15341-1-deller@kernel.org>
References: <20260430071922.15341-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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

Reported by: Tobias Bergkvist <tobias@bergkv.ist>
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


