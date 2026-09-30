Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D807ECA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJb-0000gj-9c; Wed, 30 Sep 2026 06:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJZ-0000gB-Cu
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:29 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJX-00045p-JM
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qAP2w6l3Py3lpmxnbehB9pAchuH/fxXzVXArMju7zoNzzwxvo4FO7Jjgwz7+/uQu/3GyGZXddcIny2mnrjd5jHx0l8cx4jjGp4ORSWDXHbzoezs2wZLIPzGO+sV1eYgSQW7uwBFlcwVP3WF7mIDH8NAloy5pYVDWSyqgjgtjr237qHnMx6oTqpUmQcXLhoElave9QlSvgEq4ssqyr7GptC4dTNbx3B4/I61huJpzgQsVTWSX62/DP56iZqJJAYYoP+JYpHRRi2EruXRwqXZhT1KtWkvP0MuS3rms+Xq/hfs+lqugy8oJgKW/rfFtIvd24jLxFUTlhAVnIwgD/wc2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=oYoe80feU/h3viD2yIRPffWKXwiM0IDWAtJz+Y52Y3jXRrnH08nYQwZMhEGmfQ63BwGe+4w2ry4JBY6/A7aubk5+VAopk1bo62aRAhTYFh8kwesj2d5npScyA9/55ChsspikdTHakB7msveVlsIJidUYT2HuYXEHMdtUrxGb5MfmgQIRTfkyztDelsXGAIWQhqHYcwyI4Np5pnPuEmQtsb8voEm6dfGxIES8RBTmM3i6bCooaKvX52X8LQvJhbTL/WDiuuzrL8RHEC4Gh0d7IVbJW8lqqsv580ivMNe8iDPu7JAO5YIMZwZev0aFs2YbcZ06MQ+o9W81HwjtIuDo9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsFB3FDQ+3FBoUdGrsPH789lm9GaLA45KHUm/J4Q16c=;
 b=eNKlAdMzwVntFA2vKPyQagFImM2HOKexVFcChsSKfIXs8i6EGlXDcyLZE9OAuUZkBOplkAMevkd8SJh5oFpDtNdLmU8Zryb6bAu4Z/s0+T64Yph+kL4vZ3M6UIb2QI61lpnbU+ML6oZT91jQ5b4UIgnnVAi7a7x3pFoYVdZRBAxa4qnWI7+1HSF4CZA1tfubv/RfyV08lA8HR15fosKBkq5UtmbhAltFpmTtplSRIjna0oofDxbAgWMJLXGb7BCoK9l5kvfatyg0Kz8ZH7afPUK6TkNz4TOSZsuWj5loHZ6/1QKQTVA/8IeOLxYD23WxreL0nFDTikhsuq58kcmpZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:19 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:19 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:03 +0300
Subject: [PATCH v9 04/18] migration: forbid snapshots under Xen
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-4-e9096f629770@virtuozzo.com>
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
In-Reply-To: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, clg@redhat.com, mst@redhat.com, 
 sgarzare@redhat.com, maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, 
 bchaney@akamai.com, philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, 
 farosas@suse.de, mark.kanda@oracle.com, dwmw2@infradead.org, 
 peterx@redhat.com, vsementsov@yandex-team.ru, den@openvz.org
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0066.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::10) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: b2412b88-8cd6-4bdd-9ec1-08df1edb7321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 8uhYNyY8sU55I0J/9zdPRXjrf1IKAbKdZlOjRwkSf7u/0RuZcePVyp/IJ55i+CR1uXS9NabT1LH7wmW11lc/NUUfeARrlr0Utt6ETrP/h/Q6NszY6dIvIpDgXejzw5V5b5v+i6xrZQPf3ZatmVLKGH49N82UVyvotzL5UkPoKk5/yY1hXNeKReIf09MPDAvRJY4j3TQbP9lnm+hpNVVXMMojSHuVJaZnT/Uh1+VzlvRzm0MrJkfY7qj4RUa389GpNINhpHI7GHqPiASUblt/FQEp73fXEEvo30uTJvOOiyopC9WMW03rTEdpKLI7ZNkFFF+ICUwG+iEZdCzd246qD4VSzoMKKxG/Lwm+z9SJRNrvgjY5m+80JM6fzmffiJlU+DLp6EgKXzFfcUIkL56mh1GBW/zTJw/N2RBsT/GMj4JSmqYaxWWctSekt8Z9d6tKyNUiv0EMesufxBVLcLf73jUdFiArg0iE56X6uKB1ObNZbR/Jd5xUdopFStS+BQOpQn9EKu+Ij2teE19XmAQIlcuMZpJ1Bab7J8UfNnnEfQFLy6KvzC+dZZEuV2Kuv3RH+0LAySCQ3Kei2r8djTI50Rd9gP3OHUUcH2/kqmvUCDHZZL5oE1Qj0e9JKdCCvWdWt45uBXxTrpZBIFdHpIo4h3rpcyDVfozqqkjV6L3zeCuPgHW/1VNy4c8SfIb2V3hLM5Fuu8PSTu4JD3Iz0pz1l9fGZ/XMkOMHMcYXaO8G0IE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVltV29wSHFOMlYzdGhzL1p1ZGtmRnRraHhONzk0cXRqOEl5MVdqMzZEWnky?=
 =?utf-8?B?dWdLYjZ4dHRqZWdHZzlKYlo3bXRROElHbVh0eFl0WlhmZStQWHRvVVNlMVF3?=
 =?utf-8?B?ZEZkQXBhTXBrVlE5QWlZVktraEdTbHVLUWdFVFpNaEFiNWNBU0VReE9zL09u?=
 =?utf-8?B?KzdsR0RoNnNKaTBPKzhDWjRUOUs2N2plMVkrQ3l1bnFNajY4eG1GNlRoUlVE?=
 =?utf-8?B?VTZZSXFqNUtFc211RHFBVHArUWFLSWpTTEtqRmpRaklMTnVXTDBadnVCOHp2?=
 =?utf-8?B?K3JPN3BGRDBqMnBiaXcxMkJxc3RobGpnOEk0ODBqRzZ4WTVxRnNTUFFJUXFR?=
 =?utf-8?B?ZDZoTDlwY1VqT25pY200c0tMNUx5b2VESDg5bWEweDVMdUpvZi9qNUFzeHk3?=
 =?utf-8?B?ZjM0ek12c1JWOGtpUUVJdWdVTlBudVZKc09PeUFhOWxrRExvSmZUcnFmUzZp?=
 =?utf-8?B?VTVFelBMRm0zTEMvRUh2bDNLQ1NtVHFZNHlWNkl4YjVxajg3d1d2TG9LU1Av?=
 =?utf-8?B?dHFDeHlZZzhGVzRaQjhkYW1hK3Z0UjlDRkNpM1E2di9aZXQ0dnEyR0piNUx0?=
 =?utf-8?B?bXVjYURJTjdFRXVGcDJhYnRnWmxWdlNVZVhwS1RCQkFJWW9kcUtWZlZuTUZV?=
 =?utf-8?B?SnFhUkNtdURJRDdTZk9FY1N3Q2kveHpIOU5McGIwY3pST3RDNEJNelVucWMr?=
 =?utf-8?B?RjJGMGgxTjI4NUFpc3QvSTlzY2dJV25HT2lBZFFRUHFWY25vVTRYT013UnBV?=
 =?utf-8?B?ZDZZbjdXMUR6elVuWmg5Y0Vzd2hIcDJRVVVVNGVKdHdPT0M5MVBDUU1PTDdF?=
 =?utf-8?B?QlJuQjdSWVREOXY2WU5qUUVSTnpMU3lhdzdpV2hydkJzTWc1ZE04TXRNRXRt?=
 =?utf-8?B?L2ZSS2E2TkNyei9sY0RxeFdWMUUrN01Dc21NWkQvVnRMSU82QnBOU2ZLZUt4?=
 =?utf-8?B?R2hXenhPaHVFZytkQ2JnZ2dTdFRRcWxGcmhXVmNZTmRLL2Vvdjd4bEtCK29W?=
 =?utf-8?B?cnBZUmR6SzB5RVpnY3krcy96VmVGbVh5aEdodmlVdmZpNnVXMkNsYm0yMEY3?=
 =?utf-8?B?c01IVlMrSi9CaGdxL1d6a0VrdzlXM2lZOExPRTREamtiT2kyMS9hTUZ1MHlq?=
 =?utf-8?B?UTkwNmc3d0N0Ujk5VXNUckRzYWo0ZmQ1TWpQODNSLzF2TFJDUk8vMGo4S0lY?=
 =?utf-8?B?aEZqU2FWNHlnWlRwZVBWczdvRWpwM1FZRUhDRlMvaHRBSm82bkhtQ0taZmp5?=
 =?utf-8?B?UVI1Z0NVdVoyakVJMEk5QlV0dVdFYVdUaTNpQ2gwa3dlZ1NNWmtvZTJZbVhW?=
 =?utf-8?B?S0VCRTB4Ymw1S2YzQXd4N09VWDltVDgzdlQwSm1DNEp1VW5lSDllUTVKNFhL?=
 =?utf-8?B?VGhtWEFkbDVtUHdjeDBmWC9wQ2l4cFJQWGpsVTV3Ui9zalhjWVMvMHF4dlBT?=
 =?utf-8?B?Q25LRzhhWW5DbVV2cWlKeWZacXJsY2V0M1pibUhYQjVGL3dxNmx4TXpWRUgz?=
 =?utf-8?B?Nm05Q3NsSytKbHhqei8zOU9saW1RNUtIWk1xdUtVcnhXY0g2eFlVS1NzN0Fz?=
 =?utf-8?B?VUJYcnc4eEFPTUhRRFBLeEh5bThLcjR0Y3J1WFBhQitnamp5Ky8xTjFic0J5?=
 =?utf-8?B?UmJvS1VPK0RXUnNXc09nTVpHbzQxcks2SmJPSFZVeXQrRHNoLzVPS3pFT2ww?=
 =?utf-8?B?OHU3ZS8rQzVKTE12NTJubkdaRnJHRVFhMHduWCs2NmlSYklSdnU5MkJubVFH?=
 =?utf-8?B?Z2tXODk1UC85OTgzbW5NN0xSaVZuc0dFNEF1MTJiamtoSkM4Um9RZitaSEUv?=
 =?utf-8?B?a0t4Wjc2NEhXaE1RYVlOK0puWitJTEVuTm1nbTE0Sy96MjU5Z3FhUm5CU3lK?=
 =?utf-8?B?TlBiMXNXSnZNUVdta21qTnVacW1XcHplVnNVRXA0N0xIWGJHN2JnaXVhNmlt?=
 =?utf-8?B?RHQ1NXM0bjJHNUdxZ1ZKT3NOUEdSTTZOS2granF4MlM4czZPaHpxYTZSUzRE?=
 =?utf-8?B?bFdjNjNRNGkvNTMxWURnTVoydGt2b1NDM1BQYlBIZ1lTZE1jSFpnWHBwN3Nq?=
 =?utf-8?B?NUR0TGRmMXNWTE1HQndHQ3dtN0NZZUtXd1NuRnZlc0gvMHVrWlJmWmdVcnVQ?=
 =?utf-8?B?elNGdUlkaTREM0xnNGpTd0dzdXNDWmdJZXhqR2RqNTdDQ09MbVY3T2F4MmhH?=
 =?utf-8?B?VmloZCttRm8zZnZqRmdPeUFMUjQ3YUxIUndLNmhEZEwraXVmODUvZk5WMTBv?=
 =?utf-8?B?akNicVBDSkxOa0R3RWJaT1owUVpLeW5ZZ0g2aU5ncmxNSnUva2Jmc0FqZ094?=
 =?utf-8?B?M0tvZ1ZRK2Q3MG9EaXNQMS9ROVEvYnJlVHpQZE5jQkhPRU4zRnU4NlJTL0xF?=
 =?utf-8?Q?7NMyc61+pQB4Kdh4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2412b88-8cd6-4bdd-9ec1-08df1edb7321
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:18.9220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tagOdonQU+TO68M25v6d+T5622MIDlZbSAQNoLScGQ06YUk2GR35vOv6q7UgB+brVeWv8kLIXPCV7XdGf9HTzk3gMLp/xTJMlQGnO8WMZok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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


