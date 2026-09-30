Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF59CA5FC8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:14:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJb-0000gp-Dy; Wed, 30 Sep 2026 06:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJZ-0000gF-Hp
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:29 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJX-00045T-Uh
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1vwSAH24wIQ+UIAow6N4KiV4N4QaMIy6HNd0uSzNZtB7tlJ5ZbTOvHbjBUTe772Ncg/mM8z08u9euRSxrzisXSQ+rZQ2MYEW8WoQerpXccc082fVfqtncskC7RR3AJoFtNuq67dY0Y4GIvpBEIEIBUeWQN2vXsbhRnaim2q0ts5VWNbOA2/QtKkC3pAHrm+D6mnDk06geqHYnGNzMOFu3MubJnN6PHWWm4UXAKNr4X7gsUKNL8Bt6dJ+sZi3FmdfcSvteWjFtueMFBTjNLqVYeEeJ8zShuwE1ABnRdnL3mbJ/Ffc7NGEkbxaGh6Wa6d4Dp75aTwKQE754JV0tnQQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=jfn2tk6XmzM9wqPWgug9fGOds0jb/15vYad8WPsdRDQQs+QHHJsj6Y7Lxx7aJ2qujhskps5KC/s2FY/UW6EjPoaSDjTwl/MBGFTfR4tQ3vr5o7sU4jB6IbfcpYmm6pcTlruirmIJyCH721DjAZtpur1Q6cyw/VsyjNxuhusMDU5aXo9qcJYTVlzk6azMIITIhoccLf3q10c/FLnkPh/c6a9Zu9UQ+DWE9Z0G3kNlQpdGbIK1zBFMf1gSXBKuyoqv70nnLni3RhowyY1PIuB5jT29Hp0jqovpInT6tehMssvaRjr5owPJ875K0pR4jen5hyLaPmwtZQCFbPp0Ki4bSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=Kl9UVQAb7aUjoEnItu+660UlK9Aw5JlzReq/gp5Wsf2y8pd+tC+Og/Dzvi9sRFTiCd7Le/jxGF+zC6dlovqf953rBbxDCDZKMIZJlKKl8AMRQnd1zrwRTNR0nvHP8w+ie0faclSaYz4BgcI/Eo94PORHv46BwBBO5lAFUmHUHWR3ZLvLLV2bcRCknT/42G1L6mPRk/WLz1mlfMy80WBSG1J+NX91keoNz1vEMP0ytUXmJgv9xD/30p7JuUtAJSCzzVGrP1nQPUKmLtxvO1W3F2QM9gSqBDtHfDL5D4b4PZl1Be/DRAzxKuX5g3ZoyEUTAS2b4586lxjS2qqxIxgXgQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:20 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:20 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:05 +0300
Subject: [PATCH v9 06/18] vhost-vsock: block CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-6-e9096f629770@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7e33288f-94e0-41de-3a96-08df1edb73e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: JcIWKrru9YW0KF0Sy3/HarCtYh20sGoRp8i6lq5txPikDXK8qxIsNluWCMyL1ETxPy7+qJ/RypLkOKbmtF1Z6Ex3Uhnp3iEXRIaq7W6ot4EgghPfCnC3u271FULhfrAYkyCyO/kbj5pyVcydvBSdaK7aS+oUahH4m3yQL8KaQU3zSRfUFsczhVU/66JmM+n3zUcZG3iuRUWCzlyKDCQtbpaY1xRr8jbMy3ScqZzWe4ICNn9X3jg6ncQWPvz2EmnKON57SZrdZ6BANfYsSAZx6kfW+hpDhwcTXcMX0UWUXQMaz/6r4y+XzSMEINj7YPvKFVGTiGZEqx/x3yHju8FUfQyT5jx3aigxA6M8dB+hm74YcXWJwxrMSh/vcJyGc3jBIolQxrpIIrRo4X4Csl7FGp7ypSFdGlYUQWXrUYTXChskUyGb/py+xm0HyHLZym/tySKK73gqvJY3Z8XtiyETX4nridA7zjPdPBC0p4lxkaqN9GBBRt3TADTszjLS5NTxNtLcL3MBMphM0jRBJe1kJFSQLKOLTg5naX14sgi17Opm7FFGRbhTwkFYmIUWiNSZKuD9C63vhjn1SbDCDhcirejhJO1WYK6tHHJPKtrXLnuIkWrouuTrSnVmkBUfUgur9dxDb7ifB3nMsFFgySdk8NvT8itAQUhnyeOxMhPzb2zoQG0w0jxBEVIvpLuTDW5jN6z/hNbWEh4nrDbkI+9rwSaHjLvqpVQ+XKY7Efc8Gy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmRoU21uQmFlSUttenBCQzRqcDlMTFEwaG1xTkM3eUFyVy9jVnpPdkl5OXkx?=
 =?utf-8?B?MW82OFcyZUJJSSt2VFUwcFdzNlozOTZEKzhtamJjZ2UxQ3BDL2d6Z1JZbTlx?=
 =?utf-8?B?NkNBUlNPdFZTUGV2YXVQVFdwOEUxUDlqK01sVUh5cllzaW5kWUFSek5xQkF5?=
 =?utf-8?B?bVF2TGxIWjdyL042TkRWaDVUN29temJuVGdpd29JNXJyTGx2Z01RaE5aVEtM?=
 =?utf-8?B?RUVJQUgvVU05MFNtWm9hajNBdXVQNkhiRytlRG5SZjVLSEs3V1NDT2ZYaG1Y?=
 =?utf-8?B?Q3NUci9IMmNGSkNKZ29uQ3pkL2hsSmw2Z1o5c2FrbXFhYzRTMXFBMEpXbXRZ?=
 =?utf-8?B?YzVjUjVibllYa1lsWXgxY3lmZDRkMEx1cFhPZkVaQ0lvQlZoaXdweWZNRE9S?=
 =?utf-8?B?ZndsdndsSjFzT1cyQkQ5RldzRk8vbkplaGxRamZUNGQ1ZFU0NFN4cnBiVnNx?=
 =?utf-8?B?dGN4VVU2TjhnbEVIU0kwT1ZBMnV4YWsydmxGMitNMFZwcFMyZS9jRDFtaVZi?=
 =?utf-8?B?R2hJayt1UEI1eHVTTjljOEdUNDJqNFI0SDcvWG1leXBLUDJJdUUwU1NlSm5N?=
 =?utf-8?B?MU9INzh4aytSaDNCMXoyQjkrcGsxSTJhYXpWcHdYdzA3TERkTkxHV1RXR0lv?=
 =?utf-8?B?ci8vUXQ2MmZVcVY0aTVyd1pIQmptT2h2azdMTmhSeGlXYi81cmorWDJSUzFx?=
 =?utf-8?B?aGV0RWxndDRXR04xYjdQTkZrM2ExV0JoMy9rallHOWU1blNvTTBoc2ZSUklu?=
 =?utf-8?B?eW8weWhtaUtTWGVMYVp5eS80L3A5ckJGVU00TmFrcGxzUUduN2J0RWFPTUVR?=
 =?utf-8?B?RjR6SVRWMkxjVGpvT3ovU0l5YWh0bUpvM2k3dDZ3TzZMUHNwbjdTZERyN3FM?=
 =?utf-8?B?bWJyV1pKd1k0S0VSdzFKN1habk1ZdmpXeGlXL0VrOHoxYkNwL2JHY1hjWVQ1?=
 =?utf-8?B?dE9aR2ZKUTBSWUl2R1FIRUFLd0FJaW1sSnE4aitPbFlZWDRRb1ExRnZJa01j?=
 =?utf-8?B?S01adHdRR3RFTmJTd08wdm5YVlcrcmo1RUxWZllDV3hkWi80VkZCQVdoa1dY?=
 =?utf-8?B?MVBiNnJ0QUt6N1Ztc25Bd1ptRU9OanhENVdoNlc0dHNBRkZjNVYzTVRjYk1Z?=
 =?utf-8?B?NXExZmJYeklTMDJXM1ZHVkp4TGJJL0EzMnFkMTJaVUVFb0ZYWmRNdnFFb3c2?=
 =?utf-8?B?Uk9LbkJzZFdLZEgvQktENGFSNEozcHpweXE5SlB4RUVPTVRXZHI5MDRvc0RX?=
 =?utf-8?B?cEFhL3YvQ0I5QXJOL3dhY0NZbFVQU3hBV1paN3FGL0p1c2I3eUFGR0JlRFlj?=
 =?utf-8?B?S2hweno2QlV0UlBsc2E5V1dYMXJwUHIvNVNGTDVnbSs5THE3THZJdm5KUEQv?=
 =?utf-8?B?SmV2L0p1L3h6akNBSjhEVXo5VXQ4UE1oSGptNnRTSlRSVHNNSVpudncwT2x3?=
 =?utf-8?B?eUpaaEFBa1FVMTU3cWVaM2xjb0Y4Qm1rOEQ2UkcwUWNpK3lnZkErdzYwT2NZ?=
 =?utf-8?B?T0xXMEgyWDBsak5zdXJ6NXVxenZpSDRsQU1JS1RyM0Jab0wvNlYwWHBKS1dE?=
 =?utf-8?B?TTY2MHN3T285LzhSblJWTzh1N0JHK3R6SFhmUHFFMlJ6Um45Sm0xN1Q1QWR0?=
 =?utf-8?B?cVZSMW5sbFdRSjB6TGVuZ00xcjl0S3Z2aXNpOFRwaHJTdDJqRERZNEJYVm5Y?=
 =?utf-8?B?amlZSlZrRi84SWxPaDlXL3F5bXRBSTJ3aDUyQ21Jd1JHQWUvblorUlQvVERD?=
 =?utf-8?B?WlpKakhZQms3dmpuTW9UWnRWbG9LU0I0RndvV3pTZy9IdEJMMjdLUTljUTh1?=
 =?utf-8?B?d0lzcDlNMjRwOTREcHlGOWF6bXUxN1I5bkgrb0lSdzEzTFNUSzBsRENaK1RV?=
 =?utf-8?B?WUNadkZ4aFQ5cmw5K1YrZTBLUDczN3h0RGE5MEZyM0V4NTdKU0lMRHZMSzBI?=
 =?utf-8?B?cGpTSWZBU0JjdHY5cE5iSGJBbVA0dUZINW4yTzNsSFF6UTc1cnVMV3dHbUlq?=
 =?utf-8?B?RG5iUDdOR0ZUWVE2OCtJbjhRUS9WY1M0UjJOZUpzN01SV3J6ejVNMEtGQWxi?=
 =?utf-8?B?Wmh0L3kxRTR2ZVlwU0d2cWdwaXpBTWw2RDlXbW5adzIzK2RXcHljYkNJTHVr?=
 =?utf-8?B?QTQ3TjFRZXI1a255RDBuM1BPamhUVHFVMTMyZXgxVWhEbVJyR2kyeHFQanhV?=
 =?utf-8?B?SWtGMUNNVGpsQk85UG9Sb1JVdnNRQlduZjluaHNBbDlIYk1sMWE3ekNBdFA0?=
 =?utf-8?B?YU1DelFvWTA5ckRiQ3hKckNhRVRHOFAvdHJnOUhWVEkxME1WemVSS1AzelQw?=
 =?utf-8?B?bEYyRlovVUdWUTMxcjJjSzEvb1VvYVdnWVUzOHNXYWJqaHE4SlB1UXNnVzBs?=
 =?utf-8?Q?7UDDDv9EJHcVFqtU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e33288f-94e0-41de-3a96-08df1edb73e6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:20.2651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ScyMQ6g921YMTum6e7Ns8wVJiuTaSdD+Ls8P+mBw9r/sZjvv5l2FFJ74wx3tpiHTws8oTmAM613x9MSplFSs1EIl8v2U2N4eQi5Sd2reSm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
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


