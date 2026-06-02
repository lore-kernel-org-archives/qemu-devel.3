Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4258CD6E5D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 01:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUE8Z-0001GG-Sz; Mon, 01 Jun 2026 21:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUE8V-0001G8-GX
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 21:41:43 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wUE8T-0001Nz-Qj
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 21:41:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7A/3n+qv18/A8T5SVsQaxAK3YnHJXrdcyqkvjIqZuXysiGZZc8cbxJVBtkVIgJkiUjMecrBt6GEU6vj7W6LD8QZ3ssNY3YSizG0Uw+3nseTgOZ8BU9pY47oBQtbBTYLAcrxWH3FY+xe0VcIePlpVxvPHVqyK2sRK6wj1RsCdVBby7IsCY1vk+trSFQIEcOAcLwQN+BVdpJ6LUkiomlpFx0jDhpi25vRT00vX1cGw9V7QeqpazaAc0uIXixpQ8Q0IKJ19qyl+0LOIwRio5/9kOn9OmW7QkNedvzKrm8MCb2ic4xSgtis/OeYTZeoa4yZR8yD+iJFy83FawhKITkYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rB1sOL/hziRgupncoFm78aRwGrVQqn886um84UAglk=;
 b=ZfBNusq7smom76fO96wAVcg696lzCi9APEaW8F+KZyHyIcLz58w5ylmgdov7XRoCC5FpTrFrG6Sg+mUtB+OHQhQ7c0bKEcFw+ygDkLmrF6teVmZe7mU+LYdtPyvBIoylpuK3GJO9jArC6Ysys2VPxftySkukeogdhqrNzzmdQTo+Uz8FyAkRDi/IqmM8Z9zf6F9r6JuiLIsPMchjkRXk/4tI6W2UoRlIL+gbdksuvDjYx4Ri0oZ7B+ljglEsL2ul5rk14yuf3fkd6yDK0EboB1o8iaIu6NMCwzwgheTj5/TJLWBM4TB55I6JD3SXgqCOQdkpTgSVCnYIRs/aQ04d0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rB1sOL/hziRgupncoFm78aRwGrVQqn886um84UAglk=;
 b=IJPuVM2lxsH92mse448stYnPMY5h2aA/ux8R/DV2oyMUmCWE2AeD0/fwOwq39zL9Vbk0b57WbhiiMZNqeXvjt+FzrQkXIg9FZ0K1V1b3ACG7shqOlfRYsLNpQb5Ik7lXaLUFCGxzVO4gcJWSWhqsn2zHGATS/ukWduKRqU10Mfk=
Received: from SA9PR13CA0057.namprd13.prod.outlook.com (2603:10b6:806:22::32)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 01:41:35 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::66) by SA9PR13CA0057.outlook.office365.com
 (2603:10b6:806:22::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 01:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 01:41:35 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 20:41:34 -0500
Date: Mon, 1 Jun 2026 20:31:06 -0500
From: Michael Roth <michael.roth@amd.com>
To: Peter Xu <peterx@redhat.com>
CC: <qemu-devel@nongnu.org>, Juraj Marcin <jmarcin@redhat.com>, "David
 Hildenbrand" <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, "Chenyi
 Qiang" <chenyi.qiang@intel.com>, Fabiano Rosas <farosas@suse.de>, "Alexey
 Kardashevskiy" <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v3 03/12] kvm: Provide explicit error for
 kvm_create_guest_memfd()
Message-ID: <vpqisl6bbot2ikvzx6x5hujbtky5lzwu6btqjcw6qvo3t3hh3n@fiddb2rbuxm3>
References: <20251215205203.1185099-1-peterx@redhat.com>
 <20251215205203.1185099-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251215205203.1185099-4-peterx@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aaa6ddc-9383-4621-a773-08dec04814c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ERmI9GjR4WSqDlN9y/ukd4iee22wpT4ADNSwTMGgaQpKB2QOxi+h1ipAFeXXZnNCWnEmDG9YzEOLRvz4kw8JxZt4268QxHjEuSVc5t3u2gT/UH1WDH9ExZ5XETixUrQGnxX7IILy/95VKpSvLM+Dxp5cK0Nkj9y5Vw2OJxx9+izotV/wJjH0sHB1DBuyOR9PbaEHDgeEsDyfp5xkaf3YmXdoHePe98TFe9+2aSO1yBmSjhF5z5keXCP5rbXCtz4chfdFW/rg76CLNc3Bmd/d7itVwE63TxE07jadJulNSIpaU35vUyyxHVyKRYv/qKp7tqxNWIXdcTcR/VDSjCuumTDblszypkHl9C6T6NhAXzS1HAdtELaHm9/JKxIH6Km+FYxviOTbuK8Wx0rsVHQJAnGVAzeDPyCvUUKMF5uXB4DuryDHQN4kqvv5RNZhSdclU4p0BS2NSMwbLsnlQSEJnb39m+upEL3JSBSlVSfzxo1dUMVDihj3LZOGjRk3RTrZXFMXnP3oiDtPNHulyzndZ0JDfuIb5VdqFG6BAM2cmt7DR36xO9pd1/Tx0uQLWf/qZgncNmg52Ljtq0H0OPItp64RUawfezXHWJg1rCXAmCRweSwFz2ThHkU/jodlFZgsvT+5y1fCRfj47E+zR57YKkXlROY1oj7qu2DD5lUyt5Jx5GoQnV7ZI773NYZi66dRSdKIu2w1iXJQunOAiJU4/lu/Dgu7nmqiZQPekeL2+Ek=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uVMNYqu+Ue1e7CB11uLcS/dTFSxXof3PeWT1Xmr5exLdBMc40WbOj2UrN0LeRQbW0DlCFeCx53IhfcTl+TlJVNMb4ZHwoGWSLYblW5hjtC2Yl2Q+4CUzWuUYqirCnK1pO43671xy8MvN8EIu4h8+RvFwuMCZ6lazqTUi3nnGP59oryZVJnDeqNncij3+VWI/iUrVntwRArjvePywrrjT4Ojp935FC9w/fAjDZMLaQ9OPbP0dxbSHS4BRYr5ZQIapCBol2SJFREXaARE2G0VdliIKLk4oBpOr9DhQ3w3gWa14/WBCVz/OgafDwT5i4XvRg2Uo/53furagl1Niy7HeTV9ZmaLwZQCxNRE5h4StsuadEyFCq1Fo5yIOosGJT7ZSqX8YW5XYhlh+BCVH0bomLANqy8mQ68qntMfxUkvL9eVFxzqP/+uRx8ViR6cvYAqe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 01:41:35.1322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aaa6ddc-9383-4621-a773-08dec04814c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=Michael.Roth@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On Mon, Dec 15, 2025 at 03:51:54PM -0500, Peter Xu wrote:
> So that there will be a verbal string returned when kvm not enabled, or kvm
> not compiled.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Michael Roth <michael.roth@amd.com>

> ---
>  accel/kvm/kvm-all.c    | 5 +++++
>  accel/stubs/kvm-stub.c | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 68d57c1af0..c32fbcf9cc 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -4492,6 +4492,11 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
>          .flags = flags,
>      };
>  
> +    if (!kvm_enabled()) {
> +        error_setg(errp, "guest-memfd requires KVM accelerator");
> +        return -1;
> +    }
> +
>      if (!kvm_guest_memfd_supported) {
>          error_setg(errp, "KVM does not support guest_memfd");
>          return -1;
> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
> index 73f04eb589..01b1d6285e 100644
> --- a/accel/stubs/kvm-stub.c
> +++ b/accel/stubs/kvm-stub.c
> @@ -123,6 +123,7 @@ bool kvm_hwpoisoned_mem(void)
>  
>  int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
>  {
> +    error_setg(errp, "KVM is not enabled");
>      return -ENOSYS;
>  }
>  
> -- 
> 2.50.1
> 
> 

