Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD07C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscVm-0008Te-F4; Thu, 13 Mar 2025 02:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscUN-0006tI-LL
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:24 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscUL-0006A5-Dz
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:19 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ff799d99dcso1383218a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 23:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741848976; x=1742453776;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DukArzDg125GLBsbHFL9ykYW0pGberfM/CiWiOUc3SY=;
 b=fo0h1/1pArrIBJVfd6G9QgHF0p1B51Sxv7bcEOS/z1cRctml0DB/uC+ysJttmZRnZD
 A1iJk+mqxi32m38gatagvuJx6IPe9iBnxbOmRQB2uZdXLR9IXrCzvryRAEzgCnOLVl/v
 sBZUJK8oaKHbY6k3DePHZ5cMyx298oQcycK6XiSbP/yxVBItgvqf32jLowW3d1Tjk+0M
 Awce4WfrtvDEy22zE1nhmutQkehPYnyu6bd6s4gOznHj5PdU33gYmfn5BBr6x/IT2d2L
 ps3EPG79EepJQ+C5ycZ6pohe9CBCga7owM5KEXdTCpth1YTvu9w21mHwiw5U76vbyaKw
 4lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741848976; x=1742453776;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DukArzDg125GLBsbHFL9ykYW0pGberfM/CiWiOUc3SY=;
 b=brRJRVJH4P5jkzdDkRaqnp2vFqkOO+3zbdd4RX/c8GGUU5xkhbK+mdC16IpFdguzYG
 zSAk7qrutKzZEo3ZRfTe/XYmtQE3+GzxpYT91rm5di/rX2z5hWhEXM2poYe5WFrIGZxe
 a5dhRn9GWZVLOksZZN5Q0InV2IfjJCh2FefW0voBY96AZ1N4S1HLzGD+TC7YZxgoUJAb
 a/4aNHllsYI6A3QH411+ONSF3DKKM4RzGK9+4EWhBgtsNZoUkOZtoF/W92tg0PvmRugI
 N1Cks5y6vO7LwYgd03p1qatX4aKCq6pUH76yqEAhqrRx5pAvG36vEKA5f2xbo4pFBK4F
 YG8A==
X-Gm-Message-State: AOJu0YxiiLTGb/0am8p7OSJQt+UADMH0T2wRdTtbAC4DqJa0gSPXHOdj
 GR8+U3q1RjlSQAyio0zWJfe+XLMwp8VWOKRr92vc5TdtqFBm+u+G4npsQvX6BEA=
X-Gm-Gg: ASbGncvs8W64RrFr6h9A3u00+59Cyu5MlMx7i7IAFe6jeSVjS6ZVWb3mgVCx/t1pT6l
 gD7eBj266GioBD9gRbSvCJ1Jad6uoNMPTy6pvq70gwXGwWqIyTP2O3j/lMmoHgx7QpMNNlK+2O8
 l8kDd7XXLRuUuEQwyMMwvvSj8fTvK2YTPpWctAgmQiK8zV7SVYzrj3RVcEPbeDxMeFccXXq5VOC
 XSNM11X/G9ZCygdQI3MW0Y3cX+MkF0Lb90YshOljiAvNP1nzOLNA7ixolyip2H2wvfbJIBxLfQ5
 3GHX+/0Bbb2zvFvFf6vSrHdgI1XbfidjOh77Ws6Ko6oVqocw
X-Google-Smtp-Source: AGHT+IFcrJ/eUUtY7TlfARDyFEIKRX3RHgJRzLwpozwrGsZnb2An8zyGlri72k5ZHz2rCfSxP7+eGQ==
X-Received: by 2002:a17:90b:3887:b0:2ee:d193:f3d5 with SMTP id
 98e67ed59e1d1-2ff7ce59637mr37238464a91.7.1741848975877; 
 Wed, 12 Mar 2025 23:56:15 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-30138b3b483sm681970a91.4.2025.03.12.23.56.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 23:56:15 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:55:35 +0900
Subject: [PATCH RFC v4 09/11] virtio-net: Offload hashing without vhost
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hash-v4-9-c75c494b495e@daynix.com>
References: <20250313-hash-v4-0-c75c494b495e@daynix.com>
In-Reply-To: <20250313-hash-v4-0-c75c494b495e@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is necessary to offload hashing to tap.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e125478ae834..edfc76a5308e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1712,7 +1712,11 @@ static size_t receive_header(VirtIONet *n, struct virtio_net_hdr *hdr,
 {
     size_t hdr_len = n->guest_hdr_len;
 
-    memcpy(hdr, buf, sizeof(struct virtio_net_hdr));
+    memcpy(hdr, buf,
+           n->rss_data.populate_hash &&
+           n->rss_data.enabled && !n->rss_data.enabled_software_rss ?
+           sizeof(struct virtio_net_hdr_v1_hash) :
+           sizeof(struct virtio_net_hdr));
 
     *buf_offset = n->host_hdr_len;
     work_around_broken_dhclient(hdr, &hdr_len, buf, buf_size, buf_offset);
@@ -3111,11 +3115,13 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
     }
 
     if (!get_vhost_net(nc->peer)) {
-        if (!use_own_hash) {
-            virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
-            virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
-        } else if (virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
-            virtio_net_load_ebpf(n, errp);
+        if (!use_peer_hash) {
+            if (!use_own_hash) {
+                virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
+                virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+            } else if (virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
+                virtio_net_load_ebpf(n, errp);
+            }
         }
 
         return features;

-- 
2.48.1


