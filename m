Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185F0C55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 19:36:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpt1g-0002Kj-Kr; Fri, 31 Jul 2026 15:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1wpt1d-0002Eu-3l
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 15:36:09 -0400
Received: from mail-westcentralusazon11010014.outbound.protection.outlook.com
 ([40.93.198.14] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1wpt1b-0007GQ-CP
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 15:36:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iIm0mBKis65kS5/NNF4xFRZOONhDC6YvjaqVSqcgT+Rm5h0d+/aeKmdu9aJx1LOGEEG6VDw5TI/8uf6X4IGRGpcL1Jx7qNvTZJSQQ50ZRgFQ+aX8+gaMC6UkLFOgdOa7+Usy83UntXTG8BF+7LCa2pfrXcGgiGlVtm45KWw5Bxy9rYf/dN/8CtjsLKeOlmWFR0oi0frYV2dQeifp74OLNexgqwab22SIwayToQuKTFnIcdW4aXKbqIZ4/KYwG+gEZi7zBn8kPnSNq7NE/rKO+Lo4pb/9gTsxi118PajNqo6F75WiQzzjioaj4rwnWGVr6KqNktj8AD434gquwvEX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfI7RiwqcqpAXL+AmreYX//amfJhydxAKH0X8ISxggs=;
 b=GEMcjQkec5nrMZTp6zKt3s5EtuqIf3f8KIrBOFGRKvzPbUsdSAC6mQzkCaQMVWMPXymh7v0bk0IW7LLzpq/FvmJrmYQrucNIKhT6nx6sFPVmUw/saP7ehmPuLoNQcrJN1deS7FmX/jNNyH+ewHVpiQfb7aNKPJfgmL8+MYZOdxaHzemGj0j3WLBvsHXv93M39GLQb1Tv6j+EXwdZAGeyW3voZMPKsI3HmvOHOLM+5QaAP+ml7o9Vs1BXqgVaaoj6ETxoF6NwA+i/XO/Gd17qzDd4R2wIlBP+7xAeF2DCunpSU66tIbb5w5pTQYYPNk6RdXMSSudwsvbzzHpYP4hNeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfI7RiwqcqpAXL+AmreYX//amfJhydxAKH0X8ISxggs=;
 b=IkEhvrUpR384qShfiDd5VO4vWgDNUVgREaulkylXfM1YpvnC/KgP+g61QpAFRLkm1CZML5VJd/TVIUod5c7umT5mhpYoDtg0vlSBk9qN2rahcRL6eWt6jmqHKTRn7MGoo7JoC7YKsVguBii774LUToBRLfnUk777ODEY+w8ciVQ=
Received: from SJ0PR03CA0142.namprd03.prod.outlook.com (2603:10b6:a03:33c::27)
 by DM6PR12MB4332.namprd12.prod.outlook.com (2603:10b6:5:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 19:31:00 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::98) by SJ0PR03CA0142.outlook.office365.com
 (2603:10b6:a03:33c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 19:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 19:30:59 +0000
Received: from [10.254.61.72] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 14:30:58 -0500
Message-ID: <6789e612-f624-41eb-9c09-4a3514287f58@amd.com>
Date: Fri, 31 Jul 2026 14:30:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add Support for AMD EPYC Zen 6 CPU Model
To: <qemu-devel@nongnu.org>
CC: <babu.moger@amd.com>
References: <20260630153315.1585-1-Benjamin.Cheatham@amd.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20260630153315.1585-1-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|DM6PR12MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4c6ae3-b621-4316-2cec-08deef3a4025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|56012099006|11063799006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: A7VbpEzIB+6M2GgQz8FG4jkGrs3XeVPbDDyuWKHBN5xUgJO8mgdtt7zdpebpVeOPI6sZOWXrmgGKCIPN+ZSHoeUmqywpyVv2cHwWhL/sCBSTGLyyZfjs+KtAweX8ig1vYs2ZN7yplzWEesDgUBT1NIYyHM19J90XKP+OCkCSmL7R4XMus7Ud48GDBECoTdW9YqHHwuI1TASxmQJnVh4ZRq+fDMn7sI1ylbeLpSC7tgNSJLsq2NzfOLT4Z9/ldjfdvQu+9c+nQgz3zCljYUUhb1fLa+zmXsvaOSxIM9BaxYGkjv1G+4HG8yAS4Hm9rD12p8+mnTxg7m7SVDugXOeIcHJrOXSpb6hZor6k2OPHYoktu2IwoC1lBc3Ie9NwovcC29s007O89bBNDqnpFofjv/AYBjHM0X1mEfRD5wT/TWIhhA/KTXeImNbWA0ydoJeLlOyKqtr7WVefK/Z3oW2W0/uPyPwOTl6XNk/oTLndyZlF4C9fgD8+q/K8O0w8TfPVQYzcIIU/RcjE645nnIja+3wl3CtUb4JLrXTtlwWNHi/59kxEv21Mp9MBGfYfN/2N4+W5YX43IISdAkUUH1qiRgcW5uMF9YRc5fsWrF/bChrU8MrGWVCz765DnJVzVbQ88ZcAEw+21joDijiJ2j8JVmYRYlndqMJBJdduAcBQbHW0f3/v8I8mQmVFrfXEpxlNjJ97ktq0WnFdzX1RteUCaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: duUV2i4tq0NQ50YXjD5cUbqp543Z62neTOo8JHDXXDWeN/H1R/GyNTADbhWWfqfsvbUhwXAMczdfKTBwj9JsdEIHEdN0En2ET+cydUWk4XEm5kxjXPjSs8QxakzZmopa5jO0LQa7FqL4cnltXZXFanClm+CHYEFqgG41IffjrxAN/aJdgx9yxIZOu5S82MixPpUEdn+nlSSGqfPqNn6bka5KqQjFvkRkIAt09LdEU8B0BGnVZ929x2MWlPORJluRO2j39AUoI3SUexifmb2msiq77u87zIMHL976a5/hZt7jIDoEYGOaicp1heqHijkwWaIXA79gXYAZ/E13v8H/KHbX49vQGCckfYc0bQmxjnxkxyXhQHpGuQBmIV0RegQz4Nn03fPM+jVkaS+qgnwh1qDgT/9MKG1uxWEcG+L+0ultke8v6ECHLOxh1ZTUV6zg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 19:30:59.5021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4c6ae3-b621-4316-2cec-08deef3a4025
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4332
Received-SPF: permerror client-ip=40.93.198.14;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Gentle ping.

Thanks,
Ben

On 6/30/2026 10:33 AM, Ben Cheatham wrote:
> This series adds support for AMD's upcoming EPYC Zen 6 CPU models
> (EPYC-Venice). The first four patches add support for the EPYC-Venice
> model while the last patch adds the actual model.
> 
> The EPYC-Venice model is based on the EPYC-Turin model feature set with
> the following feature additions:
> 
> 	ERAPS, TSC Adjustment, Shadow Stack, and SRSO_NO vulnerability fix
> 
> and support for the following instructions:
> 
> 	AVX512 FP16, AVX512 IFMA, AVX NE-Convert, AVX VNNI Int8, and
> 	AVX512 BMM instructions
> 
> as well as new cache values.
> 
> Some of these features (ERAPS) were only just recently merged into the
> Linux kernel. It's recommended to use a v7.0+ kernel to leverage the
> full support of the model.
> 
> Amit Shah (1):
>   target/i386: Add getting RAPSIZE for ERAPS enabled guests
> 
> Ben Cheatham (2):
>   target/i386: Update RAPSIZE definition
>   target/i386: Add EPYC-Venice CPU model
> 
> Nikunj A Dadhania (1):
>   target/i386: Add AVX512 Bit Matrix Multiply (BMM) support
> 
>  target/i386/cpu.c | 152 +++++++++++++++++++++++++++++++++++++++++++++-
>  target/i386/cpu.h |   9 ++-
>  2 files changed, 156 insertions(+), 5 deletions(-)
> 
> base-commit: 10a9fa0065a3cd3dcf12e2eae6b8caaac6ecdec7


