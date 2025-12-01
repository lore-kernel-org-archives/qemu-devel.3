Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05BCD116F5
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 12:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ3NA-00083J-1M; Mon, 01 Dec 2025 07:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ3My-00080J-6q
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:51:09 -0500
Received: from fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 ([63.176.194.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=423f6341f=bchalios@amazon.es>)
 id 1vQ3Mw-0003kX-Cq
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:51:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
 t=1764593466; x=1796129466;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Af3wAy5m9T1pyoUgQy/nPKuc+zbTcDofO927bNzlVoI=;
 b=G9c/eAX+qKwr19Oa+WfBiI3BCAQrk73xzxKhd7WsNL4w3zP0ID1Uk2hi
 N3S9tJnRtsgGuBD5TyHsyCds3XNxKWsR3GdX7b8cpdTGKWdmhYZyLoDVZ
 i0HJkTobYpTLxIpICp80kjp9ZOV0ysCiVOB1W300e3uSUgvn6/opS2IDv
 UEe7EvRAhDLWGwQ72AK0m0EWEaDIrs2wlwaYGambqiVU2nbquBDpuP1zY
 ep+Ual2j7hO+hcwAkn/GMzpIOOmlf4dV23c2glUtJEUnymUuo4ISL0jvm
 ghoQVOgPHSYhXLrEJN25mxY7WnGgBIAH9euO9GotG3Nh35m0vjbt2kPKy Q==;
X-CSE-ConnectionGUID: 4oNWy7yeQL+EihnGrv1S0Q==
X-CSE-MsgGUID: vVHcoRUzTEen1V0+f2jh0g==
X-IronPort-AV: E=Sophos;i="6.20,240,1758585600"; 
   d="scan'208";a="6058410"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO
 smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
 by internal-fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 12:50:48 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:13112]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.31.35:2525]
 with esmtp (Farcaster)
 id 992c0900-3165-4cce-aa02-746190535d2e; Mon, 1 Dec 2025 12:50:48 +0000 (UTC)
X-Farcaster-Flow-ID: 992c0900-3165-4cce-aa02-746190535d2e
Received: from EX19D012EUA003.ant.amazon.com (10.252.50.98) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 12:50:48 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA003.ant.amazon.com (10.252.50.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Mon, 1 Dec 2025 12:50:48 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with
 mapi id 15.02.2562.029; Mon, 1 Dec 2025 12:50:48 +0000
From: "Chalios, Babis" <bchalios@amazon.es>
To: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "Chalios, Babis" <bchalios@amazon.es>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "mzxreary@0pointer.de" <mzxreary@0pointer.de>
Subject: [RFC PATCH 1/4] acpi: fix acpi_send_gpe_event() to handle more events
Thread-Topic: [RFC PATCH 1/4] acpi: fix acpi_send_gpe_event() to handle more
 events
Thread-Index: AQHcYsEdcQTQFFpCvkGEL1mIzIcFZA==
Date: Mon, 1 Dec 2025 12:50:47 +0000
Message-ID: <20251201125023.18344-3-bchalios@amazon.es>
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
Received-SPF: pass client-ip=63.176.194.123;
 envelope-from=prvs=423f6341f=bchalios@amazon.es;
 helo=fra-out-005.esa.eu-central-1.outbound.mail-perimeter.amazon.com
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

acpi_send_gpe_events() sends events encoded in the AcpiEventStatusBits=0A=
enum. The maximum bit used so far in the latter was 128, hence a single=0A=
byte (ACPIGPE.sts[0]) is currently enough to hold the set bits.=0A=
=0A=
When we add an extra one, we will need a second byte to encode the state=0A=
and casting from AcpiEventStatusBits to uint8_t will silently ignore the=0A=
higher bits.=0A=
=0A=
Fix this, by taking into account the length value inside ACPIGPE.=0A=
=0A=
Signed-off-by: Babis Chalios <bchalios@amazon.es>=0A=
---=0A=
 hw/acpi/core.c | 8 +++++++-=0A=
 1 file changed, 7 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/acpi/core.c b/hw/acpi/core.c=0A=
index ff16582803..48694eca54 100644=0A=
--- a/hw/acpi/core.c=0A=
+++ b/hw/acpi/core.c=0A=
@@ -730,7 +730,13 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t =
addr)=0A=
 void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,=0A=
                          AcpiEventStatusBits status)=0A=
 {=0A=
-    ar->gpe.sts[0] |=3D status;=0A=
+    int i;=0A=
+=0A=
+    for (i =3D 0; i < ar->gpe.len; i++) {=0A=
+        ar->gpe.sts[i] |=3D (status & 0xff);=0A=
+        status >>=3D 8;=0A=
+    }=0A=
+=0A=
     acpi_update_sci(ar, irq);=0A=
 }=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

