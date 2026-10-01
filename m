Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599F2CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:28:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC8L-0005R0-T7; Thu, 01 Oct 2026 04:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC87-0005De-Pn
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:03 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC86-0003QQ-7T
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2aBFZTHUJDbULjkS6+9oEmChMcD2grsgg9AOiimt/o2Aaru8v7bXZMiHd49bGrllN29BGz5IR6W5EkJY6EGBaJ8EV8zN8eN1ngmW/4+MUro7pQNeZbbO1pjwzHy2SzItOhc/6+04u52PMKITW1+NEfKM8GBKeJekMSfMi0BnSpTlkqA6Ls9XFGELVxKonEPuxqYBraRxhskH62xYyGUCwtlpXnnCFiGXsubmHrGjDtRhoyndfNZUZP3Ck7itS/itBY5fKFw5pH+ibv9zxudXFUeMykbXKK6RliK4XMxZTUZlZP97Ldr74rhmupSasG0OihJnrZ7/ZK/w9uZPiV5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=sfXCT2jbCTT1opMXqmZEnCe9DmKb2xDQLq8rXlyuljLOoAe7W2YkYk64kPuVkqYH1S4gvs+3QVUOhD/HEuNP6ApC2UVmubtKn/zjxWPoL31JgvNACv9C5t5k7Y6iRcznQv43EfLU7FwTdGF9o3l3b6ym6bAROrWcBbMEXZpodfqmM+PGYI4Nn5vlS2cy+TajNPCF58R0SJgM2hQbkDOqlS7Hn0Nott4VCzjPGVI+aiiWkQkXekNPKKCXaNj7fnN035UnNKehhkrq2EQkyYg2q8X0qE8pxBvAIB4jJNhIE+BTXSXR3kib0lq/le4tTWqW7Tns1xFCnJzXm+6GmMkz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQgnkcViSHs3Rahhzmph6ktL2+UOz0MojTzm/dDNgZA=;
 b=iiOeOupnrjb9/s+/PjpYJDNvo4I3IK2Tr/gtcOptS4BtcqCYGenoufuGXIceYTMaHr5cs8VB7yIqZNCFvxSJqMyskwgt+HZrv2EEbttP9sej5ilgEo373TAh8HuNXNrjPQ5irMXfakEUqNLBYSmv6SvnbptSz8oDdf+hABsPYe4jc6hfH9LctZf+90XdG+uwQQo8i/sYdnE8jZvxKQkfncfu2uCHyqrCfc0lfZh3w74S9S/wKRrhjntuKX8AxSZytW48VO55kheUriOtfGPABSaDkpUU7QX/IbJXciwGI2rcKEv/I+xy8890nHzo4aOyKc//uLeApwAm/Ok1zmP7zg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB9442.eurprd08.prod.outlook.com
 (2603:10a6:10:458::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 08:26:50 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:50 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:14 +0300
Subject: [PATCH v10 14/18] vhost: add vhost_dev_is_initialized() helper
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-14-8c094843e98b@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ca54f382-525d-4944-0ae2-08df1f95bbd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|52116014|376014|23010399003|18002099003|22082099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: RpfXd8A0b1MCH7+1ZW66uOknJD+bgXQJDAY90eg1SrbBDqLiY0Eu6336KivXztKgjaxXlAL1CZf7Tb8wB3oUiaix8ab7RjsPQhBvvW4uZgKLFAA4cLlJkATNSTraBDCi1z7IEWDQZwMCBQ2GxmIbbuHDr31dXVDhMYnRiIA0CZfdq47l4+nJkTCtpid/Y5sdarQvVg+eABgVN3eyW3IOqrtnzZj3GgIDCzaayMQkUJyYjxcEihQhWI8fwOGOwAkfFYj6/YuV5zLbxeEFeAJUTMHcV0dpil3JkELECH/LcIsraUpVyRZfwt48sGDLiIZ/LN+k6ecAF/VXidVcSSWDKmEZFChU3Lq5x6JSx8WSX1YjpYJ/QZLPJtKNCb1w6tofNZtIZdjqhVtE8Vk6qOicYKBa3pj6WpHGW9xv+u6NlWk6leLp5z2Uqn2Uc5tMjyIOQcmsN9Q/XVVuroE8/k+A/yVHyjbrgCyXS7Ll7kUbRWPXyuNWz62azgOBwg2GiYhMSkRGmXRc6+rBGv8TcOccmgWnSE6Y1trBeL/xkRYzrJ+BWn0bRkkR5wG88UIQys0c3drDhBSP+2WWgm67D4hkdD1DPFfhCagzDjaAhgyQ+cxm5JooCIXAacX5iY/mD1btsXfvi9MCvjG7msu0M/xncReFn/7oCv1aYodyivah9CPt8GvZFUeN7znyXDG064FSLAe8WWmn8fhIdbgiWrQ6uPqqi7N7R86438T30Y+GUZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(23010399003)(18002099003)(22082099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkhjRW5JQm1WY0Q1SUNCZVVoTDNLNzk3S09VSklmLzBGMzU4bnlaUVVzUDBO?=
 =?utf-8?B?ODB5bUxHM0ZzWlBjb3dxdHVFTGxVR24zUGlmM2JVRWVlaE9Zazhxd3FsbERT?=
 =?utf-8?B?S0FXV1BndUtqOWlpMlNnWmtkYXM3NkR3WmQzbS9tL3pFU3h2aDAvTFdpcDNy?=
 =?utf-8?B?M2dCZktmZm1KeUZFOXJ1SmJ4cGQxS2VrM0dCdEdpVDZqbHYzVmVMM0ZoNWU4?=
 =?utf-8?B?NDFlbCtLS1Arb2wrenVyY1FRT0xHajd1UCtkZUxsUWU3eklkL3hUVUkrWGx6?=
 =?utf-8?B?cWdXdG0vd0FndE9HdkgzZGdpZmJNWlJQd1FvbUlxNjBzS1ZFSFh5Yy82dHRa?=
 =?utf-8?B?MnlTK0Q0eFAxU01rZ0JnQXZIbWxEc2ZNbnhVelBjNUNCMmpDMmh5aEJqQzd5?=
 =?utf-8?B?M3IxMitiaHhEYk8rMkcrZmRJT0R5WlRvWHBnWlR1Nk4rd0ZBVVFaTVdFYlNV?=
 =?utf-8?B?TnJYSjY1am5hdHplS3V4dml1eXJxb3hkZW9DNFIwcGxOK0F6WEREbzFGSzZl?=
 =?utf-8?B?WTRLOXlobFIraVo4elZKTVlDem5Gc2U4U0JKQzIrWG1sRDRrKy94TGtXRjhr?=
 =?utf-8?B?YnhkVklQQm1KZ1RzaWJMVkxYdkViTXl1T1FUMmdhSzFBWklsV0RGNmRmU2x0?=
 =?utf-8?B?Z1dCN1RQbTVOcGJiTFFjeDNoMWpWNUxnV0orTUdHck1zQzFvRTh3SGw0Z3ZD?=
 =?utf-8?B?akFRblpRZHVoMkJYVmNVSWF0VGJza2hWU0NlMmJ2OVVRN2xrbHdvU3l0U3lZ?=
 =?utf-8?B?QkNmelgrUmZUMk5xL2crZ2hVMjViYlA4OXBDRVNQNWFiUlJxTUJFQ2NubmU4?=
 =?utf-8?B?NTVtM2cycThOMnJvS3g0alB6OUV0Rk5RN0JTWkZQODBSOXZQYlhMV2hRdzA0?=
 =?utf-8?B?aFJobnR5bytvaTdVMjhDNmRrUURpM2thUVMvRGxHV0pvUm9VUzhxUForeXU0?=
 =?utf-8?B?MkhxV3p2SEt1allwSlV1TU5RazJrbDdKN3NKNkxveGRNYXU0L2Q2dHMrQzA3?=
 =?utf-8?B?ZGVyVzQ1YWVWd3VJR1dZRzBma0lQL3UvTmVRUUhlbEdFblFPY00vUCtpdnpn?=
 =?utf-8?B?OU8xanZ0amI1blg1cnRyTlRlQ2w1ZVIrMyt6aUMvbDkvbmplZWo5SW40aHc2?=
 =?utf-8?B?YzJRQXNIWUlXVWl1NkRxVjhkNnV6bEpqSFVGR3ZBc21oNlZHQ1BUeVE2cmMr?=
 =?utf-8?B?RFJWTmFtREFGcXR4YXk3cFRxRHZRVHI1VVAvSzZaU1ZsYmVZbGpHSlFwdHBw?=
 =?utf-8?B?a2NVdUxwNnUzV21RUzBnUmw0RERIcFRjYzBYb001d2YzQlh2bjdVbUVCL1Bh?=
 =?utf-8?B?Z1dIUVVhNXovMU5vYUN1Mzl3cWFBaGJSR3dXVlJncXdWcnJDT3hGb0VacmtW?=
 =?utf-8?B?M3lxVFB0emxNL1NOTTBoSFdlZld4TjV6ZHl2aEVoUDJTenRQcUVtd1BCREI2?=
 =?utf-8?B?R0xZMGZCK2huMnNKYi9DZlZtajRFNG4rRmRhMUI3ZG4rK3lrQkxRU0drMGJQ?=
 =?utf-8?B?dnpDNXVZUFNUMlgvMXRvQlVMR0R3OERPY005NUhjZnByVXo2UEZIOWpNU2Zu?=
 =?utf-8?B?Q0Y4aHpTSk4vT1Y2Y055NVZEdkNyWG8vT1ZrdnhienZuMUlEYlNtSW5ZRElI?=
 =?utf-8?B?dnF2dVhQcUNWUFNGMm9mNVkyOUpYSGw2UVN1am81cHArdllKbFlVL2hmcDlh?=
 =?utf-8?B?amFlRHQ0RU5WbXpnS2VJVzZVUm9MRk04QndVZVUxYUtWVXRQRklSMU1NT1NK?=
 =?utf-8?B?cUhDeko3Q0x1ZnA1WDJ6cW1sN3A3SmNiM0NvS0pvamtsZ2VhRmJ3Y3dwVXRu?=
 =?utf-8?B?TE82TFFyamVOYk1nVlF0NGR2UUlLeW5URU9WTmd1YlRDT1JWRUdNUEZKcm1E?=
 =?utf-8?B?Z2FYYWNDemZDUzkzaFlVNlpBNHhPNVRQNW01N3RHejkwa1lYK2grYUZBYVAz?=
 =?utf-8?B?djdpMFB4QTBVSE1hK2p5NmJaK2V2aEdFUW1LOUh4UTFGL1pPQWwwZFcxOXFi?=
 =?utf-8?B?RUx4Vk9DNlZiN2JrUExSQjFDRFFZb0VyNUNiL09aWlJEcDNKdjVqNVFJeE5u?=
 =?utf-8?B?L1d4ZjEwYTN5TG56cDlJVk9WS3gzZFY4ODU0ekZwSU01c0tSQkJrWkZyeEMx?=
 =?utf-8?B?UXRMbmYzLy9tWjlLSXc3Rzd6ZGZ0NjRmYjZLWW5vQUZ4L2cwV05jL0xVT1Zy?=
 =?utf-8?B?b0NQdzNzc2ZBWUJNUnhvUmpGS0RqWVh1cHZFeU4vRmRDbjEvUGR1SFdqZEo4?=
 =?utf-8?B?SzZSU2Y2a0FkRkI4Z2hUalFKdW9yM01vM2UwWEJlVmVCbGFROUkweDhXTjg3?=
 =?utf-8?B?MmxqN0tWTGJmRWI0OVlmcWlYQUR1MWwwRjlvMC9wcUNIVDhRK0Y4eEh3L2VX?=
 =?utf-8?Q?fCUhpmJhCODrIBwo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca54f382-525d-4944-0ae2-08df1f95bbd7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:47.2965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYOyxAs2Q+4pz8Riv9kQF6DvxmHEvlIbbbk9IKGrQYJyKvkJZt2UwS2/X7p1M+7Lte+H7y+jFwe6fOtGNOGuIFyyE2+QpTN4es3YYx5f5Vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9442
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The upcoming CPR support for vhost-vsock defers the full vhost_dev_init()
to .post_load(). On an incoming CPR .realize() only sets up the backend,
so we need a way to tell a fully initialized vhost device from a partially
initialized one.

Add an explicit 'bool initialized' field, set once vhost_dev_init()
succeeds, and cleared only in vhost_dev_cleanup() (by memset(0)). Also add
a public vhost_dev_is_initialized() helper.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         |  2 ++
 include/hw/virtio/vhost.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 56fa4345886..c01ccc800cb 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1834,6 +1834,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
         goto fail;
     }
 
+    hdev->initialized = true;
+
     trace_vhost_dev_init_out(hdev);
 
     return 0;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 8127a9a5a2c..73ea130d7ee 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -109,6 +109,8 @@ struct vhost_dev {
     uint64_t backend_cap;
     /* @started: is the vhost device started? */
     bool started;
+    /* @initialized: has the full vhost_dev_init() completed? */
+    bool initialized;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;
@@ -248,6 +250,18 @@ static inline bool vhost_dev_is_started(struct vhost_dev *hdev)
     return hdev->started;
 }
 
+/**
+ * vhost_dev_is_initialized() - report init status of vhost device
+ * @hdev: common vhost_dev structure
+ *
+ * Return true if the full vhost_dev_init() has completed successfully
+ * (and vhost_dev_cleanup() has not run since).
+ */
+static inline bool vhost_dev_is_initialized(struct vhost_dev *hdev)
+{
+    return hdev->initialized;
+}
+
 static inline int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
 {
     if (!hdev->vhost_ops->vhost_set_vring_enable) {

-- 
2.47.1


