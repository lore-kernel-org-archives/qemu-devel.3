Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC34D116F9
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 12:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ3NJ-0008Lf-My; Mon, 01 Dec 2025 07:51:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ3NB-00087e-Fy
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:51:21 -0500
Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 ([3.65.3.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ3N9-0003m1-An
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
 t=1764593479; x=1796129479;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SyOmMtS87Fj8wOKMxxjUIwG7mOYmsl1VXssurPgDu6o=;
 b=NhiElWyS0ZsIdoBegOiyinGHZ4Lg+lFneYUM8CZ0JcY2cwt4hO57M2CH
 dZXhtEyvmkx4563ucLwEHuy3ZuUOkFPTRMU7snkAhLa7pBUzpqd2ippKU
 IEWl0ah2uuSdh4V30u6SKPMh+69+V7HXsXYPTQuJvL7zubJQNp6yoMok7
 2BNmbdQVkuhI3Rb19czNCSc9kvwiyVVsyeJRe03z9WFYevfx3o5H8dq0p
 mHeFUCWbsIRFWg/BmXuJmnAq9RiipDad9zsVfQ0pEVElRkygSUl8Is56f
 eNQSAQZXu6GoyT6it7LfpRENAXZaTp/8r4ZdKkZ5OhPXz4sDe7yvJhUv/ g==;
X-CSE-ConnectionGUID: VJzJewh6SlSE/a0w49zGfg==
X-CSE-MsgGUID: 8DsAb2RIT/SOX5uuJG6oOg==
X-IronPort-AV: E=Sophos;i="6.20,240,1758585600"; 
   d="scan'208";a="6055140"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO
 smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
 by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 12:51:00 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:21883]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.10.60:2525]
 with esmtp (Farcaster)
 id 75a89876-aa07-4770-b9ca-f223213e8cc6; Mon, 1 Dec 2025 12:51:00 +0000 (UTC)
X-Farcaster-Flow-ID: 75a89876-aa07-4770-b9ca-f223213e8cc6
Received: from EX19D012EUA002.ant.amazon.com (10.252.50.32) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 12:50:59 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA002.ant.amazon.com (10.252.50.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 12:50:59 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with
 mapi id 15.02.2562.029; Mon, 1 Dec 2025 12:50:59 +0000
From: "Chalios, Babis" <bchalios@amazon.es>
To: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "Chalios, Babis" <bchalios@amazon.es>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "mzxreary@0pointer.de" <mzxreary@0pointer.de>
Subject: [RFC PATCH 2/4] hw/acpi: add new fields in VMClock ABI
Thread-Topic: [RFC PATCH 2/4] hw/acpi: add new fields in VMClock ABI
Thread-Index: AQHcYsEkuCIYhcNvIUSZItyTw04tHA==
Date: Mon, 1 Dec 2025 12:50:59 +0000
Message-ID: <20251201125023.18344-4-bchalios@amazon.es>
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
Received-SPF: pass client-ip=3.65.3.180;
 envelope-from=prvs=423f6341f=bchalios@amazon.es;
 helo=fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com
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

VMClock now supports a vm_generation_counter field in the struct it=0A=
exposes to userspace. The field signals a disruption that happened due=0A=
to a guest loaded from a snapshot.=0A=
=0A=
Moreover, VMClock now optionally supports device notifications when the=0A=
seq_count changes to a new even value.=0A=
=0A=
Signed-off-by: Babis Chalios <bchalios@amazon.es>=0A=
---=0A=
 include/standard-headers/linux/vmclock-abi.h | 20 ++++++++++++++++++++=0A=
 1 file changed, 20 insertions(+)=0A=
=0A=
diff --git a/include/standard-headers/linux/vmclock-abi.h b/include/standar=
d-headers/linux/vmclock-abi.h=0A=
index 15b0316cb4..fe824badc0 100644=0A=
--- a/include/standard-headers/linux/vmclock-abi.h=0A=
+++ b/include/standard-headers/linux/vmclock-abi.h=0A=
@@ -115,6 +115,17 @@ struct vmclock_abi {=0A=
 	 * bit again after the update, using the about-to-be-valid fields.=0A=
 	 */=0A=
 #define VMCLOCK_FLAG_TIME_MONOTONIC		(1 << 7)=0A=
+	/*=0A=
+	 * If the VM_GEN_COUNTER_PRESENT flag is set, the hypervisor will=0A=
+	 * bump the vm_generation_counter field every time the guest is=0A=
+	 * loaded from some save state (restored from a snapshot).=0A=
+	 */=0A=
+#define VMCLOCK_FLAG_VM_GEN_COUNTER_PRESENT     (1 << 8)=0A=
+	/*=0A=
+	 * If the NOTIFICATION_PRESENT flag is set, the hypervisor will send=0A=
+	 * a notification every time it updates seq_count to a new even number.=
=0A=
+	 */=0A=
+#define VMCLOCK_FLAG_NOTIFICATION_PRESENT       (1 << 9)=0A=
 =0A=
 	uint8_t pad[2];=0A=
 	uint8_t clock_status;=0A=
@@ -177,6 +188,15 @@ struct vmclock_abi {=0A=
 	uint64_t time_frac_sec;		/* Units of 1/2^64 of a second */=0A=
 	uint64_t time_esterror_nanosec;=0A=
 	uint64_t time_maxerror_nanosec;=0A=
+=0A=
+	/*=0A=
+	 * This field changes to another non-repeating value when the guest=0A=
+	 * has been loaded from a snapshot. In addition to handling a=0A=
+	 * disruption in time (which will also be signalled through the=0A=
+	 * disruption_marker field), a guest may wish to discard UUIDs,=0A=
+	 * reset network connections, reseed entropy, etc.=0A=
+	 */=0A=
+	uint64_t vm_generation_counter;=0A=
 };=0A=
 =0A=
 #endif /*  __VMCLOCK_ABI_H__ */=0A=
-- =0A=
2.34.1=0A=
=0A=

