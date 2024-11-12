Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC01D42BB3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuKe-0006ZS-RW; Tue, 12 Nov 2024 12:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tAuIe-0003aJ-42
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:03:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tAuIa-0001aj-PH
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 12:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731431007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+AxEZy2EKAfJ4HugDLM4SSnrhVh/F2CqwmRwaOYjnc=;
 b=YJr89xa2eqjy4LIjRgVYFrPxyBIMIE/1t9ZNplMYSfOXRBAaOBjjkFFWRh7ozgbq1hXoGB
 pExrtKpMULEMsrQeJv4DVc0VNIw8tXkIV8ggM55huxBC9qDRW0p8vUuLGIKaGvvbePm30u
 qtcM935BDi6PN09GFKDk9Dd8FpvR9bs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-0RIq40jjMTSaMjpRU07xUA-1; Tue,
 12 Nov 2024 12:03:24 -0500
X-MC-Unique: 0RIq40jjMTSaMjpRU07xUA-1
X-Mimecast-MFC-AGG-ID: 0RIq40jjMTSaMjpRU07xUA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F1F21955BFC; Tue, 12 Nov 2024 17:03:22 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24CDA1956086; Tue, 12 Nov 2024 17:03:18 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: salil.mehta@huawei.com, mst@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com, anisinha@redhat.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, gustavo.romero@linaro.org
Subject: [RFC 5/7] DO NOT MERGE: acpi: cpuhp: add option to AML genrator to
 opt-in to always present vCPUs
Date: Tue, 12 Nov 2024 18:02:56 +0100
Message-ID: <20241112170258.2996640-6-imammedo@redhat.com>
In-Reply-To: <20241112170258.2996640-1-imammedo@redhat.com>
References: <20241112170258.2996640-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Looking at [1] what 'present' bit would do, it's no necessary as it's
statically defined for VM instance. So instead of introducing new ABI
in cpuhp flags register, add CPUHotplugFeatures::always_present_cpus
config option, that when set change _STA default return value to always
present but not enabled. And the interpose 'enabled' check on top of it,
which would set 'enabled' bit in return value if vCPU is enabled.

Platforms that need the feature can opt in by setting
 CPUHotplugFeatures::always_present_cpus = true
for other plaforms _STA will revert to the behavior before [1]

1)
 bf1ecc8dad606 (w/acpi: Update ACPI `_STA` method with QOM vCPU ACPI Hotplug states)
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/cpu.h | 1 +
 hw/acpi/cpu.c         | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 32654dc274..e9e9c28359 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -56,6 +56,7 @@ typedef struct CPUHotplugFeatures {
     bool acpi_1_compatible;
     bool has_legacy_cphp;
     bool fw_unplugs_cpu;
+    bool always_present_cpus;
     const char *smi_path;
 } CPUHotplugFeatures;
 
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5cb60ca8bc..67513450f9 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -452,15 +452,20 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
 
         method = aml_method(CPU_STS_METHOD, 1, AML_SERIALIZED);
         {
+            /*
+             * For always present CPUs set all bits except of 'enabled'
+             * ACPI 1.0b: chapter '6.3.5 _STA'
+             */
+            uint8_t default_sta = opts.always_present_cpus ? 0xd : 0;
             Aml *idx = aml_arg(0);
-            Aml *sta = aml_local(0);
+            Aml *sta = aml_local(default_sta);
 
             aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
             aml_append(method, aml_store(idx, cpu_selector));
             aml_append(method, aml_store(zero, sta));
             ifctx = aml_if(aml_equal(is_enabled, one));
             {
-                aml_append(ifctx, aml_store(aml_int(0xF), sta));
+                aml_append(ifctx, aml_or(aml_int(0xF), sta, sta));
             }
             aml_append(method, ifctx);
             aml_append(method, aml_release(ctrl_lock));
-- 
2.43.0


