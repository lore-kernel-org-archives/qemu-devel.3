Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F542C43327
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:48:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd9iI-0001SA-6W; Fri, 26 Jun 2026 12:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9iC-0001RV-UJ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:47:28 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9iA-0007dq-Or
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:47:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggqANCVBsCJ2MpyAES2erCClu3mE+H8cmb8lUSGzlGQz/1eHr4ZWjN1ujwohb2ovxO8mR5F5idnuSEMHD441DXvwShxi5paNJVT8t/OCX3t6jjU/RYwBOsaLNWoKb9qLcal1RA1UjizXBM4FvG7oNioh9vyejIZDxCMKPK51wbdfSSsLozALqQN9YMrPJHT5y8eegWmXU6PH2fCDeuWei/YLCH7PwbjXvt4FQlOqdOIMvTAOfD9VRpwsNECvjRa9BgTBSRvOyuyBf1cHHXwCh39wrK5cL6fGE7KHSG/LmdQLPKV7UfJUg0L/oPH+Vw+289ESRgfme8ZH0/RLVDrGiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xof2VDEtBz2bmBuMETloPnrQZJmaKtafo9dLFC9qPgM=;
 b=nhyCW7KMz2SkzbAZVCWZV2Dx5iFaCdbXlOjNuKnW9covDA45YSyunej6YbLoAN8S91VRbMw3qVU8WmcSD4kbL05AAWRunIK4MedcNHuEWIkstbDJGAMiv8P8HxBMFuyNPGJhU6MlxeNiwIr4Unx8+HIgZSKNTyEmQlmocJAbhWFiPn3MR86y7NcLspnlNqyvg3HHfatLaGDjccWxAN6FGoD+6dzCYdrdclt04kNsGNZg7zK6kqOoXOSNjQrfNl44IZTP+XTyupkZAtjxLr9lrnQXiwNRcfGMxxhHPYbpgcDf6fBybwf8cd+BoxIVPmABlXWreGjTGXylRLZvd1/qLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xof2VDEtBz2bmBuMETloPnrQZJmaKtafo9dLFC9qPgM=;
 b=kYnTxf9h2WathhpLLZ8B0QGBMS8o7Vtzexozh6VBQ0mGqas420/tzkJGqEjgIXpqTNFxdO/Br1D7qWH2sS2ow1cJ3J7XUCLrUXyBKPFBg5OUu0LMpK5qrI9qTdhTZi8zDIhdJ6uBvFCNIXns1uguCm7a37HE3fAXhSHDHtfrUNFRMbCpXk05dA/IizB1UH8s/kVyKe/bQPMpsrnKFifOKGDnIHvh2v++Uz3xTPA5XMxr3fCskRGCEM8ELowLDCfHsCXTD9GKN0wDV8syaU6pjQjsMCaNeBqLV2xAJYr1RZI5ZrdiWCFdG1sycBKuh20MjDfEhEL84YZmJjFEXMHRyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB6347.eurprd08.prod.outlook.com
 (2603:10a6:10:253::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 16:47:05 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 16:47:05 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v3 7/7] vhost-vsock: hand off device ownership across CPR
Date: Fri, 26 Jun 2026 19:46:43 +0300
Message-ID: <20260626164643.2526-8-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0088.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: b093abdd-6634-469d-4336-08ded3a28dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|52116014|23010399003|376014|38350700014|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: rCYBgOowk0akoQ9AozCq2xMf+bbLy4hTkplxZcavrmU7hfR0IJKfW2CJmtDJ6ibcQ7FLM/x+fQ0x0+btqg2NLZgYy2g8vpVG+h5qXiU9fnzb2jmX2alg7h7IRInAkvFm07ja3nDI9Wuc/o4ZmhCU3SN+AiwKwMxQu6TkuG44M48DwnTcs1GQTZGYvY5HsQ/UIeNqBvPHAV8mCHNYOoPfhJVLFfb3GKNjgV1LhLYDgTsvCXoB1U96aysLm+/vb5krwAqnni3CGN+ImZG1C4M11bSxbRzUphQ8svHn59RdstEo2THePR9FayTxKYeMFYLlWL2V031Qh1QZCZnmTpubO7clyu+loJiW3AiUqhXNkuNcXQdp15epNLUnseb36+ZnvDLJjmzuXGqFm+ecxYwyhV18YJoNAC6UQcHHxFl2BQxOJpkOUyDaCSC1HWl5Hg05jf8SE2oYHmXaSDeT/m+JqzRnX3xV71FmX976bOq1kXhdxRF76w3oQWV3mqeaNagWcVa+v6D3CHEbK2TUO3sjur1Pysmyf7QcRz2CPMi8Xw/vDw8g0VZ44VJLrLdFVlVGRrhFZ4xtC1FKt9ElYxXuB+VXWXZz26t8n5UbVQBsZU1JB7FOSzCOM3+/hisWmHPbJ6fgbtYjZq2XxuJc4wHUdr9RQC4Zjl1eyqHKiRpXbUZYhAhvcwwaDTOX5L6QeBn4gdJ8U7cu1ncFGZreO2oQDUuMjDPYTbZPG5dK2gEmaSc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(23010399003)(376014)(38350700014)(22082099003)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERQnaA8VcCzDZ+eqGqLSWXUckyv7DXbOl+WDx6MTUk010EDQwUyQKkykrDgG?=
 =?us-ascii?Q?xj0vF07bqASVaRPszkcD5CFOdEiaIDKqK9lIy9RP8iocMrN/A7UOfDa3HMd8?=
 =?us-ascii?Q?TVm4h5Zss7g4QSRV+r1uULxzIUAoHJC3ARlJ/VDDUjAibs+WoO2A7q3ruXmC?=
 =?us-ascii?Q?6qbLP4lJ0iLTJobEah5A7Cw3RNObH1anyFAWVYbUnyzY5cIdbSmJpRYAWmPO?=
 =?us-ascii?Q?JH3fWco0zy9IHvGejk6ZQEVnshDJDmKSzY6wwqrgO4oyoYY54+YZzx/dpzXf?=
 =?us-ascii?Q?PVeqaA9AtXITr496iFN/4XWpKbHiPgDdVNqnpmHlAHiMHnF1OGOlqjq9SSjS?=
 =?us-ascii?Q?JdWjWFHuvO0vxD5hPrZ8MqyyLDMUqNisBhfrnbfanjSPSVx9w9xfRrVyLU3c?=
 =?us-ascii?Q?MBIirZGixT4Vhc44J3CkIrSgevKmU1OjHK/Pf8N8roQjP8tjNW49aC1KAtSV?=
 =?us-ascii?Q?Ry4tZ0JID8V87E9nwSho0/2J/9zZTADIDTdp1iRU69d4YhmKrxAmQEaPEuhv?=
 =?us-ascii?Q?Fn2BMhhfWdAn4ogPAsuEJsr+Uc3bxyPWIQCJtBlwjy6BalbpiQL3MqVaZcam?=
 =?us-ascii?Q?P/yokrVPh6EYjQsm9cEpvgmLOYGeSNtZaucVXaRckW61hkGu15CPuWBa3KTd?=
 =?us-ascii?Q?+aozfpHdwLlrVajAnDBv3mlpBWT/8WVZPo4at0tF+PT1bzZJcMlGuQwyYeOK?=
 =?us-ascii?Q?gUjfyDQxBSoxyHCSxz2JNY3kjq7Mz4mFVB7M0CZrm+lsxnplZV6fHcfaVXT3?=
 =?us-ascii?Q?NpPpGIhbgv8/m6n06DhbRxxB9+BbQobw3Qgi3az1rdaq1WAB3QWGrgSN+NCL?=
 =?us-ascii?Q?RMH5rkzUKE9AsOP5YQ9FPw2wAubo8rjFUY/efYTvwaLcJh2o5L8dji6M6KwT?=
 =?us-ascii?Q?wnxZYeyRxTyTq6/bQ8m47O592iNdl6yaNloAjKvuj648OV7HVjjMZ+rvJ52G?=
 =?us-ascii?Q?O3s9lfcAHi5QuLwo4LniR2drYiiVhE1xAOb7a8GHtUztWkpPK0dW2cFX2DwW?=
 =?us-ascii?Q?4bMPyPwLFPqjwSk5wAeIpbiNnIQwxIfXJEE1T4l8IjPfmELJEviRBVaxorK+?=
 =?us-ascii?Q?TICcNxk0jmYBmu7EwnhK0T4Pvi0x5CMhxmqZBtDni6jF3+1ZzDg2Om1xsCcJ?=
 =?us-ascii?Q?lHDjNJjYKXD0oiuaR4pb12KbBMK1nb1KynXL2blLJs8B0M5HxN2xRU7fqQKg?=
 =?us-ascii?Q?SliOArNRsrW0SqJf+ykbi0CZIYxB0Qd0NVbGiXL2lQ9FW5JKzq6o4Ro8lFUU?=
 =?us-ascii?Q?zqeF3SPGCucVnjZDi+em8ksmnkNb11NB7SfovcEJWCzBSs22B7sNqSJU5709?=
 =?us-ascii?Q?z2UPHBycgNp09qsGEGjj3hUReTuLryx44QMhvLghlt5JWMsp45S6tseuQ+EG?=
 =?us-ascii?Q?CeohdQKpD0eBOZDQDtjzW0WnOXO9Z7QD9MIRafGGMQ9v06KYc/CR+eaBCzyg?=
 =?us-ascii?Q?+94ZNjCNKWRsF/U5k4AQDiVTfmLN1269tzykgffiSu/x1PxFcgewqHIsi2fE?=
 =?us-ascii?Q?mjIQRzoOUPV0NeG3LOPntvuKxYyyq6TTRXzWNn8V9XI0JlOg/PF1qwqzyNy/?=
 =?us-ascii?Q?Ep1lely/2JJGMuJT7eX/kFOUfQUhmGU/hhGzXAGqKHQ1usAQuTLm+SnOgSC2?=
 =?us-ascii?Q?F9fbtElWX5P000A/3qO1UlcrvRWYbuvENMNjynGMFQdik+eYXEGrOMaMFWPi?=
 =?us-ascii?Q?vzArJlWi1n7rNCqlgQzpvlniSpdOcZ2pRu6mLnrNcd/TLFFbTgKL2if3l7cj?=
 =?us-ascii?Q?s3OUSgbDCxdYgjbwit/aXUrHvHdCaew=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b093abdd-6634-469d-4336-08ded3a28dd5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:47:05.2098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5bnheJ/e1tsSMs8g6ZrQhp5vpfkcKDoGtJdiPXxnO5538T9wbXEapRXnGfMwxPsL/pbAf32+is8V1KXlJ5Q0SBPVInL1s93QcWvWBpMGjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6347
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

The previous patches reuse the source vhost FD on the destination,
however both source and targe still call vhost_dev_init() (VHOST_SET_OWNER)
in realize().  For cpr-transfer the destination realizes while the source
still owns the shared FD, so its SET_OWNER would fail - ownership has to be
handed over explicitly.

Do this through the device's CPR vmstate hooks.  Namely, release device
ownership in pre_save, reclaim in post_load, re-acquire on failure:

  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
    cpr-exec).

  - .realize(), for an incoming CPR, only sets up the virtio device and
    queries the backend features by calling vhost_dev_init_backend().
    It doesn't take device ownership and doesn't touch the VQs which
    still-running source might use.  The full init is deferred to
    .post_load().

  - .post_load() reclaims it on the destination: the full vhost_dev_init()
    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
    the device is started at vm_start.

  - A MIG_EVENT_FAILED notifier re-acquires ownership if the migration
    fails after pre_save released it and the source VM is resumed.

Also harden vhost_virtqueue_cleanup() against a NULL vq->dev which can
now happen if an incoming CPR is aborted after realize set up the backend
but before post_load initialised the VQs.

Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c         | 147 +++++++++++++++++++++++++++++---
 hw/virtio/vhost.c               |   2 +-
 include/hw/virtio/vhost-vsock.h |   3 +
 3 files changed, 140 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 7eacb608d07..b02b3f9cc03 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -76,6 +76,17 @@ static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
     bool should_start = virtio_device_should_start(vdev, status);
     int ret;
 
+    /*
+     * On an incoming CPR the full vhost_dev_init() is deferred to post_load
+     * (realize only ran vhost_dev_init_backend()).  hdev->mem is set only by
+     * the full init, so refuse to start a device whose handoff never
+     * completed rather than dereference a half-initialised vhost_dev.
+     */
+    if (should_start && !vvc->vhost_dev.mem) {
+        error_report("vhost-vsock: refusing to start, device init incomplete");
+        return 0;
+    }
+
     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
         return 0;
     }
@@ -111,18 +122,102 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+/*
+ * Re-acquire device ownership if a CPR migration that released it (in
+ * vhost_vsock_cpr_pre_save()) failed and the source VM is about to resume.
+ * This runs before vm_start(), so the device is owned again before it is
+ * restarted.
+ */
+static int vhost_vsock_cpr_notifier(NotifierWithReturn *notifier,
+                                    MigrationEvent *e, Error **errp)
+{
+    VHostVSock *vsock = container_of(notifier, VHostVSock, cpr_notifier);
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vsock);
+    int ret;
+
+    if (e->type == MIG_EVENT_FAILED && vsock->owner_reset) {
+        ret = vhost_dev_set_owner(&vvc->vhost_dev);
+        if (ret < 0) {
+            error_report("vhost-vsock: failed to re-acquire owner: %d", ret);
+        } else {
+            vsock->owner_reset = false;
+        }
+    }
+
+    return 0;
+}
+
+static int vhost_vsock_pre_save(void *opaque)
+{
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VHostVSock *vsock = VHOST_VSOCK(opaque);
+    int ret;
+
+    ret = vhost_vsock_common_pre_save(opaque);
+    if (ret) {
+        return ret;
+    }
+
+    /*
+     * Release the device ownership now for CPR migration.  The device is
+     * already stopped at pre_save, and destination reclaims it by calling
+     * VHOST_SET_OWNER in post_load.
+     */
+    if (cpr_incoming_needed(NULL)) {
+        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
+        if (ret < 0) {
+            error_report("vhost-vsock: vhost_reset_owner failed: %d", ret);
+            return ret;
+        }
+        vsock->owner_reset = true;
+    }
+
+    return 0;
+}
+
 static int vhost_vsock_post_load(void *opaque, int version_id)
 {
+    VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(opaque);
+    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
+    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vdev))->parent;
+    Error *local_err = NULL;
+    int vhostfd, ret;
+
     /*
      * Only reset vsock connections for non-CPR migration.  For CPR the
      * guest cid is unchanged, and the cid-change reset would otherwise
      * tear the vsock connections down.
      */
-    if (cpr_is_incoming()) {
-        return 0;
+    if (!cpr_is_incoming()) {
+        return vhost_vsock_common_post_load(opaque, version_id);
+    }
+
+    /*
+     * CPR restore case.  The source released device ownership in its
+     * pre_save.  Complete the handoff here, before the device is started
+     * at vm_start.  Init vhost device on preserved FD, issue
+     * VHOST_SET_OWNER on it, and restore the guest cid.
+     */
+    vhostfd = cpr_find_fd(proxy->id, 0);
+    if (vhostfd < 0) {
+        error_report("vhost-vsock: could not find restored vhost FD");
+        return -1;
     }
 
-    return vhost_vsock_common_post_load(opaque, version_id);
+    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        return ret;
+    }
+
+    ret = vhost_vsock_set_guest_cid(vdev);
+    if (ret < 0) {
+        error_report("vhost-vsock: unable to set guest cid: %d", ret);
+        return ret;
+    }
+
+    return 0;
 }
 
 static const VMStateDescription vmstate_virtio_vhost_vsock = {
@@ -133,7 +228,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .pre_save = vhost_vsock_common_pre_save,
+    .pre_save = vhost_vsock_pre_save,
     .post_load = vhost_vsock_post_load,
 };
 
@@ -144,6 +239,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
     DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
+    bool cpr_incoming = cpr_is_incoming();
     int vhostfd;
     int ret;
 
@@ -172,7 +268,16 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    if (cpr_is_incoming()) {
+    /*
+     * Re-acquire ownership if a CPR migration releases it (in pre_save) but
+     * then fails.
+     */
+    migration_add_notifier_modes(&vsock->cpr_notifier,
+                                 vhost_vsock_cpr_notifier,
+                                 BIT(MIG_MODE_CPR_TRANSFER) |
+                                 BIT(MIG_MODE_CPR_EXEC));
+
+    if (cpr_incoming) {
         /* Reuse the fd handed over from the source QEMU. */
         if (!proxy->id) {
             error_setg(errp, "vhost-vsock: device ID is required for "
@@ -205,14 +310,32 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
 
     vhost_vsock_common_realize(vdev);
 
-    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
-                         VHOST_BACKEND_TYPE_KERNEL, 0, errp);
-    if (ret < 0) {
+    if (!cpr_incoming) {
+        ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                             VHOST_BACKEND_TYPE_KERNEL, 0, errp);
+        if (ret < 0) {
+            /*
+             * vhostfd is closed by vhost_dev_cleanup, which is called
+             * by vhost_dev_init on initialization error.
+             */
+            goto err_virtio;
+        }
+    } else {
         /*
-         * vhostfd is closed by vhost_dev_cleanup, which is called
-         * by vhost_dev_init on initialization error.
+         * CPR restore case: only learn the backend feature set now, but
+         * defer taking ownership or touching VQs (the still-running source
+         * might be using them).  The full vhost_dev_init()/VHOST_SET_OWNER
+         * is done later in post_load.
          */
-        goto err_virtio;
+        ret = vhost_dev_init_backend(&vvc->vhost_dev,
+                                     (void *)(uintptr_t)vhostfd,
+                                     VHOST_BACKEND_TYPE_KERNEL, errp);
+        if (ret < 0) {
+            /* vhost_dev_init_backend() does not close the fd on error */
+            goto err_vhost_dev;
+        }
+
+        return;
     }
 
     ret = vhost_vsock_set_guest_cid(vdev);
@@ -234,6 +357,7 @@ err_vhost_dev:
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
 err_blocker:
+    migration_remove_notifier(&vsock->cpr_notifier);
     migrate_del_blocker(&vsock->migration_blocker);
 }
 
@@ -250,6 +374,7 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
     if (proxy->id) {
         cpr_delete_fd(proxy->id, 0);
     }
+    migration_remove_notifier(&vsock->cpr_notifier);
     migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 7ae2abe33cd..3734e3f20b5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1647,7 +1647,7 @@ fail_call:
 static void vhost_virtqueue_cleanup(struct vhost_virtqueue *vq)
 {
     event_notifier_cleanup(&vq->masked_notifier);
-    if (vq->dev->vhost_ops->vhost_set_vring_err) {
+    if (vq->dev && vq->dev->vhost_ops->vhost_set_vring_err) {
         event_notifier_set_handler(&vq->error_notifier, NULL);
         event_notifier_cleanup(&vq->error_notifier);
     }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index 5ebc63afc5a..6d0cff4fb93 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -15,6 +15,7 @@
 #define QEMU_VHOST_VSOCK_H
 
 #include "hw/virtio/vhost-vsock-common.h"
+#include "qemu/notify.h"
 #include "qom/object.h"
 
 #define TYPE_VHOST_VSOCK "vhost-vsock-device"
@@ -30,6 +31,8 @@ struct VHostVSock {
     VHostVSockCommon parent;
     VHostVSockConf conf;
     Error *migration_blocker;   /* set when the device has no ID */
+    bool owner_reset;           /* CPR released ownership; needs re-acquire */
+    NotifierWithReturn cpr_notifier;   /* re-acquires ownership if CPR fails */
 
     /*< public >*/
 };
-- 
2.47.1


