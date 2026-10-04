Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E912CCA5FCE
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJOo-0005LW-Vu; Sun, 04 Oct 2026 06:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOe-0004uS-Gn
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOd-0002vl-0z
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iLn0HToiQucmhekriPBtu8oNm8TCPFkMRRfueNJ5LDY=;
 b=QBLMxIw6rCWaVTMenTayS/rU206HDcu3EkCxz3nZfh6E55NnhWuD+V97oOiDwaNJOq8I4W
 ACANQnt6WnEYNNoNrSd/e//B4z06BMqc5RG+/C/YKj1525oymbp4aWlufrbwjA8RpYkFfE
 7sijrVYZKdyd/1G1TCWZAIiYPImawo0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-4Rj0UVQkNV6a3gC0CsKOLQ-1; Sun,
 04 Oct 2026 06:24:39 -0400
X-MC-Unique: 4Rj0UVQkNV6a3gC0CsKOLQ-1
X-Mimecast-MFC-AGG-ID: 4Rj0UVQkNV6a3gC0CsKOLQ_1791109478
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43F9B180061C; Sun,  4 Oct 2026 10:24:38 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C1A119560AB; Sun,  4 Oct 2026 10:24:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:31 +0400
Subject: [PATCH 17/63] ui/vnc-enc-zrle: propagate zrle_compress_data error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-17-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2914;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=/Qya3Ys4W2DAVAfgzCU1/qn0qYJaUsv84IXi+9j/VQU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikiRO/c+b3PyTM9b+HHVFawdjzdKEKX96CHh
 sGA6Vfpb8mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIgAKCRDa6OEJdZac
 5fR9D/sFTOBD3EDm58ccURpccpiWzUyC0D0VLQlSLqAGke92BxhvQxyFZskHjANj3M+96c6cMLN
 nKBdZeEyeH+jwy3KAPmhDGO1QnraSwGl58QXJ3iEUyUX9vCKTczVqXE0uv3zzrkWEgOD60Cs3oi
 IFOjBmgY6OIZ8rv9AjVGHdIOBCmZ6pleay08FWlONmFojlPyswkmKEM646g1XJ1AGlFreSZ/MCJ
 ZFIaz3g+2MgNydU15So4jIegs5IYlOgmcypPDVwti0Se/n/amorbJoFMqnhw7++ZPWXyr3UqUc4
 0wKeq2B65pxDvqPwHASdFBJRPbfTPOq900D3S1sxFEQrlf3QM9ydMqP+ZFABDS86c4HwRvZJZFW
 /uyUMtCYyhOImGYo7BzpMUgrKKiqh/eFaf4A1xOCBof7l+YyeZMxVKSuwkRU6NT+8PTAKby1+ny
 CNnODK+bKYM1a/6X6v9A60os56vEuRgae4Mw3JH6M893k9m/1SBUtiI2mNkGdwYekZi6whXtGSK
 +G/h/QEcH/m/lmAT/IbMfHNJBHM3rTO4QiJc2JqEvF46FvC+501CA0tblGFuz8U2dRJZqO3T3B+
 Wjropv1TSenP8o5hqBsaGXC+5rydXbk6UO9pfJQ1tzX/N3EskL7gRgQbK7Yuz3lUMTf+pFwSKra
 2vjszvlOs6phAUw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reported-by: Pavee Hui <phui@google.com>
Fixes: 148954faca58 ("vnc: Add ZRLE and ZYWRLE encodings.")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
2.56.0.rc0.29.g47ce80527c56


