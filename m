Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3458CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHlS-0006EJ-FL; Wed, 24 Jun 2026 03:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHkF-0005L9-7e
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:10:00 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHkD-000371-L3
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:58 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c8ce8f2e235so412842a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284996; x=1782889796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7t5cTU126FnpUwkoAoirKGUM08oblbAVX84J7t/Z2ng=;
 b=IxQxmtPHAzTEP/1jhGpllS4sujqpY+VjpW8qRJIUyw2O0OLZp4cnnuYxXvCHFY5Jxg
 P9cbQJeLX9Nigcwu+1a55XxNPGg/Y2r7/K2M+BZX/0jyyYlthbmV6GEZjwd6JnfyalHu
 sceI4Df6DN7mvnPlVvf0WoHI4BSndthbz++yDHcH+bFTycBuldH5reOKXbjQ8ErQqlbw
 SyPT7BZs9fiJ2eMlDGC2nJSMpV1PpHFTMmpb4BPh4aEuqXeI7Dcl5okpRcX4mnItW3Ey
 bc0PGwehQ16p60EFeWm7ZE8wL0e6wWfEmfTkhnVJTuAwt5i2adMjAkuJS2dAkmJWD8Xm
 KLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284996; x=1782889796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7t5cTU126FnpUwkoAoirKGUM08oblbAVX84J7t/Z2ng=;
 b=mfNJe/fdzoepetIJV2YiaBZS0uUzxEWRMF6z1qOj6ONbSMnHs1JP4O5SWqRPuO7cik
 O/RNN8Vwzf+OyuPJetvwGKAqC0iNt7sUBDF17g6wZ4P7RptVsjP6NqqhSXy8MByi4ijS
 cTqBw9dHf1eVpntHhMCNPE6nKrUvfYvqK0SnJ1Hq1dVJ2rzojc9YIGBT0AqDPzhHrlNE
 fyD8bZVIRBdhQry0EAx9WjoZwScbk+l0OF1TXB0yK+90sWFBbYwBdE9uyM5W1dzC+uZ8
 swSj5yFYD1A2PWOYU6tRDOjqY1wIHEI24yhrqUmRf0KynoMPnzsVw6hTDtSrYmzb/OZ0
 KwXw==
X-Gm-Message-State: AOJu0YxUtSTPBGWSultLhFqR5bzd+eE7ifjqP7PVpbUqePMJ2XJfTqFR
 p/QzQ02zOES/kfDr0mQuhDgszbvzbcThs3FdHf4Spai4SxfZdWU7He7XEkB3DCSYCsw=
X-Gm-Gg: AfdE7cljCD5GFTOUg+iOaqGCG883iqr+RaecbXPw4kQ3kKQGQ8mHSg0saqwxdETAhJC
 CMsajoxl4oObbJt+x8dzbjdcfqpgQ0Ob82w0Ij7XhXkxSskMKbzB4uhliVjCCefcdo+BVyvyZOJ
 KPouLWGRk9S4UYGfasCh9UVkyivXcDCQwCN1BgNj/SlO4Kr8M4A/Z+a+LdbUFGUtl6D0WrQDAMB
 eRYBfYuoSOODKBoKzpUZM91PMgSIISZx+AdYMUGd+WCZqFGw+ohyGjN+PEokvaEmNGKFtraLMR8
 bkBP2Nk+JJnHvXKtDz05WHIkOS2fgdtXtMLKWfvPaNMgbe+EUZpiPisFiJjstGR1nVx/DnFkn3f
 92nXS2s7Al01Lt1z1WgTpmPTGxTHny6mY3LX1kXEMuVej8FHjsXU5+VW7Pm8SK7a4Gope9Snb2I
 XIom1yu6mfH00a7307wGbWJrLR0ABvf4xU3Gf6r5vYwKbxXCqpr/CM
X-Received: by 2002:a05:6a20:3d10:b0:38b:eadd:449a with SMTP id
 adf61e73a8af0-3bd2d2ec5d7mr2686736637.38.1782284996465; 
 Wed, 24 Jun 2026 00:09:56 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.09.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:09:56 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 14/17] xen-block: Update tracking iothread users with
 holder name
Date: Wed, 24 Jun 2026 15:08:48 +0800
Message-ID: <20260624070851.13342-15-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260624070851.13342-1-zhangckid@gmail.com>
References: <20260624070851.13342-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace raw object_ref/unref calls with iothread_get/put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/dataplane/xen-block.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/block/dataplane/xen-block.c b/hw/block/dataplane/xen-block.c
index 48c2e315f3..b5bf8d359f 100644
--- a/hw/block/dataplane/xen-block.c
+++ b/hw/block/dataplane/xen-block.c
@@ -621,9 +621,15 @@ XenBlockDataPlane *xen_block_dataplane_create(XenDevice *xendev,
     QLIST_INIT(&dataplane->freelist);
 
     if (iothread) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(xendev));
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
+        };
+
         dataplane->iothread = iothread;
-        object_ref(OBJECT(dataplane->iothread));
-        dataplane->ctx = iothread_get_aio_context(dataplane->iothread);
+        dataplane->ctx = iothread_ref_and_get_aio_context(dataplane->iothread,
+                                                          &io_holder);
     } else {
         dataplane->ctx = qemu_get_aio_context();
     }
@@ -652,7 +658,14 @@ void xen_block_dataplane_destroy(XenBlockDataPlane *dataplane)
 
     qemu_bh_delete(dataplane->bh);
     if (dataplane->iothread) {
-        object_unref(OBJECT(dataplane->iothread));
+        g_autofree char *path = object_get_canonical_path(
+                                        OBJECT(dataplane->xendev));
+        IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = (char *)path,
+        };
+
+        iothread_put_aio_context(dataplane->iothread, &io_holder);
     }
 
     g_free(dataplane);
-- 
2.49.0


