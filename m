Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ACFCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut0EJ-0002oH-On; Mon, 01 Sep 2025 04:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut0EF-0002jZ-Br
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 04:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut0ED-0000xY-43
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 04:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756716565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4JE3VOkiV62MK+0IJ2Z6XJp4shx48oTJqqqImyPhww8=;
 b=RYVgcKdlW23cMT6eBilKXbZQr0Vz9joU+aRY5mKJbvPd4fPudjbrO1sN6micHwe0yIShgT
 uRN3yWVqDnx59rVFfx9xg4fgwci+OLMkqBwFGCAdOoKJwS1apQVtXqWmFKphhm1TcPkAFj
 Vfwh//emCFSSrm73uY1NGzCUNdOSfRQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-l6KBsbzGMG6l9KkSsssDtg-1; Mon,
 01 Sep 2025 04:49:22 -0400
X-MC-Unique: l6KBsbzGMG6l9KkSsssDtg-1
X-Mimecast-MFC-AGG-ID: l6KBsbzGMG6l9KkSsssDtg_1756716561
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E60618002BA; Mon,  1 Sep 2025 08:49:21 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5CA571955EA5; Mon,  1 Sep 2025 08:49:17 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, mst@redhat.com, pbonzini@redhat.com,
 qemu-arm@nongnu.org
Subject: [PATCH] smbios: cap DIMM size to 2Tb as workaround for broken Windows
Date: Mon,  1 Sep 2025 10:49:15 +0200
Message-ID: <20250901084915.2607632-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

With current limit set to match max spec size (2PTb),
Windows fails to parse type 17 records when DIMM size reaches 4Tb+.
Failure happens in GetPhysicallyInstalledSystemMemory() function,
and fails "Check SMBIOS System Memory Tables" SVVP test.
Though not fatal, it might cause issues for userspace apps,
something like [1].

Lets cap default DIMM size to 2Tb for now, until MS fixes it.

1) https://issues.redhat.com/browse/RHEL-81999?focusedId=27731200&page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel#comment-27731200

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
PS: It's obvious 32 int overflow math somewhere in Windows,
    MS admitted that it's Windows bug and in a process of fixing it.
    However it's unclear if W10 and earlier would get the fix.
    So however I dislike changing defaults, we heed to work around
    the issue (it looks like QEMU regression while not being it).
    Hopefully 2Tb/DIMM split will last longer until VM memory size
    will become large enough to cause to many type 17 records issue
    again.
PS2:
    Alternatively, instead of messing with defaults, I can create
    a dedicated knob to ask for desired DIMM size cap explicitly
    on CLI. That will let users to enable workaround when they
    hit this corner case. Downside is that knob has to be propagated
    up all mgmt stack, which might be not desirable.
---
 hw/arm/virt.c     | 1 +
 hw/core/machine.c | 5 ++++-
 hw/i386/pc_piix.c | 1 +
 hw/i386/pc_q35.c  | 1 +
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 9326cfc895..4100c4ff1e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3463,6 +3463,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
 static void virt_machine_10_1_options(MachineClass *mc)
 {
     virt_machine_10_2_options(mc);
+    mc->smbios_memory_device_size = 2047 * TiB;
     compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
 }
 DEFINE_VIRT_MACHINE(10, 1)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 38c949c4f2..ac00e72127 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1115,8 +1115,11 @@ static void machine_class_init(ObjectClass *oc, const void *data)
      * SMBIOS 3.1.0 7.18.5 Memory Device — Extended Size
      * use max possible value that could be encoded into
      * 'Extended Size' field (2047Tb).
+     *
+     * Unfortunately (current) Windows Server 2025 and earlier do not handle
+     * 4Tb+ DIMM size.
      */
-    mc->smbios_memory_device_size = 2047 * TiB;
+    mc->smbios_memory_device_size = 2 * TiB;
 
     /* numa node memory size aligned on 8MB by default.
      * On Linux, each node's border has to be 8MB aligned
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d165ac72ed..eafa081825 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -514,6 +514,7 @@ DEFINE_I440FX_MACHINE_AS_LATEST(10, 2);
 static void pc_i440fx_machine_10_1_options(MachineClass *m)
 {
     pc_i440fx_machine_10_2_options(m);
+    m->smbios_memory_device_size = 2047 * TiB;
     compat_props_add(m->compat_props, hw_compat_10_1, hw_compat_10_1_len);
     compat_props_add(m->compat_props, pc_compat_10_1, pc_compat_10_1_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index e89951285e..6015e639d7 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -384,6 +384,7 @@ DEFINE_Q35_MACHINE_AS_LATEST(10, 2);
 static void pc_q35_machine_10_1_options(MachineClass *m)
 {
     pc_q35_machine_10_2_options(m);
+    m->smbios_memory_device_size = 2047 * TiB;
     compat_props_add(m->compat_props, hw_compat_10_1, hw_compat_10_1_len);
     compat_props_add(m->compat_props, pc_compat_10_1, pc_compat_10_1_len);
 }
-- 
2.47.1


