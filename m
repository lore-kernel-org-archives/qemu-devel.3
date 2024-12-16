Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40E6E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:53:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNCSv-00021K-IR; Mon, 16 Dec 2024 09:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNCSu-00021B-41
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:52:56 -0500
Received: from mail-mw2nam10on20628.outbound.protection.outlook.com
 ([2a01:111:f403:2412::628]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNCSr-0004vF-C6
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:52:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOqFELOZThSBrfxC+eFlOXX3kqu0lb/QyQNw/jd8CVfgNBkE+5GwsfK2jKxYY6mN/hvxtj+pcrpKQGVjP74SJ46cROfP6k53lY+zHDq3uxxBcYt9Rx5OKZPPj8r4EV4xDKRwuJCiGVLICqJnMIUPcUOCfvK4ex2kdwuEI/J2NM2VS2AiWvVPk/WGjnaY/2hi947vXVBlbVWuH6qM/J+h4MwzYWPnxwXo9JIdLhlHimNgdwYgsp38QbB0KLqF938i1Ng+brNK17W8TyJimHFYQ9Ixeq+yvNKSNozm/kaXTsdv5shqrbNpEeaZodAHZVIJVMJS4DTklW/pSImIJANetg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vO0iKi1ciHUSbIPiSQYjMgTqgDa1QjJGT0o3g1Nf71c=;
 b=SSkkhv5ggzgJHFrFQXi3sFpeTGnVmj+9gMqBN5N85Ve80Y2qAnZQ1LPfqpvW3F0lniFfdTS2AEx8Mg6GGxOpnBcFqNhaU8dzFHFbqQnt6U/cvsdtC6JLWU8gfgX9jXSNULn89iOxHg5NzqltbRY1yPm5G2CGuk9KkJmtMEbbExW6+OiDsP7GeA2D8F7ag6GXo8mAi58xGGB59MbDwj8relN8vI+wSIzSRnrtQyzKriy1q5xDiqwnXy7vBwZgr5vl3RThKjI35p8Qj/8YAUbqJ9gcV4tXazJ3QAhmzCwW8uJi7r0vLC7plvpisrHy3t6NRRUmNs/aKfmkVB0ztsZ8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vO0iKi1ciHUSbIPiSQYjMgTqgDa1QjJGT0o3g1Nf71c=;
 b=JqBBM4fqty1YhMImeiepEFjoWgEmGMXHreT3jP1RU2hWAG4cEv37qpnGu1/dIs7EzKZQ74QbnArYFcDuaouKoj/yTcwCGtWtFHnCzBe29rWTaALe3ibgPMaCIf67GYjAq/zTAXX/ytYS9K6M8yik3ClETj2+6SNtqc09RHVOyx4z7DhaS5flnMKMJgNbmdxb9AApYWcmlldDlFZa0S2glxvIMzG34yXyrTgZ4bMAzzs+iwTc5alwAr9OuZyPpqSDvMB168Hr4LVR7hPfRM4K+mzAznBgoJQuqtdLsJVFxRaPVddbgnl93cDifWMxeTTvmP8E3iHT0JLGxE2TTfNS9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH7PR12MB6666.namprd12.prod.outlook.com (2603:10b6:510:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 14:52:47 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:52:47 +0000
Message-ID: <50e6d3f8-0642-4a6c-b6fe-21a68ebe9d39@nvidia.com>
Date: Mon, 16 Dec 2024 16:52:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] vfio/migration: Refactor
 vfio_devices_all_dirty_tracking() logic
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-3-avihaih@nvidia.com>
 <7fdc0511-7a31-4e75-a873-c4c67edbc08b@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <7fdc0511-7a31-4e75-a873-c4c67edbc08b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::19) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH7PR12MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: 29dc5a23-08ba-48a6-b8a4-08dd1de14e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXkvcFFWYkkxMXBCNVJLWGtxdG00T3VMMVJTNWRWWE1vbU9SbG9Ha1owNHNQ?=
 =?utf-8?B?NjMwSUR2aDJ6Q1UwK21peXhtUzU1ZXl3WFlUR1VPbTN2L2lVVUhSaUVwYzg3?=
 =?utf-8?B?MEZsUFN0b1ZNMU4rUkRCTDVCb2dBcG9VT2lwTXdSRjFBYzl5NlBPMnZOVXhj?=
 =?utf-8?B?UWZ2VDcvTkJDaXNrMitWU3EwT0o1eWdObnZxYkcyOWRDOWd1QlBQbHVLUEFQ?=
 =?utf-8?B?Rmgra3U5WkY2RDYxbXFoeVBkNzhQaVZ4MzlGNTFqeUFSbFY4V202VlFiRDJt?=
 =?utf-8?B?ZGRJbnBQMHhtQnRrb1Q3YTZza3Zlc2V4Qm45ZGxXT0VML1RFMURCOFVES3Vl?=
 =?utf-8?B?RFRrRkhzdHp2bWJpRWVDSUVtSStKNUM4cGVvTGwrdVhSbSszYk5YcXVXZW0v?=
 =?utf-8?B?NjhoZVRoTVU5NEdzQ05EcXJxd2Q2T1o2OG1hMzBSWVBQeHNQVzJCQ0RjZEQ4?=
 =?utf-8?B?ektzYmwyQStMOEZlaUI4Zmtudm16RWcrWk5Pckxxb1FvYUowMFZpM0ZlVlg5?=
 =?utf-8?B?OFFBNFEvWGdiWG9odWdnT0xJVU5wdlNCM09hNExNN1Bqdm1seTJaQVVnak0x?=
 =?utf-8?B?YUIvaWhkN2wySHQ0U1dDaVRMMlJ6UHpMVEUrQWNVbXdDVm5xTHp0dStLTG5u?=
 =?utf-8?B?UmZBS0d0SjhPSXo4Z0J3d05OSjV3WGFhT1V2aXlYalMvbG9vdnhtMERKTXBN?=
 =?utf-8?B?U1g5VXUvV1lVYWFJUko2U0drRFYvdTBLdHhRUnlwamx0NkcvcUFWL0xDK2RQ?=
 =?utf-8?B?eXZ6QkdhTjZCY0Mxd1VhazNmaXFWbjdudDVHNmJIMFhCOWtHRGY1S2orVlJw?=
 =?utf-8?B?Y2FrdXZmL205NS95RHZ0NUdTVDhjUUZRWXNjZ3d4WTd1SmthTGRoMFlWOXQ2?=
 =?utf-8?B?eVFMVmt6Zmg1SDRzWW11TnhhUStiaVYyb1RmUmhtbmxFVWR2bTVodWxlNm1B?=
 =?utf-8?B?MVk0VUEydWdGOFY5aUhRZzJuajVIeUlrYUlGT1lGdmN4VmtTYXdyUU02VkNG?=
 =?utf-8?B?dUMxV2tDV1dLZnRhVVpNTitDL2ZwTGxDNnJ6aWNITllYZllVOExscCt0S0k2?=
 =?utf-8?B?VU5Gbm1BTXg0THZBUFdWbHc2QTI0MldTMzR2TUx6UW5YaGc2Q2E2azFQemVn?=
 =?utf-8?B?aTRMS2lCczAxSk1ML3BPU0Z6blZrbzJHKzdCdG5Vb25BMDFrM3FIVW1GNEpT?=
 =?utf-8?B?anFhTWh2VlZPVW4rckkvTm5ua2U5dmFHVng1azZ1aTVHWnlCNS9zY1Nzd25J?=
 =?utf-8?B?SXU2RnlmaUFxdUgrUzZ1cDZlc2tHNm5QUG9TemduOHZqVFMxVzFtMFFVUno4?=
 =?utf-8?B?eEFqK1RKTGdKbU1JTGZySTRLT2xGdGVtbUhlTTFOYUZkTUpLVXNpdU14WmpE?=
 =?utf-8?B?WE16aVhzQk1DN1dxTk1KdWd4TFBjWFpNVHdEYTQ3bUhMeXNsSUh2YnFtQ0N6?=
 =?utf-8?B?K21BdC9xQkVoY0xXU0t4alBQYW9sS3ZoY1V3SFhLb3B0aHBMWUdtMEI1c0VU?=
 =?utf-8?B?bUE2eHZ4N1M1a1hWQ1Y0d1JLWWs3RVd2NkZNZnlJakFXVEhtU1NwTzVMaUNR?=
 =?utf-8?B?dE55c2l6TElXbUNJbk1oNGwyWm1GQkg1T3pQRDczK25FY1JwUnNmYmk2ODND?=
 =?utf-8?B?aE04a3RJK0VpK2M4TWV3Zzg0Zit4MWpKWVpKV04ycitZRjBKd0EvNGh0ZGNM?=
 =?utf-8?B?MmhNYThTSUdleTIvK0NuZkRpSWM3ZkRCQXJjMlR3SVp2ZHNKa3VsR1o5SVNi?=
 =?utf-8?B?NGkyL3JQekt6NGJJQ0lpeFpqSTlqekYwS2xXall0dkpEZlZtTWNsQ3BkSUs0?=
 =?utf-8?B?ZkEyUXJmenFNa25pM3hjWFhReHFUdFRPQmxNZno2V29yMUs5d3Bva1dOVVNP?=
 =?utf-8?Q?rMbj+Ob7aATFK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkZmak1UaU9PYWhHZHBDWHVnV3hhK2JZUDFaRmordStzZG1HV0c4YW5TMjhJ?=
 =?utf-8?B?WTVFOTY3NnIyQmV5T0hwdkJvSUZvLzltVHl2c2dPOXlsV1huVjhXUlBBdHdH?=
 =?utf-8?B?dmhKRGtWZkVoMURvM1h0VlBqWEFraVh6Skw5NmNZSWY4N1NtWi83bDhGcjUr?=
 =?utf-8?B?NUdFZkhhVjZDbzZGVSs4Y1FoWjdGTTkvNkZWWnVSN2lDaWplaHJlR3BkSy9R?=
 =?utf-8?B?d0RCRC9wZ0FHSHdWK01WWXdXNjkySkEyd1dFNGFLNEtQQVV3WVVKMmVjTU5K?=
 =?utf-8?B?VTZ1ZkpPbHMyT2U5NkJaNFVjcEluTnhRQ1RmelFtMFdQdE9ENkhPajZTSkU3?=
 =?utf-8?B?Z0VDbWRBNmFDNlFaWnRISDFFOUZPK0dGV3JkQ0dZWVRQVnpJWWQ0aUhLOUtM?=
 =?utf-8?B?S3FzeUtlYmxBcVJDMWsyRy9YMnBROEEyRWxBMUl2MSs5VU5mdlpDaFNja0Rk?=
 =?utf-8?B?WnJyWlpMVnBYd1RFSVJnUDJlZUhoSXZCL0Vjbzg3TjI3RWRxRVlFWFQyVG9L?=
 =?utf-8?B?QjRESkVBTTBab3lBay95Z1V2czFISkNtOFg0VHdUUWxBSlpLSGJEbVVTc25r?=
 =?utf-8?B?ZEptOG9Wb0R6dGpWNHZ3akRua0p0S0dMT1lGTllETFlCNnJSV3V6RlczNnBL?=
 =?utf-8?B?bzFYOGtaOFZPSGhibDg1M0hIK01Zb0VHM3ErYmI4SmwrRUlqSGNKODBmcU9n?=
 =?utf-8?B?dXZvSXFPRmg1NDNyVkF3LzZQYnlUaHNaaWwzSXpZOHZxc3FsOWlsNitXay9W?=
 =?utf-8?B?RURUNThheWI3NklzU0xQY0h1aTMzcDZSVUZ0LzBhUlo0TmRKRWtlK09OL2Zs?=
 =?utf-8?B?Q0F5UldiQXZkMUVXTHNQYzBjWDJLS3FWWnNUaVpqSmJpQURMaDNjQnd2MndG?=
 =?utf-8?B?ZFpCSndvSnNQZWhlZ09CR2o4R05zQW8xL0lsVG5ENXhpYmI3bGNFdmZMbk9Y?=
 =?utf-8?B?bzU2ak9WaERHOEhCb1FRL2YzM012ZlBqSmhjT2cxU1ZqRGJDM0JEWFZudWJR?=
 =?utf-8?B?azdlcG00NzdVYmxUQ3N4U0V4MVRZL3V4OUtjSkptOUR5RU5KSzNtTTNOemtO?=
 =?utf-8?B?MzM4c2xmbUd6OEpTRk9OM2paR2pPN1BzN2tOdXI1eDJHWTQ5bkpkZXorVWps?=
 =?utf-8?B?SGpFVW1RVXF1clltcG9WVHJScXRMS3hhOUQxMjJFTXl4MzRIQlI5ajYzaVI1?=
 =?utf-8?B?ZWZBVVhSSlhpYmJpM0dWYVAzSVM0KzljRVlQYU00MFQ5dkRZYUJkMWltNTZG?=
 =?utf-8?B?bDdJVlB0YlFyKzYvVmlRQUl5ZVZHd1IzYUYwWmRHTmt0cGRmajVYRit0c3pj?=
 =?utf-8?B?ajZTS0ZpV3hTNEh1WmxtMExwZEx6a0ZCVC9qQm9HVU5KVjZPR0ppLzJ3aTRU?=
 =?utf-8?B?ZmRHdzJSc1dhT3pDc0RqVGpEU1dIR1h2RUgyVzZ6ZHFsaEM0YzBCN0ppc0Rt?=
 =?utf-8?B?V1RYYXA3Z2QzVzNWR3laZDhFellVYUJERGRYeStPeEE5T0JGVllQYUZidGRS?=
 =?utf-8?B?bEFLN2IvSWRXT004SUdqV1drSHAyYkhxbDRqdTVOQUxNR29ITWpZQzBHZmhG?=
 =?utf-8?B?dXM4UHk3K3E0SWVQeDVTZHliZGxRdU1YMDFxcGFNeHloY29rY3dGeXhaaURJ?=
 =?utf-8?B?ZGhEUmI0YWk2RUx1TGhsT3NPcTIxZmpWRm1zdFo5TlgyeDAzZjZLNEdhbXJK?=
 =?utf-8?B?aDZQNVEvczd5WGxNYm51T2U4cnp4bmU2UHV4WTN2aEVvcVloSk1XQlFlRTRF?=
 =?utf-8?B?Mjk0dGVidkNhU1FDc1h0c0xPY1FCMk51eUpzSHd5M0kraFY2THZlMXVsM1BK?=
 =?utf-8?B?eUsrOHpUQVczRHN5Uml3VHBqakpKUXYyOWowUUlHc1E5NFYyUHluU005eDZn?=
 =?utf-8?B?MlF3czZmWTFtT3ptZFVEdjRIZVU0Rng5aTF6Y1BIMU8rTzNQb0VIQmtqYTdV?=
 =?utf-8?B?WFFuSXVjZEhGaHdSck9YcGJhK2NlZG54bG16VUo1T2tEdmpzcmV4ZzJjc3dy?=
 =?utf-8?B?clY5OGtDVDBCOTJuenY3V01nTTBnNUpzUHBGNWpuMWxjN0VLRnRpTmQ1VkFM?=
 =?utf-8?B?Q1lYc3NldjRXTXVCYTVyUlh6RHpLZWFuZmZpQ3ZSRXNOejZ4OVMyWFBQOEF5?=
 =?utf-8?Q?IyBUXGnFZgb8UcmQnz7e9JcAa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29dc5a23-08ba-48a6-b8a4-08dd1de14e0f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:52:47.3390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DGXTePcCiwseNJSotsn28lxx50Rpg31f03sPzoJwbcvQ84F42Rl0akr5EF1q8t/phDuIAkqVGweZS6rnOLRtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6666
Received-SPF: softfail client-ip=2a01:111:f403:2412::628;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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


On 16/12/2024 14:32, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 16/12/2024 09:46, Avihai Horon wrote:
>> During dirty page log sync, vfio_devices_all_dirty_tracking() is used to
>> check if dirty tracking has been started in order to avoid errors. The
>> current logic checks if migration is in ACTIVE or DEVICE states to
>> ensure dirty tracking has been started.
>>
>> However, recently there has been an effort to simplify the migration
>> status API and reduce it to a single migration_is_running() function.
>>
>> To accommodate this, refactor vfio_devices_all_dirty_tracking() logic so
>> it won't use migration_is_active() and migration_is_device(). Instead,
>> use internal VFIO dirty tracking flags.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> The refactor itself is fine except a pre-existing bug:
>
>          Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>
>> ---
>>   hw/vfio/common.c | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index dcef44fe55..a99796403e 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -170,11 +170,30 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>>              migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
>>   }
>>
>> +static bool vfio_devices_all_device_dirty_tracking_started(
>> +    const VFIOContainerBase *bcontainer)
>> +{
>> +    VFIODevice *vbasedev;
>> +
>> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>> +        if (!vbasedev->dirty_tracking) {
>> +            return false;
>> +        }
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>>   {
>>       VFIODevice *vbasedev;
>>
>> -    if (!migration_is_active() && !migration_is_device()) {
>> +    if (!migration_is_running()) {
>> +        return false;
>> +    }
>> +
> Tieing to migration status means that non-KVM dirty trackers cannot be toggled
> unless somebody starts migration. When really your original intention behind
> commit ff180c6bd7 ("vfio/migration: Skip log_sync during migration SETUP state")
> was to avoid the setup state when you are indeed during a migration.

It was tied to migration even prior to this commit, as VFIO log syncs 
were restricted to run only during migration (we had "if 
(!migration_is_setup_or_active())" check).
This commit only narrowed it down further to not run during SETUP.

>
> Now you can actually start/sync/stop dirty trackers without migration when you
> use calc-dirty-rate which is immensely useful to draw out how active a VM prior
> to starting migration.
>
> The fix is simple and would be to flex the condition to be something like:
>
>          /* Migration status is 'none' with calc-dirty-rate */
>          if (!migration_is_none() && !migration_is_running()) {
>              return false;
>          }
>
> This is ortoghonal to your series of course, but given you are skimming around
> this area, sounded like a good idea to raise this. This patch below is what I
> had plan to send when the development window started, but this was before folks
> wanted to unexport migration status helpers.

I remember you had several patches that formally added VFIO DPT to 
calc-dirty-rate (with a new "-d" QMP parameter and everything).
Are you still planning to send these?

> What would be the alternative idea
> forward?

Now we have an internal VFIO flag to indicate dirty tracking status, so 
that's one thing we can rely on.
And we can also use the global dirty tracking flags in 
include/exec/memory.h:

     /* Possible bits for global_dirty_log_{start|stop} */

     /* Dirty tracking enabled because migration is running */
     #define GLOBAL_DIRTY_MIGRATION  (1U << 0)

     /* Dirty tracking enabled because measuring dirty rate */
     #define GLOBAL_DIRTY_DIRTY_RATE (1U << 1)

     /* Dirty tracking enabled because dirty limit */
     #define GLOBAL_DIRTY_LIMIT      (1U << 2)

     #define GLOBAL_DIRTY_MASK  (0x7)

     extern unsigned int global_dirty_tracking;

So I guess we can add some helpers to access global_dirty_tracking and 
use them in VFIO to decide when to allow log sync.

But as you wrote, I think that's orthogonal to this series.

Thanks.

>
> -------------------->8---------------------
>
>  From ace22f29a0547353e4ed5a0db53292a77f79fa81 Mon Sep 17 00:00:00 2001
> From: Joao Martins <joao.m.martins@oracle.com>
> Date: Wed, 9 Oct 2024 00:27:46 +0100
> Subject: [PATCH] vfio/migration: Allow dirty tracking reports with
>   MIGRATION_STATUS_NONE
>
> Invoking calc-dirty-rate HMP/QMP method queries the VM dirty rate
> without starting a live migration, which is useful e.g. to understand how
> active guests are and even for testing purposes. calc-dirty-rate asks
> the dirty rate from the VM and it's not restricted to a particular dirty
> tracker.
>
> However commit ff180c6bd7 ("vfio/migration: Skip log_sync during migration SETUP
> state")
> didn't consider this and currently restricts that VF/IOMMU dirty info when migration
> is active to allow it to be skipped during SETUP stage.
>
> The vfio dirty tracker is already started, the reports are just skipped
> based on migration status. So change vfio_devices_all_dirty_tracking() such
> that we include MIGRATION_STATUS_NONE to cover calc-dirty-rate case.
>
> Fixes: ff180c6bd7 ("vfio/migration: Skip log_sync during migration SETUP state")
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/vfio/common.c         | 4 +++-
>   include/migration/misc.h | 1 +
>   migration/migration.c    | 7 +++++++
>   3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index dcef44fe55be..0c188a2baac2 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -174,7 +174,9 @@ static bool
> vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>   {
>       VFIODevice *vbasedev;
>
> -    if (!migration_is_active() && !migration_is_device()) {
> +    /* Migration status is 'none' with calc-dirty-rate */
> +    if (!migration_is_none() &&
> +        !migration_is_active() && !migration_is_device()) {
>           return false;
>       }
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 804eb23c0607..857768b51383 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -53,6 +53,7 @@ void dump_vmstate_json_to_file(FILE *out_fp);
>   void migration_object_init(void);
>   void migration_shutdown(void);
>
> +bool migration_is_none(void);
>   bool migration_is_active(void);
>   bool migration_is_device(void);
>   bool migration_is_running(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index 8c5bd0a75c85..49d11e1adf04 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1637,6 +1637,13 @@ bool migration_in_bg_snapshot(void)
>       return migrate_background_snapshot() && migration_is_running();
>   }
>
> +bool migration_is_none(void)
> +{
> +    MigrationState *s = current_migration;
> +
> +    return s->state == MIGRATION_STATUS_NONE;
> +}
> +
>   bool migration_is_active(void)
>   {
>       MigrationState *s = current_migration;
> --
> 2.39.3

