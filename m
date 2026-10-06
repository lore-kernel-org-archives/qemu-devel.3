Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7DACA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 07:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xELmc-0006zv-5L; Wed, 07 Oct 2026 03:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEGOD-000300-TC
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:24:37 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEGO5-0006Oo-Qc
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:24:09 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufHEmNeTh/DwIDklgPwuq2gDe5sSAw8e0hE4/yJOQWDgbAHebSbwk2SFHebW1ZrbnI5KS+RJX792r6XY6WxxO+3swrB4DRpW88b+07XyIeUBZg7hthtPJbp96oJ3nuFSV9OoWEozyGeX3CYmGrQ48Whs+O5vxWeFS/2N4lxOkcO9KtcuCXIkbl6GKuoE41Fqqy+2hMrhzNo5IcRiMMKEtykfTGF74MOcoLfA4rXO7BPmN8TPZZnPo2K0D5xAWqPhtILQ1+kHjD2N44t3Q0n6QhdJ7dhPxV2dp5HtupbopvcyH77Yk7FsOqVCsK49uh60Y6V2RVIhEkDvmIDHdGuC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=tJbtWEBZx7FbdqYK2FXw/IAlHehGW9zMubiy1k8jL0k1l+GlgaMB9cWimtLuREGhoo86zwRrf/wlA9M/XDsTraIV+6+9MY3dG1+qPvHYCRF35qhKMDwyitWjlZ+7UKPYAVYzOsFPxZ3jUx5KSuAX4t/Qio9BpRGoFxEPyM/6cuVPoFNN7MqTLDNdDCCrAEd4IVmGm08jljGGRDXabicZWk362HwjP9v0LSvY6jnPXlIpPN8joNLXdeALqFVOR1f5z+EiyCS2mIl9hLFmh79nFTOnYvT6Kc5bi9QBuE0N4TZl04F0d91PbeJw83pvy4Q4i7hKfp0l54B6IAMuI1F4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42TxjWWVF52+WjX+vXTK/F5rsdLUfNrhRilXbJ+LOJc=;
 b=yhM3sUuLiL/LMwNJyiLmov207HI/kp+9BuKVKSIGHv7tB7k2lb4/BfiTp/Fcj8HayuRqmx0TJb+48pCSdCm4eVSnk527w5+NE2fYJjFkahgO5BqS/6Wf2dRlR02AkZIF/HAMm/bjtgGxleH45daInj7zTLoSeT1vQZCYc50GJjwvn3T9WNYVC+IQkz2SG89Zw/h/CA78lFVo4jcqe9EsJwv82ofVLx8owd/5RSPHVW/17nJF209U+oXByOEh6RpxYre5FNPQMs1If/effublJqOUzyD8XEb9pJcWqh9xGul7IWXotqHR0x3m6ZBrgOt19iqVOhZIbhY0yW5uI8TfXw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:58:52 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:58:52 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:29 +0300
Subject: [PATCH v13 06/22] vhost-vsock: block CPR migration modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-6-2ea78fd1b7ed@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB285920:EE_|DBBPR08MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a7635b9-cba6-40cf-4cfc-08df23b1f441
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GHALjJg3cPuYB4iYz+48wo40vpbvdLQMpsf36nJGgeAxEz8SJEF6YtkrHQW21xVy46PC9lLoDRoNzmASHZnX9IGC3b/0k3Od/YDW6lMUJ3pJ1UDfQwrGC6kUr8ZiQUxM+B/1tMKnxUl0aJqOJhGr/ywftVG7r86OFn4HFJWnBpmpEZUaHxl/HHdzBlTSFwwrQvS83V9h5nuLMZt9stHNyi18S0NXY8Tbvnrx7hmOzRDjRiPntGrbaq/qhvzTCCAxmokzeYfvr5DhKVVgTjHB08KqmqkW2iStkV9bcsq5csf7ligeVG6Q6+k91Q9jzVgNl85yHPl2Jc5eqrNvAvZhwvwmSB+x1lZii8b5e73Dt0URjWcKy3RYEZxDIU9EfA7H8GI61SAPSpcQvpc1uaPXpgFmA42rO3NgQWFnH3hdgN2eu78zlZPiMWugEg4sldeeqFczmPPkofdTpVFsrKXcDXQbLkXVwYfkkQ3+raBcJ10ACafbG/is9qh/+Y5cFLXlRMy3Zp5yCk3BQRQIz5Hqrk1/a0OYESv05Pfu0efJc++OuDcW6om2wgraM848/0lKbfG3z8BhRngow1xRGEwslguzc9y6ZGjDJ/GOeSJk0AEtlTe9T7VSu6Jg7EXpygbwHfRL7ImhXCnIQPYgp7uINWMacQEZrZL/sxzRBt5Fr3qbkdTSha4VFMmaZUoGOnDPpab8ibG8JKm1dSmA5V87ft1opmTkBWac//linepjy0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEorKzF6Z2hOeFFsTlM2MHZhME9QOVlGbU0yNzFxTWV4Y1FXKzhVYzJSK0FM?=
 =?utf-8?B?MmRCYkJVOVo5VDNSTkt1dEZ0L0kzRE5STnJncE94NWtVcWgzeUpXNmt2bERV?=
 =?utf-8?B?TFM4YmtqUUEzTERRUjkvMjBuYWhHQ083WVUzVnVYaHo2Rk5HZUN6TGR3TG5o?=
 =?utf-8?B?bExHSHh1NWxFSlpPQ0JIMGNDSlp3dldWeWRYaEhrT1FsOVFYVmhqTmhyUm9K?=
 =?utf-8?B?QVZLTVJlbmtvQzkyRnBmbzk1Z3k1OHRKSnd4V2JZL05zVmRHTUFRbG1LTHJT?=
 =?utf-8?B?aFZUSDF1MFpTRW1OSWE3RTQzcWVsMSt1Rjc0ZlJPNnNWVlBvaTRnTERDUC9K?=
 =?utf-8?B?WHVxaENkem56U2hwazFJNkdkWWdGaGsxblhPNjk0SEk0Vi95RUY0UWFyc3NV?=
 =?utf-8?B?VTRDc1JjVnJpRXZkK0Y4VlVQdmpGREVnbWp6ckNia1lzOEJiNFlVd25LWXFu?=
 =?utf-8?B?S1RHVFp5ZVBpK0ZDaW9jT2hiQmxDNXRQb0ZHSWFOY05LVnVRUjNYMEd5bHdQ?=
 =?utf-8?B?NC9BM0NEQXVJc1RMd0kzYzVpa1ZuWEhiZlJ6QzU2QmRaREk0aFRBeENRa2pi?=
 =?utf-8?B?OFZvbnN2a3B4TmYyQ2RVOVErUXVxNVR0YUpWVkl3WkNUS0l5NWJySWZ3czRm?=
 =?utf-8?B?SGZsY3lseWkrV3MxeUdoY1o5K0ZWcGQvZmVVbGdTVjBZN0JrUE1rQkNmZUl0?=
 =?utf-8?B?UTNxT01ISm9Fay80MWNnZk9Wc2dDdCtpdis3NEtxdEo4Yk1tUy9scVFwSUVW?=
 =?utf-8?B?ZnBRYUROWG1LMTdVc1JYcFBZZGJDcGRYWXZBSjFoN2d0ai96LzBvbmtROXNu?=
 =?utf-8?B?UkZhWFg3MXVVNXRjR0V4UUhhdTdTNFpPUTF2RVJIeU8vb1NhSEJ5Vjd1VFJU?=
 =?utf-8?B?WE84ME5oeldCTUJKeXF2Z0NHck50bm9NeUJmU1ZoTjRpdno1K2ZVSHplc1J3?=
 =?utf-8?B?eG5rNjlvUW4zREk2V0FVcmpUNU1aUjFISk5SSlBaSWN1eDgrbDBJUno4bmpJ?=
 =?utf-8?B?OU83M0xHY1V1aXU0Ylg5akdoZGl5VWlETUM4eE1jbUgxSXdEVXViak8yekFx?=
 =?utf-8?B?WGNEWEQzYkEvc2JDdjJtVHcwSEV3WmNqdDM3Q1YxSFRGSFJsaFIzVFA0dTUv?=
 =?utf-8?B?dXVqVGplT0doRjFPdkhZVTZhTWlLWnJrQU1TUkdndzJSOVcyeFU3eHQxNzI2?=
 =?utf-8?B?WVF1SkkxSDRKWENvRGNqZytna2ZvcFNvN2NxRDJHUXBSTEgyRTk4NkFmem11?=
 =?utf-8?B?Mm9hYlZ6emlZdDZ1WlRrQ2p2YkVnZnAvd21UTmNGT3Rpcko4NkcyeGlVN2dX?=
 =?utf-8?B?SXoyTWZrYUxCZTQyV09UQmZwVmViTHRNOEVrVnREVjRmRU14UXpwclRyb2Vx?=
 =?utf-8?B?RGhqa2Y5NVRLTjN4dCtlZ0ZVSzYrY1NEYVAzckM1dnEyRFYyU1ZBUzIrVXJI?=
 =?utf-8?B?dHJ6WFVNV3l2WFQ5Q0RnYS9uRlYxZHNZMUZlajN0N0NNRG4vdG81SG9Qd3NN?=
 =?utf-8?B?YzlxNjJsdThiSEM1QVpJcnk4MU4vUlo2QzdKd1V2UExaOWU1VlVILzBSWUgv?=
 =?utf-8?B?b1hYYmNGKzZ4djE5dXNrZ3hORXEwNjdLbDhMaUQ5ZjN6akxrQmpoMGtIS1hS?=
 =?utf-8?B?eDVYbDlrdHJ1V0tyOU1IQzFhQ1BEY1RYZmN2V3BFOE1oeUlGT0hORVZ4Wmpt?=
 =?utf-8?B?ZGJ3cTVBb0JvZFJLZzVKWkFZNU5sN3ArUjNjS1d2UkhFaXZoUTdWenl5eHd0?=
 =?utf-8?B?QzJXYkRsRVZQOE5SVVJ0ZlRESEFaQmxPOW9jTW8xN0F4aDBjQVF1OFNaYVlq?=
 =?utf-8?B?TWNYaXZ5K2x4cE4yNlRrSkVZWEErSlVzaGlmV2xJNTREd3o5dEQ5SHBwSGJQ?=
 =?utf-8?B?Sjh0YUw0bjNUUVp3eUZ2WnBsUG5Vbm1rNENTNnB0SW8zOVdZUFhQWVJrNHB6?=
 =?utf-8?B?VUN0U1VEcU9DN2dKT2ZrWHk4L3NZUjJMNXU3dWFaTzlPVzVyK0ErakViQXJQ?=
 =?utf-8?B?NkZHcHBvWG1JVkNUV1gvNGhZMG03SUx1bjZhVXpRR3hVMU90ZHJFYWF5ZUtp?=
 =?utf-8?B?U1dUdUJsSzl6TnRPYi9XSHVXdjc4cGN3RnhxV21aOXpxdWtYalhCUEp1TUov?=
 =?utf-8?B?L2x6MU5vYTRId2JLenA3TUE2c3VJSDRPY1lqRWJIZmFPbTRSeGxVVjl1b05I?=
 =?utf-8?B?eFhMeXlCdzRkcEYxWXp1N3I1YkJIakFwdHlzTCtQYy9JdzhjQVVUb2JRdzJZ?=
 =?utf-8?B?WnZQZkZQaGdQbHplQkhhY2psdW1VOFJxdjBUY0pvLy9maStUQ1l1WnNYTXY3?=
 =?utf-8?B?QURnVURtdHdNaUZzTkVOOUFXL1dENzVzNWI5cnhCVjJrQVkxYmtEcUNXQmEw?=
 =?utf-8?Q?dxPZfyeKJcpGgwgM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7635b9-cba6-40cf-4cfc-08df23b1f441
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:58:52.5381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RGuGLVyIaSj/jfhzbP0hGlh2cD138Vbo9WtBZ6zy2UYxSAK6D4Wo3WV6Y03M0fYZ7ZiSWtASgYILxSzpOUXSGtrXHzb+YMeSGO3shzHpdcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
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


