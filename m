Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ABB103E162
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 11:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2p8Z-0006kI-KS; Wed, 18 Mar 2026 07:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p83-0006gV-Ob
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:32:00 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w2p7z-0001r8-SV
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 07:31:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C508880850;
 Wed, 18 Mar 2026 14:31:50 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:431::1:10])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id kVLGYB2A1mI0-fEHySrjD; Wed, 18 Mar 2026 14:31:50 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773833510;
 bh=oYrOWvxpPKolxAzR15PEuouflhd7oKextGuv7hv0qo8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Z4pmVUL4+G/gJ/sHER8WKZfc0Us+Nwus7Pl/HWqFNjKY0Q/kBGdgjG3SpphP65fbN
 qkdUQyrL53HnzLTSrwhPe3KUAOu8QpU20dBX7KPQdNgu+OpVq/gSduBYCZi0wk+aME
 OvIsQwYPhY3AiH/tk6wehcQdYcDVUi9EiAfDb8Ig=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 vsementsov@yandex-team.ru, Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v4 01/13] net/af-xdp: fix type overflow
Date: Wed, 18 Mar 2026 14:31:31 +0300
Message-ID: <20260318113144.15697-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318113144.15697-1-vsementsov@yandex-team.ru>
References: <20260318113144.15697-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

In for-loop in net_init_af_xdp, we do nc->queue_index = i,
where is is int64_t for 0 to queues-1, and nc->queue_index is
unsigned int.

Also in parse_socket_fds, g_strv_length() returns guint which
is equivalent to unsigned int.

Let's simply use int type for queues, and update the check
appropriately. It could be unsigned int, but in future commits
we'll share with net/tap.c the common function which will return
number of queues or negative error. So, let's simply use int for
queues-related variables, that simplifies things.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
---
 net/af-xdp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index 14f302ea215..ff1cb30a98d 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -442,14 +442,14 @@ static NetClientInfo net_af_xdp_info = {
 };
 
 static int *parse_socket_fds(const char *sock_fds_str,
-                             int64_t n_expected, Error **errp)
+                             int n_expected, Error **errp)
 {
     gchar **substrings = g_strsplit(sock_fds_str, ":", -1);
-    int64_t i, n_sock_fds = g_strv_length(substrings);
+    int i, n_sock_fds = g_strv_length(substrings);
     int *sock_fds = NULL;
 
     if (n_sock_fds != n_expected) {
-        error_setg(errp, "expected %"PRIi64" socket fds, got %"PRIi64,
+        error_setg(errp, "expected %d socket fds, got %d",
                    n_expected, n_sock_fds);
         goto exit;
     }
@@ -484,7 +484,7 @@ int net_init_af_xdp(const Netdev *netdev,
     unsigned int ifindex;
     uint32_t prog_id = 0;
     g_autofree int *sock_fds = NULL;
-    int64_t i, queues;
+    int i, queues;
     Error *err = NULL;
     AFXDPState *s;
     bool inhibit;
@@ -496,13 +496,14 @@ int net_init_af_xdp(const Netdev *netdev,
         return -1;
     }
 
-    queues = opts->has_queues ? opts->queues : 1;
-    if (queues < 1) {
+    if (opts->has_queues && (opts->queues < 1 || opts->queues > INT_MAX)) {
         error_setg(errp, "invalid number of queues (%" PRIi64 ") for '%s'",
-                   queues, opts->ifname);
+                   opts->queues, opts->ifname);
         return -1;
     }
 
+    queues = opts->has_queues ? opts->queues : 1;
+
     inhibit = opts->has_inhibit && opts->inhibit;
     if (inhibit && !opts->sock_fds && !opts->map_path) {
         error_setg(errp, "'inhibit=on' requires 'sock-fds' or 'map-path'");
@@ -537,7 +538,7 @@ int net_init_af_xdp(const Netdev *netdev,
 
     for (i = 0; i < queues; i++) {
         nc = qemu_new_net_client(&net_af_xdp_info, peer, "af-xdp", name);
-        qemu_set_info_str(nc, "af-xdp%"PRIi64" to %s", i, opts->ifname);
+        qemu_set_info_str(nc, "af-xdp%d to %s", i, opts->ifname);
         nc->queue_index = i;
 
         if (!nc0) {
-- 
2.52.0


