Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB1BCFD65B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 16:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdW9o-0006Za-QA; Wed, 07 Jan 2026 11:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdW9i-0006Ih-9D
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 11:13:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdW9f-0005Jm-Rc
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 11:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767802382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zvIbc5z9SdQCq83Vk1qBemPaH1jqlBkNFDuqrNgs054=;
 b=JDP3ouK5/0THLAm/rHakcM0mY4PabYvq/lByU2JbAogqB53l1DIquqg0vF+eibxo25pkHB
 kOBJ894v00QeKOVxp/tg8IkV3pa7x4IWzkYjQaVk57kvPuxhGMKSiHHJ/22Vgx43Pg5p+w
 8aQF6X94+CxRFunk79z5wMCMEa4vaNA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-wDha-cjqPiibQqCKnMsnAA-1; Wed,
 07 Jan 2026 11:13:00 -0500
X-MC-Unique: wDha-cjqPiibQqCKnMsnAA-1
X-Mimecast-MFC-AGG-ID: wDha-cjqPiibQqCKnMsnAA_1767802379
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B731E19560A7; Wed,  7 Jan 2026 16:12:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DABE19560A2; Wed,  7 Jan 2026 16:12:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 13EFE21E61A9; Wed, 07 Jan 2026 17:12:57 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Thomas Huth <thuth@redhat.com>
Subject: [PULL 3/4] scripts/device-crash-test: ERROR_RULE_LIST garbage
 collection
Date: Wed,  7 Jan 2026 17:12:55 +0100
Message-ID: <20260107161256.1321694-4-armbru@redhat.com>
In-Reply-To: <20260107161256.1321694-1-armbru@redhat.com>
References: <20260107161256.1321694-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Device 'nand' was dropped in commit commit e86c1f967a3.

Device 'vfio-amd-xgbe' was dropped in commit aeb1a50d4a7.

Device 'vfio-calxeda-xgmac' was dropped in commit 8ebc416ac17.

The last error messages matching r"images* must be given with the
'pflash' parameter" was dropped in commit a2ccff4d2bc.

The error message matching r"Option '-device [\w.,-]+' cannot be
handled by this machine" was dropped in commit commit db78a605599.

The error message matching r"Ignoring smp_cpus value" ceased to match
in commit f2ad5140fa5, and was then dropped in commit 72649619341.

The error message matching r"rom check and register reset failed" was
lost in merge commit af3f37319cb.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20251128101321.3287186-1-armbru@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 scripts/device-crash-test | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index c1576e8b96..f97d9909c0 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -93,7 +93,6 @@ ERROR_RULE_LIST = [
     {'device':'ivshmem-doorbell', 'expected':True},        # You must specify a 'chardev'
     {'device':'ivshmem-plain', 'expected':True},           # You must specify a 'memdev'
     {'device':'loader', 'expected':True},                  # please include valid arguments
-    {'device':'nand', 'expected':True},                    # Unsupported NAND block size 0x1
     {'device':'nvdimm', 'expected':True},                  # 'memdev' property is not set
     {'device':'nvme', 'expected':True},                    # Device initialization failed
     {'device':'pc-dimm', 'expected':True},                 # 'memdev' property is not set
@@ -114,8 +113,6 @@ ERROR_RULE_LIST = [
     {'device':'usb-redir', 'expected':True},               # Parameter 'chardev' is missing
     {'device':'usb-serial', 'expected':True},              # Property chardev is required
     {'device':'usb-storage', 'expected':True},             # drive property not set
-    {'device':'vfio-amd-xgbe', 'expected':True},           # -device vfio-amd-xgbe: vfio error: wrong host device name
-    {'device':'vfio-calxeda-xgmac', 'expected':True},      # -device vfio-calxeda-xgmac: vfio error: wrong host device name
     {'device':'vfio-pci', 'expected':True},                # No provided host device
     {'device':'vfio-pci-igd-lpc-bridge', 'expected':True}, # VFIO dummy ISA/LPC bridge must have address 1f.0
     {'device':'vhost-scsi.*', 'expected':True},            # vhost-scsi: missing wwpn
@@ -159,7 +156,6 @@ ERROR_RULE_LIST = [
     # Silence INFO messages for errors that are common on multiple
     # devices/machines:
     {'log':r"No '[\w-]+' bus found for device '[\w-]+'"},
-    {'log':r"images* must be given with the 'pflash' parameter"},
     {'log':r"(Guest|ROM|Flash|Kernel) image must be specified"},
     {'log':r"[cC]ould not load [\w ]+ (BIOS|bios) '[\w-]+\.bin'"},
     {'log':r"Couldn't find rom image '[\w-]+\.bin'"},
@@ -167,7 +163,6 @@ ERROR_RULE_LIST = [
     {'log':r"Can't create a second ISA bus"},
     {'log':r"duplicate fw_cfg file name"},
     # sysbus-related error messages: most machines reject most dynamic sysbus devices:
-    {'log':r"Option '-device [\w.,-]+' cannot be handled by this machine"},
     {'log':r"Device [\w.,-]+ is not supported by this machine yet"},
     {'log':r"Device [\w.,-]+ can not be dynamically instantiated"},
     {'log':r"Platform Bus: Can not fit MMIO region of size "},
@@ -175,11 +170,9 @@ ERROR_RULE_LIST = [
     {'device':'.*-spapr-cpu-core', 'log':r"CPU core type should be"},
     {'log':r"MSI(-X)? is not supported by interrupt controller"},
     {'log':r"pxb-pcie? devices cannot reside on a PCIe? bus"},
-    {'log':r"Ignoring smp_cpus value"},
     {'log':r"sd_init failed: Drive 'sd0' is already in use because it has been automatically connected to another device"},
     {'log':r"This CPU requires a smaller page size than the system is using"},
     {'log':r"MSI-X support is mandatory in the S390 architecture"},
-    {'log':r"rom check and register reset failed"},
     {'log':r"Unable to initialize GIC, CPUState for CPU#0 not valid"},
     {'log':r"Multiple VT220 operator consoles are not supported"},
     {'log':r"core 0 already populated"},
-- 
2.52.0


