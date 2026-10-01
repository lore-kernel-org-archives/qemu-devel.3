Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B35CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC8C-0005NP-Od; Thu, 01 Oct 2026 04:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC83-0005C2-Fo
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:27:00 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC80-0003Pj-RP
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THgNBgsv1bju8wdBjbaqRepBq63/o2LKxRCGJsVCDgkbEOT1B/dCtjQvTCSI/jqaW6CfAcUrxDAQaX601eY6RTzMycUAYR3fyxd7DfurbTOmpTVAt1SklPSk4owppED50WsBCIvI07/UxR7Ehet+rw/Ukh5XdeJp4BSJMYktd0uqLh1/sC18TUhomx+dr6aMcwyoNtnLstAEB7HFwBqXAD0CwodrWp09pKcv0nGZ9CM6b/t7Ypo/VqZmO55YLAKcOcqP7gUaW4og+yiO9rA+kJTOm/kQTd2xqjWAEu9nglpi3p/v/QpyIg84Gib4T1TtHUTmm6CDZWefZnoQ+G6iwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=IM7mC1XedPa86E3/08CYLH9jmrqRHX26JQI0pP1zYLTEq6UaX7CxsD54jyc+fDWuN3ErRl5wtrZaxnWKOraw9pWrjlxk8BIizSzkEeaozM7DC50ZjGb9MO87pvd62m0m2PUs6C1lkO0/5ssuAcZRer1LUjsBocQeyxdpGL1cvCXkyVM44GpBMwwWTF8e7vuj9/CnGD1BivAltkFQdDwMFiEHVKaYHs8BGK9ZV6pqpahVDAdzQL475vrCCWCngAKln4LS3PYUIHA/6rFBfnV9mCVBDaOdjKaIrpA76ZhZ/k+EHsgUyIRgZY9PmzRq9LbaRxjlrij3FGDY1XjsPOb8/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=Ol6pcjoWB1zunIHrhkTl3e2vxUChm9c8DQ+58EIw89p2ZwbX+VrkYnDySrtLEJUuwQKdcvj/1YIAg2Zoxyo5JY45nPpQRsiPLaHB/9Twyrp6wTinzIeAyYG2XFldsBJqFZTKTEI0uRQKYfSb1zcpGoGB6kDbj09/NIWIzy82rmziV3yQ1TZrO5pJ1piFQvXbVyTYibHaDmQqMx7WjmYM124SwfGirc2H7ZQEywEYUOsbKFrib2YTJiiatlDceImBYyVjTYor5w+No9Qk4M4Jp0ES4nqk60/8e01lHK4+gknmFhAGCvuMoFBgZ2/H4N7A+wO5dYb11h3ngnLwkugaKg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB9261.eurprd08.prod.outlook.com
 (2603:10a6:10:3fa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 08:26:45 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:45 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:07 +0300
Subject: [PATCH v10 07/18] vhost: add vhost_reset_owner op
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-7-8c094843e98b@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fc705d-2e59-45d3-e3db-08df1f95b8f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|10067099003|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: vTmnb4sda6iLlcoUPmKc8kPmZ/beaRn8CJIk/cGjyenxGIX2jICNATdLxtJWVRknrv2Ahqfde3mUZ+BSMNjOA7B0PIuleqsOyeB9MbpT9FijMiaTa2rz9DS+seT8PbOKeLWAoS/bt/84I0hKRbbR65eWcK59T+MGFpJZyN8VssWUxBDSrX0VCDA+3XmcVWn/aDhRn8SmINQH6bpJizcHPp35XsqlXQOLQAy/9iIRQg8aqwhwxxBABuagzPsjby+pSBjtSPMOO2Khohd0i27LQf3E1tkXKJ+s7bYpydW4JOHk5/3tppKF4W6w6vNFUqhohWMLPTE92gDjixZ2y+/4MW2b6gmMx/CccXvOsFcsxpeS5VJvwZM2FNSj0mcedw9fYruzAjP7jK7w609cQdNk8WNjnYALilORlIdbsaeZRk/HMkdL2vQDjc3rA8vJ2I9ggfvqSz5OUFGCPsTgtzGol+LlC2TSLkE5H6sSutPDrYRBGCGBQK9Wgc0jYuPK1+oTsrTjcw+hCPEL1h6XEYT62xMNuH4+LGEvpvM3FLy0L820kLEo/Rlmjw15AkKou3tEle+iEmcEaF5/oZ289xa8mcAZOYr407VTdb2Luw6GTPEul30wzD03Nog9fRZB/GzsgcqidMoODmrtCD6FWq5RNNgsa+rNp6cS/n/Rfhy3nL2qIrcn7rK75h0Z+njI/Ew1nbME1KAe9fLGG+1M+B5EUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnlyazZZUm9QWVFldUJ1OGsva1VvaGRjckhkbTcyUXVBWjlZWlR0eDdBRkw3?=
 =?utf-8?B?RnFWSFNiUlZQUFU4MWFucnlLSGVTRHltYktpOCtZTG5RZENZczNiYTk3aTV6?=
 =?utf-8?B?QVFiQk04NTgydWorT0ZlWHVPTEtXZytvSU5MWmk1UDMzSHB4TVB4c3F1NDZp?=
 =?utf-8?B?WlR2Ui9hazlmVW52S0Z3RlRNVnh0Y2dhV0tqVGt4Y0Q5YSsza3k2bDdUUndz?=
 =?utf-8?B?VGJMbWlsOENkZ3RGMVdIM0ZMSUxtbGZTV2dDNHV0enVHeEJjdk5iUDc1YzEr?=
 =?utf-8?B?bU5tQU5VTU1rZUpjS3BGOENPNW5kRTBMamdzL013NnhxTytsNFRRM0N0OW1J?=
 =?utf-8?B?bHRhUWFPSDAxb3RlMmNiS085U29nUGI4OFJYT0hvZ1FQR1NQQ3NJVk4wa254?=
 =?utf-8?B?Z25Fd0ZWcFh2Ym1oVmpUTlRDOVZCKyt5bE53MnpPODhlU3UwOGNSVjdOZGdK?=
 =?utf-8?B?WW9LM29GSjFzZzA0RGFNbGU0RDYrSURQaEF6QU53aWFITGdhMEk1TUUwNldt?=
 =?utf-8?B?MHFIcWloMlhQcDc5QWswTXhYb0krSDdEUUZWMVMzbDRGMkdQaUE3UXBvVUVB?=
 =?utf-8?B?eUZrRHZhRkpreFk2YkVzUHVKYkxKK3B6VEVLTjJCU2Y4WXAxYU5hV3hnbGFO?=
 =?utf-8?B?d0dEVE1EaHp2Sm5XUlNuaWdTclBjb3FYWmdvTC9VUmZhZ1hOSWdMLytuOS9n?=
 =?utf-8?B?akdyQTd1Ykx2UWtaVDZ0NG5FRVFraEx0ZGJ1ZmE3UEhHMHgwWXltUkJCcUFG?=
 =?utf-8?B?bTFnWTBBQloxT051TXZlNTJlK01CVDFHT3Q5R2NtdlBISEpKRVBrSGUwZTIx?=
 =?utf-8?B?a1EvSUgzSFJPSWljbHE4ZFRyL2Qva0puTVpYdnhQQ1ZNL2o5a3JXdzNYYXl1?=
 =?utf-8?B?MEtaMU00ZzBDVjhJRXh2UDJGMHNzVkRrS3A1OW9SYVRiVjAweDk4ZzJQc2k2?=
 =?utf-8?B?MzhKSmRXQWw5RVArR0RLSGtvYjc2b2QreGMwcVN2bWtXMEFaZU5scU1weW9W?=
 =?utf-8?B?MnJORXYza0t0R3YxNVNCbVAzaHl4Tjl3WUxzVTlhYThBc0tTcExVYnNFRWNu?=
 =?utf-8?B?aTJjZU40S2EzaCtmbW5VMjh3YjVyMHVNMFEydW5pTWtSVnZTeThiaG5hcXhO?=
 =?utf-8?B?bXlzdXNJUUFXR1ZlaGlPWDdNZDhrczdhSTBRcmFCN2EvTEcvcjVlNnR3dC9h?=
 =?utf-8?B?ZUxzcCtxUzBlUHh4L2lVeWlNbFpLZFppOFdvRHh5Q1lKVFA5Z0UySEVzVE5p?=
 =?utf-8?B?WDliT3cyZXZ6NnJ2VUdsQjhkR1hFc2F1cFVDYU4wM25lbWRlV2djVGU5VkVI?=
 =?utf-8?B?Qkh4Tnh0N1FZUkpLZXVHSk5MOU12Mk1mZkhaeGxMekFtc0hweHlMWitqQmN0?=
 =?utf-8?B?aVpEMFNiaDBCTTZGekV5VERJVVB2eHpURUVGbnk3L3FwSXR5K2U1bDVyM1ZB?=
 =?utf-8?B?M3lpclJXdTFQRkdIQnFkZXlva2dkSFB3aXZqRlZzTS9hYUp1YnRjY0RBZk81?=
 =?utf-8?B?TUlOQnZCdm1PT1UrQldFcHlFaG5zbWZnclJaamc4UGVJNDJuMVo4QVhpT2Nr?=
 =?utf-8?B?MmQ2OFl3UG9rTFZxMDRxLy9kenJlc2RmU09xaXZ2dGFTNUxMbWtPQ3FleVVM?=
 =?utf-8?B?bUNvdDVLTytlOWlvc0gyM2x6azRLMTdnNTZYNFQzV1RUaWM4YjJzbzNucmEr?=
 =?utf-8?B?YjNXcURQeTFCVGZWSFdQMGttYzRTam9keVNRR0RCSTJnTnZ3SDJEZFB2aFVo?=
 =?utf-8?B?bW5SZzJwWkxNd3FRcjd4bkFSWGhJOG9EelVRYlE4MG8wQUI4Zzc3UnpNQWUr?=
 =?utf-8?B?U0krRGp4bUlyblN0Yk1FRW5vN1IydmpEc1pQa1VYeTdrT2t0Q0ptVTdYTW1o?=
 =?utf-8?B?UWV5d1RrNWZ0RTJaWGE2TS9BOVpzQkhuQW92dTc3TTBudXQ0U2psNDREa0VF?=
 =?utf-8?B?YUdDYkRiWDNtTThzSFhCaWx5WG5MU2VMTUdBR3BzTEVBN1I4NEYzNXUvMDY5?=
 =?utf-8?B?UjJrZGY2czQ3SXArWlpIZDdnUGMvdlNicCthSUY0bm1uYzBESVNOVTNtbFN3?=
 =?utf-8?B?Nnp5Qk5xdGxnRVc2Q3JmZlhXek1FUmRTbjlDVTE4di9LRklKbTVLM291STA3?=
 =?utf-8?B?d0l6aWx2enlDTU5HZU1CcVBzWG5DdFhuY0c0S25TekU0MFFyaEhZMWRCWG9P?=
 =?utf-8?B?TWZXNXlsR25RSVN6aFh2UEczZE9sbjFZeDRqNUZJREhLcld3eXByeDdxNWhv?=
 =?utf-8?B?eU9PMSttMllRRHhQQ3lNVzlQbWRDS0xJN1R1WDhpcGg1endCUmtCcUhacUJi?=
 =?utf-8?B?Qm5ySTdIYnovNG5ocHArZFJYNWMwSytUcUs4SWw4TWdRbFFZL0tFcFROdEZJ?=
 =?utf-8?Q?qmbqER3VlQtIWVD4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fc705d-2e59-45d3-e3db-08df1f95b8f6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:42.5003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+0FpHmS0MRH6xnTDPeuHy8rFAn4pniiGoPelvSldtp3FCt/2NlAJ1ov4caLjoXcT2L5Y8rgXMuILDhrhDKK/GBGXprAkddvrSJQINEE41I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9261
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

Add a VhostOps callback issuing VHOST_RESET_OWNER, wired up for the kernel
backend.  The CPR (checkpoint-restore) path uses it to release device
ownership on the source so the destination can reclaim it later with
VHOST_SET_OWNER.

Originally-by: Mark Kanda <mark.kanda@oracle.com>
Originally-by: Steve Sistare <steven.sistare@oracle.com>
Originally-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-kernel.c          | 6 ++++++
 include/hw/virtio/vhost-backend.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/hw/virtio/vhost-kernel.c b/hw/virtio/vhost-kernel.c
index 3390b48c6f1..55d316b88e9 100644
--- a/hw/virtio/vhost-kernel.c
+++ b/hw/virtio/vhost-kernel.c
@@ -261,6 +261,11 @@ static int vhost_kernel_set_owner(struct vhost_dev *dev)
     return vhost_kernel_call(dev, VHOST_SET_OWNER, NULL);
 }
 
+static int vhost_kernel_reset_owner(struct vhost_dev *dev)
+{
+    return vhost_kernel_call(dev, VHOST_RESET_OWNER, NULL);
+}
+
 static int vhost_kernel_get_vq_index(struct vhost_dev *dev, int idx)
 {
     assert(idx >= dev->vq_index && idx < dev->vq_index + dev->nvqs);
@@ -385,6 +390,7 @@ const VhostOps kernel_ops = {
         .vhost_get_features_ex = vhost_kernel_get_features,
         .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
+        .vhost_reset_owner = vhost_kernel_reset_owner,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
         .vhost_vsock_set_guest_cid = vhost_kernel_vsock_set_guest_cid,
         .vhost_vsock_set_running = vhost_kernel_vsock_set_running,
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index daa979a1aae..fb580aa417e 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -104,6 +104,7 @@ typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
                                      uint64_t *features);
 typedef int (*vhost_set_backend_cap_op)(struct vhost_dev *dev);
 typedef int (*vhost_set_owner_op)(struct vhost_dev *dev);
+typedef int (*vhost_reset_owner_op)(struct vhost_dev *dev);
 typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
 typedef int (*vhost_set_vring_enable_op)(struct vhost_dev *dev,
@@ -205,6 +206,7 @@ typedef struct VhostOps {
     vhost_get_features_op vhost_get_features;
     vhost_set_backend_cap_op vhost_set_backend_cap;
     vhost_set_owner_op vhost_set_owner;
+    vhost_reset_owner_op vhost_reset_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
     vhost_set_vring_enable_op vhost_set_vring_enable;

-- 
2.47.1


