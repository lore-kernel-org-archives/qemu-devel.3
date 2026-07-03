Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F909C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 08:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZMQ-0003Te-GT; Fri, 03 Jul 2026 04:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wfZMO-0003TM-C6
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:34:56 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.K@amd.com>) id 1wfZMM-0002K8-Mb
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 04:34:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/gWd7OpiFyLKF4Mp9kkll/FWOCSVkEaj/GeliGKLec9Yj2hSLqvspAlxk+jknGsHCvnlQg9+KUNhPoSOdb2ROIOLvoSDp0pxdqmck1m8MFhiT8F29+ZQBeomMQWcD4xxASEnl/VMtV86OW69kB9puKhgcy0a8Y3qupTMQ82PhB5TtM4uhvCWs/X/KRc3WgAhpOvfRJxnT4bzzl8fIm3/Jh12gQTY3QVj9XL0rozlxw0eY9PQlwZ3DTXl4/Ql8T2AAGH8KE5sRTODYld5Mzs0xGOSHOVNw4CUQUfW0soyLXfFdPkifG8Rh4Nfh2sQQgMy7dKcAzIC3l7VEL8cRgQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0Pi1b3Q5L5j3a+BsWcKcW4gcFr0CZjBoFZnPNRlBgI=;
 b=CAEe4GUk7bRd2PWe4NKHgERho8Qw7wc4Wxb/1ovVQK8IPRVRs4ivWvLtYrihsCpf1V900Rem6FzGpfSbgnnXNDToPn2CHl2g+Sd5f6bSbA1KPq/nPUb7b9EDyZ0ltbl3fG4bEgk5YjrXeOENVa2ajj9m/xFZN+6pvvG9yusSVsKB7SFNEKQg7BSfqcyr/1lhIPhL9a7O99Vp1MOAsJO1uCY59BIE0O0lSycmrLHw5PIqFucnNm6TnCDhxZKB3Nj5Ooyidob+qKwUcG9jTIjrfBgU1btBRS8Ixf+BS2CvHddSZiqIIkPnwhO9Kh8XcPiqrDmkFOts+cURk3lDvFqCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0Pi1b3Q5L5j3a+BsWcKcW4gcFr0CZjBoFZnPNRlBgI=;
 b=xVjMKW8cEBAprY+2zTIL+K65sIHxwCWIZ9rHcs6zK2g293QrVh4OzeKm6kHVbZO0naMt1wKx69zt/7AnMwnLSslmw1TejwJGxG7+FtG1faLrTbh9SMv0NJJnCaNBZLgkCwZyyEOvQ/3pEOmlEbUZFIRgFMVY54T7OSR4RADCaHQ=
Received: from CY5PR22CA0024.namprd22.prod.outlook.com (2603:10b6:930:16::27)
 by CY3PR12MB9554.namprd12.prod.outlook.com (2603:10b6:930:109::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 08:34:49 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::e) by CY5PR22CA0024.outlook.office365.com
 (2603:10b6:930:16::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 08:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 08:34:48 +0000
Received: from [172.31.37.251] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 3 Jul
 2026 03:34:42 -0500
Message-ID: <cdb197a4-198f-4eb6-b176-5483897a1735@amd.com>
Date: Fri, 3 Jul 2026 14:04:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <pbonzini@redhat.com>, <richard.henderson@linaro.org>, <mst@redhat.com>
Subject: Re: [PATCH 2/4] amd_iommu: Use full BDF when reporting page faults
Content-Language: en-US
To: Dongli Zhang <dongli.zhang@oracle.com>, <qemu-devel@nongnu.org>
References: <20260609204403.323149-1-dongli.zhang@oracle.com>
 <20260609204403.323149-3-dongli.zhang@oracle.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20260609204403.323149-3-dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|CY3PR12MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1207a8-aa52-48eb-f906-08ded8ddf1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mDhH5Lbp4MPYBGGheTKDEtY6LX0OUMrSHFkbF0p9kx4+BB7TaFxAiCqo4kC/yMQlfeZe6mfYdAQwyQj1KV7tta8u7LU7hzmlRo31QC/dg4w540li+F4DXO6ojla/9tPMS2kVMc0KRsHM0JwJWUQcc47N8UaqW7jIn/1g5RUjK0gwctKbpjkt4XvNPPR49nAHPIWJMZ9D6s9/GY3kkvMTVRyWc33OHsAELyOr+NJD3DX4Iwx3SJJUIaw9L3l5jdq3OwaRgEzv10ZVtpeUIPz9fmHLpHyGKK+bxqjrXphgdzz4xCt8HFsKdHQ4cFnK7uUdApiuIn3V97Dkob1sb4VGzg7T6vTGKmWRWbV0O+ju+cU8gc6JbxqMQYXbzX/iEQ6e8l/VmiAZvL8yu1v1n0wXfduGC9Vem/jI904G43+X3Ub7nRJcycqmhvF9xJKSYtb2xkAV2Q36ReoJvW28/qYg8DU6dQMjSc8u9wzGmYme9pdjy653TFHuvw0N1rcblRlMrSRPRA6tYzEoOwnpyD4cjGdRy3/WetY1fsduNKiXVUIIarzGsnLSfaNLv3Q1qX89w8kW+6tpU93YB9hSglKUBCFgoDeWLYnLG11b+dV7MBYXYae5fc7+c4wEsyqzKEkpo/X31xkMfNMR5uRBT1wmEmsQQLn9SxuH/bC3rE1c87ASl7sRdRcqYIjRWq/zK+9/17JFvt283QJpOA9EHCONgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XC3rkt+m1WknKOXqZ910UjvgyhCVDo0lmUmx4eI5RIp6L9MMynPbq7YNDHPHPG49XVMNyYNVmEAKkl5RSL6XWFnqwy9mtNp4L+Z+Us0MrRp/EdnxC4ob0SzxkRYkHxjjJV9dw+LZByG1ih16fvkLUgIdx0gr+8SgWq22JWEyeZppHWUQwlbq1PTHMjgbsb4n6UlN9w0hZvChAQiskZFoFhgrYFz2nr2640ry4TxjgX3sT3nerP7LJffxcJm0pgT6KVPwSpYyOUa6lBkOvR6u8rSnjfcoiAoMuFYl/F93z2f7erKN9XVJhSaLtHMof+KLMnvS8+CvU+v/KhbWjEEMJP5GVVnx6l69dV/raeGLTCFceEwf2VjGn9WlWJcQ9EcwigCYmja+fBp6Pg2Lfh9A/l8le4at2AibRo8Csn43bKK7TkHG/NMs4tBTgoQJd0oC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 08:34:48.8043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1207a8-aa52-48eb-f906-08ded8ddf1c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9554
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=Sairaj.K@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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



On 6/10/2026 2:13 AM, Dongli Zhang wrote:
> AMDVIAddressSpace->devfn only contains the PCI device/function number.
> AMD-Vi event log entries require the full DeviceID, including the PCI
> bus number.
>
> When reporting IO page faults for devices behind a pcie-root-port, QEMU
> logs the fault against the wrong requester. For example, a fault from
> 01:00.0 is reported as 00:00.0 because only devfn is passed to
> amdvi_page_fault().
>
> [root@vm ~]# lspci
> ... ...
> 01:00.0 Ethernet controller: Red Hat, Inc. Virtio 1.0 network device (rev 01)
>
> [   58.154050] pci 0000:00:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0xc0000000 flags=0x000a]
> [   58.156968] pci 0000:00:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0000 address=0xc0000000 flags=0x000a]
>
> Use the full BDF consistently for AMD-Vi address spaces and pass it to
> page fault and page-table access error reporting.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   hw/i386/amd_iommu.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)

Please add fixes tag.

Thanks
Sairaj

