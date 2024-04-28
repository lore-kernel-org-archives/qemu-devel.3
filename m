Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAF5C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yr2-0001EW-UY; Sun, 28 Apr 2024 03:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yqx-0001BX-C9
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:21:41 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yqu-0001Dr-Ho
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:21:37 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6edc61d0ff6so3562661b3a.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714288894; x=1714893694;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v81y/vxYpe2rcT/fG7YqvYwXIKuaTja4A9su9lW6f6I=;
 b=YpvJcan8PwsZIG+7up6Y+lpy4Ga0mJOV5TyrIaJycbk7feUr7doQqF8on7z1WuonHQ
 8a3qTO7XyJTblnyIoh/OlJa3fMWhdEqQivffMXGo/r8ERAZ8gbPsi+h0bN2/fKGBWcYz
 Z4ErTZwbPePvpT1SOFpcgzvyQ7gZiteUCZLTP/UhZETrbe0M+jT0LEN+PUd/gaFnmLu2
 R1fRbIkNcYrfyXalyINRv+Y3+Q/2HfcW0oZx36H2nUhfSRhJ0BFYwslN9Y4Nn72voCgN
 ybjbxpfmysnzn20jWvXHPB7rddU0hMnfl9jwcKO2D6L16J39r9GQFsVRdo3Qm40FcmLf
 DNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714288894; x=1714893694;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v81y/vxYpe2rcT/fG7YqvYwXIKuaTja4A9su9lW6f6I=;
 b=NrkEzFNCRytHI2DXqmwFmhWSrK3FmwIDJUNj6rIvDZ9/Y/ivruNHPyh7SueoWLTxnW
 tiAdenvfIPw70FYY59VphHLhAbr3oZZWaGhGKIxG0VSCHTFdB3AT62Fz3MsrAugWHfij
 dSDgYrduPCM3t0U9j0OKHqBrIrjyPWcDObQpRem1x9a1sGgG5tcLPxwWPLzVOG4xODb2
 asQF5hR35XyTv+oC9Fnp7gP7gHmdKSdLCojqddViaIhIp8wSFtDmmK5zvsQjwIEoARAI
 Rk5n92D5NFDp761ZhT7xe0FbNp/ESLIu8E+mHu2VZLPQIPw7Ewt8Y0HkGNOjzoZeOHjo
 yXJw==
X-Gm-Message-State: AOJu0YzXk8bGAslZi7zyKvn3EBpzt7+w5mp7oxzUD10C4GxVJD/Vo+p2
 UrNn5bWKsykMHbTXDud3PoAywTgWqfHUaqfTMO4IpGuFF67pYhcUiAUlEGQxFOI=
X-Google-Smtp-Source: AGHT+IHClLs5NqWdXylpq6d5jXrOUqbk8SrdN6/okT7hb12jOpKwAnmsAXiWOXqJnKeveA76fEY9DQ==
X-Received: by 2002:a05:6a00:8d08:b0:6ec:f28b:659f with SMTP id
 ik8-20020a056a008d0800b006ecf28b659fmr6773928pfb.3.1714288894365; 
 Sun, 28 Apr 2024 00:21:34 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 l185-20020a6391c2000000b005ffd8019f01sm11278476pge.20.2024.04.28.00.21.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:21:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 16:21:09 +0900
Subject: [PATCH 3/3] virtio-net: Report RSS warning at device realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-auto-v1-3-7b012216a120@daynix.com>
References: <20240428-auto-v1-0-7b012216a120@daynix.com>
In-Reply-To: <20240428-auto-v1-0-7b012216a120@daynix.com>
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
Cc: qemu-devel@nongnu.org, 20240428-rss-v10-0-73cbaa91aeb6@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
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
index 5b6c901915a9..e1a6d43de283 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -817,6 +817,10 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
 
     if (!get_vhost_net(nc->peer)) {
         if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
+            if (on_off_auto_features.on_bits & VIRTIO_NET_F_RSS) {
+                warn_report("Can't load eBPF RSS - fallback to software RSS");
+            }
+
             virtio_clear_feature(&on_off_auto_features.auto_bits,
                                  VIRTIO_NET_F_RSS);
         }
@@ -1327,16 +1331,10 @@ static void virtio_net_detach_epbf_rss(VirtIONet *n)
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
2.44.0


