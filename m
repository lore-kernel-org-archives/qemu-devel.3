Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03DCCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEWK6-0001TY-D5; Thu, 30 Oct 2025 13:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWJb-0001CY-6x
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:19:59 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWJU-0008Mp-FC
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:19:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5B0F6C0165;
 Thu, 30 Oct 2025 20:19:24 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GJjc0O0FA0U0-3uPA7wJD; Thu, 30 Oct 2025 20:19:23 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761844763;
 bh=Pyx9akFGNoeu+Fy6mc4TIv8Sp1l5A46fhojHiVayjV4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=NnRdZFSg+W1nhO3vMTIxDW6A8FsDfsmy+FMgC4feOLunyoLOzpiWToGg2eH20ga80
 Lld4LH9TZpTXQKt1htFkSQHTFZBeLAYH/TiISjOhaRuKAVuzsrv+a6X3XwHz1mzHdz
 8ip1L7iDJPeED3w3uMybLsZKXaKP73h2+hwYlWC8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, peterx@redhat.com
Subject: [PATCH v9 8/9] net/tap: introduce TAP_IFNAME_SZ
Date: Thu, 30 Oct 2025 20:19:13 +0300
Message-ID: <20251030171915.726441-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030171915.726441-1-vsementsov@yandex-team.ru>
References: <20251030171915.726441-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To be reused in the next commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 net/tap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/tap.c b/net/tap.c
index 7e85444ace..c50430ba49 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -48,6 +48,8 @@
 
 #include "net/vhost_net.h"
 
+#define TAP_IFNAME_SZ 128
+
 static const int kernel_feature_bits[] = {
     VIRTIO_F_NOTIFY_ON_EMPTY,
     VIRTIO_RING_F_INDIRECT_DESC,
@@ -853,7 +855,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
     /* for the no-fd, no-helper case */
     Error *err = NULL;
     const char *vhostfdname;
-    char ifname[128];
+    char ifname[TAP_IFNAME_SZ];
     int ret = 0;
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
-- 
2.48.1


