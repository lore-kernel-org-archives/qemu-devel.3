Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772E3C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA6s-00044w-Vz; Wed, 17 Apr 2024 14:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rxA6r-00044X-4n
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:34:17 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rxA6m-0004qw-Ol
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:34:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:c10a:0:640:882f:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 12E9460B0D;
 Wed, 17 Apr 2024 21:34:06 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b58f::1:2c])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZXJAD70If4Y0-82BNRhce; Wed, 17 Apr 2024 21:34:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1713378845;
 bh=znaRLD9fB/1boWuMdchXq2LTMHx2NjDn0dXBdwcCIbc=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=j9BKwLrCFCjKzmBZ7ftVqbV5TK5vgWELOLewkFWf8R0ptn/2Mbu15takTjiGGN61j
 GVlIUCgVxj22iyaThaKjmHirrFuLQhfC/0i+w21jttzaIeg//RaLzKt8sQkNVf/wqR
 NBwxhHB735+yjK+lPAao+eV+qdG5hYmYBty1Wrl0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, pbonzini@redhat.com,
 richard.henderson@linaro.org, stefanha@redhat.com, groug@kaod.org
Subject: [PATCH for-9.1] util/log: add cleanup function
Date: Wed, 17 Apr 2024 21:33:33 +0300
Message-Id: <20240417183333.39256-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We leak global_filename, and do not close global_file. Let's fix that.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

Interesting: seems, nobody is maintainer of util/log.c

 util/log.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/util/log.c b/util/log.c
index d36c98da0b..30de209210 100644
--- a/util/log.c
+++ b/util/log.c
@@ -85,6 +85,15 @@ static void qemu_log_thread_cleanup(Notifier *n, void *unused)
     }
 }
 
+static void __attribute__((__destructor__)) cleanup(void)
+{
+    g_free(global_filename);
+    if (global_file && global_file != stderr) {
+        fclose(global_file);
+        global_file = NULL;
+    }
+}
+
 /* Lock/unlock output. */
 
 static FILE *qemu_log_trylock_with_err(Error **errp)
-- 
2.34.1


