Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0765EC48BEB
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 09:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rauB9-00025U-1G; Fri, 16 Feb 2024 04:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rauB7-00025B-Uc
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:06:41 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rauB5-0003sS-MR
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 04:06:41 -0500
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41FNH0YR003311; Fri, 16 Feb 2024 01:06:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=Kc4uUJAbKKnVToZiVQkTJkASjOeEICBQEEk/7Zz8w
 I4=; b=W8P9nwSFNo1tlM6ClXRbwtT2tLLs3kyGpAnGVWFtj23/3ccXVTnZjnAlO
 0Y4UxlOOn7gzdkDwg926YAcJI5LXpfL5ZlssxW1X/P7O7LjIq4iZ2ON4+fuj7pJi
 UJlv1XyS1PzJyDMLxnnJIIT2L4pMGSS7zd0e1LHSWAkR0leiSqRIB3mOJ7U5p1d9
 PRx0/sWZ1XLbk6nZGxEJFngzJwQY4Od+6LJC3YT01cjOO2rKigofER7x1UPPLF0S
 KKKP2Q6DSywJWn+pOGJDgpaMY5zs1KBm5aMueHNCdaH7hzv1fU2snB26HqOhsYy8
 Bkjacrrxvai02zoXACwC7NflxQviQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3w69bg4q5f-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 16 Feb 2024 01:06:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K/lH4pL9d1n0s6iCfAH1ced2usd9aZumMhKa41KiTh3vraeHYfoqw0dHif89cEifmXgTQF+aKWJnZxEa0+ElZzxd0Y50TREu+2OSiRoDFiT+AnZiGRuzZ8upO0OjUBub9Nyq6Zv88YaydA4K070bp7aPTyNMzyYhQqJK+9usBDVuEQLKcTBZVSYkpStikuzN0oz9ByUc1P2LRFJEIaqGZNmQsg+YZZk1jcSptak4SQ6kAWYUv2V393fXQUpha7Pl4j6X3XtGiTf1fzazH/yUaGQJ2cAT6d6cX/KDU8cTzC9+Y288vvCNSPFy1GzSyjezTMTMKure1Gqy84RAz6Zuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc4uUJAbKKnVToZiVQkTJkASjOeEICBQEEk/7Zz8wI4=;
 b=bgH8VKe4oGB3+V9k/PXQVBqvwRrlZY6p39mfhSXSwFNFK8r7RjQ60YA6RtO2t47fW5Oa9PqNgQenm0oSSoMHIwxtSfJg6lLS87te17e9B3ecdVxDTH62VE2BD6XcqT3hTJHpWkYCXMZO3uvmMaRHrxGO+rNlx+gA7x6ey2kQOF3wGkdebFWVuuP8T+zuhXjwxHs1tKdjwtmKUFR/nbsTQ6pAKj3g3MPYVeqKMy7Fzdy1tYSXLeJRJpwpGSQiZZqyPZYODPzi6IIchSPdVs15Z0RKfsIZlOArrGUkkWkTMfZPB02d0HpzvvC3SXOYqP+VxvnwsBXmI4OcdceADf7eIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc4uUJAbKKnVToZiVQkTJkASjOeEICBQEEk/7Zz8wI4=;
 b=J2Yh9j5PIMZJHdCcDlkhIgQ9oe9vKh5IX395ySPlaIN+ykDq62tod1UhSHY+TVXWeMIwXd8a9GG89HPnl6Kb9eid3VVA3UK4rRHflL4XbL2vQz7ImzhDCDaxRBg6fQn6z2BiET9aw3kdPsCfWPLtTKcn4g1ha/T7wsIAQZ5zi5Jg4A5cpYScvNIxAdB+GgjSBuUDWeFoAedSdoWSoERQ1XUbTTy/3OcGxlMLb1ehKSyF4bs0JyqUsABhfGhaSmQqwIGapqpi1IhItpo2SLYEXKzuZrHg2XvAWucfBFJ7eD0tXkKNaJkjovVp+2sW9M2peGNhKaNudKdLCOBzyYB6Ow==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CO1PR02MB8521.namprd02.prod.outlook.com (2603:10b6:303:158::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Fri, 16 Feb
 2024 09:06:34 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 09:06:34 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH 1/3] qtest: migration: Enhance qtest migration functions to
 support 'channels' argument
Date: Fri, 16 Feb 2024 09:06:22 +0000
Message-Id: <20240216090624.75445-2-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240216090624.75445-1-het.gala@nutanix.com>
References: <20240216090624.75445-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:510:23c::10) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CO1PR02MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 24220c7c-e2e0-40c9-138a-08dc2ece92e6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfFKOtMrYSKu7xG6q+p9ENP/8y4QBwsKK3LFD4yIGHL2AtgAUhUXyJbgurSVRP90IOkiFiTZDwNau6NYoFiu/CttdF7FdzIFdTvi5ZzibUWHM4wr/aA443UcE9vrxlbteguNuQvHAF+P+itx3oA5KcSC2HEXLEHbmqwJU5uBp7LXjn97P5LMrBHSJ6b6jqRdYbJ4TtGXgq2dnwAB9KMKcEx1qyvLtyCwL+NWM2dWGOSJIdY55DczUgjYLauT4DFIUIYqUqZIOsJ5GrCtXNfLrqBwrRI7x0QW5k8tAFrAL3x/Zy5yTdWak3JtRHKZhnxHGEeNMK0dZsb3SHYQCfUsKBZDanQk75pW0YsY0CZ7x/0ZNPO8K9psw2pCUvFwCtaP9GERnGkbfpIy6NBCV1pyJvxHpCa260ZBn39Z6yQlo+fbz6gVhj1MwaA3hItGJFzDvnlqyVOd9yI/Um4EqGVxqQiAJPskGmGvJD6+mUgybYLcBs5TgSe58tEZIYHGwqCsn4rCczlpnWxHmJWKFUXRopi79TDc0qnkKQD1wHrpsVCdbw6gYSmovu0L4SmDTQsiDfEy+aHa03oSWf57VhrKIQUakm4UWmbk5G+AK8ulReUywUomgYsCC1QMEczASAZl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(30864003)(66946007)(44832011)(66476007)(2906002)(8676002)(5660300002)(4326008)(8936002)(6916009)(66556008)(6666004)(26005)(83380400001)(38100700002)(107886003)(1076003)(36756003)(41300700001)(38350700005)(86362001)(316002)(2616005)(52116002)(6486002)(6512007)(6506007)(478600001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4qnRejwibJAYQqEOQPe9FkbzNq6JOjooCFvO8Mx57Y889que19/IZ4q0deDc?=
 =?us-ascii?Q?ZA95hKOV/Wh/E5UgRENwHBrwaaD49iJtOTCk4PynABe76xyvB+gsNtVJSj0o?=
 =?us-ascii?Q?aFPxvg8dMl+lTKUsPAcrTpMAUxxRFLHNBq859XLqcXqnuV5HsYRjtV418QKV?=
 =?us-ascii?Q?fjhhyFAfSZ6u9b8eCHSRdnSLQXQx6+hJnkgroiNBJeInfVsdaSDo0rss4vvr?=
 =?us-ascii?Q?JJNahLwQIsbYhRcEYhU7oNXWmiUAwvrMF+vAMgnrUfG61C8h/9V2GVivgkVF?=
 =?us-ascii?Q?dEsqjx6ivc4VwhX9r1DmasgiSg1qUUc0TSZK2KSxPrhAmF8qgFm/UMj932Ki?=
 =?us-ascii?Q?/Rm86kDgD8JpAiltkGqjqhpb2+KnhxgMhne219U+xVj2zIQ2Zua1IPeaj/yO?=
 =?us-ascii?Q?w9AumPpy1fZNmNGjiduTM4foyQk3gh1DsqmA1UQSZ0j6T6Y1eb5hPQXTIrBG?=
 =?us-ascii?Q?DEiuMfZCkVC0yAECgP4Eog+c17XamH8WN46lMA69WzhvLl9Ilm9CYhs1vKli?=
 =?us-ascii?Q?DvKhatv2mhP5W1RSTglsavqZrVVJpHhxb44PZ5tma7GzCEKFMSkB3A0faleX?=
 =?us-ascii?Q?a31DiQvL8ZXgz+7UEmR9rNI9i6pwMcXqmsY7wi0j+cSb0zS2PSu5jCYDzRxC?=
 =?us-ascii?Q?oqx7PiDot48W0Im63DTef17ok1k7jP8dxH4r5ObtCkOIhFnnDB/44Acu8qkg?=
 =?us-ascii?Q?gqkKng+wRUQJNSrFeh10/nMkadui+/28unwgrC7TR/AkOqhbcd6TqcgtlTR2?=
 =?us-ascii?Q?i4f8l1Ek/zXw55J0uXnsh75Y+bA2gcEWTxjQGVAQAxvK40D76h/oHPgSOjTk?=
 =?us-ascii?Q?onYuTHKVqyBSPX/4XZF7OunGg0fnUHTtLXnCzTgdOfxaTHZIS2tAMH4/JL0E?=
 =?us-ascii?Q?hmJfkOoqy1mk2QwJ6wDTK5WT3nQArvwK8T84FjVSGPJ8taGor7GSCv/3scf0?=
 =?us-ascii?Q?v9nedpqxCmdj2Zu4bh3URksd6xtumvzLCh5W3w2xhIRVY5frh5lfhXaXSMWS?=
 =?us-ascii?Q?2qzQqN73AhfAU+6JE/5vscqV/M7pqY+VZk14Zg+RNXvclZMuscxhpvbLEw5y?=
 =?us-ascii?Q?EpAy5FVWWETQK3xCZh7kvrZBUU8Y+bKt73P4AL8RolB4K3/Q2vp7cA9I+bgh?=
 =?us-ascii?Q?mRNOHdMzCMz6cFv9D9yn77IJte0E6QXEzB94fEuxnPQh63PaOyeB5/1m3XJo?=
 =?us-ascii?Q?+mvZSyuuefFMuHEr67Ewg3s/9GECf1WQR9CnxuLErbfY/G6KOTuac+ZM56rG?=
 =?us-ascii?Q?fu9l2JxeWxmkrhbvfK0rweW6kj1RFKDi/dVBN/ZKjaJ06TdEVy1jXr8PZORv?=
 =?us-ascii?Q?Msm4BqNo3m4ed6SUrABXLjXtqXfS+YsVSKzeH7RjAWJQ3OQdCuBHlCZg6Ze1?=
 =?us-ascii?Q?YMd4seiAnYYFd+8WDjXCxnAdymgVyKLTUBMimmjQ1NhA/ql3F2KC+4/r4pCB?=
 =?us-ascii?Q?6b0T+PsF3OFgBaoN6pmlaeIXwYiFFmJi8rgX09nXUtRGUU7+i1j5WZkUDHkd?=
 =?us-ascii?Q?B83aZs1x9wy0xxtxejahoJpzaiDlV/mUa2M3YYzTcqDeROqxdffBLfLEV/J3?=
 =?us-ascii?Q?IMXzEd8Upu/z9a/0lnCrNYq2VHNt7CfZznJTCymq7qrlQfqlEW2zck3HmCBM?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24220c7c-e2e0-40c9-138a-08dc2ece92e6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 09:06:34.3647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aump1QiBf8NzAlWxWyLQFjbnlWfSJdgeAP9KkXtAu+GPX379uTOIEemx7bYZZ3E9WKM6jUpWKke8eis5NUQMmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8521
X-Proofpoint-GUID: ZrjeYCJNJOiL3S9VFsiPiSxUclo-bFrb
X-Proofpoint-ORIG-GUID: ZrjeYCJNJOiL3S9VFsiPiSxUclo-bFrb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_07,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.772,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Introduce support for adding a 'channels' argument to migrate_qmp_fail
and migrate_qmp functions within the migration qtest framework, enabling
enhanced control over migration scenarios.

Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/dbus-vmstate-test.c |  2 +-
 tests/qtest/migration-helpers.c | 93 ++++++++++++++++++++++++++++++---
 tests/qtest/migration-helpers.h | 11 ++--
 tests/qtest/migration-test.c    | 33 ++++++------
 4 files changed, 112 insertions(+), 27 deletions(-)

diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
index 6c990864e3..0ca572e29b 100644
--- a/tests/qtest/dbus-vmstate-test.c
+++ b/tests/qtest/dbus-vmstate-test.c
@@ -229,7 +229,7 @@ test_dbus_vmstate(Test *test)
 
     thread = g_thread_new("dbus-vmstate-thread", dbus_vmstate_thread, loop);
 
-    migrate_qmp(src_qemu, uri, "{}");
+    migrate_qmp(src_qemu, uri, NULL, "{}");
     test->src_qemu = src_qemu;
     if (test->migrate_fail) {
         wait_for_migration_fail(src_qemu, true);
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index e451dbdbed..d153677887 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
 #include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qlist.h"
 
 #include "migration-helpers.h"
 
@@ -43,7 +44,70 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
     return false;
 }
 
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
+static char *socketAddressType_to_str(SocketAddressType type)
+{
+    switch (type) {
+    case SOCKET_ADDRESS_TYPE_INET:
+        return g_strdup("inet");
+    case SOCKET_ADDRESS_TYPE_UNIX:
+        return g_strdup("unix");
+    case SOCKET_ADDRESS_TYPE_FD:
+        return g_strdup("fd");
+    case SOCKET_ADDRESS_TYPE_VSOCK:
+        return g_strdup("vsock");
+    default:
+        return g_strdup("unknown address type");
+    }
+}
+
+static QList *MigrationChannelList_to_QList(MigrationChannelList *channels)
+{
+    MigrationChannel *channel = NULL;
+    MigrationAddress *addr = NULL;
+    SocketAddress *saddr = NULL;
+    g_autofree const char *addr_type = NULL;
+    QList *channelList = qlist_new();
+    QDict *channelDict = qdict_new();
+    QDict *addrDict = qdict_new();
+
+    channel = channels->value;
+    if (!channel || channel->channel_type == MIGRATION_CHANNEL_TYPE__MAX) {
+        fprintf(stderr, "%s: Channel or its type is NULL\n",
+                __func__);
+    }
+    g_assert(channel);
+    if (channel->channel_type == MIGRATION_CHANNEL_TYPE_MAIN) {
+        qdict_put_str(channelDict, "channel-type", g_strdup("main"));
+    }
+
+    addr = channel->addr;
+    if (!addr || addr->transport == MIGRATION_ADDRESS_TYPE__MAX) {
+        fprintf(stderr, "%s: addr or its transport is NULL\n",
+                __func__);
+    }
+    g_assert(addr);
+    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
+        qdict_put_str(addrDict, "transport", g_strdup("socket"));
+    }
+
+    saddr = &addr->u.socket;
+    if (!saddr) {
+        fprintf(stderr, "%s: saddr is NULL\n", __func__);
+    }
+    g_assert(saddr);
+    addr_type = socketAddressType_to_str(saddr->type);
+    qdict_put_str(addrDict, "type", addr_type);
+    qdict_put_str(addrDict, "port", saddr->u.inet.port);
+    qdict_put_str(addrDict, "host", saddr->u.inet.host);
+
+    qdict_put_obj(channelDict, "addr", QOBJECT(addrDict));
+    qlist_append_obj(channelList, QOBJECT(channelDict));
+
+    return channelList;
+}
+
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      MigrationChannelList *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *err;
@@ -52,8 +116,16 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
     args = qdict_from_vjsonf_nofail(fmt, ap);
     va_end(ap);
 
-    g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
+    if (uri) {
+        g_assert(!qdict_haskey(args, "uri"));
+        qdict_put_str(args, "uri", uri);
+    }
+
+    if (channels) {
+        g_assert(!qdict_haskey(args, "channels"));
+        QList *channelList = MigrationChannelList_to_QList(channels);
+        qdict_put_obj(args, "channels", QOBJECT(channelList));
+    }
 
     err = qtest_qmp_assert_failure_ref(
         who, "{ 'execute': 'migrate', 'arguments': %p}", args);
@@ -68,7 +140,8 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
  * Arguments are built from @fmt... (formatted like
  * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
  */
-void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
+void migrate_qmp(QTestState *who, const char *uri,
+                 MigrationChannelList *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args;
@@ -77,8 +150,16 @@ void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
     args = qdict_from_vjsonf_nofail(fmt, ap);
     va_end(ap);
 
-    g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
+    if (uri) {
+        g_assert(!qdict_haskey(args, "uri"));
+        qdict_put_str(args, "uri", uri);
+    }
+
+    if (channels) {
+        g_assert(!qdict_haskey(args, "channels"));
+        QList *channelList = MigrationChannelList_to_QList(channels);
+        qdict_put_obj(args, "channels", QOBJECT(channelList));
+    }
 
     qtest_qmp_assert_success(who,
                              "{ 'execute': 'migrate', 'arguments': %p}", args);
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 3bf7ded1b9..52243bd2df 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -14,6 +14,7 @@
 #define MIGRATION_HELPERS_H
 
 #include "libqtest.h"
+#include "migration/migration.h"
 
 typedef struct QTestMigrationState {
     bool stop_seen;
@@ -25,15 +26,17 @@ typedef struct QTestMigrationState {
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque);
 
-G_GNUC_PRINTF(3, 4)
-void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
+G_GNUC_PRINTF(4, 5)
+void migrate_qmp(QTestState *who, const char *uri,
+                 MigrationChannelList *channels, const char *fmt, ...);
 
 G_GNUC_PRINTF(3, 4)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
                           const char *fmt, ...);
 
-G_GNUC_PRINTF(3, 4)
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...);
+G_GNUC_PRINTF(4, 5)
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      MigrationChannelList *channels, const char *fmt, ...);
 
 void migrate_set_capability(QTestState *who, const char *capability,
                             bool value);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 8a5bb1752e..e7f2719dcf 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -18,6 +18,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
+#include "migration/migration.h"
 #include "qemu/sockets.h"
 #include "chardev/char.h"
 #include "qapi/qapi-visit-sockets.h"
@@ -1350,7 +1351,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     wait_for_suspend(from, &src_state);
 
     g_autofree char *uri = migrate_get_socket_address(to, "socket-address");
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1500,7 +1501,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     g_assert_cmpint(ret, ==, 1);
 
     migrate_recover(to, "fd:fd-mig");
-    migrate_qmp(from, "fd:fd-mig", "{'resume': true}");
+    migrate_qmp(from, "fd:fd-mig", NULL, "{'resume': true}");
 
     /*
      * Make sure both QEMU instances will go into RECOVER stage, then test
@@ -1588,7 +1589,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    migrate_qmp(from, uri, "{'resume': true}");
+    migrate_qmp(from, uri, NULL, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
@@ -1669,7 +1670,7 @@ static void test_baddest(void)
     if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
         return;
     }
-    migrate_qmp(from, "tcp:127.0.0.1:0", "{}");
+    migrate_qmp(from, "tcp:127.0.0.1:0", NULL, "{}");
     wait_for_migration_fail(from, false);
     test_migrate_end(from, to, false);
 }
@@ -1708,7 +1709,7 @@ static void test_analyze_script(void)
     uri = g_strdup_printf("exec:cat > %s", file);
 
     migrate_ensure_converge(from);
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
     wait_for_migration_complete(from);
 
     pid = fork();
@@ -1773,11 +1774,11 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, connect_uri, "{}");
+        migrate_qmp_fail(from, connect_uri, NULL, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, connect_uri, "{}");
+    migrate_qmp(from, connect_uri, NULL, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -1869,11 +1870,11 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, connect_uri, "{}");
+        migrate_qmp_fail(from, connect_uri, NULL, "{}");
         goto finish;
     }
 
-    migrate_qmp(from, connect_uri, "{}");
+    migrate_qmp(from, connect_uri, NULL, "{}");
     wait_for_migration_complete(from);
 
     /*
@@ -2029,7 +2030,7 @@ static void test_ignore_shared(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2455,7 +2456,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     if (should_fail) {
         qtest_set_expected_status(to, EXIT_FAILURE);
@@ -2558,7 +2559,7 @@ static void test_migrate_auto_converge(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     /* Wait for throttling begins */
     percentage = 0;
@@ -2869,7 +2870,7 @@ static void test_multifd_tcp_cancel(void)
 
     uri = migrate_get_socket_address(to, "socket-address");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2901,7 +2902,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_non_converge(from);
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
@@ -3234,7 +3235,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3275,7 +3276,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


