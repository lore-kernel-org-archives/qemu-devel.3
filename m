Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646F7C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1gdh-0005qR-PS; Wed, 02 Sep 2026 04:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gdf-0005me-6H; Wed, 02 Sep 2026 04:48:11 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gdb-0007Al-Og; Wed, 02 Sep 2026 04:48:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 1AF0580738;
 Wed, 02 Sep 2026 11:48:04 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b72::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id xlfWR5raWmI0-5Q5cgadi; Wed, 02 Sep 2026 11:48:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788338883;
 bh=r4ooZCwQxoXOa23yi0FK2t075lY3nXixXM3TRGUTv5g=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=GODSGPjCDuPMzRWbMBqGNYQP7mHRUypacC05dAP6QJOYlpUdw91+RSwe1ECnogrpl
 rBLtkOFXfU4x3iPn8kOkkzBDsOLJdi/k7xagKDRtZsGI9Fv/BKcKa3hpkpRhaIm0d6
 Js1bcc6kSB/rMJihM2/vsZc99i6rc4cw2505yZKI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@openvz.org, vsementsov@yandex-team.ru,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 5/8] nbd/server: accept NBD_CMD_CACHE above the maximum payload
 size
Date: Wed,  2 Sep 2026 11:47:51 +0300
Message-ID: <20260902084754.140103-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902084754.140103-1-vsementsov@yandex-team.ru>
References: <20260902084754.140103-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "Denis V. Lunev" <den@openvz.org>

NBD_CMD_CACHE carries no payload in either direction. The request is
a header only, nbd_do_cmd_cache() passes a NULL qiov to
blk_co_preadv(), and the reply is a bare status. Still the server
rejects any effect length above NBD_MAX_BUFFER_SIZE with EINVAL,
which forces a client to split a large prefetch into 32 MiB pieces.

The specification does not ask for this. The constraint was renamed
from "maximum block size" to "maximum payload size" precisely to
separate payload length from effect length, and it says:

  For commands that do not require a payload in either direction
  (such as NBD_CMD_TRIM or NBD_CMD_WRITE_ZEROES), the client MAY
  request an effect length larger than the maximum payload size;
  the server SHOULD NOT disconnect, but MAY reply with an
  NBD_EOVERFLOW or NBD_EINVAL error if the oversize request would
  require too many server resources when compared to the same
  command with an effect length limited to the maximum payload
  size (such as an implementation of NBD_CMD_WRITE_ZEROES that
  utilizes a scratch buffer).

We already follow that for NBD_CMD_TRIM and NBD_CMD_WRITE_ZEROES,
which carry no length check at all, and our client assumes a server
supporting extended headers takes unlimited zero and trim lengths.
Handle NBD_CMD_CACHE in the same way.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20260827161002.310688-3-den@openvz.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 nbd/server.c                          | 4 +---
 tests/qemu-iotests/tests/nbd-commands | 5 ++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 78ec9844097..e6c47f8c2e3 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2718,7 +2718,6 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
         break;
 
     case NBD_CMD_CACHE:
-        check_length = true;
         break;
 
     case NBD_CMD_WRITE_ZEROES:
@@ -2752,7 +2751,7 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
         req->complete = true;
     }
     if (check_length && request->len > NBD_MAX_BUFFER_SIZE) {
-        /* READ, WRITE, CACHE */
+        /* READ, WRITE */
         error_setg(errp, "len (%" PRIu64 ") is larger than max len (%u)",
                    request->len, NBD_MAX_BUFFER_SIZE);
         return -EINVAL;
@@ -2908,7 +2907,6 @@ static coroutine_fn int nbd_do_cmd_cache(NBDClient *client, NBDRequest *request,
     NBDExport *exp = client->exp;
 
     assert(request->type == NBD_CMD_CACHE);
-    assert(request->len <= NBD_MAX_BUFFER_SIZE);
 
     ret = blk_co_preadv(exp->common.blk, request->from, request->len,
                         NULL, BDRV_REQ_COPY_ON_READ | BDRV_REQ_PREFETCH);
diff --git a/tests/qemu-iotests/tests/nbd-commands b/tests/qemu-iotests/tests/nbd-commands
index 4c1cd33db74..cbfc47782ff 100755
--- a/tests/qemu-iotests/tests/nbd-commands
+++ b/tests/qemu-iotests/tests/nbd-commands
@@ -114,10 +114,9 @@ class TestNbdCommands(iotests.QMPTestCase):
         self.assertEqual(self.block_status()['qemu:allocation-depth'],
                          [(size, DEPTH_BACKING)])
 
-        self.h.cache(maximum, 0)
+        self.h.cache(size, 0)
 
-        self.assertEqual(self.top_extents(),
-                         [(0, maximum, 0), (maximum, size - maximum, 1)])
+        self.assertEqual(self.top_extents(), [(0, size, 0)])
         qemu_io('-c', f'read -P {pattern} 0 {size}', top)
 
     def test_cache_past_end_of_export(self):
-- 
2.43.0


