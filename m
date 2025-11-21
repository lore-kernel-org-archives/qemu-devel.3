Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12333CFA765
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 09:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNtn-0008Us-Dl; Fri, 21 Nov 2025 04:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vMNtk-0008Tc-8q; Fri, 21 Nov 2025 04:57:49 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vMNth-0007B3-1D; Fri, 21 Nov 2025 04:57:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmnTFgCZ/3DfH4pSqaEEeHSHA/Mde8ND/beVhmHR/FXCF+M8UkbJ2mSFxlfzFAVR+EeJFpyNvNY4r4mbm2vILf4M7YWBSvW87kwUZ7NSjeVU5Lly3YTxOquf93bUAPZjxzwaJ3lomhA9CWCGX201vfFs3ivYj3q92UZBduBYd9Znrtwz2dxPQcwD5E7jNBnv5OI5x9bXteXmG352tRx61VXZ5SGUlWvX0lgEOhnPmWWA9lS9ysI2DMeqSEmC6XlmXZjuJy1ZMmn4tfsbljogCBTPvwWqlOLM5ziITa9DGpcaRf8Oy5DTp+16WfIkZZudYDuvLwlslnovLCELfQhJqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01NbHHNi17PJq63ZD89pM1wqs1RLniTTgJgMiu9oyvI=;
 b=qTunT9g9vH+5t2I2Fn1uN+Y+R/o5vd5JTif3M45+QlC4U31BX7ODeWf/Tehr4dGVZh6VLMxFIhQsPwdD41Ke1zMcBELAalIymbvxAtAJ/uom9ysWxxW3yv9cw8S4/iPpRQM/8m1nSxkkNip8iaeD0RzxUpuRAD3WMtMW9hmI4C/j3juQBXNkltTw8Bv7BPXkwHqs/ZOf2hE1MvzyjGu+732lhTeLzNe8OhQ4FJn0s5fnc1pPEFaKzvjA3we5bup5YBwxNKcBlGNn5Ldsvhe390Pax7E/7+O8XitC348fcJTTKR5gKVUPJGOP9gkjf7JXpEzKXouB7KohtgFCLThfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01NbHHNi17PJq63ZD89pM1wqs1RLniTTgJgMiu9oyvI=;
 b=kVxNDLIvughFxhz+4KDXcjHJ1jQ47IN37TkeCP/jRv7wrAV8nh21l06HMMvKqGj5bAnAd9N5UJVA64JlmxOe4N00VWJndJF+7f7smXV99D5CR7dbx4u+gTks7yPs4u+W6cHwZsuszlx9p2z1CPPoYEkOb0KurMLUst1lEU1f12sm/eGCeFLeHiLzUn7hQQ1qKiBaQzM1ewwcbO72Ws1Sq/s614mNm9Z135qSe3NjZRfRhOEaZarGNE3cb/W55HxlGlmqZdLuDdI+Ll0zSsMXv90ltYUn5xZsrNlb0RoCNQUetvqcvnLcijDlecvsGtuh2H0iuuth5yBwn4xJq12Imw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.13; Fri, 21 Nov
 2025 09:57:38 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 09:57:38 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a
 direct MSI doorbell GPA
Thread-Topic: [PATCH v6 17/33] hw/arm/smmuv3: Add support for providing a
 direct MSI doorbell GPA
Thread-Index: AQHcWiEf+PaTPr3V30uUQF2zh8a+rrT8ExiAgADSd6A=
Date: Fri, 21 Nov 2025 09:57:37 +0000
Message-ID: <CH3PR12MB754869BFD4D1B5C65EE30AB8ABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-18-skolothumtho@nvidia.com>
 <aR+Ga0DrveuOd3v7@Asurada-Nvidia>
In-Reply-To: <aR+Ga0DrveuOd3v7@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SJ1PR12MB6145:EE_
x-ms-office365-filtering-correlation-id: d2fd5f8a-7e4b-4c83-ecae-08de28e466f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?clVqU1l0Y1Q0RVNJZUc0R2VSMlZNYjRBYkF3bFlkSXdJbEVPenVoM3BtcW41?=
 =?utf-8?B?RGhnZmpDU0EzMkVLcW14MUc5WFBOSEVmV25oeDVjQStVeWVFMkViNDNaZUdG?=
 =?utf-8?B?VUgxcGdlV2dGS0UzZUdBNElnL1RKNlVnN1pRQmUxZjNNZ1B0cDNUQTlvbDJK?=
 =?utf-8?B?dUVkenVWVzMvOFdFaFRJQjIxWmtyV3BlS0Z2aGozT3VXcnBFRDFCb1duMGxF?=
 =?utf-8?B?c1FHaXY4aXhPUWFxRXpXaEY3TFBmbmNSM2pXUGUxM0p6L0VJNU1DaEx0VVgw?=
 =?utf-8?B?U2pueDd2UjZDeHF3Tk9RVWtLWjdyd0NjKzBmY0pKTXpjWmhvcUtLbW54UkQ1?=
 =?utf-8?B?c0xnLzMyWGp5akZxeFUzZEN5eWJsNTZuM1lBcU96bSswMnlIeHRjdzE3WHVZ?=
 =?utf-8?B?aWRKRFVyVEtBcFY5dTluY0lETGZiTlFtWE9WaHE2WWx1eHJ4TGZGUHhLV3o2?=
 =?utf-8?B?TjRrL1dvYmhSYnF3M0R0QjVONmR1Q3VpQ2NYMG16bW51ZHlyaFJaUDdhbVJv?=
 =?utf-8?B?VzlUOU9HR292RmN0MHdmUkMxcVhGVWdOV3h3TitLUlVZMUE3WHRWRERQWDhu?=
 =?utf-8?B?c1NSbm0reE1HaW5JbjRUVWlDdStCNENERnlCemF3WjVta2RmSU9rSGRiZWw2?=
 =?utf-8?B?UU10SHQzTjJjdXNpLzI0Vnl2ZVJUdXc1akcwSkhrRXpjVUEybDYvNEU2bWlz?=
 =?utf-8?B?M1RMSGpTZkh1cnBjWWtBY1haMWpZUlBFNm0vSXJtRjBPOVFER3JEd042STVX?=
 =?utf-8?B?bTk5c0ZINTNWSWdMTFZ6bnptOFJpRFBxMDlvL01TdGJMUDMxODNHL1N6V2VJ?=
 =?utf-8?B?QU54QXViOHdoc3BlTnNyWlMrNkdDakY4Y0JBRWgwdU5NUGRoM2RLdVoxclM1?=
 =?utf-8?B?S2dsVFBGQ0FQU3c0bWZUNU9UNXFpWkI3TVdGcHBqMXU0UW1MalByWk9UYXEr?=
 =?utf-8?B?cjA1WllJVmxyM2w0d3RKKzc5U1o4OGhFVG9OUVNTbHRXMUpqYmZOQklZWVBP?=
 =?utf-8?B?Ums5aHJIYWlDakJxQktybW9ZcEZlV1UycjdIUjFLUy9BMW93TEhkVTh0Z2gy?=
 =?utf-8?B?dWFpUlk4WVJSUEdUTWJDVWtzV2tBb0pOcnBvWU85dGhpR1hkUHBtbUZ2SUtN?=
 =?utf-8?B?bnNXSU02ZzUrQTBNYUJOSXRaaUlWdW9CTU9lSlZMSmpGWWNzalpIVElGZkp2?=
 =?utf-8?B?dGNuL0prb1lqaDcvZnlLK093bFhsS0RXU2VhZ3ZQWHJSVEV4M1BVdExFdlVB?=
 =?utf-8?B?d2Vvc1FhcWhNM1Z1WWNMZFE3dTJuK0NPMFNlUG93KzRZZWJFTXg0aDJIeTJR?=
 =?utf-8?B?cCtKTWNpNXovYWNGNUEzUjRvQk1vSklGcXUydzNvOG9DNVFScU82OE9FQmlD?=
 =?utf-8?B?L2ZHeDlteVpDYnRwLzg2ZkI0WlNUM25OUmdPbGUxSHZpemRmaTNIUWdGZmNG?=
 =?utf-8?B?NXUzWlVtdTBzbzVYQWlzaUxRKy84UnpEZWJEQ0hoaFRiRWN0VmwxR2lvTm1K?=
 =?utf-8?B?UElJUXlTSWFDdHdzQllEUlg4ZStTTDU3ekJ5emIwalhWSndrZldCNXh2b3RW?=
 =?utf-8?B?VHRRR3U4cENHc2lITzI4c25nVUIxUDRNNHNsL0tGSk55bE9Xa3VhSlpHWkRT?=
 =?utf-8?B?VU5pbXRPQUh2RXZCNTFIaU9oNU9EVnhxYld6OEVrRU9HUDhJcnZCem41R0Z2?=
 =?utf-8?B?dklMbkZtc3BWU3R0WEEwbExMelFpWlBzNVp5OGFJMEpvLzRCd1c5Y2Z0cDVU?=
 =?utf-8?B?MWU0T1BhUjZnNUxXak9TSU9rUENKSHRNQWlld1lHVnhIbVcrRHJqN0dxTS92?=
 =?utf-8?B?NmUvY2syS1ZKOGdUT1pRei9kaHFHTzNUckFCaVBpNk9BT1lON2gxcTcyU1VG?=
 =?utf-8?B?cjJ5UERyTyttQlZMN2RhbFNvbERlcDczeUhPdFh4RzFRZlE3M0pYbDFlejN3?=
 =?utf-8?B?RFNDbkMwNGFSdk1WVmFvL3FuRGljTWd0aXMvUnJ3TWg0WmtlcE1VbGlMQWhn?=
 =?utf-8?B?S2lvbU8rMHhFTWJscVgyZHhRU3dZK3ZzZk5LdUxzN1VQM242bzc2K1Y0bzJW?=
 =?utf-8?Q?NkXA5D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTMxRjVxTmJOY1ZjbjdOUWpnb3NkeWxJaVRzNjloUXNFV3FQa1MzblJza0hI?=
 =?utf-8?B?OHRQY0RSTHZiYmYwbFNFYUhuUWVjTHovL1pIOFB2R2tlcVdJVlg5ZHc1a3di?=
 =?utf-8?B?c011UnkvUWFQaUlONmdwNG00OXJVeDlCbFlCNC9kbzYzYkdVaXh1Vk9TZzl6?=
 =?utf-8?B?aFowdUJQa2Y5YlFNbmVJWjVjbVZBWG10Z3ZJak1DYzFBaVc1K3A5TitmUkh0?=
 =?utf-8?B?QVlVeElLcWs3dCtiWnByTTNZOVVCdmQwTXBYN1lhUDNwc0kxaUJ5aXMvNmhm?=
 =?utf-8?B?Q0EzRVM0V3h0RnU2czFoZ0k0YTI2SHh5akoyeVFRN1ZIc1JxUVZLa0RNbE5V?=
 =?utf-8?B?NDFtTkhwZjJvdTlKNENVVVh3MUZMQjY5N2M2a3htaWM5clcyQ092L3lhL1Ry?=
 =?utf-8?B?UnBCQmdUUHhNVmtkanJtdmtwbDQ2QjkwM3dGN294TVROY3JIVmEza2xsMnFF?=
 =?utf-8?B?MGZSUEZoNkh0VlFvWFVNOEtWVDhPSjhuaDBZV0J6RmhXT3lzQWs0VE9URFBu?=
 =?utf-8?B?Mkd3WXJxZS8zOTBudjY5aFRjL0t6Vm1rTnpVQTVhbEQ5TUdCOVJIRnJ1TExz?=
 =?utf-8?B?dWVSTldUeGI1cEs5anFobG9RRG9GMWJURSs1Z1RsRm5IZ081a0pDOGxDa3h0?=
 =?utf-8?B?eVpLL3lPYTBFb25QRnljQjk1MS9zUzlUbTRkU0RPaEpvTXhRNGg0SXlIdi83?=
 =?utf-8?B?SXlFRUNVaVZSZEdMWWdLY0dZWXJTMHJSdWl4WVNhbDQ0U2FtU2d3VXNuQ3hx?=
 =?utf-8?B?UTdnTmI4SUhXRXllUTBVZTdRNnNiR2RsVjZtZjlXcGpXUGFvZkJxcFpFM0ZB?=
 =?utf-8?B?R2FqV3ljdEE1bVRYNWNzTHNFS1lHWlJQenZUQTVPSmNNeHg3Tk9Fd0JBY2dV?=
 =?utf-8?B?cVNzLysyaUMyK3JGRDR1OG4yaHBSRjZoN0NvTEZvYTV4WlhPVFdXSGJYRGZX?=
 =?utf-8?B?NFpneHgySlZLbzVaY2FPUTNQL1gxMnlhSnBmS2JpSjF5TEo3eTkzQm9ZRkc2?=
 =?utf-8?B?NzA1MTZPZmI4aW02QnkxY0YwSFBJZmpwS1N2L0YvWE5maDJmc0RFbFE3RFdi?=
 =?utf-8?B?R09LSE9CWHJVTHFJRzlCTXUvKy9xTTZ6dFRYS2dScFU1VmlCK3FOSmVJcXNi?=
 =?utf-8?B?Mk1PTWtLZUhad01BbkM1dWh3NDNZOC9zZi9rdGVPajVQMzB0eDh3R3J2bTNQ?=
 =?utf-8?B?dG03eGlBWjMxOWZEWDZPQlZlYnc1TzBZK09WZjMxYWxTMklrOVNtSFcwWHhT?=
 =?utf-8?B?UmQwRWNDTnVDTytUSzBOUzBmRGVTQ05LMEp4OVZWZnRldldTaHZBT1U0WkVw?=
 =?utf-8?B?UWxqblZ2YnBzR2JrM2xHVXVZaHdUNHMxWWtvY3drSFdKZkl3TXY0MDN5NnJY?=
 =?utf-8?B?bFg2Zm5iS1FrSHVoZ3ZuUzhvU1BTMXVwMXF4T1BzRW9IamxpSUx1WlFJQ0gr?=
 =?utf-8?B?WTZ1eUxERnlRbVpQUVhmbUtzTmR4NjdKM0NSS3drTHhHUHlWVDh0a1dkU3V0?=
 =?utf-8?B?ZUQ1cWJZdUNtc1lqdWZaVFVNaUJSVWtHOFRGVFJWUlgzRUNmYWxDREJyaEMv?=
 =?utf-8?B?WUpKUWl0b0xHV2tRR3YvWm9CQjJYc0lFVVJDdkVSQjNJaGtwdnhRbHpVM2d6?=
 =?utf-8?B?cGN1QlYvWFlqdzlQUGlzeUVvWVE4bjJ2aHJHS045Ry84cEhEWVpyOEg2Ly9t?=
 =?utf-8?B?Tm1MRjg3M05ZaG5tM3o2cVR4UUdaNVNLK3poVzFSamVUV0JLRHVzSWZPMkxq?=
 =?utf-8?B?T2NGbnBGd2VOaGVDZTFYbW80VmFmbDF4QUsyb0hqM2NCL21EVDB3WFBhcG9H?=
 =?utf-8?B?TnVhSmZOY3ZhUG1tVnc3R1ZNMnNoNUZqVW13enVRdW0rRnhwVE5kdVFUa0F5?=
 =?utf-8?B?RzBoZVBDc0lyQ1VIWkp4RElNclduRzdjeWozK09NcDl1TENkN0lZZzF4Q1U3?=
 =?utf-8?B?WWV3OTk4cnBpbmFwalNUNVk5MjBKODg3L1Myd0s4dWpVbEFYNnNpRDdPdDFT?=
 =?utf-8?B?cSthRENHZytkdE9qSml0KzlEOXU4MEtvY3hRS2JhVERCNWgrdUJKNEdMN3R3?=
 =?utf-8?B?QmVURHhWdTEyTnEvM2ZUNE9QcmFXSWNKMVJ3TTU4U3Q3QndHSXVEenNnellu?=
 =?utf-8?Q?zNU4WO/P7/56DbQZsearzGFKL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fd5f8a-7e4b-4c83-ecae-08de28e466f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 09:57:37.8146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OP/cAWirPs4msITApFpJYT0wj8/dk8Az1taTdo5tI5fOYwSgFglzmY4WQIoYSPLIVVDdmJwLrzCJQxN5Qbs7Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmljb2xpbiBDaGVuIDxu
aWNvbGluY0BudmlkaWEuY29tPg0KPiBTZW50OiAyMCBOb3ZlbWJlciAyMDI1IDIxOjIyDQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gQ2M6IHFlbXUt
YXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gZXJpYy5hdWdlckByZWRo
YXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRob3JwZQ0KPiA8amdn
QG52aWRpYS5jb20+OyBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJlZGhhdC5jb207IE5h
dGhhbg0KPiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRp
YS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsN
Cj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0K
PiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyB5aS5s
LmxpdUBpbnRlbC5jb207DQo+IEtyaXNobmFrYW50IEphanUgPGtqYWp1QG52aWRpYS5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMTcvMzNdIGh3L2FybS9zbW11djM6IEFkZCBzdXBwb3J0
IGZvciBwcm92aWRpbmcgYQ0KPiBkaXJlY3QgTVNJIGRvb3JiZWxsIEdQQQ0KPiANCj4gT24gVGh1
LCBOb3YgMjAsIDIwMjUgYXQgMDE6MjE6NTdQTSArMDAwMCwgU2hhbWVlciBLb2xvdGh1bSB3cm90
ZToNCj4gPiBBY2NlbGVyYXRlZCBTTU1VdjMgaW5zdGFuY2VzIHJlbHkgb24gdGhlIHBoeXNpY2Fs
IFNNTVV2MyBmb3IgbmVzdGVkDQo+ID4gdHJhbnNsYXRpb24gKEd1ZXN0IFN0YWdlLTEsIEhvc3Qg
U3RhZ2UtMikuIEluIHRoaXMgbW9kZSB0aGUgZ3Vlc3TigJlzDQo+ID4gU3RhZ2UtMSB0YWJsZXMg
YXJlIHByb2dyYW1tZWQgZGlyZWN0bHkgaW50byBoYXJkd2FyZSwgYW5kIFFFTVUgc2hvdWxkDQo+
ID4gbm90IGF0dGVtcHQgdG8gd2FsayB0aGVtIGZvciB0cmFuc2xhdGlvbiBzaW5jZSBkb2luZyBz
byBpcyBub3QgcmVsaWFibHkNCj4gPiBzYWZlLiBGb3IgdmZpby1wY2kgZW5kcG9pbnRzIGJlaGlu
ZCBzdWNoIGEgdlNNTVUsIHRoZSBvbmx5IHRyYW5zbGF0aW9uDQo+ID4gUUVNVSBpcyByZXNwb25z
aWJsZSBmb3IgaXMgdGhlIE1TSSBkb29yYmVsbCB1c2VkIGR1cmluZyBLVk0gTVNJIHNldHVwLg0K
PiA+DQo+ID4gQWRkIGEgZGV2aWNlIHByb3BlcnR5IHRvIGNhcnJ5IHRoZSBNU0kgZG9vcmJlbGwg
R1BBIGZyb20gdGhlIHZpcnQNCj4gPiBtYWNoaW5lLCBhbmQgZXhwb3NlIGl0IHRocm91Z2ggYSBu
ZXcgZ2V0X21zaV9kaXJlY3RfZ3BhIFBDSUlPTU1VT3AuDQo+ID4ga3ZtX2FyY2hfZml4dXBfbXNp
X3JvdXRlKCkgY2FuIHRoZW4gdXNlIHRoaXMgR1BBIGRpcmVjdGx5IGluc3RlYWQgb2YNCj4gPiBh
dHRlbXB0aW5nIGEgc29mdHdhcmUgd2FsayBvZiBndWVzdCB0cmFuc2xhdGlvbiB0YWJsZXMuDQo+
ID4NCj4gPiBUaGlzIGVuYWJsZXMgY29ycmVjdCBNU0kgcm91dGluZyB3aXRoIGFjY2VsZXJhdGVk
IFNNTVV2MyB3aGlsZSBhdm9pZGluZw0KPiA+IHVuc2FmZSBhY2Nlc3NlcyB0byBwYWdlIHRhYmxl
cy4NCj4gPg0KPiA+IEZvciBtZWFuaW5nZnVsIHVzZSBvZiB2ZmlvLXBjaSBkZXZpY2VzIHdpdGgg
YWNjZWxlcmF0ZWQgU01NVXYzLCBib3RoIEtWTQ0KPiA+IGFuZCBhIGtlcm5lbCBpcnFjaGlwIGFy
ZSByZXF1aXJlZC4gRW5mb3JjZSB0aGlzIHJlcXVpcmVtZW50IHdoZW4gYWNjZWw9b24NCj4gPiBp
cyBzZWxlY3RlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNr
b2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IE5pY29saW4gQ2hlbiA8
bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gDQo+IE5pdHM6DQo+IA0KPiA+ICsrKyBiL2h3L2FybS92
aXJ0LmMNCj4gPiBAQCAtMzA1Miw2ICszMDUyLDE0IEBAIHN0YXRpYyB2b2lkDQo+IHZpcnRfbWFj
aGluZV9kZXZpY2VfcHJlX3BsdWdfY2IoSG90cGx1Z0hhbmRsZXIgKmhvdHBsdWdfZGV2LA0KPiA+
ICAgICAgICAgICAgICAvKiBUaGUgbmV3IFNNTVV2MyBkZXZpY2UgaXMgc3BlY2lmaWMgdG8gdGhl
IFBDSSBidXMgKi8NCj4gPiAgICAgICAgICAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9ib29sKE9C
SkVDVChkZXYpLCAic21tdV9wZXJfYnVzIiwgdHJ1ZSwNCj4gTlVMTCk7DQo+ID4gICAgICAgICAg
fQ0KPiA+ICsgICAgICAgIGlmIChvYmplY3RfcHJvcGVydHlfZmluZChPQkpFQ1QoZGV2KSwgImFj
Y2VsIikgJiYNCj4gPiArICAgICAgICAgICAgb2JqZWN0X3Byb3BlcnR5X2dldF9ib29sKE9CSkVD
VChkZXYpLCAiYWNjZWwiLCAmZXJyb3JfYWJvcnQpKSB7DQo+IA0KPiBEbyB3ZSBuZWVkIG9iamVj
dF9wcm9wZXJ0eV9maW5kKCk/IEEgbGF0ZXIgcGF0Y2ggc2VlbXMgdG8gZHJvcCBpdC4NCj4gUGVy
aGFwcyB3ZSBzaG91bGRuJ3QgYWRkIGl0IGluIHRoZSBmaXJzdCBwbGFjZT8NCg0KV2UgbmVlZCB0
aGF0IGF0IHRoaXMgc3RhZ2UgYXMgd2UgaGF2ZW4ndCBhZGRlZCB0aGUgImFjY2VsIiBwcm9wZXJ0
eSB5ZXQNCmFuZCB0aGF0IHdpbGwgY2F1c2UgIm1ha2UgY2hlY2siIHRlc3RzIHRvIGZhaWwgd2l0
aG91dCB0aGF0Lg0KDQpXZSByZW1vdmUgaXQgb25jZSB3ZSBpbnRyb2R1Y2UgImFjY2VsIiBwcm9w
ZXJ0eSBsYXRlci4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

