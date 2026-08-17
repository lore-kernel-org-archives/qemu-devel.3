Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C023C5DF74
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 21:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww4tj-0005g2-Ej; Mon, 17 Aug 2026 17:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1ww2mk-0006kn-33
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:14:15 -0400
Received: from mail-northcentralusazon11023082.outbound.protection.outlook.com
 ([40.107.201.82] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1ww2mi-000895-5Q
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:14:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHPWah57Nk2qN2VPbrYYVaHRb72gL3AGfWf2g4cCPBYJP6oMfSlHtU8ujR9QzSYn06JctdN//AdAAnl6CCNpYkv6uvC9IqsfEjaP5scWduGD9gAiNWnR+qfREfudGcDy/qk4L7MK/IkiFVXlvRcw/hABWWwcDywN/wi3nm4bhXPLmNjBb0NgdG3E0NQyplJ12d1peuHA9YT2zMOypgt6c5ijBIpRcOySeBZ3ElpUWUg3ilOZEP6mYQku7DYdGbIcYDFZ79Uzrj79lZZlcTuylFD1Ce1jNqMC/1rEEIW7Wu+leLHCJ/eKz7xjvRgaLEANHxUmLSsMHfKztLwbFdOOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f48aiME6lxnfmQW1yUd5gIMP7RlIMUQeMwhaUHveWfI=;
 b=k1pEC9Q2lSkI48+rEP//oDLqHnV9lSTWPtUbKkl/EXhdyu0UU2CSghIyWd0fvaeaA954YjXEOTNx2Z6M8CP4oS9Z6fa609TBXh25ykHMyYM7d02xoZ7hGW/XCjhC389waCRQsfmW+FTZR2UOvzKbUMZODyywVn6LOBpueZ956V72jM7Az9XdGk9q4FBWWqy/ICJ8c0jPEywUI1SnNkwjEJDiasKA6HO0dKVhdyZ0vHPXrS8oEMwZkE80ufF8Bn+zSH1aKKk0qCVteN5OJuhi6yHCQBVduW179WvUyCoKe/lsz2yyZP9jgdjMVYUbFbDDHaTf9xECABzA0n0oF5aIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f48aiME6lxnfmQW1yUd5gIMP7RlIMUQeMwhaUHveWfI=;
 b=TzUz7AOlofeKl22KkShXRHaK9yi4KQayXAs8qCMGg9APdqAYx98dgt3zkwPfPchwTJJSuel4C/jB/Yx3mu+6dW8Rr2oguoAM9c9ieCv8WE+iqmEcRTwNqRnYEUEQ+dnoFE0upAZl2jeYRiCbDZiir4SEyd47W3iE2vZvmZjcrvc=
Received: from LVXPR21MB7009.namprd21.prod.outlook.com (2603:10b6:408:37f::24)
 by LV0PR21MB5822.namprd21.prod.outlook.com (2603:10b6:408:324::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.0; Mon, 17 Aug
 2026 19:09:07 +0000
Received: from LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc]) by LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc%4]) with mapi id 15.21.0315.008; Mon, 17 Aug 2026
 19:09:07 +0000
From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH] hw/arm/ax3000-soc: fix heap overflow from missing class_size
Thread-Topic: [PATCH] hw/arm/ax3000-soc: fix heap overflow from missing
 class_size
Thread-Index: Ad0ueyrHSmUKoAUvQgipvZ2O3HBQrA==
Date: Mon, 17 Aug 2026 19:09:06 +0000
Message-ID: <LVXPR21MB70090B04FF7397B0F2A201C8ADA72@LVXPR21MB7009.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f5bd96c1-da17-4117-80ce-cc9530753556;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-17T18:54:04Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVXPR21MB7009:EE_|LV0PR21MB5822:EE_
x-ms-office365-filtering-correlation-id: 8840ce67-673c-48d9-fdea-08defc9302cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|7146999003|11063799006|56012099006|10067099003|18002099003|38070700021;
x-microsoft-antispam-message-info: NuwIXIOC0Gw+uzGG9PPJdxrH+8jw7JiyqQzAa2R8DOPucuGB9HR+BcyTvzEMSDV2GDHL0up9GwsxaXu/tqha2phKhnsFCX0/6Hu7Xezlh7GExckE0ON5Tj+4eS1awNZrT7ZBKAPV0FWk05cKSCE1ozBmerjYaBtHjS3QW4D09G0YRfgWXLfZPuKwsZ4kNIj4eMTcoAfpxcieW/EvBRfJlvE9IOVM+jpwwXD8gZC3ig63aiToUThYStI0qo1debK+Tqu8qXpk9jMoX6d1BtPcLFBNkZ7bqzWvZSb1RQHVF2i0KBGb2r3HVwOkGkCXgVOeXmQv2C6XpSh2m7dYdWYBm2IN095bSlSIC2hAvmh0qUf8KsrpRxSLWdtn2czES2V1B6NQqTM4m+wKNY4WaFnCbgoSrPwKlMjejd9A17TiIhPv5oJ0LvvaRBnjXK2ffYB1YSXJ/8o/ZrQ+jWT5C3/RD2ZqFWmIkW05hQcdb82Q1qytDKcAS82FaRF/nJqhKYL/RttA0cdPFHiw1LK2VuoN7SDs7KaSvwJbTI8k98lH0kB0ylWKgs3ozp3CAJp4NeE0XEVhgBK1KRTofgBp2x/RJCcnkaCWO8u1Db5RkOGxFF/833hC54erqr+yfe86FWRVeTl48GQy4yw/quSmiK0rX4WfkcIgmaWd357Kf1XfV+3G5MrVAFTdFXWGm3b9tKa6aMM1dvNBgHWvQ2ywIOE3pfCuMYknfKfE3pVDIHZ9brs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVXPR21MB7009.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(7146999003)(11063799006)(56012099006)(10067099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QfDbKb17BVCY+km7GPQf61AmkYD7LvNZXtRxf4F5s4NHBkp9x1HaOOy0svDY?=
 =?us-ascii?Q?Onqxlv8k+0cA91daJM29NoAdsCaQ4v36ywybOtsa0YtUn2YCSvoE1Z4cwhZj?=
 =?us-ascii?Q?HqBj46PenISZgUIK8W956xvSNKTfTPbMotNTwvoNKVL4s2lIDjyjsCjfzOJV?=
 =?us-ascii?Q?van1vlzSS60GLzEE/Ux5H1c5690sfDOO7oBmiIwAg9ja+wWsFf1J0fNcZPKj?=
 =?us-ascii?Q?/n1LE+qxkZSbjka1yRDR/QEAVlpCGmUkQcCi5nO0En05BMkP8GNPychJhOXI?=
 =?us-ascii?Q?gS8tG5XlwXbZF1BSXldWhHKCaXDH1lUJ3WcZdoTIKCHDoqNtXSKZh/BK7UJL?=
 =?us-ascii?Q?h/J2BWN5A8hbyxWRKopRrmLM7lvJsMISyynfR+8lfR48TM/MY51AjrVeF7rd?=
 =?us-ascii?Q?tZrN4Pyh4+YLczyTChyX+qLYQL7yIwUxQwisbgi5hDm0Z9+9/Qx/AcAPzfnF?=
 =?us-ascii?Q?fAAWuG3dVXww7JmCNQH7zeie8bCDjKfSH6W/8weG1Jemb5jkGaViMZgBfTCE?=
 =?us-ascii?Q?ggEWDupI2WjnejSSZ02IDbA7Qul2v3BYThIJU0CV2EAdzHfSmpuRl9YeqCCM?=
 =?us-ascii?Q?URPw5wJWScy/rRSsEHlKiRex9SvcajrcH5Z+QbxCBn0eCDN5qyYS923JfjsH?=
 =?us-ascii?Q?IKQAs7f18k8RYchGaTLlGV+pf6YD2MrrKweocbGIAsIYxV3uK/dhkAvwQkph?=
 =?us-ascii?Q?piMm/4mQ+flHydP86Ns1bvLgqfR6ahDL57I5CYn6GCumNbcFTnFeGUt9sMAR?=
 =?us-ascii?Q?PM79tb/btv/KmtJiGUqvB5cnA/0OJOX8+gj7VYKROeIGqYoz9oLAN9RvB4lH?=
 =?us-ascii?Q?m/cjeHY8qDkPAo9nSXBLBf5WkDqS3K0CnY+bB2zRNxmshBXuJTpjYfCpT3Mx?=
 =?us-ascii?Q?/KAaFruFn/7G4QBLUPX0WUYKbrXCaDeVjBEf848lXYuDmqrhLfTVijWt+SLa?=
 =?us-ascii?Q?gTc0KTq8vLFVTqdx7GKNS8HOPnQHSO1QmdJQuAa5Qeq1FxybzJXTyo9BtWTI?=
 =?us-ascii?Q?Y8kT0qZ+lDaBZEWcn7Tqw5WT+nVXeEAjcdKQy3XoCt0DZzyqEFzAO/v+OP2e?=
 =?us-ascii?Q?pI1esESdQzA23+6n47ZVI1+FcwFUl0UiNjwwAD8qm9lbx2FE5K2v2XSKeDPI?=
 =?us-ascii?Q?YPFGxNNeJX09H8JSaO/R3sCJothe1Q+LM4lxT7XcIejlpmmPKkNQ4vgKsj6L?=
 =?us-ascii?Q?hsBMlcFyVrmQZ1zQPVEFBdkVYstoudfH69sTD++36quYjLwGWg4ZMHHcak/L?=
 =?us-ascii?Q?PrpKqL6m1gFeetwWDhZcGhy3XyjiN/JARi/hRYm7GCUYPMemdg1Mquzg2L+3?=
 =?us-ascii?Q?IdN5VmDMYwKLsJR9X/Sq4RgX21oHHllLf3u6Cl9VaV4lMdQB7W/Y7TGa66po?=
 =?us-ascii?Q?vP+hO9MCHYgG5MH1GJ0g+ZDJnmYkSP4y+Yxp42rIAVKWzldBdbxhPDVi+Rot?=
 =?us-ascii?Q?fApEf55sxBDvzBv0sWRbApsMD+T/HhAiVq46rcoafR1xlPBUjySbFlDKPmux?=
 =?us-ascii?Q?APXiAm77EtOYQ1VrFhjIOT1exnV9rkoG8xoJo1VgtbEtmi2ORLcH02vG6CYI?=
 =?us-ascii?Q?O8OxLUVzec9Xw1roU3rZ8/tUYK/d8V4DhQ46+K1Tw1Pl04zFmuIPWmUUjx9U?=
 =?us-ascii?Q?IPer602R6FNqGNzPZLNzZMZbNuQ6/iYqBvBug9e1VuOQ1F8p1Stb2kX704lA?=
 =?us-ascii?Q?ZHsiyQecQBaBo6c0TcDwo8st4KH5jfx6S7vLjTAsI41u0oAo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVXPR21MB7009.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8840ce67-673c-48d9-fdea-08defc9302cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 19:09:07.0246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcR7HHb7kiv9HZlR21+JuAuGWqzbTq4RJ4Dwj94EGDu1BT6Tv8tNT9rWEd8QncKpAb1ugHxVwB3zUSR8wzNL6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR21MB5822
Received-SPF: pass client-ip=40.107.201.82; envelope-from=dcook@microsoft.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Aug 2026 17:29:34 -0400
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

TYPE_AX3000_SOC declares an Ax3000SoCClass via OBJECT_DECLARE_TYPE() and
ax3000_class_init() writes to it:

    Ax3000SoCClass *sc =3D AX3000_SOC_CLASS(oc);
    sc->num_cpus =3D AX3000_NUM_CPUS;

but its TypeInfo omits .class_size, so type_initialize() only allocates
class_size inherited from the parent, i.e. sizeof(SysBusDeviceClass).
The store to sc->num_cpus therefore writes 4 bytes of the value 4 just
past the end of the class allocation, corrupting whatever heap block
follows it.

Fix by setting class_size.

Fixes: 33a71a68c6e1 ("hw/arm: Add Axiado SoC AX3000")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4197
Signed-off-by: Doug Cook <dcook@microsoft.com>
---
 hw/arm/ax3000-soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index 71e31c6fb4..ebe174fb97 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -236,6 +236,7 @@ static const TypeInfo axiado_soc_types[] =3D {
         .instance_size  =3D sizeof(Ax3000SoCState),
         .instance_init  =3D ax3000_init,
         .class_init     =3D ax3000_class_init,
+        .class_size     =3D sizeof(Ax3000SoCClass),
     }
 };
=20
--=20
2.55.0.vfs.0.3


