Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C789CC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 09:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvZ7P-0003BD-2j; Fri, 21 Mar 2025 05:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tvZ7K-0003A1-4e
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 05:56:42 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tvZ7H-0000AT-Ja
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 05:56:41 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2243803b776so6629305ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 02:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742550995; x=1743155795;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hsiQif1VBC0yMxCeUnvdy7BWeFSNFgjL2neoOgQfTbc=;
 b=WPSna86AM46JYwe8j+PntEKSZZC2O2io07hqDDpfk8GmlGSF4iygFiCZpJOSzRPcxS
 T3ovktqpyDa2aLz3HvZJxkmS5sIl5A0H0csADAzT0SKztUMIEpb1wPq4vua7w1W8iVPT
 KvbWRG0CC6Qigi48v93BMPp+iaH0nvCbCFaAEcGXEMSE78jS+UmdAJ3OP4yx3EHr+70g
 RsiW9Y2uC3LDuW53G4X6t9Z9/flHW8kNxi2kUmkPSaJj8tVPv/kyFC0/W3j6wNhSvw7T
 iCc7BJexRZB2Vyx3sKZdNfWEMa/Qqi0OtupuQ4BYPKTVnGYPWZeurje6m/xXEJclJhnG
 076w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742550995; x=1743155795;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hsiQif1VBC0yMxCeUnvdy7BWeFSNFgjL2neoOgQfTbc=;
 b=l0Ct2NIdx/CuNtGUWb6PMRSAsVddKCaVJIVEtUawqlltXuT3I1R5fW/4BtabAVQBwN
 cF6mAVFJKCij6a8SL6s7ad19bOrWJy5AhFyloHuTPL6+bk4cvz5ZggdU1elTxUlb6EqW
 06xH0Pce5xXYQrzjcEmJy/AGVRpM88nBcBv4MQ/gD/OlSROOvHCZapx9qSpfJ0SwV8rR
 +M8ekI5lOuB2SBXAzdCpPXdCdxjA7+PNkJCFVizZhZoBcUXXEmRN1XtNYYs+bCThGtwQ
 MogkGtDTlQHKQq7kMsSLHrFveWWoD3Oxy/wt/qjE1x5OAneekGwzpoXolK3ihkB+OVfN
 dXFw==
X-Gm-Message-State: AOJu0YwoUq+wvNO13MYoJ63PTuiQ4IJ77gbQMHB9tsXlOYHqRxdGtgcT
 peE9YoK9cAL8aubHnJqTc4mhGmK9d0j1yM0P+F6nHWpI70HA3207tKdMA9wulXw=
X-Gm-Gg: ASbGncuK2lhcGsaqtNziVEIxrjwcFR0R0oJYa40JnVXy/LZBOgvciazemNRYD93cszw
 lTNEcZ6lV9yV4zL+Si90zSS3CBm5BktfrCSi642w/FHzq5Dtw0IYCy/ghzWiOV3bAGN7oIEizOV
 89uFsLREJTjzi23Fn7kV0d/cAwYi7+nSg4nYzB/6zV7wKk5akcxpqqP0bv9NQ7XVhPotzsnZlGA
 Br5Xf79dNdT2fPgOMTOTIPQBKB0/ywppLVpJhfNGBmD24gZ+GF/sDHn8NOJeC0i9AlOib1n3tDD
 UnY6HGqEsuVmlWn8E3ecHEdRFyNvawgFl+zDDMSSELzvShYh
X-Google-Smtp-Source: AGHT+IHbPWk1pLXkkuPl3cM7a+FJ3O6Qz3z929aQGl/5fKngJt9gg+yPeMKnSUmCd5DquN2I4EIb9Q==
X-Received: by 2002:a05:6a21:a44:b0:1f5:8903:860f with SMTP id
 adf61e73a8af0-1fe42f359d0mr5543486637.14.1742550994937; 
 Fri, 21 Mar 2025 02:56:34 -0700 (PDT)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7390611d3b4sm1449698b3a.97.2025.03.21.02.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 02:56:34 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 21 Mar 2025 18:56:29 +0900
Subject: [PATCH] virtio-net: Fix the interpretation of max_tx_vq
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-vq-v1-1-6d6d285e5cbc@daynix.com>
X-B4-Tracking: v=1; b=H4sIAMw33WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyND3bJCXQvzxLQ0kzRTY8OkNCWgwoKi1LTMCrAh0bG1tQDreCBaVAA
 AAA==
X-Change-ID: 20250321-vq-87aff4f531bf
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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

virtio-net uses the max_tx_vq field of struct virtio_net_rss_config to
determine the number of queue pairs and emits an error message saying
"Can't get queue_pairs". However, the field tells only about tx.

Examine the indirection table to determine the number of queues required
for rx, and correct the name of field in the error message, clarifying
its correct semantics.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index de87cfadffe1..d9ab9e1eb74d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1450,23 +1450,28 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         err_value = (uint32_t)s;
         goto error;
     }
-    for (i = 0; i < n->rss_data.indirections_len; ++i) {
-        uint16_t val = n->rss_data.indirections_table[i];
-        n->rss_data.indirections_table[i] = virtio_lduw_p(vdev, &val);
-    }
     offset += size_get;
     size_get = sizeof(temp);
     s = iov_to_buf(iov, iov_cnt, offset, &temp, size_get);
     if (s != size_get) {
-        err_msg = "Can't get queue_pairs";
+        err_msg = "Can't get max_tx_vq";
         err_value = (uint32_t)s;
         goto error;
     }
-    queue_pairs = do_rss ? virtio_lduw_p(vdev, &temp.us) : n->curr_queue_pairs;
-    if (queue_pairs == 0 || queue_pairs > n->max_queue_pairs) {
-        err_msg = "Invalid number of queue_pairs";
-        err_value = queue_pairs;
-        goto error;
+    if (do_rss) {
+        queue_pairs = virtio_lduw_p(vdev, &temp.us);
+        for (i = 0; i < n->rss_data.indirections_len; ++i) {
+            uint16_t val = n->rss_data.indirections_table[i];
+            n->rss_data.indirections_table[i] = virtio_lduw_p(vdev, &val);
+            queue_pairs = MAX(queue_pairs, n->rss_data.indirections_table[i]);
+        }
+        if (queue_pairs == 0 || queue_pairs > n->max_queue_pairs) {
+            err_msg = "Invalid number of queue_pairs";
+            err_value = queue_pairs;
+            goto error;
+        }
+    } else {
+        queue_pairs = n->curr_queue_pairs;
     }
     if (temp.b > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
         err_msg = "Invalid key size";

---
base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
change-id: 20250321-vq-87aff4f531bf

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


