Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E978C3DA6D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 07:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGv6i-0005Cg-BT; Mon, 19 May 2025 03:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uGv6g-0005CP-Sf
 for qemu-devel@nongnu.org; Mon, 19 May 2025 03:40:18 -0400
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com
 ([40.107.236.56] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uGv6e-00060e-8m
 for qemu-devel@nongnu.org; Mon, 19 May 2025 03:40:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yU9stCbOahvj19xpkkTgnjlZv7TLFy3BHeesk7NERbCYxcLGioJIcaF4ayZZnUDiyzW8fVU5bh98INGF8Gsp0nPaDOZfpbxmL0sRjqIlQetaZXtiWJmJe9PK4NAgMCmQYRdJeJhaLVWmdFGOq6NoF6B0ip+tzFS053UTWL5YAI8a0bkSDTbIi8/R8cMr8kTo3gxK7p9hK1capBWZ1yXjBxCwTU0WGOqhJp1f0cnMC7hbv1T2r3pbELsWBjVwNzbe9N2zAgoNzFXq/48xDlI28tXroHVrLxiyM+jIoUVxVgEJMF44pNoNt+eaT9qghgMxXCzN/n/boMI1tCKbGp1pIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OinjN6TBLg2U0kIj5UOPbh2fAqWRkKs0SWeZ967CftM=;
 b=VxlLTqdoEhgjvQBwv98Pn/fksVVsmbAVa+R0VpOR0NSDNOIjNFqRssoHFr1jRmzElTdMZxL8BLJZr8078bcjkMp5AJBbMuis5DeML04lBXG4SD8WBzz3S1Lg6mAekuxRugsyTplGeeHIqq5E/I0MuwpUbn8TQArs/4vLNd3sQYgZffvZ8VeH7Qd4KA+mU6PBZbgvorFy1cfs/MHft5iEjuxlHhLJy6xwIvs2V9o3o53+pDAzNKX8rjtnxAo1y9uOdieXXwikChVyCiq4HHekDbo91GGbWytrVdnRCXgKCEViVT9w/qEbWjBrZZJ1LYUcLgQY/9zNIjXySOeyKTn50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OinjN6TBLg2U0kIj5UOPbh2fAqWRkKs0SWeZ967CftM=;
 b=qwq8DsPwTCd1Pj8t5zqATheAgFVbTQejg358OttU9iV91WP4ycWyfsELxg1uZrN0rv9YzLirAsHPyGkZXsJh9GGpZVwNZza6wkugWRjRngtRp8BjbLMYfx2/5w+p+M4voxOdetuLcBlmQurgOYCYyQ4ijp2T9oF52N2kuQ/roXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 07:35:09 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8722.027; Mon, 19 May 2025
 07:35:09 +0000
Message-ID: <4613b159-9b72-4686-9cde-ae541ebdc78b@amd.com>
Date: Mon, 19 May 2025 13:05:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] hw/i386/amd_iommu: Fix xtsup when vcpus < 255
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 suravee.suthikulpanit@amd.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20250516100535.4980-1-sarunkod@amd.com>
 <20250516100535.4980-3-sarunkod@amd.com>
 <e10a625b-31d2-4759-b775-9b7d8409de53@linaro.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <e10a625b-31d2-4759-b775-9b7d8409de53@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cef8da-ae1f-4d93-4286-08dd96a7ae78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0QrY04zbzlrZGd2QTZ1Tmo4UE5wWmw3cWdTc09iLzg4ZHF3SFVFVUI2ZHcw?=
 =?utf-8?B?dlhHeVp6Z2JDUUNGREdMV2tjRTdyOXdrdEFZTGdTbCtVemR2UDc5Mk5PTEgx?=
 =?utf-8?B?bDNxWk50UTAwbFE2UVBOQ3lPVVpVUWN5RitLQ0twNFJ4NW9WeHkrOTAzdytL?=
 =?utf-8?B?N1RsZXdqTFdIYzNKeFFXcHVNbWtGKzZKcUVXN0dpZ1lvQUEyZ3ZaN0xKczBr?=
 =?utf-8?B?YnBrMDU1b09YSXBYcXdGN1ZrN29tNU9NU0RhMXUxWVVRRU5UM1I1K21iczNw?=
 =?utf-8?B?REZxWHNBUnh0bDN5djltalVoSXhONWVvcWNJdXl2Qk9WMm5CaTExa1N5ZDlT?=
 =?utf-8?B?WWdqL2RRZ1h1UmJvd0VBdzhXaVBoTE0xUmZTRnlqOHliUmh2ZUp4M2tabVI0?=
 =?utf-8?B?cEtiYUd1R1Jsa0NiTnh1dUwwRG9ocFBTV1ZEK1RSdmR3Qm95WWZXV01OQTJt?=
 =?utf-8?B?QUxWbkJrbUR4QnFQUU9SRE9naE8zSFlYQ1RVVHlCMlBLR3g1ZWlEaW1NekYv?=
 =?utf-8?B?aG02ZjFHZHhOYjFCaVZueUNmWEp3eU5sOUlrcHU5RHFYelJLZmdjYTdncjZt?=
 =?utf-8?B?SjkyUzEvLzIzc3hoOFZyVHhnbllrSmpFZkY4ckhrNk5hdjZyUUwveTBwZ3hR?=
 =?utf-8?B?VndSMVNzSlpSOWQ2bVZEMCtLb3dIT0Q4YlNNQkw3VTkwSzRuQ3N0QzZDd01y?=
 =?utf-8?B?TFJjNUZuOFl6dU9IcVNFdzdiZ2xZWlhUMmsvWEt3VE1zZnNMQmlXcFcxUXli?=
 =?utf-8?B?T1NRK2V4UmlHbGZ0UFZCMWRUMk90a1Q0NkJsQ0tSVmoxKzI3TzdEYnFMcUZo?=
 =?utf-8?B?UU5HcjBXMElaak5ZS0tJTHIrSGZqNU5HUk56SHh4a0FnbnBIMkJpVEsyVFg5?=
 =?utf-8?B?TmJiQVZXRm5XMUt3VmNPUy9TRUdxOG1iT2JyVUc1L3BjZ21KTStsSmVOQnc0?=
 =?utf-8?B?d2ZscVYxSGpONXcvbkdma0g1ZW5XNytoWC80RzcyaW1JaDRaWlZXdFpiZTJt?=
 =?utf-8?B?THVKa1ZxSFVXQ05YYVIrRzRmbDVLa0g5R3RGZEI3bVBJM2l1V1BVL2JzT0h0?=
 =?utf-8?B?ei9aK3RmOGlkMVBmczJkcDZPRTZGeTZROFhxdFNUdExWcXVMRUI4NW9wZUR0?=
 =?utf-8?B?MXpqQUhqN3lQbnp5YmNDcXUwOVZ6a2RNeFR3dkQ3Yjg1VVU5ZmcxamdYbzZB?=
 =?utf-8?B?L1lqSk44UnVaZnVScWFMc3pVN1Jub2pObFVCbytLdmMyL204K3FydDRURnhC?=
 =?utf-8?B?azJFWlpkQzVUL0FKWEhDTmYyNUJYdEdIWFVyVnZDbVFISlZCV0Y4NGJud0h3?=
 =?utf-8?B?VGEwaE01YkRIOHZ5RWphT0lOK2tMWWRGVlJ1alNHOVhQRWcrZENvbUJmNk1o?=
 =?utf-8?B?d3Y1dmpPRXBlVzhzaFhERmpNV3lmdFZHeTRwQlozTkpYNXpOekQxK3ExdC83?=
 =?utf-8?B?a2UrSTIxYUlDUkZKRkl4S3NlUWJZK2FoM1hCakNkbmg3aHdWTDd0ckVHZ0RK?=
 =?utf-8?B?QmgraG9UOTJ3STdBUDcxYUZwK0loSmo2bURYalMzV25UWC93T282VkpRaXZs?=
 =?utf-8?B?eTlCcFZEMkQycUU5YmN2bEJ6eEx4Rm1LcHpTamV6eEZkaWtaRDVRa2x4a2JR?=
 =?utf-8?B?cE5TTFkzQ2I2RzlkTUl2MDJQQm02R29kZ3BSMFZ3d1J4K1FvSGNDanA2Ukc4?=
 =?utf-8?B?eDQvZVZ3cVFxUVlRWXR4WmdFRFFWWFdGR3g4ZGRERllqSHJZYzBaelBYR28x?=
 =?utf-8?B?T2w5bDBiVHI2QjJGU29Oeit1R2pZUHQ4WHV5YXlRaFFxQmdhd0ZMNWRwNmlU?=
 =?utf-8?B?OEEydjY4Q1FNTWhONjVJK01GMXZnamxsbVdjdXBxaHJMcko5Z1lOZVBibDgw?=
 =?utf-8?B?U1hLaWZMb3dBSCtYVXhteEhiekRoNlJ4UmF3YUZpREJVUUVRZENjOHZQWTF3?=
 =?utf-8?Q?GoRLxnUhILw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2laR1NZakJCSytIdEpPOFFZVlA0NjlPVEduM1JFM3AwZjJBaGZ4V1JXSEdx?=
 =?utf-8?B?cUdneEN3cUowenRmNnp6aTFmVmtjQWdsR1lvTm9mVEZWcW00UEphMW0wcTMy?=
 =?utf-8?B?STN1NWoxcWhUQjFzOGRtdHV1OGJuQnJxYjR2bGVRa0FieFBPRUtOeWNIWXdT?=
 =?utf-8?B?QkRRalEwSndibXFqWXUzQnpEZDV5K0xNc09STFZMV21DK3N4TTI4UnpSYmQr?=
 =?utf-8?B?SXEzOHhyZVR5OVhhd3hvMkI2bDU3d0ZnZDhGem9yNjUvczRYOXIxcTBZN1U2?=
 =?utf-8?B?bW5hQ1dPNmRtMktidjZBbUh2WUVqbnhzVEFZeEMvdDdmb1BHVklqUXFpUkpw?=
 =?utf-8?B?aTBKenEwSy8yOHUyZUQvTmYxT094NTdYVGlTajFvTysxZytuSFZXZ2NlUnky?=
 =?utf-8?B?UTRpSGVCUCtKTnFGZWFUcE50Vlo2Skc0ZmdzNlVKL05rL1hsdXplZ1BOanJw?=
 =?utf-8?B?OWExY2didmdtMGR3K3NMMHVoYVVqMGFXd3ZpcERmRGxocGJta2VZMW9YcEc5?=
 =?utf-8?B?d004eEZwYjBYYjVOQ3NSR0RuUTdBVm0va1dZaEIvS1dtb1lFUjlLbUpkaXpU?=
 =?utf-8?B?dy9MZjByaEpLTGk0RlN0NmlQOVpBTGlQUVkrdG5qM2xxM2l0QlNpQmQvMUtr?=
 =?utf-8?B?NFdmaXdmeW9aSEs1dkg5aHRHYWxiYS9ZUXdRRjc2QlFmOXlQYTlUNDF1dVk5?=
 =?utf-8?B?L1F6ZGN3YWg4MkpHeXBxb1I4ZWk5MklLSCt4SjVSU0Fac0dGQXNNM0lQY0tI?=
 =?utf-8?B?d0xJRjdKUkd2NldlZ09DUUR0WG1DY2F5SG43blUwUGJxb1JmU29iOW0veFVj?=
 =?utf-8?B?dkEvU0pyR0hCRlcyVTUwZlJjZmEvSi9hZkZHRno5WnBSM1BPZFRPMm14R0tR?=
 =?utf-8?B?TWgvQWtjcUJrL3FYeXlrYnBLTGx2RGRJc0hEMVIxOC93NXZEM3dZTXVNREtU?=
 =?utf-8?B?QVZkY29EcnBUb2FrdWhod3RGaTN2dytZdURQR2xXcFkwcGIvekpMelZ3Y3V1?=
 =?utf-8?B?TDluZC9zRnkwYXpQRjJLQ0FRR29CNjNPNXEzT0dSWmdhNStKSjhHdklKNlFh?=
 =?utf-8?B?RlBod0Vxa3lROG00UTZaZmpuYnVXeW42WnJ5d253T2taTDZ0WFJmZkJwSm5B?=
 =?utf-8?B?UG4yZk1jUXZpMDdRbjZQdDIxTHlyQ3ZyT0pid1poeXA2UUNmaCtsUW1SZVMv?=
 =?utf-8?B?dWk3VnJ4NWtYMVNHV1g3Y3JJczZRYTdPck5BalFtd0RHaVU3WEkyZ202dzc0?=
 =?utf-8?B?TmFTSEk1MkpRZFVEYkZUQk5oU29IQ1FTS2g5Y0E4cUJIc28zcEYrS3Zuc3ll?=
 =?utf-8?B?aGNERnpOVTREOEdrcE5Fei9tQ0I1RTRNVnNkVUZheHpXNStqSWRvZmdTOFJo?=
 =?utf-8?B?clY1Q2tEUkpJa1o3Y21QMG1kVkpRclZmV25xTjZXcTRKNVN4MFB6S2FoMVVw?=
 =?utf-8?B?S0xWNHkzK3RnRFhKSlZvcjllTGhyY0UvYXhGOGhrWk1jRm00RnAwTlNsYy8v?=
 =?utf-8?B?Y0xzbC94c1VYd3BqdXlXZDJkL2F2R0hKeEl6U3g5UjdVVkJ4cGkvUXNEdmNO?=
 =?utf-8?B?S3NoNGNIQ3Uvd0QyYVg1SlBDUU55UnVlUitjRlBUM2FuM1BQR3B2dHVISVJw?=
 =?utf-8?B?SERER0U4YmRTWEtwTzQ0aVc2Wnhxc01ac3YxK0lNajlyYlFIS011RG1lMHdS?=
 =?utf-8?B?RlBIY1MwbGhldDF0L0pKTElGUm9MazE0bHN3WlFtUzNDNWxMRGg0czBjN0Yv?=
 =?utf-8?B?LzdGOUoxMFJ4MnhZTVdPYjdiemtQYVBac0QzbkFIUlVDL1JDVUF3eDR2b3Bj?=
 =?utf-8?B?K05iQkRGaDBodCtRMEdzeHU4NzRGUDg5dnl4WWNGc3JoRkErZ2xnL1dCYnNE?=
 =?utf-8?B?SkdQenRtUEQzUHVyZkxpdS9aUGFVOGI1ZzlaK0wrdDNwMzZka0ZzaDJ1Q0Z0?=
 =?utf-8?B?K05SVVZxQldQZExWVEJ6M1VQVWhKNnc3VXJkRUNjZGpvRHBRbW0ydHNiVzJU?=
 =?utf-8?B?VUZVWkJDYTJFdTRNbmZJNXhKdjVmOTN1VGVKT3NCaVh1WHZZS3ovSVpiWDdY?=
 =?utf-8?B?VHlPcTlJVmYzTnZSL3labVlWZFI4UGQvNy9WMm5rUnM2UVJ0NnByM2dPSjd3?=
 =?utf-8?Q?h/4kNZPRphx5vzdxj5ESHABrd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cef8da-ae1f-4d93-4286-08dd96a7ae78
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 07:35:09.2502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fP5Wv4MDSI15/IXiH8z9egHLaZKc4vHaFtsHMXjkDR4M9nDC4tU9lTqWU7buZDGbzvMkSiDDbjj5bqSXBxkCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505
Received-SPF: permerror client-ip=40.107.236.56;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

Hi Philippe,


On 5/16/2025 8:08 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 16/5/25 12:05, Sairaj Kodilkar wrote:
>> From: Vasant Hegde <vasant.hegde@amd.com>
>>
>> If vCPUs > 255 then x86 common code (x86_cpus_init()) call kvm_enable_x2apic().
>> But if vCPUs <= 255 then the common code won't calls kvm_enable_x2apic().
>>
>> This is because commit 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM
>> checks on XTSup feature") removed the call to kvm_enable_x2apic when xtsup
>> is "on", which break things when guest is booted with x2apic mode and
>> there are <= 255 vCPUs.
>>
>> Fix this by adding back kvm_enable_x2apic() call when xtsup=on.
>>
>> Fixes: 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM checks on XTSup
>> feature")
>> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> Tested-by: Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Cc: Joao Martins <joao.m.martins@oracle.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index df8ba5d39ada..af85706b8a0d 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -1649,6 +1649,14 @@ static void amdvi_sysbus_realize(DeviceState *dev,
>> Error **errp)
>>           exit(EXIT_FAILURE);
>>       }
>>   +    if (s->xtsup) {
> 
> I suppose we need:
> 
>        if (s->xtsup && kvm_enabled()) {
> 
> otherwise that will trigger back the problem I tried to fix.
> Did you try building QEMU with KVM disabled?

My understanding is if KVM is disabled then kvm_irqchip_is_split() will return
false and we exit on below condition check.

Yes. I had tried `configure --disable-kvm` and it was built fine.

-Vasant

> 
>> +        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
>> +            error_report("AMD IOMMU xtsup=on requires x2APIC support on "
>> +                          "the KVM side");
>> +            exit(EXIT_FAILURE);
>> +        }
>> +    }
>> +
>>       pci_setup_iommu(bus, &amdvi_iommu_ops, s);
>>       amdvi_init(s);
>>   }
> 


