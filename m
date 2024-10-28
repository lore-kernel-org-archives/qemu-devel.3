Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB86AD13588
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 10:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5N2t-0004g3-WA; Mon, 28 Oct 2024 06:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1t5N2r-0004ZB-Po
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 06:32:21 -0400
Received: from mail-co1nam11on2083.outbound.protection.outlook.com
 ([40.107.220.83] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1t5N2p-0007lN-CO
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 06:32:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGCKt0p1lcFyX/Chhk3sI58rKU69Msl2g02BjSXXALJIqgTE0/bQBlqcfTIjcALPItEgh4jiExlMJ/oGltZ4q5N9FNI8HTxTn1zq3ZZjTsnm/cNsN6zJSLqxaSMMrfG1BMzn6ey20Xew9ehi+G2CLs81QNFOOIqzwHyOIZ82eU8ZjzbbhK0tw4LRnNgfbw7+TqSaICNKA3YLGFrS8G2/kOumjJmvKPaenCpDZLLNLHdSuQ/bB43RGZjT1r2AeBj0S8ZvEUkp0Npx8PweyRetjo7zjbJebudjpHYUKVFWabbQ3DnluG4TJfgVjGPiDAFarlM5tq6+CdmFwarPF5fbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jELByqC1BhrHZWAGQPMkAeVZoMlL19dt6YLFHC7hzck=;
 b=pLC3KN7XRAZzxiKWQs9VdNzEKWHq1FteTVX7OUiDNeopdshznFbS4LXjUC2V4ylRzr2PakD9RLmund3AvK8rxvHkRYOomSKCsd4+1Iw7p/ImLSe0ToUNqnPf0+zRYUPvSbP2OADDjGTgdKQLebWxlkzg/aaPH2Xi15uC6RB3UzisSjUD+Pjq8D3hcYw9vlc36Z4T5eZxdf4dprcm33+0HFdJ7g0rA6LFr3g158tCjG4Ydt0wktfVp3zsrG4yFY7gijV6iuGqJglPlhIoTdpartmoVHuxFVur0ZLR+Bb8DRkutVAvd+vvbN5OIXPP20SRkOaS0DnH3J/+ep/WImK35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jELByqC1BhrHZWAGQPMkAeVZoMlL19dt6YLFHC7hzck=;
 b=2kRA0yTQFZdP/PP9jOiQxW72SVQ/6Xtklq2FNAd6rios2nGmtaYeIKYuCuJfH40o+CYXEXSRw962F9iuY8n1jtEfrE3uMAxuyFL8woaYl6iUInfrmNev+VfrOHZIjTntjeR37au29kpRvMWrzznBHQ4rtWR8mWeaVGuK28AL4P0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 10:27:03 +0000
Received: from CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750]) by CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750%7]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 10:27:03 +0000
Message-ID: <d6a1489a-83a6-a7d5-060c-02e82c28759a@amd.com>
Date: Mon, 28 Oct 2024 15:56:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 0/5] Interrupt Remap support for emulated amd viommu
Content-Language: en-US
From: "Shukla, Santosh" <santosh.shukla@amd.com>
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: joao.m.martins@oracle.com, Suravee.Suthikulpanit@amd.com,
 vasant.hegde@amd.com, mtosatti@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alejandro.j.jimenez@oracle.com
References: <20240927172913.121477-1-santosh.shukla@amd.com>
 <42e3067c-1e87-9e17-2e89-4a0b910d9f61@amd.com>
In-Reply-To: <42e3067c-1e87-9e17-2e89-4a0b910d9f61@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0241.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::12) To CY5PR12MB6323.namprd12.prod.outlook.com
 (2603:10b6:930:20::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6323:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a2684f-6105-4315-dfa7-08dcf73b1066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WldmQnAwaWtKaC8wSXlPeTd3RElhdUg0N1RUVEc5RnQxMWxjQWVCMHgreXNt?=
 =?utf-8?B?aHU0QlpYUWhaemtnd1gvNFhzTHBxMUJQdHgrcCtKOWtxdWtqVmdMTEpJRWVQ?=
 =?utf-8?B?Nk9MNllQT0l6ampQZGRURzdIUE11VHJ3Q2hzQ1lRTUNXakFKUWR2QXFPSTVH?=
 =?utf-8?B?OVlQbytKRVZYVnFtUWVzblFjS1FHRU1yNHZSQkxPbkVuQ0NGcTlYMTRYRHFZ?=
 =?utf-8?B?M3hmb3UxV08rMEZBVUdWRnBEdThBSEVldlpvOXpkOVFsMHh6aUcrdWRrYkZ2?=
 =?utf-8?B?SzNTOXVuWHhRMTVzdTAvWEpiZ3hlcFlEbU9mRWhTejB3Q1pBMXY4UVJ4SDFL?=
 =?utf-8?B?eU5lK0VncGQyZ1JkNkdSNzJBdXQwNy9BVFU2RG9GZHR2VHhEM0kzTzJTakN3?=
 =?utf-8?B?Q3ZkM0JkWUpodlVLenhEelpRbEdhdUVIN25wWUZNbHhiblAyWFl4c09lanVP?=
 =?utf-8?B?bkFkVWdqUkhxcFBLL2VzZWZGQm5OTWkxc3Y1SGJOQmM5U1c3VFBmTFRIaDAy?=
 =?utf-8?B?ZTZCZWRWWnh6Ly9YbWk1bDhZd2s4YjUzNkkyVWtXcXdzNHp3VDRwci9Pano1?=
 =?utf-8?B?eHRObVNxOXNZL3pEQWN3bUdQRG5uL2NGK0hKTllNY3FCdWJ2Z0Q2cTdIR0tE?=
 =?utf-8?B?WkNLbkFFUEZvK1ZQQ2hWMi9kc0Z4TmhXdWp0WmNZdEVBM1I2TytoQ2FoblNF?=
 =?utf-8?B?L3hRR0VrdzJUNjRWeVBQTHhzZUVPeUc3STgwKytyVjc1a1lHWkNIWG4zQ1Jv?=
 =?utf-8?B?RThiOVZuTGw5ZWdkaW95ZE5OY09jdzNUZmpGbDJDaHlzMFZtQ2tTRFpWQjNm?=
 =?utf-8?B?NDljUU54TldPaEdwNmNRSndMY2YwTE5YU1FkOWxiMjB0cWs0NWt0SlkwdEdR?=
 =?utf-8?B?dER6NnRSZmFsSlU1TjdtcEx4TkNlTmtmMEYrMzgrM0QrSmZnc0FTTURrcVpX?=
 =?utf-8?B?SlkrZzloZExJVjk1ZG9GMnlPVUZYRXg1ZUxpa2RUOXRtUXBrc0RPMndIV2Jn?=
 =?utf-8?B?MkpDZ2w2S1NIWFFVeVhzZ1drN3JLOW5LMmozZGh4RmgwVzFUa01sNmlCcnpZ?=
 =?utf-8?B?VHlDV1J1Y3dNZzFjNzB2NWV0WTByanNsM1RiTDF0UzJ1a2xNWGprcW1zaklo?=
 =?utf-8?B?Q1ZIb2tFN0hRTE1BMm1XZk1kWkFSYW1VcjQ3Z1Rqa2xJZU9WcGw3aXZlQWov?=
 =?utf-8?B?WUlJTjFXYWpHcnE5YVlVZHZFRzhIa2ZwVzlGMDZYK0o4YjNEZ1I1VjZaUEg2?=
 =?utf-8?B?R2lhakVZMVduRjlhSFczYU5QMDFGVG1BZlVuaFdhVWwxZmpqL0hXbzU4YmFV?=
 =?utf-8?B?d2RKRmxmWEduUVVaOVBjbWIxejl6bjlpVGN6TURiYVh4MlBDeUpEMGhMemIy?=
 =?utf-8?B?bjNsTEZQaXRXWVgrL0NVT0g3V0NYdlAwOXdBMWxKbG9QMlVlblk2dFFhbjVr?=
 =?utf-8?B?UmZBL2FVUi9Db0tyMGg2WmhOU3I3NTl5OVF4Z1BEUnpydndlYVdwK0UzZUEz?=
 =?utf-8?B?NzExaVh5cFBxYlc4L0lQVUtGVDNGdC9nMXpSb3A0MjVGRUd3aGdYZXJGbkJL?=
 =?utf-8?B?N2VoVG1rKzE5aDdCQTZnVmgvbWFxZGg2T3FDRGtPQlJ3ZUtnSXgzeFhQN3VE?=
 =?utf-8?B?Y1RLSThoZk5LVTRxb1BnTDExWTBEMlRkeXU4NittTUV2RmFvYTFiZFpwN3Jz?=
 =?utf-8?B?WDJQYTA2M3J6blRSMk1IMThYTTZweG8yZEpCU2Z1M1pXMjhJZUxLeXo1VGNV?=
 =?utf-8?Q?PjiXo/FR9H1JIdnxrJIRU6oslD8RXjSLdKp67+U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUdwRFVpSDJXeU5nVHh1UWorYm9abDhLWEdFQVErUkx0TUlsZlhWalh2a3Vu?=
 =?utf-8?B?K3lPbnlHMDNjajNiSFQ2WVJBQ0thRGxjVzVZMVRXWTVBTHA4eDhhbGNIOVRV?=
 =?utf-8?B?SjNpb3NHSVJkSDRKVUtOZHRUTk8xV1NhZmk1aEVhQzFCQ2J4MjBjVmxqRlo4?=
 =?utf-8?B?cFRnWTNhM3hCSko3eHRYUEtFOSs4VnJPRkpiTXJHSmhZU1E5ZmVHdVo4Lzl4?=
 =?utf-8?B?eitPTWNrdjNYRE9sbkNFbkhTVDRMQnl2T0FoLzhMeE9MQWo2Q3lnenhDOVZZ?=
 =?utf-8?B?a1NGamd2amhIdFQ0MGVFQnluclg2SmI2WXVuMUhLcUx4dEVRQk95ekh3OWd3?=
 =?utf-8?B?YmNraUQ1K3NiQXdLVWRXTTNzVHI3Mkljb2U0MkswZlRFRTRodmZwSkxSS0xs?=
 =?utf-8?B?aXBHOWl2K2oxRFVnaElVVHA5Zjg0bDdnSkJ5alJqeVN2clM0ZHBzZWU2Rkdr?=
 =?utf-8?B?d0o1SUV5emFZd2NrR1NUcEdIR1F0bjU1NE1zWjJWRnVCUHM0RXdPR2RKcnJh?=
 =?utf-8?B?ZEpVUjk2RFlhaWE3Uy9pSDN4SXlVZ3djYTRrQnBSem1ESUhCMlpuQ2pPQWJO?=
 =?utf-8?B?MlJVWmMwRTdPZzFEZzQzNEpNbHJNZk5BNUdXZXB2bndLMy9jcU14TndGMjI5?=
 =?utf-8?B?bEVDMGRSd3AvLy9jdkpIRzBoRmhRRjFuMENOVHJDS0g4OG1nbDROZTh5dDhw?=
 =?utf-8?B?bXFzbUhuU0drRElpMXU4RVhoZGVMdytIa3JTMUJUUTB5MGo0TzExcnduWk9H?=
 =?utf-8?B?SU5aTDNBMkc1bjQyUjl3eUlqM3U5SmllWXJNbU9ocWpiQVFDUHlPcjcyNUE4?=
 =?utf-8?B?ZEVyRVU4YitjVXdLeHZFRlEzNm5Bd1BmZHJLUGhmdG0xcUowb1Rqc0ZDRGhO?=
 =?utf-8?B?Zy9yb2N1WGgyTWMxelIrckt2U3ZlVnE2ZFptVWowVmZnY3FSWjAzVnZUWGhM?=
 =?utf-8?B?M2VaVW54RktSZFVhWVlMWDR4dGF4VkE0TUpRTytMRW9aMkdWanVPUGo5aXNa?=
 =?utf-8?B?UUE1NS9tVXhKTG9vSzlkRjV4KzVZZXppcXNRbDRYY1Bncm5FckVhNzFPQ3Zq?=
 =?utf-8?B?a3FSaXhzamlpQnVBUFErSkt5UUI4SkVpelE2TGtZcFh6L3BGYW9ma1hheVdW?=
 =?utf-8?B?RFhUMzExcllMWEh5Y29rOHN2NEhMNEFmMENTb2sxZm1FUlR5S0p5TVpzV2Y5?=
 =?utf-8?B?Ym4wbkVjcDQxaUhkQkpqZE15dTBsTDVaUE9MZksvRDExcU9NUUQvRk9UYjla?=
 =?utf-8?B?N1RsRUZsd0M0dnEzVjN6bEZqTjNqUHlTMHR4RlFXSENDUjg5eWRLTHNuT1Z4?=
 =?utf-8?B?VWFNVG9CUGduU0JsekZmcWpUMVZmOUhjcjNHdXV1WmlsSzVGeFJZb2U5R1A4?=
 =?utf-8?B?enUxTUtUb1o1QnhXdXpsVTdBM0dsY05QYk9kTlA2bnUzVmhIdVBkQ3dRR1k0?=
 =?utf-8?B?V2c0NzRTNmdWbXVLc2tkMFFWTkc5WGU4MnB0Y2JnbFFXSnhCcHFNTGk0TnNH?=
 =?utf-8?B?M1cyWmhVMDRwcklwL1hrMGhjOGIwKy9BWTFoSVBJckduSnhSRTd1Z0RkbWRv?=
 =?utf-8?B?WWRwdW1oYVNnZmV0UXBLMWhmTXFVcnRtbklBQkZSaWlwTWlHZzNHalpZR1pz?=
 =?utf-8?B?TnVsdHV1U2ozY3NKY3J4VmkvVXN4Y2VTNXNVaThRdnNzdjBiTHVyVGZiR3Iw?=
 =?utf-8?B?eFNDNWJrWUlwSWVCWERHL2V1WjlHZXcwTHZWeGgyUTRXT0lJNm1iRzBXbHRT?=
 =?utf-8?B?KzQ4eGJsQ2lXeEhUUjJoc1YxODJUcVBETUNaNVA0RTN5K2NPVWw0UFVYaWg1?=
 =?utf-8?B?QzhFWnhUWWNLUUZXV2RNZHFFVjFmL3huN0taSHFHUDVoUUcvUjFzUE1DVFJ3?=
 =?utf-8?B?a0dNelpPZGtrVHc1WjhCb0ZpTjNFbTRIRS9oZTIvK0RGcVJCNzJ4bTcxTGdT?=
 =?utf-8?B?WmtKdEJjRUFRWWxlL0ZlejVpWHVlWDZ0M0xNUFZxY2taZ2tpTmlrZEtaWFhC?=
 =?utf-8?B?a3ZkT0laN0I3RDNaVFplK1EyclUweFVtanM1bXA3TGFtOHRhaitRcmdFMXUy?=
 =?utf-8?B?cFVlR3JDbitjSEllN0R0citQcVdIZlRYNmZCVjZ2YnFlWmIycGdPTWRMVURp?=
 =?utf-8?Q?R6fkapoUxPRDY2VqzND7NsuxB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a2684f-6105-4315-dfa7-08dcf73b1066
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 10:27:03.3396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsZI6W/KPR2ngOawgqSq05mOLK5Qh+bay0wNPchIbueIZZDnhgQjrK9o9QHK8wzStyUWEpDodfT7lybi1rN0LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
Received-SPF: permerror client-ip=40.107.220.83;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.811, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi there,

Ping? Appreciate any further review comment or series is OK to pull, Please let me know.

Thank you!
Santosh

On 10/9/2024 11:35 AM, Shukla, Santosh wrote:
> 
> Ping?
> Gentle reminder.
> 
> Thanks,
> Santosh
> 
> On 9/27/2024 10:59 PM, Santosh Shukla wrote:
>> Series adds following feature support for emulated amd vIOMMU
>> 1) Pass Through(PT) mode
>> 2) Interrupt Remapping(IR) mode
>>
>> 1) PT mode
>> Introducing the shared 'nodma' memory region that can be aliased
>> by all the devices in the PT mode. Shared memory with aliasing
>> approach will help run VM faster when lot of devices attached to
>> VM.
>>
>> 2) IR mode
>> Shared IR memory region with aliasing approach proposed for the
>> reason mentioned in 1). Also add support to invalidate Interrupt
>> remaping table(IRT).
>>
>> Series based on e10cd93872c31332b002c933a798ab0bc51705a4
>>
>> Testing:
>> 1. nvme/fio testing for VM with > 255 vCPU with xtsup=on and x2apic
>> enabled
>> 2. Windows Server 2022 VM testing for > 255 vCPU.
>>
>> Change History:
>>
>> v3:
>> - Incorporated Alejandro's v2 nits comment.
>>
>> V2:
>> - https://lore.kernel.org/qemu-devel/20240916143116.169693-1-santosh.shukla@amd.com/
>>
>> V1:
>> - https://lore.kernel.org/all/20240904100257.184851-3-santosh.shukla@amd.com/T/
>>
>> Suravee Suthikulpanit (5):
>>   amd_iommu: Rename variable mmio to mr_mmio
>>   amd_iommu: Add support for pass though mode
>>   amd_iommu: Use shared memory region for Interrupt Remapping
>>   amd_iommu: Send notification when invalidate interrupt entry cache
>>   amd_iommu: Check APIC ID > 255 for XTSup
>>
>>  hw/i386/acpi-build.c |  4 +-
>>  hw/i386/amd_iommu.c  | 98 +++++++++++++++++++++++++++++++++++---------
>>  hw/i386/amd_iommu.h  |  5 ++-
>>  3 files changed, 85 insertions(+), 22 deletions(-)
>>

