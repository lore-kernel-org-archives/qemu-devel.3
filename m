Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C76ACA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkCZ-0008Rb-2g; Mon, 05 Oct 2026 11:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCQ-0008OV-HY
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:54 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkCO-00056n-3z
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr5E4R6Rs1zUgUduA8r8cjgYENoEtS0YnunNGQqI3wEwwIO0ekHlAOjcRiXBAM1N8Yh7JzXuGD0WKBnNuut6JCawKaxjmevb0dKwLxDYVOrw374cB8igA5fZFf7JKHOffTR8tLjmfzXeH9S//HsXrMjDy2rsG4i3h8GmEldvYJugRnhAMTDhso2zGoutq5w2/CApCLb8SQATDsOppxlW6bgZG3Dsg15O8UR8AOqmlzhOEALpVl+oSYKct7bpjy5px9K7Pnl+ENT1t3K6XgJTYco7Sym57KN+3IOostZPBh2K6p5CPRhUPq6cdQSDVMC3kwo4fml8LKa9fCm8yu8TtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=RKZHgq1qO1OyAK4egPaEuHzUWGqIIOwUQl/XM/00My5mLrBiUU5NlqtQC258gN7ddYF9HcEzQQFdIH+4zrZUqxVKbOVUlEeH6SmHwPAB5CA1uKB6wleApLNZ9LCMbI8EHMNUjRth9rHszHYExciw4zssG96WLiBeEcI3Nchis0i3oAfc04ie2DE0T+Irp8hTnkyrUdvWUa+oD9+Gbbvc5CmUs6GPP3Q9zqpMSPsV/KoMOO9CacMDS5dVESf2jLgeSoPO8+nNr+RXAc097fTEL8vZcf/4SgN51Fl3zm9POqCzRSpx+4sZorgn2CS8ks1+p3wLOPdF+5CKqibxmalLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=ZAbLXl1eIWX/oIoCkmtnWxOlSM/DMxcaBS0PO4NgUE4DkoWl1uXAp3uSxXDGSRoyU5mE+fGFctJ2ySVkQAo41n/I4r0odGp3n0nPAOeQKMqLY4hic8UkJGN15RrI/XdnHJUD0t9vZ4RNSf9esYcaWQj+NvOd/3wfSd1alRHnnmusu5nWUy1nAyMqgzdnjydFhmuNZc45nnuWvVh5yCI6xhBtll7b/pnIiBMrfmlGkyIowzVJp9QlfmqsHPakOFP6Oc4Evinw0DVgCi8zRN/VIsu5ajPtCCp9YL/tNtfTnHGdrj1erGCnpaVuwqwtmLSwzva4pI5bSCcezw2a2tiSWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:27 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:27 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:57 +0300
Subject: [PATCH v12 18/21] vhost-vsock: hand off device ownership across
 CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-18-40162390c68a@virtuozzo.com>
References: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
In-Reply-To: <20261005-up-vsock-vhost-v5-v12-0-40162390c68a@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: vsementsov@yandex-team.ru, clg@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 mark.kanda@oracle.com, bchaney@akamai.com, mst@redhat.com, 
 sgarzare@redhat.com, peterx@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, den@openvz.org, 
 dwmw2@infradead.org, farosas@suse.de, andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: WA0P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::19) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAWPR08MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 549da147-c1f6-4997-d10e-08df22f187eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ORd7xa8EDRNjWYb17NHSUNA33z37+1wNKu1QbX0D2qrGv01e4ih59MHOnpuB0nMZrcwAb/j4CwjE2PC7WHnf74F2o7sspZl7mKnZFrFc4irINuA7DYRv4xOv4yuz9nu+CqJRiJfLm1xmKvl+yOCjpelsnd0zvWWaWhzYWXsy1shapSx2NaI6nOv9LxJEpm/0C9xVSLXrzSbNLScsaekGIFFrA1oHL/Bu/pMWpZzo2uJQmsWEhZuumX4VH4/0kk5k/LLxwy4N+E56bYjohSzSHUQQCndIdYl/Hh2T/GHL5s10G+1/jAABAvYlDj4qNHHLBI4qij0vNnF/awhRiGxT3DrY2zalt2lm7Ykk4K05gFCa9ARwr+FRSNhSG8jNrqvPVMvhqLEZTJquObuUarpkpdM57tgkoxjgyXvwLnt+iP6rzxHUa0pZkDGIeQHPvrT8MlRVPHoh2eO1jw/t+UBvjmZ2kr3IpDCxCGQabcXB0gWI9WHfxXpgkFepJIZL2V4RzuuP2ot+fkdjJHkDaWLIJcDLwWVOgKM78SId6KTrjU9h7iIhQJzmm7b4M+RcFl1uliyFvy47xCdF9Nve9JCgHa4RVm6L7TFHDFtAEwMuz+qIx6d3S50r0+TAPwX8nQv02KlgBsKGOOMcDrqba1z/ZNCGMMP5pw7PzI3Ts8tjjOy5weMmJTr01loLYKu2uaGrCR9PYbErcJ1e6Obm6tlfiZxhCScqvkeMse8VJqRl5EQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXFyUjVRcGsxdkszS2cvWVA0NUtibzJYNlAzM3NRaEg0MkM1ZkR2NVM3WHBu?=
 =?utf-8?B?SVFqM0JHYWRYclh2NmJSNnl1SjdnaFV1QzBRSlVITnExR3htRUhZeWU2K3gy?=
 =?utf-8?B?SUplSkkzTmcvQ0tldW11S0lQZnQxdHhlNUpFbEE2V3JDaWtpUFRWZmVxTzlL?=
 =?utf-8?B?cndDZm56QmZ6MGdQdGZiR3laWnltUlhVamxjT1Z3b25TZ0orbjEwWEUxbWlL?=
 =?utf-8?B?WkRXM3dydTkwckt0d0lzbUFkQ3A0dnVQeWVtSi9NcWhBRW9aMWZGVHVQRjBa?=
 =?utf-8?B?VEtrV3p6ZFM0UU9ydkZzSGVRY3lhRFdlSVpXV1pWN2tjNDhiek9nOXNuenVu?=
 =?utf-8?B?TmtHU0VCOWRwTndpdFdXTmJ1bzFtQ2NKd0RZVk9ueUJsRXJzS3BrUkp3MFQ0?=
 =?utf-8?B?bXpzK0pENWZyOEZoTFlPWEJ3Q0V0UStDVnNGanBMYWNtZXR6Z2s0THRReEh2?=
 =?utf-8?B?blg4MVdmL3A2bE03RGR1YUFZK0hLUkVTc2NSSCtZSlZWQ3p5RXBEY3VlcTF1?=
 =?utf-8?B?a00wdmZmZzhzeDRTeXRRM1Z3NVArcjV6RnpWTGN2SzN2Nlpua1ppdmNQZ1Rw?=
 =?utf-8?B?aVYwK082R1hKZE5rZkt1elZxVGlGS1g4YlFzZjF3ejFQN0tiVDlOYkhBb3ds?=
 =?utf-8?B?QUdMc3VKUmpoV3NMUGZnaTFjK3Fhem9Eazk5V3Z4M013QXRReXJkcjRuMVhZ?=
 =?utf-8?B?NG5yekhaSk5hNEZSNHBOZWYyRGUyTklpWmE3UHZDcS81NnAyNnR0ZGFXL0lD?=
 =?utf-8?B?YzhFcENPcEwxakJ0MW5KbnVwbWpPSWM5SVU1QXhkeHhzUjlXV2k2N0ZvMkN3?=
 =?utf-8?B?dHdoZVlteEVzQlhsNUk0bHdCWXJnVld0Z3M4R2xOQXF4QXpvVGlLSkY0aktW?=
 =?utf-8?B?Rk5xRWd5TUFWY3MwVUxKN2hPWjBPWnJaTHhNWEpyRktQaXdTNGJaSGdBMFl3?=
 =?utf-8?B?d25XbmxKTE13MFdCcytKU3I2TmFHWXR4OE9XYjdvWkdqOXVTWjhCMmRGMW80?=
 =?utf-8?B?Rkw5aTdJRUg3MnVtN0FqUExsWDFwOVpMRCtxMzVzWnRZeVpUcXF5Lzl4VWE1?=
 =?utf-8?B?UTBTYzB1R29iMUQxR3ZDdkxrYm1GbmVKN2h1ZXNvQmJaQmowVk9WMFgrZWR1?=
 =?utf-8?B?dDNmSFhUUnV6ejNXRnR1OHRZa0NUa2ZQMEhKM0l4QjYxLzFQRnFLSGxjTk1M?=
 =?utf-8?B?QVEvcEdFWnZsNFViWmZZZm5yb1RjK3BPbnBGU3FtNmNrbTV6Y2dZMEpmMHJk?=
 =?utf-8?B?OEVITEs2amlkaVAxVG5zdGk4enZrTkJuN0ZLaXIxZ0YwdlFnYVluMllaMTdY?=
 =?utf-8?B?cEloTk5IcVordXRjaEY2RzEvNTZtSzhwdkpld0RxRjlRQ09vbFFDY1ZmWXJJ?=
 =?utf-8?B?OEVBamVzZ1EwMEY0ekFJc05OMFdvVXE4Q1p2UmtGY2lXV3hmMElRaXlJZGdY?=
 =?utf-8?B?a0M3WEoxb0M1WFhQeGtVS042MDkyenBCUXJya212OFNzNmwwMzkvM0ZjYkJp?=
 =?utf-8?B?cnIxL3d4dUR0cTJ4WDY5RDYvRmlFSG9LU3g3MnUvTUpqdU0wMVhTMmVuZWZm?=
 =?utf-8?B?aEZHU09iZ2krWVlGQzluUEFGYkxkN2c3a2Zvc3NvOFlOSnZDdG96MFRIY3Zr?=
 =?utf-8?B?dmxYQVBFNUFyYlQ3TEdDRUF1Y0k3SnFDYVJYSlAzbnk0Qmw1MU96M3BvM2hl?=
 =?utf-8?B?ZzlVaC9PN0ZpaEJjWnB6T3hYY2lWaU1DSFV6b1phT0ttaUNBMkdkRTRrTitV?=
 =?utf-8?B?OUdGV0RMVEEreVFKSmN3djd1Q3RLcHFGOXhBbmoxbTVKclVXU2lrWjRVQWxD?=
 =?utf-8?B?SFhVdFVvQ2N0TDlLNldrOGt3ZzFveDVLdnQvUHU4d2xnOUVtczRXeGNJbXBW?=
 =?utf-8?B?c09OeTEvRGNTbk4ySWE2VE03czR3bTJiUzg0RGQ0Q2hPeW1kMUgreG9hOW9C?=
 =?utf-8?B?SmsrNVB1QzdnQy9sUzJVMW92dEdCT2NtVTZiUkZHeDN6eEpSaXFyU2FSZWVZ?=
 =?utf-8?B?bjZNdEM0TkVGSnlzM2Rva3Bicjg4cjdCY1VKTlVQdVpubWdKcFZRcVo2ZU1W?=
 =?utf-8?B?d2FVOEVHY0VFNG5HeVlXcHltSGtsMXF5TmZJS3N5YTlkUDRRbDFJZ0dlUGs0?=
 =?utf-8?B?SHR0d1dOdW5YV2F1OGs0dmk5QVZFMWwrcnVRVkdodHVqNjJYY1dzazRGOGZp?=
 =?utf-8?B?d3BmR1c3aWVydnk0T3Qwd1BqOTdXcTgzRHRCUXE2bGNUbUU5TFFBTWlpdGV6?=
 =?utf-8?B?RTZLbkUva2pkT1E0QnZOZTZhRE9kR1grZFBDYWlMK0ZhbVNiRGNmWWpxSFVm?=
 =?utf-8?B?Z0R6Qm9BcXFkaVc3MUxUQzFFMmsrc2xHYVVqcEl4WTRpakhVbkVBM0xMTXB6?=
 =?utf-8?Q?ak5E72kVpC1LZwyY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549da147-c1f6-4997-d10e-08df22f187eb
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:27.3907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQCxex2ec0bxv41EA9CXtxeB4nsScFqKChkrUs2mY/wo5T6op97cCdcRYCVdHd2zT01U6Et72HR6F+LPUVipVBZ8Ax3oIyoIFz6zFYbmh28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9736
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
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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


