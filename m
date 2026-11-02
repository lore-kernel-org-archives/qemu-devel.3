Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CD8606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SOjOWsG+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNxIs-0003Qt-4A; Mon, 02 Nov 2026 14:02:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xNxHj-0001vr-C6
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 14:01:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xNxHf-0008DU-II
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 14:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793646090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jKP5HFz810ebf9alfWmuhAqqhtocmxxt5vjo0KJQomg=;
 b=SOjOWsG+PB4e0c1LMMfUzAVBOLth+uGBdjSioSouy/W2UzaRRitmP9zVUS/LEEPSBu0ytn
 3rMdzOfLUbHlZ8N72WSRxJNhlvrDoyHTl0MKOTiMPLhH4UI2ivhgc5E+kvLeDHmDL5+oCn
 r0qCCkRsV0mSCrWZptG6Eq35+vpSAGE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-O__lPeZ8OP6EyAo73df12Q-1; Mon,
 02 Nov 2026 14:01:25 -0500
X-MC-Unique: O__lPeZ8OP6EyAo73df12Q-1
X-Mimecast-MFC-AGG-ID: O__lPeZ8OP6EyAo73df12Q_1793646083
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF7571954AC2; Mon,  2 Nov 2026 19:01:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5A451800446; Mon,  2 Nov 2026 19:01:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Helge Deller <deller@gmx.de>, xen-devel@lists.xenproject.org,
 Anthony PERARD <anthony@xenproject.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 02/25] trace: use 'ignore_value()' instead of a dummy variable
Date: Mon,  2 Nov 2026 13:58:08 -0500
Message-ID: <20261102185831.1880189-3-stefanha@redhat.com>
In-Reply-To: <20261102185831.1880189-1-stefanha@redhat.com>
References: <20261102185831.1880189-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel P. Berrangé <berrange@redhat.com>

This pattern is more concise than using a dummy variable which
in turn needs annotating as unused.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20261102142844.3464712-3-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.56.0


