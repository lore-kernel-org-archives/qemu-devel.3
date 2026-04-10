Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ECDF45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHOc-0003eM-8K; Fri, 10 Apr 2026 15:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHOa-0003Tq-E4
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHOZ-0000qM-10
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVtXUd3/vnIW9OWxR+IrxGHFdO8ndQ7MDKjHO+ZSuxs=;
 b=F5ZFh+Ilr50rZq2FQXNpei9roqRweULwE4fcjVb1YEToJDFwS04/DDzCsSdbo6N7G0B4Oa
 4mD33kzJDaSckbl6q+b7DBSiIzNqMbnNVPIn7b2KhqNRVMDFRV/cjwwrAcBMoWJXXZ2iVR
 8U1hRtq//R0WVge6MjBYHVctmDlefGY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-h-bk7hw6MnKbfBnvI-fy8g-1; Fri,
 10 Apr 2026 15:19:55 -0400
X-MC-Unique: h-bk7hw6MnKbfBnvI-fy8g-1
X-Mimecast-MFC-AGG-ID: h-bk7hw6MnKbfBnvI-fy8g_1775848794
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30EAE1800BED
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:19:54 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1133D19560AB; Fri, 10 Apr 2026 19:19:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:18:32 +0400
Subject: [PATCH v2 10/67] ui/console-vc: ignore string-type escape
 sequences
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-10-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2045;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=m7qmdCz70Vht0Po69gBkjQ+7bxeu8B0z/LwcEPzXT8o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0UWMOYphewUu/SP9fn+qqHNkY4OwSH4wRqq
 hxvCdAa3aiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFAAKCRDa6OEJdZac
 5TK0D/wI6POFjveO6ZH1hK70vYP14aBpIO8mx9oogGIW9vVCeDJAo3gzDDp+X7wZa7JXA3+o4vd
 ve3aC1Ry17qu4eA8s1wT3YGVzfclxY0vDt3krCSvCDXHYtt13wVOqEPu/ZwX8Ly1jrp5V7z8M1t
 /NesmOXx9uVRq+vlvDyUi9kAsUKIUoS7mLAUb5IeNj9cEVLbZF7vB67pSfeUgYR1MGgSQVDzpwC
 tp2pRYnpffzHdjbQTSxLP4hSexn8R/faSq+7azwQfbVk2bMSHndd7sRlpK6SX8p/UyZrbkv7kIl
 wSpgvIDSHlU4dlXfeXf7PXK7TcVjZFNwFcT9A2ccVGLGT0nuaLp58IB0KaOKOjVDQj3HA3XRkCU
 wuDKorb1ZdIWcrj68KQeddI6LD4Q5sAIWgj4bmD9q+pYuYpNckC9hYSTzyrNMSj4YUz6TUtYp8t
 pJCpHdPRndvbyE1wMBrju5kLJAMjqCmi7bkiyuJ+TOm5+WRtQap4zmVDl5pZ2mX5xeX4+6X5iK5
 npCSELRu85Rg7bCqs3x+yIa4+zJev80nKvM90DwzBwxn3IZ0vDmQ0IG9BAUm4PymUvc1dPhqFth
 R0CnJ7xh+e5hIrTOrIuSnmjS9HlxQ3L/qKR1m2/eqJPo+rznQLMiNywyDyGyH4/3NZgkZ6aUrRX
 3fttw4clpeYmGbw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Modern terminals and applications emit OSC (Operating System Command),
DCS, SOS, PM, and APC escape sequences (e.g. for setting window
titles).  The text console currently does not recognise these
string-type introducers, so each byte of the payload is interpreted as
a normal character or a new escape, producing garbage on screen.

Add a TTY_STATE_OSC state that silently consumes all bytes until the
sequence is terminated by BEL or ST (ESC \).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index d9d6966410a..f1d38ee8ada 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -45,6 +45,7 @@ enum TTYState {
     TTY_STATE_CSI,
     TTY_STATE_G0,
     TTY_STATE_G1,
+    TTY_STATE_OSC,
 };
 
 typedef struct QemuTextConsole {
@@ -868,6 +869,10 @@ static void vc_putchar(VCChardev *vc, int ch)
             vc->state = TTY_STATE_G0;
         } else if (ch == ')') {
             vc->state = TTY_STATE_G1;
+        } else if (ch == ']' || ch == 'P' || ch == 'X'
+                   || ch == '^' || ch == '_') {
+            /* String sequences: OSC, DCS, SOS, PM, APC */
+            vc->state = TTY_STATE_OSC;
         } else if (ch == '7') {
             vc_save_cursor(vc);
             vc->state = TTY_STATE_NORM;
@@ -1026,6 +1031,16 @@ static void vc_putchar(VCChardev *vc, int ch)
             break;
         }
         break;
+    case TTY_STATE_OSC: /* Operating System Command: ESC ] ... BEL/ST */
+        if (ch == '\a') {
+            /* BEL terminates OSC */
+            vc->state = TTY_STATE_NORM;
+        } else if (ch == 27) {
+            /* ESC might start ST (ESC \) */
+            vc->state = TTY_STATE_ESC;
+        }
+        /* All other bytes are silently consumed */
+        break;
     case TTY_STATE_G0: /* set character sets */
     case TTY_STATE_G1: /* set character sets */
         switch (ch) {

-- 
2.53.0


