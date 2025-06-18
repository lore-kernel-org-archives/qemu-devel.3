Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC0FC7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRqym-0001J7-JR; Wed, 18 Jun 2025 07:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyl-0001Iw-0p
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:29:19 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyj-0002Yl-Cj
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:29:18 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I7qwBV012989;
 Wed, 18 Jun 2025 04:29:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YXgNAcT65xEeiKBmtNJjdXPE3i48Zr8lTpDcjhf1e
 nk=; b=BEbVEROKRTJuiAH1YDe9Sa54WrYm/ht0WSLeaJ2Hl8t3yA9QB4ij6NnnI
 rP4hlQIoEJ4ra0e26RuJmtly2l3rfFG/gEH7b8pg8NZQsVCIWd50Vby99/FmZvbS
 IDKbUPH305Y/rALI0g+PNryBueS7DWV6ZnYJbGes3682/kpCjFlrpkQh3gdWQsac
 x42GB9+LmA1KgQe7aCIOUAevPKOG3iDtv1gYHPnNTimax7YgdVMJDeyULBgpUOJ8
 Q1gy4iSi6tYI/DrLmCYFTSSgX9kMoOwNo60hK7c3i/ERbryYmKvETcptVZB1bwIF
 OsMxsqhTd8I//EmqqvkEeKtpQtXDA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2132.outbound.protection.outlook.com [40.107.94.132])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4798mygsuq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 04:29:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5Qhd+MBZpYTPMlpYcTrKV6zaDfvWitt/F5QtJRxhPUdN3SIGF+d36i5Ue4kgzMZ+EdnKUjacrI8ylK1BI+k8RO8KjkmrO5OeHo1GOIoQOOqyR68dKfl7gMW658igm/3T/Z9UvNdeLLfhbEGfweIXOXoc8tyNj9SCVxrImc6K0d1C1AhInRVSNWayEg7LWlnOd6afCoBQws2nwd2kZBIZAee4PUwJ7XxoZZGKVCx9dLf312h1ObHypBcxnnjcUo/c9MtJ1dxIMZvqwPPLSWAEAVPiLSax4lyA8U0srft6YB7lMcVpSJCOEpS+rpzp+1YDptgyaDrAeYkReXs2ysp3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXgNAcT65xEeiKBmtNJjdXPE3i48Zr8lTpDcjhf1enk=;
 b=okp8gVVy1+p7iBxke9nYgKFmNMsYFSbqJ8BrIKD69eb8VAbROJIUReoSSi5lrDCzcy2FodjkjacZ6sbtc63TwNmQjlP8iUu4U0aUr6qLJqbap4HaV8P94uZ0V6mbpg/Oe23YyIfAE6WZFsIecte2i1M7iZfvaOmuDINXDLrC74I38OxDaO2VeoqszIX2EO9+9MYN43hQm5rRgPlqDyZMWuv7fP7+/TDpdk3ysT/ZdfCdAxzRxn0Wf2z1BLCfnkkZaaTBCF6K4U0oJZ6tEPEZnfKS1drds2EEemvr3n46W64gabKbIr7ef1/zTJ9KqEXeaOActPR/33kobYfAO1P1cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXgNAcT65xEeiKBmtNJjdXPE3i48Zr8lTpDcjhf1enk=;
 b=pkOvqQnhra70Wo5cL0ojevY8tIiFiwQdl198bwG3ZEfCvbX9zSXVQS9xd/VECX1Ssmu2LBpsm/r39OOvtoYoVjwyloQjWjqh9w63bOe0H2i5OyFrcatKQNRdCeC+PHAPaHpTi3NsgyGHOjRLkzNWPWfm6Y1SYxrFghJ9UYfTjS5GBjOnVWCCC1EeavBD+D5ys7JPZJFs+wGxcrXuCQqmiEC09Iobx9iaiO9X2HIZLkZLbwHkmX+D1CQ3cvSMCK59cvJBvZYI26nNMsA0egi6Ty7d0zLd+zHzrCwyPq4fW5yJjpDPpzq2SHCcKUxPIkFswVHH/SLZVna3ATkeznODow==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7295.namprd02.prod.outlook.com (2603:10b6:a03:292::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 11:29:12 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:29:12 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 11/12] hw/i386/pc_piix.c: hardcode pcms->pci_bus to NULL in
 pc_init_isa()
Date: Wed, 18 Jun 2025 12:27:16 +0100
Message-ID: <20250618112828.235087-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618112828.235087-1-mark.caveayland@nutanix.com>
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0043.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::14) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cd99dfc-7323-4a86-1564-08ddae5b59a6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oCyAAH/aWDWgpkDb7mwHcLl/Tmesvw5tx8Zi1JpMz3PICYgyuX2OHlVCTzOk?=
 =?us-ascii?Q?P9oKRRs5Fg9dQ+1yV+eMmHrneRRz12zgZDc5d40zdeR1xflSohfbHEqY6SRQ?=
 =?us-ascii?Q?Jh9bPybqq8xBBEXRTuOsbJiDlZPIcSSSEl0E3cLtlk8VyQuxWo05r4HuINfa?=
 =?us-ascii?Q?yQxBC8+t9b2pzS9AhzyQAR3tlrbC1tBH8EIR4c7RJEe5EufWURWQjIryC4Zd?=
 =?us-ascii?Q?i/HiJ1/IiEKXG+8IzbMzWryP8xyMVnfAYG8Rks6KqJ+lL09GxWRm2XZSLvDE?=
 =?us-ascii?Q?01OJREKoHkvrG80QR6XHE8LbkmKFPNrYW6dQxcHTpCsXh6i/yUFgS5Q2twQC?=
 =?us-ascii?Q?TowM6Ph4gNNZ2oVkf/7MkdJ+OVworH8/6LOJYzVhjoWYwH9ogAEVKKWusWRB?=
 =?us-ascii?Q?0SkS5tZQ83Jpde8QA/atEz9FS4E5zu8NSSJlBERC/ZQOw3ALoPzq3gHQh0wq?=
 =?us-ascii?Q?1rroUs/XvHFbYBDrUcK3gQMci5eAT1mWLJrf1SDH+6cmoJe3KUtDpYTfhUQk?=
 =?us-ascii?Q?bWhzaFGm0ASv3FUYagl+hwTDqmkP5wYUIPvSc9ICW4bkG3u5hsOm+mrrTmBk?=
 =?us-ascii?Q?cGd084p1VeuFxKEdYIEseR39Vpp8jV/NMo/CxNyZMXyIvd0tri/Au3H4JhAr?=
 =?us-ascii?Q?Mz2VfOn0pK1dx7oimRl37O00zJHhmwBMYx1rtFVN8G+onAxUPsWSMlyhsasH?=
 =?us-ascii?Q?ODb/BDC7zEwSkKtqHPx+Iz1pylsdB2cEuBsA5SGyw/4pTg7CARWbCKLyu0+f?=
 =?us-ascii?Q?YQQtHVi1Vf64fhaoejWhEn7BNoGZXM69iEAdVFdLgjpx0cBziqaisdn03OPJ?=
 =?us-ascii?Q?P3U9We5eFneJZF6z7M6kc6hoCDknPqS6fMpU/Kf5hNeoWdci/xzxEgUUyupe?=
 =?us-ascii?Q?+edGZfyAOAprY3P761QBCECLm1+VuYmFHxKnNBer5pzZnx+DSUKsMTdCz74t?=
 =?us-ascii?Q?nljwFXO+429+9O4DwdHXHE5QkY/TLeD7C/mVeYXrLVeeW4cdMHxpO9mxQIm8?=
 =?us-ascii?Q?A78zIIUnFyfxJwloq9zpnOTK6dDvqPJNCVjbf4nKpaH/w+AS2Czs6iu4YVH9?=
 =?us-ascii?Q?yUPUdfy151YLXGxDuaWwE+l208ORUkm4noBW0x+RSGLARW7p+XZWMcSLB64Z?=
 =?us-ascii?Q?zVZLhToIlWVNeiZDSfSWLzkIm6vo6gTkEg9vq8Fz6PgxNSBy8YWfZIaLm8E0?=
 =?us-ascii?Q?mmrGsQBFfOwkQxEF7wGmzbbXjKAzDhYiRdwwW0j+X3jBxG3g3JLLjmK/47rV?=
 =?us-ascii?Q?NrRzR4hTAwnpshwqjFrZaC4ASLQ541vR/BfHcuQmdgiWEOp/e5h96hb5GTMH?=
 =?us-ascii?Q?H5NvAhOmIiHXRoMx+TGFsQWuUUqVJFaPmlF1L7f6+KhM9+RuVh+qq+0dTwIG?=
 =?us-ascii?Q?0r/5k1RG95zhsk82AJgw5OOl5qJ0mTcvr3snrR3toDBNe6e0h5sQUjM/tfP4?=
 =?us-ascii?Q?SUS59F2NyH4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0d17yyvD12UdmFuYP7s3Hh18DAIU/NvT89yoQkzZWjkGgzhXKsXJn9BFsEwO?=
 =?us-ascii?Q?SHttxb+PrBjNu/tC5MBsF6ifpUi390iHbkbwODHyYXHmBjEsQLsdhTXHrkjp?=
 =?us-ascii?Q?oAu4pywzytZlsuy1tw+XYQE51OCZy+QnsvKsMVZRhBo3PZ7633wpDADSHoXl?=
 =?us-ascii?Q?wowZaOG8PhlVHKVp1RQdDpgNL2G7nloOb/j/xzZveaPLxaF1JEoyeiBZWR0z?=
 =?us-ascii?Q?VvhKDxEeMfoUJpin5LFJZ8a1+F7OZRbFXu2NTT+c38XaPtkHc5vIpCPiNwdb?=
 =?us-ascii?Q?FQsB8NYxHFGQBIPdWrha7nkuEJRz+NiocKlHpnZqlH4EaTVsFQPcJaVzOEEf?=
 =?us-ascii?Q?bEqWuyUS4Ce8XAf+zpX2x65MoQtBzpTHgScdr7EFf1DOGTRs1FiQeMx9gRG+?=
 =?us-ascii?Q?j+rEgxxF/e9qksOfRq+dySxJx3nVdJmNikgN5GWfh0+D1Vh5Zp8+/0NxTqHn?=
 =?us-ascii?Q?hTrZb5gTTPO7yqrSnLAzej/v+aZyhRMjRfjWmwNp95reRJa/8mJeQJFHA868?=
 =?us-ascii?Q?Uekcb9VbbWfkvGFvBFRiXpqP0EcvGdTuLSPif8pFb5SalCacTpak1hKsBNhm?=
 =?us-ascii?Q?s3LEaUlJ3uKPKi/mVgdlpfGUES4a009VoKMcLkQlW9Ted/NeDEVQXxN3a/X0?=
 =?us-ascii?Q?CCH2OLXfHnZGJdEcGjioxmGPwAuIwaQWAv+DXWaSNkpa1RW/iK4/cxgEDRqq?=
 =?us-ascii?Q?2sXIseloYHBANsFQqaj7MXv05VcYTvmoUjL3eMEMrF9wkSsWVUP8twCJxaS4?=
 =?us-ascii?Q?KYqrJp3s8KRPkSIJYyucoDzH6QMBxUSILYTyJljg+x43pa10QholGUeksSPf?=
 =?us-ascii?Q?PDvzf3p33Ah/G/6DHV+hs638T92/f+4MCCUSfPu+nkH7/zEWWwJZyN8JqOCd?=
 =?us-ascii?Q?SqDi8+HvCiUNBkBP9d6ZuyQ/WX7oJKPBi+E4lkkzGdXaZz7vKzZUVpFSB+yL?=
 =?us-ascii?Q?LGcr5TLJ2w+KgO6SCNDvVM9vqR2ccc+S3tfv7irwvL+VgBJ8ZxchIxWChvg5?=
 =?us-ascii?Q?dpPToHsRX29v91x4PPjIGp9VOWcv+ERDUfOC+/E16RPIy3+8TZlxIhkjBYvZ?=
 =?us-ascii?Q?D8i0l2heFiPK3+JKk140ot6oH9KfZ5Wkyu4ZozvIMiebl5umnUv9tUMu2fKt?=
 =?us-ascii?Q?mt8eAOYFi3QQrqAIVocgiCNrMi1Ib+f6YCoQ6tjAm6s1Qfguu0UbSXYf3S6x?=
 =?us-ascii?Q?zrp5fRpgNhoInNWZOVjpdOCsnHCf36gjoUNPObis6EJvoluIyIi4Frywy7Mk?=
 =?us-ascii?Q?VHil6sChkA9mKuqosb6ZLVHj4I1T0dZUVUMIfhdk7IOp1g+4LpgAu4uGXb2u?=
 =?us-ascii?Q?1hWlY1JsLyOJLhDUhFOraMIFBILHWs7Y5am+1wgDulLdk7QbRF8wGv8Ctysj?=
 =?us-ascii?Q?ra8WDuGMigR2JyZQ3Tec9kzVYJ4137AveQoi0ZZMBZnEy1/HX1U1OVsg84q0?=
 =?us-ascii?Q?UceQ4hvAC9R6gyt3vCVgYIf30DLiXLjhzzXW1thfMSWoDEzQ9Q7jQe2VQxs9?=
 =?us-ascii?Q?sM+EzuSY1k7ceJEKXz2qQEWxbiHg8jMvBgO0WH7WORWNSHtUcqKBgky1WneI?=
 =?us-ascii?Q?BxMkcyN86crGu2xvpNlYp7SriXvZd1opo+YmNKjNcDewNsvNMptcfizhJLWd?=
 =?us-ascii?Q?bFM7CrfJf62Ol2c7Jc7AVd5MXuDoGHrHiFno4Rs6sO9HlpiIofGBmO2i0otm?=
 =?us-ascii?Q?9YoPyA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cd99dfc-7323-4a86-1564-08ddae5b59a6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:29:12.7604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuVudy8DChAZdpAwc77CX4G++dzy7CMy44FB822ZJj48AI2cCbebrxVi9QzH5p27d4EAlguLGZN6NC0Z6UAz3Dxx7aTRerBhRtR56xa8P4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7295
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NyBTYWx0ZWRfX/yAu3c7dP7uu
 9d0Gl57QGlRU7ch5Gafs/BIP0W7iE2oO2WR0kxiKgX+5+TLXQyo25a2XCsyuvyMLL4gO5FJWczu
 U5POeArtFd1oQM1aQIMcZJl2UbgBt+jW+62UjsWONsqSE4aQ/QLm5f9Xd5ip5JptmbPInJ3/aCK
 ayLSFwsNjsyYA/iJagN9UO3xSfpSZqeeNgQuZznPYW4GhG8Y6BQF5Jj73y44OzVDjxGWNzOibHi
 KguNo2qxWvDmAuOVkRudHOC2MC9w6qk4rAAfUHnCXfWyDdcRYwKYcXdh3hGoeCqYjKUPaFO8kFP
 0LOtUEFToYnmx78EdvxBFvutCJftqr9zb9d9xzj4s0/ptIIisT2kG1DzCw0qWzrMd987Iw20GnW
 XlO9B6SK9GyLrAXjjpvXGO5mr8h4/r+4GsBfdqG07Ab2+Afjz06UjhIOLu8WJ6CuTFEooE70
X-Proofpoint-ORIG-GUID: bWf7ndCApHvRHq9m0xA5OUjUgs4UgyvT
X-Proofpoint-GUID: bWf7ndCApHvRHq9m0xA5OUjUgs4UgyvT
X-Authority-Analysis: v=2.4 cv=LIxmQIW9 c=1 sm=1 tr=0 ts=6852a30a cx=c_pps
 a=74iFmKrLo1AlckCWLuqWvA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=t_IIakVZT3XxnDp3cAMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

By definition PCI can never be enabled on an isapc machine so hardcode the PCIBus argument
of pc_nic_init() to NULL.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 279eab10ce..f9d7967dee 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -489,7 +489,7 @@ static void pc_init_isa(MachineState *machine)
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
                          !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
 
-    pc_nic_init(pcmc, isa_bus, pcms->pcibus);
+    pc_nic_init(pcmc, isa_bus, NULL);
 
     ide_drive_get(hd, ARRAY_SIZE(hd));
     for (i = 0; i < MAX_IDE_BUS; i++) {
-- 
2.43.0


