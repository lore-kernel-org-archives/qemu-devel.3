Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB267C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yYA-0003bj-Kq; Sun, 28 Apr 2024 03:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yY3-0003Lq-Rr
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:02:08 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yXz-0005Ul-Bh
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:02:07 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2adce8f7814so3032866a91.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714287722; x=1714892522;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nOqObjFvo/9oAC/9p+G1KW7r4O+qd7IGNrZnts75bB0=;
 b=TVXcv58I1s8KvaOkwwe4uG11EhtjVkfvlIfiDXuZsiz7xz04ZGBki347EM/MFJUtGi
 5hsAZ5vRTso6c8NyRI7Hpj+kmvT60AFHEMILo9iXNRGK56goTLR+rHTYlQbMVphSh+Cc
 U5r8yCRNFSxom4ceA6s04otyNLwYqQr9yEmIsU9MvSKmmO/LOzKd7j9MHNVdfDL/Tyzs
 5wKXg4itrbj0YhCR09VZT1fD8hp7JniSqQfYqavCNFh+hBdptwlfBImPFJVuonUq8CeS
 4VU7OYNRFMz9685ftpaXUnBJrpkRk/JUe3LBYjAzCcp6/oEZUy8vMazM7vJ0SzAV7u0O
 91/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714287722; x=1714892522;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nOqObjFvo/9oAC/9p+G1KW7r4O+qd7IGNrZnts75bB0=;
 b=FGAltQq9fZhMCJrhFdwf6EcGX9XhBw1TDm3SfRlt47ZHwXSapqZ89UleM0P7aVzkwt
 FHGrs4apcC10HNaGsWbxoq1P65A/0ghPUto4qY26mdL1pTcUaY7EG4TEHQk5AIJTFFsY
 jBqScAfT286A3zWKi0a9HXhmK7ZTGqr3N23qB5SNwGvz0AIexO3e6k5q0dPVz2F8jUEl
 SL3UNADT0ampTy7HtL20dH+5N+KHShu+/vksl0E0bVncyIFzgDGozJ3v9lWE5tGtUv/y
 kTuwb6kHN8NZwLUiVeRiG3zSxejZs0/09t5p8vy6mxlSjpftekbyEmbUjkYKfogqb1Wc
 n/3g==
X-Gm-Message-State: AOJu0YyPFOVe3PZ2BZoTNHocqISotoLov4g01lyVypceaWkkLSYcgJbN
 GXyrVk6P7gpudZ2NDXBDB1O45sm7dgvkMN9lqtck68KnQI/xWijGgBbx5pzvEus=
X-Google-Smtp-Source: AGHT+IHhL2aPfV/gvzVBAFdVMxzLtaU5xUK7lXahVenjJuKgga29KjMq7j5NBgXL5UNdvTx+AnfBNQ==
X-Received: by 2002:a17:90a:8904:b0:2ad:e41d:caed with SMTP id
 u4-20020a17090a890400b002ade41dcaedmr6678029pjn.37.1714287721845; 
 Sun, 28 Apr 2024 00:02:01 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 ca15-20020a056a02068f00b005ff58ee59b8sm10156471pgb.44.2024.04.28.00.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:02:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 16:01:00 +0900
Subject: [PATCH v10 17/18] ebpf: Refactor tun_rss_steering_prog()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-rss-v10-17-73cbaa91aeb6@daynix.com>
References: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
In-Reply-To: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1030.google.com
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

This saves branches and makes later BPF program changes easier.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tools/ebpf/rss.bpf.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/tools/ebpf/rss.bpf.c b/tools/ebpf/rss.bpf.c
index 77434435ac15..c989cb3cd82c 100644
--- a/tools/ebpf/rss.bpf.c
+++ b/tools/ebpf/rss.bpf.c
@@ -547,27 +547,23 @@ int tun_rss_steering_prog(struct __sk_buff *skb)
     config = bpf_map_lookup_elem(&tap_rss_map_configurations, &key);
     toe = bpf_map_lookup_elem(&tap_rss_map_toeplitz_key, &key);
 
-    if (config && toe) {
-        if (!config->redirect) {
-            return config->default_queue;
-        }
+    if (!config || !toe) {
+        return 0;
+    }
 
-        if (calculate_rss_hash(skb, config, toe, &hash)) {
-            __u32 table_idx = hash % config->indirections_len;
-            __u16 *queue = 0;
+    if (config->redirect && calculate_rss_hash(skb, config, toe, &hash)) {
+        __u32 table_idx = hash % config->indirections_len;
+        __u16 *queue = 0;
 
-            queue = bpf_map_lookup_elem(&tap_rss_map_indirection_table,
-                                        &table_idx);
+        queue = bpf_map_lookup_elem(&tap_rss_map_indirection_table,
+                                    &table_idx);
 
-            if (queue) {
-                return *queue;
-            }
+        if (queue) {
+            return *queue;
         }
-
-        return config->default_queue;
     }
 
-    return 0;
+    return config->default_queue;
 }
 
 char _license[] SEC("license") = "GPL v2";

-- 
2.44.0


