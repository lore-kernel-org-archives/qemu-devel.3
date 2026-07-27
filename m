Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191E6C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woEeM-0006gV-BR; Mon, 27 Jul 2026 02:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woEeJ-0006fa-GO; Mon, 27 Jul 2026 02:17:15 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1woEeH-0007FI-Dd; Mon, 27 Jul 2026 02:17:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZ5TI5bjUKW+8rckZsmJcp/gM2uxy/t5CfUbAmVwVR9ElWdj/MJf2zEEGKy1Khy/lYJcYhS8a4ArVD9grOvDAOiITbciDGwAkCKBBj/qW/19Ltd2xqSd+D+2rIUozTvb866DqZdXlG6Xct9je88+unuBpbH67pmoL0SulGRiCN9S6y2drGDMyeinjVaUMK16RNiQRH+D8BtaChwy9ktAhz1GRHxN4kicNzjYQcVgxx3z/BInMP3sWQGE23hxBE9kOZqYb+buymX+fpO9NYl4EM4en3i0FP0627Fqocauqb9S0BPUf+UzzDwDcvtGn+Wa96eLM2UMbFJM51QrytWQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYlCFF/Np5ce6S+l6WERs7Xwb6a59CknK/wVYwm37u4=;
 b=BzZdUeNqEm7idhVsIhqL0cllR7JrINnsJImxfbX64+YoQm+tB1SLPlGu5xuIl+XaI4UDr8EOEcQY3jxtUSYEJmbQH428fvUgz5QxsGADOCoaS+CECENT0VtEw+0O3t5oKHudqydptzI+5O/x3u8cqjJU0shsl6xKK3QaFa8za8GHq8h+DkH1E6BuQHjssbmXwC92YIRNcb4D99GbsQR5N9Uz66bp2/p32BhfRnEKCqN1gksaupKeWVShbJp+QzMiyxBZiv7VR467nXieh/NsrFHGT0VHn9CbMb8HBiIqn4zKPiHWj1ITTxf80WPanlOzqFnOs3NgJwxVYAsqJMNhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYlCFF/Np5ce6S+l6WERs7Xwb6a59CknK/wVYwm37u4=;
 b=M90cmpshBasEdfJqifjmNBsCFOSDAzFbV2J8cMw1PKr1+wnBMLw1Y86rZVmElUdmh0hRFGGIkYYnLwjjQiw3lEM3r1H7OfImBJ8JBHML4m3zMOp/jiLItmYk//JuVID8/vfh1jdeKoQpTPs0EsHmtt/LVlTDOss7JkuO+jJYWzZ5LIwRx1uEu38YNHi8J9bMFGgySrgwIraybpHd5FCJQTgNsZ7izEFFilgXXpFs9BW8qm/qeb/tOCG88vBPyRvP7ghU+SpeC1pvkzz+3P0xuKCwgT+eAOOA5sChA5LqI+nt4avOz+ctnPr9oHe1sPjtzYIhd4WeB5ITJ1TRP7u5Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB5624.apcprd02.prod.outlook.com (2603:1096:400:1b0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 06:17:06 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 06:17:06 +0000
Date: Mon, 27 Jul 2026 14:16:59 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Flavien Solt <flavien.solt97@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-stable@nongnu.org, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3 2/3] hw/riscv/riscv-iommu.c: always send MRIF notice MSI
Message-ID: <amb320e7s03aKBlQ@ChaodeMacBook-Pro.local>
References: <CANVUYGvOyZdCwXOtDkS7bXY3Z2HGK1b6QWKttCVUjhnpH65g5A@mail.gmail.com>
 <CANVUYGvtuMbxE6TCkO98G1rCadb0psdn8HQM+6T8v0KE+QVr5g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANVUYGvtuMbxE6TCkO98G1rCadb0psdn8HQM+6T8v0KE+QVr5g@mail.gmail.com>
X-ClientProxiedBy: BLAPR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:208:32d::25) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: a591d19e-0700-40a7-b037-08deeba6ae9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|376014|7416014|366016|23010399003|1800799024|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lg6Y43QqUw5HkWjDiFJKe43mXP4eDUaKDIrSl7bEq64kb+Il3I4zJb5KtEHqaP9gLwg+ucRlzucjNiMobOb/2+p+WEM2WtsJUnVJ8Kty46ssGN5CsQdh4n65qx9rDZLM6/7SmL10GY+bk94OrCvQt+OIjAKY6yyxPf5h7mAXZS+6+P17dVIUjqQQgOrjytuCyU2tjLaarT9OaodoUAp/g+7xaCNl2oUL3BPKRl0HZFV7zAClxQVIBZ3KXf/2bacMnFybCZNpu6eQUFYWz1mBpUEpQzOCvs4VGnsZg2UQ4izZOAZwbT0cuQgCJef4uqVWUcB1VP4MvKSmzBxQ+vAnQSVeDGH6W23xct75L0Vm9Slm3EUX6v4GA0UcKjoYSx4nGIqUAeS44XHPD8lTHPeLasL07G5n1xZtGHLIfTZhzWbj8KWCdmWYXru/g2JfA1wJ1GSgH57p6/Wo7iJ90pg4z60GMlCLJfaQvz49PuVJ1otthmE478kL9c5dQ1QnQRdMnCXUDS5kkgp7YWBFjEVuLzPQJ9ZxIXkA9v25BGYCbnHIFScq/mXCoMCTPccxXBWhLsQ7mEuL1SI4QspMJWWpZOkhe7T4TmvX5udeXSb8juwhELf9D4oNC1CB/rFfGF9QP4RWayv2kdSAw2de9V026xn+T0XXL8TKH7H+WiEAMcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(376014)(7416014)(366016)(23010399003)(1800799024)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mRqEORf++H37c4AhEpQQXOtOeOSBycsMaVibdBaIYir1yblO5DyflRPDs7je?=
 =?us-ascii?Q?xNfut4TV6juYnM62AkN1WrV3uJ1MFkRiMoR/Um/m5yxmnU9HmqqfNx1MEnIm?=
 =?us-ascii?Q?0ZObAdgN8+GclpvxOkLxfULYFNEw4nL7dvou3FoDmwLmad15V8yTHki9+poW?=
 =?us-ascii?Q?nncNh7K6ykM7CI9w9K4mad6kxtxlHigtpi+4gOB8GIuLwZ26HnzRLLU7rN5W?=
 =?us-ascii?Q?5C6SMFKTGrcM148bWrguS9XLzCh7OCXJpGt4TjLHu43475U5682fXS0WFbQw?=
 =?us-ascii?Q?95OOBV3UoT4YV/VS4hJIUVJzTKXc/Iox0np7M4TomujJ63DS6LrOtrvhBDPz?=
 =?us-ascii?Q?lqYT1kPMyDe6k8aAxOOmHSf8BOESATKhWGJrHul20djFQq6IU07OZUI6t+9J?=
 =?us-ascii?Q?S1RNmc2WG9AV9Wl7PeO//c/xrB8hgmW4zjDSefOsT8Wl8ZOE0v+JuQ9R/xru?=
 =?us-ascii?Q?uPK1sogcNlsBk1NU1RHFbcd9SBY+4GVPhzJsayGzzw2Mpa7HIkJJMS4sTCV8?=
 =?us-ascii?Q?H+AFLu54tCFClOlvN4cLBZoBHhyrE46cWn30sfVXtNNYYbT5cmk+V75p9qDk?=
 =?us-ascii?Q?p+UBLF62Kaqv0ClEYj/BS3wfjCD4/Oxw/4q0swqn3+3qZJB7uDQZn+0o3Kbv?=
 =?us-ascii?Q?kAJ6BOJ6EsrlUK/0j0BfUBvmdgk4MhojAXQhGIegU4yevqRKo4rcFNCbD32I?=
 =?us-ascii?Q?K8J1fWs5tFYWULOrqLgeQKK7tPGTGBFp7PeKyPx3zDF9wVs/HhDf4a6LW7Fb?=
 =?us-ascii?Q?7EpTHiu6DNfjT+WFhz0y0Z76sELSqVKVfKKRZtBUxafmyldgw0Lc4Ddc9GXw?=
 =?us-ascii?Q?V5uTEE1Fac6spbz/PbbEMlf54KSNEO6PI/GgqX1slbk+l9NIHMjvYFtVIHpP?=
 =?us-ascii?Q?+Z6cE4vPFstsrjUQ4aaRW3JYhwj/TO+w3v2wWDaMk+8Br9I878PS3oMSFWhz?=
 =?us-ascii?Q?HGFr8QXNi9/otvdn20mpneDK/VgtveLDDcdpD5OBGB3We/IXB67auWtO12qm?=
 =?us-ascii?Q?0q5V6taydPtiqS59O7FdhvsBDmO8ZJEXPhACAwVpKCMKN/U40klhoKFEr2jc?=
 =?us-ascii?Q?aWTEtefmR290SRQRWRVJUO/AkEs9aueFwGIRBTBuTsHZxlx8Fr6JWnDGRjVJ?=
 =?us-ascii?Q?0TyRBt/of0k7ZbAoNoawQGr9TEAhqZ61gNFUu6DAdSH458nFw9X+l83lszWD?=
 =?us-ascii?Q?Ia4hwv5RmImxFPOlZwHy3gVojcUPUZLgdkGDvtqRBaNokGSUjvnC7mvv00H/?=
 =?us-ascii?Q?LO957BprOofkpcmGLNN1sVEnRZuQgMS9TQl79soLWZiO7S2CtUIvUdwbYhjt?=
 =?us-ascii?Q?BVkWUwL91aovndhbQmySbj6ToN085kVFLf/qSTn66FUWrewIUJ8OXAegQ9jX?=
 =?us-ascii?Q?yHdIIpMGXsW0OIfGWz0yVw41deV6tR5wsvVRvKE0rrCUbCZOh8elCb614rZn?=
 =?us-ascii?Q?tf/aCauBC5C/H4nTAnxb4W/QprM3K/QRDG3FTfq35DnZdRS9zwKsw52CdCfY?=
 =?us-ascii?Q?HQhg3SiicRA6y+QdoC9k6V7E7wwNJNmR2H8sPjAI3XB/T59ybL4UQ09C368Y?=
 =?us-ascii?Q?NgVQYkqlQeHWPvilwMZWgSjSW07yefLe9Z1nqRf8tvd61GJ66/V6wNEY+dFK?=
 =?us-ascii?Q?KcOTj/WAL0LL/89k6TWbBz28Zb8hUdiCe87l7Mdq5PEuK6o/aO0FzcVIW2KH?=
 =?us-ascii?Q?j6pghTuqMQPl+tavrDQ0TLWLe9iXU3C04clH0cDejHgLxt0MsvmSk5mthqgX?=
 =?us-ascii?Q?cykrObf2QhrUotFDmd0Iufw7xo8QjlY=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a591d19e-0700-40a7-b037-08deeba6ae9b
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 06:17:06.0187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsiG0FdAhoKcskF24vNzUj4FQkPA4fgT5VVqIT0b7vL6wLGwyV6y3wdM5+M+4WBaxt8H+ldGxWypGggHR9APStaNmx+Xj4xob/O+HDjZdb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5624
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Hi Flavien,

The code change matches the current AIA requirement: the notice MSI must
be sent after the MRIF update regardless of the interrupt-enable bit.
Andrew's v1 requests to wrap the commit message, retain the notification
comment, and add tests are addressed in v3.

However, the transport corruption reported on v2 is still present in v3.
`b4 am` retrieves 2/3 with this hunk header split:

    @@ -788,19 +788,6 @@ static MemTxResult
    riscv_iommu_msi_write(RISCVIOMMUState *s,

The continuation has no diff prefix, so both `git apply --check` and
`checkpatch.pl` report a corrupt/line-wrapped patch. Patch 1/3 also has
four similarly wrapped hunk headers, so the posted series cannot be
applied.

For review, I mechanically joined only those five hunk headers. After
that, all three patches pass checkpatch, the riscv64-softmmu build
succeeds, and qtest-riscv64/iommu-riscv-test passes all six subtests,
including both new MRIF notice cases.

Please resend without body reflow (for example with git send-email or
b4 send), and verify the posted copy from lore using `b4 am`. You may
also want to restore Daniel's Reviewed-by from v1, which is missing from
2/3.

With the transport issue fixed, for this patch:

Reviewed-by: Chao Liu <chao.liu@processmission.com>
Tested-by: Chao Liu <chao.liu@processmission.com>

