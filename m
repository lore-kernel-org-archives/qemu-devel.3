Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FCBCA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 07:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvWjT-0005jF-KV; Mon, 08 Sep 2025 03:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvWjI-0005hj-9d; Mon, 08 Sep 2025 03:56:00 -0400
Received: from mail-bn8nam04on2061d.outbound.protection.outlook.com
 ([2a01:111:f403:2408::61d]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvWix-0006nR-Ll; Mon, 08 Sep 2025 03:55:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dIidpGoaBeEaBndIZBuzkBpLrK7YcW0of+TmMFe6XQV6WQpW/XutoAgGqjEu3JakgALc8fAYpUmqg6zsrobIfOdDFjcFgcPzToFkU3CbXKRcz/Q/uPqjYDcww2OOBQmKoAfJNI+39yoCwAXUjzpsRreGYnMeoo5hE3Z/Ui/8D5qFc4mj6ArtOuYaU85UYDByQ0Tf37ragCowhIysC2XvCw7S932JdZkiaxYtFyok5OJ3FxpMb666B+Ty093ejqi8Rf9IgzspJV9H5QGAsinibzkrDR7TFbhLGrf2U9q4bysv5gA+hMb9FPibOZsM89StIyLD1PR3OqS/SWvxqOJZag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cisGre5bexKW25piSHIG2lpiIq3Tz33UZy+rgpQ28XU=;
 b=Hqig/rkN/hOn/pMEjBPGeyKTT5CcZ42O3b3m32n8paAxK6TF1vyVE5YZC2XOmJhHgRI3HAr3IPlHwDmg669Cr2NrYfEmNNiVdFOX0RsDnllX3ZBQ2XPoGGQt4Nr3oprJjyeSkwl1Rti8YLpSaWZqU/Claw+7oEQfXsJ23zDh9/DglsL8KncTOZzxNNxx05oJGCFt/BB+KksiosedfoiBQ21IOdWn70Rlqn/EpUJTCLe4CYWvPfgHd+uSAmpMABbBQj7aUJjSr2djSdxvNpkDSZcfU5pb6LUSXESSYqmr9UlA78o1N3nrKjsDPhdt33wgoRdhyfPpZCmA/5+TB5Mrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cisGre5bexKW25piSHIG2lpiIq3Tz33UZy+rgpQ28XU=;
 b=I2PJL6U3z9qAInATmbUeMe3XfiuyM1KlkUrUj47QorpDp875inUD2/4u7EeejKVG2J5BhW6mUWHfmZhFiqla2Z8J0WGKgjMCtn7uxSkmPzJq0XFEAER3gnxbF1U8Gy/VSLkJDu1UKpRrHhunCma95nvqVScQ/b7S4ov8iqAePW9dWf2uUWleA3TmtHTwaAuRcRbu7Q+pWKXsIKO9KKzrub3LGXxvqZpizo6AXVIrOJIaQ8Tn+TelXX7NyheNAj0tP3FUIviUU19viLsCGQE/ZNYuYQPm+L6cDu459gTATFnDXDpTvAO6482N+HPZyBYFPxG19BHSoMDlRznQocupCg==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 07:55:21 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 07:55:21 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
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
Subject: RE: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Topic: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHcHj84yZvN/mVpTUewNZT1jGrd9rSI65Bg
Date: Mon, 8 Sep 2025 07:55:20 +0000
Message-ID: <IA0PR12MB7555D1D7D4B75ADCAB070395AB0CA@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136A660E9FAE540037986FB9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aHaW9IpjbaVcRUpA@Asurada-Nvidia>
 <756cf804fbd14d66ba8f23358524fe96@huawei.com>
 <27f2cf53-cfe8-45ea-8df9-d5afccbc43e4@redhat.com>
In-Reply-To: <27f2cf53-cfe8-45ea-8df9-d5afccbc43e4@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|CY8PR12MB7337:EE_
x-ms-office365-filtering-correlation-id: bf46378c-bb35-416d-95e3-08ddeead0f52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TG9OelZNNU0wQlFBSHZ2TkpYRjd6RlRxbnNxWnYrRklLYzlpTmJmMysxQ1lj?=
 =?utf-8?B?dnV3QXU4SFJ4UFJ0N0Vmd3BKMUdDaUJjY0hrQ3hHalF3THVIYXJEeXcxcHVn?=
 =?utf-8?B?WkVyOXoxZjdBUDZVSU04U1V3d2pxK3ZzK1NUTTJiZnlpWVdsMVEzTXo1ZWtI?=
 =?utf-8?B?bTR1N291VVJucHhkVHl2Vk9KTkVCd2Vla0tGM0pKTXI2aUZpUmR0SDhmeWZo?=
 =?utf-8?B?WHpMWmlxWHovWmhKR0Y0NC9OZ1lLMzJhR3lZVmNtTG1MYTVGblpMU1k4SEZr?=
 =?utf-8?B?ME5MZE5RcThmLzUvQnJicDY3WmFiVVhZb0l4QWJPSXBkeE1WREQ0clJHRFV5?=
 =?utf-8?B?UkdtUDY4QXZ1ejNKRWRid25lSFZ4OUtNWElDTmFPU3U4V0VtVU5hZjVaTUc1?=
 =?utf-8?B?WmY3WlpraVREaXNQM1ZNUVVaY3BIRlpsZTFMd1BCb1VIOU9RTFExSmtWT2RM?=
 =?utf-8?B?aUh4c3F4SlJkUHM3cU85K2lsNDMvai8zbk4vaVp0eURCTVZDTWFhYzFwc3l3?=
 =?utf-8?B?b0JwNzVLNmlYOVA2Y2RPT3RXbXR2U0lRZ09laHVPSHYyZjZHRnlxQTdPTW95?=
 =?utf-8?B?Nzkva0pzVTloT0d3NDZhQXNxK0t6cGhkOWlqQk0xeVFBMmR0bC90SWw3L1ox?=
 =?utf-8?B?ZzRVVS9zQThmbnU0UUx4ZHNmeE9OWFk4bUxRcWJQZGhyZnJzakltVnpCZUtx?=
 =?utf-8?B?RjFFMFRGUENXaXRKQVVBbkxFUGdLQjZzSUtWY2VPMUFWem1QSmljYktIRVZv?=
 =?utf-8?B?VS9lTVMxZkZBbFF6ZnJYWWUyUWpYcTJ1L2V3azdhYytuM2NJWGxXSVpkVE5X?=
 =?utf-8?B?OE9TUjZNcmw5cWowUUxqY3p3VDhLWjN0SGhic3VUbldKSWN1bTdPcW12dlVm?=
 =?utf-8?B?REFYWEtVbVYrWVlIQk02K3dCSGJCYTU1TmtMYkxzTjVvaklac1Z4NFd5MHMr?=
 =?utf-8?B?S1Bpemw5cnFTTFN0bENSM2dleXVwU0ErZlJzcXIweDE1bDB4Q0U5WktrT1Bj?=
 =?utf-8?B?NE96azZuNEhaZkF6Vmp6ZXFGV1pTUEhpNGJSbjJaaDlxaXQ5MGpCMS9uZzJz?=
 =?utf-8?B?T0JjNTZaSTdoK2Q2ZVBWVlpGaUJQQkZwSjcvMHlTZjk4RnFWWUNrNVZ3VGR0?=
 =?utf-8?B?NW1EMGJLeWpNVW80M2lCd1dxY2VzZGJWS3J0VTlHUXRJR2wyQU5qWWpSa253?=
 =?utf-8?B?WDBQSEU4WGcxaFF0Z1FjVHBUYWlRaUt4RndGbWlGbVJyT3U1ZnhjNmNjdnNl?=
 =?utf-8?B?dXVvRkNuYjkyMSt2TGdiNTJkN1lsSFFrL3lVVFRJSldoenB0RjVGYWFKNjBY?=
 =?utf-8?B?ZGtiYjd6emVMZlRvVS9BdktQUXBxdjhEN0wwRlkxUWp2clBMVGxDUHJZa3pm?=
 =?utf-8?B?NnpXTmJLSTNwdGhSdHhtZ2pWOGhsd21QbEFwYU4zajMwY21FdDUvQnB4QWZm?=
 =?utf-8?B?enJqNXRLbEhSbkhGWFFrMi9nZGROK1pzcGRqVHJqdzVJc0ZBcWU1TGl3VHl5?=
 =?utf-8?B?K2VtTkFMdSsrNlczc2gxbmFKeWd4ZUdQcEFCVnJIaFJHZVJCRkNWeVZpQm01?=
 =?utf-8?B?SWEvdVM1NzFIZ05rYXlWTW5obzdpYXYzOEhnM0drS3BZNisyQTh3Z3I3OUt4?=
 =?utf-8?B?NHhnd2FOR3Q0OU92alFCRkdVeno4ME45QTlSenpuUjVIU21qd1BqTm94ak1Q?=
 =?utf-8?B?VTVYS2ZVbG1mcUdGVCsxWFAwZFdHQW9Cdjl4NGtHaEltdlg2QUhXNk1UTEN0?=
 =?utf-8?B?NE1EdC9MQlFPemp3a053NitnR1RibEsveFJOSktJdFhhS2h4dUJuR3hVaG9q?=
 =?utf-8?B?dENrUEh0M0xCN1hWVVRlYXY4aFJWd2lPUnVpNGhMSFJCN3RWNUdXOVB3UXJL?=
 =?utf-8?B?dEttcE96aGxzMFN5QXh2cU0rcVE1QUtOVWxNMHZTM21GT01jcUpWeG94cllC?=
 =?utf-8?B?N0pvQ1VZdzJ2QnJJWXlHK011dUVEV2NnQjEzc2lXc3ZJNi9MTkdXZ1JBUzJ0?=
 =?utf-8?Q?Eep59z2ZyllwuFcK9pTEUySjsVOEJA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEhveTh6VXo2NW9nN0ZhZXVZR2l0eXlISlZvL1dTNUxMTDRPdk5pSU4vWXZ6?=
 =?utf-8?B?YWJFdkxGbGpWSGdWcVJsQVNGVkE3a3lIUGdCQjBYUDJXdHBPRU5wVlBENVk2?=
 =?utf-8?B?OTM5MHlSQVQ2U2JOZnRUZitMamJnOFJDNVlpdTVMRHVyZXNlL0xKcURwa1lp?=
 =?utf-8?B?OGVtTXZVVXh1Zkw5RjlNNTBMZ0RiRU9ISDd2eDFCQmU4NkpnUVYzN1VrUm53?=
 =?utf-8?B?LzRIOFc1akdjRTJNNVpqOFN4dnZnQmpaNE5sNnNzYjU5U0czQmFMeWIwVzdo?=
 =?utf-8?B?eGxsTU44TnVjaDdxemxPbVYwdHI4Um1CampORkJNTC84aEdJc0ZtdytkRG1I?=
 =?utf-8?B?NVk3VVJYZUtJSE9BcC8yMXd2NEVHQzExZGIzSGdHbU1mYStQdzcyNDh4WVBt?=
 =?utf-8?B?M05pVi9Zajg2YU1CbWFnSGR1ZmxnaFZ2YXRpU0x1M21CZVNtN1lBWHpLVFpZ?=
 =?utf-8?B?RWNWUnIwWXlZaDFaWk5NWDNZbEdEV1k2VFZ5YXE3QUo4UGNLMTdDZnJhTU44?=
 =?utf-8?B?eVhUUXRvN2dMaExRR2tYTkM1aDdPeEN5ajNNVVB4OGQ1b2RhZUN1WjIxOTJm?=
 =?utf-8?B?d0xHTzFiN3U5UExYaWdaME12V29LUFh5cTF3Q2hsNWtBbk16TS9zdmZtWWRz?=
 =?utf-8?B?VmlhVENTb2NiUlMyZTVNaHhJTS9URHFGcWhXK0M0TDlnd09WS1dhc051aGxz?=
 =?utf-8?B?blR5SjJZWTVwQmRxWXRhSFNBV1VyQWZlc2dWRnlwbVZ2ZEdDdkJrd0NwSUpR?=
 =?utf-8?B?dytNcC9FclNhRytUeTFld1hzWlllUEJISFc2VnpoQmxneldTN2RuQ3owNytR?=
 =?utf-8?B?OFQ5M2dQUDJISVJaVzcyVmxuTlR5MXA0VWoxeFMvc1dGMEdaN2hUSkgwMHF2?=
 =?utf-8?B?TXgvMjVnR3dDU0tPclV4c1h6TENpZzZKSEcxTVZ2L3pNT3kzbFo1QjBERGZV?=
 =?utf-8?B?THFvSU9DZ1QrRTZNN0tDbUk1Z1R0VndXbmt3Rmh4YU1sQWRBK09PNENIMDdh?=
 =?utf-8?B?S3RsM1ErWmRVNEFuUmJWOEdXdWd2WXBQamI3aVB3ZzMxWDcvR043ZDE1Z1ZD?=
 =?utf-8?B?ZGJ4SU15VDNnU2JKQ3UrM3AxSWt2YmRVSDNxZm5UdGlsZ3B1WitBd0E0UmI3?=
 =?utf-8?B?WmN2Q21ROTZVUWpMdzVzS2F1YUUvMWlXbXhPSnBYWitoYjZRM1ZhS1NrZEpW?=
 =?utf-8?B?aURRNUtwZlVSbGlTYmJKZk5IV0tNMHJrTjc3aVJ5WGI4Ym5yUjd2OVJINE04?=
 =?utf-8?B?TUpJVmRBYWl0WnFUMzV2QmVOOWdVOTJ0anZQZFdwVEJCWVp3WTErNk1kM3hZ?=
 =?utf-8?B?eXpneGdvcytYc0ZmYk9iZy93dXA5cU1xZ2lwOGxkUm1rWlltRW1hNFFyVDJk?=
 =?utf-8?B?ZzgrMU5ZUkpOeGhBTWxhVmpibmgxdEc2SEplYTg2SnlpNGRRY2xlcFVrK0s1?=
 =?utf-8?B?V2xpNWRFOVlyWUswRVZqWE1jV1JiL2p3SkwzdWlZdjhBQkZBWkNmRFFuSTVB?=
 =?utf-8?B?eTFIeUowUTZsbjY2T2h2NkRIWHE0UEE4SGwyZFNVSE5KbGZTMlhBRzhPaEJI?=
 =?utf-8?B?cjFRODFxOWlucWhUbWxCdkd5MkdiNXBxSzhremhXc0hpTDFadDh6d0lIcVlq?=
 =?utf-8?B?ZXg0Y1dSSDZWMkZHbitqaVVUemxPNkhUYlBTVHpNQjhkMGViWWttRW9KR2w3?=
 =?utf-8?B?OEpvc3JzNWRVcUs0ekN0eC9MVStZenNoRHZuVGM0RE9hcWw2Kzl0bUp6eHJ5?=
 =?utf-8?B?VHNlYzl0d3diUFRKMVM5ODFjdG02UGFjRGNpeTVmYk1GK1ZyeEpmMi9RQm1R?=
 =?utf-8?B?ZnJvRnhBYlNwQ2trZjlTS2dIVzV6UXRCaUFFeVdqM2xzMXhIM2VqR0RrL0VX?=
 =?utf-8?B?N2J1K2twVndrWFQ0d0h6bHZLaGp1VWZkeGtNdHBIYXZhYTBqMlBiU1hXTG5v?=
 =?utf-8?B?d2paWFo4UjcvS3VVQUhzL2ZzWVc0cW9DUTBIU3pzQmZNRDhCczBqdlZVbCtO?=
 =?utf-8?B?U05DOXllT0p0SzVZWnQ5ZGdHV0YrN2dzMWdUZ3JlRnpDVlBLeXVaZUZrbXdJ?=
 =?utf-8?B?djRmd2h3L0hwcGtrR1JDcGt6S1RsQXcwSlA4K0RmdWluRGhjV3lEZ3BvTml1?=
 =?utf-8?Q?GhVAX3i/xgAmTGk31nLOXYmiI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf46378c-bb35-416d-95e3-08ddeead0f52
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 07:55:21.0007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n0HQbZrSdcKtkLH0tVKka4enwSOaRjAV52prr3kb3Xec/1vrS/JsOGptpIbVaYlegV1D4qWgN6vEvhKJlAC2RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
Received-SPF: permerror client-ip=2a01:111:f403:2408::61d;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_NONE=0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA1IFNlcHRlbWJlciAyMDI1IDA5
OjMwDQo+IFRvOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBEdWFuLCBaaGVu
emhvbmcNCj4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT47IFNoYW1lZXIgS29sb3RodW0NCj4g
PHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiBDYzogcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVt
dS1kZXZlbEBub25nbnUub3JnOw0KPiBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1
bnRob3JwZSA8amdnQG52aWRpYS5jb20+Ow0KPiBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdl
QHJlZGhhdC5jb207IE5hdGhhbiBDaGVuDQo+IDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9j
aHMgPG1vY2hzQG52aWRpYS5jb20+Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyBMaW51eGFybSA8
bGludXhhcm1AaHVhd2VpLmNvbT47IFdhbmd6aG91IChCKQ0KPiA8d2FuZ3pob3UxQGhpc2lsaWNv
bi5jb20+OyBqaWFuZ2t1bmt1biA8amlhbmdrdW5rdW5AaHVhd2VpLmNvbT47DQo+IEpvbmF0aGFu
IENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47DQo+IHpoYW5nZmVpLmdhb0Bs
aW5hcm8ub3JnOyBzaGFtZWVya29sb3RodW1AZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUkZD
IFBBVENIIHYzIDA2LzE1XSBody9hcm0vc21tdXYzLWFjY2VsOiBSZXN0cmljdA0KPiBhY2NlbGVy
YXRlZCBTTU1VdjMgdG8gdmZpby1wY2kgZW5kcG9pbnRzIHdpdGggaW9tbXVmZA0KPiANCj4gRXh0
ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4g
DQo+IA0KPiBIaSBTaGFtZWVyLA0KPiANCj4gT24gNy8xNi8yNSAxMDowNiBBTSwgU2hhbWVlcmFs
aSBLb2xvdGh1bSBUaG9kaSB3cm90ZToNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+PiBGcm9tOiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+ID4+
IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTUsIDIwMjUgNjo1OSBQTQ0KPiA+PiBUbzogRHVhbiwgWmhl
bnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+ID4+IENjOiBTaGFtZWVyYWxpIEtv
bG90aHVtIFRob2RpDQo+ID4+IDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+
OyBxZW11LWFybUBub25nbnUub3JnOw0KPiA+PiBxZW11LWRldmVsQG5vbmdudS5vcmc7IGVyaWMu
YXVnZXJAcmVkaGF0LmNvbTsNCj4gPj4gcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBqZ2dAbnZp
ZGlhLmNvbTsgZGR1dGlsZUByZWRoYXQuY29tOw0KPiA+PiBiZXJyYW5nZUByZWRoYXQuY29tOyBu
YXRoYW5jQG52aWRpYS5jb207IG1vY2hzQG52aWRpYS5jb207DQo+ID4+IHNtb3N0YWZhQGdvb2ds
ZS5jb207IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgV2FuZ3pob3UgKEIpDQo+ID4+
IDx3YW5nemhvdTFAaGlzaWxpY29uLmNvbT47IGppYW5na3Vua3VuIDxqaWFuZ2t1bmt1bkBodWF3
ZWkuY29tPjsNCj4gPj4gSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWku
Y29tPjsNCj4gPj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHNoYW1lZXJrb2xvdGh1bUBnbWFp
bC5jb20NCj4gPj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjMgMDYvMTVdIGh3L2FybS9zbW11
djMtYWNjZWw6IFJlc3RyaWN0DQo+ID4+IGFjY2VsZXJhdGVkIFNNTVV2MyB0byB2ZmlvLXBjaSBl
bmRwb2ludHMgd2l0aCBpb21tdWZkDQo+ID4gLi4uDQo+ID4NCj4gPj4+PiArICAgIGlmIChwZGV2
ICYmICFzbW11djNfYWNjZWxfcGRldl9hbGxvd2VkKHBkZXYsICZ2ZmlvX3BjaSkpIHsNCj4gPj4+
PiArICAgICAgICBlcnJvcl9yZXBvcnQoIkRldmljZSglcykgbm90IGFsbG93ZWQuIE9ubHkgUENJ
ZSByb290IGNvbXBsZXgNCj4gPj4+PiBkZXZpY2VzICINCj4gPj4+PiArICAgICAgICAgICAgICAg
ICAgICAgIm9yIFBDSSBicmlkZ2UgZGV2aWNlcyBvciB2ZmlvLXBjaSBlbmRwb2ludCBkZXZpY2Vz
DQo+ID4+Pj4gd2l0aCAiDQo+ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICJpb21tdWZkIGFz
IGJhY2tlbmQgaXMgYWxsb3dlZCB3aXRoDQo+ID4+Pj4gYXJtLXNtbXV2MyxhY2NlbD1vbiIsDQo+
ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIHBkZXYtPm5hbWUpOw0KPiA+Pj4+ICsgICAgICAg
IGV4aXQoMSk7DQo+ID4+PiBTZWVtcyBhZ2dyZXNzaXZlIGZvciBhIGhvdHBsdWcsIGNvdWxkIHdl
IGZhaWwgaG90cGx1ZyBpbnN0ZWFkIG9mIGtpbGwNCj4gPj4gUUVNVT8NCj4gPiBUaGF0J3Mgcmln
aHQuIEkgd2lsbCB0cnkgdG8gc2VlIHdoZXRoZXIgaXQgaXMgcG9zc2libGUgdG8gZG8gYSBkZXYt
PmhvdHBsdWdnZWQNCj4gPiBjaGVjayBoZXJlLg0KPiA+DQo+ID4+IEhvdHBsdWcgd2lsbCB1bmxp
a2VseSBiZSBzdXBwb3J0ZWQgd2VsbCwgYXMgaXQgd291bGQgaW50cm9kdWNlDQo+ID4+IHRvbyBt
dWNoIGNvbXBsaWNhdGlvbi4NCj4gPj4NCj4gPj4gV2l0aCBpb21tdWZkLCBhIHZJT01NVSBvYmpl
Y3QgaXMgYWxsb2NhdGVkIHBlciBkZXZpY2UgKHZmaW8pLiBJZg0KPiA+PiB0aGUgZGV2aWNlIGZk
IChjZGV2KSBpcyBub3QgeWV0IGdpdmVuIHRvIHRoZSBRRU1VLiBJdCBpc24ndCBhYmxlDQo+ID4+
IHRvIGFsbG9jYXRlIGEgdklPTU1VIG9iamVjdCB3aGVuIGNyZWF0aW5nIGEgVk0uDQo+ID4+DQo+
ID4+IFdoaWxlIGEgdklPTU1VIG9iamVjdCBjYW4gYmUgYWxsb2NhdGVkIGF0IGEgbGF0ZXIgc3Rh
Z2Ugb25jZSB0aGUNCj4gPj4gZGV2aWNlIGlzIGhvdHBsdWdnZWQuIEJ1dCB0aGluZ3MgbGlrZSBJ
T1JUIG1hcHBpbmdzIGFyZW4ndCBhYmxlDQo+ID4+IHRvIGdldCByZWZyZXNoZWQgc2luY2UgdGhl
IE9TIGlzIGxpa2VseSBhbHJlYWR5IGJvb3RlZC4NCj4gPiBXaHkgZG8gd2UgbmVlZCBJT1JUIG1h
cHBpbmdzIHRvIGJlIHJlZnJlc2hlZCBkdXJpbmcgaG90cGx1Zz8NCj4gPiBBRkFJQ1MsIHRoZSBt
YXBwaW5ncyBhcmUgY3JlYXRlZCBwZXIgaG9zdCBicmlkZ2UgSWRzLiBBbmQgaG93IGlzIHRoaXMN
Cj4gPiBkaWZmZXJlbnQgZnJvbSBhIGhvc3QgbWFjaGluZSBkb2luZyBob3RwbHVnPw0KPiA+DQo+
ID4gIEV2ZW4gYW4NCj4gPj4gSU9NTVUgY2FwYWJpbGl0eSBzeW5jIHZpYSB0aGUgaHdfaW5mbyBp
b2N0bCB3aWxsIGJlIGRpZmZpY3VsdCB0bw0KPiA+PiBkbyBhdCB0aGUgcnVudGltZSBwb3N0IHRo
ZSBndWVzdCBpb21tdSBkcml2ZXIncyBpbml0aWFsaXphdGlvbi4NCj4gPiBXZSBoYWQgc29tZSBk
aXNjdXNzaW9uIG9uIHRoaXMgImF0IGxlYXN0IG9uZSB2ZmlvLXBjaSIgcmVzdHJpY3Rpb24NCj4g
PiBmb3IgYWNjZWxlcmF0ZWQgbW9kZSBwcmV2aW91c2x5IGhlcmUuDQo+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9aNlR0Q0xRMzVVSTEyVDc3QHJlZGhhdC5jb20vI3QNCj4g
Pg0KPiA+IEkgYW0gbm90IHN1cmUgd2UgcmVhY2hlZCBhbnkgY29uc2Vuc3VzIG9uIHRoYXQuIFRo
ZSAzIGRpZmZlcmVudCBhcHByb2FjaGVzDQo+ID4gZGlzY3Vzc2VkIHdlcmUsDQo+ID4NCj4gPiAx
LiBUaGUgY3VycmVudCBvbmUgdXNlZCBoZXJlLiBBdCBsZWFzdCBvbmUgY29sZCBwbHVnZ2VkIHZm
aW8tcGNpIGRldmljZQ0KPiA+ICAgIHNvIHRoYXQgIHdlIGNhbiByZXRyaWV2ZSB0aGUgaG9zdCBT
TU1VVjMgSFdfSU5GTyBhcyBwZXIgY3VycmVudA0KPiA+ICAgSU9NTVVGRCBBUElzLg0KPiANCj4g
SSBkbyBub3QgZ2V0IHdoeSB5b3UgY2FuJ3Qgd2FpdCBmb3IgdGhlIDFzdCBkZXZpY2UgdG8gYmUg
YXR0YWNoZWQgdG8NCj4gImZyZWV6ZSIgdGhlIHNldHRpbmdzLiBJcyBpdCBiZWNhdXNlIHlvdSBt
YXkgYWxzbyBoYXZlIHNvbWUgYnJpZGdlcyAvDQo+IHJvb3QgcG9ydHMgYWxzbyBhdHRhY2hlZCB0
byB0aGUgc2FtZSB2aW9tbXUuIEFzIHRob3NlIGxhdHRlciBkbyBub3QgaGF2ZQ0KPiBhbnkgYWRo
ZXJlbmNlIHRvIHRoZSBob3N0IFNNTVUsIGlzIHRoYXQgYSBwcm9ibGVtPw0KDQpXZSBuZWVkIHRv
IGluaXRpYWxpc2UgdGhlIHJlZ2lzdGVycyBmb3IgU01NVXYzIGJlZm9yZSBHdWVzdCBib290cyBh
cyANClNNTVV2MyBpcyBhIHBsYXRmb3JtIGRldmljZSBhbmQgY2FuJ3QgYmUgaG90IHBsdWdnZWQg
bGF0ZXIuDQoNClRoaXMgaXMgd2hlcmUgd2UgZG8gaXQgbm93LA0Kc21tdV9yZXNldF9leGl0KCkN
CiAgLS0+IHNtbXV2M19pbml0X3JlZ3Mocyk7DQogICAgaWYgKHN5cy0+YWNjZWwpIHsNCiAgICAg
ICAgc21tdXYzX2FjY2VsX2luaXRfcmVncyhzKTsNCiAgICB9DQpJIGFtIG5vdCBzdXJlIGhvdyB3
ZSBjYW4gdXBkYXRlIHRoZSBHdWVzdCBTTU1VdjMgZmVhdHVyZXMNCmFmdGVyIHRoZSBib290Lg0K
DQpBbmQgdGhlIG9ubHkgd2F5IHRvIHJldHJpZXZlIHRoZSBIb3N0IFNNTVV2MyBIVyBmZWF0dXJl
cyBpcyANCnRocm91Z2ggYSBkZXYgYm91bmQgdG8gaW9tbXVmZChJT01NVV9HRVRfSFdfSU5GTyku
DQoNCj4gPg0KPiA+IDIuIEEgbmV3IElPTU1VRkQgQVBJIHRvIHJldHJpZXZlIEhXX0lORk8gd2l0
aG91dCBhIGRldmljZS4NCj4gdGhpcyBjYW4gb25seSBiZSBwb3NzaWJsZSBpZiwgb24gdGhlIGNv
bW1hbmQgbGluZSB5b3UgY29ubmVjdCB0aGUgdnNtbXUNCj4gdG8gYSBzeXNmcyBwYXRoIHRvIHRo
ZSBob3N0IGlvbW11IChvciBtYXliZSB0aGlzIGlzIHdoYXQgeW91IG1lYW50IGluDQo+IDMpLiBU
aGlzIHdvdWxkIGJlIGFub3RoZXIgb3B0aW9uIHdlIGFsc28gZXZva2VkIGluIHRoZSBwYXN0LiBC
dXQgdGhpcyBpcw0KPiBub3QgdmVyeSB1c2VyIGZyaWVuZGx5IGZvciB0aGUgZ3V5IHdobyBsYXVu
Y2hlcyB0aGUgVk0gdG8gY2FyZSBib3RoIHRoZQ0KPiBkZXZpY2UgYW5kIHRoZSBhc3NvY2lhdGVk
IHBoeXNpY2FsIFNNTVUuIExvZ2ljYWxseSB3ZSBjb3VsZCBidWlsZCB0aGF0DQo+IHJlbGF0aW9u
c2hpcCBhdXRvbWF0aWNhbGx5Lg0KPiA+DQo+ID4gMy4gQSBmdWxseSBzcGVjaWZpZWQgdlNNTVV2
MyB0aHJvdWdoIFFlbXUgY29tbWFuZCBsaW5lIHNvIHRoYXQgd2UNCj4gPiAgICBkb24ndCBuZWVk
IEhXX0lORk8gZnJvbSBrZXJuZWwuDQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgc2Vuc2li
bGUgYXMgdGhlcmUgbWF5IGJlIHBsZW50eSBvZiB0aG9zZSwgZWFjaA0KPiByZXF1aXJlbWVudCBh
IGxpYnZpcnQgYWRhcHRhdGlvbg0KDQpBcyBtZW50aW9uZWQgaW4gbXkgcHJldmlvdXMgcmVwbHks
IHRoZSBpZGVhIGlzIHRvIGluaXRpYWxpemUgdGhlIGFjY2VsIFNNTVV2Mw0Kd2l0aCBhbGwgdGhl
IGZlYXR1cmVzIG9mIGVtdWxhdGVkIFNNTVV2MyBhbmQgYWRkIHN1cHBvcnQgZm9yIGFueSBhZGRp
dGlvbmFsDQpmZWF0dXJlcyByZXF1aXJlZCBmb3IgYWNjZWwgY2FzZSB0aHJvdWdoIGNvbW1hbmQg
bGluZShsaWtlIFNUQUxMLCBQQVNJRCBldGMpLg0KDQpUaGFua3MsDQpTaGFtZWVyDQo=

