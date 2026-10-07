Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F04CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENwT-00040N-Gp; Wed, 07 Oct 2026 05:28:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENC9-0001Dy-D2
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:23 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xENC6-0006sq-7P
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:40:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct01kFoBzBgxjX8kA4ob71l86CvssqaFAPrVPUqd4PSg4rRBSOL63eGikievWgiS4pKn61g4NdpIjyUHQJ1W3l0Z4Jc0q0rJaMasfTNiQc0G8xrLcYK2WP4HaETf4XUbINZiHGsjlTFiV1nLxZvGFeDtF7g550CfmrPMQ54AvCtYrGeC32DpaSLWHE6UO1OZQfX+ScHA0ruHFdf8qiwEigsOLyNyHaXr9Tmg1RLLlqUn9Dp76VZolSHBfsiJ5jCPE7u2e/HueKdkijI4G2cjwZ+NvKjE0vMxbOBNdR0ke+DdRnZhQLTWZjJXEkY9/vgubmDRi+kZWUP2msc0yWRJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=q7xBMkYGipmL27ZqRFh2AgAzzDvWIEZYq+R90bSWmZ8TDXfhL6lwqcUSqdHFqFnMNxQFTRTynBh+vtIKLzNO2lF6OlV/9XSZQAyxgF3zkn43BY3YdaPqYE3flScx53VJw6y2WDYLcKrTO6+w13Is09rGW30HJcWs3S9w10pUEzzArtp2bDrHC2NIvdIlemAHlb9bCR4m95iB7Qi6uWP8ippFLNkeBYgzkB7p73XoFmiWHDeC7eMDsqRbD5orzkcGgJhZoaYF/3ZScrD3ZvdQ2UV+PRW7captrTPEEpXBTR9HIEZqieK1kZjQueQlmaSFfTYJ6Qdt4Lb1tHFfbuJ+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFLHrTXYn30DKBGfZX9XawwQGNuxnOEL0tX4YglZD1Y=;
 b=yl7KACQiZmhufWZjAEvno3ryF9NdcXFY9ayIXhJEfLkHz5IfDEE5omkP7YXq7LROajn685fNYDq1wympQtpUJKjdvYozKiyziIQiECvNWlJPCDULvh0PqT5mwjBaAub3A+FgAel0njxxhgeX+avYy0NHeIR4cX7pMDKnl9hV/8nchSH/ga3SHGwUeQsI+HkkGhm5QyuBqLCDVGw0Dsrznbqr0LvRGYlZFWIg/fpjDMYXVOdw9sVhLDsKLXjQ0GtCtiEhB0DOZv/eKFwtk9KQRo+b7sF7AI/fdEFIM6t6rN+GhYqohnTKVs8IrM406IYfQ9w7JXgCx9kYVyWJ+MFhfQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB9058.eurprd08.prod.outlook.com
 (2603:10a6:10:430::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:40:04 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:40:04 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 07 Oct 2026 11:40:02 +0300
Subject: [PATCH v14 09/22] vhost-vsock: fix FD leak in realize()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-up-vsock-vhost-v5-v14-9-e16de9962df0@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 14307164-b62e-4ec1-cf99-08df244e9501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|376014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: YPMXZFg4bYbw87aCKeIFIhc7SNdcdABYGgBiKqhYbXfeRP1LgVUrHLXRf2BGKdCphI7KbjmIxiUBqyPXkLHlrXMo/oHXVF1C6pfUHpg2LBwyJdT7l2qmgr6kFUlo29trNb4UzPuk3cCCL1aB+L4ZtuhpbY0hbQ1uV+dd3TR+QBIvEMgJfbck5kWqJ/NXzd/x54uJ4A1BQHAe4M6hV4P5k3LQLo4KBeNpOiqQWbmudI48rYBC8nZDMwskv8G3mbi9A2okVQ/eHktStB0hlWvy2CS78kQRQyizUT4VtGNTq7ByHAmcMZHypEnlznMgT8AhdQgmZf2a7oyFEG2KbaGA81UmQVUueDE2U4s39JiJBs+ck30LkzztUbWhEAhEHHbohRBhXvYPF2MuwvjbQUx4KOwQE4c7ARk7gKKTzOrXJlk84GqSK/rFhr00Ot7CfZh370elAR9A0DgaQ1ytDILVCtKwLC3FqapnRjNvO732uPWQDm1PuVXuNiTOtqIwHhUv5jru0ggQDsuV63R3XTO24zWCx2LbzCvfZICTdwtz6poGsRPuens1ta9u/0Ua1J29DM9ADJfQ4GM0MXDLTgT6gZxTYeJ1zKBZ3FJn3T6/JZ3rtBa6lIb9uD/TdWjHJutgksAy7Dw9DzvqkutqXBWYmU4jI63dlVLkEUyKEBFsp332iUnmmTX0Q6YqYd8ixX73K/+/cXf2wv0RawavCFQxn/yEOE+q2IANAd/TNUEwmD8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGduUE9oVk5XNklRdDVxTklpSUorQ24xbHJvZy8vTXdUS3VpZVQ4THJFdjFh?=
 =?utf-8?B?eWhQaTdPaFVPNlk2NDRvZFBMVVJMSE4veUdtSkJTNGtibEtRWWpjOUpiUlR2?=
 =?utf-8?B?L3hZK0Q1cS85WEhOQjdSaVo1Uk56QmppREZGTHJqUjlTN203dnVGUjZxNmZL?=
 =?utf-8?B?citja1ZuMzR5b2hOeWpqbzFnOHhONktZQ01Vd28ybmJrUVVJSkQvTEhCbk5s?=
 =?utf-8?B?QWVZcVFTLzhtTE1JYTlDMEcwL3pDc0N3YVQwaFVta0w0Wm9weWpHdFBTZEVY?=
 =?utf-8?B?QWVwakVOeDZ0QnRoOXYzVWxHRmtKTE9kMVRBQU9Vd2U2dFg3dHpJdW92NjNS?=
 =?utf-8?B?RktuZndIazVFRnhJM2FsSU5lazRhRk9ZckdSaHFReWhaT3RLUWJvMy9aVTFu?=
 =?utf-8?B?ZFBWNFlZR2hSV2VmUjk5QTV2YmE2WlZmUlFHVndtUVhCSjM5SStxNlh1VFVS?=
 =?utf-8?B?UzJVb080R3NFaUY3RDBhMnk4VVF1NzNwV29LRWt0c2tnNE1TNlRhZmtIcGJY?=
 =?utf-8?B?bUFEejRwcjdSTVhLZ1FoWjVVM0VBQW9GV25GcWdCamlYY0dkbWpQNVBYNVNP?=
 =?utf-8?B?NFV4QnozYUxvZlhnbjhkdGhRcXFwWmNwUUlYYjFXUW10N0krNk16Y0REMWhS?=
 =?utf-8?B?VGNuUWpQeTJLeWpaMU16S3NDYzBhc2VSNmZmOVJJNnBuVUx6NjVWb0d6NGcy?=
 =?utf-8?B?MTRYN3Izck14ZkVla212M0VjTmZmZWNnamRKcTNmZ3BnS2hLTHRjbGduWUVl?=
 =?utf-8?B?SW8vT241ZGpRV2lLSnZQQ2RQSjdXbGJBVXducEJ4OFRZK2FNZTQxMTFzTnN3?=
 =?utf-8?B?SjZacEhZUFhjalE2TnQ1UDllMGpna2IySllRQkdMd0NRTWlIVG5tdmNMVmV0?=
 =?utf-8?B?bjRRemhLV2xpQTJ6RzY5a2o3MVRlbkViTjhlSWJ4TDJNS3gyQ2EzL1ZObW1G?=
 =?utf-8?B?Wnd6NUxUZklvaUNLUmJJM1pjWTdrN1Fmd2N0K1VLbS8xNGdEeWpNMm1KMHha?=
 =?utf-8?B?ajRmRHJHNG5ObHN0WEZQdDUyOVZlNmt2MFQ1QVluQmpCV3J3MXQva24xUURK?=
 =?utf-8?B?UWVhZHhrNHVqdWR1Sk9aaStTdmxIZ05KcVBoNmNlb1doajBVNngzdUI0Njha?=
 =?utf-8?B?NzFQREp0VnF3RzVaZzU2aUhESC9yMSsvSkduSlRIUThoRVlGSXl4YVk1NGRR?=
 =?utf-8?B?NVhyZmw0TCtYSjNNa25QOXNhaVdVK29hSXBnWnhnOWVIbTBHcXVOcytxNjBQ?=
 =?utf-8?B?Y1VZbFRrSDBZVlNMeWxTUmRBbDJyZUpJbURJay9vM002YTJVakUwY1pmNFNZ?=
 =?utf-8?B?NEZ4TGswL2s3ekMwa0dGT3lpRUlab0lxOEdSWGw5SnFPNm4rZmdxblBwVGJy?=
 =?utf-8?B?dnZCbVphcWpVMDRFZWxraUdUeStidUJ4RnRicU9zYVU2azRqK2hZWTdHU3FS?=
 =?utf-8?B?NFA4ZGF5QXdYOTNNdVY1R0JzeTEvMGwveGZ1Y1RwaTdEbmtlZEZmMDZtK1E1?=
 =?utf-8?B?SmoxRmsrbUpjSU5Sb3BzNmhqcWdBbUk1bGFoazNSdU1Sb1JDRE1BTFhDTTNM?=
 =?utf-8?B?em9vUi8wc0tRRmx0MHFkall5SzM3TUVwWmkybTUvUmF2Zytua3o2aXJVbWw4?=
 =?utf-8?B?LzVtN0d6K1U0MWRzQmlUN1gvTGRlOGJwN1VOZzJPOU5qYkUvVHNyS0srM1Fa?=
 =?utf-8?B?RjBHTUZGRzBCN1cxaEJDM2phclh6TkR1eFN0YWpNS0Y2amFTeVhjMWxqbWJl?=
 =?utf-8?B?dGJoSVhEVEJiQnNkWVg3WGd2a2sxbVV4RTFhTmZSZUgwVjZMOUdEY1RCWUZx?=
 =?utf-8?B?LzJBbFovdllKVEQ2RTFiMm5ibUtLZ1B3NGRwOGt6Q2xzMGZyaXBBaWZMVytn?=
 =?utf-8?B?VWNOL2pBMWUvM212T0ovVkdWV0hTS0xYQ1pqbjNKUkR5UE1oblg5QTF1cGxG?=
 =?utf-8?B?WUVVZmIydDl3cmZoTXJVc0pLY0NFY3VUeEhKWWtFa1dpbkJRcERMTi9MY1Zn?=
 =?utf-8?B?ODBEYmRCMy9kd3BkUkgxcWVzMnJUYWUyZTNMbjhiQzNOTXVxVHNjc2NSakJY?=
 =?utf-8?B?aUxYZHBBNkdkbEx1SndNZFZ4MkxpTkdCZG0xNDZjNnlIK3BPS1NkZlB2bWFO?=
 =?utf-8?B?WXFac2h2MFlOZWxORmhadTZLWThiL1ZqekFwb3BuNXVzT2hKS0xsRXdiTGhn?=
 =?utf-8?B?bzJ0WEV2Y015Qml5R2Z4MFRmYitLK3dYeUFUcTR0LzB4dU5TNHg4SVg5bElh?=
 =?utf-8?B?ZEVsM3p6TTZiL1F0QWl6TitKQUIwQ0FLalFNelJIeTlHREY4UCtlTmppQmhG?=
 =?utf-8?B?SWhFaVQvU1Q0aFNoYURXZVIrdHAxWjE1TzBkUEw2TXVVS0s0TkNTNjZMWG5G?=
 =?utf-8?Q?SRbYnSgFGpZhwt3Q=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14307164-b62e-4ec1-cf99-08df244e9501
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 08:40:03.6854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOTXc5n9dsu/liER6bNZAGVhot5J9OaHgXr6IftDiy9bIFXa6cPg4/Z2kv0UQHiBpQthkglDZ6tZSfFe3/KAqE6cbjKlMeUgFNlzHiBMVUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9058
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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

In vhost_vsock_device_realize(), after unsuccessful call to
qemu_set_blocking(vhostfd, false), vhostfd gets leaked.  Let's close it
explicitly in this case.  CPR-saved FDs don't get automatically closed,
thus it is safe both for vhostfd obtained from cpr_find_fd() and from
open(/dev/vhost-vsock).

Fixes: 384c2561bddf ("vhost-vsock: set vhostfd to non-blocking mode")
Fixes: 701544cfaf46 ("hw: replace qemu_set_nonblock()")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index c582ac9fcc8..3ec20d87606 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -176,20 +176,17 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             goto err_blocker;
         }
-
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
             goto err_blocker;
         }
+    }
 
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            goto err_blocker;
-        }
+    if (!qemu_set_blocking(vhostfd, false, errp)) {
+        close(vhostfd);
+        goto err_blocker;
     }
 
     vhost_vsock_common_realize(vdev);

-- 
2.47.1


