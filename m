Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20047C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuw1a-0004D2-8d; Fri, 14 Aug 2026 13:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw1Z-0004Cs-1r
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:48:57 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw1X-0007l1-JR
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:48:56 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so1192738a91.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 10:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786729734; x=1787334534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XfQIfRYN7Xq96ddopw2hElc20SqanaOXzgQn6fcjYRs=;
 b=SIM7TINspHpRwgs0vUVmBZhqcKkoKGsycWFW5H6UGxBDKGfK2SHKgv/oU52tA4G0i1
 m84EteUO+HZBL4rJorhH8tWxpQ4MUSqxDEStVKSHvyaVIiAzw2bMyOKKsAh4hQi2MTLO
 ZFQ6dhUwPFnpMxRM7ec3JsnQOMIUW7lYQGSOw1OG6W6H7WH/W5OEIu+tTBGZwDQHZZU4
 oVKG16dHJW7/P8fbHGQ2KzGCoZGcA74vU44Wf0zGTAcHJ766lw7E45iFAt2y37Yuquwx
 Lp9+A279spR3cUbCTfgTe4jmWvct1MaH11s7teDTPHRawVB3utW+oFDIwNfO3/TEP0pC
 2GiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786729734; x=1787334534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XfQIfRYN7Xq96ddopw2hElc20SqanaOXzgQn6fcjYRs=;
 b=r2JAxRgvmaI14aC4pkf2ph5E/gfCMqWS4aBnxUOCjFAJsp6bD7TyGkPBs6gFX3M0w/
 pb5syU8uZGNRjsrrrAMNX7Ju9H4XZ+U6v+XUSy9K1LrLsNWc84tuFX8wg8/GKsiXzxPI
 0E2Fi49/+mJyEwudgCrJvCYsKhoGSbp36xWIgTAtzmKdiOZY8DOLK+nfFYvO27ewtBY9
 crMILMDGRBDUhYztavahnpG8n56HOUHsj7FX/1UpPJ4MwfwIV2MpmHd7LIOAWEKK3Hi6
 ATGVOAd9O4uywgXWSoYrPHlpDg5dEsYxgsZ1yygBLzezguaJCy+EmmVbtgoNJtG9XEFt
 BpWA==
X-Gm-Message-State: AOJu0YyWEwIIj5UVwch654z1qre16CLyBicLOstWZk10IeFbSWPZsi45
 ps5zG8ndqBoG84yXULuBoXG3abBV8vrHR100Ipe+P5xLvZql0xpa8X9EKgznTWxhl3gFgQ==
X-Gm-Gg: AR+sD126jnKjQfOEQ7yhekwrHHhtPMTtFqwHxauogUXKaeIhy0HPw3bCTQ8Ea4CjFj7
 5NK+Q+6hlNLosYPp6NOaQSFXbtt+l74nolCHpBlwwz99iHWZZFo+HX1xuXDlYTSh4vFwuly8TtJ
 V5XL2VLyCWhFz0MittlDUKeRsVZ3N+A6V/khk8P+vkrTFrxLtyfpKXiAyxOle1Ruu6BSJFOvlsJ
 yZgn8gE3tTN5v5gzNMi9L0ED83wCWK1X8PSG+G+gKNjU0dEqcDdRJvIzoDCsQUo1Tnbr+3UvOPV
 D/xnXrHRdYFXoP6/jS8/5IeU4GrFDozxZiGqOBhPLCmHXVwAox7mjbxVPYs9WT4LHAmu6w/1bJt
 k04pLrh99oHhjdu0g7LFStsS6uiQctP3kehzQ6BaSgockdBRNccZ27HTgv4v5ILAFATA5N9/aLI
 OwThYcPH9wdPX4LESamQrbk4emM8rEyPzG0ckTBS7n9ffxugf2O0JwdY/O9g9mkuKa13PKoRhP0
 fJN+MyVvhc7zhJjudLC
X-Received: by 2002:a17:90b:254d:b0:38e:e9b:ffa4 with SMTP id
 98e67ed59e1d1-3933b75bc6fmr8721232a91.6.1786729734023; 
 Fri, 14 Aug 2026 10:48:54 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320e9df03f9sm6708081eec.19.2026.08.14.10.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 10:48:53 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V12 04/15] iothread: introduce
 iothread_unsafe_get_aio_context()
Date: Sat, 15 Aug 2026 01:48:18 +0800
Message-ID: <20260814174830.1691540-5-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814174830.1691540-1-zhangckid@gmail.com>
References: <20260814174830.1691540-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add an explicitly unsafe accessor for legacy callers that cannot
provide a matching holder lifecycle, and convert blockdev.c to use it.

Keep iothread_get_aio_context() temporarily so that later caller
conversions remain independently buildable. It will be removed after
all production callers have migrated.

New code should use iothread_ref_and_get_aio_context().

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 blockdev.c                |  2 +-
 include/system/iothread.h | 10 ++++++++++
 iothread.c                |  5 +++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f..baeab3a3e1 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3683,7 +3683,7 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
             goto out;
         }
 
-        new_context = iothread_get_aio_context(obj);
+        new_context = iothread_unsafe_get_aio_context(obj);
     } else {
         new_context = qemu_get_aio_context();
     }
diff --git a/include/system/iothread.h b/include/system/iothread.h
index f6c5f95dd9..2ef8c1a1bb 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -68,6 +68,16 @@ char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
 
+/*
+ * Return @iothread's AioContext without registering a holder or taking a
+ * reference on @iothread.  The caller must ensure that the IOThread remains
+ * alive for as long as the returned AioContext is used.
+ *
+ * This API exists for legacy callers without a clear ref/unref lifecycle.  Do
+ * not use it in new code; use iothread_ref_and_get_aio_context() instead.
+ */
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
+
 /*
  * Register @holder and return @iothread's AioContext.  The holder is copied,
  * and a reference is taken on @iothread so that both the IOThread and its
diff --git a/iothread.c b/iothread.c
index 64be852d1c..3afa296aa0 100644
--- a/iothread.c
+++ b/iothread.c
@@ -443,6 +443,11 @@ void iothread_unref_and_put_aio_context(IOThread *iothread,
     iothread_unref(iothread, holder);
 }
 
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread)
+{
+    return iothread->ctx;
+}
+
 static int query_one_iothread(Object *object, void *opaque)
 {
     IOThreadInfoList ***tail = opaque;
-- 
2.54.0


