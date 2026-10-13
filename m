Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3890CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXT-0006OE-IV; Tue, 13 Oct 2026 09:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVd-0003J7-Iz
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVb-000513-91
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUZIcmPsZ2Q4s1D9GK6zbZwpOVuApkVXh7EOi1BsWDk=;
 b=TbIxKk77wfJMNJGfhhvRkt7u+GxZJIHv9tq1SQ1RmSwcfsFVXo4aoV0DXRWaP+rdzzsWlO
 tbxjOG8CceV9z3vAzQlph18Qx0s43eP11XSNsu3Q85yOpDpqh1YJXJFuzKGCb5jeWuOnqs
 6UpK4dwB7fFQiXrJrumALbQg2qFfoWo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-v_74eKo6MhmvPxkkxSqbpA-1; Tue,
 13 Oct 2026 13:25:27 +0000
X-MC-Unique: v_74eKo6MhmvPxkkxSqbpA-1
X-Mimecast-MFC-AGG-ID: v_74eKo6MhmvPxkkxSqbpA_1791897926
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D88AE195FDFC; Tue, 13 Oct 2026 13:25:25 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4478195608D; Tue, 13 Oct 2026 13:25:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:31 +0400
Subject: [GIT PULL 34/40] ui/vnc-enc-zrle: propagate zrle_compress_data error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-34-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pEZ9BbbojAf/6arCFAqnTDuGUGfXTmYWqloqTv3Ammc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDEadxpbctie42qhdkP/IWNl3ndYA2bGpiQD
 vhH+ilkRv6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wxAAKCRDa6OEJdZac
 5axsD/9rGCX3+ptLzt94ZxXc3Ac4uv7Oszp5NeHFQaPBonxFISIGh6Nyj5h7hPLVQFm1xp5UfxH
 UQzveh4IxyGKUrdHYHeLNivkOcQB6lVRJFFa5BgIHXJ7JUMaq2w+i+xPThLPOEoXxtDIVEbzVl9
 PPpW88+9tJf43k6wFgab+P4gufy794R40ztmoftK7bfClqOINCmFc/W7+RxcRGELCW6a+emY50x
 x4hViPQ24YUpbHKAZcpvcj8zh5U4dvaqPfNf1pq9nFM9rMOf0//7pPzb3hozRrXytgRKCz+lIDT
 fh3bwRbR4HFf8xD8ZDl/Vxa9AtNaLElsz95G4hrKPlafXKIsikdFWZLqcdO72d0jeLvQsQnEaOm
 yuP/Miouoq+IpLx504As7d026PRf4DbCzPVrV5ySgvUCcZzk3jj3JBIuOCqosXObpyfohq1IOWb
 Nb9Tyb9RJ3OxSQK1qIbnOgbVczKRRIUK9ERRi7Rk46jsIrcHtPAA8CmW1NaKHmUErNoj1jSdtvc
 Zfgp+PrIjM3Yt8jHCT5suRzrc9jgKtWsLV+G8Lms1uMr65YRRb3QjWGX2kZN+dcYh+MCJfZKM7D
 H7vw8AwF+3IYS1iNVRLpTKikgncpj3lmbtyqcvmJz1Y2F06m1TDBO8VbjlvUdLyRRwRTK4rpG6B
 gbJ1h/5KXUtzPQQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

zrle_compress_data() returns -1 on failure, but the caller stored
the result in a size_t, silently converting the error to a large
positive value. Change to int to match the return type, add an
Error **errp parameter replacing fprintf to stderr, and check
for errors before using the result.

Reported-by: Hui Peng <benquike@gmail.com>
Fixes: 148954faca58 ("vnc: Add ZRLE and ZYWRLE encodings.")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-17-ccbef537cbeb@redhat.com>
---
 ui/vnc-enc-zrle.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/ui/vnc-enc-zrle.c b/ui/vnc-enc-zrle.c
index 7679014c9e33..c0702891b4f8 100644
--- a/ui/vnc-enc-zrle.c
+++ b/ui/vnc-enc-zrle.c
@@ -27,6 +27,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "vnc.h"
 #include "vnc-enc-zrle.h"
 
@@ -69,7 +71,8 @@ static void *zrle_convert_fb(VncState *vs, VncZrle *zrle,
     return zrle->fb.buffer;
 }
 
-static int zrle_compress_data(VncState *vs, VncZrle *zrle, int level)
+static int zrle_compress_data(VncState *vs, VncZrle *zrle, int level,
+                              Error **errp)
 {
     z_streamp zstream = &zrle->stream;
 
@@ -85,7 +88,7 @@ static int zrle_compress_data(VncState *vs, VncZrle *zrle, int level)
                            MAX_MEM_LEVEL, Z_DEFAULT_STRATEGY);
 
         if (err != Z_OK) {
-            fprintf(stderr, "VNC: error initializing zlib\n");
+            error_setg(errp, "ZRLE: error initializing zlib");
             return -1;
         }
 
@@ -104,7 +107,7 @@ static int zrle_compress_data(VncState *vs, VncZrle *zrle, int level)
 
     /* start encoding */
     if (deflate(zstream, Z_SYNC_FLUSH) != Z_OK) {
-        fprintf(stderr, "VNC: error during zrle compression\n");
+        error_setg(errp, "ZRLE: error during compression");
         return -1;
     }
 
@@ -256,7 +259,8 @@ static int zrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
                                         int x, int y, int w, int h)
 {
     bool be = vs->client_endian == G_BIG_ENDIAN;
-    size_t bytes;
+    Error *error = NULL;
+    int bytes;
     int zywrle_level;
 
     if (worker->zrle.type == VNC_ENCODING_ZYWRLE) {
@@ -336,7 +340,12 @@ static int zrle_send_framebuffer_update(VncState *vs, VncWorker *worker,
     }
 
     vnc_zrle_stop(vs, &worker->zrle);
-    bytes = zrle_compress_data(vs, &worker->zrle, Z_DEFAULT_COMPRESSION);
+    bytes = zrle_compress_data(vs, &worker->zrle, Z_DEFAULT_COMPRESSION,
+                               &error);
+    if (bytes < 0) {
+        error_report_err(error);
+        return -1;
+    }
     vnc_framebuffer_update(vs, x, y, w, h, worker->zrle.type);
     vnc_write_u32(vs, bytes);
     vnc_write(vs, worker->zrle.zlib.buffer, worker->zrle.zlib.offset);

-- 
2.56.0.116.g6de20f6092dc


