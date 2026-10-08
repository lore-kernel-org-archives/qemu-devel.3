Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B00CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 10:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xElKH-0003Js-8z; Thu, 08 Oct 2026 06:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElK1-0003GV-S6
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:26:00 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xElK0-00014o-4I
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 06:25:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhen47O7BJ3DdrUvpsnLYbYnxgOfvlxpFKubPqpyQeLqxtzvgJhqZX1d4IXp3nX5S1hGMoE4tGCIR/cylg7d97rvBUU0xb1b1nEmUYG38MMTtDxmyKbK1GST+NUKbYeYwEq4ZuLKJqUveAjkmK76kpL55TQqSowpc6Egs/dNZT0ySEIuiC5dvPOpik1vhcTAsyhC2Tg8Kd0txOP+Fupb15arY6dzS0Fo33F+MZm3eqOau20bEAjl/6Lw3pHc01BNbprRYGohJWrWrvqAoYl/4NoaXeD6ZGW97j+AOqy7NAXjkMpjcIBNQOV1F2JufoNQ3YgE8NyHwu1TLYzLLaFkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4egCNiwVeCRftUOxghlXoBl4Eq+C/4szk1uCDqoZcIw=;
 b=VH6iiQ9GuaMV3Dq/ZpQOlOOkye9CmZljByn+m0bcZUcFlJt2DhEZ3VtVyE8La+Mkh6vfohH5ytNMH0hval4LSoSWhQFVKX2gV+rKuA/w6inDFz11eESTAh4zuF525iwWLoJ6tmVFWjx/DgaViJDgoIvd5YUsO03cseAVU7uM0zLQfhWRGEKvRHsIpVjkHUrmkXTOoHcirFE6ZyO+v6uatfrNE+oqk2R1Tzg27G/11K0XkTj9hxTXVTluvfGquyl5AK8ygLf24xqjX/jNIHwW2cT6tVBHrHUc80a799D3rBDe97rsM3Gbxejh6uBlN/PrjJMw2EsDuygEUJLKg9+41Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4egCNiwVeCRftUOxghlXoBl4Eq+C/4szk1uCDqoZcIw=;
 b=r9eFWal8NkeNsocBm9clbeKGcNOGfhrfcSWlQA6+KFIn8sIUEjb9tw6HtYV9emgmHzqGFUr8VnbJhbcEpvbdGyka2U7Ai25Z38h2W+o2pk0RaEmPnQVAMhNOM2S8RhDjXAMHxMiB7Mvo8yCdJDKuh4mLpVc0snn85e40ZYs/TbfY+mRWaZjfEMScz681z5hopvPEbCoP95znfGPTU+kDvb8TBA/wkegY1wZGTfIQrHVU9MP8wLacnwCo52bEz1Z52d/3p5eikp2C9IgUkB/QiBtk9YgzVoO5aXYuG8UcK6hSQGHv/citt1Qolx0h01h3jdVU7czRM4HaELw6roIkzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AS8PR08MB10270.eurprd08.prod.outlook.com
 (2603:10a6:20b:637::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Thu, 8 Oct
 2026 10:25:46 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Thu, 8 Oct 2026
 10:25:46 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 08 Oct 2026 13:25:39 +0300
Subject: [PATCH v15 15/22] vhost: release ownership in vhost_dev_cleanup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-up-vsock-vhost-v5-v15-15-301b73b3f843@virtuozzo.com>
References: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
In-Reply-To: <20261008-up-vsock-vhost-v5-v15-0-301b73b3f843@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, sgarzare@redhat.com, bchaney@akamai.com, 
 den@openvz.org, farosas@suse.de, mark.kanda@oracle.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, clg@redhat.com, mst@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::46) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AS8PR08MB10270:EE_
X-MS-Office365-Filtering-Correlation-Id: 52c5a1ab-19f1-48d3-894f-08df2526820e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|7416014|52116014|10067099003|56012099006|5023799004|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: ZDHXMSvdvHbH3xBWDmX97x339ViRMIi21xPMhpzDvuLFyZ3MxsFg2FX90wlGlW0j2ttw64ZZ6OsrB/RK5qcvquwyx9/83Oevxkaj6ifFPrVefeSTwe6EsVij82Nyh8anpfJPsPNUIzXmhvnYi6G7wgEpIJeqxvdpK/AnEeg2h+x6d4LCLiB+7iutkmW7dhYvHLBJfsBdCZGaBLcYcXn9OQXvz8MdOpz9gYnHnT5xuKhGZttcZrENhBspd2+0tjdwnyGTScsKtvVaDvwA/duZ2Y2Ep23mcuD42qkeoJvS0s/2bhiFWbtuW7OYnIeJDXgF1BKvSzjjGkt7P1QtrzCmEa/Ic9HDVOKrA9Qx1/D0R/vy8uYATz/sta1IEr2/KJO32JnKCEeNfESQSjnWy3oG0lWzpkrLLUlApDSPpOoKqIVwtmSCzsd1AhLMZrzbrDWtzV5P1On4p9kjgJ0eRansGm7wnSkWOMxxUbbOwWseZZUon+YL+a764NYt0+B/01MSqHEymOuEj4n858tJl2ktVMLgO6pqOl0mFRWqCJ3jMlZyD3ebwnX/rAA1ZiLsnxjg422JUAFhuGqgQPYQ9u7o6Z5nmlvFXRvEi2ASXoEZxu2RYh+DTs50+wWecs8T523aojWZrUhpfnruOfxgfknAUzhcc6eGaPbovahLIzTiLNwW1tbEB+GGf/EkA9dHIwnNYrwZzyqBgfviXqgGDcEY8CuR6msX3YRxKQwe4aezWtw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(52116014)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y29HVGZ3bngvNjFQS0UyRzUzNjh0VzZwbFB4VFZGVUNPUHpWTk1zK1JkVHhN?=
 =?utf-8?B?ZEVXWHlFNGJRaDFnc2w1cFJWVFBFU2VMTysvWjU4b25qbFpBUnU5dWROZ2FN?=
 =?utf-8?B?WUZ4NFhiaEd4clc2NS83aVVvYlUzTTBpZGRsaUhhRjY4TS8zNS9ZQ3dNWTZE?=
 =?utf-8?B?ckRwd0hSa0dsMU10eGl4cnI3MDBKQjduVE9Pb2t5UDBhT2lXSnlReGQxTnlL?=
 =?utf-8?B?clZrM3lVZ3JTaEtkUFhSSHl6Mmw5QkFnN0pOOGJkWVdveW1sQXdYMXYvbnhM?=
 =?utf-8?B?aXpCN1d2NVR0c2t2bW1DYnVobUN3RmVyVU4xSlNIZGxGcEIrM21kbkJKbnpy?=
 =?utf-8?B?bGtrY1Z2VDF3MmcyNlNoUjFyVGc2bzl2dk00VWRFUkJWZG44am5BWitsdjZi?=
 =?utf-8?B?T1lEc0o2M3ExQW1FaE1SQjF3UU1jV3lVS0NoYjQ0N0E4cHhBdS8xdEdud2E2?=
 =?utf-8?B?U2pDQlRVUU5qQ3MyS09uaHY1SUluWmZpMkhaY1llbWFncnQreCtrV2Uwd1pi?=
 =?utf-8?B?OGxnOHhMWUlMSVhNbzNoT3BCRmNIVXlyd0RWbkNFWFFPZHJobnY4YnQxdHN1?=
 =?utf-8?B?QWw0bzQ3NXd5Vk52Y0gyeEhsd0tWYUNnY0JkSzh3eXhlbzRqVE1YZndaNXFj?=
 =?utf-8?B?SVZQZGMxbmhrRXZWSU1USTA1Nzc3U1NJcGE3LzI2UWxQU3RBd1JjQ0xXNTJT?=
 =?utf-8?B?ejB3Y1ZZbDBGKzdkVXVCN2tudS9BbEs3ZVhxd211MW8zR2JCTEJCMWh0Rlls?=
 =?utf-8?B?OSswTnF5STdqK0FPTzk0a0ZvUU9SQmoxMXE2UVgrYmlhUEhyb1RNOFNOTVA4?=
 =?utf-8?B?SUlPUW5pTmF4dHErc2FsdWJ3eEl3Z0gyY3Z4QXlQcWR4bi9VMmV4MHNPS2Fl?=
 =?utf-8?B?OXpsMThFamRjSDNQK0pFZHBjMnE0ZEtERWsyekVISWRMZmJDSGZ3N002YmFP?=
 =?utf-8?B?LytIckpXRk5DZkx5ek9TbjhoTW4vLzNyVTJHUm5GV3hIQUswa1ZObURIaFJO?=
 =?utf-8?B?eVVyVFJJb1k5UG5IaEl3eGZZU3ZSYUVINUg4akRiYU5CWEhJR21MREU3QTJk?=
 =?utf-8?B?ZEZiVjNMR0FuZUwxelpVNkx5OEpFYnNqUGF0VWlGUkgrTUxPc0JSb3lPdyt4?=
 =?utf-8?B?bWxQcGQzenh0UUtyTjNqWVBHVnZPVzgwQTN1L1hFeUpxelNLR3F5aEhNTjJS?=
 =?utf-8?B?eDFRTXVNc0pWMlhsWVUzYmJ4c0ZkSmQ1VVEyazVJNXUvdHRKMHcyTm9zbFNZ?=
 =?utf-8?B?MEFJcUpSc3hSV2xrQVE0WVdBUU1hMWU0YnQzaWFaZXJ6M2t3WlROU0tEY1ds?=
 =?utf-8?B?dERVUU5uL1lvWmJuckFKTi9laXoxb3BHc0JyZFNsUnZLL2lDTnBQRlVTSkVi?=
 =?utf-8?B?WjVkWGx6cDRnT3ZYVzhVbEp0NENOTXo1NUJMM1N2MS9wdnd5WWxWcGNHTE16?=
 =?utf-8?B?NzRnUmZONE9TcHJkaVhzOWZKQ0M5bkJ3LzlZWjJqemgzVWNpSkxWRURBeitC?=
 =?utf-8?B?ZTI5bWl6Nlc5SDBEazNHeFVnY0VvRHFrK05VYlk2NnVpUjNuRkVRTHUvOGdh?=
 =?utf-8?B?dDY5WXpUWDZrcVdCT0QxK3F6RmVjUVh5RVAvZlNDMkRYV000anlvcG5DMUl3?=
 =?utf-8?B?cHR1N1VSa0dGOVVnQ3pxS2FTYjdMcng5dzR6Q0o1ZUI5T2tpVWJMNlRvdGVa?=
 =?utf-8?B?N1VseVA2OTQzQnJvRnI1djI5aytUbzBYamYxVlc5a0o5YXZWcUlieE91Y1BF?=
 =?utf-8?B?TjJXZlhFcFVHVmtvL0FtZG5mU2ZpMkJyWHh2ZE5MMUhwcXpNQVdCMDRwbTA0?=
 =?utf-8?B?ZWxwaEpBK09ESndnd0haVmpBaWxRSnZmUzlNalArUW93eVBwNzVHbVl5WUc0?=
 =?utf-8?B?SVY2bGhKM093ZFlOSHNKNVRiZUlINEw4bEx3ZU1NcXQwbjBhN2dNMEh5RzJs?=
 =?utf-8?B?TFFmRHdRWWdacldJS2R3YU5zWlJoaTZ1bzdTQkJxTk4xajVjbGtxRnF2TTZo?=
 =?utf-8?B?MG1iUE5wYVJpNUFhVk9QeTY5bDA4Y2g4cTh5c3l3MkJBR2pLamJjREI2aXZ1?=
 =?utf-8?B?VHB3R0d3TTZ6bWtiRjhoQXFjN1FNS0d5d2tsdE5HaTk2VGZWNGx6RTRPNHE1?=
 =?utf-8?B?VkhvQ2lyQ3g4UUh5ejFsRlBrT2FVRlA2NGdublN5V2JxWTRDdFhvZ3dpbkM1?=
 =?utf-8?B?dEEyYTU3VjVjY3FhMkpydlJJSTBuckdwZHBBRHVKeWQxaVFOM1BncUwyVk45?=
 =?utf-8?B?YlViU0twN1BZWTdtWW1CQnBDaXB0RW0wRHRvWGZ2b2FxbUFUSklheU1OZjlU?=
 =?utf-8?B?bU5hUlF3RHJBVVk4NGhOL1RzNll4RzNBazJpdmtLTGYwOHV3d1NjZ09iVGFS?=
 =?utf-8?Q?YEw7qSpf/SoPAUpA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c5a1ab-19f1-48d3-894f-08df2526820e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:25:43.2481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84A1SH9bko2fh78cJht18O4M4/vLCMBQWrGLkYM+P4bwVOLRE2xSGy5lp0mJklRrA3JtIu7QYImLWx4Lcsot4EJ63ghRG7scHFguH8LL1DU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10270
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

vhost_dev_cleanup() closes the backend FD, but that doesn't release the
device ownership taken with VHOST_SET_OWNER if the same file is open
elsewhere.  That's the case on a CPR target: the source keeps the FD,
so if the target fails after SET_OWNER, either inside vhost_dev_init()
or later in its caller, the ownership stays with the target.  Once the
source is resumed it can't take the device back, SET_OWNER fails with
EBUSY.

Track the ownership with a new 'owner' flag in struct vhost_dev, set and
cleared by vhost_dev_set_owner() and vhost_dev_reset_owner(), and issue
VHOST_RESET_OWNER in vhost_dev_cleanup() if it's set, as the common
teardown for all those paths.  That should be safe in any case: the kernel
refuses it from a non-owner, and an owner is about to close the FD anyway.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 40 ++++++++++++++++++++++++++++++++++++++--
 include/hw/virtio/vhost.h |  5 +++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index c01ccc800cb..8fd0af42a0a 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -53,6 +53,25 @@ static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
 static QLIST_HEAD(, vhost_dev) vhost_devices =
     QLIST_HEAD_INITIALIZER(vhost_devices);
 
+/*
+ * Release the device ownership if we hold it.  Backends which don't
+ * support RESET_OWNER have nothing to release this way.
+ */
+static void vhost_dev_try_release_owner(struct vhost_dev *hdev,
+                                        const char *when)
+{
+    int r;
+
+    if (!hdev->owner) {
+        return;
+    }
+    r = vhost_dev_reset_owner(hdev);
+    if (r < 0 && r != -ENOSYS && r != -ENOTTY) {
+        error_report("vhost: cannot release device ownership on %s: %s",
+                     when, strerror(-r));
+    }
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1705,20 +1724,32 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
 
 int vhost_dev_set_owner(struct vhost_dev *hdev)
 {
+    int r;
+
     assert(hdev->vhost_ops);
     if (!hdev->vhost_ops->vhost_set_owner) {
         return -ENOSYS;
     }
-    return hdev->vhost_ops->vhost_set_owner(hdev);
+    r = hdev->vhost_ops->vhost_set_owner(hdev);
+    if (!r) {
+        hdev->owner = true;
+    }
+    return r;
 }
 
 int vhost_dev_reset_owner(struct vhost_dev *hdev)
 {
+    int r;
+
     assert(hdev->vhost_ops);
     if (!hdev->vhost_ops->vhost_reset_owner) {
         return -ENOSYS;
     }
-    return hdev->vhost_ops->vhost_reset_owner(hdev);
+    r = hdev->vhost_ops->vhost_reset_owner(hdev);
+    if (!r) {
+        hdev->owner = false;
+    }
+    return r;
 }
 
 int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
@@ -1864,6 +1895,11 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
     if (hdev->vhost_ops) {
+        /*
+         * Release the device ownership if we hold it.  Needed e.g. for
+         * failing CPR target, so the source can re-acquire it.
+         */
+        vhost_dev_try_release_owner(hdev, "cleanup");
         hdev->vhost_ops->vhost_cleanup(hdev);
     }
     assert(!hdev->log);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 73ea130d7ee..f6e32b59ab2 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -111,6 +111,11 @@ struct vhost_dev {
     bool started;
     /* @initialized: has the full vhost_dev_init() completed? */
     bool initialized;
+    /*
+     * @owner: has this vhost_dev acquired the device ownership?
+     * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
+     */
+    bool owner;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;

-- 
2.47.1


