Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E392CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryX2-0007gX-S6; Wed, 03 Apr 2024 07:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWw-0007b9-UK
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:48 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWv-0007LO-9D
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:46 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-369e8d588bfso5421705ab.3
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142704; x=1712747504;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bs9/gC6mUVYOY+Jx84jn4xmGiO1E5P8MHNmgW3YHydw=;
 b=hUV/dNJej9iOZhnafXrp/rQaWHQQhOjPYHgemgDB+ZBhVf0KB7pDcMa7Yau3ojE2NS
 QbhGxd1fbeViDOC2zCPf8zQWpAKVTGeNDZkdpTbyfRICM1VeWwKNc5KaZ/8ykv/SauEV
 KzqjC2DT/7mXAk362VOUo7XHXWcelDjOTS/a396rA1u2IGD/jTCXPibbP4X1ul/wAOIc
 B0tdPcFDlaTGtS5bJF4Q9PPwx+zbVMQNQrNrplrR1X2I1jbNpisb/QWT+UFuDOky8kWN
 J+1xfPWAwvzPLPNv2fSrKULGHBOQPkrfcWId0Fg1x3zTYuegY0ZpCCqODHm0HEhln/se
 PhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142704; x=1712747504;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bs9/gC6mUVYOY+Jx84jn4xmGiO1E5P8MHNmgW3YHydw=;
 b=ZLfrcytcWD68reBGcZIpWVuyYbkhM72itSEkalTOUige5sen08BdTeHRR095A9crqM
 Qn3PpWQ5LlCpJ4TTTpbFiuDbWbgljOteO4TJZf4x7GkbtJ7JfUXKm6pRwcW2TnVLLkqN
 wED/La0j0EnoDijLVAQ8mWvwxltxvJ3lqsar8vPIhKExI+vC1HY5kgUOVZloRZ5ySRbI
 WmL6HDMCMqvK8eKE2yfiM1qrF0cOvYMiCecnWQoyYJRgDWjHXHIkqfO1oklcAdpJOE5x
 +VdocYJOCHF8tO6A6TxvBRX4ygTSwEr8e+FTGPedVMiPB8HXzo0iufjztmZUeqj+RIyx
 UY6Q==
X-Gm-Message-State: AOJu0Yz73SiIet0kDZw6zg9n/hrIDWKIwTuTWSAKCxfoUUntOPF+30J0
 tI2/SWSkwGHU01qlPbG1iNwMACfolSahjuSgflQoHJsWJ5IykDCqiSyEDrHzamk=
X-Google-Smtp-Source: AGHT+IEnlZQrj01p5380OhsZ9Us6muJ/rG+f4xcCIhpViXqtuNLa0nSzmn2vQmFubI0yBK6oO73flw==
X-Received: by 2002:a05:6e02:156a:b0:368:8d92:3253 with SMTP id
 k10-20020a056e02156a00b003688d923253mr2669819ilu.23.1712142704252; 
 Wed, 03 Apr 2024 04:11:44 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 h38-20020a63f926000000b005f072084432sm11160453pgi.38.2024.04.03.04.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:11:44 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 03 Apr 2024 20:11:00 +0900
Subject: [PATCH v9 12/20] virtio-net: Unify the logic to update NIC state
 for RSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rss-v9-12-c6d87e69d38b@daynix.com>
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
In-Reply-To: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::12e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x12e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

The code to attach or detach the eBPF program to RSS were duplicated so
unify them into one function to save some code.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 90 +++++++++++++++++++++--------------------------------
 1 file changed, 36 insertions(+), 54 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 1ac9c06f6865..61b49e335dea 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1232,18 +1232,6 @@ static int virtio_net_handle_announce(VirtIONet *n, uint8_t cmd,
     }
 }
 
-static void virtio_net_detach_epbf_rss(VirtIONet *n);
-
-static void virtio_net_disable_rss(VirtIONet *n)
-{
-    if (n->rss_data.enabled) {
-        trace_virtio_net_rss_disable();
-    }
-    n->rss_data.enabled = false;
-
-    virtio_net_detach_epbf_rss(n);
-}
-
 static bool virtio_net_attach_ebpf_to_backend(NICState *nic, int prog_fd)
 {
     NetClientState *nc = qemu_get_peer(qemu_get_queue(nic), 0);
@@ -1291,6 +1279,40 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
     virtio_net_attach_ebpf_to_backend(n->nic, -1);
 }
 
+static void virtio_net_commit_rss_config(VirtIONet *n)
+{
+    if (n->rss_data.enabled) {
+        n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
+        if (n->rss_data.populate_hash) {
+            virtio_net_detach_epbf_rss(n);
+        } else if (!virtio_net_attach_epbf_rss(n)) {
+            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
+                warn_report("Can't load eBPF RSS for vhost");
+            } else {
+                warn_report("Can't load eBPF RSS - fallback to software RSS");
+                n->rss_data.enabled_software_rss = true;
+            }
+        }
+
+        trace_virtio_net_rss_enable(n->rss_data.hash_types,
+                                    n->rss_data.indirections_len,
+                                    sizeof(n->rss_data.key));
+    } else {
+        virtio_net_detach_epbf_rss(n);
+        trace_virtio_net_rss_disable();
+    }
+}
+
+static void virtio_net_disable_rss(VirtIONet *n)
+{
+    if (!n->rss_data.enabled) {
+        return;
+    }
+
+    n->rss_data.enabled = false;
+    virtio_net_commit_rss_config(n);
+}
+
 static bool virtio_net_load_ebpf_fds(VirtIONet *n)
 {
     int fds[EBPF_RSS_MAX_FDS] = { [0 ... EBPF_RSS_MAX_FDS - 1] = -1};
@@ -1455,28 +1477,7 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         goto error;
     }
     n->rss_data.enabled = true;
-
-    if (!n->rss_data.populate_hash) {
-        if (!virtio_net_attach_epbf_rss(n)) {
-            /* EBPF must be loaded for vhost */
-            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
-                warn_report("Can't load eBPF RSS for vhost");
-                goto error;
-            }
-            /* fallback to software RSS */
-            warn_report("Can't load eBPF RSS - fallback to software RSS");
-            n->rss_data.enabled_software_rss = true;
-        }
-    } else {
-        /* use software RSS for hash populating */
-        /* and detach eBPF if was loaded before */
-        virtio_net_detach_epbf_rss(n);
-        n->rss_data.enabled_software_rss = true;
-    }
-
-    trace_virtio_net_rss_enable(n->rss_data.hash_types,
-                                n->rss_data.indirections_len,
-                                temp.b);
+    virtio_net_commit_rss_config(n);
     return queue_pairs;
 error:
     trace_virtio_net_rss_error(err_msg, err_value);
@@ -3092,26 +3093,7 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
         }
     }
 
-    if (n->rss_data.enabled) {
-        n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
-        if (!n->rss_data.populate_hash) {
-            if (!virtio_net_attach_epbf_rss(n)) {
-                if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
-                    warn_report("Can't post-load eBPF RSS for vhost");
-                } else {
-                    warn_report("Can't post-load eBPF RSS - "
-                                "fallback to software RSS");
-                    n->rss_data.enabled_software_rss = true;
-                }
-            }
-        }
-
-        trace_virtio_net_rss_enable(n->rss_data.hash_types,
-                                    n->rss_data.indirections_len,
-                                    sizeof(n->rss_data.key));
-    } else {
-        trace_virtio_net_rss_disable();
-    }
+    virtio_net_commit_rss_config(n);
     return 0;
 }
 

-- 
2.44.0


