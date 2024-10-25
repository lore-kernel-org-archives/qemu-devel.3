Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A02D0C61F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 15:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Lrh-0006FD-L5; Fri, 25 Oct 2024 11:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t4Lrf-0006En-PZ
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:04:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t4Lre-0005xc-38
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 11:04:35 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PEtZgo025047;
 Fri, 25 Oct 2024 15:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=Y2AoW50Hseq7+UhedgVSoO+XwiklLvzTrpxCBVA2mLE=; b=
 HZEh4OqJJi0pm5fyvvUSlX0x++XjZPMYCNylOPxweA1aY7id81FQrpPo5y+bse4P
 Ug1xnV+QIcycsD2BwL6J+wIYVryemxoqVCVhPN1CzcqmKJoECpvI80dckxuW7GCT
 OOzg78dHbpQ475gjJQ7VNRtpQac8Ez1NrSlc3R3ElTqBlb1ql/Cg+hLV0DosRcie
 9bv0CmttYKSauvYfd5EkItPicE+FMpRIXC12xrLWpZkBwsBgmPIGd1pXZtMzKg8t
 5txJGheNJRxCPINB5SJJIqm33EuSo9kEywYPdBBSYZLMjDEGTBhMtxviREPJk39t
 iBl0YyLvSObjAh7aor9mGg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v561n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 15:04:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49PE22vJ008933; Fri, 25 Oct 2024 15:04:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42g36aky6f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 15:04:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sl8KYL/lOo601q5ppaPsQb8YQtTnRFaDfoeF4zc2HwxAOFVdt/i540/BkPqoRbeLdQ5lfPyFjCr9VSAUm3RNhuxS6PvCSS9CFSGWPxQn1ww0lcWhkf2CcVtTSIme2IkS58AaS9EYHjXjxF/3dDhPrUuA/ex7302bS+pPXQ4BGV8IGINNnJ6hVYpBAlWcF/FFgKxqCArdd87WW8+Ymtltk9XujHmmvpRlbx2KBN34lUZK7Kx5BV5mv3Mr9P+YqRiHkKX4ojDkyysiHcV/nvKAmLPqVq01+VYARMVm6tIR0k1dAeKMKuenDM6AJCMii6YWQ/6L+SwW+uggVDpGjO63Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2AoW50Hseq7+UhedgVSoO+XwiklLvzTrpxCBVA2mLE=;
 b=g4rBe674KE9uUrC8fAgYEWwjCBIa4hLloE04ZIqAWnNDeBJyhfmMM1LRNUHafPOKc9asIGEsfnQ6G/d20vlbsepTac3g0z1k+6Cf/lLRoe755FKqvRe4OmYg0PK2qqO5kuqzPy5UF5ceA/FhRlepAtvdiZPqlU9PD5Og4AmD1D3NScfUZrXvg99kXPIHhkFHId1olLKVW6xR4sekivTgbaB/pG6Gxelf8D5L2uW8bLJWU7cqhECvPtSjSCYUgE5RlaZ6nvnx3N1vFWxOPm0+DtXDxzYPB4Mipyyak/TbC0AlMJmkgumjRUeTlMwhs6nFLVDcI4N9tbKexAZHb/jtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2AoW50Hseq7+UhedgVSoO+XwiklLvzTrpxCBVA2mLE=;
 b=BsuQVqQUMtalKjigry4WHoLO5sGCwwkyzaL90eWcDu3ot2SmaDeyVHirNvMkVWtK10hpbIsFuHRN5cm5PNJdsn4wAsoFux+GKOIjdaCh8w6pq9FHJo/i0tVsoVceF2xsb67kx5op66DqccPnrC+1HCiLuFivhMV4hCzR4I7vOVI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB6038.namprd10.prod.outlook.com (2603:10b6:8:8f::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.19; Fri, 25 Oct 2024 15:04:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 15:04:23 +0000
Message-ID: <f32be6e3-c44a-44f0-880f-e1394530ccf5@oracle.com>
Date: Fri, 25 Oct 2024 11:04:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <ZwV-NRICDNTajTRq@x1n> <877caitno5.fsf@suse.de>
 <ZwWMj4FYYpOSnPbe@x1n> <8b92a6ee-19f7-4483-9766-6b849cc04017@oracle.com>
 <ZwbUTXCxxl4heZYV@x1n> <95bfa06f-de5a-42cc-8078-c49fd617a73b@oracle.com>
 <ZwbpQiK7YWKpqHTk@x1n> <198913f5-32de-4771-98dc-02e73c4f0754@oracle.com>
 <ZwhFyOQanyqWqr6I@x1n> <6d626aed-a78f-4dbc-b1c7-111bc42c72dd@oracle.com>
 <ZxujV_9eTYCvOU_0@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZxujV_9eTYCvOU_0@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: b867e71e-aef0-44af-6841-08dcf5064fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEhhVW4vOHdXUTJSY0xRNEczcWJZcVRQUFl6SDVlMDBHWENrMmFTM1ZjM1Vs?=
 =?utf-8?B?QjV5bzlHaUZMOEFTTVlibnBFVW84dTFaajZmSVVGaDErcHpVeEZBSFFTTjU2?=
 =?utf-8?B?UTVENXUrcGlCWHdkRnlpcTNjOS8ybGdwczI5citSWGZaRjZuUko5ZkFIWTBo?=
 =?utf-8?B?emgwN0N0eWY3OFUxMnY0YUtLakRBci9oZGY0VVQvSFlCeGFzekpxbFB3aUsv?=
 =?utf-8?B?MDZkdnZPMzFUQ3pOQVFZd28yMTRkbHNIM0VVa2dRYUNDbDRKUHNvbzRTaHJ3?=
 =?utf-8?B?aHpKK0dMam8xT3VhSWd2ZjdsbnZOdGpzdEZlWDBab1RMRmNhWDM1Q2J0bG9m?=
 =?utf-8?B?U01tSDd2UnpvSHpMM0daSkNETkh3ekEyTThGcks1MUdsTnVqVDJITDJ6RFpk?=
 =?utf-8?B?b1J5MitrME03b09KOTJDNU55QjA2aG54VEZCRDNLNnI5Sk1xZERlR2w1dzBQ?=
 =?utf-8?B?cVI3STVDQTBaejY1Y3VlaHowdk9sOEN5N3QvNHkyb1AvaE83ODc5S1JRMlFZ?=
 =?utf-8?B?NGY2OTIzclZrR3FOSmxJU0R5RkM2S1BzMWJuREtudkZNc0NFTTZWVW1QUFZY?=
 =?utf-8?B?Vjc4cnRSMld6ZTlURUhJajJxMDFqOHpKQ0RGMGhkL0ZqTGtFck1kT2lnNlhR?=
 =?utf-8?B?WHh3aUlMbFJyWnhBY1hvYnA1RmlyS2QyRWUwNHFURXlXZTBJc21yREg3T0J0?=
 =?utf-8?B?SVAzZ0Q3Ulp1ckp0QVllYklZWUVZdStkajd4dERZMHRaVEtPdEdzc3p4WXhh?=
 =?utf-8?B?emVraTlQSVl4SWEvVmRKZ2N2TkJQd2l2WjBibXkwZjI5d1I2TW1kbGhraDNW?=
 =?utf-8?B?dWRGMk81MFFGLzhhcVM3Q2hPOTBXZnBYb21OR2tEaXlkMjZoQzdWZFAyekhF?=
 =?utf-8?B?bmNKckN6VWNuSEdBd2JIZVh1WVNzU2RoRjAyS3V1ampuNk43b09GMXd2aVVM?=
 =?utf-8?B?dmtVRUdLZUt6VHhZajltd1pUU1l6NEc1S3BaNUpaUmg3cjF3dWMrMU9LL1Uv?=
 =?utf-8?B?UWtpRlFUQ2VldGd2T2tRZGRiZEhGODgwSjVPODRCaVpkSlVnRURvdWFOZk0r?=
 =?utf-8?B?NU1YR2Q1QldjVjJTWmQ0ZWttdFhaSjdMVzhHV2VvTUZvQnBWMEoyMmFEY0ND?=
 =?utf-8?B?aUxrZTlXOG5sVEpFTGNaaGErUVdFTjZNT1FYbForZ2wrbE1PNW53KzNpTUNP?=
 =?utf-8?B?dk4yMWI1TVYyQ1hkNGVQMFA4ZmhSOCtESm1FejRUZ1Z0R1k1TXRWajhsNGxh?=
 =?utf-8?B?SVVXWkdoTjk1RmVsR3ZwQWI3TFR4RWUyTzAydEE5czU0OG5zd29JK3F0aC84?=
 =?utf-8?B?Q1dFVG1sWkpoWWFLNk15ZmxTMjU0emE0MDdxYkwvQ0ZzZkZCTGN0cG15d1pt?=
 =?utf-8?B?eVI0dkV6eThBdmdlck44VW5laWZLaitkWURBS0NneHhQQ09SL1ZpZDUweEFl?=
 =?utf-8?B?enA3RXJkQy9uTHpVZDdZc3lLK0wxa2tsWERBWE9HaDJlZC9oOEk5eWphTDFl?=
 =?utf-8?B?OGZMRkVoWFFFNTVIakJJWkFqM2w0NURJdkhwRWZLNUdIRlJPVDBueDhrUmNx?=
 =?utf-8?B?NXRMWERidjRVb3NXNHNhRVJXL2M1Z2VRTnpVU05WME1IZkpSNElwQkd2UzJG?=
 =?utf-8?B?VzRBV0N4dm9FUVlaN25kS0MzWGpBeUl0S2swY0ZzOC9qUmtFdE91WjhkSkRC?=
 =?utf-8?B?YjR3dVFJRHFxOVBCd3VOeDJmd3c4TWREamNNa1V6NjVjZ05wenFxeGVCdjYx?=
 =?utf-8?Q?FpfHjeM0MuflYhSfT8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nml0OEl3Y0RTTEJrVEVMSDVkT0h0elBhaThYZUdBSWlHNXlRMUYzN2twRXhq?=
 =?utf-8?B?QVhERFE1Z1V2a1ByZnkzY1Rsd0c0aktVMHd4aHBtNXdIaHRoUGFkSXVFbjA5?=
 =?utf-8?B?SmtjV1ZWOWZZeExxaVR1QzlLZFBHVVVoL2wwajR3N3hWL3ovbkFid1h2RHhJ?=
 =?utf-8?B?aE5FSTBGYlJEM1FWVzEvV3dicjdCTnBnL0RHWTA5elRzL0xJaFFFb2JESkIy?=
 =?utf-8?B?OUtTKzRsMEptQnVSMUMwVytPOUNTK2dzYTlod292L2dlUFFhZTYxdUtZeVFB?=
 =?utf-8?B?dFNEUUxwcEFUUERkS0tnWmFIcTdEejU1RTMyaHpqMlFHV1B0RXZoMGFoT01o?=
 =?utf-8?B?eHp4dm84UFJ4UU02MjRSOHNDaURzc1pDZ2cvT1hISDVrdEJoSUlMUlcrRVBQ?=
 =?utf-8?B?QVE5MmdETG96TStPcDF6MWx6bEpqL3VUd3h6K3pUWUpYNWdSRVZudkY0Q0F3?=
 =?utf-8?B?RENJMitwcmE0R09tVFNFQVd1Vzh4dklsS2lXVHJ0Szg4RE5OcDNQWUQyVlpt?=
 =?utf-8?B?OHhtMWN5aTRYWkUzVEZYeWE3MmE4OUZkVy9sdjdmdWtic1lJQVBRc1dGdGda?=
 =?utf-8?B?UHNCQWhUU2MwenpMdFVpaW1HWGg3dmlQK1l6bEppSFVWT3QwQXAwaTlGM2V0?=
 =?utf-8?B?TVhwWHcyekR2UW5BQm5EQ2dxNkhmUkQ2alNDNnVrVmNreWMzN29DZWpEdU9S?=
 =?utf-8?B?QTd0K0tYamtxM29oV1g5LzgrMmVBbm9WTmxkL255ZXpSdEttaDVsR0lmckdN?=
 =?utf-8?B?RDIrK09lT0doRlRtRnNnVHRWR2QyL3I0TnMwTmFCamlCb1E4STJxY2RCTHNw?=
 =?utf-8?B?SEl6bTIxOFcxK0hTUFgvc3VkQkJuQUhrK2ZSUHFsTDFURngwd00zNUNEblYy?=
 =?utf-8?B?SzBGb2ZDMlNnRnAzU3ljeGJmRldmZG11K0VmT3dWUUR5eFhiOU5yVnlyWmxI?=
 =?utf-8?B?dVJJUGdCQ3A4VTcyM0F2eFRvU2xkY2VpdG1ldkt5dnEwdTdwVUVraVFxc2gy?=
 =?utf-8?B?N3k2dThvUGtPSlVqL3JhTmVHVEphbncyTk9ONWgzdjRCQkM3bkdjQTRFOVI2?=
 =?utf-8?B?VjNsLzFiQnRRYWQ0ZjJiSUFYSXBsaElBZmVMWEVFUUIyaEJwdXV2cTJIYmR4?=
 =?utf-8?B?WERIUVk5S1lYaUVUL1pGRlBiTFNxM21DRi9Ic1piTmtNT1FEbm5iV2ErcTZX?=
 =?utf-8?B?VkRhcmpZU2pobi9EcEdJb3ZBSGYzUVBHSk9xNTk5cUYrS040VWZzaUcyVFR5?=
 =?utf-8?B?OG50QUorOFU4UTUxY3VXUEE2V0FOQjhQOGc1eVNlUnRTMmlpck1rczgyUTU4?=
 =?utf-8?B?YWZ5d2FKSitONGcvWTk2cm5Lb2tZWFhHMWZySG85c2VueWVkSnhOUTdXa2c4?=
 =?utf-8?B?K2ZSNm5IaG9WSE1rbEdpZEk5SnlzRmlWbXhYU3NPYitaOTBTWFl1VVJhSjFj?=
 =?utf-8?B?NUhvNzVqVWpCYWU2M0FNUVZmaDN6N1lLWFpBM2VxK1RKY05ySExyVXJudVA4?=
 =?utf-8?B?VEZoU21ZUmk5Nk9Nc01wa1JkNDMvd25vbE9oT0VBSllmSy94ZlU0STJrNE92?=
 =?utf-8?B?RitudzJibDJYeDdvcU1QTEZvUzJsdnhQczZGMzFNTWl3OWh0UlBGNkFJZllR?=
 =?utf-8?B?dG5qQ3lRYzBiRXpvcWk3U0VudThrbFJyMjVSaDZHZ2E4RzlhcFVxdjRpVTZD?=
 =?utf-8?B?R1FFRVZ1OGU3amNMMlFvbEw4KzB2T29MMVA5bmh0dHZpbmR2dTVGcnRNRFJJ?=
 =?utf-8?B?b09zeGY1N0tKQ0h3ZVNibVBBQjJYb20zcXl2SE9ESW93eWFGVDYwYlc2MWJJ?=
 =?utf-8?B?ejFsUlNBaGliVm1CZVk1Vm1JTVFLL280Q05KSHVkZW9vTjI5TnFNZ2JkTU00?=
 =?utf-8?B?bkxpQ3kzWnFVc1gwUEtDR3dzdGx6RDlMUzlydnJnVDJiOUh6c0oxcHpsSFo3?=
 =?utf-8?B?Tm1Ba3I1ZVFkejJ0Y242bGMwTkM5WFh5emlYd2VNNmJjbTlvK0d1YlU1NmEv?=
 =?utf-8?B?ckp5YUxScDU2dGFPb0dVTHRhdXR1KzlaeVIxYW4zczkzZE8vVFBSb2dPTDQx?=
 =?utf-8?B?elhIRTNCWkVKOERCQUpBbjVpMTl1TXorVFRTVTRPQlNOQVF6SzRiVXdqRENN?=
 =?utf-8?B?N2lJUzVTNlhGRExBckx5VnI0UFE4ZWtWOG9SS0Q2aGhJUXdiMEZ2cXdMRHpS?=
 =?utf-8?B?cUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8QvaRcUFcT3eUbUMgLf4RvoEMdWhz4hpkyo7Y9vj2HbYxq8FqZKkScytOMEFx4XIgd0kmXTF3zZLqWb0cf9qysmSbGJiGYbSaaeD5ZD5b052Ss6bKfIx+l4MjiYSd5g9YZgZ8R4UJIqHol05RtE9lYcaWfJpJ4TsSTtMNMvB6eTBThDYuD5lctH1eZEbSFARTlvhzHHmPGZh9LkEcTMhqwPyGgB7UbvJVEbtgrgRg7jUetixjcKA74QJt40hsFvC05lUZ//FxR+Jaa0YLDNNwp8pkPhOrWaw40RbrOyJmjuHR/LedUSCwETVjrkx2DDKOeg3Xoie/PK3WEmGkdUCVTVz1geVFHJXsh6Q/OW7DGXfMDhl7vKcjPmmPp1O90j8KtcJ3sv+/bIPcLhbkkerRdxi87dmRrBjyo8NDmp34S6QAXEWd7ZrngYa9Atc7VjR5R7RZ1Gp1jPFeBWxH4+3CG6PzDbPX+8TxcUdUkCQ6oM10WBufOzgl4Cx28A1zjlsdVdBOCCqgJ/5dkV5HLsJ5Q1HU+9HMqecCaaPi3PFxc6sUrqJxrVK67QyCaT95p4eL7yedTkHsJraZRTdtxKNthJ9H/K7ybL87/33FtywWwA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b867e71e-aef0-44af-6841-08dcf5064fb3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 15:04:23.7340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nX1rF6XhgIDfR7SybbDiQxHDh1ctQn7ecEYIGSaipiWNiSPoxQwhgB7dCA5Uaw8+DxLJEi2nEgbaK4IKPhJ65ODDBepRdc4B5SXnUsH04+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6038
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250117
X-Proofpoint-GUID: IS7hE0ZQWuEJlLo02HAMPrDgJuiegf87
X-Proofpoint-ORIG-GUID: IS7hE0ZQWuEJlLo02HAMPrDgJuiegf87
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/25/2024 9:55 AM, Peter Xu wrote:
> On Thu, Oct 24, 2024 at 05:12:05PM -0400, Steven Sistare wrote:
>> On 10/10/2024 5:23 PM, Peter Xu wrote:
>>> On Thu, Oct 10, 2024 at 04:06:13PM -0400, Steven Sistare wrote:
>>>> vhost requires us to stop the vm early:
>>>>     qmp_migrate
>>>>       stop vm
>>>>       migration_call_notifiers MIG_EVENT_PRECOPY_CPR_SETUP
>>>>         vhost_cpr_notifier
>>>>           vhost_reset_device - must be after stop vm
>>>>                              - and before new qemu inits devices
>>>>         cpr_state_save
>>>>           unblocks new qemu which inits devices and calls vhost_set_owner
>>>>
>>>> Thus config commands must be sent to the target during the guest pause interval :(
>>>
>>> I can understand it needs VM stopped, but it can still happen after
>>> cpr_save(), am I right (IOW, fd wont change in the notifier)?  I meant
>>> below sequence:
>>>
>>>     - src: cpr_save(), when running, NONE->SETUP_CPR, all fds synced
>>>
>>>     - [whatever happens..]
>>>
>>>     - src: finally decide to switchover, vm stop
>>>
>>>     - vhost notifier invoked. PS: it doesn't require to be named SETUP_CPR
>>>       notifiers here, but something else..
>>
>> The problem is that the first step, cpr_save, causes the dest to finish cpr_load_state
>> and proceed to initialize devices in qemu_create_late_backends -> net_init_clients.
>> This calls ioctl VHOST_SET_OWNER which fails because the device is still owned by src qemu.
>>
>> src qemu releases ownership via VHOST_RESET_OWNER in the vhost notifier.
> 
> I think the block drives have similar issue before on ownership when disk
> is shared on both sides, and that ownership was only passed over to dest
> until switchover, rather than dest qemu init.  In the CPR routines it'll be
> also during switchover rather than cpr_save().
> 
> Maybe it's just harder for vhost, as I assume vhost was never designed to
> work with using in shared mode.  Otherwise logically the net_init_clients()
> could do the rest initialization, but provide a facility to SET_OWNER at a
> later point. I'm not sure if it's possible.

net_init_clients cannot do any initialization that issues vhost ioctls,
because the dest process does not yet own the vhost device.

- Steve

> For block it could be easier, IIRC it was mostly about the file lock and
> who owns it (e.g. on a NFS share, to make sure no concurrent writters to
> corrupt the file).
> 
>>
>> Thus the guest must be paused while config commands are sent to the target.
>> We could avoid that with any of:
>>    * do not issue config commands
>>    * precreate phase
>>    * cpr-exec mode
>>    * only pause if vhost is present.  (eg no pause for vfio).
> 
> OK.  I hope precreate will work out if that can solve this too.
> 
> Thanks,
> 


