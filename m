Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31F3EA4E07
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx3tf-00069a-TX; Mon, 02 Mar 2026 09:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx3sQ-00052V-5I
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:04:18 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx3sN-0003rN-OT
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:04:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGQE3h39Dz62xGRdYfHGAOwntcOGLY3GzJ4DGNPogsK4HaGTVWmwQnN6+1paQ31LvasLps6vLzZxpPHpYzJyor3jEFZF35FfMyTBnEex5eRmnNW7LbmJE045zWn2InukHE07aSDAmNFnz7BsnhJMhT/YkyENVu2oeLGDdetObwlWIBh3hgEZsvvznjusiMcA0JoSC2L0eOoxepY565m8DH2uDmiK89w2+gmRTUYAZuUp3ch+BMYbzplZSWy5II5NR64IggQgsQpJWjG5FixDzt6VZuPwSywe5T99R/kXXYTMsDrHNoqd3GdVHoyCz+fqDdTchCJ5MohjxMsE6NrwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A1hW6ZIYH0mOw4HKORhLgmid2hj+3pe+wmCtQdpK0Q=;
 b=K9zN9jz8bGW9HrK7b9xiJgAYi6ZaEBegRLBpta4WtlW3baiF49K/dSs5TpPVhtC4li68Ygmi2Z/Zoc04byN5/5xwzgL/c9xlDapbvwUTb969RRgjn/IOk9ekJcWP5j11yAHEw3zb1HU920QzAddgT900DH/ogAOZU0p1YhZTqGP8xjeGhr6FusPARbjM3jg2VVdbMMF3U5ymp6pFn4RRdcWKgq5olA4NyIBTAHgcdsZiEVTKsUsGrJMXFuheZH2pQjlEadzC6Fi3Tgc/sZYN/lUtJGr0FzjrjsjLglSnR0Xgp9XWGsLiSopE4ZMo782VDFyUqqbUHdKQbp9bcL1g7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A1hW6ZIYH0mOw4HKORhLgmid2hj+3pe+wmCtQdpK0Q=;
 b=XQHz2/DkkU0nyI6iZxZBqFoIxYBlPprDeJPWC5Uq7xL9zioZl8gqKzL3kdwC+dh7pJtSVpmphqyqN9J+WAr046+c0QKwQ2sP7MId98u3lLFJPBWa2w0krFsHKtRhQQ3XH8ts1zleJklw91yxwzEAPZpVy6G+Dl2/pFGzc0uTOfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR4P278MB1788.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:03:50 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 14:03:50 +0000
Message-ID: <80238c4b-2a40-42d3-b9c0-2a2b000812b0@epfl.ch>
Date: Mon, 2 Mar 2026 15:02:13 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 7/7] tests/tcg/plugins: test register accesses
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR4P278MB1788:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab8d4ef-e2b2-4325-ce5a-08de7864876a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|786006|366016|376014; 
X-Microsoft-Antispam-Message-Info: JPXFtkseR3GJTCKLb/vRitpo8gwZLv7HiVmBhsAvebNn/xZArrhqVXr4HPssDxyHm7TQDVzxMctxq29trl785kwIjIYIRcOs6mY72jfbNSsATJDU72chSqhSV8xtWaZukVZeK+wlkq1CMik7GFJZmlrRIrM65sBpf4Nx8Ij6KrGGrgDinhCR3lZq2ViZ7UXwjymd7kKJsxzTSZeqc/es57oC4Gyppzmad+rRH2yJFndA6ETVoJp5aE7xtWwE3UqiOwpCjHZjTEzTN1dHWO0qOhHa6sFUOOQ/GlfFTi9Z+fzHMxk7v5orpHFPH//nOn2soqUSmkAMUiOYoONPgL2VCprhqM7lJFY7MROpstI325xNGYUAJxIH2A4Su3bIa4VhTTxQLnIEK0/S8qvSOK9Walm8ggmbvF//Kq2+KlH+V3hKWG3zjSgZOexj+OJyUOHBDB0WV+6f4gOUZfM0iM1Ivt+YEZWirCqE2PypDqx0iRB5v382Mt+RnkGfCDq5avMElbwvMGbRkMcZk/TEcCS2QNtH6pYiU6H3/vFNCWX6MlbKOf3S6Xo3P9vvh2G6P3m6e23Zkza8npYROq/MMfN0Eh4EzwwxFsg/b2rFfLylcqdICoMFsfLGLzZ6xTnKIGgqAByYaYyhJmEYrBr8i/iN7lTc2qNx+6xjr7BWP2sey2vMBQaZj/UiDXMrelxnaO7otJZ0GZouGkCNJDRVixIl9g4wqSplWO3ufFo5AcuAj58=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(786006)(366016)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWRIZFMvQ3VvRnh4ZERpbjBsaTVFV0dqWU9zWitYOVJieTZjd1o3OXVnSFpG?=
 =?utf-8?B?R05MVkgxbmVoNC9UdE9OaGpla2NES3hQVHB4RjBZV3dybHB1eDN4YmxLdWlh?=
 =?utf-8?B?YzJtZ2RvN1Iwei92UFhHQWJ4NU1zRlhrdGNWb3NGaU5xZkVIbG9GeHdROVUv?=
 =?utf-8?B?ZFU2ZFp1Y3luWFRJeFI1eGt6UTNFVVhSVHJWQ1R6eFNhVFpmQUdTSlZhUkxH?=
 =?utf-8?B?MSsvc01mYVZrdnhtZk44K1Z3dm9RUWFsZVJWcUVyMG5TOERxdXNjbjRzVmV0?=
 =?utf-8?B?MkRucHUrY1U3V1JrdUJhb2p1UkNRck1KenR2a0wxemRJL21peHdiRGFSVFQx?=
 =?utf-8?B?VUd6ZmpSNmtYa3F1NXhaSmJpU2Q0R05IMXVXd1VhRXpyTE9ZSGFkVUV6MW5K?=
 =?utf-8?B?bWlqSVphK0l5T0RxTW45cWJMMWp4clR1dE0zU1RxdW5GMExxRmxNK00xSWdk?=
 =?utf-8?B?Vlk1OFZBZHFhejZCM1M3SXVEbTFkeEtDV1VpK1JiY0krT0Q5R0VGRkM0bk5p?=
 =?utf-8?B?WTZIWjlqSjBKUUdtaGNxakEzY3lmeHo4L1Y4U1AyZkhTRm8zblVBNWVmc3ox?=
 =?utf-8?B?bWp1bkRxUE1BNXV2bzV1dWVDYUo3MXFHWWF5S0dwQUwyT1J5SHl1ZzdYaUxD?=
 =?utf-8?B?bW44SklYTGxmcXQrR2FoL1d1MnNuUGtUTUFWN2dpUnZETmlNWEtRZ0hEdDVm?=
 =?utf-8?B?ckZnODR5WFplbFN4MmhrdkNWWkgxUCtNZy9NL2FuMVYwR2hLaDZlR0FNeUZn?=
 =?utf-8?B?dzJHeUt3cVYvTkU1eHNhVUMzdjc2STQyaENJU3F0NytlNU04bHEvRHEyZmZm?=
 =?utf-8?B?TE0ySjFjalFUSnRjelBQZFdJeGN5d1RtZTRQSksrd3E3OVZtRHhVMkNMOTBp?=
 =?utf-8?B?NktpYkYvU1ZFYmlDRE5qdi95VldKMlJ2QjR1SE5xNXZSQkRQZmpLY3RCbU1B?=
 =?utf-8?B?WXhwZ1lGYldENEFIVmpyTUdGbWYvLzBFaHZTQjdCNHRORlFjNGNIaEp5ZXVR?=
 =?utf-8?B?SjR0WVNqRDBlTVYvV2JmUmZzRzRFVTlUM0tYVmdGN0ZYVWd2cUJLK0Rycm9W?=
 =?utf-8?B?ZWMvakNCbGNrTjlGNXNxWGlYQWJsdXh4UUtFNmJpa3ZtWjhFQmJyOU9hRkdZ?=
 =?utf-8?B?RitFc1plWTRkcUxEK3lnd2lzU2RVNXQ4bzFDRGl1blgvMmJheEh2Yi9EK3lL?=
 =?utf-8?B?ejk1OU45UWdUR05MaFlKamRjczMxNWFVaU4wdTIzc2R4aW5uZkxMcm1WaXgw?=
 =?utf-8?B?bjgwQkVFaUNTdkcrMmxxdkNvcGVDSDRPWkNlcXEzWGV1WVAxdUtRR3MwTzVG?=
 =?utf-8?B?OG9TWHlLSVZsREw5dExOcE5MdkMyQUxzUDNGbFhVUnhpN2lYY3BmeDdoQ1U3?=
 =?utf-8?B?cndVV09CRklJTUtNYS9mQmJtZXBBK1g4VGt2QlV6ZzZDanBScExnQXBoc3RO?=
 =?utf-8?B?OUlWWDFaeUVFb0xyMmk3eHVJUFJMVkp2UG1NTm43RjdxUG1XR0N2RzhBZWRl?=
 =?utf-8?B?UTZjalN4cnJUR1VualprdloyUU5iVzlsWjAvSlp5MnpoN21nc3pmRGNrc3Fo?=
 =?utf-8?B?dnBoRG5pNWNYb1BYdWV2Sm5nRlBFWm1tVWZGNW5aM1lWRjNBN2J1UElpZDlo?=
 =?utf-8?B?RysvdXdoMmVkNVA0T1NJbnRPUGFMeHA1ZjJiYzZUY1R3M1BEK1dpVE12Rlgz?=
 =?utf-8?B?TE45RGE0bFJFMXhNSHJCclZxSVJ2cXVaeG9YYU9qcmluQkx6N3RFVFFOdGZ4?=
 =?utf-8?B?YktXQlJRNUR1dUJ5Y0dGbXdndjJyNis1cC85QTh3Z2FzVjkrMEZNcmNIdXNP?=
 =?utf-8?B?MWNZdEZzK3R2YW1IRmxQRVZSWmk2cDczVTN5Y0lCakJGcjN0cFNFbGN1bDlz?=
 =?utf-8?B?SnBOaUlFMnRwa1Z4QzBYNGV5Yk8wMFJ0b3lWVG10QWdZQkpJWjNHZzI4amNC?=
 =?utf-8?B?S3hKWXFkcklQMVl4VWs2MGVYVlhrVGxnQTBDN2NBTkxEblNkc2Q3eFpXemdS?=
 =?utf-8?B?c283QWl4Zy9BcnZWaGZQUnZ4V2VzNlAvSmRyQjljVkpZa0IvZlBKNnVaSmhi?=
 =?utf-8?B?VjdSL2IrZms3ZWpHZXJRSlg5eng1TWs5NzFQRTBDL0t1Q1RtbEYzSXExYUkr?=
 =?utf-8?B?RFlnbXM1SDdRdHdocWlobThtNzExNFAyb0dDSXBYSDAvbHozNThSZjh5RWI0?=
 =?utf-8?B?MTh5b3NlWlpvV3pyc3BaeUVMWDNrSHFiT2U2QlFmQTlOcUF6ZitPYkQzM2pY?=
 =?utf-8?B?TThLRTdYeGtidCtaTlJ1WjhLbWhzWWhiUnFHVHcwajc0bXc4eVNTZFZWb2o3?=
 =?utf-8?B?NWNwT2J2RVYwY0JtdDJCcVl0QVF5UlFGWWVoSmxjVmtwSjlSUmk1UT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab8d4ef-e2b2-4325-ce5a-08de7864876a
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:03:49.8397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eh8nrAwL4qDiuQMWZViaQneIhFgdUYSnK50sS95MQz0MedvXNVvEa5+uswQNTDmbHSOiq63SlO4BG7OInq4KR20Os2zKhSSyMkNUnK8ojv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB1788
Received-SPF: pass client-ip=2a01:111:f403:c213::5;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The additional plugin tests register accesses, specifically both for
read-only and read-write registers. Writing to a read-only register is
currently not tested, as this would trigger an assertion and fail the
test.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 tests/tcg/plugins/meson.build |  1 +
 tests/tcg/plugins/registers.c | 79 +++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)
 create mode 100644 tests/tcg/plugins/registers.c

diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index b3e3a9a6d0..d7f8f0ae0a 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -6,6 +6,7 @@ test_plugins = [
 'insn.c',
 'mem.c',
 'patch.c',
+'registers.c',
 'reset.c',
 'setpc.c',
 'syscall.c',
diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/registers.c
new file mode 100644
index 0000000000..6d627c7037
--- /dev/null
+++ b/tests/tcg/plugins/registers.c
@@ -0,0 +1,79 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
+ */
+#include "glib.h"
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/*
+ * This plugin tests whether we can read and write registers via the plugin
+ * API. We try to just read/write a single register, as some architectures have
+ * registers that cannot be written to, which would fail the test.
+ * See: https://lists.gnu.org/archive/html/qemu-devel/2026-02/msg07025.html
+ */
+static void vcpu_init_cb(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    g_autoptr(GArray) regs = qemu_plugin_get_registers();
+    g_assert(regs != NULL);
+    g_autoptr(GByteArray) buf = g_byte_array_sized_new(0);
+    qemu_plugin_reg_descriptor *reg_desc = NULL;
+    bool success = false;
+
+    /* Make sure we can read and write a register not marked as readonly */
+    for (size_t i = 0; i < regs->len; i++) {
+        reg_desc = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+        if (!reg_desc->is_readonly) {
+            g_byte_array_set_size(buf, 0);
+            success = qemu_plugin_read_register(reg_desc->handle, buf);
+            g_assert(success);
+            g_assert(buf->len > 0);
+            success = qemu_plugin_write_register(reg_desc->handle, buf);
+            g_assert(success);
+            break;
+        } else {
+            reg_desc = NULL;
+        }
+    }
+    g_assert(regs->len == 0 || reg_desc != NULL);
+
+    /*
+     * Check whether we can still read a read-only register. On each
+     * architecture, at least the PC should be read-only because it's only
+     * supposed to be modified via the qemu_plugin_set_pc() function.
+     */
+    for (size_t i = 0; i < regs->len; i++) {
+        reg_desc = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+        if (reg_desc->is_readonly) {
+            g_byte_array_set_size(buf, 0);
+            success = qemu_plugin_read_register(reg_desc->handle, buf);
+            g_assert(success);
+            g_assert(buf->len > 0);
+            break;
+        } else {
+            reg_desc = NULL;
+        }
+    }
+    g_assert(regs->len == 0 || reg_desc != NULL);
+    /*
+     * Note: we currently do not test whether the read-only register can be
+     * written to, because doing so would throw an assert in the plugin API.
+     */
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init_cb);
+    return 0;
+}
-- 
2.53.0

