Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C01CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGHuE-0003lA-5q; Tue, 04 Nov 2025 09:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGHuA-0003jZ-Gm; Tue, 04 Nov 2025 09:21:02 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGHu8-00066x-WF; Tue, 04 Nov 2025 09:21:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqX3epiIjPgg+o/9YkGGQenwkI53LSDvMVNCQRIErT80ftbgeTQAg9S810zD7WnyH8CWYpO6336ywTpflnbCiNZZEheLp7wsVVnZegstdLp5fy1+jbz8PdhuA3s0c5eYxOY9YaHUlef0QdhZ3Q8MFpEHLlOXFbaXRQWdP/9mOzOWlOfPEt+hcOByan/rpYilPIhmJULuLixqiPKHC3deQ7ZOZpekoAK/MZaAu6nAWSt6CFtsx7lIdG2emFkQ/xH7PP6IWmA5voUavper+MvHAr/RC8qAeBclK8l88xi86f/H9MQRenGMZoltT/PVAqqO5sJTJlSRKZUhtcjayaUgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6pmjmf0BBmLKdlSswsZaFuB44AzXp9XQHjTEDJ0Ips=;
 b=lpY5/Oc9+IpJlcXNyiCFKAMr2I72wiJmg5xeae/dIrlhaXJUh8YnrmATYs9GH5v6kXbu4oGlbGnxFauNBSEsN2jYZJS7fnr4OAFiUHhup2oB8r+8K8xhqgX14M6JKIjeUswP+yPFsrb8Ek7THeNkMwttbWGjQjvaU8Z12kaysV7jjv/UtrnIKTZL6bir0UwIcmn7p6T8I64RwvI72WY34/8vnfwhh0LsVNzVsTYHVejRWzGJPmmKnD67xpSMXK5XeSqwlnmM/RL65vPcZ3jU6DENwKZ5HHl13vm0z90hUs5tSbVYP+J68t4dyk+ir+axVnS+fksqI1uLJRXXVgCYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6pmjmf0BBmLKdlSswsZaFuB44AzXp9XQHjTEDJ0Ips=;
 b=SdhCXE4zPd8FzBlNFENKWLZs2owQPaj0h9bbNy8puJ0sYsSrRVycYMHDpVixERWrjcfOlrh+YoU7Oy9W8z+SKAAyMOGyJ/Bh2fOtTy9ew2QFvLVadzL+Cqa3ytR0ujLys6y/++SkuNR07roN8oVAL55fMMisOrKjUo8evn3fUrLQk2UMnleGuliqZGADeLepaWJiNcs6Dqputa+XFVxmGH/1e+/8OzW7SqWFe6o7yxAVK85kyqUgOy5hzFgqBGmZo5Vc3uNSoKnKErkIb/yEhUsIRko7ioGxihq01oNy/aGEWTcWOn7QjZhpgIDfsqK7GqrzeBizAgRB4TP2XJBhnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by DS4PR12MB9747.namprd12.prod.outlook.com (2603:10b6:8:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 14:20:53 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 14:20:53 +0000
Date: Tue, 4 Nov 2025 10:20:52 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org,
 nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <20251104142052.GD1537560@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
X-ClientProxiedBy: BN9PR03CA0891.namprd03.prod.outlook.com
 (2603:10b6:408:13c::26) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|DS4PR12MB9747:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c83671-c820-40db-df77-08de1bad5cf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?46sXRyhcmH5MWJEzqI7AKsityK/qsAaqvDd9kqLFpR3V02DvXgNSn2jRUxNW?=
 =?us-ascii?Q?2Kgq98CKBL1E/fu2xQqoUyViXZSCz4dvgOP6UPh3tvonvvP6fBS/cNsaDkBN?=
 =?us-ascii?Q?i4Ogmq5vP30WRMacDZ0kSBNfXsfu2tDYd8IfHZPoRFgC8q0+jEDREKYqeto5?=
 =?us-ascii?Q?cq640W/nEYtFH1TVLHSxOD0iK7Yn6OkGdfOKhToKqxD68t5dk0MFWutIqbvQ?=
 =?us-ascii?Q?sg9IAYJK+hqmaSyAwoxNpbG2bpPN31AAo3D2mcg3tj0/0bagDjnYbG16uoGn?=
 =?us-ascii?Q?bWiiDpgDhrRU3c6lAbhTKLZY9Z9x2dzp7wOpoqIJkHQ6tQV9LA+ICjsD8bwJ?=
 =?us-ascii?Q?TCtgIZjp4qQ741BpHonTz9hmhCOsZU84y7C4X3wzCZ9IjxgQAg5LNqhnavdb?=
 =?us-ascii?Q?9KTgzsPx2kf6OMsG+Gy5aVVyP6ah4df6hYmXoxJPfzKynX2AQtJfWhmtZd9Z?=
 =?us-ascii?Q?Oaup9bWxiWVIkDUEPCjlJMWvEQejM0771jHUAM8rHvw3GGqHBCT8h71bf6n5?=
 =?us-ascii?Q?dgzZhG1ZTmwHUUW8M4T4T/eUqNiJupTwcwcrRdjSHKPRLPN5TlUbjwTbDm3B?=
 =?us-ascii?Q?H943qCqk/oULh/fKhsyRYg5jisxYa46yfdnBxM3GAQ8r3birWyn4ihilccSD?=
 =?us-ascii?Q?YL/lNy5VQ3KnwSYcBmNbgFq8IFLFN+1/zVzoZRzq5RDx9UHT1lA0YMopgnRW?=
 =?us-ascii?Q?Nju3C/JXOIqgZykhfIOxpyCOXdRvHKe3lZUbugY3iHyinx8kRJrHHKo7W791?=
 =?us-ascii?Q?26U1u3j7YhRe/h/UNLfKVjpx3TLIa4Y/spUBjpq76oHMNfF3Q9uE0qJgLb2J?=
 =?us-ascii?Q?b0nRhGrBZo5ac8uKlQWolLjt3Mg78x9ooRh+F9zP/6Dp7YKZartTBahyiPsc?=
 =?us-ascii?Q?j93yGsqEHz1aijTl9BSod/jmRZo8aw39MJz8NUfDvAcpN+Z4sBVLcjZ5x3CZ?=
 =?us-ascii?Q?+sjurHC1HVJJlEy4bOp79xYzaLj25jJu9E/SB5ZZlQu913YHBOuRWPJRjOPJ?=
 =?us-ascii?Q?cpSoUaUmRGkoVJO1ASvaL4+cDCDQiowTz5b7M4GOTqd2yerQ5fXp3NHyC2E0?=
 =?us-ascii?Q?5q6e3lEjlisVLqvzrw+9bFEYXC+7QShgeIDk5H0yA4mzkmg95eZIVnI9Bma+?=
 =?us-ascii?Q?wE8Mr2TXPMuhyUMmpXZNWD0caOf0fphBHl9ZEf2fYMnzr5HYnOQ6tTNyxz1P?=
 =?us-ascii?Q?/ZBn4STJHD9qNG/c7fWvFu4zDS1YF/JSgWX9P2vjkenvhJ9se5VV1Sf1+bpz?=
 =?us-ascii?Q?78tkZOyOR176nHZ5v6aFNn1EkLPyoVgUfbqZShK3xbu/bHdjPIJxXk/ZlmBN?=
 =?us-ascii?Q?OwoObP4xqLiKf79p6NlvvGcZoAKRFlK2X6EAir4UMNur1wFuAbykwa8Q2NmJ?=
 =?us-ascii?Q?guX0j3/WNxF6Iv2liCSglbQqhhUv5kTHu8DoLjWHMsrGBCA2h2f4E7hSQ7VM?=
 =?us-ascii?Q?d5tiur6AWgKLch1aFprlipxV264jim+M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hszHoPt7iqSLMF7l/Aq5qm6nXAiQ9S1bm9elExaJo1fvvYvZewOFJSCnR/Wu?=
 =?us-ascii?Q?hNOm+gFXMuNfDAxYxuMm+e/1rTR+fuvMUuf2Oh8zwJprujQMYabRHaECIwdb?=
 =?us-ascii?Q?t1bzPEG8TxmOoyzBEvDi3MtiuOll1EFdf+E76r7hqDdEXN0mSaN6JlKliZEh?=
 =?us-ascii?Q?KsgEw8YEhtaiRGunPEbgT4Mk0lgKBBTeS04GWaSjsVcnE4Y7TYLWDkT+K8RV?=
 =?us-ascii?Q?/pwXJpP7t7Mq9BPLHSyZ5/4PbZ/YfGLO7fmwmMDHlTKDGD1w8taxXdKnyvlg?=
 =?us-ascii?Q?x7josCpTnfuuLyMIlJy/pHci831jGtMph0pL1gvUO//cJFEeSZQjqrsYGSE5?=
 =?us-ascii?Q?lruNOebxaQKgxNMooag67EuG4MI5Qw8/cmhkkYuS43e3lgu2UygzBpo9jSL9?=
 =?us-ascii?Q?t8X1F4BQ8f+SrplUaTpVWsM2NDNW2gCz55Nhl/x9Q8wOWfNILVx0a6JuoVOy?=
 =?us-ascii?Q?1+FJAf9x0XL/Fkt325mi1tl/j5mFUthoqiFgqphsW5JPFIXizbSlkxe1P/rl?=
 =?us-ascii?Q?ld0cpaOFGt3Cd3HVFFWFS+hRE5Jj+CMxfdF5ke1Us/J/t57+UcjpuZakN8b4?=
 =?us-ascii?Q?Q3rdXvC12YuW7alpmaIRkR1ngGAXLNA4em9novvFhjT5v9tKUx7i5GfmYtLF?=
 =?us-ascii?Q?FEH1saAPqE+0B8TB87cQbuvuGXlzGNBzDosZEDjahbhHXtzTuU0ropcmRgZN?=
 =?us-ascii?Q?JoCLSzjMQpOHGb5RPtlyq8nLIIBJcQNK1lK3E9V4IG9Fj3ApAbsiotmEXnny?=
 =?us-ascii?Q?27iBdOHRstkA/XgRzdSgtPUSzIebzDHnNE4dgi8v37jDmHOsqRpSdjA6Bxyx?=
 =?us-ascii?Q?1WKsw7OExHaGUSVwkdSKP5qEAb18yn5cCgnRssHguIVk5aWMVht5ieukhLsf?=
 =?us-ascii?Q?V/SoMqfIsT9LEBgPYg0WX7kdeaHfpM8fmkHNH2HlHle/OWOn7nzmm221yKHM?=
 =?us-ascii?Q?nPZSSuLnPYSVrDrs5dXjKmOT8fAFbJq+B+BQEB8IpDXjXjaACfYovuQZwO8Z?=
 =?us-ascii?Q?4RDFdjqEKW9HKUOgqx8UXE2+Tu8JlmXSWZFscz2ikCMikA39+4put4YzcfcA?=
 =?us-ascii?Q?JklpWfIJL363RezUSZG5xn67mnnz3dWMfhHqSXdfeVY4gBnQZcqNkLXqwFm9?=
 =?us-ascii?Q?UP1zcsu6wv/uUrUiKZYezpgnmMfOfI2ydJcdLnET16buBn1V3DXJ2R+YCQCy?=
 =?us-ascii?Q?I4QgCKeIeGY6985wwlzMc2VbYlYeI6D9tCR00rDUHwz7Z7H2QeNeFtvBfE1b?=
 =?us-ascii?Q?Yn6R0SvfVLHoKUQvp+VpjnoLm5JHdoF97Nbm3Q+fruhXKaUWtXDCJpFMnpw+?=
 =?us-ascii?Q?EcvkW/FvnnobXaOXLF0osZu6aTV//eQiINwFS71oFXyHTZyO82mubdlzkGIC?=
 =?us-ascii?Q?82qts1XSL5JDz2EyRave+ueOr1HFIUpXGKVrLp1qHW8l6ykJsMF4bjlns+ac?=
 =?us-ascii?Q?lJrhxLi2NOcz0F9Yck6g8TS4+8D2UW2LYjzQsn4UvcXMNfpnrvWWJKawwBeb?=
 =?us-ascii?Q?z0ox/5qD6xEN+dWGXKKLp6QcD1UZ15sxr9SRP9aO5Jl/H8rtMmNxD9u8cfH5?=
 =?us-ascii?Q?8Sbxbj6ShL3NtC/qO0Y=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c83671-c820-40db-df77-08de1bad5cf6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:20:53.7720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C56IgUIXL6DWQD1SKsB06koRGD4Vf/6tsrEuuEV2zJ5QkYMBUuaB/8lw9Nz5akL3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9747
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=jgg@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 04, 2025 at 03:11:55PM +0100, Eric Auger wrote:
> > However, QEMU/KVM also calls this callback when resolving
> > MSI doorbells:
> >
> >   kvm_irqchip_add_msi_route()
> >     kvm_arch_fixup_msi_route()
> >       pci_device_iommu_address_space()
> >         get_address_space()
> >
> > VFIO device in the guest with a SMMUv3 is programmed with a gIOVA for
> > MSI doorbell. This gIOVA can't be used to setup the MSI doorbell
> > directly. This needs to be translated to vITS gPA. In order to do the
> > doorbell transalation it needs IOMMU address space.

Why does qemu do anything with the msi address? It is opaque and qemu
cannot determine anything meaningful from it. I expect it to ignore it?

Jason

