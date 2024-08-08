Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BFFC52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 03:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbtS9-0007Tf-30; Wed, 07 Aug 2024 23:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1sbtS6-0007SQ-J3
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 23:04:34 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yaozhenguo1@gmail.com>)
 id 1sbtS4-0001yc-UR
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 23:04:34 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7b80afeb099so366557a12.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 20:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723086271; x=1723691071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OXqZrXDuZoECLxjte3wbuZqP1YGh+i4nv8PGa7x1f2k=;
 b=XNSmBoRbLpYzONxgMdBJPjFrJ2ADTTYEkp6A8FBn1k/M+t1gfqpAhNXLIoAldCA9Lj
 aBDCqy80UnfBBkCBoGtndQ+m3xhLKPw9rBSVZFX238JqytrFhhLQvGFzt7t8OOiOVK9A
 Hv0lrA70qIK/cDjm3gFfGxQfgcznyOmvJELlJ/S3X0eN+NTrjlaIvQit2pR/ZL9rBKKR
 Y8MvLrMxPcTIa8nYb7SjYDrfjnkESHUMCAnPUmoLmc2SysuAZvInbw6dRX/cChcSVuyS
 xAiAOuzXFbsKDHDY32Ka1NLPzpf301WmTtRX0SAZQ35DQWY5zeHX78UzpBzfxUXPfYwt
 SAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086271; x=1723691071;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OXqZrXDuZoECLxjte3wbuZqP1YGh+i4nv8PGa7x1f2k=;
 b=uKVYHLQR1t2lMWoBuRCQxoTnK9B+tK2Fcqi+8kGrpaUwsuyn5RC0/vyt0BoGI+wo1h
 0JeODmDsCEERzBT88tSRiGv13TM9mYHG3BSm68IkVjrvlQ87rLtXVOBayt2inH8qWiFM
 87JxmaX8gGaJggj9CDt2zTBw2BdhNAO/wnJag9GJRhmK1iisQ8tJT1ui8KUscP53rDn8
 qDjmW72fQD88Ot3TaReLAmktOIyKlwwqBZK5AAd7YdLmwj4NUfp4nCwHJ0i9xUGlmScz
 G5QkI8yTUPXNRo5Xo9CRcC2OZf3qL4wrCctFLXdC7/Fj9kEVkN3JOHXngjitoRgkrIYt
 1G2w==
X-Gm-Message-State: AOJu0YxCxBIYfK9uZIR/tEFkmTGtZHNRoiASkcvxn8y4PxkkmswsKwVN
 sh9hW7wvRv8pwskZLc8olC7Mon8mTuEbRvCQGBsoctBOzMS17HrIZNvHlg==
X-Google-Smtp-Source: AGHT+IHCkWBdITJyHXkmqiOG/rqTzrXIaLB4DtfW5qa5Go9h7vo99w9+VJ3SxRvp+igvs3cGCWDJTA==
X-Received: by 2002:a05:6a20:8401:b0:1c0:f648:855f with SMTP id
 adf61e73a8af0-1c6fcf0a3f8mr571114637.18.1723086270803; 
 Wed, 07 Aug 2024 20:04:30 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.92])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b3a9cba6sm2363542a91.12.2024.08.07.20.04.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 20:04:30 -0700 (PDT)
From: yaozhenguo <yaozhenguo1@gmail.com>
X-Google-Original-From: yaozhenguo <yaozhenguo@jd.com>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org,
	yaozhenguo@jd.com
Subject: [PATCH] qio: fix qemu crash when live migration
Date: Thu,  8 Aug 2024 11:04:11 +0800
Message-Id: <20240808030411.76990-1-yaozhenguo@jd.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=yaozhenguo1@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

qemu will crash in live migration cleanup process at source host.
BT is as below:

0  0x00007f740fc9e165 in g_source_destroy () at /usr/lib64/libglib-2.0.so.0
1  0x000055a2982a0f6e in qio_net_listener_set_client_func_full
2  0x000055a298345130 in tcp_chr_update_read_handler
3  0x000055a298341598 in qemu_chr_fe_set_handlers_full
4  0x000055a298341655 in qemu_chr_fe_set_handlers
5  0x000055a298191e75 in vhost_user_blk_event
6  0x000055a298292b79 in object_deinit
7  object_finalize
8  object_unref
9  0x000055a298292b3c in object_property_del_all
10 object_finalize
11 object_unref
12 0x000055a298291d7d in object_property_del_child
13 object_unparent
14 0x000055a29834a3c4 in qemu_chr_cleanup
15 0x000055a298160d87 in qemu_cleanup
16 0x000055a297e6bff1 in main

Crash reason is that qio_net_listener_finalize is called before
qio_net_listener_set_client_func_full. so, listener->io_source
is used after free. fix this by adding more checks.

Signed-off-by: yaozhenguo <yaozhenguo@jd.com>
---
 io/net-listener.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/io/net-listener.c b/io/net-listener.c
index 47405965a6..c02965f919 100644
--- a/io/net-listener.c
+++ b/io/net-listener.c
@@ -143,6 +143,11 @@ void qio_net_listener_set_client_func_full(QIONetListener *listener,
 {
     size_t i;
 
+
+    if (!listener->nsioc || !listener->io_source || !listener->name) {
+        return;
+    }
+
     if (listener->io_notify) {
         listener->io_notify(listener->io_data);
     }
@@ -264,6 +269,10 @@ void qio_net_listener_disconnect(QIONetListener *listener)
 {
     size_t i;
 
+    if (!listener->nsioc || !listener->io_source || !listener->name) {
+        return;
+    }
+
     if (!listener->connected) {
         return;
     }
@@ -301,6 +310,10 @@ static void qio_net_listener_finalize(Object *obj)
     g_free(listener->io_source);
     g_free(listener->sioc);
     g_free(listener->name);
+
+    listener->io_source = NULL;
+    listener->sioc = NULL;
+    listener->name = NULL;
 }
 
 static const TypeInfo qio_net_listener_info = {
-- 
2.43.0


