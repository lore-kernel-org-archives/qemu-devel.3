Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530ACCD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpIQ-0005hf-J0; Fri, 29 May 2026 00:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIP-0005hN-8q
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIN-00087K-EP
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+urkdBxoRfMQzsCR9ka10liC8QUAMNwGeIvlBxb3yJs=;
 b=LVfD91O/kFToYw4wyYmL5xF7Jk8ASQak+iBBE9TaqmBwREJtNkUkZOQSXIbK3LKUddj+Ln
 X0akZUdHShzhaHDptkCHalPxi674HefQFCEWSoJ4BjyvLwLs86JvPmUyxSbn08d6F4XUp7
 2KDxtfYkhw8ysc3xqL1lvXszuTE7db4=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-qCEhwbyHMTCbdECEsOpZqA-1; Fri, 29 May 2026 00:58:04 -0400
X-MC-Unique: qCEhwbyHMTCbdECEsOpZqA-1
X-Mimecast-MFC-AGG-ID: qCEhwbyHMTCbdECEsOpZqA_1780030683
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2fe1cf409a1so3524700eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030683; x=1780635483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+urkdBxoRfMQzsCR9ka10liC8QUAMNwGeIvlBxb3yJs=;
 b=MK6RKYfFCY2j4Ln4kFWHAyk8tIy+J9fRZVjTv/7gcI3v5SYKKsbj9PUbjYe/cxyddh
 Zpv0kFpEbqf76EUcQJuMjphAEOhqIIjk+K0HNyScEQPQWeaCzjS66F+P8NxlGz1pE+Hh
 gmzoRdX5R/Ef9IupVqFn9Nhhgs91e5dSz+uo42UlpIxmDDUV2JFVpejhIJVRAJDte6+j
 0thvAyd+lgZWw+ac9rBLfSAO7JKmBRBgH/jAD9zYAiBJ54hVqp3/To0JXX9AIuzv/xlO
 3EJXekimVY1KceKyeHdQc9uo9IFsI64IPYKRapI4Ga2Aj52qYiMINH607u8Uxgp4fs9U
 l+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030683; x=1780635483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+urkdBxoRfMQzsCR9ka10liC8QUAMNwGeIvlBxb3yJs=;
 b=GclrgiUdfA+j9zf6OBgAf3P/XrOvdlnansGYjcFeqRPB4Z8w2wJ9qZ0Qjln6ZF4QHu
 jHai/P1k61Wns1uE2VPgRlSNZXS3pFEdFzo/k92oyzIWMPwP3dlMxdlzkj4e6HU96cRD
 GsPoLRb+nPHOiNzypmjDva1Lj6FxrRwYxBGWzohwGGYdhrsVHYC310dS1LxX4A/sHLwJ
 s49YXKm8hN0UA9jBPjwOOKJwWLo1X1e+JPAvw+t1GwdXf/QmiNBeZH9BA8nG3VUEbwFN
 oaYXfr2TqzJ7nPLOorq6WCU4gXi/UYOmn0/ineN6itPOfeEBkLbtl6OAEPbHF/u4TcnD
 7xAA==
X-Gm-Message-State: AOJu0YxEjznrcVOQSV5CvhPpD3n0u4kY8TF2ppB6hZvEkiKvvPFTEv19
 0XIsxJpJJwcJ2B1GmmbLrA0kaI2nTXs6cZ3yf4ISTorLkzaIXvxzhIKkm6EqfMSiFLqzeHuXdDW
 IVDGXuaYOej5G0DW3NKppFJna0wszl/EdVU3c3IDVYT+gz/4DN0WQi5fjsbvJGZfTKIIHjQl/l9
 /O1SnAEu4OUcVsh+UgpE2ObRa3fGkNSTXW3XWZL3suibI=
X-Gm-Gg: Acq92OGHzYqnYzy18AiT/Wnu8CTlwK6RyBTi8bGWtnjXlQYRO/3+2GCIBTCdamzyijH
 xMTk/YX+qdpuGA6+PRo2zQuHzZLEU5bG57kss9FzcW8gGYtgj1Wj6Xk7EbnR1OTYIeOY6MkBcXo
 NAnmtVcQLbB3wduhe+D2vEqy2dJu+ZdomkUl8BVWibWO70wTMnSyxMNmuYEZ7tdx1Afw4EYmLnS
 Sdki15CBjrglOU0qNltDnH+gKkefR2bjyrFZB2FAAAehHO+geKt3jm2zDE2XCYIVCRrewgZm5n0
 HEdFXGp7myX8DUgMRd7lBJAWqRSETi6iSJClZBU5oqafA0Q4gUKE5wv88vzXzl9VfGp0KOr18PX
 sDPjJIlDs5rAaGYaVfB7NI7p9cTYNv9bZ5P8BZpCXGN3RjEAoIlg5YkWpZDY+zWs65XElOOYj
X-Received: by 2002:a05:7300:fd84:b0:2ed:2942:34ab with SMTP id
 5a478bee46e88-304eb06ccabmr614929eec.3.1780030683112; 
 Thu, 28 May 2026 21:58:03 -0700 (PDT)
X-Received: by 2002:a05:7300:fd84:b0:2ed:2942:34ab with SMTP id
 5a478bee46e88-304eb06ccabmr614912eec.3.1780030682427; 
 Thu, 28 May 2026 21:58:02 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.57.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:58:02 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 06/15] net/tap: net_init_tap_one() refactor to get vhostfd param
Date: Fri, 29 May 2026 12:57:21 +0800
Message-ID: <20260529045730.90322-7-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529045730.90322-1-jasowang@redhat.com>
References: <20260529045730.90322-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Get vhostfd instead of vhostfdname:

- more symmetry with fd param
- prepare to further changes

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 2eb8a2caeb..2c5f8e73fe 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -706,11 +706,10 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
 static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *model, const char *name,
                              const char *ifname, const char *script,
-                             const char *downscript, const char *vhostfdname,
+                             const char *downscript, int vhostfd,
                              int vnet_hdr, int fd, Error **errp)
 {
     TAPState *s = net_tap_fd_init(peer, model, name, fd, vnet_hdr);
-    int vhostfd;
     bool sndbuf_required = tap->has_sndbuf;
     int sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
@@ -738,7 +737,7 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     }
 
     if (tap->has_vhost ? tap->vhost :
-        vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
+        (vhostfd != -1) || (tap->has_vhostforce && tap->vhostforce)) {
         VhostNetOptions options;
 
         options.backend_type = VHOST_BACKEND_TYPE_KERNEL;
@@ -749,15 +748,7 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
             options.busyloop_timeout = 0;
         }
 
-        if (vhostfdname) {
-            vhostfd = monitor_fd_param(monitor_cur(), vhostfdname, errp);
-            if (vhostfd == -1) {
-                goto failed;
-            }
-            if (!qemu_set_blocking(vhostfd, false, errp)) {
-                goto failed;
-            }
-        } else {
+        if (vhostfd == -1) {
             vhostfd = open("/dev/vhost-net", O_RDWR);
             if (vhostfd < 0) {
                 error_setg_file_open(errp, errno, "/dev/vhost-net");
@@ -820,7 +811,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
     const NetdevTapOptions *tap;
-    int fd = -1, vnet_hdr = 0, i = 0, queues;
+    int fd = -1, vhostfd = -1, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
     char ifname[128];
     char **fds = NULL, **vhost_fds = NULL;
@@ -866,6 +857,17 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
+    if (tap->vhostfd) {
+        vhostfd = monitor_fd_param(monitor_cur(), tap->vhostfd, errp);
+        if (vhostfd == -1) {
+            return -1;
+        }
+
+        if (!qemu_set_blocking(vhostfd, false, errp)) {
+            goto fail;
+        }
+    }
+
     if (tap->fd) {
         fd = monitor_fd_param(monitor_cur(), tap->fd, errp);
         if (fd == -1) {
@@ -883,7 +885,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
         if (!net_init_tap_one(tap, peer, "tap", name, NULL,
                               NULL, NULL,
-                              tap->vhostfd, vnet_hdr, fd, errp)) {
+                              vhostfd, vnet_hdr, fd, errp)) {
             goto fail;
         }
     } else if (tap->fds) {
@@ -910,6 +912,17 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto fail;
             }
 
+            if (tap->vhostfds) {
+                vhostfd = monitor_fd_param(monitor_cur(), vhost_fds[i], errp);
+                if (vhostfd == -1) {
+                    goto fail;
+                }
+
+                if (!qemu_set_blocking(vhostfd, false, errp)) {
+                    goto fail;
+                }
+            }
+
             if (i == 0) {
                 vnet_hdr = tap_probe_vnet_hdr(fd, errp);
                 if (vnet_hdr < 0) {
@@ -923,7 +936,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
             if (!net_init_tap_one(tap, peer, "tap", name, ifname,
                                   NULL, NULL,
-                                  tap->vhostfds ? vhost_fds[i] : NULL,
+                                  vhostfd,
                                   vnet_hdr, fd, errp)) {
                 goto fail;
             }
@@ -945,7 +958,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
 
         if (!net_init_tap_one(tap, peer, "bridge", name, ifname,
-                              NULL, NULL, tap->vhostfd,
+                              NULL, NULL, vhostfd,
                               vnet_hdr, fd, errp)) {
             goto fail;
         }
@@ -978,7 +991,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
             if (!net_init_tap_one(tap, peer, "tap", name, ifname,
                                   i >= 1 ? NULL : script,
                                   i >= 1 ? NULL : downscript,
-                                  tap->vhostfd, vnet_hdr, fd, errp)) {
+                                  vhostfd, vnet_hdr, fd, errp)) {
                 goto fail;
             }
         }
@@ -988,6 +1001,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
 fail:
     close(fd);
+    close(vhostfd);
     if (vhost_fds) {
         for (i = 0; i < nvhosts; i++) {
             g_free(vhost_fds[i]);
-- 
2.54.0


