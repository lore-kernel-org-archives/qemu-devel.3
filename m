Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E73CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkC5-0008GO-9e; Mon, 05 Oct 2026 11:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC3-0008FN-4S
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:31 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkC0-00058M-JX
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+RJK5hp4FHViYd7GsgS5Q9d5UdsSyOSHDS4ip5Lo93cMe3mcPtFQTfhonv9w5sqRKNYi9Gj6QISOBDtHcukMyj985jueBnehVSLNiSIZsZ3MDJ85H42SVz/5LaCxGqbAXi3NSNBQhk5CKdD/qJ5qycUIuelq0Kq2p10fC0+Z8jFUxXnTzumuhKItA3eWWllgLjl5Ck/+MrRYuHKSggZssgWIBujYXtrByNWVEmsk/merxbD7NL5wUz4B2wRuZSZzTu62QJeZYTwdHgFlWGiOCE61Arm2DcTluSba3abJ+C3UHVflH7JoHXt8k2oI+S/OqCo9VRiwuMwiDD10SwCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=asLxkapQPmsJyNZTFurVHVrVaUBtCjH2tCmGseIyCvl26mCuk1jb6TY7BafBdyzev9LF3AvnlCJTn7nDjfuUmNh/NmGlbravAbOa/Qhl6zPjZYa9x3U58BuORyJKXziDLBacMSazgVclNcpy3EM2UAfLsOw8oXZvZSGqAE9fGFPdUV/4UbPk0HCOLb/Dkkz4ovZ1fej4Dn/AbPWLmYOvnyfM4ZitiWKS5NBjGKMVYImZJJeOOnSAjMjmenWTdlbi62sGlYRytchLrO/BQfkQMcmKqyR1EXw6gGS2miEStOY2ewdPUTDGj5H5d1g9xKvsxNzikC9NEVahen2c/a0Hew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI2kEvdyqWo2h3cBz00/awDb1Cv0bW/IrdoDs7geeFM=;
 b=eilOM8qMmAfu9+mYJDk2n2g4/yZX6wITZBAyosRHLGNB9EymYn5A+eEygSJaTffyibZnBw8rCZ/TGGCv4zqa7oXwdN+shECCrJYf9F38af/KeIhb0BGdedlmE8EmIwfNQ3rg05NVdRq4cIWdZuK187wtMhNGj9ePs2u8g65LNaPwqDzJ4s0Z6vbt7gFZQrMxW8ogvj/0dL9SGgR9jD7h/Lig7L3bAZqh+yBqgItkETonI6UD16kgQy1ZpkEQzQ874yzAxRHZzWBB5ECdqvM/+8B/gy+cWRExuHXsNaNy1gF7jTXY5AmDk5fdZ9GWrg3BcR9Gg9YnNrZDVm/YTyC15w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:15 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:15 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:46 +0300
Subject: [PATCH v12 07/21] vhost: add vhost_reset_owner op
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-7-40162390c68a@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e90a9127-401e-40f8-4e0f-08df22f180b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oz6TZMxcIVFNd434jnVFtOsT0S4x4lKMwWFlRdDwcjPsF2J/VI4d9pK4uvmLu0yuJo/mVkh/4om5vphCtUktMFAxpBhMqNxPgBpiQ3T1oIWGyLFOAgfkSif5fT3NfSh7rkdJXm6vDg9HVyEaUMwiQ9OG5m9+d+KUrMo7JP6ZJZYF4gXTq23Ts4TxFJfNAnqoaAZO8ZXcL82yqV33GtrtTYlCyR4UzB2QIRyWAmA45GjdSyXqT7kuhtrNp+IrRi0eWwJdFB6yQXTuOWzoKOJ0ypjN+7aFBX+Vr3uNK3uwHH99tcv9eumRfM9k9l2q0+OGnTgK+k2tiYx8xT3XZVQ5qoE9CZIqLRObBO9mPfvFCZ7rdYElFuoFtAfCBc76cOe3fNk/LHq6gX7rgGOCckIsw/+f8A7sy70Ed1OOws6mM7Z7wFvi7hZy1TcbBBVXuv5VGX2Jq3lDMq3J6E4F2+h3nDN0PnBNu21f9LfSyHZLsy5HfQplME0is+FbiL0yXEi2sjAIPTfftDhOsekQWhVzs5DMEA6ToBRCTfn15xDEZk6CeDL4VHwXsEQlRhQddHVZrN01Y1XF9YvIspLvugjaOEawrtt2K9DmM2GWE+pRkeoVK2Ygsb43XasXCjqziSrY/x/z1hcjSQwLST3MbbJqqy4BnUca4siBQmXlNaPxx6xvqJc2RcWL90D7p9oXwQJuxMv0/dkpJXAXsvF2Rer1FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0t6bzdQNWtRSXpKb1ZTYjJkWHlzWVNlNU84VHJjd1I2b2wwenRkM2tac3pr?=
 =?utf-8?B?YzZlWmsrVG00Z2l2Q0NCR0gwODBMVWZGNDFXUytrREF2N1RRZjZLK3pmNXdw?=
 =?utf-8?B?U1duZDNnZjNlSHBDZnplbGVTS2M2SzV1T3J2YUtrY0JKZTRJVGwzTnR0bTMw?=
 =?utf-8?B?UFd4bC9sLzNQRVE5QTdOV2JMTUtuVnYxNjl5TmhnR3ZrYjZuOEE5QWpsRzd2?=
 =?utf-8?B?eUVUL2lhZDl5NENMT3FVeXNXMWZjOERMQ1BURTgxQ1NoZ2hwZ3FHV1ZDNERX?=
 =?utf-8?B?YkJmRWFac29jZlBaOVcrbW82azZ2aGR3NFBxTlBrR2VwM0JiZDVLQVlYemlL?=
 =?utf-8?B?SG1qdmN6QmxrVXIwY0t3ejBvYUUzMFBjVmY5azB3a2w4S3hMRU1UV1dWZC80?=
 =?utf-8?B?SDFldEtHcmY2ZitUbDZoMThLNWIybDJncThGZFdOSVBla0ZlVXNZc1lpRHRw?=
 =?utf-8?B?NzNiUFlrMUpoWUtheFI1dGowTmR1OW9tck9BOXd2ajVOWTY3V2xoa1Jxc0tV?=
 =?utf-8?B?bURBWU83OWpSNzltTU1ISEJvaE5VMlo2ZG9ha0txdUcvK0hqdDY5V1B2QXJZ?=
 =?utf-8?B?R3plSFYxeDNmVm9ZTGthMDIwWDR2N2h4a1prcTFVaHJiZ1Z5am5PNFlmRkkv?=
 =?utf-8?B?a2xuNnkvdlptMnlBVWROekoreDdrMkVhNVFaY3lwUWFVU0VYVTBVVW43dks1?=
 =?utf-8?B?Nlc4c0R0QWZ4ZS9ObnJGK3VxMUxZWGJDQVBwa2xzZlZBdVozQmxtbmpENGV0?=
 =?utf-8?B?UmZoR3d2N2ZIUVZtZmM4L2dkUjkvQXRxQTVZZGxodFVSTHFraGlxaG5yMXV0?=
 =?utf-8?B?cUdUZkdTMzRUWGh5aHI3WG56WHdXWTFpMXRsZURlVmY0cXA4QmdudmwvdmxE?=
 =?utf-8?B?RmtrVjN2NUxTQlovZWpEVTk5Mm1VUzJyU3Zxc2E2a0FKY1NaT2lkUFk2SXVI?=
 =?utf-8?B?Y2c0NFlCYm92cmxUa3pSNDhuRGNCK3d3SDE5Mzk2NE51WENTT1hLSWl0SjFj?=
 =?utf-8?B?K0cvM3BWRndJK3R4NkJKRW9wdzFxbHdBUno4SkloNENENFBDcnI0TW5hY3BE?=
 =?utf-8?B?RStOeXpMendtUmVZcXpLSHVMU28zL3ArL09VMy9UcEZldGl4TlBzeTIxRUVa?=
 =?utf-8?B?QzZrOEZIOWJIbGd6Vm82dTZNZmNoTFJJUmE1OG5jOUtIdkFBR09xcEgzVDYy?=
 =?utf-8?B?OHlxNXoxUU5VYjBpZWp1TEdkYm5McU9pb1UyRS9STElWMnQxQnY1M1lmUkd6?=
 =?utf-8?B?cU9UTk1nRGtPUk5nc1NuSktLYU1TQWRHL3laSjczdmtWWkpXTlcwMXdjVVdE?=
 =?utf-8?B?Q1BCYmFPaTdTcUMybXZkSTVTYkZXT08wcE8zRXJoOGtPbEcyRGQ4aVIwNnZ2?=
 =?utf-8?B?U0hiZ21aOU92b1hEZCtXS2VMTVlIUGxpSW1Yb0p3RWljZVhESUsyeHZubUpB?=
 =?utf-8?B?OTE3a0UrQTduTllkTXhOblRUdXdQamFPdTdnSk5DNFJmOFhiRXRlM3JvS05G?=
 =?utf-8?B?VFdSSjI0dFZPSkoyN0hNUnRPTE9aWUpDNUl1eWovRmhEcVFEeWgzeEJjM3Vl?=
 =?utf-8?B?YUovRGJlaGpMcVdoZy9wTnV1VEFabFRFVE9ybERJUFFzWWVCU1NwNS80dVZE?=
 =?utf-8?B?QkhRMnR2SWVrRlNCU2FBblk1aEg2UzU4MitYaXovYnNxTFNNTDh5SkRLajcz?=
 =?utf-8?B?eVp5RDNmZDMrTGcrQlV1RWg0VlhtVGVXaHZjT05pQzJwRE8xSllvejZNVkdM?=
 =?utf-8?B?T3hNMFN5TE4zdDloczdXMER6L0pJenRHcWx1Q3lQV2ZVeXlzMFE5MFVyM3h5?=
 =?utf-8?B?cXdhMnBWRmNNZ2tvOVZFQzIvbGYwSE50VjBCK3p5N1hnSU5VYkVYSTE4bEI5?=
 =?utf-8?B?OFpKQXZCVDBZSGpHanlpSmRXam52amtiUDJtOHRmRDVLVlp4dWFPL29XbnU4?=
 =?utf-8?B?TlNTeE5mZUFHTjhVeEtYQ0ROMUZwZTFWOHVmU0Y3bXBnT05lbVVSbnNqTS9m?=
 =?utf-8?B?SUpJcEYvV3MwWDdqOXdYTE1ReWNzUTJvYnNqaFR4ajZ1VEVuc2RFWUg4UjlN?=
 =?utf-8?B?dlZzRkRQZkJNbS9Dcml2NzdUY2FyUFhaRFIzWUs5RFFzU2d1R0ljeGNNdUtF?=
 =?utf-8?B?Qm9pL2hNREdkbTBzZkx5NXVudDhEQ0hTYWlmeURGb2hndXBQcVZYTkE3VHc1?=
 =?utf-8?B?NFpscXp0STlzMFM3cm5qaFlZa3FKSlU0UzZaTnhOTEQ2OFdhcm1TSW5IWFhq?=
 =?utf-8?B?RDlBYVJ2UVY2TThpZHNKeFo5cjlZSkRzYmMzT3pOTUlEZ21aTVlPNUJvcWVw?=
 =?utf-8?B?dG9sc1huRjVlWWY1Qk1PNVB5bGNBUHA1V2NDUHBTZkFWUTcyZStwVGNpY1Zt?=
 =?utf-8?Q?W1z9UV1b3uuiDBg4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90a9127-401e-40f8-4e0f-08df22f180b6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:15.2726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cf43VO5CeOD3Ilb0A9iLNuSpLdrldYFRMVm+fNQ8ZA7goYrmsPssBv+gc9F6gXJ09wvW4wwkP6PritpUsJFEBYQToXyEn7rtC/2uMkE1dYI=
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


