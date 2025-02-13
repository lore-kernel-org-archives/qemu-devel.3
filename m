Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B07C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 23:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tij1w-0003Ns-L0; Thu, 13 Feb 2025 18:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tij1t-0003NZ-5U; Thu, 13 Feb 2025 18:54:01 -0500
Received: from mail-bn7nam10on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2009::629]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tij1r-0006jQ-67; Thu, 13 Feb 2025 18:54:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8Es2okLH4Oj2UU8UxsFVgeT/IrMxlbJmpYnuLdN+YB4JvJJ3ViA2h8NWgfa2vDeVtTg6iv/PMvZug7VyJL+ZGOUeTKHgNLcliX1MrlirFqWc9RXgkbGtbHeaxATucHN0ZUarbuvQHtR+mIcVqm43JZxG/sWNBm/TlTYeyTt3b5G4Pl9gW2mi4+hpMMNV0y6l+OIM0qrImwRmn7KvJfpFuRwd7w5RKGfZTJSge9l5lFFWAyOj58bTl87/Vst+9ZI+kWCD4YFWZ5LQWZai1V+0SKPqG6ohIWLl3WGbRqa/LLN/nS3JvMV2XbL8WUwcVgr+N2xGsDQeXWGevAX69eY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhnTdFCogHOfEgi/cFMTQKqOFmewenOQup2zql6t/u0=;
 b=bj+4qEGpTKYMzv7WuirRcbptx/iVv5ji1nr98Vq0WjX5HrN2QU2eLWuok/ifQjzyZvsAZnHw8qPPSz7ch2oS/E4waQLsxE/OQ5S0MedDi/gM3yPYAvCb5Fc9FrFxtuZfaVB4ssEooNYRipNtvjP//5UJ53DbMNZu5q9WJVZBqPaQdZEWVitT8+85WGIfsG+8Gt9SGTYR71ASrlFROPCEaFzkl89lk+8ihHkA7b5S1cN8qoCtHNWYloRrU+1hidfy5CbBdbx3KaMpBvFlFtUeBozf2RzbBL1b6pLUdMcaWtUMuE0JTkjoP1D2CuHXHEdiKqMAmXTlSt/CWu5xTsLkdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhnTdFCogHOfEgi/cFMTQKqOFmewenOQup2zql6t/u0=;
 b=wpQKwIusX6+iy7Jt6GG23FdYMcdoOEL2IWwuUl85UVdsI2xXaUybxtuCaNDEKdVtxaXDumMQUyB4k/uPw4CqlkchvS2aGqYGjT9qx7VC59mdwOl2xYTmItkREJgAHh6EGGy6MlkpHnUEYTSv72bm+mtfZbFf9e7zm21x29ESUps=
Received: from CH2PR20CA0022.namprd20.prod.outlook.com (2603:10b6:610:58::32)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Thu, 13 Feb
 2025 23:53:51 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:58:cafe::cc) by CH2PR20CA0022.outlook.office365.com
 (2603:10b6:610:58::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Thu,
 13 Feb 2025 23:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Thu, 13 Feb 2025 23:53:50 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 17:53:49 -0600
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 <qemu-stable@nongnu.org>
Subject: [PATCH] make-release: don't rely on $CWD when excluding subproject
 directories
Date: Thu, 13 Feb 2025 17:53:20 -0600
Message-ID: <20250213235320.3100397-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a45310-3d51-47ce-4931-08dd4c89aa63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lTjHpBkSLmpHFgTmylAgBqQHgTv2dxDeqPngQbu9+LCWlx7VyIO6wj9V0BtS?=
 =?us-ascii?Q?cVuhNyyizz+t1rJO1Vi+Kt9G2zybAurq6Nuh0Dr9gcPFECHF9mOBGzY2QXYb?=
 =?us-ascii?Q?/0baXHmfrFdpeVGbeDzgelV1jkN4hCTx+dam/YQPN2ZhbH6rYxZXkCOYsdBh?=
 =?us-ascii?Q?L8HYvrypVIevdT3/GEexudj4akTWIgkd5NHSDaIK/uJa/CJun4l+5mBOWvOc?=
 =?us-ascii?Q?MsbSmXQnWrxXkZ9Ki4arCElAZafh3fPrLXeX1dzC3ZvRvJojeuteavGiZavu?=
 =?us-ascii?Q?ziTWVOgR2X3QAcmXPL+LO+PaAYQ+ODZPcvYydZkFTF5sAPyeTmbd5s+qC42r?=
 =?us-ascii?Q?Tl3cFxVkjOEZiD3BVxlmzb8lJLh9zPjMYEJ+xxKzPgaVtPdVT7QWK1aD7NkX?=
 =?us-ascii?Q?Kuh42vJ/7Ss7zQgdniBejRjOCzfJ363TOZluxdubnnbmCjVeLPtKAhJp6z8Q?=
 =?us-ascii?Q?L0ahqbwPticez2/3tBS8jE0oFvtWW//KT18WJC+9Jd/dYIAYBQWk7hxZco2w?=
 =?us-ascii?Q?+JX7cmvnSYbimNAtDJRiHhWbLUdkqhZQXhb+3gFGYEczwrj4rhUHlDGdez+n?=
 =?us-ascii?Q?m+4oXIkUFgZzu8ezbxx08Q4zj4TFXqMvgGQ+7t4adlg7XrSUePn5C3CnW3er?=
 =?us-ascii?Q?fFOELAk3pQS0/27ShivhC/tyQv0DQs8Uux1BdsNaSvXxuhN4jmhey6tXq1Mj?=
 =?us-ascii?Q?wxUf3UJJvMEmrtcu7EXTem5y/10sY+YEO5y/dChhGJ9M6VogOBl/cZZlq1CD?=
 =?us-ascii?Q?63oFeApZPSvcD0Qpr+drMDzcn36E33udDu4G/BJuZKM1nRPzjIpkaX/aertD?=
 =?us-ascii?Q?gu1QbjilYzWI6DRb1yItTvPRlJ9Ytqy7dVjri3AHsalLZwRAYAYeo/xWXYgp?=
 =?us-ascii?Q?zqBhACvx9ViH4PFScIeQLu1Mjif0+24nVUwVC8QSYpNrL3fyxO1AevscwQ71?=
 =?us-ascii?Q?0TMjotpCJMXJH1BYzDxuf8CsEoQu0gb+4xG18vmhmudEqjMErusQytvCXnv0?=
 =?us-ascii?Q?gu0681KxJSSDqH6nVqI1OZNwq4P9mzNXy5cgC28UO0kX86hiTrJ+VbFVnidK?=
 =?us-ascii?Q?eaZajbYy760MOFwS062qo7NbMK2gLBgB56K8a5Mc1R6FXfV5W1Wcm2yyEoJy?=
 =?us-ascii?Q?PXIJadrxS2PS5WjEkActU/nq78loYCFZTkJ2gP/BWD05ewuWtTP6i9cJ2z6y?=
 =?us-ascii?Q?8TBIDmV3J6oVeptl80/Un615Q4MliaA81KJh++mFCdQVDpjUzaHix29OxLTJ?=
 =?us-ascii?Q?kUguQANgpQpsjvWc83eWdd8G5kl7bbhc0EvUGBdjezipY7zW7jmAblHHf7Kp?=
 =?us-ascii?Q?SWVwyDZGJdq1DSQz99uYCsQWpuy0/XyXoU4IoFo9uyVXxESKNH+g9uOclmGZ?=
 =?us-ascii?Q?HA2rO1Gek3D7DmIvDd6qez5X4J9JfuBI4pU3Mjhc3EhUN90rOqq67BodxCSE?=
 =?us-ascii?Q?C7qP5HM4b8s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 23:53:50.8561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a45310-3d51-47ce-4931-08dd4c89aa63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158
Received-SPF: permerror client-ip=2a01:111:f403:2009::629;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

The current logic scans qemu.git/subprojects/ from *.wrap files to
determine whether or not to include the associated directories in the
release tarballs. However, the script assumes that it is being run from
the top-level of the source directory, which may not always be the case.
In particular, when generating releases via, e.g.:

  make qemu-9.2.1.tar.xz

the $CWD will either be an arbitrary external build directory, or
qemu.git/build, and the exclusions will not be processed as expected.
Fix this by using the $src parameter passed to the script as the root
directory for the various subproject/ paths referenced by this logic.

Also, the error case at the beginning of the subproject_dir() will not
result in the error message being printed, and will instead produce an
error message about "error" not being a valid command. Fix this by using
basic shell commands.

Fixes: be27b5149c86 ("make-release: only leave tarball of wrap-file subprojects")
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 scripts/make-release | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/make-release b/scripts/make-release
index 2885e87210..1b89b3423a 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -11,8 +11,9 @@
 # See the COPYING file in the top-level directory.
 
 function subproject_dir() {
-    if test ! -f "subprojects/$1.wrap"; then
-      error "scripts/archive-source.sh should only process wrap subprojects"
+    if test ! -f "$src/subprojects/$1.wrap"; then
+      echo "scripts/archive-source.sh should only process wrap subprojects"
+      exit 1
     fi
 
     # Print the directory key of the wrap file, defaulting to the
@@ -26,7 +27,7 @@ function subproject_dir() {
       -e    's///p' \
       -e    'q' \
       -e '}' \
-      "subprojects/$1.wrap")
+      "$src/subprojects/$1.wrap")
 
     echo "${dir:-$1}"
 }
@@ -76,7 +77,7 @@ popd
 exclude=(--exclude=.git)
 # include the tarballs in subprojects/packagecache but not their expansion
 for sp in $SUBPROJECTS; do
-    if grep -xqF "[wrap-file]" subprojects/$sp.wrap; then
+    if grep -xqF "[wrap-file]" $src/subprojects/$sp.wrap; then
       exclude+=(--exclude=subprojects/"$(subproject_dir $sp)")
     fi
 done
-- 
2.25.1


