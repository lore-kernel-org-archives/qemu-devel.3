Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A27CCD1BC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 19:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBeTt-0002ud-H1; Wed, 22 Oct 2025 15:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTf-0002su-Ru
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBeTb-0001WX-Rq
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 15:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761161186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWalDO9UGdGD6EJXyoisbCsd9GWW6yspcoUh/J0vPH0=;
 b=U7Lty0a7XWoqhs9b0xnD8DTThYHYSiOEgYZi92s5PfpRclBL9jrh04QHzXZII21UDMpFYB
 jEk8uaMhabDv+OYg4Y5jetgqnuTWdbM2TBidwXALLwwY/xc3cVKDI3/4fE3zDA4LZxeLdU
 8sFHHze9LFpt/bIqOB2AGlzABEBaRI8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-7k1KVtluMhGIudvI83ItOg-1; Wed, 22 Oct 2025 15:26:25 -0400
X-MC-Unique: 7k1KVtluMhGIudvI83ItOg-1
X-Mimecast-MFC-AGG-ID: 7k1KVtluMhGIudvI83ItOg_1761161185
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e8a89c9750so49670071cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 12:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761161184; x=1761765984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SWalDO9UGdGD6EJXyoisbCsd9GWW6yspcoUh/J0vPH0=;
 b=BFE0C+7KNGIa1Np3PWB6brGkgxT8hWDsesheOCmVd6QNJ2g8TBYBDwPUzrwGjTX/Vq
 HrjTAKUF6zoQ34UwOJ401wg9rsgpex+QfCsD28hHP7DrjvMX7FXpPnt9zCSehktm2XNu
 5hiainQKcizb0xIwJp84j571OtqFCkwiabGwRpUW1i9vu/KUcNBvkkg/bERnXfdeWCMU
 PsEc+P03xL1n0wmZALYD2IZO7v+9+0jN55DsCw6qFCP3NZhDS04kJE9628y6p+/ugOn4
 OZKBVo55XofHPJ8AZ+az5fGXt9G08x/atVu7qob9kRv7jUb1uZEiSjHc9KFl6izOfSAd
 573g==
X-Gm-Message-State: AOJu0Ywc7Fwb//XfO0yxp3B7unH4QAnCk3FeSkOmauTgomEs7zsWXIS/
 /OjcVzQcqVRPfFRd4rHNFaKHEZyzU8Tfa8GBsWJmH1j5qcVmgUSofvyJiW8grhE5q3uWpq/6f+q
 wzsGuLENuqlT4CJae4f5BFYkwAKYWm9IKv810QajoneFmJL6JSAeqJtr/fseaHq949iQAZslJhI
 Ipra/blaH7ppSFlpfw1SfUNSRV4csiF2Wlq5Ac+w==
X-Gm-Gg: ASbGnctMSkcmFK8a5POIUBwjZAYm5VjZr9yt/5r0phx85Xqg+8W0wJdjozQB4EMCV7Y
 f5BcEkrtH++eASO8fh3drNrfIO2hVHV5zyHiPn02rHgPh3F/RHdBTmW788kwjqHveCaluxt8IiF
 4elDNGXKJlBfSe+25o10jaqH8erVCEq8dRkbvql7aLn3nymwdKs8EWOpkVh729YDopdX6zH+SX3
 GnCAExorNA+5D+8PicKB5YryGxvScCbtKf85C9hcmmu2ViFdojzfdpq0T/7Ajcbh24nzeNjOk+u
 fL1enXPntBz4rOTVP/GYXP0gdDI1gv3j0bAoTEeyc3CN3OjmWr1tkUk1no7D+qMW
X-Received: by 2002:a05:622a:1191:b0:4b3:104:792c with SMTP id
 d75a77b69052e-4e89d38e3b9mr278915311cf.57.1761161184155; 
 Wed, 22 Oct 2025 12:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhOrheVBqGyXuZA/rrIXuxaqUX5Nv0oDj04wJbzKRE259wtQ9DQInY23Vhj8ZgGOwfFTrhbg==
X-Received: by 2002:a05:622a:1191:b0:4b3:104:792c with SMTP id
 d75a77b69052e-4e89d38e3b9mr278914801cf.57.1761161183608; 
 Wed, 22 Oct 2025 12:26:23 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e8aaf34307sm99748561cf.1.2025.10.22.12.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 12:26:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Prasad Pandit <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 05/13] migration/rdma: Change io_create_watch() to return
 immediately
Date: Wed, 22 Oct 2025 15:26:04 -0400
Message-ID: <20251022192612.2737648-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022192612.2737648-1-peterx@redhat.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

To be eplicit, incoming migration should always have marked the iochannel
to be nonblocking.  For non-RDMA channels, what happens with current master
branch is when we have nothing to read, QEMU yields the coroutine at
qemu_fill_buffer().  For RDMA, what I see is it always polls on its own and
it yields at qemu_rdma_wait_comp_channel(). A sample stack:

  #0  qemu_coroutine_yield
  #1  0x0000562e46e51f77 in yield_until_fd_readable
  #2  0x0000562e46927823 in qemu_rdma_wait_comp_channel
  #3  0x0000562e46927b35 in qemu_rdma_block_for_wrid
  #4  0x0000562e46927e6f in qemu_rdma_post_send_control
  #5  0x0000562e4692857f in qemu_rdma_exchange_recv
  #6  0x0000562e4692ab5e in qio_channel_rdma_readv
  #7  0x0000562e46c1f2d7 in qio_channel_readv_full
  #8  0x0000562e46c13a6e in qemu_fill_buffer
  #9  0x0000562e46c14ba8 in qemu_peek_byte
  #10 0x0000562e46c14c09 in qemu_get_byte
  #11 0x0000562e46c14e2a in qemu_get_be32
  #12 0x0000562e46c14e8a in qemu_get_be64
  #13 0x0000562e46913f08 in ram_load_precopy
  #14 0x0000562e46914448 in ram_load
  #15 0x0000562e469186e3 in vmstate_load
  #16 0x0000562e4691ce6d in qemu_loadvm_section_part_end
  #17 0x0000562e4691d99b in qemu_loadvm_state_main
  #18 0x0000562e4691db87 in qemu_loadvm_state
  #19 0x0000562e468f2e87 in process_incoming_migration_co

This patch may or may not help in reality, the whole IO watch may or may
not be working at all for RDMA iochannels.  In all cases, this patch makes
sure above will be the only place that RDMA can poll on IOs.

Tested-by: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/rdma.c | 69 +++---------------------------------------------
 1 file changed, 3 insertions(+), 66 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 13dd391c14..0e5e02cdca 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2776,56 +2776,14 @@ static gboolean
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
@@ -2835,29 +2793,8 @@ qio_channel_rdma_source_dispatch(GSource *source,
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


