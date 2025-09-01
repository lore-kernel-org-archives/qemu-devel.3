Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4A8CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1n9-00042r-Mn; Mon, 01 Sep 2025 06:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1my-0003vG-SI; Mon, 01 Sep 2025 06:29:29 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mu-0005KU-RE; Mon, 01 Sep 2025 06:29:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLCiZnfus1iLM9fkoEENxxiwjKUHpqlr4HyoVbjcNpZ7uA5b8/D2/wR55j7nSSDvYTMmHWPfEPx8a1WzUYFa9yU5ZJETOIQKDEnXAB98W4f3T6qBPDXOa4vD8ew5Bywuhtvee+xnOesyYX37FsYGeIKMA4PvWO/jD7aamJ/0kfoqsvw51v8ocmiZoHYnpY6IWasFLPPtqVRgNx+yZSYzS/+ir8vsX8dL+lywltHveO5x5iV+DVZHIBcasc2aqY026FL1Trkub9IFVwo8lC5qTh7sS3Su6Q4q+ooQBVRShs6Oya7T9SGPssXyGn4qQNAXZ2G3NgalyLkx3WFQU+m1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMqW50nLtFo518TWNRfMJiDyicYK7GyAEVHebMn2tw4=;
 b=L1waBMNWZ0eNUzFbIzwkmK3LysdQJulEoG31nXEuUYeFO7F70fSrbS7VVDkbw9riNeqw+1922rJMQRdOLSnMENfJUPBP4zTTaKunrSi3MR2dmx08ZEgfLi7B+dJMtEDYN1KEx+b+bwzAVNLUceym82s1/OGgorz84n3CeDm1KnOpBiqcsTatbxJML1kWqYNQcZFUrMxZFKGGZ867MVjg2Cxf5Q1qOxXKPrjgWghliDQjZ4fcx65kPL3Vsgv027lsRkL1WIVU3/cKuWU4uuyb9nnPWrxEgRa7PCOwu6tvChU0kEFvlvbW9146MUuTaIrauZ4A00akmorqhspwqUupOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMqW50nLtFo518TWNRfMJiDyicYK7GyAEVHebMn2tw4=;
 b=vFzpTfUDUCKz2ONiG7lx4/1MoS9VQNGuNLzfKLy8oj6ZCj9IrRIeN0FmHARZ3AZrY7yE5uyFKUPwy/g2EYZ+FOsrUUwimN2SwMGRUI9/HCI2J5Do5cu3zzRPodPIvJ3O215Ee1LZrqe/l1hruDHC7KUPyDFRHhXNe4mdvbx4EOweEx9Evp44Sw5Iv+XY44duxT6Oi5zj9mHU7hROeHCrGFSIzVHG2qKBbwnezmbuJLnpnQYwSxCNOL44Llq9FXbjAlatTYJ7k88r/SeZjbzq4WHIfBn8fU97/ZdnBWdem+qcBXoSZQQ1jT8NpQPNIe14nH2QodzpP3GRI7MAG2OAkw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GV2PR09MB5992.eurprd09.prod.outlook.com (2603:10a6:150:be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 10:29:08 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:29:08 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 11/14] hw/riscv: Add support for MIPS Boston-aia board mode
Thread-Topic: [PATCH v7 11/14] hw/riscv: Add support for MIPS Boston-aia board
 mode
Thread-Index: AQHcGys+w+PjlDIFOEaiJ7CxlXs85A==
Date: Mon, 1 Sep 2025 10:29:05 +0000
Message-ID: <20250901102850.1172983-12-djordje.todorovic@htecgroup.com>
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
x-ms-office365-filtering-correlation-id: 202e04f7-7201-4729-e811-08dde94262a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?VfAZOEYop49++2a22IUU0wHKqfZwa60KiW9mDcGTgbNWTTTfqBnCIOBFop?=
 =?iso-8859-1?Q?VKqyofS3C7/evco4paFuUCM3TlqomSNiUF1O11RNYCg8dzroQ2fAJXVSPL?=
 =?iso-8859-1?Q?Tzf+UTDshBfwclxA/V9HO1CyoKxeclZSNV/T2sIwB2CkV87iKhXa9qhMHK?=
 =?iso-8859-1?Q?2cmvG+enDxeNghWIHldPBKGi80WTSFI+PW9/LzSyyoEFMCSbhYNS6ZsVOI?=
 =?iso-8859-1?Q?emPg3DvVDZEEN4LAguwTCz//Js5+f7BSXt7x9NxTkK0W/2ug+grLYR4imq?=
 =?iso-8859-1?Q?HT06AqXpAHzTWpk1wfbDEMbdkVlC5RAAKHtBxm++hySoB0zgkmewQ2EKe/?=
 =?iso-8859-1?Q?j3h0Y4qkq0hD71Nmc0UMZj4yAHOiao7zT7LmGxLG37VXU7A4zJJm9C4GoR?=
 =?iso-8859-1?Q?n6JyPs8QlxtlMgwqj64QYDSnA2fsdAmBCVtudVzdRwNDGuBbOMbhmASqtf?=
 =?iso-8859-1?Q?RJJweO7Sls7LsLaRcOA7OwDtYXpR5b9Kti5mSumDWAU7BWTrG9pECgVDoF?=
 =?iso-8859-1?Q?Pb1UmTJThIu5FdcSyTYznd3BOmL1ESSPyeSJ6c768if/IMzGaH/9lS9tBL?=
 =?iso-8859-1?Q?WM8S5ue7dGCcSMTHuRKS9XXwP5+E/T6QNGEjjxbe2B+pP28T0q2Bhv0SoG?=
 =?iso-8859-1?Q?0uDE1IONUb29Y3sOjjxmUxRXHHnZvmAg/nKz25dgjVg+KIHe7W3rjr4NrA?=
 =?iso-8859-1?Q?RRkYCAJGc9OYcMzrk0c9b8DlWDci4zYQfPjXeKGL4VviJy9DVJytdEnRu8?=
 =?iso-8859-1?Q?2fKcpn4XNG9G4SEZ8o6wHI5QDQjTt/i/DPnO6vtJHYe2IYO6AkGihf72WY?=
 =?iso-8859-1?Q?emNW5r9TTeIiFKH6jukwK4z4FdB0yG0AuNMfQthObpWJ5HCaPwhZVjoxEy?=
 =?iso-8859-1?Q?3JZsXpiHqc2o4DFV3mdF43a8Rx/VtJWKoPohAAIYuwEkoElez6KucYyxS2?=
 =?iso-8859-1?Q?0abNNXf7BE7ys/8G/r0wfIpcPTNUiAX3eRQydVQwrQ+vhvPmAnhLq+JLuI?=
 =?iso-8859-1?Q?ze96oCJq8iw/txKox3VhNTxTykZejacQj94PGTAIGwxWMMg4vRcEe2BshQ?=
 =?iso-8859-1?Q?0Kq13WZNoHoIeKq65KMMlNsnqKRa4iKcijt2dVPoZ8w+FqS0XYKvtXSoHc?=
 =?iso-8859-1?Q?8PFW7ZkqKj5dCRtfXs3SnRbU72zyUWm2zIj3FVAG+od+tFRd90bQFQ4zV9?=
 =?iso-8859-1?Q?i8vkNh/emze5OW5YGmj+2mvJki+Pl1Spj0KMxatiMx9bS9nNbIyBHQIm8u?=
 =?iso-8859-1?Q?7VxKAY6reHY9vqwuMuf52zaPwNITHeORBFEJbO0fnWUb/g/N5SjxqlAGQX?=
 =?iso-8859-1?Q?NWFfvWEDvb1NYzlUim/1URJ2o+6vAZEooyU4U0Lvu67gac1zsHJEDmVapQ?=
 =?iso-8859-1?Q?r+wH5glHhsF5QOJqRcGW9kS+SPbP2MK9uvWIDS87FCCMRXesxa+eVAkywg?=
 =?iso-8859-1?Q?q2qHFtxLf3j2fq0PAcVgQkdJetd2oUuJlLw8YHVlB0woB3MN3fSWZB/nHo?=
 =?iso-8859-1?Q?hi5c6aURjgKuEczTTS5CjTnbfxCnYZ327UhElam6S+0umgP7jzFHcrkzD+?=
 =?iso-8859-1?Q?Cef57oE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1SG4SjSgDYAH8G5H/GF8Vrgk+w9JhnVXbxYQLswwnsfuwRIsEARzyj1Sku?=
 =?iso-8859-1?Q?PNJVR41XtX1yAZwVeHlhSX2aDOp7YRyZnYR8KndetXljyFe1zvqntVrP3I?=
 =?iso-8859-1?Q?MvX5lqIF6T2r2rtniCec/qGZJWw+6hRbU+JTF40pSDtDSaaSX0oxwEYomv?=
 =?iso-8859-1?Q?oxyEELmnG80NKw5/lW8N/UG6w7LEz7+A8TIaCHBh4CARoA+yTLGwWvkP5M?=
 =?iso-8859-1?Q?MyqxZS+lTm/X3cerPzfwMsPlsIk/acIZtVc2k0hfY7NLwrXiz7I+IjhINx?=
 =?iso-8859-1?Q?TeuZ20207hV59etxiwrDfJtDYHtaaQLZtTuBu/bWSNuACU2MCg+nsFVz2w?=
 =?iso-8859-1?Q?uONnCmMw4Tm78NLZrBd6m0SwIq9lqwdbd69L8NZf7lY3VvILGBLvdCXuVe?=
 =?iso-8859-1?Q?5KskikShSTBOtFs//nPRf+88q+mJ70GYLRpUQQBAjwCvMiDO/IwRR93+4E?=
 =?iso-8859-1?Q?ds5kMmvBerRFeH9HD5Ol2rcrD0KOSfZS6HDVwT8oLBtGUqLNU8L508LcUj?=
 =?iso-8859-1?Q?LUEmt4pKW4VgO/yPmd3IoU6+OHSEtmnLHPiyYgHUM9dELxpPbHsEuVglXS?=
 =?iso-8859-1?Q?8LrS0Ci7oouWo/YieccjDMoaHnvSvsUanBcM+yeyRAZg6RYi5V8dIuJr/Y?=
 =?iso-8859-1?Q?3HGXBG+s7GNp87s1aUYWOxUNDQVXoJBMG1C9Sa7suSr7Cp95s4ERh4Fg+D?=
 =?iso-8859-1?Q?+HovKazCDHbqs7qeOCVz9L3HTPr4Zk7/AeJpKpUuD+UEymLujz7C5NQme2?=
 =?iso-8859-1?Q?m/abeBiWyHhcTihicv/UnPddUolIYm8WNVzeP8/Zh7ddpibe3rl+F6a/Mg?=
 =?iso-8859-1?Q?YtQ+AoC34HylrRxloHXmSqY17R5kMfBPKcM3jdCabkemobaQzUciiGM142?=
 =?iso-8859-1?Q?KuM7QPGe7sOp0aq5EguvpHdr0ZaehaWutNHYmTpSWMdNqed3vf6G+hHt+Y?=
 =?iso-8859-1?Q?BQZ8VOvhkY6gRC5iXUrkAu7WDgSL9QCy6EbdQ/5xWpewRIoBs5/3P+4f+f?=
 =?iso-8859-1?Q?zwYQtvji40ETDIatinq2PNAJYyN2XJvruVsLQ36Wef23GV7jrZnbjCTPnE?=
 =?iso-8859-1?Q?/pIGrySN5mJS7peH1btVNCJkKijCxFea3E/68jwlLDbHgfDW4pe6frFQdf?=
 =?iso-8859-1?Q?GpuYzy60XoPuoM8x/XVPBU0/Rpo5UPueVzQAiJqgmHRbntC5NSETaEuGzW?=
 =?iso-8859-1?Q?unhhNyD3U/ipKRKFpE6UPLcQbzW65NEy/mbQe3tHlu3UWPYr+42P+7i1Ci?=
 =?iso-8859-1?Q?XjX9zOGp9iVMSByvgOgkku1cB+qOMUK/7t7hId5rFjhUeelaWN579ntzya?=
 =?iso-8859-1?Q?ADYqiDvtyl7JqVKHPaRA3kgjkYghJEmwG4mGUM1WtopXJy3FljWTVvbs0f?=
 =?iso-8859-1?Q?hLc5DdUrzA9e5M0YAVeMciWMhH0wszJ5Z5Z6BU24Vs+2EAD63A6+kYK2pD?=
 =?iso-8859-1?Q?lNTwuWcUr5Dh96FcVKywsCQzWuDblYIC9qZhoYvmV7+JQVFfdpBMdTtqMB?=
 =?iso-8859-1?Q?EP91bJ1cB4/52+0aoc6YYflRUCMYPFEwUrQ/KBOrDeHJle5BYiuGPd990y?=
 =?iso-8859-1?Q?QUlcsnlAZz+wR4NyRmlL3BzBKDcR8HTFICkPLAXt9ci35mGJvfdzObP97f?=
 =?iso-8859-1?Q?3/KTfHMwAaQD9FcdzL7dksh3ixeJr1CYhlxqh/KWrdlwiI0yB3XGt4GQBH?=
 =?iso-8859-1?Q?cSLVMxwrvMzb35Q6WXg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202e04f7-7201-4729-e811-08dde94262a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:29:05.9729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G++/xmfSvKLrR1NNKNT/8XxMQATo61VzRPnFKveaP9oeT101+FxgFEI45xkiG/g788DfDNf84Q0QVVr3mSspE6Sc0slENVMWkQlPartcexg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR09MB5992
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

The board model supports up to 64 harts with MIPS CPS, MIPS GCR,
MIPS CPC, AIA plic, and AIA clint devices. The model can create
boot code, if there is no -bios parameter. We can specify -smp x,
cores=3Dy,thread=3Dz.
Ex: Use 4 cores and 2 threads with each core to
have 8 smp cpus as follows.
  qemu-system-riscv64 -cpu mips-p8700 \
  -m 2G -M boston-aia \
  -smp 8,cores=3D4,threads=3D2 -kernel fw_payload.bin \
  -drive file=3Drootfs.ext2,format=3Draw -serial stdio

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/mips.rst                  |  20 +
 docs/system/target-riscv.rst                |   1 +
 hw/riscv/Kconfig                            |   6 +
 hw/riscv/boston-aia.c                       | 484 ++++++++++++++++++++
 hw/riscv/meson.build                        |   1 +
 6 files changed, 513 insertions(+)
 create mode 100644 docs/system/riscv/mips.rst
 create mode 100644 hw/riscv/boston-aia.c

diff --git a/configs/devices/riscv64-softmmu/default.mak b/configs/devices/=
riscv64-softmmu/default.mak
index e485bbd1a3..a8e4d0ab33 100644
--- a/configs/devices/riscv64-softmmu/default.mak
+++ b/configs/devices/riscv64-softmmu/default.mak
@@ -12,3 +12,4 @@
 # CONFIG_MICROCHIP_PFSOC=3Dn
 # CONFIG_SHAKTI_C=3Dn
 # CONFIG_XIANGSHAN_KUNMINGHU=3Dn
+# CONFIG_MIPS_BOSTON_AIA=3Dn
diff --git a/docs/system/riscv/mips.rst b/docs/system/riscv/mips.rst
new file mode 100644
index 0000000000..97096421e1
--- /dev/null
+++ b/docs/system/riscv/mips.rst
@@ -0,0 +1,20 @@
+Boards for RISC-V Processors by MIPS
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+RISC-V processors developed by MIPS support Boston-aia board model. The bo=
ard
+model supports up to 64 harts with MIPS CPS, MIPS GCR, MIPS CPC, AIA plic,
+and AIA clint devices. The model can create boot code, if there is no
+```-bios``` parameter. Also, we can specify ```-smp x,cores=3Dy,thread=3Dz=
```.
+
+Running Linux kernel
+--------------------
+
+For example, to use 4 cores and 2 threads with each core to have 8 smp cpu=
s,
+that runs on the ```mips-p8700``` CPU, run qemu as follows:
+
+.. code-block:: bash
+
+   qemu-system-riscv64 -cpu mips-p8700 \
+         -m 2G -M boston-aia \
+         -smp 8,cores=3D4,threads=3D2 -kernel fw_payload.bin \
+         -drive file=3Drootfs.ext2,format=3Draw -serial stdio
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index 89b2cb732c..3ad5d1ddaf 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -68,6 +68,7 @@ undocumented; you can get a complete list by running
=20
    riscv/microblaze-v-generic
    riscv/microchip-icicle-kit
+   riscv/mips
    riscv/shakti-c
    riscv/sifive_u
    riscv/virt
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fc9c35bd98..0222c93f87 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -128,3 +128,9 @@ config XIANGSHAN_KUNMINGHU
     select RISCV_APLIC
     select RISCV_IMSIC
     select SERIAL_MM
+
+config MIPS_BOSTON_AIA
+    bool
+    default y
+    select PCI_EXPRESS
+    select PCI_EXPRESS_XILINX
diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
new file mode 100644
index 0000000000..e31b0509ca
--- /dev/null
+++ b/hw/riscv/boston-aia.c
@@ -0,0 +1,484 @@
+/*
+ * MIPS Boston-aia development board emulation.
+ *
+ * Copyright (c) 2016 Imagination Technologies
+ *
+ * Copyright (c) 2025 MIPS
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licens=
es/>.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ *
+*/
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+
+#include "hw/boards.h"
+#include "hw/char/serial-mm.h"
+#include "hw/ide/pci.h"
+#include "hw/ide/ahci-pci.h"
+#include "hw/loader.h"
+#include "hw/riscv/cps.h"
+#include "hw/pci-host/xilinx-pcie.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "chardev/char.h"
+#include "system/address-spaces.h"
+#include "system/device_tree.h"
+#include "system/system.h"
+#include "system/qtest.h"
+#include "system/runstate.h"
+
+#include <libfdt.h>
+#include "qom/object.h"
+
+#define TYPE_MIPS_BOSTON_AIA "mips-boston-aia"
+typedef struct BostonState BostonState;
+DECLARE_INSTANCE_CHECKER(BostonState, BOSTON,
+                         TYPE_MIPS_BOSTON_AIA)
+
+enum {
+    BOSTON_PCIE2,
+    BOSTON_PCIE2_MMIO,
+    BOSTON_PLATREG,
+    BOSTON_UART,
+    BOSTON_LCD,
+    BOSTON_FLASH,
+    BOSTON_HIGHDDR,
+};
+
+static const MemMapEntry boston_memmap[] =3D {
+    [BOSTON_PCIE2] =3D      { 0x14000000,     0x2000000 },
+    [BOSTON_PCIE2_MMIO] =3D { 0x16000000,      0x100000 },
+    [BOSTON_PLATREG] =3D    { 0x17ffd000,        0x1000 },
+    [BOSTON_UART] =3D       { 0x17ffe000,          0x20 },
+    [BOSTON_LCD] =3D        { 0x17fff000,           0x8 },
+    [BOSTON_FLASH] =3D      { 0x18000000,     0x8000000 },
+    [BOSTON_HIGHDDR] =3D    { 0x80000000,           0x0 },
+};
+
+/* Interrupt numbers for APLIC. */
+#define UART_INT 4
+#define PCIE2_INT 7
+
+struct BostonState {
+    SysBusDevice parent_obj;
+
+    MachineState *mach;
+    RISCVCPSState cps;
+    SerialMM *uart;
+
+    CharBackend lcd_display;
+    char lcd_content[8];
+    bool lcd_inited;
+};
+
+enum boston_plat_reg {
+    PLAT_FPGA_BUILD     =3D 0x00,
+    PLAT_CORE_CL        =3D 0x04,
+    PLAT_WRAPPER_CL     =3D 0x08,
+    PLAT_SYSCLK_STATUS  =3D 0x0c,
+    PLAT_SOFTRST_CTL    =3D 0x10,
+#define PLAT_SOFTRST_CTL_SYSRESET       (1 << 4)
+    PLAT_DDR3_STATUS    =3D 0x14,
+#define PLAT_DDR3_STATUS_LOCKED         (1 << 0)
+#define PLAT_DDR3_STATUS_CALIBRATED     (1 << 2)
+#define PLAT_DDR3_INTERFACE_RESET       (1 << 3)
+    PLAT_PCIE_STATUS    =3D 0x18,
+#define PLAT_PCIE_STATUS_PCIE0_LOCKED   (1 << 0)
+#define PLAT_PCIE_STATUS_PCIE1_LOCKED   (1 << 8)
+#define PLAT_PCIE_STATUS_PCIE2_LOCKED   (1 << 16)
+    PLAT_FLASH_CTL      =3D 0x1c,
+    PLAT_SPARE0         =3D 0x20,
+    PLAT_SPARE1         =3D 0x24,
+    PLAT_SPARE2         =3D 0x28,
+    PLAT_SPARE3         =3D 0x2c,
+    PLAT_MMCM_DIV       =3D 0x30,
+#define PLAT_MMCM_DIV_CLK0DIV_SHIFT     0
+#define PLAT_MMCM_DIV_INPUT_SHIFT       8
+#define PLAT_MMCM_DIV_MUL_SHIFT         16
+#define PLAT_MMCM_DIV_CLK1DIV_SHIFT     24
+    PLAT_BUILD_CFG      =3D 0x34,
+#define PLAT_BUILD_CFG_IOCU_EN          (1 << 0)
+#define PLAT_BUILD_CFG_PCIE0_EN         (1 << 1)
+#define PLAT_BUILD_CFG_PCIE1_EN         (1 << 2)
+#define PLAT_BUILD_CFG_PCIE2_EN         (1 << 3)
+    PLAT_DDR_CFG        =3D 0x38,
+#define PLAT_DDR_CFG_SIZE               (0xf << 0)
+#define PLAT_DDR_CFG_MHZ                (0xfff << 4)
+    PLAT_NOC_PCIE0_ADDR =3D 0x3c,
+    PLAT_NOC_PCIE1_ADDR =3D 0x40,
+    PLAT_NOC_PCIE2_ADDR =3D 0x44,
+    PLAT_SYS_CTL        =3D 0x48,
+};
+
+static void boston_lcd_event(void *opaque, QEMUChrEvent event)
+{
+    BostonState *s =3D opaque;
+    if (event =3D=3D CHR_EVENT_OPENED && !s->lcd_inited) {
+        qemu_chr_fe_printf(&s->lcd_display, "        ");
+        s->lcd_inited =3D true;
+    }
+}
+
+static uint64_t boston_lcd_read(void *opaque, hwaddr addr,
+                                unsigned size)
+{
+    BostonState *s =3D opaque;
+    uint64_t val =3D 0;
+
+    switch (size) {
+    case 8:
+        val |=3D (uint64_t)s->lcd_content[(addr + 7) & 0x7] << 56;
+        val |=3D (uint64_t)s->lcd_content[(addr + 6) & 0x7] << 48;
+        val |=3D (uint64_t)s->lcd_content[(addr + 5) & 0x7] << 40;
+        val |=3D (uint64_t)s->lcd_content[(addr + 4) & 0x7] << 32;
+        /* fall through */
+    case 4:
+        val |=3D (uint64_t)s->lcd_content[(addr + 3) & 0x7] << 24;
+        val |=3D (uint64_t)s->lcd_content[(addr + 2) & 0x7] << 16;
+        /* fall through */
+    case 2:
+        val |=3D (uint64_t)s->lcd_content[(addr + 1) & 0x7] << 8;
+        /* fall through */
+    case 1:
+        val |=3D (uint64_t)s->lcd_content[(addr + 0) & 0x7];
+        break;
+    }
+
+    return val;
+}
+
+static void boston_lcd_write(void *opaque, hwaddr addr,
+                             uint64_t val, unsigned size)
+{
+    BostonState *s =3D opaque;
+
+    switch (size) {
+    case 8:
+        s->lcd_content[(addr + 7) & 0x7] =3D val >> 56;
+        s->lcd_content[(addr + 6) & 0x7] =3D val >> 48;
+        s->lcd_content[(addr + 5) & 0x7] =3D val >> 40;
+        s->lcd_content[(addr + 4) & 0x7] =3D val >> 32;
+        /* fall through */
+    case 4:
+        s->lcd_content[(addr + 3) & 0x7] =3D val >> 24;
+        s->lcd_content[(addr + 2) & 0x7] =3D val >> 16;
+        /* fall through */
+    case 2:
+        s->lcd_content[(addr + 1) & 0x7] =3D val >> 8;
+        /* fall through */
+    case 1:
+        s->lcd_content[(addr + 0) & 0x7] =3D val;
+        break;
+    }
+
+    qemu_chr_fe_printf(&s->lcd_display,
+                       "\r%-8.8s", s->lcd_content);
+}
+
+static const MemoryRegionOps boston_lcd_ops =3D {
+    .read =3D boston_lcd_read,
+    .write =3D boston_lcd_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+};
+
+static uint64_t boston_platreg_read(void *opaque, hwaddr addr,
+                                    unsigned size)
+{
+    BostonState *s =3D opaque;
+    uint32_t gic_freq, val;
+
+    if (size !=3D 4) {
+        qemu_log_mask(LOG_UNIMP, "%uB platform register read\n", size);
+        return 0;
+    }
+
+    switch (addr & 0xffff) {
+    case PLAT_FPGA_BUILD:
+    case PLAT_CORE_CL:
+    case PLAT_WRAPPER_CL:
+        return 0;
+    case PLAT_DDR3_STATUS:
+        return PLAT_DDR3_STATUS_LOCKED | PLAT_DDR3_STATUS_CALIBRATED
+               | PLAT_DDR3_INTERFACE_RESET;
+    case PLAT_MMCM_DIV:
+        gic_freq =3D 25000000 / 1000000;
+        val =3D gic_freq << PLAT_MMCM_DIV_INPUT_SHIFT;
+        val |=3D 1 << PLAT_MMCM_DIV_MUL_SHIFT;
+        val |=3D 1 << PLAT_MMCM_DIV_CLK0DIV_SHIFT;
+        val |=3D 1 << PLAT_MMCM_DIV_CLK1DIV_SHIFT;
+        return val;
+    case PLAT_BUILD_CFG:
+        val =3D PLAT_BUILD_CFG_PCIE0_EN;
+        val |=3D PLAT_BUILD_CFG_PCIE1_EN;
+        val |=3D PLAT_BUILD_CFG_PCIE2_EN;
+        return val;
+    case PLAT_DDR_CFG:
+        val =3D s->mach->ram_size / GiB;
+        assert(!(val & ~PLAT_DDR_CFG_SIZE));
+        val |=3D PLAT_DDR_CFG_MHZ;
+        return val;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Read platform register 0x%" HWADDR_PRIx =
"\n",
+                      addr & 0xffff);
+        return 0;
+    }
+}
+
+static void boston_platreg_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    if (size !=3D 4) {
+        qemu_log_mask(LOG_UNIMP, "%uB platform register write\n", size);
+        return;
+    }
+
+    switch (addr & 0xffff) {
+    case PLAT_FPGA_BUILD:
+    case PLAT_CORE_CL:
+    case PLAT_WRAPPER_CL:
+    case PLAT_DDR3_STATUS:
+    case PLAT_PCIE_STATUS:
+    case PLAT_MMCM_DIV:
+    case PLAT_BUILD_CFG:
+    case PLAT_DDR_CFG:
+        /* read only */
+        break;
+    case PLAT_SOFTRST_CTL:
+        if (val & PLAT_SOFTRST_CTL_SYSRESET) {
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Write platform register 0x%" HWADDR_PRIx
+                      " =3D 0x%" PRIx64 "\n", addr & 0xffff, val);
+        break;
+    }
+}
+
+static const MemoryRegionOps boston_platreg_ops =3D {
+    .read =3D boston_platreg_read,
+    .write =3D boston_platreg_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+};
+
+static const TypeInfo boston_device =3D {
+    .name          =3D TYPE_MIPS_BOSTON_AIA,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(BostonState),
+};
+
+static void boston_register_types(void)
+{
+    type_register_static(&boston_device);
+}
+type_init(boston_register_types)
+
+#define NUM_INSNS 6
+static void gen_firmware(uint32_t *p)
+{
+    int i;
+    uint32_t reset_vec[NUM_INSNS] =3D {
+           /* CM relocate */
+           0x1fb802b7,     /* li   t0,0x1fb80000   */
+           0x16100337,     /* li   t1,0x16100000   */
+           0x0062b423,     /* sd   t1,8(t0)        */
+           /* Jump to 0x80000000 */
+           0x00100293,     /* li   t0,1            */
+           0x01f29293,     /* slli t0,t0,1f        */
+           0x00028067      /* jr   t0              */
+    };
+
+    for (i =3D 0; i < NUM_INSNS; i++) {
+        *p++ =3D reset_vec[i];
+    }
+}
+
+static inline XilinxPCIEHost *
+xilinx_pcie_init(MemoryRegion *sys_mem, uint32_t bus_nr,
+                 hwaddr cfg_base, uint64_t cfg_size,
+                 hwaddr mmio_base, uint64_t mmio_size,
+                 qemu_irq irq)
+{
+    DeviceState *dev;
+    MemoryRegion *cfg, *mmio;
+
+    dev =3D qdev_new(TYPE_XILINX_PCIE_HOST);
+
+    qdev_prop_set_uint32(dev, "bus_nr", bus_nr);
+    qdev_prop_set_uint64(dev, "cfg_base", cfg_base);
+    qdev_prop_set_uint64(dev, "cfg_size", cfg_size);
+    qdev_prop_set_uint64(dev, "mmio_base", mmio_base);
+    qdev_prop_set_uint64(dev, "mmio_size", mmio_size);
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    cfg =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion_overlap(sys_mem, cfg_base, cfg, 0);
+
+    mmio =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    memory_region_add_subregion_overlap(sys_mem, 0, mmio, 0);
+
+    qdev_connect_gpio_out_named(dev, "interrupt_out", 0, irq);
+
+    return XILINX_PCIE_HOST(dev);
+}
+
+static void boston_mach_init(MachineState *machine)
+{
+    DeviceState *dev;
+    BostonState *s;
+    MemoryRegion *flash, *ddr_low_alias, *lcd, *platreg;
+    MemoryRegion *sys_mem =3D get_system_memory();
+    XilinxPCIEHost *pcie2;
+    PCIDevice *pdev;
+    AHCIPCIState *ich9;
+    DriveInfo *hd[6];
+    Chardev *chr;
+    int fw_size;
+
+    if ((machine->ram_size % GiB) ||
+        (machine->ram_size > (4 * GiB))) {
+        error_report("Memory size must be 1GB, 2GB, 3GB, or 4GB");
+        exit(1);
+    }
+
+    if (machine->smp.cpus / machine->smp.cores / machine->smp.threads > 1)=
 {
+        error_report("Invalid -smp x,cores=3Dy,threads=3Dz. The max number=
 of clusters "
+                     "supported is 1");
+        exit(1);
+    }
+
+    dev =3D qdev_new(TYPE_MIPS_BOSTON_AIA);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    s =3D BOSTON(dev);
+    s->mach =3D machine;
+
+    object_initialize_child(OBJECT(machine), "cps", &s->cps, TYPE_RISCV_CP=
S);
+    object_property_set_str(OBJECT(&s->cps), "cpu-type", machine->cpu_type=
,
+                            &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "num-vp", machine->smp.cpus,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "num-hart", machine->smp.thr=
eads,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "num-core", machine->smp.cor=
es,
+                             &error_fatal);
+    object_property_set_uint(OBJECT(&s->cps), "gcr-base", GCR_BASE_ADDR,
+                             &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
+
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
+
+    flash =3D  g_new(MemoryRegion, 1);
+    memory_region_init_rom(flash, NULL, "boston.flash",
+                           boston_memmap[BOSTON_FLASH].size, &error_fatal)=
;
+    memory_region_add_subregion_overlap(sys_mem,
+                                        boston_memmap[BOSTON_FLASH].base,
+                                        flash, 0);
+
+    memory_region_add_subregion_overlap(sys_mem,
+                                        boston_memmap[BOSTON_HIGHDDR].base=
,
+                                        machine->ram, 0);
+
+    ddr_low_alias =3D g_new(MemoryRegion, 1);
+    memory_region_init_alias(ddr_low_alias, NULL, "boston_low.ddr",
+                             machine->ram, 0,
+                             MIN(machine->ram_size, (256 * MiB)));
+    memory_region_add_subregion_overlap(sys_mem, 0, ddr_low_alias, 0);
+
+    pcie2 =3D xilinx_pcie_init(sys_mem, 2,
+                             boston_memmap[BOSTON_PCIE2].base,
+                             boston_memmap[BOSTON_PCIE2].size,
+                             boston_memmap[BOSTON_PCIE2_MMIO].base,
+                             boston_memmap[BOSTON_PCIE2_MMIO].size,
+                             qdev_get_gpio_in(s->cps.aplic, PCIE2_INT));
+
+    platreg =3D g_new(MemoryRegion, 1);
+    memory_region_init_io(platreg, NULL, &boston_platreg_ops, s,
+                          "boston-platregs",
+                          boston_memmap[BOSTON_PLATREG].size);
+    memory_region_add_subregion_overlap(sys_mem,
+                          boston_memmap[BOSTON_PLATREG].base, platreg, 0);
+
+    s->uart =3D serial_mm_init(sys_mem, boston_memmap[BOSTON_UART].base, 2=
,
+                             qdev_get_gpio_in(s->cps.aplic, UART_INT), 100=
00000,
+                             serial_hd(0), DEVICE_NATIVE_ENDIAN);
+
+    lcd =3D g_new(MemoryRegion, 1);
+    memory_region_init_io(lcd, NULL, &boston_lcd_ops, s, "boston-lcd", 0x8=
);
+    memory_region_add_subregion_overlap(sys_mem,
+                                        boston_memmap[BOSTON_LCD].base, lc=
d, 0);
+
+    chr =3D qemu_chr_new("lcd", "vc:320x240", NULL);
+    qemu_chr_fe_init(&s->lcd_display, chr, NULL);
+    qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
+                             boston_lcd_event, NULL, s, NULL, true);
+
+    pdev =3D pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->se=
c_bus,
+                                           PCI_DEVFN(0, 0), TYPE_ICH9_AHCI=
);
+    ich9 =3D ICH9_AHCI(pdev);
+    g_assert(ARRAY_SIZE(hd) =3D=3D ich9->ahci.ports);
+    ide_drive_get(hd, ich9->ahci.ports);
+    ahci_ide_create_devs(&ich9->ahci, hd);
+
+    if (machine->firmware) {
+        fw_size =3D load_image_targphys(machine->firmware,
+                                      0x1fc00000, 4 * MiB);
+        if (fw_size =3D=3D -1) {
+            error_report("unable to load firmware image '%s'",
+                          machine->firmware);
+            exit(1);
+        }
+        if (machine->kernel_filename) {
+                fw_size =3D load_image_targphys(machine->kernel_filename,
+                                              0x80000000, 64 * MiB);
+                if (fw_size =3D=3D -1) {
+                    error_report("unable to load kernel image '%s'",
+                                  machine->kernel_filename);
+                    exit(1);
+                }
+        }
+    } else if (machine->kernel_filename) {
+        fw_size =3D load_image_targphys(machine->kernel_filename,
+                                      0x80000000, 64 * MiB);
+        if (fw_size =3D=3D -1) {
+            error_report("unable to load kernel image '%s'",
+                          machine->kernel_filename);
+            exit(1);
+        }
+
+        gen_firmware(memory_region_get_ram_ptr(flash) + 0x7c00000);
+    } else if (!qtest_enabled()) {
+        error_report("Please provide either a -kernel or -bios argument");
+        exit(1);
+    }
+}
+
+static void boston_mach_class_init(MachineClass *mc)
+{
+    mc->desc =3D "MIPS Boston-aia";
+    mc->init =3D boston_mach_init;
+    mc->block_default_type =3D IF_IDE;
+    mc->default_ram_size =3D 2 * GiB;
+    mc->default_ram_id =3D "boston.ddr";
+    mc->max_cpus =3D MAX_HARTS;
+    mc->default_cpu_type =3D TYPE_RISCV_CPU_MIPS_P8700;
+}
+
+DEFINE_MACHINE("boston-aia", boston_mach_class_init)
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 945ba20612..90cd5acec9 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -16,5 +16,6 @@ riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files(=
'microblaze-v-generic.c
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan=
_kmh.c'))
=20
 riscv_ss.add(when: 'CONFIG_RISCV_CPS', if_true: files('cps.c'))
+riscv_ss.add(when: 'CONFIG_MIPS_BOSTON_AIA', if_true: files('boston-aia.c'=
))
=20
 hw_arch +=3D {'riscv': riscv_ss}
--=20
2.34.1

