Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B10C41513
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jul 2024 11:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSx8c-0006Gy-9q; Sun, 14 Jul 2024 07:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx8a-0006Bi-JY
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sSx8Y-00029r-N6
 for qemu-devel@nongnu.org; Sun, 14 Jul 2024 07:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720955486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JU35dLNvZmB9zyjiP8aa02bKtvhRGQs0KzD05llqlsY=;
 b=Z85J1LpcUWcw9UggaGs2iCcSqO2BH1KbveEThQZYhlkapZFZTBwCi6zknuZU6ePB2nnQBT
 zZbLkwDVzLJmh5COUzbyFuTqzacT9TB8RLtRwIgMP+z531dpWT4h+WXj4Et4zMuLRF5R3G
 QqS4OfcSzgxSn9W54z3X6goCLS7fGHM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-bNqOqEAbNwO5DfzIb9wahg-1; Sun, 14 Jul 2024 07:11:24 -0400
X-MC-Unique: bNqOqEAbNwO5DfzIb9wahg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36796a0687bso2350221f8f.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 04:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720955482; x=1721560282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JU35dLNvZmB9zyjiP8aa02bKtvhRGQs0KzD05llqlsY=;
 b=UQgfdsRMZ2H2BtcbWI8RkFICf5rn7W035CtCJjFIgxZhWZRGCw/jnddG8CB2OT7h6s
 5VPBMNWlL+aFvtxAOn/2W+kt0zML9z99Ql8OLgZXD4JhIUBqV/7aFQ5f+U3LbH/jpQk8
 8kk4DOvow+B/mhLZKvKdBoS8PdlJtGcQkZ+3GHumzmDoYYt3PbuD6Fg2xuFd/sQLScxo
 8bNbsdJEBbCP11AG29hTg9SM7LxYRV2b1UaBOsx2N+kk/M82WLsOr1KoTyZYHMDYgxie
 Y3eutHn5ssXOFtMbe7J7Tw3RcXU2lCK9nS8eDToOakzRGP46clMwp6t5c5PNB6WqVLO4
 ZGog==
X-Gm-Message-State: AOJu0YzwF5Nfb+Y1EbpNyz86nnjdXGU6HXD4BvPO2mgwe7KIRSiUULm6
 bzYLTe21nddNWy/38EJiBva+x8vvaFgrn/mqdGf2QVMpvhEU7kYOlC4loOArYr4LmRHosGH1a6q
 Q3deopcz6w0CZlfwraaEvXdPlvoEWjLw6dQRVwR+lr2lnsuUgjWHllSResaDfS6cxng2fKJbJtY
 eGQo31ZagJDcFck0vrQ7T9sZsbFd46yUst806l
X-Received: by 2002:adf:e64d:0:b0:35f:11c5:5c74 with SMTP id
 ffacd0b85a97d-367cea963bemr10548515f8f.36.1720955482275; 
 Sun, 14 Jul 2024 04:11:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7g0f7Fku3eAKR837iku5Lba+W1UVvXNJWrubmY1MU038o/gCBn+q+kwEqHn971g0f4+vcSw==
X-Received: by 2002:adf:e64d:0:b0:35f:11c5:5c74 with SMTP id
 ffacd0b85a97d-367cea963bemr10548505f8f.36.1720955481908; 
 Sun, 14 Jul 2024 04:11:21 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dab3c2dsm3613844f8f.1.2024.07.14.04.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 04:11:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sergey Dyasli <sergey.dyasli@nutanix.com>
Subject: [PULL 13/13] Revert "qemu-char: do not operate on sources from
 finalize callbacks"
Date: Sun, 14 Jul 2024 13:10:43 +0200
Message-ID: <20240714111043.14132-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240714111043.14132-1-pbonzini@redhat.com>
References: <20240714111043.14132-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sergey Dyasli <sergey.dyasli@nutanix.com>

This reverts commit 2b316774f60291f57ca9ecb6a9f0712c532cae34.

After 038b4217884c ("Revert "chardev: use a child source for qio input
source"") we've been observing the "iwp->src == NULL" assertion
triggering periodically during the initial capabilities querying by
libvirtd. One of possible backtraces:

Thread 1 (Thread 0x7f16cd4f0700 (LWP 43858)):
0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
1  0x00007f16c6c21e65 in __GI_abort () at abort.c:79
2  0x00007f16c6c21d39 in __assert_fail_base  at assert.c:92
3  0x00007f16c6c46e86 in __GI___assert_fail (assertion=assertion@entry=0x562e9bcdaadd "iwp->src == NULL", file=file@entry=0x562e9bcdaac8 "../chardev/char-io.c", line=line@entry=99, function=function@entry=0x562e9bcdab10 <__PRETTY_FUNCTION__.20549> "io_watch_poll_finalize") at assert.c:101
4  0x0000562e9ba20c2c in io_watch_poll_finalize (source=<optimized out>) at ../chardev/char-io.c:99
5  io_watch_poll_finalize (source=<optimized out>) at ../chardev/char-io.c:88
6  0x00007f16c904aae0 in g_source_unref_internal () from /lib64/libglib-2.0.so.0
7  0x00007f16c904baf9 in g_source_destroy_internal () from /lib64/libglib-2.0.so.0
8  0x0000562e9ba20db0 in io_remove_watch_poll (source=0x562e9d6720b0) at ../chardev/char-io.c:147
9  remove_fd_in_watch (chr=chr@entry=0x562e9d5f3800) at ../chardev/char-io.c:153
10 0x0000562e9ba23ffb in update_ioc_handlers (s=0x562e9d5f3800) at ../chardev/char-socket.c:592
11 0x0000562e9ba2072f in qemu_chr_fe_set_handlers_full at ../chardev/char-fe.c:279
12 0x0000562e9ba207a9 in qemu_chr_fe_set_handlers at ../chardev/char-fe.c:304
13 0x0000562e9ba2ca75 in monitor_qmp_setup_handlers_bh (opaque=0x562e9d4c2c60) at ../monitor/qmp.c:509
14 0x0000562e9bb6222e in aio_bh_poll (ctx=ctx@entry=0x562e9d4c2f20) at ../util/async.c:216
15 0x0000562e9bb4de0a in aio_poll (ctx=0x562e9d4c2f20, blocking=blocking@entry=true) at ../util/aio-posix.c:722
16 0x0000562e9b99dfaa in iothread_run (opaque=0x562e9d4c26f0) at ../iothread.c:63
17 0x0000562e9bb505a4 in qemu_thread_start (args=0x562e9d4c7ea0) at ../util/qemu-thread-posix.c:543
18 0x00007f16c70081ca in start_thread (arg=<optimized out>) at pthread_create.c:479
19 0x00007f16c6c398d3 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

io_remove_watch_poll(), which makes sure that iwp->src is NULL, calls
g_source_destroy() which finds that iwp->src is not NULL in the finalize
callback. This can only happen if another thread has managed to trigger
io_watch_poll_prepare() callback in the meantime.

Move iwp->src destruction back to the finalize callback to prevent the
described race, and also remove the stale comment. The deadlock glib bug
was fixed back in 2010 by b35820285668 ("gmain: move finalization of
GSource outside of context lock").

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sergey Dyasli <sergey.dyasli@nutanix.com>
Link: https://lore.kernel.org/r/20240712092659.216206-1-sergey.dyasli@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-io.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/chardev/char-io.c b/chardev/char-io.c
index dab77b112e3..3be17b51ca5 100644
--- a/chardev/char-io.c
+++ b/chardev/char-io.c
@@ -87,16 +87,12 @@ static gboolean io_watch_poll_dispatch(GSource *source, GSourceFunc callback,
 
 static void io_watch_poll_finalize(GSource *source)
 {
-    /*
-     * Due to a glib bug, removing the last reference to a source
-     * inside a finalize callback causes recursive locking (and a
-     * deadlock).  This is not a problem inside other callbacks,
-     * including dispatch callbacks, so we call io_remove_watch_poll
-     * to remove this source.  At this point, iwp->src must
-     * be NULL, or we would leak it.
-     */
     IOWatchPoll *iwp = io_watch_poll_from_source(source);
-    assert(iwp->src == NULL);
+    if (iwp->src) {
+        g_source_destroy(iwp->src);
+        g_source_unref(iwp->src);
+        iwp->src = NULL;
+    }
 }
 
 static GSourceFuncs io_watch_poll_funcs = {
@@ -139,11 +135,6 @@ static void io_remove_watch_poll(GSource *source)
     IOWatchPoll *iwp;
 
     iwp = io_watch_poll_from_source(source);
-    if (iwp->src) {
-        g_source_destroy(iwp->src);
-        g_source_unref(iwp->src);
-        iwp->src = NULL;
-    }
     g_source_destroy(&iwp->parent);
 }
 
-- 
2.45.2


