Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326D8CD1297
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryWu-0007a0-Vp; Wed, 03 Apr 2024 07:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWl-0007SL-GA
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:37 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWk-0007Hq-0t
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:35 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6eaf9565e6bso2537700b3a.2
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142692; x=1712747492;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xe74X6FoQm294awHcG8+aJfTJ6SJKDn+2TXhvqpinSY=;
 b=Mh08kEIbXmp3bI2CW9s8FqpDgG0g7W6YJcRa99UqvNTvCTLfEGZ23cBaP3T0IBLjYO
 Z5ukplm5wUIamDjbhGHGDOa7G5V1yvVMJIkGVgkzS+K4n+sHcgl9bDgoX2K1s5d0/MDp
 u8wt7/BmDGjRbeXSHeckWG/+7fW/fADPHS+xPfup+FTrpWl+V2g2sMx2adPnuNo78Q4v
 +ZGEw2mMzF8+POGM1EUKpqDInlU6xdHpSYEwebKRkoPuy2mteb25J6G/i7nm0Y6JR6nb
 py8gEfsrP4u63/yTEFWghQmSVkU7zoMVfLK3gs2n8AXYJdi1vRDU5m+MMgoDBBCVSAOu
 4ygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142692; x=1712747492;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xe74X6FoQm294awHcG8+aJfTJ6SJKDn+2TXhvqpinSY=;
 b=dUVqS5YLHXiG6sPlzZOa/WhSqaocUBIiaRyBlFSz/mkjKD0C5esmCDLVhE5cDTgrYm
 +i14t9D2+YIkpMDXw2e0YDMw9Fd4HJYAIty1W3TKwIzRLE3agssswW6epbrPyPTj7l8c
 XHTJSvvo85p0lEQ/Y7NqnR5ct/b7EsuDxolzzOrz2GhCNmfr81W3We+K+mxLYjtls/pr
 WWaLaHsC9+C5zxdrTh3Ogz7FsVMSQ4MiNN0VzhwADXDmb1wgYadAWgoVU/w08ck/3WFM
 5sX/D5WI5iLsZZscbs5bEe3Klz8wnSGqeWGkHVze6C/SzTCK5+weqmluHHrJDEJrEXvx
 XPhA==
X-Gm-Message-State: AOJu0YxCZA4qLn8xXD9MEGoEdkpfJrz6KRBHA7ukefgpqZSstnV8EJSJ
 nEjqMgF8AlE8WnGri5fku4cgXl4WbZRPZD7McFumeH45ZeBAGzRcdmsdwt/poRY=
X-Google-Smtp-Source: AGHT+IGA4IAnGFwCyKwa4rianXvTykCf8daKtxv4tNNhlYOj+l6PBoBbXlRvGb7GsyJYgJn/XtTl0w==
X-Received: by 2002:a05:6a21:3995:b0:1a5:6f9f:26af with SMTP id
 ad21-20020a056a21399500b001a56f9f26afmr17320695pzc.2.1712142691847; 
 Wed, 03 Apr 2024 04:11:31 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 f6-20020a170902e98600b001e01c1124absm3429544plb.171.2024.04.03.04.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:11:31 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 03 Apr 2024 20:10:57 +0900
Subject: [PATCH v9 09/20] virtio-net: Copy header only when necessary
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rss-v9-9-c6d87e69d38b@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
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

The copied header is only used for byte swapping.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e33bdbfd84a5..ca0fbf7b7654 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -360,7 +360,8 @@ static void virtio_net_vnet_endian_status(VirtIONet *n, uint8_t status)
          * can't do it, we fallback onto fixing the headers in the core
          * virtio-net code.
          */
-        n->needs_vnet_hdr_swap = virtio_net_set_vnet_endian(vdev, n->nic->ncs,
+        n->needs_vnet_hdr_swap = n->has_vnet_hdr &&
+                                 virtio_net_set_vnet_endian(vdev, n->nic->ncs,
                                                             queue_pairs, true);
     } else if (virtio_net_started(n, vdev->status)) {
         /* After using the device, we need to reset the network backend to
@@ -2767,7 +2768,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
             return -EINVAL;
         }
 
-        if (n->has_vnet_hdr) {
+        if (n->needs_vnet_hdr_swap) {
             if (iov_to_buf(out_sg, out_num, 0, &vhdr, n->guest_hdr_len) <
                 n->guest_hdr_len) {
                 virtio_error(vdev, "virtio-net header incorrect");
@@ -2775,19 +2776,16 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
                 g_free(elem);
                 return -EINVAL;
             }
-            if (n->needs_vnet_hdr_swap) {
-                virtio_net_hdr_swap(vdev, (void *) &vhdr);
-                sg2[0].iov_base = &vhdr;
-                sg2[0].iov_len = n->guest_hdr_len;
-                out_num = iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1,
-                                   out_sg, out_num,
-                                   n->guest_hdr_len, -1);
-                if (out_num == VIRTQUEUE_MAX_SIZE) {
-                    goto drop;
-                }
-                out_num += 1;
-                out_sg = sg2;
+            virtio_net_hdr_swap(vdev, (void *) &vhdr);
+            sg2[0].iov_base = &vhdr;
+            sg2[0].iov_len = n->guest_hdr_len;
+            out_num = iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1, out_sg, out_num,
+                               n->guest_hdr_len, -1);
+            if (out_num == VIRTQUEUE_MAX_SIZE) {
+                goto drop;
             }
+            out_num += 1;
+            out_sg = sg2;
         }
         /*
          * If host wants to see the guest header as is, we can

-- 
2.44.0


