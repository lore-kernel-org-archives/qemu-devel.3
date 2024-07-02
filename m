Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B15C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWWm-0007NX-0W; Tue, 02 Jul 2024 01:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWWj-0007N3-Rt
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:58:05 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWWg-0007ce-GK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899883; x=1751435883;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=sFQfUUO+jwqiV0ysf6bkRHP4q9RHybqeXKfOtzAyQ38=;
 b=tIP70bboGh9MyfqLqS8sRxC8ndeM7EkAT1xqOIYkz5moQSRGW9ezmAUh
 X4iZiGOkxukHf8Dok8a9z49XA8UK2R2xWZ2voa1icSR5/xs6gLL85GwTi
 qJsrqrNYP3SmFsVg+VOxYHtcJXA7eOd9Li9OwALefJfhVF9qTWy5Hdkj6
 iW/bE7F3RT/EUOe3WZ/DU/xOVXsZTl47hwlYOPzeJs+BWmWXx7hfi6Tfb
 zUqbml3IzMtL+Bk2z1Z/azBD99HQm9h5pHY6ffnpi/sWAReoJf4DMqY3B
 h4UqoAbWzkuHMpI2kJZLRgGk45I3iJN4/1r38X/92hTwBuk/lfmI6yYUR w==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208,217";a="15813546"
X-MGA-submission: =?us-ascii?q?MDF4/Hm7Dibf53g3+G5+ZYNwC4m4PGp9oggKcA?=
 =?us-ascii?q?rbD+an0HjNoM18EKRKEW5QKw8kOTx1gM9j61B0VZzpgE8csHrF24CS0p?=
 =?us-ascii?q?PVpcpDYTzwBKHW4k3h3BNv5YJsAhBTgBxoGJ+SyNAMvNaiTkf6pcw4Tw?=
 =?us-ascii?q?L6jigghepWPgN7vQ6825qrQg=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:58:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAZ60GMf0G5xiXSOgdhklapmQyxWJGz47NdlCu7DqSXZ9JzdOr0KYs0z+npX83WPjZexy5H8jsGtjARdSoGDIJWOhvwEPLDwXmUqYLvwPYG0/BkrN9CHv7yk92qNfuKhtmLc7v65sarFOBNRecj6Q2i/4S0+KrZeTlExJkzh0F6JuZA5WZ+NFs9pkZMSGocdkrujN4Xd3CE4DHO+/V/4uWfdikBKUpCWvbWjcUYAQS1/Id4dhbWLuuVpy9RRlV2Kkeh9pJMF9oMfIn5u5cO371K+uEgmh1bH9R7Q3ALYRHC35GrKQQUmnKT55b9SFcS+w59dEX74+FLoS81rIQnYTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeqUTbnhbgdx1h+9fum8Fde3ldscxfev6xAxmDpRNVg=;
 b=ggltpbKkUSq9/HuTUP9ViR5rzTiNUjfuaOWzjV512KAqGE5uR6BQftfrjLeaLI02p+FoKtnR797uBtgpLQ4+X3VHKYkkTvwA9hdCJpNF2BaIJDGO86etzmIs3cHH9vhxN1Vkvod0aL+/RUffvWd4m5hjolVnE7zQV9jyYS5zw4LzbePAnRYZmCjQjYrYa4IMRMWLrK5GkOwISBQmzxSjRi8bwps8Sif+43ln2D5SpmmEUqiZIvrfr4mO8/qvfvubfyXnz/N9uF7R0zAFecm/MFsYUxUA+PidxZWJcCxPeJ/N3s+Wht1CHrQZPi7mlcDCLORNz3RXNQbqR5lGADGJVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeqUTbnhbgdx1h+9fum8Fde3ldscxfev6xAxmDpRNVg=;
 b=Mi3Pw+Vt7bAjdLCVMwgJkLgfQ+xbMKwz7SEzEwodUoDJ/SwMEEOqquG9gi/n66+a/gDQF2MzTFpG+BKs3s9vpI1g/tVIpG3E3R0TS7Xdq3P5oYU8NQBrzkq6NDdS2b03KIph2qvKZhqW3y/M3N8dKlWT9SzI06+7JL5RAb7Hvw0ISfpBz5KM79/J1thEBDcUj54EzchVh2YgeD3KbBRv/gIwVdvkGQqhnJyMKQoaKpl0MwU/Wu3dQF2UhklJLSUZsUNLAfo0gN7Fsf5ViWdZTbuODodorq7+soRftbD+70Bd116lwevP5F32TvQtiDhKSoklgYqCe6eY8Wrxy90lOA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM7PR07MB6978.eurprd07.prod.outlook.com (2603:10a6:20b:1bf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 05:57:57 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:57:57 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH ats_vtd v5 00/22] ATS support for VT-d
Thread-Topic: [PATCH ats_vtd v5 00/22] ATS support for VT-d
Thread-Index: AQHatXs42Vo/2A63BES9fBhuPzCosbHieF0AgACk6Vk=
Date: Tue, 2 Jul 2024 05:57:57 +0000
Message-ID: <AM8PR07MB76020A044539A40485F91F0A86DC2@AM8PR07MB7602.eurprd07.prod.outlook.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
 <20240701160122-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240701160122-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2024-07-02T05:57:57.610Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=0;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM7PR07MB6978:EE_
x-ms-office365-filtering-correlation-id: 76ef7676-f17e-411d-4710-08dc9a5bec60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?K3ZnB1A2LHrJi6CbdC1jxBIEVshi3K36PSEqy4E68girq/Zsyqa72GhGBU?=
 =?iso-8859-1?Q?48OdsoGPswIcFxqc8WlookT0ymeMYZcV4ka9o/FxrL9OUQ5a3kRFvrR3Pz?=
 =?iso-8859-1?Q?EmigY1csDQ5KI7x71Fu7GGV3xTP4X28PtLww+WTIrfEjEEiE7gvqT7fEJi?=
 =?iso-8859-1?Q?qpBbvMRqycOegRDlDOxSvus/vdsUZlAEcU3TetUpoJwhWY40Ygmt4uURm3?=
 =?iso-8859-1?Q?iRY25loHm9rVyX42W1NFcwghkUi/TcMftZi3Cyi/EvEoJruH6wBPtm/NZx?=
 =?iso-8859-1?Q?n16DqU8her0lEkzYG0PURg/6Mu94XOZ6fRo06XR4EyOZY7exLuVQ9BmouT?=
 =?iso-8859-1?Q?IYS6gbskmIgcBvOTjHnCCQJXU96LFrgh3xGfXcaAilOoli59zUVk2aryJp?=
 =?iso-8859-1?Q?PsV97fKWgpKBlPfBQAgn0uXz9XDC1bttv6thVVfh2HjzuO2q7Mr+o9OWVB?=
 =?iso-8859-1?Q?/dEEfiQCg7R3OXZo7zIsVOwmtXqLdE3fYoHNWxigeDBxUa3+Q1DbNxiPk+?=
 =?iso-8859-1?Q?vM/rtEoCA1L+Ruo/BsB14+xeJerXlw1Hpz/Khi0gwfhxYx52jNfspgSqLm?=
 =?iso-8859-1?Q?qglA+3FrJa7gNnlMeTWU64/dmMb4stKUrUDjRh5JySkfrt+FXuuLsWAMC1?=
 =?iso-8859-1?Q?TiWgW+n0rlpOaQzVA2moa46nSNw8xQtuo7Vst33u+wgCPA9etdO8R7mjTi?=
 =?iso-8859-1?Q?T4Dfz9ZO7+MdMpsyxPOV7Rt+QEOycfdTt73ZeAoiM4j5NMLhXToDCLhCsI?=
 =?iso-8859-1?Q?bqYr4gLWTmwVfNSVPuUPUaqHWRukZF0fsiKAQYB6QRd+ylp4/fU2JgBJ6K?=
 =?iso-8859-1?Q?nLIZXob2zXF83r0Iy77LakxzH285+JqPeUt3soTpXZjNnhwtsTdG/aEOc2?=
 =?iso-8859-1?Q?OVDl3+2WSU/PEdZE+PJlSziy1GuGDWHDUX4/Sp//fQY4OmdJc/Q6QbZBme?=
 =?iso-8859-1?Q?fmTBvRs6822gYTy8av727iaZrbZmbmOD0XAEdiyAIqfhQVRNTWLsKjGI1W?=
 =?iso-8859-1?Q?65gB4V/FVid9pitKwgP3eHPwYhoE7tTeAibWKbuZPTcA8HNZuNFWEbRXzw?=
 =?iso-8859-1?Q?WFJN/9Dh1WagX/kJFf1dDn/O9xim6T6hjDTlqhq268+6o3IcrOj2YrHqz9?=
 =?iso-8859-1?Q?qr6teIaBfGZpGNFeVn3qgofC2SAbkWEGTTBaNREzl9tdnjVbshrelfn966?=
 =?iso-8859-1?Q?Xq5aLFHdeP/A/lBXpqTAgeeXnRbRvhrFLeFRp1+gVbl+XSI4Dkfv0cohEY?=
 =?iso-8859-1?Q?qlmyyUiZBVuxkmuXbRlJ19J1fMG0nBVp3FhsLL5gjLcPVhqJlnCvGZMHHN?=
 =?iso-8859-1?Q?diPAtIOKpjRpzM0HWUVQ42K9dF6tn0LXU5XfyA0HQcB2n3IkgIY90j8hzZ?=
 =?iso-8859-1?Q?GxxNKsXw19EuCA/VtwFuIXlCtG6VgQRSqiZ2fqcUPNHGr7MlTG/8E=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?J5K8Y/f5QKEFfWeyZflD8j2daVRzZjeo9njbaQX+K2pjFzPnOwP4Ewy9n+?=
 =?iso-8859-1?Q?FkMViMvNpnc3SsigQz2UkBETIetppqOVde8DHDh4XZgVHBBLUSNu0hxxtV?=
 =?iso-8859-1?Q?j/NLpE0bIAdQmBgti8pgjKQHAvAZHVE9tcPzCDBCA6PnATz9BuaVG1+y4j?=
 =?iso-8859-1?Q?WIhf5XaVTqX6HomYU9DG60gIj47XJswoLpVR5sZxmq/ocgWXZAYr9X/mJv?=
 =?iso-8859-1?Q?u11yJPvmYIluUvl0pb1WvMFA2FJPul11v9y8hxrd9N9+WCWfsHuC5ui5VQ?=
 =?iso-8859-1?Q?uiFAORUTGhYZNFFCCfZhM1taX2Is7YpsHWAAPNO2igHxclnyrfauVoxHgg?=
 =?iso-8859-1?Q?v1GWPuSFXa4E5pm8eV7Z5aAtMF2hXO7SjOzQKxG76zeQBP1m3ItUYZPzgN?=
 =?iso-8859-1?Q?wDNpIak4LPCpl+SjVQDEvnOd/UIWIK0lLrEHUKbR8ehpAEIMqw2HKwfuC3?=
 =?iso-8859-1?Q?XLwfNNnJBjumEKO1XSi1Z3BPUHjA3rB+FGBnZf8fGhFbcgnSx2vh/kqiZt?=
 =?iso-8859-1?Q?ND3mIW+vr0EMjRZKVUwuEgOcu2pmBvAnQtewN2nEoIu9cgMD7ftadvmCm1?=
 =?iso-8859-1?Q?KDthyub8qKB+F2bNf2nI0ksAFTrJoCYzJtI6AnQtcjMsoGbw7uhyS8kG72?=
 =?iso-8859-1?Q?JnD7yTU/wbOoXfTByGo0QqV0qsQJyH4b5rVLAr2Gf8RKzvRIpfEiUs73K/?=
 =?iso-8859-1?Q?q2JUx6vymLTGT4GCPm+cPZ/wMHuXS78d1ajQaxkFf820q5Ox+nXLpPYBHT?=
 =?iso-8859-1?Q?qL61KgEVGOqeRiiejdE+CU1666Zp6UKzx81Qu4pZ3sBUPAzmZGOBd8sud6?=
 =?iso-8859-1?Q?gQuD8Q+O9uZdVQWzmhNETpaCHihr8OHydUizSPpiRlkZnmZjRU5wcdMn/w?=
 =?iso-8859-1?Q?mB/KKG7JCOw+047dMvun0J9l0V1/soK06GVgYMgUtm5jGgELFr6nL06Nw3?=
 =?iso-8859-1?Q?goPCd+HGBUwtX0GqQxiVGfBzICcQKCbepyaUMQo/kkWVU4uv296wJjaMk1?=
 =?iso-8859-1?Q?y/oTETXQCTEWHf6hEn9mDYDCxiKIu0c1FxKiED2w9vivKnACNu4b3TQ1zA?=
 =?iso-8859-1?Q?EqMCS59OavpgDu2r6+0vqaa88MsxKjaIocoQuhfq2YF55esTvzviFcUPlW?=
 =?iso-8859-1?Q?RcbMPen3N2yw2RgtU6YUdgDv9xqStVX1/Evnl3jTjiwHPXhpjt7mOH+3qk?=
 =?iso-8859-1?Q?GoaRYFB8JwVnRBxP6H8O78xWEN0bp38ukuSdSS3MmfNguS5afHLeXHz3fp?=
 =?iso-8859-1?Q?8qKk2zHLgluFPQuoEGTjcqgHyddFcIFJYt+XTmK0zaQ4px/2VpbGqaEAZN?=
 =?iso-8859-1?Q?BNoipnrBUqSBRFU4UWgWaJLmA0/0E1SHRC54K0eB+G0efVTijNppJ7kBpc?=
 =?iso-8859-1?Q?TaGXSKDOKp8QYHISIk+ffrZW7Ei+SmLYI3OnMHhYifreATNzKYI9tONPFr?=
 =?iso-8859-1?Q?g7KlZOONjh24JjMbT6at9EKAcTkNaitmC4v2wbmYWS+hEc+LwfeTVZfV9R?=
 =?iso-8859-1?Q?ZLdMIvLEz3M+7XE+9n0TQvPFzrangqPnj7WOjn1lCayHFhBCaZo5ZJj6Sy?=
 =?iso-8859-1?Q?4EloCHM9GWIUTnzG1ApZLDyPlvICDejldLfWdDT8if0aut5IvDFTiS9CZQ?=
 =?iso-8859-1?Q?8J3od9eHGkGxVT/3uObfCLQ74yVTiYeJEDdcwJlMj2VoOsrrDvPbQNEoB1?=
 =?iso-8859-1?Q?GTJiyTdibGcKA7KxNP0mKV2Z+rS0k/BLNvH+ZYBZb1HhUbHh7VsXjR0Z+X?=
 =?iso-8859-1?Q?n5rA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_AM8PR07MB76020A044539A40485F91F0A86DC2AM8PR07MB7602eurp_"
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ef7676-f17e-411d-4710-08dc9a5bec60
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:57:57.7680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6IoxGagV6dJbqu+VmvVQ89XeRimaQ6Urq/JXs18eBI06k1hy6fTqjqycyb+hxC2U8OOPtjqjIxOGQjxNC3kuzjsUxdBOKbXppPEQVLhaeN89Ap4I03sZSQIrTk3MrNx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6978
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 HTTPS_HTTP_MISMATCH=0.1, SPF_HELO_PASS=-0.001,
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

--_000_AM8PR07MB76020A044539A40485F91F0A86DC2AM8PR07MB7602eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



________________________________
From: Michael S. Tsirkin <mst@redhat.com>
Sent: 01 July 2024 22:02
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; jasowang@redhat.com <jas=
owang@redhat.com>; zhenzhong.duan@intel.com <zhenzhong.duan@intel.com>; kev=
in.tian@intel.com <kevin.tian@intel.com>; yi.l.liu@intel.com <yi.l.liu@inte=
l.com>; joao.m.martins@oracle.com <joao.m.martins@oracle.com>; peterx@redha=
t.com <peterx@redhat.com>
Subject: Re: [PATCH ats_vtd v5 00/22] ATS support for VT-d

Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


On Mon, Jun 03, 2024 at 05:59:38AM +0000, CLEMENT MATHIEU--DRIF wrote:
> From: Cl=E9ment Mathieu--Drif <clement.mathieu--drif@eviden.com>
>
> This series belongs to a list of series that add SVM support for VT-d.
>
> As a starting point, we use the series called 'intel_iommu: Enable stage-=
1 translation' (rfc2) by Zhenzhong Duan and Yi Liu.
>
> Here we focus on the implementation of ATS support in the IOMMU and on a =
PCI-level
> API for ATS to be used by virtual devices.
>
> This work is based on the VT-d specification version 4.1 (March 2023).
> Here is a link to a GitHub repository where you can find the following el=
ements :
>     - Qemu with all the patches for SVM
>         - ATS
>         - PRI
>         - Device IOTLB invalidations
>         - Requests with already translated addresses
>     - A demo device
>     - A simple driver for the demo device
>     - A userspace program (for testing and demonstration purposes)
>
> https://eur06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.com%2FBullSequana%2FQemu-in-guest-SVM-demo&data=3D05%7C02%7Cclement.mathi=
eu--drif%40eviden.com%7Cf5759aefcc5f4e7d4e6c08dc9a08d29a%7C7d1c77852d8a437d=
b8421ed5d8fbe00a%7C0%7C0%7C638554609882544195%7CUnknown%7CTWFpbGZsb3d8eyJWI=
joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&=
sdata=3D2Gza1VD7hKr1Sx3fOLoRh6tk3taSPKTn5nfimhPLz70%3D&reserved=3D0<https:/=
/github.com/BullSequana/Qemu-in-guest-SVM-demo>

I will merge, but could you please resend this using git format-patch
for formatting?  The patches have trailing CRs and don't show which sha1
they are for, which makes re-applying them after each change painful.



Hi Michael,
I sent the series again without the trailing new line.
Tell me if it's better.

Is Zhenzhong's FLTS series merged? If not, it might the cause of the sha1 p=
roblem you are facing

Thanks
>cmd


> v2
>     - handle huge pages better by detecting the page table level at which=
 the translation errors occur
>     - Changes after review by ZhenZhong Duan :
>       - Set the access bit after checking permissions
>       - helper for PASID and ATS : make the commit message more accurate =
('present' replaced with 'enabled')
>       - pcie_pasid_init: add PCI_PASID_CAP_WIDTH_SHIFT and use it instead=
 of PCI_EXT_CAP_PASID_SIZEOF for shifting the pasid width when preparing th=
e capability register
>       - pci: do not check pci_bus_bypass_iommu after calling pci_device_g=
et_iommu_bus_devfn
>       - do not alter formatting of IOMMUTLBEntry declaration
>       - vtd_iova_fl_check_canonical : directly use s->aw_bits instead of =
aw for the sake of clarity
>
> v3
>     - rebase on new version of Zhenzhong's flts implementation
>     - fix the atc lookup operation (check the mask before returning an en=
try)
>     - add a unit test for the ATC
>     - store a user pointer in the iommu notifiers to simplify the impleme=
ntation of svm devices
>     Changes after review by Zhenzhong :
>       - store the input pasid instead of rid2pasid when returning an entr=
y after a translation
>       - split the ATC implementation and its unit tests
>
> v4
>     Changes after internal review
>       - Fix the nowrite optimization, an ATS translation without the nowr=
ite flag should not fail when the write permission is not set
>
> v5
>     Changes after review by Philippe :
>       - change the type of 'level' to unsigned in vtd_lookup_iotlb
>
>
>
> Cl=E9ment Mathieu--Drif (22):
>   intel_iommu: fix FRCD construction macro.
>   intel_iommu: make types match
>   intel_iommu: return page walk level even when the translation fails
>   intel_iommu: do not consider wait_desc as an invalid descriptor
>   memory: add permissions in IOMMUAccessFlags
>   pcie: add helper to declare PASID capability for a pcie device
>   pcie: helper functions to check if PASID and ATS are enabled
>   intel_iommu: declare supported PASID size
>   pci: cache the bus mastering status in the device
>   pci: add IOMMU operations to get address spaces and memory regions
>     with PASID
>   memory: store user data pointer in the IOMMU notifiers
>   pci: add a pci-level initialization function for iommu notifiers
>   intel_iommu: implement the get_address_space_pasid iommu operation
>   intel_iommu: implement the get_memory_region_pasid iommu operation
>   memory: Allow to store the PASID in IOMMUTLBEntry
>   intel_iommu: fill the PASID field when creating an instance of
>     IOMMUTLBEntry
>   atc: generic ATC that can be used by PCIe devices that support SVM
>   atc: add unit tests
>   memory: add an API for ATS support
>   pci: add a pci-level API for ATS
>   intel_iommu: set the address mask even when a translation fails
>   intel_iommu: add support for ATS
>
>  hw/i386/intel_iommu.c                     | 142 +++++-
>  hw/i386/intel_iommu_internal.h            |   6 +-
>  hw/pci/pci.c                              | 127 +++++-
>  hw/pci/pcie.c                             |  42 ++
>  include/exec/memory.h                     |  51 ++-
>  include/hw/i386/intel_iommu.h             |   2 +-
>  include/hw/pci/pci.h                      | 101 +++++
>  include/hw/pci/pci_device.h               |   1 +
>  include/hw/pci/pcie.h                     |   9 +-
>  include/hw/pci/pcie_regs.h                |   3 +
>  include/standard-headers/linux/pci_regs.h |   1 +
>  system/memory.c                           |  20 +
>  tests/unit/meson.build                    |   1 +
>  tests/unit/test-atc.c                     | 527 ++++++++++++++++++++++
>  util/atc.c                                | 211 +++++++++
>  util/atc.h                                | 117 +++++
>  util/meson.build                          |   1 +
>  17 files changed, 1330 insertions(+), 32 deletions(-)
>  create mode 100644 tests/unit/test-atc.c
>  create mode 100644 util/atc.c
>  create mode 100644 util/atc.h
>
> --
> 2.45.1


--_000_AM8PR07MB76020A044539A40485F91F0A86DC2AM8PR07MB7602eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Michae=
l S. Tsirkin &lt;mst@redhat.com&gt;<br>
<b>Sent:</b>&nbsp;01 July 2024 22:02<br>
<b>To:</b>&nbsp;CLEMENT MATHIEU--DRIF &lt;clement.mathieu--drif@eviden.com&=
gt;<br>
<b>Cc:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; jasowa=
ng@redhat.com &lt;jasowang@redhat.com&gt;; zhenzhong.duan@intel.com &lt;zhe=
nzhong.duan@intel.com&gt;; kevin.tian@intel.com &lt;kevin.tian@intel.com&gt=
;; yi.l.liu@intel.com &lt;yi.l.liu@intel.com&gt;; joao.m.martins@oracle.com
 &lt;joao.m.martins@oracle.com&gt;; peterx@redhat.com &lt;peterx@redhat.com=
&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH ats_vtd v5 00/22] ATS support for VT-d</spa=
n>
<div>&nbsp;</div>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">Caution: External =
email. Do not open attachments or click links, unless this email comes from=
 a known sender and you know the content is safe.<br>
<br>
<br>
On Mon, Jun 03, 2024 at 05:59:38AM +0000, CLEMENT MATHIEU--DRIF wrote:<br>
&gt; From: Cl=E9ment Mathieu--Drif &lt;clement.mathieu--drif@eviden.com&gt;=
<br>
&gt;<br>
&gt; This series belongs to a list of series that add SVM support for VT-d.=
<br>
&gt;<br>
&gt; As a starting point, we use the series called 'intel_iommu: Enable sta=
ge-1 translation' (rfc2) by Zhenzhong Duan and Yi Liu.<br>
&gt;<br>
&gt; Here we focus on the implementation of ATS support in the IOMMU and on=
 a PCI-level<br>
&gt; API for ATS to be used by virtual devices.<br>
&gt;<br>
&gt; This work is based on the VT-d specification version 4.1 (March 2023).=
<br>
&gt; Here is a link to a GitHub repository where you can find the following=
 elements :<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - Qemu with all the patches for SVM<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - ATS<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - PRI<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Device IOTLB invalid=
ations<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Requests with alread=
y translated addresses<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - A demo device<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - A simple driver for the demo device<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - A userspace program (for testing and demonst=
ration purposes)<br>
&gt;<br>
&gt; <a href=3D"https://github.com/BullSequana/Qemu-in-guest-SVM-demo" id=
=3D"OWAd5f8eb7b-d74e-f109-1858-21756737e8df" class=3D"OWAAutoLink" data-aut=
h=3D"NotApplicable">
https://eur06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.=
com%2FBullSequana%2FQemu-in-guest-SVM-demo&amp;data=3D05%7C02%7Cclement.mat=
hieu--drif%40eviden.com%7Cf5759aefcc5f4e7d4e6c08dc9a08d29a%7C7d1c77852d8a43=
7db8421ed5d8fbe00a%7C0%7C0%7C638554609882544195%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7=
C&amp;sdata=3D2Gza1VD7hKr1Sx3fOLoRh6tk3taSPKTn5nfimhPLz70%3D&amp;reserved=
=3D0</a><br>
<br>
I will merge, but could you please resend this using git format-patch<br>
for formatting?&nbsp; The patches have trailing CRs and don't show which sh=
a1<br>
they are for, which makes re-applying them after each change painful.</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos Mono, Aptos_Embed=
dedFont, Aptos_MSFontService, monospace; font-size: 11pt; color: rgb(0, 0, =
0);">
Hi Michael,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos Mono, Aptos_Embed=
dedFont, Aptos_MSFontService, monospace; font-size: 11pt; color: rgb(0, 0, =
0);">
I sent the series again without the trailing new line.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos Mono, Aptos_Embed=
dedFont, Aptos_MSFontService, monospace; font-size: 11pt; color: rgb(0, 0, =
0);">
Tell me if it's better.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos Mono, Aptos_Embed=
dedFont, Aptos_MSFontService, monospace; font-size: 11pt; color: rgb(0, 0, =
0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos Mono, Aptos_Embed=
dedFont, Aptos_MSFontService, monospace; font-size: 11pt; color: rgb(0, 0, =
0);">
Is Zhenzhong's FLTS series merged? If not, it might the cause of the sha1 p=
roblem you are facing</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos Mono, Aptos_Embed=
dedFont, Aptos_MSFontService, monospace; font-size: 11pt; color: rgb(0, 0, =
0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos Mono, Aptos_Embed=
dedFont, Aptos_MSFontService, monospace; font-size: 11pt; color: rgb(0, 0, =
0);">
Thanks</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos Mono, Aptos_Embed=
dedFont, Aptos_MSFontService, monospace; font-size: 11pt; color: rgb(0, 0, =
0);">
&gt;cmd</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt; color: rgb(0, 0, 0)=
;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">&gt; v2<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - handle huge pages better by detecting the pa=
ge table level at which the translation errors occur<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - Changes after review by ZhenZhong Duan :<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Set the access bit after checkin=
g permissions<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - helper for PASID and ATS : make =
the commit message more accurate ('present' replaced with 'enabled')<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - pcie_pasid_init: add PCI_PASID_C=
AP_WIDTH_SHIFT and use it instead of PCI_EXT_CAP_PASID_SIZEOF for shifting =
the pasid width when preparing the capability register<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - pci: do not check pci_bus_bypass=
_iommu after calling pci_device_get_iommu_bus_devfn<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - do not alter formatting of IOMMU=
TLBEntry declaration<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - vtd_iova_fl_check_canonical : di=
rectly use s-&gt;aw_bits instead of aw for the sake of clarity<br>
&gt;<br>
&gt; v3<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - rebase on new version of Zhenzhong's flts im=
plementation<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - fix the atc lookup operation (check the mask=
 before returning an entry)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - add a unit test for the ATC<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - store a user pointer in the iommu notifiers =
to simplify the implementation of svm devices<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Changes after review by Zhenzhong :<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - store the input pasid instead of=
 rid2pasid when returning an entry after a translation<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - split the ATC implementation and=
 its unit tests<br>
&gt;<br>
&gt; v4<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Changes after internal review<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Fix the nowrite optimization, an=
 ATS translation without the nowrite flag should not fail when the write pe=
rmission is not set<br>
&gt;<br>
&gt; v5<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; Changes after review by Philippe :<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - change the type of 'level' to un=
signed in vtd_lookup_iotlb<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; Cl=E9ment Mathieu--Drif (22):<br>
&gt;&nbsp;&nbsp; intel_iommu: fix FRCD construction macro.<br>
&gt;&nbsp;&nbsp; intel_iommu: make types match<br>
&gt;&nbsp;&nbsp; intel_iommu: return page walk level even when the translat=
ion fails<br>
&gt;&nbsp;&nbsp; intel_iommu: do not consider wait_desc as an invalid descr=
iptor<br>
&gt;&nbsp;&nbsp; memory: add permissions in IOMMUAccessFlags<br>
&gt;&nbsp;&nbsp; pcie: add helper to declare PASID capability for a pcie de=
vice<br>
&gt;&nbsp;&nbsp; pcie: helper functions to check if PASID and ATS are enabl=
ed<br>
&gt;&nbsp;&nbsp; intel_iommu: declare supported PASID size<br>
&gt;&nbsp;&nbsp; pci: cache the bus mastering status in the device<br>
&gt;&nbsp;&nbsp; pci: add IOMMU operations to get address spaces and memory=
 regions<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; with PASID<br>
&gt;&nbsp;&nbsp; memory: store user data pointer in the IOMMU notifiers<br>
&gt;&nbsp;&nbsp; pci: add a pci-level initialization function for iommu not=
ifiers<br>
&gt;&nbsp;&nbsp; intel_iommu: implement the get_address_space_pasid iommu o=
peration<br>
&gt;&nbsp;&nbsp; intel_iommu: implement the get_memory_region_pasid iommu o=
peration<br>
&gt;&nbsp;&nbsp; memory: Allow to store the PASID in IOMMUTLBEntry<br>
&gt;&nbsp;&nbsp; intel_iommu: fill the PASID field when creating an instanc=
e of<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; IOMMUTLBEntry<br>
&gt;&nbsp;&nbsp; atc: generic ATC that can be used by PCIe devices that sup=
port SVM<br>
&gt;&nbsp;&nbsp; atc: add unit tests<br>
&gt;&nbsp;&nbsp; memory: add an API for ATS support<br>
&gt;&nbsp;&nbsp; pci: add a pci-level API for ATS<br>
&gt;&nbsp;&nbsp; intel_iommu: set the address mask even when a translation =
fails<br>
&gt;&nbsp;&nbsp; intel_iommu: add support for ATS<br>
&gt;<br>
&gt;&nbsp; hw/i386/intel_iommu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; | 142 +++++-<br>
&gt;&nbsp; hw/i386/intel_iommu_internal.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 +-<br>
&gt;&nbsp; hw/pci/pci.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 127 +++++-<br>
&gt;&nbsp; hw/pci/pcie.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 42 ++<br>
&gt;&nbsp; include/exec/memory.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |&nbsp; 51 ++-<br>
&gt;&nbsp; include/hw/i386/intel_iommu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-<br>
&gt;&nbsp; include/hw/pci/pci.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; | 101 +++++<br>
&gt;&nbsp; include/hw/pci/pci_device.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&gt;&nbsp; include/hw/pci/pcie.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |&nbsp;&nbsp; 9 +-<br>
&gt;&nbsp; include/hw/pci/pcie_regs.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 3 +<br>
&gt;&nbsp; include/standard-headers/linux/pci_regs.h |&nbsp;&nbsp; 1 +<br>
&gt;&nbsp; system/memory.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 20 +<br>
&gt;&nbsp; tests/unit/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&=
nbsp;&nbsp; 1 +<br>
&gt;&nbsp; tests/unit/test-atc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; | 527 ++++++++++++++++++++++<br>
&gt;&nbsp; util/atc.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 211 +++++++++<b=
r>
&gt;&nbsp; util/atc.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 117 +++++<br>
&gt;&nbsp; util/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&gt;&nbsp; 17 files changed, 1330 insertions(+), 32 deletions(-)<br>
&gt;&nbsp; create mode 100644 tests/unit/test-atc.c<br>
&gt;&nbsp; create mode 100644 util/atc.c<br>
&gt;&nbsp; create mode 100644 util/atc.h<br>
&gt;<br>
&gt; --<br>
&gt; 2.45.1<br>
<br>
</div>
</body>
</html>

--_000_AM8PR07MB76020A044539A40485F91F0A86DC2AM8PR07MB7602eurp_--

