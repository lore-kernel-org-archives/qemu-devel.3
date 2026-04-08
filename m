Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E4910F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYJM-0007xC-ID; Wed, 08 Apr 2026 15:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAYGt-0004ui-LU; Wed, 08 Apr 2026 15:09:06 -0400
Received: from mail-05.mail-europe.com ([85.9.206.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matt@matthewpenney.net>)
 id 1wAHL5-0001LR-V7; Tue, 07 Apr 2026 21:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matthewpenney.net;
 s=protonmail; t=1775610124; x=1775869324;
 bh=axp9OvX2u/1jELssvVNz/X82F+EVXOIbQ2Ns624NQ98=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=G/Omia9pDQrucoGX9D2WymyPX7/ggOqz+4YU+1keUf+ISw9boiB1hGKNF6LWrhvGD
 QrBt1lOycaHd2MegDn75fG1EtLks2K0QAK6xZBCm+x2n/OAMtGK6jLM+SZx7Ql/LAE
 sQR+rFGqn1Vj897B4hMsJuIYimsQE1F3Pt0k4kWlOE2q7y8PIGvBoeCxt9cuRDRY1e
 E9xnCJWjBYHhMa+bym9cxFI2y2bzIIN8axXL3sOybs+HTke0LtqLuvKfrtKhH9NiVR
 irfe/blqNBGfEkg97TaDwOsAyPHNoH2iyec0yGjjF1inxcoRGGtcxZjGmg0nXTLbgn
 QhXMmLIWDizxg==
Date: Wed, 08 Apr 2026 01:01:58 +0000
To: qemu-devel@nongnu.org
From: Matthew Penney <matt@matthewpenney.net>
Cc: Matthew Penney <matt@matthewpenney.net>, peter.maydell@linaro.org,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 joel@jms.id.au, "Michael S. Tsirkin" <mst@redhat.com>, sam@rfc1149.net,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 "Collin L. Walling" <walling@linux.ibm.com>, cohuck@redhat.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, lvivier@redhat.com,
 amit@kernel.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 1/8] hw/char: use g_clear_handle_id() for GSource cleanup
Message-ID: <20260408010026.4611-2-matt@matthewpenney.net>
Feedback-ID: 185185778:user:proton
X-Pm-Message-ID: d72ce9499a15f39196aa172ce73e39dc25ed90eb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=85.9.206.169; envelope-from=matt@matthewpenney.net;
 helo=mail-05.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Use g_clear_handle_id() instead of g_source_remove() with manual ID
checking and zeroing.

This simplifies the code and ensures consistent handling of GSource IDs,
since g_clear_handle_id() checks for a non-zero ID before calling the
cleanup function and zeros it afterwards.

No functional change intended.

Signed-off-by: Matthew Penney <matt@matthewpenney.net>
---
 hw/char/cmsdk-apb-uart.c  |  5 +----
 hw/char/nrf51_uart.c      |  5 +----
 hw/char/serial.c          |  7 ++-----
 hw/char/stm32l4x5_usart.c |  5 +----
 hw/char/terminal3270.c    |  5 +----
 hw/char/virtio-console.c  | 11 +++--------
 6 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
index edb80f6181..0631821a57 100644
--- a/hw/char/cmsdk-apb-uart.c
+++ b/hw/char/cmsdk-apb-uart.c
@@ -236,10 +236,7 @@ buffer_drained:
=20
 static void uart_cancel_transmit(CMSDKAPBUART *s)
 {
-    if (s->watch_tag) {
-        g_source_remove(s->watch_tag);
-        s->watch_tag =3D 0;
-    }
+    g_clear_handle_id(&s->watch_tag, g_source_remove);
 }
=20
 static void uart_write(void *opaque, hwaddr offset, uint64_t value,
diff --git a/hw/char/nrf51_uart.c b/hw/char/nrf51_uart.c
index 7306923244..96f0d085fd 100644
--- a/hw/char/nrf51_uart.c
+++ b/hw/char/nrf51_uart.c
@@ -104,10 +104,7 @@ buffer_drained:
=20
 static void uart_cancel_transmit(NRF51UARTState *s)
 {
-    if (s->watch_tag) {
-        g_source_remove(s->watch_tag);
-        s->watch_tag =3D 0;
-    }
+    g_clear_handle_id(&s->watch_tag, g_source_remove);
 }
=20
 static void uart_write(void *opaque, hwaddr addr,
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 0f3469a1e8..cfb5efed50 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -857,10 +857,7 @@ static void serial_reset(void *opaque)
 {
     SerialState *s =3D opaque;
=20
-    if (s->watch_tag > 0) {
-        g_source_remove(s->watch_tag);
-        s->watch_tag =3D 0;
-    }
+    g_clear_handle_id(&s->watch_tag, g_source_remove);
=20
     s->rbr =3D 0;
     s->ier =3D 0;
@@ -913,7 +910,7 @@ static int serial_be_change(void *opaque)
     }
=20
     if (s->watch_tag > 0) {
-        g_source_remove(s->watch_tag);
+        g_clear_handle_id(&s->watch_tag, g_source_remove);
         s->watch_tag =3D qemu_chr_fe_add_watch(&s->chr, G_IO_OUT | G_IO_HU=
P,
                                              serial_watch_cb, s);
     }
diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index 736f1e764e..dd1b099195 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -280,10 +280,7 @@ buffer_drained:
=20
 static void usart_cancel_transmit(Stm32l4x5UsartBaseState *s)
 {
-    if (s->watch_tag) {
-        g_source_remove(s->watch_tag);
-        s->watch_tag =3D 0;
-    }
+    g_clear_handle_id(&s->watch_tag, g_source_remove);
 }
=20
 static void stm32l4x5_update_params(Stm32l4x5UsartBaseState *s)
diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 1d857bad9b..989b6f6ee1 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -52,10 +52,7 @@ static int terminal_can_read(void *opaque)
=20
 static void terminal_timer_cancel(Terminal3270 *t)
 {
-    if (t->timer_tag) {
-        g_source_remove(t->timer_tag);
-        t->timer_tag =3D 0;
-    }
+    g_clear_handle_id(&t->timer_tag, g_source_remove);
 }
=20
 /*
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index efe7cd6772..4de8577c13 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -159,10 +159,7 @@ static void chr_event(void *opaque, QEMUChrEvent event=
)
         virtio_serial_open(port);
         break;
     case CHR_EVENT_CLOSED:
-        if (vcon->watch) {
-            g_source_remove(vcon->watch);
-            vcon->watch =3D 0;
-        }
+        g_clear_handle_id(&vcon->watch, g_source_remove);
         virtio_serial_close(port);
         break;
     case CHR_EVENT_BREAK:
@@ -188,7 +185,7 @@ static int chr_be_change(void *opaque)
     }
=20
     if (vcon->watch) {
-        g_source_remove(vcon->watch);
+        g_clear_handle_id(&vcon->watch, g_source_remove);
         vcon->watch =3D qemu_chr_fe_add_watch(&vcon->chr,
                                             G_IO_OUT | G_IO_HUP,
                                             chr_write_unblocked, vcon);
@@ -256,9 +253,7 @@ static void virtconsole_unrealize(DeviceState *dev)
 {
     VirtConsole *vcon =3D VIRTIO_CONSOLE(dev);
=20
-    if (vcon->watch) {
-        g_clear_handle_id(&vcon->watch, g_source_remove);
-    }
+    g_clear_handle_id(&vcon->watch, g_source_remove);
 }
=20
 static void virtconsole_class_init(ObjectClass *klass, const void *data)
--=20
2.53.0



