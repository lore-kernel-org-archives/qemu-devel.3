Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C0CC61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 07:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPbuc-0007K5-PC; Thu, 12 Jun 2025 02:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uPbua-0007Jm-Nv
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 02:59:44 -0400
Received: from mail-mw2nam12on2049.outbound.protection.outlook.com
 ([40.107.244.49] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uPbuY-0001mX-BM
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 02:59:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2fPkeljQ5ELBEt94MNsVd9bd4QiO7RwKHUjYlNwFEsRI11a5PUKts/dTB1u0Gn2YumXXX4sPYPXlxgLVqRGDLGpPabZ2FRef2Tf7PRbjWZZefDAfMtqZG0s5rMgzDb75SmyYBv+aRB1K4jYccdl3j7yptwM84Oz9kwLqOq1y09PmLwEsZr3ByNKqB75RWRIxyEYXYnCv237AXBeua/eb0PoAa0rtqpsthAI9vWOJjEtX/OaoAiSYsgnAH4pswazMR1bEhRSb2OtkOE7qc56qjxG03MS8Al3R4mJ9VsRG+DY/UEUU8BEi323S7XFnfPgPr5cSoZJoumkbUrT7qnkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nl9c2Yick1wCW9YtYVEozSWjPUHY541cOvvUDKUr3Uw=;
 b=Rp7qlQ7unHzs3aGTDwERVqC0xYIfwfpYZMQRKGXtZRT+a1Py0nFReWrO1wTnOLJwtfgpsKirpuKn/gaIPGn9eNwAwPtQ5WrLJJuLoCoNGOhI9YYcrm/5+kfunSQgZwTCvS3lxz+6GYEHm7/6dvwlPOHtYsetTHNQ+tMfR/X4IDSmd9SiUOo9VJUl2byzYtCfJsvvlcDbo3VgtxuBzaDlnAwVsanpMYXk3lhc6xoBkuNzDoURKu9+1BFwvi0Phk4PbP8KVdo4Z8SWdfAlCyfH6QiKQl5BacLYfw/d9o2nRgVvxpRgX+XfUlt/rx39ZZiu6RyRNMxg82jKdkcu4hw+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nl9c2Yick1wCW9YtYVEozSWjPUHY541cOvvUDKUr3Uw=;
 b=r6EKSqtYbZg2aMgNKeuNFmpmylQybbZ3bkXGfkb3Ff12AloN/Xt/02wexh8fcGieTea0m0Q+7kSuu3OUxmyZXU2K087LI3v876okViIXXscQdraYFx4yOfCkBGIZz4AMIza5W5v9rnlWabn2nnLP/a1HrrTgKQ21DhobKeQCkuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB6117.namprd12.prod.outlook.com (2603:10b6:8:9b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.37; Thu, 12 Jun 2025 06:54:36 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 06:54:36 +0000
Message-ID: <883bdbc2-e6bc-4bfc-9dbf-effcce6197a0@amd.com>
Date: Thu, 12 Jun 2025 12:24:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/20] memory: Adjust event ranges to fit within
 notifier boundaries
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com, sarunkod@amd.com,
 Wei.Huang2@amd.com, clement.mathieu--drif@eviden.com,
 ethan.milon@eviden.com, joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-2-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250502021605.1795985-2-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0234.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: 28210f33-5b3a-46ca-b8d4-08dda97dfe1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEduMGdDSEV4SUVwWEk3aXZ6eTlFNnV3SEVxaVNLeVFaZE5uZFF4N2dFMnBJ?=
 =?utf-8?B?S29zOU9Hdmt3MUZpU00zc1pkUjJLc3BIa3U1a0t0cXhUeDVtWE50UFVJajhN?=
 =?utf-8?B?T0ZGQUh0ZFpKb3poWWpXZUNlQnVXU1Bna1U2VlVtY1A0NHZHQnhZRFd3VnIx?=
 =?utf-8?B?dW9DSmZWazhVUU1abFE0WGN6MnI4U3BNT1BsTjFSSHgzcDdmZ0ZZdWVmUmVP?=
 =?utf-8?B?djF5SUhmUlpDZFlUZHl4dUtVSVJoM1JEOVk2VE9PaE1zQmNGbUtPeVBKY285?=
 =?utf-8?B?MVB1c2g1QmhEaEFGK080OHQ5N2I0RVNTNHRseno4NVJuN3B4RUV5YlBST2Fk?=
 =?utf-8?B?Vm0waG01TnV3WXJWK3JXQ3I1d011WjNzdWl4emtLbEVKeTJzR3J0RUZOSHIz?=
 =?utf-8?B?QnJ0M1dYazNNWnEzOXRvQVM5blRmWEZsT0xOc3lTMHFNWjdQTnRYU2RVY2tK?=
 =?utf-8?B?cjJ5QU1mSHRpNy94L1ZWVWNhYTU2MU5ONi8xeUxHd1RSUG9XZ3hhVnVCV3lT?=
 =?utf-8?B?czdpOUUvajEreGV1Z0FKbnZieVo3YjVack41UzJBMTA4clN1Q3A5N0Fjbnoz?=
 =?utf-8?B?UjNITS9ndks0UlJRSHcreDViRk11MEwzcE5teDE3Y1AwdlNWSmNSSXhxc3hh?=
 =?utf-8?B?SkNpRFNYalBSU0JVdU83TmRvc3RVNGpQS2NOcmVGeXEwLytPR2ltODZEdGhk?=
 =?utf-8?B?SHcrWk15c2hrUjQwOWsxaEM2Y1hobzE0ZEpJYmxLUU1OclQ4bnpLMjJKOXNJ?=
 =?utf-8?B?cTRLcWJic1lqMXRNTkxmeFVIdm1sQkh0ZVF2Y3B1dmhoaTRmMFFycVlpTXlE?=
 =?utf-8?B?NHA5bTdjbVVUY1h4OGpYVXJWSEtPUC9vRnFSblBTdGhHYmtlUlFwcWErQ2l0?=
 =?utf-8?B?bEt6d09ObDZnYW91RUJaTTNoQU5Vd0tVWU5ZQ25zbUdjUlFHczZ1SkNFcVFI?=
 =?utf-8?B?SWM3Q3dWekRKdDRPRFRZOWZEdFNHQXR0NmVBUUtjSVNrV0wwNVZWMStoOE5V?=
 =?utf-8?B?cTdLNXVyVDhNeVNuc0hWaEdwVkE2bWdhOExrb05HMFlVSysrREt3NW1mMHp4?=
 =?utf-8?B?TlQrN3NPMEM4a05HNW9FYmV2YzNNQzhTbitTem9nZDgwMWRtTTBWUlhNcTdJ?=
 =?utf-8?B?cXJpMTlhSjE4TU9Zb29RdEJXNCtjQW92LzFib3RralpLZGhhOTBtdlZnaEdl?=
 =?utf-8?B?d2t6YW1lZHhHV1BaT0FwenlsNk9KWVc1SVkvNWRWTHdkcEpHQ3VLRENSdXdD?=
 =?utf-8?B?ekFvSDVLVk9wRnIyNjVEZWhySm5lYTdVTFlXbm9ITVd2czRiUGNkdkU4Y2J5?=
 =?utf-8?B?dUtmckswNDJWbmJGUlgyR0hhYTRCL2ltU2dKVW1NN2xybUhRNk1hY2JJdHVq?=
 =?utf-8?B?anNMN2dtVlRHdFVnYXg3aUNWcDdZTjZ0NEozZmg3WUx4WmVqc1dSdEptS3gz?=
 =?utf-8?B?RFNwb0FNNkxnQTZ2U2lHZndlWjdsdXdsQjhDcnRqTFQxSHFDcEo4b2pwS3Nj?=
 =?utf-8?B?UklSZmpZQkt2VndjVys2Z0h0U1FPeDF6N3RGV3Vva1U1MlBMajlWQ1RsblZo?=
 =?utf-8?B?QVpqelUyUVdJWEVWdzREU2xhaFZGYmYrZ29vZFhjMUlTRDY3R2NmS1RocllJ?=
 =?utf-8?B?em90WXdvcHlkc1Irbit2YktmUkJGT2JFSVpob3phdFNUOWdEM0F4dFVPQXNV?=
 =?utf-8?B?cFY5K25QcGs4ZW85TjRSbEZVS1ZtU1VuUXlRQUxHMnVqbXBEcW9lWVkrUzRI?=
 =?utf-8?B?dmxmL2M0OTNzKzdYcGoxdDlzczJKclR3WmJWQ3pOWjl0ZzZrcE9RSzVtMEx1?=
 =?utf-8?B?TmJBL1VXRm9NZVgzYTg1bVRZV08rVzg1RTJjRGJBaXpKcndqS0RvT1lKSkt0?=
 =?utf-8?B?aFBTRDlUWlUxeTRTbzRtOG5scVIrSlE0U0tpNno2UThHREFoL0c5VlpJOWxQ?=
 =?utf-8?Q?UIQlOkarI78=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDdSeUVMMnlpeDVPTXlJcENuVTRwTHdETmMxWHVtNmZlZ0VoSGNzeWc2ZDVR?=
 =?utf-8?B?bGJZSW9PZURraHhmZ3gvVFR5cFljUzc4dGJFTXZoVWxvVmFqUitrSGpERTJr?=
 =?utf-8?B?V1VUMTdEVllWVDAxVXRQS01GeGQ3VThmVzJGTU5rSTJEd005U2hKSkVBVzJr?=
 =?utf-8?B?d2tQclFzbXVSenp1cXR6OEJoUlNQdVg2WW14K2VPUXVOSWt4SU1TT2YrUlpQ?=
 =?utf-8?B?YWVJQ1lRVWZ5Z2N1REdqM2V1NU5CV2dqZ25tUS9SYUNtZVNyZStYZjdTZ2V3?=
 =?utf-8?B?eUxqWExPYW1LaGl1dStjM0JDU2VZTjVUc2pvZkNMUnJUWkpPdmczeTczMXlj?=
 =?utf-8?B?eFV2eEI2R1o1bm9sWmU2SDdpM09XNlBvL1huV0Yva29ueWUwMVMzcTIxenhU?=
 =?utf-8?B?REM3RzhjYjFXWk1iWHYzMXdCb21MVis0eXdOK1U1NXc0ZkNmZHJ3RFdBT2h3?=
 =?utf-8?B?UUVmSTBmTERqdGlpcWZvU0h4TlNiQyt0ZzBPenJxRThkQ3pHa0RkUm0zYVox?=
 =?utf-8?B?Mkh1QzFBOGVtZkptVk9iSkpDWW9relFMS1VpQ3lPYkNrNkIybm54L1g1bkJw?=
 =?utf-8?B?MCtUV0JHaG5nOTJod2lLWTZuam1BNUdQMTlTcEh3Q0xvT1VBWGR3SU9XaDV5?=
 =?utf-8?B?VUYrUkxPYnJsekJsVzl2YUZlcTNFMlVQdlJaaHl6SnRQM3ZFZTBydFVRdUNv?=
 =?utf-8?B?ZVI0T29RMllZMTlKTEFtRWV5V295YmRTRThqVnNQYXNER2lZNkpKM3RmeEYw?=
 =?utf-8?B?azNzQWFUbGdSbitUYjFpd2tSY1JkVmlHb1hZMlAweUtoNW9aeklKdmZOc2xR?=
 =?utf-8?B?eWpPS0NJbGt2dmZ4a0FFdGc0NE40QXBMZWg5SkYyRzJ0UElHNi9qeTNUNjJM?=
 =?utf-8?B?UHhuUFFTKzhrOWV3ME9PVHNRYUlrZG1iZFA3VW5NOERlRUk3clBnTHhHdE1O?=
 =?utf-8?B?SlBCaUUxMzlZUVhHdDdHVFpVMGJodVJPWjRsbjBwUUx2UFd5eTc5R0ZwRnoy?=
 =?utf-8?B?WW9BK1V4Vm9lRFUxZlh3aDFxL3BjM2p3cUdiY3pwVlRFdU03algxaTBXb0R6?=
 =?utf-8?B?VlE5WWFNemJ6MW1ER2wxbVRyWkpVZzVFdDdPQXg2dU8xT2xNOHdCK3dRTjNE?=
 =?utf-8?B?OUc2TkQyUjc0c1NNeGlLMUovRlFOdWtldnI5Z0xYMHV0OWoxck9zN1BKU3I2?=
 =?utf-8?B?M1FZa3U5WXBYSHdXaFRKOFV1eGFpM0FGdXA4eXEweEtXcDMvOWpFY2F4ZURs?=
 =?utf-8?B?Y1JncE01QUluZjFYcXgrdisxN0RFOVllZjN5eGpQT3prRkxkMUpMWG0zZnZL?=
 =?utf-8?B?cE9wZXdvTGJrNTB4SnZQejZ6UjErNnZlWmd1ek5jaWpVajUwWjFVd3B4QXBH?=
 =?utf-8?B?c242bGpETHdMRGIzUUtLdkJiN3FFNGtnSVR6R0g0TDQ4dHNHQjNubHpDRk9F?=
 =?utf-8?B?M1RGSlBZaTNnNGRKUEwzMHhuTUNESkhUSC9vRGxlaEZlcml4YWFZUEJac3NU?=
 =?utf-8?B?NFgrVUZJZWI1MDJoLzJpSTA3UVg5UHp6UHBlU3psZjJiS3B4b0lqcmVEVFBj?=
 =?utf-8?B?OWNvUGpCV2IxNUFDK2w3SVMzdDVIK1Bac0I2QVdSWFdVa1k3Sm1kVVRkclZO?=
 =?utf-8?B?STNtZjFHWVdJa3BJRDBKOWt4a3lyZUlKdnlKQnNFSEdReklxLzl4SUlEVEcy?=
 =?utf-8?B?QTYzaE1EK3ppa0VvSy92aVBMK0tqVDVlZjFzeWJsbTNLZ0NyZC9KTDAvUmor?=
 =?utf-8?B?K0wzSGxKSEFFWWhqbVA5MC9yVFIzSjZ3UituYnBHQ0hkZ3QyTWh3NkRPV0ZC?=
 =?utf-8?B?Y2tiOTI4R3Z2VTRYY3JqWURmdlVyM3RMVGsyQlpGcTkzQ0RwMXJ3VS9zR0VI?=
 =?utf-8?B?Sk1vR0VIcG5aczhVMFpQcVgvcDhVRlh2STltUjY3SjlCMlU5UDBXMmVhdjcy?=
 =?utf-8?B?RWJTWjlnNEFPKzZUaCtLSnc2cDlwMFhKdzFwMnJ4aS9tcDFGZUlNamQxcXA0?=
 =?utf-8?B?cTliZ3Nvam9uUU9GNXRMaGtRTmd1K3Jabys3MjFXaUxYdGR6dUk3SHByK2hH?=
 =?utf-8?B?RVE1dk9WWmVySVJ6ekVGRHRHZzFZaC93Nmx6WFZDaHNmZUh6eGVxTmhNWUJO?=
 =?utf-8?Q?BUouHQGWYoUAsBZkPlSlLbITm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28210f33-5b3a-46ca-b8d4-08dda97dfe1f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 06:54:36.0707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3prUYTWckBOu84GujcbubOp2aLWYVbTzeOnUmu1ZqY18eePSZSw0sspigo9cIsTEYSxvMZg+v+6wSX6ylh0kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
Received-SPF: permerror client-ip=40.107.244.49;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Alejandro,


On 5/2/2025 7:45 AM, Alejandro Jimenez wrote:
> Invalidating the entire address space (i.e. range of [0, ~0ULL]) is a
> valid and required operation by vIOMMU implementations. However, such
> invalidations currently trigger an assertion unless they originate from
> device IOTLB invalidations.
> 
> Although in recent Linux guests this case is not exercised by the VTD
> implementation due to various optimizations, the assertion will be hit
> by upcoming AMD vIOMMU changes to support DMA address translation. More
> specifically, when running a Linux guest with VFIO passthrough device,
> and a kernel that does not contain commmit 3f2571fed2fa ("iommu/amd:
> Remove redundant domain flush from attach_device()").

FYI. Its easy to send invalidate all without above commit (as it does it in
every attach), there are other paths where kernel will still send invalidate
all.. Like detaching/attaching device, etc.


-Vasant



> 
> Remove the assertion altogether and adjust the range to ensure it does
> not cross notifier boundaries.
> 
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>  system/memory.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 71434e7ad02c..7ad2fc098341 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2021,13 +2021,9 @@ void memory_region_notify_iommu_one(IOMMUNotifier *notifier,
>          return;
>      }
>  
> -    if (notifier->notifier_flags & IOMMU_NOTIFIER_DEVIOTLB_UNMAP) {
> -        /* Crop (iova, addr_mask) to range */
> -        tmp.iova = MAX(tmp.iova, notifier->start);
> -        tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
> -    } else {
> -        assert(entry->iova >= notifier->start && entry_end <= notifier->end);
> -    }
> +    /* Crop (iova, addr_mask) to range */
> +    tmp.iova = MAX(tmp.iova, notifier->start);
> +    tmp.addr_mask = MIN(entry_end, notifier->end) - tmp.iova;
>  
>      if (event->type & notifier->notifier_flags) {
>          notifier->notify(notifier, &tmp);


