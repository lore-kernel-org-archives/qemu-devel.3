Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8FBCD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpI7-0005ex-Vj; Fri, 29 May 2026 00:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpI6-0005eb-NF
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpI5-00085T-1t
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uihaSoHM7LrSDDH5BIzYL6KB1nlD+77aPlq53M6xXW4=;
 b=Nbjp8XOfaGqIxkZG/wOmvXksHDxwm9MIFQyhZPkHmdEPrfy3t/IHq6ziEjU8et8lbDZ95q
 6DsZWZrhUIWFxsGhLp+wOwc08KA+gXMPyDE8uNhjOQBZ4u8VAbl5iaFwIEi6RS2dgWrQwN
 l3QMz5YhQPYM6/y1yq3XHqcwM6ll6MQ=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-N_ERN2oEM4egOiTHHX-rUg-1; Fri, 29 May 2026 00:57:46 -0400
X-MC-Unique: N_ERN2oEM4egOiTHHX-rUg-1
X-Mimecast-MFC-AGG-ID: N_ERN2oEM4egOiTHHX-rUg_1780030665
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304e3e3fba5so3116503eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030665; x=1780635465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uihaSoHM7LrSDDH5BIzYL6KB1nlD+77aPlq53M6xXW4=;
 b=dAa4twV3Pb9YI7P0+RqStrPVysJ6o3LdSrFCTX0Yx+1SzFp6zElLdw8DDvYmDpy6DI
 0KPCDwF769JMDRl66QKabwnOTupFKqwKj+d2p588sk+qTyPLViACC4SCic+wBp6byByS
 FlapbMS1LowFgMsOAaDbsd1baZed+Dtvq9Wh71kt4IfBLVgQ+lNaD5rD5OS0UGxq+SNv
 Le0EgpJ7z1Q9qePM+LikokoHrEgNnw+jsrI+6RLZlrQxZZcUOzGoXcrGuIaNxKA7nkE+
 CWz+5SriccA8wWRh87SIiogiLzkQRb1g9m8TH+xZflzDfSB3LfHRuSN5c3dWJvp835X3
 s/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030665; x=1780635465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uihaSoHM7LrSDDH5BIzYL6KB1nlD+77aPlq53M6xXW4=;
 b=AlTuTuw0WlP84PANg6eT/VeqOWyWEByBJwGXppZWiFG5CMJDRZFxyplc2MG27FNKsM
 myTEPbitZ/tOqN5A/MLvDfYeYPr0U2UU6Rw0mAH8azZCOkKOzWiFS5TkUcXOKeG67L1b
 Z3HEJ+MJZt/wPBNQtZEDraRIsqD1uxykmVF9uoJM1IKrnBJWF3seNCda8ylqsTWWV7nP
 sbWaPuBgcOdFyoH2Nj6WzAnPSF+MCJe2PZESpvqtgP2n1bJpMojufbN8IGN/XRdvY1/a
 nk7OIdQ9ecSyWho8aGJmNySCPPYrnYSeXfWk3DYKXwBFmvUr5kltFa650DX9w/ipLJY1
 CIWw==
X-Gm-Message-State: AOJu0YwMtUQZUx93LtxvudKlKtthnZxbz7896YSBYX0QUDBUWHsU23WX
 W0tCFLQFs+AvZQpEH/mzx5X5eIcNDJYBuv7YhBgBlw4kks+eBy1+iRKQZmsEc0az6uAi1MlApkE
 J5sNA1REKUeWjolRbDDwio5GGJTa157yYnScbsgt5P8ByzpUv+KHse4ZVN6ey1U7kumVnKsauRr
 KOGGtb+/kH6vcR8waluugy1X8tTNCye/CYcvqHkOqE4lA=
X-Gm-Gg: Acq92OF1QA8g9nn6wNETFlnDWgwELdFQTllAqhe0aG3MzANo94b7ocNwp1OUxsO9aT+
 AOTmlvY1/08rthRTWgWsC+kxPJ/nyeSNJ9ED7Eql9HhPDsHnYS6mcOAP/pppmN/OW7NZhGUK+Os
 m/tQkO+Qq1dx2CR1e5ctNzP4miMnWOII3aFGs/NSiU8864t9t/1yFt4MF9KsB1R0FpHaSvXoqXQ
 Rxe2dwbWipNoVcBlzrFXpskwa2+WxMtQTQZzh2V2s8FOFm6oyvRBR9WKVevprhSPqFWLayXfEBf
 RxkeMVS7i9H2VtnVwK4GrMbw1JBSL5/2jSOgsOkJLBl6bqq/QyrWEgoeg/QJjoxz3MmzwQK3yTE
 13u6VsIVcGhSXqt3YHh7x07m8TsWju+vwb+v8j3BL6WzUZquiYX5xjCYoD4Dj9RevLfgsBAMz
X-Received: by 2002:a05:7300:80cb:b0:2ee:ade0:e0bf with SMTP id
 5a478bee46e88-304eb161d6dmr628786eec.30.1780030664830; 
 Thu, 28 May 2026 21:57:44 -0700 (PDT)
X-Received: by 2002:a05:7300:80cb:b0:2ee:ade0:e0bf with SMTP id
 5a478bee46e88-304eb161d6dmr628773eec.30.1780030664115; 
 Thu, 28 May 2026 21:57:44 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.57.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:57:43 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 01/15] net/af-xdp: fix type overflow
Date: Fri, 29 May 2026 12:57:16 +0800
Message-ID: <20260529045730.90322-2-jasowang@redhat.com>
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
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/af-xdp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/af-xdp.c b/net/af-xdp.c
index 14f302ea21..ff1cb30a98 100644
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
2.54.0


