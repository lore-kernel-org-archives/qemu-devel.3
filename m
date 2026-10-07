Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCA0CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwh-00058W-Jr; Wed, 07 Oct 2026 05:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCQ-0001SY-98
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:42 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENCN-0006kK-Ny
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4aJLwU92UahWSJoMKCIFxfgvc7EN/WbgvIQLuS1A2Wk1Iin5sU02Q1bwRgIUPE6a2gRPCcaMfnciXHxGNFjw3aLdCTsLmfEY2sVEBSiswvSPtXxXYQAkj/cN7BzjzliiB1JEgqs2pMXBLl5JkZ9T249rTVJtr6mTIqOSXmeHooukq5pWFjcKn2ytf8o0Tc6t7HKNXy2m2/N0VQ5GNzzTNySez8wWdBiev4OqnnOXY+6b78h/Demqz9VQo79wfSEkowi4o2rbfQc3BEqrLamnuf3louZttSY8J1m4idd/yWIMtgBAN0gTriHY0IciBJmuzufMfnSJXInkPV+UADKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=ozi4Uh1BbqKwB1K8rlxSo96qE/o/c98Qyk48TI1YV34v9gKMGxNmWl9LtfR397VzxddB9z2AZUb2p5pux8lxJ6i2EPlhFaD5Ay/fnHWs0aZrS36iPd3wDPZBfyjwsSHZ6JVmPJ/YSf4MlMYehVJA09Aw7SjfAecylhsXHV6vLIYrXsDPJpKHco7CZXIR3pcLM165Abo1isqAnu0yCxCLn2F/9Rf+z1N0RDaewdPLFtRCFmsYWzJMOmz3Q4San+qorSNiRD+25lWsXzSifohgmU9FAA09+286CKmsuCaJiGguGrFmU1Ie5b2eLFE1YDz3T2cO8tTXm8jzNL1JSnZ5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=waSKw55/KjaA+GZiJ5f8vytwObWZ/MO+LYceNd5gHcmBE4T29URWrhUAvje/m7C2d9+6SjavgoqRP5ykkNdl2y7rdmcrKrMuRmD5+3CQoRwDJl+9MrEc/3HNTQ/vhh/BUK2UNP7ubW8oJRQF4nZm72IbeL2SLVwYd/tfiMKoBH7+wiXxHeSM8A166pLAst9jKcg51VWwWCFYZPeH1+ivgkihuqhisNJj59g03AQ9N4AMIqtfWyILceDbN+eC3Ov5gjjTJAOMTqPMgmAmJy9uQmVVz36sdZ4diaQPB1ZXs7Tsa8VwALeGYfrd0fUchUnKa9kDUMsj6X/21pWzy3PLsA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9058.eurprd08.prod.outlook.com
 (2603:10a6:10:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:10 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:10 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:40:12 +0300
Subject: [PATCH v14 19/22] vhost-vsock: hand off device ownership across
 CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-19-e16de9962df0@virtuozzo.com>
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
In-Reply-To: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru, 
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com, den@openvz.org, 
 andrey.drobyshev@virtuozzo.com, mark.kanda@oracle.com, sgarzare@redhat.com, 
 maciej.szmigiero@oracle.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI6PEPF00000236.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8ee) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB3PR08MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: b32732e4-06fb-439c-65fe-08df244e9926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|6133799003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: ANqJnRw/h7HEJLhCHDYnl7hZzAn6v9EeE44LC4qqMeAnJZ+jePELaYuzoxxA6rIit+lzMGsGA5ym3sNMC/Vb90e6wYTbv90Rseg8Xxy1QwGel8VM/lu23axY5ZehWwWHMR4KINEyyE8R2VWo7Ryr26UR6YmmgxkDRUeDV/MdxGmT3DyKmSCXDGMu/1zxJ5lqCRuKESAYfi1RTs6DO5UkGYAX29zsAfQVKyqfMqS9sa7tLdz8HNo4Aw0QZZFxRAzRlCzh1jab6z58kV5Tydh5Vuc7TM++nzU1hYSx1NP/cioIofh2HEKRNuWH6dIBL9Z+z9RGG12A/1k+QeyCC632ll/5qaAK0gAVY8sofrtI3EQQ3fTzOgPaID2x7Dklk5cyTJKVshr9cUeIyIgDyW4QluHW9UZS+qAKonGtnoWORqNzrLS6hABHldoQ+kz0d7kMt9raLrmBw1RyC1/U+JVXGuATnT0/kHBe5S7hLQ7hlrCefwXY0IdiFcCIiF3mIgoipq8tTAukPWn7TW5RcR+KgnMOqhFr/a81ZtB3FeC6sN+xJyplb//a3Z9E3B+m910SowX1AfP+Jf8riGow5D7ujy5+DRyyQoXKWJJs945w882b92M3TMUf1ZarGhVCevPjbX9QaIWhq/hKJeTaoFeYAsdShUn9B+nEpRSZeZ22Gg63Krl8CgQB1uyPeaJxr6IOkbUlXzbXwtj0v2/pA2M7Lq1Cq+QGVdy2EpD8wCUxneU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHJmYmQvcGx2WmVnZXJaR3p0WXZ3Uzdyc3VnQU1MOU9TR0RiaVVoaGJVc3ZW?=
 =?utf-8?B?MTUrWDYraCtacjd2NEJMS291eGpJME9uWGhGNTRKOFNjMEtsZ0RvbHVtcU5I?=
 =?utf-8?B?dDB5RlBpMVRiV3k3M2lDSTk5UFhVaW1yUy9qZGQzNjlXNG8zcnNKbUpNV0Mr?=
 =?utf-8?B?dWg5cVpmS21OeDFIOFRYU3A5V2psa3pGTEh3STIzRDhRSGNZa1ZSUFl1ankz?=
 =?utf-8?B?aXNRSitvMEZHcmIwUGlXSU1va2lVbEdGVmphTGZlVXF1V3JmRm5yR2hLM2tX?=
 =?utf-8?B?NFhnV3l0Q0U3b05LS0RIZFFJWUVVUVAwemxqSzlneVRGNHVpV2NEN09uL0k0?=
 =?utf-8?B?UkY3aEtSVXNCcWc0c3liVzFVV2NOUTc4dlc4R1ltTTR1SGlza1VDdEZwVGNz?=
 =?utf-8?B?L0VkR2VkcHo4Q01SUVozOW80Yko0QXNGT3dEVEZOQUF2Uy9Ec29tUmFrTUo0?=
 =?utf-8?B?MzZCcmQwVk9rWmo3Nm92SENCOW5VSXhiUEFNRUhGdFAyU1pVeGlJenM5VkI4?=
 =?utf-8?B?Ny8yMzRpZUF4am1IaDcwZFFOQ2hBd2o0L1YrNXc1RzNEcytNblk5c3RRNnFO?=
 =?utf-8?B?dEREMm5VUGdPY3FBTmQyVmZYdTh5WWZmYUVDR3VFSnRrTUpHdWl4bk5vWUdQ?=
 =?utf-8?B?dXhyR09WQWNmT0FqNU1xb3VGL2c2TlR2Z0hlekY3dEdUenRTVm5vcnlDQUty?=
 =?utf-8?B?SzlYMEJ0alZVUU5tSXB5SndROElHWDUvaG5tRzJmeDdYUkFGcEVPRThRSk80?=
 =?utf-8?B?STkyWEJveG8xclRVVEJtTFhHb3R2U0xFZXk3bXBTS0hCc2lxUDgvd2plSTZl?=
 =?utf-8?B?dVhtMTZnaS9YNytUSjZqVXJxYnVCM2t6UUM0U2YxNk1iQkhoc0IzZjR2b1Nr?=
 =?utf-8?B?S2E4QUxuWElyTUc2b0xxancyM3ZLUytBMHgvNzlxdFNJMmVQa2tYMDdJeEQv?=
 =?utf-8?B?SGlXbDQ5NVcyMVhscFI5VzF4L3ozZ1ViMFU1Z2M0RjZZS0hjdC90ZWZTUVFW?=
 =?utf-8?B?Ty9renV3UTZvZmFZZ21MVjA3RDA5Zk15U0YxdzAyRFltRm8yR2JLNDFCcS9a?=
 =?utf-8?B?aDVPK1gvSWVWeFExYjRQS1NzRUpxbU16cjRaMWZxNERIR2luL0Fyayt6bXl4?=
 =?utf-8?B?VFZWM0t4WTk3MkJHbDdCTitJYy9wUHNWbzNGMzA4ME5BYWxFYVh4Ym12cnow?=
 =?utf-8?B?T29jMHJHazVvallyT2NaQWhPWkRtTC9ZNUVZQk1aelhHdVZqNFdjeDBBWDVL?=
 =?utf-8?B?TU5Sa1h4WXNjNW5FN1JlVzFEN3FETThUTlN5SlJuRWNwVEsrdFJ0NE1UdlFD?=
 =?utf-8?B?OEpUZGJRQ0J4cWIxRFVSZ2J1REZwWHpmOEF1ZVI2eTRFTnB6Y29BQnYwVFFy?=
 =?utf-8?B?QnZmdlpKS1BrQjdGMGk2dHRKWk1uQ20xNFhFbHlIUGh1SzFLa0VMbjRoUTJJ?=
 =?utf-8?B?VkYwd0U5NlIvSEJVbWVCbzVUc0RtNjJRUGs3aE9qY0RCL2EzOUp2Qnl1cTZZ?=
 =?utf-8?B?d3AzZjVmaDB4VE9ZQXBLTGY1d3NIOHBaS2lGU1JQQlBOWklDb1F2SHV6bjNs?=
 =?utf-8?B?RGlleEJnZm9xeXVMVDJRQkhrN1RXWHRteTFSU0hqa0NGRTRTTHhFUHZpTGli?=
 =?utf-8?B?ZXBESEJKWGxsWU82YTY1YjYvYmRmajZiN3FVcjdnOTZseExQSmNKOE5hYXR0?=
 =?utf-8?B?OFRwRXVPRUw4MzM0MWhNUnJNVmVWeFdMZHV0Y3NQLy91ZjBUaFpxd050STdm?=
 =?utf-8?B?M2tLbmNnU080eUR3MG1sWjlBZjA4dk11VTRURTNSN21pTmFxYTQxc1R2L0tQ?=
 =?utf-8?B?SXZyRGNLc0JRUkZDMkFOVlZROHJHWFBmRk42Y2FYTHVjWTlFMkkxSmhyb3cx?=
 =?utf-8?B?Y2ErdmprOGRmekhKbjNCWmFCclQ4K1ZjYUF3bi9VdVVTTFhXMndJNTN3KzFQ?=
 =?utf-8?B?N01UVFdOaWRWdGUyam94aWZscWhZR0ppWFBnL1BCN29kNlJENFpYa2x4b1pD?=
 =?utf-8?B?NmJYN0Z1L2h1NVF2WTk3ZjJraUxObjViU1EyYnE2OHlmR0VOcjgwSEdMQStY?=
 =?utf-8?B?YWxNYTY3UDU2VzZSZENDRm0yYzBHQnEzRzllMGduaTJ4blBkaW93QXpiZ1pU?=
 =?utf-8?B?bjg0RHgrcUwzZ0s5YmlBWU1FbjF3SmpITk1IZVBUVjNVV0JKWHkvOFUySEtH?=
 =?utf-8?B?T0ZrZ0F4QlFQRDUzdDEzOWRJTUtmRVJ0SlVsRWZoZEgwUkdKVDBsWDNFd2JE?=
 =?utf-8?B?cmE5TVVUa3RPZGZRRDllc2QvTlE2aDduZjhmdVp0RWtxdXFPTkJTTWU4ZWll?=
 =?utf-8?B?YllkQ0pJaFZySFJzSGlBUHlSU0UvOFRiNVVXQWpTaWFtSnpjOFIwRm1HSkll?=
 =?utf-8?Q?1bQV7nkKuUzxPYxI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b32732e4-06fb-439c-65fe-08df244e9926
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:10.6577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4rVt2SIJfkWUuI/OjXweAd2fMVL47X/PHwSz6zqgT6iTxspYD9SgewgNI5Fp/ot8iymdEApdI3kJBMlaz0oUCI1a8XOrZoq4zZBF8GPpAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9058
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


