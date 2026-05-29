Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F5BCD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpIt-0006SZ-BK; Fri, 29 May 2026 00:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIq-0006Jq-Nb
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIo-0008FE-55
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R30LUVTxAYk4BwKAO0Omq+7KzeofNUrPyd+QTxsv7Os=;
 b=ZbX7S+1aAKIJtorwzibHuYQz+RidnDskGgPtL6yCWzZD+wdhxo7WRjL0YvMunDHvbmg5C4
 IXkFn32Q+I8pUF0m7sblCiNfeHVJeOSDjjXTPzKt9Gm4jLHA0xfZwHR3Eon/XsGrUl0Xl2
 itO7ntTD8sEo4VCRCcYVC8TvlpOtFG4=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Vd8CPRzJMSWtU977td8RzA-1; Fri, 29 May 2026 00:58:28 -0400
X-MC-Unique: Vd8CPRzJMSWtU977td8RzA-1
X-Mimecast-MFC-AGG-ID: Vd8CPRzJMSWtU977td8RzA_1780030707
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304ee7d1368so116036eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030707; x=1780635507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R30LUVTxAYk4BwKAO0Omq+7KzeofNUrPyd+QTxsv7Os=;
 b=acK5BdxGluHrsO+dTNK/XpAwx8Wjw3d5FFtkgd9pxwI+qobbrsRIGERH1POGR8LVi3
 CMEzTb9Tm64VwU5BwLn6gXDom0HybKQEYYZKFTsihIB6jwJ0GlQso3Vmwhh5dOypD81X
 YIcKlhZO5TMSu2R/f7/RDnPxz/mkvIQpWxmGj7Fmj/krvKmlHIU5O+O9/uzMoickirjD
 G2ARx6bXfhNS6or1kNVeZxpgfKfdeH/e2Z+F7AvLYpHI0llFEJLGxaSoXIzbR4xsUhyX
 7TwHVCbiDltt7yNunO2L/KV0wXFTorVuwADuJ9Vt53B3+Qg8EVqEIh6dbrTxnoT1zK/p
 ii+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030707; x=1780635507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R30LUVTxAYk4BwKAO0Omq+7KzeofNUrPyd+QTxsv7Os=;
 b=FpbRmpC3tO5XIrOPfePd04zQQQtYeoIsb1t7oKOe206xjo/BRuArJxSoI30dK1R0jy
 szTVLyfzrR1bLY/1X70x5M2/Amt628sUn5ZU/2e+IiIhmFRxQsY33tl4JR0rJcqgMojR
 Q9WHo5Jm1fZ8Zw/5C+OMJYwF4bHth8TYbNFEzMpxJKJdgR8hzH1ocsBO5+1xsHL0ybji
 e4F5gJLpJSHzcz695UwtFacdzOLy3C/mgVYiSYrDKMqvO/pmfcOMaQxRZJFrDmj+l0wD
 qPV8JKkHZqPG6czvR2q/TC7i+rKd8515nLaGinDyh2YhhEB1Xazc/2Q+5WY0M3pC1ec8
 /VqQ==
X-Gm-Message-State: AOJu0YxCJHA/zbPDcmt62mqYpa6BmCTR6iJmFEoCoQTL1P36LADUcdio
 VE+4PY+DQLosB9FZVnOauZwplYdwIIsh4OWGfvU1hZbV4pTNo68ajAUuDkuMM5aTTb0gHZLkOZB
 /9mvpCaWUpXOKpYBbwIata9KHfg9ltx9VUTAZbq1xFJokq3vaW1qlvIcsCHBSfYFnjm/Cq4nPXz
 kqv4b1jv2bgUn1tQmbBuzCym386mfMj6ENWOtbiV1kWnQ=
X-Gm-Gg: Acq92OFK92tXBH0sGV6ysp2AwSiWIVb1qZ/iBUMp0GDALqS6NeibhR6PcCtWmSYaSJe
 vgoUD3C3q9BqNhAFv5R8k6tHabch5GVpzTqUoyxw52kPDvJbZX3EsygoTc6YMY7QCi3aZm0/4XP
 nbo+RHIaMyMKzF7Tpc1lPpA69d0pjQtmSe8mTrWzMCVQ+0JxGRo/YPD897zWSUixG6Jz1PgvhY5
 y2tyxt7U6mxQom5LqQ12EO/V6MCOzKv2fmXnGJZ4gDSoOqGLgtnzt1uK0TXfMJ/G+Cg7luboJpT
 V5lkymQBMMwbVCx5T+nEv7RRhWXEO3/rcbDV9nO8Z8CVzJ8Kv4c7bUtipQiCrTY5JwR7B6lPHTo
 wZtQ1bEgT9Q+yqieNn6X2z3ANFuvXP0Zh72VlWcX/d6LMGIhkkQnPOcFUmQzVGVXkVjhSciaN
X-Received: by 2002:a05:7300:ec07:b0:304:d92a:e60a with SMTP id
 5a478bee46e88-304eb241113mr556422eec.31.1780030706786; 
 Thu, 28 May 2026 21:58:26 -0700 (PDT)
X-Received: by 2002:a05:7300:ec07:b0:304:d92a:e60a with SMTP id
 5a478bee46e88-304eb241113mr556413eec.31.1780030706133; 
 Thu, 28 May 2026 21:58:26 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.58.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:58:25 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 12/15] net/tap: net_init_tap(): relax QEMU hubs check
Date: Fri, 29 May 2026 12:57:27 +0800
Message-ID: <20260529045730.90322-13-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529045730.90322-1-jasowang@redhat.com>
References: <20260529045730.90322-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

queues may be set to 1, as well as fds may contain only one fd.
No reason to block such cases. Let's check exactly number of queues.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index c6bf8a7042..e464f62b47 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -869,13 +869,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
 
-    /* QEMU hubs do not support multiqueue tap, in this case peer is set.
-     * For -netdev, peer is always NULL. */
-    if (peer && (tap->has_queues || tap->fds || tap->vhostfds)) {
-        error_setg(errp, "Multiqueue tap cannot be used with hubs");
-        return -1;
-    }
-
     if (tap->has_vhost && !tap->vhost && (tap->vhostfds || tap->vhostfd)) {
         error_setg(errp, "vhostfd(s)= is not valid without vhost");
         return -1;
@@ -899,6 +892,15 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    /*
+     * QEMU hubs do not support multiqueue tap, in this case peer is set.
+     * For -netdev, peer is always NULL.
+     */
+    if (peer && queues > 1) {
+        error_setg(errp, "Multiqueue tap cannot be used with hubs");
+        goto fail;
+    }
+
     if (!tap_parse_vhost_fds(tap, &vhost_fds, queues, errp)) {
         goto fail;
     }
-- 
2.54.0


