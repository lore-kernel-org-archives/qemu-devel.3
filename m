Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812A8C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd9i6-0001PW-CU; Fri, 26 Jun 2026 12:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9i1-0001Or-4Q
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:47:21 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1wd9hz-0007dq-Hw
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 12:47:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIFFoBtNB6Vzh5sl3nS34WbHf8K8p2UGpOejbfA/Ahp1rnTgXHVuOkVM4FqcoFTN77u55b0za6YO+iynTbqwtqjaTpM7y0Uyak9vLa9ABwWK6F96saDvWcYn6qY8aoHGHoL202PvOTLSQtnxnuQN61039kN192A+hNZ6oOq/AKFua2fRRDX4xXkZwjhouHDkBCuX53jD20M05gczxFdr9cvYTBFCzL17jQqEuXXVb1BrPQHeLuN0JpHQlOqtpGVhmr+WLEvUp2QeWHwGotsEtEGBAfwOyqwh7E6LhiCQEK/TcEHLnd0Dbg1JJaIjfMWRtCvf1r/v8e2vA0ZlUJWq1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ480zU0ZphDstoKuzFbXxrVFFUrGm2MG9Rkglgk9QU=;
 b=TKVqr2OJ46tTZlOTCQ9ZPrc5dd9CCMPvlYIunatwGtGIdTao0EeRWK6+66iIB9aqB50TShaTMEbMuq1Ur2HQv4qRZOyJSUYRmPFKPCzcJ6Fx35Dp5PzrqKuMdZGpTzSDWQo6vwCI1mABLsN4w0dKGra1gLhk2/xwtYpssVV2Azl3LHhd7ojY+qEYfiEnldz31euWZ+EyLwX5WtDmbfHxVyD/N+scUJmDRwWmoBmucYa1aFsAVnJLFWPvyBSqJ0trhrmR2NGvRizN7t5jnMXNXVsuzjmSDXVMUs3FyGeM8VzR7re42RPq8SzzBotbM9CaaQA/RFgaqpuFGvtiqEB/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ480zU0ZphDstoKuzFbXxrVFFUrGm2MG9Rkglgk9QU=;
 b=QuiLxMjELtxgzZV1fewq+onm4FQ8kjcmERgoPRQ7Ro1XkrXTN5dH3kIpfqKzpVe4tQd3xj1egvvqyxaezW9eKwHPco9paeaL8CwGczl471AuKRRbtgZqNCQ6Ky2qrMVHQ70NJCY0eJwcHHntXlgmuW7teNLVLv13ncDjiTeRg81oAwtyJC2rnWltIo4gna0qX05O92hidMhb7mvl5gFyDRqVfRx17TcGmZTjVzq2RO4oRtY9iRTJckSK4F6YtQoHUPjtK6kFkC6Nk3UfLmvZA8+Pw286vCyXwCqtkV5rajrcAz3OyYKT9S0X1/GO6j1d1xt4HF5vfsOimMb0OXorTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB9PR08MB6347.eurprd08.prod.outlook.com
 (2603:10a6:10:253::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 16:47:03 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%5]) with mapi id 15.21.0159.013; Fri, 26 Jun 2026
 16:47:03 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, peterx@redhat.com,
 dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, bchaney@akamai.com,
 mark.kanda@oracle.com, den@openvz.org, andrey.drobyshev@virtuozzo.com
Subject: [PATCH v3 3/7] vhost-vsock: fix FD leak in realize()
Date: Fri, 26 Jun 2026 19:46:39 +0300
Message-ID: <20260626164643.2526-4-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIUP296CA0088.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35c::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB9PR08MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: cf1b8535-98e0-4ab8-10c2-08ded3a28c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|52116014|23010399003|376014|38350700014|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: AnNvjvDBhqTdj+EMCJs2mrGlvZz3WwDzUxRjwRH6lftD+mWa3OnTciugbc4aWIZOweUYWZpiYwMme1t5wJIaIymC28QNxG0N4c4u3Gq3a9MmklAIMYaE42f9s/PgfNDI7fPD2Su+efrhxvnDKnwLOw0pQRNUqwaRoDBxsHNRQDCjfMConjM+k2kwMiY4ahrUSBjwQhhLcevfk4200lyeYbJuoP288YvKb15VyFXn1ASM6/FGjcCXUowfTs8m/zCvAKiooYellVpAR0aZw9o16emSbIjVKgkOTjgTg+HHzt5PzSo2SRNsx/xsMyHaN7gMEw+qHw2SBLNa5OaPVgVVkVN+ywQgYL0tLPB0sOleo19kcfo+XznaOciRVBhT4K9AJNsKRKBR3MvbIuSjCm4RlO4Kg7478IIHzHcgr8mpQhiGWv6hyOdBopIf98N6JRJruR172IQZnCHQb2kq0h8nDYdUb+HfTM/KdiBnz85Dd3aT/l9Mp9lriku8mXxYdGqWiZ4MG0nbPa5ctIzq371JkLtTjg8UVO5hSH0wHOoyJYL0u86Rzjba2GtOPxfjc9v5vyKJbNUJLJDfKDi06OYbCQ7Ef7hRuNz35Ut43wJwuASfnA4qsUrXbtR5Cru3LaAbgkiPa3ukzM+BoU0vWOB06nuJuRL3NxdOnSENM91dcY5FxGRInZulUc6naSm+JDg8DTaIZf/Vpr+ILej93ywFaftqHM2qInKJ6NKrFUH9Efg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(52116014)(23010399003)(376014)(38350700014)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uKHZd5SiuvYbiDgcnKF2RiPWdWW4Egc4/KIX8c05ueeNrRqF3rP1NAc+Ylzd?=
 =?us-ascii?Q?TLxLtszAplspLczQa89nXI0Q8Ottox/weUouPj7VR4Q66Tou1eOoT1/EBF0z?=
 =?us-ascii?Q?llt2UdmrQJeVGiNKi5Wdxez7P7rKYba3GMc1Id0pWOpYqlT64QqqVQuzVLp0?=
 =?us-ascii?Q?BgOmQIxeOb22jQeflAcxnoGsWc61JInRgNSELoRKu4rrvmtZ5guefXBR7le4?=
 =?us-ascii?Q?y5YLJX8m1cGIUMJ4sI3oa077FYmpzq4R8RrlXG9BVOADv9++Hd2S8J87ixhl?=
 =?us-ascii?Q?UgVL2Hph5f8qiCyfreE5RQm15ej+c9AN9cq7ItApM/D2SVft36tC4o+Egqjm?=
 =?us-ascii?Q?oWAbfTBcGD37nACdcREhINEFCH9vWXizblzsbdkTgBMiPJz5QqTqSl5TZRkl?=
 =?us-ascii?Q?oimSz2B2AAbR6lEZ2Sid3mPVMTbrG8QBg8l5Ln6/wA0eqY0qNVshdDRYZISi?=
 =?us-ascii?Q?+GT392zFg/KJcsj/xgbia1KPY5nlA61B1BIm+qk40My2DTFYW7eQpO9tMhgU?=
 =?us-ascii?Q?SjmnvkMNkIApV5xDdeWPTNbV49DvyMQAqmp1GYCvDLTIWV/6Dm9VhViCGa7M?=
 =?us-ascii?Q?yEOOVcaB5qr1XrTfF6/HcY8gM2yGM+TlnE0yQKXrAAaIflD9rtxWcrh8zscB?=
 =?us-ascii?Q?IWdhh1US2n3iRFtcX6kW2FjAsxhxvfqntyLTe4z9qDfG+Gk53GXLhiF2ZHoK?=
 =?us-ascii?Q?sPuxlkvRPenHeQXn/eLcLQ+L+Bm+aktdlhXS0wR+ulB2Rx8VcWGaiMLA8LE1?=
 =?us-ascii?Q?95ablFZKLmL2XZuccDclKdd7StRsBKbzkxgS+JCv26YluJheYhfpk0Sgxg3A?=
 =?us-ascii?Q?Sc8YofUxapGD+4BmDkeU0BRc77TFxJKA1lZEWlmiQ7VKf98iuoHEnNQQTAEV?=
 =?us-ascii?Q?mTGuf3cQ+FdXw3UgfFdsgB8TyNgsdnmfU+ufeG/CLzg+w5XfgyM9KowB4lYL?=
 =?us-ascii?Q?2rGGXWCVZtSIQ+UZdKB/OKZfG9jdYA3PFQ0KwKq8gYvu9AuprnKpze/joz+A?=
 =?us-ascii?Q?exm3GyToBY2UwDhmtrx3fZN2+u2H4LCrmRSoppWoghy94j+eRSmvoZ7J3rfM?=
 =?us-ascii?Q?v4SMsINWZlV87ss8jCARIOq67wcUU1v4YO4fvgF4knp24VGxaLpfxVidypA8?=
 =?us-ascii?Q?tnwXkjUPG+TPF2PV/cqWiLWXdHGrka78A3vLrfWSYMqwvPk1bc30iauKWuKP?=
 =?us-ascii?Q?FgV7e4odz3p+dt98mq5JRwK2OQufDnvop3/Bz1TzDnuGVF85O2rZ3Jk3JiB9?=
 =?us-ascii?Q?E9e++0aY3I5gg76ykCVWEnN2g4HnGreuTU1Ho3JiKAOC3VrlUxwERpEuwqAy?=
 =?us-ascii?Q?j27TzW+mXz9KP4qQ1wyuaG1kEteKrcxzTGTKTrUa4+nCiJ9fBI9sL/ZoYAQ0?=
 =?us-ascii?Q?hOZRrj9AsAnJtZS8RCO8G6ssyQLcNfCUQkwBtDhUtTO4lAJJ0Gjn0zAXBA8N?=
 =?us-ascii?Q?u2/yd0CgAXd9jaIHUjixYSE43E3rfs+AC9Tho900CldlJfArm3fpXEUT5/u8?=
 =?us-ascii?Q?87BPGiMqjo0eqA+MI4EaShJ8FFWtxQDMp7E2I5v9Vdk5kzNXX4QA1q4gpijA?=
 =?us-ascii?Q?z0txQLETqHnE+HLmsHwt9IAKsBuQ0YlEHo2GxfwBfloD5RrNcdbnATpI4YU3?=
 =?us-ascii?Q?QwiMLjuwPwZZlsHy9NjRg9cAqEB7Gci31W23IIEvKJMy0Ez8iuqEECprfMM/?=
 =?us-ascii?Q?k6WYOxh0kQycSzcBf5PTFfp/gNl3ldJtA9lW8OMtZdt7ZE7xckMEZ3k625a0?=
 =?us-ascii?Q?YPWSNRALoLRNg1IWU9JMPYwdmRQTClM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1b8535-98e0-4ab8-10c2-08ded3a28c85
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:47:02.9952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoFaXGJgbfKs1lWLVtV5RYw6j2Qcp8uvi/VgRzOOGEbbfzfM5WH2Y6BwZuSw0Qxj2j/PTu+fQzApnVhbz/i7+iqezxbEIFeHXqmda827Mu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6347
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

In vhost_vsock_device_realize(), after unsuccessful call to
qemu_set_blocking(vhostfd, false), vhostfd gets leaked.  Let's close it
explicitly in this case.  CPR-saved FDs don't get automatically closed,
thus it is safe both for vhostfd obtained from cpr_find_fd() and from
open(/dev/vhost-vsock).

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index cdc58d58790..fd7ffa88990 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -161,20 +161,17 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
             return;
         }
-
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
-        }
     } else {
         vhostfd = open("/dev/vhost-vsock", O_RDWR);
         if (vhostfd < 0) {
             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
             return;
         }
+    }
 
-        if (!qemu_set_blocking(vhostfd, false, errp)) {
-            return;
-        }
+    if (!qemu_set_blocking(vhostfd, false, errp)) {
+        close(vhostfd);
+        return;
     }
 
     vhost_vsock_common_realize(vdev);
-- 
2.47.1


