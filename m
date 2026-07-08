Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7113DC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whPVm-00063U-W2; Wed, 08 Jul 2026 06:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1whPVm-00063G-7k
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:28:14 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1whPVj-0008Fh-CW
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:28:13 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66887krD776405; Wed, 8 Jul 2026 03:28:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=sIWpZumsKtEvoUxPR5089y7AaCM76/QRXKrbJYpRK
 6k=; b=LChZcrf1Pvsf5hVBvZuZtAHJ2BB2Smx6ex1MdNcqUYXGbi2aox4zRPx6z
 bJEPmAU6Wj8XjCbeLDfrMmPn4zPl9U8iEm8O4rwqs1BV/Ndhpog52ZZGt6tYbQVR
 uPv4HiXzCezEtS87WAFC5ZrnJf/LfkMwMKbdjezB1xwOBf9hfnPTznprNjVS1KVC
 US7Qtwc+rx9uE8urJ4wIoTnGlVUN8xEXyCq0/oBUcLBFf0BZ+1vXAfTIM9QPd1OH
 lAu8fKNNxOULB4sfx26Auof6NrynBZ9oZYTD2zAFIzDFmwIUs0rZCSeRfcfl/YkI
 Fmx5eEiAOvpzZgLDvHKcfMIGLqSTQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023123.outbound.protection.outlook.com
 [40.93.201.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f97wshwbw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 03:28:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/+PniJ1Saiu6Tj5nBeAKmi4TbQvAJNLmD2sq2S6/nY2bJw5GO17IGUfD+g8KJou32ZPZ88GgdC/r1r3o1o1YFG9mRna22RBtrXbtu64hgN3s7uTZ9eehx4Xz/0zWVSuZc+qnR0JBrkTlwoqYnGAE5GCTIcDkz7xXJxVh842f+RfTWda26YWNlmBuc7gQAMWJx+egHztvPUytyXn8OU3q38ZfN/PNV1y4ZRj1RjTnh39fS5HSMsHVIPLwvAMN52twcRVf+l74l018HiA+YzjZemq9NUcE6lVowLCqpobDTfzECTGMId4Ub1VSqQ45HsQFHMOMrylZL7jdF0PaafpEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIWpZumsKtEvoUxPR5089y7AaCM76/QRXKrbJYpRK6k=;
 b=A1cCzd2k4Hk0zUjXRjKr6gkd/K0e60td8QZkuDEU6IA0Sert+Sua4Z+StB444zM3WZKfO48WYKw6gJSBRF53WIapN1B0598O0BnTESP7jWdKYqIbokstPVwixgED+oPDeR6F50mak0Vpsxie0PGknRRRd+cbUGODIJth2Z1lgAfXg75kf8rE2aBMpABtfJ1Gj2oTjUlTroebdNi/KWE8DJiBdtHZA/nbKEcaZVmKKDJlAGboU7Uvvo/RrX/NdiLwU/dYmjuzopEJFODqFg8RiLyzCDhALS+t2upMvqM7vmr5HBiMvqL2c94O0Kj6ScTQ16T2Zhrw99ehxDQicfwAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIWpZumsKtEvoUxPR5089y7AaCM76/QRXKrbJYpRK6k=;
 b=CqKgwnXdsOqGrpnW9zQDoq7iS436eBMuAOvQGov52VtaJk3ULa12lcT73NXR8vtYzz5WHf8FwKpAi2II8aOWcFZtxeXARWUcHFmwl0L04roHqD4n1ydgUhdtqYQajtDTHAoee06Za40rIo83ZqKSkJoOu1rsVt/UC+8wnzyFRiL2fb9141b3pnG8EXQab0WcynH4Rd/HjRpyTYXbjUY7QzTqAIKpeNilaTMfKYBzi3fyzABj/517EzsoNwiprwt3l7Wm/bm1s+swY6Rx3q+owb2PjV69ACo7+uWW79/NTpT+F+jTVfH23lPuzUHpKRFXkE9HAtF8NwPU4T7n75oXJA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB6541.namprd02.prod.outlook.com (2603:10b6:5:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Wed, 8 Jul
 2026 10:28:07 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.014; Wed, 8 Jul 2026
 10:28:07 +0000
Message-ID: <85749cad-b072-47a9-b48e-692f415bd84a@nutanix.com>
Date: Wed, 8 Jul 2026 11:28:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] hw/i386/pc_sysfw.c: convert pflash0 and pflash1
 object props to class props
To: Peter Maydell <peter.maydell@linaro.org>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
 <20260703090814.2993188-9-mark.caveayland@nutanix.com>
 <CAFEAcA-Agr3jDYfM466UtqNywfxxX6Vv6H30B8QQDMykQ0ktOg@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA-Agr3jDYfM466UtqNywfxxX6Vv6H30B8QQDMykQ0ktOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0070.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2de::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: c9eee757-e113-4525-2b3d-08dedcdb99e3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|4133799003|4143699003|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: M+AtYAF0TcYD/oUxbgjen/VTdSrEcuaPXRUjZw+52ewIXQXiY1q5kYkvST+XOc7BjvPYLnLCyL+ZaqZV8CDupLvJYRG+1Mjd6UcCn6bom3QE0RvzbLmTykIyiYrZZEYt1rEbYo27aheDnYGW0AyU5OPYfSprdW9X7mFHYhhJx0I2THkgioRsfuZBdtCL03iDcs/4eYGSFjz871SWIeXOg0aNIWru59Iv4MbsfcRGXr8YciM/EnF34CbQmvCIrCMYup7hvAhE9uIhFOtpLZDDzb6cGP04USpKaXNjv+GLeb32p43fTrJVpRgy2E+J+2P21p+zFRpNkR6Hc6Bbflup7srh3Ey6nB5tr3VFTHjH0Ek3nQNqdH+HPQan5efxtNjUKjmswJ1JI2FdTIv/55gce+q51QiJBnrlEhAd15PwChFzw/0aEGlYUt1r37o2PcZL+vp2wsFvKQ94oIQH96uQCvx5lHnDCJJntq2iUy+3q8KcueDaUAyIxOHdpLmutKTJ+yZ5Bv0MzRklRW433a3bEh+nnXPXjhW5mXi/wJFDfF/if/xyMo0zW86tndCKkdI9m1b88QKt2BPgKLIjFsiK6S+38bAV7nC5mysLwEmpNElfOSPRyKqnl3fWwRVNZoB+tAbnzDU6fYnFuUGjEsAFkNTxrVrF3ANc3yM7IW7EevA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(4133799003)(4143699003)(18002099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3FwZkJCMlpMRjZTcjhmbzQzbVZMMVhTU2NBUFc4N2VkNXZqWmg2WWVhV2hM?=
 =?utf-8?B?c0QwNnFhTVhJeTRQd2VKc1h1QTR0dHRzOXRPSTVLa2tiQlVqZGNHc3lkcmox?=
 =?utf-8?B?dVh2cEpxaDFaTzhRNThuUnI1ZWo2K3dCY29ENWs0RjBvbWltWnh6ZlYwcEdV?=
 =?utf-8?B?cThZbGxRemd3YjlwS2VUMEZHZGs5bmNuTzM0dStUdGt5OURRZGJKdWM5WUpj?=
 =?utf-8?B?UElTMzZtaUJIeC83MnpIM3BJdHNkaDB0K1BNS3BXVzg5TDF2VFR5dlA1NHJB?=
 =?utf-8?B?QzczWW9wZzdRTndsMWcwUmVrWnczUnlQM3NXNktvRURvK29EVzcydHQvN1o1?=
 =?utf-8?B?RTJ4UjAwZTFxZFhUME5qbVpvZUswOTczODRmYU9RVnBPRmJMQTVaUzJJcVRG?=
 =?utf-8?B?a3BWaWhqZGhvL0hSRFlZVVUwSUpmNVo0ZlpOQmJYQXlreDJHM3pPTUd6cjdY?=
 =?utf-8?B?UGJWRTQvY1gxd1ZvSHFsdi9RQzJpazJmTUVaTkI0bGRrQzNxaVpuMlpQeTh1?=
 =?utf-8?B?YWJzZm5LeWxzeGZEdVVGdElCMW5EUXFZUTRxbzBDZWdnYUoveDJHOXBaUVlp?=
 =?utf-8?B?bFl5QVRUYWt2VXJIY2dBYmtqUEU0RFBUbVlNcTA0NTRNdkZQVnRxb29nalhp?=
 =?utf-8?B?d28rN2NtN053QmdKNm1Mc0tjQ25oK3Q0OFJrR3ZPcWNiK1hxQkoxQ05XajRF?=
 =?utf-8?B?Qk9LU0ppKzJXSUVkWmRFMEZ1M2M0Z3RXdnZIUzVuN2FPbWVSQk1yRDhWbm9J?=
 =?utf-8?B?WCtHeVBiRVIvNFRINmEyMzMvSlNmbEhaM0QydFZjVnVQcVJGcTJIVktxY3Ar?=
 =?utf-8?B?SXN4ekJIMFJ4TTBFUXZTRnFucjFrd1pPWm1oK0xwd290VkpxSVo0L3NWZVhj?=
 =?utf-8?B?SnlnQUpnYUpwK1p5OTdDd0JPSjFmUlhkN2hYNnp2Rld2NkpwREo0NXA3UVVW?=
 =?utf-8?B?TTkwakNpaEtFa25hRmRzZ1pIWmM0NUNkMVI2ZzJXL2w3TU1uRE1CZ3lEbEF4?=
 =?utf-8?B?REVkY3h4U1lUOGkzeEZBS1Zpem8xQ3B1Vjhob1NPaStOUUNCNzhqcGkvbGlB?=
 =?utf-8?B?d20xQ2RvRHM5SE1KZG5vdTJzQXFVQXVZNlJaeWFqSnNpd0lINE04QkNIbXIz?=
 =?utf-8?B?dnRCNVoza3NVSUtHdXRGaDZ5VFh1bjkwSnh5c0tYdklpYmNpZE5vcnZ0Z05D?=
 =?utf-8?B?Rit1a3pkSVVRK2lGeVRUR1I3S1hxN29rS3RndkY3SjNwaVZDRTNrM2NOZTZx?=
 =?utf-8?B?VzJZVFBZR1A0dGJrOEZ5UjBGaHhiWm9MMENuSy9adUFFL3Q4WXRVRWpRcHly?=
 =?utf-8?B?bVZ4QUpyS3hyNUJWenZYUnNuRmFZeVVvRHJIcWYyRXJtcWhFNTV0amZQdlpQ?=
 =?utf-8?B?d3BuS0lsampyODFXcU9rQmE5NVhJMFREZVRXYjAyQW9MZ3JHa0VhYUk0WG5z?=
 =?utf-8?B?cWlsZzVXZE9pTlpZNHZiNE9YNnJDYk43cFJxbXZ5RGk3dnhBanpTeEx5VE5y?=
 =?utf-8?B?TFBZcUFaUlU1Q25uYWI2c2ZibE1VL3dKWitEWFNyVHFESEdkcWQ3azhxQk9B?=
 =?utf-8?B?bmhvRHNpTUk2MEQ5QWhoeWFRVDc1Zzg4N0hKdnlxdFBMdzFBUldDcmt0UWhM?=
 =?utf-8?B?a1d1VHFGVkd4TU9JUGFCUnZqVHppWTJoWHQ0TmF4akRvc3pXZVJGM0hGZTEx?=
 =?utf-8?B?cUxYakZmdm54amhiOU5mNTYyMncrUHVnSnlvYUZRZDcxUkcwSUJpcVE2WHds?=
 =?utf-8?B?WkU5QnAwNnVUUlF1Tmtqc0F1UHk0ZFRnLzhCMTlNaUVuZ2M2ZHlyNER2M1k4?=
 =?utf-8?B?WHdzSlgvRUV6NEJwazJ1Y2x1S0FmdU0vamRyNng4MzBNbVREbEpWNkZaNndn?=
 =?utf-8?B?dC8ybXdtR05yMm95ZjJTYStSVUFsZVRIMzM2ZWd5S1Q3d0o1b1R3U28wSnN4?=
 =?utf-8?B?QmNESkRkL3RZSTl1TFZFV3NvczBkNW1KR1E0V2poK0J3SEdSWmQxaW5NMmFj?=
 =?utf-8?B?Q1A3bGlRTXlWRjBBQmM5Rk5XdHJHRUxYVFVzUEhhS3Rwdk9vY2NsTXdWN3Ey?=
 =?utf-8?B?cndBOE1ISDZ4SVFGbjNDV2FvdHQ3UjR3NG5zVjIxV3djTVBFTXBTbTltcEJh?=
 =?utf-8?B?SmJKdlFpUm53YVhVVzF2UjJsNFpMb2dFem5ZUVdEQ1FoOVZRV3Npb3NuMThh?=
 =?utf-8?B?RklMSVJncnlNK1FwN1lDR2VZNlNDV3ZLVVpPcERwZWxaeVQ3WTFmRVlZaldq?=
 =?utf-8?B?M1J3ZFZGL0VINi9UMFI1WXoxYnM1ai8xSjZNOHBSK0FmL2pQcEpUODhDRmlX?=
 =?utf-8?B?WnpqZWtXQ1pPeUtacFhOc1VJTG9HaWxxRVZzRjNtcUN5My9hOW15RllvVnRl?=
 =?utf-8?Q?Roh4IlAeVoaD1SfU=3D?=
X-Exchange-RoutingPolicyChecked: S2F4x6zUBhiKWRolG69gUV5N1iajspaWBym2jfvrdc+wteECSZXvbZ0aDs3kTkb/dVe471J6Xa8H/QeMCALZtsFbmVKSwkfrVEt+aQfBpu5TOIZtCs2S6OtzZkszDIgfU/d6ttV7v8tCN7CmSMFryRKsWgM7KCU4yapOc9Yltbmznzx71AR+qKLDl9fS/OID9bHGieQYaQgj9QEP5WOlqMX2wp6c6IRwhOXUZBkiR4mD38QWsDAXjJ/WqscjXH03XcfUxvqLYGCGi/1FOiwhZpIFjzqc1F4AKmFSe2mxuWWoOowC0PKD7xZjQJdMnFqFSlPzqnLk29A7jembT1LcbA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9eee757-e113-4525-2b3d-08dedcdb99e3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 10:28:07.3417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhtKHQNvYfLTCBA0sPoM47i31BNOaCfbf52DUccYwnqSeAuORZ05/daOQLkZa5vLOhMMlV8H2a3dHD00Nxbjaqnhyuz2j16hZqMEV5sBWWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6541
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEwMSBTYWx0ZWRfX+h4fq1TP8mwk
 ngjCfsbmsBvRIRi3hM4V6CabcfDfNFsQUlEJZ0JvNil75SNokR2i2ihtbwycbuVrBxxLCTTUC/p
 qOvQ4/soBR0TYrnb3ffAC7LWfbk38X7rGd3GVQaCb/aQHx5CV6joWdd7A7zw4G29rkVO1ndTCBJ
 KaktKcecleP8v3YZl1jvvbYGSTC+HYyTO/sRqua7MDWDytOT4tsk7cw7RScKVaZPRySrDWNq6+w
 ZWHeYWgzSlijTgzxhGEonW7fIN3M0Wg9hvv4AFjoGEOGXsnc6oRfdAwed9LEFL65yloWoW+l3Ud
 KdimwuDVE63bHHSkJ9ggzhyF+m8CrpF1PcbLVmPllbWFonVjSPnXM/8gHj9tQCC9C13YSOeV6Fi
 k4cszIP+yzImQxdMfS5HlUizb1plRA9qFsUise1Du6HgPlo1EpdCDk3cOQQMAWDME2MFG7Tu4VA
 Y+RruHogrGDBiXTUNqQ==
X-Proofpoint-ORIG-GUID: jiQq6ZsDIfiriayvR-YoZ8Xxp0AkieMP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEwMSBTYWx0ZWRfX4UyAmOOKbkPV
 t15nkK0T2PdmkPL5+dckX54fxOl0D4zTdxJIlBE3MgNODciPqr5GeuONl8ed7GgpUT67VtZHUFx
 umnk63jSEZQrkechpa78NpHdSrEqh2g=
X-Authority-Analysis: v=2.4 cv=H4DrBeYi c=1 sm=1 tr=0 ts=6a4e2639 cx=c_pps
 a=5D4/3oYeZhDPDdnr7H2lFQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=p0WdMEafAAAA:8 a=64Cc0HZtAAAA:8 a=dhnMXtyzOa4b2YWUsPkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jiQq6ZsDIfiriayvR-YoZ8Xxp0AkieMP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08/07/2026 11:16, Peter Maydell wrote:

> On Fri, 3 Jul 2026 at 10:09, Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   include/hw/i386/pc.h | 2 ++
>>   hw/i386/pc.c         | 8 ++++++++
>>   hw/i386/pc_sysfw.c   | 7 +------
>>   3 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 309de2eda1..16cb0ec01f 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -40,6 +40,8 @@ typedef struct PCMachineState {
>>
>>       Object *alias_pcspk;
>>       Object *alias_rtc_time;
>> +    Object *alias_pflash0;
>> +    Object *alias_pflash1;
>>
>>       /* Configuration options: */
>>       uint64_t max_ram_below_4g;
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 13c9c1bfc8..11eef176f4 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -1762,6 +1762,14 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
>>                                      offsetof(X86MachineState, acpi_dev),
>>                                      object_property_allow_set_link,
>>                                      OBJ_PROP_LINK_STRONG);
>> +    object_class_property_add_alias(oc, "pflash0",
>> +                                    offsetof(PCMachineState, alias_pflash0),
>> +                                    TYPE_PFLASH_CFI01,
>> +                                    "drive");
>> +    object_class_property_add_alias(oc, "pflash1",
>> +                                    offsetof(PCMachineState, alias_pflash1),
>> +                                    TYPE_PFLASH_CFI01,
>> +                                    "drive");
> 
> Does making these class properties fix
> https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_qemu-2Dproject_qemu_-2D_work-5Fitems_3254&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=aFRMA31BRpUGFc6oz2sysTVC7X4XLweNq3bWaZ-Qe2X0DjWynbeE9wH6KkOxdVV9&s=cLTzhO_XGkGotBc8X71KHVkE1UNW_8uTVosqAi0gBa8&e=
> (which is a report that "qemu-system-x86_64 -machine pc-q35,help"
> doesn't list these properties) ?

Yes, I can confirm that it does:


Before this series:
$ ./build/qemu-system-x86_64 -M q35,help | grep pflash
$

After this series:

$ ./build/qemu-system-x86_64 -M q35,help | grep pflash
   pflash0=<str>          - Node name or ID of a block device to use as 
a backend
   pflash1=<str>          - Node name or ID of a block device to use as 
a backend
$


ATB,

Mark.


