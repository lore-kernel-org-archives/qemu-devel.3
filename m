Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDD6C44515
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPmB-0005pE-MU; Thu, 16 Jul 2026 13:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPmA-0005p0-Ge
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:21:34 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPm8-0000Ru-MH
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:21:34 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3810c5d691bso5397345a91.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784222491; x=1784827291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EWnksNoYUxBUrwcSM/xM8wvQyla6RML0UmckypoRO1Y=;
 b=EddIN8Y5owjmSFlGG89f4dqFrqKmnYgIJAfaUlS4kV2eD9reIA2UFu8CJITNQmbyfj
 iizSMvs2/M7ydeHJMTAwcs5hIZLbtaC2S2ii4c25XUnhKV0c8WuK0KGLe/PreBQzl5p1
 3beUApUMJVRofS3VfkWZlNvOcEaADk8t+oYBCvSj6MlGCfficpQicuivcuZ4cn7aDU5f
 TFqVyXVIFLInvqdSqclhB7Wb8v3+Mlfwibm+a5MG7A2KJsv/ZfNDXNZ9ZXD77t+HOaV8
 XyFxbvTrdxr3N5vMYhlWHVLga6zCIQyTgmV0LSuESpsJMHpSfy9VTkl26HyCmOY2l0UV
 3gVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784222491; x=1784827291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EWnksNoYUxBUrwcSM/xM8wvQyla6RML0UmckypoRO1Y=;
 b=LyjOprWwbVCnLKEGlmTyAwLN+0lWxG7M9leq+mSk5YfbdASmqvjK1Z3wWMFwd961yr
 Tm+6wj3X7iXy3Q5xptUAS4dOJkGIiKzV5pB3aFzAwTWekaTBxU/UPe6jwqgFw5WZ/19F
 2r7VhHs0fzNg6WX9IgXOzskKvACLwGyINkR+rKOQvmd6rzV6ibXIAT+OU0BO7rV4XrZo
 HlL81h9HtgnhwS277D0Vz0PIk4JfVOVLkPOmiOv1yagaNRmEiVYdmUKl3IzQqSL+EZeG
 LXXqKMtwrVu9nZKRAljasea4+x/RpUreAh9iNkpkodNHMzrpVUTTQSzfBg2Mcpw3zYX3
 NjeQ==
X-Gm-Message-State: AOJu0YwpffdLkG6+fz+mhquVtCihnoy+CIo90ML/SXywPORqPfXrZA/o
 fiPrTkBhfNr7ImdNJIapjSGkIOn25qxyzllaDekNvJiqy/WyxC9fPXBJu9nIWxymb5s=
X-Gm-Gg: AfdE7ck3wFTcyJmvMAeENJOLrYQsfj4lTSslESD3hh+EEMGFdVhFIUJ8EaHoaNi34Yn
 +1ofpq9enYPiiYqrhl5rxjUMZ4tmoG9aW2NkSPIoN1GtHGxFjzKYeKugxoXl9ckWz3ckojTac1E
 VWYv1WeLWtv1AI0Hqk0LOAIgkHWgf0U5u4sfYEkWhbr3aVUkRDAMTybcSxqb3w2SOetgOtUfTqH
 g1pjDdfxyllQsvlWS3PQwyXcYH8+F2eU4R4mVPnvfUleTnd45p0RfDp9JDqdxf/8QY9B5DB+g16
 wiZ6VAFbW8Ipk7gfx0syIS6OL5wGVdVbhw117rYotMVhv3bPv6MmXRis2qoSoqcxSIskKpZdqKE
 VIiBhoC+sjQv+PmTQRqaKPQH0YiQ3Dih0++Sea/3hiPxtsHViXNci3P304mGJ2MYyf4Ggd2HYhx
 hVeYiQZyWGDMSS5qCQVImIKyuRNhMx7Q==
X-Received: by 2002:a17:90a:f950:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-38e1add8ac8mr10911181a91.4.1784222491130; 
 Thu, 16 Jul 2026 10:21:31 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm16800417eec.11.2026.07.16.10.21.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 10:21:30 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [RESEND PATCH V10 02/15] iothread: introduce iothread_ref/unref to
 track attached devices
Date: Fri, 17 Jul 2026 01:20:43 +0800
Message-ID: <20260716172108.87700-3-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716172108.87700-1-zhangckid@gmail.com>
References: <20260716172108.87700-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102d.google.com
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

Currently, IOThreads do not maintain a record of which devices are
associated with them. This makes it difficult to monitor the
workload distribution of IOThreads, especially in complex
hotplug scenarios involving multiple virtio-blk or virtio-scsi devices.

This patch introduces a reference counting and tracking mechanism
within the IOThread object:

- iothread_ref(): Prepends the device's IOThreadHolder to a list.
- iothread_unref(): Searches for the IOThreadHolder using a
  string comparison (strcmp), releases the associated memory
  upon a successful match.
- holders: A IOThreadHolderList storing the IOThreadHolder
  of attached devices for runtime introspection.

A later commit will add QMP commands to let management applications
query the attachment status of IOThreads.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/system/iothread.h | 11 ++++++
 iothread.c                | 70 +++++++++++++++++++++++++++++++++++++++
 qapi/misc.json            | 59 +++++++++++++++++++++++++++++++++
 3 files changed, 140 insertions(+)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index a1ef7696cb..ef0b2f9648 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -38,6 +38,9 @@
 #define IOTHREAD_POLL_WEIGHT_DEFAULT 0ULL
 #endif
 
+typedef struct IOThreadHolder IOThreadHolder;
+typedef struct IOThreadHolderList IOThreadHolderList;
+
 struct IOThread {
     EventLoopBase parent_obj;
 
@@ -50,6 +53,11 @@ struct IOThread {
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
     int thread_id;
+    /*
+     * The list elements are of type IOThreadHolder, which can
+     * represent either a QOM path or a block export name.
+     */
+    IOThreadHolderList *holders;
 
     /* AioContext poll parameters */
     int64_t poll_max_ns;
@@ -82,4 +90,7 @@ void iothread_destroy(IOThread *iothread);
  */
 bool qemu_in_iothread(void);
 
+void iothread_ref(IOThread *iothread, const IOThreadHolder *holder);
+void iothread_unref(IOThread *iothread, const IOThreadHolder *holder);
+
 #endif /* IOTHREAD_H */
diff --git a/iothread.c b/iothread.c
index 3558535b40..38f273c0e9 100644
--- a/iothread.c
+++ b/iothread.c
@@ -21,10 +21,78 @@
 #include "system/iothread.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-visit-misc.h"
 #include "qemu/error-report.h"
 #include "qemu/rcu.h"
 #include "qemu/main-loop.h"
 
+/*
+ * iothread_ref:
+ * @iothread: the iothread to track
+ * @holder: the IOThreadHolder object initialized by the caller
+ *
+ * Add the @holder to the iothread's tracking list.
+ */
+void iothread_ref(IOThread *iothread, const IOThreadHolder *holder)
+{
+    assert(holder);
+
+    QAPI_LIST_PREPEND(iothread->holders, QAPI_CLONE(IOThreadHolder, holder));
+}
+
+static int iothread_holder_compare(const IOThreadHolder *holder_a,
+                                   const IOThreadHolder *holder_b)
+{
+    const char *name_a, *name_b;
+
+    if (holder_a->type != holder_b->type) {
+        return holder_b->type - holder_a->type;
+    }
+
+    switch (holder_a->type) {
+    case IO_THREAD_HOLDER_KIND_QOM_OBJECT:
+        name_a = holder_a->u.qom_object.qom_path;
+        name_b = holder_b->u.qom_object.qom_path;
+        break;
+    case IO_THREAD_HOLDER_KIND_BLOCK_EXPORT:
+        name_a = holder_a->u.block_export.export_name;
+        name_b = holder_b->u.block_export.export_name;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return strcmp(name_a, name_b);
+}
+
+/*
+ * This function removes the @holder from the @iothread's tracking list.
+ * The @holder must match the one used previously in iothread_ref().
+ * It is a programming error to call this with a @holder that is not
+ * currently associated with the @iothread.
+ */
+void iothread_unref(IOThread *iothread, const IOThreadHolder *holder)
+{
+    IOThreadHolderList **prev = &iothread->holders;
+    IOThreadHolderList *curr;
+
+    assert(holder);
+
+    while (*prev) {
+        curr = *prev;
+        if (iothread_holder_compare(curr->value, holder) == 0) {
+            *prev = curr->next;
+            curr->next = NULL;
+            qapi_free_IOThreadHolderList(curr);
+            return;
+        }
+        prev = &curr->next;
+    }
+
+    g_assert_not_reached();
+}
+
 static void *iothread_run(void *opaque)
 {
     IOThread *iothread = opaque;
@@ -129,6 +197,7 @@ static void iothread_instance_finalize(Object *obj)
         iothread->main_loop = NULL;
     }
     qemu_sem_destroy(&iothread->init_done_sem);
+    qapi_free_IOThreadHolderList(iothread->holders);
 }
 
 static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
@@ -373,6 +442,7 @@ static int query_one_iothread(Object *object, void *opaque)
     info = g_new0(IOThreadInfo, 1);
     info->id = iothread_get_id(iothread);
     info->thread_id = iothread->thread_id;
+    info->holders = QAPI_CLONE(IOThreadHolderList, iothread->holders);
     info->poll_max_ns = iothread->poll_max_ns;
     info->poll_grow = iothread->poll_grow;
     info->poll_shrink = iothread->poll_shrink;
diff --git a/qapi/misc.json b/qapi/misc.json
index c71a5fe657..096e418b7a 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -67,6 +67,56 @@
 ##
 { 'command': 'query-name', 'returns': 'NameInfo', 'allow-preconfig': true }
 
+
+##
+# @IOThreadHolderBlockExport:
+#
+# @export-name: Name of the block export.
+#
+# Since: 11.1
+#
+##
+{ 'struct': 'IOThreadHolderBlockExport',
+  'data': { 'export-name': 'str' } }
+
+##
+# @IOThreadHolderQomObject:
+#
+# @qom-path: Path to the object in the QOM tree.
+#
+# Since: 11.1
+#
+##
+{ 'struct': 'IOThreadHolderQomObject',
+  'data': { 'qom-path': 'str' } }
+
+##
+# @IOThreadHolderKind:
+#
+# @block-export: A block export.
+# @qom-object: A QOM Object.
+#
+# Since: 11.1
+##
+{ 'enum': 'IOThreadHolderKind',
+  'data': [ 'block-export', 'qom-object' ] }
+
+##
+# @IOThreadHolder:
+#
+# The block export or QOM object holding the I/O thread.
+#
+# @type: the kind of I/O thread holder.
+#
+# Since: 11.1
+##
+{ 'union': 'IOThreadHolder',
+  'base': { 'type': 'IOThreadHolderKind' },
+  'discriminator': 'type',
+  'data': {
+    'block-export': 'IOThreadHolderBlockExport',
+    'qom-object': 'IOThreadHolderQomObject' } }
+
 ##
 # @IOThreadInfo:
 #
@@ -76,6 +126,11 @@
 #
 # @thread-id: ID of the underlying host thread
 #
+# @holders: the QOM objects or block nodes currently
+#     associated with this iothread.  When an associated component is
+#     detached or destroyed, it is removed from this list.
+#     (Since 11.1)
+#
 # @poll-max-ns: maximum polling time in ns, 0 means polling is
 #     disabled (since 2.9)
 #
@@ -98,6 +153,7 @@
 { 'struct': 'IOThreadInfo',
   'data': {'id': 'str',
            'thread-id': 'int',
+           'holders': ['IOThreadHolder'],
            'poll-max-ns': 'int',
            'poll-grow': 'int',
            'poll-shrink': 'int',
@@ -124,6 +180,8 @@
 #              {
 #                 "id":"iothread0",
 #                 "thread-id":3134,
+#                 "holders":[{"qom-path": "/machine/peripheral/blk1/virtio-backend", "type": "qom-object"},
+#                            {"qom-path": "/machine/peripheral/blk2/virtio-backend", "type": "qom-object"}],
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
@@ -132,6 +190,7 @@
 #              {
 #                 "id":"iothread1",
 #                 "thread-id":3135,
+#                 "holders":[{"export-name": "fmt_qcow2", "type": "block-export"}],
 #                 "poll-max-ns":32768,
 #                 "poll-grow":0,
 #                 "poll-shrink":0,
-- 
2.49.0


