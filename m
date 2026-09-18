Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C47C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7YwG-00034o-IN; Fri, 18 Sep 2026 09:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwD-00033F-Uw
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:37 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x7YwB-0003Dj-Ge
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 09:47:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPWIs+6E59vjQdI2R/NswU/uKIrOQfRucubFxLVFgS+vtiJmsxG9UizbtG808JLu7jP0t+zOJjWLpwfiazF64XNynL77zpAKmcZj9qFgZsxobinDfohqd5yii6XFrPm/puI+LU6+hbrkjqQyyZ2vkmWBFEvnlgn/z84qqqCy99qZ5WKQ00HTxyYSbI2lUtUowBx8ZXN+cbzQi9efdH23LHbMZqNdeWGYs/bFjCnk5T7ZeYT2+wr6ASxRQvM8S+0qfspbiO3y7cs2fb1+vE9GMowJGvfioMublnIV8B0l+lFHMEbafHXhEXUpj4SGohYt6E3jATzIV92QlVvaVfB8Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJqZYuHV0pX0XTBo9aaLq7gNIgHLQMdPHm65UiCsz2c=;
 b=K+oDxsmbN0RTmlbkMbB8YqEGQzaa0nh1aKHkO1XV6z0isnsaonxO6NEvq4pCTPQd2o3e0kPp2F+a2PAw6P7dBWDpcQTqcAusJx6q09lXY3D/WPOkYXKtFYh0acEw2lngsNyyHD4KQsM7C1c1FtXn1DTUa/MXk8Lu0XXQjoOBjhVDQmyF8Rxcgf+scHj9qyAvB6jlDqWZ4OpO25//qBnQxxnprDjw8K+KgH4EsCF2l/aHoIhfj16SiFXMBwMrALU20K6pbvRC5ZsZVwhhaewRbJOdLRSkSBP6Cq8ec7wUiLzcdO/F9TKlTcFfyGgJCkEPdlv32XGZlY4ZsdC/kOtg/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJqZYuHV0pX0XTBo9aaLq7gNIgHLQMdPHm65UiCsz2c=;
 b=OBnlGlbfGGNsJfdRZiS+PEzxbn9TuqZ3LmYekeaFJPdORFYJco4TDrlver6d9MD+bxG26XekX4UnQxGfQylioR/IMcjAfXZrx/vMiywtPPOj49C2OXj8dH54j+k7YX7Bmpf6NauAw/W6W/nE7b7FFR+Wp/LDvf6iSmBuyMaDaVCAawphEc97f3gbsudtxAmgbB8YOpLuaqqIhg8GTONC3M6DMx/+0efVXgnIoc1sZrN1MRi1x5gp0UQ2yTx0D4dqfvu/7DogJROsRO5yO5/FNFYQU5ABOfpqXUC+S0M8upsYI9n4BQ6pG+jStH6NKNGvCgkIdUwgXiuoSIQmDD+Kag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB8PR08MB5483.eurprd08.prod.outlook.com
 (2603:10a6:10:11b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Fri, 18 Sep
 2026 13:47:29 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Fri, 18 Sep 2026
 13:47:29 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 18 Sep 2026 16:47:05 +0300
Subject: [PATCH v7 14/16] vhost-vsock: hand off device ownership across CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-up-vsock-vhost-v5-v7-14-6ef9ef033c35@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB8PR08MB5483:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d353a67-3e9b-44b6-a111-08df158b6188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|52116014|1800799024|23010399003|6133799003|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: bYLZg8ueCsgTssO5Q4jHVHtZ73y3THv5rg+FO7wRXXk9F2zZMvaSka6fCRo60kbRQf4KwK9W33D5xA/4zDtb6aMcogi9SQmgUOqe5fH8+W7rwFWx6eC3r1mbQVJX41OFjQaAfE5nmPzmIT6iZzzvj5Mvce24WYTUXu2Sx353BaPTFkbgsSzxDbAd/tP0FdoHGWvNx3GxrcCZihT3QnptPuIfz0VIsazWU8tM8hZ4DuQuXEH+88jerNZ2+Db78NGZiLGgChhWznTX8wz6qRA42my3y+kuYRMC48yPgOpiv1ctLky+VL2W2X8MxHKGztyT1zOevyNtpnBMFCmFADy0xznH/lIrskDCHDHYPhkzM02lg59kuAX+pblkxSed/co0et/xDbYeD7qA6Xu654dZGtcEudPilg2T7/s4WJJE5YxTWNXPBVBlc8W6mnWxGg/pkXSFkqIBhlpToxQb8eGxc/aSOLhfUlSCFOi8szr8eK0y+e+NNzhuiW7fvuoCPQVUK+HAKs9JtDlN2B82zecK4Wdrm878MK1LCAmBEhg2ft7yPuOJnYj28mZf4kKb/vBnO15YEdluRtzDSR6sUVszzW2HUCT94bncXBISj3ho4jAtxNTbzCkGSzph4zbySt305CDC+8PELLUhDEMovRSJ9ZT8SdqB92xO1JA7QYik8MvM4HaPn1xZuCNL33L8BI7NxFm/LCO9IUGTdIFjEUaXvxal9O0vC9q2Pwor8vHKvZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(23010399003)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVlMZTRtRXNHMC9CYnhoNmtCTFNVUFhKeGgxN1p5QTlKMjhucDMrQ2lOY3FS?=
 =?utf-8?B?d0lSWHNWTm5MTk0xbmh2N2FaNHB2clpBQmlGSTd1bnNxNGw3MEVMOCt2VXox?=
 =?utf-8?B?K0pXVk8rcHI0a0hhQUNpZzVBcjBIQTh2WUlSUEZVNC9jcnVyekcxLzhSWExp?=
 =?utf-8?B?cTZ1MDRGQmM2RVFqUEdQWE9WQklkYmNsR0s0elh3MW1xcDdJY3FYbVRGa1Ny?=
 =?utf-8?B?WVFJREU3UWZhdXRPdnVBVk9DQVUxbkFQVHQxajcveXdRMUh2Rk8vVnRmSy9u?=
 =?utf-8?B?WTNNSVZONE9CaXQ2bnRZWXo3NktpZWs2MHJZUVhkMjhnSGlBMXBCSjdsejNC?=
 =?utf-8?B?SjhVM25WQitxZjVTSFYyTUZkSGtlalNBd3RwL2RwL3d4OU9uVFVOM2Z6YUs2?=
 =?utf-8?B?c0tYdWFwcWwwQVhJUkIwanNjWmhjOVJnLzhtY0VtakkwWkh0NkpUMSs2aW1N?=
 =?utf-8?B?Zkw4dTA4R1F1SUk2cXU2VVdQcUZGZkwvdGJzdFlJM2pBVEVxd21mQ0E4MFA5?=
 =?utf-8?B?eS9nRXhNWUJXYU51ZVhjMnlkdUVLYWtHanU3SXVDRHh2MkZhL3JiTHJuYUhw?=
 =?utf-8?B?M2ltdW1vdENiQ1p2SUo3dVNLWUZtOVhaZ252aE1WMm80VzhPZUxqd1lNbXBx?=
 =?utf-8?B?eEV1bCtwelhwaUYxRWtsMHJyVlpBWVc3VjZ1TFB3RzlvQ2JPVThTY0ZBRnYx?=
 =?utf-8?B?T0x4bXluTkFGazlWZEtBU0VMNGwzS1l2UCtxK2RjN3RRRDB2bWFaTER4YjNz?=
 =?utf-8?B?ZlVFSjVsNlFzRWhvallmVDBSQTlYZWRabnROOWEwMzQzZVA2VWp4aXRYR2Z6?=
 =?utf-8?B?cFNjdk43Q1hXSy9tMHQvWDVxTmZjYzVUN1JYTzc1aDBnNzU2VjlSUk42L21E?=
 =?utf-8?B?SWozeTl4cWg2NFlXYnVSY3hvcHNrN1FFUHBoWUdRcmZsL3MyanJRVTRsQzNm?=
 =?utf-8?B?N3NiQ3NYQ2E0eXM1cnJSVjMrMzJ1SHpHeG9jaDNQanZTbEgzamNDdThlSjZM?=
 =?utf-8?B?aDAveGlwdk4vSmVNUm9yVmVScUNGbE1Kci8vdmhwejM1OWRQRWZBblFPbWFS?=
 =?utf-8?B?Rk5jdkpxTXlaTDJtd2o3UzY5Y3J5NW94dXFFcEdocjVqbW0yQ2hlSUhpdkNW?=
 =?utf-8?B?RGpBWFZtazBPSU4yWlpwYUpqU1IrM0RUZjVMTVVLT05yNFVnYStZME82dFlx?=
 =?utf-8?B?R0c4bEg4VUNldFlHbTBiL0U1SlJkVnBDYjVoV1FJbzFrVHJDRXlQT2RmaW0x?=
 =?utf-8?B?aEV5VWc2Sll3MTBZUFBIYkVqRlRTMWEwOVVBMmwxT083aVg5eXlFQmx1azdM?=
 =?utf-8?B?Yk95S1didzBWNUxUVHJyb2hYdDV1VmdpeWZiZDlSMlNOVmdZV1AwWVRDSnRy?=
 =?utf-8?B?NytuRGtJYjkrQlhJVm9ZY0FsUjVTbjBUWFdOc0diUFVuRlZEaGFkQWVNdGhZ?=
 =?utf-8?B?L1J2UFh1cndUbCtZSzdGdTl6WUtra3RFS2pVU3dNUmFyY1hZQ2pjczFWNHNj?=
 =?utf-8?B?OGVEN1BQNXBINnNCK21ZZFZMNjRWeGRhdGdJRXhPVWdnaWo1bnNRQzdOTW10?=
 =?utf-8?B?eWJ0YnNkK3gyNHZoaEFUZGo3RG1UUkpGMThrYjZicmtFdDZkQW5uT2FONnYw?=
 =?utf-8?B?ZlJaQlZnUHhYbG40Q1RSYi9kMVFya1ZYMG95WWRYWHNvNjBLL2p0OElFQ1VF?=
 =?utf-8?B?N1J1dEZrY1kxQW1GRGdZSzcrNTgyUW9oWjVBODJKbUdaUWlVNmxONjVXNWxW?=
 =?utf-8?B?NlJzaG9WTUdhS0VSZHVGbStTMnI2ZzVodVVyeTZPMUVzdFA0WWVuTmM4MXdi?=
 =?utf-8?B?TkNuZjVPNTJUTy9kZDFqeitNVy9RWXdXVDJyak5lK2RvQStRcnhiTUtlNHBK?=
 =?utf-8?B?ODA1ZGNLQkEwVVdkd2Fvc21PT0grNzVoZDhkZGRPN3RWYTNjWGw0RDc5ZHpS?=
 =?utf-8?B?UkpvR3I5SVhMeXlYWWRnZ3ZRTEM2cnVwY2hGa0ZNZUVVaHB0cVJmZTM3OEFU?=
 =?utf-8?B?eFVUZkNMQUVUUzFISk9EdGphMjBkelJKam9NUFNYRVRvS21OcXpMb3hNTEFv?=
 =?utf-8?B?cklqSmY3ZzUvbG1wMC9SWkR0cVVyYnh1NytlMnE2b3lrbzlacDNOOEdwa2tq?=
 =?utf-8?B?bWdTTytKaFZrNFhON0tMR0pPbnYzbGVFSXdrTlozc2lod0EzdytIOTRHaUR5?=
 =?utf-8?B?alBRT0d6NlM0ZHFvQ0ZtOU9GMVU5VEZibzkvcHIyZklMeHh0RXdsVFdhdkVG?=
 =?utf-8?B?clVZYjROTDdQQWtvS1JYWnBqdmFicFhJMXRmeEM2OHRwMldWUkxqSHNvVmZ0?=
 =?utf-8?B?U0pVeU9LYnVHQ0hWMVcrYmZlb0w5b3dPaDZIa2V6Z2dRK0pQa1JJeXlXUnIy?=
 =?utf-8?Q?jvjdhi4bOBisgec0=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d353a67-3e9b-44b6-a111-08df158b6188
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:47:29.3069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MY8Mva5SCqsBujOAOawFCW4GMdbo33xmzxphLO9ykw67rGBDkSCo6oZERNisXcglyUEMFIynK3X4FO9br3rz/f5W9ueiEekcxAHT3kZpuVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5483
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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
however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
in realize().  For cpr-transfer the destination realizes while the source
still owns the shared FD, so its SET_OWNER would fail - ownership has to be
handed over explicitly.

Do this through the device's CPR vmstate hooks.  Namely, release device
ownership in pre_save, reclaim in post_load, re-acquire on restart:

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

  - .set_status() refuses to start a device whose init hasn't completed
    yet (incoming CPR before post_load).

  - .set_status() re-acquires ownership before starting the device if
    pre_save released it and this QEMU is about to run the guest again:
    the migration failed, or it completed and the management resumed the
    source (e.g. cpr-transfer target died).

With the handoff in place, lift the CPR blocker.

Note: this requires kernel side support of VHOST_RESET_OWNER operation
for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().

Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c         | 157 ++++++++++++++++++++++++++++++++--------
 include/hw/virtio/vhost-vsock.h |   2 +-
 2 files changed, 128 insertions(+), 31 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 6e89007b2ce..65ba573da4d 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -21,7 +21,6 @@
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
 #include "migration/cpr.h"
-#include "migration/blocker.h"
 #include "migration/misc.h"
 
 static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
@@ -85,14 +84,46 @@ static char *vhost_vsock_cpr_name(DeviceState *dev)
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(vdev);
+    VHostVSock *vsock = VHOST_VSOCK(vdev);
     bool should_start = virtio_device_should_start(vdev, status);
     int ret;
 
+    /*
+     * During CPR, on target the full vhost_dev_init() is deferred to
+     * post_load.  Refuse to start a half-initialised device rather than
+     * issue vhost ioctls on it.
+     */
+    if (should_start && !vhost_dev_is_initialized(&vvc->vhost_dev)) {
+        error_report("vhost-vsock: refusing to start, device init incomplete");
+        return 0;
+    }
+
     if (vhost_dev_is_started(&vvc->vhost_dev) == should_start) {
         return 0;
     }
 
     if (should_start) {
+        /*
+         * vsock->owner_reset is only set in .pre_save() on CPR migration
+         * source, after a successful RESET_OWNER op.  If we end up here
+         * with this flag set - that means that either CPR migration failed,
+         * or we got 'cont' cmd from the management (e.g. cpr-transfer
+         * target died).  In either case, we need to re-acquire device
+         * ownership.
+         *
+         * On failure leave the device stopped.  The next start attempt
+         * (guest driver reset, VM stop/cont) retries.
+         */
+        if (vsock->owner_reset) {
+            ret = vhost_dev_set_owner(&vvc->vhost_dev);
+            if (ret < 0) {
+                error_report("vhost-vsock: cannot re-acquire device "
+                             "ownership: %s", strerror(-ret));
+                return 0;
+            }
+            vsock->owner_reset = false;
+        }
+
         ret = vhost_vsock_common_start(vdev);
         if (ret < 0) {
             return 0;
@@ -123,8 +154,44 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
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
+    if (cpr_incoming_needed(NULL) && migration_is_running() &&
+        !vsock->owner_reset) {
+        ret = vhost_dev_reset_owner(&vvc->vhost_dev);
+        if (ret < 0) {
+            error_report("vhost-vsock: vhost_reset_owner failed: %s",
+                         strerror(-ret));
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
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(DEVICE(opaque));
+    Error *local_err = NULL;
+    int vhostfd, ret;
+
     /*
      * Only reset vsock connections for non-CPR migration.  For CPR the
      * guest cid is unchanged, and the cid-change reset would otherwise
@@ -134,6 +201,35 @@ static int vhost_vsock_post_load(void *opaque, int version_id)
         return vhost_vsock_common_post_load(opaque, version_id);
     }
 
+    /*
+     * CPR restore case.  The source released device ownership in its
+     * pre_save.  Complete the handoff here, before the device is started
+     * at vm_start.  Init vhost device on preserved FD, issue
+     * VHOST_SET_OWNER on it, and restore the guest cid.
+     */
+    vhostfd = cpr_find_fd(cpr_name, 0);
+    if (vhostfd < 0) {
+        error_report("vhost-vsock: could not find restored vhost FD");
+        return -1;
+    }
+
+    ret = vhost_dev_init(&vvc->vhost_dev, (void *)(uintptr_t)vhostfd,
+                         VHOST_BACKEND_TYPE_KERNEL, 0, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
+    ret = vhost_vsock_set_guest_cid(vdev);
+    if (ret < 0) {
+        error_report("vhost-vsock: unable to set guest cid: %s",
+                     strerror(-ret));
+        vhost_dev_cleanup(&vvc->vhost_dev);
+        cpr_delete_fd(cpr_name, 0);
+        return ret;
+    }
+
     return 0;
 }
 
@@ -145,7 +241,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .pre_save = vhost_vsock_common_pre_save,
+    .pre_save = vhost_vsock_pre_save,
     .post_load = vhost_vsock_post_load,
 };
 
@@ -171,37 +267,24 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    /*
-     * CPR migration of a vhost-vsock device is not supported yet: the
-     * device ownership is not handed over, so the target fails to set
-     * up its device.  Fail the migration early and gracefully instead.
-     */
-    error_setg(&vsock->migration_blocker,
-               "vhost-vsock: CPR migration is not supported");
-    if (migrate_add_blocker_modes(&vsock->migration_blocker,
-                                  BIT(MIG_MODE_CPR_TRANSFER) |
-                                  BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
-        return;
-    }
-
     if (cpr_incoming) {
         /* Reuse the fd handed over from the source QEMU */
         vhostfd = cpr_find_fd(cpr_name, 0);
         if (vhostfd < 0) {
             error_setg(errp, "vhost-vsock: could not find restored vhost FD");
-            goto err_blocker;
+            return;
         }
     } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
-            goto err_blocker;
+            return;
         }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
-            goto err_blocker;
+            return;
         }
     }
 
@@ -210,19 +293,37 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         if (cpr_incoming) {
             cpr_delete_fd(cpr_name, 0);
         }
-        goto err_blocker;
+        return;
     }
 
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
@@ -232,7 +333,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     }
 
     /* Register the fd for a future CPR after a fully successful realize */
-    if (!cpr_incoming && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
+    if (!cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
         goto err_vhost_dev;
     }
 
@@ -247,22 +348,18 @@ err_vhost_dev:
     }
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
-err_blocker:
-    migrate_del_blocker(&vsock->migration_blocker);
 }
 
 static void vhost_vsock_device_unrealize(DeviceState *dev)
 {
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    VHostVSock *vsock = VHOST_VSOCK(dev);
     g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
     cpr_delete_fd(cpr_name, 0);
-    migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);
 }
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
index a964d57e1bc..6e1c39383ef 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -29,7 +29,7 @@ struct VHostVSock {
     /*< private >*/
     VHostVSockCommon parent;
     VHostVSockConf conf;
-    Error *migration_blocker;   /* CPR migration is not supported */
+    bool owner_reset;           /* CPR released ownership; needs re-acquire */
 
     /*< public >*/
 };

-- 
2.47.1


