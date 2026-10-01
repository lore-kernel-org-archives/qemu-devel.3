Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEF9CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCC8S-0005kl-Mj; Thu, 01 Oct 2026 04:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC80-0005BP-IB
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:58 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCC7x-0003P8-2b
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:26:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbh12A8zUEQjrOJIgGWSmtOsGYGVNIGN23LDkV1ZNzpkRHCsHP7rGOH+OjZDjVhOaViKJ9MYB0QT6Z2fv4oJeBKguBIa/nkEa/X3/J4kQ9yVj25AGboT2j0YZIrHp4ZpoLg/krF7ump7BsRAF4qYZP/UqUkfWJvlsdx9i1UH3NeKWXPW+vjoG1AAnsaqGcLxfxAO+WML3V5nEJ+QmdPbprjcEkRWhOjahVBjCp6iMnYZ67LKnf2GPLzKA4kzHzzZuplpeiEqwQVo4rd86AF6SouVenwyOnumVJA6drrG29MHMkA5VNXBSkSlFpdFzLpFp2EU9NGO+CywYnSG8e1vew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=AxRenFmHPBog14d617xpkDOH/qXpBqEfPBhIfbO2yNkydUCjbFz0cs0LeKyDeZ0JDDR9vCMuWesZvSNLmgQBgJvhCjB8kTxB5AX5r0ZbUS4aWB6Za05aiw0InLdZq1/xc/kzgOAR6bq9qg/jdOebuzTQRnVeK/rKdf3XPMQRKDcDgruNdCdclUPvvat59g55GEvhviSlZHTkBhLRFuTN9gXpWVl7DA00KsSFsbeVEzXJbCusEst8rht4PiPkiFxtnwpKIPVPi56DztvwUbZZ2KF+WgubLeE/EXHgTaFd2IXdR5095kp0DcSgcURsRvBYgR2EZnvv9kWYw8KNJjQusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=Zuo68GZ1/uxSYPSyrsPfTQuNm7HOIaIAACbgEPQG+UmDREnETy3i2B5IZgwzO8iAiqiAx2YOixP4jTmu4fE6l4IaGvnGQ4FqJ245D3B10LnR2k41+Bh3ep4NsWxsxOUy1dEGTsfBZfLUGGWOvIf9vTSikj2/CUevWBDJx6f6DjlSbfwwtbt5tEUmBk/hFWu0RvXCY6ZeUqK8tZgEDzqvY+BInCyzQ7xDu15E9u/kORW60Ojf4oPGxovCJvHAYFZI9kP0pedkSnQ/c695MJ4+D59uHuIvuvTmSJY4/3Eqin0/d4rSn+f65p3nS34hc8jwROjja3N72MlRCLugHYSK5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB9261.eurprd08.prod.outlook.com
 (2603:10a6:10:3fa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 1 Oct
 2026 08:26:42 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Thu, 1 Oct 2026
 08:26:40 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Thu, 01 Oct 2026 11:25:04 +0300
Subject: [PATCH v10 04/18] migration: forbid snapshots under Xen
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-up-vsock-vhost-v5-v10-4-8c094843e98b@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7ecf9192-0a3c-4879-6030-08df1f95b7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|52116014|7416014|376014|1800799024|10067099003|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: lMl9I3uQMZrhUclPGUFx38IElgTdwcA7nWu/kj9mxKxAyTmyLO+KLOvuyYb2TR0zbpzsyQxAgSEDqjNrQpl93ESnJlYRkhYQ61yC/AnCc6USsRSuMQry/kO9v3gypnVe3yJ7C/iM+1TydoEC5JbfB9K/YDaY89nx/24AwVU3PbefemJBPVYfknL/mRxVoMGjsgXTWuNaxdw4NUv4nXzPpRKyFXqxV8qI93QylWaL76dySwlzJxLPJBbS6V30jlLBnvUo13iJASkZxCy+7JSeiszaLKAntPBGYpRnLmNONpXu0bttCc8YGRuBMnVJPLeD4xpbD07VwQqForxpedGNSr8A+tqzxEVSrjT6UiekbWfB0tZphSyk7Yc3KryTKomB4P+So9Au4+MTWgviH8/RB+eokl1wLVNEYyjZPnb2FX9mi3nNdfVSLTVf6XJtd5NtFli4BSFjwylEkjCRuNOaov5uyDksEAzCbt+m1jvTh8sK8wimDI8D/4vGE2U6b/ewnduhtv0S/mJY+hdmusk+KVFMVycGArKyrMxBJzizf9HiMIjCi0Qds0b+IkA0+6JtLUn0JPqFXBuZVzWU8wGIuYTE38kqIcwCrB5QW++rbJ5ZizFDEMCXRR4NZY3gA9Bo9ozKdicT3GeerZSVYRahaetcHo9Fg0HDr5aXU+PUv7qrnrRsu+SsGAKWbB60+ZWGfIvYcBvf7l5YJ3hT26/G+U2qkvZ0nhS7qdgU5NMQMr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(52116014)(7416014)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmRjWUxtZStRcnlOMUNIcHNUS2luVmIvK1Y2Ti8xZGhVZUpNdFpRb0kxb3d1?=
 =?utf-8?B?ellkZGhwL25IR01yNkhVZ2laSmszRWZMbFZ1VlJicmtmT3lHM0hzTmF3QzAy?=
 =?utf-8?B?VENzRWFNY3doWVVMR0g1RzVWSXBxb21xc3IxRy8zdkVLNFBmdDlvSnFPbElU?=
 =?utf-8?B?Y1RNV2tuTm5ad1dUeFRLT2xSbzA4WXl6dll1c0RXTFdRdDhtS0lSeW9HOFlt?=
 =?utf-8?B?NTFORjNkUjdNK05SVjBlTUFaMlpUaXg5eUVNQklSMGp5czNCeGZXQkJOcmZr?=
 =?utf-8?B?d0xLL21EWW9QRW51bTVJcjNXY1NmSDhaaGVkakl2T2FMTnMzK2l6ejBHVHF2?=
 =?utf-8?B?Ri9KVi9SeWYwOHlNZzg2YnVJNGRzRHQzZTZsYlo3aUFUODFGNjhBdlMra05C?=
 =?utf-8?B?U2ZwZTJTQkMwcXNLeUV4UmUwRjhVRVVoNHpXTlJDWGo1MnhtOUNEMmRRSG5x?=
 =?utf-8?B?eE5qWXluaU1QU21IT3V0UTBjNWtFQjQ5bmRWODVZRGdLalBqRUlhWkQvM2VM?=
 =?utf-8?B?V0xpV0pmNlR6VGwwZUtHRWtWdUI2Y1VGdXRwM0RheEd5R2ZiNnNsOEtHYkxQ?=
 =?utf-8?B?OWdUVUpWcVlUT2dMc1A0VVM4TjhjMmdNUjYwZVU0TE5VUEZLeHAvQ2llTUp0?=
 =?utf-8?B?ajg5aEJ6SU92czNlZE9JZU5RMXE4R04zZWNmNElxd2RjLys0N0tzcUlLNWxS?=
 =?utf-8?B?bis1dEd6RExpbHVpc1VqZkhWMllHN0UrbjArNnJabm9SZFpXYm9nY3BHNzV1?=
 =?utf-8?B?dG95WEswLzkzemwzQkh4YnRzdDNlbWs4dWZUdkRUeEU5TTVEYnZWU1RuRytT?=
 =?utf-8?B?MjNCQVpmYmRISXFPSGw2ZUx2SmU1TkxIL2xlRm1wOHJySFA5T2hTTVpRaFp1?=
 =?utf-8?B?QnVwNkVIcHduRUtoN2plZkQyOURoRXdVUjBPQ1hhSEJVK2wwemZQb2dKL2JV?=
 =?utf-8?B?dzdEY0Z0dFpRL3RkZncvMEVETVAzcVowMENSbzdaSlZmZnJoQm1kRnR5VjRR?=
 =?utf-8?B?MUlzbTRKbTR2c3J0Nk1YZzhrWVNiTEdBUUVXd21mNUxvV2hwV0l5dTFwS015?=
 =?utf-8?B?LzJXRm1ydzlSbUxGS3UxcjJ4VGhGQlNJUUl4TDZZNkdFeW9wRm9EdFU5cHFo?=
 =?utf-8?B?TFQ0OUxBY285SXBtTGpBdGx5YXU5eXZIZUFieG9DSGdOM1ZibitqNFhqUklw?=
 =?utf-8?B?NGJ0d1l6alZycWUzaEZPR29IRTFPQzNYTTBYTVR0Tmh1Yy9LYWMzSGNJTUxz?=
 =?utf-8?B?R2REWWlLbW9mQWNQeUhkcXdhVTc5S2lpcTlxQ0RzMGFSQUJqWWc0OHEveWlT?=
 =?utf-8?B?d3NVeTBNRTEyOVRBM1RPT0dKQzNYRkhCa1hlVm1XdytZUEZhbndGVkxVMkFt?=
 =?utf-8?B?a29YTWhiQ210bnFsbjhnNUYzVVNpRGU4RURUQ0kraUFvYVg0QkVJUjcvV0Nn?=
 =?utf-8?B?WEZuamtXWE1NTG5CTnRtYTFaczh6SlBrZVkybTZTMFZ0TXorQ2Qzd3A3THVJ?=
 =?utf-8?B?cFVleVFPNmtLNHZSNjJqZTRZdURGbGNxT25iZkZLK2FuZTJEUmhjdVE2R2M2?=
 =?utf-8?B?YkZmSjAxSzRLQjZUelZaVDBoQkZna0tjZEFHcUgvODhSYTJVb1NtZFN4alMy?=
 =?utf-8?B?UndQN1pUUm9xbjdXUXduYktoU2EzOTlQUUs2dFNUeEQxZW1Ja0t5MVozeGpT?=
 =?utf-8?B?c2pBQTM0QXVHSVdLYW5TdmNqOGtVSlk2TEJ3elFnM2oyMnBGMjNZSDJNWita?=
 =?utf-8?B?cE9ETVhjb3ZvR2kyeTJONHZTOVBvMmQ5TUkvc3g1ZEdhUmdrcW9rWlptcGkz?=
 =?utf-8?B?RDZpempzdW1QdUg3Vm81L0h5cGdmaEhaZUJYSE1MbGxLZE01c3BMR2pyb3pX?=
 =?utf-8?B?ejVHQldvWUo2U0tVZnJjU2l0aitPY3RtdEEzaUFIVU5VeXZTZS9idVl5WFNl?=
 =?utf-8?B?cks4QlROalc4RlI5dk9XbkdtZ1ByQUxtaHExbDZnRGxjZFgzNG9LclJ6UG52?=
 =?utf-8?B?amdvTkUzUlJTd0ozTHA2RStxMFpYRnRaaXJKT0dSSUU4MkRuMDNTTytvcCs5?=
 =?utf-8?B?VFRxUDdvaUNndElQMG1IRU5tbVhVT2NXT2tUVnM4dERYSk5mdWc5Mzl2VW5X?=
 =?utf-8?B?dEFhSHdwWjFsYXIrRUxkTEJobVpPMXNEelZLNUVjb2lwMDNBL0MzQUs0WHdk?=
 =?utf-8?B?aWtJd01GWGs2cGowV21kbEJ6cHlQeFhUUktSM2tGQ3R4b1kwZDRHcjExNFFG?=
 =?utf-8?B?MHpRc3dkU0VJQ0JzN21FQm93RG56MGFiWlVoUEE2UjB3cVJjdENGTmRIVm4y?=
 =?utf-8?B?VmJKWWZPVDA5VGU0TVVpbkFuU1ZnK25kWVZjcHlaODZKV2hIWjlISG0ydTh4?=
 =?utf-8?Q?9rkCXmB/lkI6O57o=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecf9192-0a3c-4879-6030-08df1f95b7c1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 08:26:40.4438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWJ6l7l2uGOpkpLAj/NXFtQtxlgqHoqqGvIxpl0cYa7G8vPvvdfe7MeCzZZfGDoc9f28RtEyQxHy88+RzrQg4XVEnkV2c+mB5WZ+8NKq/zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9261
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

The snapshot RAM-saving path does not support Xen's memory mappings.
Refuse 'savevm' and 'loadvm' when running as a Xen device model, the
same way they are refused for CPR migration modes.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 migration/options.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 92eda90114e..0b7f393492d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -37,6 +37,7 @@
 #include "ram.h"
 #include "options.h"
 #include "system/kvm.h"
+#include "system/xen.h"
 
 /* Maximum migrate downtime set to 2000 seconds */
 #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
@@ -563,6 +564,11 @@ bool migrate_can_snapshot(Error **errp)
     MigMode mode = migrate_mode();
     int i;
 
+    if (xen_enabled()) {
+        error_setg(errp, "Snapshots are not compatible with Xen");
+        return false;
+    }
+
     if (mode != MIG_MODE_NORMAL) {
         error_setg(errp, "Snapshots are not compatible with migration mode %s",
                    MigMode_str(mode));

-- 
2.47.1


