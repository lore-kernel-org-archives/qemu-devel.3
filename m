Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F39606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VD99KM2m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRIJ-0007zn-KX; Thu, 29 Oct 2026 10:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMRHL-0006fV-7n
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMRHJ-0007Ty-H8
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793284731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c3e2Ct+OT3GPUgejsoL2VwAkgGfTa5FpMy87mdCaido=;
 b=VD99KM2m/Ey4GucbVJssGWtuBP5I8pWh6nwb14tp6VSuYHSojibH8X0si3YP3I9Kn13mUC
 ZeMQ3oBaqO+rNXMLQLPopQOFITAF9VOr+Qx21nj29U3xubvzQbC/PwKflakVtlUGvCLaiB
 Jo9+LNkDTEugGvsram/EuV4un5Boop4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-MQU0g0nhM6K5FoVuf3o6Gg-1; Thu,
 29 Oct 2026 10:38:41 -0400
X-MC-Unique: MQU0g0nhM6K5FoVuf3o6Gg-1
X-Mimecast-MFC-AGG-ID: MQU0g0nhM6K5FoVuf3o6Gg_1793284718
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E7DB1956043; Thu, 29 Oct 2026 14:38:38 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BBE1B195608B; Thu, 29 Oct 2026 14:38:33 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, shaju.abraham@nutanix.com,
 khushit.shah@nutanix.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com,
 7746591750@163.com, maobibo@loongson.cn, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com,
 milesg@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alireza.sanaee@huawei.com
Cc: armbru@redhat.com,
	mbawa@redhat.com
Subject: [PATCH v2 for-11.2 9/9] hw/arm/virt: Make sure virt_get_caches()
 keeps on reading CLIDR_EL1 as 0
Date: Thu, 29 Oct 2026 15:36:56 +0100
Message-ID: <20261029143742.294275-10-eric.auger@redhat.com>
In-Reply-To: <20261029143742.294275-1-eric.auger@redhat.com>
References: <20261029143742.294275-1-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In KVM mode, virt_get_caches() currently gets a zero value for the
CLIDR_EL1 register. This is due to the fact CLIDR is never read from
host. This is a bug.

Soon we will initialize all writable isar.idreg[] from host and this
includes CLIDR_EL1. However, we cannot directly fix the initialization,
first because it would change the way caches are exposed to guest in
DT/ACPI descriptions and because some host values would be rejected
by the current QEMU code, especially in the case host has a unified
L1 cache which is currently not supported and triggers the following
error: "Unified type is not implemented at level 1" error.

So this issue will be fixed separately.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Khushit Shah <khushit.shah@nutanix.com>
Reviewed-by: Gustavo Romero <gromero@redhat.com>

---

v1 -> v2:
- fix the commit msg and improved comment (Gustavo)
---
 hw/arm/virt.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0d56197dac..a80c60f3fa 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -338,6 +338,21 @@ unsigned int virt_get_caches(const VirtMachineState *vms, CPUCoreCaches *caches)
     ARMISARegisters *isar = &armcpu->isar;
     uint32_t clidr = GET_IDREG(isar, CLIDR);
 
+    /*
+     * Commit f669de70011 ("hw/arm/virt: add cache hierarchy to device tree")
+     * read the CLIDR value from the isar array. However, in KVM mode, we failed
+     * to initialize that register value from host and the resulting bug is that
+     * we have always read 0.
+     *
+     * Soon we will initialize all writable isar.idreg[] from host, including
+     * CLIDR_EL1 but we will need to handle compat properly and also extend the
+     * support to unified L1 cache. For now do not pretend we have something
+     * different from 0.
+     */
+    if (kvm_enabled()) {
+        clidr = 0;
+    }
+
     for (int cache_level = 1; cache_level <= CLIDR_CTYPE_MAX_CACHE_LEVEL;
          cache_level++) {
         uint8_t ctype =
-- 
2.53.0


