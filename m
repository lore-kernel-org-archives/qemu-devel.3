Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863E7CA0FFB
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 21:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urNFx-0006qX-Ew; Wed, 27 Aug 2025 17:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFe-0006je-Ob
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1urNFZ-0006rq-CU
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 17:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756328407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ots0mbGToMDfMjNgyHf67gn8Hoqcw759JCa7SUjENtQ=;
 b=SB/OkPFzTslBK1eILqIk2nvdEGCQyWp2FOFBziCFyFnqyIoZ7zVQBb0nWp5mGLGoQSWm3+
 nBAzJMt6osSdMiaKGdEjt/aUvP0c04T1Loh+2Yu/mIoyj/mjreRBzW03/dY/vJUgucrAnB
 5wWpxOyFoOnczaMyvQkaxffZN8TGRYg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-f-85Goz_NoSC8B3FF1O4ww-1; Wed, 27 Aug 2025 17:00:00 -0400
X-MC-Unique: f-85Goz_NoSC8B3FF1O4ww-1
X-Mimecast-MFC-AGG-ID: f-85Goz_NoSC8B3FF1O4ww_1756328399
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e95391965d7so259332276.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 14:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756328399; x=1756933199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ots0mbGToMDfMjNgyHf67gn8Hoqcw759JCa7SUjENtQ=;
 b=OTVcao8pa9Oo4Zj2KZCPObR39YpUYmSMmW3VUnPAY+sG7b9Q0gJ7gy18S1s85hlhZC
 TK64VOx3x/qqAN9Besyf4i6qg9yo2oExYEdF1xvpSf+EAUDeUTGoLYPr8jbxzMIqzErq
 UNd/oCJX3UNXappeoyNd4sDMnI0liRK/3b6wf6RnycpyjMkKPuUn1bzlpa2mTxPpwqa8
 iNjsrhagsEZZsLLRR/Ei5RDo7FziiWppoVnebPvIzkv+rG55qTMHf0QXByOP3SsezkNx
 AQgRAqLvjk/ep1suGnihdHvFlnbiz9zwvgmtxIbyQ/Xjc5BXmgzDoHa8tvL48hluqsWn
 PXLA==
X-Gm-Message-State: AOJu0Yyo53L88JPxIMG9zGMKzztqFdb1w5to+FFhWYLqMQf9guSdK6vj
 Ex54TsjEoW5MKUmbasu48yOVDPLb8Z9KSg3VZZb3IcpwLt8iBybhn5KksuUisHYdVkD5QLmiS4e
 atrA5QziBoDENIk0dWbnxF5PnyQOMVjtJ1PZY7e37NDkl/UABFELN0jEW4xp+cSizBPkDQcn3L0
 7Zd+D1c2kOsYlQFJ57pRAST5zODBKvaVnh1sUthg==
X-Gm-Gg: ASbGnctp08TXexxIwl9NzBBLxVzBwd7LSXv0A2fdZYGZjzrdaliceOivTRV/qcdwWV7
 2eTvoVqt+AckT5kn7kSYYRvQ7T4PMLmVS+ke07kONvOKvj48Q8Sz9AVq9bdFDADJkdDcBLxSb4e
 xVkSM7hSsAUFRdOh743tYQFJwvuZsRE9vaWhCg7rCApC7ApI10jw1NR5IJC9jR7WsWOlpMDQWLZ
 cpSZVjxx81dxEpfXVOqz7NYblLwHG1qKYcGsTtuRF7c/EgyEXOj8X3e33K1U98e08j6/r2uD8OD
 tMOZdWNAirQM7c8j9IBGiBNdjWp1TkgYWWbNcGRyZrBUQJDgUsRnGFEa5MhIU0iZa16wctbqZ7P
 p/7TajesE8xoBnfjDPJo=
X-Received: by 2002:a05:6902:2b07:b0:e90:685e:bbd1 with SMTP id
 3f1490d57ef6-e951c22d377mr20976266276.17.1756328399190; 
 Wed, 27 Aug 2025 13:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs3leWXEt4Ya1ej3Ts5nJZ9ue7DC4FVdskZXgOfIRYf7NXnKA3osSQ714KktHySUnqQrcvXw==
X-Received: by 2002:a05:6902:2b07:b0:e90:685e:bbd1 with SMTP id
 3f1490d57ef6-e951c22d377mr20976210276.17.1756328398592; 
 Wed, 27 Aug 2025 13:59:58 -0700 (PDT)
Received: from x1.com
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e96e5530a32sm1389846276.17.2025.08.27.13.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 13:59:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH RFC 4/9] migration/rdma: Change io_create_watch() to return
 immediately
Date: Wed, 27 Aug 2025 16:59:43 -0400
Message-ID: <20250827205949.364606-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827205949.364606-1-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The old RDMA's io_create_watch() isn't really doing much work anyway.  For
G_IO_OUT, it already does return immediately.  For G_IO_IN, it will try to
detect some RDMA context length however normally nobody will be able to set
it at all.

Simplify the code so that RDMA iochannels simply always rely on synchronous
reads and writes.  It is highly likely what 6ddd2d76ca6f86f was talking
about, that the async model isn't really working well.

This helps because this is almost the only dependency that the migration
core would need a coroutine for rdma channels.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 69 +++---------------------------------------------
 1 file changed, 3 insertions(+), 66 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index ed4e20b988..bcd7aae2f2 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2789,56 +2789,14 @@ static gboolean
 qio_channel_rdma_source_prepare(GSource *source,
                                 gint *timeout)
 {
-    QIOChannelRDMASource *rsource = (QIOChannelRDMASource *)source;
-    RDMAContext *rdma;
-    GIOCondition cond = 0;
     *timeout = -1;
-
-    RCU_READ_LOCK_GUARD();
-    if (rsource->condition == G_IO_IN) {
-        rdma = qatomic_rcu_read(&rsource->rioc->rdmain);
-    } else {
-        rdma = qatomic_rcu_read(&rsource->rioc->rdmaout);
-    }
-
-    if (!rdma) {
-        error_report("RDMAContext is NULL when prepare Gsource");
-        return FALSE;
-    }
-
-    if (rdma->wr_data[0].control_len) {
-        cond |= G_IO_IN;
-    }
-    cond |= G_IO_OUT;
-
-    return cond & rsource->condition;
+    return TRUE;
 }
 
 static gboolean
 qio_channel_rdma_source_check(GSource *source)
 {
-    QIOChannelRDMASource *rsource = (QIOChannelRDMASource *)source;
-    RDMAContext *rdma;
-    GIOCondition cond = 0;
-
-    RCU_READ_LOCK_GUARD();
-    if (rsource->condition == G_IO_IN) {
-        rdma = qatomic_rcu_read(&rsource->rioc->rdmain);
-    } else {
-        rdma = qatomic_rcu_read(&rsource->rioc->rdmaout);
-    }
-
-    if (!rdma) {
-        error_report("RDMAContext is NULL when check Gsource");
-        return FALSE;
-    }
-
-    if (rdma->wr_data[0].control_len) {
-        cond |= G_IO_IN;
-    }
-    cond |= G_IO_OUT;
-
-    return cond & rsource->condition;
+    return TRUE;
 }
 
 static gboolean
@@ -2848,29 +2806,8 @@ qio_channel_rdma_source_dispatch(GSource *source,
 {
     QIOChannelFunc func = (QIOChannelFunc)callback;
     QIOChannelRDMASource *rsource = (QIOChannelRDMASource *)source;
-    RDMAContext *rdma;
-    GIOCondition cond = 0;
-
-    RCU_READ_LOCK_GUARD();
-    if (rsource->condition == G_IO_IN) {
-        rdma = qatomic_rcu_read(&rsource->rioc->rdmain);
-    } else {
-        rdma = qatomic_rcu_read(&rsource->rioc->rdmaout);
-    }
-
-    if (!rdma) {
-        error_report("RDMAContext is NULL when dispatch Gsource");
-        return FALSE;
-    }
-
-    if (rdma->wr_data[0].control_len) {
-        cond |= G_IO_IN;
-    }
-    cond |= G_IO_OUT;
 
-    return (*func)(QIO_CHANNEL(rsource->rioc),
-                   (cond & rsource->condition),
-                   user_data);
+    return (*func)(QIO_CHANNEL(rsource->rioc), rsource->condition, user_data);
 }
 
 static void
-- 
2.50.1


