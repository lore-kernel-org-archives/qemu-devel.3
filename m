Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94992C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Tmt-0001KD-OI; Tue, 15 Sep 2026 10:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zorin@swemel.ru>) id 1x6So7-0000Aw-7k
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:02:46 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zorin@swemel.ru>) id 1x6So2-00048R-Tj
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:02:42 -0400
Message-ID: <a15f7b76-0ffc-418b-85dc-219e351d9794@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1789477351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sC5Vxlg6n+Lp8ZrqtKzTe6WEDKCQ3vM7wXZvTLaGDV0=;
 b=UmwLqBkI1ODD+yJz6qqx6t4oDKJR6xv/DXu29jfRvez2pye/PDKi86HzHlk6z45YaUt5xM
 666rKBfsGZ18rhvlCBFrO+kAr198JHzIArysrMb6LYK7G4FQ4IcmJGO/XMBBvBi9NY4bzL
 WcDACuy4brvWkNX6+Y2togtZquh+FLU=
Date: Tue, 15 Sep 2026 16:02:31 +0300
MIME-Version: 1.0
Content-Language: en-US, ru-RU
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, mst@redhat.com
From: =?UTF-8?B?0J3QuNC60L7Qu9Cw0Lkg0JfQvtGA0LjQvQ==?= <zorin@swemel.ru>
Subject: [PATCH] util/vhost-user-server: fix potential NULL dereference in
 vu_message_read
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=zorin@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 15 Sep 2026 10:05:29 -0400
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

The `vu_message_read()` function initializes `local_err` to `NULL`.
If `server->ioc` is `NULL`, the execution jumps to the `if (!ioc)`
branch and invokes `error_report_err(local_err)`.

Passing a guaranteed `NULL` pointer to `error_report_err()` leads
to a crash because `error_get_pretty(err)` will attempt to dereference
`err->msg`, triggering a Segmentation Fault (`SIGSEGV`).

Since `server->ioc` shouldn't be `NULL` during an active coroutine
execution, this error block is effectively dead code, but it represents
a dangerous pattern left over from copy-pasting or incomplete refactoring.

Fix this by removing the incorrect `error_report_err(local_err)` call
inside the `if (!ioc)` block. The `local_err` variable itself is preserved
as it is used later in the function for actual I/O error handling.

Signed-off-by: Nikolay N Zorin <zorin@swemel.ru>
---
  util/vhost-user-server.c | 1 -
  1 file changed, 1 deletion(-)

diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index f30f6b3e..a4b2c1d0 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -15,7 +15,6 @@ static bool coroutine_fn vu_message_read(VuDev 
*vu_dev, int conn_fd, VhostUserMs

      vmsg->fd_num = 0;
      if (!ioc) {
-        error_report_err(local_err);
          goto fail;
      }

-- 
2.43.0


