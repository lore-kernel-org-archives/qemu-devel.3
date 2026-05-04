Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5809FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrbI-0008NE-6k; Mon, 04 May 2026 07:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrb2-0007oz-8J
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJraz-0000v2-6x
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tzBsqml/dM6fWiSEjTcIGoL9jK84pwIUG7THdwR6FSc=;
 b=WBdzyYQSRpG4ZXVwjaDfQSXCHiAWJrd6SbkIGa0A92TO9jHFcHuE7jrZPKkiegAejKMWu6
 cFtlJ1kPGc7xwCZuvtwHS4jO7lYEVfFvkEm079fXd6YvJCmhSJPy7XHZbxKF8kBgmybpb4
 pEvTdmZmQiByEdQAANbU33ryl7up8GY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-xDvQBCAQM1STPmBlb00yLw-1; Mon,
 04 May 2026 07:36:13 -0400
X-MC-Unique: xDvQBCAQM1STPmBlb00yLw-1
X-Mimecast-MFC-AGG-ID: xDvQBCAQM1STPmBlb00yLw_1777894572
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EB311800473
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:36:12 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 458641955D84; Mon,  4 May 2026 11:36:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:34:58 +0400
Subject: [PATCH v2 10/46] hw/intc/apic: move checks to realize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-10-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2954;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=V/1REB7hPU3r4nVJQdLs+FCZBO0CucW41h7dOvCiAK8=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGn4hGzIPORZThbpGxpUr0ANHG0nhpVwWJ9c+X/SSwi4rpsGY
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJp+IRsAAoJENro4Ql1lpzl7iIP/RpA
 Mj2HsuOXfqr66hJkiLvpWPwYVSC1Fiv3b5O7B43y2jtKkaU5OLNSvMo0bADgucmIkseS/g+1hbE
 WYnhjuTlsG07ckHNIFdoHHWHAuBa5bRmRmt/1Arp9EH0uKdmSSCyzO7EKWfyfgMWkmO5JT0eq9T
 lkyGfQ1hQS4HHwVfY1Ho02ne3dHPAhNtV+FEBkZXi46a0znR/pDFoVl/rEVCZSHY+G7WmBJDTC0
 l/pNOjtIr1Car0pvMENUVJ3hIr69ry3foYmqReEOlK8G1INf0JCIB+V1mJnCp5AZhMambCUIz8p
 eSGxQG912nqN5gjIiQ8EaFweGLbxytYddVkh7CHFq4VcT0gKFRIVw5did+X6H8RnlXR/tHrtFBP
 H6T5rXt65p7quO8hlRAERdZ/nHNmkL9CfD0TbC6tMhFfJKBO/hMveafm8h7rSc0wZ8CQwyhcyu1
 Sve8UDUQiqPuhLcuDWVFWadJFGL69lfGThcOuhHog3jZFbDKPihDl/iia8AYht1zm/71/kcrtJf
 NM2cDr2FIyXKkXG/vs/PEdANlSTA3p33Zkqz94UJWkLUzDNdhgMzkn8l9AOxd8RvgUjSOkuzT+j
 UzNEkF7a4ZN0Rhq9qVblC1A7S3uuXaLelpPPNAO0/mFqfjMWQFscRZFGPZDONtS1D7f1Tvlhzex
 6xgRS
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index eaa10ad2a3d..f4f7f6b4d67 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -57,11 +57,7 @@ void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
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


