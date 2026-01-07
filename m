Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6B0CF6C15
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 12:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdSZQ-0001gN-Cg; Wed, 07 Jan 2026 07:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vdSZO-0001e3-HG
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:23:22 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vdSZI-0000O4-MB
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 07:23:19 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6079PAqj1416094; Wed, 7 Jan 2026 04:23:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+cS3YGu7MDp5i5yAjOAePbh3NnGb2PymRNipwiqoG
 k0=; b=WiSVWSCnRnyH8q7jGpsL8+nL55Qb5V0bVkc0nTJhtoPwzdVHzpfbhH1fZ
 Gvm4it5uIWeZh+yezTEOEpD7PK48abPVO/qbdQKMwcfdxATIpA3uGV12fGf++KJl
 CUsubctYwErHAFkOcC8TotWfJqS4RoQsLgbU3tFuwpCnHfL4/TPJoVUzbtrmXPGz
 6wDbRpssvPu8Wn54pQ7rncKv6tuLzvb2pfcetMMzrzCgnZwKYnlgczILres6b5u6
 gNbC/zO3uI9nbs0TYRxNS0oYH5uycCZUvlNXbhV3ITiVkM8yG0Q2TDny9tpdWFm/
 VdlBRJeDPhmTtDZsl+4UayAEiq5Dg==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022077.outbound.protection.outlook.com [52.101.43.77])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4bgu2jm36s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 04:23:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBJfK2K7kmcNhMXrYKmXdYwLT5QZuN49JD4/zIUcY8ZmkYDUJeU9kFt4aAOZqrg/JvgKwe3zyVIvO2Wo+VS9f0yg9Y/2lGXHm2wdUtOdWQoWZtiWgo1O+iom6Ewjp7rsKCme9/TFMxRUSvrHHqlnjle8AO8J/Xsy0uD40/No9LDblI/flIM0SN/NqPRos3L0YGrVbp1n7Bgock+23cIFuMQQ1NFbTwf4EYburFHQ7jaKDVQMjAB48W7eN8RWDAut1nHpgCklq+BiudOAlotLPsCxoB9crJ+xUJOGGP2YXDLwmvN20mZ8eo8E20PY3rQOxt3w/487C03wZBVjXWpMeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cS3YGu7MDp5i5yAjOAePbh3NnGb2PymRNipwiqoGk0=;
 b=zIpTCtCwMGAzzzq/iR8BnDoG7SxmcAHGZLRxOj7sCABkxi6Fy1DsE+i2qFpkL0JRv9aWZUjvAZDbx8DAJYOOFHS36SN5UGqOhCsZf+EGtlwMvj68bNfeZUijGtrU5ZjDVY7Y4tlwbfnG40/X1XgW4Axbe86pNQZ4s1+6V28M6lxrZ7hcYyGjbZO39tgVVFklXlIZOwNF1zMReq4nJlMMgPpTDsuZif6PhoDjnSKbE4+VeCXNuwImJBThNIwjCcngTQR2dpimGgeT5wRT5xR0yJHRHNUr/JG5/lAZ/ei7cNfzUgad2UeaevcC/CcIJq56zmn23EhO1cQi8y1Xg4ig8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cS3YGu7MDp5i5yAjOAePbh3NnGb2PymRNipwiqoGk0=;
 b=jgd5Bi0kOa+7TuOgpnC1mH/YUy0pA0Wi8BdSZ6nrs9gzuXAmEiL7r3slmgBTUbZEJXIYBe71nKTarkKTqwxLIdYEqk5yOnpbh1w1y2MICe5QCdcytxrZ/X7F04wqlEa8239eZ0bwbXb1lrZjd0m3UB67Z02/1f2r4s8/ezWuQexbZhaoNQ5lggA1Xyx3ke9949dJKeAKlTRI67SDbaX5Khc68togRft8mjf+nPmDEnbFbFePxO62VITW3NgNDpWThL1bYaGomC9VGzz06F3jKnJiJtU293PBgKmrmBBI+weD6Hpkfq2kG1u5BUuuqIuYV/bU3NCevDY7dWEQ7e694A==
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by DS7PR02MB9436.namprd02.prod.outlook.com (2603:10b6:8:ef::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 12:23:12 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 12:23:11 +0000
Message-ID: <866bd2d5-4ec0-42bf-904b-90eef42efd24@nutanix.com>
Date: Wed, 7 Jan 2026 12:23:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: do not leave non-arithmetic flags in
 CC_SRC after PUSHF
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260107045235.94348-1-pbonzini@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260107045235.94348-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::20) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|DS7PR02MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcbe381-0c49-4657-8ba4-08de4de785a7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUNNTlJyQW9UYjNFTGVxSyt3NVNuZStZdEdFZzR0Y0pHVVc0T0N6Si9NOXlM?=
 =?utf-8?B?dSt0MnpIN3FROGFNaWpvVkFERWhtMllUWFdVWnZWNWhvY1Vacll0b1pJNDhp?=
 =?utf-8?B?Z3l1R2JIdk1oRmdGWjZMeFpXY2dIbXZhbGpnOWhCUW1rMDgrbTJ0TmJiWU9Q?=
 =?utf-8?B?cTlLd21Tb2s5TjU2M3NCVnFGM2Q3bTlqVGU1RnBIQ0I3QXJ4VVRCbEJ6RDJU?=
 =?utf-8?B?WWZHeStxNjc1bFIxT2FMNEM5MGJzakd2ZzZoNkQyRnJhdk5kd0NlUmpDKzdt?=
 =?utf-8?B?ckNqN01kWlZIcEpQWElsYklCS0ZHUjNqdjlwd29pVS83NWxEMDFNYUxiZVNx?=
 =?utf-8?B?b0Z3V0sxaTNDTHErb1NiM25NekVIaWlZVGtYSE1maGJnRE9KOTNTRFhkekh2?=
 =?utf-8?B?SVBlMi9zTE9maFh1WXRaV3JDa0l0YTFUNzVaK0RENDVKa0FSbXQzeEl4cEdC?=
 =?utf-8?B?VnlIcEJwcDQ5WkFxaVk3SlpETktYdkk0aXd3RUpCRndoMVlERm1BbTc5Z1ZR?=
 =?utf-8?B?NktPRFRkci9XNXhTQXVQd2F6Y3MvL0MveWp0UmIxVi9lRUR0Um1pRWNnQi9n?=
 =?utf-8?B?TFlJYUxJOVBoU2xGVnVTUGZmWEVDNVByTWpEelV6a3ByOEFiVm9CTWhtK0Vh?=
 =?utf-8?B?UFhlYXBTKzVyZUZycmkzWHBEbnQwU0lDYWwxRW1XZXJYUWJ3RkNZQTFDOVJq?=
 =?utf-8?B?RXFHeXdOdFpZUGFMNnlGc3ZyVHJDSlkyQitoSFF0YWJ2MDg0b0ErU3lxSEw0?=
 =?utf-8?B?a2VzeXJHZ2h5dWcvcHZXbitIRmdWeHJVK1lNZGJvS3V2M3lSN3RycmFwdm1X?=
 =?utf-8?B?a3RmVFlmNnZoS0h5YTdJWjk1MzQrb1laRGhCQzRjZHh3anlUZmlvMTQvU1cy?=
 =?utf-8?B?Vkl3OUllVTNvaklrMUtrQnJtdjlHY1Q4T05sNktGbC8rQ2VmbjE3SlhEck1a?=
 =?utf-8?B?YURHdWpkSlBVY3pHUDMvczBGY3BxSXdLUjkwV3MxSzBjRjgrcmZBY2lDZENl?=
 =?utf-8?B?L3VzYTM0OTZGcXVPODdiZFgwLzNoLzg0S0tDejdMeHp2YVVoMEZDNzNyWmVR?=
 =?utf-8?B?aDgvN0xFVm55T3pycHUzbFZwMWpCWjR2SWlHdklaaXlSdGMrbHlGN0lWWG5v?=
 =?utf-8?B?VWN1c1Z3SkNIbXpqbW5kaW5kT2dYY3FTUDFvN1VtcjJlUUVZdHNNTnh5bG9o?=
 =?utf-8?B?Q2FxSW0rLzNSKzhhRTc5R3I1ZWdmR3pUSkp3a0JJdURCa09sZ2s2VzV2Qmgv?=
 =?utf-8?B?dDNJV1NSRGVBTzhqOE9kNER2cHI0cnIwNmhNWXY2Q09EeTk5ZWl5OEhGK1NI?=
 =?utf-8?B?KzRSTzc1WGxsSDJtUnc5UGh5aXUvMk1iUGE1eG9XSTM5dGxEK3dyMkU5MEln?=
 =?utf-8?B?S05JRWpuc1cwOS9lSEE5RUFvM3YxbmJKeWR6RnNadmdSRmFSUW1PS2s2Zi93?=
 =?utf-8?B?MDM1dExUM1Bva1QyUTBJZWFrdzZaSWZsczRESkNBY1BLYTBnWUE3SE44UC82?=
 =?utf-8?B?MGtUSTFiRTBod2FKaElvUlFFbXROMlUwckZZU2tydkIrdGdyUHpmaWw4RG52?=
 =?utf-8?B?YTJlUUgxYzhORlVyazZHaytmYjR6dW5zODFIYVlvV3JMQnlZUHp3d3ZWazBL?=
 =?utf-8?B?YVcrNFhQMEJ5bVFQQXZ3a2JaTFdoRDM3aDhITGNVMTR3dWNpUFJTNUkvVWlK?=
 =?utf-8?B?eFVkaVFsNTlMSE41eFJzT3ArTUI5ZFBRY2pJS1ZJUm1Ec25hSGRaMGJwZysw?=
 =?utf-8?B?Y3BVc2dHVThLQU9DUEtjblVNcndDSHVUUS8vbVJZWDltZUpOZnhqVzd3MkRK?=
 =?utf-8?B?UjY1YmdOSHZ3bVB4SU4wbCtUM3p0eTBQTERGL0Q0YUt0cHF3ZFY0aExla1ZI?=
 =?utf-8?B?Qzg1M0l6YStmb2lZaTU1OXRZTGhrVlZXaWh2MlJva3RHdmRmNUNDZHdnVnRG?=
 =?utf-8?Q?BN0Nv+M4EB6SsheeXrirghCcG89lcgQk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnlzYW93RmVoN1gxY0haMDBidHBQUGJGdzQ1YlFFN1pWTkMrbnRyZUorZXM3?=
 =?utf-8?B?R2RISW44dHc5alNESHF6TFJtVGtmdEI3YjB1SmpYV0RXMFNPTEQ0eHBqblFU?=
 =?utf-8?B?SFBxeFNVSUZuRUh6d2JYZitOWEpPK2VxOEUwT3hoOFpsVzNiclFWWTFMNkoz?=
 =?utf-8?B?T3BzWmNnNGRpUTl6SGx2V2U4ZDcyNy9hbTVDdm43eUloNjRsUm9wR1VxSG5S?=
 =?utf-8?B?U1BLMG5uRjVWdnk4NCsxSldOUDdkTHdMenFkdVByc1hleGdJZ05KREdaZFAx?=
 =?utf-8?B?UkpiU0JiWWR2TC9SVFlqc0hlR0ZNQ0hvNithQ1FlUnFHcGF3bmhaZkQwMEcz?=
 =?utf-8?B?OGRYclNBM09OdG5Ib1lZUUhoNzBoREh2OERGU0FoWFNUSjdFK3hWcDM3UCtM?=
 =?utf-8?B?OHBJUTdPTGJEa2FuQzZWRUdYeGlJOGt1RG5SRk5lRDJHS0RQWFlhcm9FRExl?=
 =?utf-8?B?RnFNKzlKODRyR0g2eWp3MDBuVXBHeHJLUkcza3htSVZtRzhSTmY4YUQvZjZs?=
 =?utf-8?B?dkNmWU9FdlZTTGdRQkw4MnJJK3BXYzRUb1dKRlJzc0ZUaThzNUJHYUZWTUFM?=
 =?utf-8?B?VEJyVU9sWmhmcFJLQ3oyOTVod1FTTHltdFdOTlhsdW9JbS9ZZERzWjJDd3BW?=
 =?utf-8?B?czdxS20wZm5nVjI5cHBsTUdyTjVSd1JvQ2lVMlNTVmhsNStkL0JLbEV2MXhr?=
 =?utf-8?B?MWh2dnNGNmxrQVhCdkF3NG9uMTVPaEh4Slh3bk9uQVRkMHVWajgvTll0NnFY?=
 =?utf-8?B?WlNSaTY4WDJPNk1qNEcreHlNTWJ5TDZadE9FNmxURnpXUWFIUk5wVGpkZUtC?=
 =?utf-8?B?T1ZxQUR2QkZnY3B5WWg1eENSWm1JZWg0OHdwSnFxYmxKOG56S2V0UzlwZi9Y?=
 =?utf-8?B?NFNNTVlJaVZ1QzNYekFFbXpLZThaRi9ITFV4RGE0MDhxcW1qbkxRU1NIMmRu?=
 =?utf-8?B?QXErMnBHTHdhdEZTZXR5R2ZDMjFMNlZ2YlpHT3ZwMVVocUtmUHpJMm52Z3FU?=
 =?utf-8?B?bTFPY2V6M2pISGo5ODF2TjdGZEdjNGxKTXhXNVVra3NGWUlEMW1VNTFXS2tn?=
 =?utf-8?B?N3loZkJIMnNPVlJqcktiaTlYTmowQ2ZrMW8zU05KNXJsaVhjcmFheEVKUUpH?=
 =?utf-8?B?OXJ3REVSMmt0NGpMNFJBVHpLY1VGNk9zVldmRG41Y3JtenZDWDBwNnI0RFlH?=
 =?utf-8?B?Mk94M08rZ0lKaUFMeEQwWEc4OU9uRURnd0NNb05tbVlld0h5S2F5QU11cnE0?=
 =?utf-8?B?UTJLaTlUa04zdkpmaTA5dTh6Vk5zL3MxUjlQZnFkZmxRTkNmM1Nqdnl5UFUz?=
 =?utf-8?B?V29Md2syclU5aThpNUt0WEdsdmQ3bHZiODNtWmZwZWh2N1BLdURhSnNldEY0?=
 =?utf-8?B?eTI4aVBJZnVCZUx2aEVuQnRBYmtXWWJyTmk2Lzc2S3VUdG1FY1J4VUVKRUE4?=
 =?utf-8?B?anVoK09Ha1gyWTRpYlFGWExuNUZGYzl3QW1aOXFJWlRwMGw0MGRYTU0xaXJG?=
 =?utf-8?B?bisyOU5JcVMrRUNMYmsrNVEvdU5YNU1hQ0UwZHlaVmJIeU13bS9zYlNPdlhP?=
 =?utf-8?B?Vk9Nc0FScU1rZCtHTGNsdzQzajQ1UGg3SlpLK1ErbjRsb1pja2xVZUdtcjhn?=
 =?utf-8?B?UHRSK093TExxR1dDbVBYc01CQ2pwcC9nUzhnczVpOVEzbFdZS1VCbXRObGhS?=
 =?utf-8?B?S2t4NzdZa2kzVXNHR1g4cTMzcFBla214dWlvWWZoK1FlZ2JTNjVVclExUmI4?=
 =?utf-8?B?TzdOWGRYTTJTMEhjVHhCdTM3QlVHclA0L3JmeFB4YTljbkppVFlCQWVDYUJ0?=
 =?utf-8?B?NUFDWGlRUHh4VG4xREFmSC9XVCt1dTNXRjQrT3h1bHd1dDI1b1ZzVklxb2V6?=
 =?utf-8?B?NUwrMWs4Z1BER08xTGd0MHV4dWs2N284ai9xTytRV0NLT3hYQ0JFT1BYa0My?=
 =?utf-8?B?d1F3VWwrYnJLdkdCa0RXaDZPUVJQTEY1cjZSVkNhbjJZSkJNd1c1WVBXaHZZ?=
 =?utf-8?B?SFpRSVVlU3VBSE9HNUJXV1d0MVp3dWEwS0p0TjVXTU9FcGU2OHNyQlpUYlJH?=
 =?utf-8?B?L3BDaVRXbHR0dnhweHZFZEIxUUxsK25jSFlUcU16NmZDaFRmT2cwaHl5OFVs?=
 =?utf-8?B?S1JHTjV1RUpISWNwVGFYM2RkbjdLYzVvdm1DZHNPUTNmcFQ2UzkxS0l1QnZ3?=
 =?utf-8?B?WU9QTHJ5VENlMTU4bmo2MjZnSUhzRWJHcHZHSzZtOTBPSGl1dTVGS3hmQzll?=
 =?utf-8?B?c3A2SDZYOUQ2NDJTVlJzcUFtd2tvcUF6NnAvbEdZbkdhWEV2cTBoNzlHbkox?=
 =?utf-8?B?N2VsUWV1Vk9PaThsdFp2am83U3lUU0dGeS80eXNoRVVRU3IyYjk1NVRzek8r?=
 =?utf-8?Q?2S6J54EXjVL+3Gt0iFVc7xN8GqaBrVQdO1yqzEL7wm0XM?=
X-MS-Exchange-AntiSpam-MessageData-1: fZH5CLa4hP01aoLFtvijdbCMUlITI05OyPI=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcbe381-0c49-4657-8ba4-08de4de785a7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 12:23:11.8621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKTZEZ9PyUKrAEJJiQ98A8J7ByVOk72BXhpGDuN+9sONsMNA6maq8H9yf3XzI393+JKeeAvaiillBW59PSPorWMTxGDOHjqZe2lV7CIEHGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9436
X-Proofpoint-GUID: CnXcZMD2L0sOmIH7jHUnVIzAthcvWUVQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA5NSBTYWx0ZWRfX8KzAoXFkYsMM
 ouDimrG7QT5mZaZLpheqkQW5T3uN4WY9K8kWO+ChRVsIgCx/TU7KtcDy86RhrYNA1nvhQf1fheK
 QQpJxqYrmq18MlhKh0KjUHn7sKCVS8Q3JpzQXcpzMebvarTR8vLvzWudo7aWyow+YAuRWjc5A7C
 tPIMFX0lQ7cBD/5eas3R1IvOuC5fDgIra0EdBl8zZD8nZbh6ALwUMRjZCctx0QPL2E8bJ+qzMLd
 1t12S5ufUr+5x75+Oze2ptjQ1CtXrlOmZe8llOAxJLhRkN0u/YjWO8Oe9B8jE021+vMesZgy/+v
 t2jaEsvLq9F0LpANVwKzjr2cJbP9rUnQiQZQ2NaE6m+/dzRmTC/CWn1l3YXfJhSIktPraeYenep
 SmQ6/DDgih09rzGIPql3huckxwJtxbP8JDGu8skZCiTx6GUBMW2mJqY+4TkYB0S1hmX3u53QDsL
 ssOQ4N2fkxMhhERvZtw==
X-Proofpoint-ORIG-GUID: CnXcZMD2L0sOmIH7jHUnVIzAthcvWUVQ
X-Authority-Analysis: v=2.4 cv=eu/SD4pX c=1 sm=1 tr=0 ts=695e5032 cx=c_pps
 a=7Kp79o39qosEjZWU4lqIzQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8
 a=1e7L0lRRrksz1_Wta9wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 07/01/2026 04:52, Paolo Bonzini wrote:

> The value that is pushed by PUSHF is the full EFLAGS, while CC_OP_EFLAGS
> only wants arithmetic flags in CC_SRC.  To avoid this, follow what other
> helpers to and set CC_SRC/CC_OP directly in helper_read_eflags.  This
> is basically free and fixes an issue booting Windows 3.11.
> 
> Reported-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Fixes: e661e2d7a37 ("target/i386/tcg: update cc_op after PUSHF", 2025-12-27)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/cc_helper.c | 4 +++-
>   target/i386/tcg/emit.c.inc  | 3 +--
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
> index 91e492196af..6ddd64fcb07 100644
> --- a/target/i386/tcg/cc_helper.c
> +++ b/target/i386/tcg/cc_helper.c
> @@ -414,7 +414,9 @@ target_ulong helper_read_eflags(CPUX86State *env)
>   {
>       uint32_t eflags;
>   
> -    eflags = cpu_cc_compute_all(env);
> +    CC_SRC = eflags = cpu_cc_compute_all(env);
> +    CC_OP = CC_OP_EFLAGS;
> +
>       eflags |= (env->df & DF_MASK);
>       eflags |= env->eflags & ~(VM_MASK | RF_MASK);
>       return eflags;
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index 0fde3d669d9..e55b65176fc 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -3253,8 +3253,7 @@ static void gen_PUSHF(DisasContext *s, X86DecodedInsn *decode)
>       gen_update_cc_op(s);
>       gen_helper_read_eflags(s->T0, tcg_env);
>       gen_push_v(s, s->T0);
> -    decode->cc_src = s->T0;
> -    decode->cc_op = CC_OP_EFLAGS;
> +    assume_cc_op(s, CC_OP_EFLAGS);
>   }
>   
>   static MemOp gen_shift_count(DisasContext *s, X86DecodedInsn *decode,

Thanks Paolo! I've given this a quick test and it fixes the issue here:

Tested-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


