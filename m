Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EA3C021A0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 02:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti2vT-0005zM-9g; Tue, 11 Feb 2025 21:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1ti2vR-0005z8-P4
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 21:56:33 -0500
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com
 ([40.107.237.53] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1ti2vO-0006CZ-Uv
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 21:56:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdLTkskDuYuIqsck0ds0BNbGbRs2ZYdZS3hdz9A+tmlwlGcrmTQOizs0Aqc/1RSNzn6xO9iRTcbsDXv5RC5gm8dN452Yiy8RhDSTvV2lzcy9ZxHklW2Ixtb+HqWaT5E/qREn3ggrAMVPKp4tLI4VjoWs4UfcbS/XdQ3KNleSitD+cznFtQb/KQK28n/oPpLLJESiAogLytQIzg5+HqLAK1PNS2HFDF2i1I5qhiyOdpWnbV4BypW6mFVAf90viKNmIkFUtH1SAyqLV3MpI/tta4B/38Cr+9D4nJBd8t1d1kxRZMoBPi1BI64QonAQ2vpDMbnS5qeCTxmVajKjyb+3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndyNAmfwQn4MoDd0+eC3PcwyjlkMGEQArF6UNsrohgQ=;
 b=dmdz3mZJFdGd7ILAldDrIgl5BGwZIiFpq0ANbZANQk860itLHWRQiWtPFE8fD4L1aEmaeqQy1dBvKQfRpuBh4rK63M4XbOld3srF7dj2ekszILorfa4q9LqIF0AJOsNhF5W3shwCb/4uXClvFIWiT5AK/wW7nsvomvHqsH6i6j0STi6j5nmTaK3DU0vRu011v3yoBgyUkO07LLF1Q0RnpHrPYqSqK8p+rQH6epEwmYnSsaI9tXUTB03zUf/ZShG0qemGiyuQE3ERcBbv4p+GVWD7GWJqtYXEAEYGyJrwL7PGT4aaeKZC7LsWsDMGxYDI8UOFksSaKxxSq/XDiyNb1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndyNAmfwQn4MoDd0+eC3PcwyjlkMGEQArF6UNsrohgQ=;
 b=F57FgYl8rY09KMTiI8XuHgXxz7ltnD68hLEo38U76+6Bx4uhy8ovn3ImiR3tmxjXCklE9eQKFcwqFAcvOwwaf8FTiN1+LoZMFJ5XK2UvdCWm/CLUI48lZKdi4wvc8EiVzCK8JOgVbAvLFArFZ3YjhmuU6fBi+/OA524XkOyba80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.19; Wed, 12 Feb 2025 02:51:25 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 02:51:25 +0000
Message-ID: <545534cf-67a9-4a92-bdb4-9ee8c30c457a@amd.com>
Date: Wed, 12 Feb 2025 09:51:17 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/i386/amd_iommu: Allow migration
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, jon.grimm@amd.com,
 santosh.shukla@amd.com, vasant.hegde@amd.com, Wei.Huang2@amd.com,
 bsd@redhat.com
References: <20250206051856.323651-1-suravee.suthikulpanit@amd.com>
 <Z6R6ZiHhbBjOfbko@redhat.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <Z6R6ZiHhbBjOfbko@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2e7bae-49e5-48e2-1ac3-08dd4b1023a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVZodmk2R2dYQXpqZHAwSnIwWHVHdlhSaXRtalYyVGszaUVnb0FHUGNkOWFr?=
 =?utf-8?B?SkN2NnFOc1NXWFM5MU5TcjZkUlFkMFVxZGFLaFVVTWx3WXZ3WVFIN1hXSnpk?=
 =?utf-8?B?Tm5nV0prNm93V0NtRUZQMXk5NlFUNnVLWWdFcDFvb29mWnZYMnRZRnZnODha?=
 =?utf-8?B?eEdzNnlzMlZybkxPZTlFYXNsSGhnM0RRZDZJNmVxVm9rVGVVTW9LMkRUd0pX?=
 =?utf-8?B?eE9KR1pXVlUweGplRmlNdDRQL1hwNWNuUkNDSGVTOTZSRzJKUDhNaXRua1NJ?=
 =?utf-8?B?ZjJ5UmhIS2dHazlSNFlsbkZLVHdWazhQd3JPeDJLN1Ftc0I4bkdGUmNEK2JX?=
 =?utf-8?B?MDRyLzB1Umh3TnlNKzFVejBDQ21tV05hMWducXdJRzJVbHdFOUxpS2U4aVVE?=
 =?utf-8?B?NjY2cDVZNSs5OFV4emtrT1lBVkVyY1F0REhYSWtvWDlwYm5rREE4TjN0MnhW?=
 =?utf-8?B?aUgzSEdxZXpIc3orTnlnaXYxeDlOTmNlY25ZVWJnZ0tiVEFOYS9WM3l6dDlB?=
 =?utf-8?B?K3FzT01Id0grV2VmSFd4Qk0wcUFUTHE4M3A4M1haUkdVc2RHcjk4OSs0ZENu?=
 =?utf-8?B?Z29nZkVEbzJwNUplL2drZ3FOSXdtc3JFa2M5cnF5U1dieTIwVXNiMnJiOTVS?=
 =?utf-8?B?d3ZLK29iOHRxRUpSNjJJZk1qcU14blJHYTJwY3lDaitPNGkzbmNzOVBhd3gz?=
 =?utf-8?B?S3Z3WEtVNTl6dnFHTHJ4RkpvN29ZUkFLTXlWSUE0cEY4Rm9JbDZyblk5citJ?=
 =?utf-8?B?MWlYNTY0dVl1eXVhWXBKelpDN2pEN2QzVExsWTdkQjNVUmlFNE9yS1pWNVVM?=
 =?utf-8?B?dHMzMU4vQkwwSWJjaktRbC91Q3krdlZoamhEZWlqMGExd1JLQkV6UjFMYjhx?=
 =?utf-8?B?dm5HK3Jydzl3SWYrY3k4Qlo2Y016d0hFSUNYUjBlTERvdm5SWWpDU2l0K1R5?=
 =?utf-8?B?YkYvNGs4ZDhsL0FiNmR0TDJGaEN0dTVjVEZNRlRDTngyYjlmSWEwcHdLWlJw?=
 =?utf-8?B?a0VweWxTb0NhdkJnbmtIZFhTVytodzRHLzkybXlNUit6bFU2Yy80NWplOXc2?=
 =?utf-8?B?NEM5LzZ5cnMzMitMS1dLdEVDZ1hZeUpPNlFrMzhONllyZ2RaSUoxeVR3NGM0?=
 =?utf-8?B?am5IVS9oY2tHSDgveVNuV2hvYVpzOW1lUko4YjY1MHozUXIrU3VKcFB5ckpa?=
 =?utf-8?B?VVYwdHNNQ3ZNNmZJZWN4TXZiK0RmeVY4ejFtRkV1NGhBN3R3RFQyK29iL1pp?=
 =?utf-8?B?TlBGazltR0thYkhPTUluYUwzeFl3WVFBTmN2Y1lQTzhzT2RCbWJhbmhNM1Vm?=
 =?utf-8?B?dTkyb1BKbERnRmhzZTdnZlFxOWU2WUJRd1FYYlgzSG1OcTZzUy8zQ1hVNmJG?=
 =?utf-8?B?WDhqd3NGay9PUGVQSURFZ1VTbjJvL1d2WmxXdStRYUlWczlUbUx3QkhPNTVN?=
 =?utf-8?B?aHVvZ2MrTS84SW5qdnI4RkNMMXAvZ3hrZTQxVm43bWx1Z1VyQ2locWZHNkdv?=
 =?utf-8?B?RFVsYnpiNmxXY25icVBvRmRsbVBvSExKQVB4MksvTDVBS3p1TGlTYnRDY2Z6?=
 =?utf-8?B?MU5OYVBnWDhFUlRaVVBlMnpLTXJ6RmxRSEt0Mm53c0tuT29JaTZ4b29sWjRS?=
 =?utf-8?B?SUR6VTdadjdQMmdzcXR4T1VRR212czF3ZUJ2Q1lxM09DbDN5U1RzUkRmdmY5?=
 =?utf-8?B?Z3ErSEZiSlFOMERwY3RWb2Jmb0lpa0FVeVBXc0RKaFJKb0d5UnJXbWRRRWd5?=
 =?utf-8?B?S3pLamRXbmhYbmRta2dlQXQvdk14Rm5sWUpkYysvakM3ZkJOb0l4UDI4MWVH?=
 =?utf-8?B?aHpZMHlnQWNYR2VJTWhTZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTVGR2YvWFF0YWFsWE9yRkNvOVJjcFNuaEUwNGE1ZWZzMUJKQVNYcnhnVWhC?=
 =?utf-8?B?Q0pQODNxQy95V3BManpZUG9sM2Z4V2dSQ1o4OTdQVHFWTklRNTdnMFBqRlpJ?=
 =?utf-8?B?bEUvanNoZnpzTVh1QXZJajhDZytWYm81a2l5amYwbkxIT2RPb1JOQzNtR1ZQ?=
 =?utf-8?B?NnFkcitjNFBtVjQzQURSU3d3T09lbFVBb0Q2MTh3ZVNXWHFwK0cxTjcrNEc1?=
 =?utf-8?B?QTh3dTBlUVV4eHYyNTd2SlJFTytYbllTMGhSWGpWTVhVQjllWkpwb2ROdVV1?=
 =?utf-8?B?RFh4MnNsbmhRVmRGNW9CcXNvamsxclhCbE4wV3RVUit2WkVkemdxM3dmUS9t?=
 =?utf-8?B?eVVueWtDVFg2TlZPaWc3cU1ZQ3BJcDUwUHFIRWkwY3VFTGY0dTcxN0ExQ1pk?=
 =?utf-8?B?Sk51YmZMYnR4ZDJnQ0RtcFQwazROT1VFZTF2U21vMSt2TDZYMlQ2TThBRmJ1?=
 =?utf-8?B?VUo4anBiSEFxbXNWZFJmQjExYzZ5Wkg2NWF5eER1UGhDTzE0MzNwUmJhWlN4?=
 =?utf-8?B?N1NKMnU1bjU1Y3J6U2MwNTZJYWg1SElzazBaT1NFc3d0bG9kZ2haMDZFY2tY?=
 =?utf-8?B?Ym1HSWEzMWJkQmhQRFBkaUpTaFhTbS9DbXV3czlkSS9Yai9GWVFCL2l4TjBu?=
 =?utf-8?B?bnpFL1ZhdmE5blJFUlI0Nk11NmFLVVJ5VlgzNG01WXgwSXd0R3pOM1VsQ2JP?=
 =?utf-8?B?bi9PT3gxcVBVS3A4N1E1YTBSaEs0dVR3K0ZVdlo1M25pRy80bTNLcVFCcVVD?=
 =?utf-8?B?M3BzQUpsbnFSVnQyaHYxZzR4TGF0L2VWdHhWaHdWNVk1Zmpmd0JvUFZkSFpm?=
 =?utf-8?B?L1E2U0RuYmxNSUJuSkIvTGsvdThNTVczZkI0UnlyZFNnZHg1U2FHQkhGdU1y?=
 =?utf-8?B?ZTFUazV1MHUzTkV0N1M3cVFNMW5FSnFNWGxmK0dLR3Jub09yRXdkbEZPWmtN?=
 =?utf-8?B?Y3Y0bUFuTDQzWWhvV0I2REhPeENTRFlXZzAzS1R6d29iaGd3eTZEeUpPWHJn?=
 =?utf-8?B?VkprVXYzLytoN2JIdXg4VzB4dk9GT3g1cEN5VGlEMXhrYVdxbE9HaCtnVGM1?=
 =?utf-8?B?ajhEWndCUXpQQTVsSjlQQjdzbFMyTElQOWNOVmZwTitDUFZOQU9jdmxYL1pm?=
 =?utf-8?B?cUhEVXBoRDMweXA3RW9xYUpFNytVOWNCU3ZmOGFmUzVrUE1BaWx4VXRpTVFE?=
 =?utf-8?B?VkxZK3Q2RjFvWVdHaUMwSkV4RDBPWlpSa2FCbVhUNStpTE04TE9BT09JclBL?=
 =?utf-8?B?WnFBcnBZRU1RNHhZM0dXU1Z3TC9EN0ZYZUhwNGRRWlY5cHV6ZGRjZnc4YWR6?=
 =?utf-8?B?MUIvTmVyL1VMdGdRN0t1YU1GK1RWK1BGNk1DUXhCQnRiOUlDU1llSUxLVUhE?=
 =?utf-8?B?OFlqRGwzNkcyTFNYb01FOHBLQTQ2RktvQ1RMaGl1NHVUZkdEZUEzN2xsVlha?=
 =?utf-8?B?RExhWHNqZEhnelR3b3Zyb3VqUFZJTDFjbUg3T0RhVjZEalNYLzB6c2hOL1oz?=
 =?utf-8?B?ZUJycUxYa1d3c0dlQitlTFBtaE1SNUVlTXJHZFFjVXBKa01JQnV5dUE4TUYr?=
 =?utf-8?B?LzVWT2g1cjM0WXl4SU9jbmI4ZDJLdDJzUVYzWW9TVmxlKzdhd1VVMmZibnBK?=
 =?utf-8?B?UVRWWUNjVzUybHRYSEpDdE91RStYQnJobHZQdFIrOTVzcGpYRDVPa2p0Rk5M?=
 =?utf-8?B?ZERWVm1HYXo2Y3R1NHNpL2RoZllRY3hVa3hqNzMrdUtobWwrbWRxWXh1TTd0?=
 =?utf-8?B?UHc1Rm9kc2tLRmJDWHRRcWRVWXBlK0xKZnBDMXo4V1lManpudmp2Z3NlUVQy?=
 =?utf-8?B?S1BvRkNHL2hlejhyMG9YS2xUVVNWTWdjQy9CeksxTjdwL3JLODhOOXNaUndK?=
 =?utf-8?B?WjRyRDg5Y24xUzFqQ0NnejdpL3FDd0piTDlhM1c1NCt4dlYrTVVsQVZxTE5U?=
 =?utf-8?B?a0N4QXhjeUpJL1A4N3liYmhlT0FDM0V2TmdKdWJwUldtRk14ZlJIU2ROMllR?=
 =?utf-8?B?cXYyNkRxdGlVdjVTbFBZNGlFMHJJbjFibmZCTG5rRDlRM1JQYmM5WUg1b2Nq?=
 =?utf-8?B?S2NyQjhXcHVMREZodWc3UVduSHJYNzlONnhkTENWaHNwY0ZybHltbjdITDBp?=
 =?utf-8?Q?IvdUjg8EGhRnEGLRTOYu+Rt0d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2e7bae-49e5-48e2-1ac3-08dd4b1023a0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 02:51:24.9428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p4HIkURAAxAXDgaW7A6G2IX00rEFucNhafLo6ddX8vHz4/RLepQ3ZTBQD7GZj9sosY8kZNOHmVByx0Ii/UUJNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
Received-SPF: permerror client-ip=40.107.237.53;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Daniel,

On 2/6/2025 4:01 PM, Daniel P. Berrangé wrote:
> On Thu, Feb 06, 2025 at 05:18:56AM +0000, Suravee Suthikulpanit wrote:
>> Add migration support for AMD IOMMU model by saving necessary AMDVIState
>> parameters for MMIO registers, device table, command buffer, and event
>> buffers.
>>
>> Signed-off-by: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
>> ---
>> Changes from v1:
>> (https://lore.kernel.org/all/9ecffa7a-f4c6-45a5- 
>> a066-84826ccb55dd@amd.com/T/)
>> * Include ppr_log, pprlog_len, pprlog_head, pprlog_tail per Joao.
>>
>>   hw/i386/amd_iommu.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 42 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 13af7211e1..a1940a0ab3 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -1673,7 +1673,48 @@ static Property amdvi_properties[] = {
>>   
>>   static const VMStateDescription vmstate_amdvi_sysbus = {
>>       .name = "amd-iommu",
>> -    .unmigratable = 1
>> +    .version_id = 1,
> IMHO we should not remove the 'unmigratable = 1'  setting, until we
> have fixed the design problem with this device, to split the creation
> of the 'AMDVI-PCI' device off from the 'amd-iommu' device, so that the
> former is user creatable.
> 
> As it stands now, there's no mechanism to guarantee that the internally
> created 'AMDVI-PCI' device gets the same PCI address properties on every
> boot. Thus it isn't safe to claim this device is migratable yet IMHO.

I'll send out v3 including the change you suggested, where we split the 
creation of AMDVI-PCI device to allow fix enumeration of amd-iommu device.

Thanks,
Suravee

