Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C09CA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkC8-0008HX-G8; Mon, 05 Oct 2026 11:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkBp-0008Df-Mh
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:18 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xDkBn-00056n-UC
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:01:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/RpltLwewqo+jsPk8CxeW4k+GvoVjSRti0SEMJA0aeML5A6fB6j3RyrXsYFZ6c6rTNmoTneNAW8dRg2yMZ+iPqO6FjOr0bw8KTdZE6TEW9+86BQALxTLCD8uRoh2LsW7W5Vp6PlvOQQhrIp6Up68ZEp7qIZ4V7BDNjSGOn3jbZVOODDRO2T0WE3FaK1wfT7wdY3jmMgsUafxfNc/7wRD+nhLouLwfxeqFbUzqsDNVlc0yaDgvF2vz/BOYyEw9W7NlkVhSEFqkWCcJYQEFxyzz6qpSZptK0WcRuEG+TuJvDZ/To+PLonM97Qd4HfxdObBfaMvYUZDK9ipHthEnk/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=S6f9nE9nevBXqm3dgg2U7dk1EN+7Fm8yOIsfXkE+vlR7REWS2WYvgd9/JvzcMUExobxoPPowt0a/Wk4ObfFd0uIfJlmP80Bm6A+ZBOSRT9PxrtlbTU32Am7M7OG3f0CnHgIzAOf84OcFOu+4ndgm9Ok7t6rrWHxEI2pEu4L3XJw7h/aFF6MNT1i1+2/NCedruEHaqhHB/OgJXwiaMeSwrNkPD2cm4TXHgVUwA/QP1BSLQgJE6J3AUk0wH9xFa7R6nYr1iEXKMo0JFHtNeSZ8Ddm91UZKBq9W+1jpaCkRWOl/VcuZl3lES5s3+1BWReDCBkWxoCQRxJRQ7Mmd820uWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=nE6BljJNxvKBagh1u6Ct5f8JCFr83evw1TcdJKzO4m32/g2g7No73KyCu+TtN9HnSz6HpyFplDlBhMSq1JPpmVCel6m11r4u3WZ3jDOcfZduxJJKV5e/fh/nos+GscT9MHo2IFAWwgSuxt1cNtiG26lr6GpNMhWZbw79KclZhGvzzGwNSj7rUUpPTfpSQPutwj+64SMUdMO+Kb192Rh6hLqjiXk8NX36uOlrjXqsac4PgahlEqREScIveloWAbjA1eoKjrrMkZd1Zi8uylCnYTvkzy3Whze2I0LnkZ4BhynILmGhBehwtxdefmxyd8M3VqdNjtaiE/Xeh4qCV5v58A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAWPR08MB9736.eurprd08.prod.outlook.com
 (2603:10a6:102:2ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 15:01:12 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 15:01:12 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Mon, 05 Oct 2026 18:00:43 +0300
Subject: [PATCH v12 04/21] migration: forbid snapshots under Xen
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-up-vsock-vhost-v5-v12-4-40162390c68a@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 60937578-68a8-4d11-71d0-08df22f17ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|366016|23010399003|376014|38350700014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9c7iV2YrW2UXfU3OKycBrU/6EaYRHECFd9NUw4NtVwBK902UxSAZEzAHFmiwSojqIuYaqC2SAvlPxSFmef4LWmfrCqgZFuHiIDawAO1rKefOzDDV0UV0WC53Rx3g//743mYIAhdTalbpdGIidpSATW7YqXcdvP+kGAMk1Eaqq734VF4fuCJn9ezlTBn0MbVb9ftgIFKEuX7XLLtbf1gBB6Jh0nRV0mvaxtcsBGWiyXJheWZziZrHEO/bRP+hb8sZjptgPJ21CFgFo8MLS6g+YACE6A3nlafXzEqpS2qpRExFuuC7sl3yIJTl63bC9jZoCIfUxKAM6Z5pGJ1q6ZewPke1KfwNqoL9nHUcgI/etmcJcKm/Rx0QNKjGbBeLxZxUcVzb4xH+2Xm0VBXTeNLb4l4K47FFmZ/wa5mfU5HiyGroqGml7txMPHk24Q9RPN4qpdk4HQdR7BpVD9f7LeSTx+bcH9VcgsLGKQUw70u6JwgUz9yRCF2UrlTp4is0uwjDGGZ+TmXia27NhzbmJ57T7boIYrrkolC6M9l16w758Z0rhg1j6V3BxGbu4oUdqYPgKxcgVeg6R/OmVF24s3B9gfWbgMs6a4r5O0Bfm8dj3mp2SGenBeBu9uVq7HKlzBV9rEwtYiD0sLX5S/ksUSlYdIClFVVXxGkxgWIF5JDp5GUJ6RdtrSaAhzID2+0CQCWTF9VOEwwFavrTAJE7QHHunWc+xkf1nEOlrHsAbTUs/Bw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(366016)(23010399003)(376014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVpaN2VOWjZBbUwyZytSMlViczY3dDl5R1NEaHdnQ3ZJZVRpbitmVmJHenF0?=
 =?utf-8?B?eXp5bDZsa0NtUDA5bitHZ1FXT1lvOTVnWVlmNzZobTRpRXZBalk3dlVXSXNY?=
 =?utf-8?B?cjA2WEhNUWxCaXlnWk5VNmdGTC84dmxrMFBXRmhrejJNNFB4N3BDalNYeDhz?=
 =?utf-8?B?ZlBTTmVHUFo5WGRZdjF5V1B2amFGUDlZdkZUeWZnWGNUWlh2WHN1aGRSZDRW?=
 =?utf-8?B?R2VOeFVCNllSaFlZeFpKYlBZMjkzcGtIdUNaN2Z0d2krYUpSNDNVZkVTWm9Z?=
 =?utf-8?B?SGdOSjd5d09OWll2empPb2E1YVQ2Q1lvZ1dQaktjbWpoOEhyaE1IZnBodjUv?=
 =?utf-8?B?UVY5bHNVd0RSY1pKZko4VVdTem5STjBNUWtDMEQ5QlhINWFXbS9oYXVEWVo5?=
 =?utf-8?B?UzNDYTVJbXlWMDVlQWFtSVUwZnRiWFZWUm14K3dVclUyZGsxTHZzV2kvMzBu?=
 =?utf-8?B?SkVzUHNESVNZUzVZTU9kVFgyZVMyNWx3bHFtRDdZdmwzT29Uc1pHc2NYUERv?=
 =?utf-8?B?TTQ5YTJORkh6WGdoOVp6RWQ2YXVOVENPQUhDaTNxZERYeUVHSVZFbkkvNWZI?=
 =?utf-8?B?REgxNGxFa1Vnem94NDRWWXI2ODRpaDJEZDQ0MHpZSWgyL21VbW0zOEF3Y0Nk?=
 =?utf-8?B?U2VNYWgzU21uUEMxeHNsZTFSTHZvMEV3dXFJbXoyZFp0UUFaZ0NqcCs4MytH?=
 =?utf-8?B?d0JYeUkzV2RycGNSdVIzdSsvNnhyQ1FxYkJKeWd3Z2k4Zi96eGNVNFFTYm8y?=
 =?utf-8?B?a25sV0dwYU00aHJqNkkvS01xaC8zZWtIMU03Nk85UDVES0V1LzcwbkpBSHJW?=
 =?utf-8?B?OEhEZ1IraGcyemIyU2FvOWlubHcwejVSSEMyeDFOWUg2a05MOHk2R3pZYjlQ?=
 =?utf-8?B?Q2ZDNEZOWmdYNFZHdUppc01jVUZZM1Rwb2tNNlpIMjNiZFlEc3c4a3dKb3A5?=
 =?utf-8?B?Z1JwekkybEE0cWRIeHViZWdzSTZMbzQ4QUN1NWlrZU9FaC9ZUDcxTExCQmtP?=
 =?utf-8?B?a2UxdkMrUTlJTkluMXZRakNrRWsweStUMnBNVFJPYUxTVWthRG9wNUNYajFI?=
 =?utf-8?B?bTFRMG5NaEkvZXh6S0NqUHhKZnZDM2dLSU9kTi8yU2N1UmRsOU9sL0tsSUwz?=
 =?utf-8?B?YlY1Uk9CbkM0ckVEd1pndEhmQWdkMllYQ0VzSzB1bXRaTldEQ1R4R1F1Ry9m?=
 =?utf-8?B?ZkRBclRzUy9QV05qMDNJUVZ5bmZncGFpaURYaTZ3NWlZaVVyK0FacHBMQWcz?=
 =?utf-8?B?M1VLSFYyK1I0Kys1ejhDYjY0U0ZXUlkyZXpmdjIwa0ZZMEpvV040Y0hkL1E1?=
 =?utf-8?B?c1pZdGpPRUthaTgzRkZBeWYzK2NZbm5rOUpnT3BMVTdZRXNTNHljYzhxQldl?=
 =?utf-8?B?VUZ5NjVuQ0pWSWxtRkpJTzE5SDJZSXdncVNsdUo1ZVhwTHFuZGF6MlNnQnlU?=
 =?utf-8?B?Y0g5NFdVK3FYcUpLb2xCL3Rtc1VlOEVtajhOTUpLU3VTazQ4ZFJzT1lRWEw3?=
 =?utf-8?B?ZnNvbVBWZ0lRRXBhRnh0clVJMFZmNnNFUnhJRDhJQlFsSG80S3BmV1ZjTERl?=
 =?utf-8?B?SktmNng3VUNQclBEVUptelJXcUI4YzNmMGVud08rc3R0cWlwS0J3dGR5VXN1?=
 =?utf-8?B?YWx5QVFuajVEMWZ3SGY0dldqV3cvSVAyajErNFRoUVZ6a0t3VXdrWjIreUZO?=
 =?utf-8?B?bW5NTzg1RStsNlJ5ZVd6WFBOcHI3ZWI2ZDhWK1h1YVFWcGl2L3kzV2FMRVJV?=
 =?utf-8?B?UDMrVmdGNFU5M1BUTUhQZEdQWWxFRUZnN3ZMN0JrNWpIZldVbURRdldkU2F4?=
 =?utf-8?B?VkJ6dmZtTWp5RDlYUkpXMVNwYmd0czNNTWRyZGh6azBBNy9oL01hTFpwYWZn?=
 =?utf-8?B?NDcyQnNXU1VlT3pnWDZCMUFYSnJHOW5acFdRVDZlcnNYRHo5MEpHb1hYTXNJ?=
 =?utf-8?B?cUt0b1BLaHZxOWpFQURhN2RJTDF2eVJvdXBxZkE0OTUzQjZKYmFxUUNhTDVB?=
 =?utf-8?B?TVk4RDNQb3NFT251UzJHanl6b2VncEVMQjMxUlRmOGREek1HU0ltUmJlQko0?=
 =?utf-8?B?YlRmR0J0Y1kvTWJUbUpwUlZCVFdFSEhORmUzbUltNzh3RldkTVY2bVVvbmlV?=
 =?utf-8?B?bFpkN2E1NGtoZVdvemJaSUYrRkcyZ2N3dTRjZnpoWUozU1IwVWJZNTd0aFN6?=
 =?utf-8?B?dGtCOHBFWHE0N0pvdFBra2hDaUZvbjVUclRLT2c1Q1BhT0hsaVVZQ2lpRldF?=
 =?utf-8?B?c3N4b1Vra3pIT3FsUjRETWllUmpOQjhnYVZFbDgvK3NoT3R5b3NYc042bndq?=
 =?utf-8?B?SG15amlUcjFsTG55QTRaMkNHd2VTbjZPb0JEZGZPNFJwV3ZRZDVja0p5ekZw?=
 =?utf-8?Q?e87B0MDWDVfL8nTU=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60937578-68a8-4d11-71d0-08df22f17ec6
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 15:01:12.0452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqCBw1sMOVlNIQ7euVpkVMS49pmvN7q4amUC4ThujTbHR+TGJgzKsnf+WbM2n+6iMlz41R0YegfpjcpoDsIUK2RZ+d4dW3D7waqCvcsNuTM=
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


