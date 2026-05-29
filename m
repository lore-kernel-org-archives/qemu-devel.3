Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F49CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpIB-0005fu-OF; Fri, 29 May 2026 00:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIA-0005fW-CR
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:57:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpI8-00085s-FV
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AEzVLZ1GXyHFH+/ory9dQMaz4t7ZvXxDRG8tjc701tI=;
 b=W0Ckw56FfQVwPgkdBPdOl/PTs6OecYK6+MxGmvW2Ud4OH0dNAmrFvjsLNpC4NJuXIjbg2G
 h52u5Q6S66UrJwwfyCY6eoZz2UQypJp96O7Tr6rDlteZkOtbAKNWES7/D2KVzYVc0QqL5L
 qtn7s8f4MKuqFLbY5OiG4Rc3hHNtOY8=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-5Qe6gaVHPWyF2OaLasoRjQ-1; Fri, 29 May 2026 00:57:49 -0400
X-MC-Unique: 5Qe6gaVHPWyF2OaLasoRjQ-1
X-Mimecast-MFC-AGG-ID: 5Qe6gaVHPWyF2OaLasoRjQ_1780030669
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304c652be4eso1431776eec.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030669; x=1780635469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEzVLZ1GXyHFH+/ory9dQMaz4t7ZvXxDRG8tjc701tI=;
 b=AzOjb9ZvwtAytwBHvZAwftOGVSA8Tb+M5gNdCYSoI4sOcWaHG4TeN/NLV6FnKWKEZq
 +En5zKJQpCQ7sAxyYXjVzPknvT6Tmgws3PdGEnT2MDP76NVeQGCMM6tCJCOkFVpD4gm0
 VgiFikZDZrki0n6sEys7JXQtT4ckz0Y+PHF06682IwBkFF4QTOmjLVNu02z15GHu2FyV
 v+je0hn9mhUpf/5rRqOBvfDzWNBfleSVGvq2KvmnL/ZdO4kIY0ArZKVTAxueieS2qVem
 994b52dv3MpMmFqqAHLDHRdwi+9BdNB7W9OoTHWaDHKAgMmBvc2tX64OUUj63/YAwfrN
 NstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030669; x=1780635469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AEzVLZ1GXyHFH+/ory9dQMaz4t7ZvXxDRG8tjc701tI=;
 b=f8xe04muZxUDY9QdROnX7VICHnmV/pkdFCUEKVjKojojRAWCsJeoDxk3Imq1xjZ+Xm
 AOxIoUzLZFg7uMDij6p1zmzO96bq6JgoboeXlJmU20VUW/0fH7LVhbip8J1+kjYTuv/m
 gY23FCF2MppeOWywoGnd3F9hTQlaxYSFN7FvVKL5ujfLFWqHUq04yc5iScMN2RneJleA
 8otZWA445c23ebBi1TmG8KnCq1uIJ5LLKikYcyrgYP3HrfshcYhxbSo9xVb+Rnmpnl5f
 qHCQs7vxaqX4eSreHUxaN5F3rxkWwNWhhvV5ZiMHzjj/XruwZevo+1mzfDOwnNjNdOSN
 BXnQ==
X-Gm-Message-State: AOJu0YzYyLfqFAD5g5a6eMEPaFIyQ+pBKuQzlkPB8CtpPfjBdCXUs6Qn
 iFkHwMqTUWw8Y4xyQErgR3rWICm9SshLsJweyyt+vfFN8njL1a+ZhggEgjkBjwSiYBxO6JPVD1v
 YEU0pGxNUbXunn0m0bf5kWEDibhJHgA+gVeGKZbhCfJEclfak3h+1WZwARqBJl6E7h53GUdz2cs
 GrzIAQ6QfPWzVbUsABnPMLWLcdFC2H22RVD9oRkzcOuxs=
X-Gm-Gg: Acq92OHuWN6mPZ0VXinquqk0m92LzWhAxBaR2jYeZoWOu/S+o7JTQ/ocPvIoSRu1Sm8
 lnX87J4C6fxRetIqkQtMjkJbq7H8DhNkdEqTm1LwRO3uuBQ4Ij3EiK+3P9YpI2hkYf/nAh5CqNc
 L8qCE9XmKkK8M3Ygot6iErjAhEw/JQqejrfXfj+xpCJ3stbtV7qpa/QcZtNB1+WC98qO7BiGvx9
 9GVBFSRaaWIPww6OUBjI6YB1Ok7wwvFEXSLtfnEReel5eV6VIckeCFYdkthrO5BDT5KSg1LN5aq
 Pfa1yqOiLdCOZBCPsgUe9XuC4I+PDHt7p8WHSt8YSz9CB9cOKfRq938tmkole3uTRkJOcLjU7WX
 jp/rWUxEJhUzZvkYixa1piI4Qh+qkhFAf4iIgmTPKm8+IDtgfm+UAHCUg1p+XZ7QjPRVynCKN
X-Received: by 2002:a05:7022:f411:b0:12c:9037:5126 with SMTP id
 a92af1059eb24-137ae515e54mr462274c88.9.1780030668703; 
 Thu, 28 May 2026 21:57:48 -0700 (PDT)
X-Received: by 2002:a05:7022:f411:b0:12c:9037:5126 with SMTP id
 a92af1059eb24-137ae515e54mr462262c88.9.1780030667983; 
 Thu, 28 May 2026 21:57:47 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.57.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:57:47 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 02/15] net/tap: net_init_tap_one(): add return value
Date: Fri, 29 May 2026 12:57:17 +0800
Message-ID: <20260529045730.90322-3-jasowang@redhat.com>
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

Follow common recommendations in include/qapi/error.h of having
a return value together with errp. This allows to avoid error propagation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 8d7ab6ba6f..a389aec218 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -703,7 +703,7 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
 
 #define MAX_TAP_QUEUES 1024
 
-static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
+static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *model, const char *name,
                              const char *ifname, const char *script,
                              const char *downscript, const char *vhostfdname,
@@ -783,10 +783,11 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
     }
 
-    return;
+    return true;
 
 failed:
     qemu_del_net_client(&s->nc);
+    return false;
 }
 
 static int get_fds(char *str, char *fds[], int max)
@@ -821,7 +822,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
     const NetdevTapOptions *tap;
     int fd, vnet_hdr = 0, i = 0, queues;
     /* for the no-fd, no-helper case */
-    Error *err = NULL;
     const char *vhostfdname;
     char ifname[128];
     int ret = 0;
@@ -869,11 +869,9 @@ int net_init_tap(const Netdev *netdev, const char *name,
             return -1;
         }
 
-        net_init_tap_one(tap, peer, "tap", name, NULL,
-                         NULL, NULL,
-                         vhostfdname, vnet_hdr, fd, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!net_init_tap_one(tap, peer, "tap", name, NULL,
+                              NULL, NULL,
+                              vhostfdname, vnet_hdr, fd, errp)) {
             close(fd);
             return -1;
         }
@@ -930,12 +928,10 @@ int net_init_tap(const Netdev *netdev, const char *name,
                 goto free_fail;
             }
 
-            net_init_tap_one(tap, peer, "tap", name, ifname,
-                             NULL, NULL,
-                             tap->vhostfds ? vhost_fds[i] : NULL,
-                             vnet_hdr, fd, &err);
-            if (err) {
-                error_propagate(errp, err);
+            if (!net_init_tap_one(tap, peer, "tap", name, ifname,
+                                  NULL, NULL,
+                                  tap->vhostfds ? vhost_fds[i] : NULL,
+                                  vnet_hdr, fd, errp)) {
                 ret = -1;
                 goto free_fail;
             }
@@ -975,11 +971,9 @@ free_fail:
             return -1;
         }
 
-        net_init_tap_one(tap, peer, "bridge", name, ifname,
-                         NULL, NULL, vhostfdname,
-                         vnet_hdr, fd, &err);
-        if (err) {
-            error_propagate(errp, err);
+        if (!net_init_tap_one(tap, peer, "bridge", name, ifname,
+                              NULL, NULL, vhostfdname,
+                              vnet_hdr, fd, errp)) {
             close(fd);
             return -1;
         }
@@ -1015,12 +1009,10 @@ free_fail:
                 }
             }
 
-            net_init_tap_one(tap, peer, "tap", name, ifname,
-                             i >= 1 ? NULL : script,
-                             i >= 1 ? NULL : downscript,
-                             vhostfdname, vnet_hdr, fd, &err);
-            if (err) {
-                error_propagate(errp, err);
+            if (!net_init_tap_one(tap, peer, "tap", name, ifname,
+                                  i >= 1 ? NULL : script,
+                                  i >= 1 ? NULL : downscript,
+                                  vhostfdname, vnet_hdr, fd, errp)) {
                 close(fd);
                 return -1;
             }
-- 
2.54.0


