Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BB3C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 17:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyuq7-0005fy-A3; Tue, 25 Aug 2026 13:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wyuq6-0005fn-8P
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 13:21:34 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wyuq3-00058O-V4
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 13:21:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2ef91pJHOj59CCKH86/xAGVJQTZyPpIe5xn4QJn4yH74Xy+Hc4BNLkfQu00okAg1Srxx5Sy/JhjvO5oLA7uU2oHXExF+wM1FmDs1Hrx7JCduUcTvEx+PRl+yo4rHx5k8rDH0H22J8905DbSeXs0VFLJelPhGO9aLNlSUQgFISdhkLw2H6EqkmU437whlHgz/EOR6W+XWdO9QQxImJbgF05C0pwLNmAkr+lw1TNlny/5JJ/eUdYiazb/7u5Z3QvagwGx3gELefY6ABfOe6ODCAHjcwcOlo9fPvZTqbTg3V9R1IkI5UZd8VZhFYvLPRAiRG1sePLWAP0eXwcmxR6fSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfZCM7F8lYhz4G9t1lD8TEL+j0jCRjihKHR0uEksOt8=;
 b=CJ7VzHFLrr5yNbCHqhG8UasTTGWgXiEy2qxTJ8lVRDNlwFUW98Et86Tz+1pVlckLQ1PPdbNxYMy4jLd784mntfMgbQdkioFQeH6awnHKJ4nhPMSpl0ETMAa4jHZGZwPt1+mqnBRfLHoO+W9EZE2dRYDAofGn/yii2UFK3818GZshzScPD8NghZnWF+0eJH6SotdVe7YUq1Y7FZg7KOxvJEetzWh2gNAY6ZRwf/yZrgKEFyAyudwhLAMZ/5VOhsfYxoBfI1A0GCxNuBy5q5MS6fDZEVki5tZ+zoTy2WiDAzTGIbYWumL4W13WU46Cp2y+Jav13MujwfvDrM+G68Btyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfZCM7F8lYhz4G9t1lD8TEL+j0jCRjihKHR0uEksOt8=;
 b=ghs48qPpmTLwOWzy8t6uKUvvLvfz+xqnTgQnZKB8u/11ebNTTXlrvQRSNfMLgEXhatbpBeLyIdE3RlkchO+ioK2NUJaQitlWWD/+lg4MpCPT7aBJHQsrYw30cBvfIJXzLVRJujk41RzTWDDOJXL7ISgCvEG6mGrvpJFSkLJ+nltEhbKI2GtD5T407IBquoxK/yM3b6pfiLJsSxNxMHrXzyrZ60nYHEBRSF3psH9hPpNgGHpyr6jOpqcSBiYG6mSb4NlQa/8iuxFYoLdXF4yh1TmqYlUvuEP+ZBXtvh6rbw/kFtOIas901NGduxEgqn7aHN7+gAQqizWNjZFKBvt1BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PA4PR08MB5902.eurprd08.prod.outlook.com
 (2603:10a6:102:e0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 17:20:59 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 17:20:59 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, philmd@oss.qualcomm.com, den@openvz.org,
 andrey.drobyshev@virtuozzo.com
Subject: [PATCH 1/3] hw/display/qxl: factor out qxl_guest_phys2virt()
Date: Tue, 25 Aug 2026 20:20:49 +0300
Message-ID: <20260825172051.435372-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
References: <20260825172051.435372-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIVP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PA4PR08MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e81b34-a6cf-4414-b31b-08df02cd3ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|52116014|1800799024|23010399003|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: a/hZ+V1KK7t/CQfFRdc2o3CPROmnP4siDVWcl0poUfwqA1/q0X6Ex4JIOd42/RAMHzvydlrSTtJ9Iwpe3lEFDuDPn8M2Dux61Vc71ApfQdlEUHXkjEGsriGytZEWDsFIuaL03Qq7LAFACXPsnIBmjyznkRPzPeizAixHN9eOZUUy12kfkd7ajY7h5vjf0JOiCek3f482CM8hJpZW/YZlrXvGVMKst6TPLG3PLfSDOTwt888DM+QmxgCgeeKQrAYy/psQESyTuVedUu3LHMuqJU4V6dWijbNVszJAtHLU0y/Yl6CnN/AXJM1sD1fuRiNYPanZy80uWEA4aQAbnNarrfhhpx9rHrSvlIR7/k3PfJAFCnyYpPGiU3h7GpGjxsQhYnwknduSQdIkN/hZK4oazVCfpJlvj99WrS33cLKNl0VjQsEE7oOTfoUsVPyzS5ZKoWoHrRXZarT0lRpvo8WozqZ0Qa6KS+5oTcQqWSImiGc7uWpCio9rt14Nwe0C7Vs8Lz2f++jbMXNiph0amaQLMaOSp7Ynd/6g3bI2OsZwcdPAJ5hvMgNYSDzLtiYlhHt39UsUJ8tE/sVqRqXT0D/o2wJzw0fYSsKm6qfvUzN8GCuTCEjXTvejpEaenhG6qY1TJbhfPEt2G3ZBLkmvo2d4zz9nphBBHy/9YfZPDf501Tuec7sHTUYlqEe7/HFPYtJ58Qy71qb31KjYoD6+U7wFnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(52116014)(1800799024)(23010399003)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AgbDiaijCdtP1VQyt9TUA1SUB8lftT2e+cQ4NzycShFuOAhzQmR5qQ2vb0BK?=
 =?us-ascii?Q?+D94yG5IZYgP0ZtgRCux1MljB/67tkGrxzJvrlF63jiP1iLj4rxg6ds+r72N?=
 =?us-ascii?Q?THB427nU1qK9mFIHL5hfAEMJ8ubTE+NQIkLpyOBIfuNd75bzWiyA2uxVGRf3?=
 =?us-ascii?Q?X4jApYNyTePsM5q1JG1prYHlSpD0HTlWDlasW5wNKVZK6HU6W1kYKzVD1Wrd?=
 =?us-ascii?Q?mZuDq4c1v2bcJrYYoXCIfLfDsSmDH0aVcZRjTWtG2dV9+k1ygnz3l7OhASI6?=
 =?us-ascii?Q?0MzZwFp9euYTctdJf32/W/12mhXOB2u6ukxo5yPykPwHs5sfP0XFCMIvwFNq?=
 =?us-ascii?Q?/1Bl/6M7WNaaGE3qkth04HKktT5V6w0e7Kno2O/LlLA5bBO7eIuZPoJTMMB/?=
 =?us-ascii?Q?QMQCqcGqDm78IMW4nUSyS7o43mJtDm85bYFjPgrpTMaKZzAyoXH/jgD3Ib9z?=
 =?us-ascii?Q?8LZ30vYQeRZKXbxMSJRpmdswfUaQUvsuI15vJ051imUPs0JvWrzK0UpNRrCI?=
 =?us-ascii?Q?aQPWUGqE3nODyEzgK/vAnH3eS2c1eZMiOmreZXZQ5rEQP0qneYLtXdvZH39e?=
 =?us-ascii?Q?f8RGOxVr37D3ykhEbdAChuxNNq9P/xHHT+MLLDv2zJ26jK2J/QPNrOiO2Lg+?=
 =?us-ascii?Q?AA65iKNznOyezkOaG5r7mLB9+VRt0Y1YmRPmjC7e1bbBp489l7Vs/+VL/r8O?=
 =?us-ascii?Q?vpWJYco6Y3W5oGwRiTte2g6QPyCa/mDfOSsrIOfNfdIAz+ywW7yPGxo0VEWy?=
 =?us-ascii?Q?T2ARi0yWpfRWoa2WQpQCRp9IV/xwJ7aKLjkd+sLy0DuBbnyVH8gKkMPFNIr2?=
 =?us-ascii?Q?xXCel9v7WirFSixr1xPasmtKxUR34mKYzUUvHFSzPIffkDhaqTxFbYfr5fYY?=
 =?us-ascii?Q?EEXombJplA8I/aKYuWS0vtljIqd5W3ZqxX5snv8kXLKKhYztdh/BtasI7E8u?=
 =?us-ascii?Q?h7NKem1j8Qdsr/FQctM05tvG/CotBRr+ImauoQ0dKMj4p6msZMjZl694ofqT?=
 =?us-ascii?Q?tsqw16sizCFJCzEBugnWbi701dcifo7R3YQgogA/lRGxSeW+a1uWNCtR/Zq3?=
 =?us-ascii?Q?7ochQPHgzt7z21F6xhDUMMnJ/HCQ+JSywC+t4j6+ws30+F6WHeOl4ixqJ6EE?=
 =?us-ascii?Q?6patzlWJY3bSqrsjuMCFgyNu7gFE5iOJuc0N47Zfn60jAaDOXyXcBHT9tTkT?=
 =?us-ascii?Q?1IuQPbK1ElZPdhQAz+VSfhISD9+O7/HA82fSSF8YhIcMKN+AYVN8mF0fIw6F?=
 =?us-ascii?Q?lLlrfxuayXFH5V2JAoZc20nsICma9yIU18P0MedASx6K3Uz2KrAb2kcx6wHg?=
 =?us-ascii?Q?JzLfLSz3ancTtsxc8+pZHPtFC1jgHFF76w3EXa9iLup2FluCaTzDWoNnpjON?=
 =?us-ascii?Q?R84Dy43IQXM8V788hk8mtORlPPTFs1/hLBjQ6rpW1xrrlQJSyN6S7xCQAPwN?=
 =?us-ascii?Q?Mud5aQ9MJ6yMyGpiO7hCzSY3QMWLzhfCk7mRiqgJ/l+ZVYSWYKpeF/K0KJff?=
 =?us-ascii?Q?h35eWFMr8XnE3M6qRHPF2MIdbnxq2LR6lXMhr+sXX/FRXiQuiPS6qhmniEpK?=
 =?us-ascii?Q?QEIPe+1J57lKLSzypZn2UUKdrB5TN0euxYaIa80IpsyYJw5M39i0uuRvRMPm?=
 =?us-ascii?Q?t1bs7wXW9F7WhsPiAxlU+W0xqMbIUb4RH3CN1kwKOy8WrW3oOQWY+UChm3sp?=
 =?us-ascii?Q?ieBtVDFuCrtnMLy/WKcNmdlzs7UqA9+T6JEdmYW5fwMGgLyP1F4DvuwsULrA?=
 =?us-ascii?Q?QUx29PFLHX8xa5fzfTX4sGFyXHtW58M=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e81b34-a6cf-4414-b31b-08df02cd3ae0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 17:20:59.0570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TczqnQpKd0gKP/F015CoL9bpUKMYSkU/omjtoxQ9D5Yhdwy57IiCpfcfnQR6wfgwTfa/NFtjmza29qpN457ginpSOK2v+li0TgIrnEEkcxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5902
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

Split the GROUP_GUEST half of qxl_phys2virt() into the helper
qxl_guest_phys2virt().  Also add a bool 'report_bug' param to the
qxl_get_check_slot_offset() called from it: when it's false, a failing
check just returns false without calling qxl_set_guest_bug().  All
existing callers pass true, so there's no functional change.  This
is in preparation for a quiet caller that validates guest addresses
which might be legitimately stale, when flagging a guest bug would be
wrong.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/display/qxl.c | 83 +++++++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 32 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index b7d871b9ee3..be620b9c94d 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -1407,7 +1407,7 @@ static void qxl_reset_surfaces(PCIQXLDevice *d)
 /* can be also called from spice server thread context */
 static bool qxl_get_check_slot_offset(PCIQXLDevice *qxl, QXLPHYSICAL pqxl,
                                       uint32_t *s, uint64_t *o,
-                                      size_t size_requested)
+                                      size_t size_requested, bool report_bug)
 {
     uint64_t phys   = le64_to_cpu(pqxl);
     uint32_t slot   = (phys >> (64 -  8)) & 0xff;
@@ -1415,42 +1415,55 @@ static bool qxl_get_check_slot_offset(PCIQXLDevice *qxl, QXLPHYSICAL pqxl,
     uint64_t size_available;
 
     if (slot >= NUM_MEMSLOTS) {
-        qxl_set_guest_bug(qxl, "slot too large %d >= %d", slot,
-                          NUM_MEMSLOTS);
+        if (report_bug) {
+            qxl_set_guest_bug(qxl, "slot too large %d >= %d", slot,
+                              NUM_MEMSLOTS);
+        }
         return false;
     }
     if (!qxl->guest_slots[slot].active) {
-        qxl_set_guest_bug(qxl, "inactive slot %d\n", slot);
+        if (report_bug) {
+            qxl_set_guest_bug(qxl, "inactive slot %d\n", slot);
+        }
         return false;
     }
     if (offset < qxl->guest_slots[slot].delta) {
-        qxl_set_guest_bug(qxl,
-                          "slot %d offset %"PRIu64" < delta %"PRIu64"\n",
-                          slot, offset, qxl->guest_slots[slot].delta);
+        if (report_bug) {
+            qxl_set_guest_bug(qxl,
+                              "slot %d offset %"PRIu64" < delta %"PRIu64"\n",
+                              slot, offset, qxl->guest_slots[slot].delta);
+        }
         return false;
     }
     offset -= qxl->guest_slots[slot].delta;
     if (offset > qxl->guest_slots[slot].size) {
-        qxl_set_guest_bug(qxl,
-                          "slot %d offset %"PRIu64" > size %"PRIu64"\n",
-                          slot, offset, qxl->guest_slots[slot].size);
+        if (report_bug) {
+            qxl_set_guest_bug(qxl,
+                              "slot %d offset %"PRIu64" > size %"PRIu64"\n",
+                              slot, offset, qxl->guest_slots[slot].size);
+        }
         return false;
     }
     size_available = memory_region_size(qxl->guest_slots[slot].mr);
     if (qxl->guest_slots[slot].offset + offset >= size_available) {
-        qxl_set_guest_bug(qxl,
-                          "slot %d offset %"PRIu64" > region size %"PRIu64"\n",
-                          slot, qxl->guest_slots[slot].offset + offset,
-                          size_available);
+        if (report_bug) {
+            qxl_set_guest_bug(qxl,
+                              "slot %d offset %"PRIu64" > region size %"PRIu64
+                              "\n", slot,
+                              qxl->guest_slots[slot].offset + offset,
+                              size_available);
+        }
         return false;
     }
     size_available -= qxl->guest_slots[slot].offset + offset;
     if (size_requested > size_available) {
-        qxl_set_guest_bug(qxl,
-                          "slot %d offset %"PRIu64" size %zu: "
-                          "overrun by %"PRIu64" bytes\n",
-                          slot, offset, size_requested,
-                          size_requested - size_available);
+        if (report_bug) {
+            qxl_set_guest_bug(qxl,
+                              "slot %d offset %"PRIu64" size %zu: "
+                              "overrun by %"PRIu64" bytes\n",
+                              slot, offset, size_requested,
+                              size_requested - size_available);
+        }
         return false;
     }
 
@@ -1460,25 +1473,31 @@ static bool qxl_get_check_slot_offset(PCIQXLDevice *qxl, QXLPHYSICAL pqxl,
 }
 
 /* can be also called from spice server thread context */
-void *qxl_phys2virt(PCIQXLDevice *qxl, QXLPHYSICAL pqxl, int group_id,
-                    size_t size)
+static void *qxl_guest_phys2virt(PCIQXLDevice *qxl, QXLPHYSICAL pqxl,
+                                 size_t size, bool report_bug)
 {
     uint64_t offset;
     uint32_t slot;
-    void *ptr;
+    uint8_t *ptr;
 
+    if (!qxl_get_check_slot_offset(qxl, pqxl, &slot, &offset, size,
+                                   report_bug)) {
+        return NULL;
+    }
+    ptr  = memory_region_get_ram_ptr(qxl->guest_slots[slot].mr);
+    ptr += qxl->guest_slots[slot].offset;
+    ptr += offset;
+    return ptr;
+}
+
+void *qxl_phys2virt(PCIQXLDevice *qxl, QXLPHYSICAL pqxl, int group_id,
+                    size_t size)
+{
     switch (group_id) {
     case MEMSLOT_GROUP_HOST:
-        offset = le64_to_cpu(pqxl) & 0xffffffffffff;
-        return (void *)(intptr_t)offset;
+        return (void *)(intptr_t)(le64_to_cpu(pqxl) & 0xffffffffffff);
     case MEMSLOT_GROUP_GUEST:
-        if (!qxl_get_check_slot_offset(qxl, pqxl, &slot, &offset, size)) {
-            return NULL;
-        }
-        ptr = memory_region_get_ram_ptr(qxl->guest_slots[slot].mr);
-        ptr += qxl->guest_slots[slot].offset;
-        ptr += offset;
-        return ptr;
+        return qxl_guest_phys2virt(qxl, pqxl, size, true);
     }
     return NULL;
 }
@@ -1942,7 +1961,7 @@ static void qxl_dirty_one_surface(PCIQXLDevice *qxl, QXLPHYSICAL pqxl,
     bool rc;
 
     size = (uint64_t)height * abs(stride);
-    rc = qxl_get_check_slot_offset(qxl, pqxl, &slot, &offset, size);
+    rc = qxl_get_check_slot_offset(qxl, pqxl, &slot, &offset, size, true);
     assert(rc == true);
     trace_qxl_surfaces_dirty(qxl->id, offset, size);
     qxl_set_dirty(qxl->guest_slots[slot].mr,
-- 
2.47.1


