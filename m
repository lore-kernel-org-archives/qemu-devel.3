Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AA6606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YIBcdd7b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUto-0005tk-GD; Thu, 12 Nov 2026 08:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUtk-0005rL-At
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRUti-00022x-Fn
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RUzFWFtSUedVfRo+7wUDvuFIpBlo7nzvNHrYqCgurLc=;
 b=YIBcdd7bt27469qSmWibHzGZ11vdmumbsT5zhrbkPHvefichwS8aTwrmgVGlav6692rkkv
 zjNtBqADnas4MzSW0d8Q4ItJNncQGCt74mqKNRdSXqCZFyRHf0wIXTcF5nhzpgm/b+MwT0
 4DC83t+Tf64KonBkwYgyNQQnCinPbMI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-zI_7leHIOP-7IewCYOJSow-1; Thu,
 12 Nov 2026 08:31:24 -0500
X-MC-Unique: zI_7leHIOP-7IewCYOJSow-1
X-Mimecast-MFC-AGG-ID: zI_7leHIOP-7IewCYOJSow_1794490282
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25B4A1899FF6; Thu, 12 Nov 2026 13:31:22 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB2F21955DB9; Thu, 12 Nov 2026 13:31:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 13/48] hw/avr: convert machines to use AliasedClass interface
Date: Thu, 12 Nov 2026 13:30:19 +0000
Message-ID: <20261112133054.1977618-14-berrange@redhat.com>
In-Reply-To: <20261112133054.1977618-1-berrange@redhat.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stop setting 'alias' in the MachineClass and instead set
'aliases' in the AliasedClass.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/avr/arduino.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
index e166ca18e11..fbcdc32a21f 100644
--- a/hw/avr/arduino.c
+++ b/hw/avr/arduino.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "atmega.h"
 #include "boot.h"
-#include "qom/object.h"
+#include "qom/object_interfaces.h"
 
 struct ArduinoMachineState {
     /*< private >*/
@@ -73,13 +73,18 @@ static void arduino_duemilanove_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
+    AliasedClass *alc = ALIASED_CLASS(mc);
+    static const char *const aliases[] = {
+        MACHINE_TYPE_NAME("2009"), NULL,
+    };
+
+    alc->aliases = aliases;
 
     /*
      * https://www.arduino.cc/en/Main/ArduinoBoardDuemilanove
      * https://www.arduino.cc/en/uploads/Main/arduino-duemilanove-schematic.pdf
      */
     mc->desc        = "Arduino Duemilanove (ATmega168)",
-    mc->alias       = "2009";
     amc->mcu_type   = TYPE_ATMEGA168_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000;
 };
@@ -88,13 +93,18 @@ static void arduino_uno_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
+    AliasedClass *alc = ALIASED_CLASS(mc);
+    static const char *const aliases[] = {
+        MACHINE_TYPE_NAME("uno"), NULL,
+    };
+
+    alc->aliases = aliases;
 
     /*
      * https://store.arduino.cc/arduino-uno-rev3
      * https://www.arduino.cc/en/uploads/Main/arduino-uno-schematic.pdf
      */
     mc->desc        = "Arduino UNO (ATmega328P)";
-    mc->alias       = "uno";
     amc->mcu_type   = TYPE_ATMEGA328_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000;
 };
@@ -103,13 +113,18 @@ static void arduino_mega_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
+    AliasedClass *alc = ALIASED_CLASS(mc);
+    static const char *const aliases[] = {
+        MACHINE_TYPE_NAME("mega"), NULL,
+    };
+
+    alc->aliases = aliases;
 
     /*
      * https://www.arduino.cc/en/Main/ArduinoBoardMega
      * https://www.arduino.cc/en/uploads/Main/arduino-mega2560-schematic.pdf
      */
     mc->desc        = "Arduino Mega (ATmega1280)";
-    mc->alias       = "mega";
     amc->mcu_type   = TYPE_ATMEGA1280_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000;
 };
@@ -118,13 +133,18 @@ static void arduino_mega2560_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     ArduinoMachineClass *amc = ARDUINO_MACHINE_CLASS(oc);
+    AliasedClass *alc = ALIASED_CLASS(mc);
+    static const char *const aliases[] = {
+        MACHINE_TYPE_NAME("mega2560"), NULL,
+    };
+
+    alc->aliases = aliases;
 
     /*
      * https://store.arduino.cc/arduino-mega-2560-rev3
      * https://www.arduino.cc/en/uploads/Main/arduino-mega2560_R3-sch.pdf
      */
     mc->desc        = "Arduino Mega 2560 (ATmega2560)";
-    mc->alias       = "mega2560";
     amc->mcu_type   = TYPE_ATMEGA2560_MCU;
     amc->xtal_hz    = 16 * 1000 * 1000; /* CSTCE16M0V53-R0 */
 };
-- 
2.56.1


