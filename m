Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C376BC3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 05:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSrWL-0007WE-B4; Sun, 14 Jul 2024 01:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSrWB-0007KN-Ax
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 01:11:27 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sSrW9-00053n-Pt
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 01:11:27 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d9de9f8c8dso1959010b6e.1
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2024 22:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720933885; x=1721538685;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iMISOcooxhdq/M4EEkPrjF33VD9e2Se2tW19e/nqD5A=;
 b=sT8dVCtaipDIYjcxHAodLV8rq0WgHgXWuPCia4ZvmEjhxdcQBiX0nVYM5oRfNrqVSf
 hyx7aHjjbOTqesc+BJZTGAjqqCnLQRaCGZ2JMgwAY2tg0QJz/ymuuv84cRWKeHuaC3yb
 fPW52ZPOcvZdYVnE/PBJUGBi+7CLnku7/574yviBqZE4HOGnitKN029/4TEsJ6Pm7C7+
 grzO6riaMSwIkFL5/VfJ0wtmJ4ETBhmRQTVn8hYwaBE9uic3pcrQWcAJY+ycORhXNFiL
 aELVY8wsg2jIkfTjoFsF51l1n3goRl/SkZxaoPNzWPCZKQurkjm9sodqXtI25d9VvbE3
 GnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720933885; x=1721538685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMISOcooxhdq/M4EEkPrjF33VD9e2Se2tW19e/nqD5A=;
 b=tio8tN9cKrDra+DxtNKy486XtkSajdJirHqlckkNiCpDZDX3llp5nA23fk1BbOIGNf
 4fX66GjVbBbijbXpDJ7XHHXcz7eiyX0ELYaKB2W44sdjrh8J8LK33Q+Bcu2HRuD/YSuP
 Dmz11AHZ1BwlEQLly/7wtIRDI++N8JCPPdTjpQhWTXCqH8Y/5zkJubT/niAzsp0qoPMM
 Ed4wcLYtzSzjSORGjjSMWyNxLB12JqrK1PNWVKWqnpGz47tIwK3Cw6jQS6iZw0bfGLNA
 c1OkIc/GQnq56rSltOA3s3uDQN4mSa9gdqVIde72DjhD3qeZ9kbFE0TTw/Fm2Vk2zJPq
 Up/g==
X-Gm-Message-State: AOJu0YzI/gF9w74vDUU7j8VJ08LyDktv0E7PZOaLpuV8AVvhRH1+esNo
 0f4c3qTfCInUeoYrTCK6pxahq2dFgI9ujUWWkyoNWyUgbURiLv+BzhfqtXNHcrM=
X-Google-Smtp-Source: AGHT+IEJj5q72576lLxdMdfvH2pVGOK+BiUff5b/yEBelDxtKAmy2Qzy61PsRrXu6N+RBJY+XjLBiA==
X-Received: by 2002:a05:6808:189d:b0:3da:a032:24a6 with SMTP id
 5614622812f47-3daa032397amr13335005b6e.19.1720933884777; 
 Sat, 13 Jul 2024 22:11:24 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b7ec7d2bcsm2048768b3a.99.2024.07.13.22.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Jul 2024 22:11:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 14 Jul 2024 14:11:04 +0900
Subject: [PATCH v3 4/5] virtio-net: Report RSS warning at device
 realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240714-auto-v3-4-e27401aabab3@daynix.com>
References: <20240714-auto-v3-0-e27401aabab3@daynix.com>
In-Reply-To: <20240714-auto-v3-0-e27401aabab3@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22c.google.com
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
 hw/net/virtio-net.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index bd285921d507..e779ba2df428 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -822,6 +822,10 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
 
     if (!get_vhost_net(nc->peer)) {
         if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
+            if (on_off_auto_features.on_bits & VIRTIO_NET_F_RSS) {
+                warn_report("Can't load eBPF RSS - fallback to software RSS");
+            }
+
             virtio_clear_feature(&on_off_auto_features.auto_bits,
                                  VIRTIO_NET_F_RSS);
         }
@@ -1332,16 +1336,10 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
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

-- 
2.45.2


