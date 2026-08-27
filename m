Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5079AC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcgD-0004ZZ-VR; Thu, 27 Aug 2026 12:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzcgA-0004YG-Ms
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:10:14 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzcg8-0007uc-OY
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:10:14 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so16124715e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787847011; x=1788451811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f5QFhAFnxCdd4h1trIbLuH4MIh6b8yqEQgKz02p+ZQ4=;
 b=JPbgWoogH8QRf8d7KApWKb4aSbZFRRHBFof58OhHBlYNyXosNjWI7GkluiglEU4unx
 gNnSu5x398+DF5mH4AVCCkN+cTq09xMrIsFAt0qjb595jeBragCc5FXDK5ojcu/v6jgO
 GvAjwQ5r1tYcmCsfwQmGr7Wgf8cMh4nvd/7wAMxhQxiIjE61eCqeMhvsuTGCr6itwD/6
 bzmOGCvQRjdi+2xyqSXDjh9u43SASik8SM6IrDadfA1MA5N26YSyACgXWA8dKfh276Pb
 e/4eM2fuS04gaPBHgUt1HMRUqvM9w4VYc0byZczKNCsyq/W7yallVLayQbVQC/O3/G0G
 vYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787847011; x=1788451811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f5QFhAFnxCdd4h1trIbLuH4MIh6b8yqEQgKz02p+ZQ4=;
 b=BMHp9ww0BTgyAP2/v5ob6hAr8VNlUKLS1kHdTnq6soiPUOH4RwMrhJi2xi5FU6QNRn
 QRD0fyRlxPoIRGHx5ohjpE/3T5yNuB9gidQkNgXzjM4YxuEGs5+WOaD1pm29V45Nx9hQ
 s49nmIZoq9y1+Gs4s+tjXwPab5XxCfwWM/OdEJjh+k8jkSPLgUuj5rnKOBQ7dYje9exN
 NIBNZj1FmEkqMRyo6RF5m+twIF1SekQwaUtqinFyww61ANIXAaOI1EBSbbYWttZIP7AA
 /QSlYshREA7IgTneLkuDLkSKQgIkiHc7XQc0KCnIaSwmBlU7k+wlHJzALcUYEyioRiYr
 pILw==
X-Gm-Message-State: AFuF++nAXyKrB6wOLsUPCSsClmeQqQnWzU6KlKiMYV7Qmxpm6grzV+Uh
 /nIo0Q/wQdOFb5TETwsCZC1jOlFj8pJq1l8WDT8JVshhgf7QeAn24HejNqjEOr8v/qy7tTdy49t
 HwoJW
X-Gm-Gg: AR+sD13J6dUJEWiIDT7lF20EHUBpwu5FISRxvymg4+h5nPSymCGDR/Ssm0tsvcl2q2c
 6NHmvluBQ1lZv1II7g4qqJbzoS1gKzFwJvLwFHgewxNzCUO88mCZfRe5vVLh15X0dCvKsYpzjyi
 P2rKmFqRByqk9fNrnzLYqS8HUaehNLtNgsBtqyfdO6qxhhtYBBqMWdAzyP7vgqVSFhDt1cCzeRR
 P0dW+RcNzs/Md+5NjszRGTAzl1ft2kaLYdWQFSEAhn2k5f4pbMjBJKbzp9f5rVfeiiZtWPLwFX/
 GAJm/AUdVa5YhBZrC2woPRxccW/da+nWmf9WGwnzyN16ncpOmSfP3haApoBIH6en5oBzhRO8G/R
 AEPcEtTa9lQVB1GYHaqM2oCHsWKTGpddkQlJ8MIj1qyOP29aQu2JfdKu9mxfxTnqeUeK9/JPQk+
 vwkietBJxd+fZoBHELmzZNRjsi0D+w4rv8s79MQ4rU2uJaOY0HRQ==
X-Received: by 2002:a05:600c:37c9:b0:49b:2796:be30 with SMTP id
 5b1f17b1804b1-49b2796c07cmr118083215e9.11.1787847011061; 
 Thu, 27 Aug 2026 09:10:11 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:e57e:de8:330d:26d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5771a3sm71359465e9.4.2026.08.27.09.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 09:10:10 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 2/5] nbd/server: accept NBD_CMD_CACHE above the maximum
 payload size
Date: Thu, 27 Aug 2026 18:09:59 +0200
Message-ID: <20260827161002.310688-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827161002.310688-1-den@openvz.org>
References: <20260827161002.310688-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=den@openvz.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

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
---
 nbd/server.c                          | 4 +---
 tests/qemu-iotests/tests/nbd-commands | 5 ++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 78ec984409..e6c47f8c2e 100644
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
index 4c1cd33db7..cbfc47782f 100755
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
2.53.0


