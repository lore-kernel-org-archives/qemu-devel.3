Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E826E7DEE3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmujj-0006g2-6f; Mon, 02 Feb 2026 09:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=6493f4f895=qi.chen@windriver.com>)
 id 1vmmGV-0004sl-Oq
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:14:23 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=6493f4f895=qi.chen@windriver.com>)
 id 1vmmGT-00078x-EB
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 00:14:23 -0500
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6123wPmK141598
 for <qemu-devel@nongnu.org>; Mon, 2 Feb 2026 05:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=cc:content-type:date:from:message-id:mime-version:subject:to;
 s=PPS06212021; bh=Sq+prl8Q5vit3YDJ1oAkbqMJO/e2h5sBm4JVNg7Nsco=; b=
 RUd8ORRvS3vspTGARoA9PDJ4Bwjv0jlSqDimfVKbVDgJp+StxzEG/8UQz+nYVG/+
 EIbifvJKHH4rTvFKdlJCQpdlin21l1ibUFGgcdvFwMnYGfJWQO5UwIYwi1Gw9X5U
 +ygxhRUzUgnaEcT340I+TGkQAkvGHi9pYydHEY2b2GvzCNrsVPMANgzSRElXc9WO
 R24yFrd2gPOJUtC3qJyTOxOnt2OwfFzLPbAU+9INbA6kFcDLDpFhjubidXsdQYGu
 /jimyMiKEUCLCl5xylOI1G0HwHH5OQFgjijdrg0cPq5n+Yknrdi5iN6TdRrhrwHZ
 Mt6idPnuQ92WjswOPcjFDw==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c18q3smcg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 05:14:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhsJUTRpUDFKreDdzRFZWo85F9dTAsIBsQw5TnyRUBwMqjZAmJR0xBZk0L68eHw7zVAmw+aIkQayRX/F0xu3PKpR+l5J4C0ymsMzP3V4yDmONk+s+1B1pWXXFDQ8oZk4RviisQr0/AGiB0jImG/lSmLdcWvoGl1siYLNos9TgXWfYxSa2J5naX+dFJAQ9jJAbD3M6EbnJa4a3cpDmyCWooHqn8quR0i3xWZCZhd65oKaSJDk+A8BzPEWZqzZnbyvFbZ0cNkdC0gb+iEXIMMjqlOe1rbVd7fXXL0Lh6NFsILckS7JWHzgOGmlCvoB7s2XyNM+316zHjZtVstlmloyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sq+prl8Q5vit3YDJ1oAkbqMJO/e2h5sBm4JVNg7Nsco=;
 b=yxLBKj0/4EJ5HIGOvxEOEIAgkr/NwnN/fV6aodhffECQxb9A1XibgAaQyxeerKMgmEoXfT6IK9y9zybYthcd3rQkxPSZb/aS+UDBXTbZVeulgfR8dutrOXnFXSB83ZpYgO/RQBFaWe82GgK6KjSK1bPC4L9WdJcQPgjtQhhSXaM14JPt59eY/PS9Uggvl15GDIrmrCx9iasmiMDRDQGc7ozM9/3PHGTmpZMWJFJT8ZngwZ0vurXdy3ci4SSDNjWd0go6JSh5VGIl60fp/XnhCVKuqvES198qKQhkzpp3lcM6NJmqWoBRrTFybvdO+/ycNbF2xex4p5RisizumKCF0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DS0PR11MB7878.namprd11.prod.outlook.com (2603:10b6:8:f6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 05:14:15 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 05:14:14 +0000
Content-Type: multipart/alternative;
 boundary="------------cZKTSOdP1iBl6Nb0xD0qpgwk"
Message-ID: <7b2aa99d-8d3b-4d75-9328-e2d6a7ac0cb4@windriver.com>
Date: Mon, 2 Feb 2026 13:14:10 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org, ChenQi <Qi.Chen@windriver.com>
Cc: ChenQi <Qi.Chen@windriver.com>
From: ChenQi <Qi.Chen@windriver.com>
Subject: qemu 10.2.0 user mode has regression on ppc64le
X-ClientProxiedBy: TYCP286CA0134.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::16) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DS0PR11MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b90529-36d3-4df3-611a-08de6219e868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y2FWTTc3eUZSMmtZOGNCYUpqbGxiRmVqN3oySjhqMXpTVmUxY0RXajR4aE9t?=
 =?utf-8?B?K2dsMnpYUkJHOGU0SGhtUHF0Q2hIRTJFaW53UXhkQmVvaHR1YVIrdFhnZXhv?=
 =?utf-8?B?TmtxY3FqbGswZkdzTWxFNkp4bTR5NG9hTmczNnVJekdCQXgzUkwrMmZ1T0Zq?=
 =?utf-8?B?ckZEVWFsdE4zUWw0VFplZWo0Y2kvMmFadG5vY0E4eGdKT1RCcmNZUHBXRDc4?=
 =?utf-8?B?WU1pdUxWQWorY293VURNeGpDTDZQRUxLL0hvRnJ6dWsvRkZqSnNuU0ZMb0tj?=
 =?utf-8?B?OWNpVEQyZkZGMVNVVTNDUTBtandIRkJ1d0MrN2MrRWxQWVZOZUN3dU1kUm01?=
 =?utf-8?B?MUd2OW1JUWlKTk4reTg2UThwRWY3SkpqdUtIOXVwUXZUV3BSUk9kNHIrK0dy?=
 =?utf-8?B?blFHQnN6T1Q4ZENMdXd2cnBiQ3l2Qi9lZjcwKzFtRlhpNmlVbTJxcE02ckRU?=
 =?utf-8?B?K3c2U3JSMFVNNjl3MWJBSk94ejFGN0RpbXVFSmsrVFV0VHVJZFlHMXdpTW1O?=
 =?utf-8?B?UGIzMzNhWjZxSUNXTnZCV2l2dll6dU4vQnpDbmZRemd0U3I5WUJRYzJVdFhs?=
 =?utf-8?B?L0tITGFtMGp0WTYvUytRUUpIalBVUW1EQVFIcDBLSGlOVEF0cTN2MzcwdC9k?=
 =?utf-8?B?SGEyS3lBSWxiNzNCRWRDQTJITTZwYnJPUjJjUTBYT2l1eW1uTFQyZ21sb1hv?=
 =?utf-8?B?K3Q3bVNKTmt3SzRVcXVmRnJZTi91MW5vdnlDRGxTMjQwMUt5eWJ2MTFwajFG?=
 =?utf-8?B?aDZmRmExNnRJbWh3aER6eHFwemZxajJNeHBTU1daT1JSYmdQZUNTNkw0cmFM?=
 =?utf-8?B?OWx1NTFwNDVnbDBmMUIvR0EvSThnOHpTNWxQRldka3d0WkR0RldlaVkzSktO?=
 =?utf-8?B?U0ZFWkhhYStxSGtQcjZRckFXRlUzR3pvdHNpd3N0d2t3VVJBN1BFWndwL2Zp?=
 =?utf-8?B?MnUvaGRKNDUzbzBQdXFvVWoxbk0xbWZRby9yU0VrZCs3KzV2b1VkODdkVUMv?=
 =?utf-8?B?M0hmc21uRC9KVnFLaU81YmNWSUxvUFhuWlJaY1NLSHhPNk9jSDJheWRnL2Vl?=
 =?utf-8?B?R1hpbzdOY2lSVVRkT0hyMHhNOFNCcTFRb2pSQ3NZMkZWZUljUENJUEVicm5P?=
 =?utf-8?B?NlUrZjZLZU96ZGNSWHg5MzMyWjVHenlveExyOFNMVGI0OEgzUUVTbithVm5L?=
 =?utf-8?B?S2ZTTlE2SUV3WndkM0lsOGkzNWtQdlRKbEwwZ1htMTlEdWREcDBoZUlCZi94?=
 =?utf-8?B?VDZCZEJhRGd1cVhWZHFob1RpLzlQS01UOHNPVFdISGxKS3VDeFJXNjF6b1dD?=
 =?utf-8?B?N3ZlNXJ4YTRBeTRENTArMjlZcTNaaW1rcFpCTUlHUFlhR1BkQ0ZicVNXSDlY?=
 =?utf-8?B?N0REbWo1NmEzQWxrZjc0ZTFWZW5WdytDMmRLaFBIV0t4NUNiQnZsTU12cGVn?=
 =?utf-8?B?OW9wZGFTR2RKb0htaUk0K216TzN1Qk9RakJqbWo4SENoTXhjZkgwdVo3ajBT?=
 =?utf-8?B?WENzdWRWeUZjcnlHcXBCblNzZGRneVVhT2Z4R09qVjA1cGZUMXc4ZUNxSHUr?=
 =?utf-8?B?QkRIWjBucEg5RVBsY2kwNlZ1bVFKc1FSM05NN2pNRjBENXVxQzU5bjZkMUd6?=
 =?utf-8?B?RXBLMzRFTVZwRXI4Ym1Ma1NzRzFueDNlWUEzQ24rNERVMmFMcGVUV2ZiM0lE?=
 =?utf-8?B?T0N3R3cwOEt6WGx6VW5oQ1MzTnZjZVNpeUR0MUpaRUk2dEl4QjlwbEZtbnNB?=
 =?utf-8?B?Zk5Jc1llUW51SEdUVi9NdFBrbWtLMG9LSXZoNXZDVkIrZnQ4THAwT2lxWFRX?=
 =?utf-8?B?VkZGQnQ3NnBZdExVTklyRnI0Unl6ZEo5RDNHbElBSmJOaU5OWVB0QjlwWXBH?=
 =?utf-8?B?MkwzUHZCQksrZ3RXL0E4V2VBSkVmZW5uV003ekRmWFVPL1Ayb3paZWFVRTdG?=
 =?utf-8?B?eTUrdWNzZjIvSlJwTTY3dE9wUStSbFZFT1RsbDNubUxHbWVTNFNmZ2R2WTJB?=
 =?utf-8?B?REpYZzMzOE51TEFwdjZGaGc1bHRtRk5IdjBTUVFEaTN1WEQ3dWtEZlR5Q3ho?=
 =?utf-8?B?c3dFaW0xNVFTYmdSSHZRazNyT3IyVkdNRmJBMUZyVkxrMUtDV3JIRml1Wi9h?=
 =?utf-8?Q?FOp4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR11MB5602.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmNkZzVwYkQwSEdDSjc5UHdpYmVCMllpQVY1NHF1cnlaMllkd09oNmg0SlUx?=
 =?utf-8?B?VTVaTW5mYlh4bGNmVGszeWd0ck1jZlpxY3FPNldCWUxhN3BpSUgveEo2bjN5?=
 =?utf-8?B?NnFxYjhZUmptYVdtTlRnWkozWk15VzhOVzlQL1ZOL1VKTk93MzBVL3M0MHJW?=
 =?utf-8?B?WmZvWGhUMkRGSlQySERYakhCWGZQdkE4RDk4TU5DemlKS3hLejhCQ2g4RGpL?=
 =?utf-8?B?Tjlsd29Mb3RWNkMxUGxVdldBV0c4SmR4OGJ4UlJDUjlJUlVDZjJaMXhrTUhB?=
 =?utf-8?B?Q0ZNYW5yLzhaWWw3OURVLzVlV3B0YnJlYXBlOGxwR3dyOEFqeWZUUjl2VTdT?=
 =?utf-8?B?a2h0UHVQS2NwZlN1UnNubThEcXF4MVU2MEVjcHRURXZPV3VOdzlJWGI5RTlH?=
 =?utf-8?B?Ym5vNkJMQU5IbytCWmo2dlN3MytPVEZUZVNqZjdYOVJqQ251OXNvNU9SZ0p0?=
 =?utf-8?B?bVZLMXh1Vk9jZTYvUk5MS2JlQWxuRTc5VzZEL3FzUkNCcXI2S1hmRHdWWW85?=
 =?utf-8?B?c3FBcmRIVE5rOW8yZjgzejluT3hVWW1USzRUT1BrT1NPQ0xoYmRoVmc2VEQx?=
 =?utf-8?B?TmVzcU10MklPQkh6eFNDNW5lWEExUHJmeEdreVhxbURMdFFHZzI2WGg3dFZR?=
 =?utf-8?B?aVRHSk54dy8yRW9BdDNFOUFiV1BRSVIrV3k1UUZxckszY2k2MGdkZlM2VU9B?=
 =?utf-8?B?b1l3Yk9HYWlLWlF1TE5NUzdwL0gwdGRqcThDM2ZKN1U5TXdKeVp2K0s1ODU1?=
 =?utf-8?B?eHRIOVQwblNDd3d0aDNFSnl4c2ZCdEx0VDI1c3R3NkUyRzY4NjVzeTFvRnZN?=
 =?utf-8?B?ZUlvVHdFVzRLV0hGbXpVaE5jTFltQXpEWlYyTGs0VlJpa0NuNXZJZGlTT21Z?=
 =?utf-8?B?WkowVWdwV3p3TWxSTGxqU3d4RituRnhBTDkvcHp4OXdCT0M1enlrZEVGWWRZ?=
 =?utf-8?B?SWZ3QTczMUJJRGlpb1d2NEtibXJpdFpyWm16NGdrTy9vNUhIYWVPYWJGamVB?=
 =?utf-8?B?aXNTdDhoSVhNemhKVzB2eFgwcUxFbHZrYmw4NVpFWXo5b0p2clcvREFMczM2?=
 =?utf-8?B?RklHdkc2eURYWmE0LzVRMmxWdmo3aXBJNUt0eS9WeWRLZ0YzbEtiU1BlcFBh?=
 =?utf-8?B?VUNtRlFoUkh4TmtHbUZUakg1NUR4aFFiUXpxTlZMMms4aEhydFIya2VFNGpy?=
 =?utf-8?B?TlVyTE9adXArUFZtb0R6UDRWNWt3MzZOVHdXNmJsR2VaWFIzSW5WdmV2R0Fy?=
 =?utf-8?B?dE9WMHUxYXhZQzVsemJCaHJheGpIYjNtUFFKQWYyUTMvaWpEOW8xTlo0SWJr?=
 =?utf-8?B?OVhHRGZLSTlVNWJ3eHlrWS9mR3VLRnN4czVsMndkT2Z5VXdrb3NCek5xWWl2?=
 =?utf-8?B?VFNjaUs0dnVRdzlZS1hTNnF3UHU2andKTDUzWnJ3WmdtbG9BVVlScVNhVThH?=
 =?utf-8?B?QS9kaTMxQ0c5RktJTTVkaFhqNkhGYVFNSWErc3pLamt1enBYRDhjZlI4b25N?=
 =?utf-8?B?T3J2QnREVzB4bDlPNHBoM3JOckVBcUFqOVU3ZllUamo2Z2dKQmpZY1dMS3lD?=
 =?utf-8?B?S1ZrV0pobHdDb0xZRCs4cGkwdTZISVZNbmJMbEdvS0tFUXlELzJzV0RWYUtN?=
 =?utf-8?B?OGlKb0p6dHpudDhHRTZlQnhlNitzOEIzanFzc1R2cFRxUGNid2srZVpjakdH?=
 =?utf-8?B?SU0xZStqUEdFL0NRWnloeExBdFNtNVdhWnB3MmgycDVkMEo1YVRKTTBQWWpD?=
 =?utf-8?B?ZFk2K0dEZkJINUN4WWdYZnFmN3BWZ21mNWpBTlNjT3FIOEowdVZGOFV5bXFQ?=
 =?utf-8?B?YzVDS01CaTVsbys0TUZWRXJYVVVLSnJyaE5DbFBJV2tGdCtSOFJhMjFGTUhs?=
 =?utf-8?B?QXllVVFoTjJCRnJBeDViUmpDcnFOOEdQYm9McXZOajMwQWc3NWMyMkszbDRS?=
 =?utf-8?B?QzFQRzliei9vZ3pvWXo1WGxPKzY4N0psMEY2M3V5ZnVDQjFxZytKQ00zcmNa?=
 =?utf-8?B?WTc4b2FJK3l2V3UrUll1YnpIdUY0R2tZV2JRa25oT1pJc25Vd1hYVTQxYkkx?=
 =?utf-8?B?QmIwM1V0b3VQYjZ4TDNGRGkrbzNUb3F1aU10cHhBSitKclg3MllWRFdIWDhp?=
 =?utf-8?B?bzVrSVVBbWRvQ0d3dDUvN1N2VjZ6STdtOUd5VUJ6elpreHU1NFI5S0NiOUZy?=
 =?utf-8?B?QXlJeEllRmhOSkxLaDhubE1GUFArZnNxTnpWT2FDbEwvUVFSOUlIM1phZjNw?=
 =?utf-8?B?dDRRMjZCNVlYNVMwNjM4YTRSeE5wOG4zdHdRY20xYUpBT2xHZFB0aVNxa2cz?=
 =?utf-8?B?NFBvQjJ3TU10Sm5ROXNBMWo2clBEbUt6eEdvc2tMQWFnM1NPdlg3QT09?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b90529-36d3-4df3-611a-08de6219e868
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 05:14:14.7404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eBzn9TMGW/qlzzOx2HoHwOW3mAx1uneT5sHPGwoDRbTWNCC8MY09zrSH6n9rXYOa5yQFxrJHan0rA0PlOdgBWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7878
X-Proofpoint-GUID: oJSa4d8Nn9A2SVKbScrKLzARERzH0TYX
X-Authority-Analysis: v=2.4 cv=Au7jHe9P c=1 sm=1 tr=0 ts=698032a9 cx=c_pps
 a=5I5pDAtSp800fId2YpAiPg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=2XKOcvmy7GU5hsJYr2QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=VHa3aG9DZJzOR-ytK0UA:9 a=njagI3Ucau7jja9t:21 a=_W_S_7VecoQA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA0MyBTYWx0ZWRfX6sxuadZzu/V5
 Vg1HswDpqryHjwOLanF6cMPAWeu3r38ze5VmkO390Id2ZeUV5mYnfjog3lZ58sVPdrzXqtmARZo
 95ta97G49UAHIJn4TDYWbVVSCCq+VXRsyKZrLBG1Yvl4GaupRSPFyxFRzrBfJEhaPlctN8hZez5
 mtYk0WkakGikczY5RPa34CikkgYSIsj3YUdzzbgHtQFCjHk7d8SXsET1brmd4ezdd7qky+zgj56
 RJTnp3n8iruoQyTRJepRGtgr4KSXHtclf7dwy2KomwXtu7/NUdTRNoJP5PWhMS0kIrnOjstY6KI
 JlbpkpUJ1qa2Sd+zKlm74tYeYgGyBPQtGXzM7Cir8KOIAqtmNJAaMMh/InaA9QGSMU1tU72l7Wc
 HPKjEOsKJ+UYL13L+QkEwfKa4HP4FGmxdK7ynhiYCVN/OhdvHH7VU3l0yJQAYh0AjeRvrQFbvIQ
 kYYgGiVQqNeWW7tUmWQ==
X-Proofpoint-ORIG-GUID: oJSa4d8Nn9A2SVKbScrKLzARERzH0TYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_01,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020043
Received-SPF: pass client-ip=205.220.178.238;
 envelope-from=prvs=6493f4f895=qi.chen@windriver.com;
 helo=mx0b-0064b401.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 02 Feb 2026 09:17:05 -0500
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

--------------cZKTSOdP1iBl6Nb0xD0qpgwk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi qemu developers,

I'm working on Yocto project. With recent qemu upgrade from 10.1.3 to 
10.2.0, I found that qemu-ppc64le has a serious regression. It cannot 
run binaries built out with "-mcpu=power9".

The error message is like below:
"""
../sources/which-2.23/meson.build:6:0: ERROR: Executables created by c 
compiler powerpc64le-poky-linux-gcc -mlittle-endian -mhard-float 
-maltivec -m64 -mcpu=power9 -fstack-protector-strong -O2 
-D_FORTIFY_SOURCE=2 -Wformat -Wformat-security -Werror=format-security 
--sysroot=xxx
...........
Sanity check: 
`/PATH/TO/build/tmp/work/ppc64p9le-poky-linux/which/2.23/meson-qemuwrapper 
/PATH/TO/build/tmp/work/ppc64p9le-poky-linux/which/2.23/build/meson-private/sanitycheckc_cross.exe` 
-> 127
stderr:
*Fatal glibc error: CPU lacks ISA 3.00 support (POWER9 or later required)*
"""
The meson-qemuwrapper is a wrapper around qemu-ppc64le.

I can confirm that qemu 10.1.3 has no such problem.

I used 'git bisect' to find the first bad commit. It's 
fcac98d0ba8b5f4c311c1059d897d74d1276af9d (linux-user: Remove ELF_HWCAP2).

Unfortunately, I found this commit is part of a series of about 100 
patches. See commands and outputs below:
"""
$ git log --oneline v10.1.3..v10.2.0 -- linux-user/elfload.c   | wc -l
98
$ git log --oneline v10.1.3..v10.2.0 -- linux-user/elfload.c   | grep -C 
5 HWCAP2
f10c3d9084 linux-user: Remove ELF_PLATFORM
eaf983e04b linux-user/hppa: Create get_elf_platform
084b3247a0 linux-user/loongarch64: Create get_elf_platform
d6b8c5dbd9 linux-user: Move get_elf_platform to arm/elfload.c
3c907dec45 linux-user: Move get_elf_platform to {i386,x86_64}/elfload.c
fcac98d0ba linux-user: Remove ELF_HWCAP2
0dbb0ba870 linux-user: Remove ELF_HWCAP
50e59ad0b7 linux-user: Move get_elf_hwcap to riscv/elfload.c
1d4774b60e linux-user: Move hwcap functions to s390x/elfload.c
92c9983c06 linux-user: Move get_elf_hwcap to sh4/elfload.c
48004ab058 linux-user: Move get_elf_hwcap to mips/elfload.c
"""

So it looks like that the code refactoring for linux-user caused some 
regression for ppc64.

Could someone help check it? Or is there some suggestion how to debug 
this problem?

P.S.
If qemu-devel is not the correct mailing list for this email. Please let 
me know.

Regards,
Qi

--------------cZKTSOdP1iBl6Nb0xD0qpgwk
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi qemu developers,</p>
    <p>I'm working on Yocto project. With recent qemu upgrade from
      10.1.3 to 10.2.0, I found that qemu-ppc64le has a serious
      regression. It cannot run binaries built out with &quot;-mcpu=power9&quot;.<br>
    </p>
    <p>The error message is like below:<br>
      &quot;&quot;&quot;<br>
      ../sources/which-2.23/meson.build:6:0: ERROR: Executables created
      by c compiler powerpc64le-poky-linux-gcc -mlittle-endian
      -mhard-float -maltivec -m64 -mcpu=power9 -fstack-protector-strong
      -O2 -D_FORTIFY_SOURCE=2 -Wformat -Wformat-security
      -Werror=format-security --sysroot=xxx<br>
      ...........<br>
      Sanity check:
`/PATH/TO/build/tmp/work/ppc64p9le-poky-linux/which/2.23/meson-qemuwrapper
/PATH/TO/build/tmp/work/ppc64p9le-poky-linux/which/2.23/build/meson-private/sanitycheckc_cross.exe`
      -&gt; 127<br>
      stderr:<br>
      <b>Fatal glibc error: CPU lacks ISA 3.00 support (POWER9 or later
        required)</b><br>
      &quot;&quot;&quot;<br>
      The meson-qemuwrapper is a wrapper around qemu-ppc64le.</p>
    <p>I can confirm that qemu 10.1.3 has no such problem.</p>
    <p>I used 'git bisect' to find the first bad commit. It's
      fcac98d0ba8b5f4c311c1059d897d74d1276af9d (linux-user: Remove
      ELF_HWCAP2).</p>
    <p>Unfortunately, I found this commit is part of a series of about
      100 patches. See commands and outputs below:<br>
      &quot;&quot;&quot;<br>
      $ git log --oneline v10.1.3..v10.2.0 -- linux-user/elfload.c&nbsp;&nbsp; |
      wc -l<br>
      98<br>
      $ git log --oneline v10.1.3..v10.2.0 -- linux-user/elfload.c&nbsp;&nbsp; |
      grep -C 5 HWCAP2<br>
      f10c3d9084 linux-user: Remove ELF_PLATFORM<br>
      eaf983e04b linux-user/hppa: Create get_elf_platform<br>
      084b3247a0 linux-user/loongarch64: Create get_elf_platform<br>
      d6b8c5dbd9 linux-user: Move get_elf_platform to arm/elfload.c<br>
      3c907dec45 linux-user: Move get_elf_platform to
      {i386,x86_64}/elfload.c<br>
      fcac98d0ba linux-user: Remove ELF_HWCAP2<br>
      0dbb0ba870 linux-user: Remove ELF_HWCAP<br>
      50e59ad0b7 linux-user: Move get_elf_hwcap to riscv/elfload.c<br>
      1d4774b60e linux-user: Move hwcap functions to s390x/elfload.c<br>
      92c9983c06 linux-user: Move get_elf_hwcap to sh4/elfload.c<br>
      48004ab058 linux-user: Move get_elf_hwcap to mips/elfload.c<br>
      &quot;&quot;&quot;</p>
    <p>So it looks like that the code refactoring for linux-user caused
      some regression for ppc64.</p>
    <p>Could someone help check it? Or is there some suggestion how to
      debug this problem?</p>
    <p>P.S.<br>
      If qemu-devel is not the correct mailing list for this email.
      Please let me know.</p>
    <p>Regards,<br>
      Qi<br>
    </p>
  </body>
</html>

--------------cZKTSOdP1iBl6Nb0xD0qpgwk--

