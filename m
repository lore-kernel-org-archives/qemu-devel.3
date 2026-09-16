Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16774C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 22:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6xgY-00083N-Pf; Wed, 16 Sep 2026 18:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1x6xgO-000834-JV
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:00:51 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1x6xgN-0003Sf-0d
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 18:00:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0jKZJACht7DAlEuSBTlbvA/rqD/P7mXynxt7DrAhLZlALcNr2VP9zdpeguRmE9Z0wf5PEeo6QIK8qqLNOXL788BygVFITjz7BDJD9sIMOZmeYNdrRNoTYyb2dgmumRHfYRiFaoSEaJcaD9IMGe97jhCGUpe5CMzFsusILMPEg6N8Cy1Y7snal7dyqdplC7ZhB8W/XNbqb1sJRBJQIL5KY/r9tL6goSmXUMyRHdwrq5QiNKIOjDWp4pKSyjUEmg38cPmQNJ2hlW7hfrTo90AyU5CH7cjzIE5tDhH5DxWrbHnehMPRC2hAiiO9atSXWLrK5DbwaSNB567us6QgUhpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmehvTvc5vnrttoIklhUE6Z4quA6ps2a+odHXDAORkk=;
 b=YKEu6Nq7WZI1ha7/RqUeg47+4C4gHF4CNNPIFzchz5VW1EwRaCu7HsopMrkTPa0PMSdz8loqUlzCLs9CPQSWux0Ny8AMDEfGHUfyOiIQG/W51Hp+5/UnoyhZd/65LGqNBq8MoGYMkw/AZjuJ3ENleRz5IYw+hLsKrEWx0Mw7fivEUMS0MqVZfOO8RuDWAexqZcWDIXPzjbIVW81ZSddnDvAUh5wWJaTEGWBtIKvMFFxqDoY3oHeDhbIdM6q8vPgSqPTTfOQRGeGLI7UUXyxmP1Dv/HOF/CTUtVJt/ASkMWBHfaQY+MHj0nEin300PUI5cPquNK+ov57HAz3LoFyf7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmehvTvc5vnrttoIklhUE6Z4quA6ps2a+odHXDAORkk=;
 b=IhU+tBtkcklFiFBfYwBgEEg+ZDL76RH8OFe7eQVF82LE1D6zUbFEqPIfrv8FbL6weu8NmQTT6WU3mCzcfLRQ7TD7W3CgklriMo0YZZaADjBVT8w4YSM+6Y9WL0/HPwklNdsOiIbFyLEUslMDtnbEkCVnFC7EVbK195EEun7kvUQ=
Received: from LVXPR21MB7009.namprd21.prod.outlook.com (2603:10b6:408:37f::24)
 by LV4PR21MB6079.namprd21.prod.outlook.com (2603:10b6:408:357::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.4; Wed, 16 Sep
 2026 21:49:38 +0000
Received: from LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc]) by LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc%4]) with mapi id 15.21.0451.003; Wed, 16 Sep 2026
 21:49:38 +0000
From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>,
 "mohamed@unpredictable.fr" <mohamed@unpredictable.fr>
Subject: [PATCH] target/arm/whpx: fix uninitialized PhysicalAddressWidth
Thread-Topic: [PATCH] target/arm/whpx: fix uninitialized PhysicalAddressWidth
Thread-Index: Ad1GJO+7qYxXzYiCTnSuEdCbzbCL6w==
Date: Wed, 16 Sep 2026 21:49:38 +0000
Message-ID: <LVXPR21MB7009F3FB78275620435BEEC6ADB92@LVXPR21MB7009.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cd841ea2-8d9f-4777-bbe4-a5a4c3c1d0a1;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-09-16T21:47:14Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVXPR21MB7009:EE_|LV4PR21MB6079:EE_
x-ms-office365-filtering-correlation-id: c9382abc-6fc7-4fca-0c1f-08df143c6825
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|6133799003|18002099003|38070700021|7146999003|10067099003|11063799006;
x-microsoft-antispam-message-info: BK5KWj4IOlJAnpmpqVuCQn9axvW0lxtlXEhGjEZBKPo6TJx6v/o2MTVjDDW8d3wKMVb4coJQgshHgq4Op3e0hrs5ucl6ioM1bCQL911I4umAzQAlBrfccY2YpYs21bJ9yiVVAW030jytfOLHoZRnpZIXqukxt7stkOFbnRW9B9DqkY1W0d6g+Q00mQpg6H03t+ZSTW8ovv8vBbRNjQ07KV49lOHfbj1Xm4CPtUWXspyrnx9dMpHDElCbrYArPbbHO0TjIkLJTTKxLaw4XnmYZ5eXNrlqdtIVmYjx1c7PamiJFxcL+RxCWWRlXtUVrhtGeBpFKuwtlOM+jLouuKJ8hIHYfQwl2Z+M/nz5SiJTXtuiKqzrHvtYCXIXd/ES0ZES8zohxTMgfKEVaYIy+AUjWjyhCYAQ8V4nDQGA7Qfvc8QiyNuUpjDK4MIy3dQp9oKiwUPVVIdcdk3WAMbEkbb1QIiI6uEaGrF82qCOWLwawpfGDzOtjobqrhne2UldAD+QkvogmfkmOBGf55qg6+V2sguUTMp2H+Oe87T7RqQNxgzNj8CdyAeZgMabFU7j6VjqqchvSt68G2eXqA38g4nsg+aP6U07TfcsBiwml+xcNbY+cu/ICJYa1ceI+l51QGAzWHXoAsO0BC6s3xPp4kFa9WRldLOUymRhyst+z3Ag5p1MGwMzCLQGFcfOY9KF5C2J4F3LuPlpTlqsVahAt1x4WAeb7FPQg5v67KhN27qKU+k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVXPR21MB7009.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(6133799003)(18002099003)(38070700021)(7146999003)(10067099003)(11063799006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mJTG6Ro2GaKVXtK3h/cY0agqAkTPxhCiXJMd9Xs2lKCJG4aeVSPwxl/ejHVM?=
 =?us-ascii?Q?L9K5CNcyGdQjGQbfdoOy/H4SbYkGii/QmWzVAH0hJwbkHzN7zq64zRGo5Ssx?=
 =?us-ascii?Q?slAkJeO5Vg+E+VyGgMfM4JIJh+MkFQrdaAGco6ju/iiAfi/Y1WwSjdNMMSzt?=
 =?us-ascii?Q?8ueUVTQXcKSC3CrJ8hlPmxXsbkzakjlTJ4XQr76JxEZuxpOTa9r/ff75bVqZ?=
 =?us-ascii?Q?JgNUeRHtVCH/vqdvDnVZmZESERgD0ONyshXFCq+2ZbU3SIK/GbZOd8ljDLpS?=
 =?us-ascii?Q?t1C/L4aaM6QHkc7dxp3eMztij9BoUnvOUYYCKkQTpk8o2shuSw/IJrU1ofa0?=
 =?us-ascii?Q?n4ruzZk62FYNAKixEAnkCc6N5Fq39wsoQgcsGkJtwyZf7JI0hG8Q2eQfi4GD?=
 =?us-ascii?Q?VSOsIeUnVwSQIFrpWOAYxYdyVn2sKCcFF1liBS5n+QCDq6f1VQYbbvFYewzX?=
 =?us-ascii?Q?ondmG270yS8Ysg0+Z8dS+bSTBhkZVyPB/LpiINgW9gOeSa9qjQ0FMd9XD5S+?=
 =?us-ascii?Q?dbjyjMQp2wNYDa1xy7a2iDuyepWMiN1rXdOUWkC2QqV8hK8NLdd/6CHHGGpN?=
 =?us-ascii?Q?CHQuwBhDHUr5YJMIqGThx2NW+9uzm/ZjIDcDdMwIGWq/rDdE0ejICLTxsIW0?=
 =?us-ascii?Q?vRkCVJDSl4qLAF/pPvN+5U9/O6iIyO/c4OdyzXY24+alngyU987uA2uCCNUe?=
 =?us-ascii?Q?Z/1kyFeFWuvAA/w5+5fw87h2YAC+xjuaZmZNk14MQakAOQ8gJvlHFsvLuTEW?=
 =?us-ascii?Q?kWFpQsInk1eutRN+0x/OSjQVDlUVxOzL0yBlZtPx7jyrrg3GSUePUCkRoQN6?=
 =?us-ascii?Q?euF3Jh8PCIAy3sDHsQNuo3PIHgX2Dk7RRFPn1jmhU9lJh5sd/SXFlL2A5JFW?=
 =?us-ascii?Q?BS54iYU4zqXm1xXNhuXz3ddiB7fQlU2YBbU21NrSuwxv7Iot99ly2r42AAWB?=
 =?us-ascii?Q?dhm6SQhsk02sbOxezS5h5+L8MIMYDXpFtof9IE9bygezK+tu53Tiq8FxaBAR?=
 =?us-ascii?Q?CIH19GxsgRd0DvQ9+D3lPG18IBI9Sxv5qjYB0evNS7VogT6DAQgPczuDy30Y?=
 =?us-ascii?Q?z8hOBZ6rhFgyqtsNgI8CboDbXKMMaKUk+mQh1gL2HxTjQWIS9JcsJvIVn+op?=
 =?us-ascii?Q?c2+9XppotTqjYUnJdZ/D/61P6kJZFQnYK6uEUz26FklNjw/VynXsGecvBYTV?=
 =?us-ascii?Q?DsLzhBGvlHj6LS3E/rLSSqMnqLfRFyKxY5Z8byuQc9Baod1hjnaWYddXM0uR?=
 =?us-ascii?Q?16PbRxlSi4g6rgW5QXh3025lEx1fSWilU7cux0zpEAX54iB/W+rJyzMPgdZw?=
 =?us-ascii?Q?o0Hxp1eaGmDtYF0unpNiibF3CzM3lz+bXxOwMPzJS2YnmytCUU85x8taTqg+?=
 =?us-ascii?Q?7P9hcHL4kTvc03AOjlrjQ/Zs/+lfX3KYDVJWknGyinFjSE23NLgyrpU23h7T?=
 =?us-ascii?Q?LZVi5emptjSF5SP6WkqwBjyHOQhcH6PTWr1dMyXTtTh2LJ5FkTdUFJ7Z1j7V?=
 =?us-ascii?Q?wPTUfIYwzv9OQVlUAbGo2dVC3kHL+XZm9OUWI/ms1FNHf5+0/fjqAAv4mwPs?=
 =?us-ascii?Q?6nlXGVpveBs+EXHQHANoXEFxqRuNJXy0REcCzxxVUeLgyqVmFIbxGmhv9gjG?=
 =?us-ascii?Q?NUm1eeGzHEIVmqEfuZquPCxXPl1K+fj2obn+g//ZjyK+XPk1kLC9+fYWsZd8?=
 =?us-ascii?Q?HhosmdcMoCkELXhmsxd3VSuv0NMOcGrk7FYh0y+2LoEE4fBv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVXPR21MB7009.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9382abc-6fc7-4fca-0c1f-08df143c6825
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 21:49:38.7588 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5niGE5aerkWhasRLe+6gv+2DNVakFrQfT6qqKUkr5f2a+swL6OJ2kQjf5sV3Em5C5dB/6HHXKPYSNihIRO5FYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR21MB6079
Received-SPF: pass client-ip=2a01:111:f403:c10d::3;
 envelope-from=dcook@microsoft.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

whpx_arm_get_ipa_bit_size() declares WHV_CAPABILITY whpx_cap on the
stack and initializes it only via WHvGetCapability(). If that fails, the
error is reported but execution falls through to
round_down_to_parange_bit_size(whpx_cap.PhysicalAddressWidth), reading
an uninitialized value.

round_down_to_parange_index() searches pamax_map[] for the largest entry
that is <=3D the requested size and ends in g_assert_not_reached(). The
smallest valid PARange is 32, so any smaller value aborts QEMU.

Fix by setting PhysicalAddressWidth to 32, the smallest
architecturally valid PARange. Behaviour then becomes defined, and
where the guest memory map fits within that range initialization
continues on to the accelerator capability checks and their more
specific error messages.

Fixes: ea475a5ebb00 ("whpx: arm64: clamp down IPA size")

Signed-off-by: Doug Cook <dcook@microsoft.com>
---
 target/arm/whpx/whpx-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index d106400686..dc70b33bc0 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -663,6 +663,7 @@ uint32_t whpx_arm_get_ipa_bit_size(void)
     if (FAILED(hr)) {
         error_report("WHPX: failed to get supported "
              "physical address width, hr=3D%08lx", hr);
+        whpx_cap.PhysicalAddressWidth =3D 32;
     }
=20
     /*
--=20
2.55.0.vfs.0.8

