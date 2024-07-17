Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29B0C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2X7-0002AZ-88; Wed, 17 Jul 2024 07:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sU2Vg-0003rS-6S; Wed, 17 Jul 2024 07:07:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sU2Vc-0007Zl-SW; Wed, 17 Jul 2024 07:07:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BF8737B381;
 Wed, 17 Jul 2024 14:06:36 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 31DEC10B296;
 Wed, 17 Jul 2024 14:06:41 +0300 (MSK)
Received: (nullmailer pid 844428 invoked by uid 1000);
 Wed, 17 Jul 2024 11:06:40 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 15/16] backends/rng-random: Get rid of qemu_open_old()
Date: Wed, 17 Jul 2024 14:06:39 +0300
Message-Id: <20240717110640.844335-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717110640.844335-1-mjt@tls.msk.ru>
References: <20240717110640.844335-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Zhao Liu <zhao1.liu@intel.com>

For qemu_open_old(), osdep.h said:

> Don't introduce new usage of this function, prefer the following
> qemu_open/qemu_create that take an "Error **errp".

So replace qemu_open_old() with qemu_open(). And considering
rng_random_opened() will lose its obvious error handling case after
removing error_setg_file_open(), add comment to remind here.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Amit Shah <amit@kernel.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
(mjt: drop superfluous commit as suggested by philmd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 backends/rng-random.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/backends/rng-random.c b/backends/rng-random.c
index 80eb5be138..489c0917f0 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -75,10 +75,7 @@ static void rng_random_opened(RngBackend *b, Error **errp)
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                    "filename", "a valid filename");
     } else {
-        s->fd = qemu_open_old(s->filename, O_RDONLY | O_NONBLOCK);
-        if (s->fd == -1) {
-            error_setg_file_open(errp, errno, s->filename);
-        }
+        s->fd = qemu_open(s->filename, O_RDONLY | O_NONBLOCK, errp);
     }
 }
 
-- 
2.39.2


