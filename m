Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61896C88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x92-00024g-Og; Fri, 11 Sep 2026 05:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8w-0001yF-NN
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8u-000860-Sn
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hZQoGnwsXrICqagpiwSzGmzqnz5JLACVM0aRzU+Os8Y=;
 b=Bp/witqGEwjpULH8QBPREQNBj2+OIzIloTe516VgGmiynXktdk5/xfIcqy5K2pvlmSvBJk
 3dj3IX4k2o6xNPsE7k6jBUt9dLYsbEGwgxUep9qQ59lbuqpCpqb47LJ9oHBpkfwQSgQEFy
 QNP7xrn4fgLeIFbaHUVAF3PfoEqyqOA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-Gui_1bLOMjKIfq-YkzfyKw-1; Fri, 11 Sep 2026 05:01:54 -0400
X-MC-Unique: Gui_1bLOMjKIfq-YkzfyKw-1
X-Mimecast-MFC-AGG-ID: Gui_1bLOMjKIfq-YkzfyKw_1789117313
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4855e47d062so350851f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117313; x=1789722113; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hZQoGnwsXrICqagpiwSzGmzqnz5JLACVM0aRzU+Os8Y=;
 b=QGgylghYTaK9dbyrIP58nBVrpInrgSlx2ax/s1En8asJV2JnrKxfdmNGrZsUeqX74y
 TkolHYfX84nESSuTUOHxlEUY95KX/3PWLgHVn2uqpqu7xA4kEZ7KRUKV1km94ExIdtma
 I4ShZVSI+aJ7EN+n83Jw3uNttjzGQbTuD+ku73Ncm+uLtFE4uLk6iaSuGAvaSrZK8yuJ
 wtrQflmwf4kxu5fbar1wmZ/Y1qwcdeyPMDDw1Erzhoy1PIVKOXXFGNXcmjpUVsmeD8Us
 dRCH+61xRuEDYg4BmL7FpVxJSEe/b+eTTiQNc3of6R7GFvAY3QuBXXbjEa+OynNKg7Mh
 IXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117313; x=1789722113;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hZQoGnwsXrICqagpiwSzGmzqnz5JLACVM0aRzU+Os8Y=;
 b=V/95E4Y+aVcX2SxBuaAghEX4J9TyHccOKrIEX65YF1gToONwkywh1GxaEt5nY6WrzE
 CMLuNS6TpEIPi3mMJdTb/196rKUKIsVbNowtqGdYpMxv27yYryz24wU+XQ//DZHcfqc2
 ZJFsIF8b+qMaBPE/uiaIIqWz7GQsruZYOjgXStsAY6KewkMm4GOwV6Hn2EIKM+2GqUM4
 VN40cLCgchLDUG6AmCfdKpNFFGTq/T6KjTEIDSxOaMeGw64gSBuLDiPXUOpfGxoYC7tu
 ZNEOh2NpESjm/xWMIiAcSpvpmFZdNB5Jb3B9MGeszcUE02bZm1u9MZO+v+aZrLdAaXco
 sC3A==
X-Gm-Message-State: AFuF++m6gCnyeURFago1+FdcZDFMFWJsFSD5ITdJLBAaR8oDonu8zohj
 8ka6q8dGp6lfeLu9BLFQZ+gOIdMeYsWFZiWabpUNztawn41A+H4WB9JGv1+exfflQOKOgp8IOvm
 /LXvIMe9z8mXXWkOKwinwQ2FbnoGHucRBPv/eBZzZyj5lFtYMvWA6moLFDOuqhZp+dCYumlyJjj
 Eqz+OYTLC2NF2+oUoSzxelLlD15Z3MlpMkSw==
X-Gm-Gg: AYBFou1u0q17JzdojloCx4UU55IpU5/lMsDFjPzMZpE2+J/WZBQQv64rQPdHtkOF527
 HsmQTvAIWfgXEXrRrgKdy3Cq5eN2hAe5UE7F+usY7fTnF4wE9LBaq+gqMMaVmo61BcQXutYHL9k
 ANJKYU1t6z3hWov6+4BlYyQEeJBIT6+LGUNjn5/8Fo1kuehPAUHW8uNragGnoPYD0U+xER3Fz5f
 ZRKfVEFzQdNiHVV1/l9XH7XJm+eeIk9oqRLHnofGGDGLRAemwfmMoS/o+UAYzetsCEZ5rvYVqwX
 Q5cvLLMfvQMcKBioXkEZKSNWG0A3l+9sfUW1pQJRy+T4sqKN6pOGZHBgVsQbiBzC/RWrDnFbgfT
 MdTg9g4mg
X-Received: by 2002:a05:6000:4b0c:b0:486:ecc0:b77a with SMTP id
 ffacd0b85a97d-486ecc0b879mr3086361f8f.3.1789117312434; 
 Fri, 11 Sep 2026 02:01:52 -0700 (PDT)
X-Received: by 2002:a05:6000:4b0c:b0:486:ecc0:b77a with SMTP id
 ffacd0b85a97d-486ecc0b879mr3086285f8f.3.1789117311612; 
 Fri, 11 Sep 2026 02:01:51 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ee5csm4530004f8f.20.2026.09.11.02.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:01:49 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowangio@gmail.com>
Subject: [PULL v2 13/75] net/tap: move vhost initialization to
 tap_setup_vhost()
Message-ID: <69036a8554924548235ca4e85cb11551346aef9f.1789117222.git.mst@redhat.com>
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


