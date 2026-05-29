Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8952FCD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpIO-0005hF-Oq; Fri, 29 May 2026 00:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIM-0005h0-Nq
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIL-00086w-0M
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wXgUoz2kDhdvNT3gb2pcIb2zVVrprNZrWtVAiaM5OzM=;
 b=amt2mN6YC0wTRbWE8iroO51yIXklysFaueGkt+srUAbsaUQxNd1CDFQ66Xbowehaf81tf7
 nPb6FxH0z8DJ74zqcBjb7JSin7ZPnMyWbnlsWoo+0CmL2xH7K4ZohgiNgZUvgevDm9ickJ
 Y666SDZWJYErODslbFSJO5KgoT1FJb0=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-fdFzWZ5zN3SdZJnuwhXmbQ-1; Fri, 29 May 2026 00:58:00 -0400
X-MC-Unique: fdFzWZ5zN3SdZJnuwhXmbQ-1
X-Mimecast-MFC-AGG-ID: fdFzWZ5zN3SdZJnuwhXmbQ_1780030679
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2fe1cf409a1so3524656eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030679; x=1780635479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wXgUoz2kDhdvNT3gb2pcIb2zVVrprNZrWtVAiaM5OzM=;
 b=TL1mFPswIlDL+iVtPxk3NWwPZ2omZc+VVptckxZMkuFZAU8UFzGRGIPCbqi7PTEp/f
 6apf+JazW0Gqb5suqjVT5vwXo+USrOmHCT+7V2r0COtYPKpGrJzUjIhvdP1d9KsI8lVF
 SC1pZgWl8OVfeQsYIFgMGB4EygAIo7FtRD3PhCnSjJxhEs9yUcDRyEoHrWzXTO/tiQW0
 zyqlV+3f06BTntaMG+IMfjIEZSSx6IsZ6vlWgoKnfM5STInh+qc7NyrOcFVuEc2kbOD+
 GsN5q5jBMc6A5ncAS/ATqsbjjZVoGHSjYptXkb2bEfcRdqyknMbIqCgAH+rmFk0QNWPb
 uDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030679; x=1780635479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wXgUoz2kDhdvNT3gb2pcIb2zVVrprNZrWtVAiaM5OzM=;
 b=IvkH0SYWu+CQmT/bNgkOBGxDJOqhJgJCYKKkDA0c3PCAb7Tvuhs3vVl3L2nnV7EUqO
 B1ImB8eCLFBoEZIlEPjcbA1Mq6tqgCD2TgfXXfPHsvHmDFBIEUtodT07wVQ8O5Em4ph1
 TRLdkRqxgTZsZZE+T+2/Tmls45mKVu2ilh7hl7KDLd8+zgNwRlU+XGzxfnSqiLQlQsei
 qHaa1/Pp0Zu4xXpiBLKfJVcwbkCSWw1t0HfVjH64yzNng9Hh4EXyBjnHvHAV0G9KUZ/t
 iGqLsZXroi1/eHaTPTENWEgwhCXvEpVvJ5LNasjutHNk0sGX3Y9id9QtsPPY+8kUVJrk
 P1gA==
X-Gm-Message-State: AOJu0Yzr0m5syFY3bhdE80LOFYeqf0Fsu4swtlIHcw09kwy9Yi+asijo
 9vnee6Fcih4zkm5YQZg4cMEYAuMFEIPtDNXMzh8ZTaZ0E90FacgFJv/MkoURdr6jioQcIt2AWcz
 FlfKlAlxVVHGPordri4FI6q191svINPN1MVLJkzRmYKApiKFBBaObCmKQM/GWGH5Pgvp7QB8YSX
 NTmVqedalBx4rz/t1KJ/G7fy2EJAcEVpI2xQ68aLrUYbw=
X-Gm-Gg: Acq92OEKup7IvVVH4Gfo1hc2+mU1bBE329a7hFQkgAmUI0E8NYqg9akX6wUgXOeVVam
 wDOjVRkv8JSlsUjX1uvv7XiqOpbRlmpTDyGqBPXJJNmOrB7kXHziV4uvmDA/pPyRWFZDK1G48wR
 HtrPD+z5N87H6y0nXq6E17N5z7r4w91kU+DChgxf5+uUFrpA4fUhQRGTmiokyixZ8n6UiCxpZNP
 S1w6Ur8FQ48jOaTp322oRv2jYq+3jY4ItLWxzPCpUrOL6ehAIOcEdcp34khF6TMJsixORGut0Aa
 vNHPppRROIVmgVusYup1RT8a6d5o68wMqqCqeKagR3LqOGiYOLZBDjd4ELAtlIp0pFJnXsqDwte
 dBJVgkEy+RHWWaUkBcbGQ+8mI0ICmivLLgAnYITMofuqVsSMV3TQE/hvN+58EB/Z12slhBdeL
X-Received: by 2002:a05:7300:6d21:b0:304:cf6c:4cfe with SMTP id
 5a478bee46e88-304eb0bcb61mr605314eec.9.1780030679368; 
 Thu, 28 May 2026 21:57:59 -0700 (PDT)
X-Received: by 2002:a05:7300:6d21:b0:304:cf6c:4cfe with SMTP id
 5a478bee46e88-304eb0bcb61mr605299eec.9.1780030678739; 
 Thu, 28 May 2026 21:57:58 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.57.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:57:57 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 05/15] net/tap: net_init_tap(): common fail label
Date: Fri, 29 May 2026 12:57:20 +0800
Message-ID: <20260529045730.90322-6-jasowang@redhat.com>
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

Add common failure label. This:

- simplifies failure paths in the function
- get rid of unusual free_fail: in the middle of the function
- simplify further refactoring

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 84 ++++++++++++++++++++++++-------------------------------
 1 file changed, 37 insertions(+), 47 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 331a779585..2eb8a2caeb 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -820,10 +820,12 @@ int net_init_tap(const Netdev *netdev, const char *name,
                  NetClientState *peer, Error **errp)
 {
     const NetdevTapOptions *tap;
-    int fd, vnet_hdr = 0, i = 0, queues;
+    int fd = -1, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
     char ifname[128];
-    int ret = 0;
+    char **fds = NULL, **vhost_fds = NULL;
+    int nfds = 0, nvhosts = 0;
+
 
     assert(netdev->type == NET_CLIENT_DRIVER_TAP);
     tap = &netdev->u.tap;
@@ -867,31 +869,24 @@ int net_init_tap(const Netdev *netdev, const char *name,
     if (tap->fd) {
         fd = monitor_fd_param(monitor_cur(), tap->fd, errp);
         if (fd == -1) {
-            return -1;
+            goto fail;
         }
 
         if (!qemu_set_blocking(fd, false, errp)) {
-            close(fd);
-            return -1;
+            goto fail;
         }
 
         vnet_hdr = tap_probe_vnet_hdr(fd, errp);
         if (vnet_hdr < 0) {
-            close(fd);
-            return -1;
+            goto fail;
         }
 
         if (!net_init_tap_one(tap, peer, "tap", name, NULL,
                               NULL, NULL,
                               tap->vhostfd, vnet_hdr, fd, errp)) {
-            close(fd);
-            return -1;
+            goto fail;
         }
     } else if (tap->fds) {
-        char **fds;
-        char **vhost_fds;
-        int nfds = 0, nvhosts = 0;
-
         fds = g_new0(char *, MAX_TAP_QUEUES);
         vhost_fds = g_new0(char *, MAX_TAP_QUEUES);
 
@@ -901,77 +896,58 @@ int net_init_tap(const Netdev *netdev, const char *name,
             if (nfds != nvhosts) {
                 error_setg(errp, "The number of fds passed does not match "
                            "the number of vhostfds passed");
-                ret = -1;
-                goto free_fail;
+                goto fail;
             }
         }
 
         for (i = 0; i < nfds; i++) {
             fd = monitor_fd_param(monitor_cur(), fds[i], errp);
             if (fd == -1) {
-                ret = -1;
-                goto free_fail;
+                goto fail;
             }
 
             if (!qemu_set_blocking(fd, false, errp)) {
-                ret = -1;
-                goto free_fail;
+                goto fail;
             }
 
             if (i == 0) {
                 vnet_hdr = tap_probe_vnet_hdr(fd, errp);
                 if (vnet_hdr < 0) {
-                    ret = -1;
-                    goto free_fail;
+                    goto fail;
                 }
             } else if (vnet_hdr != tap_probe_vnet_hdr(fd, NULL)) {
                 error_setg(errp,
                            "vnet_hdr not consistent across given tap fds");
-                ret = -1;
-                goto free_fail;
+                goto fail;
             }
 
             if (!net_init_tap_one(tap, peer, "tap", name, ifname,
                                   NULL, NULL,
                                   tap->vhostfds ? vhost_fds[i] : NULL,
                                   vnet_hdr, fd, errp)) {
-                ret = -1;
-                goto free_fail;
+                goto fail;
             }
         }
-
-free_fail:
-        for (i = 0; i < nvhosts; i++) {
-            g_free(vhost_fds[i]);
-        }
-        for (i = 0; i < nfds; i++) {
-            g_free(fds[i]);
-        }
-        g_free(fds);
-        g_free(vhost_fds);
-        return ret;
     } else if (tap->helper) {
         fd = net_bridge_run_helper(tap->helper,
                                    tap->br ?: DEFAULT_BRIDGE_INTERFACE,
                                    errp);
         if (fd == -1) {
-            return -1;
+            goto fail;
         }
 
         if (!qemu_set_blocking(fd, false, errp)) {
-            return -1;
+            goto fail;
         }
         vnet_hdr = tap_probe_vnet_hdr(fd, errp);
         if (vnet_hdr < 0) {
-            close(fd);
-            return -1;
+            goto fail;
         }
 
         if (!net_init_tap_one(tap, peer, "bridge", name, ifname,
                               NULL, NULL, tap->vhostfd,
                               vnet_hdr, fd, errp)) {
-            close(fd);
-            return -1;
+            goto fail;
         }
     } else {
         g_autofree char *script =
@@ -989,14 +965,13 @@ free_fail:
             fd = net_tap_init(tap, &vnet_hdr, i >= 1 ? NULL : script,
                               ifname, sizeof ifname, queues > 1, errp);
             if (fd == -1) {
-                return -1;
+                goto fail;
             }
 
             if (queues > 1 && i == 0 && !tap->ifname) {
                 if (tap_fd_get_ifname(fd, ifname)) {
                     error_setg(errp, "Fail to get ifname");
-                    close(fd);
-                    return -1;
+                    goto fail;
                 }
             }
 
@@ -1004,13 +979,28 @@ free_fail:
                                   i >= 1 ? NULL : script,
                                   i >= 1 ? NULL : downscript,
                                   tap->vhostfd, vnet_hdr, fd, errp)) {
-                close(fd);
-                return -1;
+                goto fail;
             }
         }
     }
 
     return 0;
+
+fail:
+    close(fd);
+    if (vhost_fds) {
+        for (i = 0; i < nvhosts; i++) {
+            g_free(vhost_fds[i]);
+        }
+        g_free(vhost_fds);
+    }
+    if (fds) {
+        for (i = 0; i < nfds; i++) {
+            g_free(fds[i]);
+        }
+        g_free(fds);
+    }
+    return -1;
 }
 
 int tap_enable(NetClientState *nc)
-- 
2.54.0


