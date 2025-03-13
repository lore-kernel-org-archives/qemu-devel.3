Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2145EC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscUx-0007eh-QX; Thu, 13 Mar 2025 02:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscUJ-0006pj-Iq
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:15 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscUH-00069V-N1
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:15 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22398e09e39so11095875ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 23:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741848972; x=1742453772;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PsM+Cnp++8fm++9PBlCkfszQ/qYqRJZZsKVMXkCvzrE=;
 b=rnL9slShvI4DKQtKlA1CyRDQKK6tNtbdb5UBwTJizuJs55o0PKK6zjtsLO78ZZP1zg
 fFtGN0VgVvSj82P1i9L6oKGlRACh3K6/L8v5KAtaEKQjXXBDjcCurLvrGyvf95h/PYMr
 49yA09EeaySdovqE/aP2swbNQkPRW+AQCTpMHSVbQmG8WrrIQdN0n7irM+30b684TwJx
 FHNPb+Kfau2dnHpTD4a8I91Ur8mtYDYWeXXc34J7UDVL9Ggk7y27D+HacL+lWObx/W68
 BauCcG2tJyvh5IIXn0ASbch0J0rOtZzjdCAxsFyXJlhDzb5pIY/6pswIjdEko7+9lFkL
 rNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741848972; x=1742453772;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PsM+Cnp++8fm++9PBlCkfszQ/qYqRJZZsKVMXkCvzrE=;
 b=g5UvsmnK1IWcsTwWe+V/4mdEmI8PeiDgVZSfpT1q0ePADPVfEG8yzN/pUQzSXabJC1
 KZ4zzdtYlvLJDu0xc7wnNmdIzX+L4rAc6HSt5kPLguY+M/ibSWjIQDd6xtFNfXm9INlE
 aMUnQjG3p5QJOS1U9oYvyIDxyxA4uyOT167oHszBUGkmnVOedsQHTe5BBse0XFdR2v/0
 CF+KyUF1TyvjyEYwxedYoxY9ijv21aLItlXfi2UvB3UVqQBUVQeENgC5x7rqO3a4OTrS
 eb4HNsuG4Wc1RxCHN3hIVxsHY2GREq/CVikoJ49dGAk1LcgeouAWy1ITk6MuzdRdBd8C
 AdIA==
X-Gm-Message-State: AOJu0YypWlXwZNY3s3qjnMSB+UIHuVLZJM0CgUHTjFqf2WxTm4oxFQSv
 OjQmAGGAtVfcOOTXjAnDCoigV14eaecluDTxraPC+E046Ie68SK6kSz+rizsWPtnMpssObzXcT7
 r5TU=
X-Gm-Gg: ASbGncvEMlaeZ72sLSR5/fxpOGfgNKKSAXd1ttL+BSqrqo7Ro489qxjLkbsT8vhfJiw
 UGe6TTsknO8AfDci5gc/WFIEXKp4dKPzvBPcc+Hy8T0miBO941XkTPEA/lDQNTdOJKitnAtWWC3
 A3GjAivXau6/Fcbz00PrxtFZgH7mCFhX8CfmIIieqEvYhk1d0KTxzPNFRoLULDAz9qYe2xJ+xEW
 crTtqWorLv3bXztxanRyrmiYbIpoubLkmj7jacGA4UrrNfrmF96BmLX79WLebIYTKkUq3TbO7oV
 B6LGPifIokB5VWPGPSMl0GY7Up4ucxiyWnkfMFoedRWwu0WZ
X-Google-Smtp-Source: AGHT+IHE7AuOv9sAizGHSoQoKxjTQBVuoXPApftupIVhjBN9TJGbbM24hEQmosIt8IERG9IK93CRTQ==
X-Received: by 2002:a05:6a00:4fc6:b0:736:32d2:aa82 with SMTP id
 d2e1a72fcca58-736aab17045mr33600845b3a.23.1741848972128; 
 Wed, 12 Mar 2025 23:56:12 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73711529531sm633744b3a.2.2025.03.12.23.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 23:56:11 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:55:34 +0900
Subject: [PATCH RFC v4 08/11] virtio-net: Use qemu_set_vnet_hash()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hash-v4-8-c75c494b495e@daynix.com>
References: <20250313-hash-v4-0-c75c494b495e@daynix.com>
In-Reply-To: <20250313-hash-v4-0-c75c494b495e@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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
 hw/net/virtio-net.c | 77 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 13 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index b0f2ad78cb39..e125478ae834 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1212,20 +1212,65 @@ static void virtio_net_detach_ebpf_rss(VirtIONet *n)
 
 static void virtio_net_commit_rss_config(VirtIONet *n)
 {
-    if (n->rss_data.peer_hash_available) {
-        return;
-    }
-
     if (n->rss_data.enabled) {
-        n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
-        if (n->rss_data.populate_hash) {
-            virtio_net_detach_ebpf_rss(n);
-        } else if (!virtio_net_attach_ebpf_rss(n)) {
-            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
-                warn_report("Can't load eBPF RSS for vhost");
+        if (n->rss_data.peer_hash_available &&
+            (n->rss_data.peer_hash_types & n->rss_data.runtime_hash_types) ==
+            n->rss_data.runtime_hash_types) {
+            NetVnetHash hash = {
+                .flags = (n->rss_data.redirect ? NET_VNET_HASH_RSS : 0) |
+                         (n->rss_data.populate_hash ? NET_VNET_HASH_REPORT : 0),
+                .types = n->rss_data.runtime_hash_types
+            };
+
+            if (n->rss_data.redirect) {
+                size_t indirection_table_size =
+                    n->rss_data.indirections_len *
+                    sizeof(*n->rss_data.indirections_table);
+
+                size_t hash_size = sizeof(NetVnetHash) +
+                                   sizeof(NetVnetHashRss) +
+                                   indirection_table_size +
+                                   sizeof(n->rss_data.key);
+
+                g_autofree struct {
+                    NetVnetHash hdr;
+                    NetVnetHashRss rss;
+                    uint8_t footer[];
+                } *rss = g_malloc(hash_size);
+
+                rss->hdr = hash;
+                rss->rss.indirection_table_mask =
+                    n->rss_data.indirections_len - 1;
+                rss->rss.unclassified_queue = n->rss_data.default_queue;
+
+                memcpy(rss->footer, n->rss_data.indirections_table,
+                       indirection_table_size);
+
+                memcpy(rss->footer + indirection_table_size, n->rss_data.key,
+                       sizeof(n->rss_data.key));
+
+                qemu_set_vnet_hash(qemu_get_queue(n->nic)->peer, &rss->hdr);
             } else {
-                warn_report("Can't load eBPF RSS - fallback to software RSS");
-                n->rss_data.enabled_software_rss = true;
+                qemu_set_vnet_hash(qemu_get_queue(n->nic)->peer, &hash);
+            }
+
+            n->rss_data.enabled_software_rss = false;
+        } else {
+            if (n->rss_data.peer_hash_available) {
+                NetVnetHash hash = { .flags = 0 };
+                qemu_set_vnet_hash(qemu_get_queue(n->nic)->peer, &hash);
+            }
+
+            n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
+            if (n->rss_data.populate_hash) {
+                virtio_net_detach_ebpf_rss(n);
+            } else if (!virtio_net_attach_ebpf_rss(n)) {
+                if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
+                    warn_report("Can't load eBPF RSS for vhost");
+                } else {
+                    warn_report("Can't load eBPF RSS - fallback to software RSS");
+                    n->rss_data.enabled_software_rss = true;
+                }
             }
         }
 
@@ -1234,7 +1279,13 @@ static void virtio_net_commit_rss_config(VirtIONet *n)
                                     n->rss_data.indirections_len,
                                     sizeof(n->rss_data.key));
     } else {
-        virtio_net_detach_ebpf_rss(n);
+        if (n->rss_data.peer_hash_available) {
+            NetVnetHash hash = { .flags = 0 };
+            qemu_set_vnet_hash(qemu_get_queue(n->nic)->peer, &hash);
+        } else {
+            virtio_net_detach_ebpf_rss(n);
+        }
+
         trace_virtio_net_rss_disable(n);
     }
 }

-- 
2.48.1


