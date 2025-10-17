Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38887CCD1A4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 21:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9rka-0003q5-TJ; Fri, 17 Oct 2025 17:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1v9rkX-0003pY-BD
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:12:34 -0400
Received: from pc232-55.mailgun.net ([143.55.232.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev>)
 id 1v9rkT-0005ko-9z
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 17:12:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mail.yodel.dev;
 q=dns/txt; s=pdk1; t=1760735538; x=1760742738; 
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender; 
 bh=5Sbhjsngm4RxsNio2W5tuQwDo7g8V5Wa8vXSVRSbXiA=;
 b=BzBUH30JxVAYTvAfIrQ8JVYNaBe1JMaKlrr2yhYwdG5I4BxNBikQDx5jARWLBUKNbMC1ZGmfHHhMuYni8tGlje9bKBK53VSfgPgTAw2a5YG57FMGseQikqbghedbfJABie0DmjG2c3XcRZeL9WPT4NBn02ozOd04GhD0wGJn3lelUSd5/tPdW811gYC/wiTsXerAtNZJ4xjdZpEri/LDsXgeFtcdQfkEhwCgkkwCPWDW+Qjy53q/E7J+Z3ojwqzdCHQrLp/Tjh7w2lwb43fziA9fDICn/+FXLNMXO1CrX8YDTcglAbARdwJJE6VCXuYWc27hPgpc/qVNKJbRe5pWgg==
X-Mailgun-Sid: WyJjZmM4NiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjMzZTkyMCJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 65586c34f6143b3160f0ced55fa49016b6000fbc8f25c7264d78fa599f872416 with SMTP id
 68f2b132698b6ee81bb95cba; Fri, 17 Oct 2025 21:12:18 GMT
X-Mailgun-Sending-Ip: 143.55.232.55
To: qemu-devel@nongnu.org
Cc: Yodel Eldar <yodel.eldar@yodel.dev>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] include/gdbstub/syscalls: Add GDB_{EIO,
 ENOSYS} errno values
Date: Fri, 17 Oct 2025 16:11:43 -0500
Message-ID: <20251017211149.163762-2-yodel.eldar@yodel.dev>
In-Reply-To: <20251017211149.163762-1-yodel.eldar@yodel.dev>
References: <20251017211149.163762-1-yodel.eldar@yodel.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=yodel.eldar@yodel.dev;
 h=from:subject; bh=x0CRH2C9uucROXz3oRf89PhjQREONSb8IRV2Yv27pjw=;
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI+reARYNuVOzdL6cwhjc+hFXxxD8XrtQNXCHRl1gWfb
 RLQeCjRUcrCIMbFICumyHL5rMRZh9zdXWkrf9yHmcPKBDKEgYtTACZy/Qojwwnz/m4rJSYDuS8X
 HRd8Edpyr0hyE2dp3rUn6oWNsxca8TH84ay8/LXj1qYDqvFtKtGyBx7V/j05+fFDB7UErx6zRYX
 NDAA=
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.55;
 envelope-from=bounce+c033f0.33e920-qemu-devel=nongnu.org@mail.yodel.dev;
 helo=pc232-55.mailgun.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Yodel Eldar <yodel.eldar@yodel.dev>
From:  Yodel Eldar via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch adds the EIO and ENOSYS errno values as supported by GDB's
File-I/O.

Until recently, they were not documented in the relevant section of the
GDB manual:

https://sourceware.org/gdb/current/onlinedocs/gdb.html/Errno-Values.html

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 include/gdbstub/syscalls.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/gdbstub/syscalls.h b/include/gdbstub/syscalls.h
index d63228e96b..6200416f77 100644
--- a/include/gdbstub/syscalls.h
+++ b/include/gdbstub/syscalls.h
@@ -22,6 +22,7 @@
 #define GDB_EPERM           1
 #define GDB_ENOENT          2
 #define GDB_EINTR           4
+#define GDB_EIO             5
 #define GDB_EBADF           9
 #define GDB_EACCES         13
 #define GDB_EFAULT         14
@@ -37,6 +38,7 @@
 #define GDB_ENOSPC         28
 #define GDB_ESPIPE         29
 #define GDB_EROFS          30
+#define GDB_ENOSYS         88
 #define GDB_ENAMETOOLONG   91
 #define GDB_EUNKNOWN       9999
 
-- 
2.51.1.dirty


