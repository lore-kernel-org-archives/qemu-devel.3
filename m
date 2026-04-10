Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C75DF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHQ0-0007Un-4E; Fri, 10 Apr 2026 15:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPp-0006uI-Pu
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHPo-0001bG-52
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7wOl7UndXUNuRv23Xd7plO7oSwHYgXZFefU88CGlrWo=;
 b=jSfT/D3/aoQ+x8ejo9asTSgef4TKTwdwVQh0QoERE+J5VajlQaFFH8rupxng0UtawYz+YT
 GwzwFWKZpolEm0iPx/00GcLmlqSitoC2l/hKPBUvTSgJwDyATZFphjQA6jiyKb00rKTVH8
 TvQPj+EMMEiqcBbcSuAMmciYBnuBkOs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-33THIKEINRa3I6ztWQeWAA-1; Fri,
 10 Apr 2026 15:21:13 -0400
X-MC-Unique: 33THIKEINRa3I6ztWQeWAA-1
X-Mimecast-MFC-AGG-ID: 33THIKEINRa3I6ztWQeWAA_1775848872
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 938011800371; Fri, 10 Apr 2026 19:21:12 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 68DE718002A6; Fri, 10 Apr 2026 19:21:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:45 +0400
Subject: [PATCH v2 23/67] ui/console-vc: move vc_put_lf() to VT100 layer as
 vt100_put_lf()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-23-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AbfZ7yrsZMJ8QK+onxLgGeGlwus1yT9WAbcxhWv1EDs=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGnZTRSgbJELCZ8+YVtBLxn0WLm/AHqIyV2ivFLGAgPYD2etz
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJp2U0UAAoJENro4Ql1lpzlMxoP/RSI
 elvMxJ19JraDqcVVMUxnkrDAmV/xshygLsDF52ImukkKWInt3zGyhphnjjMtlKnT9v7IjtIX8Li
 g/t5mOyVjlFK1bqSq6suD9dvt/6+YH0JejpJ8MSIAVjMWjIhw5UJdtXRSS8Z3Q7EFk7mRbblDlL
 7JQFZVJmqiaIWMgqkztaScjpGNeaOoWePErc6mjuz46rON/4y7qYUHzc7HRB7LU+k/7pQQgs0/V
 Ry6tajdhRwphgnxFoFoLGwJUoDuwzAyYBbJxLIGV/4RlzJSJUuyuP+J/pVNIY9h/hArN3mz/jZe
 Ww7F65Z7FINndZJW01D5I7KBL/MHR3YezSpH+Sz93Fy2sKajaW2fuor8HMMv+oeNLuaeHx6z9jY
 91UhLypBjLZfAwYUp5LTEBF7LYMIfCBZyJZcq/VfAAhOCs4hDbqCMJkZ2IC5i3derqCjCU40lpZ
 56CgVgnUkBe/pKCT1dX/H2umtxBNanTcA9OQZU6fy86TZWH8LRvyXBadK+Ioa8hVOBHrCeKIazK
 NAwL0vLUhwEfFVAFbvXKk7wtGK3x6fuZSYrhK4Q2eTzWc8QVpbYdk1N0xYtCyQKeil9tpNGL/0X
 pVt4gaEO49hA/OvChzOwM5ymg08xTc88gJd4n2uHKEZ3tEym7nzOBl0QxQ5j5CDHUulfm6kFGPG
 zOoBp
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Decouple the line-feed handling from VCChardev by operating on
QemuVT100 directly. The function no longer needs the chardev or
console pointers — callers pass &s->vt instead. This continues the
effort to make the VT100 terminal emulation self-contained.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 85c794062fc..a367622d819 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -435,10 +435,8 @@ static void vt100_set_image(QemuVT100 *vt, pixman_image_t *image)
     vt->cells = cells;
 }
 
-static void vc_put_lf(VCChardev *vc)
+static void vt100_put_lf(QemuVT100 *vt)
 {
-    QemuTextConsole *s = vc->console;
-    QemuVT100 *vt = &s->vt;
     TextCell *c;
     int x, y1;
 
@@ -669,7 +667,7 @@ static void vc_put_one(VCChardev *vc, int ch)
     if (vt->x >= vt->width) {
         /* line wrap */
         vt->x = 0;
-        vc_put_lf(vc);
+        vt100_put_lf(vt);
     }
     y1 = (vt->y_base + vt->y) % vt->total_height;
     c = &vt->cells[y1 * vt->width + vt->x];
@@ -853,7 +851,7 @@ static void vc_putchar(VCChardev *vc, int ch)
             vt->x = 0;
             break;
         case '\n':  /* newline */
-            vc_put_lf(vc);
+            vt100_put_lf(&s->vt);
             break;
         case '\b':  /* backspace */
             if (vt->x > 0)
@@ -862,7 +860,7 @@ static void vc_putchar(VCChardev *vc, int ch)
         case '\t':  /* tabspace */
             if (vt->x + (8 - (vt->x % 8)) > vt->width) {
                 vt->x = 0;
-                vc_put_lf(vc);
+                vt100_put_lf(vt);
             } else {
                 vt->x = vt->x + (8 - (vt->x % 8));
             }

-- 
2.53.0


