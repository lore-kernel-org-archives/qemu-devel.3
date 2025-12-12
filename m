Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9886FD41D74
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 00:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTqwU-0003lm-8M; Thu, 11 Dec 2025 19:23:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTqwR-0003kV-3D; Thu, 11 Dec 2025 19:23:27 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTqwP-00064E-Bn; Thu, 11 Dec 2025 19:23:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USn4gzyyxyGapUAHMyShBgc7esnjYutCJ3M/yH6Y2wmj0HCCQK4iB38BCGz7vcgPE1dg4TnSlvKFgtBD4NvsB+nBwShHMBsJ0v4/ZTdieYvQrzzQDJipaowwk0kJ8Bbydvobi6y/M5B9Ohp5gyUTHKwf/0dkg94LqS9/4St4BHSKqUBcp7Ts0GKnd30scWKXh5e56863ykNqWAjsR/8Xndd4E02uFLo6lfVL9q/pFbzAX7ijcaV2GtyPenHIuS8m+nOPeGAPAqBtn1gjzagTt2MUoTixqDeyGDPuR1qSF3afdxilbeRVpHKjDa5gz6/dm1E0CQAWE+d4U0KbtKBAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=beVPEsO1l+oPQQZ5HoBa+j50Ap+25sVH1jdVUF7xjPY=;
 b=LSpg/aqjzoOIr7P2QB101L8EpQcNocxlu0OXr90wiLfgyfwuy8K6UrTFbfs/3NE4s3lY+zcrpB9ZmbVlMS5ko6IRbOf0d6acetdYbcf0lVnFuNUf9e7KT/PO3ajuaVVPiKVzm626bGanJIdlRHaA0qt537yV9bZaeEhL37hoWktyHUWKfRoJtKirn+m6ZPFDXkPQnV/AT21T0les5W2SIAN9pPLm8K6foMTcu4E/XK3UFZKXyGuHDBC05lsTITeBsHC17c56fu/VcHprgBhi5mpAQlYmzswEe+upjH/c4E5W5tJmLjde6g9cocXEcpZTv3Z6oSs3uMU9FMn8dpS82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=beVPEsO1l+oPQQZ5HoBa+j50Ap+25sVH1jdVUF7xjPY=;
 b=IIe7TmVH/QxaEv+6G9F004VZ7maOC59IrsIUWAiP85nqzpQN6VDCsFfLtCinwWeHEt+x8mI1oocEJ8PW0sGkfkjb05goSuD0/4Sdel/a+FQX17e0i7q0gf9cSXx9KFFKcFB7qD674hZzrcg8J83EnuOx6tJmtmOxumWx1EFXlA32KHBgbyAfseh8dpCHhOhbTZzNtzlSa1IHWlbxP+bRtPkcwVNgUnZRHbIRCKT8s5/DrNTbb8Xn9tllcqxLPMs/92LT6U329TTq8Z4Xmo0TIj/ByTbwZcb/qI9s4qUZ+3Jen29Sp1uWo/HxScHRgQKHToA7KK/+ISLNvZu18A1sCw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by CYXPR12MB9388.namprd12.prod.outlook.com (2603:10b6:930:e8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 00:23:17 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 00:23:17 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [RFC PATCH 00/16] hw/arm: Introduce Tegra241 CMDQV support for
 accelerated SMMUv3
Thread-Topic: [RFC PATCH 00/16] hw/arm: Introduce Tegra241 CMDQV support for
 accelerated SMMUv3
Thread-Index: AQHcadocqMzkFAhYTU6WU1M92/lWQLUcuskAgABsA6A=
Date: Fri, 12 Dec 2025 00:23:17 +0000
Message-ID: <CH3PR12MB75483AF12699B30402BAACABABAEA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251210133737.78257-1-skolothumtho@nvidia.com>
 <e58763db-6005-418a-ba18-0acefb626929@redhat.com>
In-Reply-To: <e58763db-6005-418a-ba18-0acefb626929@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|CYXPR12MB9388:EE_
x-ms-office365-filtering-correlation-id: 934604df-7688-4852-ef7b-08de3914a5a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UkFlS2hrZU9LV01yNXpyNDdOS3luS3pIVUptdEVUd0NzZG9HeHhoeXROUTdx?=
 =?utf-8?B?dVFtTjB5dWt4S2c0UVZaUkZNN2hIcHFEQVJ1RVdxTmdvZmtmOXI0VTVQMFBa?=
 =?utf-8?B?LzlXOXhJeitkZFljc2RMRXdpV0QyYXZnZUVuS2dTbUZGM1hKMklHNDBHQVRG?=
 =?utf-8?B?WU9Eczc4TFNqN0M2VFR5NWl4ejZyUTczWnRjZXJ6YTZaZ0VUcFlkK2ZQRURn?=
 =?utf-8?B?WlF2VzUyZG1jUFVha3EyaHVsUmltNU13WU8xZ1lQOFBjWFYwSzlCN0xNNDlU?=
 =?utf-8?B?ZTNYOWZjakh2N2xJUUFGTDUrM3ViY3JYUGsrcHRPcnY3OWplNDhLQUpib2Jt?=
 =?utf-8?B?UVd3TFRVN1JvT21lQlgrcXg2WnkvNDF3RDRvWHNwa1lDWEx2ZEJvQk1VMDJJ?=
 =?utf-8?B?eC9iTGlHN3VseEFhcXJNb0JleGIvWVJ5TWZMb3ZRUlFvTndrZlczSDFyV1dm?=
 =?utf-8?B?cDdxVHVKWDUzYXE5MEJUN0ZaRitrNkpiVk5UeFpRN0tDSGpKaGNhRklPN0x5?=
 =?utf-8?B?NzY3QVpWWWl3Z3BEMnkzL2VxRUd5Q1NsWjNoS0NnT1I0WGlPM2ZjSFhBZW4z?=
 =?utf-8?B?TE8vZUluVUdDYXFoZW1od1BkOXI3bjB5dUxOYXUySFFkZWRnQVNrUE1WbXpl?=
 =?utf-8?B?TWFpODhYYmJVcGhDMGpvY0JNSDlhNlFBNitoQXhtWDRSN3FpK3dycmNDaTJI?=
 =?utf-8?B?S2RSUk0ySlNQUDluTXluODVieXZ6TGxNRi83bmZUcFRldWswVk16Z0hzazVB?=
 =?utf-8?B?cHdlSkxWVy8ybFNWOWtRYkVkeUJRNEFnbGdINzRkSlhoakRYZXBwN2d4TTB3?=
 =?utf-8?B?ZytyalBZVmVYUXdVR0JyOFpMWktzaVA1WWVjZzdnWE5YRSs0ZGdxMWtJN1RP?=
 =?utf-8?B?OFVnVm40UEd4SG56WlRoTWt1Tyt1VTh5MERIMjlzTWVpWmhKVUFuOVJzSlFE?=
 =?utf-8?B?MUFvMHRDZXkvaWJrVS9xa3B1dU9GaVBzOVJOeVRtMFhDSUpLTlVpZU53Q2lo?=
 =?utf-8?B?MFQ3cnVTamxjamNZZXVLdHJ2TU5YR0dCOTVnR0JrWko5clJlZDFtMmhVKzl1?=
 =?utf-8?B?SGF4cDdaUzF1QkRoOENiTkN6UkVKMkxYUVZDRnYxZ1VYa3g3SVd0bWgva2J4?=
 =?utf-8?B?N2VDdEFGQmlWTDExa1Nsb0l5aGZQTEJTSWNLeVN2cjNiK0pMTW1kYStXTS9u?=
 =?utf-8?B?aGpRcklCcG9wM2Qxa29ERmswaXdEaFJwWXZ2bTlpcTVrb0lUZEdtUHRVTWs1?=
 =?utf-8?B?VHlObGZVV1k4L01UZXhpMTk2TkZRY1hSY0ZDRmZ5Sk51bjlEZ0NpQ05LRWoz?=
 =?utf-8?B?eGYvN0JueTlxZVlsVHhERjZFOCtIV2xYQnVKUjU3NmQyUnNQd1gybUVUeFRK?=
 =?utf-8?B?NEN6cDVIZk5jRklORU4rcWV4a1JodjZxYS9XWFdxQmQ1VWtMcncrdEZ0N0dm?=
 =?utf-8?B?VVhkVkdhUHJUQjBpWjJFV1h2QXkyZG9neWd5MW50S0ZNRlRmUWVJUFlSZExx?=
 =?utf-8?B?R0NuRktaclBEUGpmdkFVd0k0UjhwcmZleFNHV1RwUUl6cFNSOVowL3d3Y2NQ?=
 =?utf-8?B?ZENQZ0FibVM4RmRPbkMycTdiYS9UcStab1JLaGdYOFJKbzVwcmlpckJOMm5i?=
 =?utf-8?B?UjhMRWthK2U3K0I5TTVlMnkvbmJ0cnFXREVUeFVtd2ZEaWpRb2NXNGpHR3NF?=
 =?utf-8?B?RjNkQUZTKzFKbmRwM0MvL3VaQ2xzVENUSWRHdnVxQmxnelNZcC9YVFFxc28y?=
 =?utf-8?B?bzVvdXdndHkrV0xWZi9hNEZVQUdMWTZQeUl6czFEQU1qc0d2UnI3YVJaa0ll?=
 =?utf-8?B?dTVEQnpDUnM5Q25qcENjdWc2b0RFTzFWaVpMNFRsanpmcmtJb3VxbE9BKzdS?=
 =?utf-8?B?ZjFUTldNWDVCTVZlWDJydm1PcnJLYXk2ZW9lNjU0MWxqWW5UWXVhQ3Q1VW5U?=
 =?utf-8?B?L2RRdHRhZ29yY1IrVERUQ3Ivd0w0SFRFanNBeklPUEdwV2c2UWNnMS8xT21Y?=
 =?utf-8?B?U1IvTm9hMlZjN3JlS0k5ZitWdUN5NG5wYU1CL1lHdng3YUYyWlA2RmpXZlpQ?=
 =?utf-8?B?RVFzMXNLU3NvR1F1aGxjQ0RLL3BFQ04xU0pjQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXFyNDE2Nk1nc1o1YXpvZHpjaitsTWRESnljUTV5S004MW5PRytJd0lxVmNM?=
 =?utf-8?B?WHJmOE4yZllnZ1BoRytNT2lSMzZvTHliVWZNOCtFa25Wa0YrMFVUbzhZMmZ4?=
 =?utf-8?B?WGUzS3A4d1lKM1hUWXVpUzVnSGVGNkxIekMvZllHcFJkeFgvTGMvMFlnNFg4?=
 =?utf-8?B?bkRFbVg0cnErRWo0UUdIQkhwTkovYUs1Rjlma3Q5dFg5ZnZpRGdVVUlwbTds?=
 =?utf-8?B?VnV4aTdJZklleWlMbVBUWFNMcWwzdWFGZ0FlVk0ybDBmTVE2NHRSc2x1R0Q5?=
 =?utf-8?B?c0pUSlhGZGVCOTgrdmZTQ1hyWTcvU20wZTZlaFFCdDVtS3YrV0tEL01ZM2Jo?=
 =?utf-8?B?U1luV1oyOWphaFRHYjVaWjBkUmlLY3RvSFlwdDJtTk5vbTlVYmtxenlONjBw?=
 =?utf-8?B?UDJ0bHkwc3k3Sy9LQTdZVmFSZzFEYnR5aGZmTzZMVXQyVGt2dlRlSWVYTThW?=
 =?utf-8?B?c0RaMkNobUJ5cGVSbUFaeGlPSHBXditoMEZEbjFMbzNIQlZXY2p4Umo4Vks3?=
 =?utf-8?B?ZlZJcllZclkxMmxRNENRYlFOY2dIYTZ0UC96M0EwWDhreFhHQnZIVWhjNzRn?=
 =?utf-8?B?UFQ2SG45eWZqQmg1ZXJYMlM4K2dpUUw4RWV2NkVZZjk1RCtFY0ZmcUhlSVRF?=
 =?utf-8?B?ditxVTN3SzgwYmUxSDRkUW85ditMZTFIUDBqc0hzVGlPK29RQUJaTzZyK2JJ?=
 =?utf-8?B?WTlzTHI0ZUVySElVL0phcWtwWXBIeVJNeE05TTUzRlB6RWE5aGdjUVRqRVha?=
 =?utf-8?B?cm1uMGhEM3dQMENycldqd3V5Qjd4UWtLcDFVSkZwTzFHeXBUQzEzTmo5NFhI?=
 =?utf-8?B?T3p6d01QdkxPV1o1M3k1MU1DN3dxazRqY3RWZkUxa05TK1o2aHUxK0d1NThr?=
 =?utf-8?B?N0RIcWNhd3NVQ2FoMThERWZ1ZFR1MkcrVEs2eXcxeGFWVzNENkpBTmxZcGww?=
 =?utf-8?B?NUN3WFpwVXRsNkVBM2gxM2ZEQWpKcllvejRVVTdWY2tDYVl1WW1abzZWTmlL?=
 =?utf-8?B?cC9iWVRJYWErRU1xang0ZW9mVDZpME9tbzV1Z24yb015SW80bEFlKzc1WHBT?=
 =?utf-8?B?cUljMTNWOUNYMEZ6WEdzaWxvb1h3VVM3QXZsRzN0K25mU3RicUtMZXd2NXJ5?=
 =?utf-8?B?aWo5NUxXbGJHTmtGYlpkZ0FxbWRIRVI1OEtDd0NwRnNkVlZLNkFoeVNOWUdj?=
 =?utf-8?B?QjRLMVRHbUNCdWk4MUZ0cXlDMEhISklta2pLR3pCa0dqSkM4SStVSUFaWTQ1?=
 =?utf-8?B?VFhMVkZJdFFKVFJhajBhVkdvUkJHVDRtUFVXTE1RSDZOK2pDcHFJL2l4dFVs?=
 =?utf-8?B?ZEQxc0hFNmtLdFlKWFdrZ1ZZY212bVFrWFcrNGtHMTJCcTBWMVFjdnhSZzRD?=
 =?utf-8?B?NHBJOXRDbjQvdzN1KzFUbkhzTkE3SlRVTzNmVkt3QnJXR01xSHZaZFk3Nm05?=
 =?utf-8?B?NEtKVEJOZy9TU2Fsc2QzVzVFbXZLTVFpT0tOSkdoQVRTR2ZBZzNnV1hNc3dD?=
 =?utf-8?B?MzZxYkwrREdXdXF1blhBZ08xR2RUMVhkTUM2bU4xU3FkNi9ZcFNpR2tuQWZt?=
 =?utf-8?B?Z3prSEt3NXZIeS85N0JzTnZhdy92SWI2MC9BeWtXSUlVRDBTbE1MaFpnZnZu?=
 =?utf-8?B?WDU1ODZpakkvZTRVZWMrWHFobXh2SDdwSEVwRTY4R0NoR0p2VHozRTg3UGFm?=
 =?utf-8?B?aTJKWG5yNklhdHRrTVBqVThjYWZVZG1tZ3J3T29tVXpYR1BZQzVDMUZWTno5?=
 =?utf-8?B?bVNxUURCc25yczUwTXlhV215WnVudisxVUlOcUVkQWF3MXkyS295TVlkSEhI?=
 =?utf-8?B?aUxHM0NDSGRLbkRFa0tVUjJyRnZIYVpaY2kvOFhTQnhrQVo1TGpUdjFvWWRv?=
 =?utf-8?B?N1NGVlp1bkE4MUdBUGUveVZHTnZMZmloUDI2bjZYQTU5ZnBRd1dsRUh4Q2hD?=
 =?utf-8?B?bkErOHR0YzQvNndzTEk0eEM3YWh6UUhFS1VHUDhET2JHZnk4MU1xNzBRVWZx?=
 =?utf-8?B?MjZtM1pzTk92UG9IRFNTM2FMN1hUc1ZJeEwxRDZMakNjWml3UlB5VlZlUWxR?=
 =?utf-8?B?UjBGR09qNHA5bEd1ejQ1OTlXdVVqdGVqakM3TnNaRlRxd2JmZS92R3ZzTnRU?=
 =?utf-8?Q?Lkspjy/NQeheUb5yIRqarAfv3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934604df-7688-4852-ef7b-08de3914a5a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 00:23:17.3726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hew/OrROitzuT3mULunMmo72HAKI3NnZ+yv3rTrYT2pGxHDbDzbB/AGZbWA7xdrP7KCRMWRQ3LLvOLa2xhRCSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9388
Received-SPF: softfail client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDExIERlY2VtYmVyIDIwMjUgMTc6
NTUNCj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsgcWVt
dS0NCj4gYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnOyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBO
YXRoYW4NCj4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzIDxtb2Noc0Budmlk
aWEuY29tPjsgSmFzb24NCj4gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0aGFuLmNh
bWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9uZy5k
dWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMDAvMTZdIGh3L2FybTogSW50cm9kdWNlIFRlZ3JhMjQx
IENNRFFWIHN1cHBvcnQNCj4gZm9yIGFjY2VsZXJhdGVkIFNNTVV2Mw0KPiANCj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCg0KWy4uLl0N
CiANCj4gDQo+ID4gWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTEx
MjAxMzIyMTMuNTY1ODEtMS0NCj4gc2tvbG90aHVtdGhvQG52aWRpYS5jb20vDQo+ID4gWzFdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9jb3Zlci4xNzUyMTI2NzQ4LmdpdC5uaWNvbGluY0Bu
dmlkaWEuY29tLw0KPiANCj4gZG8geW91IGhhdmUgYSBicmFuY2ggdG8gc2hhcmUgd2l0aCBhbGwg
dGhlIGJpdHM/DQoNCkhlcmU6DQpodHRwczovL2dpdGh1Yi5jb20vc2hhbWlhbGkyMDA4L3FlbXUt
bWFzdGVyLmdpdCAgbWFzdGVyLXNtbXV2My1hY2NlbC12Ni12ZXZlbnRxLXYyLXZjbWRxLXJmY3Yx
DQoNClRoYW5rcywNClNoYW1lZXINCg0KDQo=

