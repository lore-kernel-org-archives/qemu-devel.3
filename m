Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E3ACE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 15:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1bO-0005QM-14; Mon, 17 Nov 2025 10:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vL1bL-0005Nk-JY
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:57:11 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1vL1bG-0000eB-MY
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 10:57:11 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AHA69S1313801; Mon, 17 Nov 2025 07:57:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=xutl4pGhW+zcQ
 JnGVuc2A743ISAWdOyQiIRKH2B32so=; b=w1/NB7DQRmO6CFh4m9zWvXEX+EaDk
 XCFNrcl+ihfZZzLj5NKlguUdZ7UR0vpH/DZNomu66rRLOhc6hTRlwrOef91iH761
 +5PjujR/5P3hvVMhglfmX6OuoBvfgI1juiZjN1nHzUzmtPigggxDOWSOwO7QsDXX
 DyPbUiZdRKOokwefuYf0hT4UkU6QM0JJYtOQQqC7cBb5WkrYqPG5IQ+lnWieeS6q
 zaz+eRosJfq8/TrZ/5gSGIOCvTM1k4/sSSiSDcReS5ExHdFZh1zybb2TYTR5myrw
 qkxQLiHz7TN51WcalOpDjrN/4ZQB7rzwL1Vcf4yMa2FtiVM4W1Cx0S7RA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021093.outbound.protection.outlook.com
 [40.93.194.93])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4aesx3kfr9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 17 Nov 2025 07:57:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wu1zX3gZ7891uyICKd7Wj0OWmiZAtvAsocudVZPzcQa9iWf5llM30Pv+E14W1c8ankAvWuVIsdfn2dLCVymO13YdQ3b5Pg3wxwa8na2R6hw666iqDyWH1n4y006jw5JU7dt6aJFMosa+8VVnXtb+tXPbZx8bVu/lFjabGkJHV35PNhfq6GysYvxFPynwha0cbBIVXvPvWkJIMF/JS3KJIlEUjJByOsZt8Klj2O5Zxd05sa/lRwURE8tnH5/9RnupP5RZGFqCAf2QHNC+fW3pXffAdBZN28RnLfoJMTVGRAbecOEnXJaPWwmfwW1aHUN1tv0poGsLZ9FJfjtoXDkiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xutl4pGhW+zcQJnGVuc2A743ISAWdOyQiIRKH2B32so=;
 b=G89KqtufIdpFzc171rsY0Il8mXlhBGvE0eCl79+fjhgODMIcrv/ZsmV6efwmAFYGRab0qY7iSwuwgCHsTuf0wvYQQIGcsPM4Eq3YDF++Fe0u/LXZAkE0Tn7agPVcimhSEyAEnDXdkSWfNDpDEUmNNaCqfhjEddjq5s9jf+/5UU5R3G2pjNgj5MW6KNhGSQWEWo9v4nAPL2Z3UjB4sY6B5sAku5ptYKqp5+zbqcMk0Hb94VsKuzDo+z3iwuZr2RwGnivALymmpOGXvDSh9htxYLbkOIoGFbQV9PiOPAXhV83a7pT2MqAH25uSom+4T7zw+YG0PbLd4WtHhTsXZcQxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xutl4pGhW+zcQJnGVuc2A743ISAWdOyQiIRKH2B32so=;
 b=eJMw6TqEwm1wZsLaxZQNLWMTQOZbCPUEqiKGpgLWu7E8eNCpdvmtoM56nYQ6fWEhYN3kGUJo9TCngrL19oVUOKqvkGX/8NBMThTOZSvINZYYC6IMcbshyFCEohwEWbqQWOV2bohf2vxwids2j3+GhJyDo8tQIHCRBNwII1jW1M4SL/8DgX2L/XCnbICPcQIIZZdNJW+BEgk1GV2QH0Rs77wB9dsbfNxnR3aPyviUIUruReI44uqqNqJCWJ9OVz0WW7y8wSFO+BjA8KYBu8XNwHAsXeoj2JVO2+EDgcI7b30+yADWVLEeVYnHkKoz+Rcj8foF8sLXCfrzSVWG8wjlMQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH7PR02MB10025.namprd02.prod.outlook.com (2603:10b6:510:2ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 15:57:00 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 15:57:00 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 0/5] vfio-user coverity fixes
Date: Mon, 17 Nov 2025 21:26:51 +0530
Message-ID: <20251117155656.2060336-1-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0226.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::15) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH7PR02MB10025:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9307c5-abcd-4f8e-0b14-08de25f1f143
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGhvNm1Dck8yRkpoTTBGMGU4VlVxRCt1NitVQVZJQU80dlRaQ01DbmdaWkRZ?=
 =?utf-8?B?bDZFUTM1Nm9XUUhXQURMZ3NkZS9KTEtmenV4LzlVempGZGRjQXJEK3lBN1Jh?=
 =?utf-8?B?TkgzK3JDQzhBdXZVZHN3MFNrRER3OXFsMU5CMExBbHZWbXZBR3JXREEvcVRX?=
 =?utf-8?B?SVRYb3VaSzAzbzhZRm91SEVKZkRlNG92WjZrUURuaW5YcVRvR3l3VFZzSTNJ?=
 =?utf-8?B?cnhJcmYrNUZtSnZTQTlYM3kzODRaZ2JrY1JITGd3amRoajVhZlgxdUc1L0Nz?=
 =?utf-8?B?N2lSYmIyUzgxOCt5d0x3emlWNnZqMEdrK08zdlcyR1lBeDFVRklqanZJMXM5?=
 =?utf-8?B?aUM0c2RJNVJmYyttWXFNVGlxdWRNTDlXMWo0Z0o5eld3cW5kOENPT04wZlVp?=
 =?utf-8?B?MHBUOWhOeHY2KytBS01EVnlsQlFTdm5UVzlIaGFWNWxUSnJOY005akVqMktq?=
 =?utf-8?B?djlDQ0ZXUkdaSTdmVitxYUpRd0ZLSHl2OUVTc0hOSkp3UzJwaXRPWlRoQjdF?=
 =?utf-8?B?UWUvWVdoNFVSY251UURTN2NjdVRid0MvQlkzSjBMWmxXL0xhMUhwQjNRS3FG?=
 =?utf-8?B?eEY0Z1NQR3dIeTRhL1g1NGFjRzFBQkRYQ3phNXQ5ZThjOEZkbG5lV1BKcGVn?=
 =?utf-8?B?Z0dKbHlKeWorQ1ZES0pNeVpJWGNNeGtGVFZhdEVFcUlIWEs1eGtxNWlYVC9r?=
 =?utf-8?B?N1lQNlJHT1FHWm0yQ01uQzdpeitSRHJGZ2g3T0JaUFJPdndjSUtoR2pUalNm?=
 =?utf-8?B?Sko1YS92WCtnKytrVHhxM2JQL0FBZGVjWHJGSHg2Y2tKS2c0MUNUUmtzNXhJ?=
 =?utf-8?B?czBSUk5IUjdNMHp6ZFhnVEZBU2ExTDBCSUhrWHBpNWoyelJOUHJwM2lFREZn?=
 =?utf-8?B?UzFWZjUwU1NPK0JhemdtRytRRWhnTmM5dVZwS3V0M21Tc29rODhNQ1dKUGEy?=
 =?utf-8?B?eVdzeVZNdkFnNXpJQ2pxMnVWRUpKRXN4Uy95cHRaSDZmZzZOMnZvdUJGSU4x?=
 =?utf-8?B?VE90VFltSnZvTy9Ubmg0UExTaFBLaE51K1NhOWcwNHMzSUd5OUorMnVyL0xp?=
 =?utf-8?B?TzBIblR0ZkwwSU16bnZOWlF3RHlPSUgzT2Z3ZXIvQlUzWkFVMVBSeTVmZHdC?=
 =?utf-8?B?TTRBaU80WXdUYjl6bXJMYkFTY2MyYjQ1YTNBalYzNHYwMGhOL0JvTC90Y2d6?=
 =?utf-8?B?R1FCWlRiNWRNTXFnamtHc1RBQWxOemlDTytoWnFVOHF5YW02SEFIYkRzUTk2?=
 =?utf-8?B?ZEpiczYrcVNNeHQ4eEJvU1FPSkk0MGFiQUVVVU0rbWEySEZuemF5NnZJcUQ5?=
 =?utf-8?B?d2p4K2pMdDdHeldyZ1pvclBYQ0J5dlZkR3AxRFhIV1RqUk5CYU9INzFwQUtK?=
 =?utf-8?B?a00wSWFMT2djejVQUjdwSFp4VDJFY3FncWJPVWtsN0krdTFHMjRJSUdHL3dJ?=
 =?utf-8?B?NVJHK29UbDV3b1lHT2g3Mm4wMHZyb1N0Q0toVjZSdlBGMk1xSjJ2OWFHNEhQ?=
 =?utf-8?B?WUxudmZhbVd1Y0hwa2xjZGdBZUNQdUlVbWxuOW9FSGZWaStrdXl3S3hUME8w?=
 =?utf-8?B?Ui8rUkhxcnFGblh2NjdOajVyMUVXOGtKNFFLdXl3dTZzdWxTeGdkbnlIQWpT?=
 =?utf-8?B?VDBWSmlIaEdaNTdER0J3UzY3OWVrT3grTzBYYmFrejYvTjBmNCt4QVZFTHdC?=
 =?utf-8?B?b1phNlMvUm4vU3dnamJtZGVland6ajFzODZjY05saGtOd0RzNnVHSUErMVox?=
 =?utf-8?B?QVdSZndYcUdKNW43Y05WYm5MZDg5R21oSDM2WWRZR2ZXVVpkT0tsNTRlNU4x?=
 =?utf-8?B?eWJjeW9nZXFIMldtWFJUOXVVemp6Z3ZoN05FVUFZZURNcHNjMEZicTFKRkll?=
 =?utf-8?B?SWlpRWVrWnN0Sm91T3kyVy9CZjlwdC93UGVvejJhTVdZRHZkOTRSeFBwSmNW?=
 =?utf-8?Q?8QZw2WkEwUha6wxd25mDQd2CleabFq79?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEV3dVFpY21QQjljVTQ1Z2xMVy9udDI5dUVsODJVN2tuUk5vY0pxV2daTEtT?=
 =?utf-8?B?N04rMkNRODFNUVoyYVJTbXZZMFE0eUxvemp4SXVrd1Q1bXFvYk9UQ3Vya1ZD?=
 =?utf-8?B?OFBsUFFZNTdJbHVUWGZUdjVJaGRlNEg2YllKZmlzdElLNUhOYnNPVkduTEdE?=
 =?utf-8?B?WEVXMHVEeGNWVVc4dlVSQkY1Q0VXM1FleUZLUk1TTlJaRnFEYlZocDhRWVRo?=
 =?utf-8?B?ektTa0xwZ21GTGRja01mQVR0VkZkSmpoN3FONU9EaHVxelYxY2NZNnZkc3U3?=
 =?utf-8?B?Nm01clJuRWEzZlo2dmNFSWNaY1AvVGN6dmlINjI4NEhRMUtxNWZPZXlVUENZ?=
 =?utf-8?B?WnN3SFphN1pITVA5ZDc3dXhNbUlaRWpMc0RXSWVobU01UStWY0xhSnh0VUJu?=
 =?utf-8?B?RWpxNGI3em9DTzR4WW9QTmtiTlg5aFZ0Y2xGYmlCR3B5RHhud0lvaDRFWEhv?=
 =?utf-8?B?NmorYkdwaFZBc2crZ2JzZTRZWUUwMDhsVWp5WXRWZDI4RHBoU3VnQlducUw1?=
 =?utf-8?B?WmdsZlVSQjdqL1RXSXFON1JreTRxZmNTbjd6OWtiUjJVR1laYWFCNytqZXpT?=
 =?utf-8?B?dTB4UDFwMjBncEdaQnRnM0lIQTJ5Z2N2KzA5THRXem01dVhuSVFLdnFaNWtU?=
 =?utf-8?B?NGpoYTViTGQza2k1cjE5cGlsZjFGRityQzNJakZ3cjFyNXZWTnlMdEptTkgr?=
 =?utf-8?B?bU9GaUQzNjQ3eHZ1V0JhR09ZMXlPQkczOUUzVWdUdVZyVFAwa0pPYUtMeW5t?=
 =?utf-8?B?KzFxZE04YXZWUmxMSFU0ZDVlbGppb1kybE1LbGhmblkrdjRJSEFLOXdrMzZ3?=
 =?utf-8?B?WFh3Wk9TL3dGMkEzSWwrV25ZWDVGQ0R0aHlnYTF2d3hZbFhEb25zcDR3QmNj?=
 =?utf-8?B?YVYzZHpxTjBmQWZCRzk2WUZhYTFiWmJZc1lLSFA0SHJHbmlrTEY4bnB3K2tr?=
 =?utf-8?B?T2FpaWVrNVVLQldhemdOWDZsTlk0NEtseE9OYm4yMkhRcXRrTXZpWS83Qysz?=
 =?utf-8?B?aU9ydmt4RlBueTh0V05jYjRNL2lBb1BBMWgrU1BXdEFud1Z6bFM0ZGl5T25n?=
 =?utf-8?B?R3NuQURKT2NpQnROR1dkWlIxdHAyMjFnRzY4azdoVkExTWo0R0Y4NE9xeEkx?=
 =?utf-8?B?eHJhUnBrZjVrRXkxdndlRUNadGxiOFJiTVF1bE9sTFhyUXR4VVFLY09ubGxW?=
 =?utf-8?B?aU5FVlQ1a0lzVnJrelpDUWZ5NDc2ckZESHA2U044L0xPZUdvQW5iMXE2ZlNs?=
 =?utf-8?B?MnJPY1BRMnFraWlqL3I1SWdhYWpmK2hMbDNEK1JBcWFUYm1mVlhRRVBxQnMx?=
 =?utf-8?B?MitMNDVvTXA3Vms2Vll0Wm16TURuakJVSW9OVTR5enRVcFBZNXZNZkxrQjEy?=
 =?utf-8?B?eVJtSXpKbEgyWFovRG9xY3doOCtINDBHV1hMNHNOM1Z3WE8vM0xjU2N0cjJ4?=
 =?utf-8?B?V0pSeGo2ZnJ6L2xaaTU2RHlyQ2wwNnMrQ1cxb3ozSTIzci9xeXAvcUNhZEh0?=
 =?utf-8?B?bm9mL2xKLzdFUzZqNEJmbkZuaGlERUZlalQ3T3dCcHBtU0NqenZRNmMxNnRh?=
 =?utf-8?B?VkhLTnpkVmowaTJjdjdqME5Cc040Zk1xT2c5MUM1Yk91WERvZTZXNDlXMWtU?=
 =?utf-8?B?NjRtZElKYWhYWCtWTi9WeXRBV2FwVk8wcGs0cENNYlZRUGZCeUF0N3JmWjhO?=
 =?utf-8?B?TDk4WXIxUFVLR0QvNEZFeXhhVlZDZ2dpWWFEdlV1SXM0aFkwTjJaTWFVTTU0?=
 =?utf-8?B?cm1PY3A2Qk40YnV5TzZPR05XQnJFK1cxN0hsMWhFOEZwUFB4bS9ZTWhpcExx?=
 =?utf-8?B?NXB2N1VZWnk4Tll1cVNtMXNGanh0UVk5STFrOHVqUWFRM29UcSszZ2Q0czBq?=
 =?utf-8?B?eWZVNmRJU1c3bUQ1WEUvcWc3eGFZYklhNTh4dGZGWW9XV0JldldpNjFzMDQr?=
 =?utf-8?B?b3RPTzZValpXa3BSUnMvaU5ML0xKQ0NhV3F2eUJ1THdORk8xdlNsZVV5ZEVu?=
 =?utf-8?B?bjNBcm9RK2MyL2dBYmZxYUJCVEVtYy9kd2RPcHVMZ2l1bzBBUXJyUmcreGw1?=
 =?utf-8?B?dGhZamt6T0xqUjJVV1VxYTdmbThPNmh3bnAyeURUWld3c3BSckI5Skt6V25u?=
 =?utf-8?Q?ltXSH2biPvhE3lUmRe51jSIve?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9307c5-abcd-4f8e-0b14-08de25f1f143
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:57:00.1150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDOz74kSNRcnKIKYZO72LwX8TqEhiofhfrtY6l1++9OWMOFsGY//4zJM+oRxxZkYpT73rNi1WJ4SRegahEaKsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10025
X-Proofpoint-GUID: mkVS54y2h4u1xf64DkUM2F4YHbSJVo9X
X-Proofpoint-ORIG-GUID: mkVS54y2h4u1xf64DkUM2F4YHbSJVo9X
X-Authority-Analysis: v=2.4 cv=VKTQXtPX c=1 sm=1 tr=0 ts=691b45ce cx=c_pps
 a=G8VycjxW3wO8/D/xgNJDKg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=61wL3NVAMDne11lxUa4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDEzNSBTYWx0ZWRfX+N+AOugKpRtb
 nlDOrA866DEFDQZzs0PCTgIpogdLE1UxXWSSEv/2gXzrwT9CvT3rbY8UUTbNfWbyvEy1+IQVfl7
 eNH7EjaagtG1PiHXJP66u7z/QdxmB+Hgr/gwUcCbljuiAmDLTBKXZZ/7/zQmoQaV1YFebeITVDj
 I2eGLmREkTLTeNzPhFHObYivRke+i3AgPJDJV9vqyEZ1anXL04O20jArcbkfJkU+YLJz6NQerM5
 XkarI+LiD2X6swkIl00Tu52iooKav4njx+PswvdSXmEDRpSUVQHMw0gIztQv1mI3zAF4ZG38IKy
 27i0+Lei0rnk6+eJx8qaTKjk1oNwbz3uH7Em3i+O6pS5yfMkEJouMlbgvQ+ggOTLqwys6b3ua60
 l4lpGa37HM3sr4Hb0jwlGu3mXIID7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Fix some coverity-reported issues with error handling in vfio-user message
processing.

John Levon (5):
  vfio-user: simplify vfio_user_process()
  vfio-user: clarify partial message handling
  vfio-user: refactor out header handling
  vfio-user: simplify vfio_user_recv_one()
  vfio-user: recycle msg on failure

 hw/vfio-user/proxy.c | 204 ++++++++++++++++++++++++-------------------
 1 file changed, 113 insertions(+), 91 deletions(-)

-- 
2.43.0


