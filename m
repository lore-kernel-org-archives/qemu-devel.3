Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AD8CA0FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 10:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urDhI-0004uN-6B; Wed, 27 Aug 2025 06:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1urDgw-0004fZ-Ro
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:47:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1urDgo-00043N-Nb
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 06:47:45 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57R2cL5M2967180; Wed, 27 Aug 2025 03:47:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4bqNILGhZfpsIG9ELymjnYACguif3xVgQgcCWB02e
 Io=; b=2uQritowz4cq2BiP8wqncBnKlqzVx7y/J9QIjWNs9OfOamHgbm8B42m8G
 xuUwT0v53UkXnoPL6RnardVsSioTKdORjuDw5LhoadIgQYbLk0JtP1CvheviuLkg
 KWwu37EU16ojpa4h2uOMhDB9zGi5ajUPlRoWgbPqUi+bkQq3YlGIr9I1A1i0aO3Z
 fwQBmCeUol/7NW+sC6oeUPG3nxYk8wWhZtR0YCaCnwqQoYcUmdySPbhlPZOwaHBV
 Q3crabmFY1QeYmRXBeG18l9ycgty9sb0DX8Co+pFTO+X4Wu9jvVGge54HEbXbaif
 p+x9b2jGC5+HEGdPlzptD3tqh+Dyw==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2090.outbound.protection.outlook.com [40.107.101.90])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48s9pru5f0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 27 Aug 2025 03:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmLTtv3djoB39bDa8FAl5TYqYgwO0ETnNHWe0Q1EY+6dTddk7fAYqt0JuwliAucpCE8rSQ26/6yJwTvJlV5WDL+DBmg8hm0LchU2Y25V63/VqIFftsqrinpCtPMLHzhP1zz2U94fRJWWYuLPUUrREW7R5vgIqjhZDz3q3FYTIPxH195LFsDGPBgnpwC+GyjIrP49997uBnYkmDm6R3qyNQXhRJU49ybx/3xMf8pb1ikQ+ncA4TZRtXQ0SO4WCYBIN3Z03WFGFz11eclWwyoM1y1SNLV4e6Jdw3zsjou27CgF1uC9GKFxl5OQbbaRJua4ez8WxKGAaZ6VhEphVksFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bqNILGhZfpsIG9ELymjnYACguif3xVgQgcCWB02eIo=;
 b=gBIjySPrGDK/LQHy8kTokJnsFuqz3hwGk2yyoJKzt7FDWc/d5RgQtGinDSU6bAUrbDwy+cQRHLioDGQfLrcbo6wC+Nvi5Dn1f1vqeUAhlgCgFcY1hV19h9R9q4Rtp/UW5nrFsBMSTXsTiwi53WXrtEuWXk+0520AsEk4vQCSorZeapZ+l3fT6O9gCJvdRXG4FF8S2TuCgdL6eHfHdTCO592ZV7CYYtBTfrdTzit89Qihyn4snwRFnwWnrTxUOfN4bTsn4C1yvkzjRYTn2bJw0ehCvvwn913yTymGQTKgPyFBHR/cDwNVMHq8b6nvTzq7ZiiKArYNqVbyI8EVx7ZfRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bqNILGhZfpsIG9ELymjnYACguif3xVgQgcCWB02eIo=;
 b=f+fnXNTFsHiZzkb3fvKulJUk38R65QrTqXOVlcKhcph3yCPbBmJKDajBOsaIB/ya3lgJd3M4l+gfp7hB/xFMo7aeyUVan5Jnzvnme4FyQuhHsw/EvfN5dqWSFFtTNlAqI6QErcPtGvd7uDtUH1nZ6nsKu+y8hu/dxyQTi3FtXxWXiYh1nWB5nrwv3w3Q1vI8GV+6pfkfzfVaNzVQwbwNFaK25IK1661nzDxbCFi+IHscaveTYRlrKQMFfaabxk7jcM/46OMTN83ZMDEhLDwJcNHFRzjAnVTtABx7XcIBc27V4w396bE4TQa2pez+tbaVWwAF5r+pRwh889h2jq5Ewg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7414.namprd02.prod.outlook.com (2603:10b6:510:1f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 10:47:24 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 10:47:17 +0000
Message-ID: <26154464-e7cf-4445-81b9-11ccfa18dccc@nutanix.com>
Date: Wed, 27 Aug 2025 11:47:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/19] hw/i386/pc_piix.c: duplicate pc_init1() into
 pc_isa_init()
To: Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, imammedo@redhat.com,
 qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-5-mark.caveayland@nutanix.com>
 <010b2b2e-7d88-42b1-ad5e-ccd1518777af@intel.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <010b2b2e-7d88-42b1-ad5e-ccd1518777af@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0056.eurprd04.prod.outlook.com
 (2603:10a6:208:1::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: a31480bd-0fcc-4169-cca8-08dde557178a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmVwSVN2VFMxWEx0ZFQ5WEhKOFpIVDQ4T0IvOFhmL3hTUHMyZ0F4dFhvMFF1?=
 =?utf-8?B?blJKZmRmbXFzemVIZ0gvaXVmTDZ0Mk9BbE84V3VsWHJnRDI5Ry9vYnkrb0p6?=
 =?utf-8?B?UGJkSi85WWFMYUQxaDkvYlltNkRyUlpkcWhIOWF2aUVEWFFmd1FFREJXSm5w?=
 =?utf-8?B?TjNickVNTXdzaS9XZ2RCall6ZUJJS3I0TUxrblNoRnhEandldXJOZ29GOWxi?=
 =?utf-8?B?OXlkb0FDc0tPYXZSSXc0VEJPdWFIL0ZvYkNnQkZrNnI1bkplSzc0aHJKMXpj?=
 =?utf-8?B?RktHYVBNRkhQSVVobjRmdEx1WW9LVlhVZUpXYzBlRmZXZkd0V1ZxUjM3NWhC?=
 =?utf-8?B?NW9KTkI2RWVOV3lOelAwWDZYenZMV3RaUEN1Z2J6RkhGUG9vT1pEZ0k3V01R?=
 =?utf-8?B?Vk9LcU1RMzUwMEM0UUh4ZUpsU3U2YlFHY0MwWEZ3ZmJ5MURFcjVoWE5jc241?=
 =?utf-8?B?b0MvZ2haZFFPZGtObDRFd1NVSFpnMXBBazhhLzdSaGx2UUkwU0I3RTVlRndG?=
 =?utf-8?B?aW1IYXhPQlFoMUJ1N0YwSElFSkxid0wrOEJ1VXBZVUJnVUtrdWpZYVEwZ2tL?=
 =?utf-8?B?Wi9EakdVTkFGQnZTc2d0T25nZWxpandkYXVKdGp1NHN2VkMwOGJLcU5LR2U0?=
 =?utf-8?B?am9VaXFqVVJDbjhKbS9XWEVCdmh5L0krL01sMUNyWWhoenlCL3E0cnp2RVNW?=
 =?utf-8?B?amt3bENyMnIzK0lUcnJvN0E2WnZGbE5DVS94ZGJFQUdmUEhMQ0Z4Y3J6YlFs?=
 =?utf-8?B?TEI2ayswMTZUdjBwM3A2OW1QN3lMdm1JRnVqN1NLQVhPeEVORFlybmt0WTY4?=
 =?utf-8?B?M3d0ZmxqUkxHSWpZY3MxQVRpWTV6aFU2RnFOaGJOS3pYYXhvRFlLUUpMYjRi?=
 =?utf-8?B?T1h2VHFIVm1wdTl5bHFRSmZWOW50VFJNclFLNFhVMkY4RlFGUmJKS2pwRlFT?=
 =?utf-8?B?b0hrMzF1bE5pMnJaYWdCTW00eWtRdElLc05YelVWUmNSRUQ1UVRYYmNNN280?=
 =?utf-8?B?aE9XbGlwYXk0SVB1TC9VVDJqeXcvY2c5OTEwWFJKL1NCamFaZnM3bkszL3o3?=
 =?utf-8?B?ZmpUSjlMOFFURzZ2d0xTZmtQMnZ4YVFWeXoxRGlpNFdzS3g1UHlMN29qdnMr?=
 =?utf-8?B?OFlmbVFITHdJTVBOMk51RHBCQzhPdDVMTDkvYmU2ZEFBMWFvYkErTkUxa24y?=
 =?utf-8?B?MVI2VG5Xc0t3Q3I2MkhzdXN5WllRbUFWd2VJajRLdGFPcjdHMGNHVm5IQzc3?=
 =?utf-8?B?d3ZtUEZtc1BTanN6TkZaWDJrUllPakFNdHpaTnZYY2NLdnJ1TlRDa2pMbVcv?=
 =?utf-8?B?K1NjSFQwazZ3NWpHR3MxMlBYdEkvKzJSWjZObStZWEFwalRJMkFWR2VBbEhT?=
 =?utf-8?B?T3dZaXphN0wreUxtT0MzV2tjakRHTW9ONk94QU96V2wrNnVxSU9wQkNwYzBp?=
 =?utf-8?B?bGNzbEFYTS9VUXp4VzlPcnBGeFVEMnVacG5icExmYWFOMXZlRnRrL2ttNnh6?=
 =?utf-8?B?V0x2eXhuY3Y2UTh4blBkWHJnSlpqSWZJbHVwT1JxcUxESHdMRWYzcWQzd3dm?=
 =?utf-8?B?bnZwNDRURGhUT3V6ZHdkTEJyOU9BNktkMFJZNU1EYVlWTUpNYlhFQnB3bkZG?=
 =?utf-8?B?MWYyRlVDWWF5YmdTbXN6Z2RiOHdIOHFHOGR0K1ZCVExTM0V1VFBkTzNoSVZr?=
 =?utf-8?B?TEZZaG9MWFRvckVVa3pHV3o1VjNpR1FJNFdLWk5TVE41eVJjWS9LYjY5U1BN?=
 =?utf-8?B?OXY1QzZnZGhHZDUyekY0c1hlRHJmbXFodFNqZ1g5WmkySXZubG8wY2lCam1u?=
 =?utf-8?B?bHFFV2xpVEFYbnBkeWV2U3BhMDRjVW45Rk5GWC95V1h6ZE0vckhRVU8zbjlR?=
 =?utf-8?B?Q05EZmh6R0FGWUhvSWUyUEpZdSsxRHN2UUlwbFoxV21xWno5V09ZeHpmMFRs?=
 =?utf-8?Q?r+ibYxZv3PI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUlYSE9LY0N3NTM2RXVxUytQZThnditwdHhGZzVrRGJaRTgyaGszMVEwRzFm?=
 =?utf-8?B?YlJpdjEzSDVTMXFvbXRGZk1QdzZrTUlsTGpiaEorMUtHUE56S1JrS1BmZUp5?=
 =?utf-8?B?UmdCTnFaSmVxcmk2d2tKY2hyMUhlSmFVOUs4MStJYzBrdWorYkVnZi9CVzJB?=
 =?utf-8?B?Mkova2dyVzgxL2RORUE5WktWRzFDVTJ6QWhZMk41bVMyYUo5QUVwQzlRUmt4?=
 =?utf-8?B?bEF6UytpYjdxWHRBSTRLZUVYajU4cVo2SzNVTjMyOHg5NXhrOVhmazFjRzBB?=
 =?utf-8?B?cFhQWnhOMFpldlc4TDJ4d2pteGcrS3JnRjkrN0VwRmZIRjBQdlB4WDVwN2xN?=
 =?utf-8?B?eDlxc0llM0gwaUQwWjdDODdBVXRsY0tWR2lDRzdlalVJc05wdVZ3Uk9PcXFw?=
 =?utf-8?B?NjZoSE5aTUhYVmtiaWduaTFQM0w0VDlNQ0FPM2kwcTFsVmtmVm0wSWNhN01U?=
 =?utf-8?B?L093UXRwazljWnIzaXZybVZiZDMrSWN5VitTY0I5empKUFlZWmF5YUpQajg5?=
 =?utf-8?B?cVhnMThiNCt3MTFZN1A5M1NRVTduNjZkamg4bFlSaDhLRjV3NzFEVHV6bzNp?=
 =?utf-8?B?K1ZvZ3Ztck9oTGlnQzJVWG15R1h6VXVYZ0tNYVhIbWRYem1lNHJReDVNR2py?=
 =?utf-8?B?S3BtUC9xYll4OVRrRTd6Ni9tYk15Yys2QWk3bzhML05Kc2ZQWFlQOHR0Rm03?=
 =?utf-8?B?WFArN0VCd3BPWGhYbUE3NURKZFVEblRSTHltL01OMlJqOVREb2hqa0gra0pG?=
 =?utf-8?B?Wk13SFF3bU95c21FS3NqOGYrSzJ4TEtkeWdKY0lSdVU5UEJLR1R1ZDZCWG5t?=
 =?utf-8?B?WHc0MW94YkJnWVZkc011SVJaSmcrQUpaZ3pZRXYxRHN0Tnk3MUN4WjNDRFdk?=
 =?utf-8?B?K2JHVktJY2Rxenp6MlNVVENvSkpNVEI4RmIrenhjQVhFNUxhK3MzL3IySUdo?=
 =?utf-8?B?Y2pvU1NZTTI3RmhrRjRkQTRaVlVyZmFzNTRsT3lyaEJTVWJVeXpQYnYvMFlY?=
 =?utf-8?B?eldsOTV5U1dvcUlRMXBIL2FqOEVPNmRMNHhWVHRmRHQzWXAzbTNPZ3Q5cUdK?=
 =?utf-8?B?SkdwZUV2eUZra1RxazUvbUFBWk5sdFMrOTVqelNDeDN2TW02NGw4WE9GUVN2?=
 =?utf-8?B?TVErYTloS1B4RlhXTm5OVmp1ZGFWSTJFTTdOMDVtUTBCSVR3bEgrdXBocU9H?=
 =?utf-8?B?S291aVorSVVhcmJoTlRZTEk3VTl4eVBMcXRPOE9hL3M1eUxITHhVZUhKWk5m?=
 =?utf-8?B?bUtlOUszeTg1aGxDbjMrQjNNMFRTUWI4YUlPaFMwOFlPM0lXM3NGNWZyeHVC?=
 =?utf-8?B?azhETkRCenZ3eGF3RlhYZUNqeEFqRHppSjZDdlR5SG1XYzFZNHV5MjhJa2cr?=
 =?utf-8?B?bjlBOWppR3o0STlBdkpzYzJoSWNuZlNjRWs1bXhqMXBFeUxhMDRWdGJNcHFp?=
 =?utf-8?B?ZWNTNjdzSDRSN2tPelJNd2EzRUoyNXEwWlRteHlKeFViZUtJa1FFeGVOREY4?=
 =?utf-8?B?azhIeDBObW5WTzQwZUZxY3B0SjdIb3lGc240Yk9JRVhNb1BVUDQyNXBPd2xT?=
 =?utf-8?B?bHVzVm93cDJTbkpGTHdFUWo2Y1BZR2JVZVo4WXZVZ1V1QnRoTDllQXdlcWNU?=
 =?utf-8?B?cVBGREIxVC9weVRkb0FaTHVFNU1VL3JSbW0zVUlEUWNEOGE0Y2RUM2hDeHhx?=
 =?utf-8?B?bUdpblZCQnBkL1hUV2xzZHdjUVFlOXM3N0cyUnBBTGdOK28zeE8wd3I3NVdr?=
 =?utf-8?B?S2hIMDAwTjVCakhXSk5LYVBuMUNCTzhMeGpQamdrcmdmVG9SeGl3c01uUXo5?=
 =?utf-8?B?SlQ4RnhNLzFETVJUS1htcTNvMWhsTTFLdlVnbTE1ZnBUdlM2ZkRJaDRUdkJE?=
 =?utf-8?B?ZldEU0VJTDBJTDBnL21lQWxiT2ZJMUJKRHMyL0haNGxDVGtLU3IybGs0YkFr?=
 =?utf-8?B?Y3ZISjNGbWFzQzdzZHJsMENXdk5ZMGJhajk0b09OalJuRXp3MTlDaDE3WGc0?=
 =?utf-8?B?TUpPTWRpYUpHNCsxbjYzbnJHYWI3Vi9sSW1GY3d1a096UjdrNm4yYXVDTXA4?=
 =?utf-8?B?bXA5L3gybWZVOU1oOGxnSzdFUUJpREgvNEorVVpTRVRHbWk0RHFUeG4yUjlM?=
 =?utf-8?B?WTg2YlgyanZnRi9peURqZE9uVU0yaWNrd1hxNEhOczdOb2pwZE1CVndGcFdQ?=
 =?utf-8?B?dUhOZU8yR0JMYjBjMDdBNEJnaWc4QTdFTjJoeG5tNWNNNGV6NEdoRURsb0kw?=
 =?utf-8?B?TjUrWlBtYWVoUm1vZEdUMGxFeGhnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31480bd-0fcc-4169-cca8-08dde557178a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 10:47:17.9146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfleb4ZYZtwyPz7iFXJqnKDTR2+YLtGkAzdI4ZusKifqxTsOXPrpZvsEmkA2H63wViyB02rNoc3u8svf+7N6pcaOzqt1REQQsjfm/25voL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7414
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDA5MSBTYWx0ZWRfX70ukpJ5L603t
 MOi0KwyH+tVAryYDyLLcpO4zqLlvflZp7294wkBBr0MOEMiEMXKga9+5akIlDY1PPKS/lQGhMlT
 63L+v75OblfMKvukNXob4f8c/P9yjwp1BvmbiNTzyX/foQ2fE0GsDBc0xjdIUP4clTXEZS4RPbR
 Vct+on/8hWrnBl4A36RPPWsOd/18YiL+0FB5aXW5oXwdCqL1sGjuJIsDOB7NlwQogpsqTm7kIkE
 oa7m/p3foDyu9HgUb3QpELXtCEf00jKWbpWmSkn3GQTZXQtgjHbknQM9lqhKp7LMQ0F7AE8m22L
 aNvutmXz5l3e4A+nbO2JDu9uUElBtRuL3Ul22noMwUMlzr1fY6s/sBd7SBj2Ok=
X-Authority-Analysis: v=2.4 cv=G84cE8k5 c=1 sm=1 tr=0 ts=68aee23e cx=c_pps
 a=8L8FiTcFnCVlekLszpoA1Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=p0WdMEafAAAA:8 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=guU5Yos-aBU_fBW4BsUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: CGpKbPQ1YlSaD7iyGgMUq8Jf7qgKRROg
X-Proofpoint-GUID: CGpKbPQ1YlSaD7iyGgMUq8Jf7qgKRROg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 26/08/2025 10:21, Xiaoyao Li wrote:

> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
>> This is to prepare for splitting the isapc machine into its own 
>> separate file.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/i386/pc_piix.c | 261 +++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 260 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 071bf7412e..5b97ad2cea 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
> 
> ...
> 
>> +    if (piix4_pm) {
>> +        smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 
>> 0);
>> +
>> +        qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, 
>> smi_irq);
>> +        pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), 
>> "i2c"));
>> +        /* TODO: Populate SPD eeprom data.  */
>> +        smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
>> +
>> +        object_property_add_link(OBJECT(machine), 
>> PC_MACHINE_ACPI_DEVICE_PROP,
>> +                                 TYPE_HOTPLUG_HANDLER,
>> +                                 (Object **)&x86ms->acpi_dev,
>> +                                 object_property_allow_set_link,
>> +                                 OBJ_PROP_LINK_STRONG);
>> +        object_property_set_link(OBJECT(machine), 
>> PC_MACHINE_ACPI_DEVICE_PROP,
>> +                                 piix4_pm, &error_abort);
>> +    }
>> +
>> +    if (machine->nvdimms_state->is_enabled) {
>> +        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
>> +                               x86_nvdimm_acpi_dsmio,
>> +                               x86ms->fw_cfg, OBJECT(pcms));
>> +    }
> 
> IGVM support was merged recently and the rebase of this series doesn't 
> catch it.

Indeed, thanks for spotting this!

> I think we need to copy the IGVM related code as well, in this patch.
> We can remove it later in a separate patch if it's unnecessary for isapc.

Yes, it looks like we can just simply remove it in a separate patch 
since according to the docs at 
https://gitlab.com/qemu-project/qemu/-/blob/master/qemu-options.hx?ref_type=heads#L6186 
IGVM is only supported for the q35 and pc machines.

>>   }
>>   #endif


ATB,

Mark.


