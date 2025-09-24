Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EF6BCAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Oxi-0001ld-AG; Wed, 24 Sep 2025 08:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1Oxe-0001lM-7i
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:51:06 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1OxU-0005X4-GL
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:51:04 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58O4DDvK696579; Wed, 24 Sep 2025 05:50:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=eBaVvXs9VplH9KiDeeOK9ex4ArwMfcl3Kd0GFP9qQ
 8c=; b=sU8uVhR10SPq4ZvlhMRvPgb9Fwztdfw2sK7ROeqmgFnBuNzBRihwWDrZ/
 vc+5L8CYB7cbUoIPxu7unN009QgVDfeCwGM5xePXaKOxst8MOuukrXOq96qpGIVe
 QN5rQGTcyjYJdo2oeB3ybdLLdyvq3Uqz0wVzVGDWrOJGd59UeNMuZnz1DK9icn0a
 7IJRskq9AvN/7W6rsYD/gbHbsJc12AOTfP/BAw7aM/SFha2ebWj1pEubww3H+P5W
 lsbkAqy7dtzGK2hVQDF/U2Ns2/6qLLCPRt+6U6OkOJSEW8mv9q5DvEZUuZRMrIng
 rnPtn+0GtlVbGZ47jzLaiL3t7Z3vw==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021123.outbound.protection.outlook.com [52.101.57.123])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49c9dws31y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Sep 2025 05:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ug2zG13hMJgxohjrssELkDpIMkQxqSNgdqjZOLDYHG5u3/ShZN4C+Xg+2De1NOo+on4pd+VYhiPkixxpc78oDOjex0df1Awa31ECuVwv639+C8EpGkGK5vxpufgWDAwWG/k7H0Pj1/EMCCniVIFqCV11/Jdq8/SYp02GnzDhGSf5Q4y2wLbSJIm8ImH6WzLPwhPMrHQWbRk5kuvrBcN6Q4ma7CUHwnsQm47nXrXyrGUFSVTZ9YVRwjstYV6922HUSiidf8GO/FnLAKZC/W29ycF6qImmEvBbURT5T9+cKROC1ZsnylmOX1C4S+nnfv8FDuHc/mTVAmvVhbDxvceMVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBaVvXs9VplH9KiDeeOK9ex4ArwMfcl3Kd0GFP9qQ8c=;
 b=CVg9wAIRaA3e3iGmJ8sMwtGVDwYPJS77/vYruKAvIc6peeSiBpnRUarQknTbJ7F47cxkgCsIcYTTWuS0Uz6AA9nU0pp+PpuQ5dJObR8tc4n7OVytRTdE0gn6dPVKDi5RZjdv75z2pwSmRhfTNQQzzrTjMe4J3ZDThfKheibA8FuWbEV9BpxAszRstNOhctGvDKSvkk8EUFJe8CMB0I4vjFdgc67jJJURdUvFwPEkevZPeBTzLEKm5PhDJvujzOR2dVB2kOmHxxtrJ8e+f0o9BhR+uubPSGgzpJLxI5WtRl5QpZjM2QaU0b+CcV+iY9O4UbYUOvUu49LdHAqJJAqPjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBaVvXs9VplH9KiDeeOK9ex4ArwMfcl3Kd0GFP9qQ8c=;
 b=vKNp1qNCrcQ8I8o/FRvwUO4SYz2ZLcBOK6lp1ckn+2xqqymLTSMB0gCUBDdeM/VgDuizUG96dSag3/yztQSJ4pufdFjyrZtDPKnUKWIbK0YwMazOilb3gG0idR2wTL7zM4YOBuJ4PhULYF4BYezQmO4QK+9JQEtB0V0LnHtalK2rVbM6sLU7B2tS5q5JZSVZKKZOwyDi2S1aHGUXhaB6bkkkX4auE5AOCpjxUsHpie0E0NxdDzxhfPBj9DqTK6KENJJ8pF/oQ4h41oyVHNiMoVKQa0yHc2gfd3wHL08h2mpBCI+tI2fYDAbAxwbIc0asSpKh3o6WcMxxjQmxA/e5Aw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10734.namprd02.prod.outlook.com (2603:10b6:8:1f8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 12:50:43 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 12:50:43 +0000
Message-ID: <ddfb99cf-efc7-4883-8e36-6dbc1f4ece82@nutanix.com>
Date: Wed, 24 Sep 2025 13:50:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/19] hw/i386/pc_piix.c: restrict isapc machine to
 32-bit CPUs
To: Igor Mammedov <imammedo@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, qemu-devel@nongnu.org,
 Jiri Denemark <jdenemar@redhat.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-2-mark.caveayland@nutanix.com>
 <3c2e9fbc-db80-4dd6-a1a5-deeabb8c0194@intel.com>
 <58c515a4-292e-4aec-b57e-73be89b9c322@nutanix.com>
 <aK7wDn03e8RtKmk3@redhat.com>
 <1178e514-a054-4ace-a5b7-06ca899badec@linaro.org>
 <20250922143537.39896851@fedora>
 <bb967b28-4ec5-40b5-88cc-cebd7493d381@nutanix.com>
 <20250923113029.78c03a5c@fedora>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250923113029.78c03a5c@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0085.eurprd05.prod.outlook.com
 (2603:10a6:208:136::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10734:EE_
X-MS-Office365-Filtering-Correlation-Id: 7403cd2e-4b8f-4d00-4574-08ddfb68f952
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|10070799003|376014|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0cxaCsrRkdwOXlBNVcrWnN1TkY2ZWdIbmVaVXJDSE1qVU1WUDZxTElVdndL?=
 =?utf-8?B?Q1JwYkNwcUJHYWUzY2hlSWhUQVp1WWpDRzhJekJQMDhabG9iRlBOa2piT2p6?=
 =?utf-8?B?SzFrakxDTG5YN1l0Y2Vlb0hmQ2xUdXBiYVowaVZJdTlab2liMzJzWCs0dHM5?=
 =?utf-8?B?YXMydWwwS0tZMmJWZnZIa3d5VDBaZWJqSzNibmRCa01tYjA1eDlSd0lIT0FW?=
 =?utf-8?B?KzlvaW5WMFNzWTZyM0h2S1lQeVdUYVpFbFBCMVVCalltZndsK3pkTlE0YW43?=
 =?utf-8?B?bVdYenJlamx6QlN4cGFsMUhuQjF4TWxNSDhLN0J0OEZsbFZGRmQ0eWt3MFJJ?=
 =?utf-8?B?bGROcWIwNXFMbDVUd3AwSGE3bjNnTXhxTDFFVFZEWStBUWJXaXExN1RqMDRz?=
 =?utf-8?B?ZGRrekJwd3hENGdmR2plNi9KR0J6NEtqdXVQbWQ0VjdyTGlBRXN3RU5TNGly?=
 =?utf-8?B?aEltNU1NZElCVTUwWXhpcThjNzNmTlpkS1JWYyt6aGcxTnUzZUs5cVdTMWVl?=
 =?utf-8?B?SnBCTDBwZ3VYSGd1eVZFYldQU1hZaWNqbHlJdjh6UVoxWlM4U3pMZjNtUlhK?=
 =?utf-8?B?RkNHV2NHdzNEMU1nQkpOZFYrNFc1cWl6Y0ltc0N2cjVGc0Z4R29vWUpZcHY5?=
 =?utf-8?B?RGtjZnJlVjd3Sm5ieExIK1hFRm01MWY5Mjk1TU9JUUV3ZGRrY3gxUWcyVURS?=
 =?utf-8?B?T3lsMnBzbzltdUFOc1FCQi90NVdENWtOSE5FZUtvZkpnYjJUM2puWkRKWDAx?=
 =?utf-8?B?bjZkRVJBa2J4RW1lRFE5WFYwR1FrWHZEUE9ITm9xYnFDcGIzT2tCakZRdGV3?=
 =?utf-8?B?SGVia0hHZWlJT010QkR4dEtrSmlnTk4yTTA2STZjZVJWZkc4RGMyYlpqanNp?=
 =?utf-8?B?clNaMUxwU0FXTHJmajJPZzgzS2tUTzQyd0Q4RWZDR01MT01lcGF1VVNnclk0?=
 =?utf-8?B?cmx3OXVhYTlZOGtXb081cGFTRFV5ZW9HVWwvSFpDUFZyVWNKME9tWGdXV2ZI?=
 =?utf-8?B?N3AyT3lmaGVUWHl2TzlWR0lHRCtlMmRkUC8rdnUyeGxyWTY4d3JaQ0t4NDJ0?=
 =?utf-8?B?VGR3ampva0JjOXBsQVFrTzVQU09DUFloTWg2c2puSGZJZ3prNkN1WTdUQnNK?=
 =?utf-8?B?cEc3R1NuVEpKV0I1cE1ZZXlaYm82QVRnVmpnYzJuYi9FNGJxRHl0NGR6WmRU?=
 =?utf-8?B?cGRhRklhTCt6c2sxK3dkaHNOSjhoK3hMYkdLcEI1ald6WVdQdGdwUWw3Wkg3?=
 =?utf-8?B?b0YyNHU1K0N0Zm5QVWpsS29LUFE1WFJpbGN6aHVGYmxzSllRenBUUmNVWUlt?=
 =?utf-8?B?MExUUWtScUVVNmhRdHJQOHRtV1JwRTNmWFBldzE5T042Qk9IV1hTYUhXbGpr?=
 =?utf-8?B?Z3NyaS8rQWg4b0tKVzZ6c0JLNXRkZDNQWjlIblY3SzB0azVzRml5M3Zidlox?=
 =?utf-8?B?RzBzN2pCTnJnNEcyZEVQdnpiUnM4Z0pGS2xuT1RJSllJZG55YmZXWFEyZVJs?=
 =?utf-8?B?akxRd1lZaitvMG9Sd21lVWhrcFgwMis3U0VNbkk1NmhxejZzRElSc052NHdw?=
 =?utf-8?B?d0psWTVaZi8wQjljV0VJa0p3WU9VUGVVSmRpcXRMU0NMMEdrNmZwczZMakpq?=
 =?utf-8?B?Z0xEZmtNL0FsODVhRFRiUk45MHgyUXI4cHVpVUdhYnh4c0g3ZHR1VWFoeVU2?=
 =?utf-8?B?OC9CUTlOM2pMenVsRDRiZnlzSkJkQ0p4QkhFUmI1dkI3Wk40MDdlYk5JVFR1?=
 =?utf-8?B?TjNyeFFNVXk1VFV3K0MxYTR1TXluM1JjUXFwakFDelR4SmtvQVZqRWRiRVlQ?=
 =?utf-8?B?NjhrU1ovRVZ4aG1aQThadGE1MzRBQ3Q0cjJqdGgxY3ptdHZpcUY5alV3ZTRV?=
 =?utf-8?B?WmptdS9yQ3hOVENOamoyZHN3bjIwdkF6dmZjQ1k1MFo5dWJuVytwY053SXFH?=
 =?utf-8?Q?/qwFT/Wphcs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(10070799003)(376014)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzRvdDdWeFppZXdiOFZPeEc1MzRhMi9US1NZZmg0NnVUU0FvYzRRZlc1RU5G?=
 =?utf-8?B?S1VYUmgyUCtocXVXUDR4V1lHNFhGODRuWm1tL0tpV1lEbVA2OTNPSXhaczh1?=
 =?utf-8?B?NXhuMkppWm1zNVE5QTRSWVRSdzAzSnk3NFNGNkliTWF6SEMzcCs5bk9XTEtD?=
 =?utf-8?B?SUMySWNOdmdXQllDZ3UrWTN5WHBITUlhZEg3Q3Z6WjdCdFk3ZVV5dWNyWEhF?=
 =?utf-8?B?SklBbkJFYWx1K2F1WkZxcDVNK0hNUnQzS01NSXNYWkVpbEttTmRjSkF3SHpr?=
 =?utf-8?B?WlB1LzlITGh3UnNDY29yL29nNHRxMHU3Q2FEQkRmU1d3Y0hRdDBFNURuUkNC?=
 =?utf-8?B?SC9mdkZWRjB6WVE5UDRmd05ic2UzMHNnQ0dkcFJheCtmWmVteGtZaWNJd2tX?=
 =?utf-8?B?TUxGVGk5THZ4YjlGTHJ6T3VoakNJSzZQVXhWWlZvT0JYanFmdk42Nk9IQ1o2?=
 =?utf-8?B?TnRvOUZkSi9PYjQ5ZzlGMVFDZzNGVDFrVXYveTRDd3duVkhHSlp5aFZ2MW1n?=
 =?utf-8?B?UHg1dm5JNEhQZlE4YlBibW96eitWZ2JIOTNocURHM2pTaERjYVRudWZCdm5Q?=
 =?utf-8?B?dzlrK2hSaFhyRjE0MzhuZU4xbkYrbkNHUUJjcVpvMHdZMjJEWk5nVndpaVA4?=
 =?utf-8?B?aW55RlV1d0hUZkRDQWowUXJVTlJHT0F0TmlZMC9jYjMxcHRaY0dOQXFvUWZs?=
 =?utf-8?B?ejFlSUN2dkJJbVVGVmdwdE8xMTFYdGk1UVJIN1ZhcFh4K1o2bGZGVW1pQ1Jr?=
 =?utf-8?B?MmhjNFJWQld6M1R1MnZnZGlTTjNTR0Y4ZW1PTHBCaDFRb3p3R3pMazR0TFVn?=
 =?utf-8?B?UFo2OGV4WTA1RDBQbG1WZnlvL2VLNk5HS0U0OWgrbktDSUQwTHZGVUY0NzFQ?=
 =?utf-8?B?NE1HaW5idUxEKzBva0J0V0lJQVh2MDlUYlN5R2k3eHhpUDF3UlpNczFldUNT?=
 =?utf-8?B?ZWVTZHc4Znk1Nk1sNlppeWU3MGR1OEJhV2J4Q2krL2kwK2c5SzNGYUdVMkxu?=
 =?utf-8?B?aHh5ejcvTnNOKzdIVlh6Yk4ydTJhRVhBejd4a0hQN0hMa3p6QVhURWdEbHdB?=
 =?utf-8?B?aUVTaVlCU2lQemxFd0dKd2R0aXZXS3dHdjZycTY1ckdDNkF4di9xN3hVdEk4?=
 =?utf-8?B?VVB0SUZTR3hnQTF2aElqRm8rV3BsTE0zQ3JzU3RvMndQMTdaS2RuWm1rWDlH?=
 =?utf-8?B?eXlyeFVvSFpZWjErSVJzQ2dGSFNCdVN2aTRKdm1YcEJyazNxYWs4bkMxT3Bo?=
 =?utf-8?B?cTluWTlxZ2RHNXBIZFFtMjV4Zjk5ckI1ckQ0SkFpTFpOZHlmbE5xa09oK25N?=
 =?utf-8?B?dGlOWExwMDBmdllwcVh2YUxYbmtDdXRra2pxWElRQTBOTnllU2FkcVNJRndw?=
 =?utf-8?B?SVUrM3FCSFo5UVRRL2RkTTcrYmtVVG1STUNvOVlwQXdkdURVY24wN3ZON0d1?=
 =?utf-8?B?bkE0T1ZEeUFKRmxPd2xrWGlFMWNXL0RnKzlpRm4rQlRuRFhNemRTaXBnN014?=
 =?utf-8?B?NGF4cjdNYVVHSFRaRnp5THdEbWtjc1lPSWoyblVIdGFsbDNHQlhiZXhIQXN5?=
 =?utf-8?B?cm1zNittdXViejJFb3phRGNCMk9yd0Q5WmtKeGZNVVR0c0NqdmtacHFaTHRU?=
 =?utf-8?B?QzlLdGsrOE5WQVFQaTNEUTROaFFjbTNzS2tHR2thVnNkKytzTVVTS2Vtbk96?=
 =?utf-8?B?aXVYZEtEdDZQTVRobGJ4RStOaVpJVC95Tmp3blpQb29wdlc3RHpJN2cxemRV?=
 =?utf-8?B?d0VFMm5qNmxaT1ZyTityQnJWSGxrQzFHaHNrRVU2cGJWTkNKWHdJRDBKQ2Jm?=
 =?utf-8?B?SHYvVHpmMFVhaVJvU2FPM1FTQ2xncmVlb1pJeDdLMUdISC9MUzgrN1J5RnR5?=
 =?utf-8?B?eWdka1R3bTZZQm5zVks2RFNER3djMjVTODgxQnY0R0dKOEU0N3JwelBnSUZ1?=
 =?utf-8?B?RWd2azZXVnEzelJGSHVzd2NBK3V4N0ZoaHU4NU5wNmVPdVFNVnJjQTFxcjdr?=
 =?utf-8?B?UkpybGRzNVFjaWpqTzFoaGNLNTMyUXRWTEI0aGJodVl0UVZNVm5YdVlqbkV1?=
 =?utf-8?B?RzFyK0VxTmhtMjlMMjZsNkdaRlBTYzdQUE9WMzN6aUU3bUhiNVNTa2I4RVI3?=
 =?utf-8?B?R0RCUzR4NWdBc1FnSHlYVjMwdFI1MVpEOUhtdVBOc3ZxQ2xhRFhRUTRFd1V1?=
 =?utf-8?B?aXF1Q0Q0MFBKT1gzOExUa0s2U3hMeEJVMGFEUzJEY1pDTk9aOUxoRnBmN2ly?=
 =?utf-8?B?OURUbHo1Ynh5dWtjNkF4dVFBV09BPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7403cd2e-4b8f-4d00-4574-08ddfb68f952
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 12:50:43.7755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UzHAGRKOdisE9gN0x8GAGTsXxw2gTBu1pC3GNskYGh5h+KFbbqSMdnbzI+S1b3hpdb6hP5I9W3l7YjTNZzbGHSH6Jc/87K0OmN59soFtTMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10734
X-Proofpoint-ORIG-GUID: Na7HqnqTxduDWaV-nXNFsY1op6c8mYfE
X-Authority-Analysis: v=2.4 cv=DtFW+H/+ c=1 sm=1 tr=0 ts=68d3e927 cx=c_pps
 a=ffxAIQPz1en3uIgdmftvlw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=TwO5F89O0gy9Z8t02nUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI0MDExMCBTYWx0ZWRfX2IEIqiM6IXn5
 xZd1x/+w5KHibcnJwjt5mAEtfEFnzsqRCMWkScRkeHm+sl6UspaVvVzKR9916lPxjPWrHJusDIA
 o9AwRheiVH8VDDwl0U5cRTzotS6aafzlbR12vG7mmpL4WtkUYPN0QnSemLNko9p2ucUR0v+ILAS
 iW7uSQRif6Wzt6uKoaLSGAzkS0fiz9U8EuZsQqpxkF/YKG3X5FyJZCsazXBDCXXsIs1I6ftaNY0
 Cj0P7JMwCr5Dgc+cIqSsSVBhkbT6Fo9kWpOWPxXFc7HyQUJSiMA4WKK5RYBzS6WE7w0wO1AJ6ty
 a23eGFcIVhFfxu8Iz8aizRZppRb+3XRqACezHN+T0ydnKXD/0iFykxASWzwl0g=
X-Proofpoint-GUID: Na7HqnqTxduDWaV-nXNFsY1op6c8mYfE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

On 23/09/2025 10:30, Igor Mammedov wrote:

> On Mon, 22 Sep 2025 14:56:57 +0100
> Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> 
>> On 22/09/2025 13:35, Igor Mammedov wrote:
>>
>>> On Mon, 22 Sep 2025 14:05:13 +0200
>>> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>    
>>>> On 27/8/25 13:46, Daniel P. Berrangé wrote:
>>>>> On Wed, Aug 27, 2025 at 12:10:00PM +0100, Mark Cave-Ayland wrote:
>>>>>> On 26/08/2025 08:25, Xiaoyao Li wrote:
>>>>>>      
>>>>>>> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
>>>>>>>> The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
>>>>>>>> possible to specify any CPU via -cpu on the command line, it makes no
>>>>>>>> sense to allow modern 64-bit CPUs to be used.
>>>>>>>>
>>>>>>>> Restrict the isapc machine to the available 32-bit CPUs, taking care to
>>>>>>>> handle the case where if a user inadvertently uses -cpu max then the
>>>>>>>> "best"
>>>>>>>> 32-bit CPU is used (in this case the pentium3).
>>>>>>>>
>>>>>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>> ---
>>>>>>>>      hw/i386/pc_piix.c | 26 ++++++++++++++++++++++++++
>>>>>>>>      1 file changed, 26 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>>>>>>> index c03324281b..5720b6b556 100644
>>>>>>>> --- a/hw/i386/pc_piix.c
>>>>>>>> +++ b/hw/i386/pc_piix.c
>>>>>>>> @@ -436,6 +436,19 @@ static void pc_set_south_bridge(Object *obj,
>>>>>>>> int value, Error **errp)
>>>>>>>>      #ifdef CONFIG_ISAPC
>>>>>>>>      static void pc_init_isa(MachineState *machine)
>>>>>>>>      {
>>>>>>>> +    /*
>>>>>>>> +     * There is a small chance that someone unintentionally passes
>>>>>>>> "- cpu max"
>>>>>>>> +     * for the isapc machine, which will provide a much more modern
>>>>>>>> 32-bit
>>>>>>>> +     * CPU than would be expected for an ISA-era PC. If the "max"
>>>>>>>> cpu type has
>>>>>>>> +     * been specified, choose the "best" 32-bit cpu possible which
>>>>>>>> we consider
>>>>>>>> +     * be the pentium3 (deliberately choosing an Intel CPU given
>>>>>>>> that the
>>>>>>>> +     * default 486 CPU for the isapc machine is also an Intel CPU).
>>>>>>>> +     */
>>>>>>>> +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>>>>>>>> +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>>>>>>>> +        warn_report("-cpu max is invalid for isapc machine, using
>>>>>>>> pentium3");
>>>>>>>> +    }
>>>>>>>
>>>>>>> Do we need to handle the case of "-cpu host"?
>>>>>>
>>>>>> I don't believe so. I wasn't originally planning to support "-cpu max" for
>>>>>> isapc, however Daniel mentioned that it could possibly be generated from
>>>>>> libvirt so it makes sense to add the above check to warn in this case and
>>>>>> then continue.
>>>>>
>>>>> Libvirt will support sending any valid -cpu flag, including both
>>>>> 'max' (any config) and 'host' (if KVM).
>>>>>
>>>>> If 'isapc' still expects to support KVM, then it would be odd to
>>>>> reject 'host', but KVM presumably has no built-in way to limit to
>>>>> 32-bit without QEMU manually masking many features ?
>>>>>
>>>>> I'm a little worried about implications of libvirt sending '-cpu max'
>>>>> and QEMU secretly turning that into '-cpu pentium3', as opposed to
>>>>> having '-cpu max' expand to equiv to 'pentium3', which might cauase
>>>>> confusion when libvirt queries the expanded CPU ? Copying Jiri for
>>>>> an opinion from libvirt side, as I might be worrying about nothing.
>>>>
>>>> OK, on 2nd thought, even while warning the user, changing the type
>>>> under the hood isn't great.
>>>
>>> I second that,
>>> Please don't do magical mutations of CPUs, just error out.
>>>
>>> we used to 'fix|tweak' CPUs using machine compat hack,
>>> however with introduction of versioned cpu models we shouldn't do that anymore.
>>> (aka: existing CPU devices should stay immutable if possible, and any visible
>>> changes should go into new version)
>>
>> The original suggestion for allowing "max"/"host" was so that it
>> wouldn't cause any regressions with command lines erroneously including
>> -cpu max or -cpu host (which I believe may be possible with libvirt).
> 
> looking back and at Daniels reply,
> max/host are indeed are 'special' aka mutable as opposed to named cpu models.
> 
> if we go by the books, 'host' and by extension 'max' should work with KVM accelerator.
> But that (aka reducing it to isapc levels) should be done at 'host' cpu model code
> and that part of code is not really aware (nor should be) of machine types.
> I'm not sure, whether it's worth the effort and complexity.
> 
> I'd be fine with valid_cpu_types[] approach here, i.e. user will get
> clear error that her is doing wrong thing trying 'host/max',
> and printing suggestion how to remedy error should guide user
> to the right config.

Okay I've just sent through a patch that removes the -cpu host and -cpu 
max mapping logic for the isapc machine.

As an aside, I think it was originally your proposal a while back to 
deprecate isapc? Now the main series has been merged, is the current 
split sufficient for the tidy-up/improvements that you were planning to 
do for the pc/q35 machines, or is there a way we can improve it?


ATB,

Mark.


