Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40A0CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 15:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v92y2-0007qa-IR; Wed, 15 Oct 2025 10:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xq-0007ng-IZ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:56 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v92xg-0000fH-VA
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 10:58:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 4FA5FC067C;
 Wed, 15 Oct 2025 17:58:28 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id AwRFIp2FFSw0-rX3IEuCK; Wed, 15 Oct 2025 17:58:27 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760540307;
 bh=Qvhx2PfrSL/sLNOgPGSepT8yXjtIZZets0wvlD0gIvE=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=0DHLyI0N1bXIgGXn88iAjOdrbyy8jf0ck0OJzGBs5im2og9Hb0OPurEhH/BVJ7WHs
 suagy6eQAim/oQczd/VQQshMERts1Umltwdzn4m3gHOpdeTibcf0Ts6p3nHYjPnm8j
 oVOR+PFOdGbHWYv6iusUff1EG2Q/Wg24TCDsQlIo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: [PATCH v3 20/23] hw/virtio/virtio-bus: refactor
 virtio_bus_set_host_notifier()
Date: Wed, 15 Oct 2025 17:58:04 +0300
Message-ID: <20251015145808.1112843-21-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

The logic kept as is. Refactor to simplify further changes.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
---
 hw/virtio/virtio-bus.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index cef944e015..9b545acda3 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -298,20 +298,18 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign)
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


