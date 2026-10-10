Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD52CA6017
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFXHc-00024f-Ue; Sat, 10 Oct 2026 09:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXHa-0001wg-4p
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:38:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXHY-0004b6-NG
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791639516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vbBNwYmdqWnLEJ+d5lcNwGr8+ZO1ZyY8BY+i6F3iv7s=;
 b=YWpnpqovq5MA8qFcL0XcqaBF5xCdKI81bpA4B65LFPmx/24Xnj9k8DkcwcV8kqPzhdHD6z
 74upmcfHx9cZN9BgTsayhtbG8ghirZJe6lgBvL6UOqlkBI5pw5mL2kNuGqlO9DuDNeo3dY
 e5roAofjTzUEh5CqVjR0bKH0fcvyg7s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-uB2iRn8UPheDRXe62kqzeA-1; Sat,
 10 Oct 2026 13:38:32 +0000
X-MC-Unique: uB2iRn8UPheDRXe62kqzeA-1
X-Mimecast-MFC-AGG-ID: uB2iRn8UPheDRXe62kqzeA_1791639511
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E877C1953955; Sat, 10 Oct 2026 13:38:30 +0000 (UTC)
Received: from laptop.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 773C330000E5; Sat, 10 Oct 2026 13:38:26 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v10 11/26] hw/arm/virt: Make sure virt_get_caches() keeps on
 reading CLIDR_EL1 as 0
Date: Sat, 10 Oct 2026 15:36:15 +0200
Message-ID: <20261010133725.642498-12-eric.auger@redhat.com>
In-Reply-To: <20261010133725.642498-1-eric.auger@redhat.com>
References: <20261010133725.642498-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

In KVM mode, virt_get_caches() currently gets a zero value for the
CLIDR_EL1 register. This is due to the fact CLIDR is never read from
host. This is a bug.

Soon we will initialize all writable isar.idreg[] from host and this
includes CLIDR_EL1. However we cannot directly fix the initialization,
first because it would change the way the guest is exposed caches in
DT/ACPI descriptions and because some host values would be rejected
by the current QEMU code, expecially in the case host has a unified
L1 cache which is currently not supported and triggers the following
errod: "Unified type is not implemented at level 1" error.

So this issue will be fixed separately.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Khushit Shah <khushit.shah@nutanix.com>

---

v9 -> v10
- add a comment explaining why we oveeride the clidr value
---
 hw/arm/virt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9d192515d8..f9a7beb584 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -338,6 +338,17 @@ unsigned int virt_get_caches(const VirtMachineState *vms, CPUCoreCaches *caches)
     ARMISARegisters *isar = &armcpu->isar;
     uint32_t clidr = GET_IDREG(isar, CLIDR);
 
+    /*
+     * Commit f669de70011 ("hw/arm/virt: add cache hierarchy to device tree")
+     * read the CLIDR value from the isar array but in KVM mode, this index
+     * was never initialized from host. Now we want to initialize all ID
+     * registers * from host and until this gets fixed, we need to override
+     * clidr to 0 to keep the compatibility.
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


