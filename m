Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F5DC88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4lwz-0004ie-5M; Thu, 10 Sep 2026 17:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lFY-0000YX-2X
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lFN-0007J2-Hh
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hZQoGnwsXrICqagpiwSzGmzqnz5JLACVM0aRzU+Os8Y=;
 b=JnUYXMiuTTRToQMS6Lc7Uy8SMfDpUikNyvZqGFSNxbzwpuGAry6QBcxTU4Rdr6N/czOosG
 T/RqHVZ1WUqmF3NAVeL0Pl4VEvWQ6BjEym+jE7ccIjJDZT/TrAG5uSpnHStCHF9a0E3MXh
 3VfA1sAMYpbR7ZotSKkJMTRdu1DVeLw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-uLCNIWTwP3i7H-OUr3ZmcQ-1; Thu, 10 Sep 2026 16:12:22 -0400
X-MC-Unique: uLCNIWTwP3i7H-OUr3ZmcQ-1
X-Mimecast-MFC-AGG-ID: uLCNIWTwP3i7H-OUr3ZmcQ_1789071141
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-484362cb000so118971f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071141; x=1789675941; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hZQoGnwsXrICqagpiwSzGmzqnz5JLACVM0aRzU+Os8Y=;
 b=gWy5ml5Odz1nGvLURfrJzVpZaaWpqaLMs+l5xNVPvpMHf0mW9ZA2S87vywsqu083ui
 NYiY5pzm2qJglv1C0cZeuNshpRFPS9DRJGU0fMC48sMWonqb34SC79SbdHiOiUShdwKC
 0mutoNezYiO4vOFBb97pntU/W7q5oE5gTw5NuRVwX6CuqZ/gzq1g8Df3G/7QAJlXHccG
 FTkHlyyRNxHZXEg0cidJpq9BZfSpOGwrYuq6pJDZ5vIwFnlece907pKzS8qkdRbKQtdb
 n8FuKoIGWJdH2Ts31m6oO3aMqZy57LQP431NAs5ffQXq736czdBbofsgOXOC2OrIJoJe
 J0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071141; x=1789675941;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hZQoGnwsXrICqagpiwSzGmzqnz5JLACVM0aRzU+Os8Y=;
 b=ZQ8SxlgNXUKNo7x7pc4DdhMCf2XhgcGyZAm4AxU7/CsDCckeuWAT0vtH+lahUaI+18
 npQesGMsINq99KBrR4tPuvCp//0k3wO2uCnHvlHSIrER7HVgYKpWuEbkbo0s2Xu/Ijrr
 4FpU8xN+FisObryYSNWsLMgI1GuepPFvuMuLZXBOgDBukbfQjtLYITnORY173bGeRc5i
 ASwRH3lhPPRVQkZVO+n8FRFW+6L8u48hDY80zgW3iPxunaZzz+wDuBzZjyeiAxfVYpVs
 NvjpvcJfZ7IzMQaS97vas125vrDrwbRmVuCXLaKpm+ltt4/ZK3TRZlEYiGWtCSx91rC/
 QMhg==
X-Gm-Message-State: AFuF++nsJfwAMfBFcXnZhxEak9asQHvIf0LmcFvO8fjgkftfnbaPbLX+
 ssQqkLVKip+5dWLGJzfaw/i4StyPhW4fpPK+DZ3RKFi8yKEZZ/EDD6KZaYimtYYAotkXl5e6Btf
 pTwScOLhu6uPdBD8eiS4bfzeD5XuqTxuUue4NwL5ceu0Yn7vl2LtDg3Vvr6JAznhPbIhQsfX6sR
 9KZZOgEmfW57KlpF2RFHbIXiiPPOXmZgE3FQ==
X-Gm-Gg: AYBFou0IDLw0gDh4kAN/y21TJk7s2b+01KKJTM4bHkMkj8Q2EROB4VrbjTlT6EaTtEH
 vNsxhmg4sbbAet68wQyKJCxagtWejsoi5VGDgoDJBouVs9/sz9P3UIzfH643u+7yJkIZ7OycoMW
 1Iui3DybEInQkYfoLwWBaATA8rdA7LP9eb4dWRfZ9GUM/F/LRR0fTg/fMT1xNviAupX4us8uGZ+
 oY0DqIbPSCuUbFiVv++63ZwVvV2GAHRVmlZpn1WqhV8Pb79AI3x+44SMxMV+r+JExXt842HBTPw
 A+2PXxEewp9Jhl4ZMlEy9u8Gc9q8hiV5hDX++aTXVHwJMpAJx/jYPoN/+/e1qp+3Mn5ip61f11l
 pFXRxJlAlrmZ+2BQT3gdm/xY=
X-Received: by 2002:a05:6000:2082:b0:484:482d:dce4 with SMTP id
 ffacd0b85a97d-486e91e4c97mr1443183f8f.0.1789071141436; 
 Thu, 10 Sep 2026 13:12:21 -0700 (PDT)
X-Received: by 2002:a05:6000:2082:b0:484:482d:dce4 with SMTP id
 ffacd0b85a97d-486e91e4c97mr1443142f8f.0.1789071140901; 
 Thu, 10 Sep 2026 13:12:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32d3c7sm753668f8f.10.2026.09.10.13.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:18 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PULL 23/90] net/tap: move vhost initialization to tap_setup_vhost()
Message-ID: <e0b150d65e80c3f836e4c7669cc0f1b32dc92d5d.1789071042.git.mst@redhat.com>
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

Make a new helper function in a way it can be reused later for
TAP fd-migration feature: we'll need to initialize vhost in a later
point when we doesn't have access to QAPI parameters.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Based-on: <20260318113144.15697-1-vsementsov@yandex-team.ru>
Based-on: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-6-vsementsov@yandex-team.ru>
---
 net/tap.c | 62 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index bec2cd48fd..f2b571dd11 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -71,6 +71,8 @@ static const int kernel_feature_bits[] = {
 typedef struct TAPState {
     NetClientState nc;
     int fd;
+    int vhostfd;
+    uint32_t vhost_busyloop_timeout;
     char down_script[1024];
     char down_script_arg[128];
     uint8_t buf[NET_BUFSIZE];
@@ -722,6 +724,38 @@ static int net_tap_init(const NetdevTapOptions *tap, int *vnet_hdr,
     return fd;
 }
 
+static bool tap_setup_vhost(TAPState *s, Error **errp)
+{
+    VhostNetOptions options;
+
+    if (s->vhostfd == -1) {
+        return true;
+    }
+
+    options.backend_type = VHOST_BACKEND_TYPE_KERNEL;
+    options.net_backend = &s->nc;
+    options.busyloop_timeout = s->vhost_busyloop_timeout;
+    options.opaque = (void *)(uintptr_t)s->vhostfd;
+    options.nvqs = 2;
+    options.feature_bits = kernel_feature_bits;
+    options.get_acked_features = NULL;
+    options.save_acked_features = NULL;
+    options.max_tx_queue_size = 0;
+    options.is_vhost_user = false;
+
+    s->vhost_net = vhost_net_init(&options);
+    if (!s->vhost_net) {
+        error_setg(errp,
+                   "vhost-net requested but could not be initialized");
+        return false;
+    }
+
+    /* vhostfd ownership is passed to s->vhost_net */
+    s->vhostfd = -1;
+
+    return true;
+}
+
 static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
                              const char *name,
                              const char *ifname, const char *script,
@@ -756,30 +790,10 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         }
     }
 
-    if (vhostfd != -1) {
-        VhostNetOptions options;
-
-        options.backend_type = VHOST_BACKEND_TYPE_KERNEL;
-        options.net_backend = &s->nc;
-        if (tap->has_poll_us) {
-            options.busyloop_timeout = tap->poll_us;
-        } else {
-            options.busyloop_timeout = 0;
-        }
-        options.opaque = (void *)(uintptr_t)vhostfd;
-        options.nvqs = 2;
-        options.feature_bits = kernel_feature_bits;
-        options.get_acked_features = NULL;
-        options.save_acked_features = NULL;
-        options.max_tx_queue_size = 0;
-        options.is_vhost_user = false;
-
-        s->vhost_net = vhost_net_init(&options);
-        if (!s->vhost_net) {
-            error_setg(errp,
-                       "vhost-net requested but could not be initialized");
-            goto failed;
-        }
+    s->vhostfd = vhostfd;
+    s->vhost_busyloop_timeout = tap->has_poll_us ? tap->poll_us : 0;
+    if (!tap_setup_vhost(s, errp)) {
+        return false;
     }
 
     return true;
-- 
MST


