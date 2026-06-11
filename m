Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379FBCD98D5
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 09:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXbKV-000074-Si; Thu, 11 Jun 2026 05:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKU-00006r-Hv
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXbKS-0004WA-Q0
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 05:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781168640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Smidf6FMOj3LuQCqpb0c6LifDKbvfiyh56oQEfYvK00=;
 b=TYZNuqXP9lx8azGrv2Bq4vZ5TGlQiJQOHmgB3zAxAUCSXq4ubVgZDIvUBTfpfoPbCEHi/a
 jsBJk1eFvAKRYwSaXH3UXnwMx07+zhMAtZVQJM+q+FLxSXGM8fUZkEA9qYD1tEBzmWyqei
 UJs6HEdpmy2PLyxyH8v1kux/0u0tf10=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-Zs8AfaNpP7-digZY3Tad2w-1; Thu,
 11 Jun 2026 05:03:56 -0400
X-MC-Unique: Zs8AfaNpP7-digZY3Tad2w-1
X-Mimecast-MFC-AGG-ID: Zs8AfaNpP7-digZY3Tad2w_1781168635
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AB6019560A1; Thu, 11 Jun 2026 09:03:55 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 664DD19541B2; Thu, 11 Jun 2026 09:03:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jun 2026 13:03:18 +0400
Subject: [PATCH v3 03/35] irq: add per-IRQ observer to fix
 qemu_irq_intercept_in leak
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260611-b4-ui-v3-3-72bcbbea0fae@redhat.com>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
In-Reply-To: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4758;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AgfY59Jw3FWwwFgiVCxaDztJQCKR319w+PzxgVpWWCs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKnndGPJZOIJsbGpAfn8IeXH89XuarbByT8S5m
 hwl8xDjIm6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaip53QAKCRDa6OEJdZac
 5YCOD/9Yt88JPH/wzCnpf1kwyN2iI51uAwkjqzYBIlBgDcJ1JvDUxokEExEVFQ1oJAyhSWVwvuV
 aJTaag/GKjjouwlAKVUF8yiMoo8sDF3wP0qY7Gkxo/8ttkkW5aPTKxg8qzsc/jCMl0JWkULjodw
 2S/J2zCIjwnrUdclj8eB63xey2p1fMyv3v8v7wCMz08klNcVbaMs/tfyzEW5OUF2Wffqy8Yndxl
 SKEnCv1ROdnLJNASWbemeiJfoylCrphMIom1K8qwqQ4eEXpGc7XV4z/UInGoQ1o8iEM4TQBafHt
 T3olxQPYgMTFQjcKsrhQmAFZdybnh2rPyNsRuI5MXgZWrMHZlRclGl/dhX3xaHxvfDNI49oi2lh
 oysbBOKnkzJWyQ6iqbpnHQfEWvxDA3lCiyFp5bGZLHdW9QRy4ou8bxRRIZav1fLZJODq9fJv/ml
 pdibDwqiNw3B6+ociPn+0qwPB7l8eFSPrc20f3xKTZ//BoK+5IcNRrmk0muyVMGz2wlbi6xhmU0
 pCmgGjDAXYtvIAMXqW+XdNXKnJyeYqIk3YKvmKpHl6WoIcsNwieimJmBICEUR2IniaLxp+9lusd
 j+PQ2+327ez7+tccBF9U7QArk2b3V3jeoAZaaruSTEIpS9HRJSWY1z7RwMkL8CTmAXM5UQEdt+w
 BLasrAXhP7c2++A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


