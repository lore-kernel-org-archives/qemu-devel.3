Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6B7C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 19:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJexi-0003te-IQ; Tue, 18 Jun 2024 15:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sJexe-0003sL-KS; Tue, 18 Jun 2024 15:57:46 -0400
Received: from mail-mw2nam10on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2412::62f]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1sJexa-0006Xm-Kx; Tue, 18 Jun 2024 15:57:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj2uACTbsleETNprlRqcbZMpzHXvyFAQvyr7sLEO+kNK/6v44q+P9gATAoBkY+vl6Cps8V6C0WK9gW+qASxml05gykPsejGrucBUQj1jB7DxghGSzUgAG0Pli3A4eC0pB3YOTFYqvRDoQ5IigYUep4AfvZENZ5HSK1ONsFi5WfjUZugmFRk6WAYD3UhtKau0AGrXe9+E1+f/gNVLk/BbNPpbXrvw2eeICRXGqwrlwcO9SHxcK6hsB8Ndv1R6ixhKJiLTE5STzVywmEoNHUoyeGkINuzCU5fFg7duFNdiTGuW5Kr27Tbq34XPBKEG3dlr8nZG2urZBtVcMvCraACNew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZBANl1o5Mjf25Ae+cKQttzErJHzfMd7u27p/DEL5Jw=;
 b=D+bjwp1RSQARKcq5sCo4My5q8xy42uIWr9MXS1DDBAW9un4KHNHVA/6KQxGGdkUmHRCTgtksFtPLxlgAVbI5Y3Deym5sZGbJTDEADn7GRwa9j77q6S/1T2O6sF2pJfuXe/Bfocuuo+q1FcWjQmvnC66DZI/gQ67+x5NqsTbhbwA0Kqv6deA59MhV+Wiu7wFbfTLYxvTNx0w0I6Ciz6WJfQpbYNEczPd8eFS7+1Ixf5+IaPFIT0bUAE0xmv0MMQN50zxKFtfQDBttsFcSBpTGR4ID9vCwXz3od8wzQEcLwzQbEN9R+q54ViHzNjLZbsTA5bspNegv7H8JaBE8ukajEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZBANl1o5Mjf25Ae+cKQttzErJHzfMd7u27p/DEL5Jw=;
 b=P6Yp3fduvXIb7/OCdBI62kMCnVpZWyKS8e24ea3fIfspQHxy5wuHBAgFJVPuYe0nBoJfHT1jbeP2wu1+QLlqjsB70a71yhJTBNpCu3JqpmwbEOvApjfKYHCEOdg+s3FOinwymRL65dL6klGVb7fr0OMOKp1pBHSHJfJFWcNmyr7BNyG7Fv5irLc3b8uXy86S+lB4Syz4mwCeJ5DbyLali7Qcf7hZEk/Xazx0oAv8mLapCnO9gzlaHlhAX2Bb7ncDOx8eUUuMNNrqro+3KT8c8wnR7O7pxNBqvpPN2nu4p4msuAagDj3GrZpuX3C10kgY99DSfl34rdFYZsDmq2Zp+A==
Received: from BN9PR03CA0082.namprd03.prod.outlook.com (2603:10b6:408:fc::27)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 19:57:36 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::a4) by BN9PR03CA0082.outlook.office365.com
 (2603:10b6:408:fc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 19:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 19:57:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 12:57:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 12:57:12 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 18 Jun 2024 12:57:12 -0700
Date: Tue, 18 Jun 2024 12:57:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <peter.maydell@linaro.org>, <wangxingang5@huawei.com>,
 <shannon.zhaosl@gmail.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2] hw/arm/virt-acpi-build: Fix IORT id_count
Message-ID: <ZnHmlvckrUNJDWsC@Asurada-Nvidia>
References: <20240617223945.906996-1-nicolinc@nvidia.com>
 <20240618054729-mutt-send-email-mst@kernel.org>
 <ZnHaNMNlFjhn5Jjb@Asurada-Nvidia>
 <20240618153725-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618153725-mutt-send-email-mst@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: c77a17d1-d67a-40de-3f62-08dc8fd0e6de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|1800799021|376011|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tv183eR+TC3/6aW1NbVKEZ9IWFZbHh2Z5s6pdJ40wtpae4H/ZwVIWhhVCgE/?=
 =?us-ascii?Q?vcXyhvh9zQb4vKd5RLLqWcQgR0UMmB4sPtL9Ii7X5SLnwzzl49FKZtv77wl8?=
 =?us-ascii?Q?dMXkdbpWxp+oDGj3OPMd2WNQQlHy8wYgzO8i2wlKuxKjE6GLrtzT+q7NOJas?=
 =?us-ascii?Q?t+XxWRV/BhachdMbfr1NEtbSWVSzbyvApAx25D+PfLpA6yK5EESNwr0/H+oA?=
 =?us-ascii?Q?e3FG5etOzcgVvc5H4D9URL492hIvIvHYd5iHhn2DKXMoR1fuHt/pOYUUq52Q?=
 =?us-ascii?Q?u9s3/bIPLMGrgO4CdWm2rWBHXgn82noE+9xIKc5RX9e5Hodvkku5oRZZrvCx?=
 =?us-ascii?Q?8RPMqErMSLRTMYaGSkbKCO3hdIETpzne48rdb8NtwMoo/S/QKS89KZL9dZFu?=
 =?us-ascii?Q?d7saTRfkuXEhpS7K++IErfDkjHN0YztkqOOIJKxYMFZZ5q42YzO8YMBq5ojW?=
 =?us-ascii?Q?ZgzpOxVtUPA0r0c+cWIdIkYzMasUGh3SYFFaZU9E6TcUIZVPzlnzw16qzyTV?=
 =?us-ascii?Q?dsyEhrXpFbuSXytHa6sYmegbEh2Gjg/8+68Ze9LbcmwM0dlEm4TEekFNXUsq?=
 =?us-ascii?Q?rRjxMGwBmSexNBkmL/EC1jcHycJpwbq6pt8o5CkOMMbxwZ3EbtK6ZcvMjjwE?=
 =?us-ascii?Q?VpIHcZkrvoNOZTtggwvs9XhnGjc7gs6dS8z3+pUZseeZmSuXyn9+8xr4IKoh?=
 =?us-ascii?Q?CFQ19dJg6YaYR0VTUx7LbDzejoyBUd6XlZMqWyKSDtQbl1vbKprMQaE2T3sG?=
 =?us-ascii?Q?N6aFRuyk2HPLyZw7rSZgtE2UrDNRkjp0DRapjDzTAcqYJTP7SGbSBnBhYukJ?=
 =?us-ascii?Q?ni2Rjc4zBpClWfLYOxv6uILw+mscEWgMdnjxhMo35sNhUGXvsqFB2d5GpMna?=
 =?us-ascii?Q?jzFkuZPyx9NO+PzaI2EgXcU+kqlI1ogbW388ad9rfpBXp1RLd3IzKTocdTLK?=
 =?us-ascii?Q?cJMrpmjk1KMTbProsmHSOSchehUP2ULKF5tHSzYCNe68J28vAOV/awEqHAce?=
 =?us-ascii?Q?swWka8sueAGwNelkfgSGT4OBG59aWy+8pLQI8y9wII89NxVPw3oqIELXd6JG?=
 =?us-ascii?Q?Ss0nVMh6mhChxuo80f8fn/nzNcdT69Mjgd6HmeZCuehR0F3KuqGircL63CnN?=
 =?us-ascii?Q?pyZQwUehAvHvsY8UyHB1uwO+wBPK1dxTwAKE2/Apaxw/Shh3V/hhNtK/pc0m?=
 =?us-ascii?Q?PNYiSteF+TZwuB0PrgG7d5SH+Tq6xbWBWwdpcgWD6TFk/nFUb6rYlHHsB4Za?=
 =?us-ascii?Q?zpo0ja4bLo19yaFvzpy5p64K5EanQ1CQWJDQa1lgnWBPQDowAE4EK9Im7Bty?=
 =?us-ascii?Q?TM4ne4Li2wZROeo9nRMOXWhj3SdkcB2hmzfIE0FO14gELuDM1V9IxeZ9iQ7B?=
 =?us-ascii?Q?1ZVsk/xt+I8rUg0RBbEjnKHxIapj4DqnMQz1y4JUofQkISoCkw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230037)(82310400023)(1800799021)(376011)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 19:57:36.7031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c77a17d1-d67a-40de-3f62-08dc8fd0e6de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840
Received-SPF: softfail client-ip=2a01:111:f403:2412::62f;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 18, 2024 at 03:38:31PM -0400, Michael S. Tsirkin wrote:
> > > > -            next_range.input_base = idmap->input_base + idmap->id_count;
> > > > +            next_range.input_base = idmap->input_base + idmap->id_count + 1;
> > > >          }
> > > >
> > >
> > > Given this was different previously, did you actually test with multiple ranges?
> >
> > Tested by creating 5 buses: input_base increases by 0x400 while
> > id_count=0x2ff (0x300 - 1). ITS results look correct to me:
> > --------------build_iort: smmu_idmaps
> > DEBUG: build_iort_id_mapping: input_base=0xec00, id_count=0x2ff, out_ref=0x48, flags=0
> > DEBUG: build_iort_id_mapping: input_base=0xf000, id_count=0x2ff, out_ref=0xa0, flags=0
> > DEBUG: build_iort_id_mapping: input_base=0xf400, id_count=0x2ff, out_ref=0xf8, flags=0
> > DEBUG: build_iort_id_mapping: input_base=0xf800, id_count=0x2ff, out_ref=0x150, flags=0
> > DEBUG: build_iort_id_mapping: input_base=0xfc00, id_count=0x2ff, out_ref=0x1a8, flags=0
> > --------------build_iort: its_idmaps
> > DEBUG: build_iort_id_mapping: input_base=0x0, id_count=0xebff, out_ref=0x30, flags=0
> > DEBUG: build_iort_id_mapping: input_base=0xef00, id_count=0xff, out_ref=0x30, flags=0
> > DEBUG: build_iort_id_mapping: input_base=0xf300, id_count=0xff, out_ref=0x30, flags=0
> > DEBUG: build_iort_id_mapping: input_base=0xf700, id_count=0xff, out_ref=0x30, flags=0
> > DEBUG: build_iort_id_mapping: input_base=0xfb00, id_count=0xff, out_ref=0x30, flags=0
> > DEBUG: build_iort_id_mapping: input_base=0xff00, id_count=0xff, out_ref=0x30, flags=0

> Okay. Is it the case that none of these effect the IORT in
> ./tests/data/acpi/virt/IORT then?

I wasn't aware of that. I checked the dsl content of that IORT
(attaching at the EOM). Only one section of ID mapping, and it
covers the entire 0xFFFF. So, I would say it's not affected?

Or is there anything else that we should try with that IORT?

Thanks
Nicolin

-----
/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembly of ../tests/data/acpi/virt/IORT, Tue Jun 18 19:49:04 2024
 *
 * ACPI Data Table [IORT]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "IORT"    [IO Remapping Table]
[004h 0004   4]                 Table Length : 00000080
[008h 0008   1]                     Revision : 03
[009h 0009   1]                     Checksum : B3
[00Ah 0010   6]                       Oem ID : "BOCHS "
[010h 0016   8]                 Oem Table ID : "BXPC    "
[018h 0024   4]                 Oem Revision : 00000001
[01Ch 0028   4]              Asl Compiler ID : "BXPC"
[020h 0032   4]        Asl Compiler Revision : 00000001

[024h 0036   4]                   Node Count : 00000002
[028h 0040   4]                  Node Offset : 00000030
[02Ch 0044   4]                     Reserved : 00000000

[030h 0048   1]                         Type : 00
[031h 0049   2]                       Length : 0018
[033h 0051   1]                     Revision : 01
[034h 0052   4]                     Reserved : 00000000
[038h 0056   4]                Mapping Count : 00000000
[03Ch 0060   4]               Mapping Offset : 00000000

[040h 0064   4]                     ItsCount : 00000001
[044h 0068   4]                  Identifiers : 00000000

[048h 0072   1]                         Type : 02
[049h 0073   2]                       Length : 0038
[04Bh 0075   1]                     Revision : 03
[04Ch 0076   4]                     Reserved : 00000001
[050h 0080   4]                Mapping Count : 00000001
[054h 0084   4]               Mapping Offset : 00000024

[058h 0088   8]            Memory Properties : [IORT Memory Access Properties]
[058h 0088   4]              Cache Coherency : 00000001
[05Ch 0092   1]        Hints (decoded below) : 00
                                   Transient : 0
                              Write Allocate : 0
                               Read Allocate : 0
                                    Override : 0
[05Dh 0093   2]                     Reserved : 0000
[05Fh 0095   1] Memory Flags (decoded below) : 03
                                   Coherency : 1
                            Device Attribute : 1
[060h 0096   4]                ATS Attribute : 00000000
[064h 0100   4]           PCI Segment Number : 00000000
[068h 0104   1]            Memory Size Limit : 40
[069h 0105   3]                     Reserved : 000000

[06Ch 0108   4]                   Input base : 00000000
[070h 0112   4]                     ID Count : 0000FFFF
[074h 0116   4]                  Output Base : 00000000
[078h 0120   4]             Output Reference : 00000030
[07Ch 0124   4]        Flags (decoded below) : 00000000
                              Single Mapping : 0

Raw Table Data: Length 128 (0x80)

    0000: 49 4F 52 54 80 00 00 00 03 B3 42 4F 43 48 53 20  // IORT......BOCHS 
    0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
    0020: 01 00 00 00 02 00 00 00 30 00 00 00 00 00 00 00  // ........0.......
    0030: 00 18 00 01 00 00 00 00 00 00 00 00 00 00 00 00  // ................
    0040: 01 00 00 00 00 00 00 00 02 38 00 03 01 00 00 00  // .........8......
    0050: 01 00 00 00 24 00 00 00 01 00 00 00 00 00 00 03  // ....$...........
    0060: 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00  // ........@.......
    0070: FF FF 00 00 00 00 00 00 30 00 00 00 00 00 00 00  // ........0.......

