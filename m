Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5642ECA1006
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1n6-0003zJ-5U; Mon, 01 Sep 2025 06:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1n2-0003wr-8g; Mon, 01 Sep 2025 06:29:33 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1n0-0005M5-Ft; Mon, 01 Sep 2025 06:29:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRi8fg3fIzebe2Iu7o0K8rywm1knDBhi9YwGW9+hMsi/oyErhSiFAB64OIbcFWrvc3V5PTX4cNNNw/uiZD2SE0XRGpr/hfC80xlL6CjfocauAt1wBcgnQva+uTm9xSa8UlAkE2R62ISm6bvl2RlWZ5BSXBf8tQ3U01wN5S1JhRl+KfKYedbizXWLDvvJxoh3KYqYaYthIZ8eha5L7MZ4epBk7DxkY1j2MLtIo0AsFJ5C/kptzOQ0S71F9jKPSckScSFakM9FfbZhR7niUp6zWrzO6OqjlMiWeXx9y2/IXXS2L/ud8X3zqYZYgsIpLYN1SmanCgr7qgEyE5U9IE+3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3/MMDlZmON35bnlXTOVwcVZr7OS9rg77npq3crIStE=;
 b=hguiwCA7Shf978j9It9vZnVbOp6MVgIDl7hqclZ5GPsw+t8Xlo3B3bKTrLnyvparn+vPYWxVf3MT2noeGcfSoHQaJUqvdf3/GbvzVhw3re64ak2udnAoB0XywJnCHO3O7ey+hniMFA+jGgkKq7zfctpC9iu4788HliUX9NnHweKBFTDnzKE2sSV8tBVDmDCXDWxXppLOJLBSWK4lqAs4OCcpL5iR2kHQU0Dxn85DZJOYiU7zG/NVNZCu9oh9htMU7db4RldYwkG+36Lywv/JdLe/GjYBe0r8iDM+71Uing7F3vu3QbpN8P5NE6AZuMIfdwL2x1gbp8Q9VZuJ2OXTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3/MMDlZmON35bnlXTOVwcVZr7OS9rg77npq3crIStE=;
 b=EXyK4WLfNFuJplvSu9Qv3y6/kZgoYi9LkwGm1WJxtgjLul2OMRzaTWdUS6jW4Ko8sKBtl1kvzwlpcxdE/3g6YKHnCJ8/oubJDYCpVr46WTN880q81WY9CROARGiNWtWZ6n5Cuofvvm04l97oNO0G6/tVBUmzd7P9k7r/044mbAQMXMtmBTS59HMGbOY9ip+roShZXHVAnpYGElWUpBI0UNQHVrUdaxAWNZsxBmj8vWPjnVsunms135mfCu8JPrXkmyOiDRM9aTdCCcreoVBVSJa/s6td6fEPioZkLL+BxuYRlMhrPFMkN5uN9BsjZfwW/0fwEv3tp7GX0+LyWQ5y7Q==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GV2PR09MB5992.eurprd09.prod.outlook.com (2603:10a6:150:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 10:29:09 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:29:09 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 12/14] hw/pci: Allow explicit function numbers in pci
Thread-Topic: [PATCH v7 12/14] hw/pci: Allow explicit function numbers in pci
Thread-Index: AQHcGys+KOFEuYVv9k6kny05Y8vGtA==
Date: Mon, 1 Sep 2025 10:29:06 +0000
Message-ID: <20250901102850.1172983-13-djordje.todorovic@htecgroup.com>
References: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GV2PR09MB5992:EE_
x-ms-office365-filtering-correlation-id: ab735713-4aaf-45e1-764d-08dde94262e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SSwLjGtqtt4w135MtVqM/kjxiK5cxAL4TiVMbUPz4zBY7fFo7YM3W4aBrK?=
 =?iso-8859-1?Q?ew1M5Uv3h6uTQS9VMbMDPqqNQUU70oI5/QkICB8BUe5B8LZxTcx3KrRWBV?=
 =?iso-8859-1?Q?NoKMYiryGIckLfqB4ywSADKzp/jzHjwST9Qc7XNi6Yaq4BpLdxt6LBHrQj?=
 =?iso-8859-1?Q?amXNMNdyu0X3fexWze8ABq7P7GuTYQLym3ordXjxx90u+nyAkE5QsFO5mr?=
 =?iso-8859-1?Q?EqTuWeqAkmc6HiI2KDy6Owljtoi7pX9aNFXlEjv6jfn3J6wVeLyX+o1jaV?=
 =?iso-8859-1?Q?jD5t/4rIoUAc0Wjg6rPwnEBA/6zM0EdMz6Lw9HMcb6T49fu2ytgfvUWjB8?=
 =?iso-8859-1?Q?n4vXuKtEP1/CiWBBJKfGZ5bCPOzTxyG96bjb24KP/1ygn1VyFxoatn9Zbu?=
 =?iso-8859-1?Q?2JV+dRM1XfCM/aa275u88gk5cZz8OlomN5U/HXGcclx8Kyvd1jL68hHOCQ?=
 =?iso-8859-1?Q?XI7veuSfpiL8pi+4Rc707aVKnQybheugidNrMTVpTSzukIWBBMj4sXBybc?=
 =?iso-8859-1?Q?tGIa+9JhoSp6I3lMmM2NqypiCkZxJnpWXJv+hQuQwGd0lEqbZBZsdUxsHA?=
 =?iso-8859-1?Q?2ojB+JBLVRkF4P0Ror0xX1hYwCOzkSaQO/IeVfl6prqthhusUL3FpNWvdi?=
 =?iso-8859-1?Q?PJLxLCfdiiV7s2WH5BS+WL3APW1vd9sUpjQ1FCn9EQJgaoKlCtPS19f6Xv?=
 =?iso-8859-1?Q?HMjFoa7nHOK6XmS4wIUc8dEfUJxvHonpSeTpqdiWe+421MFu8FcLLje1OW?=
 =?iso-8859-1?Q?lkHCKvq5GftGGLIt9TqSBFkkxxLT4IeQjSEVNqhiqVLu3MFEq5aQKTc4u1?=
 =?iso-8859-1?Q?BDcq5sAb1SKXVrePTMCg3UT0k1DYIgGogRu2f/oOcZqfpVQDyoXjwojBHJ?=
 =?iso-8859-1?Q?HrttYKAqXtNld5LPBo+6pLGhNnWoZ/TceFyB6d5yN8/fTZPx/L6DDXljzv?=
 =?iso-8859-1?Q?tYhWR62c04hi/dFlgUH60dWe/e4bpRFprxuix5Ic2yIkGfMXZBQ27zWZM1?=
 =?iso-8859-1?Q?kmV0VbIzEvfosyy7zAB9lrEnGSm29bNuQi3vNfPPGFzxNiCHrAwTOk0U5z?=
 =?iso-8859-1?Q?CkahyJpRyfHuCHTogFCH443WE9sOTed8BdH39XSmg4+Ng6agGHhcuUzpjY?=
 =?iso-8859-1?Q?QHOrZZ6Kosrmyorhf92Wj0WZwT+wjb8M5NF0jIOyP6arznkmhpHFzJZ1kQ?=
 =?iso-8859-1?Q?tj0xWmHXwoR1IHIh6Bt64vwxp20+GM0IliCz1lk3rsQCPFn3mUbdNExHua?=
 =?iso-8859-1?Q?Gl2Ipg8+YBh9DGpz25LtNRbP64oHaa9S6nl3UTJtbVPPuBOpDA4vLPsn9b?=
 =?iso-8859-1?Q?HXmUrJWZFka2dSAMA0rCL5D6V8cQaLxxoiKPKXabgXzvZzHQfenCcqbvBL?=
 =?iso-8859-1?Q?rwQFP5mb0u3EReJJsegCFhh+EDd0eJc9vfpS3soxz1PqY+4pzgxqtULpJL?=
 =?iso-8859-1?Q?1kLl13lZ9QiNtFNyqps5iLJAtMQocoK7RYwKCMDzwQUGTCpALTuF33bXU5?=
 =?iso-8859-1?Q?qgsu1G87hwoMatjZwtLoE4J/IyVkTdvSQJPVxMwEfZ3g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NN8GmpGQQG8LcEEl0+WshfIH1nlaxCIHqJyVfKuVqfGjLQEUbCtvV7jjZR?=
 =?iso-8859-1?Q?h+/fuiGZk8A41gnTxO+S2p+h4mJ3xrSzYS7aCa5/BEk5iQNk/J1DgNuRTO?=
 =?iso-8859-1?Q?ZL9kYWXRMdyy+A6R1WLCd8bIAoCpzjTq0EEkYc52z2P87OD9CsEisvYMQy?=
 =?iso-8859-1?Q?jglpzzZm8DT7LaM4mTI5HWpAInbJdngEPP1YQKfmWkb9uWW4lo53x+eYjS?=
 =?iso-8859-1?Q?wDRVI0iOREArmh8u9MzXZWdOfXQ9eAB/O4FxN1wGX62ytPcm9Xmegicmh2?=
 =?iso-8859-1?Q?FJkCxbZty9xUZsJdyeKHQVAuvifTmknHAryeKNx3o+BFISsLEaVPV6a3M5?=
 =?iso-8859-1?Q?xvkUcCGCzpGMsXBiEItAEHf0vhCfKgi4foSBTTRD5ESISPm592f+JkUnSD?=
 =?iso-8859-1?Q?idPkt9SX6ULT9qEmQJgUAJGVeWfrJFQa0eCBKmVIGURVNGvxJ0/iZRe8kj?=
 =?iso-8859-1?Q?7sBHlfWOHX8nF0I0IppQYZA/e3vfdutb2d49dJfVnYzz1su1HRT4RLnmBN?=
 =?iso-8859-1?Q?fKUcc2ekqx4uRSGdS88WDvnMvUfvJJQLVxGkBPQiKz9YS5CXSxCl2gFWVg?=
 =?iso-8859-1?Q?SjyNxKYk4eg9xjKlPFdaaiXQWsG6EqUGMp/ZI/OdzRHYOHSyYtAXNLTdFX?=
 =?iso-8859-1?Q?RAVG1HxmXuq5lIl+SsV0rNLu2GWFaH28TJsJj/91CfjWtlSNmG9Pwixqjj?=
 =?iso-8859-1?Q?pPY3rMavKq9EZtcDuynzhm34VZKmnRkk2cnsfjOtEgz7t6bl1LcGt6lqxg?=
 =?iso-8859-1?Q?22g09gA5WWoU/PShqCTZabXVt0eRBZUf/3duN7lgy8O0RB8+NFpcGGv91V?=
 =?iso-8859-1?Q?tj9MlN0Nr/Jq6L9PwCpPj3bf6UWpxfYcob1S3mdhs4TzR2zVMGfmtmK2PG?=
 =?iso-8859-1?Q?e6DXngMuzWy7Bmb41h5kz5zb+lLHLdAxqXscaMWH0v41wMUiumZ2HUmXa5?=
 =?iso-8859-1?Q?x8IoekYiyZ3oyC2kt2pmXDJM2Xn5QY9PIV4IO8y/Iv84J7ICFew2RyUsRJ?=
 =?iso-8859-1?Q?3FlHvVPw7Y7I1Euskp7K2MSqW+1fmwJgl7YM4I8fI7NtJRbia0G9mgYZJp?=
 =?iso-8859-1?Q?c3WWuRuyKYcHyP4U/iW/rweVyu7Yo9Pr1Zo849zd4YtEBatohzfuKnWHOM?=
 =?iso-8859-1?Q?mC2z7ovQotIF01qq+w0c4c8xfJHKQedAw9s0UCOW8Io91ExTR6mXZx9rCL?=
 =?iso-8859-1?Q?9Ogw3N5loWWFpdeuO2Qg5VRuYFlSsH8afGpAZw1IfbQeXcdEZT25XFmThS?=
 =?iso-8859-1?Q?GuyV+Y7fys9w88mTi+NfzkatIkWcpEQX56PHAX5HUEaqzxhCrHIldmZtRA?=
 =?iso-8859-1?Q?7Vf8Le6LbnVJvSUA6zTKHOSvpFt4zj7D5VIuPiuvg1jl+fXIA+YtDImZ+3?=
 =?iso-8859-1?Q?cvvdBwkqi465iKJ8lcM2h2Yg9QG3weohQogvZQ7k050X6ZFOj0QIaPxs+9?=
 =?iso-8859-1?Q?AslJs3CCMR31CuvnbYhLZ8AFMX+5YH6ugMriol7aOAICRPpccgdzYCzbV2?=
 =?iso-8859-1?Q?8PPBKe4KexwG6HfrUrUHabGKBDomoAXeWq8XAmQuFNdGmfIG4A76IpPHul?=
 =?iso-8859-1?Q?KRPXS+Z3qEc66nnMQcVSL1BicYhnwPVDZzeWeuyrxErYv5jV6QuQvGgWzs?=
 =?iso-8859-1?Q?Q0mkZYivgk8UKY1ERUeaJNFWs4r26EuTZxqKmOFMUr+8cUsHysdEgK65RN?=
 =?iso-8859-1?Q?yOLKvqGeDlKFTV8VhZg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab735713-4aaf-45e1-764d-08dde94262e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:29:06.3134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XYGpMrqUaAQv1v65p7wuFYa0vzGPcr8DxhOU8/GrmS0nMvu/qv5UHbj3XbUZQfkgqK6v7LnNq5woOpsQ2u4X7BOVXcJiitoPwlKQp2y44V4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB5992
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since there is no pch_gbe emulation, we could be using func other
than 0 when adding new devices to specific boards.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/pci/pci.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c70b5ceeba..0c6d11e145 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -984,14 +984,15 @@ static int pci_parse_devaddr(const char *addr, int *d=
omp, int *busp,
=20
     slot =3D val;
=20
-    if (funcp !=3D NULL) {
-        if (*e !=3D '.')
+    if (funcp !=3D NULL && *e !=3D 0) {
+        if (*e !=3D '.') {
             return -1;
-
+        }
         p =3D e + 1;
         val =3D strtoul(p, &e, 16);
-        if (e =3D=3D p)
+        if (e =3D=3D p) {
             return -1;
+        }
=20
         func =3D val;
     }
@@ -2054,13 +2055,15 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const ch=
ar *model,
     int dom, busnr, devfn;
     PCIDevice *pci_dev;
     unsigned slot;
+    unsigned func;
+
     PCIBus *bus;
=20
     if (!nd) {
         return false;
     }
=20
-    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, NULL) =
< 0) {
+    if (!devaddr || pci_parse_devaddr(devaddr, &dom, &busnr, &slot, &func)=
 < 0) {
         error_report("Invalid PCI device address %s for device %s",
                      devaddr, model);
         exit(1);
@@ -2071,7 +2074,7 @@ bool pci_init_nic_in_slot(PCIBus *rootbus, const char=
 *model,
         exit(1);
     }
=20
-    devfn =3D PCI_DEVFN(slot, 0);
+    devfn =3D PCI_DEVFN(slot, func);
=20
     bus =3D pci_find_bus_nr(rootbus, busnr);
     if (!bus) {
--=20
2.34.1

