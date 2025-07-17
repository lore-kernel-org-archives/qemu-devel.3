Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38365C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLJK-0003Jn-SD; Thu, 17 Jul 2025 05:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL51-0006Zm-JJ; Thu, 17 Jul 2025 05:39:07 -0400
Received: from mail-westeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c201::5] helo=AS8PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4z-0002Os-UY; Thu, 17 Jul 2025 05:39:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzrsNX8TFG8+Ox3HuCroPpDO0Mj+ERp2ZOSWIoS6bD6mT3GNKhQGxJaAyB74KwH2HqURpQoPCwd45VXKaFj/TsuWQYfW0hzrRQOpO8k5FxYNVG8g9EQry15McJBprRDrUeGxtEJtxzx8JERUX1ioOrNny4VExvpl/eOSWNfUkHDblJ/WdbFPGLupP/9drij4CxnGOBICmjNuhtl1gD26NtGPFSQzhyL/QA5YPqouAqaU1vjnFh8iIG5GwiPdkuDsHEWSec2nQniTcl7yI6kEQXlKxkz4MrxjETE/PNAxLhu2/qZOVDJBfd+fXtW261lb9wfEkmdTS5tnI7SfxWIs+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lo2hX4EBl0lIXzvHlZi6xKfPJl5zFBo5XKWULHxYLE0=;
 b=V4jGQUCpXp3KhNM7YTPQHEkFiK7I3kc7FTdlZJg+dc7/rwoQcvEdTfLLDzleDXa5Kwym+u5bsVbMl1i4Ve2VQ+5Zin3WZseSMV5q6qmPWuUx0lGCWkLoqGdJ9FWZ4n8DY3J3jkZRbf5sh7FHcJHL6hh0o10JqK8rgV3MQ56YsR2/X2+n7ZobBPWhMHOx9pfxeLEle/zpT6vihNklR14LjpvoyJL2F2EUYCT+0eAD4EiEsypWjzPlpxyf5BAJqC52lNSwdOrqj9PqyH4V2+x4cF1MIKjmVYBLA3O60nJ6XfwgfYU8+Oa2d9Mtf5bU77VVbsGO2gEXtJSmr7pKC1xc7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lo2hX4EBl0lIXzvHlZi6xKfPJl5zFBo5XKWULHxYLE0=;
 b=FChDKLLOcDL1ctO2SZH9afcSZ8Dk+sfJROBZNBa1odq1Xf3TbAncFKbjn/oA7Sft22+vIJTUQZ4aXeSiV8VPwHKtUBrb09m6Ngid3qJ+S6bTalX4vKblqcSG9WxNh6AJs5DwBFjM6Uvx5saGobSvNmm15qyo83o30/Trc3lQZhpPNsD3rFLotep5fxq7sOPbyHc/9/aok/7ZeMT7IPcsVq0dEeNwhSIgvCr8dS+k2OcbLKW+SiHoiKhpfWKPg+fQ5cM7h3XFixNmEQkPbr9wS2zNhzqfDEFYCWU4SHzvuvzoHHo/UA5rp4iZG3UGrnfJiEG5duHjp/jb/VnTouj99A==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by VI1PR09MB4318.eurprd09.prod.outlook.com (2603:10a6:800:155::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:38:50 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 09:38:50 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 13/14] riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
Thread-Topic: [PATCH v6 13/14] riscv/boston-aia: Add an e1000e NIC in slot 0
 func 1
Thread-Index: AQHb9v6X1tAUAYTyok2R8fa7AFc36A==
Date: Thu, 17 Jul 2025 09:38:46 +0000
Message-ID: <20250717093833.402237-14-djordje.todorovic@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|VI1PR09MB4318:EE_
x-ms-office365-filtering-correlation-id: dfa1c632-e687-4e31-db8d-08ddc515bc69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?EEXAyRvUDvj9h2XI7wkvcBSfSTbLE4NS/LHaRUy0V7juNqMBkEt5HedbHH?=
 =?iso-8859-1?Q?0TRgbA8uy9bSDubFWCfX+9UwE+oeOp/941Bjc2WK1QkaxgFLkeXDAdPNn4?=
 =?iso-8859-1?Q?VZVqGDRUEpDfMXN+tvpWKy2MQqV5fG1y7XGdk67EQpesI2OYvOB8b171CD?=
 =?iso-8859-1?Q?niHqqB2qbxrI4m1OrTiC3pL1u3iqEuuK8JjIJkDLJPdExUQndH38NKLW6c?=
 =?iso-8859-1?Q?2Gyle606yRU3WiyAkFobHQjANcjd1i1W0KaAmNFzcjMSc24LTiEJuQOcWd?=
 =?iso-8859-1?Q?aYHr8elYklQq6lPZ5V4rDD8Gd/EFyA+Wsk5AH71GdP5Q+Kh6JbEFsy1RbP?=
 =?iso-8859-1?Q?xH8uCoT7HUqd9fkHn1AS4lyImVjEraEsYNbm0grroiASpY2iwUiHoE+uzd?=
 =?iso-8859-1?Q?iw8+gNxQXmek5FqJ36kXlVn7jHkIlHgsdeC3CotlZlLlPzELRFrfOZ5qKl?=
 =?iso-8859-1?Q?xBAdTJ2a/06VRYERj/O7AOOZAFVb3TbtlsT2+1opwlCqFcWHQFWcbsCHBe?=
 =?iso-8859-1?Q?5YjfE4myfluBIaBKJzqk7JIW27zobEgaFvqFdqnQ/EKRALGWXtuyKNTq5h?=
 =?iso-8859-1?Q?iwJ0z8jMO5/uz/pMuiz1g103R2bf1rcOrR5lnxVtY1vttq3cI5AneStEyh?=
 =?iso-8859-1?Q?/Rx9TK0ZLQndSZeeilGGxR7vsTdmWKTPGmhh5WIPhGDx1ZLUBkqSGzpsmI?=
 =?iso-8859-1?Q?fbUEhA1sNkf3d6EdjiYIJYjKRzkEdpndTIyQTSxZLIrHfkJdxAZy9c/aPV?=
 =?iso-8859-1?Q?E4R5un6kLc7YUQDNqDQH+Y4D6h1z1imc80cGkYDOioFFtnAqHkiRypH0vH?=
 =?iso-8859-1?Q?MZKWUv9x2yZ8gtORelM0185Qzl1lwWlAZVXi55+9IbO10tsUMz4Z2vazHc?=
 =?iso-8859-1?Q?03Ol2rhnPTfBDjz2OLs6sD69Cri/IzglNvQ7WkJ7fvqLZ9mv279Ie6mpTT?=
 =?iso-8859-1?Q?fUZQ+Cc43/m+iWcE80Vg20auVY+I/zPm68//fLOCuksYdVXWk4njMUBxIx?=
 =?iso-8859-1?Q?s22dA1Fr0+ne/utzj5kcDWSqkgRIoNEvxV6MXpk2h4v3RVNTGajVOCXLCA?=
 =?iso-8859-1?Q?mS54uGtvgl/MRpKopaUWf0ib2/RyfgqVF4/nFw4ZJXcuNM8PbW/zkF7mcx?=
 =?iso-8859-1?Q?ryU9Aa6WMSKIVcYNdwh2AhrfN8gIAXmE/f34Afsif49uVnqSfjN/6+DHOT?=
 =?iso-8859-1?Q?jTrKgdJFnS7JSjzEH3+iH7be63But/G/84I6WdKka0gTjJOtBWVH8gWZGO?=
 =?iso-8859-1?Q?oNMYJkzaK1aWn8Gwh9a+VDM+PshdAs4VfTXFaykc9VqaSFC8s+vdfhGy3i?=
 =?iso-8859-1?Q?P1JyKOl0QckcHoq9PnEwLyKne1ormMxJEUEhksymZLLESnp1D8sICBUfHM?=
 =?iso-8859-1?Q?5r5SzX+p63qUO91BtEI8B3ZnT/dJTT+kefAR5/noCsm+Kt5sM/HmkaWEME?=
 =?iso-8859-1?Q?x7RfHu3QE0Ul3rV629KioJYzAPeCSKHRQr32SmcC6f2aiy8N8BZ2TaVj5y?=
 =?iso-8859-1?Q?Mtuu+48B6es6kYaF97+VjSxUpCGe11wKJsQMys4Gn9fw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?h6g6kUZpDsybeCTR3XBQaGtEkHuvcpxWvjwoauTAuX7qC9/lcbmWnKAP3E?=
 =?iso-8859-1?Q?7QuOG4YpADDF5hymA6psv1aHUeJRjcfR1Jc5y6KU5C/sqRaE4X1UXPg0YT?=
 =?iso-8859-1?Q?HfnHQU0tuxgGF/Ykk57p8ERJPlw1YcOOTdi2AKp5gK/U5+1Upq/zJupmVl?=
 =?iso-8859-1?Q?8VbDY+fZTAWBARks/WjcyHIeS5s/iolIzHfsX/W5O4aJ5jwCs0RGcADJE+?=
 =?iso-8859-1?Q?9E6rg4a+uvN6BpkIQOcV+H8/M56QxL04RXoVtv7PhQZzvgTG3c7kmo5lQw?=
 =?iso-8859-1?Q?9q/ic3Wo8egGWSNqwEiFC7SiOCdZpKczgusPPq9BUI+BopZVFlLks/MH3P?=
 =?iso-8859-1?Q?NxaOqhhowpzOjKRIOVIDT0Jy/5iK3kIn6ImZ9xDeysokXne2YSjIG2eB3l?=
 =?iso-8859-1?Q?WSXwDgoJZRtFyUubBQj9LRGU7IZfpUdWTrjzthrzVq+OtVATainJxg9juB?=
 =?iso-8859-1?Q?/s56b3eKBsXy/pEr8vFoLJ+z8kY4KieUPP+vYfPqJxYbCGtJhHRej/Bwz0?=
 =?iso-8859-1?Q?u5woJ94vGovCJFW3VszK2Ua1ibIoaPuv9A08uU5eT1/4q8EImARdmfx+rX?=
 =?iso-8859-1?Q?DWlJSagSVbDsC3Mf0aHxrrRqrCmWvX101JX1gzDsnRrKBJB0h/vpMRfQpY?=
 =?iso-8859-1?Q?ds3tzGqCXopTffKDF0TPKtLoadqJlVy0nA0nyOIuzRUTBVmanOvDzTojy9?=
 =?iso-8859-1?Q?XPloPBDhqCmkX9PECLcaXYu4qwERc7Q0LC/phXkM8S8iSeKoUisa7ynDjX?=
 =?iso-8859-1?Q?50fCuewU+6gS5JaROrByysPYuIyTbFFgAN3LlEMIjFC9YGDPbeKCyKfJh9?=
 =?iso-8859-1?Q?Z9V4PlcH/8xV67ktwYBC6e2VZ9bORj6inRXXJuoktHhKlYK6uUUejcH9JX?=
 =?iso-8859-1?Q?9KR+jnER7eFu0bA+5bZ36m19iPeVDBpv4UjnLuItmixM1P0q3M9Y795T9m?=
 =?iso-8859-1?Q?7py3UgZp/6XyWSviKh3IY/SliAdrI1GBEs8gV4PeWvyJoqzIDFamUqUJhO?=
 =?iso-8859-1?Q?R24P1SIXed7ixL/wURbM6fiZouwrVGuqDXJ0isy+jz3iTQAP5SvRWU1EWa?=
 =?iso-8859-1?Q?ocosft2b8ksCRLDgTcoUoRmLy+ydso1VqAFTCw2tpYogPKGMSxphuPWUn3?=
 =?iso-8859-1?Q?IyGZSY2Qcfv6iSGJlkyaGadm+2PPSN1+gSioAFWpsqc9ZGCNd85YS+FLX0?=
 =?iso-8859-1?Q?udxzIGRTC/Lhi7xCFZFmoc39YUNBPBfAG9syUrLjdgkHKw7WN4kAas1xDT?=
 =?iso-8859-1?Q?7Nmcwdy8kfXSYE05ZXdHcDSskq1fK3LdhvusNS3ukGJY+vGcuDu/f2pB8S?=
 =?iso-8859-1?Q?3dtOQQJU47ZpvrMEvSaOOLyT3yow4Agl+K+TVCWmHs2IeKL1vNPk01XY5k?=
 =?iso-8859-1?Q?OX9aISuo+lsPO9FFciQ9qTrf74vu0a3EUitUc/mXdoMJOoJLao/cDHAykz?=
 =?iso-8859-1?Q?BpWPeaqsGqwB+AU4KgQ3kV0qUQ73WLyWOphdfGlPTE8aRY8xTbmaMqYZvA?=
 =?iso-8859-1?Q?LliCOw4piZ6D2+hQc3mR+z/V2O2h/ZkmnEgmlx+bdP3a0sWA27Bm96dME7?=
 =?iso-8859-1?Q?zhFSfHx1WD00BWEnmkjr/FGUEK2dZPRbLS7Q+LE7Kfe384pfusWpSI+gwZ?=
 =?iso-8859-1?Q?/U9O8+H3c0/TFNEBc73+8fe69G2slDsuJSHdV3euPdX3sP7y+GVgTQd4R/?=
 =?iso-8859-1?Q?rJ+A57vKHJM243X3FnQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa1c632-e687-4e31-db8d-08ddc515bc69
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:38:46.6677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RrlwfmXbhzSFdJ2UwQHQ2o0D0EK+35+OHvqHhAjV/qU+q+WUA8T4kt7Od0XlbhCmYPM72gcpDyf6V/IlL/6xYBhWlRg5TPVfElar0hSX1Ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB4318
Received-SPF: pass client-ip=2a01:111:f403:c201::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR03CU001.outbound.protection.outlook.com
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

The Boston AIA board needs a basic GbE NIC.  There is no PCH GbE
device emulation, so use an `e1000e` instead.  We place it in
**slot 0, function 1** in order not to conflict with the existing
AHCI device in slot 0 func 0.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/riscv/boston-aia.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index e31b0509ca..9be66167f0 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -437,6 +437,11 @@ static void boston_mach_init(MachineState *machine)
     ide_drive_get(hd, ich9->ahci.ports);
     ahci_ide_create_devs(&ich9->ahci, hd);
=20
+    /* Create e1000e using slot 0 func 1 */
+    pci_init_nic_in_slot(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e", NUL=
L,
+                         "00.1");
+    pci_init_nic_devices(&PCI_BRIDGE(&pcie2->root)->sec_bus, "e1000e");
+
     if (machine->firmware) {
         fw_size =3D load_image_targphys(machine->firmware,
                                       0x1fc00000, 4 * MiB);
--=20
2.34.1

