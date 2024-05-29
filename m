Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E612C25B7E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 23:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCSnx-0004aZ-RP; Wed, 29 May 2024 19:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sCSnw-0004ZT-2H
 for qemu-devel@nongnu.org; Wed, 29 May 2024 19:34:00 -0400
Received: from mail-dm6nam04on2045.outbound.protection.outlook.com
 ([40.107.102.45] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sCSnt-0003Hg-7y
 for qemu-devel@nongnu.org; Wed, 29 May 2024 19:33:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fe1Is4NDB/ZVmefyqvkPW/C2r1RRHyWv5eZO5xowZVyNKycma92Q8mjOQ11cSWwO4/MYZLMrw4pHt6O9E6g1yTno3FDUTrhdOcYGJ8XYrrukm+uFAzAKVJVPCO/dn4OeyfzWtsz3IYCjMpb6sxltKVsfIGXI0YJAjvaCUfupiyaVxr2X4GFYJpD4NVTrTaDij3uNV9a1spvvnnuUDPipR7RGUXCYyZZfqhxfIbWX3dehTW69X5n+Npxu7NQ+9zuefd7nTLXXfv5Fz+vAJ7fiyDN0LoXxf0m551cw4Adi0S9CH2LQeox4e2LeocbCtU6VlbPlje8vwQc36svpUXSF1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8yM2gbAVrv20rysuUcrYFfZ7OAWIqxWK7g9t6HioKk=;
 b=JFlAEOV+nOMgV55/tnjJ3WfAAr5dI9o6cAIJV+rhDiWFvLraH4mu+sBhOGV3HRK/OXkPomz3Xud/NU4OsAxtEF7NN/OR43hWg6d9hx5MUYbL3k/sGxyJzWMm2h5mwOTSS/d3V+Mganx4P+qGf5zBRxi+/YTGSkhUrUyPqQbnaCHtIbKAF/WGHOlAmypPJ6zgJIgNnUwPbzw0Rn6WxXdRkc58BsC2C8zrWrsFHKYvWxxI++2rpIwo3SzyHQyYChr5V7gjyn6OLOXlQICJkuottV2SRoZETbXKGxmMKHUDN90c38UJs0Xj/rSULu8AQpJnr6CLhkxwNlSxjUnq/JzM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8yM2gbAVrv20rysuUcrYFfZ7OAWIqxWK7g9t6HioKk=;
 b=G/6wdPoAiR6SSvUM1J9aSNaTPSSADz9BUQV+xqo6Hes7vO9zgMO6df1rbUmDLtSGJxD82u8a+md/DBbw98+NsFNZeFGtrFMRdFY5MWlCgWS1KuVL9IWnR/uvFohHfuHdzwiRU02i5BmtMlWkCv6EpEzcf4ki0MCXE1woLyyGmF8=
Received: from BL6PEPF00013DF8.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:b) by CY8PR12MB7707.namprd12.prod.outlook.com
 (2603:10b6:930:86::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 23:28:47 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2a01:111:f403:c901::1) by BL6PEPF00013DF8.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Wed, 29 May 2024 23:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 23:28:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 18:28:46 -0500
Date: Wed, 29 May 2024 18:28:28 -0500
From: Michael Roth <michael.roth@amd.com>
To: Thomas Huth <thuth@redhat.com>
CC: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
 <pankaj.gupta@amd.com>
Subject: Re: [PATCH] scripts/update-linux-headers.sh: Fix the path of
 setup_data.h
Message-ID: <ktatuml4vbb757of4cgwsur6dh2fudcggd54wsrkvkzi2tv7tj@bcx4enlebbrm>
References: <20240527060126.12578-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240527060126.12578-1-thuth@redhat.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|CY8PR12MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d2fac7-e257-43ae-b46e-08dc803716c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d4sO1i+K/dEfWvLxDf4elVWpXH/ARNP5q4PX/6cOgDT/5daJgEUi86us4Y/m?=
 =?us-ascii?Q?lZlufZg3lHVKUTtkjKdH83hTlgT+tw1nBFYRJpLqQ3yw9EjDdUw7VZoOuSqp?=
 =?us-ascii?Q?C4TPy+fWUXGl0QZVf+e5O/Q8cDPUzsS7jd2M3P7Ff1SMxDefxdrWSJNk+R2F?=
 =?us-ascii?Q?Y8FGPyVQnW7EcahGrpeRLoX/d4BjnGMHmX1uHsiu77UW8Y/68NgXNp7Mv2Ih?=
 =?us-ascii?Q?EVpjhz2mbBCij3wxzU8Hu8WX3Gr6alDkly74hTH0qHurnTnT0V1LqpSoTNCc?=
 =?us-ascii?Q?GzhRM1aYmSf+rz/tNnTARfWFqu+7I+PReyQLqJSppCKIWvjqoB4w8lHuE7wd?=
 =?us-ascii?Q?JHsZmIIqTCdshj1q5RsbMK7RU0xtotKzW8OCiftX4JdtcP0cxKpgK49pPZzv?=
 =?us-ascii?Q?L/RKCUd9vBkTKzheKz28WSEIYgpBTz9Ha4TmmJaeYjrg8udSDDmAxVWj5LyK?=
 =?us-ascii?Q?cG7cCJSVfw0IIoMa6Q3N4ekOd8KrpH9X0b7CZCf05P2bpjWPmBxkoxv7E47a?=
 =?us-ascii?Q?eWluVg3nWrnNcq1uQAB4oEp/1DFdckjOCtWAUNqllKbMWoJ8itAR3fpK6EuG?=
 =?us-ascii?Q?1pRAQXwusM+kBZ0qre5K4gmi/KZStknEtYROKALNt3uP+zB5LzSATdHITR3p?=
 =?us-ascii?Q?SF+4x9vkS9t3Z/5RjnhO0dr+AQxDRtzM0AoKCTO5/s1Uz0DtaA0uOffSOAnq?=
 =?us-ascii?Q?Yug/dQr/0gbZpNGHhrGJUkMGwixsqXMmCHlrnRN4KbMklJ3CZzPQzGsBQotT?=
 =?us-ascii?Q?LCYiZNGpB0H+s4Us6g5dL9OsFVmGZmDeFBzJQgwG65PsNJQpZf7Qg/yPfFQn?=
 =?us-ascii?Q?tZ5vH3LK2ZegEisS/0ZHzdQggjm6UXWDTe5kliGRt3yp9PzXtKYhBUGYqX+e?=
 =?us-ascii?Q?mWv34tOqoeArPBRroHAf4RgG32/58hTBeXT0IhsJAJ61vz3fZjoXOmJzK6pq?=
 =?us-ascii?Q?SmBUCJS73rvXrIcCtEwLKgRQkHislL4ZNBgfp71ySiQS+WQxtGEP7vrFHehf?=
 =?us-ascii?Q?r98xGGw72NQsNgxGnkXIriehos/QEzsQQROA1vot0um0ck2R+ZkzgOoHoFKh?=
 =?us-ascii?Q?1XbkcBfxrKPWMV0M9InCoLbN1iOBfDK3pLhoaWDFZLxzn7Zl62W4mn9sYfNo?=
 =?us-ascii?Q?d7nmUcB22dbHfPinNR1+x3yUpYljEhD1OW2m0DSLpZPSKP2tljzPR1elbrWy?=
 =?us-ascii?Q?Hbcbge7NaSCWUCRLN2mtFNCXRkeErDyl2p8iR+DYu/jovZD0HHC9iUu6iYju?=
 =?us-ascii?Q?iZm5BRLI2OgPOhLXnZVj870X7vS82IRlIE9DiQg2YZpqJKj1vtN3Cfpe2OPn?=
 =?us-ascii?Q?otAlmk956MJz0Z4jXmieJFYvD3muWCE3QNa3sQcHAjM+iMhtpbfDloOugIn1?=
 =?us-ascii?Q?H7OxrO/tLsEqYhC4Xny9CHyJBgZQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 23:28:47.3198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d2fac7-e257-43ae-b46e-08dc803716c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707
Received-SPF: permerror client-ip=40.107.102.45;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 27, 2024 at 08:01:26AM +0200, Thomas Huth wrote:
> When running the update-linx-headers.sh script, it currently fails with:
> 
> scripts/update-linux-headers.sh: line 73: .../qemu/standard-headers/asm-x86/setup_data.h: No such file or directory
> 
> The "include" folder is obviously missing here - no clue how this could
> have worked before?
> 
> Fixes: 66210a1a30 ("scripts/update-linux-headers: Add setup_data.h to import list")
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Tested-by: Michael Roth <michael.roth@amd.com>

> ---
>  scripts/update-linux-headers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index fbf7e119bc..23afe8c08a 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -159,7 +159,7 @@ for arch in $ARCHLIST; do
>          cp_portable "$hdrdir/bootparam.h" \
>                      "$output/include/standard-headers/asm-$arch"
>          cp_portable "$hdrdir/include/asm/setup_data.h" \
> -                    "$output/standard-headers/asm-x86"
> +                    "$output/include/standard-headers/asm-x86"
>      fi
>      if [ $arch = riscv ]; then
>          cp "$hdrdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
> -- 
> 2.45.1
> 

