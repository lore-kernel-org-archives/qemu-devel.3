Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41646C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 19:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbmjE-0005ed-N2; Wed, 07 Aug 2024 15:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjD-0005cw-F7; Wed, 07 Aug 2024 15:53:47 -0400
Received: from esa.hc4959-67.iphmx.com ([139.138.35.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.zeise@seagate.com>)
 id 1sbmjB-0001yD-Ba; Wed, 07 Aug 2024 15:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
 t=1723060426; x=1754596426;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UZr8Q+rVP999rFDhN9tBozCwoxi1n6tg4pUav7eUXTg=;
 b=ClIWcM/soKUUM8hYJlcexxc71WES4nREFIjmPglGIKaEyCKoih5CMYQ5
 S/Qq7JG9O9P1hhXZteoaT6d1cMgvriCyMh2YG6Fl84TF43xPEJO480cF6
 CkVd3fXglGpcyw69hHLKcWygOYTISEhL0Z2LlNvEQc2c2ZtiTywcZ0uS0 Y=;
X-CSE-ConnectionGUID: 6bHxzzNzQ4WKoHvUs5aPxg==
X-CSE-MsgGUID: 5DgNqaotQt6xSgvmH5+Dgw==
Received: from mail-dm6nam04lp2040.outbound.protection.outlook.com (HELO
 NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
 by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2024 12:53:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwHkEmfynuvtDZuAsaqx4UCjJ/zbVBTI70Oz/8lGB5no1O8Ca6+NDmsz6CDev8PMvYIjbIOnQ2vCIx7zkW4Y5jiswOFbsQsQ3XBpIlPPScvC188OKjI86LHLF6dYL1wjT1haUHWj5O/s85zNVG7UiaV8i2tTO7c97u2VHWPAODJ729O6rimefXhKPpUfnKMxP8szeS543CUu+k0+Qx4GAkgstT6Bvc3CB19sOMi2RmpIumnPWbphJLoOllzXLYWUx9BXSXZJTKiv+vBFdrO9ii9th7puq1KF7Z2k64XuPz59BEIBh8p6Eg8C76hUnwqLO2HS9hqRC305YmJwuS0bzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOup/niNwxYnzZ78U6mY3ejsLMx7wSKTKo7PpqRXuLc=;
 b=qwSZiGsf0gDCPkp7AF0v5VAhW1/h6/1HVsPp978kCUxjFUCFxn7Gjcl5nKjNPgZngmiGSgJnlt1cc1f4j7fMbeR6ma4kBFO/7BRhzbJV+WIpnO0PUOCSpPq0642xR+58dtEq6ylqIuPpK6cGlxs8zGkxKQSkdz7aJ7vougvqCZ2Rmvfd99HujRcMyZPpSL3BKW7/CFO6SOSelw3SGJf80dsv39tEW23EyUDLZacNrJ1ONgV8fSDxzUjLUiUpG/OB/b1QmTJu4bvMzeyWAc4GSYKdpZQs946LYfN4Suz+u8GIHYW7d3vK+wtdlL9ReF5M8poCmQN/9FiCQFhnWlOnbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 192.55.16.51) smtp.rcpttodomain=nongnu.org smtp.mailfrom=seagate.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=seagate.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOup/niNwxYnzZ78U6mY3ejsLMx7wSKTKo7PpqRXuLc=;
 b=UTXw2dpZ3yJIpRg1gDGTVmxRB9HslCmGIszUA556+GrHtmq022upkvXtG8pvyxqU9zHRqxf+kTTaRHTffaiUuLJ1j8g5RgcIe1+MJDmICGnnauQ0zxHqKU9mYDSAk39xfINNyoalAbTbbm1WGtIaiBQdT61Pt+wt+dNfO11EQ/I=
Received: from BL1PR13CA0315.namprd13.prod.outlook.com (2603:10b6:208:2c1::20)
 by IA1PR20MB6479.namprd20.prod.outlook.com (2603:10b6:208:451::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Wed, 7 Aug
 2024 19:53:36 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::bf) by BL1PR13CA0315.outlook.office365.com
 (2603:10b6:208:2c1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Wed, 7 Aug 2024 19:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 192.55.16.51)
 smtp.mailfrom=seagate.com;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=seagate.com;
Received: from sgspzesaa002.seagate.com (192.55.16.51) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 19:53:34 +0000
X-CSE-ConnectionGUID: +unAZlVgQC2iESlX3n8KfQ==
X-CSE-MsgGUID: L/xu9SAhSOaEMWZaclHqVw==
Received: from sgspiesaa002.seagate.com ([10.4.144.53])
 by sgspzesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:23 -0700
X-CSE-ConnectionGUID: OnWT+4bFQ8SXJKxPR9YqgA==
X-CSE-MsgGUID: 1GGgW/s0Rtqe7OVDrtI64w==
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="122235452"
STX-Internal-Mailhost: TRUE
Received: from unknown (HELO cortana..) ([10.4.50.14])
 by sgspiesaa002.seagate.com with ESMTP; 07 Aug 2024 12:53:15 -0700
From: Alejandro Zeise <alejandro.zeise@seagate.com>
To: qemu-arm@nongnu.org
Cc: alejandro.zeise@seagate.com, kris.conklin@seagate.com,
 jonathan.henze@seagate.com, evan.burgess@seagate.com, clg@kaod.org,
 peter.maydell@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 00/15] hw/misc/aspeed_hace: Fix SG Accumulative Hash
 Calculations
Date: Wed,  7 Aug 2024 19:51:07 +0000
Message-Id: <20240807195122.2827364-1-alejandro.zeise@seagate.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|IA1PR20MB6479:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1abfdf7c-8d0d-453a-26fc-08dcb71a9fa5
STX-Hosted-IronPort-Oubound: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l2UtrojMxB4QYZ1YD7AtQsXgfbVO6YZ9Xz1G6tNSVArxs+AhrJvb2+1VQTFy?=
 =?us-ascii?Q?XsL7Rlq2UZRmSuQBtuQGPIQMDxoABs3hSlCUQC6IYksVs6kD5X47TuT/QIvK?=
 =?us-ascii?Q?ImaREQz4KqjIFB4BFtbV7b1Ys1ArX1bB7T5DGAMfNbj8mnuBCgK+Ry8HxV6G?=
 =?us-ascii?Q?XqCyZFn2drNnkYoH0F26zKZYJ1VVvf7ZlN7wMr2tLV21B6vJm4I+TP/Ud4Fu?=
 =?us-ascii?Q?xa1uhZtvB5YWkqYDB8OU+hMquIH/ypAmc8dgRZxK5AGgiESlX393oWBFlFmN?=
 =?us-ascii?Q?TB1dL0IwvMJkDNiNG7L3TGFg3dtd/mBANID3p0mBfh9kRLKHRlfQCcsAkSDp?=
 =?us-ascii?Q?ubwXzNXqz+vBaol4vUlI5rBf5w0N/fOmyNMmgYf77G+46XMU1Mz+MENYOLUe?=
 =?us-ascii?Q?6alLa9NLI963byRyLBuqZbzLapQjL5b0polVjnxQ008MNKq5eWA4vKg0JAU1?=
 =?us-ascii?Q?fOxbC8mMZdXTl43mNAh60y+l0PWnvfidmhSws/uLgXo8ME6F6GajKaAX0aBQ?=
 =?us-ascii?Q?DSh/U6gmVJS9AKDreMBJILb/h/371PcvF9ISawnQvcCf3vR6fs987S3UABSt?=
 =?us-ascii?Q?6BMnpR9m6oIqsxOda8p5ssrtsZxNarmGruM5TeRCZ9bbqJ/ajD1r9/78WUPL?=
 =?us-ascii?Q?B2vajD13OYFUAZydm+oxEIv5jIswbSsRPMTH1law9uu+L+EtoxIcgO1Nhl2X?=
 =?us-ascii?Q?B0GFWe1XNoZ9PMXn93f5NwgLknwJH2eKgIVi7cecQOrTdNUg8b1zXDL7BS6r?=
 =?us-ascii?Q?DUFGqHmUiJiu7NKsr/1fEYdEv2v1XkgQo3MP0RqIqahiXruTsfK4unX4R9UU?=
 =?us-ascii?Q?6yEdpFO8wPxhGu8OPHQjtepzgUPEtOKCh3AgWV9FkIJ/rhxhhnbKhoF4b9pE?=
 =?us-ascii?Q?DC5ZCU+WOe4RcvdLBRdL2pNX5SgOoKiPpnqmhd3e7MfICv43vpPNar7WDHrs?=
 =?us-ascii?Q?4BsNBeEKspIWe0vw3QDeUeY2lWPuDB1VALqCqHJXZfd9E/WUKbU33jjYCBBe?=
 =?us-ascii?Q?kp0CipyOeNLfGt6MNedQodKyWfxQEX0HAMRLdnYEv3lw5e2cQvmvPRCb9N4v?=
 =?us-ascii?Q?nEaU2wbcnTWwHufMy/En9VktHlS/zljlTwUrmSolm4DJlT9qGsIOQfO1Dz6/?=
 =?us-ascii?Q?3j/OvYm3JYEBIX7XwAd+BnLbf/zKKOTqgcjM9kwGyH+Uk8wVlIaBGkZ6Jx+v?=
 =?us-ascii?Q?k/D8J6gOfDsvjRFKQlNkUZQ98pkc9NZEk1s6uL6Rj7ZCC0Ogi4spe8oOArQU?=
 =?us-ascii?Q?3/CdXl7TIq8m7DUhbb2IoLE8Bjl8P3gLTmzyCCCCgyN3At0gIMMTY9cV+ISO?=
 =?us-ascii?Q?8ORS0CMN6a+nxGWll3ZUcLylQlxNSg4ED1V7PZh0VGweWR+kLJ7bVCyllaC9?=
 =?us-ascii?Q?qcOOBoUL18xedLojCFCyBTQD2uUCS34+nWM4Mn8f0TggodVR2/PIOCTKsjA6?=
 =?us-ascii?Q?dKsr+1NwQIG+qHP08gYUFMqQDoLpyQXE?=
X-Forefront-Antispam-Report: CIP:192.55.16.51; CTRY:SG; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:sgspzesaa002.seagate.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FWP0nfORCBSQ56efWnl3+9W8ZMSZVUE1MwGNGCuefxlClY1cNyX64Q3993Dem6zR5qLVmgQDC5oFyJEpSW95QOR2QwPX8bXFc/ioBVROU8R9VzN/rIcNWVuoM7g4nrHucnwe6hjco7y8OWt5iNgEGkJacalQVBDdlAyPLlRiMtVP5N6Et1wL+3kjOWu+/8lZekKC28OA9AAAtMi3/5QMGHCFKzHBWjKrVUURlCEIqHLhIsfJG9YP86WqMTf0FF9+nt2XlDEd9CeG29jWlQAzvEMwAyjjgApsjp+Sap6I20mNz3DLcBXII66R+uqThJtxT6NIpObuYaaNOOcb9ms7zyqxcVPBpgzpTd51nLWbro8kgyusQ0jwFcXFU4yYEJcEFKxu+yVtK0eHbdmdQVUHLK0KLR5JlVLlWG4DMav2VCV6sCLqxlUDu7OfxHTsTzIUjPwZBgIg3CH4VAt9Ldzx8XRomhwhUGNXc17PaaHpI9qZOXaYa1lZLQsZUwXPEF6HK+YTNpDBfBGo17xLTEGra+9rNm84dQ0AVoWDKozeWS57iqQ6wAo+GzFnRwpb6Erp3o1edQhYAwEdTTmxdJ8ZBFP2LEUoEjNBAEpogqCnA/1RIZAr/xHTRwJefvQZis5y
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 19:53:34.3794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1abfdf7c-8d0d-453a-26fc-08dcb71a9fa5
X-MS-Exchange-CrossTenant-Id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d466216a-c643-434a-9c2e-057448c17cbe; Ip=[192.55.16.51];
 Helo=[sgspzesaa002.seagate.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB6479
Received-SPF: pass client-ip=139.138.35.140;
 envelope-from=alejandro.zeise@seagate.com; helo=esa.hc4959-67.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Changes in V4:
* Restructured patches so unit tests pass for each independently.
* Freeing hash context is now a void function.
* Added autoptr cleanup function definition for qcrypto_hash_free.
* Separated qcrypto_hash_update into qcrypto_hash_update and qcrypto_hash_updatev.
* Changed public hash functions to use afalg implementation correctly if support
  is enabled.
* Fixed accumulative hashing in afalg driver (pass MSG_MORE socket flag).

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

Alejandro Zeise (15):
  crypto: accumulative hashing API
  crypto/hash-glib: Implement new hash API
  crypto/hash-gcrypt: Implement new hash API
  crypto/hash-gnutls: Implement new hash API
  crypto/hash-nettle: Implement new hash API
  crypto/hash-afalg: Implement new hash API
  crypto/hash: Implement and use new hash API
  tests/unit/test-crypto-hash: accumulative hashing
  crypto/hash-glib: Remove old hash API functions
  crypto/hash-gcrypt: Remove old hash API functions
  crypto/hash-gnutls: Remove old hash API functions
  crypto/hash-nettle: Remove old hash API functions
  crypto/hash-afalg: Remove old hash API functions
  crypto/hashpriv: Remove old hash API function
  hw/misc/aspeed_hace: Fix SG Accumulative hashing

 crypto/hash-afalg.c           | 171 ++++++++++++++++++++++++----------
 crypto/hash-gcrypt.c          | 110 ++++++++++++----------
 crypto/hash-glib.c            |  96 ++++++++++++-------
 crypto/hash-gnutls.c          |  92 +++++++++++-------
 crypto/hash-nettle.c          |  78 ++++++++++------
 crypto/hash.c                 | 163 +++++++++++++++++++++++++-------
 crypto/hashpriv.h             |  13 ++-
 hw/misc/aspeed_hace.c         |  94 ++++++++++---------
 include/crypto/hash.h         | 119 +++++++++++++++++++++++
 include/hw/misc/aspeed_hace.h |   4 +
 include/qemu/iov.h            |  26 ++++++
 tests/unit/test-crypto-hash.c |  48 ++++++++++
 util/iov.c                    |  22 +++--
 13 files changed, 753 insertions(+), 283 deletions(-)

-- 
2.34.1


