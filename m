Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FFEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 15:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb012-0007Vr-Ch; Mon, 05 Aug 2024 11:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb010-0007TF-3h; Mon, 05 Aug 2024 11:52:54 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sb00x-0003mM-Sg; Mon, 05 Aug 2024 11:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1722873172; x=1754409172;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=09RX23Wtzq+fv5ZYsbMviGBMA+4n/QejKP21Iqo8EeY=;
 b=H91XTrATGxhJ/R3W5JhY1iQ96z4t5hF3BzellSJU+HZekEOyiMvRQlwy
 g0Gs95onoP1ACZprEkBjLOHn+NKFYLPEGMZCFVSRu18bxYR62OmLYZGi4
 ri3dqmM17fgkM0qJ3vW9eYlLdGJMV+97YoBe/dlB0I6/D0cgW1G+Ziryo 8=;
X-CSE-ConnectionGUID: JAJh/Q38TfCBxx6dmDy+7A==
X-CSE-MsgGUID: JvjVCvsJSRuMLKhvmQD0yA==
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2024 08:52:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gmbxz7zOZfkoDDH+ooEq5Jrp0jo8v788G4Wh9+zOCDSmY88hZyx+dDF6bojUCpGBiLsHR+NMZt5VesYr1bcs9EKVC9nlVopB87kTmntXbc2huqIYINfctEFd6+8wapWadffqLTeobo+rKI+C4Rzf30Hm+gkq+62rICf+T2cmGHKv+oDOgWxEne6V5X1T5YfG0AefGh0QKHpn6Xzi2XDLOWA4iwUyLVMX6xNcaYdMrAQm88H/ohVX+NI9Urb4wr3JC3tn8udlbSPvL8E749Kp7BovzZ4RhnT4qEllw0kBmjowP4oO3Y/zOC682zFNxiNo5DtV+jLUzNVkJDPCMfdfzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XCh4uxi4wGlzYHF6iM0FBG3aLPFpO8KFJJeiddiVqI=;
 b=wUlarkV14k8mqP5qBTF8gPzdmxAbrdlsQR+V31Ivta0d/cOhrhJmnG49ELahC216DOY8j6e++UVI0TTJO0xA5CmLMEX2jTeGBwakuskkS3sm+GXqNj4AKIhaf5s0pWFMJrijp6IZQTzTwRhOEBJAktM3gA9xSG/e2NTuNOauIbIp2svn6FbPRTpD5o4R66ykTTvxuZ4QUcntUjKMuTy7VtPRIyXhrgMMUlti6GYVQMkzF1jLUtDwdz9gXhWofN3Ih9ks7p38TdznqJkwbvVlaVXQ11fkDtrCmEdlIejeC5MHeIj1JqLGsGHqJFNPnI31HNv23MCvEbzl8d5bU/k/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 134.204.222.53) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XCh4uxi4wGlzYHF6iM0FBG3aLPFpO8KFJJeiddiVqI=;
 b=djYgjk7lpv4H/SzuKVb/rubKab0F80Z2oYvurun0Py2ltSsXXq9iGxFRkxCTjMtMgwjg71TH9ASbG8emEr6d0tPpIF527xDMkA5w4BvF8N2rCjWZZaufq/MczDNSjHrrhVVTw2RgNov0vTLMmd/8F6yP8II302SNVDEae4G0RY4=
Received: from MW4PR04CA0377.namprd04.prod.outlook.com (2603:10b6:303:81::22)
 by DS0PR20MB5906.namprd20.prod.outlook.com (2603:10b6:8:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Mon, 5 Aug
 2024 15:52:43 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:81:cafe::a4) by MW4PR04CA0377.outlook.office365.com
 (2603:10b6:303:81::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26 via Frontend
 Transport; Mon, 5 Aug 2024 15:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 134.204.222.53) smtp.mailfrom=seagate.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from lcopzesaa002.seagate.com (134.204.222.53) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Mon, 5 Aug 2024 15:52:42 +0000
X-CSE-ConnectionGUID: HW0PO65NSiOEZMt4OIx1kg==
X-CSE-MsgGUID: k6a/LyrCTOSGgYNxBUiVzg==
Received: from lcopiesaa001.seagate.com ([10.230.120.52])
 by lcopzesaa002.seagate.com with ESMTP; 05 Aug 2024 08:57:33 -0700
X-CSE-ConnectionGUID: tYOfS65rTTqpEKM3RIotQQ==
X-CSE-MsgGUID: lJ6gDgAPRfacefceJcmFng==
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; d="scan'208";a="106920677"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by lcopiesaa001.seagate.com with ESMTP; 05 Aug 2024 08:52:33 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v3 00/12] hw/misc/aspeed_hace: Fix SG Accumulative Hash
 Calculations
Date: Mon,  5 Aug 2024 15:50:35 +0000
Message-Id: <20240805155047.3151540-1-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DS0PR20MB5906:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 32503e5a-e0fb-42f3-5d1c-08dcb566a426
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pehL7GzPi/IX5gQ5Y+8PRuMtIXW+ObmD0MoGJfEZir88jEt/s8YTUy0W5PQr?=
 =?us-ascii?Q?h2J4yFA3EB/ogIIEjNL4dw3b/PyWTVz2pTz2iF71U7gFB7N55Sz1B/RkITOI?=
 =?us-ascii?Q?nrbGAqYdnQerj6n+idFeUsM3Ihfpg2X5lKzH65yFsRWmhXC5c8OZgct4Fb1Y?=
 =?us-ascii?Q?LS9PWdu8MnBV/jl9yhKVDMvVYHN58jcqOxFI39bIM0XYuOAvxDCRI7blPcgA?=
 =?us-ascii?Q?IO189AWzcqCO2K9xqCU3FGYKg18QzNE0gScE6tvK6Le93Zhb8PIyNyGLy+O1?=
 =?us-ascii?Q?7PV+51srpFyZLcZZdqli15ZeBUOfUm0XWaDJO0f/yIdI0JrHyXIPBVf1liuO?=
 =?us-ascii?Q?Nt9SxfLa3XWDyuRfh8gSQvTZ044OR0ooNgh94c+9uNU4lCYdUdnA6Pv0lBJu?=
 =?us-ascii?Q?mQPRY/aoEY0NfDX1WXFpvJ2m9DSGVBtS8aisryx9Ifv5D2j5DzqsF4P/5CoC?=
 =?us-ascii?Q?vXkogKSEGH5qdnwJ8FVcBOv4kJ08ct56jn8WZv7u+UalI2OOufBS8Ban1dZ/?=
 =?us-ascii?Q?9bLhRRmf6Yhp8VicCqXq+zXFhiWDanFvW1pbW7Anlg/zXXlXRRC03qVJvidM?=
 =?us-ascii?Q?icSB8yX/pHsTX2FQheqIFllyIuOus9eIaq84YR4eRFfiI4IIEuGjhlxoUcR9?=
 =?us-ascii?Q?/d1uj2LC3LV4fWwga46OnXPKcY8qc5njqcdTIBB5jzZG9GA45YPNeWSTxiUk?=
 =?us-ascii?Q?/bh1DoEp3lPZfrWqbdC6p0vLW7Id+Wwp5spKBvnSLYUWCuAou1XZpeyCwGa+?=
 =?us-ascii?Q?VtZYCLVGrWICroQkinTSHl5gw5du0ekzOHcf/CRpkatbn+nCmy+WyBqg7aUN?=
 =?us-ascii?Q?Bj7pFSb9G+9VsR93rhtP8Zx9stcwDyL65/CdBFbLGhCCrlOBeKLRrurAt4rS?=
 =?us-ascii?Q?jxa573LfnuQhzfjlWYdVP7AmtqIzCZv72WF1cWvgsvzMwg/f7jyDCCKch9OI?=
 =?us-ascii?Q?E7OYxoMerfb4QQ/nV2oeODIWxfh4AnXFj7n1K7NpJolQg6vNUBhskG8rHCLv?=
 =?us-ascii?Q?CYnrfJy92Qz5lgQ9I7l2pVc8VersvKv25gzS2mGkgq8eri+bjERGyrJzNIU6?=
 =?us-ascii?Q?Sb+L2sENzpHZvaPcq78Te/6yMDDqcfOVG3GWhwBwE0xKTAhJZYgSBzcxfiJy?=
 =?us-ascii?Q?kA7etX/r5PHy0SSpltE+4v2oYRTmulXYsIRr53fkDrnxIsJwhOWGeQOmpbYR?=
 =?us-ascii?Q?+D/xYnvt1At14QRuwI5oIoWZ2a9a8C1q7sneK8SanafAvYhLQNt9bNSoDQs8?=
 =?us-ascii?Q?anoiMLigT0J0s5ir74Fx+0AANn2pmJO35faH+afVhofxO5Q+5uYS2173y31/?=
 =?us-ascii?Q?XHwRKP+Qsgc8aj+zYbPna3Xmx7KaOebPWJCwOkDV9V+H18PV5Ndfdl5TTGyd?=
 =?us-ascii?Q?Sdsz8vRHt98+Yq3qFEAMOv4V4AMA+t7kPjiSwOrVuJG8C/YC1C/DLcz5+Cg/?=
 =?us-ascii?Q?JAKUr+BypuWJYDpOlNoyj0LntJACzmM9?=
X-Forefront-Antispam-Report: CIP:134.204.222.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:lcopzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ihQtGplpOPYyuebKX95/B2ZNq+0CfbTorXDA92r4GDAbjdv3m2OGaKd8fmI9QSB/szowRdhEbxDWJHOnVZl4muviV0EfkB/M7jjiJNZ1oQ9fsQy3loT8rLtyRPmskd0bMBwKzZZ6igtI9KLAo0i4bH3LADKs237Yvnopov4v4i/o1jsJ02QmWPY0PRCpyA4FciVkTfuRA3sxcHaFoJE98GEf+g288hwWT9Qm4Y9JWk93RjD6dHe4hg+mnpTDlV2HFN47mMgep3m7g00itUWlfoPdl8CwmAYI7pzoptSP8GOIIwn8PGOM9K9wz/Njt3tk4hX/Ns614+joEI3FXwpcxHxHCqwmmcHjSwtCFHGnxPGXGx9RgLPVOkK9MN+eZJMO8urts9U5hnyandVj9liAqfp01MLOFJeE30hlk1jcKvJfZLMFO3EJL6CZrfzDovD4tRxmFUJVqQzsfG1kVVP/TwgtjR7wkxPbRTxBny++3DqIhLnR/BYRkvLkVOsmNPvR7EzIznDeQerR5AaopXPIActrkm9Ll9VGHTSPfJh63j2swvWQS7YotQuQf+IvJINlAKtxCofJjeWUXxuPtiNWS4D1RdLyUQjkJ9V5Dx5470YCANUCHRsJ4s2WONzLUnF2
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 15:52:42.0818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32503e5a-e0fb-42f3-5d1c-08dcb566a426
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[134.204.222.53];
 Helo=[lcopzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB5906
Received-SPF: pass client-ip=139.138.35.140;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

Changes in V3:
* Reworked crypto hash API with comments from Daniel
  * Creation/Deletion of contexts, updating, and finalizing
  * Modified existing API functions to use the new 4 main core functions
  * Added test for accumulative hashing
  * Added afalg driver implementation
* Fixed bug in HACE module where hash context fails to allocate,
  causing the HACE internal state to be incorrect and segfault.

Changes in V2:
* Fixed error checking bug in libgcrypt crypto backend of
  accumulate_bytesv

Alejandro Zeise (12):
  crypto: accumulative hashing API
  crypto/hash-glib: Remove old hash API implementation
  crypto/hash-glib: Implement new hash API
  crypto/hash-gcrypt: Remove old hash API implementation
  crypto/hash-gcrypt: Implement new hash API
  crypto/hash-gnutls: Remove old hash API
  crypto/hash-gnutls: Implement new hash API
  crypto/hash-nettle: Remove old hash API
  crypto/hash-nettle: Implement new hash API
  crypto/hash-afalg: Update to new API
  tests/unit/test-crypto-hash: accumulative hashing
  hw/misc/aspeed_hace: Fix SG Accumulative hashing

 crypto/hash-afalg.c           | 154 +++++++++++++++++++++++-----------
 crypto/hash-gcrypt.c          | 112 ++++++++++++++-----------
 crypto/hash-glib.c            |  96 +++++++++++++--------
 crypto/hash-gnutls.c          |  94 ++++++++++++++-------
 crypto/hash-nettle.c          |  79 +++++++++++------
 crypto/hash.c                 | 136 ++++++++++++++++++++++--------
 crypto/hashpriv.h             |  19 +++--
 hw/misc/aspeed_hace.c         |  92 ++++++++++----------
 include/crypto/hash.h         | 106 +++++++++++++++++++++++
 include/hw/misc/aspeed_hace.h |   4 +
 tests/unit/test-crypto-hash.c |  50 +++++++++++
 11 files changed, 667 insertions(+), 275 deletions(-)

-- 
2.34.1


