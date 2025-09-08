Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688B0CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 08:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvWrV-0000Yj-Vi; Mon, 08 Sep 2025 04:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvWrH-0000V5-Si; Mon, 08 Sep 2025 04:04:16 -0400
Received: from mail-bn7nam10on20610.outbound.protection.outlook.com
 ([2a01:111:f403:2009::610]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1uvWr5-0007f3-QF; Mon, 08 Sep 2025 04:04:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6CMpW/1wBHafOwC5cNiUOLNtYklAOhLWBuUHErbFSyel/EZIfVJ/2J23WzqH0pwAXY23GR2ftEtRhc/hM+XLV1jPC6afrvvjEYDnJXRd73akNLN8t18wvpnA9RpUho6AN04T0Iz2vBWT7rmXfL7muLKYX90QFJCqjAjmnaVbbQOFOMDvrSCwqnIoz//gWWbls32OGXbZM+QpZdf1JBetQY2xgu4GUJFo+NDq6NS0qIT9BuILE/AK61+t24KVa/cbpt30g6yLzteBZ36aw9UyY7gIK8YCGKORog2KPJ0EzCe1Ur2AP24dwS31UqSFMQF8A6IApJSSh+U3b3o+UgLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vp8WFwues+j7g3A1JqtCjd/bGE10okRTurqUunvYS+0=;
 b=YVnzbHnzgZ2tleSNMm7r9xa1BnIed0JuKf2MjAv2Pp49GnN8kIDnWb47NkI/RHujIh6gakTOKTa/F5gyClCVCBNWRINreRQ4680NI03qs/pMYdLnw68KpSNf0vPDjsVbKu7qsMw0uNkiQo+uRDtaAVNoWehfb2uTMROjaA8kuw0W+0PbKwiobzNGnaZPcIMU5UORTViwO1pW+CGg0rC7G6jPZX9tyhvVO3gl9al2VYnG+TrzMRqNkt9l07YkkD5fkzvBlB/+nYtPrvw3iSTPfYpUrot1XKN0IlrkAsGA1jGDMXnrfKvX2EM62vec/y+fzYh86OqL9m+m8hw2ctyLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vp8WFwues+j7g3A1JqtCjd/bGE10okRTurqUunvYS+0=;
 b=pwAcmmKGUcBoCFChQ1FNO7DW9h5jXVsaMtQQUXi1go1bmrplgUNffolOMN1DWnFqhppJDZ4giUcWECvMhVmIqkN3n2Whvg/SP1+uFJDaKD4cDwjhEcKyMHneec5Zqc1BtPDUtXOuW4K/6TXJCAOa+UtJnspOOltOkApoAfjx6IEBDtV/fbXYlby1B4MaFokO5lzZRU+/X6IgInOPEVAxCCTARekDMI/dERabWK/eEB5IX9IOD7Hzeu2U5UXcFrw5MxRfsJ2CjdLY6FQDOpmKPPSQrypFzl8r3T/RIzv/iSCQVJvZpaqRa4VpKwnVAZp5R0RM0UVoeInXpJtlaXTkKw==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 08:03:46 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::963e:9c86:4830:2ebd%4]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 08:03:46 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Topic: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHcHkEVyZvN/mVpTUewNZT1jGrd9rSI8BSw
Date: Mon, 8 Sep 2025 08:03:46 +0000
Message-ID: <IA0PR12MB755515C5F3B47040B59E098BAB0CA@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <f6980853-3559-4a7a-afcc-5a7a2385335b@redhat.com>
In-Reply-To: <f6980853-3559-4a7a-afcc-5a7a2385335b@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|LV2PR12MB5917:EE_
x-ms-office365-filtering-correlation-id: 41a6e37c-8193-4200-79c0-08ddeeae3cc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MzhnakM0ZkdGTU95cDRxdEVvR240UGtsbWhKRFlaNUNVRE1mc3lscXlibTdR?=
 =?utf-8?B?QUhZZlVGU0tzVTFkUEdNdnM4dWlwV0RDeUp5NFBWYXVWd1Z5UlFGR2VvMzdP?=
 =?utf-8?B?eDl1dS9xV0lGUzRlMS9zNXo3OUsvemNGWTcxbUhTcldoVnRNNEx3UmoxTXY5?=
 =?utf-8?B?ak9ZRE4yZmpHUWVYQTVSOTc4dXhXcXl4TXBoditVTnk1U3d6Y3orQXg5K0Jk?=
 =?utf-8?B?bnpnT1FNcU9PRkF0Z1BzYXF2MGJOMElPQ1QwSjQrd0lTOFBCM1dXeTJkMThz?=
 =?utf-8?B?OEtqMklPQWdmdGhma0daRk0xR0FWdDdBMnRBeDlKQWJWZGN5SjE3aUR0T2ho?=
 =?utf-8?B?Rk53T3I0WllYLzdNWnk5M0didFdhTHo4c1FwMGlTNHlOVDMwWDBlZ1cyNkF0?=
 =?utf-8?B?QkdBcGpYajJKZmZDZnZmeEdUTEl3YlJMb2VKWmZSQ0tKUldsc29aNXBZb0h4?=
 =?utf-8?B?RVkxNDVjcC9pZ0c4T1ZEMG9XZ1BmMk14ZEFCVVd3TjJ4OVU0MmVxUy81QTk2?=
 =?utf-8?B?QVlRU3ZJVEI1THNOWHVObWtubTZMaC9EclgxNXVXRmdYV3cwaXNsSFFrRHVH?=
 =?utf-8?B?Q0RFWjRjaTlGSFUvdlFvK203SStVN0g2TTVMbkQxZlBQR3B0czN4MmkwMEtS?=
 =?utf-8?B?dTdBMm9zS2xrT2M1RlJhYUxsVmNMWXg3Nyt2RTJJTnlyZkFCU2ZtRE9LdFZl?=
 =?utf-8?B?L0daeEF1MWZZeWlxUnlQUVcwWFhGM3hoclpoMDN4WGtDN2k2SWR4elp5ZXFO?=
 =?utf-8?B?Y04xWGg5eWhTOGJ2MG9NUWRRSGRVODIrRWMvWVJWK3lGNnBETDByaldmWk91?=
 =?utf-8?B?cXoxQ2l2Wm5xREdoTnRPQkZZUlFEYnJMK3ZlNlp1U0tEZ2hWbnBEbzhIM1pU?=
 =?utf-8?B?MzRpY3RYc0NMSVFQYS9YLzFuSjBRbFhkNkd5ZHUrSER5OWU2M0hENHMxWDls?=
 =?utf-8?B?eW1Lc1pGcENWejBGS0ZuSmJGMEpwQWtLZmdTbHhWN2hsWGJjYldJOU1sOWJP?=
 =?utf-8?B?dUZWK01YS0VUV3VuVXBpY1hHcmdmMjJKNGFSZmtnOXo3TU4wajVSLy8wMmpL?=
 =?utf-8?B?TGJ0Qzl4bkQwQzQ5Wlg3OXRURHh4eXcyNkVFVW1paDRLSGtYcWpnRGlzU3Jh?=
 =?utf-8?B?dklvTklST243V2wxU2w4NmpjNk5qK1QzczBTZGdKNWNhYWdHUUhKdUVEczFS?=
 =?utf-8?B?cUFsK2Q4NnNRWk5jeVhNTnFOV29adEdaYUR2K0dhd0FiU1c0c0dsSkhicUww?=
 =?utf-8?B?UUN4YkVjb2s5bGN5ZHhJQlNxMmI3emhkYnhubmgwejRhTFR6VHVBOEpHTUho?=
 =?utf-8?B?L0NuZ2x3Nm1wbDZtZ2pWaHJsNy92aTZpMzNoelNYSVZKc3d0VnN6NGxNdlZH?=
 =?utf-8?B?MXNGN0FUd3ZXTW1lNmN5WW5vYTZiN21wa2dHQmJ5MVI1V2hheWk3ZmptZ2dF?=
 =?utf-8?B?eXJRUGVoSmc4T0FuNHQwS1RraDR5YWxCcHZWelZ0aWJ2dTFTK1ZFb0MvcU1m?=
 =?utf-8?B?aE44a2VtbURJMHlEMUt3Y0p2NGJ0bWozM1ozVnlDV1hRaC9mMVVLRzVJNytD?=
 =?utf-8?B?a1NDVi8vOWxESmFkU2E4MW85Y3ltcnpTQ2k1VU5PaHZSV0dCVkxYRUdHR2V3?=
 =?utf-8?B?VVJZWHVvRng1dXM1ZW9scnUxMUwrdHB2QmFHWjZIbXdFb3pudDVKdDJYYXc0?=
 =?utf-8?B?Y3lkSGxadFZjZnJEQ2YybW1GenBTK3ZjeUZLR0l0d0IyQ09CV3VFeTk4cy96?=
 =?utf-8?B?NzNBM1J2T29scGhHMlgrYzhCTm5HWkJ0OGdSclZlNGZPZVlvQkk1N3p2bzI5?=
 =?utf-8?B?UG5NY1VyRnJFT2hSUlhPNm1rejYxQjZWNy9XOVQzT0Z5OCtCcitacTlkZUxQ?=
 =?utf-8?B?UFBDci91d01tanVoaEk1WkNYTXltTGt6K3V4Vno3VjgramRPUTBsTWQ4UStG?=
 =?utf-8?B?Q1FveWRjZUl1SjhaNWZSU2FtRTBLODFFS0RlTVlYbkhGbHo3NTFKSkxscXJj?=
 =?utf-8?B?L3B1bElrQzlBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S05QZXhldWZMV214cDF2dk1INUpZaGl5a2RZUHNMamZkNmpjM3dTZHRHNlJQ?=
 =?utf-8?B?YmgwcndDMXhPWDBZRDZIc2l3dnlKVHRrdHo3R1N5OEJFOW05OWVYNHZqcmo3?=
 =?utf-8?B?ZnZhRWxCMXc5SmkvOU9tODJHUzRQZlRkNVh5bytYZXZ5Wnp3c3lXKzBObWdq?=
 =?utf-8?B?VHRBSm9Cczh1em5qTk1yS1BWVzRzb2NGZUJhK0tSQWg1d2tyaFk1bGVKb1ow?=
 =?utf-8?B?aDNKb3V0TUpGU05NL0duUjFQU0JEdDI2SE55eUx2NlF6Y1p3UDB4N0RBV3FN?=
 =?utf-8?B?bW5qYXVWTjRtL3RNN0RGYkg4dnRNNVZhZDljc1h1Wk5yOXFkUjlpV2RTU01T?=
 =?utf-8?B?TXp4S3hmSmZDcmJacThKejlOZ0srMFZ1NGhYTWJGY04zZTk5cFhmcXA0Yzlp?=
 =?utf-8?B?MkZzQ3hjNTNIdkx4UFp3MHE0Q2NVODRLY3k2eDJIdk5zOWVxWDU4T2F6OXg1?=
 =?utf-8?B?SS9EdWVISnBYY0daRGovQjZaZkQ0ckY3VFZBUEdiNk5OOXU3OGM5dUk0MmRK?=
 =?utf-8?B?R3RlWU9TaTZsTi84aWpYdlBKcTkyeDRDM2d3Y2hJOEpyM0tEcFJZbXlnVnFQ?=
 =?utf-8?B?bytLU01xKzBHdUQveERYQkFobjFCdXBCMGRYQ2U1RWpkcE9IVHU5TnBoQ0tw?=
 =?utf-8?B?ZjZlV3MyVG42T04vbXZlRUg3RXJMTXN1cUE3VWs5bmsyOGxWa3pFaktuT3dK?=
 =?utf-8?B?dU8yOWcxSUpocllpVVBDU3UvdGx2MkZTa2hBT2Mwalk1ZFNqQ295cjUwVThj?=
 =?utf-8?B?VzlXajhXQkFuN3kvNEtXdjhQbFAyL3pXRVFBMGxXU2Vsd0tDQWZpWDdHSlVL?=
 =?utf-8?B?c2lsWDBIcURpM1MrZGlzV2VaWDMvenh3MEZnbHhhait6S1grSlFId0NiVTdX?=
 =?utf-8?B?Y25iNitWSTlmNnkzc0dNYUMrcm1PUXZEdHVNb0graUwxdS9iRE9vNHEyeDZS?=
 =?utf-8?B?cC9wcFJQNkRBTEtPdmtEWFQ0TjlzclZhR3RqWlFlZlpTWEswQ3lZbTIvQVhh?=
 =?utf-8?B?aXk0Szh3YzNhcnNNNDRDcmx6YTNwWmpTeVhaMGc0a29aaHFhZ1VxSjV1eGpP?=
 =?utf-8?B?V29hRERHdE5HM2VvZ2IrakxEaHZnZHlwNGJLSXhyRThqaWZrVWg4NjZUUlhI?=
 =?utf-8?B?c3FqNCtCTGVuM002dTJCNGxRVi9BQUQ2TW5VUnNiTlR2N0FrZkFqMEdRUmI4?=
 =?utf-8?B?VmdOcksrWjVyK1VNd3Z5alVFZDZDT0pCMjNSa1BMemhDWHBxeEc2RVJVZUFH?=
 =?utf-8?B?ZXJCcU9EOWpNRlVocWVlVHJub0Q3TVQ1VE9iWkpwc3YybEEzWm9rVEVKSTdx?=
 =?utf-8?B?ZWxFSVZtWDl4dGVxTU1TUE40UzdGV0ZLUXdtaXVjbWUrQTEwTmFiNStteXEv?=
 =?utf-8?B?OUFFbWxSMGYwSnhxakVLaS9MaEZSQVRSbTZZN2JVMUhIVEs5MUJuRVFpT0JP?=
 =?utf-8?B?RFUrNHd3SmZCbGc1Z2JYZFVsRnJ3N1M1ZFJUYWcwWVZFOUtvbTZIWEkxSWRZ?=
 =?utf-8?B?SU5IRmdiQTBwU09KRDNuaDJrS2M2NjRINC9iZEZ2MysrOU5lTDQrWTdVYVUw?=
 =?utf-8?B?UTlJcUV0M3g4TmplNURTcnRjRGFSeWhuZ0FNTStKYS90M0xmUmxDLy9hUndl?=
 =?utf-8?B?azZCaitIZ1JJTjdsZ3pha1JjTVZ0cEZHQ2tnRDJQc3MrS3U2bTFIR2sxcFg2?=
 =?utf-8?B?YVpOT1FoWXlxcVBndEFhcTRzTEdSa3VJQkNKZFFzSmRISm9PTVJjRFhKQlE2?=
 =?utf-8?B?QXNtVGFKckpTbjFWd2NmTXZHNjlCRHdVclB6SGRhWFN4RC85QXNZTTZNQW50?=
 =?utf-8?B?cTlxYnZGWmFjZ0dNbTk2U2FtRWd5N29sU3czUW5CVDNXWkxRUlUxTWhKcFhV?=
 =?utf-8?B?cFlsZHFsZW5mazhsaDZxZ0pqclRXVkhLSmNWazl6dDVSNGpSZ1JQaHpEajlr?=
 =?utf-8?B?dU1qemcyNWdIM2JncTZPYWwyYjFPOGlPUnh6L3hGbGxkc2swbU05UEhkd3Fa?=
 =?utf-8?B?ZjFNMlNoMWN4bm9wWTl5RHluaXViQjJ1ZGlmb3p6TVd4OGdhYThRV0pNRWpO?=
 =?utf-8?B?S1Jpc1c3c1JJUCtaUmcwRFIxWERaUzh1ckFBdHVmaTFpVzNEQkV0a1BrcVFG?=
 =?utf-8?Q?IbWVldZj7bICjsxGrYjgjCg4V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a6e37c-8193-4200-79c0-08ddeeae3cc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 08:03:46.7675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BijAwm5gpiyPwS6kJOD38LOliJT7bfRBohRmnXjtdvG/CYhal3zBWbQoRpD6vtI8mrPgYZbClJ8sZK0SwoyNXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917
Received-SPF: permerror client-ip=2a01:111:f403:2009::610;
 envelope-from=skolothumtho@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FORGED_SPF_HELO=2.131, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwNSBTZXB0ZW1iZXIgMjAyNSAwOTo0Mw0KPiBU
bzogcWVtdS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBTaGFtZWVyIEtv
bG90aHVtDQo+IDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gQ2M6IHBldGVyLm1heWRlbGxA
bGluYXJvLm9yZzsgSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT47IE5pY29saW4NCj4g
Q2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IGRkdXRpbGVAcmVkaGF0LmNvbTsgYmVycmFuZ2VA
cmVkaGF0LmNvbTsNCj4gTmF0aGFuIENoZW4gPG5hdGhhbmNAbnZpZGlhLmNvbT47IE1hdHQgT2No
cyA8bW9jaHNAbnZpZGlhLmNvbT47DQo+IHNtb3N0YWZhQGdvb2dsZS5jb207IGxpbnV4YXJtQGh1
YXdlaS5jb207IHdhbmd6aG91MUBoaXNpbGljb24uY29tOw0KPiBqaWFuZ2t1bmt1bkBodWF3ZWku
Y29tOyBqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb207DQo+IHpoYW5nZmVpLmdhb0BsaW5hcm8u
b3JnOyB6aGVuemhvbmcuZHVhbkBpbnRlbC5jb207DQo+IHNoYW1lZXJrb2xvdGh1bUBnbWFpbC5j
b20NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjMgMDYvMTVdIGh3L2FybS9zbW11djMtYWNj
ZWw6IFJlc3RyaWN0DQo+IGFjY2VsZXJhdGVkIFNNTVV2MyB0byB2ZmlvLXBjaSBlbmRwb2ludHMg
d2l0aCBpb21tdWZkDQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBs
aW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIDcvMTQvMjUgNTo1OSBQTSwgU2hhbWVl
ciBLb2xvdGh1bSB3cm90ZToNCj4gPiBBY2NlbGVyYXRlZCBTTU1VdjMgaXMgb25seSB1c2VmdWwg
d2hlbiB0aGUgZGV2aWNlIGNhbiB0YWtlIGFkdmFudGFnZQ0KPiA+IG9mIHRoZSBob3N0J3MgU01N
VXYzIGluIG5lc3RlZCBtb2RlLiBUbyBrZWVwIHRoaW5ncyBzaW1wbGUgYW5kDQo+ID4gY29ycmVj
dCwgd2Ugb25seSBhbGxvdyB0aGlzIGZlYXR1cmUgZm9yIHZmaW8tcGNpIGVuZHBvaW50IGRldmlj
ZXMgdGhhdA0KPiA+IHVzZSB0aGUgaW9tbXVmZCBiYWNrZW5kLiBXZSBhbHNvIGFsbG93IG5vbi1l
bmRwb2ludCBlbXVsYXRlZCBkZXZpY2VzDQo+ID4gbGlrZSBQQ0kgYnJpZGdlcyBhbmQgcm9vdCBw
b3J0cywgc28gdGhhdCB1c2VycyBjYW4gcGx1ZyBpbiB0aGVzZSB2ZmlvLXBjaQ0KPiBkZXZpY2Vz
Lg0KPiA+DQo+ID4gQW5vdGhlciByZWFzb24gZm9yIHRoaXMgbGltaXQgaXMgdG8gYXZvaWQgcHJv
YmxlbXMgd2l0aCBJT1RMQg0KPiA+IGludmFsaWRhdGlvbnMuIFNvbWUgY29tbWFuZHMgKGUuZy4s
IENNRF9UTEJJX05IX0FTSUQpIGxhY2sgYW4NCj4gPiBhc3NvY2lhdGVkIFNJRCwgbWFraW5nIGl0
IGRpZmZpY3VsdCB0byB0cmFjZSB0aGUgb3JpZ2luYXRpbmcgZGV2aWNlLg0KPiA+IElmIHdlIGFs
bG93ZWQgZW11bGF0ZWQgZW5kcG9pbnQgZGV2aWNlcywgUUVNVSB3b3VsZCBoYXZlIHRvIGludmFs
aWRhdGUNCj4gPiBib3RoIGl0cyBvd24gc29mdHdhcmUgSU9UTEIgYW5kIHRoZSBob3N0J3MgaGFy
ZHdhcmUgSU9UTEIsIHdoaWNoIGNvdWxkDQo+ID4gc2xvdyB0aGluZ3MgZG93bi4NCj4gPg0KPiA+
IFNpbmNlIHZmaW8tcGNpIGRldmljZXMgaW4gbmVzdGVkIG1vZGUgcmVseSBvbiB0aGUgaG9zdCBT
TU1VdjMncyBuZXN0ZWQNCj4gPiB0cmFuc2xhdGlvbiAoUzErUzIpLCB0aGVpciBnZXRfYWRkcmVz
c19zcGFjZSgpIGNhbGxiYWNrIG11c3QgcmV0dXJuDQo+ID4gdGhlIHN5c3RlbSBhZGRyZXNzIHNw
YWNlIHRvIGVuYWJsZSBjb3JyZWN0IFMyIG1hcHBpbmdzIG9mIGd1ZXN0IFJBTS4NCj4gPg0KPiA+
IFNvIGluIHNob3J0Og0KPiA+ICAtIHZmaW8tcGNpIGRldmljZXMgcmV0dXJuIHRoZSBzeXN0ZW0g
YWRkcmVzcyBzcGFjZQ0KPiA+ICAtIGJyaWRnZXMgYW5kIHJvb3QgcG9ydHMgcmV0dXJuIHRoZSBJ
T01NVSBhZGRyZXNzIHNwYWNlDQo+ID4NCj4gPiBOb3RlOiBPbiBBUk0sIE1TSSBkb29yYmVsbCBh
ZGRyZXNzZXMgYXJlIGFsc28gdHJhbnNsYXRlZCB2aWEgU01NVXYzLg0KPiA+IEhlbmNlLCBpZiBh
IHZmaW8tcGNpIGRldmljZSBpcyBiZWhpbmQgdGhlIFNNTXV2MyB3aXRoIHRyYW5zbGF0aW9uDQo+
ID4gZW5hYmxlZCwgaXQgbXVzdCByZXR1cm4gdGhlIElPTU1VIGFkZHJlc3Mgc3BhY2UgZm9yIE1T
SS4gU3VwcG9ydCBmb3INCj4gPiB0aGlzIHdpbGwgYmUgYWRkZWQgaW4gYSBmb2xsb3ctdXAgcGF0
Y2guDQo+IEl0IHNvdW5kcyBhbnRpdGhldGljYWwgdG8gd2hhdCBpcyBzYWlkIGFib3ZlOg0KPiAN
Cj4gInZmaW8tcGNpIGRldmljZXMgcmV0dXJuIHRoZSBzeXN0ZW0gYWRkcmVzcyBzcGFjZSINCg0K
VGhpcyBpcyBub3QgcmVsYXRlZCB0byB0aGlzIHBhdGNoIHBlciBzZS4gSSBvbmx5IGFkZGVkIHRo
ZSBub3RlIHRvDQpoaWdobGlnaHQgdGhhdCBhZGRyZXNzIHNwYWNlIGZvciBNU0kgdHJhbnNsYXRp
b24gcmVxdWlyZWQgaW4gbmVzdGVkIGNhc2UNCmlzIGFkZHJlc3NlZCBsYXRlciBpbiB0aGlzIHNl
cmllcyhwYXRjaCAgIzExKS4gSSBjYW4gcmVtb3ZlIHRoaXMgbm90ZQ0KaWYgaXQgaXMgbm90IGhl
bHBpbmcgYW5kIGNhdXNpbmcgY29uZnVzaW9uIPCfmIouDQoNClRoYW5rcywNClNoYW1lZXINCg0K
DQo=

