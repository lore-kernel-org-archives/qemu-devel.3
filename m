Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BC9CDE000
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcHjo-00053g-6S; Wed, 24 Jun 2026 03:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjd-00052d-Sj
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:22 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wcHjc-000343-Bc
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:09:21 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c890110acdaso258357a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782284959; x=1782889759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tDeHKlljfDpSkFWWN2SnpQW0cIV42Ft5R4hhaWwRewI=;
 b=j53VQsh3DKsy0WUlHibx8r8PwKOUwMPcHAQhjUbaMHtoDnPQfwRDJhj3V5kmWd0n+3
 dupiyO7ie4dvivfonHhjIvOF7KENL4t3z/Kzsl6EFBRrlaDI2UO1MfUwZ+o4ossiQcrn
 fHTpannKZa5DGKOvwz+ZIVywuEXmI10YIC0atRh6qaAqvOAO9ZbRMY6aTg6JyyG7awQk
 xwp0YxbxTJL4raPqqNfbgLC5HMNFKLOHYm+ydOEG1AJm460+6G1Nj4m/YulhPXvQD62a
 mW6vO7GmGRJAPfChmdyPdkdiEo9sGEIybsTVqhLRRZ77iLh7EPpsG57TOq5jTbn0Je0U
 4mRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782284959; x=1782889759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tDeHKlljfDpSkFWWN2SnpQW0cIV42Ft5R4hhaWwRewI=;
 b=pXgFYkeFIPWA5Dxoj2KJSHd1pZ/elzmAqRijXjyeF20e8th6LGqhRAvLcRfVcH5ib9
 eZAv+TTPwK1tIzamLjQQsS/2GPncz+WrrlsmFwnI96Ve6yZxRItDvaa8usbIVMkTHijn
 ScOcga75ThLxo5aeO60wDvpYFJFY5QDSL2R7Wnns9MNLRztTp3kLjHTt0Izex7viLhKe
 mrnl6izm2SfwTA04H1I4c5pcfMHXi8IrYzHCquM4pEzJUlF4qjpqKS77kvOgwsVS/7RG
 ti77kIH9LZLIFxZ24G/W4lydE5DDffqpc2kugWm2SFLX3ldYRg8nF35hL4UV3Xw15CZc
 0Tng==
X-Gm-Message-State: AOJu0YzY656PQTbLu2dHUkOoZ4c8q7eOpe7yaoM2MFzR8dKExqORw9KI
 hW2w6UAjfrN6tuVF9cEH8Q223PNSwbDbYzA4HSILqJw2+I8lyms1nNtKcsFlmOWNHdA=
X-Gm-Gg: AfdE7ck+2T6LLPuGdLXzDy6nKqVomCxEwLlZ1jqtlZwv1SL94okrNmd+H9QvmHjzDrw
 uigngBGik0tGIh3g+FA2H/9sv6TkxGdKtGj00zbYZPpnXf9RxPwLp+j1lrkUmJ8H/Szm5+4AWDp
 OHYn+gkW6xnm7Du6h+NOV7xR4PA5lYl+iU1xrNZXuy5/WfAQp5nB4Wf9rn6JjnzATiqZrVAQdMD
 c/bUFadp45YwWQdvu0TAzynpqX2yaDo9RmS7cMq8It8f4bDIpjTBt/Whcq9x74FDGYfnt5NFx3W
 yXGnDMxOk2VhE0FmQWcW6sE4kXLErC56SUcDsli37cbfJa4Y/ZDzRYWg4vXNihQgzT0o02xAOji
 dKaL3Qg2dPyLAU86/t5yYUMvKBJ6VDVWefBpvscBjL4JJiCybqyqxx3m7a3PGpYlZ3lQgmgjup9
 dRRgxCtJLrYm0YlrT3un7tPIdhFwPfee89EEfqAaOAKR7CT7K1c2Jf
X-Received: by 2002:a05:6a21:117:b0:3b7:8e6b:7001 with SMTP id
 adf61e73a8af0-3bc51b6d080mr21052068637.12.1782284959095; 
 Wed, 24 Jun 2026 00:09:19 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::1277]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8bc2c8e92asm10736569a12.2.2026.06.24.00.09.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Jun 2026 00:09:18 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V9 04/17] iothread: introduce iothread_unsafe_get_aio_context()
Date: Wed, 24 Jun 2026 15:08:38 +0800
Message-ID: <20260624070851.13342-5-zhangckid@gmail.com>
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

The iothread_unsafe_get_aio_context() is a low-level unsafe way of getting
the AioContext, recommend migrating to the new API with IOThreadHolder
as much as possible.

The blockdev is the first user:
Every BlockDriverState would need to get/put the IOThread AioContext in
bdrv_change_aio_context() or related functions.
However, the QEMU block layer has been moving away from having a
per-BlockDriverState AioContext. It is possible to use a
BlockDriverState from any AioContext (including multiple AioContexts at
the same time). I'm in favor of not associating BlockDriverStates with
IOThreads and instead relying on their device owners (e.g. emulated
storage controllers) to be the IOThread holders.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 blockdev.c                | 2 +-
 include/system/iothread.h | 6 ++++++
 iothread.c                | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

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
index b483bbfab3..064c05e78d 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -71,6 +71,12 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
 char *iothread_get_id(IOThread *iothread);
 IOThread *iothread_by_id(const char *id);
 AioContext *iothread_get_aio_context(IOThread *iothread);
+/*
+ * The iothread_unsafe_get_aio_context() is a low-level unsafe way of getting
+ * the AioContext, recommend migrating to the new API with IOThreadHolder
+ * as much as possible.
+ */
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
 AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
                                              const IOThreadHolder *holder);
 void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder);
diff --git a/iothread.c b/iothread.c
index 528002c34a..a85e960e45 100644
--- a/iothread.c
+++ b/iothread.c
@@ -468,6 +468,12 @@ void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder)
     iothread_unref(iothread, holder);
 }
 
+/* Recommend migrating to the new API with IOThreadHolder as much as possible */
+AioContext *iothread_unsafe_get_aio_context(IOThread *iothread)
+{
+    return iothread->ctx;
+}
+
 static int query_one_iothread(Object *object, void *opaque)
 {
     IOThreadInfoList ***tail = opaque;
-- 
2.49.0


