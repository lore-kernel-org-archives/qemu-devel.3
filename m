Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7835AD116F9
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 12:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ3O5-0001UR-0C; Mon, 01 Dec 2025 07:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ3Ne-0000qY-AS
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:51:54 -0500
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 ([35.158.23.94])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ3Nc-0003nJ-Gi
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:51:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
 t=1764593508; x=1796129508;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Df5wsz2RSElfKfhsADXDWgX0ZlC5dNW9+WhnQcsb5BQ=;
 b=GB86SNmR8RQqwDPOKU1ul9RVlDRkHMspNG9X840V3wpbK89l2AfPAI1p
 NGEqqBPvU9inK/JdmcDJ2EQmttbDa9cq2/bI58Jq97jYjP1MHH94c5l6J
 e72uHmdKhfNwS3B163otBWz5l6gJjNNCib9PIQFVGr+ZDgwAReSW/G8DX
 XkJ0JLXqdG70OMdfEan4Iwk324uG58cXuniiDD0tNxz2PYlnlScqG145n
 p/SYVkmiOogGhatDvpePVUm2/mOUkrjy0v0z3BipfUuUS6FQlyRcBH6VV
 k0OGvcwwqH6UDCOiKMjb/Jz1vzlpF4rdjifqMX7ttlyERZum3aRQc2Lpc g==;
X-CSE-ConnectionGUID: tpHgzo5KTFqzVkK9PSz/Cg==
X-CSE-MsgGUID: X6iMoA3CTTaH8Uiuv1e6Ug==
X-IronPort-AV: E=Sophos;i="6.20,240,1758585600"; 
   d="scan'208";a="6056174"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO
 smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
 by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 12:51:22 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:26348]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.21.117:2525]
 with esmtp (Farcaster)
 id 85614544-48d7-4f29-9356-489bd89025a3; Mon, 1 Dec 2025 12:51:22 +0000 (UTC)
X-Farcaster-Flow-ID: 85614544-48d7-4f29-9356-489bd89025a3
Received: from EX19D012EUA002.ant.amazon.com (10.252.50.32) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 12:51:22 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA002.ant.amazon.com (10.252.50.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 12:51:22 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with
 mapi id 15.02.2562.029; Mon, 1 Dec 2025 12:51:22 +0000
From: "Chalios, Babis" <bchalios@amazon.es>
To: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "Chalios, Babis" <bchalios@amazon.es>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "mzxreary@0pointer.de" <mzxreary@0pointer.de>
Subject: [RFC PATCH 4/4] hw/acpi: add ACPI notification to VMClock device
Thread-Topic: [RFC PATCH 4/4] hw/acpi: add ACPI notification to VMClock device
Thread-Index: AQHcYsExYoIYzSGQdke7VH92GRB+vg==
Date: Mon, 1 Dec 2025 12:51:22 +0000
Message-ID: <20251201125023.18344-6-bchalios@amazon.es>
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
Received-SPF: pass client-ip=35.158.23.94;
 envelope-from=prvs=423f6341f=bchalios@amazon.es;
 helo=fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com
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

Extend VMClock device to send an ACPI notification every time the=0A=
seqcount changes to a new even value. Use GPE E08 event, which now=0A=
becomes part of the guest ABI.=0A=
=0A=
Signed-off-by: Babis Chalios <bchalios@amazon.es>=0A=
---=0A=
 hw/acpi/vmclock.c                    | 17 +++++++++++++++--=0A=
 include/hw/acpi/acpi_dev_interface.h |  1 +=0A=
 2 files changed, 16 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c=0A=
index 47cbba4496..f6f242cb66 100644=0A=
--- a/hw/acpi/vmclock.c=0A=
+++ b/hw/acpi/vmclock.c=0A=
@@ -28,7 +28,7 @@=0A=
 void vmclock_build_acpi(VmclockState *vms, GArray *table_data,=0A=
                         BIOSLinker *linker, const char *oem_id)=0A=
 {=0A=
-    Aml *ssdt, *dev, *scope, *crs;=0A=
+    Aml *ssdt, *dev, *scope, *crs, *method;=0A=
     AcpiTable table =3D { .sig =3D "SSDT", .rev =3D 1,=0A=
                         .oem_id =3D oem_id, .oem_table_id =3D "VMCLOCK" };=
=0A=
 =0A=
@@ -57,6 +57,11 @@ void vmclock_build_acpi(VmclockState *vms, GArray *table=
_data,=0A=
     aml_append(scope, dev);=0A=
     aml_append(ssdt, scope);=0A=
 =0A=
+    /* Attach an ACPI notify */=0A=
+    method =3D aml_method("\\_GPE._E08", 0, AML_NOTSERIALIZED);=0A=
+    aml_append(method, aml_notify(aml_name("\\_SB.VCLK"), aml_int(0x80)));=
=0A=
+    aml_append(ssdt, method);=0A=
+=0A=
     g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);=0A=
     acpi_table_end(linker, &table);=0A=
     free_aml_allocator();=0A=
@@ -67,6 +72,10 @@ static void vmclock_update_guest(VmclockState *vms)=0A=
     uint64_t disruption_marker;=0A=
     uint64_t vm_generation_counter;=0A=
     uint32_t seq_count;=0A=
+    Object *obj =3D object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL=
);=0A=
+    if (!obj) {=0A=
+        return;=0A=
+    }=0A=
 =0A=
     if (!vms->clk) {=0A=
         return;=0A=
@@ -94,6 +103,9 @@ static void vmclock_update_guest(VmclockState *vms)=0A=
     /* These barriers pair with read barriers in the guest */=0A=
     smp_wmb();=0A=
     vms->clk->seq_count =3D cpu_to_le32(seq_count + 1);=0A=
+=0A=
+    /* Send _GPE.E08 event */=0A=
+    acpi_send_event(DEVICE(obj), ACPI_VMCLOCK_CHANGE_STATUS);=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -156,7 +168,8 @@ static void vmclock_realize(DeviceState *dev, Error **e=
rrp)=0A=
     vms->clk->magic =3D cpu_to_le32(VMCLOCK_MAGIC);=0A=
     vms->clk->size =3D cpu_to_le16(VMCLOCK_SIZE);=0A=
     vms->clk->version =3D cpu_to_le16(1);=0A=
-    vms->clk->flags =3D cpu_to_le64(VMCLOCK_FLAG_VM_GEN_COUNTER_PRESENT);=
=0A=
+    vms->clk->flags =3D cpu_to_le64(VMCLOCK_FLAG_VM_GEN_COUNTER_PRESENT |=
=0A=
+                                  VMCLOCK_FLAG_NOTIFICATION_PRESENT);=0A=
 =0A=
     /* These are all zero and thus default, but be explicit */=0A=
     vms->clk->clock_status =3D VMCLOCK_STATUS_UNKNOWN;=0A=
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_de=
v_interface.h=0A=
index 8294f8f0cc..f51f6065f9 100644=0A=
--- a/include/hw/acpi/acpi_dev_interface.h=0A=
+++ b/include/hw/acpi/acpi_dev_interface.h=0A=
@@ -14,6 +14,7 @@ typedef enum {=0A=
     ACPI_VMGENID_CHANGE_STATUS =3D 32,=0A=
     ACPI_POWER_DOWN_STATUS =3D 64,=0A=
     ACPI_GENERIC_ERROR =3D 128,=0A=
+    ACPI_VMCLOCK_CHANGE_STATUS =3D 256,=0A=
 } AcpiEventStatusBits;=0A=
 =0A=
 #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"=0A=
-- =0A=
2.34.1=0A=
=0A=

