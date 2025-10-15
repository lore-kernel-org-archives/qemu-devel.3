Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F4ACCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91SM-0005Ks-G6; Wed, 15 Oct 2025 09:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91S4-0005Ha-2H
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:22:00 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v91Rv-0002zb-ML
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:21:59 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 4CD5C88A67;
 Wed, 15 Oct 2025 16:21:42 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a94::1:15])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id bLQ5oq0N5Os0-tnOhXPIG; Wed, 15 Oct 2025 16:21:41 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760534501;
 bh=bbvjn2b2AN6mVV4jMAmeSq+jgoBhCopUSDtTBCApKuY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=HfwldODTizHDOND58VrdkzXcsy66eJeL/7+g+kPuTQbFmzdZT61nZ+zMB/MGObNkH
 lA1K2uZBQ4AicI6XzpHkB7CgM3qZgOcgnTHqJ1Mny4ji4QfIqe7Jp4h+7lmvY+JXr1
 kg42tnyCGmurdHkJz3d9zic762hF6iLaUMl2wZAE=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: peterx@redhat.com, farosas@suse.de, sw@weilnetz.de, eblake@redhat.com,
 armbru@redhat.com, thuth@redhat.com, philmd@linaro.org,
 berrange@redhat.com, qemu-devel@nongnu.org, michael.roth@amd.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v8 02/19] net/tap: net_init_tap_one(): move parameter checking
 earlier
Date: Wed, 15 Oct 2025 16:21:18 +0300
Message-ID: <20251015132136.1083972-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
References: <20251015132136.1083972-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Let's keep all similar argument checking in net_init_tap() function.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 70de798fe8..f90050c3a0 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -768,9 +768,6 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                        "vhost-net requested but could not be initialized");
             goto failed;
         }
-    } else if (vhostfdname) {
-        error_setg(errp, "vhostfd(s)= is not valid without vhost");
-        goto failed;
     }
 
     return;
@@ -832,6 +829,11 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    if (tap->has_vhost && !tap->vhost && (tap->vhostfds || tap->vhostfd)) {
+        error_setg(errp, "vhostfd(s)= is not valid without vhost");
+        return -1;
+    }
+
     if (tap->fd) {
         if (tap->ifname || tap->script || tap->downscript ||
             tap->has_vnet_hdr || tap->helper || tap->has_queues ||
-- 
2.48.1


