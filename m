Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7606D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 12:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viAkJ-0005jJ-Sl; Tue, 20 Jan 2026 07:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viAje-0005Ls-FC
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 07:21:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viAjb-0008F8-Lx
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 07:21:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768911682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ShMc2XHbUAPIbnNN5HY4lv4NPM3nDKydBPkK/9xe5Zg=;
 b=UW/574At3lZU/o4QyW+ayzC6kWX28fvGWTSYGQAbAreDJR2FOBHK+Rt0Qbys6EcCC66S2E
 5wi/CcjfNu2/b5lDzOT19Fo3DBlbiZ583XnvikLqwQ2m+4WFDHEP9xiEBLgdbkdcfqYUWf
 k5GuH9INUsSJ2oK7hXFLBNFJxp4JKVI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-zrtLTfGNPN-r8amCIVfXZg-1; Tue,
 20 Jan 2026 07:21:16 -0500
X-MC-Unique: zrtLTfGNPN-r8amCIVfXZg-1
X-Mimecast-MFC-AGG-ID: zrtLTfGNPN-r8amCIVfXZg_1768911675
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF10F18005A7; Tue, 20 Jan 2026 12:21:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.226.98])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D8A1B30001A2; Tue, 20 Jan 2026 12:21:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH] hw/arm: Move the "arm-cpu" compat settings out of
 hw/core/machine.c
Date: Tue, 20 Jan 2026 13:21:08 +0100
Message-ID: <20260120122108.131708-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The hw_compat_* arrays in hw/core/machine.c should be used for generic
compat settings that might affect all (or at least multiple) machines.
Target specific settings should rather go into the target specific
source files instead. For arm/aarch64, the virt machine is the only
one that cares about compat settings, so move the "arm-cpu" related
switches to hw/arm/virt.c now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/virt.c     | 10 ++++++++++
 hw/core/machine.c |  2 --
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 4badc1a7348..99040e08f6a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3571,8 +3571,13 @@ DEFINE_VIRT_MACHINE(10, 0)
 
 static void virt_machine_9_2_options(MachineClass *mc)
 {
+    static GlobalProperty compat_9_2[] = {
+        { "arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
+    };
+
     virt_machine_10_0_options(mc);
     compat_props_add(mc->compat_props, hw_compat_9_2, hw_compat_9_2_len);
+    compat_props_add(mc->compat_props, compat_9_2, G_N_ELEMENTS(compat_9_2));
 }
 DEFINE_VIRT_MACHINE(9, 2)
 
@@ -3589,9 +3594,14 @@ DEFINE_VIRT_MACHINE(9, 1)
 
 static void virt_machine_9_0_options(MachineClass *mc)
 {
+    static GlobalProperty compat_9_0[] = {
+        { "arm-cpu", "backcompat-cntfrq", "true" },
+    };
+
     virt_machine_9_1_options(mc);
     mc->smbios_memory_device_size = 16 * GiB;
     compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
+    compat_props_add(mc->compat_props, compat_9_0, G_N_ELEMENTS(compat_9_0));
 }
 DEFINE_VIRT_MACHINE(9, 0)
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6411e68856b..1c1de7b5d18 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -59,7 +59,6 @@ GlobalProperty hw_compat_10_0[] = {
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
 GlobalProperty hw_compat_9_2[] = {
-    { "arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
     { "virtio-balloon-pci", "vectors", "0" },
     { "virtio-balloon-pci-transitional", "vectors", "0" },
     { "virtio-balloon-pci-non-transitional", "vectors", "0" },
@@ -76,7 +75,6 @@ GlobalProperty hw_compat_9_1[] = {
 const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
 
 GlobalProperty hw_compat_9_0[] = {
-    { "arm-cpu", "backcompat-cntfrq", "true" },
     { "scsi-hd", "migrate-emulated-scsi-request", "false" },
     { "scsi-cd", "migrate-emulated-scsi-request", "false" },
     { "vfio-pci", "skip-vsc-check", "false" },
-- 
2.52.0


