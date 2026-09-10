Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1885C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4o5A-00043y-SC; Thu, 10 Sep 2026 19:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lW3-0006SV-2y
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lVh-0004hg-Fs
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pzQMAUIV8a8b91Vm/oUOdfGDZskrETDwBh/Nv2MWtB8=;
 b=U/e4hcTTkpym+2k5X/3fRId2p40noSu3WKiTC0BU9G+WbpfLD/DMnBllHqtS2K8SR+6eZr
 wg6jMLDyOsbXsKLNcsmV6vECRQ/D92/sqg733hrSUHkrd8J8MjWJ/sXsa/Wmyzbja40+oE
 9VSKLusPyCLQn6Rvvormd2xO3HGuCTY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-8-MuRIUwOuKcG3ZLw_3mbQ-1; Thu, 10 Sep 2026 16:12:19 -0400
X-MC-Unique: 8-MuRIUwOuKcG3ZLw_3mbQ-1
X-Mimecast-MFC-AGG-ID: 8-MuRIUwOuKcG3ZLw_3mbQ_1789071138
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-486e9338393so71576f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071138; x=1789675938; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pzQMAUIV8a8b91Vm/oUOdfGDZskrETDwBh/Nv2MWtB8=;
 b=Cq90e/vtKNZ97AnecRxqGClTWWH0lUrP1Aeg4y8cVmNE4iLdoZxVFZhpqK2jNil7Il
 WpIsrd5eMBGdaGBtaVD6CEs4XaAzyrnnj+AVRQbljODbaoW0SNKjqxYAWSNlrVDvOLNg
 1Zs38NWEksU3rOiCAxa2X8wn3YQQzUIpiRzd3wIvdvQiiQA17dRTfaTJIqhRTDYjyr4W
 LuUjFRuEspBHj8sAv4iV8U/E8qmIOHZictquclGnY5ajjBe8nrqQfBPahp74ZEQ1mfDt
 EcioIPMXnab3rhoyTWV8yHc+cDoEAi9AY1qbTuEUZCH8X6hYjnamGkzQq4hsTBiaBhEE
 asNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071138; x=1789675938;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pzQMAUIV8a8b91Vm/oUOdfGDZskrETDwBh/Nv2MWtB8=;
 b=HFtKnHqDt/76rXroSbudf7dQa/G4caQSH2JryGQMyy6UK5+s0MEOaz6M5DBRmp/ayY
 NlAq+4ycuVb5Sb2GflhlwB1xZEzfwl8ihGGKPCVZFrndyxxHUqCx9C2xvNk4I77qMcVg
 BCWYwQQPox3va14LT1+krnwqmmVnzSnIguaYHkltVyLC6pnH4jWfMjG0xj+32HiltUV+
 IoZ4DcXE5uRrtc7cGBNx2q6yCm2k9ftftKrQusYclLEudnxkhcXQPJkM3vFave2gXdE1
 NZpsEB1degPZoS6IE9jW+BGk6PJujwH7qg1oEZspV8b4jHRSdXYoLfSYoDH4oE2D5Maa
 fNHQ==
X-Gm-Message-State: AFuF++lkXskuB/c9t+L9JgSt0u3Y3wGgEqJFdWZlfHfyTy90XLxZfBR/
 qCEx+cdthiwuuT1KyFqa68k5NoI64lcpoRn5h/XvkEWLWN8EN1pVNk3NnkQ+ORGEluIetLGW1I0
 Q3jrqM/+ue2H6OshtP8SjQcxHR3nGzsfZgjuHlfN06Ze/7sN7L5LB49O2nyvPEoRt+eeAMrVPPm
 MEidaM2hNl0jBscMrzgDf7HiIgs+ZAzpubmA==
X-Gm-Gg: AYBFou1LwLsxrjrqFTzgR3FQ27LgQyOdH1P/jyXnM6qUIkJQ0fOCOuGhfQgk87eS6eK
 /TcHaj5BfsORkf+G0DgFqwF9vyqIBlvWg9com+If8ADjES2mNCLuXIQv7DSNmECYj7n5fnpjxRb
 psrtlD/k1VE2kxWKhP3YkPTRrpTEUJPCtxyUK2if3toOVtVP0InQgqCJHGazyRSey42ePJT6ETx
 s75hMsO/z++1b0IPu17aRo2XuGuFHRvRaNVPBLmwmMTToaOsCd74nwWCETc9YZQmg8I7656stan
 ImKIbMwG29SSfEGfNurM3IJTIFz/OQ4eMEx9aMaPpqZh6KAhwhZRsHGoWrf4vphB2Jpwkhwq98B
 eQ6AYS/+HQvrOEaiUSkeXWTo=
X-Received: by 2002:a05:6000:1cc9:b0:485:8a46:b3c6 with SMTP id
 ffacd0b85a97d-486eb3395e0mr480895f8f.46.1789071137755; 
 Thu, 10 Sep 2026 13:12:17 -0700 (PDT)
X-Received: by 2002:a05:6000:1cc9:b0:485:8a46:b3c6 with SMTP id
 ffacd0b85a97d-486eb3395e0mr480857f8f.46.1789071137168; 
 Thu, 10 Sep 2026 13:12:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm843320f8f.9.2026.09.10.13.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:16 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PULL 22/90] net/tap: move vhost-net open() calls to
 tap_parse_vhost_fds()
Message-ID: <b5ee1ede952d139595e519e14a706319684950dd.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
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


