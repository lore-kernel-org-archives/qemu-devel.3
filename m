Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A599CCD4F25
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 08:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO9wg-0005cr-RA; Sat, 16 May 2026 04:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9wV-0005LP-KX
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wO9wT-0007RC-EU
 for qemu-devel@nongnu.org; Sat, 16 May 2026 04:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778918412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Svp94K9ltl7osqc8aHL2v+NM7N1LmXuvHp5XMBZkMxE=;
 b=Qd09JKlVOUlhbYF4gPw7QXfkWiEkptzQc/8SBRuKOAXf3K4l9TZt4WEKnlDRlWJpId58dY
 RJRUZ29ptKZknAWKd9R6ttp8iM7Y6WJsli1xfrS8TeClKL/eg0JmfMhPq+5HH4hLMgZHm+
 a4kmabkC2dzUAuQqX4I7bFzum3jyX1s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-QbR6auFVO6az4tPXj2roRQ-1; Sat,
 16 May 2026 04:00:10 -0400
X-MC-Unique: QbR6auFVO6az4tPXj2roRQ-1
X-Mimecast-MFC-AGG-ID: QbR6auFVO6az4tPXj2roRQ_1778918409
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE5AB180034E
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 08:00:09 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E6DB1800349; Sat, 16 May 2026 08:00:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 16 May 2026 11:59:08 +0400
Subject: [PATCH v3 09/24] hw/intc/apic: move checks to realize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-qom-tests-v3-9-3f20c3a029a7@redhat.com>
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2954;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=M65iE9wl2UK083ridVP7VDYH3qQY8kBa9mO0RUTKoIE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqCCPP1XOm7SuEKzvDbeSugf4S+Ni+m5ZMLTxuw
 hTdiN68drWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaggjzwAKCRDa6OEJdZac
 5SCPD/9MxYEL2/cIRvbweAKeug7NAUArNO1LMdzEchkaASneoJMC806R13nKh0bc7c5qlEYoMOc
 rqlq4l8hoaqYTiQQ2Lrz+ZAK0WVIISEWBQopj/znZHxQ//zpVt3hDaBhTRf2PRcLFwXI1jcs1fk
 +E+OijBGyBKSXSgMf7Af2HYMXAfhmKB4CTo0UTqMRB5MuGldm2dImtv6D2D9ilAv7eDGfYCQ6fe
 ThCFHEIb5mxUNSi3s19TeWptQSI/V0X685V3az9Be6GLWW8fzoRCEVPCi2mJDpZG2C5Wp6GMxi+
 9Ur6Gup1+KXUnoWLn9REUMDogCENUuH4j7zC9K2yJ/e3762R4taktXGkcwoQ4ACD4RhciYjpX8a
 EgPq7jAf5DQ9eOmrSFOmD06zH9ZFzSCf/Z14CdvK7sg5z1JtGopVWEGXGFAr/9OqQmpK0gYMoH/
 BoHv+klWEmB4fFk625Ktl5UZw9iOqAh1scrE9cK2QmP2zBZfyoR/zB/lVE8yextAiRPi9VZpkuS
 PLjS4SLppm+lSP6D/SO6dow9MZN65f/OJukPLSb5O9LkTB3YlA8GWXtZOIrsF6QkqMWKT+aoRat
 UtmMKcdLD+O8vWLyeFL/+pVw7fZINb5kNDt/14f2fSiM8ACoKL6K5fsVwsU7sjGwuEDq87uBTPK
 T4jfqNHRhVwtESQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

apic_common_set_id() dereferences s->cpu to check for x2APIC support
when the APIC ID is >= 255. On a standalone APIC object that has not
been attached to a CPU, s->cpu is NULL, causing a segfault.

To solve this, move validation during realize().

Fixes: b5ee0468e9d2 ("apic: add support for x2APIC mode")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/intc/apic_common.c  | 23 +++++++++++++----------
 target/i386/cpu-apic.c |  6 +-----
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index bf4abc21d7b..49c03a5bcee 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -257,6 +257,19 @@ static void apic_common_realize(DeviceState *dev, Error **errp)
     static DeviceState *vapic;
     uint32_t instance_id = s->initial_apic_id;
 
+    if (!s->cpu) {
+        error_setg(errp, "APIC is not attached to a CPU");
+        return;
+    }
+
+    if (s->initial_apic_id >= 255 &&
+        !cpu_has_x2apic_feature(&s->cpu->env)) {
+        error_setg(errp, "APIC ID %d requires x2APIC feature in CPU",
+                   s->initial_apic_id);
+        error_append_hint(errp, "Try x2apic=on in -cpu.\n");
+        return;
+    }
+
     /* Normally initial APIC ID should be no more than hundreds */
     assert(instance_id != VMSTATE_INSTANCE_ID_ANY);
 
@@ -410,7 +423,6 @@ static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
     APICCommonState *s = APIC_COMMON(obj);
     DeviceState *dev = DEVICE(obj);
     uint32_t value;
-    Error *local_err = NULL;
 
     if (dev->realized) {
         qdev_prop_set_after_realize(dev, name, errp);
@@ -421,15 +433,6 @@ static void apic_common_set_id(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    if (value >= 255 && !cpu_has_x2apic_feature(&s->cpu->env)) {
-        error_setg(&local_err,
-                   "APIC ID %d requires x2APIC feature in CPU",
-                   value);
-        error_append_hint(&local_err, "Try x2apic=on in -cpu.\n");
-        error_propagate(errp, local_err);
-        return;
-    }
-
     s->initial_apic_id = value;
     s->id = (uint8_t)value;
 }
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index 5599a4675c5..04b7257ad12 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -56,11 +56,7 @@ void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
     cpu->apic_state->cpu = cpu;
     cpu->apic_state->apicbase = APIC_DEFAULT_ADDRESS | MSR_IA32_APICBASE_ENABLE;
 
-    /*
-     * apic_common_set_id needs to check if the CPU has x2APIC
-     * feature in case APIC ID >= 255, so we need to set cpu->apic_state->cpu
-     * before setting APIC ID
-     */
+    /* cpu must be set before realize, which validates the APIC ID */
     qdev_prop_set_uint32(DEVICE(cpu->apic_state), "id", cpu->apic_id);
 }
 

-- 
2.54.0


