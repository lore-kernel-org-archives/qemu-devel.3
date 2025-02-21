Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2DDC021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS3N-0004Qi-9k; Fri, 21 Feb 2025 07:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3G-0004Pg-3W
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:22:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3E-0006zB-8C
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hoj9zHkQc68Myno7gmXyzMQyAEjnKBSFykdtmN9gSKo=;
 b=bhZCsDbXKJ2ZjOLk7KJidBIN+KlLOACNA4mPd2x+jZFfD7oHNi85CcwDNkMApnFasSFhY7
 HdnSTaRnMPjLb8Uf39zB2D9mH0SnM5ZBi3HFFi3KmbP1SlwxK1bSQevK/DGUJcMr9tdP7L
 abGqPdOn2nVjO0cn9SYsMNJKBJ6/jgI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Bl5B60hUMK-I2o09nWKg5Q-1; Fri, 21 Feb 2025 07:22:37 -0500
X-MC-Unique: Bl5B60hUMK-I2o09nWKg5Q-1
X-Mimecast-MFC-AGG-ID: Bl5B60hUMK-I2o09nWKg5Q_1740140556
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f628ff78eso1073025f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:22:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140555; x=1740745355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoj9zHkQc68Myno7gmXyzMQyAEjnKBSFykdtmN9gSKo=;
 b=BaTyJdA37j0aCMHpZMnFzhQU0saGadyXERRzIinWN4ZvHP735D4ekOgzXqKlO3/JwD
 xgxbW2c7o0QtkEI9+Wu7BYifM+TMj7tbCBCbYrKTATpiwBGGRgkZ5iChARnxUY8JGA05
 YVdEpjXw2X9OQI3IiM+aUs3QywzOMyJwo7JCY8hbvHM1Is80oTtxVmVadK8MgDMhCli+
 mkGkcRV6IJw2V5DpcW6sbkUkRFl5CNCMJz5ycCU8Yx170SwyaUwnJaP9bP4Vq8WT45HK
 CWtqFVg3ejSJFJuKtvfAEjEbNh6iR2HgS1DM0S0aiCwKxcNE/CZpQODB1pO3E8ABGNpZ
 XJgQ==
X-Gm-Message-State: AOJu0Yz+NfjpGVxGQylLEQ+/p+Q15H5Re0yatMj1iO7D0/RdUjv7otxH
 OO7R0+3EmCzJj4cPjbr0rhbhNdwqToyRk98IOwNtl/SEQ25cJtoyRpor7IRtPV8KP5l8YRy2to9
 EwId9tRqqiDXYVNAl6DSshoZmAS+BAs94570ZEhax3qJ20N2rH0DD0y/bD9mHj8VJH9fTlgeNbX
 VyilJ7LRRusnF3wGnaLyCImBcF8E5bBw==
X-Gm-Gg: ASbGnctK86j5zQuaihmzrlkbeaoc+nbE3tDoN24/G83ZSLxfwq9LjXlGWAah+MVvhzz
 Pw1AWj8tacJDA8IKNWEpgRs5o/qo36bMAv5jIvFEeLyOjI3jd1mOF6cfDVZW6SsiaFDzI+pWrRO
 V9Ni07pIBYurb1PHnHX1Jj4j+kV/mhhjrP0km/87wxddK1ayiSXHiCZ3QNgpQ5Q9J1JK8VkBZan
 VRT+hMjzewtUDErm7EwcUKuduoXnN4a/tVKB21qo9V7a2W8FvgfjheXCXhRJ/AJzmZYZ8SV9Zsn
 xHk2Ew==
X-Received: by 2002:a5d:5f94:0:b0:38f:2b52:f059 with SMTP id
 ffacd0b85a97d-38f61633567mr6317272f8f.27.1740140555456; 
 Fri, 21 Feb 2025 04:22:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC/lDqWS3/xYESMbj44WDsA1JtY2jXIJrcRr3bwF/vaBwluQWd2DmmHE+TCJQ3iIedZgijhA==
X-Received: by 2002:a5d:5f94:0:b0:38f:2b52:f059 with SMTP id
 ffacd0b85a97d-38f61633567mr6317242f8f.27.1740140555036; 
 Fri, 21 Feb 2025 04:22:35 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce65dsm15949635e9.1.2025.02.21.04.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:22:34 -0800 (PST)
Date: Fri, 21 Feb 2025 07:22:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 02/41] hw/net: Fix NULL dereference with software RSS
Message-ID: <bc82af6b0dcb0933e72640851fdd2594f822b23e.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

When an eBPF program cannot be attached, virtio_net_load_ebpf() returns
false, and virtio_net_device_realize() enters the code path to handle
errors because of this, but it causes NULL dereference because no error
is generated.

Change virtio_net_load_ebpf() to return false only when a fatal error
occurred.

Fixes: b5900dff14e5 ("hw/net: report errors from failing to use eBPF RSS FDs")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250116-software-v1-1-9e5161b534d8@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/virtio-net.c | 45 ++++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 85e14b788c..d64941bf8e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1352,18 +1352,25 @@ exit:
 
 static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
 {
-    bool ret = false;
-
-    if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        trace_virtio_net_rss_load(n, n->nr_ebpf_rss_fds, n->ebpf_rss_fds);
-        if (n->ebpf_rss_fds) {
-            ret = virtio_net_load_ebpf_fds(n, errp);
-        } else {
-            ret = ebpf_rss_load(&n->ebpf_rss, errp);
-        }
+    if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
+        return true;
     }
 
-    return ret;
+    trace_virtio_net_rss_load(n, n->nr_ebpf_rss_fds, n->ebpf_rss_fds);
+
+    /*
+     * If user explicitly gave QEMU RSS FDs to use, then
+     * failing to use them must be considered a fatal
+     * error. If no RSS FDs were provided, QEMU is trying
+     * eBPF on a "best effort" basis only, so report a
+     * warning and allow fallback to software RSS.
+     */
+    if (n->ebpf_rss_fds) {
+        return virtio_net_load_ebpf_fds(n, errp);
+    }
+
+    ebpf_rss_load(&n->ebpf_rss, &error_warn);
+    return true;
 }
 
 static void virtio_net_unload_ebpf(VirtIONet *n)
@@ -3913,23 +3920,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     net_rx_pkt_init(&n->rx_pkt);
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        Error *err = NULL;
-        if (!virtio_net_load_ebpf(n, &err)) {
-            /*
-             * If user explicitly gave QEMU RSS FDs to use, then
-             * failing to use them must be considered a fatal
-             * error. If no RSS FDs were provided, QEMU is trying
-             * eBPF on a "best effort" basis only, so report a
-             * warning and allow fallback to software RSS.
-             */
-            if (n->ebpf_rss_fds) {
-                error_propagate(errp, err);
-            } else {
-                warn_report("unable to load eBPF RSS: %s",
-                            error_get_pretty(err));
-                error_free(err);
-            }
-        }
+        virtio_net_load_ebpf(n, errp);
     }
 }
 
-- 
MST


