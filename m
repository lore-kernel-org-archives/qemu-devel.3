Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26087CA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN36-00034d-5g; Wed, 07 Oct 2026 04:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHiz-0006A6-CJ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:50:02 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xEHil-00042F-TX
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:49:37 -0400
Received: from MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) by DBBPR08MB6155.eurprd08.prod.outlook.com
 (2603:10a6:10:1f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 01:08:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgCfL1S6G6j3nXsqRzovxJBa1GhMOH/BlscROY9np7UY006YiO05c7//lFng6hFUVXBbb5R4R4OJAtxVjISjdX4GFs6pFCS6fD+bq58omxHN+f12bVpvdXWJ7uF/BW41rAzQtYk1Q6+sIVEALQshV4x9bjehnocE1dwPCR24jz/Q+Vw2zVdtENj9yx88+yrbsCU8+NkTpTPKxyM/zfRxAr8MInptlgPjSChO6albWsG5BWN+Q6AFGDxeyNcV9XHWlUYxqZ7fE+AcSNHORQCg9ghpyeAkLPTTw+duZKDgj4EISkV1mmvQ2afy3qV6Ucbw1zeXCdjARWvHVyrJISj8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbE34RnEsgNrP/6xdOelQTJXhbgpwqH9Sdjp6AaY4UE=;
 b=N93q8I8hqJqY2E4GXxyd6qAjfCIY+lq4lwUSbHrWCvhOJlHM6a+MEXMz3Gs4+WU2JFEfFsTZhHSu7y2jLtPr+nru+hoz5xEmn/jiIICA0a+gXsvf74ING0s6bXeyy+iAyrZpcME/keZJAAI/rdLRkFWOM14pFn4lEJGb/0VCKaVOoNzlTRA724zRJbq73YgnmZuE73YWAXxbOWOfPEGQ/t5ak+NSrErfpMEXdZk6/brMvqZ5FNn8S9bZwwE/ACr00yP4ttYnhxGjccH/G99h2c5UwjftU3ZJeKHcz38p7iZD6N0PvEcW7Zb2/tOJQNAWsBh7DAjMJr/HQY3UcVbu/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbE34RnEsgNrP/6xdOelQTJXhbgpwqH9Sdjp6AaY4UE=;
 b=dM9hcuimPLgp1F9tgxHClYeaYYiieXX6jOlD7GaDXS8+lpSN+2ZK36//B5W7JoW94ybu3BaOOiUN0F5AaAPETM7qqeRZaJOLmcUZ2w49vQnQKRe0BEZNuAkIO60amjo02Y+4YikZFsQMv2xU72hdOZpani/18C+jjwle8xCkSQ0lgjWmtiHZ6n89cy74kCwJ4WGRARsVe/5v+mGfrRr7FLJwbQl2J2FN2paZDfluctncY/63pt7873fa9PAxUGG4SbMqFPbFO/trxDUHnsxMvClc2ewY45TTIIaFSHCbT82at6aWX2Rh2lZRTR11q14dMFvlheLbt/YV38yVqsrxwQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB285920.eurprd08.prod.outlook.com
 (2603:10a6:290:aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:59:00 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Tue, 6 Oct 2026
 13:59:00 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Tue, 06 Oct 2026 16:58:40 +0300
Subject: [PATCH v13 17/22] vhost: release ownership when the incoming
 migration fails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-up-vsock-vhost-v5-v13-17-2ea78fd1b7ed@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 928275cb-2160-43d1-d83d-08df23b1f8b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|7416014|23010399003|38350700014|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DvCBUHfy5IAyVA4PfWsNvPmxFbOJmPGB64cKLXhDUIukY6Awi1ON/M0fvYASOvQ9O/2E+ixU/h/ehg9+1Sd+D8x5xumsJOD9rgBVSP7ZpkgBTXoDc9Giy78Lzo9Vj+T/MPHgDgR8qirnXTus3WtOD5rdQsWKR2fcYnMyjs4ktRY3wsYsBnMFgIQo09JiTcOLdA5SBzbR2sIHIUSBc/dw0HpcOWENjVrrCI2/H6l0GVBEuODcFF3vSW9E0YATe0hYPJ++Bt/eQ4OPDGopXksg83s/gAH85gZn5lRjg9mpAJZv5otrgg8oCZlzvxexTzkR0AEiqlO27LmUjRa4r5MJ+VjjRBS3hPVp/uX/iJsQqtFGjvWLcJIb6BjMyBCdPJu1fyDPk+qz5u4YN5pxJ9AU45BiodsVaQYJX1sIMuiCggY+44ccafXU/LTYU5s55jJb13lupgS5uwAtvNKEHkBA7RyH4WSpPa7/+fxpClWIcRGFaCawdhCsyBl4uBjNeF5kTua07Fa3JuOG/63wKMJwSV0MJ6LmsuaxzpSFc4JbUxBHLEGn9BFn1UzgHo+wc5U7yMnkpjTIK6us6MwFILMRemMQDm9F65s7CSHviXyYsZYBTfjbD6Vxr/0iLEDuECP7MHLPtic599aXEM59BLGZ0k7h44o8DJd4WuuX8xrSeQdje7umXKz8Cut78yG6H0Gk5uJwHQqja2yUDQ5Llvv2S2yCXO7ZOLSzkG22+lZ1Y4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(23010399003)(38350700014)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0xWaGhoRG5jMmwxMG9GMjd0MnBtdUptWm92dkxwM3hBTFdib2R3OUs5aVNn?=
 =?utf-8?B?bHMyaWlZVFFpVEs5K2thYStlTUFUcmIzbHZBLzhGbU9tbnBxY1JJNkptakFp?=
 =?utf-8?B?enpYdE1kbllGZUplVGFzQ0dzUUl5NWdLZEttNmNoY2JYNnNKWTFSQXpaWjJM?=
 =?utf-8?B?Z1JjRG1JZlYvemYyMFgzN1IwMDJLUnFPZGVLSjdUS3BlUEk5MzVtWXhQcmV1?=
 =?utf-8?B?MFBXU3RMZmF0cjlxcXRFY1BkaGZXVkhEOGZRY1pYME5RNUlpMWNTSGd4TVkz?=
 =?utf-8?B?UEQ0N3hZMTlwMGtCb2QwS2xwOTNQc0o3SjZwbnRUS0QxZ2xvdnJJMTlLSmlR?=
 =?utf-8?B?SkJrTnc3YzZSbkRYbTcrS3VSZmlIVjVnQnoycGNLTmM0UXl5L3pQYTFVaUJ1?=
 =?utf-8?B?Rk5PamM0VnRxaHFEN1hnSFpJcTd4WnJ0MVJwdy9tUTBCNE96TWxxZmxJTDVF?=
 =?utf-8?B?STFUVGdGV2VoZm1JYXl2d01IMXpZYkVuU3BwOEFYSnlRRnRJUEdJSEhvYVNS?=
 =?utf-8?B?RHNNUkFhS05HL3dxVDd2STJ2Q3dSNFBkZVFKTzcxZlZaOXo0aW9tVjRuMzZ4?=
 =?utf-8?B?NzBIb2Z6VjBkWHgwM3FsMVY0YktEZ1NLdVIxT3g5U2JBR3AvRVJpdFFwZDFo?=
 =?utf-8?B?c3NGVjA0OVZsU2dQUGJEUzgvTmNNMTNQS2lmeUtMVG90QmZBaGxuSmVoeHp5?=
 =?utf-8?B?LzUxRk1BUCtKSkh3bGdlSVkyWkxnY3l2VnVONE9SMkROL1Z1NS9LUmVxRlFL?=
 =?utf-8?B?VHBmQVJUUm8wWHlEc1FXSTg4UXNCMEdBMXpPRlBOamtkMUNyVEJ0VWVEa3lO?=
 =?utf-8?B?dEhHVkJnQSt5WTJuWXFqbDFvTGZidFRUVFJObVVDWjdvQk1tVHoxNUc0b0RO?=
 =?utf-8?B?N3lVYjJ5UnY0UklwMXZLbnc0U0ZZcXZ3NGVGbjNMNnJJeXQ1NFB6WjZ3dXQ2?=
 =?utf-8?B?ZU1aejdSelVVUCtSc3c3dk5KQzFqYW8wQXVRZUtvSlhPQjVubHN6WjE3Vm5R?=
 =?utf-8?B?a0xjZ2dKSnhYaHFUS0RvNnljVnBxMUc2ZXVGclBJeVlkbC8zQ2paVTZBdmha?=
 =?utf-8?B?NjdlWVFmRWI3UW9BdklySEtvL3FmMmg0KzEvMVozWUFBQlNVQ0I0cXhnaXBK?=
 =?utf-8?B?VytGa0cyNmhyeERLN09hdDFsNlJGK01GTmgxWjNqRzNTU1NTWElxeHBtbnBk?=
 =?utf-8?B?YzQ3dFJSWHc3TzdLMnVTaVFHL25aMzlMZ24xbHhydmFyWUJKOGVubnp2aHdR?=
 =?utf-8?B?NlhHTWxTd0dsalBwc3hTV2wyY01mcmQvNy9GbnBNUWIyTEJ3N09KdmhpRVl5?=
 =?utf-8?B?OHJiVkFUWEJpYTBscHVNaUY3V3lXVzVWbG5zekNhYURESUhKd2lsRDBleCtr?=
 =?utf-8?B?U3VVeU51STBTSVNjWDgrL202djZmS1lRbGRZY3pXaHlFeThGUmVGOEttcHUv?=
 =?utf-8?B?NXMrWVF4TVN2QkVmRXY4ejg1K3BoZmFKREFEZzFrczhGc1NTTURhRExveWdX?=
 =?utf-8?B?MHhXQWdFQnJLSUhRZW4rOUdmdmd2QmRoekRYT1FENkF3dVZ1dU9CNlB6SVZV?=
 =?utf-8?B?ZlBJQ2k5L2YrRkZteDl1YnlSVnA2Z3l4S3pBTnMySGlvVVA0bWZxbXpqNGZu?=
 =?utf-8?B?aytTTjRIYTA0UlB4UjQ5QVBOdEpySVpTME1GWlV1SGlCblJCQmRvNGpNS1NZ?=
 =?utf-8?B?TzlVT211NGVwUFh1ZVBidkc5bW5tYVQvY2RCZW0vdmZUQWxodkRwVTY0YVdh?=
 =?utf-8?B?TXYvekROWEFvcFVSNTRHd3l4RlEyb3oxeDhWWEtlS0Y1d213RHVwWW0xVG9U?=
 =?utf-8?B?RUxJeWhUeDlMTEJROEhnK0xFaXk5YkJoTWFjbDRaMk0ydWNNY01kQlVBKzVY?=
 =?utf-8?B?Q24xem5NcXVnWnovOHJuMVZNSCt2djFpclYyQXVXdXA3OG03VE9BcmhLVW40?=
 =?utf-8?B?RkZ5VEdRT2FMUmFsNHhDd2RIV29kdDBYM2JwQ09sNDRwUXMxTDVVcTRIZld4?=
 =?utf-8?B?TEt0OHI4OTdBcDI1ZnBGZjZMZCt4eDlER0J5Sm04S2txNEVQY09aVy9LZmgv?=
 =?utf-8?B?YWNMbUt5L2NYQTdvby9YZGkzWmR5Zkt2b3JYMmtWY3VGMzdxNlc5bis0a1ZO?=
 =?utf-8?B?RGtaY2l0WXU3Z1JTREtGU0dkYVh5SFlZaXBJNThLbHprT3l4aWpJYlMyRm5O?=
 =?utf-8?B?dTNBQ3ZzbDZnWmltdkd4ZFVZbXNVMWJDWUlTSnVxUHpOUEpwejVDSXpHcU82?=
 =?utf-8?B?SnVKcjJKS1hlVy9acUpWZ2E5Q1IvbGRwTWtVM25OaldPN2Eyd3hyK1hjbUpv?=
 =?utf-8?B?aXFBc1VhYjNaQ2ZBSGVRK1BGOXdpeDJ6bWpJYk96eG1FamE5cFoxWFF6ZUJE?=
 =?utf-8?Q?QoJR9junHqbNR2fw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 928275cb-2160-43d1-d83d-08df23b1f8b3
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:59:00.0103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giRELbYsjELHS1hWvEl5njbn7UE/ldmIhJukc774ivF1bj7yQ/eZAKDwjE0yzNkWEjIalW8yqojOJ5IiAgdvVjXRIC57/QOd0/YSLyKIt1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB285920
X-OriginatorOrg: virtuozzo.com
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

A CPR target that has taken the device ownership in post_load() doesn't
always reach vhost_dev_cleanup(): a subsequent load error, e.g. a
truncated migration stream footer, makes QEMU exit() right away, and the
ownership stays with the dead process.  The source still holds the FD,
so the kernel never releases the device, and the source can't take it
back after being resumed -> SET_OWNER fails with EBUSY.

The exit notifier is not good enough here, since in case 'return-path'
capability is enabled, the target reports the failure to the source before
exiting.  In this case the source resumes right away and is racing with the
target's exit() for the ownership.

Add an incoming migration failure notifier to each vhost_dev, registered
for its lifetime, that releases the ownership if still held.  It runs
before the failure is reported to the source and before the target
exits.  A target killed with SIGKILL or crashing still leaves the device
unrecoverable.

Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost.c         | 24 ++++++++++++++++++++++++
 include/hw/virtio/vhost.h |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1241c5a954d..86e9a234638 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -26,6 +26,7 @@
 #include "hw/virtio/vhost-user.h"
 #include "hw/mem/memory-device.h"
 #include "migration/blocker.h"
+#include "migration/misc.h"
 #include "migration/qemu-file-types.h"
 #include "system/dma.h"
 #include "system/memory.h"
@@ -53,6 +54,22 @@ static QLIST_HEAD(, vhost_dev) vhost_log_devs[VHOST_BACKEND_TYPE_MAX];
 static QLIST_HEAD(, vhost_dev) vhost_devices =
     QLIST_HEAD_INITIALIZER(vhost_devices);
 
+/*
+ * A CPR target takes the device ownership in post_load().  If the load
+ * fails afterwards, release it before the target dies or before the source
+ * learns about the failure and resumes, so that the source can take the
+ * device back.
+ */
+static void vhost_incoming_failure_notify(Notifier *notifier, void *data)
+{
+    struct vhost_dev *hdev = container_of(notifier, struct vhost_dev,
+                                          incoming_failure_notifier);
+
+    if (hdev->owner) {
+        vhost_dev_reset_owner(hdev);
+    }
+}
+
 unsigned int vhost_get_max_memslots(void)
 {
     unsigned int max = UINT_MAX;
@@ -1823,6 +1840,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
     hdev->log_enabled = false;
     hdev->started = false;
     memory_listener_register(&hdev->memory_listener, &address_space_memory);
+    hdev->incoming_failure_notifier.notify = vhost_incoming_failure_notify;
+    migration_incoming_add_failure_notifier(&hdev->incoming_failure_notifier);
     QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
 
     /*
@@ -1872,6 +1891,11 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
         memory_listener_unregister(&hdev->memory_listener);
         QLIST_REMOVE(hdev, entry);
     }
+    if (hdev->incoming_failure_notifier.notify) {
+        migration_incoming_remove_failure_notifier(
+            &hdev->incoming_failure_notifier);
+        hdev->incoming_failure_notifier.notify = NULL;
+    }
     migrate_del_blocker(&hdev->migration_blocker);
     g_free(hdev->mem);
     g_free(hdev->mem_sections);
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index f6e32b59ab2..6df012859a6 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -3,6 +3,7 @@
 
 #include "net/vhost_net.h"
 #include "hw/virtio/vhost-backend.h"
+#include "qemu/notify.h"
 #include "hw/virtio/virtio.h"
 #include "system/memory.h"
 
@@ -116,6 +117,11 @@ struct vhost_dev {
      * Updated only by vhost_dev_set_owner()/vhost_dev_reset_owner()
      */
     bool owner;
+    /*
+     * @incoming_failure_notifier: releases the ownership when an incoming
+     * migration fails, vhost_incoming_failure_notify()
+     */
+    Notifier incoming_failure_notifier;
     bool log_enabled;
     uint64_t log_size;
     Error *migration_blocker;

-- 
2.47.1


