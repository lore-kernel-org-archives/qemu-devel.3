Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11618F33A70
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9di-0003uR-NA; Thu, 05 Mar 2026 09:25:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9df-0003tL-1c
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:20 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9dd-0001mH-IU
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:18 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ad9f316d68so35478805ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772720716; x=1773325516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTCF5zOAA44l8G8TLuBObT68V1kn/BPzGs0UeAXkp5A=;
 b=XiltmvotZ5rDviUCKakliAFv05ZCaeryDbS09t3b9VMZXh/oxVfJSVGd28Cr7wBwlI
 9o58qRD6s5R+4gsQ7WD/Kur2xTS0J22vBoFlgKSa+QIDOeDiBzebNFRGospMk6hdDpRA
 UC97a8QUEW/XFuTHrH60BCuCjkinYREx60M2xAZBjhEu26YrMTPY6pfYwkpgfA1W8Gs7
 QIinfIGzugSeAaSfEvFs++an9PbLfgxLvDxYFyGWTPHuUQe/zjCVJUg19XDFSZZ0VjV+
 kyaph3D4f5hh9UOu06EBXwSUpO1EyGDRQU6LqUd3VoVH43GQ5yMAdlN10hEiVRDf1PoP
 LETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772720716; x=1773325516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zTCF5zOAA44l8G8TLuBObT68V1kn/BPzGs0UeAXkp5A=;
 b=OVdjA5KfVLt2iEHH0Jn1GAefPBj1vcXuvfFGpMwpUPNtxSHfV6s6HfLfd3HN0WjAH4
 r4i4Anv+euPAiF3rQnStC6OqdwZYyEWoWpOH05lqgapXuMAv2S0S/lW0Tt7arDpEatdV
 amhcSYuzO/ViEvVQYNjfAIP79zoFfThajq7a0V7M1r8d9ouRZ9Rr0LEpDLst6TXVMOrZ
 wH93pqZVBxUqhitGQb/alI23JPJz+x7pR8jJDpEUXZV3jBDrHSuj1gnkTQgMQ+xJWqF+
 npHc3HfksxE4CoTsrvLXhSkUR2CiFBO5+cDRc9V75AYG/afhUIzlzejpXo2+kJGuy6XR
 nJ8Q==
X-Gm-Message-State: AOJu0YxixkSytiUNkunFaRaR9XPW0pqF3Y4SknCDI2mOdIY0sSMybP+/
 xfJIGs2WKYIKRc6gab+2hlpSsVXmzGIdt9BlYiFJm3Vq7sn7kGQSI7bRX2bM1kvVJ4AuKg==
X-Gm-Gg: ATEYQzxRXrUUkaraiLXZgIJQQJsVHVhJTLziThr7xoTQYvsDZvIe2F9V9HiLyQCHuBt
 zDDCKC4EJ7mSJA14qAkTl/99yKT48P3QQ655RlE7U/nJr3badALWcv+vi3oee1Yb5nS8tcPTMWx
 3Xy3d9Y8cqejeNcwzexvgOWnWZg5DAwz1BCZgDnpMoiRHBK7LZON0mAtKAJedkOt/IwXsyzB3ln
 u9WaR3KS1UrG4hm6oGFZUW02nYDe1S1q0vrWLYMmfOCkpVMWvrs4F1zwqggbtJ3MWMDRqTCLG3U
 VlwQwZYLSQpe0PXefKDRcL3VCPEM9sZq2VK1wMfRBXlh5Z/quodpTZ9L+Xzk52jKGCE8w5Bg5Aw
 CCb2r4/ABXf57Jvn27sbmgeXi2taIRQ80lw7qFc7nkuYGbU0hbIYvGam0GtVnMeKuO4QpLWP6dW
 TCB/KsI5JqFnOBNo8SlR0Ajwzm5V7EaNBjrp9V80E4pF9JDQ6BbRufv+I+LHAxPatIk/4=
X-Received: by 2002:a17:903:15c3:b0:2aa:d671:e613 with SMTP id
 d9443c01a7336-2ae6aad687cmr65171845ad.38.1772720715633; 
 Thu, 05 Mar 2026 06:25:15 -0800 (PST)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49:0:1:b277]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae4650000dsm140204835ad.54.2026.03.05.06.25.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Mar 2026 06:25:15 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V5 02/13] iothread: introduce iothread_ref/unref to track
 attached devices
Date: Thu,  5 Mar 2026 22:24:48 +0800
Message-ID: <20260305142459.52559-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260305142459.52559-1-zhangckid@gmail.com>
References: <20260305142459.52559-1-zhangckid@gmail.com>
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

Currently, IOThreads do not maintain a record of which devices are
associated with them. This makes it difficult to monitor the
workload distribution of IOThreads, especially in complex
hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.

This patch introduces a reference counting and tracking mechanism
within the IOThread object:

- iothread_ref(): Prepends the device's QOM path to a list.
  Note: The IOThread takes ownership of the passed 'holder' string.
- iothread_unref(): Searches for the device path using a custom
  string comparison (g_strcmp0), releases the associated memory
  upon a successful match.
- holders: A GList storing the QOM paths of attached devices
  for runtime introspection.

This infrastructure allows management tools and QMP commands to
query the attachment status of IOThreads.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 include/system/iothread.h |  1 +
 iothread.c                | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index e26d13c6c7..21a76bd70d 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -33,6 +33,7 @@ struct IOThread {
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
     int thread_id;
+    GList *holders;             /* an array of QOM paths for attached devices */
 
     /* AioContext poll parameters */
     int64_t poll_max_ns;
diff --git a/iothread.c b/iothread.c
index caf68e0764..80a8cf4b32 100644
--- a/iothread.c
+++ b/iothread.c
@@ -36,6 +36,34 @@
 #define IOTHREAD_POLL_MAX_NS_DEFAULT 0ULL
 #endif
 
+/*
+ * Add holder device path to the list.
+ */
+static void iothread_ref(IOThread *iothread, const char *holder)
+{
+    iothread->holders = g_list_prepend(iothread->holders, g_strdup(holder));
+}
+
+/*
+ * Delete holder device path from the list.
+ */
+static void iothread_unref(IOThread *iothread, const char *holder)
+{
+    if (iothread->holders) {
+        GList *link = g_list_find_custom(iothread->holders, holder,
+                                         (GCompareFunc)g_strcmp0);
+
+        if (link) {
+            g_free(link->data);
+            iothread->holders = g_list_delete_link(iothread->holders, link);
+        } else {
+            error_report("iothread_unref can't find the holder %s", holder);
+        }
+    } else {
+        error_report("iohtread_unref iothread is not held by any devices");
+    }
+}
+
 static void *iothread_run(void *opaque)
 {
     IOThread *iothread = opaque;
-- 
2.49.0


