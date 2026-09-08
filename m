Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC48EC79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tIo-0001q5-FN; Tue, 08 Sep 2026 06:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIm-0001mu-27; Tue, 08 Sep 2026 06:43:44 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x3tIk-0006jE-73; Tue, 08 Sep 2026 06:43:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dc47l0MaRD4FX5lx81qj97YhdS6OU/jilJR7WL1d8mQ0SFFCzpnhRtuCB42c9PKFz2B8k8ncZNqt6/EVEJTpnMsiwEl7G2iVHLFgLtjEdrBfAqKIf4MuRC/qYUFcBKi6ubHzNKplJpnL+ZtjhBwuA5jDfY+UtkJPJRLAq0+7+k5YB3AALc/Uw6R7oeHfXxtIkRYChFW1pyar0AcwS9x+QTe7Z9n4A9eSMaTBw9vf1QbFsKQn5dQ2Zsl4hWnaDaeDdL4TsagyoOHzGav9ryNeIMOSulLQ8ykI0mBYBQhZr1fZX5r+rbB6+Ghk4W9g++NBi1Xvz6xOKOKL+r9LBZc5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2Mwtf6ufQ2BTKr1+tIn7JMew4bc8JQQe5f65TE+1Ik=;
 b=UiqECZBtZ49T5H1nD3tCTxAVGW1JmKdQqeK/LoU/6fwcNYSDmzo/z2o71lvNYIexMx5OXbUoX/Mt4JW/vq7SRjqnWgwjxJ0412RTcBXplc4auDHHvbDQUfS0+OKPg+amPD45Q69Q+UEZYQxK7aldXEVdlaSEXSnNN12N8N1qRrHr8RbUjhj7jGdO4JOa5kdTRQ64nst3x718Tu+rhFgsnVKTwtibPI+FEnb7dt66a6E+d+HDbSK7DnBTClxNBQWSPL3Feaf7f60DQ0XC5q5o74DDk/Y39QEjSNaYny2JmWidmie8Pbi6K9S1d2c3O7bWVGOTlmK7snITAEXXTDEgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2Mwtf6ufQ2BTKr1+tIn7JMew4bc8JQQe5f65TE+1Ik=;
 b=bK0jevN0dwY5G8M++zpTcenpgZh0TVVdOOlp+PiwQwVe8F39vQhM3MCEj7Q1iJzWobbEzyUjNH3bOYDS1XIlXs3D+Fs+jn0ti6Ns2y3s0/HhueDUruE0jZP10vq4+x7il5mPBzTIOZq0uNZm/hQiouAhivQuNp4bhPBhzwUWTB2V6qElVSpcy1dQnxa1IbBmYt92j/nmUl4S8+kROi52qTNllCtBzj84QuIrhEmFupRQ4PE2lw2BXTcCghCXhkTSYf+Ls/kbdKOk4W/d4BHjxZ329952VND4GkspCDoIX+L9t569K68+oYt8rc17PZm8RN6xcp21kwqbb9z1WYy8GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com (2603:1096:301:78::7)
 by SEYPR02MB6579.apcprd02.prod.outlook.com (2603:1096:101:139::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 10:43:34 +0000
Received: from PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616]) by PSAPR02MB4984.apcprd02.prod.outlook.com
 ([fe80::fd75:bbda:6f27:c616%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 10:43:34 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 31/32] tests/functional/aarch64: Add Phytium Pi boot tests
Date: Tue,  8 Sep 2026 18:41:40 +0800
Message-ID: <20260908104159.1621764-32-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908104159.1621764-1-bin.meng@processmission.com>
References: <20260908104159.1621764-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To PSAPR02MB4984.apcprd02.prod.outlook.com
 (2603:1096:301:78::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4984:EE_|SEYPR02MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 720107b9-3114-442f-e9b5-08df0d95f6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TOvefMDeeOBNZ+HFKMT/hA5WZFv3iI/B7uIZA8qdRAvH1d7MLbBbT2wgyr9TjQJxa9qn1gq3yX4pSyDdWtrQK/gLLjrLpkdj5ynglvGz3ZGIMUP5sxbm9IA9u01cGdR+ERxHGQ143IME07BltyynGV0Wj8lFF/+8pNN0nl0PTXM+ZKu9z3+vUnQRCpUM6bSfXIbYLRyC1IH/CRG0H8rGJMH7W9uxN20BtRcmCPfjLSVlguRfFNocuJC+KC5XiaJTwXvwwu3+ztv8BVOUTSg9+JQrCOS56IESL0f0cLpYW7ykItAhBixSXYIlYuWn96EoapwK3oWKRi5/XzMePEviYCFxe2Dt3er6+ACOiXF82f/faKHPX0EOw/w1FgXZol/EXOpY10n2pFhzryBaPT3WOUqMBNvFBG3E6Szfmr6z5dUHBQcJKHodkE9N8mFfUsrAUoJS4IRWGNVXTnwPPTnLS3HnjtnV7y3ZgRi/Oy9VmxH/vk178AB54s7PONQOCCQEo6+En3hOHFPXGlc9d6KFX7aYYyzrpQ5lHbl12qSR8pAn7amUzkiMmkonSo7g67IseYajAKpZbaV0u3py0be9VqyyNBplf9ngHvXQJbnz7ENBwBrF2z3FKnId1p5qPhkqQkjx0RA+V9C866z6MveTeFNHJQ0IwpiRusx0mxuZsFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PSAPR02MB4984.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmNUd2J1NWpUWERuSTdqaGRUaWhIbGtrMUFzTGhNdW9raTE0ZjBXSTBpd1BN?=
 =?utf-8?B?Znd1b2NPSlovN3lMQThCOFczdENJQmJDL2lSNm8vM2VsOFJYUnBUVEpjZkpD?=
 =?utf-8?B?ay9uMWlvYllJRVNQdGdVWXpVVXhHRHQ5ZElSclBFVGxCMHpPanFMeUh0cDYy?=
 =?utf-8?B?SVBQb2xtM1JCV3VmY1ZMVGhlalI4RFd2UFBBOWQ3ZTczbjVBcktrM2dGUG9i?=
 =?utf-8?B?bDl5cCtmazlKa1FRQ2xreWhuN2xJVnl6UWQrS1VRNjFDOTRCVHFzWUt3UkN1?=
 =?utf-8?B?ZzVvU3hBcEFPQmszZkk3TlRtQTVZd0IrRThsdy9JK2J5MUt1Nkh1THBMSWh4?=
 =?utf-8?B?Y3BBQzE0cTQ4elBobkFhdUpXWUd6MlYrajkyQ3l3Rkl0aTY1R0RpZUtEQ0l1?=
 =?utf-8?B?RG1RNzlPSW5UZEROdVQ5NjlCU09vSUd4WWNCQUs0V3BqYWZHU1ZGQmROVGwv?=
 =?utf-8?B?bG9vV0czSnhvYWZ6cW1zS080R05NSXlKeTF4clF2M3hFd1ZFTlNpWngyMGZF?=
 =?utf-8?B?VmVpWStoTmMwd3QwTDgzM2tkdjAybEtXM3k4cUp2d2JJZVJUVmY2Y2YwaU9h?=
 =?utf-8?B?eUJIcFJuOE94RXMvWjVjWDNocGI5cGZkY0NQTlc1dk5VeUlFVTAxbVN3MDQ5?=
 =?utf-8?B?UlNFenBNL2F2UjJlbWlXR0h3dGtVZXg5RVBXWTViQzduQ2JqSnowUVIyMkY4?=
 =?utf-8?B?V3dTZWZ3VWphbnZsOG5OVS9ickdscmJTQmpRYXJMUGhXZ24xYlFZdHR1VXRr?=
 =?utf-8?B?NzgzKzFhdHRKeFUyYVNFYUhPTmtuU2xXOFdjOGNjUEl1cmdmdStCMVcxVWc2?=
 =?utf-8?B?ZHl6VkZDUzMwcTlDOHZ5cUV6WjZYYVJFUldpTkRCRkNvZ2ZrVXpUYWVTbTlm?=
 =?utf-8?B?V2Jpdm5Ld1JyWm8zczRFVmFreWlPdy8wTzh0SlZMRW10b1JLYU9tRlJTS2ow?=
 =?utf-8?B?azNudHpIMzVRTUZMODFFUjBNV2d0UlFJc09ZblNBNVRQaTlmeXJwbDdMUzJ4?=
 =?utf-8?B?L29aZUVFclZDWnkxcE5XU2swaUdFcTlWWWtacFd5aXZLci9BU2lXcldlMGtR?=
 =?utf-8?B?ZWcrazhpYWdWdmpqVUJkbU83ai9uaXV4YUsydDhZbUJac1UrTFcxRHlIMGFi?=
 =?utf-8?B?RkNCdjdkODhZY0txU2EwQURmWitveHNIV2JOaFNXa1RVS29ITThIKzJxc1Fy?=
 =?utf-8?B?SVR4d0R3TmczT3g2eGFwOEJodFM5SjlPYnYxOGlncVcySGRhZDF0TGg0QkxR?=
 =?utf-8?B?bi9jcjVLOE9tTVFrZzF1U2hBUGRTM2xLbGJCUWIvcHRrMUFCb0hiSm91RlZJ?=
 =?utf-8?B?R3hKb2YxbythdVh0SUtHVXk1MHo1SlhhWkphT1FuaytmUFpzdi9SUllkK0FG?=
 =?utf-8?B?QjQ3QTYvdVpKZ1dPUXJHemRaNmRPeW9jMG1RV251cldleUJuM2o4ZDJSWFMv?=
 =?utf-8?B?eTMzS0dEWTh2NlZQUjdnOUl3UHcydHBzOGxZOC9ZbVNybklZQ0pWWGF6Q1RZ?=
 =?utf-8?B?OVViNGtqQnh4SktNOU93UGlZRDgxdmR5ak1FeEFDUFh2K2VUQVErS2g0S3c4?=
 =?utf-8?B?cGVaN1Noa0loYldta3VmbDlqU0tNM01KZlpSS3hDckp2SlFiZkhFTlZicXJ2?=
 =?utf-8?B?cElxWU9uWUVpUi9xMzdEbWoreG9tUzE1ZUMyL1lrWExqa2MxTFVVYVNTUjlE?=
 =?utf-8?B?Z0FTWG1SWExSWEZLNDVUVTVBSmJEVnFFQmpKNTAzcWhHQ3FvalpIaUNCaS9z?=
 =?utf-8?B?MHlzdEgrV2NmU3c1dXhPU1RPdFNxN01vaFZ5MGcrdVhKbWoxaHNiVlJBZ0hE?=
 =?utf-8?B?bVNTREtMSVhWNDYxUjBUUHcrdTZRWCtoWHJlWWNKbmtiTnFLcnV5WW1hVTdQ?=
 =?utf-8?B?Q2o1TGNXbTBoRmxJdzMvUm1pMXF0TUJuWjIwcnJBcHVQQnljV0pLeWFBNzdy?=
 =?utf-8?B?TWVsNVBneVNXUlNMRVVacGVqWG4raUFjVlN2R0FGVnZhaGlvUTJMZDM1c1RW?=
 =?utf-8?B?UXdCYnFEMVdBeUc4Z1pOeFdrK0FXRTFadmRPWGpzRFUreXZmc2RseExEUTFB?=
 =?utf-8?B?MkQ5eVVwd213TS9Fbnd6N21nVy9zOTZYdUtmZmMwdExWb0dtSTVnY0ZDYUlD?=
 =?utf-8?B?d2MzS1ZGUlBUUEp4UVd2RHEwVjNTT3N0ZlVjZTE1WnVPY0VmR2tMamppWDA0?=
 =?utf-8?B?dDVqTCt3MWU0M2xodWJqY3IrcUxYOWpSMk8rcVpnWFYyUE1tcmRDSEF4V240?=
 =?utf-8?B?Wm1KM0pUMCtONUdwd21TbnJNVHh1ZkVoei9nd1h6cHdleTk5ZVJaemcyZnV4?=
 =?utf-8?B?anVuL1VxcWkvNW1iR3BXTWN2dWFRVDlxdHZxR0lITzdWU2JhdFhlemwzbHN3?=
 =?utf-8?Q?Vmv/MLs3k3H3373I=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720107b9-3114-442f-e9b5-08df0d95f6c0
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4984.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 10:43:05.1810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMZ2Lf64G968j1HHrZj3Yz+UZqhkeBtIUGOdfMNgFtdq4YAA6JQqUPOcvHQZpw9zPRVsUuOjviXMv26pqtkC8P8+Y522yZgUeCVk3uQVcrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6579
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=bin.meng@processmission.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The Phytium Pi machine supports both the board firmware flow from SD
and direct Linux boot. Exercise both paths with an SDK image bundle so
firmware handoff and kernel loading regressions are caught.

Verify U-Boot, PBF relocation, the Linux handoff, and login for the
firmware path. The Linux test loads the bundled kernel, DTB, and
initramfs and waits for the same login prompt.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---

(no changes since v1)

 tests/functional/aarch64/meson.build        |  2 +
 tests/functional/aarch64/test_phytium_pi.py | 77 +++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 tests/functional/aarch64/test_phytium_pi.py

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index f0881bed16..71bf45e4ea 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -7,6 +7,7 @@ test_aarch64_timeouts = {
   'device_passthrough' : 720,
   'imx8mm_evk' : 240,
   'imx8mp_evk' : 240,
+  'phytium_pi' : 600,
   'raspi4' : 480,
   'reverse_debug' : 180,
   'rme_virt' : 1200,
@@ -39,6 +40,7 @@ tests_aarch64_system_thorough = [
   'imx8mp_evk',
   'kvm',
   'multiprocess',
+  'phytium_pi',
   'raspi3',
   'raspi4',
   'replay',
diff --git a/tests/functional/aarch64/test_phytium_pi.py b/tests/functional/aarch64/test_phytium_pi.py
new file mode 100644
index 0000000000..4ae0392bdd
--- /dev/null
+++ b/tests/functional/aarch64/test_phytium_pi.py
@@ -0,0 +1,77 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the Phytium Pi machine
+#
+# Copyright (c) 2026 Process Mission
+#
+# Author:
+#   Bin Meng <bin.meng@processmission.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset, LinuxKernelTest
+from qemu_test import skipBigDataTest, skipIfMissingCommands
+
+
+class PhytiumPiMachine(LinuxKernelTest):
+
+    ASSET_BUILDROOT = Asset(
+        ('https://github.com/processmission/qemu-machine-images/releases/'
+         'download/v1.0.0/aarch64-phytium-pi-v1.0.0.tar.zst'),
+        '5219d52b862e1245b12f79ba72e9a6144f5e0cf1a50061f8fda2db0aeeb92428')
+
+    def _prepare_images(self):
+        self.set_machine('phytium-pi')
+
+        archive_path = self.uncompress(
+            self.ASSET_BUILDROOT,
+            target='aarch64-phytium-pi-v1.0.0.tar',
+            format='zstd')
+        self.archive_extract(archive_path, format='tar')
+
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-smp', '4',
+                         '-m', '4G',
+                         '-display', 'none',
+                         '-nic', 'none',
+                         '-no-reboot')
+
+    @skipIfMissingCommands('zstd')
+    @skipBigDataTest()
+    def test_firmware_boot(self):
+        self._prepare_images()
+        sdcard = self.scratch_file('images', 'sdcard.img')
+
+        self.vm.add_args(
+            '-snapshot',
+            '-drive', f'file={sdcard},format=raw,if=sd,index=0')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('U-Boot 2022.01')
+        self.wait_for_console_pattern('PBF relocate done')
+        self.wait_for_console_pattern('Starting kernel ...')
+        self.wait_for_console_pattern('Phytium login:')
+
+    @skipIfMissingCommands('zstd')
+    @skipBigDataTest()
+    def test_linux_boot(self):
+        self._prepare_images()
+        kernel = self.scratch_file('images', 'Image.gz')
+        dtb = self.scratch_file('images', 'phytiumpi_firefly.dtb')
+        initrd = self.scratch_file('images', 'rootfs.cpio.gz')
+
+        self.vm.add_args(
+            '-kernel', kernel,
+            '-dtb', dtb,
+            '-initrd', initrd,
+            '-append', 'console=ttyAMA1,115200 '
+                       'earlycon=pl011,mmio32,0x2800d000 rdinit=/init')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Booting Linux on physical CPU')
+        self.wait_for_console_pattern('Machine model: Phytium Pi Board')
+        self.wait_for_console_pattern('Phytium login:')
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.53.0


