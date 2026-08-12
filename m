Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74C7C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8dD-0006AX-By; Wed, 12 Aug 2026 09:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8dB-0005zg-Ne; Wed, 12 Aug 2026 09:04:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8d9-0004Qi-Uw; Wed, 12 Aug 2026 09:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=ET6C9e1evicLzMVE9bmdi1Y6qJCSZ5TmRj/WTts8YzE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mOUKAbw54uNh6dOeWbS8bElIoJlOrvnLoa14fOKxXJrCp19MoOut3crz2ARIPNA9o
 swV4kjkJfLPMHv53EwH7h29Y6aJk318vEcT7TsbV5FRD6w3XB8C00jwql04Yyq3xN4
 xy25xW1atBCR5j3O8QwqgEF1YNuOY73YvZDe6LVFdi7gyYKjEKRSW7wnnz59DkwBjn
 Z/8V8BRDuFRYb5/SHA1dRtuGtRY1lZagFKKnYDrBALLDKynAgtGWs8Q+UC3KJVUSg3
 KENlU4gxlJKJUBE7ei+RDxWbPjjoK2A3k/qbal21F2IGdwrLFzetSzXuI6fYcoNeJF
 oy0c6bEhqmEeA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5027E1CA48F;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 848EA409B72;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EA2CA2F8B4; Wed, 12 Aug 2026 16:02:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 016/102] hw/9pfs: fix O_TRUNC bypass on read-only
 export
Date: Wed, 12 Aug 2026 16:00:51 +0300
Message-ID: <20260812130233.621965-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Guest 9p client opening a file with O_TRUNC on a read-only 9p file
system using 9p2000.u protocol version, allowed to bypass 9p
server's read-only check, eventually causing file(s) being
truncated to empty file(s) on host's read-only export.

Root cause is that 9p server's read-only check is using Linux open
flags like O_WRONLY, O_RDWR, O_TRUNC, but checking them against
the 9p Topen request's "mode" parameter, which has a different
encoding (Otrunc = 0x10 vs. O_TRUNC = 0x200).

Fix this by checking against the "flags" variable instead of the
protocol's "mode" option. Because the "flags" variable is already
converted to Linux encoding by omode_to_uflags() for 9p2000.u and
by get_dotl_openflags() for 9p2000.L protocol version.

Only 9p2000.u was affected by this bypass, 9p2000.L uses the Linux
format on protocol level already.

Fixes: 2c74c2cb4b ("hw/9pfs: Read-only support for 9p export")
Fixes: CVE-2026-63318
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4000
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/E1wk2Dq-0019kY-JK@kylie.crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit a0414545a212e27058fab7b057b018e75b8c4b13)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index e337b45517f..bb263afe430 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2144,8 +2144,8 @@ static void coroutine_fn v9fs_open(void *opaque)
             flags = omode_to_uflags(mode);
         }
         if (is_ro_export(&s->ctx)) {
-            if (mode & O_WRONLY || mode & O_RDWR ||
-                mode & O_APPEND || mode & O_TRUNC) {
+            if (flags & O_WRONLY || flags & O_RDWR ||
+                flags & O_APPEND || flags & O_TRUNC) {
                 err = -EROFS;
                 goto out;
             }
-- 
2.47.3


