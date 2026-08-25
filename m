Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E35CC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyr9-0005t4-6D; Tue, 25 Aug 2026 17:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyr7-0005sE-KF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:53 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyr5-00056E-Sh
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 9609F80BF4;
 Wed, 26 Aug 2026 00:38:50 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-5rYjpZ4y; Wed, 26 Aug 2026 00:38:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693929;
 bh=ruTE9n4bIPwJtg+8yoYt/Cw2K0p82HwIULvvyww/7i4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=HPxw759vuaCFwsyxK6V6YAUlrRaXqZ76gq4Oaq4omRdZTFtxMSZWcnwYTHRGjR3uC
 jP8Rz+lRDJYFaGNKE67sp2uzUCkDdtqgAyVrAZaRRS9AvbOWI2Te0L9jXPiYqGT/lM
 /BFQv5hEwpyKsLdEzyTKPG0AhTSVtJm26eMitrVU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH 20/30] avr/machine: move to new migration APIs
Date: Wed, 26 Aug 2026 00:38:00 +0300
Message-ID: <20260825213811.3725682-21-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 target/avr/machine.c | 50 +++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/target/avr/machine.c b/target/avr/machine.c
index 8064a7214a3..2f6283743c7 100644
--- a/target/avr/machine.c
+++ b/target/avr/machine.c
@@ -23,78 +23,80 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 
-static int get_sreg(QEMUFile *f, void *opaque, size_t size,
-                    const VMStateField *field)
+static bool load_sreg(QEMUFile *f, void *opaque, size_t size,
+                     const VMStateField *field, Error **errp)
 {
     CPUAVRState *env = opaque;
     uint8_t sreg;
 
     sreg = qemu_get_byte(f);
     cpu_set_sreg(env, sreg);
-    return 0;
+    return true;
 }
 
-static int put_sreg(QEMUFile *f, void *opaque, size_t size,
-                    const VMStateField *field, JSONWriter *vmdesc)
+static bool save_sreg(QEMUFile *f, void *opaque, size_t size,
+                     const VMStateField *field, JSONWriter *vmdesc,
+                     Error **errp)
 {
     CPUAVRState *env = opaque;
     uint8_t sreg = cpu_get_sreg(env);
 
     qemu_put_byte(f, sreg);
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vms_sreg = {
     .name = "sreg",
-    .get = get_sreg,
-    .put = put_sreg,
+    .load = load_sreg,
+    .save = save_sreg,
 };
 
-static int get_segment(QEMUFile *f, void *opaque, size_t size,
-                       const VMStateField *field)
+static bool load_segment(QEMUFile *f, void *opaque, size_t size,
+                        const VMStateField *field, Error **errp)
 {
     uint32_t *ramp = opaque;
     uint8_t temp;
 
     temp = qemu_get_byte(f);
     *ramp = ((uint32_t)temp) << 16;
-    return 0;
+    return true;
 }
 
-static int put_segment(QEMUFile *f, void *opaque, size_t size,
-                       const VMStateField *field, JSONWriter *vmdesc)
+static bool save_segment(QEMUFile *f, void *opaque, size_t size,
+                        const VMStateField *field, JSONWriter *vmdesc,
+                        Error **errp)
 {
     uint32_t *ramp = opaque;
     uint8_t temp = *ramp >> 16;
 
     qemu_put_byte(f, temp);
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vms_rampD = {
     .name = "rampD",
-    .get = get_segment,
-    .put = put_segment,
+    .load = load_segment,
+    .save = save_segment,
 };
 static const VMStateInfo vms_rampX = {
     .name = "rampX",
-    .get = get_segment,
-    .put = put_segment,
+    .load = load_segment,
+    .save = save_segment,
 };
 static const VMStateInfo vms_rampY = {
     .name = "rampY",
-    .get = get_segment,
-    .put = put_segment,
+    .load = load_segment,
+    .save = save_segment,
 };
 static const VMStateInfo vms_rampZ = {
     .name = "rampZ",
-    .get = get_segment,
-    .put = put_segment,
+    .load = load_segment,
+    .save = save_segment,
 };
 static const VMStateInfo vms_eind = {
     .name = "eind",
-    .get = get_segment,
-    .put = put_segment,
+    .load = load_segment,
+    .save = save_segment,
 };
 
 const VMStateDescription vms_avr_cpu = {
-- 
2.43.0


