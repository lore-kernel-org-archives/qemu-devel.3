Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE83C3DA42
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 07:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQixY-0002Yp-9r; Mon, 08 Jul 2024 03:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQixU-0002US-Hd
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 03:38:49 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQixR-00024j-H3
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 03:38:46 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1faad2f1967so30926705ad.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 00:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720424324; x=1721029124;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9K8hP6K+GS49iC8TK1k5qVM0FxyjSx6s74AXBMFGPSk=;
 b=LQgyoSZ0x1Pcl/OBRrsLg2I1HICdYfK2N0vNJCjbmk5RDmnbDPBKHjpr5P7s3EdfRL
 bAzyYd9m5AFAIytdQSaHN4PEpQ3pAjDYwTiEAIbWwnL75smn3sLw9snSW/rZQdAb0H9V
 RG7pL6OiQzq+CBE1ohKzldELf17b5GtdQAWuGEXWYxTap2HRrLLKvYUFsZVZOTqn7uXX
 rwm9JwVUT4BQVtnIi6/VwQ7RFepWVNmVaxa2bF956i/a2sgyU1LChD+E8PItDJgQkNkE
 b8e5eaLW9aAiYWKa62bC66XykDk3KK+bPDAwZ53RyXNL1gtIPMtUZ0SJy3wB86gfRcDi
 rZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720424324; x=1721029124;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9K8hP6K+GS49iC8TK1k5qVM0FxyjSx6s74AXBMFGPSk=;
 b=a8/xutBNMPDgf+eOxEhbUjScD3CTCu2JQ2jG+AFE112ArCwKaBZdZAFPKXRfW6GU85
 YYjr9ZtI9wBxpKiI20XtaNzbt7bb7IMiTrfUladqgMKlhEYwGfJXZa7j1PdprKPfUqor
 Et8HNkJMnBScwmyLKpU+VHTelhz682VO2U6+bnMZBj+5X9wWfwF7PvBpLnZs3VZaf+Qd
 +nzkb3oOjQikVjResAKUaWakWS244P35PZVe8pFVZPpFTloz28uSaGJTqKZ7eXApX2uJ
 9+c5n9Ud92+Fu+Bkn6JwJRlPH79bbOxPTDgE/T+tt1Pz95HZ01ESRc5TrnWVJqHyKJuG
 d3QA==
X-Gm-Message-State: AOJu0YxZmCxneEVLUr/jmZBt50s38hK2kjan9SeE6NOX9yYvt8CwvARk
 pfL0DlK9C+eUfM70iecqOsJzv2T/PoL1jMq5ZcuRpiWfP53uQ02KILP7ZlttKdA=
X-Google-Smtp-Source: AGHT+IHHodxy70yX/X4yIg+q4E7xiYuu2R0cRm6EhFPHT5v2EIpIT9J4Z8+lWDBPcu9xPgcfDmKQHQ==
X-Received: by 2002:a17:903:110c:b0:1f9:a69d:4e05 with SMTP id
 d9443c01a7336-1fb370562a6mr159128765ad.19.1720424324096; 
 Mon, 08 Jul 2024 00:38:44 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fb526a67ecsm50805975ad.150.2024.07.08.00.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 00:38:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 08 Jul 2024 16:38:09 +0900
Subject: [PATCH v2 4/4] virtio-net: Remove fallback from ebpf-rss-fds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240708-auto-v2-4-f4908b953f05@daynix.com>
References: <20240708-auto-v2-0-f4908b953f05@daynix.com>
In-Reply-To: <20240708-auto-v2-0-f4908b953f05@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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

If ebpf-rss-fds is specified but we fail to use, we should not fall
back to loading eBPF programs by ourselves as such makes the situation
complicated.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e779ba2df428..075c91f037d1 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1396,15 +1396,9 @@ exit:
 
 static bool virtio_net_load_ebpf(VirtIONet *n)
 {
-    bool ret = false;
-
-    if (virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
-        if (!(n->ebpf_rss_fds && virtio_net_load_ebpf_fds(n))) {
-            ret = ebpf_rss_load(&n->ebpf_rss);
-        }
-    }
-
-    return ret;
+    return virtio_net_attach_ebpf_to_backend(n->nic, -1) &&
+           (n->ebpf_rss_fds ? virtio_net_load_ebpf_fds(n) :
+                              ebpf_rss_load(&n->ebpf_rss));
 }
 
 static void virtio_net_unload_ebpf(VirtIONet *n)

-- 
2.45.2


