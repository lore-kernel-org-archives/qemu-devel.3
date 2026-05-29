Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B84CD6E51
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvDC-00019z-Mw; Fri, 29 May 2026 07:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvDA-00019k-E5
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wSvD8-0008Ce-Ol
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780053425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wY3DqdzotWKSNT8RMduN5EZCcx+3OdHIWy49nisB+mE=;
 b=Whuj2Ra9XyImm4jm4CzuXi4TSFAZJIBcWu9n8C+oVpkLiqjucT1UQV5ubgWZgs+ELwQk8k
 vaCCR7jYzBoZOZdpXHgcpMCuACXQawg4+HlScsKyC9EvTOthU12mSBDPhPHIfS6SW87ldt
 w+bxRjCBa/ziDo6JUziYKSOedykLoU8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-zG8795jPMD6m_MPWQ4NC6A-1; Fri,
 29 May 2026 07:17:02 -0400
X-MC-Unique: zG8795jPMD6m_MPWQ4NC6A-1
X-Mimecast-MFC-AGG-ID: zG8795jPMD6m_MPWQ4NC6A_1780053421
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8E571956094; Fri, 29 May 2026 11:17:00 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 524D1180034E; Fri, 29 May 2026 11:16:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 15:16:24 +0400
Subject: [PATCH 03/32] irq: add per-IRQ observer to fix
 qemu_irq_intercept_in leak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-b4-ui-v1-3-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
In-Reply-To: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Alex Williamson <alex@shazbot.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3581;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8BV9XKCCJHZtxTMIxPScYaA1rInwrGcYDZ1yr66/tJo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqGXWOFMQhK4a1tths1eevg0SnUN23BHppedz8r
 up91MnUqN6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCahl1jgAKCRDa6OEJdZac
 5TlND/9fVyASCBAIODtrOAsaeylTqbQeS0HsPlaRP9/xS6cxH0ivye0Qpj6veEs0OmzuTbIMvoZ
 pvRzxevsXZs4M+lo0R37H7OSd+y85SnnLlApsU9pOyiCTLcUHhvW8TnwEEb+Zri1+lklhvtcqNe
 NnDE6p0j8+7BwG70tm5DIlBOUN9AFWGEG9U3uar2OUUvjojSm1hhgaVRaoN26+jYGVripc8jrYg
 ExFJF42kxU+s1H5PFuvkkahgu7qk+IXZohQZZtmr9aX0Uw92UiBybT2Qe3ipPZvhKQGd2euvQkB
 2gkWMRpvkc9jKw9Ry42Z67bgcIezRW3kQoUeDaj2sx5viBMXBarrx0TrmbaMaZsN4uyo6YYJd5O
 8w3ix245/L+KWOvzGKE8FJ/lVz6FL73bN2t+Z5SRAZTww5oKEcqXwJFrmBSdGc6z9jiZGGKyrAP
 EVE5kQ27TY4n9Lc7FIub/vVgkv2rOJG1la38d0EGZS77rcTGJJHfcpsjZNPxQLkpZKACsl+K5NQ
 y0t/OanjCXTBcDCQCXYVm8q2asBNF9DEUrDxREIzwCjWzAiz5XKHs0fqZPfw86cOJCIWUBcwMI+
 N/a7DbalUHDXHObtIcHTFRU101HGrC+Wld5dguvk17kmWw3RZk7ICHbBkT0ygdZb+R16jA6xGGM
 0h+JLtxD4Cx2G5w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

qemu_irq_intercept_in() saves original IRQ handlers by allocating
new QOM objects, which are never freed. On a PC machine, this leaks
IRQ objects (one per IOAPIC pin) on every qtest run.

Rather than tracking allocations to free later, avoid them: add an
"observer" field to IRQState, called by qemu_set_irq() after the
real handler. Interception sets the observer instead of rewriting
handlers, so there's nothing to save and nothing to leak.

Fix qemu_notirq() to route through qemu_set_irq() so inverted IRQs
trigger observers too. Drop the LSan suppression.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/core/irq.h         |  1 +
 hw/core/irq.c                 | 10 +++++-----
 system/qtest.c                |  3 ---
 scripts/lsan_suppressions.txt |  8 --------
 4 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/include/hw/core/irq.h b/include/hw/core/irq.h
index 291fdd67df4..93d5710a73e 100644
--- a/include/hw/core/irq.h
+++ b/include/hw/core/irq.h
@@ -14,6 +14,7 @@ struct IRQState {
     qemu_irq_handler handler;
     void *opaque;
     int n;
+    qemu_irq_handler observer;
 };
 
 void qemu_set_irq(qemu_irq irq, int level);
diff --git a/hw/core/irq.c b/hw/core/irq.c
index 106805e2417..fa11e9bc0aa 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -32,6 +32,9 @@ void qemu_set_irq(qemu_irq irq, int level)
         return;
 
     irq->handler(irq->opaque, irq->n, level);
+    if (unlikely(irq->observer)) {
+        irq->observer(irq->opaque, irq->n, level);
+    }
 }
 
 static void init_irq_fields(IRQState *irq, qemu_irq_handler handler,
@@ -111,7 +114,7 @@ static void qemu_notirq(void *opaque, int line, int level)
 {
     IRQState *irq = opaque;
 
-    irq->handler(irq->opaque, irq->n, !level);
+    qemu_set_irq(irq, !level);
 }
 
 qemu_irq qemu_irq_invert(qemu_irq irq)
@@ -124,11 +127,8 @@ qemu_irq qemu_irq_invert(qemu_irq irq)
 void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, int n)
 {
     int i;
-    qemu_irq *old_irqs = qemu_allocate_irqs(NULL, NULL, n);
     for (i = 0; i < n; i++) {
-        *old_irqs[i] = *gpio_in[i];
-        gpio_in[i]->handler = handler;
-        gpio_in[i]->opaque = &old_irqs[i];
+        gpio_in[i]->observer = handler;
     }
 }
 
diff --git a/system/qtest.c b/system/qtest.c
index a79d10d1361..b359a3e1c84 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -324,9 +324,6 @@ void qtest_sendf(CharFrontend *chr, const char *fmt, ...)
 
 static void qtest_irq_handler(void *opaque, int n, int level)
 {
-    qemu_irq old_irq = *(qemu_irq *)opaque;
-    qemu_set_irq(old_irq, level);
-
     if (irq_levels[n] != level) {
         CharFrontend *chr = &qtest->qtest_chr;
         irq_levels[n] = level;
diff --git a/scripts/lsan_suppressions.txt b/scripts/lsan_suppressions.txt
index f88bbab18b8..30256bc6d01 100644
--- a/scripts/lsan_suppressions.txt
+++ b/scripts/lsan_suppressions.txt
@@ -16,11 +16,3 @@ leak:/lib64/libxkbcommon.so.0
 # https://github.com/GNOME/glib/blob/main/tools/glib.supp
 # This avoids false positive leak reports for the qga-ssh-test.
 leak:g_set_user_dirs
-
-# qemu_irq_intercept_in is only used by the qtest harness, and
-# its API inherently involves a leak.
-# While we could keep track of the old IRQ data structure
-# in order to free it, it doesn't seem very important to fix
-# since it is only used by the qtest test harness.
-# Just ignore the leak, at least for the moment.
-leak:qemu_irq_intercept_in

-- 
2.54.0


