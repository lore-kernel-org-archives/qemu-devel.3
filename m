Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25060CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN5B-00053x-Fs; Wed, 07 Oct 2026 04:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHls-0006Uu-5M
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:52:54 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHla-00054H-VA
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:52:31 -0400
Received: from AM0PR08MB286923.eurprd08.prod.outlook.com
 (2603:10a6:20b:804::5) by BR0PR08MB296250.eurprd08.prod.outlook.com
 (2603:10a6:2c8:44::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:02:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTnlCsXRlnnlABxwnagRFTlnjwc7ZSxIp0LXGnLLK4NFMfngXRoB1Rh9+ladODlkD6JjCzaUwi7CoBKkTawMX1ampy/1nZiHN56tZQIGE7On4V6dZkNdGppquYWeLsCZ3skk2b6kqzXeKMRT6L6LNDS4US17QNrfg9moDwRiWaTjD+eTyjmX4xz3PEiH8caUewAuWMC2pnnlRnNtv6T7iq2QlJgMwQJ6B6nm/Ye9FC+FYOlsc3v+nJqbMdaWnvNLqF1tairI4Au31e0rT1XVT1HbQBBxdW/9jsT4YJfOXDVHAd2wHfDrs4pDSl0RIIPvmgPdJeVIBPzgm58bnhCrgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=bImAc1dIINOY1tt7Y2yWbBDyYq/Yg+5fbSGCjXESm9Mo9sQIrS5Mf+VsOBqk0IKSnk3++Yw+NGhcFBRBtshAPGS5Kizgs+GTxRpx7VF5HqBZ5VAFWxemUo8SbxUb/UST4E4KTbWyBiWmou68NDhGxe7mP2uR4i4L2V/sZ5w40+uHevd9nrPt3NTRBB0hLAxTx+BLtWe2E8FArFMqGB6XjN/G4/LjqlJCLm3mlZYQ0fmoWR05hNcgX9Xd18/p66w08jMPxxzF9JIkoQyg9cCxXcnr5iNTfZn1vOpuuJW1khdgyqbQD3I82w6pgjroUHownPUP4+m6FWRjpeCMcBMCBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzhhEOopcN3KOOtfWAhLZROUNYy2FrEKLzdoJ27vb+k=;
 b=l+rN8E2HMzzwn7VWmZs/220EQi/gK4a1lyXLvbVZxg9b9yjppWZcChx6cSN4vRsVtsLj6KbnM5I+f0dPK9S+PDgxVyXb2FNwOMrQZKH0cVo6MTQaMNEeLSDXi80oZxUxTCxqXSXEYhHeVeVG9kwcUM76m8ZP1thEHmDqWJabfhLHrP5bz8JbAWMirxqP7ovLTacs3iIdvg4phVxl4ltEKqgnXGlS92VpE4gTmprM44FrnyZa/ZIhITiNGCgJySjgl2q3Pf/iKBmZouZ65FJynahy4Gd1nqz3JU4gAwJEB6Sg27HD+yNmecmcc3ezRLfjRPqRu9mCNhsxY7f195hq6w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM0PR08MB286923.eurprd08.prod.outlook.com
 (2603:10a6:20b:804::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:58:49 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:49 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:25 +0300
Subject: [PATCH v13 02/22] tests/unit: add test for duplicate keys in CPR
 FD table
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-2-2ea78fd1b7ed@virtuozzo.com>
References: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
In-Reply-To: <20261006-up-vsock-vhost-v5-v13-0-2ea78fd1b7ed@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, maciej.szmigiero@oracle.com, peterx@redhat.com, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, dongli.zhang@oracle.com, 
 bchaney@akamai.com, den@openvz.org, farosas@suse.de, 
 andrey.drobyshev@virtuozzo.com, clg@redhat.com, mark.kanda@oracle.com, 
 vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000229.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8f3) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM0PR08MB286923:EE_|BR0PR08MB296250:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aafc2de-1d88-4ac7-17cc-08df23b1f28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|52116014|23010399003|10067099003|56012099006|3023799007|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: u6ffjFbcTxtWS93gaxOrdfmOaa8YpAvlB+F2PZIr2EmemwECuJykPzAZ71RfhgYjif2ZKxGRu2p9BZX5B85jeOWLpsPLqx7SUrEPYublWKGaKeDQPuKCH/SbN+uzZ6+dm9teeSimS4LIbbsjECexU1K0zcwsEB7NFMe1pXI+4TrYNf3FBrsVtf6TDricLxrUxz/JkF1QYueskiiay8ZMKTtJhDGCpIOEaugqFzMpbDdg5l//sqGkoH1MLCRR+TQ0sSS1NZN7P1ibSQGebyg8GCsNnf5ziT/FF8laEzleqxrDYKmvfqfpCM1TdcmdOK41ngVry65kf5BbgXPU4v6fqnVEA0QDuI7lh6Bq/uQ3zGwH4r1wYaiGnsiQtvL1gC/cELVGuy6366Hei74uRDSk+NBgzrX+BVjxA4c3BmF/xXoniFyuVAKNfi0qKQudFT9BLzp4/nLuAukE+ODPYtEW+WqmyU98RkAzcXTgS0fGPLgPeDxeQrvlbQ8aryLGhR/DEG5rfJx+bl8bCI7Oe3IOjaNAv+xHChK6WKgzird6g9lxs26aPmuBHyOMcaY4AvEplpFUNow5chXktFPcF3EHbZW9kX5+yoZB+Qf315jW+GndV9wJwdcfur5w7CYNUhy0NUpx5Bhb7nxm4v827bbcAvpreMjtmJeFEzPU/Y/dxIBhfn5QBt7rgIWtTs/W5MXQOB8YUVC3PwAhY+tMHhwp9zcQaHSYi25p4XYl2C0Ojj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(23010399003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlNVVVBEKzFOV3pCUVUydThFUEFYdFJEaXNNZWNmc0g3RW0yZmU3RXNaL0Fs?=
 =?utf-8?B?RVFwaGFyS1JBVVZwZUplUG1IVHFUVkZ2UjFsUXFsaHdzQmo1c1J5dTN2V0o2?=
 =?utf-8?B?TWQ3K0JJSG5RdnBRNlVQU1duanlNUkRyOTRtZG9lRUgvQWF1WUZJM1dKTmlP?=
 =?utf-8?B?ZDlQOWpNaS8zSkpESzVFdjhnY09McXlERzk0QVhOOWtJK05ncnFMOFNyUDF2?=
 =?utf-8?B?MWxTc0tXV2ZRcm9KMzhkZ0tQaFFIcnVabG0vQXBOaGxyK1lVRzgwSGZTcGVp?=
 =?utf-8?B?bSt6bVMrYndkcm5jWDgrUWtmTGMyWlJsVnlJVDl5VUpUdXB4QjdiMEZmQXc4?=
 =?utf-8?B?c2M0cTRCRjk3NTVwUldjOWN3cmR6Z0g0bGFRQ2RCL1ZXcU1qbDhIeWhkZmJw?=
 =?utf-8?B?aDFsSHFqNG5FWmtXWERYK3ZRbFNFL0kyLzVmaEpuRElaRndDUlIvSFFmaHM4?=
 =?utf-8?B?WlBvTDZOVXhEcHAzTUxZNjhET0tXZVZnbVczL0tTMGg5QVJkVGZUQjBTODF0?=
 =?utf-8?B?VThBTTZObnNEcFh6dmdJSVF5UFc4ME9UNm1JK0NTcEc1NVl4bU9VUzFHVTBq?=
 =?utf-8?B?WGJ0VXRCU0Q3ZkNPelovQmVaSzlDSVdlYzYxdVNiUkxaQWtlYkExRDUva01s?=
 =?utf-8?B?RGNKS2dJdkhzV0I3dVBmTzMyUzdYV2FDVGZQcE5NeUw5WnpoMENGUkRPdlpL?=
 =?utf-8?B?dm8wOTdBeHdaYjJNenJ0UkxKMmg5ZTRkUWRlZ1MyWUh2YWdrUmpwczhyaE0z?=
 =?utf-8?B?NktiUXB4ZDlPL1JTQ3NmMS8rZ3dwRko4T1NJbzJ4K1M1N0VHcjRPbnAwWUM1?=
 =?utf-8?B?bVBDL3ArY2k5TUdBRlVVc1pGanREQVBtSmhRMkZweVhIMmVzZGluK0VQUXZQ?=
 =?utf-8?B?N0VpdEhGU2tuM3UvRVcrUFR2R1lWci82WjlrY3E0Z2JHdWgxMW9QL0ZHTzdT?=
 =?utf-8?B?ckc3Yk5wa1E3MGZLNExwQjFKYmZ0dlc2MUVIZWhsUHJxWERJMFJZY0M5Y2lB?=
 =?utf-8?B?Y3J6Z3NTSGRRdVFMbE5oZTFBUzFBTGJXb0c2OWNGU0xVendMd0EzVVAxUjRX?=
 =?utf-8?B?UE1kKzlCTkZ3QWtGOTIyTC81OU03aGRSNFNMRDNsRzhKaXdvUzF2MXExTW11?=
 =?utf-8?B?NHlMekdOdDl5cVpta3REWmtNeVZZUkl0U3FQVGI3VEVER2hTNDRMZ215eTlE?=
 =?utf-8?B?dStJOXFCVUZuWll5RWQvMlNhbGhMVTlqK2hYWHdNMzVZa2VhdFc4T3lRWnpF?=
 =?utf-8?B?Y2RnRDZVT1I2cldBaURxL2RMZ2JhN1VQQ0pWNnNBRlZjclZheVZUSEV1YkRv?=
 =?utf-8?B?c0Z1T2ZBMU5pOER2TzhybjRvaW5WeXp5L3hQbUVlUmQzVlhUcHN6L2dubUIv?=
 =?utf-8?B?dTcxcE5Gb0dVUkRjZ0I3WmhzVlUvWmc2N0FUNExNT20wb3d1YlBmbmNRZDVG?=
 =?utf-8?B?TE55SjZ4QTFpK0hwdndMazJiVzlNdVk3RlM2c1Uzb2dsT0hrWFVZUUl0UzRN?=
 =?utf-8?B?MjlVZ1NoYUxqN3MxWHlYZklnUTFPN1hMRnF4SWJVQ0t5NmN4OTlwVzFod1J4?=
 =?utf-8?B?R2xISHlCRjI1eTNBN25CVk4wNm81UGZuQlkzeUYrMkZDbGlaNDYyQUxXWlIx?=
 =?utf-8?B?aEdEUXRRREI4aHM2QkdCSXhJcFd3cVFLUzdPL3NYUnY3T1IzQXJEYmJzREdV?=
 =?utf-8?B?ZFdFekhuRmwwazhodTZ2MlNtV09XM0ttNUJYVzh3MzRpZS9LY1hnSUE0VXY4?=
 =?utf-8?B?S0UrbTQyMlhJTUtFeWlkUUh2cDUrQURGajZMU1N3SW54dUYzUXJla3FzOEtB?=
 =?utf-8?B?RllaSHY1UGxOelo4NThuN3pLRkptNDAyb2tJSnhRYUhrR3pHRkpoOEdqK3N6?=
 =?utf-8?B?cDFBRDRESDhzWTdDYnE2OXRJL2c1WXQwZjVoZTl1MWgwMmpmUFVoUk9BUGpZ?=
 =?utf-8?B?Rm1aTmVCSW96MVEzYzd2S2J0NFlKTnZOTDZ0alY1dGRDeFM4WE9pb3VsKyt1?=
 =?utf-8?B?NnB3bXAwSjNiVGMvd3hnMnZVZk5hVkNwK3o1cXN1TldDejBxMSt1bHV2dDdl?=
 =?utf-8?B?ZTU0SVlNM0FqOHgxQjFSMC9ZMTR5YmhjYjJzRW5mR0NjUEV1Z3VEM3BUQmJI?=
 =?utf-8?B?OWxsMk5JakJXR05aNmxzQTd3dzlvMmlaN0l6RllSSmRZbjZVWmJjNU54UFpz?=
 =?utf-8?B?dEx2T0lNV3lHR0tTS1F5Rks3WC9GU1NhelB2VWMrL1BBamFXcmdwVENJdjY2?=
 =?utf-8?B?eGxOOXBFTzM0NlVJYzZiVm1HRnZwUExaQ2F1UEF5bzBsQmwyUmd3dE80Q2xn?=
 =?utf-8?B?OWZOV1JmRE4zQkovWHdBZmVaZlZ3R3VkeE9JMFROSE9XTHRZRDRvWUNlUWFK?=
 =?utf-8?Q?QFO9aDkwR0hKsmbs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aafc2de-1d88-4ac7-17cc-08df23b1f28d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:49.8007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiLa2mhxYZ9r+JjzW1PBPrkmy1yu+NrP4zSlVU/z8y8OzRc5voH17VOvOqMNHLc1NqfM1ObwBW9l+z9LY10uNrZah03rgCYiHtZ5rymvkC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB286923
X-OriginatorOrg: virtuozzo.com
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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


