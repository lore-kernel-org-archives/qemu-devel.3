Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C3CCD1294
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryX8-0007hi-Fd; Wed, 03 Apr 2024 07:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryX5-0007hQ-Ow
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:55 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryX4-0007N5-5F
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:55 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e0f0398553so55566915ad.3
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142713; x=1712747513;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b1mEKoDGZ4GGrqc3/3B4HXNGq76T02i3zn74clINDmw=;
 b=HefW53rNnJT0YkjKYpes9DpFcPr7NX7oYmUUzO7mugrcdAAef08rUcGuSygO/v9E0D
 ABgx6/ryTqkwmnHFpo/WODBHQg/xPP2oMygYaiLfQ82Ln+71qU4hw1bSeED3cjTkSUBf
 07cPqW75wf35PnaRAQhLTcg6bDnuvPITo1ZgLszEuIJWF2464YWHOBUTu+IBWQjnc4fv
 XKPgUnNlM96Jnm9wg/jodxNGgsp82v0TryrQxvf0FnJf1FB+gIwE0moUqmujIPxcYRbE
 xN2vteAaLNpUYvb1Lrj4FcPWnCTrfKrY5zBCEldpJ27UaFP11S//RT2+7jXABqhAuCFs
 bZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142713; x=1712747513;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1mEKoDGZ4GGrqc3/3B4HXNGq76T02i3zn74clINDmw=;
 b=v9ZI9+VzGwya8HzGLXuHWbUFWLUJoMhXnBmHnl3AJt2+7CDS89QyPFpCnZigSIF/LY
 39Ily2wkwVY5A5BnPAlYvMWQXFIrf4OKiTixwcifHd2SntXdW4MTjWGjFy4PpkHnor/V
 +lT8/6PIfl6cJQT7EDoceL/JvuRy2kj/dfZZfpJ1033viVA0jkKZUTjXllTcMwpttGVs
 N+G4QV4rNthJTi6pVMK4Z0yNPQCkTMHAwbOKUt0zoKicHyPIswWSsgcS/mCzZrd8oTyN
 3TMc9fzaCinuoeBPpOAkYoYlMF5IOhgw7Y8LjPgDuoB2F3yg9r70ej1FQs6ezRY7XL5n
 ti4A==
X-Gm-Message-State: AOJu0YwCtKkEu7SXXwQqrKm9NAmBgi3OuOdf2ArxXKGJ/A/CR7SQWU4U
 5+U2V4FlH5aLQYLXy8KponKMg0SoEQe5+96iNn28jOkKr2QjgT5Fp8sQtvjYC3o=
X-Google-Smtp-Source: AGHT+IHvoC8xqgF91bDQlnBrnxzII7j07cUWafpRBktQBsVJhWwVjC6DwoPKCkl21CGTV//zpc6s8g==
X-Received: by 2002:a17:903:1ca:b0:1e2:90c6:839a with SMTP id
 e10-20020a17090301ca00b001e290c6839amr1831744plh.31.1712142713065; 
 Wed, 03 Apr 2024 04:11:53 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 y20-20020a170902e19400b001e28ba8b4d9sm1777496pla.132.2024.04.03.04.11.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:11:52 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 03 Apr 2024 20:11:02 +0900
Subject: [PATCH v9 14/20] virtio-net: Report RSS warning at device realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rss-v9-14-c6d87e69d38b@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

Warning about RSS fallback at device realization allows the user to
notice the configuration problem early.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3d53eba88cfc..86929c9e1fad 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1261,10 +1261,12 @@ static bool virtio_net_attach_epbf_rss(VirtIONet *n)
 
     if (!ebpf_rss_set_all(&n->ebpf_rss, &config,
                           n->rss_data.indirections_table, n->rss_data.key)) {
+        error_report("Failed to configure eBPF RSS");
         return false;
     }
 
     if (!virtio_net_attach_ebpf_to_backend(n->nic, n->ebpf_rss.program_fd)) {
+        error_report("Failed to attach eBPF to backend");
         return false;
     }
 
@@ -1279,16 +1281,10 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
 static void virtio_net_commit_rss_config(VirtIONet *n)
 {
     if (n->rss_data.enabled) {
-        n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
+        n->rss_data.enabled_software_rss = n->rss_data.populate_hash ||
+                                           !virtio_net_attach_epbf_rss(n);
         if (n->rss_data.populate_hash) {
             virtio_net_detach_epbf_rss(n);
-        } else if (!virtio_net_attach_epbf_rss(n)) {
-            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
-                warn_report("Can't load eBPF RSS for vhost");
-            } else {
-                warn_report("Can't load eBPF RSS - fallback to software RSS");
-                n->rss_data.enabled_software_rss = true;
-            }
         }
 
         trace_virtio_net_rss_enable(n->rss_data.hash_types,
@@ -3802,9 +3798,14 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     net_rx_pkt_init(&n->rx_pkt);
 
     if (virtio_has_feature(n->host_features, VIRTIO_NET_F_RSS) &&
-        !virtio_net_load_ebpf(n) && get_vhost_net(nc->peer)) {
-        virtio_net_device_unrealize(dev);
-        error_setg(errp, "Can't load eBPF RSS for vhost");
+        !virtio_net_load_ebpf(n)) {
+        if (get_vhost_net(nc->peer)) {
+            error_setg(errp, "Can't load eBPF RSS for vhost");
+            virtio_net_device_unrealize(dev);
+            return;
+        }
+
+        warn_report("Can't load eBPF RSS - fallback to software RSS");
     }
 }
 

-- 
2.44.0


