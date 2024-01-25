Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7CBC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 13:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSzRs-0005GY-F1; Thu, 25 Jan 2024 08:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rSzRq-0005CH-2C
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:07:14 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rSzRl-0001lM-ND
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:07:12 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-558f523c072so7996279a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 05:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706188026; x=1706792826;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0UrQw4SvbljKnKX/AfTgFezeqRJM29Wou2bQOZsRlE=;
 b=gU3XdqL7GVTJQ7TK4Sncf7mJ3wOjmDdBYQ6NpO7Z6YjYDa1hfI/K6KQ2frMJ6Y/fYi
 RCQBCmOgE7tOkOtD03bZ9YD8972wHTZynPf0Pxk1oPOfHFFvNZ5fLtkFhp1tbpAKziiG
 E1Fb5ys8TupG7Dkr0dCAd5e3dvPHAuaZ+XmlAvdmLuKxkHMyEpPEfhPb7SX/VTfJwBDj
 g/HZ9KcjZSJu53YJUIGuTkGAzMadttsgiEvqaQFCpg/DQfUUMmxOJVSN2vorxfayTdGv
 06fMfEvLpiHqXTOIVMvYtz4FoF1jmgzkwx0WGleOF5bsHLcV68DD84KMmAn4/jJGHev7
 QqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706188026; x=1706792826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0UrQw4SvbljKnKX/AfTgFezeqRJM29Wou2bQOZsRlE=;
 b=iKbWWadq4bNOGmkAzcJur2MlXT9oR+6gu2dxPPMcATlvu9rpEhUQzQ3jBYNVoPVbno
 qFho1HMDHh2Tvay+yFPmsU3EsvUTDI2jhSsHemx2XCsfzy7Jh4moPKidUjBoMKlBoO7a
 w0Peib9VmSgJ/ZKDYJko+8oNBg62R9jhzof6R9nXHgvnDO7c00Wqw9mr7V7s6UNGIkqX
 MfS9R5TtnzMctFCsiDqb58MypCHgrgoJGiqBmEnQGzndycuUAuduJnGakRtraVXJqBWD
 +3P2ObTlsZKbmMrLESzvKqBfcgJ0KRoLLddQL+iqENfJlMCR9uAwbFcmpHKUyzgnYbEw
 mv+w==
X-Gm-Message-State: AOJu0Yxn+YJSm59GW/WbeYHqlHOWGp5PKBMCowHpQjmScA1VPDbmLIPJ
 SLwDeC1SQwJmNYbokI/LxKv3SZ1jqFM799Qwluxr4QkViVAep7UqrpXSwq44FYQ=
X-Google-Smtp-Source: AGHT+IG3Kdduy+12pmhWZR/uGs/418NzUboSV5VsgQzMTZt+4CR/jIkROJyDFAFbMzzZHQxwKepnAQ==
X-Received: by 2002:aa7:d907:0:b0:55c:2ad:9f53 with SMTP id
 a7-20020aa7d907000000b0055c02ad9f53mr305627edr.80.1706188026693; 
 Thu, 25 Jan 2024 05:07:06 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 er25-20020a056402449900b0055a829811ddsm6558709edb.48.2024.01.25.05.07.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 05:07:05 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com,
	akihiko.odaki@daynix.com
Subject: [PATCH v8 3/5] virtio-net: Added property to load eBPF RSS with fds.
Date: Thu, 25 Jan 2024 15:06:52 +0200
Message-ID: <20240125130656.425607-4-andrew@daynix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125130656.425607-1-andrew@daynix.com>
References: <20240125130656.425607-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::52c;
 envelope-from=andrew@daynix.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

eBPF RSS program and maps may now be passed during initialization.
Initially was implemented for libvirt to launch qemu without permissions,
and initialized eBPF program through the helper.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/virtio-net.c            | 63 ++++++++++++++++++++++++++++++----
 include/hw/virtio/virtio-net.h |  2 ++
 2 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7a2846fa1c..d7980d827a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -42,6 +42,7 @@
 #include "sysemu/sysemu.h"
 #include "trace.h"
 #include "monitor/qdev.h"
+#include "monitor/monitor.h"
 #include "hw/pci/pci_device.h"
 #include "net_rx_pkt.h"
 #include "hw/virtio/vhost.h"
@@ -1323,14 +1324,53 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
     virtio_net_attach_ebpf_to_backend(n->nic, -1);
 }
 
-static bool virtio_net_load_ebpf(VirtIONet *n)
+static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
 {
-    if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        /* backend doesn't support steering ebpf */
-        return false;
+    int fds[EBPF_RSS_MAX_FDS] = { [0 ... EBPF_RSS_MAX_FDS - 1] = -1};
+    int ret = true;
+    int i = 0;
+
+    ERRP_GUARD();
+
+    if (n->nr_ebpf_rss_fds != EBPF_RSS_MAX_FDS) {
+        error_setg(errp,
+                  "Expected %d file descriptors but got %d",
+                  EBPF_RSS_MAX_FDS, n->nr_ebpf_rss_fds);
+       return false;
+   }
+
+    for (i = 0; i < n->nr_ebpf_rss_fds; i++) {
+        fds[i] = monitor_fd_param(monitor_cur(), n->ebpf_rss_fds[i], errp);
+        if (*errp) {
+            ret = false;
+            goto exit;
+        }
     }
 
-    return ebpf_rss_load(&n->ebpf_rss);
+    ret = ebpf_rss_load_fds(&n->ebpf_rss, fds[0], fds[1], fds[2], fds[3]);
+
+exit:
+    if (!ret || *errp) {
+        for (i = 0; i < n->nr_ebpf_rss_fds && fds[i] != -1; i++) {
+            close(fds[i]);
+        }
+    }
+
+    return ret;
+}
+
+static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
+{
+    bool ret = false;
+
+    if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
+        if (!(n->ebpf_rss_fds
+                && virtio_net_load_ebpf_fds(n, errp))) {
+            ret = ebpf_rss_load(&n->ebpf_rss);
+        }
+    }
+
+    return ret;
 }
 
 static void virtio_net_unload_ebpf(VirtIONet *n)
@@ -3762,7 +3802,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     net_rx_pkt_init(&n->rx_pkt);
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS)) {
-        virtio_net_load_ebpf(n);
+        virtio_net_load_ebpf(n, errp);
     }
 }
 
@@ -3776,6 +3816,15 @@ static void virtio_net_device_unrealize(DeviceState *dev)
         virtio_net_unload_ebpf(n);
     }
 
+    if (n->nr_ebpf_rss_fds) {
+        for (i = 0; i < n->nr_ebpf_rss_fds; ++i) {
+            g_free(n->ebpf_rss_fds[i]);
+        }
+        g_free(n->ebpf_rss_fds);
+        n->ebpf_rss_fds = NULL;
+        n->nr_ebpf_rss_fds = 0;
+    }
+
     /* This will stop vhost backend if appropriate. */
     virtio_net_set_status(vdev, 0);
 
@@ -3924,6 +3973,8 @@ static Property virtio_net_properties[] = {
                     VIRTIO_NET_F_RSS, false),
     DEFINE_PROP_BIT64("hash", VirtIONet, host_features,
                     VIRTIO_NET_F_HASH_REPORT, false),
+    DEFINE_PROP_ARRAY("ebpf-rss-fds", VirtIONet, nr_ebpf_rss_fds,
+                      ebpf_rss_fds, qdev_prop_string, char*),
     DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
                     VIRTIO_NET_F_RSC_EXT, false),
     DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 55977f01f0..566ec53e7e 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -225,6 +225,8 @@ struct VirtIONet {
     VirtioNetRssData rss_data;
     struct NetRxPkt *rx_pkt;
     struct EBPFRSSContext ebpf_rss;
+    uint32_t nr_ebpf_rss_fds;
+    char **ebpf_rss_fds;
 };
 
 size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
-- 
2.43.0


