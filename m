Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55D8C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 17:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4OY2-0006Vt-8A; Tue, 07 May 2024 13:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4OXw-0006V2-G0
 for qemu-devel@nongnu.org; Tue, 07 May 2024 13:24:08 -0400
Received: from mail-mw2nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:240a::600]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s4OXu-0006Xs-1S
 for qemu-devel@nongnu.org; Tue, 07 May 2024 13:24:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SV3nkz0m+SIS3C4CoLgyT5jPVuxCqEetpawJ6SLmuFXepFq30ra7GO9SvlrF0ARMUBSIEe2BBDsyOm0xqOiGpCl5f/02TVlbSQY/I8CwwsPCW0Oh0QDECTD/LCo8dmL5Q27hnk3Z+9n6ImcbKm/ME/Jb/3DfkO7js6AWoh0Blk8UbkgfznoAgV8zaOyUeq175iBlFGcwDX4DICs1LMbzjozMaKAe8Ujo0CZjYNtZR1UxQVAFExit6J6BzhvMbDVqRNxryZrVmvNHjQrnKwUJf3X7vEyTuoOj0IopDxu5zxUKeP+R0mlTZXFFKi3G+V2NqNGclD5lpSYFVZYwYakbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKIs6XOiNdjs5SHqzyt8XbeDo8KMSIPgNcj+eXZjxfY=;
 b=Cwmo1EEiFokDWua9zoGyiQYu3fipn/Rb57uQvBABDaedn5fzX37MOgbmruS9oJOmqVp7KUwj2bA74FOR+7OE6gWQLVUZD9JqH6fpC7LLbXKRWiT5UuXj4qEjEYXu3s3oHPDxWqpHSSREgXPLWEn9oznwnC5bVFvtZVVRe7SB0Lfuhuy0XUwgLCjwOkQFLjXaRnVSFeO27R/sab1o5HmuRyzf3SJE/BTyJjPrDNoh4fSb/3BBaPGT+n/x/Q2iUciFRsKpHAdL1WzJe5r6hMPJGN9YFr+ErgqI4m2SNoTN3HRIlfItVvd5VhJr1xqd85epVwr2H2s5bF9FGwPwZeKSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKIs6XOiNdjs5SHqzyt8XbeDo8KMSIPgNcj+eXZjxfY=;
 b=GM+t33r/1Jy4xbyHZjhO0BfCnkFVH5guSVz2g5jqSN/t3jaEdZKBP5t9DEZFB6TexpzEssp8dOXUwIBGKkqBwJbTtUOLvYmmJSf2EC9mqJXY+UzaaLDv8PzCZd++u3CGrSLogNXFrxkYtLsnPWFdLZmUxzwnok+722ri9rcySbZBDhe9W75E75RI2Jp87uOwLll0+aI9Lz3FNHQ4ojTyvs++x7EU08+trSthMS6gcEEI99x78zka33yvtPoEtHyzAvLVs2uyx/DSojeGl4CS81gGJYR/PHdrZKB4Hk3Uaenz/b6H/WuauBfM3OxMF6EIb5yYCzFWz5HIM3cpc43FfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 17:23:57 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 17:23:57 +0000
Message-ID: <f67fcc88-aaf6-43f7-9287-90cbd7495ba1@nvidia.com>
Date: Tue, 7 May 2024 20:23:50 +0300
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_RFC_00/26=5D_Multifd_=F0=9F=94=80_device_s?=
 =?UTF-8?Q?tate_transfer_support_with_VFIO_consumer?=
To: Peter Xu <peterx@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alex Williamson
 <alex.williamson@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <ZiKOTkgEIKo-wj5N@x1n>
 <d7d59001-0800-4073-9def-08327e904b7b@maciej.szmigiero.name>
 <Zig0IPofMCpJdGsn@x1n>
 <e88ecd55-14a2-4043-946b-9c2447fe9def@maciej.szmigiero.name>
 <Zig3vebacR4SfJLh@x1n>
 <1a0b3c24-fffd-4db3-a35e-e40ae2e0a074@maciej.szmigiero.name>
 <Zi-4FmjXv-gx7JH_@x1n>
 <fc0721e3-4932-40b8-a6eb-2584a475d8eb@maciej.szmigiero.name>
 <ZjkZyP9Ty0TpTCTx@x1n> <7e855ccb-d5af-490f-94ab-61141fa30ba8@nvidia.com>
 <ZjpTQoKT9AIGwNGk@x1n>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZjpTQoKT9AIGwNGk@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::19) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee0c239-8bf3-4e3c-3e5a-08dc6eba7a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2lJOHliNmNzTWRxSTVCN0JoVjhBOUFSRTh5YU1BY2RJTU1ka3drazE3L0pK?=
 =?utf-8?B?YStMVXVsTWgrRDQ2OHY0SHNBTUd0SHEvWk1udE5VV3gzK1JXOUlnZDVqTEVT?=
 =?utf-8?B?ZDNtM0t3T1N2dTZWeEhKV01DdXZJYmhaYWZReExFSXMwamdEV0tSc1E4WlFo?=
 =?utf-8?B?TjBva3VxNDYxS3JtdDNiM3hPU01yQnM0bVlsc2xhUXo2dnNpSUJUVzB0VmNM?=
 =?utf-8?B?VW1zTk1QSk5ScEJmSHJET0ZwZERlNk1TSklNNmtTVVFkMUJSeXdFd2RVT0xt?=
 =?utf-8?B?NDlFMmoreFc1ODBzMmo4WmJ2aXZZeXRLT3h3VEV3a3NZc09NVE81QWFVWVJm?=
 =?utf-8?B?RU1tVUhBWElaM0Y5SVFxVDNjUzg3TGVkaWF0b1lpdWl3Ym1IVGY2cTNZR2xN?=
 =?utf-8?B?V0QrWWxJVGhWLzI4WTNyNXNRL1lzUDg0QmZXNFZHdjZadWJwRUIwcTFqOW5T?=
 =?utf-8?B?ZWx1ZEYrRHRrUFhSdDQ3clJER2U1aThpZzhLWFp6MnBqSUtPZEdyK2xzZVBB?=
 =?utf-8?B?d3ZMWlo3dVpLVmxaQmFubnp3ZHZ2ZEV1YnU5TDNFZW5EL3N3T1FKTHFwQmVG?=
 =?utf-8?B?bGNnbzJ4Z3ZIYk5kdTJlbm9KNHRUbnpEdGtOQkVpdStkeGg3dkVMenRIL3Jh?=
 =?utf-8?B?a3gxck1nYm5iTCt1WWVUWVFrNHJzT1RWeVlPa3NDZENoSjQ0MVBBNlQ2MnRm?=
 =?utf-8?B?NGlDWXErYnNWTEpDN3I2aVF1dmcrZHk4UkVtcWdoRno2U3o3cTVEUHFPd08w?=
 =?utf-8?B?bG5IUS9KeTBmVTRoc29ic1lLUzcvU2RuczJPK1p4aW91dWFsMllZN3FseGpV?=
 =?utf-8?B?L2R1OXByQ1pIY3d5WGYybWxnVGxMd3JhaHhyWU9iRHBlMXFwU29qMUE4WW54?=
 =?utf-8?B?VHNXYmErck5aZHhhNlBCcTV5UjhyZlZ3TjN6M043b25kU0FVamNONjZybkdM?=
 =?utf-8?B?a1FoSVZMcFRkOUZDb2l0Y0FuRVIwWlR2bFhyQmJNNU9WUzdGall4Q1J6YzJw?=
 =?utf-8?B?Mjk1RkRIcWI1SHczM2JMaTlaMXMvaVh5Vm94cDd5bmNVeVB6ZFAzUFpFbUVj?=
 =?utf-8?B?cUUzMk10dU41TEpFRXpTZk11RHZtL1BPTnlDOXRLdkwrMWlyM1hJd1lRU0dq?=
 =?utf-8?B?Ky9mZXZCU2kwbnRiSU5aN25qYUV6cTU3ODZ5YXFDeVRVR1RQZ0JTVUcyWXJU?=
 =?utf-8?B?dFF2cEtqNC8vcWt2anRld1hiT3Zxem5FODVoRFBSeHVkd25uVkNIY2RPN2Q2?=
 =?utf-8?B?UFFNUU1mb05PNzlxMG9TbE9LL3I3VjNnWFdIOGM4Z1pWVTZuZGpldlV6aFdF?=
 =?utf-8?B?dVYzR3lQdXRPN3dCT1EyOWhqdnR1WFZCQTM3cGo1aStPWXRscVVPb2tEbEgx?=
 =?utf-8?B?L1dCN3Fha2k0RjdDejc1eU9Ua2ZGUS90dG9yZE5QVUZSU1lkeFQ2WGZjTHFz?=
 =?utf-8?B?alhLRCtjeHk0ejVRSG5UVm1XblFkem04Rk42M0xodmxYWDcwZi9tN3ZqS0px?=
 =?utf-8?B?ZGxEclYwYlR5My81VjI1VHRwc0RiT1dtMUZ2SWhyMzA5Yk1oNHlsU1VhZTdp?=
 =?utf-8?B?UEN0ZjJpcE1XMUF5SFlkNGNDV0ZIdU4vajU0ZTF3UVdBbDA2K0wxbzRvL0Nr?=
 =?utf-8?B?ZzBzYVNyZHRacGpETTlhRDF5TVF5anQ4b0ZickRyYzBKYThQbytqWURXakJP?=
 =?utf-8?B?ejRaY21CbkxjekdyTHdFM1gvUzBYQ05tUUNKM0k3Q2pJQ1pvYTk2a0d3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnJMNUxYNk5SWVIvUEc1V29MYzN2ZHBRbVFkYjkwSW1NdE90NXIvemJSMnNG?=
 =?utf-8?B?aVBiekxrM1NUbWt0akU5MDhMaDM0MkgwZ25xdE9GV0lRS3gzc2YxeVRQZEp4?=
 =?utf-8?B?dG1BMHlhYmtITlZKWWxBNkRIMEtaVG5nTm1acEdPZmNMSjRHRmhzRjV3c1A5?=
 =?utf-8?B?ZHpMb21iNW5ydSszU1ZxYzd4Q3RvTEVBdjBiQnFVU2lERVhQTXFWSVBUZ1RG?=
 =?utf-8?B?cWRNNGVjdDRkZ1ZEVnBibE9RdUFWL09oSkJxd29UdkV4V0VJRG9uQVVMSTdL?=
 =?utf-8?B?Y3ZFOWZ0eEd2UU9lcmpPOXprN3FqZmJSbGswTUNuRk5QdTlEaUVGVEF0Rm12?=
 =?utf-8?B?cTZCMnVwaGgzZHR6elpKVmJyVUFXa0lta3MxaDlDMllzaFBTRDYyN1BCaUlQ?=
 =?utf-8?B?ektzMHptUUdVWUlRNGhqMVBVazVLUDk3clp4b1hDV0ZueEZ1WG1NcHR2VmFs?=
 =?utf-8?B?bkpWcEZxc3hkVEwxTDlndHdUb1ZTeDlnaFhEM0pNMEMxSUpNYlh4bVI4bElK?=
 =?utf-8?B?ZlBiQXVKeGxHVWE4WUs0VElGY21oVjUvL2J6Vi9PVUsvWjNSNUVhMlNXZVFk?=
 =?utf-8?B?M0dITlhWRjZ6MldOMkJEM0NpbGdsb2ZhSmo4K1JHcmpHeFBPMlluTTBDTVp1?=
 =?utf-8?B?clNJR1l0YlRXQzVNNFFMd0MyNm54N2xWbi9ISFB3OEhpdVZaRjNzeGpGSlY3?=
 =?utf-8?B?ejdMaDJydC93UllubThLcE5BNFdwTXF3VkNkeS9VOFZ6R1BrbGR5OUVSblFJ?=
 =?utf-8?B?RmpaRXRnZVA2MG9CMzR5aGdMMFVkRjFvelFoK2QySUxTY2dqakR6T3AxeHF6?=
 =?utf-8?B?V0xHWkFaYitlV29sbS9zaVF3WHI3NkxaT1hoYzl3SVQ2UE1jVzNmdlEzMGtJ?=
 =?utf-8?B?NnlnekZwZitNV0NZYXh0Z0NPcFZ6aUlZVWphL3ZwOGtReFB1ZjZuaUJ4MUhZ?=
 =?utf-8?B?ZUVMdXFjRitDcUJXM1lhWFRZaDRIeSszUDB6QVNwT2x1Y2VGK1dUQko4WWI1?=
 =?utf-8?B?SHhGelNsZWt2Tmx3WXRoNit6dDhnZmlBUlM0aVdzcjE4OCttZG9wUTlkYzB0?=
 =?utf-8?B?NSt3Z3ErWlUxVzkzV3ZPdWM4T01nR2NRL0ZiRnVWQzUya0tiM2J2cldRVWsy?=
 =?utf-8?B?Sml1ekQ2Mkp0WG9OZDJCbWs5SzA5cnJmMWFjNjVtR0FBeFFTSisrNEpTQlRx?=
 =?utf-8?B?aW9RcjFTQVdrT0ptbWE0Q0dBcUFwNndzU0NBSkJpV0FpcEk4WDN0L211NFhX?=
 =?utf-8?B?ejB4cHgrdzJPNjUwN2l2aWlJUXRIbmF6OU41OUhrNWhhUEUvZ29HbjRqNDlT?=
 =?utf-8?B?T001VDlUaFJKTmFXUlU0RFNoYTNuSjZZL0JmM1laUk00TDRIRWdVdDRmZ0lZ?=
 =?utf-8?B?MHNtTXBDVk00SVpOeGxENVNSMzFFTElLeHdjUUpqa1hhelhEcDQ0SjNldHdW?=
 =?utf-8?B?cnp4aTBMZjZLSEM0UWd6ek1QdmppS2dxOUlURTR1dHpPMVpLVmhxWDIveHJB?=
 =?utf-8?B?OTRIVGg5eStuSzZxV2xadjl3REREZDRFS2xKbjRKZFV3L3QyeVZFOFZWY2RN?=
 =?utf-8?B?QkVoRzNCVHlkQnZFT29mczlNbE5meTYwaHJrbHNQSTR0NThYYjJ0OXpLc2Rm?=
 =?utf-8?B?dnllSGNOc3dvMmNtNzNFWnFWS1RmZDQ4NGxOdXRQVVcydVpaNTJjc0IvdXZu?=
 =?utf-8?B?RzhUSURJRVhQcjN6TUVadHVkVjRiMG9oTThmWllnS0JVU1ROUTdTb1VYYmVa?=
 =?utf-8?B?S1U3Y3JJSGlBaGFRaFFubngwQ0k0OXJLM3FRZ3cxc0Z4VUNxSVc1MnR5VWZs?=
 =?utf-8?B?MURNS29vWFlkMmlvd3lMdlc4WTJSQUVVTVlMUDMvdVRIMGFaaHpyMXVyd0RK?=
 =?utf-8?B?V3hJNFplUklJS3BDYWVjbVV1R1ZsclJDZnRNQk9DNFZYK0kvdEF4cDlDbHcx?=
 =?utf-8?B?RGY5TzduSEpoSHNLcXdYaVhVc096WXFTTG9yR1c5Vkp6c0hBMy8vaTFNVExY?=
 =?utf-8?B?U3NXR016dnVRYmZwVzM0cEY3QXkweDVteVRrQVVZS0F1dlo4MGdTeSt0aitK?=
 =?utf-8?B?MUU4elR3L0U4Rk56UHR6WGVBKzE4dEtRbXEzL0xQd201Q3NxclZCMDJMRjlJ?=
 =?utf-8?Q?jVh60kGrY/nh8pOdwHvoW6bV1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee0c239-8bf3-4e3c-3e5a-08dc6eba7a0e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 17:23:57.5977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGeEJ5C7+k0b9QtTj+xKMA0MWgBd6Q3kqm2nNUjb9k/DSj6XFXBShrLIvglWyxQIX2/Dfuiy6Vbsc9u6lnAvDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863
Received-SPF: softfail client-ip=2a01:111:f403:240a::600;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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


On 07/05/2024 19:13, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, May 07, 2024 at 11:41:05AM +0300, Avihai Horon wrote:
>> Yes, I was working on parallel VFIO migration, but in a different approach
>> (not over multifd) which I'm not sure is relevant to this series.
>> I've been skimming over your discussions but haven't had the time to go over
>> Maciej's series thoroughly.
>> I will try to find time to do this next week and see if I can help.
> IIUC your solution could also improve downtime, it's just that it bypasses
> migration in general so from that POV a multifd-based solution is
> preferred.
>
> Fundamentally I think you share the goal more or less on allowing
> concurrent vfio migrations, so it will be greatly helpful to have your
> input / reviews, also making sure the ultimate solution will work for all
> the use cases.

Yes, of course, I am planning to review and test this series once I have 
time.
As I previously mentioned [1], I'm in sync with Maciej and his work is 
the reason why I pulled back from mine.

Thanks.

[1] 
https://lore.kernel.org/qemu-devel/f1882336-15ac-40a4-b481-03efdb152510@nvidia.com/


