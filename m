Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22341CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 16:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwNOn-0000bh-6E; Wed, 10 Sep 2025 12:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uwNOk-0000U6-1G; Wed, 10 Sep 2025 12:10:18 -0400
Received: from mail-dm6nam12on20614.outbound.protection.outlook.com
 ([2a01:111:f403:2417::614]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uwNOh-0005gK-HR; Wed, 10 Sep 2025 12:10:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhMzf1NibUrejpbbb9d4gHpVE+yywDQ/YhBroWlSQisC0842tt67UtSTSAUlMNNJYCHPlczFBXUKW9m7lffE5D5oFHe3zaQNMrILFbo0Ip2Lauhzwlm8V/xGeZQhfKlaTaUBKBcR5d/DoFdZlZ70ghd3lnU6Xjt+k3h8kbfNM84OOZv+WLLe565aET6r8jaUV5RtN6l+Dku8kOM2csn0qBxDa2QuWehHw8WTYLRDD+WN2qpeNzcOLgyNvM9gVTLFVoqgwtBpNYDi6GsmAxjyhxEYKIGjJelXu10QJz6N9NG7UYnXAhQXqQSIB1L5XZCqa1cf+Rk7RPQauLaTETgC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRvg0TcV4POm+MJX0ucycIM5nd1wgGxOGM8VpRqE8Cw=;
 b=GRamTExJtFk4jabEDrs59bjdEQ4ru7K4qUFHxafABU0e0wTH/f2/gyqtmPErptj+nj+ZkFDX4XgxQconwz4Fm4TNj7q9bj+7HUZikjqyWfBTwc109DO3A9PoYZwiFtn5PnoEHKki7hFr1m9wVuG/EVf4Isx37fh8juJvYSqEFNcRkMWVxKokeWUNhLpI495Otp485Snzrhv44k2i6uOdbUZhljGjRw/T9eqsuMDR5tdl4rvZw9W+cnv5b5OJPIck7JflBcvmuiCkB3Df6/EhN3V8jbn45gp/AH86ZZe2K6ltTshv+kXXpKEvEl9NiTrNO2h3lg/ZM4QNjqUOIx5P0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRvg0TcV4POm+MJX0ucycIM5nd1wgGxOGM8VpRqE8Cw=;
 b=cy5ehQjSo5VFF0e6bBvEQgJR4jEIQdTHjtevBFnRphTmWoZwg/uTCWBxGsGIewevkqsRqJLIPRYEX0KBuP+aihpDXxqGnD1Qp0fqTnHYqMV0JWGLBJiOtyaGtIxUSGkVguk+M2VXFTup33haycBNaOYSZ62nGsM6w0cAvyl2dy0xoAu5TARd949eqEMoRkCJp4zqVqPBMx4VspNi4/rNi3JAx4SwsJk1hoEfAjRYHM7RQhRvEM5YUT7nuErui1cp3ad8ai0z9LTH1YvjA1hiJeHUj1RCpu/bx4AIVcaExg6vmCapW4WM8iJmrtsF4ts5WpX7JUthIOOBXpK/Urgmpw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 16:10:08 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%2]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 16:10:07 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>, Linuxarm
 <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, jiangkunkun
 <jiangkunkun@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Thread-Topic: [RFC PATCH v3 05/15] hw/arm/smmuv3-accel: Introduce smmuv3 accel
 device
Thread-Index: AQHcHaivcGBvRYDlMUyaDHeRHM9GsLSMnZeQ
Date: Wed, 10 Sep 2025 16:10:07 +0000
Message-ID: <CH3PR12MB7548FAB361794C79A8555C26AB0EA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-6-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136ACFB4721D47304A9885C9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aHaP3ULG90gGqWHJ@Asurada-Nvidia>
 <IA3PR11MB9136C94472D7D50CDC627CB49256A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <6ee7908c8ea44270b9f4aa64abacaace@huawei.com>
 <71ca9132-8deb-4f57-abb0-2bcc0fe93ae9@redhat.com>
In-Reply-To: <71ca9132-8deb-4f57-abb0-2bcc0fe93ae9@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MN2PR12MB4424:EE_
x-ms-office365-filtering-correlation-id: 4ce87749-9422-42c7-7f5e-08ddf08482e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?MTkwT3hlSlZvOXVWMVVMTmhma2RDN25CcWlaVGNrYW55enRzMzM5bUpqVVFq?=
 =?utf-8?B?UGt3Vm5NRU5VZHRPcUNvK3BnVnBXeHc4QWx6aXFRR1ZDT3NLd1ZTbEsxQTFO?=
 =?utf-8?B?dE51NTdPQUlpVUduMll2cFYyOVUwRURIYVJoMHVId0pSQWZFRzgwMEJobnd0?=
 =?utf-8?B?MXVkb3hJdmlVRWJwa3hEK2ZMSTJsNnlSR2JZbTNSMDNBOC84L0xsMGNmOW1O?=
 =?utf-8?B?b25MNjA5YUJ1all0c2pHcFJNY1JOY1RGTHBoZWJvZ01zUnVrWDk3VmVXYVFV?=
 =?utf-8?B?RnJBVmdvQm9hS1Q3U2xFNWJiR3BMUnFGNGwwTGlybEZvcW9NVDV5U3pxZWw0?=
 =?utf-8?B?bXdEdlVwMis1dHc3R0ZGUHlVaTU3UFBucjdrc1ZUSnNiWWxXR3V5OFFPT001?=
 =?utf-8?B?Z3B3ZnhRQ3pxNHlkSSt6UVZkSDc3MDVuS1FlQTRLZndYdTlBazhrWmJNTHBt?=
 =?utf-8?B?VFQrdlk2SXZDcDR3QzZrN2pMZlVESFVvdC9hU3hlM0hTckQwTXV5MDhLZERT?=
 =?utf-8?B?VnF2YjVkOUhYdEVKbkRjT3RhdjZmbE1UaExTajVnclYyZk5xU2dtZWxrZVNQ?=
 =?utf-8?B?ZDRWM0s0aFJMN1JDVTRKcS9kRmZjZ3B5QUYrNlIrUjcwNHVHU0dNdHhzRGgv?=
 =?utf-8?B?ZmxWZGp6R3JnQzJ3RmtESW0yalh3TFk2dVQ4NHpxcjBnc1NSVk9VQWdxbjA3?=
 =?utf-8?B?MlF2MVZTZmlLZXRwVUxZZGIwajFNSXpYTGhJbk9wYU1jSTNHUWVmSXpKUUhp?=
 =?utf-8?B?aHRnN3FnYVU1L2swbnBpdGNrcFFmMWFpSVYvQ2lZVklIMUd3UDUyZHlFRkJz?=
 =?utf-8?B?cEkyblVUL05CeUIxZ3hLUy9sWkMrUnBNZFdmbnEwSFZJQWNWZUdzSlUydEg0?=
 =?utf-8?B?ckFXQjFtOEpNNFJlSVNOZEdDK3NKUkgvWmdOY0F3dkphVmVBakZHOFJDWGQ0?=
 =?utf-8?B?cTYvdkxUUG5malN2eXpmTHpZUVNoT2xTcVF0alowTE1Ca3dGTVRTL2VzZDJq?=
 =?utf-8?B?cjQ1M0xxTUswcDBoVFlHb25kYytqOFdyQTVLMWg2TG9JaEx0c3lYKzVZRjQ1?=
 =?utf-8?B?ZWVzcDZFb21kYUpGV2o0OUxqd21kVXlVR2VEUk9tMjdJSWY5WWt1MHNkYzJw?=
 =?utf-8?B?bEh4QUZuVTFlK0RxWEt0UjJ5Z1M3U1EyS3BEUHIzQ2VEalFIeHNHQzFMQ2g5?=
 =?utf-8?B?VjBUMU1ENEo0TGl3UzhMWktnaXNMZnc2UGJtQXJmT0pNVFlKRE1XdkUzaE53?=
 =?utf-8?B?bWUwdkR5TytWS3dxUjVhMVR0T2IwSUEvQ2k5cW5JU2NXRXRjWkF4b0RtYk5E?=
 =?utf-8?B?WFc3d1JwQ1JvWkt6Zkl0ZHlmdEFHeVBpcjJFZVpiODFzWHZRdTJ5Z3Y3d2hE?=
 =?utf-8?B?SGlaTVJGK1hYQkpsQ3FNUE05Rk1CWENxY2pPYUJjdGpPTGxLbFFPbmNRWDc1?=
 =?utf-8?B?OTg4ZmVLVEdJRW4yOFVxT1hnZXpWd21LM1VnaktBbjZ6ZlZXc0hEQzV5VTB1?=
 =?utf-8?B?Z284NWRWRFloSW1wZ0FibWRHbkVYeEFiTyswekxuUVFJUTNEY3lBYXhJbWJE?=
 =?utf-8?B?eDk1cUh0V3pkNDJyMWJnSUM0S0pyVkVsemlYYmpXK0cwQzFvNmVzZDRibTMx?=
 =?utf-8?B?K21GRm03QmZYUm9CUnptaDRzRXBNd2kvNU0wWndRYWc0SlR6UzY3a0l0b25K?=
 =?utf-8?B?TERGUFl4RVhJTHp3ME8xY085dmFNY091U0JQVXRzREJQQWZIODM4QzBEOGZw?=
 =?utf-8?B?eHJNbG1KZW9ZUkZlcHZiakQ0ZC8weUcrTitoUXgyN2xCRG1GNHc3TzdLVGp1?=
 =?utf-8?B?cjJjVGdrdnBSc09qNTVCVHRkQkRqK2owQ2tuMHpzTFJLd1JZRGhKR0xCNFlF?=
 =?utf-8?B?MEkrNmpEbU00L05wM1JFN0VkS3VjeU5WN0lueWJKdUdHQ0NxMWp6VnlybkdU?=
 =?utf-8?B?SmtkeXJ2djV5aE4ybHJxWHQyT2ErYjVDNmNqeFBjbmpXeXdDaCsxSklKcGxk?=
 =?utf-8?Q?a7U7fb4t/dmFNO/PClP97j5GAO5Ltc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnpHNmtBcFQxYjQ2ODA1S2NualJMb0h5NUpCQWhHWnlWeHpKOG5ndHZVRlA1?=
 =?utf-8?B?eTEvd2FxZkVZWlIyUnRBeFg3bEpPbTNuM0pmcVVmb2J3a2ZkR00xZnVSWGZB?=
 =?utf-8?B?M1NGSlVhbW1KU3dRNWtDR25RN0xUWG9rdGN0WGZEdTNkTm85cm1nQUFQWUVk?=
 =?utf-8?B?MlpTTi9LV2s3RlhoU3ZocjBjSVNkN0RETWdQQ3JYL3NEbkhqczJOeFhCL2tQ?=
 =?utf-8?B?THhjM05BbjB4UjNtVWVmMEs5dG5NR3lzN1Raano4WS9GTldUMjBJYVl3Wi83?=
 =?utf-8?B?azZsYi90UVdOYkZSRHlEN0RnUHJoSUtLNEwrUDlSNUVkRFlLcVo2WHRSVTdv?=
 =?utf-8?B?Q1dCVzV1c1M5KytkaWwrSUNRUkJiTjM5UWxaTHVid0xjVFFqZ0JHYlpZUWJP?=
 =?utf-8?B?NElzRFBMM3A3UGVuYXVLa2U0SmJpdnhyZkx1OE9uUW4xejhmUjZxdWc3eDhD?=
 =?utf-8?B?eWxkdUEwZTFudC9IbHJUMitBZDVrMEk5U2tpZDYzQ0h2bU9hbTRRbGJ4ZHlr?=
 =?utf-8?B?Slo1MUMwM3k2Z3FMS3BlNzE2cWRyN09rSUF6QVcybVFLWXVncWIxcHkzelcv?=
 =?utf-8?B?T25jbHU3Sm5KaGdnUExCaFI4RDJuWEpreHE4SndtYk5Xd2FpY2J1YlI1YVZn?=
 =?utf-8?B?T1UxVXYzM2VKcGRza0c4YXRTQ0o0dWZyaTVXQ01WSU45MEYyZFF5dUl0RGRu?=
 =?utf-8?B?KzM3S3FHVml0dkRCWSsyUk1uS3RLckYrQW85bmlvL3dBdGxJZkF3cHRVaFVR?=
 =?utf-8?B?bFBGTnJYb1BXdERTNnhIR1lpNk5UbHI1emoybklpWlJHdzZGMlQ0My9qbWJG?=
 =?utf-8?B?WWpqYWxEMTRQV2lVL2NVTFZyamhoemkvL1Rad2VldEh2dFYxeHQwZ0FzbVM2?=
 =?utf-8?B?VS9VOHZKVldEQTFVQ0JIOVc4anBkZnpqMDlDT0dYQ1VQak1FTVhPUWRuamcr?=
 =?utf-8?B?a3BXN1Y1OVd1dUFmTFV0VGIvTEJTSE9xckduQkFNc2dSMitiZjVtbmxkV1g0?=
 =?utf-8?B?Rmt0bzcxZ1NUaWhObmc2SE03YTR3NWFsK0pUTGRScEYzaXJBOHFWVmYrZElP?=
 =?utf-8?B?dEVMc2dxS3VvV1l3VVFNVkF5UHFqN080VlpRei9DL0I0SjlCNHN0b0d1S3VX?=
 =?utf-8?B?SjhsQ283SVJTVDNJaWZYdWlVQWlOaUo0NHdWeWN5d2pGQlpHRVdMZ2FocDRR?=
 =?utf-8?B?dndVc1ZzdEpzOG1ab2ExS3N6cFlROVlwc3VDdHgxa0lvbURDdnQ4WE1Sckhq?=
 =?utf-8?B?VlNxcFNMVzZ6RjNLdmM4Q2RSZFRwb1EzbG5rZ3NlSU5IKzFCd2pwaWt4NGU0?=
 =?utf-8?B?TVNoZUxuQUhOQlRnaEZ1VFdURWpWRHZ5a0RlSUtCUEFzRTRsbGxnYTI3OXNK?=
 =?utf-8?B?QzFMV2RTTGNsa1dyL1AyR2lnYW9QVUZpUWdyVVR3Sm9INEQrcXQrY3hDWWdk?=
 =?utf-8?B?RlNuMzVaelMrRittQit0Mkp1bUdWZE9ndmtmUWZhbmpPVFhXbkVmRHkrRy9G?=
 =?utf-8?B?czF5QTBreHo4aXVrcEtnOWRrckZROEgvYUw5c1J1aDRhc2wra01zZGk0SmVz?=
 =?utf-8?B?WlBQQkdwc09XeDhZVXovRHdGd08wYlR0aVhxOTVaaGNvQkF3UEgwWm9kcExq?=
 =?utf-8?B?TUFPVFI1Q1l3ZVN3bUtrTGRqS0ZmT1UvS2MxQ1NsY0gxMEl4WFJDSTc3TkV3?=
 =?utf-8?B?dDV1WWZZamMrWjcwMzF1emMzK1AzcUhYNEVpSi9MSkV5dkJhLzQrc0xOdzQ2?=
 =?utf-8?B?ZjdDbWdpdFFSL2FYendPYWNLMEJWYjNjZEwxck5hVU9uMnNPbm1lZ1Ird1I4?=
 =?utf-8?B?WlphZHE0SXYrdXhtTitOWEhMT2hTRS9xeE1hWUNjSVdsWG1IdFByRHY2eHY0?=
 =?utf-8?B?eVpjT3dTenJEQmcyNFRVOFF3c0ZWa3E1SWFwMDVmemRneVZhVmIyMGQ3eFZa?=
 =?utf-8?B?TUs1dWtwVXZRa1VIVzRLc2pmWEFnTWpzNWFRa3M1dEc0YWcwcjZiZjhkL2pL?=
 =?utf-8?B?M3dIaXViT2pucWZRN2htQm1wdDhESnhTb0VTZ3dtNy9kaWs1Vnk1TmlDU2Vv?=
 =?utf-8?B?U3V4UENVWlZNeDVNeHpsalBjRUNXeEpvRy8xRVhNVHdGdTZwMGNJVDJBWFJs?=
 =?utf-8?Q?j6YreWyadiROd8j7a9CG6j9bU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce87749-9422-42c7-7f5e-08ddf08482e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 16:10:07.8542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BdFFN6OTTVdl0KGH8McGZwV6f4K3yRJh0PHssj7cYdO/PY7HTd/yF/53VPRrr2tUlANMr1jxNahPD82vI0hSXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424
Received-SPF: permerror client-ip=2a01:111:f403:2417::614;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

SGkgRXJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEF1
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA0IFNlcHRlbWJlciAyMDI1IDE1
OjMyDQo+IFRvOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT47IE5p
Y29saW4gQ2hlbg0KPiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IFNoYW1lZXIgS29sb3RodW0gPHNr
b2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiBDYzogcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1k
ZXZlbEBub25nbnUub3JnOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRo
b3JwZSA8amdnQG52aWRpYS5jb20+Ow0KPiBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJl
ZGhhdC5jb207IE5hdGhhbiBDaGVuDQo+IDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMg
PG1vY2hzQG52aWRpYS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyBMaW51eGFybSA8bGlu
dXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6aG91IChCKQ0KPiA8d2FuZ3pob3UxQGhpc2lsaWNvbi5j
b20+OyBqaWFuZ2t1bmt1biA8amlhbmdrdW5rdW5AaHVhd2VpLmNvbT47DQo+IEpvbmF0aGFuIENh
bWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47DQo+IHpoYW5nZmVpLmdhb0BsaW5h
cm8ub3JnOyBzaGFtZWVya29sb3RodW1AZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBB
VENIIHYzIDA1LzE1XSBody9hcm0vc21tdXYzLWFjY2VsOiBJbnRyb2R1Y2Ugc21tdXYzDQo+IGFj
Y2VsIGRldmljZQ0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlu
a3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gNy8xNi8y
NSAxMToyNyBBTSwgU2hhbWVlcmFsaSBLb2xvdGh1bSBUaG9kaSB3cm90ZToNCj4gPg0KPiA+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBEdWFuLCBaaGVuemhvbmcgPHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDE2LCAy
MDI1IDQ6MzkgQU0NCj4gPj4gVG86IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4N
Cj4gPj4gQ2M6IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkNCj4gPj4gPHNoYW1lZXJhbGkua29s
b3RodW0udGhvZGlAaHVhd2VpLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmc7DQo+ID4+IHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZzsgZXJpYy5hdWdlckByZWRoYXQuY29tOw0KPiA+PiBwZXRlci5tYXlk
ZWxsQGxpbmFyby5vcmc7IGpnZ0BudmlkaWEuY29tOyBkZHV0aWxlQHJlZGhhdC5jb207DQo+ID4+
IGJlcnJhbmdlQHJlZGhhdC5jb207IG5hdGhhbmNAbnZpZGlhLmNvbTsgbW9jaHNAbnZpZGlhLmNv
bTsNCj4gPj4gc21vc3RhZmFAZ29vZ2xlLmNvbTsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5j
b20+OyBXYW5nemhvdSAoQikNCj4gPj4gPHdhbmd6aG91MUBoaXNpbGljb24uY29tPjsgamlhbmdr
dW5rdW4gPGppYW5na3Vua3VuQGh1YXdlaS5jb20+Ow0KPiA+PiBKb25hdGhhbiBDYW1lcm9uIDxq
b25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+Ow0KPiA+PiB6aGFuZ2ZlaS5nYW9AbGluYXJvLm9y
Zzsgc2hhbWVlcmtvbG90aHVtQGdtYWlsLmNvbQ0KPiA+PiBTdWJqZWN0OiBSRTogW1JGQyBQQVRD
SCB2MyAwNS8xNV0gaHcvYXJtL3NtbXV2My1hY2NlbDogSW50cm9kdWNlDQo+ID4+IHNtbXV2MyBh
Y2NlbCBkZXZpY2UNCj4gPj4NCj4gPj4NCj4gPj4NCj4gPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4+PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+
ID4+PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2MyAwNS8xNV0gaHcvYXJtL3NtbXV2My1hY2Nl
bDogSW50cm9kdWNlDQo+ID4+PiBzbW11djMgYWNjZWwgZGV2aWNlDQo+ID4+Pg0KPiA+Pj4gT24g
VHVlLCBKdWwgMTUsIDIwMjUgYXQgMTA6NDg6MzFBTSArMDAwMCwgRHVhbiwgWmhlbnpob25nIHdy
b3RlOg0KPiA+Pj4+PiArc3RhdGljIGNvbnN0IFR5cGVJbmZvIHR5cGVzW10gPSB7DQo+ID4+Pj4+
ICsgICAgew0KPiA+Pj4+PiArICAgICAgICAubmFtZSA9IFRZUEVfQVJNX1NNTVVWM19BQ0NFTCwN
Cj4gPj4+Pj4gKyAgICAgICAgLnBhcmVudCA9IFRZUEVfQVJNX1NNTVVWMywNCj4gPj4+Pj4gKyAg
ICAgICAgLmNsYXNzX2luaXQgPSBzbW11djNfYWNjZWxfY2xhc3NfaW5pdCwNCj4gPj4+Pj4gKyAg
ICB9DQo+ID4+Pj4gSW4gY292ZXItbGV0dGVyLCBJIHNlZSAiLWRldmljZSBhcm0tc21tdXYzIiwg
c28gd2hlcmUgaXMgYWJvdmUgYWNjZWwNCj4gPj4+PiBkZXZpY2UgY3JlYXRlZCBzbyB3ZSBjb3Vs
ZCB1c2Ugc21tdXYzX2FjY2VsX29wcz8NCj4gPj4+IFRoZSBzbW11LWNvbW1vbi5jIGlzIHRoZSBz
aGFyZWQgZmlsZSBiZXR3ZWVuIGFjY2VsIGFuZCBub24tYWNjZWwNCj4gPj4+IGluc3RhbmNlcy4g
SXQgaGFzIGEgbW9kdWxlIHByb3BlcnR5Og0KPiA+Pj4gICAgREVGSU5FX1BST1BfQk9PTCgiYWNj
ZWwiLCBTTU1VU3RhdGUsIGFjY2VsLCBmYWxzZSksDQo+ID4+IEl0IGxvb2tzIHdlIGV4cG9zZSBh
IG5ldyBUWVBFX0FSTV9TTU1VVjNfQUNDRUwgdHlwZSBkZXZpY2UganVzdCBmb3INCj4gPj4gZXhw
b3J0aW5nIGFjY2VsIGlvbW11X29wcz8NCj4gPj4gV2hhdCBhYm91dCByZXR1cm5pbmcgYWNjZWwg
aW9tbXVfb3BzIGRpcmVjdGx5IGluDQo+ID4+IHNtbXVfaW9tbXVfb3BzX2J5X3R5cGUoKSBhbmQg
ZHJvcCB0aGUgbmV3IHR5cGU/DQo+ID4gV2UgYXJlIG5vdCBjcmVhdGluZyBhbnkgbmV3IGRldmlj
ZSBoZXJlLiBJdHMganVzdCBhIENsYXNzIG9iamVjdCBvZiBkaWZmZXJlbnQNCj4gdHlwZS4NCj4g
PiBJIGhhZCBhIGRpZmZlcmVudCBhcHByb2FjaCBwcmV2aW91c2x5IGFuZCBFcmljIHN1Z2dlc3Rl
ZCB0byB0cnkgdGhpcyBhcyB0aGVyZQ0KPiA+IGFyZSBleGFtcGxlcyBpbiBWRklPL0lPTU1VRkQg
Zm9yIHNvbWV0aGluZyBsaWtlIHRoaXMuDQo+ID4NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9xZW11LWRldmVsLzExMDVkMTAwLWRkMWUtNGFjYS1iNTE4LQ0KPiA1MGY5MDM5Njc0MTZAcmVk
aGF0LmNvbS8NCj4gQWN0dWFsbHkgSSBwb2ludGVkIG91dCB0aGF0IHVzdWFsbHkgd2UgZG9uJ3Qg
YWRkIG1ldGhvZHMgaW4gc3RhdGVzIGFzIGl0DQo+IHdhcyBkb25lIGluIHYyIChpbiBTTU1VU3Rh
dGUpIGJ1dCByYXRoZXIgaW4gY2xhc3NlcyBoZW5jZSBteSBzdWdnZXN0aW9uDQo+IHRvIHVzZSBh
IGNsYXNzIGluc3RlYWQuIE5vdyB3aGF0IGxvb2tzIHN0cmFuZ2UgaXMgeW91ciBjbGFzcyBkb2Vz
IG5vdA0KPiBpbXBsZW1lbnQgYW55IG1ldGhvZCA7LSkNCj4gDQo+IGRvY3MvZGV2ZWwvcW9tLnJz
dCBzYXlzICJUaGUgI09iamVjdENsYXNzIHR5cGljYWxseSBob2xkcyBhIHRhYmxlIG9mIGZ1bmN0
aW9uDQo+IHBvaW50ZXJzDQo+IGZvciB0aGUgdmlydHVhbCBtZXRob2RzIGltcGxlbWVudGVkIGJ5
IHRoaXMgdHlwZS4iDQo+IA0KPiBTb3JyeSBpZiBJIHdhcyB1bmNsZWFyLg0KPiANCj4gTm93IGlm
IHlvdSBkb24ndCBuZWVkIGFueSAiYWNjZWwiIHNwZWNpZmljIG1ldGhvZHMgYmVzaWRlcyB0aGUN
Cj4gUENJSU9NTVVPcHMgd2hpY2ggaGF2ZSBhIHNwZWNpZmljIHN0cnVjdCwgSSBhbSBub3Qgc3Vy
ZSB3ZSBuZWVkIGEgY2xhc3MNCj4gYW55bW9yZS4gb3IgdGhlbiB5b3UgZGlyZWN0IGVtYmVkIHRo
ZSBQQ0lJT01NVU9wcyBTdHJ1Y3QgaW4gdGhlIG1ldGhvZD8NCg0KTG9va3MgbGlrZSBJIG1pc2lu
dGVycHJldGVkIHlvdXIgc3VnZ2VzdGlvbi4gSSBkb24ndCBzZWUgYSBuZWVkIGZvciBhbnkgc3Bl
Y2lmaWMNCiJhY2NlbCIgbWV0aG9kcyBhdCB0aGUgbW9tZW50LiBBbmQgT2JqZWN0Q2xhc3MgYXMg
cGVyIHRoZSBkZWZpbml0aW9uIGFib3ZlDQpJcyBpbmRlZWQgbm90IGEgY2FuZGlkYXRlIGZvciB0
aGlzIG5vdy4NCiANCj4gQWxzbyBpdCdzIHRydWUgdGhhdCdzIHdlaXJkIHRoYXQgdGhlIGFjdHVh
bCBvYmplY3QgaXMgbmV2ZXIgaW5zdGFudGlhdGVkIGFuZCBtYXkNCj4gYWxzbyBhcHBlYXIgaW4g
cW9tIG9iamVjdCBsaXN0LiBUaGlzIGlzIG5vdCB0aGUgY2FzZSBmb3IgdGhlIGV4YW1wbGUgSSBn
YXZlLCBpZS4NCj4gdGhlIFZGSU9Db250YWluZXJCYXNlLg0KDQpUcnVlLiBNeSBiYWQuDQoNCj4g
DQo+IEkgZG9uJ3Qga25vdyBpZiBhbnlvbmUgaGFzIGEgYmV0dGVyL21vcmUgZWxlZ2FudCBpZGVh
Pw0KDQpIb3cgYWJvdXQgc29tZXRoaW5nIGxpa2UgdGhpcyBpbnN0ZWFkLA0KDQpkaWZmIC0tZ2l0
IGEvaHcvYXJtL3NtbXUtY29tbW9uLmMgYi9ody9hcm0vc21tdS1jb21tb24uYw0KaW5kZXggMGYx
YTA2Y2VjMi4uMDQxMmFkMjZmMCAxMDA2NDQNCi0tLSBhL2h3L2FybS9zbW11LWNvbW1vbi5jDQor
KysgYi9ody9hcm0vc21tdS1jb21tb24uYw0KQEAgLTk1Niw2ICs5NTYsOSBAQCBzdGF0aWMgdm9p
ZCBzbW11X2Jhc2VfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQogICAg
ICAgICByZXR1cm47DQogICAgIH0NCg0KKyAgICBpZiAoIXMtPmlvbW11X29wcykgew0KKyAgICAg
ICAgcy0+aW9tbXVfb3BzID0gJnNtbXVfb3BzOw0KKyAgICB9DQogICAgIC8qDQogICAgICAqIFdl
IG9ubHkgYWxsb3cgZGVmYXVsdCBQQ0llIFJvb3QgQ29tcGxleChwY2llLjApIG9yIHB4Yi1wY2ll
IGJhc2VkIGV4dHJhDQogICAgICAqIHJvb3QgY29tcGxleGVzIHRvIGJlIGFzc29jaWF0ZWQgd2l0
aCBTTU1VLg0KQEAgLTk3NSw5ICs5NzgsOSBAQCBzdGF0aWMgdm9pZCBzbW11X2Jhc2VfcmVhbGl6
ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQogICAgICAgICB9DQoNCiAgICAgICAg
IGlmIChzLT5zbW11X3Blcl9idXMpIHsNCi0gICAgICAgICAgICBwY2lfc2V0dXBfaW9tbXVfcGVy
X2J1cyhwY2lfYnVzLCAmc21tdV9vcHMsIHMpOw0KKyAgICAgICAgICAgIHBjaV9zZXR1cF9pb21t
dV9wZXJfYnVzKHBjaV9idXMsIHMtPmlvbW11X29wcywgcyk7DQogICAgICAgICB9IGVsc2Ugew0K
LSAgICAgICAgICAgIHBjaV9zZXR1cF9pb21tdShwY2lfYnVzLCAmc21tdV9vcHMsIHMpOw0KKyAg
ICAgICAgICAgIHBjaV9zZXR1cF9pb21tdShwY2lfYnVzLCBzLT5pb21tdV9vcHMsIHMpOw0KICAg
ICAgICAgfQ0KICAgICAgICAgcmV0dXJuOw0KICAgICB9DQpkaWZmIC0tZ2l0IGEvaHcvYXJtL3Nt
bXV2My5jIGIvaHcvYXJtL3NtbXV2My5jDQppbmRleCBiY2Y4YWY4ZGM3Li5mMGMzNTI1MTViIDEw
MDY0NA0KLS0tIGEvaHcvYXJtL3NtbXV2My5jDQorKysgYi9ody9hcm0vc21tdXYzLmMNCkBAIC0z
Miw2ICszMiw3IEBADQogI2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCg0KICNpbmNsdWRlICJody9h
cm0vc21tdXYzLmgiDQorI2luY2x1ZGUgInNtbXV2My1hY2NlbC5oIg0KICNpbmNsdWRlICJzbW11
djMtaW50ZXJuYWwuaCINCiAjaW5jbHVkZSAic21tdS1pbnRlcm5hbC5oIg0KDQpAQCAtMTg4Miw2
ICsxODgzLDEwIEBAIHN0YXRpYyB2b2lkIHNtbXVfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZCwgRXJy
b3IgKiplcnJwKQ0KICAgICBTeXNCdXNEZXZpY2UgKmRldiA9IFNZU19CVVNfREVWSUNFKGQpOw0K
ICAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCg0KKyAgICBpZiAoc3lzLT5hY2NlbCkgew0K
KyAgICAgICAgc21tdXYzX2FjY2VsX3NldF9pb21tdV9vcHMoc3lzKTsNCisgICAgfQ0KKw0KICAg
ICBjLT5wYXJlbnRfcmVhbGl6ZShkLCAmbG9jYWxfZXJyKTsNCiAgICAgaWYgKGxvY2FsX2Vycikg
ew0KICAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGxvY2FsX2Vycik7DQpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9hcm0vc21tdS1jb21tb24uaCBiL2luY2x1ZGUvaHcvYXJtL3NtbXUtY29t
bW9uLmgNCmluZGV4IGM2Zjg5OWU0MDMuLjdmMDZkOTVhNTIgMTAwNjQ0DQotLS0gYS9pbmNsdWRl
L2h3L2FybS9zbW11LWNvbW1vbi5oDQorKysgYi9pbmNsdWRlL2h3L2FybS9zbW11LWNvbW1vbi5o
DQpAQCAtMTYyLDYgKzE2Miw4IEBAIHN0cnVjdCBTTU1VU3RhdGUgew0KICAgICB1aW50OF90IGJ1
c19udW07DQogICAgIFBDSUJ1cyAqcHJpbWFyeV9idXM7DQogICAgIGJvb2wgc21tdV9wZXJfYnVz
OyAvKiBTTU1VIGlzIHNwZWNpZmljIHRvIHRoZSBwcmltYXJ5X2J1cyAqLw0KKyAgICBjb25zdCBQ
Q0lJT01NVU9wcyAqaW9tbXVfb3BzOw0KKyAgICBib29sIGFjY2VsOw0KIH07DQoNCiBzdHJ1Y3Qg
U01NVUJhc2VDbGFzcyB7DQoNCmRpZmYgLS1naXQgYS9ody9hcm0vc21tdXYzLWFjY2VsLmMgYi9o
dy9hcm0vc21tdXYzLWFjY2VsLmMNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAw
MDAwLi43YjRiNjM1MDQ0DQotLS0gL2Rldi9udWxsDQorKysgYi9ody9hcm0vc21tdXYzLWFjY2Vs
LmMNCg0KWy4uLl0NCg0KKw0KK3N0YXRpYyBjb25zdCBQQ0lJT01NVU9wcyBzbW11djNfYWNjZWxf
b3BzID0gew0KKyAgICAuZ2V0X2FkZHJlc3Nfc3BhY2UgPSBzbW11djNfYWNjZWxfZmluZF9hZGRf
YXMsDQorfTsNCisNCit2b2lkIHNtbXV2M19hY2NlbF9zZXRfaW9tbXVfb3BzKFNNTVVTdGF0ZSAq
cykNCit7DQorICAgIHMtPmlvbW11X29wcyA9ICZzbW11djNfYWNjZWxfb3BzOw0KK30NCg0KUGxl
YXNlIGxldCBtZSBrbm93Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQoJCQkJCQkJCQkJCQkJCQkJICAN
Cg==

