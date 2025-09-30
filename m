Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796B1CCA46F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VUx-0004NE-81; Tue, 30 Sep 2025 04:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3VUs-0004Mg-2M; Tue, 30 Sep 2025 04:14:07 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3VUi-0006NT-Fx; Tue, 30 Sep 2025 04:14:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouPwLM4Tan3ZEJ0axfVySfuNet18DAPN1O5CbORfZGuJiUovKHa+5RDjY7WFOlZN+bDNJZBrc7KJN6MIlaK/enGZtIeZFdve+Onlelm2GeD9sERhpaHJl9/KKeiAkHYyB6r9VEZA8vtM0laqHgZDvvl1HpdyKEXSDbIplU7rWJJ+dWBskYD/MQoq2bdBafPkaBzdfXYnmfkyAV3TSzBXC0c5iOgUfwUVVpw//WZiBcIzbitxN5ff+ibg9nIVZpBpzTVm/ERzb9uOwoe7djpHwRB1kbMuuenYY7rk6MzkpYxfYuTYp5Hcg/V1+K/CU9ZSoAmwjym1tLnROyxTcJB/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vTdnbuCu9GQQFT1qcd3zpFwCXVRMIMzppsEAM67uLU=;
 b=qsDyj07+3n87dS0wzHoMD+CQ2nInHzWBKeq/trQsBEEffepqVR/K1DPofmrICytqb3inUDtf9+dXNqTODSSLBHUgjZWfW3ouE4h5+iFjDhmQTFTwmyHsQXDj+iMJZRh9wlGthvwGitfs/fn7ANM8TCCMZrgewUuf4EdelLhgm/8WqJij30m7qAHN1DImIIKziLTJcYZZvQO8Vtt11NzBNEPaLeg0lgeFZ+d6RszNGmf/zgm0Kaca91PUjqPJi9AAzSaaTqglusoJIdeH4NII2D8BhS/xIBdBy8hxxFcMxr5dvvgB1yS34iRHWYyaFz53pBDsKHOPgscJ48OTti7bDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vTdnbuCu9GQQFT1qcd3zpFwCXVRMIMzppsEAM67uLU=;
 b=NN/fyVGFenQ0D9qSGqtMBiAH8d7f5vHH4ofu4IrCMtGdvX3jvbZ1wvRnsodjt3s/ufDNc/Yuhxb6Ah19rrblXaDIO4QphlCbqHgcaqchHlkVKn9mz6Oi0XgJQMloboN9ydRAAC0qeLs7eWGLNmi6Vr1xmT6VAsvGjg1qqvFg0TzZas27FtI1W+kJc+zmPtsEruMtwV9LxuakCp51N+tHJb6DH2LI/9gyiMwr61owmKdjAQW3X74WUwD2OTkh3PomhEC1EcPB42J03Q0crkxRSBU9tavEctKC4O+bkVWgbCwLyISTG3SWmp3C2TkkZ+YAylHf93QT0kROzGO/5BIKIA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA4PR12MB9833.namprd12.prod.outlook.com (2603:10b6:208:55b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 08:13:44 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 08:13:44 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 08/27] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Thread-Topic: [PATCH v4 08/27] hw/arm/smmuv3-accel: Add set/unset_iommu_device
 callback
Thread-Index: AQHcMV2/Q/UaXF0y/0CBTpFuWL1mf7SrYKxg
Date: Tue, 30 Sep 2025 08:13:44 +0000
Message-ID: <CH3PR12MB7548C0DEE6396AB406EE5647AB1AA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-9-skolothumtho@nvidia.com>
 <20250929172549.00005811@huawei.com>
In-Reply-To: <20250929172549.00005811@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA4PR12MB9833:EE_
x-ms-office365-filtering-correlation-id: 2f91ebe9-e33d-4dea-bf80-08ddfff94621
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dzlmTTUvZlNPWXczTWRxbFNFRkdRYzIydWtnbGsxeVp1aTYwZWZ4dG80eE1u?=
 =?utf-8?B?OWN1UEtQb29TYjVseUxQYWdsMjRQZjg1TXA3K25uRFd5bnNXSTR0Q1ZOeGh5?=
 =?utf-8?B?bmJBR005czc1aWtOdERXMkFHQTRrNUxvdDJXcDg1SzAyMFRCVUdEOVVZeVJJ?=
 =?utf-8?B?VHZud2tFUDVTblV3eXR6Ky9iOXltMm9UOUIyWW5oaWpNWWtzc2l6WkdWYS9i?=
 =?utf-8?B?S0R1Y3lMcG1Yc0Y2Uzg1OFNTTm5BVFVDemVPVjhQWlJiWXpQQTU0bEFsRkFi?=
 =?utf-8?B?dWZYcjE0b0hlNDV0OFcrTXUzVzU2TklHUTJLSWZHNDE4R3oweGZNYUxSTlNV?=
 =?utf-8?B?OFkxWmMwTExGRVJqTWJiUUdtWEY0dUluTHZhd3JvUnNTTWtrUE5IRTJqa3Ju?=
 =?utf-8?B?bUR0N1JETXVuUC90YUpHbVdURk54SjNlVTFvZEZjSUVNNmR2RHN4d2dUdFdx?=
 =?utf-8?B?VktqbkZiVlNiK0Rva1MvMGdEUzBhLzlib0Z4ZlNwQnAzbmtsd3ZzU000b1V5?=
 =?utf-8?B?cFlJbGlDd3JpYUwzNGpibytzVTJNbS90OExyb3ZER2VTNXhjR3pjdURUQW9Z?=
 =?utf-8?B?djVvWUk3OHFRZnJQOVlLUDNBZ2FTa0ptOGxpRWZRa1dreE04aXJ4TVo2OENL?=
 =?utf-8?B?ZDNFb3dCNkpVYXZyR3RJY0xUL0REcENCbmZ5a0xGTEdwL0VFRjl1YmNYMnQ2?=
 =?utf-8?B?STI3UGZLeTM2YmhYR092b1lWQkcvVXBzNjJoVjNOV09xWEhSR0VnM0tSWGVv?=
 =?utf-8?B?dVEzbU92UklwcUppTjFIL3BDUHFLYVdvRHU0Z1Zka241NlJuRTNuc0lnTTdY?=
 =?utf-8?B?TEtBdGpxZGZjUlFBMHdNL0NSK0RKNXN0K1dWNEU1Y0h2RGt6T0tlSzRpSkxo?=
 =?utf-8?B?elp2cFp1ampLbWlRcFZxbEZ2Y1RsY3RQSXFYYmRBQ2ZLL2FLbDBuOVVtbWVP?=
 =?utf-8?B?WFNPWmxzenQ0UmVlQUppTFZGYlhza2x4VzZSUWh0TFloWGd2MVJZQmlWV2hK?=
 =?utf-8?B?SXBHWk5wUGRXSHlXbTVqeG9aQzZsby80bE9vVzlDcmVNZHI1dTN0aXJITnVU?=
 =?utf-8?B?VzZwbVJzdWtGbFZWcmw3SGFUMFF1cWQwQTJsVGNLV0tnem1VRGtKTE5rQ3Mx?=
 =?utf-8?B?Mmc4eWJhMFBLdjJvc0hoNGlhMDVjNnpvM0JSbUtneitzNFhmZlRXUDU2VG9z?=
 =?utf-8?B?Sm42OVZWdkl1K1pkcG1vUXR5dHVnZ1puVEI2dytpaVY4c1pvV2ZUMlFya0Vz?=
 =?utf-8?B?SDBCZEFSaHBNM3JtQ1B0M0htaGlMTVdhaDBXMHVvOGdaTWxra1NkOTEzL1VF?=
 =?utf-8?B?RklobTJldUtBcTB4cElHamI4eXU3NFU0U1M3R3FxNEFYN09WZ2ZKWU5UL3Bx?=
 =?utf-8?B?QVFYZVdiNDM3T3prMHZEZXZERFZoWVc2bnE1ZmdnNFpoZDZKTlRvNUVaaGFF?=
 =?utf-8?B?OVdmVlVkTzlJWmxoN05nd1AvaDErdE5ycEQvR2tGaUpyVU1FV0ppZWE3MTJq?=
 =?utf-8?B?eGU4d2dJUGwvTVVWbXpRMXJzdEhaUGppdjN0eDZiaEdLa0JSeWk2QmRDU1Yy?=
 =?utf-8?B?ME5SSWFWVHZtSFVrdkg0SWNtNm5qUGZKY1NXUHI3L1IrYW84ait1dGkrTDY0?=
 =?utf-8?B?Y2FQaHlUSXVQSU5Va0RaMi9yc2Z5OGlDUk03UXRXRHBGSHVhemVVSXhhR25U?=
 =?utf-8?B?Nm1wVkRlWWV5YmVkYVVpTzRENXg2T2RWYkQvRmdzRjNpVmNwSHQ1M1RwZkxV?=
 =?utf-8?B?bEJDVjNjby9RWHhtK3JYSDRBZjJnQmxSR0FBR3d0MURNU2l0RWFEMm5vRS8w?=
 =?utf-8?B?WURhYkR0ZVo2ZXpYdTM0YTNxRW1sRjN3bXE1ek9iTEU2UWpRcDB1RTVNYlNy?=
 =?utf-8?B?Y3RJTmZqZ1VWK0p3R2wra0VGcHpwb3doWUdRclZmUHpQeloxVUFzOE1HK0Zi?=
 =?utf-8?B?Qk1WV2xySWY4RGt0N0xGZDlHN2h4MzlOQXp3T3E2dTkramt6UVNiaEE4WEtS?=
 =?utf-8?B?cFpaWm8xWkx4WVBjdmVaVm1PaXJsWDNad09TaVY2dUQxa29ZY3hNRGFFNTEz?=
 =?utf-8?Q?b9V2b5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2FKQzJyeHplRVIzSjVxa0p4SWFpczVIYzNPR3pvQUVvQmxjYTBlUExyVVlN?=
 =?utf-8?B?elJEWlVLNUk0d28wcW5iVmR2a2tYZnpzdVlndHB1ajNNY2tFS29SNWhBV3Nn?=
 =?utf-8?B?blgvL1NXdnRwZWw0bkdpSURXNXQwdHZoaFFSSVljZjNGUGw4NWF5SE5SYUNn?=
 =?utf-8?B?Ni9IK3pZOEt1UzZGaXRGQkNlNFhTK2ZIT25uRjZaV2JZY1NVcXVweDVTWlZh?=
 =?utf-8?B?dFN5WXhGd1RCT3JTNVRob3RscDlvN2VFVTNXQWtNVUExNEt0TmR4b09vb2ZM?=
 =?utf-8?B?MENxbmhHL000UGI1R1Y0WU1Uc09lWHlSN01qYXEwT1pXWlQ2a0dianU4Zmp6?=
 =?utf-8?B?aXhWampqMW5oeWFlak9jc0IvYU5aTEtQMVNEaE5uMGd5RFdkaWhzNGR5bDFF?=
 =?utf-8?B?TGhTOTZJWTRzV1RVYlJBd01EVWFDS05scU5vbEhhZFJ3RFZkSFpyQWZxWi9j?=
 =?utf-8?B?Q1VmdEJ4Wk1pNTR3aU1URVZaL3daeUFnRkUvMlVmdWlsVFlUNTZoUEg0d0lS?=
 =?utf-8?B?bmtYYUs3QlptNlEyZlpCcEszY1crYkVEalI2U1lQTndBMlpBaG1GM29kUTdC?=
 =?utf-8?B?dGI0Y3VsS2EvNHlDeTZINit2M0tXeEpHRHpuSXh2Q09NQW5jZnhHbXh1eGpo?=
 =?utf-8?B?L3hQK1hRWEgxZy9EVUI1U3RxVHVYelJ0WCt4L1F6VTRrOHUwLy9lMy9LUjZS?=
 =?utf-8?B?TkJlQXY0b2xRTWtiMlp6aEVhb25FWkx2dklUUmJ0a0g1Yjdhc1o1OHBCQWpk?=
 =?utf-8?B?ZW5sK09QckVpTldHc0M4WmZnTGpJQUN6dnR1d3FxSWEzNkJranpXQSt1SEVM?=
 =?utf-8?B?azgyRkJzR3BkVkJZTmY4QnhSWHlaOXNHOVRZK0Q5RGRpWDJMSVRoUjVYRUVU?=
 =?utf-8?B?cnQ0N2pIWFJZUEZ2R2J3ZE5jYm1iMUs0VjhtT0RLVU04d05SN21valliZlNq?=
 =?utf-8?B?UmMyN3pmV3B6WE16U1o2TDA4VFRDL2tLcENhOEdnSTFkWVI1VktDY1Bjd1U4?=
 =?utf-8?B?YWM5Z3FnaEdEU1F3T1A0Q1RTenhOM0FvMUtvb0Q5Yk9LeFdkdHBqWnNKRDJL?=
 =?utf-8?B?UWkrWWF2L2FUVXZuakdUbUVsSVZHQzRRYXowcHRwZ2t2S0pSdUY1dWFlcXRZ?=
 =?utf-8?B?WG9oVzFOMTk5OTM3UnowYjZwNCt3L1EyYXQ3ZEh5SE5Ya09nS3hJNFFIVE9C?=
 =?utf-8?B?QmlQeTZKd29xNFZLNCt3NUpHeTRsMW5HWWNkaTRvYkZCRmVJWFI2Q1RGSmUv?=
 =?utf-8?B?cVFkQjg4ZEN2MEdnVHo1NWRNVkhGbEMxd2tCalh2U1pYVXYzbWhReWQ4dFpN?=
 =?utf-8?B?ZVRJdmdtcWoxT3VJRHZ3Vms2ZGtkZlRXb3h0TXZvbFpBY3dLcDVmZ05TY3Bj?=
 =?utf-8?B?KzBPV0lDS3RMMlNFRHk5RkJ6L25LamgrNDZoU0lVVFRiWkt5THNxd2xlSVRz?=
 =?utf-8?B?Zi9nTXF2QjNjNUdLTGwrNVY3OXZvOTlFVUh1YldTRVBUdGQzK1I3QjNPZ2Q3?=
 =?utf-8?B?SVRDQVNCY0dFME9vSjNPblVWR1J1Rmp5WWVxcjArOTloa3VYVm4zcGYxdUlS?=
 =?utf-8?B?b3JxTUNEblozWVk0SzZQUkcwSFM3TzhaY0VveWVLOUFOcTFRcFZDdSt4Nndz?=
 =?utf-8?B?NVRoTXBzZEZvdGw1d1JHT3p3UFFoNWE2UzZxcVNKQkhNUElJbTBPK1F1V09m?=
 =?utf-8?B?dG1POEMxRmVOdVdwVXNMZmQzYVY0cnRrK0RKeGxvR0pRUTI3YVgrNFJiOHg1?=
 =?utf-8?B?NUtheE0yZnp0NWFpYWNhM25ieGZrRmJsNDdnS1Q3dHZYUUNkaWVYMWx0MVBh?=
 =?utf-8?B?UUhJcnhuNG1Fc1l4a1h5ZXNQMnVBZ05DRXFTYTNISzU1VklheVlVcU90ajlZ?=
 =?utf-8?B?NU5ldkQ4VFl4TC92TnN0STRlR2FwYVFTdzNaT1pFeElScnJKY2hyZStDdDBm?=
 =?utf-8?B?S2JuVG04SjU5Nnl4S254ZjJENWZ2dWsrSnRLUjBIZ0RSRUZmSFFHYS83UWNl?=
 =?utf-8?B?TFpGOWJLaUJON2xWazJtN1RkSFhDaGRiZDM0KysvcHFhNkhqZ3h6V05rR2xR?=
 =?utf-8?B?SkRRNUJpYzhpYmZkSXE5WUlkdFBQZVg4empBbktScWU0cjdQdElOODdrVG02?=
 =?utf-8?Q?MxHav/xSvhhuu1yMS5I48PJvd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f91ebe9-e33d-4dea-bf80-08ddfff94621
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 08:13:44.4561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7Y7EZavinsdTo9oVrFkkscYvmmbuU1p9rfnTppuTjjO/e93Y2/VTIpfnfw6cwCc19rXo5DHIlhYo/vIMVMaWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9833
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPg0KPiBTZW50OiAyOSBTZXB0ZW1iZXIgMjAy
NSAxNzoyNg0KPiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+
DQo+IENjOiBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IGVy
aWMuYXVnZXJAcmVkaGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50
aG9ycGUNCj4gPGpnZ0BudmlkaWEuY29tPjsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEu
Y29tPjsgZGR1dGlsZUByZWRoYXQuY29tOw0KPiBiZXJyYW5nZUByZWRoYXQuY29tOyBOYXRoYW4g
Q2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzDQo+IDxtb2Noc0BudmlkaWEuY29t
Pjsgc21vc3RhZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5n
a3Vua3VuQGh1YXdlaS5jb207IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOw0KPiB6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb207IHlpLmwubGl1QGludGVsLmNvbTsNCj4gc2hhbWVlcmtvbG90aHVtQGdt
YWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA4LzI3XSBody9hcm0vc21tdXYzLWFj
Y2VsOiBBZGQNCj4gc2V0L3Vuc2V0X2lvbW11X2RldmljZSBjYWxsYmFjaw0KPiANCj4gICNpbmNs
dWRlIENPTkZJR19ERVZJQ0VTDQo+ID4NCj4gPiArdHlwZWRlZiBzdHJ1Y3QgU01NVVZpb21tdSB7
DQo+ID4gKyAgICBJT01NVUZEQmFja2VuZCAqaW9tbXVmZDsNCj4gPiArICAgIElPTU1VRkRWaW9t
bXUgY29yZTsNCj4gPiArICAgIHVpbnQzMl90IGJ5cGFzc19od3B0X2lkOw0KPiA+ICsgICAgdWlu
dDMyX3QgYWJvcnRfaHdwdF9pZDsNCj4gPiArICAgIFFMSVNUX0hFQUQoLCBTTU1VdjNBY2NlbERl
dmljZSkgZGV2aWNlX2xpc3Q7DQo+IA0KPiBEb2VzIHRoYXQgbmVlZCBhIGZvcndhcmRzIGRlZiBv
ZiBTTU1VdjNBY2NlbERldmljZSA/DQoNCkkgaGF2ZW4ndCBzZWVuIGFueSBjb21waWxlciB3YXJu
aW5ncyBvciBlcnJvcnMgYW5kIGl0IGxvb2tzIGxpa2UsDQpRTElTVF9IRUFEIGV4cGFuZHMgdG8g
c29tZXRoaW5nIGxpa2UgYmVsb3csDQoNCnN0cnVjdCB7DQogICAgc3RydWN0IFNNTVV2M0FjY2Vs
RGV2aWNlICpsaF9maXJzdDsNCn0NCg0KU28gc2hvdWxkIGJlIGZpbmUsIEkgZ3Vlc3MuDQoNClRo
YW5rcywNClNoYW1lZXINCg==

