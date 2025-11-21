Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB74CFA76B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMO2J-0008JI-QY; Fri, 21 Nov 2025 05:06:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vMO0e-0005Rs-V6; Fri, 21 Nov 2025 05:04:59 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vMO0U-00087w-V6; Fri, 21 Nov 2025 05:04:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDecI3lurIBNM5mo+fPqx4l4vexKFvGLMrDfsy6TZetor5zWhl+IFB96XSUOB7xo0RUgAlZfWAzo9fPWWDvX88E2eozMBC9EnMWZMA57nltSECQtoEYbbcsK/0eMtRZj+K40rywLk9+O9WFlxCciFlAOYBo/gu+QqdEYCTHd9cH+4VphVS5Gq1MPyr1vB1i8m+F91FmL+NptOAcnBx0T2TOx+H0mH8baCrZI3+Q4Pi2SDA1KFj4lIO15JHkEUS/cMRA5OzGSURuvHrnGmg3fcF++ZiSV2USePimQEdX8RSp1N0L7ACQ2ZV7BgOCIcA44lVWUpdXeOEZh78RQ3t+v/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwA3bpwInbzzYPCY3mz8t/wgUoVt6bvfzzEFNGSr4Xk=;
 b=c1zny+7q525EPXK5y2C1YS595tZ4p1J1qap3/pb3WjEcHVuFq1PpsdJJaUaVUHM4CaKeXVtdGbjGIYzlyye4YWrGU18Vqv+/TkxKnlUhSGCXdULhfEfj3eko5BcERmZoCJsdSmDzh6ZONNZQMAl5rJpsTlYEK9OMfbpBTEOUlNtR0n+bilkpUMxURVb6DuJro6Gm6KIshRuQjPjyWes0x0xhmEjQYmONewZ3sRhS1ovr+WVujGOxmk91uqMskiz+XpshYMFG1105n8O9cEdcC1xF7sWWJS7kvGcy5+qyuxJ5/V4SuOyCizi44mjNng0gwvYpp2H1OXf3GrzHsiTtxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwA3bpwInbzzYPCY3mz8t/wgUoVt6bvfzzEFNGSr4Xk=;
 b=gZ/pQuF8wV5A47sYlPoQl1+hpUW7TRYkrB5xvwnv4N83G6oZ2CMF9BdF1ccVkpBOP+izOHE7H135NHb32JpwGO6kg+ojeGAkbZDoZa9DYNIFwrxUC67BYq1RFnkC7b98BFy71cw3nq5rFFUEYYFPWxzlpNZPRE7tpZllIEMJPXshErB0HpovGa81YIDmEVvJz5cXv0flB9Dl9MbjvX5CEi23HtZv5mSwypKuJivQJkZD9OjDQ0BxmPX4HqyLh8torhVeIHsn29VXA46CJRioN04SM+FFyMomApZGqtkk6mm2pUI/fsHI0p/oD8SHOek7VzQPqnVNunHjoWwMRPaWQA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 10:04:19 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 10:04:19 +0000
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
Subject: RE: [PATCH v6 27/33] hw/arm/smmuv3-accel: Add a property to specify
 RIL support
Thread-Topic: [PATCH v6 27/33] hw/arm/smmuv3-accel: Add a property to specify
 RIL support
Thread-Index: AQHcWiHHmIDLFz+ZxkOXrYuQCfYugrT8FsUAgADREKA=
Date: Fri, 21 Nov 2025 10:04:19 +0000
Message-ID: <CH3PR12MB754824BF9B914E0DAE084F3EABD5A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-28-skolothumtho@nvidia.com>
 <aR+JgmAxA0GgJEyr@Asurada-Nvidia>
In-Reply-To: <aR+JgmAxA0GgJEyr@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CYXPR12MB9388:EE_
x-ms-office365-filtering-correlation-id: 8f0ba69e-215d-4b36-c53a-08de28e55648
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?aDVIa0RHMHZHOU5Cc2xuaHZSV0cydzk4Y2Z5TnpUL283VXViekNRYlZjOTMy?=
 =?utf-8?B?SThyclkvNkxGY3hHOTBXZjZ0OGpBdTNGbGxQL25xYzRiOURjM3oxT2VVNkF1?=
 =?utf-8?B?WS9kczZjamxuOTRYQnIzRW1wMmNLR2dKYkZYR2IzajZNNVNPQW04dUx0MnM4?=
 =?utf-8?B?bkpVQ0JOQkNPMkJ4TnVnVHo1SWJhWjF6UWRmUVF0SHNDSTFhNG9vakVCbmt6?=
 =?utf-8?B?U05iYlREdGdscExkbk5BUSt1VTltVGVMM3BGVnh6T1NBcHlOYWRGbnZ4dnhR?=
 =?utf-8?B?dnVmVVAyMUFLZnpOTFIyYmtlMGdySG9Jc21Nd1dTeSs5S0tWYktFanlqczNl?=
 =?utf-8?B?ZTA0NkdiMUVTTERHc01sK2lFQU1PSzdSOWY4RVJRamZCd09SRGxqQ2tMUWpD?=
 =?utf-8?B?OG4zVTNZNlBCTWVIUi9ibVRpNW9mRHpQTkM2SjRyQkxQRU9OdDFpQytRdGZE?=
 =?utf-8?B?Q2d3dG90TERJNDJIUzFtbUVYSHNDREhtU1hMeUtmRDJaNmt4OXdOTjlyUWFp?=
 =?utf-8?B?bVVKTmNOc1FoR1QxS1kwM29TK2NZaXhmZXhxSnBYeFlZeWwwYURjM0ZuQXpm?=
 =?utf-8?B?K1ZORXAyQVA0KzdRT3R6b0tKMWxFSGxVajlCeVZIRktOZm9WQkRra3N6MlJm?=
 =?utf-8?B?NGc3UzNOTG8xZGZxRTN1MllFdEwveHJ3bWRhKzQ2Q3oyc0Q2RFZOOUdEVWNz?=
 =?utf-8?B?MnBuNFRrL2FQTzlhZk90c2VXTlZvK3N1d3NrRDFTazdyMUt4VVRrQngyc29h?=
 =?utf-8?B?T29RMEpEcllFS0FYci9sVU51d1puY1RTcXJzVVBRanA4ZTIzRXpxWnozSzh6?=
 =?utf-8?B?eWVrR01nTDJFUFZ4U2xaWVNUcVBydVRwUW1MQVdoeXpaamlsd05mQnVXSXRy?=
 =?utf-8?B?ZnMvdHAzUnRLeWpTSlhRQ1Q2M3F0Rm9YeU5WYUVncS9UanZwNUNlVHFNMEJh?=
 =?utf-8?B?a0JFOE5zRnJ3Mm1oU1BHN293Y2dsQTc2M0VTQ1UxTTVWYkFiNUsvbEc3V29W?=
 =?utf-8?B?SzcrT042cFR0cjVZd3FkbGVOWldLd1lONk55TnIyWjVjMmhaL0E2Y3ZGdHJI?=
 =?utf-8?B?MkY4cHZvS1JKeE9Va2t2NUtJcTlMOHo4d1BoYmw0YUl0bkgvZkZRU3pDYm9N?=
 =?utf-8?B?QVl4c21HUWQwNmRqUDdCUzVjb2RrQmljTHhFV0FEZ21TUERab3o3RW05YUVB?=
 =?utf-8?B?ZnJJcWJIM3JUVFNmenBnczVlajBBd0FIakJYaGxRdlJZVWhCMzEyMjNCNnVm?=
 =?utf-8?B?clNGQUFsaFZIZEhySEVCTzFJWVllNllCaWlEL3FUbllrMEFTRjlTeTFNMHZP?=
 =?utf-8?B?TGwrTWhWNE5MdTRjeldJSlJKQWFoTUdaamJUOGg4endOYnBMaTJTajNncVVy?=
 =?utf-8?B?Nzk1dUU1WEthRGwvZEdFQ1VKSTNidHVTb1Q2UlU4Q3lYQlJpalhLbXlZM25i?=
 =?utf-8?B?Y0h5eXNXbnowbGcrOEIreTQxWTVBVExsZUtmcG5aMzRPMlJ0ZzNINEJxTXc5?=
 =?utf-8?B?VUlWV1JLRjdUaXpXdnVDUktuQVdoWURVdkdMTjRwKzk0QWJ4TUdPaXAxMStZ?=
 =?utf-8?B?czZDb0JHTy9VSkFaakdkS0ZSR01DYUNjcW9rYUJkOERzTk5idkROQ21McGk5?=
 =?utf-8?B?UDBzQ0dJODZiNjZaQ0lrSWxGRG5ueFl0WVRyY05lbDQ3ZlhYR3ppbzlQTWZO?=
 =?utf-8?B?YjRTTTZ3QXlYUHkwNG5CZEpIdFNHUm9SL2kyR0psczgrVm5ZblNwb3pENFlm?=
 =?utf-8?B?bjF2R255OEs3eXBGQlU1VjRjdTQ2d1laelRISkRHTVJteUVBMmwzQmU5V242?=
 =?utf-8?B?THZWMFlHWTRsUlBWaGtIZUEyVEgxRVR2WmJTNUpHUnMzcUQ4TEFVekdlcmRm?=
 =?utf-8?B?eGtHY0lIbWF5NUREQjlscXhEME96WmpwMWdVQ2RERGZ6RHVkYkxpcm5HSlJD?=
 =?utf-8?B?L0kxZDlNWlNMdW10N21kUFBEK2kzMkdOZHdwb2F3RHRRVG1uSEFnRzJ0cHFD?=
 =?utf-8?B?TDFESUoxY3o4RkJrd1NCRUZKSTZISTZMUXNrZFNSV2EydFlMYXBVYU9ab2Ur?=
 =?utf-8?Q?bQDgd4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SExldlNkU05FeUZuczZEa2UwRmVZWmMycUF3WVFuM3ppVk85UWNzRkQvcmNj?=
 =?utf-8?B?WStmY08zWVp5aWdZR0s4UDk3bytkeHcyQzJHaGQ5SDNNUWpKRWFxSlNUYW5D?=
 =?utf-8?B?TG9Kc2dYeDRlOGVBUmtkdXRrV1Nyb0cvbUNkQTNzeDZHZ05raXBVRVdiQ2pa?=
 =?utf-8?B?RlBCL2ZjQWYwdWYxT2JZYnUzajd3Z090Z29xazJ6K0tmVm82TXduaDJUTEtj?=
 =?utf-8?B?K3h2Vmc0Q24wbnQydjVZTUV2SW9xWXNGTmdod1pQdkpwemJxczFzbktCMnlQ?=
 =?utf-8?B?OXp4OEtjeXZBYmVWN0ZZSUtEY1ViOEVBNEk3Vi9DTDNwaTdTdjFqaXNjbGxi?=
 =?utf-8?B?VWtHM2xsdE1xOGZOTjl4bjR1RDMyM3c5VUlCWGZSOGt2bWZ3QWxybjU0RE9E?=
 =?utf-8?B?V1dsaExTdlFPc2lsZmh3dFY0Rkc4RFYyVEJkQVE2cDVPNGprSlhrdXRyaHlQ?=
 =?utf-8?B?YW9YckZGWG9zTm9wN09sZGlObXNMaVdIQWwxZytCaG1JSXpZSFZrTGRBVzBM?=
 =?utf-8?B?amY0NnNNNUxiQUlheEtFbzVFcldCK0JpOWhDam9KS0preWVkZ2w1L3UvK0RQ?=
 =?utf-8?B?TS8yUVdiTU53NGM2alYzNWl6MjZxUWVtQnk4L1pOV2xzK2Y2UGtZcUVGVGpu?=
 =?utf-8?B?VXhIQXlkeSs2Y1ZLYVl2VHpOR3grc1B3a2MvSk5vNXpqdjJVREQyOUxFTG1j?=
 =?utf-8?B?Z1dmbGJTR2o0STZFRG81NzI2eWxyYVFkdVJFRTVYM3BtMGlZelRRVXdLdU1H?=
 =?utf-8?B?dUd5MkE0OFI0SFYxNGNYOFcvaklJb2hEZ0FOVTV0VnNXTjR4TUxYR1RoN3c0?=
 =?utf-8?B?VzVnSFVSUlVYVW1JZlFaUFRkN3o1NzU3WU84cmR4TTNYNHNwSXNzTHE2M1pz?=
 =?utf-8?B?K2ZMVWRxdGJ6c3VYUmVub3R2NU9CenFyTHJOZUdWYTE1Qy9vZ0tEaXZ6M0hY?=
 =?utf-8?B?RXhiaDQrbytiWlJUbGxWYlpiTmQzd05qOXgxNmIxL1ErVnUxbk01ZzNDQTJm?=
 =?utf-8?B?TUlNU1ZLemRQL0Q5Y08xZUEvS2pxNXpUb3VFMGJpY0JZOXhRbWtHaDBVd05o?=
 =?utf-8?B?M2hFUUt2WEdmUUFFaFZNbXpIenRCbDlDcXYxUCtwaWtMcFFhMjdvUFB3dUkx?=
 =?utf-8?B?WThqMXB0c0ZBaWhTT1NIOUpSQlpoakFDNWtPTmZmWHozUGtCQTlmZXlKNFBy?=
 =?utf-8?B?ZW91Z1B1VWY4d1dpYjNabkZhSWh3bUVNYWkzR3dXTjhZUkxWeHBqRFMraUU3?=
 =?utf-8?B?TkpwNW1USDZ0RnhhYVRnNk85WTRKclNKVjJnWjhDWW8ydVNtOStSa01PMWhq?=
 =?utf-8?B?cWYrWUlWNWtVMWNRSEVlVEI0T0txYWtsUmo3ZWZIaHdxYi9Yclk1OWhET2U1?=
 =?utf-8?B?eXM0NVI3dmc4Tm1HN3o1TGoyTUZkejlZKy9Ma0I4bnpLTjNUaCthNFpzdGlJ?=
 =?utf-8?B?dHBIcFJ2R2g1VHpoZkZ3K1JBa1J0aVdKU2JYWmRlNlpQbmIxdFV6cG9YSk5B?=
 =?utf-8?B?VmNpMDlnWjhlMHZpUmhGMGNPaGh1VmpmQVBOVTlKTEttcEVxYmxZUTNnZ2RZ?=
 =?utf-8?B?SHV5Y2ZjSmw1a3NrbE44Q2pycUlRSlBPUXErZUZqa1ZTMitqemF3Wi9FVzk3?=
 =?utf-8?B?cTFlMGxKeDlBWnk2dnNBZk1IZy9uUldDbnB1eDZidWJndXFPZ05zK0c1RjNn?=
 =?utf-8?B?WjNQM1JFV2wrNUhNWHU4RlQ5OWN3WjF1MGMyNFZsTU1wRGpvcjlVQXZEVTBp?=
 =?utf-8?B?SWg0NGRHbnhkV3BsbldBQ2Nnd3pHQkRKUGpvNkZGR0ZYTllYOVNMRGMzK3dS?=
 =?utf-8?B?V2MvczloRlJRQnZLYmxldUx4MzFuWkRVMS9GSk9FeGRxemJ2SEtxQ3hGWVp0?=
 =?utf-8?B?VGE4L3F3ZzRGTDd3UkZhc0JpV2NYcWtheUE1WHdXcXR2YzFDNkpXUUZvSFpl?=
 =?utf-8?B?U3dBaGs3cVZIek1Cd2JsMDFDOHdDK29vazFzR21KbW02NDd5c2NKZTVhbDlF?=
 =?utf-8?B?WmFDQWVDaHh3YUdXbVBzTnRqR3hXUHBtVDZwV0JEZXRySU1wYXhma3hyYWlC?=
 =?utf-8?B?bVVVek9abnJtU1NCNmVzbHovdDdibE1tV0hDVy80MG9SVVZHWTJYdk5VN0tv?=
 =?utf-8?Q?2PglrBTH90X0bgajMpLmGU8RG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0ba69e-215d-4b36-c53a-08de28e55648
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 10:04:19.2874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LTwreHxk9DrHK9sQU4GSzH59Rny+qBHALAMvMCAyhNUWQG51QoTvoJh0q+qyO869u4mlpjJ2d/Cd4ohKBJCjrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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
aWNvbGluY0BudmlkaWEuY29tPg0KPiBTZW50OiAyMCBOb3ZlbWJlciAyMDI1IDIxOjM1DQo+IFRv
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gQ2M6IHFlbXUt
YXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gZXJpYy5hdWdlckByZWRo
YXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRob3JwZQ0KPiA8amdn
QG52aWRpYS5jb20+OyBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJlZGhhdC5jb207IE5h
dGhhbg0KPiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRp
YS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsN
Cj4gamlhbmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0K
PiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyB5aS5s
LmxpdUBpbnRlbC5jb207DQo+IEtyaXNobmFrYW50IEphanUgPGtqYWp1QG52aWRpYS5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMjcvMzNdIGh3L2FybS9zbW11djMtYWNjZWw6IEFkZCBh
IHByb3BlcnR5IHRvDQo+IHNwZWNpZnkgUklMIHN1cHBvcnQNCj4gDQo+IE9uIFRodSwgTm92IDIw
LCAyMDI1IGF0IDAxOjIyOjA3UE0gKzAwMDAsIFNoYW1lZXIgS29sb3RodW0gd3JvdGU6DQo+ID4g
Q3VycmVudGx5IFFFTVUgU01NVXYzIGhhcyBSSUwgc3VwcG9ydCBieSBkZWZhdWx0LiBCdXQgaWYg
YWNjZWxlcmF0ZWQNCj4gPiBtb2RlIGlzIGVuYWJsZWQsIFJJTCBoYXPCoHRvIGJlIGNvbXBhdGli
bGUgd2l0aCBob3N0IFNNTVV2MyBzdXBwb3J0Lg0KPiA+DQo+ID4gQWRkIGEgcHJvcGVydHkgc28g
dGhhdCB0aGUgdXNlciBjYW4gc3BlY2lmeSB0aGlzLg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IEpv
bmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT4NCj4gPiBUZXN0ZWQt
Ynk6IFpoYW5nZmVpIEdhbyA8emhhbmdmZWkuZ2FvQGxpbmFyby5vcmc+DQo+ID4gUmV2aWV3ZWQt
Ynk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4g
PiAgaHcvYXJtL3NtbXV2My1hY2NlbC5jICAgfCAxNCArKysrKysrKysrKystLQ0KPiA+ICBody9h
cm0vc21tdXYzLWFjY2VsLmggICB8ICA0ICsrKysNCj4gPiAgaHcvYXJtL3NtbXV2My5jICAgICAg
ICAgfCAxMiArKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9ody9hcm0vc21tdXYzLmggfCAgMSAr
DQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody9hcm0vc21tdXYzLWFjY2VsLmMgYi9ody9hcm0vc21t
dXYzLWFjY2VsLmMgaW5kZXgNCj4gPiBhYWU3ODQwYzQwLi5iNjQyOWM4YjQyIDEwMDY0NA0KPiA+
IC0tLSBhL2h3L2FybS9zbW11djMtYWNjZWwuYw0KPiA+ICsrKyBiL2h3L2FybS9zbW11djMtYWNj
ZWwuYw0KPiA+IEBAIC02Miw4ICs2Miw4IEBAIHNtbXV2M19hY2NlbF9jaGVja19od19jb21wYXRp
YmxlKFNNTVV2M1N0YXRlDQo+ICpzLA0KPiA+ICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiAg
ICAgIH0NCj4gPg0KPiA+IC0gICAgLyogUUVNVSBTTU1VdjMgc3VwcG9ydHMgUmFuZ2UgSW52YWxp
ZGF0aW9uIGJ5IGRlZmF1bHQgKi8NCj4gPiAtICAgIGlmIChGSUVMRF9FWDMyKGluZm8tPmlkclsz
XSwgSURSMywgUklMKSAhPQ0KPiA+ICsgICAgLyogVXNlciBjYW4gZGlzYWJsZSBRRU1VIFNNTVV2
MyBSYW5nZSBJbnZhbGlkYXRpb24gc3VwcG9ydCAqLw0KPiA+ICsgICAgaWYgKEZJRUxEX0VYMzIo
aW5mby0+aWRyWzNdLCBJRFIzLCBSSUwpID4NCj4gPiAgICAgICAgICAgICAgICAgIEZJRUxEX0VY
MzIocy0+aWRyWzNdLCBJRFIzLCBSSUwpKSB7DQo+IA0KPiBXaGVuIChob3N0KSBpbmZvLT5pZHIg
PSAxID4gKFZNKSBzLT5pZHIgPSAwLCBpdCBzaG91bGQgd29yaz8NCg0KWWVzLCB0aGF0IHdhcyBt
eSBpbnRlbnRpb24uDQoNCj4gU28sIHNob3VsZCBpdCBiZSAiPCIgaW5zdGVhZD8NCg0KQW5kIGdv
dCBpdCB3cm9uZyDwn5iKLiBXaWxsIGNvcnJlY3QuDQoNClRoYW5rcywNClNoYW1lZXINCg==

