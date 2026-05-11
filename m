Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA40CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRHN-0002B4-5H; Mon, 11 May 2026 10:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRG6-0000VS-7N
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:22 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRG2-00070v-3f
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:21 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c80203b9d7bso1692776a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508298; x=1779113098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4l9Xr1hbjH1tyACtoEoX12/kjkgfEPIxAbMNxctooNw=;
 b=nkjlZpmt9b6HKzhBTsnbCt0mEHsG8zoAOe+l55ou1etqqfGA3SnELxizO1IKa+Th8I
 T0gP4vyx+qUeiw89R6iC0AgsQCDAhRGxLDupNK6pBn524GpIw5BSttvcf+via1AAJTFz
 1VnzngiYklMiVfB7AYxmvGzbsUTayGo/Un6adq40NWeIQM1Pubyauja8E32vb8M9gH4I
 4P8JHpNpSUhPibSTptcGCYLkWt+rPpOQP9rPxQohjLePTM20N5nTJHZENYRgN5i06Gbg
 ZCq2BZQROcHf3a53S7nLAjftzXvu5Z+vWeKFdq3MksN8U3cMad8PO58IV026mfwnJ4aB
 Pdmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508298; x=1779113098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4l9Xr1hbjH1tyACtoEoX12/kjkgfEPIxAbMNxctooNw=;
 b=alP4KgWDQcyqpDGj1FRYU7RDUcjACLcV8DVqtCRhKHPC/qdancZtn0IuHlDJoRCFJz
 mHje0ClUestG9cADvA7zfXIrvpznb6nWWBoAJ1oh/SJStPW7DBf+WqkviESOzrfdBLG6
 ZxuNuF1rTMujSVQTzZDgIIQZDEunnB+Iqxz1WT12ASOrOMrN8OIU0BrPrsnTbHmg/Uss
 q3vKWJp4Pkn+1i0a7X0GtuVDNMWdeIgRyjzMRtgnwBc4lN1KrCxXK8c8anBTt6+dZLq9
 3IoIfJX96wiM731INU4+J0qXRr3EV2We6miV3s75Z9X6RDUlBK1FpSA86KAFQhS4wuB5
 1gUg==
X-Gm-Message-State: AOJu0YwRlAOqJRMGvL/IdCG5W3wtxGt/PbwuXfqJWhZgHKDibC8ZlWBI
 Voq4hIgBe95wjLOnpXGii8GJXEM6nwVfg11jY2ALCEytXyejrhHb67nhDW5EigWDJzc=
X-Gm-Gg: Acq92OHTkseABjqhfZjE66X0XqfdRAoBXLYTGjHU/2FB+L1gdyoUb7ESGtP6ZLRizQz
 +R3zawbJ1aBjNV3Zdhevw2Z1XIBjJiyTZsuY9JAdjGIImW0vpSri3qFihJyMK81akFHKLIjrdYT
 9UM0/wwePKtey0Ra69nGW4ma0Pp1g9dyxz9E/c13KpAuC6YXW4O3CPc12owC3aIeFR8JbeP5Qzi
 8qZ5bBJ3HzkeWq/qQreQSrvtP4+7+uWsJEPCY4DZk8mk3H8VfqwUY70zU6/HwtETBX6mj6CFZ6J
 zlKMSyuBGQLzoyrE3sRMBZJXGIqYKJjsir+S5f4CwjOL6qqqPBTBV+XHkw23T2TI4wPBwa89iF7
 deL8ddX5tDIVQvWLs/SAC845OAKnzopERoiXYfPnNI8BPq/quyS1nWqMdLjD/IRF++N0dUaCpJt
 lnxKfipi28FBBayLRTpL4nu/LMBLPtgQyGiyMKD72MB4S3wg==
X-Received: by 2002:a17:903:3c45:b0:2bc:7eff:2d08 with SMTP id
 d9443c01a7336-2bc7eff2ec0mr101248835ad.41.1778508297875; 
 Mon, 11 May 2026 07:04:57 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e90854sm105113435ad.66.2026.05.11.07.04.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 07:04:57 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V7 04/14] blockdev: Update tracking iothread users with holder
 name
Date: Mon, 11 May 2026 22:04:06 +0800
Message-ID: <20260511140416.28271-5-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511140416.28271-1-zhangckid@gmail.com>
References: <20260511140416.28271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x536.google.com
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

Currently, x-blockdev-set-iothread changes the AioContext but does not
track the IOThread object itself within the block layer. This makes it
difficult to manage IOThread reference counting (put/get) during
dynamic context switching.

Introduce an 'iothread' field to BlockDriverState to store the current
assigned IOThread. Update qmp_x_blockdev_set_iothread to perform
proper reference counting using iothread_ref/put when moving nodes
between an IOThread and the main loop.

This ensures 'info iothreads' (holders) accurately reflects the block
device attachment state after dynamic migrations.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 blockdev.c                       | 6 +++++-
 include/block/block_int-common.h | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 6e86c6262f..6e20579187 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3683,8 +3683,12 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
             goto out;
         }
 
-        new_context = iothread_get_aio_context(obj);
+        new_context = iothread_ref_and_get_aio_context(obj, node_name);
+        bs->iothread = obj;
     } else {
+        if (bs->iothread) {
+            iothread_put_aio_context(bs->iothread, node_name);
+        }
         new_context = qemu_get_aio_context();
     }
 
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 147c08155f..6edaf53377 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -1101,6 +1101,8 @@ typedef struct BdrvBlockStatusCache {
     int64_t data_end;
 } BdrvBlockStatusCache;
 
+typedef struct IOThread IOThread;
+
 struct BlockDriverState {
     /*
      * Protected by big QEMU lock or read-only after opening.  No special
@@ -1289,6 +1291,9 @@ struct BlockDriverState {
 
     /* array of write pointers' location of each zone in the zoned device. */
     BlockZoneWps *wps;
+
+    /* Track the iothread for detach aio context*/
+    IOThread *iothread;
 };
 
 struct BlockBackendRootState {
-- 
2.49.0


