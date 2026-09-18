Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8D8C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YwF-00033o-1n; Fri, 18 Sep 2026 09:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwD-00033E-Lo
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:37 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwB-0003Df-Bt
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxVXgxvhVi4exWnzVxw2BPK3uychVLP5Sa3SAVuxtWTdweY4Mzj1Ckv22SROZBLu52Toab9mi15Z6XTw8fmk+s4TyX9mLb+UT7rg4z+OEHmhAFUDD34SVgyg6foCtz+1nzNNGVUH5GIslI8FSNvqdseFZP8TfNs/g4BUZv46aXtzGLNRjp9cRat3mUJFTKCdgd/+CTZ0hTOW4D/gVb74+8kvuiDxkjUV38H64JDi4PGPk2e3hLjIcLqVKKQHcxNFAFwuT1rKHQgvYDoqapTZN6+6hTaj6mmYMuRIPSLwzKOx4ieYBCgyvikfp1LucPp7vSfJqN/abQItvmYR8ueAnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=csxsGtJre99vDtC167fWDTOZfoCYTqBvAslE9QcPdAqSkvsYS5+ioyEd0I/wmy5R0aJpF7AEYBDShtel1ntKEEDk1RvvcbRzO9f9CEv7Ra0M+8cVFGg8zdM0rwv36YGx1u2EAcobRiWjrELQgd2RMnOcWbL3PHNBrQrkee9QqDS1EHq1FnAe4u4OgwXflxtuBMiXpezR5fztd/6uAcLMSmmoTqef33ysNL69eLoHeZe4GLsT2/Wby25GO4loXN1HGNvRxJthIwpyC/viwNok6wtgOAJoxnsQbmJJRTrbo75qRHvxq4lVuyyvi+f//Qd/Up0wBi7PTdHJs2K7o1PvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=ewtFfzuPoUWYZ4Gd3oT13gc6QFXxJA6q7Qfz5y5S54TMTe6mDCwXOo5vnMSzZoSaGGRL9qQ5QP5YHKxreZHj9OkgJTppIWtNvFEZBTsDRys8cHpao0QWFacCLRoub9XxCxqb7KDIOqLMVYDuWSU3SWJxnYcj/5sWyyNE+UWSW7g17H+tUMX5VqSw+AbysPm5PtE8AFgTvcSmUWC2b+8Atc1S3QVarDXirHOtPkF5Z1F20xZ+iSu2sjLZs6XdUcFRfnfILuiW3fowy/FY1NfijT7ZGkBvbNIKOfbK9kH13VZX6SirBsClyGlr0M6P9eytx6nsjYhrw4FRw5HNk5oxFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB7933.eurprd08.prod.outlook.com
 (2603:10a6:10:37b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:20 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:20 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:46:56 +0300
Subject: [PATCH v7 05/16] vhost-vsock: block CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-5-6ef9ef033c35@virtuozzo.com>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, bchaney@akamai.com, mark.kanda@oracle.com, 
 philmd@oss.qualcomm.com, vsementsov@yandex-team.ru, 
 andrey.drobyshev@virtuozzo.com, maciej.szmigiero@oracle.com, 
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com, peterx@redhat.com, 
 den@openvz.org, sgarzare@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0292.eurprd07.prod.outlook.com
 (2603:10a6:800:130::20) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: e63a6f4d-833f-4271-fba7-08df158b5c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|52116014|366016|56012099006|10067099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: Ml/YlqNCrn+xzkY3nv2YPBwHOlcmVZh7sYDZE3zqRVH8hleTcxvyll1rWru21egiA9Zyibqx7vnSHvgUTEWobR5Gxy9kWOrdOpGuhD2MyBXi3WBLHWoDHumzTi6FRj2sL5JukQmKwqP7MhM5wGEl1X0Py5Uvyc4CDLS+QMe8rGEzHiW9pv3DxEmA8xMvne+zQ1Xz99A9lx7Ui36a0gwnv+UQPJfxAdttCIfQY7f8q0iS2X+Ns3C5SIr42iba6l/IAkkoWbpUhlN+wgdf8XMLZQKGEMLBNBFunVB7ExC0UiUAnYfWL750e/esLYrjUzDB30c5kYRnGKdYT51CEo7FHz4of5NX3sw18AS5KLsznwpl8KSLNPjl08MjxX44822J9X8VsFZoALbCKId3ZcFKfxJCSNOD23+oa1/foFPhMbGKdk8uSHKzRAPiIUFEqPFT1FsnV0+cL9HWtg18ZMSzClXEXC+J6cqLHVoO6/nJKwFoM7EkRc6gWzzOp7S6Io7WVY0EMTfvgNxvdC6OXokLFcCi0lQ98yiRuvBdvxMQtpoiSSTPEU1u+Inuzsw3Gfaj8lo/+EbfWkCiuin+yalL1AZ3VmGCdfeQuNDPw98HTXTNwsxBByYSUV8v/VbXXyRAYXXMg9PBeIoARavU357X1PIpUExsspEga33sTPIwAu/8r/emPYWBM/zRNYLprZmIjuUAp1YuIl78lqmWLu4QS1TKdwN7bKD9XyYz9lIRU+Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(52116014)(366016)(56012099006)(10067099003)(22082099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?citrZzQ0UVM0NFoxY0lQSG5tTEg2OW9PdEx6TGMxN3JKNTJVWjE3eWdRNnQy?=
 =?utf-8?B?dzU3TUVFSHd1YUNkKzFFQkJUWWRpMEdOb2NsaTRJVkJnWWQ3RWl3c2o1RXV1?=
 =?utf-8?B?aktEeS9kcVU1YnRzMlZNQkpHa1BaSDVYcWJWZjY3REtjNmJyVVpMSGdvaml1?=
 =?utf-8?B?cmMrSlJ1Yi85V1lzK0hCNnIwSVZNejNBSDNSV2J5TXJkSUJ1OWN0UkFqMGdr?=
 =?utf-8?B?L0h4YkRCMFNWSXFwb3dTb2pOK2NnSHNyNWlGMEVaU2FUS1pYVWYrK3I5eUps?=
 =?utf-8?B?OEJtbUFreGEzRWRoUURYdmtpRXRGSUdJN3JFT0s3RUNjTDRqSVc3Y0dxeEFi?=
 =?utf-8?B?c2plWVFxTlFXSDJLaVltTk5JbjFiLzBPNWkwMzNySFJmT0VwaWNCcjZhZjFK?=
 =?utf-8?B?aE5aYndPa2d0RG8yZ0p1ZDJTL3huVmVpN204dGF2SS91RmNBdmowZDlYRnFm?=
 =?utf-8?B?aU55NThZLzR4VnlQVy9JTS93Y1haOHlsRzJhRmpLMDBQbUtXMHhEWmlqbzhX?=
 =?utf-8?B?RU5Ubi9oRXI4bThSRVVIaWhPZTRiaG1XVG1yWDZCMHRham9OSGM0dzROUDZi?=
 =?utf-8?B?Q3p0bVp5cGNVOVNjYW5LbUw5TDVyZUNwWXljY0dmai9aZjhQU3VpMWdHQTlr?=
 =?utf-8?B?aXpZaXBuL3hmTXFoM0NOUllSdTJIcHNFaDlZMEh5M3ZpaUF4VVFhY2lJSWRE?=
 =?utf-8?B?MnBsdVorcDQzNXhIUFNkUEgybVArM2pueWU0NldaZURQNXU5VlpsM1piTG1G?=
 =?utf-8?B?eHNUWnQyRGlsQkVSRm80YkIxMnFlVTJDM29LaFdLUDdkUGxPbDZ0SGN5NThF?=
 =?utf-8?B?SHFOblAraWZWSEpGZHByUENQbmVFZDBIaStneHlmWG0zTmRXeHd1eWYxM2NB?=
 =?utf-8?B?NHVIdm5udHVyQWJ1OEFPRmMxWksrZjV3RkJTVjRINjc4M0hSb1czM1RJa1lW?=
 =?utf-8?B?azJzS3JHUUVSTUxIWEYwWVV6Zk5UdWsybGFSMDU1MjBlTXU3RUdMSFRuWEt0?=
 =?utf-8?B?R2MwS0xzSDZvUE5NcXBwaWVteldGRXdZQlkrY1dLRWhCbXVHeFp2VEdNbGhM?=
 =?utf-8?B?TUk4TFNoSTVHUTh3RUlUVlpDVHBHWjF2TnNPeXBZRmJJLzIvTjhML0craExB?=
 =?utf-8?B?VUF1elRVNEYzUUtMSTluUzN2WlJ1dFJONWNHaEoyd1lUcTE1cmF2OWtyVWhG?=
 =?utf-8?B?ZmVxcTVSL0IrVGJRYXZhQkZLTlh4TGsvZFZEbzVWWXZkWTVhTEg2bnlTeHRU?=
 =?utf-8?B?WllmaWYyR3pibHRwa3pxS1ZWVG9JZUlHRk1IUUhvbWo4a0g0REp5bE53eUpI?=
 =?utf-8?B?dEcwWnZoWElsM3ovVXlZVzl6N1o2My9aRWw5Uno4SXdhZGNpQnEyL2ZMZlJW?=
 =?utf-8?B?U0o0Z3c4WjZsMWloRmZVZ0tMTGNPNVljcmJILzBFVW9zVUZrZ0dTSGtTR09Q?=
 =?utf-8?B?SWdrRnJ6UXNGZmVKZ1RmTDZLZWdadTBwU21ydUFITksrWmpreVB2RkN5MWxQ?=
 =?utf-8?B?bnlmbFk3bnVITlVFZktva2hkUWw1UklQWWJtYUk1cXVsT0RtSFh0Z1RFR3lt?=
 =?utf-8?B?Q3JQYlRnNE9hdmU0a0ViMjQ4UUZEd1RpUHgvMys4cFB5cXh2Q1p5WnBBbndK?=
 =?utf-8?B?NldYU0ZQQVFuS3dudUFDZjlxWlBubzNQOVFkYWZUYVVVa055Q1R4RTFZbjNJ?=
 =?utf-8?B?MjNxS3VQSENXMDQwbkR6NFJiLzh6K2dFMSttU0RSY2hwMms0RG4vL3pTeE1l?=
 =?utf-8?B?THQ4YlJ6ZVc2REdSZTNKeFhJTFBVUGoyM3BudTVQSTh3dUNBWlEwUGNJR0Vx?=
 =?utf-8?B?aFk1aEREZFdCQ0VRbSs4b0RQK0lvSFlYY2FPQ3RncThRUmsvYWZ1Q0o2aUEw?=
 =?utf-8?B?aU1iK2ZFRlFFVVR2VmlLdjFQN21QbCtOTEYvd3lkdDBoRVNvS2p5Ym4yaUor?=
 =?utf-8?B?OG1ZMVc4ZkpaTzNvMEVwb2JwRTRkdklHU1hINW9CVjVtTEFSakhaNzZvSnB4?=
 =?utf-8?B?QlhGaGRUUCtmUWhTZHBwY0RLSklBK0V6V0NRbW43SURWNlExenIvS2RpUHNR?=
 =?utf-8?B?KzY5MVhmOU01QnhSMzdqVnRDOFB0VFhaeTlDYXpITmpFYXFLVWJpTkxjRFRV?=
 =?utf-8?B?N0dqQjdud2dsNlh5RUdobTNwN0ZpRG9ObjRrU3JNb1pxSUg2cUdieGl3WTN0?=
 =?utf-8?B?aXhpeVhnKzZ4S21qZ3Y0VUM0WXdYam5Ic1VlM2NoNkcrTmwwUlVzakN6RTFJ?=
 =?utf-8?B?YkJyYy80QmY1QzNHSmVRUE54cThWYklTbGlKdUY2aGhNdGlKSjN5NG5lM0ZF?=
 =?utf-8?B?aUo0d1RESzlxODZMcVQ4SFBOZlpIOGxDTjZmM09FZkVyNTRobU1zYWJNdjJn?=
 =?utf-8?Q?7+pYCnWxOSWho+0c=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63a6f4d-833f-4271-fba7-08df158b5c33
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:20.3222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0LAB46wp8HoneoloEjEdqK0S/oPDrp/y9wmhVZi/H9l+vw6FEmGDQVqM6wDZe+YevIm3phYdHri3XWgfShUtW4uPdDqTgPu6GxinQMCJyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB7933
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

CPR migration with a vhost-vsock device currently crashes the target
QEMU.  The device ownership is not handed over, so while the source
QEMU still holds the guest CID hashed in the kernel, the target's freshly
opened vhost-vsock device fails to set the same CID in realize():

  qemu-system-x86_64: -device vhost-vsock-pci,id=vsock0,guest-cid=3:
  vhost-vsock: unable to set guest cid: Address already in use

Add an unconditional migration blocker for the CPR modes, so that such
a migration fails early and gracefully instead.  The following patches
implement the actual vhost-vsock CPR support, and the blocker is lifted
once it's fully working.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/virtio/vhost-vsock.c         | 27 +++++++++++++++++++++++----
 include/hw/virtio/vhost-vsock.h |  1 +
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index da244eb1657..503d248a617 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,8 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/blocker.h"
+#include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
 {
@@ -140,25 +142,38 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /*
+     * CPR migration of a vhost-vsock device is not supported yet: the
+     * device ownership is not handed over, so the target fails to set
+     * up its device.  Fail the migration early and gracefully instead.
+     */
+    error_setg(&vsock->migration_blocker,
+               "vhost-vsock: CPR migration is not supported");
+    if (migrate_add_blocker_modes(&vsock->migration_blocker,
+                                  BIT(MIG_MODE_CPR_TRANSFER) |
+                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
+        return;
+    }
+
     if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            return;
+            goto err_blocker;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
+            goto err_blocker;
         }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            return;
+            goto err_blocker;
         }
 
         if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
+            goto err_blocker;
         }
     }
 
@@ -187,16 +202,20 @@ err_vhost_dev:
     vhost_dev_cleanup(&vvc->vhost_dev);
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
+err_blocker:
+    migrate_del_blocker(&vsock->migration_blocker);
 }
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    VHostVSock *vsock = VHOST_VSOCK(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index 84f4e727c70..a964d57e1bc 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,6 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
+    Error *migration_blocker;   /* CPR migration is not supported */
 
     /*< public >*/
 };

-- 
2.47.1


