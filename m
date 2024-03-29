Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0717ACD1288
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 18:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqH7e-0002ne-7i; Fri, 29 Mar 2024 14:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rqH7b-0002li-Pv; Fri, 29 Mar 2024 14:38:35 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rqH7Y-0007Wr-NZ; Fri, 29 Mar 2024 14:38:35 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5428:0:640:7351:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 7AAD760A1E;
 Fri, 29 Mar 2024 21:38:28 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:6509::1:4])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 2cTaY94Id8c0-ygA45I9e; Fri, 29 Mar 2024 21:38:27 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1711737507;
 bh=7EzT71LTq/DekEyu4R1Kcwva3Cde8YCH520nF993tAg=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=x8NHxv+JdEhdeUdr/ePcFUygQMmtqZoZOy4T+yn3tx0JInF6J1a+eqo7aSaOJ2YOt
 lcOBugwPu+3SZfk0SD3QNiskNqrcUkOKal04cO1aaBNR//UpRmeikDK1F+wlDnEd4E
 ygnsHbZ5UvFgjsDyxaEV+Bq8IAn/JKzZQ6HdVWbY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org,
	raphael@enfabrica.net,
	mst@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, armbru@redhat.com,
 dave@treblig.org, eblake@redhat.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v3 2/5] qdev-monitor: fix error message in find_device_state()
Date: Fri, 29 Mar 2024 21:37:55 +0300
Message-Id: <20240329183758.3360733-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329183758.3360733-1-vsementsov@yandex-team.ru>
References: <20240329183758.3360733-1-vsementsov@yandex-team.ru>
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

This "hotpluggable" here is misleading. Actually we check is object a
device or not. Let's drop the word.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 system/qdev-monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index c1243891c3..840177d19f 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -891,7 +891,7 @@ static DeviceState *find_device_state(const char *id, Error **errp)
 
     dev = (DeviceState *)object_dynamic_cast(obj, TYPE_DEVICE);
     if (!dev) {
-        error_setg(errp, "%s is not a hotpluggable device", id);
+        error_setg(errp, "%s is not a device", id);
         return NULL;
     }
 
-- 
2.34.1


