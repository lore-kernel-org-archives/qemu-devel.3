Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12C8EA8126
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vppQG-0006rl-2X; Tue, 10 Feb 2026 10:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vppQC-0006ql-EK; Tue, 10 Feb 2026 10:13:00 -0500
Received: from mail-eastusazon11012038.outbound.protection.outlook.com
 ([52.101.53.38] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vppQA-0006vi-Lx; Tue, 10 Feb 2026 10:13:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWydkNc2Cd/0SCON+0Dy8WNGZorhSHAn35Ayy4OZG5FKDx3sKXwmR83iDlDqVW2mX5aIsbuxrJCra7Z3EnZXeae4XUKMN7YyZYaRRXqsi69fArvhtm/pp+Hujgc9oMWQsSu9oDvKa6N6+hMwnttbyAjcnkC8S663HHt1kHUxj/OieNO1SgxbNhn++meyIFE1AOl24Slqogp+XjCJX8lmBRYHod+cv8G8J3hkySxdRiWxv200wsuiyTLMmiJNFwDkiFBTc0E5vCdZwo/0qTwZWW7yACNMgzFgXCAK1Cz5t6VAkRjYtLPXQg7M/LFQJEMQo8uCYyGylcD3zayOV0P3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZw5zylhQopPOBVut5eLJ7KNLQqYl5pd0JYuzeK/qxk=;
 b=WCG6iUEIbegHvLx5aairT6iDnb2FFwiqG5ITiRoytCwkmwx2CgnwPIRCFNnUM5j1R0rTrWe7oFFrxT2PS4OS6ShcytoBQ/fuN6CRRmVsjlEtevS8Kcj3UTXm9gP1Ka/um+yVqU3NrQ2Y9uhntGcoR62/WiUMrvfoPXU8VzlfKqE8IPsVJAr0L9pvphLFWeEKd0MItHXQVubyw+FuvmrRw7Aj8k8n4r2rS25mh2V9hkQNQYwpWVLElkiQjljCartQkMWG297fZpbuCDhOUx2AA7JS59R9ZymxPxsPniRwZAY9S42HztXAu4ceEJDLo0f8NHnbv9Z371h2PietBI/2aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZw5zylhQopPOBVut5eLJ7KNLQqYl5pd0JYuzeK/qxk=;
 b=Z6JQHHyisaPzLXid/ryxxc0QSX3oD10SJn0DIkkIN5zPb3p1NgGMduIugHJFJVGCh03GszPRadamV9cD5YTG4MBQUz/IMuEJjeBD3Vp+/DPuFI9ch8syvK2UuELD4vJQ3y8ZrrG9DhkxY4KJyZImg7AXzqKdIXYHUkjyAU439yurTamYRI7FAiUyT//mTkrmGcdDMOqhg4eN4m8SMFHeTYU503dAikCxYiqZ+e/ugj6+vlNdWHA1yAKF4089cQJxKBsaPPv5mn8QcRspSEVwfuBdmtcjWimf/Wb5+BgP49VBzW6J4y5d3C78GSX50qk7e5VJU1ZfvVxoL3Al+6XlCw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Tue, 10 Feb
 2026 15:12:35 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 15:12:35 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify OAS
 bits
Thread-Topic: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify
 OAS bits
Thread-Index: AQHcjrF92YpMmGmntEqRZLFfH3O4H7VvhjCAgAAEUKCAAAa0gIAABIOQgAAG3gCAAAAr0IAMfn/A
Date: Tue, 10 Feb 2026 15:12:35 +0000
Message-ID: <CH3PR12MB7548515EDA96BD03F64DCAA2AB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-32-skolothumtho@nvidia.com>
 <d9192ae6-a94f-479a-b19f-734cc52a6be0@redhat.com>
 <CH3PR12MB754867E986856DC7718D4051AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202151917.GO2223369@nvidia.com>
 <CH3PR12MB754835BE4A5C54387122504AAB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20260202160000.GR2223369@nvidia.com>
 <CH3PR12MB7548DFE7F7CE555A3B3BF947AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB7548DFE7F7CE555A3B3BF947AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB7528:EE_
x-ms-office365-filtering-correlation-id: cf9cf53b-25b3-4bf7-980b-08de68b6d255
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2JNcWURHxAvggCaCho1NGy2H/sZVqVCxCywan+o0V4irCG+q9w4yGFOkSPfU?=
 =?us-ascii?Q?hdiw3zjOgAw3KYGXBhfeJPWb2Mx1gXidewAqbFe3RQX60vGqsFo27wEdcSJI?=
 =?us-ascii?Q?2t1ak+hWmB68tIGmhPyusgMUFSU/7FWOYPYniW87CewhoY7jZqW+EPRHPnr8?=
 =?us-ascii?Q?lgD+G4XHw3DNtt6/JjvyY5pv4ZKIrL6mzaBNH6nZGw9Nevb0GvVv76M9Oy5D?=
 =?us-ascii?Q?XWSUZxSj6XC98vAkztlw1XvykDzlmnQHH3k+SzVTin3s83z3KAiGPHnY8/Jj?=
 =?us-ascii?Q?SfsVjTkTEXkT5aafmA/ANiEIOvzb5LciJofI60bacFBMNIYW2hCyf7VvW1PC?=
 =?us-ascii?Q?YZy4T9Vv0z97ZSLUGBA+jsL4PCJs9gqijIVMY+q9kD+RyCvNVeqqWW473Pyb?=
 =?us-ascii?Q?aPHrr4VGPkwh+GGFYxQzR4vubSxPxBRIzseh2sgRq5NGJ2PeAQNqAxh/oRiW?=
 =?us-ascii?Q?amG3ZTfojga1vNBmmzCzQm45HwE9Wu2Uh6a/I6agWQHALwznuzz2/Uv2GeUB?=
 =?us-ascii?Q?EyAUiuEZaaJpADdHaAlhLkdGMVdmjKoXQFHTKmsFjvzd0OaE2lr6lHtdzqtV?=
 =?us-ascii?Q?nnsqZvJjMQC2/nbMDgOjYNF6UjOjLRou0Z5qW3l3WAgJVstT1ej1jpiLGMXt?=
 =?us-ascii?Q?3OcOC+4Rf2ir4O83MjAcGUYE6AHqmgNBEioIRu1D1MI+OWfqHQyAEfL0Phin?=
 =?us-ascii?Q?tiDRMuniO7jPWE8pclDM0AMSadvEMW/FhAzq5P3yt73cVBO9YSZ+BPu3u6P6?=
 =?us-ascii?Q?016dgDkKNlmE6rGhORkgY6l4ZqG2cyp3WC/4TqpuhGV85Oij4wF41rvHrcS/?=
 =?us-ascii?Q?n73Hr5XumWEzhAd4QFE+2yZmsHv2NLhx2WFxlckRCdtf9KYdhLkr/10/D6JD?=
 =?us-ascii?Q?dsF26jE9494LH9JX7jcus8ZkBJuwF9UBwimcK5RQdNkR1hQJ3yQ3OkEH96Wz?=
 =?us-ascii?Q?/PMpCgwDGtDWcDUFZSDqf0kh9vZQBOyTMnrBRtbW2warObT3xhxe80LW0RaO?=
 =?us-ascii?Q?hhyk9r4IQ7Gnt0JaDc4tC1rXfyR4giWmUGW1wRM8MSLgZ7UOATD8NM40YTt5?=
 =?us-ascii?Q?ys4niR6RNzEWhx0iwf2pYyCtQXYTT5RyzDtNFUwNQxW+ILGgxJ8qFkVfecyf?=
 =?us-ascii?Q?PNBeGOHbwOeEzbpVZqBwroh8uwFVvqdRAkAPBKYEBhdiioCYO2vLRPNnDzX4?=
 =?us-ascii?Q?ibnBSse4fCG2hdOo/VdSo5YZL6TQgXPnHevsIXaGsRGBzd3fJa8IYOlTnoM4?=
 =?us-ascii?Q?AFwrt/6cfY/wWlMcPiG75twpLPSHcVc4Ux2op6a9Kl30AOubGcTQPGFAXSFW?=
 =?us-ascii?Q?U5GSPyUZlbkzxjR4WTFFPbysCl6TZFJKyhLUEUK5/2rmzsRuv93ATqYmEn9o?=
 =?us-ascii?Q?7AUOgjPDyEPdeVsmNp0zn0S41B6XYejJxoKovTcGthRwaJyDu3WJDk8hysNv?=
 =?us-ascii?Q?ry1IR9LFByE/dKfYgtncukEVO/YPTCcfTYgytJ86mcPrLJEJv8w+g25wuTYD?=
 =?us-ascii?Q?L/QQpwAjqUaKEE7PyQ7FQQ5kVNIuKGvDQfeRFoc7ZYRPoDTrAgsccDaY95uP?=
 =?us-ascii?Q?bSH08OX4UvrAxMYxGCKB8slE8a9gmA2vPO4YJsFEP1+9hSPdDY+l14bGPn/U?=
 =?us-ascii?Q?jY4vLpSf4uI/T1fEpQarb7M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Kd7TbON9/C+jiC3ojsThvXGjq+ItdkfpwgObIz2HQinLvYCyweFFek+7QfU?=
 =?us-ascii?Q?zZK8TGCQ+lwMOdWu3SxJGPtADtSV2NO7qYBrO7fbNWlogAfpVr8cvr95pnCv?=
 =?us-ascii?Q?U3iS6UbVkhLWzlC19Pz8E/Bq5SUTTkszb06Fs4sFcMv3oX87qrrQLkkH6wtW?=
 =?us-ascii?Q?XMCa0TCbzGujn9KWRHRJgu5RLLpmQwBMmPN0hQf2fBt30Bj/n7XpGT3WC7S2?=
 =?us-ascii?Q?N95gFvnlMcAgzfpP3JSmb68+r07E0B96ZF8vqv8WvoUyjhyuTUJoU73vOPsf?=
 =?us-ascii?Q?dKrqY6O1vuNRWB7neyRmGRY5RolEJEzJ1aIe/CzdBcWVs2D+NJITi4qHHkIP?=
 =?us-ascii?Q?X4P+3YIGaaARvttGD5zMGk7hu0a1GjDCvGs/D1FFZBfUy5pqlyP7KVl1aTSN?=
 =?us-ascii?Q?DxUzsm3g3Au3Slm6e/kDBzb4+qRlF0Krj/sUengU6XClJP9GI6Cpog+gY/3k?=
 =?us-ascii?Q?pooqFxqbb+mV/SHcRLOcicBHSKJKvOx4H6YNO6/JNxmSVsv+uRqS9EZEr9Ic?=
 =?us-ascii?Q?Tw2rgNEu+W9M8qPdNLoAnzhi5qLXKQ8l0oHdxlkgTslTeWAZvI0+iERrlSgQ?=
 =?us-ascii?Q?XTMLvW7ymrpgTvpJb4MA7b9cmb1vssTNcqRNfMzkj2LiPq3Vz7w7yx0zWEEd?=
 =?us-ascii?Q?ItsmBC904s4MSXQFKeS0dEQLxF9htR9fJyfO/EGIXERTAEZ07u5hK62uu8eR?=
 =?us-ascii?Q?8V5kzZusRY7aHqr02NGUL4BrKiAGo0VnXYGTqCQxAx7ubX2jS86XXl8j11zk?=
 =?us-ascii?Q?9U8fawpD/88I2fMKCNQb536bMGvZbW53wYKFOcOPprOWMDJBj4XlJ7rsO0f0?=
 =?us-ascii?Q?V1w2uTIwluG6d3uCV352N9AmWdujNmNbnCcy/rCRm0pPzCBserpa+LI3Rwow?=
 =?us-ascii?Q?CEpG0vik7IcVSUmGhsVW+AYJk/dk4l3DBoS1obrnk3ijdEm+sVDeR/zfs+4S?=
 =?us-ascii?Q?Y3y82MPA1l7qmCr5p3AXEH27Qu595ahk4A52RRkhVj9hpbdqxh0+La3a/Xpn?=
 =?us-ascii?Q?N/rYm0Lf1I6B0HW26T+XzUwaxv6BjU3Y5menvsw/ZNLzY8AsSAyRsIdKqDDV?=
 =?us-ascii?Q?oKNAN2+9whxC4UTE0mAhYy0mJRTwPM75dHJg1Z+4qN4T+fyEKpVfTUmqPUwT?=
 =?us-ascii?Q?en75koSDmnf+KB+vr5OockpR4T4Magja48Q7kUlz6BfDcaTrMh8czKbfOdNU?=
 =?us-ascii?Q?3hF+YZn4p+IKjmcDVVojU8/ePV2U8huL0U2lYcxbwQNjdNcZfSrv+TG6YURx?=
 =?us-ascii?Q?VIP3DB4UfE8ePOcDn458A85E9Zb8oKGpa88ZIM9D/TR2HLKlGdZM9Gxeekqy?=
 =?us-ascii?Q?o6KcoKIwXQX338sHVv909QwmCamwyvd9onoPC3I6xbapyztyzj8GCDbbXmGt?=
 =?us-ascii?Q?thmvdl9DDwO7xqT0FmcS/rKiQjqE7bUkMdpaYTApi5xIeAczsGEVXlkho2HK?=
 =?us-ascii?Q?9BXwDOJQyLpBmUprHajcVk2Z0l2N0ZIxsg9I0AtWv/i/A/BKnILeAUElm+LK?=
 =?us-ascii?Q?ixcJeTexyX8sz/IVKurtKac4ZQEWsT72/TySe5Pbn4oyPxHecMayZ5uuoG9R?=
 =?us-ascii?Q?Nxpvb6/pXGuxDEIiBF4OP/r3eFutVX0qrIKVTUWfG1KUZZgLcCZHUPcZlnaV?=
 =?us-ascii?Q?59fd5khf/rAasxbzO7D+p072KOQo51gYrSp38NBB0vABWfx3R+rWXQ1Cie2I?=
 =?us-ascii?Q?IU/q+Sk2la9bOR3RXeOXB8FTjnmbzsa5WxKIFecodYZRheKMrYoN1HSjneuu?=
 =?us-ascii?Q?nKyJg7EOtw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9cf53b-25b3-4bf7-980b-08de68b6d255
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 15:12:35.5016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QRbQx0A5i0dQLcG0dOtUIq3c27vqfTAWDrRx1p8iy40lEK87+rKFPCE0y1xA78uB4SbAz7Kg0c1kxa1h63lugQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
Received-SPF: permerror client-ip=52.101.53.38;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Eric,

> -----Original Message-----
> From: Shameer Kolothum Thodi
> Sent: 02 February 2026 16:04
> To: Jason Gunthorpe <jgg@nvidia.com>
> Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; peter.maydell@linaro.org; Nicolin Chen
> <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
> clg@redhat.com; alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>;
> Matt Ochs <mochs@nvidia.com>; smostafa@google.com;
> wangzhou1@hisilicon.com; jiangkunkun@huawei.com;
> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: RE: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to
> specify OAS bits
>=20
>=20
>=20
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: 02 February 2026 16:00
> > To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> > Cc: eric.auger@redhat.com; qemu-arm@nongnu.org; qemu-
> > devel@nongnu.org; peter.maydell@linaro.org; Nicolin Chen
> > <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
> > clg@redhat.com; alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>;
> > Matt Ochs <mochs@nvidia.com>; smostafa@google.com;
> > wangzhou1@hisilicon.com; jiangkunkun@huawei.com;
> > jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
> > zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
> > <kjaju@nvidia.com>
> > Subject: Re: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to
> > specify OAS bits
> >
> > On Mon, Feb 02, 2026 at 03:38:50PM +0000, Shameer Kolothum Thodi
> > wrote:
> >
> > > > We can treat ATS as a per-PCIe device property.. I think it would
> > > > be fine to tell the SMMU that it always has ATS support, it will
> > > > never do anything with it unless it sees a PCIe device with an ATS
> > > > cap, and the physical STE generated by the hypervisor should saniti=
ze the
> EATS.
> > > >
> > > > BIOS overriding it should be reflected as the devices being
> > > > reported as not supporting ATS, qemu should have a per-device flag
> > > > to disable ATS.
> > >
> > > Do we have way to detect that(IOMMU_FWSPEC_PCI_RC_ATS) from
> > > userspace now?
> >
> > I don't think so.. I was describing how I suspect that should work.
> >
> > The iommu driver is the only entity that decides if ATS should be
> > enabled per-device, so it should report back to userspace in iommufd
> > if the device is allowed to enable ATS or not. That should roll up any
> > FW overrides and the PCI cap block.
>=20
> Right. May be just like the out_max_pasid_log2. Will take a look.

Looking at adding the ATS detection support through iommufd, one
idea is to extend the enum iommufd_hw_capabilities with
IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED. The question I have
now is whether we need to differentiate an old kernel which doesn't
have this support or not.

This is how the usage would look with an added "ats" property on the
vfio-pci device:

-device vfio-pci,...,ats=3Don
    if ATS_NOT_SUPPORTED then reject
-device vfio-pci,...,ats=3Doff
    keep ATS off
-device vfio-pci,...,ats=3Dauto (default)
   if ATS_NOT_SUPPORTED, disable ATS
    otherwise, enable ATS if the PCIe ATS capability is present
    (this also covers behaviour on older kernels)

Does the above make sense?

Thanks,
Shameer


