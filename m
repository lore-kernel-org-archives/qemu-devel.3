Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49697C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 19:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYVdg-0001T1-0J; Mon, 29 Jul 2024 15:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sYVdd-0001KT-Ln; Mon, 29 Jul 2024 15:02:29 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sYVdP-0005Lq-La; Mon, 29 Jul 2024 15:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722279735; x=1753815735;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=G68+7dfymQ00uIGAn7lJUf6VqSh9B/C4tqmMwpDvGjU=;
 b=ojXHG0rJ0OZXv2D+pkuM2IV60wgYm5SaoIbuzoTu7tfw4OMU8Xr0y2KQ
 pwBDTPjcATuRNga4JPMqUl0yMe0HLpiSxuaCWnzqly6iC9QSQ711+03no
 bqwVK7XdaTxa4kakLFZekJhJdAfb3874ZDSstFchbharZ7Zvr+/HwQHQN Y=;
X-CSE-ConnectionGUID: EeWmu0OYSGa2BEM/Su+ZoQ==
X-CSE-MsgGUID: dxxt2PovT/GyEpqBDSQTgA==
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2024 12:02:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aef5LAS6Y3mdCdNd06Upcu8d5A6lubFgNSS6M+1clfcpMW8Fur2bqDpKViXxf/ZwjMeYqyU9HwmxfXhq8UAxXiACYX5uN5OIrx232M0m/p3n+cRAS+Uznydsvku05nAHCFVCdynBtfhBsAnuPvHbEHldb9OK8FE4EJ1p3wjgTNKbs7f66b4DKxkOxHaBh/wUm9Cw8e81eUCIvWMHtC/0/UPVQq74vS2Z5SkJX4hH9xX4BLkh1xqAuy5rGpxYVMoRCkMOotopHLIfjrllXToJjSbC++YTdh5l/3R7FP9XApCRMteo9beNWwn8G3ELRHQGucFY9jYPTy72GnVLMQ6SLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkiIMDPr4hbt0KSrPbZ7A34gKHAmxkFG4WbWNC95Iv0=;
 b=xj4APsquI2r2HAVi1Xh+PUw+iZ7yk/A+MaQOdG+mV1qxcJ4wXYFGhjpMkP0P+5LKSd5AIHQ+zq6Zn1wKHdU0h6Xech9qPXlaUTzDOttc/J46FDkB0uoU7AKJbKSu0sr/DIPlK7iun/gcHRXq8IhBoYg7Ob7iPFuoKF3GUb2X4UA0HGMU4EtczHElV3KZlpRfyFIsWxxC4wnoznytg2883rY+aU0ff7lyqjky1WX4Ts2Lz/zYzPqXhO2WWd3SxkCCCyxy1H4vgbxCage7mQWCBziy5I4W6V06DofiIguqiny1Acg2xC9Px0d2ioe2Kl7V85R3143/PxtwPpWR3mPHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.50) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkiIMDPr4hbt0KSrPbZ7A34gKHAmxkFG4WbWNC95Iv0=;
 b=F93O0s5lQb+zwgZz9vxCJ0f1rRSVO5z6qwuJMDdedZfHbgfV+3ZX2DA20HODrczTSUChSrtCs2b6eq9OzwgA6r6aPgGBiH0I+EIbWAI1Yomasanms9BPBjQTaq8/UePduGGkrKxn/bCpoJeteuZBk8S8fAwAAb4nE0Eo8Q854HY=
Received: from SJ0PR13CA0116.namprd13.prod.outlook.com (2603:10b6:a03:2c5::31)
 by SA1PR20MB7353.namprd20.prod.outlook.com (2603:10b6:806:3ea::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.32; Mon, 29 Jul
 2024 19:02:07 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::52) by SJ0PR13CA0116.outlook.office365.com
 (2603:10b6:a03:2c5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19 via Frontend
 Transport; Mon, 29 Jul 2024 19:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.50)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa001.seagate.com (192.55.16.50) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Mon, 29 Jul 2024 19:02:05 +0000
X-CSE-ConnectionGUID: ljcqUpXkSom//ryisNTxqA==
X-CSE-MsgGUID: kiw991AMS8S+35q4QgXDeg==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa001.seagate.com with ESMTP; 29 Jul 2024 12:01:56 -0700
X-CSE-ConnectionGUID: fo3epGGOTqCxJ7H2xyPEFQ==
X-CSE-MsgGUID: iail1XcRRxax1OVwhTPWhw==
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; d="scan'208";a="121679657"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 29 Jul 2024 12:01:48 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 berrange@redhat.com, alejandro.zeise@seagate.com
Subject: [PATCH v2 0/2] hw/misc/aspeed_hace: Fix SG Accumulative Hash
 Calculations
Date: Mon, 29 Jul 2024 19:00:33 +0000
Message-Id: <20240729190035.3419649-1-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|SA1PR20MB7353:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ba5219a7-b3b7-4f28-63b3-08dcb000f067
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1LYYkrVl+UhVd3GEkc2CYKJ+46MCKE8z77lW7w6eF4375Vhc+NFp0yKwtOUy?=
 =?us-ascii?Q?RfO+rAErTGoXmUtv/ozNbASezMy8JOseHoo7MQf69xpkAqE0CApOHI9limj8?=
 =?us-ascii?Q?N70SVqyJNrAiYiPFYULUonvOiaRM9+4PXEnI8dZFtwG00gsMx2C+lbROFQGT?=
 =?us-ascii?Q?1OexGBbdl04933X9U9TBYAsBdSMtx8AE72/ZrtuH/ZWMwziy9yvjB3HccflS?=
 =?us-ascii?Q?P2JUpY5lLb7YJz9zgkCZpxS3lNL4tG9QmAvBvAL+FFC/K8NJDbA1PKieQCe9?=
 =?us-ascii?Q?eCpExQcLNpQMDXY6A0GNyffIuKqGVU5IDFv6H32q5tkf3CSbynaznyN1Rp0y?=
 =?us-ascii?Q?/CKeAawO1KlUl2GSCmkm1NcsRRLV/XoM15+QsuydKBxKLYFnVZsyfkXuKV0u?=
 =?us-ascii?Q?UCdZvHfzHASo3lxNXgygHA+ZQAHeqVP44PRMChZoS/eudcM/Cz3DEanAl79Z?=
 =?us-ascii?Q?IFiQKd0VfAHCVuoK8mgv2IbRhQJ05DREY2j/zpFqphzDicHN9lnHhIleSrvY?=
 =?us-ascii?Q?tDzSGZ28e1CqKaWQaE+lCoPPw5X7pceywhRRAyCtv2hQgvjSGaeLltNeT7//?=
 =?us-ascii?Q?KW9I3z+FQ2FaF1U9gr+emqGgwbIu+SEjOH+OZRzmM7EYK/K69KdqlHT3aBZt?=
 =?us-ascii?Q?ns3kegQQZCzJ2sDOFR3kCkkkibqVbM99lP/u0OiUR6Iult43qhM+FxF88+bf?=
 =?us-ascii?Q?VYmGPzHmvbp0MKSV3wgmkxuTRYCJDiH7+c9NQn8nuALI6XjZtLJNP6ExUjv8?=
 =?us-ascii?Q?J/IK4bRJQDekftQRVqgVBJQs9WQba7D2rbt+ya/GtoRzWpqz8ydG5vES/pAt?=
 =?us-ascii?Q?+SBs3kLXoevADzAGRZupwq4Yma+kyoj5bnUBTPCr0eKBEUEHbpxaH839UB+b?=
 =?us-ascii?Q?ZUoAhyaTaJpG6PIw/0kbaWf6RYtXLqQPfgueVn95/mdy79C/RqBESgEpISkJ?=
 =?us-ascii?Q?VAPwaBh4uEsUt9ISfY1l/Z3hIUR6hXEEzwPJYzyyHQj369sMh3bBnXOH0y3U?=
 =?us-ascii?Q?k/1sDUFQvM0zwiUNAu2kwe0YOUpQaVnxe3cZayhVyLSH9MR6/jykUP+8M6BO?=
 =?us-ascii?Q?JnfdB86U1bUAuNaP09saKCVkvq/f7LQHHRiAm0V8UVu2WoJAqO0eO4Py/BRe?=
 =?us-ascii?Q?AVxxkA5oLzA+uIHgKuYns133td79nDMB9XgmrtfUXIMpMGJ9SUIunGWKdpNY?=
 =?us-ascii?Q?R9JkBQb5DjlvMluPbmACP4A54/un0Yll8DWtW3LQewQBbwrb2QxTBOFCeUUn?=
 =?us-ascii?Q?wuJAekuOTjrivNFDBGLX0Uu/cnvoQEJ4h7DlYnGSLHW4oaPz/lU3UJACWE6f?=
 =?us-ascii?Q?qKeEimc1zPa/MW0/s5yT7mckbzZRimTz5PT6y3UKDUGDoLSv+qYuY7bpDu0D?=
 =?us-ascii?Q?ua99ZNHi4Z6OD+2BrwjeQoVsgMQHiSdr2LNmvw7WNnDoEmI7wT46A9Qd5qNw?=
 =?us-ascii?Q?NrkjpIrvbW/b3uCn/bskmuh72ndbEHL7?=
X-Forefront-Antispam-Report: CIP:192.55.16.50; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa001.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /ebEGkhLBJx2Lh5ehTArGbpZVGkR/3s32iaq6JvnBSyxPRuCIixjLXABMkqgAzt+MAVxuKH1E9y/5mo18W23bWCN47Enj8TXf4s23B3ZPC5Gkh1qcteLJCW81Epckmb8B0Q3qzEsiobFj0BGGqtsO0SqNRFMKlARaoOM+WIe1I8bF8vb22AYn6K2ct+z3rgd7zXqj6puwG9QJbBSKf30olw2SHn4PxlHx+eIHvcZ/Zl7klYBdF8yeBoow2b8XLv3Ng+KTYH6t7sayWwzsbm5ffA7qJzTC64uyddUuTJUe7ZKdsr/jh7skN6Zp7biNnAjMn8NcA+pW3fHUM56Kbfdw5M10dhrmDS4EQvDaOyu2jn9YDGY8zobFT6jxD7Tj1giQ/WydRvnsSb7YT0HRPXCSZIP8NK4q2x4JXrKR8y28H6qXyXvMlRvWh0CurRiXexZdXGC9U/DghjptQWVa0JDnYKu72kEyMr/0LW/69C8C/GUiTTD+K7cwkGE0dOZ+bzjV/a/02uo+DFdhtr34ntvTTqZ48uxc56vKBKlFc2gHl/SsisaGP3FR22TvF2E63VOQj5qVf2MEpNyPYUL6I7pp+Yy8EvwwpbvXFQecj8VyEOqMGk4FVHI5QKCPu/1HpJQ
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 19:02:05.0501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5219a7-b3b7-4f28-63b3-08dcb000f067
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.50];
 Helo=[sgspzesaa001.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB7353
Received-SPF: pass client-ip=139.138.35.140;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The goal of this patch series is to fix accumulative hashing support in the 
Aspeed HACE module. The issue that stemmed this patch was a failure to boot an
OpenBMC image using the "ast2600-evb" machine. The U-boot
2019.04 loader failed to verify image hashes.

These incorrect image hashes given by the HACE to the U-boot guest are due to 
an oversight in the HACE module. Previously when operating in 
scatter-gather accumulative mode, the HACE would cache the address provided by 
the guest which contained the source data. However, there was no deep copy, 
so when HACE generated the digest upon the reception of the final accumulative chunk 
the digest was incorrect, as the addresses provided had their regions overwritten
by that time.

This fix consists of two main steps:
* Add an accumulative hashing function to the qcrypto library
* Modify the HACE module to use the accumulative hashing functions

All the crypto library backends (nettle, gnutls, etc.) support accumulative hashing,
so it was trivial to create wrappers for those functions.

Changes in V2:
* Fixed error checking bug in libgcrypt crypto backend of
  accumulate_bytesv


Alejandro Zeise (2):
  crypto: add support for accumulative hashing
  hw/misc/aspeed_hace: Fix SG Accumulative hashing

 crypto/hash-gcrypt.c          | 105 ++++++++++++++++++++++++++++++++++
 crypto/hash-glib.c            |  89 ++++++++++++++++++++++++++++
 crypto/hash-gnutls.c          |  82 ++++++++++++++++++++++++++
 crypto/hash-nettle.c          |  93 ++++++++++++++++++++++++++++++
 crypto/hash.c                 |  42 ++++++++++++++
 crypto/hashpriv.h             |  11 ++++
 hw/misc/aspeed_hace.c         |  91 +++++++++++++++--------------
 include/crypto/hash.h         |  65 +++++++++++++++++++++
 include/hw/misc/aspeed_hace.h |   4 ++
 9 files changed, 538 insertions(+), 44 deletions(-)

-- 
2.34.1


