Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A942C3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 04:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKrWe-0006r4-82; Fri, 30 May 2025 00:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrWb-0006qQ-5f
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:39:21 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrWZ-0006q9-7h
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:39:20 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-73972a54919so1409640b3a.3
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 21:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748579958; x=1749184758;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tQBzKuduCWcv6douWsbSGAxa5Fec63h7Sr3QTsoSHc4=;
 b=O+5tXOPE6PlpmoiS6qAIqgs8fSpwxH3nLWUsSj20tMExgZoL9KSFb5V7+J+WMOheob
 B4S26hfUyNU5fJYJF8Mk2EaT1xH27Xfv4+65c3iJXVSYs4Vvr82wbLxdMNowwtZ+EUGu
 uyAGUWEjnE4Wx/Lfuz48erPVlTuwh+1LNf1sdduSLTDuCM0AHiDn06/Rt8Lv4PxrmRFG
 8yIjyJQ2Uk4KXaY20TXQDlR76oWfD73YVIdvQMytW5RghAHYwO2eAYqejuQViEWRqEyh
 4NjBG9EsUMFudjUM01HmAHeJxAfLGjSfaanV8hSkb3NQarSUJAdovg2O7fXIAXIzIH71
 4AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748579958; x=1749184758;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQBzKuduCWcv6douWsbSGAxa5Fec63h7Sr3QTsoSHc4=;
 b=XPYPHA43pisQPYSwCcXYEwou51qyjSRvzRsx6bnbV4xOYuCs8aLnVh2eGzSCdZFpvz
 2LYQcx0HyxWH2JwIgES/Lx4ODlWd8aOkaB/lH+vWGKC6ht4lO/EthCw2yMgOyI7EoPhD
 dTVuj5egOhScS6NxyAqjxA8f7pJgEG096Zqx1v1Qu0gR/uL7ypFdcru03TmF2N34ilxQ
 9zVOzYpYSNv0CDncJYNZvRpubhpClJgeKzSLkEG7enH/TIa8MqPnTuyzxFspC33OU+0S
 C4cncNitYl79hQKj63SK3ne/YGoBzpgi5o2KP2jG3QPxo5r6iPAE1p8xW+xWW5LjFyX8
 s9DQ==
X-Gm-Message-State: AOJu0YxBc2KUEBE1ZWF7kijRdDSN+NDt2zoh9SmV3jub+0w2eoaDEnED
 1F6sCmtXWA1+sKBtimQjN2qMw4JeLPPD1q0nF++lWZzVi43RefZQtrmQ5tU4KFcQedw=
X-Gm-Gg: ASbGncsY/sl6jQx7frmUeaH+NAfnDYXUJBrSHBqRly2cNnA87L/fao7GptPELkLsyAo
 HjcCiwvaQBEgvmaXbAwh3nc56dwaajp3g3XkfXS3bWZLJ5l43C80r+2OYCbf+gDzVYmjbFaPFDe
 AzihmPBTdeESvBAm80YWj8awIIOMvrrSpWIO7gsUJecyEstQFHJk+KCaWK4vsGYmAffU3wtKFvC
 hdiV3t81R1Y+13IiSxBIeSvsCkaNrDVJt67sDUHBP8CELahRffcxs5Ee2CKJ7usL7czb+CJYnn+
 WyB1R+5wYothIy7PCf/nwH36vXq4U55OvxeV0L4N3eQvlkn4oySB
X-Google-Smtp-Source: AGHT+IHqRAmp46ed22bvl6PfckJl/SS19VJhqfp+c8yVJteQJydudop/co7IlYAXsvRSdgOAbKJ2cg==
X-Received: by 2002:a05:6a00:3a24:b0:742:da7c:3f28 with SMTP id
 d2e1a72fcca58-747bda19b11mr2731167b3a.21.1748579957661; 
 Thu, 29 May 2025 21:39:17 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-747afe96474sm2166809b3a.22.2025.05.29.21.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 21:39:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:39:10 +0900
Subject: [PATCH RFC v5 2/5] virtio-net: Offload hashing to peer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-hash-v5-2-343d7d7a8200@daynix.com>
References: <20250530-hash-v5-0-343d7d7a8200@daynix.com>
In-Reply-To: <20250530-hash-v5-0-343d7d7a8200@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>, devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
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

This allows offloading hash reporting and RSS to tap.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 69 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 52fe404b3431..0a333d560d7b 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1213,20 +1213,58 @@ static void virtio_net_detach_ebpf_rss(VirtIONet *n)
 
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
+            if (n->rss_data.redirect) {
+                size_t indirection_table_size =
+                    n->rss_data.indirections_len *
+                    sizeof(*n->rss_data.indirections_table);
+
+                size_t hash_size = sizeof(NetVnetRss) +
+                                   indirection_table_size +
+                                   sizeof(n->rss_data.key);
+
+                g_autofree struct {
+                    NetVnetRss hdr;
+                    uint8_t footer[];
+                } *rss = g_malloc(hash_size);
+
+                rss->hdr.hash_types = n->rss_data.runtime_hash_types;
+                rss->hdr.indirection_table_mask =
+                    n->rss_data.indirections_len - 1;
+                rss->hdr.unclassified_queue = n->rss_data.default_queue;
+
+                memcpy(rss->footer, n->rss_data.indirections_table,
+                       indirection_table_size);
+
+                memcpy(rss->footer + indirection_table_size, n->rss_data.key,
+                       sizeof(n->rss_data.key));
+
+                qemu_set_vnet_rss(qemu_get_queue(n->nic)->peer, &rss->hdr,
+                                  n->rss_data.populate_hash);
             } else {
-                warn_report("Can't load eBPF RSS - fallback to software RSS");
-                n->rss_data.enabled_software_rss = true;
+                qemu_set_vnet_automq(qemu_get_queue(n->nic)->peer,
+                                     n->rss_data.runtime_hash_types);
+            }
+
+            n->rss_data.enabled_software_rss = false;
+        } else {
+            if (n->rss_data.peer_hash_available) {
+                qemu_set_vnet_automq(qemu_get_queue(n->nic)->peer, 0);
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
 
@@ -1235,7 +1273,12 @@ static void virtio_net_commit_rss_config(VirtIONet *n)
                                     n->rss_data.indirections_len,
                                     sizeof(n->rss_data.key));
     } else {
-        virtio_net_detach_ebpf_rss(n);
+        if (n->rss_data.peer_hash_available) {
+            qemu_set_vnet_automq(qemu_get_queue(n->nic)->peer, 0);
+        } else {
+            virtio_net_detach_ebpf_rss(n);
+        }
+
         trace_virtio_net_rss_disable(n);
     }
 }

-- 
2.49.0


