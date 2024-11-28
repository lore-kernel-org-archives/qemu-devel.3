Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A18D690F2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGbjf-000679-GK; Thu, 28 Nov 2024 05:26:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tGbjd-00066z-1B
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:26:57 -0500
Received: from mail-bn8nam11on20616.outbound.protection.outlook.com
 ([2a01:111:f403:2414::616]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tGbja-0000Q4-Fg
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:26:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lon/obLil0w56aXlNAlAl+qVZad1WNo1Ra7iDGcRzflEkXvlk8rlHCrK8bXv9OLLG4/sxB2+AU0mq8V/xTrmaov00shdEzUi1p4BN3xhoBP+PdvwB1QZ40cUguCBvRUIZ8suL3ksdnwqYoqe0+60UEMEy5tLW8RpP/qQdROb/wa+EKFEhfk1Tqk5QRo3ATKd01J9VDb2/Xu9YSq9tzkkXZXzbtriUFLYQudUZEHBXKovgGVIyxClaOTMuyS9JO+QG3/4lzV1wb+RuYJR4MUzuONZngRa2KJM6MqBedOsi7vVJ3YrKBSYMzGhjvR83sKnx9LqHGz8pyGxqsUHdTNQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BOBUEyWGFLZOSAdrlhgfRPwxQR+Xl1O9MK91BkB5fA=;
 b=N3+mQ+XoEPUQVYIaMt4IsaU9gAuu5XExg6iPJwNW5a9VNPRE3uiZQiwuiliL+F619ESYVoSsK2B4HDLScL2eCXohG5DxzxXW2uQlKd+uazyrDnk6/286BRBmp502508GNNBiX4ggGseI9z2CKN6yxwXZ2yPcruFCHVN5KuEZEwPtJoNXX3g18Mfe7lMSBwUKPRt4c2Z7IRBdVnCga5KLc7mwUuitralpjc772Rjfj1x8ZlPi/EJHtXfVVvDvDYqbRFRmeEpLH49MnH8TuhsAYSBUCGKgYVoPZPgpvbxaF9xGJPtwrIPC3rg70wTD/dYWo9U/wV57Jm20qN+P/QbIlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BOBUEyWGFLZOSAdrlhgfRPwxQR+Xl1O9MK91BkB5fA=;
 b=owpd2RFH20PJ3jmOItsdJIpbZP1sqKy5z0NFfp5SAzGpiQD2F3Cua3Nc+U1aYPv6EkhXvYAKDJWRa1zfpKe8ZNMOpzsdm72N/rRHrAvrGIicjOW50WnXNYFpXFzHPfjnxLYJpuPmdj9YH9gqH5R0WN5rjvBGwNxFVKdjn/BMl1G4TCuTRBELZxco0xdWhepCgaFTbQ+Be1LSapm9Y7O5Kf7cPCIVlVoj/LqEACd0pWk8fjSTxE4WK7MzlhouPN5IMs0Knl+G84JXFl3N3gZeVsSmOHt3DHRHgZOML3q81atpOwiaxoufMevK7qHYSiWZeqZ+qktqS+wDFeY4GqGacg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Thu, 28 Nov
 2024 10:26:48 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8207.014; Thu, 28 Nov 2024
 10:26:48 +0000
Message-ID: <198ca4a4-01fd-42b4-9e1a-d2860277be9e@nvidia.com>
Date: Thu, 28 Nov 2024 12:26:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/24] migration: Add thread pool of optional load
 threads
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <877b7108c9cb9064615606d4c731cb12c549b7f9.1731773021.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <877b7108c9cb9064615606d4c731cb12c549b7f9.1731773021.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0074.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::13) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH3PR12MB8725:EE_
X-MS-Office365-Filtering-Correlation-Id: 50060a43-5c6b-49f4-a703-08dd0f972a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1h6RkhCWnFIZ1FJbUc2bVcrRUFnRy85KzFIUmJPS2JwQ3VMdng5MWNLQ0Qr?=
 =?utf-8?B?NmJReXM2dXoyR2NXV3BkcVUwSE1DRUdLcHBIV2lTTDJ5ZmVJcFZIY2dkbk1M?=
 =?utf-8?B?b2pSUStkcWZRY3RpTUVLN3hiRU0zdGRsUkViODJUQk9aOGcwSUcwT1JLaHFy?=
 =?utf-8?B?eldOcS9KLzJZZ3QvRVZGQlRJL2twWVhKcGZmQlF0NStHYmMzWjlpclBmVWZt?=
 =?utf-8?B?Q1NIckFGRFRvOGFKS1Z0OU81azZ5c2lVaU9la0RvdFZDcGRyRkZYM05ZTlhu?=
 =?utf-8?B?YW1YclZSblpqS3hSdnJ3di8yR1RYVXVWQUNvbGhkWlZwQ0FNUWtKcy92N1lt?=
 =?utf-8?B?RVJLMTZnRGkxcVdCeTBwR0FucmN2ZTMzY1NHNmx0ZGZQR29OTmZqcDhFZFlP?=
 =?utf-8?B?YnVEb1d3dVRLNDdiMTdmTDFYSE9VM0crV1dKVXJleUl6bkg2NWlNMjZwMTM4?=
 =?utf-8?B?R0U2TTM0ZzhyVENPcXJpYnVPdk1jd21jU1IyMjhhM1VSM1JnaDJ1RTZ5cWU4?=
 =?utf-8?B?VWxaZkVEdTdLMHBLbVcrYjVPbjFnU2swaGZsWUt5U0JhdVduL1J5aWN6Mlox?=
 =?utf-8?B?bjgxT3BwcmI5cTA2ZldaUGM1S0tVa2VjRFUyVHNDTXc2QmF3cWUwT2VEOERv?=
 =?utf-8?B?L3h1TThpaEc4QkNlT1BpUm5YaFlKTktHUDRGMHB1aWZrYWlXVnJzR3JuMDZi?=
 =?utf-8?B?WHpKcE0vK3pDNis5SElxUWdGclZvU2RLL3BBbHAvWVZKV2NFcWYxWE15b3pk?=
 =?utf-8?B?MENFRjJLRkJPKy9zb0w4SXUzS2dVMlRHZUVhajBIanhSU0l0S29DU1hzdldl?=
 =?utf-8?B?RHptMUxjc1JNT01HZDJ1Y2F3ZXYxZHJFS2VrQ2VPRU41YjFrMXlNMUJkNTVu?=
 =?utf-8?B?dVFhaVhnaElOVGpnK0lQalp2TFZjRVlYTUFZMXFxMnZSUjdRMFljcjlIaEtq?=
 =?utf-8?B?UFVGRXJWenl3OWdwRlFSczFXZTZvOVVLL3J1UTdCQzFobklJejlQbkduc3My?=
 =?utf-8?B?bzZZci9CV0FPZDJZbXEwT2dtNjZtYzFDYWpNeWNIV3hCRTBudllqVkoxOGp0?=
 =?utf-8?B?bnpXdEdsMkpTUnNuRWthM1V1b0V0ZTlNMUgvVjRmVlBqVk5sbXVqVjc5SXRG?=
 =?utf-8?B?UlNIUVA3NXN2aGttVkt1VXNmSHpYRW5aTkdsYTJWN05Jcit6WUxvMnlwUmQw?=
 =?utf-8?B?L2piODZKajcyR1FKdmxPSW5LZXpSMzRrNHEwa2x3bFRxUHIyRXVoQm9adnhO?=
 =?utf-8?B?Nis0bnYzV2ptdTlsT1dBc0NJalFPVmVOT2h1V3hDY29waUIxelFXL0Z4b3FX?=
 =?utf-8?B?eC9TeWJabDNPRWVhQzFLWSsvWFNsNnErdS8xdUJKc3BJN2U3bVhKQnF2NWRZ?=
 =?utf-8?B?bkFlTTFlaU02VlllZkh6Wk1SWU9ockZzVVRENW4vdGdZZUZaalh4Ri9iYnpU?=
 =?utf-8?B?c2VDWm1uWHdWNElaR0tHSlJCWGZrVzF3YnNtZ1BVejlwWjlOTDg4MXdvYWhZ?=
 =?utf-8?B?K2Q0bGd2MlJ3S1ZJVEJheDFqTDdqUG5UK2xERXJCdlh5VkVzV0RSS2d1WExl?=
 =?utf-8?B?TWVmTitHNHBCUmVLNEdtcE9VSC80bUx5TFdnRnRBZXVxT2xxS3Y2MzdPYlhS?=
 =?utf-8?B?OHlhVFpSRlc0aWJMOEJiQWwrYjMrdUE5M0FlbXZHcDBBQlU2eWg2Vzl6QVFu?=
 =?utf-8?B?aGNhR0ZnZ2V3eDN5RmFNSDBzZVBLNm42Qm9NL0JrWVNoejV3ZTlReVdKMGpS?=
 =?utf-8?B?aGhEU25VSTNlamtlZ1Y2T0NYWnFQc2NLOUlqK0VTVHNTbGpLVG9BVEVEbW9V?=
 =?utf-8?B?aThzTlZ6clI2T1Z0MjNsdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVFaaHZjYXFJSC9ZSmd6MTJ1VzdFTURla3JPS3FpNE91SDF5ZVRQMEFmZHZ0?=
 =?utf-8?B?enZEcW9Gb0V1Q3gyMkdrTFRCQVlMOUpZZ0JRVExxeW9BRjhlVTY2cVI3R2hW?=
 =?utf-8?B?NUxuVFRIQ3FoaHZGWnlMZnMwVlAyeVE2ajh5KzRPWk4wOUdybnJEcy8vc0JR?=
 =?utf-8?B?UGJsTGs2TDBRUkhPejNPSE1RbmFqaFRXQXJUdld0bWtCN2U1VjVhaE5yUzZ0?=
 =?utf-8?B?SmhScnEvVVFUMExSRjQ1S0pLWE4rZnhDemdFOUh5RGF5VnNJalRWMHZvZUpS?=
 =?utf-8?B?L21Zb2J3dWhHQ0QwdlJtWlhnaU1yTEZUazlLNjBGVmpzQVlkMlY1TFYyRGdM?=
 =?utf-8?B?WDhOUC8xejVjb0E4NWMyNTRlMzBOTmtYU2tqL1BEYkJ6ZEk5K09Ddll2QVIz?=
 =?utf-8?B?WktrQjRxSXZtUmJFRjJPaHRJcUZUbGtXU0tNZkh2d0hTL1ZSbUpDK0VrdHJp?=
 =?utf-8?B?TnVQbUs1cGVhZ1dpSTU4akRJRy9UeUpaZnlmcTZnejNSaE5TaHpibmpGN2NG?=
 =?utf-8?B?MDMwNE1PVGNQdk1OSG1wTEdwVVdNMmFLT0NBRU9PMzZuS0l2ZGlwM3NIU2Zs?=
 =?utf-8?B?aC9BNlIwN1puRjQrSUFhTVRCMHp1T0oyZXF1WFhPTjladmdJQXBEcU9XTDVE?=
 =?utf-8?B?alQrZ0RJNHU0U0FzTzlBYlRFWGd0RDBMWEtEcytjejBXbVFDUGdXYmFyMjlk?=
 =?utf-8?B?S1N0aFpqcURWT2hHRXJrNXBFczhiU054dlk0YTFsRFJFaTExQUJlT2xMMnpM?=
 =?utf-8?B?eW1LaVIreGdsVG0wUk1TMHYwYkw5Q3hZQXBGaERacHFFcHBKMGVPTk1xQjVa?=
 =?utf-8?B?SEVDNkhRV2J0RFMybWlMdDJvQ3B3d1hLSXJmYnI1dkpOWkZxZU83a0ZrVDhm?=
 =?utf-8?B?YUUzTlBjUDlCWlZpVjluTElsT2tsQlNySklXV0xwd1J2NVZLUzhqVE9Za2hN?=
 =?utf-8?B?Y3p4MzdzblRUMXFVNEMrTjA1Y2VqK0Y5RUZENllkYmk5Nnk4ZlRRZ1drTWRx?=
 =?utf-8?B?T0NOK1FQcjg3ZFpkaXI1RUxZZXE2eGRRVmw3S3NpYmQ2NlMvWG9DcjRnRmRt?=
 =?utf-8?B?VE5NdHhqbXYxbkJLLzBSOHB0ajBBbHVqNVR5QWdnWFQ1aFdSVUdDYk5VcXY0?=
 =?utf-8?B?dWpKSUtFWC9kR2dCRFhYV0hBSk8wUTF4MHhkSXhhSEptcVhhVXlJbzQ0cSt6?=
 =?utf-8?B?WlJqU1RtNGF4WXNKckJkNUVkOFFyZklmR1JreHBFUmtKd0I1aElLaVR1OTJs?=
 =?utf-8?B?UTBnTmxLYXpwZDJiam5NakFtVUY1ZEt2RldsZkx2MzZsOVVJclZjWXFYOHI2?=
 =?utf-8?B?RFFTT2k0N1RETnhycTVtbzl1UmZaaXdDK1QxaUl2eGZPanhiQm5FQ1M3MzE5?=
 =?utf-8?B?UExIWW9ZVUNQYklHWlVpQUVRa09KK3NtdE1RWHg4b2pKU05PUjFZSVcrK2My?=
 =?utf-8?B?eVNkcmdVc1J0aHI5bjY4b3FZVzlFVGhuNE9Ka3lnMVgzRm9jL3F1YS83QTkw?=
 =?utf-8?B?UTQ3Ty9rN1QwclFkSFViWXRCUXZXUDUreXFueGFTZ25WMmtvb3RMaFhwejZn?=
 =?utf-8?B?N2dtZUZTdytTajlNMW9lemhSc1lJOHkxUU40TXlZWjdUVC9MWUh3OGk1ay9y?=
 =?utf-8?B?bmNtcFJlcmlyTUUxSU8zNVJDb0lUOGo5YmZPRjZvRlExUkR6S2lSTmlUTXRn?=
 =?utf-8?B?bTBPbFh4MlEwZ2k4aE5mb1QzeHI3ZlRrOGtPdHhOUjFzYmFvNHZzaHdwSUtP?=
 =?utf-8?B?akNQamRpNldpRFBkNUVFVFpCck9YZkJrR1FFZ1VyT3lsNW5nRU0zamwwNDRT?=
 =?utf-8?B?K0FDTmxyM3BUK0hzNVcyR1FiVlk2MUJyODNhREhvQyt4aSswcEJLUVh3ejlu?=
 =?utf-8?B?VDZFcVVQek95WnVrZFYydTNzcUxGOUFaZzkyWlljR010WmpGN3ExNnZMd0pQ?=
 =?utf-8?B?RG5LWkx2eUd1c2FQejBNV0Jvc2pqYU5XNWRDTXNOZ2pUcmZ0WjBFemxndGo1?=
 =?utf-8?B?RXk3U3dlSlU5NlNpMzlwWC91N1BnTnIvZ1JwdzV6Q0dxNGtwVkZuZW5EYkVO?=
 =?utf-8?B?eFZndE0vV0RGdzFYc20vMXJlNWowSDNsMUdNUnpjcGhPY2VRODJodzFPSCtN?=
 =?utf-8?Q?qSH/LYzJRpxeYrX4q9ZdUs8R8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50060a43-5c6b-49f4-a703-08dd0f972a5f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 10:26:48.4013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vTowHTlw677C0BNnG75KICcMfudkG4BKkUiOyKZBPiiy3Xt0cS7jH8Mybr0mrvvcxF2lMM2b+cN2npdhOo2aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725
Received-SPF: softfail client-ip=2a01:111:f403:2414::616;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 17/11/2024 21:20, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Some drivers might want to make use of auxiliary helper threads during VM
> state loading, for example to make sure that their blocking (sync) I/O
> operations don't block the rest of the migration process.
>
> Add a migration core managed thread pool to facilitate this use case.
>
> The migration core will wait for these threads to finish before
> (re)starting the VM at destination.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   include/migration/misc.h |  3 ++
>   include/qemu/typedefs.h  |  1 +
>   migration/savevm.c       | 77 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 81 insertions(+)
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 804eb23c0607..c92ca018ab3b 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -45,9 +45,12 @@ bool migrate_ram_is_ignored(RAMBlock *block);
>   /* migration/block.c */
>
>   AnnounceParameters *migrate_announce_params(void);
> +
>   /* migration/savevm.c */
>
>   void dump_vmstate_json_to_file(FILE *out_fp);
> +void qemu_loadvm_start_load_thread(MigrationLoadThread function,
> +                                   void *opaque);
>
>   /* migration/migration.c */
>   void migration_object_init(void);
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 3d84efcac47a..8c8ea5c2840d 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -131,5 +131,6 @@ typedef struct IRQState *qemu_irq;
>    * Function types
>    */
>   typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
> +typedef int (*MigrationLoadThread)(bool *abort_flag, void *opaque);
>
>   #endif /* QEMU_TYPEDEFS_H */
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 1f58a2fa54ae..6ea9054c4083 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -54,6 +54,7 @@
>   #include "qemu/job.h"
>   #include "qemu/main-loop.h"
>   #include "block/snapshot.h"
> +#include "block/thread-pool.h"
>   #include "qemu/cutils.h"
>   #include "io/channel-buffer.h"
>   #include "io/channel-file.h"
> @@ -71,6 +72,10 @@
>
>   const unsigned int postcopy_ram_discard_version;
>
> +static ThreadPool *load_threads;
> +static int load_threads_ret;
> +static bool load_threads_abort;
> +
>   /* Subcommands for QEMU_VM_COMMAND */
>   enum qemu_vm_cmd {
>       MIG_CMD_INVALID = 0,   /* Must be 0 */
> @@ -2788,6 +2793,12 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
>       int ret;
>
>       trace_loadvm_state_setup();
> +
> +    assert(!load_threads);
> +    load_threads = thread_pool_new();
> +    load_threads_ret = 0;
> +    load_threads_abort = false;
> +
>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>           if (!se->ops || !se->ops->load_setup) {
>               continue;
> @@ -2806,19 +2817,72 @@ static int qemu_loadvm_state_setup(QEMUFile *f, Error **errp)
>               return ret;
>           }
>       }
> +
> +    return 0;
> +}
> +
> +struct LoadThreadData {
> +    MigrationLoadThread function;
> +    void *opaque;
> +};
> +
> +static int qemu_loadvm_load_thread(void *thread_opaque)
> +{
> +    struct LoadThreadData *data = thread_opaque;
> +    int ret;
> +
> +    ret = data->function(&load_threads_abort, data->opaque);
> +    if (ret && !qatomic_read(&load_threads_ret)) {
> +        /*
> +         * Racy with the above read but that's okay - which thread error
> +         * return we report is purely arbitrary anyway.
> +         */
> +        qatomic_set(&load_threads_ret, ret);
> +    }

Can we use cmpxchg instead? E.g.:

if (ret) {
     qatomic_cmpxchg(&load_threads_ret, 0, ret);
}

> +
>       return 0;
>   }
>
> +void qemu_loadvm_start_load_thread(MigrationLoadThread function,
> +                                   void *opaque)
> +{
> +    struct LoadThreadData *data;
> +
> +    /* We only set it from this thread so it's okay to read it directly */
> +    assert(!load_threads_abort);
> +
> +    data = g_new(struct LoadThreadData, 1);
> +    data->function = function;
> +    data->opaque = opaque;
> +
> +    thread_pool_submit(load_threads, qemu_loadvm_load_thread,
> +                       data, g_free);
> +    thread_pool_adjust_max_threads_to_work(load_threads);
> +}
> +
>   void qemu_loadvm_state_cleanup(void)
>   {
>       SaveStateEntry *se;
>
>       trace_loadvm_state_cleanup();
> +
>       QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>           if (se->ops && se->ops->load_cleanup) {
>               se->ops->load_cleanup(se->opaque);
>           }
>       }
> +
> +    /*
> +     * We might be called even without earlier qemu_loadvm_state_setup()
> +     * call if qemu_loadvm_state() fails very early.
> +     */
> +    if (load_threads) {
> +        qatomic_set(&load_threads_abort, true);
> +        bql_unlock(); /* Load threads might be waiting for BQL */
> +        thread_pool_wait(load_threads);
> +        bql_lock();
> +        g_clear_pointer(&load_threads, thread_pool_free);

Since thread_pool_free() also waits for pending jobs before returning, 
can we drop the explicit thread_pool_wait()? E.g.:

qatomic_set(&load_threads_abort, true);
bql_unlock(); /* Load threads might be waiting for BQL */
g_clear_pointer(&load_threads, thread_pool_free);
bql_lock();

Thanks.

> +    }
>   }
>
>   /* Return true if we should continue the migration, or false. */
> @@ -3007,6 +3071,19 @@ int qemu_loadvm_state(QEMUFile *f)
>           return ret;
>       }
>
> +    if (ret == 0) {
> +        bql_unlock(); /* Let load threads do work requiring BQL */
> +        thread_pool_wait(load_threads);
> +        bql_lock();
> +
> +        ret = load_threads_ret;
> +    }
> +    /*
> +     * Set this flag unconditionally so we'll catch further attempts to
> +     * start additional threads via an appropriate assert()
> +     */
> +    qatomic_set(&load_threads_abort, true);
> +
>       if (ret == 0) {
>           ret = qemu_file_get_error(f);
>       }

