Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC273CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJl-0000m7-Fw; Wed, 30 Sep 2026 06:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJk-0000lH-04
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:40 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJi-00046g-7d
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d31z8z9fbS5wcI9zaqEtCCI4p0o8K6OUnpiKICk1VNqbEVG7DtWEQlkbg8O3880hnq8jUMgD+1AcR9tWaTbduwoaJfNGmoxkXrAbzxKHUMIP5lC3XaQ7P+DtMfqgDedQUx4HS7+HXapy9NzWUhJLQAQSN28SA+BIZCWv5kvkCUZqZeV2SKAI2rXESZcfU+Mrsr/hCLOMOceZFNAWa62omolNjfKfbxKkH+wpmxPS6cD8xfH1/rZR1hQe7eBgr+bc8EoHNWoSnfRqIhspVOgc6+ApYqbaJhQeAuB7hQKOo3Z0x+sWjfFwai5i8p+nqpdvmr9LQCVOmulCAMiny2IeaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=I+2voZfG7qbNjy9iSITqaqBAARuZbcEMmkoF+Az5DWiUu37bUgSBJNO2oj7nklrmtcNjGrViX1WeYFSDA9e6H2m52q8ege2oqLSfPTaSA6K3qZEp9deb74ola57aSayutfq7XyuquCZpp7GKbi5zWT2TEfYVP+6tAT/I6P5efJ64ZtL5kiwzp1gcjpquG4HDQaLbI8b8dxKD6dcfe63JauX84qLIHopq1fCo8Yc+R3l+GvVwDoByLs/DIJDW6l6N4F7Qdj0Y7RE+9WzEejVlW/G0w5IAc61VhsJVGfAcwD9wf190n7oXXXHVzZ6O+VK13kJvnPOneXgfHlxGJvIg0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q/HDXLoyiC61Uu3uiyDBlQDft7G81VamCAO8Ca1qio=;
 b=lg2qwWWglUroCDB4hEcF58rkHC2HWR7RWCnfXsHqRyc/DywGAafQh2Lixhe7Mjgjf8KQ92cx1VN5A5EYJu/z2ih2AmE1FJrjXg0f6Oj+xtE/eKecOojYJjkFJAmPDCFB0jKZKw+l6aaGMiEcK1af+cLlv2C3j9HwJqZ+KN4xW5nqGHgj8RAWVAiypRx73kPq3RRxEnCJIYRi81JUhee307yiSM/gcEin71GqPbvL7CTpQSRkc4N5b2NM4DMUV8oEKkF4Rn9XoSsgFB4qUBa6TSs2OPufIBowTKZQ7TYIFO8nul/D6ZvXUTZhqGApU6LIHGyewTp8UpaqCmrheDIdXg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:27 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:27 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:16 +0300
Subject: [PATCH v9 17/18] tests/qtest/migration: add vhost-vsock tests for
 cpr-transfer and cpr-exec
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-17-e9096f629770@virtuozzo.com>
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
In-Reply-To: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, clg@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, 
 bchaney@akamai.com, philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 farosas@suse.de, mark.kanda@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, vsementsov@yandex-team.ru, den@openvz.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0066.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: ee31f885-aaf9-49bf-279c-08df1edb7863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|260925022911599003|260925021911599003|260925021311599003|6133799003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: zl9AOQh7ksha+xRr7ruMxoVxXGWjxUsBWCyW0jsk9wIWgAMHfqb69aYeuLs0rjClHyU0lxZ5ycbNXKEnlDrozIauigmaiMGd9BE4WqV9a8Tcjy0Xhkb8tS0vxFwpIw8W1z9vhXIU92ZlRazRY9j7aGOSHDf5xl9hdAVD5kA5D/ieGVxnVQ8uiQZMvpygC5pxdX+IuRKg5KVC59hW5zLnNQNPf36FxnxqN/9dSpRJ+jAlVbgiSLs2tVQBGTybQGhqrv5SxeQsuVLJ+lf8D4hc87w5m/KxSd75+uvk1AdEN5sfoY8pkzh/VcHlLGI/EAJ0uepjcDFPBa49tmvrKwWoBLzVBtpFTmqf/pUozi+SM0Aej1zQeZTZu8T95VJsJxigZ1ss5hlsem/OGT/WEcaFVtuxWC5+VwmAA2p9pZgf6jkhoPvt928cjO9drEk1pSlEyAgxVRyKdmowUTa8pVCqKyggMZqZqaVXRynLDpWDHEa4fkE40RPIBldnPkwLIjA/IHR5N98H/pOahydMYN0dVKv9ngh1NGcpF3jJgAGnRCrNjMcZjPSl7Fe11ZqU0igSAaiHx6lkO6Osd1J8WTz2SBvKTYOVZu/nVOB0kivPGhgfblSfOsnuPh9a/cWn8+mV/5VDRDMDpHpQmzylCRkgjgEKKoyfKBv2fzCqYzRi88xpSPzx4iaZ7eq0BuchFpqaoODi/Rm7wwlLm/CCXabNULCumOmE0jsZBpuStC4rmVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(260925022911599003)(260925021911599003)(260925021311599003)(6133799003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXRENXdna1RDdm05dnZtMGJLSjJGQ1VhVi9yQ2JFWEFhRTNCSkVNZlpZL0o0?=
 =?utf-8?B?S0pPZnZKOEM3SjA1N0V0ZUxRZUxNOGcxOGkvbHFmZzgyQ2RweWhpZnR3d2Zy?=
 =?utf-8?B?SUx6dTB4dnc3YUlrbHM3aXBLODFSRHd2Vmw0TFZNQjl2SkNXT1lBOXRnQjJW?=
 =?utf-8?B?ckthUkZCcXI4RVBVRUFEMWorbjNic2doYXczRStSRTlqaE9uczlwS2JIVDhh?=
 =?utf-8?B?ZW9ac3FtTEMrU3p5K01reGZyaE5hV2FDUzJhRzRtM1ArQWtkSWtuNFVyb3N5?=
 =?utf-8?B?bkM4OXQrWlhZRXc3R2liNzZPQU8zcG1lckxQVTRldkZDSEZEMFlNUUkxOTFJ?=
 =?utf-8?B?TjVhclozSSt6OFhHWmxxa3lhaU1hYmEwVzU5b3NFWWlRRWxqc3BxNUJyT0hO?=
 =?utf-8?B?dVFQNWxCMklGT09pcnVWMnkzQ2tPNG0zU1Roc1BqOFphaGE3dWY1QlJLRkdk?=
 =?utf-8?B?VCtpQ3kvYzV5OG1nUERjbXFPM0Rpd04zcU10amIvaEZuM2pBNVEvN1gzSTlG?=
 =?utf-8?B?aDdabzZtNG8yUGJ6TDdyNFVzYTV6dkFIRm1McnNZM1lGZS9Ydm9IcWE2S2pu?=
 =?utf-8?B?RkFMZ3Nqdmx0YlE1cVl1aGJGdVE3L2JDL1p4SGI3RExRRjdXbEZ0ODJ4VmVJ?=
 =?utf-8?B?ekpTb3ByV0VqZ2pZalgrY3VlU292S2tlRkI2OEJZeXVXM1ZhUXRuSzE1NXdZ?=
 =?utf-8?B?SDFlN0d3NzRzeWROMGxST2lQUFVoV25Yd1pmc055NlJrTUtXRnZsM0VVZEFw?=
 =?utf-8?B?QlBhVktuTFFFTlpoemN0bE5pdGM5dmdTcHp4bms4Q0FpeGEvb0M0Zlc4ZjVu?=
 =?utf-8?B?QTQveXNGcVRHVVY5RFluMDBrRGNpcFdNQzhHQWdxVW16bXpYaWJzR1JTVGdB?=
 =?utf-8?B?YTFLM3dZbFVRV052NzBpZ25KeGJJYWdkcXNIOWNyUDFhU240bmFCaWlXY09w?=
 =?utf-8?B?N0dDQ0F1dWZ0SW91Q0ZmdlU2NW9KeWRIbERXSFNLb092SkJTVUJlL3RYL0Zm?=
 =?utf-8?B?WFhSOElhcDhjY21uQTdtU01DbERTNE1rYXk2SThjVjY2SS9xeVJ5bzVYUC90?=
 =?utf-8?B?Z0I4NnBFUlo1RmhlUFBxbjlvZGtVSHltaGZObGFsdDdpVkNjUHY2R0VyVFI0?=
 =?utf-8?B?clBmOXUzVmJKc2lWT256MkdZeU5aREJhWE1PeDFVSG1vbkszVy9CcnpuUytX?=
 =?utf-8?B?dWRrbzN2M1JnaU9xS2pENU1vMDJ0elZMV1VmT0tYVDExOVdtUU9LTE83T3RL?=
 =?utf-8?B?SGRFaVMvYkZpVERDUVppTDBFR0dSSnFWcHZWMlpkY3U3bUJmbWFpa1JQVGhV?=
 =?utf-8?B?clB1VWxEZEUyUElxRlFNb1A0NElueVRnNmhuSlRlaVJ1VTBCSmgwSks4Tnh4?=
 =?utf-8?B?VVB6WStnVHJlYVIzQVNialkxdG9TZ05HV1VNWVFmL2tTVW15ZGorYk9sbFRR?=
 =?utf-8?B?T1VlL1o1VG9aV2tJbWRTeXNKVXBSb0hEMi9GbmFIQWd6T0I1RWgwcGoxM0VE?=
 =?utf-8?B?bDR4UUNYVFRBUmVvZWdBTUxQd0hnN2hXcWRTZS9xOEdPaWhPRmhkNFhYZWVn?=
 =?utf-8?B?VjlVZVg0bkVwWk14NTYrTXllaWtiVkpWdkN0R2c0UldLUnNadng1Ly9icENw?=
 =?utf-8?B?eTd0L1JFVUZJTXkrRVNMTEpGNHpyUWUxUzE2cjJYZ0k0b1JjVGVqeTZLaUlN?=
 =?utf-8?B?WGc1VVdFbGZBTHVlR1lpV1BXNHdvQ2tzeWFDR3ZtVzZsR1FvNGYvQ0pxZmxa?=
 =?utf-8?B?SmlORG5GSko2akRWQ1lTVEFCMitmMk9EdmJHRFBSRGlLSWthN1Q5THJqSHpG?=
 =?utf-8?B?TXVMZ1VNV1JOQ3VodTJVeXhLVU1IT1BJbVJwSHE4ZmkxdEUrTWIrN1N0K2kx?=
 =?utf-8?B?b05mcmVNcUt4aU41by9xL3RQSDg3NFJCOEduZlVlSkJFcnN0UCtxTEdIekNF?=
 =?utf-8?B?WTkxaVZ6SVNhcjZ1SjI2d2NlSXRaRFdrdG1QTTlMNTFKTUFQWDZIMFdEakJ1?=
 =?utf-8?B?czBBeHF5aWtwc2hSUmg0dkxwdmRzQittTmp4SlJER3lkOVppMUhmTWpaeUpy?=
 =?utf-8?B?U0FhOFk2MUhtMTcvS0l1cDBVWm9uaG5jUDNYQ0c4MUNqZjVDRFhiV0tZZnpM?=
 =?utf-8?B?djFpV1czVm1XVE5NU3pNWk9XaTlDRGdBcDJTVXNmb2VOZmVGOWFweGZ0bXlu?=
 =?utf-8?B?MjV0emYrLzNQQlhtTks2NDlGVlhpQ2M3UGwvVWRydTlzR2lHVENWd1VPUVRh?=
 =?utf-8?B?QVVVU3Q4N05oYks1SUNWNUlQWm0vODJUZmxLOFhSUUxVT0U2WjVSME44NjV1?=
 =?utf-8?B?QnA4UE14ODd0MTNHZUNMd1pnNlJmaDlhVG9ZVU1MVkw5WHRLMHR4bVREQmNO?=
 =?utf-8?Q?s8ns5HznH3O2EcfI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee31f885-aaf9-49bf-279c-08df1edb7863
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:27.7561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cpi0ZUijRcGWj+r1KRuUG8gvdrR9FrLHmjLWOpV+THDcR+dxoJjk3AyGJ/QyfzLScKBgB+whp7QoBP5gTDhun2wcjunWvX/hkiSMN71LrRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
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

Run the existing cpr-transfer and cpr-exec tests with a vhost-vsock-pci
device attached.  There's no guest involved which is driving the device,
so here we only test the QEMU side of the handoff, i.e. the vhost FD is
preserved, the device ownership is released on the source and re-acquired
on the target.

The tests need /dev/vhost-vsock on the host and a kernel supporting
VHOST_RESET_OWNER for vhost-vsock, they are skipped otherwise.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qtest/migration/cpr-tests.c | 93 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
index 05c2ac1336d..3c21b79001e 100644
--- a/tests/qtest/migration/cpr-tests.c
+++ b/tests/qtest/migration/cpr-tests.c
@@ -19,6 +19,13 @@
 #include "qobject/qjson.h"
 #include "qobject/qlist.h"
 
+#ifdef CONFIG_LINUX
+#include <sys/ioctl.h>
+#include <linux/vhost.h>
+#endif
+
+/* We expect this CID to be unassigned on the host */
+#define VHOST_VSOCK_TEST_DEV "vhost-vsock-pci,guest-cid=4000000000"
 
 static char *tmpfs;
 
@@ -101,14 +108,17 @@ static int test_transfer(MigrateCommon *args, const char *cpr_channel,
  * migration, and cannot connect synchronously to the monitor, so defer
  * the target connection.
  */
-static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
+static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer,
+                                      const char *dev_opts)
 {
     g_autofree char *cpr_path = g_strdup_printf("%s/cpr.sock", tmpfs);
     g_autofree char *mig_path = g_strdup_printf("%s/migsocket", tmpfs);
     g_autofree char *uri = g_strdup_printf("unix:%s", mig_path);
     g_autofree char *opts_target = NULL;
 
-    const char *opts = "-machine aux-ram-share=on -nodefaults";
+    g_autofree char *opts = g_strdup_printf("-machine aux-ram-share=on "
+                                            "-nodefaults %s",
+                                            dev_opts ? dev_opts : "");
     g_autofree const char *cpr_channel = g_strdup_printf(
         "cpr,addr.transport=socket,addr.type=unix,addr.path=%s",
         cpr_path);
@@ -154,12 +164,12 @@ static void test_mode_transfer_common(MigrateCommon *args, bool incoming_defer)
 
 static void test_mode_transfer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, false);
+    test_mode_transfer_common(args, false, NULL);
 }
 
 static void test_mode_transfer_defer(char *name, MigrateCommon *args)
 {
-    test_mode_transfer_common(args, true);
+    test_mode_transfer_common(args, true, NULL);
 }
 
 static void set_cpr_exec_args(QTestState *who, MigrateCommon *args)
@@ -276,20 +286,85 @@ static void *test_mode_exec_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void test_mode_exec(char *name, MigrateCommon *args)
+static void test_mode_exec_common(MigrateCommon *args, const char *dev_opts)
 {
     g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
                                            FILE_TEST_FILENAME);
+    g_autofree char *opts = g_strdup_printf("-machine aux-ram-share=on "
+                                            "-nodefaults %s",
+                                            dev_opts ? dev_opts : "");
     args->uri = uri;
     args->start_hook = test_mode_exec_start;
 
     args->start.only_source = true;
-    args->start.opts_source = "-machine aux-ram-share=on -nodefaults";
+    args->start.opts_source = opts;
     args->start.mem_type = MEM_TYPE_MEMFD;
 
     test_cpr_exec(args);
 }
 
+static void test_mode_exec(char *name, MigrateCommon *args)
+{
+    test_mode_exec_common(args, NULL);
+}
+
+/*
+ * A vhost-vsock device can be handed over across CPR only if the host
+ * exposes /dev/vhost-vsock and its kernel supports VHOST_RESET_OWNER
+ * for it.  Skip the test otherwise.
+ */
+static bool vhost_vsock_cpr_check(void)
+{
+#ifdef CONFIG_LINUX
+    bool set_owner, reset_owner;
+    int fd;
+
+    if (!qtest_has_device("vhost-vsock-pci")) {
+        g_test_skip("vhost-vsock-pci device is not available");
+        return false;
+    }
+
+    fd = open("/dev/vhost-vsock", O_RDWR);
+    if (fd < 0) {
+        g_test_skip("/dev/vhost-vsock is not available");
+        return false;
+    }
+
+    set_owner = ioctl(fd, VHOST_SET_OWNER) == 0;
+    reset_owner = ioctl(fd, VHOST_RESET_OWNER) == 0;
+    close(fd);
+
+    if (!set_owner) {
+        g_test_skip("VHOST_SET_OWNER is not supported for vhost-vsock");
+        return false;
+    }
+
+    if (!reset_owner) {
+        g_test_skip("VHOST_RESET_OWNER is not supported for vhost-vsock");
+        return false;
+    }
+
+    return true;
+#else
+    g_test_skip("vhost-vsock is Linux only");
+    return false;
+#endif
+}
+
+static void test_mode_transfer_vhost_vsock(char *name, MigrateCommon *args)
+{
+    if (vhost_vsock_cpr_check()) {
+        test_mode_transfer_common(args, false, "-device " VHOST_VSOCK_TEST_DEV);
+    }
+}
+
+static void test_mode_exec_vhost_vsock(char *name, MigrateCommon *args)
+{
+    if (vhost_vsock_cpr_check()) {
+        test_mode_exec_common(args, "-device " VHOST_VSOCK_TEST_DEV);
+    }
+}
+
 /* Snapshots must be refused while a CPR migration mode is set */
 static void test_mode_no_snapshot(char *name, MigrateCommon *args)
 {
@@ -354,4 +429,10 @@ void migration_test_add_cpr(MigrationTestEnv *env)
                            test_mode_transfer_defer);
         migration_test_add("/migration/mode/exec", test_mode_exec);
     }
+
+    /* The vhost-vsock handoff doesn't need KVM */
+    migration_test_add("/migration/mode/transfer/vhost-vsock",
+                       test_mode_transfer_vhost_vsock);
+    migration_test_add("/migration/mode/exec/vhost-vsock",
+                       test_mode_exec_vhost_vsock);
 }

-- 
2.47.1


