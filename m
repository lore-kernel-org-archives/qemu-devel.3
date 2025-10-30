Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1D6CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEWKC-0001UN-Ap; Thu, 30 Oct 2025 13:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWJZ-0001BU-4y
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:19:57 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWJR-0008Mv-WB
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:19:56 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1a8f:0:640:2fa2:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9FCC8C00CB;
 Thu, 30 Oct 2025 20:19:23 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id GJjc0O0FA0U0-iGfWLy01; Thu, 30 Oct 2025 20:19:23 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761844763;
 bh=5TyEDZ5Mjwqq60C4nA/4AdTGhH71Q5NYhSQBBF9mZHM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ilOkB9+Lv3XvmJH/8USVmjfVMCC03hJK1dijfOW6g0QkLeWpzmKRWDdgS2ypm93cX
 clOtBn6GEs/kV4UD/jmkeh5/zvFMt28tly+2OpBlpHbrjbGHIyqA5voJcfJd/UjjU+
 e/TCxMxlUPej/Rwt7wIjpGmkRYy6eVqK9nRhKdWY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, leiyang@redhat.com,
 davydov-max@yandex-team.ru, yc-core@yandex-team.ru, pbonzini@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, peterx@redhat.com
Subject: [PATCH v9 7/9] net/tap: finalize net_tap_set_fd() logic
Date: Thu, 30 Oct 2025 20:19:12 +0300
Message-ID: <20251030171915.726441-8-vsementsov@yandex-team.ru>
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

Let net_tap_set_fd() do only fd-related setup.

Actually, for further backend-transfer migration for virtio-net/tap
we'll want to skip net_tap_set_fd() (as incoming fds are already
prepared by source QEMU). So move tap_read_poll() to net_tap_setup().

Don't care about using_vnet_hdr and vhost_net, the state is
zero-initialized.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 net/tap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index d08ef070e9..7e85444ace 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -480,7 +480,6 @@ static bool net_tap_set_fd(TAPState *s, int fd, int vnet_hdr, Error **errp)
 
     s->fd = fd;
     s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
-    s->using_vnet_hdr = false;
     s->has_ufo = tap_probe_has_ufo(s->fd);
     s->has_uso = tap_probe_has_uso(s->fd);
     s->has_tunnel = tap_probe_has_tunnel(s->fd);
@@ -493,8 +492,6 @@ static bool net_tap_set_fd(TAPState *s, int fd, int vnet_hdr, Error **errp)
     if (vnet_hdr) {
         tap_fd_set_vnet_hdr_len(s->fd, s->host_vnet_hdr_len);
     }
-    tap_read_poll(s, true);
-    s->vhost_net = NULL;
 
     if (s->sndbuf) {
         Error **e = s->sndbuf_required ? errp : NULL;
@@ -795,6 +792,8 @@ static bool net_tap_setup(TAPState *s, int fd, int vnet_hdr, Error **errp)
         return false;
     }
 
+    tap_read_poll(s, true);
+
     if (s->vhostfd != -1) {
         VhostNetOptions options;
 
-- 
2.48.1


