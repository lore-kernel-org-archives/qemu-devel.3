Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5068CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 11:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKDmG-0006DP-Sj; Tue, 05 May 2026 07:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wKDmA-0006Bs-2f
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:17:19 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wKDm6-0004UN-OU
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:17:17 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645864wL237558; Tue, 5 May 2026 04:17:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Go1iUS4H5GEXp8P7nwgcLJJbfWDrF7OXDyIegm6mk
 LA=; b=ph46z0IQfefJCAkPK1UQoxUZZPcoN557GnY9PknwyNpclEcSMrVXhYZsg
 6ydVYY7m81t8n5DUrqH8JwPy+z4dJpqXVV+ib4f9/TNcgKSoRcQK7bxn3xq8ybgU
 py+sRCGenf8Oe6rxKyiXzennxklsW1W5ds/ow2m054zOfQlhx0C905T8wLSfDZBt
 jgHcz5ZP00WyCRphfOqPd9rK+fJAW+/lmPefYZacU8PODc/+cKHiHTpv0La98MKG
 JUgOtz1wBX2lXUH9dGH2tzBKKxPlFgx0V7VZAWFkNYFlSh02Rfi96FbTEWw0rEju
 agG4PPLN4ykdeItc5IZFhWEVqditw==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022081.outbound.protection.outlook.com
 [40.107.200.81])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4dwgtup49k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 04:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OuOkSFdeD/r4BY/gZe61bMcdJY5Zp/ht2P8Ur+hqdUoDhiXi4hkh4Cy2wG9RLI47dhmkLY/G2XUfngcT2SjqrfRIBID8SFfxBUQIrCj5NB55OlJFM9AK4SQ0xHg6CvfuafblKBkz/RnpkzmnrYQJmwxqzLcBcK0nOj6nrtqbdvSH5hN/mU/IXhxLv0YTiGQsmj7lKVv25tzaCYmv1zz/REo1aIhx+6nR8gzwH5D7yKwfiqUHmlFtJ7MmaFb5/2FSkCc4TNS/FRlM4ufoYeSLmk68fGfyCpJv9K3J4KPMTOLwAAivzWyvbWFg8itqm+zzAwh7AL+nqrh5bFMMXwiJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Go1iUS4H5GEXp8P7nwgcLJJbfWDrF7OXDyIegm6mkLA=;
 b=BuPpPAu0YvAIzcG007CZ7eJYj4OWg2kiB5BPjjiIDocfT5dpYVir/TM4U7MctS9VN/Hsc91KF7AwdGBrxqvSWePaEekCiWtIdELLV7sMi7p6OgwJvsKx1+QI96WmfPLMOiL3qpjxXgwdOvGTCgGRfvilZAVrKGDE08kXm5kCoWr0iUGqc5ad/5V11YbbivexTluJZI4lHIB1VUG1tCQ3FOHmcz16QQnuBFmmobZCZkbA8pNUVcPsVpN9ZxY/DAAgp5Gzv1GtGG/eQLEmhdOnkmVAdA79uPjW9M89YNBbZF46NR2+BRhF6poU0H4oDZWbYQp3q0E1up1wmKaDORHckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go1iUS4H5GEXp8P7nwgcLJJbfWDrF7OXDyIegm6mkLA=;
 b=BCom1UfXxW8lzE87/9guV9qUayN1tmwYKfqymu24bH0HouwZRyVqcWHLuIWmySB44fCUjphwdSqz3HmnIUDE+8PuXifE5DJ8FjHc5uOzm+K22jA0NvPun8V9jkfx3yF3ijTnctK/6l2Oq25TImjdxP3C2/R+cfxhSWxlFkUBCMITKdO30MwlP4U0zO9hZieINR3afM2YwTG/XU4Zolohw1CI34QIPK7eTn0a+SqgsclPwFgSeQXZLsSvC4BZYt5N48WUVMmFdNqNOfcbWO7q0rZarGus2CuMs47+JzRu1B8FSnOPowZBAhY38RkRn7vYl00AKRaCRygS8XdQR1NLTQ==
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by MN2PR02MB6623.namprd02.prod.outlook.com (2603:10b6:208:1dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 11:17:07 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%7]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 11:17:07 +0000
Message-ID: <a704d9ac-2d86-4987-88b3-b3fe1c7fe7d2@nutanix.com>
Date: Tue, 5 May 2026 12:17:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/char/serial-isa.c: declare IRQ as shared in
 ACPI IRQ descriptor
To: Igor Mammedov <imammedo@redhat.com>
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
References: <20260311162605.2976339-1-mark.caveayland@nutanix.com>
 <20260311162605.2976339-4-mark.caveayland@nutanix.com>
 <20260430104534.0fa36276@imammedo>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260430104534.0fa36276@imammedo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR19CA0012.namprd19.prod.outlook.com
 (2603:10b6:930:15::16) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|MN2PR02MB6623:EE_
X-MS-Office365-Filtering-Correlation-Id: 112ac89c-6e96-4967-7ec5-08deaa97d804
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: OsM8L6iWW7IL/kholGLlJX0eZyAWPfXFTzKNWIYaWI+OozVLyFY5uhUH9pLL3UnQ0tonSk338m/o6ZPL2HGAvF67be3MdE/VrhzmW3jYymap0ldjXIsVmNe7MHMgciohrGK0qVF9K5H/C6yBNPjYmPq2Ju5c0eiyt+sj7OlfD8lgQCPPEUo3lijeI/fHZMmquxm8EC/5mnsQLRJeRBBgnbEmlZCsQWuqTBwaHklr8mPHVM1me9TwfYYGYnxySnyGZ2h/K7LyanoyzFFt4qO3/XqPAQ4e1YN90LgD+M4hbpN3f4aE59v6I1Re2nSOHCadChYG0ABYLE6ZvDNLZLkKpLL7o7Ov8U47EJAWhPqurDmodTB6iaQG/JBB5ByCM1RWgZQHuUfkgsCX9VRubsiZOHJ46rU9unt0zhIkJkrLViO8MTJsMIvwsYylsDXAX9Nkr8GX0yg7K95XN1FFNZx8r5G0F5lFLlWAVndYW0NzBwV91Tz1fnV0eLyFCDrdsFpSBBksEtstFLw1fFxQZGPwLqRDZ0KoUeMvOTwvkOiV7FtKWd0HNqnAST6LTxjwzSqPzGnT/Tq9xzcQFrLdCNHuL3h9crEr5kCzyun8P7F3Gxi55nRcTJQHlNcqlQnGOPaF9Q6+dcNOzY7b38g+PTfVIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlRKRzBBbWtJU0VCZHVqWUE5UUN6bU5qbzU5ZmFFaUhCUTh3OU90RFlEY215?=
 =?utf-8?B?eWtTRDFjTm9PWWJIVkVOQVZRQ1lUZC9mbExTTXM3RWdlemZ5ZmwxdnpYYkpn?=
 =?utf-8?B?RGw4dldpWndPczMwUG5IcjVHV3d1dCswbklkR0owbStvU2l5amtTMVZjYW9F?=
 =?utf-8?B?VXpaelllY0FmOWxGSmFya2I0VzRBTUhhUXBtRXpzd0NJVjY5UzdiekswV25J?=
 =?utf-8?B?T01MaWpJbEZPdVhONU54SS9JOEV6eHlTRzRoV09hblRMbXJuTDlVd0M1Mndz?=
 =?utf-8?B?aXRXWjJZQzNyYnpGUWlIemRkOXlyY3NHaTY3ZzVNYTlnL3BSR3l5djJlcjFr?=
 =?utf-8?B?bEFrYWFFWUlaT3IxNXF2aTRZZmdyN0FmZDRzY051dzFFT1R0QkQvNlVxT2lD?=
 =?utf-8?B?SXRxTThva080TEVlaG1ta0hMVFVLTDBnQlJPTGJGbkdVbGdrZ2dIdTBCYW1Q?=
 =?utf-8?B?YUNSbTZVUHFJV2t5RFVmVGJmNC9GVXNZeit2dThJb0ZMbFh4a3hGYjVNb25o?=
 =?utf-8?B?V1M3RG4xVkFzRktTMng4Mkp3QkpzeFk2RlpxR0JjUWpEVTNUSTM4NlJ2UWl1?=
 =?utf-8?B?TWtoaXZKRjVyQW54bWJSSE54MEdqQVdWRzdKUEJrSm1vTENqb21ENEsxd01K?=
 =?utf-8?B?NC9zZ0RwRXlBbnNCQ0N2Nko5T0N5YzBKTjRURkNMTDBXK2R3UGI3SDR1WmdU?=
 =?utf-8?B?L3praVFFMGV5eFdoUkpIYTZvYnNaVkVTd1pUN2g1YTlWdnNtK0p6U09BenBp?=
 =?utf-8?B?OWY5c2U0bU1sbXowcFltNjVwUlNNYjQweExHVGlLT2JDY2E3QzZZOXV0TzYz?=
 =?utf-8?B?YmFEeWxMc25DVmdNTE1MSUNVWlo0OXdwNUdYa0tnRmxRclRIY2xSMWxxUGJT?=
 =?utf-8?B?eUFYN21SNUhBaUt6UW5tcmw4NzVnRWZDR2dFZWc3ZHNjZ3lDVmgvK3habWEr?=
 =?utf-8?B?RW1Od1lzUFp4djJyZk1Ea21Mdk8rdmYyc0dHZkllVzZWVVUrcDM0U3BVa1d3?=
 =?utf-8?B?clExT05xb0xjcEJGSjVTNUdHRjdXVUNhWkxWWXY0UnVCZW9aZXNoUnRlQnMy?=
 =?utf-8?B?S2cyWU5PZ3hjMzNVRHhFeFVxM3JLTVdwTnhLZUxOZER3QkpUV0JQaFBOWHFD?=
 =?utf-8?B?Rm1kNjB3TEdDelNldEl0VFcrWFljblk2K216QU9KMnNTNi9acVM3OVd1cC9J?=
 =?utf-8?B?Z0Vzb1dVcHljS1c3b1g4Z2kybEVxMnRnNVREMUIreWt4V0FuY3JlWlFLcUVQ?=
 =?utf-8?B?VWV5dVNHTzUrUm4xK2x4U0F4OGRLME5CWVRzbU15OHZNblZsZlBDZEpUa3BY?=
 =?utf-8?B?SjNjRFp2bnRZcWZKck5hcmV5Uk1xYmExSlVTQ0hyVXFKOUgzNWQwQUp1UGVN?=
 =?utf-8?B?ZzNFRlJtVUdVQWlycGhZU01Lb2FHaWppYWV1USt2YkxiWEhuZ1E1M2VRbml3?=
 =?utf-8?B?d2thTWFiN0Y5M01SZ2NHTFh4a21UTkVKNXpWM1RYSGs5ajZYRWJicjU3TzY4?=
 =?utf-8?B?S0hVVTNzeFM4eU5mK0MwaFpsZVBXMFNpSnUxY1liOXJ3NzJVNkxQQ1FkOTA5?=
 =?utf-8?B?UnFlN2pPR0x0aSt3VzBadE5RRndpVTNwNm5vYnVLQXZwWWl3a1dqamZ3cUd0?=
 =?utf-8?B?ZU5YRy9FeENMeThuOUNDbk45QnJoWlVJeHFmZ1ExeWZsTDhhWnh1M2RVVlF2?=
 =?utf-8?B?M1BJV0N1dUhFY1kxbUs1SlZsWmlwSDQrL0VKb1k4aHVkdEVUME5ma1BiSTVJ?=
 =?utf-8?B?cnRVNXlHdEtSWlg4WG5xSGRRVU1lOFgxVU5BTFMxMWZBYlovdnBNRGRKRVN2?=
 =?utf-8?B?T0t0Y2NjMG9jWVJjUWhObVVwTk9PM1FselMxeXM3R01TN01KRy9iMlJsT1Ny?=
 =?utf-8?B?YU1vTm9iZFArWWFzSUwrSUxqK0RCUjNpaW9RRmRUTUdXNENGVTZaZ0E5NEZH?=
 =?utf-8?B?c2Y0MEJ1L3lRQmpsT3F1bnNEOUtJVTVXSTJvZ2xZVEkvZzd3L0lzeENST1pV?=
 =?utf-8?B?QUZ1OXB4UHlpZ0w2blFKRkJGWmtwdWFoWG4rLzJZSDBSUTBSaDhNaklGdHVW?=
 =?utf-8?B?Vm1Id3pmWUd0YURsMVk1QThDSWpGc3RXNmdJK2VpWXlyeUY5enRFSnowOWF2?=
 =?utf-8?B?WUpLdVArcmUyQnBreVRoYytieXFUMUdXSzFBMUtDTWpGWmZIdXZYSWtqK01X?=
 =?utf-8?B?bTdNeVRYV0FONFRCeks0dzN2ZDNxUWZBeGpMaHRWdHlaYzNmZXNBKytMb2VH?=
 =?utf-8?B?YjNpN3JDNmRLNTJOQzFVWkZSd0RYTTEyT201YUVMK3p4aHRrd080ZnM3WHBs?=
 =?utf-8?B?aHBQUzFOamczajBjaE42SVROejBzejdna1AwNExBTmJjbzBPc0VhT2s2Y0t1?=
 =?utf-8?Q?R5e9jIaIR6y3E4hE=3D?=
X-Exchange-RoutingPolicyChecked: g1ewzCb4HZLcd/zWO+72dETWAXk94HebOg1aPpTmfgWdYsoWG0E/yG27xch/WbxhKlcmGM83m4H2Z1Kfqss+uS0n+skbuRX7P5mI1uaKZNp/jmr/aIT6/MOanQ6Xs74CWH+uKSEllR+X7uHV5x3nXF6EaRLooBMrgpJhKMhBjhC/KY1vxz7Jh9JwItwpu//vDWyIcSibquSnHwVqjhfelYAhbtwvkDlrCew2I7ik3lAVpG92hHKm+UMK+FnvkhTt3xZV2WV3RdaGa/qz2wiYRukaCmwtvAdLQ2+9LRfcR3efteWcfesQz+lSXME+4yeMZrSO/IciCfYTGjoURTpOig==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112ac89c-6e96-4967-7ec5-08deaa97d804
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 11:17:07.5113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXQGqkzVWTQw7bbqiraH020VKIsodGWuLWPcDoX9u987YMp6+qkl2J4xc4Hubem7VGMEWUeLsut7n18zxrmI/sGCWf/g6zZHy0hJcl62JhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6623
X-Proofpoint-GUID: 4YP-DGluLzDcVjb3jL_T3b4wyKqz-9wU
X-Proofpoint-ORIG-GUID: 4YP-DGluLzDcVjb3jL_T3b4wyKqz-9wU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDEwNiBTYWx0ZWRfX+7zhQOs+u93f
 3m8ly3GeMb0OYp0alx9lyus7DYw5/PUHcLKrwGWdkBE49a0kNiRjePcHHyNUgaZ4RD3PIvRDfJW
 zy77lWiu+gDU44RQJJXPTxYwbmU8g6xROEFwe/JU3PcoYU3he2iO36r3rgJHdwNYWN9NWm31rNi
 M8mv1RvpH81+TDyGFhTmdP2EzcgZlVzflBW84rgAWu7ILmqOkWF3aNAx9pt/J6guZjvsj4RDscR
 UlTjEJsgYPPIfvd3JvCo6lPoiDOKluIWJEq8Hy8eAVpHQiy5Ad5hf0uKBLWqbtPRq9FMTuqPfxS
 DwFSOFTGDWx1Yw1mybtVgYLZWpzow9HyY0xJr82dNizaDmTnr8VpQMC7sKYmAHPEQhjDrFfIvVo
 wr11q+wPf8vJZ42Fan7dNVp00Iyt4bAhBZwsKUG3T3Osq00jPLKKUyRAineWh/zd1EbZlf5ieUC
 J/ewoQhJCYfoM+Czz8Q==
X-Authority-Analysis: v=2.4 cv=LJNWhpW9 c=1 sm=1 tr=0 ts=69f9d1b6 cx=c_pps
 a=W2lJqvwlxpc/IP2FXjrMFw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=lIoz6a4zAAAA:8 a=64Cc0HZtAAAA:8 a=3gb0CXM_iLA-Mdcmwl4A:9 a=QEXdDO2ut3YA:10
 a=-0tIMQodxoGpIMU6GLlY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

On 30/04/2026 09:45, Igor Mammedov wrote:

> On Wed, 11 Mar 2026 16:24:28 +0000
> Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> 
>>  From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
>> 5.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
>> Descriptor is used then the interrupt is considered to be high true, edge
>> sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
>> an IRQ then if more than 2 serial ports are added, Windows indicates a
>> conflict in Device Manager and these combinations cannot be used together.
>>
>> Change the 2-byte IRQ Descriptor in the _CRS resource to a 3-byte IRQ
>> Descriptor indicating that the ISA serial IRQ is low true, edge sensitive and
>> shareable. This enables all 4 legacy serial ports to be used in Windows without
>> conflict.
>>
>> Note that it was agreed during the list discussion that this change does not
>> require a compatibility property since it is not part of the default machine
>> configuration and was already broken.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   hw/char/serial-isa.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
>> index a4be0492c5..686336f34f 100644
>> --- a/hw/char/serial-isa.c
>> +++ b/hw/char/serial-isa.c
>> @@ -92,7 +92,8 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
>>   
>>       crs = aml_resource_template();
>>       aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00, 0x08));
>> -    aml_append(crs, aml_irq_no_flags(isa->isairq));
>> +    aml_append(crs, aml_irq(isa->isairq, AML_EDGE, AML_ACTIVE_LOW,
>> +                            AML_SHARED));
> 
> this combination looks wrong,
> 
> ACPI 5.0, 6.4.2.1 IRQ Descriptor
> Note: This descriptor is meant for describing interrupts that are connected to PIC-compatible
> interrupt controllers, which can only be programmed for Active-High-Edge-Triggered or Active-
> Low-Level-Triggered interrupts. Any other combination is invalid. The Extended Interrupt
> Descriptor can be used to describe other combinations.

Well spotted. I used active-low simply because that is how the ISA bus 
works electrically, however Active-High-Edge-Triggered looks like the 
intended use case for this. I'll give it a test and see if everything 
still works as intended.

I wonder if this is related to comments similar to those at 
https://davmac.org/osdev/pchwpe/i8259.html which suggests the 8259 works 
by going high upon the rising edge on the tail of the interrupt? 
Unfortunately I don't have any suitable real hardware to check the ACPI 
DSDT tables against.

>>       dev = aml_device("COM%d", isa->index + 1);
>>       aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));


ATB,

Mark.


