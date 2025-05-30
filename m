Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EB5C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 04:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKrWh-0006si-Qu; Fri, 30 May 2025 00:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrWe-0006r5-5Y
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:39:25 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrWb-0006qb-If
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:39:23 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b26c5fd40a9so2170036a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 21:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748579960; x=1749184760;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v9JDnq6XeGtOR9OFG+ek3d5CCEoi428rIOkuRtKIBFc=;
 b=bPtWgWbq21TVEqzRVc3YvP4fIYoCI7VDohRYTEDVcVPqtTTsHZg3cf6gnPpeANwT38
 QVYFhU0fhFWT6UbMYXOrZyXjYlD03f+BUUrkOkfWR1QRlnPsQt/i9cgqo95zpcA9Kapv
 v891lZum/EBekSBGVnrLxm8t705JhgH27p2kBYfAAB8D2hRM01XC0IvMc0okMX9rnxdQ
 o5Dt4rJhi0TOT/Yamsl/Q1WAlBvvp1P+8Yn26o18m1CR+5e5ZK1oyZ9Yd71HtNX218hx
 zHOWi4o9M0fRgON/5DsKkSTp3A9li2LYlCCgdhdx8kaQbfgHhbZVTasnr87odjzyXuBO
 He6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748579960; x=1749184760;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9JDnq6XeGtOR9OFG+ek3d5CCEoi428rIOkuRtKIBFc=;
 b=EnblMshBTLjruopI3f6yKGSXxpN6MF9WQ2x6vAR73VHQihJltPE2ZJCja4kHaeumwH
 fmbSS0nvw+rLCjTCRQa8c5Qn/3GZhAj7XlT4hjKku5Im2NA8ZhPLsAe3Q19m0Encxj2Z
 /MdKw6Cwgg2JW/aCC2n+P1L2kBWxBXcUJ9EJaDLc3q5v4dW/z0Wwtpv+DSpsPixR84yg
 TTVA7BtNm9ixtjtDKLa4V9m/uhDKI3A3a0+aOnbCJJ5tA2AdgsoP6NJx55znSBhqAdgI
 TK+gvTNj5gxykXNhpgZ3ihhcSkOSlW7PXamWdTf2dvVQTwXPHrZNnPfbHaaTJxcwmaxq
 sq0w==
X-Gm-Message-State: AOJu0YzxkMD3Q3mqkZYJI/btA1zvTbWeRqrjOkQTVp8m7uV32oXgggk1
 oapRcrmDyk1h+BJrq9uqcygu5n2Rb+jg3jD5SNE0nilgEzU7WNH5/sp8UuR0y9+e0u5ErxMqGOW
 4zmxd
X-Gm-Gg: ASbGncuRPzAOq6Khfx5gYWSVK443L6VyohNcE8Fo1AqXSX+qSxiK8SoLjrPyox0Dp1O
 ZEBwW1BT2CVwqfo1nUCkhM3pQML5tSN7IMC6cSOs3aDKSLSE+hI2nc6LbwJOBOzvI6oJhYQVPn/
 1Jvo5+em0wNg2q7Jw0RmPL0x4CF9TBeNUWta8tmY6KkOTyAkRPE8S8Rw+c3zrgDG86Kum1/EM/E
 IlONEqM5wMVKs+38QVsIH2l4ULsGXXZbXjRoITjx46fLKfR9RbyMT+jORneVuX+exiIsJ171ojh
 18D8M4kMzEzqkQE71QsnajsLCJKLv1uSYjDJSbpc2dkJFQ982Zce
X-Google-Smtp-Source: AGHT+IFs5vC5Nq3LNSNzI9RojaD2Dz2a5p6cDsBfBOey3yt76JwcBgP7aWW2aXcKVpLgbIbusYRF5w==
X-Received: by 2002:a17:90b:2f03:b0:30a:9feb:1e15 with SMTP id
 98e67ed59e1d1-31214e2efabmr10456036a91.8.1748579960146; 
 Thu, 29 May 2025 21:39:20 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3124e30cbe6sm358543a91.39.2025.05.29.21.39.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 21:39:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:39:11 +0900
Subject: [PATCH RFC v5 3/5] virtio-net: Offload hashing without vhost
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-hash-v5-3-343d7d7a8200@daynix.com>
References: <20250530-hash-v5-0-343d7d7a8200@daynix.com>
In-Reply-To: <20250530-hash-v5-0-343d7d7a8200@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>, devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
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
 hw/net/virtio-net.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 0a333d560d7b..3469c211b13a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1968,7 +1968,8 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
             }
 
             receive_header(n, sg, elem->in_num, buf, size);
-            if (n->rss_data.populate_hash) {
+            if (n->rss_data.enabled_software_rss &&
+                n->rss_data.populate_hash) {
                 offset = offsetof(typeof(extra_hdr), hash_value);
                 iov_from_buf(sg, elem->in_num, offset,
                              (char *)&extra_hdr + offset,
@@ -3099,11 +3100,13 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
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
2.49.0


