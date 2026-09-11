Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FADC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x91-00023N-01; Fri, 11 Sep 2026 05:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8s-0001tN-6A
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8q-00085H-BP
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pzQMAUIV8a8b91Vm/oUOdfGDZskrETDwBh/Nv2MWtB8=;
 b=dK416B9fWLdKznKnoEYZ1tTRHD6p7oe5y6grV9nZNdLSwCBKiRq4Ppipz7p1JG0qw1yz7f
 L0xa0Wt/YN3OdzjlFWCyRVgWUkIfXQKbycbOeN6aepfI2kU21exjZVdOtJNzrrBOd2Y2gs
 dZF3BOp2Lkt89oWwVM5Ph3IBU9mKaZo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-qLeuzqE5Mcad5D2cIA6hUg-1; Fri, 11 Sep 2026 05:01:50 -0400
X-MC-Unique: qLeuzqE5Mcad5D2cIA6hUg-1
X-Mimecast-MFC-AGG-ID: qLeuzqE5Mcad5D2cIA6hUg_1789117309
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6a178080182so733643a12.2
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117309; x=1789722109; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pzQMAUIV8a8b91Vm/oUOdfGDZskrETDwBh/Nv2MWtB8=;
 b=NN3kG0/YtinMhepxxnPiIT71NeMOblez0jstfTQOgXc7g0Je+Fc/8ZlkwsSweGcDs8
 J5At8ndpupO0ZRmvFjKpkpU1s/pU4OUbX8PiajRDJMk2vr0FOwV1mk5K2JMNkFmcQklJ
 evJxBGGNRTpjQH+eJUSbFtJXrY8gRQv8nM38FZWTHwTsUUMZ+XqaUYK1smqUct2+OVHk
 gIaCe6bckgk5sfWWK3nBbKC48J5+HiTKNkqKqvAlnTXJBCLHq/0fmlfnt8YSDTS6UTim
 qE+TrxokaBCxTi/SEa1abANxNWRRuG6qm+qdVq1yPVG3at2X6AlVbuN5cwFhEPaqyG2C
 78fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117309; x=1789722109;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pzQMAUIV8a8b91Vm/oUOdfGDZskrETDwBh/Nv2MWtB8=;
 b=doSCLH0itXGB/2P3kgASfvn3v6UsS0AJYRdrLZOP1SYIOw3BABSmor2r+C4XcvGUDG
 rfAk0OpZg47i96oeeK3akKyCSgNJYo18ekmIEV+nX9EtMMwL8CjNduDYXTvekfPh0T0n
 CuRMk8LvcwWhp4pwcwVuDDED01nYHCxL9krIuGo9Db3zR7ftsl5d0AvyUrGd00L8kqnw
 XBoqZNvbEB61ZD25c8aVWDs3ZMCMMy5hWZtm4SvTB1anxskBqRvk0K//4BCsg0BDTdrr
 KKsK4DBUdzXzAxjovD1pjXFMlbOKfMxRFYjyRTKgSoXcD1PXmYVjBefYDkNc3a21DF6L
 dsew==
X-Gm-Message-State: AFuF++k4Q/32D5RpFG11kI8QfBPnzOgxjGE5bkFqyhJnLdg/uSUkugZP
 shi8EaBb6k/xM7bXlf6uZO2PqT3/sZugN5/cQHBOBINIZydaSWvTH09mEanprA4XNDIUMibolDR
 Mc+/84F97Uhb4Ryu5yJ/CLeoq+33uGHPrwXIlkAeN+D8wryYXBE9WoHmjJaGMTdptP74PWKoSpX
 LhmTYjvZJ17hhB0vKIUnUzpASJghBYzs79XA==
X-Gm-Gg: AYBFou3tpXHIA8HcyPTwWkiNVbYXat4qqkdP50VdUr4uKcuyTgv8MWmJsRsJqX8+a3Y
 p9Os27J5wJc1Mu3bHDeRqu72AYFp/T4hJkm7zqItNv/NJHPhNspxG5gMqcr7MnB9RwFHoz3Og0J
 2RhsailODxWnD13Y9KiPV9+Eve6/1C5XQLU1OGkrGGcZguj7q0qJnO8fxox6Y4sctgCMNDcI3rZ
 uoV4SP7ttZgJD6K4tobAuk1biUwHZKnZXTPP7AvL3k+p+RdX3KtNrHx73oeXk9sWpLhHL/psyoS
 lB6RrT3X+gZpWduPhvyxm3zt9Z2plI8z7WHFnegvUwvvCLlkjBt0S+kS+F8sPj9gQ+UwLiRyN8l
 Cb/bqYILrSeWPZxazHycvoRo=
X-Received: by 2002:a05:6402:21cd:b0:6a8:372:edbd with SMTP id
 4fb4d7f45d1cf-6a9b56264e9mr1102647a12.10.1789117308595; 
 Fri, 11 Sep 2026 02:01:48 -0700 (PDT)
X-Received: by 2002:a05:6402:21cd:b0:6a8:372:edbd with SMTP id
 4fb4d7f45d1cf-6a9b56264e9mr1102608a12.10.1789117307945; 
 Fri, 11 Sep 2026 02:01:47 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a9b5964c7asm570305a12.30.2026.09.11.02.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:01:47 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PULL v2 12/75] net/tap: move vhost-net open() calls to
 tap_parse_vhost_fds()
Message-ID: <31ce34c2366741dd387631a2688fbd83bed5f627.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

1. Simplify code path: get vhostfds for all cases in one function.

2. Prepare for further tap-fd-migraton feature, when we'll need to
postpone vhost initialization up to post-load stage.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Based-on: <20260318113144.15697-1-vsementsov@yandex-team.ru>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-5-vsementsov@yandex-team.ru>
---
 net/tap.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index f4051e8d4b..bec2cd48fd 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -756,8 +756,7 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
     }
 
-    if (tap->has_vhost ? tap->vhost :
-        (vhostfd != -1) || (tap->has_vhostforce && tap->vhostforce)) {
+    if (vhostfd != -1) {
         VhostNetOptions options;
 
         options.backend_type = VHOST_BACKEND_TYPE_KERNEL;
@@ -767,17 +766,6 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         } else {
             options.busyloop_timeout = 0;
         }
-
-        if (vhostfd == -1) {
-            vhostfd = open("/dev/vhost-net", O_RDWR);
-            if (vhostfd < 0) {
-                error_setg_file_open(errp, errno, "/dev/vhost-net");
-                goto failed;
-            }
-            if (!qemu_set_blocking(vhostfd, false, errp)) {
-                goto failed;
-            }
-        }
         options.opaque = (void *)(uintptr_t)vhostfd;
         options.nvqs = 2;
         options.feature_bits = kernel_feature_bits;
@@ -863,14 +851,31 @@ static int tap_parse_fds_and_queues(const NetdevTapOptions *tap, int **fds,
 static bool tap_parse_vhost_fds(const NetdevTapOptions *tap, int **vhost_fds,
                                 int queues, Error **errp)
 {
-    if (!(tap->vhostfd || tap->vhostfds)) {
+    bool need_vhost = tap->has_vhost ? tap->vhost :
+        ((tap->vhostfd || tap->vhostfds) ||
+         (tap->has_vhostforce && tap->vhostforce));
+
+    if (!need_vhost) {
         *vhost_fds = NULL;
         return true;
     }
 
-    if (net_parse_fds(tap->vhostfd ?: tap->vhostfds,
-                      vhost_fds, queues, errp) < 0) {
-        return false;
+    if (tap->vhostfd || tap->vhostfds) {
+        if (net_parse_fds(tap->vhostfd ?: tap->vhostfds,
+                          vhost_fds, queues, errp) < 0) {
+            return false;
+        }
+    } else {
+        *vhost_fds = g_new(int, queues);
+        for (int i = 0; i < queues; i++) {
+            int vhostfd = open("/dev/vhost-net", O_RDWR);
+            if (vhostfd < 0) {
+                error_setg_file_open(errp, errno, "/dev/vhost-net");
+                net_free_fds(*vhost_fds, i);
+                return false;
+            }
+            (*vhost_fds)[i] = vhostfd;
+        }
     }
 
     if (!unblock_fds(*vhost_fds, queues, errp)) {
-- 
MST


