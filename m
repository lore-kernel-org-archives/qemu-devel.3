Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B1DE8FDB1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 10:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaAfo-0007rj-J1; Mon, 29 Dec 2025 05:40:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vaAfE-0007pM-Sy
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:39:50 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vaAfC-0000G7-Fi
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 05:39:47 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a0d0788adaso79350955ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 02:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767004785; x=1767609585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+a3OwfwQBO2otyKeHBN1LrQH4TMfKPwgsXvF1+xAS4A=;
 b=M4BHrubz8gfDZllcsd6CbCqKfnfq3hzvKFikwQ3Siu0uEkBZXTwKJPlF0owNvC0SSv
 KEAOb/TOdxelessIj4Q053NssotG8LXOLNLWxvAE4KEHNzamM+blCBMSgRiiZEARDsZp
 D+P9UH4+9TMhgpPXIwSdssZvJt0STKmjlX06klevPMTLusU1K8aZfwx+3Xzry7SJj0p1
 +A4fEwBJbQTXO07W3glrlFcfi03Ce85m2V7BWtfSxOVUu4VkC3gwnKABlZdtxcaB3i+v
 3TLHLaaREOgmEdzp3rb1Ijsl9SZMHv2LAf7aHkZD4Y/EvjirCar1hHvRq6bLl8sSngd4
 2SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767004785; x=1767609585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+a3OwfwQBO2otyKeHBN1LrQH4TMfKPwgsXvF1+xAS4A=;
 b=sJe81gBf0f6brfZ3C50ok6Xz5TB1zUtQTTWT/ny/fLaDld9UNGXh1vWsYf+0HGB0cp
 FZWfTwozBtuD05G8C1gGAwK7KpF6ATulpktGxIxDS6pOnF8ar7lQbi79FOcpzvI8Gy0h
 KZwSuE8ajADdqeyriHi/BzmuKB4YGve/0Y6zDD0nGZMpbxpt5EYunT6QJySbicN+7Lyw
 GdqBNYJwwMboWXeV0gZDCAERy5bvJM8Rwx50EwqHg9mhdvFmuH//2SDUzVwZdLbzDeC9
 67vskgeNOldo2S1WQNq4Y77Uj+Zs9G7OWsfFvglZ/j6VCSRNqrswop09/amujyM+QtWk
 kX8w==
X-Gm-Message-State: AOJu0Yzh+n4NmR/iaW/xrDtQlvt1H0H32x/AGohv9CgSf6laE5P+iByv
 EZOsdlM3aTMGTOzlCWbo0uxaFGG6Fj414RySOAsvkHxzpZZRyditR9AR7+KTtmZl
X-Gm-Gg: AY/fxX6c1ExrIGw8VzGK5zphDgzruLnmi0hlslas1QRI02pqznZDidUHvAp0MqawCNk
 7OTkeANwkZSZAqiIGpwin463LbB6Zrc2MWos//5riMAfKw5AgTxLRkYNIp/277LApuEEUkomi/w
 ZjzArmadMEVJOyzsQbmMNImm8LnD1NksyZkzs2WCGH+nQCkQImIbfwcZHm3TbQyFUyUaa4TI+aM
 vhy6T6oWzEyNulrXpMtzifDrV/fDlYIkwstvatOJ06moHY/17+usU4apq8Z7Q+o2g+smf4/wX1S
 7lX5XUulic/AKCi22rduNsO3KKFzt7rGcJjmKxkHpN4K1MNCQhTx6aEtrriBmnj7zS/O28mfTUX
 l9Bhm/GhScl9R6kJAAu1X2gtrz06IF3j3tkmMkKKJH8uAEb9VRO1yAlJTRL2+ScRbuGzzVBpPFN
 FyjAVsx4E5gR8=
X-Google-Smtp-Source: AGHT+IHZ1LWkZNrvLzOA6GfZExyw28UHbqiYu1WiamKzCVIiRLikvdJjTa2FFN4KVLkaoxVhIDudUg==
X-Received: by 2002:a17:903:1b4d:b0:2a3:628d:dbea with SMTP id
 d9443c01a7336-2a3628de27amr100690955ad.24.1767004784607; 
 Mon, 29 Dec 2025 02:39:44 -0800 (PST)
Received: from localhost.localdomain ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e76f03baesm17082982a91.2.2025.12.29.02.39.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Dec 2025 02:39:44 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH 2/3] iothread: Introduce a new flag to show iothreads attached
 status
Date: Mon, 29 Dec 2025 18:38:58 +0800
Message-ID: <20251229103859.98777-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251229103859.98777-1-zhangckid@gmail.com>
References: <20251229103859.98777-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x632.google.com
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

QEMU Need a flag to show current iothread attached status
when hotplug multi iothreads. For example virtio-blk.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h | 1 +
 iothread.c                | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index e26d13c6c7..3d00474523 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -32,6 +32,7 @@ struct IOThread {
     QemuSemaphore init_done_sem; /* is thread init done? */
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
+    bool attached;              /* Whether or not attached to device */
     int thread_id;
 
     /* AioContext poll parameters */
diff --git a/iothread.c b/iothread.c
index caf68e0764..38e38fb44d 100644
--- a/iothread.c
+++ b/iothread.c
@@ -94,6 +94,7 @@ void iothread_stop(IOThread *iothread)
         return;
     }
     iothread->stopping = true;
+    iothread->attached = false;
     aio_bh_schedule_oneshot(iothread->ctx, iothread_stop_bh, iothread);
     qemu_thread_join(&iothread->thread);
 }
@@ -199,6 +200,9 @@ static void iothread_init(EventLoopBase *base, Error **errp)
      */
     iothread_init_gcontext(iothread, thread_name);
 
+    /* Clear iothread attached flag for init gcontext */
+    iothread->attached = false;
+
     iothread_set_aio_context_params(base, &local_error);
     if (local_error) {
         error_propagate(errp, local_error);
@@ -336,6 +340,7 @@ char *iothread_get_id(IOThread *iothread)
 
 AioContext *iothread_get_aio_context(IOThread *iothread)
 {
+    iothread->attached = true;
     return iothread->ctx;
 }
 
-- 
2.49.0


