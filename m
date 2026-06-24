Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6291FCDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcLzQ-0007Zj-Jw; Wed, 24 Jun 2026 07:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLzP-0007Zb-47
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcLzN-0007ZK-CR
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kxxSNW/0rLIJXiH+QnSWeyVs1a+aQybhcuyThQb55xo=;
 b=HjsK8rL6jlTG2RgMJlW5yCQYZNCbA41TT21erGzShIz34jas8C3ylaJlgAsRbOmO2UxCbt
 GwHNpOkGuc810zQ56Eixw8zedHZHNMJg9gysAIejXkGgLSfsjS3vczG+OC2t42BdzIqXMJ
 Kdvzf3K9KtB19UFHEMopCU3GMCLI0B8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-Qpt9W6AJN66QqQwqfy58BQ-1; Wed,
 24 Jun 2026 07:41:51 -0400
X-MC-Unique: Qpt9W6AJN66QqQwqfy58BQ-1
X-Mimecast-MFC-AGG-ID: Qpt9W6AJN66QqQwqfy58BQ_1782301311
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ACAFF1954195
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:41:50 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95CB1195609E; Wed, 24 Jun 2026 11:41:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:25 +0400
Subject: [GIT PULL 03/35] irq: add per-IRQ observer to fix
 qemu_irq_intercept_in leak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-3-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4940;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SyhThLXVKTt14H6h4alDKK+ub1yL3BsCOMw07A+6K3s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8Jmm/T7x0tfAUSLnes0DpQSCrq+qbKY6n2fY
 2eksud3iZOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCZgAKCRDa6OEJdZac
 5eXOEACt1J4wilkayY1KSWRzShqSxLsKquMzxxK68n2UYdaYEvoHNAfyEvWi6tL6YRE8gRGgAZ3
 N85yGUlveXD9+GTqZZOhfKot/n0c4DGPz4502jbAZBD8QHfa0Q2Lo1RybP8JvkxQIKCu+g+Uep2
 aq7uBe2cIilsCer/UZ+zB+n34VcI4drnX6w8u2WlKB/dxVAFGrUfCaAlb15nt7gyZNWMpP+YkDo
 oRJ5D/GpUB2fLBwHw6hg1+SqRfSWx6lHfswGqwDPVixjVpHEwW2o85I+lVzCrvIQwrsZHqf1484
 IwwCkh6Y1mwmTJPsd+ImuPx1CnDYU3PGNBncQszQVwGx2Do+AVocrnt983X4IPqPBxs+XK9aElt
 ay00F2XFUr8veLagxd1No4w82PakFkU8b+pQiNa+6d68pFbjBiOOCpRMUp3OuMRx3PHvZfySuHp
 OfzfsBhZDtDcTbW+rbmUU2jN8mRhlzX93SMvfH+cuR2tm0XR7Qb7PcFHFEPx6pVM3DWuiHuSNLX
 bqmKIYz9bYy53+vzC/cyseAsDzg8z/N8pjSLDF6ECsSmWgB9A4A4cxFgIuHCyeXXT4btkdDywKm
 93roOLOmF/toohzmFNmDpcnXJ9PB0o/OqGFJjwB1VQ9hyhIMcgHzttsoDRD9p7enb7q1veii73t
 XMYtBWBKIN7UWIw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-3-4656aec3398d@redhat.com>
---
 include/hw/core/irq.h         |  6 +++---
 hw/core/irq.c                 | 12 ++++++------
 system/qtest.c                |  5 +----
 scripts/lsan_suppressions.txt |  8 --------
 4 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/include/hw/core/irq.h b/include/hw/core/irq.h
index 291fdd67df4..299a4a9a8ce 100644
--- a/include/hw/core/irq.h
+++ b/include/hw/core/irq.h
@@ -14,6 +14,7 @@ struct IRQState {
     qemu_irq_handler handler;
     void *opaque;
     int n;
+    qemu_irq_handler observer;
 };
 
 void qemu_set_irq(qemu_irq irq, int level);
@@ -96,9 +97,8 @@ void qemu_free_irq(qemu_irq irq);
 /* Returns a new IRQ with opposite polarity.  */
 qemu_irq qemu_irq_invert(qemu_irq irq);
 
-/* For internal use in qtest.  Similar to qemu_irq_split, but operating
-   on an existing vector of qemu_irq.  */
-void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, int n);
+/* For internal use in qtest. */
+void qemu_irq_set_observer(qemu_irq *gpio_in, qemu_irq_handler handler, int n);
 
 /**
  * qemu_irq_is_connected: Return true if IRQ line is wired up
diff --git a/hw/core/irq.c b/hw/core/irq.c
index 106805e2417..1b610e75e15 100644
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
@@ -121,14 +124,11 @@ qemu_irq qemu_irq_invert(qemu_irq irq)
     return qemu_allocate_irq(qemu_notirq, irq, 0);
 }
 
-void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, int n)
+void qemu_irq_set_observer(qemu_irq *gpio_in, qemu_irq_handler handler, int n)
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
index fd37bcbfaab..cf301239177 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -326,9 +326,6 @@ void qtest_sendf(CharFrontend *chr, const char *fmt, ...)
 
 static void qtest_irq_handler(void *opaque, int n, int level)
 {
-    qemu_irq old_irq = *(qemu_irq *)opaque;
-    qemu_set_irq(old_irq, level);
-
     if (irq_levels[n] != level) {
         CharFrontend *chr = &qtest->qtest_chr;
         irq_levels[n] = level;
@@ -421,7 +418,7 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
                     interception_succeeded = true;
                 }
             } else {
-                qemu_irq_intercept_in(ngl->in, qtest_irq_handler,
+                qemu_irq_set_observer(ngl->in, qtest_irq_handler,
                                       ngl->num_in);
                 interception_succeeded = true;
             }
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


