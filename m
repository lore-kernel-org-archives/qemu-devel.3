Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC024C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 16:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umEg2-000366-6h; Wed, 13 Aug 2025 12:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfn-0002pD-0C; Wed, 13 Aug 2025 12:49:59 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1umEfg-0007sH-1J; Wed, 13 Aug 2025 12:49:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 7F4BE812B1;
 Wed, 13 Aug 2025 19:49:18 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:167::1:21])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wmOQI00FoSw0-DXc6VwvB; Wed, 13 Aug 2025 19:49:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1755103758;
 bh=pizgr/SLVxn2pIPfmpvPOohwXp224DmrZh/s1CjFm9w=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=qVgGTHAr6UTecedE5eh70TuHhG+Hm7jfssuiQybvpx2iqOHufEh7REEcyOZo5A6W5
 Mz7qa4vag5lNSEmxYoQgwDGq2nrO+84HczKa7xtUEkaaBU6Q4rcKqjwQ+IlqoVw+iK
 3syFcJYw534AdHqMwmh2bDAz0DROCt/tHIEAieww=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, vsementsov@yandex-team.ru
Subject: [PATCH 20/33] hw/virtio/virtio-bus: refactor
 virtio_bus_set_host_notifier()
Date: Wed, 13 Aug 2025 19:48:41 +0300
Message-ID: <20250813164856.950363-21-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813164856.950363-1-vsementsov@yandex-team.ru>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The logic kept as is. Reaftor to simplify further changes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/virtio-bus.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 11adfbf3ab..c7e3941b1e 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -293,20 +293,18 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign)
                          __func__, strerror(-r), r);
             return r;
         }
-        r = k->ioeventfd_assign(proxy, notifier, n, true);
-        if (r < 0) {
-            error_report("%s: unable to assign ioeventfd: %d", __func__, r);
-            virtio_bus_cleanup_host_notifier(bus, n);
-        }
-    } else {
-        k->ioeventfd_assign(proxy, notifier, n, false);
     }
 
-    if (r == 0) {
-        virtio_queue_set_host_notifier_enabled(vq, assign);
+    r = k->ioeventfd_assign(proxy, notifier, n, assign);
+    if (r < 0 && assign) {
+        error_report("%s: unable to assign ioeventfd: %d", __func__, r);
+        virtio_bus_cleanup_host_notifier(bus, n);
+        return r;
     }
 
-    return r;
+    virtio_queue_set_host_notifier_enabled(vq, assign);
+
+    return 0;
 }
 
 void virtio_bus_cleanup_host_notifier(VirtioBusState *bus, int n)
-- 
2.48.1


