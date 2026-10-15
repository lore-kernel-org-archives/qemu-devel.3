Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03662CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJX8-00040K-C7; Thu, 15 Oct 2026 07:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJX5-0003o6-B4
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xHJX1-00048z-LE
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UR8HM/wlzD4qLVupKo+DuKdvJTIqEWqiIX3b66yaHv4=;
 b=RmE0DK7dSrkek5EP4lx5d+FCaOAD2DBEeLUYnGH88Gbzg6Rb90HbwHWGYvaBlKgzZ+2k3A
 ON5UgKq+KHD5CFkHZ3bMIP3l3ub+C7KX/oipfJ6Qd3AzNbOIUo95QR/wrzJyYJAZy228Ev
 0Mk7ziBQ+7rYIy3LbiNv+yrB96+JxVc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-K5fQMR-QMluXlyjAnpQO1Q-1; Thu,
 15 Oct 2026 11:21:47 +0000
X-MC-Unique: K5fQMR-QMluXlyjAnpQO1Q-1
X-Mimecast-MFC-AGG-ID: K5fQMR-QMluXlyjAnpQO1Q_1792063306
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 253A21956059; Thu, 15 Oct 2026 11:21:46 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 872C41800677; Thu, 15 Oct 2026 11:21:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 14/21] util: introduce capture of textual messages in data
 recorder
Date: Thu, 15 Oct 2026 12:20:37 +0100
Message-ID: <20261015112044.1999748-15-berrange@redhat.com>
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Introduce a circular buffer concept to the data recorder that can be
used to capture text based messages from subsystems. Support for
multiple distinct "buckets" is provided, one per type of information
to be captured. This ensures that data from subsystems which is
captured at a high rate, does not prematurely wrap the buffer and
overwrite (still relevant) messages from a subsystem that records
at a low rate.

Each bucket has a max capacity of 64 KB by default (though it is
configurable), but grows on demand. IOW the bucket capacity puts
an upper limit on memory usage, actual usage will be zero until
data is recorded. Every captured message will be prefixed by a
timestamp and suffixed by a newline, if one is not already present
at the end of the message.

While writing into the bufers is synchronized with mutex locks,
when dumping from a signal handler the buffers are accessed
without any locking to avoid deadlocks. Atomic loads/stores are
used in certain places so the signal handler can dump data with
acceptable accuracy even when racing with other threads still
writing new messages.

When the circular buffer wraps, old messages will be overwritten
without attention to message boundaries. IOW, when later dumping
the data recorder, the first printed message is likely to have
its leading text and timestamp missing. This is considered an
acceptable tradeoff to avoid tracking message boundaries which
greatly adds complexity and is hard todo safely without locks
when dumping.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qemu/tldr.h         |  52 +++++++
 qapi/qom.json               |   5 +-
 qapi/tldr.json              |  34 +++++
 qemu-options.hx             |   8 +
 tests/unit/test-util-tldr.c | 272 ++++++++++++++++++++++++++++++++++
 util/tldr-internal.h        |  31 ++++
 util/tldr.c                 | 282 +++++++++++++++++++++++++++++++++++-
 7 files changed, 682 insertions(+), 2 deletions(-)

diff --git a/include/qemu/tldr.h b/include/qemu/tldr.h
index 67152b136b3..5766acecb64 100644
--- a/include/qemu/tldr.h
+++ b/include/qemu/tldr.h
@@ -9,6 +9,58 @@
 #ifndef QEMU_TLDR_H__
 #define QEMU_TLDR_H__
 
+#include "qapi/qapi-types-tldr.h"
+
+extern unsigned int qtldr_msg_enabled_mask;
+
+/**
+ * qtldr_msg_enabled:
+ * @bucket: bucket to check status for
+ *
+ * Returns: true if @bucket is enabled for recording
+ */
+#define qtldr_msg_enabled(bucket) \
+    (qtldr_msg_enabled_mask & (1 << bucket))
+
+/**
+ * qtldr_msg_record:
+ * @bucket: bucket to record into
+ * @msg: the message text to record
+ *
+ * Records @msg into @bucket, potentially overwriting
+ * old messages if the capacity is at its maximum
+ */
+void qtldr_msg_record(QTLDRMsgBucketType bucket,
+                      const char *msg);
+
+/**
+ * qtldr_msg_record_printf:
+ * @bucket: bucket to record into
+ * @fmt: the message format string to record
+ * @...: the arguments for @fmt
+ *
+ * Formats @fmt as a printf string and records the
+ * result into @bucket, potentially overwriting
+ * old messages if the capacity is at its maximum
+ */
+void qtldr_msg_record_printf(QTLDRMsgBucketType bucket,
+                             const char *fmt, ...)
+    G_GNUC_PRINTF(2, 3);
+
+/**
+ * qtldr_msg_record_vprintf:
+ * @bucket: bucket to record into
+ * @fmt: the message format string to record
+ * @ap: the arguments for @fmt
+ *
+ * Formats @fmt as a printf string and records the
+ * result into @bucket, potentially overwriting
+ * old messages if the capacity is at its maximum
+ */
+void qtldr_msg_record_vprintf(QTLDRMsgBucketType bucket,
+                              const char *fmt, va_list ap)
+    G_GNUC_PRINTF(2, 0);
+
 /**
  * qtldr_crash_dump_signal:
  * @si: signal information
diff --git a/qapi/qom.json b/qapi/qom.json
index 1c9031fba9a..f1c37bce6c2 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -8,6 +8,7 @@
 { 'include': 'block-core.json' }
 { 'include': 'common.json' }
 { 'include': 'crypto.json' }
+{ 'include': 'tldr.json' }
 
 ##
 # ***********************
@@ -1239,11 +1240,13 @@
 #
 # @crash-target: fully qualified path to perserve data recorder
 #                contents on QEMU crash
+# @messages: custom configuration for message buckets
 #
 # Since: 11.2.0
 ##
 { 'struct': 'QTLDRConfigProperties',
-  'data': { '*crash-target': 'str' }
+  'data': { '*crash-target': 'str',
+            '*messages': ['QTLDRMsgBucketConfig'] }
 }
 
 ##
diff --git a/qapi/tldr.json b/qapi/tldr.json
index 8e2b7cda324..987d36b91f8 100644
--- a/qapi/tldr.json
+++ b/qapi/tldr.json
@@ -26,3 +26,37 @@
 #     <- { "return": {} }
 ##
 { 'command': 'tldr-dump', 'data': 'QTLDRDumpOptions' }
+
+##
+# @QTLDRMsgBucketType:
+#     List of message bucket types
+#
+# @error: error messages and warnings
+# @command: QMP commands which change state and error responses
+# @event: QMP events reflecting state changes
+# @log: log messages from any subsystems
+#
+# Since: 11.2.0
+##
+{ 'enum': 'QTLDRMsgBucketType',
+  'data': ['error', 'command', 'event', 'log' ] }
+
+
+##
+# @QTLDRMsgBucketConfig:
+#     Configuration for message buckets
+#
+# @type: the message bucket to enable
+# @capacity: override the default bucket size, in bytes (64kb)
+#
+# Each bucket allocates memory on demand, so capacity merely
+# puts an upper limit on the memory usage in a bucket.  The
+# capacity must be larger than the per-message size limit,
+# which is 2048 bytes.
+#
+# Since: 11.2.0
+##
+{ 'struct': 'QTLDRMsgBucketConfig',
+  'data': { 'type': 'QTLDRMsgBucketType',
+            '*capacity': 'size' }
+}
diff --git a/qemu-options.hx b/qemu-options.hx
index 5f96257cef0..da9d1e2b7bd 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -6685,6 +6685,8 @@ SRST
 
 
     ``-object tldr-config,id=id,crash-target=path``
+        \
+    ``-object "{'qom-type':'tldr-config','id':'tldr','crash-target':'foo','messages':[{'type':'BUCKET','capacity':BYTES}]}"``
         Creating the ``tldr-config`` object enables the thrifty live data
         recorder, which continuously captures important information about
         the operation of the QEMU process. When a SIGSEGV, SIGBUS,
@@ -6695,6 +6697,12 @@ SRST
         The ``tldr-dump`` QMP command can also be used at any time to
         save the captured data to an arbitrary file.
 
+        The data recorder will capture upto 64kb of data by default in
+        each bucket, but when using the JSON syntax for ``-object``, this
+        can be tailored with the ``messages`` parameter. ``BUCKET`` takes
+        one of ``error``, ``command``, ``event``, or ``log`` and the
+        capacity value is in bytes.
+
         The ``tldr-config`` object can be added at initial startup
         or via QMP at runtime. Once created, however, it is not
         permitted to disable it.
diff --git a/tests/unit/test-util-tldr.c b/tests/unit/test-util-tldr.c
index 4384e10cc18..42b4e350540 100644
--- a/tests/unit/test-util-tldr.c
+++ b/tests/unit/test-util-tldr.c
@@ -9,11 +9,20 @@
 #include "qemu/osdep.h"
 #include "util/tldr-internal.h"
 
+typedef struct {
+    size_t next;
+    const char *msg;
+} QTLDRTestStep;
+
 typedef struct {
     bool siginfo;
+    size_t capacity;
+    QTLDRTestStep *steps;
     const char *data;
 } QTLDRTestData;
 
+static int timestampIndex;
+
 #define TEST_SIGINFO_NULL \
     QTLDR_DUMP_TRIGGER_PREFIX "manual\n"
 
@@ -23,15 +32,65 @@ typedef struct {
     "  - Code: Address not mapped (1)\n" \
     "  - Address: 0x87539319\n"
 
+/*
+ * Total message length including timestamp, \f, record len,
+ * message and extra newline will be 58 bytes
+ */
+#define TEST_MSG_1_TRUNC "mnopqrstuvwxyz\n"
+#define TEST_MSG_1 "abcdefghijkl" TEST_MSG_1_TRUNC
+#define TEST_MSG_2 "0123456789helloworld!!@@##"
+#define TEST_MSG_3 ">$><%><@@@>[*&^()]!!<<<<()\n"
+#define TEST_TIMESTAMP_1_TRUNC "026-10-05T16:35:40.601961Z"
+#define TEST_TIMESTAMP_1 "2" TEST_TIMESTAMP_1_TRUNC
+#define TEST_TIMESTAMP_2_TRUNC "T16:38:40.601961Z"
+#define TEST_TIMESTAMP_2 "2026-10-05" TEST_TIMESTAMP_2_TRUNC
+#define TEST_TIMESTAMP_3 "2026-10-05T16:40:40.601961Z"
+
+
+static char *
+test_tldr_now_str_func(void)
+{
+    static const char *timestamps[] = {
+        TEST_TIMESTAMP_1,
+        TEST_TIMESTAMP_2,
+        TEST_TIMESTAMP_3,
+    };
+    timestampIndex = timestampIndex % 3;
+    return g_strdup(timestamps[timestampIndex++]);
+}
+
 
 static void
 test_tldr_one(QTLDRTestData *data)
 {
+    QTLDRMsgBucket *bucket = &(qtldr_msg_buckets[QTLDR_MSG_BUCKET_TYPE_ERROR]);
+    size_t i;
     g_autofree char *tmpname = NULL;
     int tmpfd;
     char buf[1024];
     ssize_t dumplen;
 
+    qtldr_msg_enabled_mask = (1 << QTLDR_MSG_BUCKET_TYPE_ERROR);
+
+    if (data->capacity && data->steps) {
+        timestampIndex = 0;
+
+        g_clear_pointer(&bucket->buf, g_free);
+        bucket->allocated = 0;
+        bucket->capacity = data->capacity;
+        bucket->next = 0;
+
+        for (i = 0; data->steps[i].msg; i++) {
+            qtldr_msg_record(QTLDR_MSG_BUCKET_TYPE_ERROR,
+                             data->steps[i].msg);
+
+            assert(bucket->next == data->steps[i].next);
+            assert(bucket->allocated == data->capacity);
+            assert(bucket->capacity == data->capacity);
+            assert(bucket->buf != NULL);
+        }
+    }
+
     tmpfd = g_file_open_tmp("test-util-tldr-XXXXXX",
                             &tmpname, NULL);
     unlink(tmpname);
@@ -92,14 +151,227 @@ test_tldr_minimal_siginfo(void)
 }
 
 
+/*
+ * A single message which easily fits in the buffer
+ * to sanity check minimal functionality
+ */
+static void
+test_tldr_msgs_simple(void)
+{
+    QTLDRTestData data = {
+        .capacity = 70,
+        .steps = (QTLDRTestStep[]){
+            { .next = 55, .msg = TEST_MSG_1 },
+            { .next = -1, .msg = NULL },
+        },
+        .data =
+            QTLDR_DUMP_LEADER
+            TEST_SIGINFO_NULL
+            QTLDR_DUMP_MSG_BUCKET_PREFIX "error':\n"
+            TEST_TIMESTAMP_1 " " TEST_MSG_1
+            QTLDR_DUMP_TRAILER
+    };
+
+    test_tldr_one(&data);
+}
+
+
+/*
+ * A pair of messages which exactly hit the buffer
+ * size to sanity check we wrap back to start on
+ * the limit.
+ */
+static void
+test_tldr_msgs_exact(void)
+{
+    QTLDRTestData data = {
+        .capacity = 110,
+        .steps = (QTLDRTestStep[]){
+            { .next = 55, .msg = TEST_MSG_1 },
+            { .next = 0, .msg = TEST_MSG_2 },
+            { .next = -1, .msg = NULL },
+        },
+        .data =
+            QTLDR_DUMP_LEADER
+            TEST_SIGINFO_NULL
+            QTLDR_DUMP_MSG_BUCKET_PREFIX "error':\n"
+            TEST_TIMESTAMP_1 " " TEST_MSG_1
+            TEST_TIMESTAMP_2 " " TEST_MSG_2 "\n"
+            QTLDR_DUMP_TRAILER
+    };
+
+    test_tldr_one(&data);
+}
+
+
+/*
+ * A pair of messages which easily exceed the buffer
+ * size to sanity check we wrap and overwrite existing
+ * old data
+ */
+static void
+test_tldr_msgs_wrap_simple(void)
+{
+    QTLDRTestData data = {
+        .capacity = 70,
+        .steps = (QTLDRTestStep[]){
+            { .next = 55, .msg = TEST_MSG_1 },
+            { .next = 40, .msg = TEST_MSG_2 },
+            { .next = -1, .msg = NULL },
+        },
+        .data =
+            QTLDR_DUMP_LEADER
+            TEST_SIGINFO_NULL
+            QTLDR_DUMP_MSG_BUCKET_PREFIX "error':\n"
+            TEST_MSG_1_TRUNC
+            TEST_TIMESTAMP_2 " " TEST_MSG_2 "\n"
+            QTLDR_DUMP_TRAILER
+    };
+
+    test_tldr_one(&data);
+}
+
+
+/*
+ * A pair of messages which both exactly match the
+ * buffer size to further sanity check wrapping
+ * behaviour
+ */
+static void
+test_tldr_msgs_wrap_exact(void)
+{
+    QTLDRTestData data = {
+        .capacity = 55,
+        .steps = (QTLDRTestStep[]){
+            { .next = 0, .msg = TEST_MSG_1 },
+            { .next = 0, .msg = TEST_MSG_2 },
+            { .next = -1, .msg = NULL },
+        },
+        .data =
+            QTLDR_DUMP_LEADER
+            TEST_SIGINFO_NULL
+            QTLDR_DUMP_MSG_BUCKET_PREFIX "error':\n"
+            TEST_TIMESTAMP_2 " " TEST_MSG_2 "\n"
+            QTLDR_DUMP_TRAILER
+    };
+
+    test_tldr_one(&data);
+}
+
+
+/*
+ * A set of messages where first two are one less
+ * than the buffer size, to further sanity check
+ * wrapping behaviour
+ */
+static void
+test_tldr_msgs_wrap_oneextra(void)
+{
+    QTLDRTestData data = {
+        .capacity = 111,
+        .steps = (QTLDRTestStep[]){
+            { .next = 55, .msg = TEST_MSG_1 },
+            { .next = 110, .msg = TEST_MSG_2 },
+            { .next = 54, .msg = TEST_MSG_3 },
+            { .next = -1, .msg = NULL },
+        },
+        .data =
+            QTLDR_DUMP_LEADER
+            TEST_SIGINFO_NULL
+            QTLDR_DUMP_MSG_BUCKET_PREFIX "error':\n"
+            "\n"
+            TEST_TIMESTAMP_2 " " TEST_MSG_2 "\n"
+            TEST_TIMESTAMP_3 " " TEST_MSG_3
+            QTLDR_DUMP_TRAILER
+    };
+
+    test_tldr_one(&data);
+}
+
+
+/*
+ * A set of messages where first two are one larger
+ * than the buffer size, to further sanity check
+ * wrapping behaviour
+ */
+static void
+test_tldr_msgs_wrap_oneunder(void)
+{
+    QTLDRTestData data = {
+        .capacity = 109,
+        .steps = (QTLDRTestStep[]){
+            { .next = 55, .msg = TEST_MSG_1 },
+            { .next = 1, .msg = TEST_MSG_2 },
+            { .next = -1, .msg = NULL },
+        },
+        .data =
+            QTLDR_DUMP_LEADER
+            TEST_SIGINFO_NULL
+            QTLDR_DUMP_MSG_BUCKET_PREFIX "error':\n"
+            TEST_TIMESTAMP_1_TRUNC " " TEST_MSG_1
+            TEST_TIMESTAMP_2 " " TEST_MSG_2 "\n"
+            QTLDR_DUMP_TRAILER
+    };
+
+    test_tldr_one(&data);
+}
+
+
+/*
+ * A set of messages that make us wrap around
+ * many times over.
+ */
+static void
+test_tldr_msgs_wrap_repeat(void)
+{
+    QTLDRTestData data = {
+        .capacity = 100,
+        .steps = (QTLDRTestStep[]){
+            { .next = 55, .msg = TEST_MSG_1 },
+            { .next = 10, .msg = TEST_MSG_2 },
+            { .next = 65, .msg = TEST_MSG_3 },
+            { .next = 20, .msg = TEST_MSG_1 },
+            { .next = 75, .msg = TEST_MSG_2 },
+            { .next = 30, .msg = TEST_MSG_3 },
+            { .next = -1, .msg = NULL },
+        },
+        .data =
+            QTLDR_DUMP_LEADER
+            TEST_SIGINFO_NULL
+            QTLDR_DUMP_MSG_BUCKET_PREFIX "error':\n"
+            TEST_TIMESTAMP_2_TRUNC " " TEST_MSG_2 "\n"
+            TEST_TIMESTAMP_3 " " TEST_MSG_3
+            QTLDR_DUMP_TRAILER
+    };
+
+    test_tldr_one(&data);
+}
+
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
+    qtldr_now_str_func = test_tldr_now_str_func;
+
     g_test_add_func("/util/tldr/minimal/default",
                     test_tldr_minimal_default);
     g_test_add_func("/util/tldr/minimal/siginfo",
                     test_tldr_minimal_siginfo);
+    g_test_add_func("/util/tldr/msgs/simple",
+                    test_tldr_msgs_simple);
+    g_test_add_func("/util/tldr/msgs/exact",
+                    test_tldr_msgs_exact);
+    g_test_add_func("/util/tldr/msgs/wrap/simple",
+                    test_tldr_msgs_wrap_simple);
+    g_test_add_func("/util/tldr/msgs/wrap/exact",
+                    test_tldr_msgs_wrap_exact);
+    g_test_add_func("/util/tldr/msgs/wrap/oneextra",
+                    test_tldr_msgs_wrap_oneextra);
+    g_test_add_func("/util/tldr/msgs/wrap/oneunder",
+                    test_tldr_msgs_wrap_oneunder);
+    g_test_add_func("/util/tldr/msgs/wrap/repeat",
+                    test_tldr_msgs_wrap_repeat);
 
     return g_test_run();
 }
diff --git a/util/tldr-internal.h b/util/tldr-internal.h
index 193d8425eee..f523565db85 100644
--- a/util/tldr-internal.h
+++ b/util/tldr-internal.h
@@ -14,8 +14,39 @@
 #define QTLDR_DUMP_LEADER "\n🚨🚨🚨 QEMU Data Recorder Start 🚨🚨🚨\n"
 #define QTLDR_DUMP_TRAILER "\n🚨🚨🚨 QEMU Data Recorder End 🚨🚨🚨\n\n"
 #define QTLDR_DUMP_TRIGGER_PREFIX "\n🔍 Trigger:"
+#define QTLDR_DUMP_MSG_BUCKET_PREFIX "\n🎥  Message recording '"
 #define QTLDR_DUMP_OPEN_ERROR "🔥 Unable to dump to '"
 
+/*
+ * All writes to this struct must be protected by
+ * the qtldr_lock. Reads and writes of 'allocated'
+ * and 'next' must also use atomics, since they
+ * are accessed without locks during signal handler
+ * dumps. Reads of 'buf' may be done without locks
+ * or atomics, since we're happy to dump whatever
+ * incomplete writes may be in progress.
+ */
+typedef struct {
+    char *buf;
+    size_t allocated; /* Currently allocated */
+    size_t capacity; /* Max permitted allocation */
+    size_t next; /* Offset to write next byte */
+} QTLDRMsgBucket;
+
+#define QTLDR_MSG_ENTRY_MAX_BYTES (2 * 1024)
+#define QTLDR_MSG_BUCKET_SIZE_BYTES (64 * 1024)
+
+/*
+ * MUST always be greater than entry size, otherwise
+ * wrapping logic doesn't work
+ */
+G_STATIC_ASSERT(QTLDR_MSG_BUCKET_SIZE_BYTES >
+                QTLDR_MSG_ENTRY_MAX_BYTES);
+
+extern QTLDRMsgBucket qtldr_msg_buckets[];
+
+extern char *(*qtldr_now_str_func)(void);
+
 void qtldr_crash_dump_internal(int fd, siginfo_t *si);
 
 #endif /* QEMU_TLDR_INTERNAL_H__ */
diff --git a/util/tldr.c b/util/tldr.c
index ea7c26b8e9b..34922d82ee4 100644
--- a/util/tldr.c
+++ b/util/tldr.c
@@ -8,20 +8,26 @@
 
 #include "qemu/osdep.h"
 #include "qemu/atomic.h"
+#include "qemu/thread.h"
 #include "util/tldr-internal.h"
 #include "qom/object.h"
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-tldr.h"
+#include "qapi/qapi-visit-tldr.h"
 
 struct QTLDRConfig {
     Object parent;
 
     char *crash_target;
+    QTLDRMsgBucketConfigList *messages;
 };
 
+static QemuMutex qtldr_lock;
 static int qtldr_active;
 static char *qtldr_crash_target;
+QTLDRMsgBucket qtldr_msg_buckets[QTLDR_MSG_BUCKET_TYPE__MAX];
+unsigned int qtldr_msg_enabled_mask;
 
 #define TYPE_QTLDR_CONFIG "tldr-config"
 
@@ -34,6 +40,22 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(QTLDRConfig,
                                           { TYPE_USER_CREATABLE },
                                           { NULL });
 
+static char *
+qtldr_now_str_func_default(void)
+{
+    g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
+    return g_date_time_format_iso8601(dt);
+}
+
+char *(*qtldr_now_str_func)(void) = qtldr_now_str_func_default;
+
+
+static void __attribute__((constructor))
+qtldr_global_init(void)
+{
+    qemu_mutex_init(&qtldr_lock);
+}
+
 
 static void
 qtldr_config_finalize(Object *obj)
@@ -41,6 +63,7 @@ qtldr_config_finalize(Object *obj)
     QTLDRConfig *cfg = QTLDR_CONFIG(obj);
 
     g_free(cfg->crash_target);
+    qapi_free_QTLDRMsgBucketConfigList(cfg->messages);
 }
 
 
@@ -60,24 +83,93 @@ qtldr_config_set_crash_target(Object *obj, const char *path, Error **errp)
     cfg->crash_target = g_strdup(path);
 }
 
+static void qtldr_config_get_messages(Object *obj, Visitor *v, const char *name,
+                                      void *opaque, Error **errp)
+{
+    QTLDRConfig *cfg = QTLDR_CONFIG(obj);
+
+    visit_type_QTLDRMsgBucketConfigList(v, name, &cfg->messages, errp);
+}
+
+static void qtldr_config_set_messages(Object *obj, Visitor *v, const char *name,
+                                      void *opaque, Error **errp)
+{
+    QTLDRConfig *cfg = QTLDR_CONFIG(obj);
+    QTLDRMsgBucketConfigList *oldmsgs;
+
+    oldmsgs = cfg->messages;
+    visit_type_QTLDRMsgBucketConfigList(v, name, &cfg->messages, errp);
+
+    qapi_free_QTLDRMsgBucketConfigList(oldmsgs);
+}
 
 static void
 qtldr_config_complete(UserCreatable *uc, Error **errp)
 {
     QTLDRConfig *cfg = QTLDR_CONFIG(uc);
+    QTLDRMsgBucketConfigList *messages = cfg->messages;
 
     /*
      * Forbid changes, since once configured, we can't safely
      * change it due to signal handlers running without ability
      * to hold mutex locks
      */
-    if (qtldr_crash_target) {
+    if (qtldr_crash_target || qtldr_msg_enabled_mask) {
         error_setg(errp, "TLDR configuration cannot be changed");
         return;
     }
 
+    /*
+     * Sanity check before changing anything, so errors don't
+     * leave us in a partially configured state
+     */
+    while (messages) {
+        QTLDRMsgBucketConfig *msgcfg = messages->value;
+        assert(msgcfg->type < QTLDR_MSG_BUCKET_TYPE__MAX);
+
+        if (msgcfg->has_capacity &&
+            msgcfg->capacity <= QTLDR_MSG_ENTRY_MAX_BYTES) {
+            error_setg(errp, "Message bucket capacity must be greater than %d",
+                       QTLDR_MSG_ENTRY_MAX_BYTES);
+            return;
+        }
+        messages = messages->next;
+    }
+
+    qemu_mutex_lock(&qtldr_lock);
     qatomic_store_release(&qtldr_crash_target, g_strdup(cfg->crash_target));
+
+    messages = cfg->messages;
+    while (messages) {
+        QTLDRMsgBucketConfig *msgcfg = messages->value;
+        assert(msgcfg->type < QTLDR_MSG_BUCKET_TYPE__MAX);
+
+        if (msgcfg->has_capacity) {
+            qtldr_msg_buckets[msgcfg->type].capacity = msgcfg->capacity;
+        } else {
+            qtldr_msg_buckets[msgcfg->type].capacity =
+                QTLDR_MSG_BUCKET_SIZE_BYTES;
+        }
+
+        qtldr_msg_enabled_mask |= (1 << msgcfg->type);
+
+        messages = messages->next;
+    }
+
+    if (!cfg->messages) {
+        size_t i;
+        qtldr_msg_enabled_mask =
+            (1 << QTLDR_MSG_BUCKET_TYPE_ERROR) |
+            (1 << QTLDR_MSG_BUCKET_TYPE_COMMAND) |
+            (1 << QTLDR_MSG_BUCKET_TYPE_EVENT) |
+            (1 << QTLDR_MSG_BUCKET_TYPE_LOG);
+        for (i = 0; i < QTLDR_MSG_BUCKET_TYPE__MAX; i++) {
+            qtldr_msg_buckets[i].capacity = QTLDR_MSG_BUCKET_SIZE_BYTES;
+        }
+    }
+
     qatomic_inc(&qtldr_active);
+    qemu_mutex_unlock(&qtldr_lock);
 }
 
 
@@ -101,6 +193,10 @@ qtldr_config_class_init(ObjectClass *klass, const void *opaque)
     object_class_property_add_str(klass, "crash-target",
                                   qtldr_config_get_crash_target,
                                   qtldr_config_set_crash_target);
+    object_class_property_add(klass, "messages", "QTLDRMsgBucketConfigList",
+                              qtldr_config_get_messages,
+                              qtldr_config_set_messages,
+                              NULL, NULL);
 
     ucc->complete = qtldr_config_complete;
     ucc->prepare_delete = qtldr_config_prepare_delete;
@@ -113,6 +209,145 @@ qtldr_config_init(Object *obj)
 }
 
 
+/*
+ * WARNING: The data recorder is intended to be called from
+ * WARNING: many places within QEMU, including tracing, error
+ * WARNING: reporting and logging code.
+ *
+ * WARNING: The code following this marker is used in the call
+ * WARNING: chain from qtldr_msg_record() and must be self
+ * WARNING: contained and performance oriented.
+ */
+
+static void
+qtldr_msg_record_ensure_size(QTLDRMsgBucket *bucket,
+                             size_t need)
+{
+    /*
+     * If bucket is not yet at max size then we can't have
+     * wrapped the buffer and so 'head' must reflect the
+     * amount of written data so far.
+     */
+    if (bucket->allocated < bucket->capacity) {
+        size_t space = bucket->allocated - bucket->next;
+        if (space < need) {
+            size_t newlen = MIN(bucket->capacity,
+                                bucket->allocated + MAX(4096, need - space));
+            bucket->buf = g_realloc(bucket->buf, newlen);
+            /*
+             * Fill with zeros, so the dumping method
+             * knows what is unused so far.
+             */
+            memset(bucket->buf + bucket->allocated, '\0',
+                   newlen - bucket->allocated);
+            qatomic_store_release(&bucket->allocated, newlen);
+        }
+    }
+}
+
+
+static size_t
+qtldr_msg_record_append_buf(QTLDRMsgBucket *bucket,
+                            size_t next,
+                            const void *buf,
+                            size_t len)
+{
+    size_t forend = MIN(bucket->allocated - next, len);
+    size_t forfront = len - forend;
+
+    if (forend) {
+        memcpy(bucket->buf + next, buf, forend);
+    }
+    if (forfront) {
+        memcpy(bucket->buf, buf + forend, forfront);
+        return forfront;
+    } else {
+        return (next + forend) % bucket->allocated;
+    }
+}
+
+
+void
+qtldr_msg_record(QTLDRMsgBucketType type,
+                 const char *msg)
+{
+    QTLDRMsgBucket *bucket;
+    size_t msglen, timelen;
+    g_autofree char *timestr = qtldr_now_str_func();
+    bool addnl = false;
+    uint16_t recordlen;
+    size_t next;
+
+    assert(type < QTLDR_MSG_BUCKET_TYPE__MAX);
+    if (!qtldr_msg_enabled(type)) {
+        return;
+    }
+
+    qemu_mutex_lock(&qtldr_lock);
+
+    bucket = &qtldr_msg_buckets[type];
+    timelen = strlen(timestr);
+    msglen = strlen(msg);
+
+    recordlen = timelen + 1 /* " " */ + msglen;
+    if (recordlen > (QTLDR_MSG_ENTRY_MAX_BYTES - 1)) {
+        size_t cut = (QTLDR_MSG_ENTRY_MAX_BYTES - 1)  - recordlen;
+        msglen -= cut;
+        recordlen -= cut;
+    }
+
+    if (msglen && msg[msglen - 1] != '\n') {
+        addnl = true;
+        recordlen++;
+    }
+
+
+    qtldr_msg_record_ensure_size(bucket, recordlen);
+    next = qtldr_msg_record_append_buf(bucket, bucket->next, timestr, timelen);
+    next = qtldr_msg_record_append_buf(bucket, next, " ", 1);
+    next = qtldr_msg_record_append_buf(bucket, next, msg, msglen);
+    if (addnl) {
+        next = qtldr_msg_record_append_buf(bucket, next, "\n", 1);
+    }
+
+    /*
+     * We could be racing with a signal handler dumping text
+     * outside the mutex lock, so while we write text without
+     * any sync, we atomically change the "next" pointer.
+     *
+     * Worst case, some text the signal handler dumps will be
+     * "new" instead of old part of the buffer.
+     */
+    qatomic_store_release(&bucket->next, next);
+    qemu_mutex_unlock(&qtldr_lock);
+}
+
+
+void
+qtldr_msg_record_printf(QTLDRMsgBucketType type,
+                        const char *fmt, ...)
+{
+    char msg[1024];
+    va_list ap;
+
+    va_start(ap, fmt);
+    vsnprintf(msg, G_N_ELEMENTS(msg), fmt, ap);
+    va_end(ap);
+
+    qtldr_msg_record(type, msg);
+}
+
+
+void
+qtldr_msg_record_vprintf(QTLDRMsgBucketType type,
+                         const char *fmt, va_list ap)
+{
+    char msg[1024];
+    vsnprintf(msg, G_N_ELEMENTS(msg), fmt, ap);
+    qtldr_msg_record(type, msg);
+}
+
+
 /*
  * WARNING: Code below this marker is used when dumping
  * WARNING: the data recorder buffers. It is subject to
@@ -159,6 +394,43 @@ qtldr_write_int_hex(int fd, uint64_t v)
 }
 
 
+static void
+qtldr_crash_dump_msg(int fd, QTLDRMsgBucketType type, QTLDRMsgBucket *bucket)
+{
+    size_t allocated, head;
+
+    if (!bucket->allocated) {
+        return;
+    }
+    ignore_value(write(fd, QTLDR_DUMP_MSG_BUCKET_PREFIX,
+                       strlen(QTLDR_DUMP_MSG_BUCKET_PREFIX)));
+    ignore_value(write(fd, QTLDRMsgBucketType_str(type),
+                       strlen(QTLDRMsgBucketType_str(type))));
+    ignore_value(write(fd, "':\n", 3));
+
+    /*
+     * We're potentially racing with a thread appending.
+     * Load 'head' first, so we're guaranteed it does
+     * not point beyond the 'allocated' region, should
+     * we be racing with buffer enlargement
+     */
+    head = qatomic_load_acquire(&bucket->next);
+    allocated = qatomic_load_acquire(&bucket->allocated);
+
+    /*
+     * If we haven't wrapped around yet, the allocated but
+     * unused space is filled with NULs. We can assume
+     * that no valid messages contain NULs, since we used
+     * "strlen" when writing messages originally.
+     */
+    if (bucket->buf[head] != '\0') {
+        ignore_value(write(fd, bucket->buf + head,
+                           allocated - head));
+    }
+    ignore_value(write(fd, bucket->buf, head));
+}
+
+
 static const char *
 qtldr_crash_dump_signal_str(int signo)
 {
@@ -378,6 +650,8 @@ qtldr_crash_dump_print_siginfo(int fd, siginfo_t *si)
 void
 qtldr_crash_dump_internal(int fd, siginfo_t *si)
 {
+    size_t i;
+
     if (fd == -1) {
         fd = STDERR_FILENO;
     }
@@ -391,6 +665,10 @@ qtldr_crash_dump_internal(int fd, siginfo_t *si)
         ignore_value(write(fd, "manual\n", 7));
     }
 
+    for (i = 0; i < QTLDR_MSG_BUCKET_TYPE__MAX; i++) {
+        qtldr_crash_dump_msg(fd, i, &qtldr_msg_buckets[i]);
+    }
+
     ignore_value(write(fd, QTLDR_DUMP_TRAILER, strlen(QTLDR_DUMP_TRAILER)));
 }
 
@@ -463,7 +741,9 @@ qmp_tldr_dump(const char *target, Error **errp)
         return;
     }
 
+    qemu_mutex_lock(&qtldr_lock);
     qtldr_crash_dump_internal(fd, NULL);
+    qemu_mutex_unlock(&qtldr_lock);
 
     qemu_fdatasync(fd);
     close(fd);
-- 
2.56.0


