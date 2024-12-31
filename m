Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EADAE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 15:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSe5s-0004Rw-6N; Tue, 31 Dec 2024 10:23:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tSe5p-0004RM-Ov; Tue, 31 Dec 2024 10:23:37 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tSe5o-0004bI-6M; Tue, 31 Dec 2024 10:23:37 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id 1AC8ACE0CA;
 Tue, 31 Dec 2024 18:22:40 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id AA67C4640C; Tue, 31 Dec 2024 18:23:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: [PULL 1/1] Revert "vvfat: fix ubsan issue in create_long_filename"
Date: Tue, 31 Dec 2024 18:23:24 +0300
Message-Id: <20241231152324.3307386-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241231152324.3307386-1-mjt@tls.msk.ru>
References: <20241231152324.3307386-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This reverts commit 0cb3ff7c22671aa1e1e227318799ccf6762c3bea.

The original code was right in that long name in LFN directory
entry uses other parts of the entry for the name too, not just
the original "name" field.  So it is wrong to limit the offset
to be within the name field.  Some other mechanism is needed
to fix the ubsan report and whole messy usage of bytes past the
given field.

Reported-by: Volker Rümelin <vr_qemu@t-online.de>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 block/vvfat.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index f2eafaa923..8ffe8b3b9b 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -426,10 +426,6 @@ static direntry_t *create_long_filename(BDRVVVFATState *s, const char *filename)
         else if(offset<22) offset=14+offset-10;
         else offset=28+offset-22;
         entry=array_get(&(s->directory),s->directory.next-1-(i/26));
-        /* ensure we don't write anything past entry->name */
-        if (offset >= sizeof(entry->name)) {
-            continue;
-        }
         if (i >= 2 * length + 2) {
             entry->name[offset] = 0xff;
         } else if (i % 2 == 0) {
-- 
2.39.5


