Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB261CA5FCB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCISj-0000rc-5G; Thu, 01 Oct 2026 11:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCISc-0000p3-Hp
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:12:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCISa-0000tz-St
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790867555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JNBATASZe1maK+R/uHj4ADwON7Pzkeu5Yslw+3mrzWY=;
 b=akUAcNPI5p0M14h51y30Ux0fOCDRkn9dZN7bk0ZD/XX3QEOG63Tn2S0Gjb3mA/glcsXGvq
 cjO9e77h5IbEaFu9m/biBVazVEYnoQYiRYR68FBIfoEgl5wvNmoTEz6Acph6wiMNSoNlwZ
 8qsIh1ks/FdRNB1C457oLhlb50GPrZg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-OUF9I2wqMZ6sO-k24QNh4g-1; Thu,
 01 Oct 2026 11:12:34 -0400
X-MC-Unique: OUF9I2wqMZ6sO-k24QNh4g-1
X-Mimecast-MFC-AGG-ID: OUF9I2wqMZ6sO-k24QNh4g_1790867553
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 780451955F7B
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 15:12:33 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EF431956042; Thu,  1 Oct 2026 15:12:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 02/20] trace: use 'ignore_value()' instead of a dummy variable
Date: Thu,  1 Oct 2026 16:12:10 +0100
Message-ID: <20261001151228.3373747-3-berrange@redhat.com>
In-Reply-To: <20261001151228.3373747-1-berrange@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This pattern is more concise than using a dummy variable which
in turn needs annotating as unused.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 trace/ftrace.c | 3 +--
 trace/simple.c | 9 ++++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/trace/ftrace.c b/trace/ftrace.c
index 6875faedb9c..c1ed6ad4454 100644
--- a/trace/ftrace.c
+++ b/trace/ftrace.c
@@ -41,7 +41,6 @@ static int find_mount(char *mount_point, const char *fstype)
 void ftrace_write(const char *fmt, ...)
 {
     char ftrace_buf[MAX_TRACE_STRLEN];
-    int unused __attribute__ ((unused));
     int trlen;
     va_list ap;
 
@@ -50,7 +49,7 @@ void ftrace_write(const char *fmt, ...)
     va_end(ap);
 
     trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
-    unused = write(trace_marker_fd, ftrace_buf, trlen);
+    ignore_value(write(trace_marker_fd, ftrace_buf, trlen));
 }
 
 bool ftrace_init(void)
diff --git a/trace/simple.c b/trace/simple.c
index c0aba00cb7f..e148ca44530 100644
--- a/trace/simple.c
+++ b/trace/simple.c
@@ -163,7 +163,6 @@ static gpointer writeout_thread(gpointer opaque)
     } dropped;
     unsigned int idx = 0;
     int dropped_count;
-    size_t unused __attribute__ ((unused));
     uint64_t type = TRACE_RECORD_TYPE_EVENT;
 
     for (;;) {
@@ -179,13 +178,13 @@ static gpointer writeout_thread(gpointer opaque)
             } while (!g_atomic_int_compare_and_exchange(&dropped_events,
                                                         dropped_count, 0));
             dropped.rec.arguments[0] = dropped_count;
-            unused = fwrite(&type, sizeof(type), 1, trace_fp);
-            unused = fwrite(&dropped.rec, dropped.rec.length, 1, trace_fp);
+            ignore_value(fwrite(&type, sizeof(type), 1, trace_fp));
+            ignore_value(fwrite(&dropped.rec, dropped.rec.length, 1, trace_fp));
         }
 
         while (get_trace_record(idx, &recordptr)) {
-            unused = fwrite(&type, sizeof(type), 1, trace_fp);
-            unused = fwrite(recordptr, recordptr->length, 1, trace_fp);
+            ignore_value(fwrite(&type, sizeof(type), 1, trace_fp));
+            ignore_value(fwrite(recordptr, recordptr->length, 1, trace_fp));
             writeout_idx += recordptr->length;
             free(recordptr); /* don't use g_free, can deadlock when traced */
             idx = writeout_idx % TRACE_BUF_LEN;
-- 
2.55.0


