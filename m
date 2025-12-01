Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DF9D116F5
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 12:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ3NN-00007o-2j; Mon, 01 Dec 2025 07:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ3NL-0008TZ-DE
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:51:31 -0500
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 ([52.57.120.243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ3NJ-0003mj-NG
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
 t=1764593489; x=1796129489;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YiVSaceXokDxVjzqEE15bxJ9XS5trYPoQuYPiHb327Y=;
 b=GvogPZSwU08roz8hZ8dep2NjRboQJWfSoBL1GclkV6NG9qhluTAAhqSq
 ogstseLtoOdjica5yYNebTIpQP4vnNz0BxcVILipI7Y6YujV7FBVhMgGo
 91+vvWizMnWVrDqtGz5rZc9QQFst0FoUQ/RpsC2Pgf7b+y7RbpBA/kRYC
 JQARoBsWTP4dyuO3tTjNTeB36y+ymdI6JjGQvw6qBj6OKLKPF/HFoJN4R
 cjntP9YlNogEVwhUhSp50lmk1vc7f+6sYvMs6913pp/mWfOy+Mi2l1VZs
 DPHVKdkbARbGmnzWe4lOiLm+VKGlpUwPdBQaIzEeVCN48PNfxYVJRqUrD w==;
X-CSE-ConnectionGUID: TSrHaiA8R1aHhEPNuKGz6A==
X-CSE-MsgGUID: Cuuq4Ue8T5qMFyslP0SUFw==
X-IronPort-AV: E=Sophos;i="6.20,240,1758585600"; 
   d="scan'208";a="5958501"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO
 smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
 by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 12:51:11 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:14458]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.46.211:2525]
 with esmtp (Farcaster)
 id 468c4a21-0ed0-4b65-9332-218af19a7de7; Mon, 1 Dec 2025 12:51:11 +0000 (UTC)
X-Farcaster-Flow-ID: 468c4a21-0ed0-4b65-9332-218af19a7de7
Received: from EX19D012EUA003.ant.amazon.com (10.252.50.98) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 12:51:11 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA003.ant.amazon.com (10.252.50.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 12:51:10 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with
 mapi id 15.02.2562.029; Mon, 1 Dec 2025 12:51:10 +0000
From: "Chalios, Babis" <bchalios@amazon.es>
To: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "Chalios, Babis" <bchalios@amazon.es>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "mzxreary@0pointer.de" <mzxreary@0pointer.de>
Subject: [RFC PATCH 3/4] hw/acpi: add VM generation counter field to VMClock
Thread-Topic: [RFC PATCH 3/4] hw/acpi: add VM generation counter field to
 VMClock
Thread-Index: AQHcYsErx2HlZkNTNkCuXI6RHIRzQg==
Date: Mon, 1 Dec 2025 12:51:10 +0000
Message-ID: <20251201125023.18344-5-bchalios@amazon.es>
References: <20251201125023.18344-1-bchalios@amazon.es>
In-Reply-To: <20251201125023.18344-1-bchalios@amazon.es>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.247.161]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=52.57.120.243;
 envelope-from=prvs=423f6341f=bchalios@amazon.es;
 helo=fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

The final published version of the VMClock specification adds support=0A=
for an extra vm_generation_counter field which allows hypervisors to=0A=
differentiate between live migration and snapshot loading events. During=0A=
the latter, apart from adjusting clocks, guests might want to take=0A=
further actions such as resetting network devices, updating UUIDs,=0A=
reseeding entropy pools, etc.=0A=
=0A=
VM generation counter itself is stored in the guest memory region and=0A=
exposed to guest userspace, so we don't need to serialize it within=0A=
vmstate_vmclock as well.=0A=
=0A=
Signed-off-by: Babis Chalios <bchalios@amazon.es>=0A=
---=0A=
 hw/acpi/vmclock.c | 13 +++++++++++++=0A=
 1 file changed, 13 insertions(+)=0A=
=0A=
diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c=0A=
index c582c0c1f8..47cbba4496 100644=0A=
--- a/hw/acpi/vmclock.c=0A=
+++ b/hw/acpi/vmclock.c=0A=
@@ -20,6 +20,7 @@=0A=
 #include "hw/qdev-properties.h"=0A=
 #include "hw/qdev-properties-system.h"=0A=
 #include "migration/vmstate.h"=0A=
+#include "migration/misc.h"=0A=
 #include "system/reset.h"=0A=
 =0A=
 #include "standard-headers/linux/vmclock-abi.h"=0A=
@@ -64,6 +65,7 @@ void vmclock_build_acpi(VmclockState *vms, GArray *table_=
data,=0A=
 static void vmclock_update_guest(VmclockState *vms)=0A=
 {=0A=
     uint64_t disruption_marker;=0A=
+    uint64_t vm_generation_counter;=0A=
     uint32_t seq_count;=0A=
 =0A=
     if (!vms->clk) {=0A=
@@ -79,6 +81,16 @@ static void vmclock_update_guest(VmclockState *vms)=0A=
     disruption_marker++;=0A=
     vms->clk->disruption_marker =3D cpu_to_le64(disruption_marker);=0A=
 =0A=
+    /*=0A=
+     * We only increase the vm_generation_counter when loading from a snap=
shot,=0A=
+     * not during live migration=0A=
+     */=0A=
+    if (!migration_is_running()) {=0A=
+        vm_generation_counter =3D le64_to_cpu(vms->clk->vm_generation_coun=
ter);=0A=
+        vm_generation_counter++;=0A=
+        vms->clk->vm_generation_counter =3D cpu_to_le64(vm_generation_coun=
ter);=0A=
+    }=0A=
+=0A=
     /* These barriers pair with read barriers in the guest */=0A=
     smp_wmb();=0A=
     vms->clk->seq_count =3D cpu_to_le32(seq_count + 1);=0A=
@@ -144,6 +156,7 @@ static void vmclock_realize(DeviceState *dev, Error **e=
rrp)=0A=
     vms->clk->magic =3D cpu_to_le32(VMCLOCK_MAGIC);=0A=
     vms->clk->size =3D cpu_to_le16(VMCLOCK_SIZE);=0A=
     vms->clk->version =3D cpu_to_le16(1);=0A=
+    vms->clk->flags =3D cpu_to_le64(VMCLOCK_FLAG_VM_GEN_COUNTER_PRESENT);=
=0A=
 =0A=
     /* These are all zero and thus default, but be explicit */=0A=
     vms->clk->clock_status =3D VMCLOCK_STATUS_UNKNOWN;=0A=
-- =0A=
2.34.1=0A=
=0A=

