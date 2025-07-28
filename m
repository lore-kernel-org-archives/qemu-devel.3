Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41544C87FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 08:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugJfR-0007l6-UD; Mon, 28 Jul 2025 04:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1ugJWC-0000q9-68; Mon, 28 Jul 2025 04:47:42 -0400
Received: from mail-dm6nam11on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2415::62d]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1ugJW8-0004ha-QC; Mon, 28 Jul 2025 04:47:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoREslNHW/gnsbYY86o4RbUb9mrGSnP2ewZ8CiBgozRPhzKu/y4o+h+EcutzeE1DjCYOafSDztiFtaOPctYcLuAhoM3gp+e8E5MwOEdzV59y0bQBXDndWNx/FYsyFmCTi7wHKFnMRO2DpNzvGrS29yQ5/utd2CyHBtqI9iiewDDJtBW5KGL4jQYpuCGp1WPhKFQeIV9jTtECN7QL9U+W0CjvgIf5/1aGX7LIeTZOJPcIBqYuduRCzX1r+Psnx/ivVZphK1AMAuBXlVqxoUXLKydODSDHHVr4Qx0lrOiuntx15NRmPggQucfL3RqW5kkhoSQn/EG0f9mSG7+G9wRJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR1fII+WpvGlryZn74HkNIqreYl4XLqhjXLY0iCDTcg=;
 b=wV8O0zGAKtKOvGP7UvW9RhW3K7SDTdhXxPxKdQh8ZWt9lFT+ztM1X3ig/mlVjc0+oxlNCYQlgUNnuf0Kbfneaveu3PWltvjHZL2oYnt7WxMRhtQ66DPOdco7Yx950x7jP61W4yqkY3MT5Ci4LGoRzT1lExBe9SC2thMobLQLOvVkPwebSjNo0sevVExi+8U6CVJ0I9EUG2AFI1T0qxuEGD2BUJShKjaph1fNSZ6qs6Sdbn6w/5GpmcPRyz2jEJZSzMrO8+64kEGKmwDCNoaSKsLKud33wNbSOtSwu6sMi1MFwV8gNLgJAJ0KaKgoHu22qL9j1Q6+N0xrPy88Gg+f8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR1fII+WpvGlryZn74HkNIqreYl4XLqhjXLY0iCDTcg=;
 b=xOt1zjJpQw96bKnubV9EPxrzZPHG6Lm4h1HaEmfFLUOnHiWMa1UAoWD5o13EJiSNVjyl1PZbqM5xPMWpWbfCtIRLkRODsFbiSgMZbL8KYm9i51r8TLipecYMLRu21JFjz/WzVF/XIqMOs36P5a2JNcTzo5O1QZZMQir53z9DLZU=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 CY8PR12MB7660.namprd12.prod.outlook.com (2603:10b6:930:84::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.25; Mon, 28 Jul 2025 08:47:25 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::4a06:1053:ead5:ef39]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::4a06:1053:ead5:ef39%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 08:47:25 +0000
From: "Boddu, Sai Pavan" <sai.pavan.boddu@amd.com>
To: "Michel, Luc" <Luc.Michel@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
CC: "Michel, Luc" <Luc.Michel@amd.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Iglesias, Francisco"
 <francisco.iglesias@amd.com>, "Iglesias, Edgar" <Edgar.Iglesias@amd.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Alistair
 Francis <alistair@alistair23.me>, "Konrad, Frederic"
 <Frederic.Konrad@amd.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH 01/48] hw/net/cadence_gem: fix register mask initialization
Thread-Topic: [PATCH 01/48] hw/net/cadence_gem: fix register mask
 initialization
Thread-Index: AQHb9jfCZ3IZIZIX80y+qTR51HstIbRHSzGg
Date: Mon, 28 Jul 2025 08:47:25 +0000
Message-ID: <DS7PR12MB5741155C618045403E744B72B65AA@DS7PR12MB5741.namprd12.prod.outlook.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-2-luc.michel@amd.com>
In-Reply-To: <20250716095432.81923-2-luc.michel@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-28T08:44:21.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|CY8PR12MB7660:EE_
x-ms-office365-filtering-correlation-id: 6a44f12c-c569-4ae0-beff-08ddcdb36056
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Z7b0qENjUlD6YkCD7taE6f0oCCr+gZxaimpOIbxsJVfX0rUfh9t4hfBWxS?=
 =?iso-8859-1?Q?l0g6Kre8xg8as+Dao0MMtXI/4cVQJY+6uu1938Yydj12adTA2k7Ihy8/zv?=
 =?iso-8859-1?Q?oQr72BuUFIn9tJeGTczSPHpGswg+bxOrCBohqzNWNda6N2tB5gzShTnXtM?=
 =?iso-8859-1?Q?J610w4M2V9n5cJH3ZDCgKUzMOPHvh3ZTF1XViNJA5FeGg5qr86ATf56wAa?=
 =?iso-8859-1?Q?iifuvMlR/q5O4RCIWfEZwkal0aUk11Pkg3X2wtV+t1iEf52Wmsr95uZf+z?=
 =?iso-8859-1?Q?jZwaaERBt3yW7QSl9P9g9CRaLR6sccsJDVsAgpUdgneNcZIfNJznhqCDri?=
 =?iso-8859-1?Q?dOQCJ43ktZLm6GfXfwsfiyqRtT81LC3SpPUXuSE4IvvSsArEHZcXo7RDWs?=
 =?iso-8859-1?Q?AZf7zlBLqNTDhibjeVeBwkLfWbzYmyLCLBbXJxQ2wPVSTVHbUUsdkwKYZD?=
 =?iso-8859-1?Q?OANdbo3By56mshggtmLlOkCONBjIc4yERRl01TctXl1Ek3ND4vxsNlbRIr?=
 =?iso-8859-1?Q?i3tgWzMq9g80bkt4mfRlCa9KuEhT689vbj9Mj7aTVD54T+LshGfQnoxSD4?=
 =?iso-8859-1?Q?zJsvGLePQUJLrydB2zjGDh3pguSNImTigE3yaXwRInwg7wjwiNccn5X8Ix?=
 =?iso-8859-1?Q?L8UdTPm2vk/l5Lc5KnkSQKoVNoS/aWwzXN5zTCmbLC7PVRO6JSmIaVhUDq?=
 =?iso-8859-1?Q?38ALzgd3AYnjO756CWhzUcWY3q9jCM1EKwfMrnbDQuqvukQwhXKn06if78?=
 =?iso-8859-1?Q?nlIQJZzop6xSUWxewykIB2p90suBuSw+/YOOq8DcVyFPLpRRl0iGbhchrb?=
 =?iso-8859-1?Q?Giisb4fpY10Se5VvFcBacX9INCI8dpqs7WhKpHD7mCgyLT1pUm89gg6/p5?=
 =?iso-8859-1?Q?vLZjoWK6yBFrC5BCVkxw7GkTIpWTioxzmpCGJxsynGXYwLD5h42DKSmA6U?=
 =?iso-8859-1?Q?mOTXgVkaVFsV6BaG59DdxpjSZvVFGXclYR/PxLE3/39HZvNMuCq6D2UMIc?=
 =?iso-8859-1?Q?ooF++J9mKLyL/jVonTfpNdkKrCHOc00llNoPXazVGLTFn3LkzaTuQ0xP0k?=
 =?iso-8859-1?Q?0T9JyaiIscwySAfFJ08OlavnLuyCvbuODmBuB26TA9RqH1LUcoQRXJJQr5?=
 =?iso-8859-1?Q?WqhnITXPmw/Jr83oDz6J6cosahaSoaZeYdOZ9ek/ISQ3jBxzGBRc3zSenZ?=
 =?iso-8859-1?Q?tGfUZ7k3mtXsgbsyAdBKD+uNYM4qRZMyqlOz3PZNHsW4Ti51ReIObUXuMC?=
 =?iso-8859-1?Q?Tob0hcJy+f5nuLtiInTyhQqNBDQC/qSjn41mQe7rnzIubszFSTeuq9kwIY?=
 =?iso-8859-1?Q?eNZ+z9gUSbTzQIM1s4WujpAe7YhJbzD4p9DRIfVvoCdOaJqxJC5nKG80JB?=
 =?iso-8859-1?Q?BosblLUnTOe1BmVcuGUGuQagz54sTTVvaorFVjgkK8vXlkY403/fw81F2c?=
 =?iso-8859-1?Q?Qi7aD7F49XWnSBLPDFh+/M4bPtnvmvMANa7Yj0jUfwvja2Lgc3zHA9b+O4?=
 =?iso-8859-1?Q?MpjMNfo+ZrOIykdRgA7RIcjVxpsOK1fCXvY7F5apEqBQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?t068bTmut7+E20jaN8FQ++zbP+NVRnWTDxjOkDiJgyWuZodPquMvMz+OxW?=
 =?iso-8859-1?Q?yM1zk3owL6aTK7DoknpLvebo+vPXJ0JvAzN90AyBj+rEu5dUZxbF4+JoYn?=
 =?iso-8859-1?Q?rAxOCu0ylxHJFuAGhGYs3gA4U0/nqNTWgAQsFSxevROTpKnMH2AY1a9Pjj?=
 =?iso-8859-1?Q?HE2x7C8i2irBPBvMnGWlyVj2uoBZE6EoDUF6OAA9HGWPoaUDoQ0iA13XaC?=
 =?iso-8859-1?Q?NMOiK7BW/xGzJEzoJBu/1WVXAQAz7kU5wMXNrYLeBIXrTMc6Z0YgqsfvMu?=
 =?iso-8859-1?Q?5vvixddqJS1VNIwO840RNWSV1brdryUY1AdsM3dMC3K38+DCAm7NSF7Lzt?=
 =?iso-8859-1?Q?SWBmnZVsG0KruP8ynEYu7fLgozHR3mIURm0HGUdXJxJPRxHMBhc6SjihKT?=
 =?iso-8859-1?Q?Ak7nt0m1kdmiW0ckABFyKuvlg9bJK+A4SYUUYrsnWH0gB++UXJX/mDju/J?=
 =?iso-8859-1?Q?ZB8mGkLjurpP1u6iSIbgHRBiyhwkqDNEvb5x4YfLXsJppAxvy+8kGNUEmH?=
 =?iso-8859-1?Q?uIVMSIZIzPzN7JS5xHIaJYZ+kyo6ckOJSLPxHKlJPo4AZ/lFkJgCz7C5ZS?=
 =?iso-8859-1?Q?3RTja7QXPYe3GaH+t+AoCg5HlGVpfk/gOkfxd4QvfejzvUm/zgxL9IDTLz?=
 =?iso-8859-1?Q?j+akuqvBW700sW9d/EjYPZ6n+J5MgjYEKsLBWKgNSDpmulZsQmsUHnW48y?=
 =?iso-8859-1?Q?gaQwRqog6SWTBtOaQ4+CZahTm0IJPaDMKOEVFOI8pl6Ynb+ERWPViNCyIK?=
 =?iso-8859-1?Q?ybNdG0GZtJmJPmAxCbGz7JSj96k5/emhB3oiqNkS6N9pkrIDNvg/8f05Kw?=
 =?iso-8859-1?Q?MpUygttAyauVDHAkcaRqejGFCqaWC5Rqh9VAfrVO3FVNQAgGN4lUM/5t4K?=
 =?iso-8859-1?Q?4AXMUzREXsxJ8nsxciAC6uFoEfZxRGsgEFOSc1iWxqGFgYfHZcDaihxVzP?=
 =?iso-8859-1?Q?+sNwSgQbHZoj8PibTjPLrwAgjfu01N5mbHeLJ0tokMOktPHnxrbMdkUHf+?=
 =?iso-8859-1?Q?IBt2xSysL/LaOnxnme/Jly51rg9Y5Z+23kQsRX/lP8wcERZ397QLhPL5tV?=
 =?iso-8859-1?Q?FkqTu5lJIVeJjUWw6MpgWgh/YP3hN/kKPj8FK8VUkBWnJ34iAom9ihfb1b?=
 =?iso-8859-1?Q?md2w9AOXlWSpi+JfqHgh33G3oeYtXltX9DAnWhCPwMiR6J0oVBq0wzxzYC?=
 =?iso-8859-1?Q?Cdys3bDdACk8ESSD4r6WdcPvjS3VJvWD9D0FU+TCMMKO3n95WsA9TZuknk?=
 =?iso-8859-1?Q?UvMo7fyIJKsdAW8KFNKnwK3N6drT+9v2iBGszCc0L2ucDbBSktY/WC9HAw?=
 =?iso-8859-1?Q?YkbpufCThOIWL1I4MkkYK7Atf0o7WLUfsLci43fs6tka8NzXzERRHcTv9r?=
 =?iso-8859-1?Q?T/g+b/kLu+Ubh1QL01RqMgqUnvbnPvs/yEN8Uad/Wa/g/aEsB3iwR/Cd6d?=
 =?iso-8859-1?Q?yFSshNRgl/hjyXhMd6EA0Kjlf47uRHUvJtE65E3WtsplLIgWiaA3zUWqg2?=
 =?iso-8859-1?Q?WzFZZrr+lch+OmGhg6zhKjk/N3t10Mg5O8BcqbltsZREm+AumQROdBUF0+?=
 =?iso-8859-1?Q?r+YywjI7RYecZE3jkmhn7R9rpfagSij8MLxge/07CdLlHR5N2cEstidrUM?=
 =?iso-8859-1?Q?XJmObhZW7vGUI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a44f12c-c569-4ae0-beff-08ddcdb36056
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 08:47:25.5537 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TSzjaQzZAEXpfsFuBFqefM+VZd11kZ+91UP+V0OYExsabJDQxUCTxsGax1Y3DSa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7660
Received-SPF: permerror client-ip=2a01:111:f403:2415::62d;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

[AMD Official Use Only - AMD Internal Distribution Only]

>-----Original Message-----
>From: Luc Michel <luc.michel@amd.com>
>Sent: Wednesday, July 16, 2025 3:24 PM
>To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
>Cc: Michel, Luc <Luc.Michel@amd.com>; Peter Maydell
><peter.maydell@linaro.org>; Iglesias, Francisco <francisco.iglesias@amd.co=
m>;
>Iglesias, Edgar <Edgar.Iglesias@amd.com>; Philippe Mathieu-Daud=E9
><philmd@linaro.org>; Alistair Francis <alistair@alistair23.me>; Konrad, Fr=
ederic
><Frederic.Konrad@amd.com>; Boddu, Sai Pavan <sai.pavan.boddu@amd.com>;
>Jason Wang <jasowang@redhat.com>
>Subject: [PATCH 01/48] hw/net/cadence_gem: fix register mask initializatio=
n
>
>The gem_init_register_masks function was called at init time but it relies=
 on the num-
>priority-queues property. Call it at realize time instead.
>
>Fixes: 4c70e32f05f ("net: cadence_gem: Define access permission for interr=
upt
>registers")
>Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>

>---
> hw/net/cadence_gem.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
>50025d5a6f2..44446666deb 100644
>--- a/hw/net/cadence_gem.c
>+++ b/hw/net/cadence_gem.c
>@@ -1754,10 +1754,11 @@ static void gem_realize(DeviceState *dev, Error **=
errp)
>
>     for (i =3D 0; i < s->num_priority_queues; ++i) {
>         sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
>     }
>
>+    gem_init_register_masks(s);
>     qemu_macaddr_default_if_unset(&s->conf.macaddr);
>
>     s->nic =3D qemu_new_nic(&net_gem_info, &s->conf,
>                           object_get_typename(OBJECT(dev)), dev->id,
>                           &dev->mem_reentrancy_guard, s); @@ -1774,11 +17=
75,10 @@
>static void gem_init(Object *obj)
>     CadenceGEMState *s =3D CADENCE_GEM(obj);
>     DeviceState *dev =3D DEVICE(obj);
>
>     DB_PRINT("\n");
>
>-    gem_init_register_masks(s);
>     memory_region_init_io(&s->iomem, OBJECT(s), &gem_ops, s,
>                           "enet", sizeof(s->regs));
>
>     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);  }
>--
>2.50.0


