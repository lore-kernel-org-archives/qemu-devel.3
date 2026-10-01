Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD0DCA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC8Y-0005m7-AY; Thu, 01 Oct 2026 04:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC8A-0005J1-Fb
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:07 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC88-0003Pc-6G
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j39pgsgdXJ4VPKGCU0QGU3X8uKICS6DPDvJkKMn/Y/T8vEB76bqqdM/RilGrS6QUsNYpvTt/HVV9rTOrkIIiyBMux8MTWmq+qHdZXhvShKL1PY+x4c7+gXS3HcBF3PgzPC8zufA23u1vIskVtsyG4BOJ9sx+0VE6QWGmXWBE547ygSgnKzDEX3dFcz7woWQx57VY3+cSGLJOQCAfsrOP+N1QptreGqKmcAEie8yhAiI5Tt8sfZrSPs1gnNTEwIbRckECBWYjPIr5XUU9tIriky8h8zZc3t7uhJmkl+pZu33lmKxOhATNyCYd0rVooKl++1LC+Brnf3S8J5sKdBEr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=IF04xzO0gV77NReA5YHtsjshG8jQbVfu6adA527FcHDWwQDqNKFC4DQeQwWK3xv2MIgQTvIglunvzvQffjP/V7o9BeAVCNDDagIeHcjG6QDUbniot/990Kebb4CTFkxZ2LYskQymmrCVdiSd8Gh8aHgTZKyVZ5TlNEYxFE9bbT1OtaM3132wPqS6IJsrAPQ8JIxCOrpvXKcMlrLpFKu+wER3Nd1XYThIxIGLKILoR08zbD2Oy8tHL6DHZMu/UPs6wgCTlYeeOeEJqxvKlV5y9odsSv4/IY3eJ5uc/7wuHXfX5G+XijHaqUtBbMThuFAX6qFdIQAJH9jmoMi3yjrfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwrMOjbNDkBKfvJaT15RqDxDYeominibToCZs4sNc1I=;
 b=ZCIZ/1dF5m1YCt/IhMAfRpi1aVX22JMr9bI6ax6SxiV34/ROcBM6ryZC1z/WjjBYeoaQf0Eru82PV7r5wPuSAwYr2dQXQUFxKlIg/DOPgTvixxBxXRvKxtCksF0os5GZhlr+FCJD9tlA9AuTXAmn0k0rITkWNOd7jbM9Rt0rq1HxXbd7ImCi6Azmyre4YDlOdCUZm9cdxCFEmEq9JpaU/0cX+dIPjoUyVe1J316G6+lZ15K963nwEiAOyv/AklaVQ8yyQE5qWjJDS15RQBs9yf86MerlD6iWrEI4rYwqVxFeRAyrDdWeNTgcOiv7JS0OlJv8ZjYzKIvWsdGUYwqk6Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB9442.eurprd08.prod.outlook.com
 (2603:10a6:10:458::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 08:26:51 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:51 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:16 +0300
Subject: [PATCH v10 16/18] vhost-vsock: hand off device ownership across
 CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-16-8c094843e98b@virtuozzo.com>
References: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
In-Reply-To: <20261001-up-vsock-vhost-v5-v10-0-8c094843e98b@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, odaki@rsg.ci.i.u-tokyo.ac.jp, dwmw2@infradead.org, 
 peterx@redhat.com, mst@redhat.com, sgarzare@redhat.com, 
 vsementsov@yandex-team.ru, farosas@suse.de, mark.kanda@oracle.com, 
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 philmd@oss.qualcomm.com, bchaney@akamai.com, clg@redhat.com, 
 andrey.drobyshev@virtuozzo.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR07CA0284.eurprd07.prod.outlook.com
 (2603:10a6:800:130::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB9442:EE_
X-MS-Office365-Filtering-Correlation-Id: 25825e1a-b38b-49ae-b528-08df1f95bca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|23010399003|18002099003|22082099003|38350700014|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: l/7Pq2JSToQIEDgrsoZaVCG1AEwe/ILg8uZHyT97vNYI/J1J7SmVS1VCnne+FfYBt+ikheVZZFVFKPvbIJF3MW8e8zwzDMQIqfu9N+Mnr090V3dspu21Ol4fXnmU78NkAID+5ylXnCZ50lrMfDuUSOk5rjGqkJ+/EpqiwwTkG4T83SQxSn8bsvpROXTF65T4Nei89BnL2dpogVRMTbv+DVwp9uehveCBru0xCknRnxhI2uqO8M3yxTfz6PSXM3DP7xXVOTxHddR60gNKRC7cz16OtkMXIX1WaUAU/+O+EnVtk0LVIerHRkSgPxewuDDWxst1P1VNktgtjvT2kSJ6idSkU754Iivr9lRgZl6sW3kBQ5h3a5ExPBN2IpZpw68rIdp4PtAsKbj1gVohu1vouvodYzlGOnlcBy5+EV9MDYduhS+k0kKeZzK9X/00v4GnuwxMkJ1rs+q9oGkvpq+wZkgziuZQHpQDudhYi45R/ShRcMz8ynsgULPZzCCcoaP1SXlUh8vPXCAsg0wLYH4fgWsQNYoKPwNNmXIy8GY4E0I9yClrPMuS/vB/RbVDP4B30cu8v7hph98xQpgvMjmfH3QD0cb1D3f2/WLIDXITnxKQFdi9YwXbnLYw5D6X6BX3abPXFe/+ijuhx6yO2ZLwvjaNRLOETNiD3mhkvesj8EnkOBcIRoKO8b2Q5LV6+SAxg2go1t01xkHB9PhZSNWLE1KQop9MGYbXD/FXspbOB/Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(23010399003)(18002099003)(22082099003)(38350700014)(6133799003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czhHVjJrNHAyS0JFODlHN3VoMi9FWFZtbUdyYk50cXpkV2RqTURBODVIUFVZ?=
 =?utf-8?B?dzg2aUd4RnVuWjY5cGNYRGEvTXBnZmFHTnVEck0vdTVYbk0vV3hINnFYY2R0?=
 =?utf-8?B?S3RmQVMzWFowbFloMURybnd3S1hWbVNtTFNzWWMxQmI2VG9sODRxTmpPZVox?=
 =?utf-8?B?ZkFmeFdzVWNwY0ViVGFvb3F3YXVXeThYS3E4dnRNVGlJQzltREQ4THcvR0tL?=
 =?utf-8?B?VURCZ21lYVpOb0pRMUlRanFMOW1CRVZvQ1pYNFFOODNFdXR2SXBEdk0yUDVC?=
 =?utf-8?B?aDM4S0xvdXJRK3p1ZEFKbk9SRXJjRVdDZXIrOHRpdkJsL0tFNlo4b25LRFlx?=
 =?utf-8?B?WDBndmxwU3p0SWdTdWYzeFh2dmVPZGh1cTZvL1FNbmlUajdqalFIdG90SUMy?=
 =?utf-8?B?V2U5OUhJKy91Q3VjV0J4UGNDRmE0Tkx1eGVaZ1o4elNwWS9LRmorQWZNUzVH?=
 =?utf-8?B?TVJyZTlqejRsQ1Z2VW1PZnNzdHNTcTV2S21oZ0R4QXZ5Wjc1a0xxQzJGSEVh?=
 =?utf-8?B?aUpkOFA5UTFibGlsbDJoTVlQbWR3WXhRZ1l5VEZtaEFNWm1YZXNVWG5mU0Y5?=
 =?utf-8?B?VmdJTGFsUzMzdGMyZFovRWNOaTg5L1U3bjhyRVRudWIwRWhqa05QR0d4bUQr?=
 =?utf-8?B?T3d3ZFJaWU1kZnI2TzdiQmc5b2ZNa2tJTkNtOUo4OFNKejBCRWtkQmR5OTBV?=
 =?utf-8?B?YkVveW5RZEoyRFp0SE9UVXR1aDZZbnpwZkh0OVhmQmk0em5GRElkOEI5YzBW?=
 =?utf-8?B?TktoN3FCVnRlQ3VBamNmR1E0WUsrZElhOExaUEVVVUR1UXM1L2xUU21vS2ND?=
 =?utf-8?B?Z292QUUrZUpiaElkem1iNzNUOFI0MzIyM1JIQXFSVTJhU1pKQ2ZDdG5MMWw2?=
 =?utf-8?B?SzlQWUZXdTBZOFpWcGFwZytsMG9lU2RBMU5GTlRnN1ZwU2pnd1ZDUW1la3lI?=
 =?utf-8?B?bXdUVXhuNk1RZnJTVFEyeGlaN3pJSDhlYU9iYUtFSUpnbmdrcVB4OE1LbVhv?=
 =?utf-8?B?R0k4Z0xPMHByN0pldkYxcmU3ZnNOQUEyek1CM3dtS1dKeXZKN1BpR3gzNlo2?=
 =?utf-8?B?RFhTSTgzUkcxa3ZYSktuV3JsRS9uUUxlWFYvM2xGSlpRY2EwbmE3allFLzU4?=
 =?utf-8?B?RlY2cWhYeElpVHFSeEsrVTdyb0VHZkNoZHd2aWVKSmJoTHNzaDJVQk4rcHNT?=
 =?utf-8?B?VDZ3UmtwWUtqSW1IMEVjZzlaLy90N1hLUzRTUzFNTzZNYjd1cGZaelBoT3c4?=
 =?utf-8?B?WFlxbnNMQS9PL2FaK0x4SEFDV0JXVHZCcEhmbTF3clBrR3hqZjdKbHp3MkU3?=
 =?utf-8?B?cXJIWStQdWpualhIdjBsb1VMNXNGQ2F6UWppeG85eW56YXNYRXpkelZXZ2d4?=
 =?utf-8?B?OFozQUFLQXUwby9rRTJVWmNvWEw1T3FMQmhjVGo5SGRDdFRRS05JMXpja2xW?=
 =?utf-8?B?RG5HbXVGRVY0Yk9yTkswZk9QOWFWNExuaFlYMW9hanBVaFI2cGxiRnhnOXVo?=
 =?utf-8?B?RFBtWUo1OUlLMU85L0s3QlBvRzh2Ky9QclhPL1B4K3p5NEI0V29hOU0ydjJx?=
 =?utf-8?B?ejJBenRGZ2NDbUh2azdrSS9vVFVQVm52bnovNTV0WTRHQ1pORUFxSEZIVnpQ?=
 =?utf-8?B?NVFCVmhYaHFuSEhOVEM3b2pialJ5L2xXWE1RUVhtNSs2VHY4ODNGR2d1VGtC?=
 =?utf-8?B?Qkxhci9PQTJqRW5EZXE3NlNPMnRIR1Ric0tHaHZxWExGc3lucXdBc2V0OHRD?=
 =?utf-8?B?UXowWnhzK0gveW00TGUzaXZaN2JLZlc3eGtCbzZyOUFyL3BmSG5idkN3Ni9O?=
 =?utf-8?B?c2FaM29LWllPVDBpSXhkeUJibWc2d1B0bDh4d3IyV3M3MnQySXI3UUo5WG96?=
 =?utf-8?B?S0dIWFZLelYrZ2dpQmk1TWRYRU5TWFVJV3NxaXBvRGl1RFo2enF4RFM0Q25R?=
 =?utf-8?B?bXE5YUsvbmU1WVVMc1I5NzVDZVR3dWU2dno2cGxEc1cyMnhOb0JZWnhnMzc1?=
 =?utf-8?B?TDJkS2NCVURuMWV6K1dEVXZqVzlmZUtkK1d4b2owb2REdEo0cjFLSzZJWU51?=
 =?utf-8?B?YUxBWS90NWxxTSswZy9uVHZIOUxjREhiekRmM0pEQlhRemRnOFE0Wm50MWdN?=
 =?utf-8?B?OTBhRkIwQ1hEQmRLVEs4d3RiL040bno1ZFc5MDVHcWk1UXhPeFRnTllxK0Rh?=
 =?utf-8?B?bktqZWZVZ0xDZkIvSTQ4TkREc2RhaDVsYmJJWFlMOGlHMllxU0VaS0JuK1c5?=
 =?utf-8?B?b1FnS0NncGdOdU1VQkw0MkhPamwraXFFbVUyU0VCVjcvaFREYUVBMTlxbURT?=
 =?utf-8?B?UXlwYmZZVVZQOTd2ZGR0blRQdTFKRUp6QUhzMS9BS01RdXllTEZwOVNURVlm?=
 =?utf-8?Q?4sRYK0SvQPHQzVqg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25825e1a-b38b-49ae-b528-08df1f95bca4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:48.6412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: csFCGXYg6oIcNpMoTMI5x4OdNFf/JLFZWifCcJx92nu5CXFpTpHCew+nSZxQo5+o5NsgH4+kxAfSwjjzm01HDVJTdORmpE8zeDs5Sxa6pqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9442
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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


