Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05DDEE20A2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 13:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voLlC-00072J-5R; Fri, 06 Feb 2026 08:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1voLkn-0006ph-II
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:20:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1voLkl-0005bG-Sn
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770384007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v45w8vWRpxU1Mq7tjX2SU/Run2WqlnthpZPGBVSvSEo=;
 b=Vyu65p0Qw4g6eIJXv7ZqZeQPNr/zzf9cV1nUaIyi21+eAHTq5Yq2BYsUlqNnPzVDSSGRFj
 2blq3e0p0T+x3i4xQHaD7iwCe8IhJyYuG9MDQzMjUeaSqoubGbkIbpPgHa8CCC08112rYM
 zmlQstoRsKmc0hxGihGDdbaIrbBABE8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-VtWyXO_YNq6xSk2njgJyDA-1; Fri,
 06 Feb 2026 08:14:56 -0500
X-MC-Unique: VtWyXO_YNq6xSk2njgJyDA-1
X-Mimecast-MFC-AGG-ID: VtWyXO_YNq6xSk2njgJyDA_1770383695
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A03D0187CCD8; Fri,  6 Feb 2026 13:14:49 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 345F018003F6; Fri,  6 Feb 2026 13:14:46 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Subject: [PATCH 02/11] machine: add "acpi-watchdog" property
Date: Fri,  6 Feb 2026 14:14:29 +0100
Message-ID: <20260206131438.1857182-3-imammedo@redhat.com>
In-Reply-To: <20260206131438.1857182-1-imammedo@redhat.com>
References: <20260206131438.1857182-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

It will be used by following code to enable ACPI watchdog.
Initial support will bring it to Q35 and arm/virt machines using
respective iTCO and GWDT watchdogs as hardware backend.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/core/boards.h |  1 +
 hw/core/machine.c        | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 07f8938752..25577c3aac 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -447,6 +447,7 @@ struct MachineState {
     struct NVDIMMState *nvdimms_state;
     struct NumaState *numa_state;
     bool acpi_spcr_enabled;
+    bool acpi_watchdog;
 };
 
 /*
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6411e68856..4ca808fb73 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -499,6 +499,20 @@ static void machine_set_usb(Object *obj, bool value, Error **errp)
     ms->usb_disabled = !value;
 }
 
+static bool machine_get_acpi_watchdog(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->acpi_watchdog;
+}
+
+static void machine_set_acpi_watchdog(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->acpi_watchdog = value;
+}
+
 static bool machine_get_graphics(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1257,6 +1271,12 @@ static void machine_class_init(ObjectClass *oc, const void *data)
         NULL, NULL);
     object_class_property_set_description(oc, "memory",
         "Memory size configuration");
+
+    object_class_property_add_bool(oc, "acpi-watchdog",
+        machine_get_acpi_watchdog, machine_set_acpi_watchdog);
+     object_class_property_set_description(oc, "acpi-watchdog",
+        "Set on/off to enable/disable ACPI watchdog."
+        " Default: off (ACPI watchdog is disabled).");
 }
 
 static void machine_class_base_init(ObjectClass *oc, const void *data)
-- 
2.47.3


