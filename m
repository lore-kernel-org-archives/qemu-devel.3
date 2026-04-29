Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE04CD13D9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC4r-0004Qn-HV; Wed, 29 Apr 2026 17:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC4q-0004O9-4c
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC4o-0003Kq-NP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JmFBcPpPg70cERCREd01+2LUoYOfsSp3YOvkB7jQRG0=;
 b=Tr4bowoy0XHn1L1EVNtLVnl8x28XFp0zL3HXOnXrfJ1VmOfEHtL/fEHybPW0eSYfev7VoS
 0HTpU03O9p29NYAm4U/Ai8ZGZKXgoZ0BxZEO3AoWv2ERnMTCna38klaXP+3ada/lEjaef+
 tYFsCd3LlLnXy2sACNxPTG6mL0vWjiI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-6daXo7iwMsGaUmEWulvX4g-1; Wed,
 29 Apr 2026 17:04:08 -0400
X-MC-Unique: 6daXo7iwMsGaUmEWulvX4g-1
X-Mimecast-MFC-AGG-ID: 6daXo7iwMsGaUmEWulvX4g_1777496647
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D3B118002C5; Wed, 29 Apr 2026 21:04:07 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 122DC180045E; Wed, 29 Apr 2026 21:04:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:02:42 +0400
Subject: [PATCH v3 09/26] ui/console-vc: extract vt100_keysym() from
 qemu_text_console_handle_keysym()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-qemu-vnc-v3-9-be96757428d0@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
In-Reply-To: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2776;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8joCuZ7b714/pI2LClfiZ7KWft0awWMucbiOwUmsTxo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nILU+Q/oNywn9fn08iSyerRrEu/KyO0EmrpW
 oFflTXWRy+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyCwAKCRDa6OEJdZac
 5bGED/9XYcXEvdpVU7ZnV9pUa1NjfP872/1lqReXmRV3MgVn6IsBQk8cP0oc9znqYOalcWE3uya
 HHFwQPH2Y9505F733R3Gi1VwKgPtINSs0spschmlX9hxa9toazXV3A4oOR/Xo9JMVVcSCYjWlko
 qGA9JOEjLo02e2Eud6U9zb0QWdjlPOvMlw2ZMmr+Bg90KuhZXpzOCO/xa6dLvDiJ9P9XeyFZv3a
 GhjWRzhjc4gmllkWQWRNootwkypj2CQovrrpziPJ4yBPN9rUi+XryZGUi2HZIC1A4OpJi54Ww/6
 6ZBTsYaRTLHV0KoQ/Dq+JsShNIg0HOBm32PSs1m9Ba65deUlwNVr86VNt2lAFOtuAX38ko/HwLn
 BmZ5PXZINpekffxa2VgbyWRH0EkgnwvFdv89doaVR63Dt1HJHO7XQf+WvOFK5VHeX2Wxd/q9mPK
 CnhsFMM813/9ZiCqM9B7XlfYUwd+WRCP3OazMIomTDUoADZkHF+jRsaJfCdgfj5CWq8tALRMBz1
 lAaqokIm00si2+K8g3dyfijgkp8y7kP4MmjW+PZtrCd32OZAwcpw6aoFkJgNJ4/vlfT5qNAXckT
 nkPQVFy7KYfCSeBQE3g+vioaKLMnP26NHRnJ/Vj/buCPE9JHKgbH6k1cocNScWV5bBMhjj6uH4M
 Gc1wv/osDJAUwKA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Move the keysym handling logic out of qemu_text_console_handle_keysym()
into a new vt100_keysym() helper that operates on QemuVT100 directly,
continuing the effort to decouple the VT100 layer from the console layer.

The echo path is updated to call vt100_input() instead of
qemu_chr_write(), since the function no longer has direct access
to the chardev.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 024ab277e0b..9f5f49413d2 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -331,24 +331,25 @@ static void vt100_write(QemuVT100 *vt, const void *buf, size_t len)
     vt->out_flush(vt);
 }
 
-/* called when an ascii key is pressed */
-void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
+static int vt100_input(QemuVT100 *vt, const uint8_t *buf, int len);
+
+static void vt100_keysym(QemuVT100 *vt, int keysym)
 {
     uint8_t buf[16], *q;
     int c;
 
     switch(keysym) {
     case QEMU_KEY_CTRL_UP:
-        vt100_scroll(&s->vt, -1);
+        vt100_scroll(vt, -1);
         break;
     case QEMU_KEY_CTRL_DOWN:
-        vt100_scroll(&s->vt, 1);
+        vt100_scroll(vt, 1);
         break;
     case QEMU_KEY_CTRL_PAGEUP:
-        vt100_scroll(&s->vt, -10);
+        vt100_scroll(vt, -10);
         break;
     case QEMU_KEY_CTRL_PAGEDOWN:
-        vt100_scroll(&s->vt, 10);
+        vt100_scroll(vt, 10);
         break;
     default:
         /* convert the QEMU keysym to VT100 key string */
@@ -365,18 +366,24 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
             *q++ = '\033';
             *q++ = '[';
             *q++ = keysym & 0xff;
-        } else if (s->vt.echo && (keysym == '\r' || keysym == '\n')) {
-            qemu_chr_write(s->chr, (uint8_t *)"\r", 1, true);
+        } else if (vt->echo && (keysym == '\r' || keysym == '\n')) {
+            vt100_input(vt, (uint8_t *)"\r", 1);
             *q++ = '\n';
         } else {
             *q++ = keysym;
         }
-        if (s->vt.echo) {
-            qemu_chr_write(s->chr, buf, q - buf, true);
+        if (vt->echo) {
+            vt100_input(vt, buf, q - buf);
         }
-        vt100_write(&s->vt, buf, q - buf);
+        vt100_write(vt, buf, q - buf);
         break;
     }
+
+}
+/* called when an ascii key is pressed */
+void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
+{
+    vt100_keysym(&s->vt, keysym);
 }
 
 static void text_console_update(void *opaque, console_ch_t *chardata)

-- 
2.54.0


