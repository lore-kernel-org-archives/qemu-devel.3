Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6ECCA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkC3-0008FM-4B; Mon, 05 Oct 2026 11:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkBt-0008EM-JC
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:28 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkBr-00056Z-Fo
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akuAD79tk2LqwxVicATnExovz1sFNYLptgAOOgvSFLgrUilu0x/pXguJM/UN42hs8FM/CU3FJ2HLhXbAKpPgsmRffTmr8KwEk0ikRwFcgwnvQL4KTNKgljsT2WFpmqPQwipEmVSb9Tx4VE8dkuTWORuN0Y9yPQXvwV8gI8ytMe37fRM4qm9N3z/gr3R/xN90N/8crGEMux+XcT0ZPwlcfmZW5Edp1ko1BgjR3GcK9XxdZrs+dMQs6gpwxCqmkHYHJiUWxtPL+aHalFN/ibTi9gH8ALODtHVt29UPtF7cWrvnrsXW2uhV7fpuSGiq1X5+PIP4BTUh4u3t+2adYubVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=PG1cb/D5Vhy/hW1sXxMOU6vZL/F9ONeU4luET51EUIqIZGHuA+BJ2u5BagivUSZebcbHU6FQM6NJzFS36g5l137opqdWYzQfilTMnYgqtLhfVnHlX3OpMqTZYiaTulvMF6WTyxmJQ9qQeDh0uBdBFkcph8HF99Kj4dR8mkHLU0IyifwAuvPnPrZIMKUFcu5JG4sBvXrLkgX2+mZXfO5/hOInUvQdgG8dnGXkWVK3+X83Fy+plzu1HcNs5HOYfQbVwAIRaZ5jav3hLGEFW6LuSZT2C88tH90MotYoKGESmxTt7nmyyZC+4U1nqXddCUTU7ChO0V1GJNyJhcImejUZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=C9DgE0mVeFl8t9wBA0JIhuJTQmVsTttUyN0L3+E1VXP2zOH+myzYloJfjTjJi3cDb9tbyottCKJl9nxgM5PLP1lsX9WHUlAE2qcnEFhY6A56JtC6NuuntYqlyQPRRMy/Wkjheq+I/nyL6aDGsLAXGZ3WStQUvTHphydlWFqlvuKhAfcWTWmmq8EHJsprEE7B/TAeWWxWp4uZlFjPdFP5sXyGP1BAXayp9HshYGuSCJXQcN/XV9Ta7ZoqJaMwZ/EhjTe3+SMxw1e3A4SO5fC48aG2/eOun9h1cgsSfQy79IZJJfdxHyqbTSk+QG2jwYzPEsQVkI93AkMz5msiHSClzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS1PR08MB7452.eurprd08.prod.outlook.com
 (2603:10a6:20b:4dc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 15:01:09 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:09 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:41 +0300
Subject: [PATCH v12 02/21] tests/unit: add test for duplicate keys in CPR
 FD table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-2-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS1PR08MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a15087a-0f4a-43a5-9b92-08df22f17d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|23010399003|18002099003|22082099003|3023799007|38350700014|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: mgoenvwr6QqmD87rsSF2OE4kNqX+Vz/1ktFj154iOkhnV6Sn9Evf0EE0A1Ax55cEfpQsFqFxVey64kbfYW324LWtFMcqe7DERXN5lL0Vb6JtiZNx5D1e5Fc7hChBnJ8Tz2WCVfTWnMbcC6a6e9DYIFtlIYmdpXjICR8kOIwCMm14lXDKv2EU73zWcE5+VnMScf3PCL8ijaqOZTBTb4Gus7s044+BHX6SV36BQGkGdUkdDSc+YURswEAWOf0ugWgxz7h1sDzFWYUv+vhMGjkK56EC1SNF/DjFoff2iQhD64SiJZffe0zEvF+jton+cLuwvA+aBj+6yqM2i3gcrTkx2yv6ZLN3i5hhxpPt9z4d4fMxtvCKUrN6c7ZRM0gmQAdEWIb/lL7SoYygVzhh9nQz5JOu/9Bh96xzNYKN26FpNSxfVKSw2G/khO2a9HgvnSd88uKMPAuns8Q6vFlWfjdETnIxEY14d2jDsn6Mvd12ytlrI0NITu63tmV+uoSX/6vrD2p3kyz7MpTL5zHFgoxJcj5321eH5Cn8xxMSJBtcXOcXkuskV89pDA/7aR2XqtWt3dhciqiZpRdg/X/p4foonQnOVhyrGOk3hybY8NG0w0QMFmlVNKCSicMbQbF+VXY1vJQZO545jnuEH1bTAd2qbP8LVTJK8nFa87DCPpezJNlx+DAm0ks94JhIusXlQ5XInjxhu0mhKH3TAV55ICrMLOFjY44tYYXXCbAXy2126gc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(23010399003)(18002099003)(22082099003)(3023799007)(38350700014)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU9VbW5WN290ZldCbmJxRSt6Q0ZRa2JqUUZ0aXVXYi9oVkhMalJQbW11QnV0?=
 =?utf-8?B?dDFmejY0NlZxWEdvRGtWM1A3TlNHQzhKcDZqSCt6SFk1QUswVFQrcENFaGQ5?=
 =?utf-8?B?dEZjbGNFcGk4UUZPd2hqajYvNlJNQ3NpSUJpQVIvNHV1NmpqbGV0by9sK1hZ?=
 =?utf-8?B?M2lVMTN4SVNSVHMxZFRYQnBoYk9CSmZBWXN1RnVYYWduU2NQZXVkVVFCOU5M?=
 =?utf-8?B?RGQraE1Cc0d1d1I5MWw2RzMrazdHekY4aE1KdDJvTjVkZS9zcVVlN3lxdjRh?=
 =?utf-8?B?amNVMlZnbThuaWtrQTFDdmdxVmh4TXRDOGpvS05nUWZHa0ZqUk9Cd1I2d2Fm?=
 =?utf-8?B?Nk9SSXMzb2xEUEJ2aFZFTkZDc012cWxNK0NqQTZmTmwzOVZHV09sazNRTWdS?=
 =?utf-8?B?MitkbEtlVWpDaDVJd1YxdmY0WFRpRmlYUmFSQmkveEwrSDNPWGlJaUZmdU1n?=
 =?utf-8?B?b1RVV2xBY0pqclJYOG4rNTltVjVXYmRwdHRPZTE1TVJ6UmdvdlhqT2tIM0VS?=
 =?utf-8?B?RzhGSWJZU3hiQ0NOdlBWTCtqZHpTRGlkQ3k2WERQSGJLWWU3a1lwWFl2STBJ?=
 =?utf-8?B?VWJVQVJLMm9zWFF6YncxRTVYcDZseGtRVXRzYjBpajQ1M3ZKZDRCZWhlQjZk?=
 =?utf-8?B?MGorUUxXRm44R1AycmZlaHVPZm9YNzVmZVdGdklYeXZzNGFScDQ2dWlnNWpM?=
 =?utf-8?B?UjJzcnJqakZaR2hIclcxdEZlbFNFY2JJTzlaLzM4Y0I0TW15b1V2QzJYTlBn?=
 =?utf-8?B?eXZteS9PQ0c5MGtLVnMyY01zUVFxT1FTc2t0UjFHWno4OGd5SCtnK3orMmZ0?=
 =?utf-8?B?NytCMWpTQWd3U3E5OE5id2doREZZY2l0VGh4ajJ5RlFoWVVSQWtSQTFibkR6?=
 =?utf-8?B?U3ErMW9iNmROU2pFR29mVzBrMjJkaXZjakJHYS9PL3RkOXIrMDRnQmpNaHg5?=
 =?utf-8?B?WWdJZTduUzAxTldxYm9jNStXQ2tsMHhMWHhQTm15WUR0S2h2SW1qaFRvSmRX?=
 =?utf-8?B?QUxnNjYwRklWRzljZGdpd0w3YmhMTWtmeWVpK2VPU0hUS3EyalRvWUtOSFJJ?=
 =?utf-8?B?Wmc3UHl4MlkzY2VERUIreWRDNk1Dc0E5eFhCOUlIS2pwYW5RSkVIOHhmelN2?=
 =?utf-8?B?eDEzUGgrSUppb1I3M1l3Tnk0T1U5eEJJSU1mWUMvTVdWVkE0ZDF6UmM0VmlI?=
 =?utf-8?B?L1ZTYTZQN3RORGZ5TFBRaTYrS0FleXAvc2IvYmx4aG9QOFhKaitYa2lkZEli?=
 =?utf-8?B?ZXZZTWh4eVdSS1dhQXdUZGFoS2lPcFVnREVBV3cySGt4blFmNERxWENRL0cr?=
 =?utf-8?B?OWpHb2ZhbVNJVGRDWVVBWks3MVN1b1kwYmJKclBSVytsbmhzYURqVDQ5QVow?=
 =?utf-8?B?ZHhYVXBGTEhqWDhXQUNEcW5scW1Ed0wzQmtMa1JVc3JQS1VBdjAyRGpZR2NT?=
 =?utf-8?B?ZE1uaVYwa1F3WVZLSVBrL0MxSnlyK2EvcFh2NDNYZmZ1UHJLRkdqNW8rcFVh?=
 =?utf-8?B?c2NmQUd4R1NqWncvU3YrTDd4UlkzRVZMak1tUUNYQVNNUCt1YWtRV0VpYmZE?=
 =?utf-8?B?emZDQ1FpYmpLdnYyaVo4UTJ2SDYwMDZKcXFwUFEvbzVBYzNyZ1gwSmxpZHV2?=
 =?utf-8?B?Ykhla21VMk9CeTZ1QWZpN01EU2lsbG1VdURWL3k4eVFHSVVybzg3eUc1Qnhx?=
 =?utf-8?B?eEpXTUl2Skk3T1JDK21tL0pVaFY3cG16cHpTczd0NEV0ek5XRWltellqa2t2?=
 =?utf-8?B?blI5Z2NTR2ZRUjhSMjRXNmd4YjdOMU5ZTHQxdC9HcldZVVE1QmcyMjNBMWNO?=
 =?utf-8?B?U1BjMXZTcHdiZHJiTm5DYzI2Unh4ckt2ZEJaZHo0dmZDcDdlVmZWRGJzV0pr?=
 =?utf-8?B?NzZBVndVMnNwcXhIRmdBalY4VU5DTG0wSXVRV0dXbzIwN1BITXd6cXFQWE9W?=
 =?utf-8?B?MWJqTkpGTzh2Q0xxNWt0S21FOVlsdEVqTnM0bEJrS1QzNVZtM3BzVDJYbDZj?=
 =?utf-8?B?SlQrcGRsOGNWMXBtT1ZKSkozeGw0UTNLNU5pMkxoRkVSM0FaYk1zSjJOWWFJ?=
 =?utf-8?B?bllIbkVxR1hVUHc3eDR1Q1Z3bnFGRWQ3Vng1R2VQS2w4VUJua24rUGtnY1dx?=
 =?utf-8?B?NWxJSlBsL29ETnVhZVNRcG9GVWk3eThUR2pEd3AxR1lYYm1FRHo4N0NtUEVr?=
 =?utf-8?B?N2pONlNuVHhyV2xhemlmaEpVbWJCZ0N3SnArRUNqdDFPclNISlh5dEdPUnRm?=
 =?utf-8?B?Q2tUSkROTTUvZ3J2UzI0NWM2ZnRwRUxqY1RXQ0Q3SGpZL1NybSsxdWhsR0hv?=
 =?utf-8?B?eUJURDVCQjM0bTRWSWxwN0Z2a2J2RlBWSlV0dGh0SWJpbkg1ZC96M1VSUjFD?=
 =?utf-8?Q?G7iTmqxUoOAYHhSE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a15087a-0f4a-43a5-9b92-08df22f17d67
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:09.7470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ixzlZEPSXZSBEdC7GTcix/MhMmVze5Ez4hz6yf6OfwMnZwxo5eiKqzEYhNXpjmAk25dWFR/XjwQ/V/HA0/DFkJamGxCuYucOuVIMWaPQl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7452
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

cpr_save_fd() now refuses to register an FD under a (name, id) key which
is already taken.  Add a test which checks that 2nd registration fails
with an error while the 1st one is left intact, that different names
or ids don't clash, and that the key can be reused once deleted.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/unit/meson.build |  1 +
 tests/unit/test-cpr.c  | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index d17435c1877..5d2b413fcab 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -140,6 +140,7 @@ if have_system
     'test-bufferiszero': [],
     'test-smp-parse': [qom, meson.project_source_root() / 'hw/core/machine-smp.c'],
     'test-vmstate': [migration, io],
+    'test-cpr': [migration, io, meson.project_source_root() / 'migration/cpr.c'],
     'test-yank': ['socket-helpers.c', qom, io, chardev],
     'test-ram-discard-manager': [
       'test-ram-discard-manager.c',
diff --git a/tests/unit/test-cpr.c b/tests/unit/test-cpr.c
new file mode 100644
index 00000000000..dfc6b1f2ec0
--- /dev/null
+++ b/tests/unit/test-cpr.c
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Unit tests for the CPR fd table
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "migration/cpr.h"
+#include "migration/vmstate.h"
+#include "monitor/monitor.h"
+#include "hw/vfio/vfio-cpr.h"
+
+/* Stubs for the parts of migration/cpr.c that these tests don't exercise */
+
+const VMStateDescription vmstate_cpr_vfio_devices = {
+    .name = "cpr vfio devices",
+    .fields = (const VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+QEMUFile *cpr_exec_output(Error **errp)
+{
+    g_assert_not_reached();
+}
+
+QEMUFile *cpr_exec_input(Error **errp)
+{
+    g_assert_not_reached();
+}
+
+bool cpr_exec_persist_state(QEMUFile *f, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+bool cpr_exec_has_state(void)
+{
+    return false;
+}
+
+void cpr_exec_unpreserve_fds(void)
+{
+}
+
+int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+static void test_cpr_fd_duplicate(void)
+{
+    Error *err = NULL;
+
+    g_assert_true(cpr_save_fd("dup", 0, 10, &error_abort));
+
+    /* A second registration of the same (name, id) key must be refused */
+    g_assert_false(cpr_save_fd("dup", 0, 11, &err));
+    g_assert_nonnull(err);
+    g_assert_nonnull(strstr(error_get_pretty(err), "already registered"));
+    error_free(err);
+
+    /* and the first registration must be left intact */
+    g_assert_cmpint(cpr_find_fd("dup", 0), ==, 10);
+
+    /* A different id or name is a different key */
+    g_assert_true(cpr_save_fd("dup", 1, 12, &error_abort));
+    g_assert_true(cpr_save_fd("other", 0, 13, &error_abort));
+    g_assert_cmpint(cpr_find_fd("dup", 1), ==, 12);
+    g_assert_cmpint(cpr_find_fd("other", 0), ==, 13);
+
+    /* Once deleted, the key can be registered again */
+    cpr_delete_fd("dup", 0);
+    g_assert_cmpint(cpr_find_fd("dup", 0), ==, -1);
+    g_assert_true(cpr_save_fd("dup", 0, 14, &error_abort));
+    g_assert_cmpint(cpr_find_fd("dup", 0), ==, 14);
+
+    cpr_delete_fd("dup", 0);
+    cpr_delete_fd("dup", 1);
+    cpr_delete_fd("other", 0);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/cpr/fd/duplicate", test_cpr_fd_duplicate);
+    return g_test_run();
+}

-- 
2.47.1


