Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E3FC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 16:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk2Dy-0008Sf-1i; Wed, 15 Jul 2026 12:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <89facabd1490ce088a1b2d41f7712e12d7b1e3ee@kylie.crudebyte.com>)
 id 1wk2Dw-0008S1-0b; Wed, 15 Jul 2026 12:12:40 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <89facabd1490ce088a1b2d41f7712e12d7b1e3ee@kylie.crudebyte.com>)
 id 1wk2Du-0008Ge-I6; Wed, 15 Jul 2026 12:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=hWOvMZMHAYS9htQ08PE3lQy3Polwd6k3l93OnLkja9M=; b=f4pPD
 cBE+Z+OjYwOAhn8hh7Qwv1UdW344eAwsWezIF3NdxTbSbOzKvjVVJ92bzLqMEDmutvXz6E8rhxqSf
 UGxYIzskNsG41wHyHr7fAJbW3tltCa9o9Dclx7EZAPD6wi38gPl2GLSuwlBA4e2+4q0Vu27Jfze+n
 4wJ/sbUH680TAGrgXXhc6aIoOG2mMR7DRVn5+Mp1a0w8++tbmN9d2fAJ8dhyb4Affz4Z8fJ5L8sCz
 ZHx/x1TBban6EF/dTR6Y5oQs7lU4VjAQTQl15o2fOkWTgoEMfDRk3RjdWzoWwzy2RAVInG7Yqsqdd
 k/XiJOJrSLwTzET9CGSQLKD9FICdR3z4EvAIZcvVjj7oGUfAOsFUR/X5agyjdB69luWslIEbEsb/q
 SO7y8jw7LOepbpUKX+pEBIVw5SqpoYQu1mEu6TsNT5rQXj1Xi3pK1GzEY1Z1riSoFCJy0s6uihHmS
 mksBmlG4p42T7Cuzk+a4HArbDbLAgYfMBI9Dtt36YmI8Nb1l139L3uKVREJzOK9+8iKlcTz5jUsxJ
 qJF5ExJTlIkVirudq1Xi9QL+n/zOXRTZtStqE0gl9kAo8wIma+KkumhvRVDDTrKz5T3hatwvKJsfA
 GtFArF6bF3olFJI931cICLL6Nsqku8B5aMiNKAaKlP1UiRLn6Gfh9SqfJ83mGw=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 15 Jul 2026 18:10:00 +0200
Subject: [PATCH] hw/9pfs: fix O_TRUNC bypass on read-only export
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Message-Id: <E1wk2Dq-0019kY-JK@kylie.crudebyte.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=89facabd1490ce088a1b2d41f7712e12d7b1e3ee@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4000
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 3119f01117..474ac6cc40 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2181,8 +2181,8 @@ static void coroutine_fn v9fs_open(void *opaque)
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


