Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42604C88E70
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:41:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62F5-0004Fl-NK; Mon, 14 Sep 2026 04:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62F1-0004FK-Br
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:40:43 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x62Ex-0005PZ-Bl
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 04:40:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRfr3Bp/uf1scw3z6NYhlvIDANz3kJWSmrTcXLPQ9QGYXWThCqxlQvqz9cTJt7mvyXMVsNCJ8nJ4nh3xp36PfoMPGKgj0V0+wlqlye63bCTn0xYw70fZJeDPUjWmywe0Us2iwfl4LbXaNV81OWXu1+X1XCE8YyZBZtQvb/0BUfz2SQs0JBsQcxPoGm4a0OVXWnsKSvYJ5oyAQsz2E1OzqGln+08WGsViQaAlOKFHcxS5St3YaxoRwDFNDX3V6VcumxGG+O3gC+Ihr3ld/DA4MwJbZIMVjZSUrKwD9izYTHLuWVmRSsDq+NW/Y4RfdBBDgaTlb0CKnyhmRghjRTIAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1BPlhQEjh1ve1t5MaJwKpaCjZIQvshKVhE9sp4dYpE=;
 b=Yt9A4VkoJOiRlzwcYgZL2J9qPqfotbsPmKnwLAzCTltZmr5mz0B+9o9Ji1M370EwZlcvF0c75HaOgzVxBttg5UZLbEXz6iDeiL+Z49nR0B2I8RUWBSQjy9hKbig3FirQBEpn9EiJc9YuLQeEhP8pbcFFZTCMOLrkITee9UtIoBn3bwUCPv7lUdcgsXzhJB2fBhETe+grOYUTOz9qjTKI4y35SIG0GT7GCgdRFm2wL20Do17PeChY6oQGdVqdmUXmZBmqlkCzhdDn2DXZj56/VD7QwYgE9f4IuQMMbFK0GOWpPcGdz4DMKbLnkGdRhU0Pfu+ph2TffiZiP9WsxpRevA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1BPlhQEjh1ve1t5MaJwKpaCjZIQvshKVhE9sp4dYpE=;
 b=ohtbtKsLw4GUUyo86xRHO+okr5CIbgCpeQwHo34265O+c78ZkwdHQ6iFp+dK2GNgjKfHh8GmhQxvXpA5HBBuJOEKrIAbZmoTjnHEPaVA1um+sBFdA76/5yQX8v/YwYvGtL7D0b2DNMENtLmHo7I6ZzlKxVn3QHFJSFmj6aFOg7FjlNT0RCthBlyTWo/GKeCYCw/EqRXpPLeCLqTQ8OdfAeoelV0B+I18eLPSPVzdGbqz5vvRp6qCBigM47jhoqRXSEqjqYUCJjD5p4XbvnmKacGghCgdqdUcRQtSrKG/TIgQViG+Zhhq62D7zElb3HCGmTGzo1tIItndstEaRPkcqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by GVXPR08MB10916.eurprd08.prod.outlook.com
 (2603:10a6:150:1f7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Mon, 14 Sep
 2026 08:40:23 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.004; Mon, 14 Sep 2026
 08:40:23 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 14 Sep 2026 11:37:33 +0300
Subject: [PATCH v5 02/14] tests/unit: add test for duplicate keys in CPR FD
 table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-up-vsock-vhost-v5-v5-2-d17423589f48@virtuozzo.com>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
In-Reply-To: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, philmd@oss.qualcomm.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org, farosas@suse.de, 
 peterx@redhat.com, clg@redhat.com, andrey.drobyshev@virtuozzo.com, 
 sgarzare@redhat.com, dongli.zhang@oracle.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIXP296CA0028.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::13) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|GVXPR08MB10916:EE_
X-MS-Office365-Filtering-Correlation-Id: 3264fa6e-e0b0-4952-813c-08df123bd007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|23010399003|1800799024|366016|10067099003|3023799007|22082099003|18002099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: 1ODT5tX2JOQIfee2TI8ggopOFuZgX1Hwfm75e0FHb5j6hK3czxkYrh4fei7IGW8/1OuEZ4IWmNAwxAQFRZgambChT69v/0re7LmBgeDqY7WdZXC4jcOEMx67e/WmkR7tPLOmNgTSzcO6dbfOx112djvrjVlkeQ/26ifpd2kDCVxXYN0RdcOGrTxw7z312+xgBRHLjeDGd61+Sr0dwRNxGzUfevW3IuwW7XKPe/NBsdvebnAIOqgVZ3GSM8p2QHPNMeCgteriJ86SG0AelL0kVZKG2Nni2z//EYY0ezvopvoF+X/rMymacQDmx+9x7vWCoH9g43coJLGB1w4jDPpuOeRDH3RaXPbiNcqa57CwfgIr8YT7F+qgw44cpOXfUpLobpKQJ6aUoCM8C/ZfnRJD14X3aAht+zpQNJVe3JWvks9V48KztB/3g/frElUmacrGy90Ua4KJnMsoFpnt+D4pMAL1r6AYqZil7v/6j37vEhl+04KIb1IgB3qnzzLXgHQEvlsTPaAUsmXqVWmM6KGH+D6Rx+o1NJfAfB7W1RMl6fcTRrux3vig9T3Pq+HirWukO67DJpZ4D7KGnVO75FiMCAnQeR8cwlkuU69tg/+z74x4Tu5gllnvgctal2ir1o44XAU12WT+BYgFkdsqs9x0+7ciW7+4D7BroyzNZGPhiyejman91fA8Xuxi5lxmkI+Y7afANIlm/tFi8QkOVcLMxy9CK+Qanfb7BajwPebE+M4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(23010399003)(1800799024)(366016)(10067099003)(3023799007)(22082099003)(18002099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWlrdTdjSENNalo3VE1hUjliRGpkR1RQZnl2d0NDeUQ1NUx3dXJuQVJ5NTl6?=
 =?utf-8?B?WW5vVnpSSy9hVVhqTjAwa24xVjNnb1NsUW9BZmRmTWNKb0Q3VmlkR3NxV1px?=
 =?utf-8?B?S0hVWHM4amlId3NsdTdDTTFhK1Evb08rRHR4cTJRbWNrUytaYS9vRWRYekpy?=
 =?utf-8?B?SG5ZSS8za0lXVjI3SkVRZjBNOG5paHViQndWQk9uZXhMYmpoZ3BSRTNlS0Ey?=
 =?utf-8?B?Zkc0MFMzZWw2MzRaZGtsbGs0THJhL2QzV2o2RW0wS3l5aFM1ckNyQmt6eThK?=
 =?utf-8?B?YkxpODV2MUcyVUFBQ090amx5Mm50VjBjamJ3dno5YVJESk1qUTQwek04a0Ny?=
 =?utf-8?B?R1dHTFpoblhNbmVqZ21qZ3lFamg1WW1QVG9hSmNqU0MzTUlEUEdEVFFJWlpS?=
 =?utf-8?B?ZkN0cmp0WWxjMUFORHM1UWJGZURMck5UUk9XRzFsOXNhTGFEcGwya1ZUd25P?=
 =?utf-8?B?aGFHN2RQNXRrVWozK2xMTmV2SDJMT3VTUUFFZUNHelRpcmRXSTR3aXVjdDFC?=
 =?utf-8?B?TnBBM283Z01UbGd5UnBocWZJMGFaVEFRWHhvQ0QyV3R0V3ZvL0ZiazRySnB3?=
 =?utf-8?B?cTczcDdBKzFOYklReGdaZ0ZEUHBFWUp3cThSQjh2MUt3MGZjcG9BTXpIZWdz?=
 =?utf-8?B?ZzRleXVUaUlMREtZSXVIRnF0Q3p0NnppRENUU0VwSVRwYVVvNVplRlNpL2Ex?=
 =?utf-8?B?TmVDNW1yeWxzL1NpS2NYckZaUnRkVVVmbzY1a0VMWmVuck55VTBwY0pEeGJ6?=
 =?utf-8?B?UzJoZVMySisyaTNjMDBsVUlQalZxaGpXRVUrc3lQRDlOWDdjWkw0RUh4Mi9n?=
 =?utf-8?B?TUxKZnlHZURUelRUK1NBZ0g5dmRpMFlZbWdsazZjRFU2UnpNNm95d2JjbWpS?=
 =?utf-8?B?RXBJNWRvV3VlU2h3TDZ2ZmYyWW0ydHhNUjF2ZVFDZHBKV2NwVDRDYjRZYmor?=
 =?utf-8?B?ejRhd0FPZHVJbDZPbEYyWnhkUk1mZnN0OSt6aldMWC8vUkl1MEgyTUdTMWlK?=
 =?utf-8?B?OW8rQVE1Qkd4WklpRnFFYlZFeXZ0VEhSQmY1ek5GOWlPMzhIWm5WWWl2L3d2?=
 =?utf-8?B?Ty9ia1hPZDZVZFRLV05iRm9GMjN6UzZHZUV6bmdLelFMY2tvY28wRVBvamtw?=
 =?utf-8?B?a1JXRVZFQVVyRXYvNGZxREU2dnY2ZmFIbVBLckxlL1RJeGJUVFJ3UlFkQmZ1?=
 =?utf-8?B?dTh2YzVQMmlGUStWaGdDWk5qa0JiU2Z4K3p1amQxR3ZkREdpcUpQRW9BWE1i?=
 =?utf-8?B?b3BmRVpvNmpXTkxRWWtsZ2p6TmlQTkhWS2RJTERvd2FnUEUxaGIzcnU2ejBV?=
 =?utf-8?B?MTd2TlNRTUFiYWZjdU16dTdQa2x3U2svZ0hWL05VTDJiSTMvZ1RTUGRnV2tz?=
 =?utf-8?B?cWlaNFdGaWxCOVVSWmtJQ2tkMnZqaUZCQzRjZDl5YmVTN1loN3RYeDdlTmUw?=
 =?utf-8?B?REhQYzkrZGVQalJRblhWR0RFSE95bjZuTHE5NDZ6TUFTOFQ1YWJFNTk2T1Y2?=
 =?utf-8?B?WktNcHdsZFJnYUdXblNMVlhzSFpNc3NLb0lNNXVNTVpESFNOUEJ1RWhxT0lo?=
 =?utf-8?B?S0tZeTVKa00yNUZ5clhXSmtrd2NrMTVGM1ZkS1NXMlBJUkpzenpYclRPUG9V?=
 =?utf-8?B?d2lWQUlsM2VpZ1hidm02QnVVWnQ2S3ozdWlKMHpOMytNNG9xdW1KTHZybW1p?=
 =?utf-8?B?dko4T2JMazd5V2ZMOGZlaUtOY0phcmtHNDlQUTJvanIwVndPS1hLLytKYjds?=
 =?utf-8?B?TUpFMi9zVVdWS1Vvb05WbzJxaHU2dVFkM1l3QnRaUVJja0FYUDFTa244YVV1?=
 =?utf-8?B?Q1huSHRVVThGU3FTZkMwdnd2bUQ3dmdEbW55aE8rMU9lK3orMXpXOXN3MGd4?=
 =?utf-8?B?VjVMM2tDZWxqcG5RM1lpS0FIWDFzWlBhUmVBc0FsSlZvaFVwNjk2R2o4NHY5?=
 =?utf-8?B?VVQ3b1U5VFc1SUd5clg5QmZta1djSnJMUzFoZXc4b0ZVL3dLOVpTNDhhUWxi?=
 =?utf-8?B?QjU4OUhFa2U4V0llbWVSeXBMa1BsQ2hsdU1XV09SR0FSQVpWYWozSWVFdndh?=
 =?utf-8?B?RitMNXEvMjZFS1NXcUxYcm9ueFhpT0FhbnJackQ4RnpqeGV1TnhGRmErMmRh?=
 =?utf-8?B?dmpZandvM1k2NXhTMWJ6TTR5TGVrVHMyMjVSWGNnWk1OZlREQkJNRGJOZUEr?=
 =?utf-8?B?SWxUUlFIbjF1UERUbzUyVmxHdDdkQjhPaHM5KzZpeWxrRlUzMXZpSWVrZkJG?=
 =?utf-8?B?NmtjOFBybFYzeFRva0xhUGh6aDJ4c3Z3VGhWbjJQVjAvZXdQdnUzcTZkWDJv?=
 =?utf-8?B?dzRoSVl2dm1mN3FDcGJQaktjVlozV2RRYU9RNXpXclI5QlpROFBubUVZc2lU?=
 =?utf-8?Q?780aPAxenqm7f9Yo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3264fa6e-e0b0-4952-813c-08df123bd007
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:40:21.3602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/Z7OAWTQQMrY9wTPYThgpsYT49FGyFFcxDxwd+iWqwwxIpYH/eCj7bSwmjpLs1Da69AH60e151WJQVkVx1+scAW82ZUqmiN/kbZfJY1p8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10916
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
index e47bc7225ab..8d229ff60e6 100644
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


