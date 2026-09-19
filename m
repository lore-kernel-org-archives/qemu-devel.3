Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAA9C982E6
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 14:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7wV4-0007oy-3n; Sat, 19 Sep 2026 10:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frode@tennebo.com>) id 1x7wUT-0007lo-Rz
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 10:56:33 -0400
Received: from gerbil.apple.relay.mailchannels.net ([23.83.208.67])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frode@tennebo.com>) id 1x7wUS-0004cN-1L
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 10:56:33 -0400
X-Sender-Id: hostpapa|x-authuser|frode@tennebo.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 66F0E4C0C43;
 Sat, 19 Sep 2026 14:56:28 +0000 (UTC)
Received: from sh-cp12.mia1.servername.online
 (100-100-66-64.trex-nlb.outbound.svc.cluster.local [100.100.66.64])
 (Authenticated sender: hostpapa)
 by relay.mailchannels.net (Postfix) with ESMTPA id E39B74C0C97;
 Sat, 19 Sep 2026 14:56:27 +0000 (UTC)
X-Sender-Id: hostpapa|x-authuser|frode@tennebo.com
X-MC-Relay: Good
X-MailChannels-SenderId: hostpapa|x-authuser|frode@tennebo.com
X-MailChannels-Auth-Id: hostpapa
X-Trail-Cure: 51a4a6842dd7fceb_1789829788323_3567877458
X-MC-Loop-Signature: 1789829788323:1660060241
X-MC-Ingress-Time: 1789829788322
Received: from sh-cp12.mia1.servername.online (sh-cp12.mia1.servername.online
 [199.204.250.122]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.100.66.64 (trex/8.0.2); Sat, 19 Sep 2026 14:56:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tennebo.com
 ; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TR9mzCPp7hbE3EDRm2xavNzd6BiYlwbMHC9erJ8BWBI=; b=01o3y7bdM4y2Tr3jU/zugDP9mh
 6UMyRZGSoWqoi2JgEnhO1x2GalYMPMrpJCDO2yWQUBf9dd5ByBtPFHUERVTZO0cPpPgKxU3BL8F4w
 ayabO0Wh4oOgbfTA1Hz2OTd+YTrHTmujmTLyRaV9HvPlEXBQc39iD3tIy9TwIaEbx7Gr3y7h8MCbg
 scCnXqXqt9S3navezNcE3/41HC5IdRRlt34Q+jh0nYj9oyfrMbbyZ5x+5LWEw44Dx1USPRbPnvxDb
 z9ydlwFukRDIV00YW0hqaJ2tragF+0SOZlJ8NnaLD81cgOD24u09Lq7lfYdy4rYr5FrMW1fQNds9h
 0xURRWCQ==;
Received: from 55a44a6c.bb.online.no ([85.164.74.108]:50478 helo=[127.0.1.1])
 by sh-cp12.mia1.servername.online with essmtpa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.100)
 (envelope-from <frode@tennebo.com>) id 1x7wUK-0000000BpqJ-39Kd;
 Sat, 19 Sep 2026 10:56:27 -0400
From: =?utf-8?q?Frode_Tenneb=C3=B8?= <frode@tennebo.com>
Date: Sat, 19 Sep 2026 16:56:02 +0200
Subject: [PATCH 1/3] hw/sparc: add shared sun_hostid helper for
 hostid/machineid properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260919-add_hostid_sub-properties-v1-1-cc1667c0a8ad@tennebo.com>
References: <20260919-add_hostid_sub-properties-v1-0-cc1667c0a8ad@tennebo.com>
In-Reply-To: <20260919-add_hostid_sub-properties-v1-0-cc1667c0a8ad@tennebo.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Frode_Tenneb=C3=B8?= <frode@tennebo.com>
X-Mailer: b4 0.13.0
X-AuthUser: frode@tennebo.com
Received-SPF: pass client-ip=23.83.208.67; envelope-from=frode@tennebo.com;
 helo=gerbil.apple.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 19 Sep 2026 10:57:06 -0400
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

Add a small helper, shared between the sun4m and sun4u/sun4v machine
families, implementing "hostid" and "machineid" as -machine
sub-properties.

Both families report a classic 32-bit Sun "hostid" to the guest (as
read by hostid(1), and used by some software for license checks,
built from a fixed per-model machine-type byte plus the
low 24 bits of the machine's Ethernet MAC address, and written into
the emulated NVRAM/IDPROM. Until now neither half was configurable
from the command line.

Rather than duplicate the property getter/setter logic in each
machine family's own file, this introduces a generic SunHostIDProps
struct that a machine's instance struct can embed anywhere, plus two
functions that locate it via the byte offset of that member:

  sun_hostid_class_init()    - registers the "hostid"/"machineid"
                               QOM properties on a given class
  sun_hostid_instance_init() - initialises the "is this value set"
                               flags on a given instance

This patch only adds the new files; hw/sparc/sun4m.c and
hw/sparc64/sun4u.c are wired up to use them in follow-up commits.

Signed-off-by: Frode Tennebø <frode@tennebo.com>
---
 hw/sparc/sun_hostid.c         | 88 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/sparc/sun_hostid.h | 48 +++++++++++++++++++++++
 2 files changed, 136 insertions(+)

diff --git a/hw/sparc/sun_hostid.c b/hw/sparc/sun_hostid.c
new file mode 100644
index 0000000000..30501b4539
--- /dev/null
+++ b/hw/sparc/sun_hostid.c
@@ -0,0 +1,88 @@
+/*
+ * Shared "hostid"/"machineid" -machine sub-property implementation.
+ * See include/hw/sparc/sun_hostid.h for the design rationale.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "hw/sparc/sun_hostid.h"
+
+static void sun_hostid_get_hostid(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    SunHostIDProps *p = sun_hostid_props(obj, (ptrdiff_t)(uintptr_t)opaque);
+    uint32_t value = p->hostid;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void sun_hostid_set_hostid(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    SunHostIDProps *p = sun_hostid_props(obj, (ptrdiff_t)(uintptr_t)opaque);
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+    if (value > 0xffffff) {
+        error_setg(errp,
+                   "hostid must be a 24-bit value (0x000000-0xffffff)");
+        return;
+    }
+    p->hostid = value;
+    p->hostid_set = true;
+}
+
+static void sun_hostid_get_machineid(Object *obj, Visitor *v,
+                                     const char *name, void *opaque,
+                                     Error **errp)
+{
+    SunHostIDProps *p = sun_hostid_props(obj, (ptrdiff_t)(uintptr_t)opaque);
+    uint8_t value = p->machineid;
+
+    visit_type_uint8(v, name, &value, errp);
+}
+
+static void sun_hostid_set_machineid(Object *obj, Visitor *v,
+                                     const char *name, void *opaque,
+                                     Error **errp)
+{
+    SunHostIDProps *p = sun_hostid_props(obj, (ptrdiff_t)(uintptr_t)opaque);
+    uint8_t value;
+
+    if (!visit_type_uint8(v, name, &value, errp)) {
+        return;
+    }
+    p->machineid = value;
+    p->machineid_set = true;
+}
+
+void sun_hostid_class_init(ObjectClass *oc, ptrdiff_t props_offset)
+{
+    void *opaque = (void *)(uintptr_t)props_offset;
+
+    object_class_property_add(oc, "hostid", "uint32",
+                              sun_hostid_get_hostid, sun_hostid_set_hostid,
+                              NULL, opaque);
+    object_class_property_set_description(oc, "hostid",
+        "Override the 24-bit hostid stored in NVRAM/IDPROM "
+        "(low 3 bytes of the classic Sun hostid; independent of "
+        "the emulated NIC's MAC address)");
+
+    object_class_property_add(oc, "machineid", "uint8",
+                               sun_hostid_get_machineid,
+                               sun_hostid_set_machineid, NULL, opaque);
+    object_class_property_set_description(oc, "machineid",
+        "Override the machine-type byte stored in NVRAM/IDPROM "
+        "(top byte of the classic Sun hostid; normally fixed per "
+        "machine model)");
+}
+
+void sun_hostid_instance_init(Object *obj, ptrdiff_t props_offset)
+{
+    SunHostIDProps *p = sun_hostid_props(obj, props_offset);
+
+    p->hostid_set = false;
+    p->machineid_set = false;
+}
diff --git a/include/hw/sparc/sun_hostid.h b/include/hw/sparc/sun_hostid.h
new file mode 100644
index 0000000000..c0ac0a0b87
--- /dev/null
+++ b/include/hw/sparc/sun_hostid.h
@@ -0,0 +1,48 @@
+/*
+ * Shared "hostid"/"machineid" -machine sub-property implementation,
+ * used by both hw/sparc/sun4m.c (sun4m-common) and hw/sparc64/sun4u.c
+ * (sun4u-common) to represent the classic Sun "hostid" (as
+ * reported by hostid(1) and used by some software for license
+ * checks.
+ *
+ * The value is split across the emulated NVRAM/IDPROM into a fixed
+ * per-model machine-type byte and the low 24 bits of the Ethernet
+ * MAC address. These values can be changed in the NVRAM.
+ * For QEMU, each machine family embeds a SunHostIDProps member
+ * anywhere convenient in its own instance struct and wires it up
+ * from instance_init/class_init via the two functions below, passing
+ * the byte offset of that member (offsetof(...)) so the shared
+ * getter/setters can find it regardless of which struct they're in.
+ */
+#ifndef HW_SPARC_SUN_HOSTID_H
+#define HW_SPARC_SUN_HOSTID_H
+
+#include "qom/object.h"
+
+typedef struct SunHostIDProps {
+    uint32_t hostid;      /* low 24 bits valid when hostid_set */
+    uint8_t machineid;    /* valid when machineid_set */
+    bool hostid_set;
+    bool machineid_set;
+} SunHostIDProps;
+
+/*
+ * Register the "hostid" and "machineid" properties on class oc.
+ * props_offset is offsetof(YourMachineState, <SunHostIDProps field>).
+ */
+void sun_hostid_class_init(ObjectClass *oc, ptrdiff_t props_offset);
+
+/*
+ * Initialise the *_set flags to false for a freshly created instance.
+ * Call from your machine's instance_init with the same offset.
+ */
+void sun_hostid_instance_init(Object *obj, ptrdiff_t props_offset);
+
+/* Convenience accessor: fetch the SunHostIDProps embedded at offset. */
+static inline SunHostIDProps *sun_hostid_props(Object *obj,
+                                               ptrdiff_t props_offset)
+{
+    return (SunHostIDProps *)((char *)obj + props_offset);
+}
+
+#endif /* HW_SPARC_SUN_HOSTID_H */

-- 
2.43.0


