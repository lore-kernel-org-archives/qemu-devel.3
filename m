Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D85F459ED
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDQH-0006jM-KF; Fri, 10 Apr 2026 11:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQG-0006g4-H3
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:28 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQE-0002IH-VG
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:28 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-35d9f68d011so1484103a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775833524; x=1776438324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4l9Xr1hbjH1tyACtoEoX12/kjkgfEPIxAbMNxctooNw=;
 b=VD2kRAQicJ2apLSjS3dc9r1RBstwYrOwfswsNIpcjB/n10qQ1JuR76/cU74XEGCDu7
 V8DwxA0sIMBKlv7j9r2q9eSDWwix2lJ3y1RX0qYkx+prWYVTzpO2ofzpOJNPzRELnQMD
 iN2rLZtyr1xy4a9cTunTSoX8ilOvn99rXt7WKgBZvD6jX3tTGHR2riLxMIvB3rpImAVl
 o5/4n6f1gSUn28DamlzgIlXIM5y+l5UMREY1DlrnXRUY+KKw+04XHmSGr9Isc/bpy3/q
 X32NeN2dt+vnhzg9uL8tZ2CoXsNjAz0ugHAZHeyrPb1ipRUe65rdjRYBm9Y0iwxxT19N
 XygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833524; x=1776438324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4l9Xr1hbjH1tyACtoEoX12/kjkgfEPIxAbMNxctooNw=;
 b=m/ipLvNEXyYgPMlBwS74ns9SeFiVLt893Ydv9Of80FW4cYQqbaZNBKS4TKGRdX3qXh
 AI2b82SnUkkKUgZF5NEFlAmnOCP+DkYHsQXhvLN+9FFeA+4Ep5rm2xvOkvz0+Q5EVJCc
 y8/NCkDqp/5VnQNKYAvwCzbSShnpwSsx4TevkXS/+PE7wUG4pCeKzYtJqDY9SJNYwqLc
 +DXtpvoOJkAsoFRh8ntS5fo+C5nh3KEW4JKXm+9CcxPHoKeujeip056nvD1xb3drhhJc
 c7P0SLAvcP7InJYma97V9ycmAApD7gR/VJHeuKxS3Vxmsrjfh484L/uY+rAdi7yrvOtv
 4vrA==
X-Gm-Message-State: AOJu0YzPtMZ2U9YQ4I4WyuQ0KasAKDKZLxCnLBn7/u8H1414cuHeX4la
 ikpTUBRXqdippLKx9VYwxzu+gVSK4kD55rPjXm0B6OQ0ZAbSbhROzrZHaZs6WEaj
X-Gm-Gg: AeBDievRSwkb8Qmky+IU7b4kkHL9dT61vK9oTIJlNDOMnW1h9dxRWWIMYqjk7VuPbj5
 07U7SnpYVPsoe9pEtpglIlC/hsBd9Ge8mXh+3ZsUieNK5PBxOHWDrXWJmlWpgoneeIjcA5H3PtH
 Uv6kjzFlU/4Ow5/AMGQ3JOjLeowtq/gJtnzDIvWoL+NId6GTRupDPe87a+2/0whJnPr05LtvOUJ
 4hBGBFugR3pdRsCa9TgjiqFIKFSqnOYM8R6+mv6d9wht/4XgiG004MiupUYDipkGDUThjUm0A81
 ZRwwTFMoa9D+EjzsBp8ZizFn8m/jdtmBMnfNnNsoofMiqaBhk4vhcLnn+Leq6tSBNqB79c+xLIX
 XtgWlwFuX2ODUK18Tp4CBnaH1UNl1P7W0aUVyZHLCApydQupg8l1akTisbjC/nIhzqArQEX90wk
 38o8j2kFgmx4tpS/7TiuRKSlOKZpfhrt3R6Zz5GkfVPZ9t8rpLpGWU
X-Received: by 2002:a17:90b:4d83:b0:359:8a78:569c with SMTP id
 98e67ed59e1d1-35e42827fd2mr3755164a91.25.1775833523456; 
 Fri, 10 Apr 2026 08:05:23 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4131cfacsm3565785a91.10.2026.04.10.08.05.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 08:05:22 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V6 04/14] blockdev: Update tracking iothread users with holder
 name
Date: Fri, 10 Apr 2026 23:04:47 +0800
Message-ID: <20260410150457.85190-5-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260410150457.85190-1-zhangckid@gmail.com>
References: <20260410150457.85190-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102f.google.com
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


