Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7181FC79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GP7-0003ye-NG; Sun, 06 Sep 2026 13:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOx-0003jM-Dm
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOv-0000EW-L5
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QgpWisC6gZDaz6p7ndYT2lfOWn8AMMpRYPs6N/pRkAw=;
 b=VzipggVagbGd6Mvea5+2nzQcwVgRUnrxZEs/B0nDrAO4QwZmXwZFnZraELhJdEFWN48ukz
 XG1ikTOvyd4G76ENv9GrOG4Ihsx1TwFDszE3i1Uc2b5+GbtAfSlOGa6kkcHuU4RJDfVkia
 leP2Luhtow2hXZD8pC2nhI/qUN+7Jyw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-DFAOSt6qN8aJvG7J3U_z5w-1; Sun,
 06 Sep 2026 13:11:27 -0400
X-MC-Unique: DFAOSt6qN8aJvG7J3U_z5w-1
X-Mimecast-MFC-AGG-ID: DFAOSt6qN8aJvG7J3U_z5w_1788714686
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92C041954228; Sun,  6 Sep 2026 17:11:26 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31C931955F06; Sun,  6 Sep 2026 17:11:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/40] hw/sensor: tmp105: enforce the configurable fault queue
Date: Sun,  6 Sep 2026 19:10:09 +0200
Message-ID: <20260906171021.26568-29-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

The fault-queue depth selected in the configuration register was decoded
but never consulted, so the ALERT pin tripped on the very first
out-of-limit conversion regardless of the programmed depth.

Track the consecutive-fault count and only change the ALERT state once
it reaches the programmed depth; any in-range conversion clears the
count. The default configuration keeps the previous behaviour. The count
is migrated through an optional subsection so existing streams stay
compatible.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator-v2-4-1266926ba769@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/sensor/tmp105.c | 87 +++++++++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 32 deletions(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index f7d0c738caa8..5c77f991cc20 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -54,6 +54,7 @@ struct TMP105State {
     int16_t temperature;
     int16_t limit[2];
     int faults;
+    uint8_t fault_count;
     uint8_t alarm;
     /*
      * The TMP105 initially looks for a temperature rising above T_high;
@@ -78,43 +79,40 @@ static void tmp105_interrupt_update(TMP105State *s)
 
 static void tmp105_alarm_update(TMP105State *s, bool one_shot)
 {
+    bool fault;
+
     if (FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE) && !one_shot) {
         return;
     }
 
-    if (FIELD_EX8(s->config, CONFIG, THERMOSTAT_MODE)) {
-        /*
-         * TM == 1 : Interrupt mode. We signal Alert when the
-         * temperature rises above T_high, and expect the guest to clear
-         * it (eg by reading a device register).
-         */
-        if (s->detect_falling) {
-            if (s->temperature < s->limit[0]) {
-                s->alarm = 1;
-                s->detect_falling = false;
-            }
-        } else {
-            if (s->temperature >= s->limit[1]) {
-                s->alarm = 1;
-                s->detect_falling = true;
-            }
-        }
+    /*
+     * A fault is a conversion that lies outside the limit currently being
+     * watched: above T_high while looking for the alarm to trip, below T_low
+     * afterwards.
+     */
+    if (s->detect_falling) {
+        fault = s->temperature < s->limit[0];
     } else {
-        /*
-         * TM == 0 : Comparator mode. We signal Alert when the temperature
-         * rises above T_high, and stop signalling it when the temperature
-         * falls below T_low.
-         */
+        fault = s->temperature >= s->limit[1];
+    }
+
+    if (!fault) {
+        s->fault_count = 0;
+    } else if (++s->fault_count >= s->faults) {
+        s->fault_count = 0;
         if (s->detect_falling) {
-            if (s->temperature < s->limit[0]) {
-                s->alarm = 0;
-                s->detect_falling = false;
-            }
+            /*
+             * Temperature fell back below T_low. In comparator mode (TM == 0)
+             * the alarm is released; in interrupt mode (TM == 1) it is
+             * asserted again and the guest is expected to clear it by reading
+             * a register.
+             */
+            s->alarm = FIELD_EX8(s->config, CONFIG, THERMOSTAT_MODE);
+            s->detect_falling = false;
         } else {
-            if (s->temperature >= s->limit[1]) {
-                s->alarm = 1;
-                s->detect_falling = true;
-            }
+            /* Temperature rose to or above T_high: assert the alarm. */
+            s->alarm = 1;
+            s->detect_falling = true;
         }
     }
 
@@ -204,7 +202,12 @@ static void tmp105_write(TMP105State *s)
         }
         s->config = FIELD_DP8(s->buf[0], CONFIG, ONE_SHOT, 0);
         s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
-        tmp105_alarm_update(s, FIELD_EX8(s->buf[0], CONFIG, ONE_SHOT));
+        if (FIELD_EX8(s->buf[0], CONFIG, ONE_SHOT) &&
+            FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE)) {
+            tmp105_alarm_update(s, true);
+        } else {
+            tmp105_interrupt_update(s);
+        }
         break;
 
     case TMP105_REG_T_LOW:
@@ -213,7 +216,7 @@ static void tmp105_write(TMP105State *s)
             s->limit[s->pointer & 1] = (int16_t)
                     ((((uint16_t) s->buf[0]) << 8) | (s->buf[1] & 0xf0));
         }
-        tmp105_alarm_update(s, false);
+        tmp105_interrupt_update(s);
         break;
     }
 }
@@ -281,6 +284,13 @@ static bool detect_falling_needed(void *opaque)
     return s->detect_falling;
 }
 
+static bool fault_count_needed(void *opaque)
+{
+    const TMP105State *s = opaque;
+
+    return s->fault_count != 0;
+}
+
 static const VMStateDescription vmstate_tmp105_detect_falling = {
     .name = "TMP105/detect-falling",
     .version_id = 1,
@@ -292,6 +302,17 @@ static const VMStateDescription vmstate_tmp105_detect_falling = {
     }
 };
 
+static const VMStateDescription vmstate_tmp105_fault_count = {
+    .name = "TMP105/fault-count",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = fault_count_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8(fault_count, TMP105State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_tmp105 = {
     .name = "TMP105",
     .version_id = 0,
@@ -310,6 +331,7 @@ static const VMStateDescription vmstate_tmp105 = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_tmp105_detect_falling,
+        &vmstate_tmp105_fault_count,
         NULL
     }
 };
@@ -322,6 +344,7 @@ static void tmp105_reset_hold(Object *obj, ResetType type)
     s->pointer = 0;
     s->config = 0;
     s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
+    s->fault_count = 0;
     s->alarm = 0;
     s->detect_falling = false;
 
-- 
2.55.0


