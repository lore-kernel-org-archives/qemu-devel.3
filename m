Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB8AC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:05:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCQ7-0005XH-Bz; Wed, 29 May 2024 02:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCQ6-0005Wt-Bj
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:18 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sCCQ4-0002te-Mf
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716962657; x=1748498657;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1fiX4Z8+nFmItgDfCemdyuD7iTt8rkgiZ1jp71LLNzs=;
 b=BAN2PREgdx64jyNhk8m1UAKTDP5M6njmjRUUZ28572cJ5YcOsUnhe8J9
 TbQVdpsANqq3Fou6a7ITn3KyNo81he8aWewbhxdV7GXaI0E2LMHE9Vm+c
 id3s/CZy5I3mDK187rMEOV3DOpEzES8oaCwJyvmdXo9CX0FsMram8DT/Z
 aplbCQGdVhyLm1bflwFWWE3gOheMWCLDDWj9+tf0zBRCdER6iSh5/rlKF
 PeKOLuQiPKECP+hbHh3GbEP8/MKGx4j91ONJk1KqZoyngPPAqww/iiP85
 xnwZBuVRXEeqTJ83tx1rDYGPd7RBb9cinAUDZKl8IYW+sZo6Fdr7RCSft A==;
X-CSE-ConnectionGUID: IYkLDzD1Th+Jw9Hb1lqmyQ==
X-CSE-MsgGUID: C6WcqmulSGK5Lpa2Nz3nAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13187486"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="13187486"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2024 23:04:16 -0700
X-CSE-ConnectionGUID: z7JNqKDORSaQx9kjO+i7RQ==
X-CSE-MsgGUID: 7ZTrkwWwQQmRzZTIrNwQKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; d="scan'208";a="40144722"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 28 May 2024 23:04:13 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Yongwei Ma <yongwei.ma@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 4/8] tests/unit/test-smp-parse: Use default parameters=0 when
 not set in -smp
Date: Wed, 29 May 2024 14:19:21 +0800
Message-Id: <20240529061925.350323-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529061925.350323-1-zhao1.liu@intel.com>
References: <20240529061925.350323-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Since -smp allows parameters=1 whether the level is supported by
machine, to avoid the test scenarios where the parameter defaults to 1
cause some errors to be masked, explicitly set undesired parameters to
0.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 5d99e0d9234c..e3a0a9d12d05 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -436,7 +436,7 @@ static const struct SMPTestData data_with_clusters_invalid[] = {
 static const struct SMPTestData data_with_books_invalid[] = {
     {
         /* config: -smp 16,books=2,sockets=2,cores=4,threads=2,maxcpus=16 */
-        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 16, F, 1, T, 2, T,
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 16, F, 0, T, 2, T,
                                                 2, T, 4, T, 2, T, 16),
         .expect_error = "Invalid CPU topology: "
                         "product of the hierarchy must match maxcpus: "
@@ -444,7 +444,7 @@ static const struct SMPTestData data_with_books_invalid[] = {
                         "!= maxcpus (16)",
     }, {
         /* config: -smp 34,books=2,sockets=2,cores=4,threads=2,maxcpus=32 */
-        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 34, F, 1, T, 2, T,
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 34, F, 0, T, 2, T,
                                                 2, T, 4, T, 2, T, 32),
         .expect_error = "Invalid CPU topology: "
                         "maxcpus must be equal to or greater than smp: "
@@ -456,7 +456,7 @@ static const struct SMPTestData data_with_books_invalid[] = {
 static const struct SMPTestData data_with_drawers_invalid[] = {
     {
         /* config: -smp 16,drawers=2,sockets=2,cores=4,threads=2,maxcpus=16 */
-        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 16, T, 2, F, 1, T,
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 16, T, 2, F, 0, T,
                                                 2, T, 4, T, 2, T, 16),
         .expect_error = "Invalid CPU topology: "
                         "product of the hierarchy must match maxcpus: "
@@ -464,7 +464,7 @@ static const struct SMPTestData data_with_drawers_invalid[] = {
                         "!= maxcpus (16)",
     }, {
         /* config: -smp 34,drawers=2,sockets=2,cores=4,threads=2,maxcpus=32 */
-        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 34, T, 2, F, 1, T,
+        .config = SMP_CONFIG_WITH_BOOKS_DRAWERS(T, 34, T, 2, F, 0, T,
                                                 2, T, 4, T, 2, T, 32),
         .expect_error = "Invalid CPU topology: "
                         "maxcpus must be equal to or greater than smp: "
-- 
2.34.1


