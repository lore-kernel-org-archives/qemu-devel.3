Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EBFCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcw9-0001YV-OJ; Fri, 02 Oct 2026 09:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuO-0000qY-7T
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:42 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuM-0007Qg-Ls
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQKu1KOR1lVbxGZynCJOfUkC1eFpUPlq/FdtzNTwV9TdJkKiGMMyICpo9mPRBtmviEHLzAtChqrwpxD+gjBqjSKT95FGWumZSYR6KMB999cDoMthjisDZPhxon4fQf6qgqUj+yAW9UUXR5bvuVsYpOOEonB0O9LrTwd/jOWSL7p3War1XYbsdpDmLw3XHuq3oHjy3x3kmCN6bcxpjFNdHUZHrLcDOOqojJKqTbVvxCLzxk+Roza9yVUnaqfCZGsmbsevTKD2cD+k8VOxx5WvmnF9z1tsItmOhgExA0bZpoj8VJtF5E/fYd3Kjpzw/NgV4UjyqVGsUH18l7UWLE53jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=cSUMgiuDI3wRvX1WzsqQiH7v9stn0M685zSo7WnVkAdcYeavi/n8Q6Fbg3Ao9U0Qd7nxZltWblyB3RyGtUobmDB3iw0F3W1lxaBQe17Wn25jjSiy/N4GHl51STeAhBLtxepo4duZAh9vm8AXTZqOYhmKbh4JVhwgURNDr5rTl0WHEczdd15SkUYGDwBYJx6Gqfvljwh9Agj52zoZM3OVTCeeDv0ekeBEsc23EI9e7/XoEfqHEHacHvHCzMVaP28K9RFFagDzkigw/J2sV7Vz0Muj1XW41qjK56Zd1dhX0Ef/X/BeXxbZBSAav5Ok3ANvdmtFUvwv32P+3740LzYmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=Zv9K8sJ28gxwESXToxd3666Kk1SdJ/60O/SbsUJNWHZSQEa5XZ9FzY3P5umKq9Edxbrn+dgVaqblukj8mvOManxz5W/ehXxyhClF/8o1q6ewFuRUypMYy30iEi2FkGM5Qu5AJnwFzbnKCJ9No+o3xIm8Fii+fqbhq/7KB1dY3mzYof85FY2VGR22+rhuYyzgrrqhQUEDhK9/X1E+bM918qbGjnOkTSGwqZCnC1kozyvg+szZ2MJTfGCpIkqLXAj0mj7g6R89SgMf8F6yF6QAbNh5STSUvrVi/+3vm9og/YFiiO5g0wVlnZpZ63w85WyOlIn1dCEWaEqyYw/u077P6g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MIWPR08MB013052.eurprd08.prod.outlook.com
 (2603:10a6:290:e8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 13:02:25 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:25 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:17 +0300
Subject: [PATCH v11 08/19] vhost-vsock: don't reset connections during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-8-18fa09d8273d@virtuozzo.com>
References: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
In-Reply-To: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, andrey.drobyshev@virtuozzo.com, bchaney@akamai.com, 
 dongli.zhang@oracle.com, vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org, 
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, peterx@redhat.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0042.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MIWPR08MB013052:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e33e46-4141-47b9-ab0e-08df208567f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|52116014|23010399003|366016|38350700014|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZCm7SPRv8XFxnvpXmKbI7Zu4LUWYI9sEDTKQZLhFFnXTOinr285nQL/dKC3oal4afzzAPl4nUUe3NYoQ/01Fy2AXhcvBdBNvg3Q7lK3HYKSbzRmB5ELVIRoZa8wOg8JqNbPQl2r6THvXuFHW2XYnyEBydTmZiA9ZwQXQSM1A5IqyvKaU4AnovrHCSY+qiVjbmTPLSY5B8xNITrsdk98YYEGij3aUANCRnrfKYMYvjJtRDnFxE8A55vjO8iTOai8dXb1tm0ifIb7u7f21rWbf2jCya+qngb+Gilvdwf7kttyj6XtQPMGa+T6l1wz11ghGJPe+eexFciJwbWb4Lu8BF64ZQN3HfUcZm2JOJ8sSK4I13qIB+39drzd4EQL/rfHtx8Rjvu6yquw3IfnaqIaFxb7Xzez9zB7NC2Vc4LlLMULa7PSCJybDqPxrMWXJTquunl08VeQKB4v7o1v1xAOUNOj3UgYK5byg/jSoBx4PBFI8V4TtIwp/lnM6XiUz8pqmdQaXbnS8rrQLpO3d2UFiExdkS/I1MCS17w7a4j3S7NWc/9VNzM7oGL4oeAxFiFGmhOeEs3oh/xm28RBVxZlsNO9UOJeJ5E8+B+iELSjluwvo0QL74TyRSYy16G2OAoHgavc+iwEvD7tN0gaVAiCKJ6yeV9VN7X9tNYd9BhHafTPmk9z2etepaF0ni627k+1S4t9FbW6CwSqPXJAYSwej9OGeuC9sx2wNwCNFcQnEXZ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(23010399003)(366016)(38350700014)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHRPT0ZidzBTZmJBVWU1SWxPYTBvaDg5Y0YrOVhLUHdRdzJCd0NwTmhvN1g1?=
 =?utf-8?B?aTVscy9wR2NON1Y0OHdUM1dTdldvUFBBSTVUMnZJL2poOUpvQm4vaHV6ckJF?=
 =?utf-8?B?eUYwdWYyVTdjN1BXYm5ZRHFEV2xnc25hRmlwcEpSQlo4Z08yWlN1YVBUVFZ3?=
 =?utf-8?B?L09uWFdRdmNRZ1ZHUEhVTkRxdjk5MFdrektBRGtDUlFJOUxRTGo4aThBTlNP?=
 =?utf-8?B?d3A3NmhiNmJ6bUNTTnViTWQ4eTZhRWI5WDVqT28rbWFGV0V1bzJhY1ZnQVVK?=
 =?utf-8?B?ODRMVHRjQ2lKWk04dzFQWG1FenhLcE05cnhmckxVMVYxNGFRR0NxQzQ3ZFBj?=
 =?utf-8?B?YnZNNExudjNzTXJWcnRxNXExaVArQUYxdkgrR3ZPTjUycmxmWk9QZlhjS25C?=
 =?utf-8?B?SC95VktBL3ZJdmlUbldmUWQyTG9jdW0rSUJsQXBGaElPVFovV0dpcnljMU56?=
 =?utf-8?B?bmxLeDhHeE52OTU3UW9Kb0F0UE0xVDBoVC9wMzFPeGIwQk5oQklOcEdCV25m?=
 =?utf-8?B?bi9LN2orVmxYZEI4cWlRMkpTT0FoV2NJcVZlNExTOU5WSjJFWEg4WnhOQXVt?=
 =?utf-8?B?UFozZzBlWlZuWk5TTnhqVmNDdmtzeHBnampSS1lPVjZLdm42WE0xSHlXSWh3?=
 =?utf-8?B?THBSYWl6VFdqbmRKSXByNTQzNU05V0xOcUpuWmx1SnptV3BmWWJ1UDFtY2pY?=
 =?utf-8?B?L3RheUVoN0h3VVBLTFAzdXMvNDFvQ1IyTlB2M00xdExXT3YyNUJyai9mRHdW?=
 =?utf-8?B?SWRoSVFzZmZqRElGd3ZTSTRoVHpmQ3cxUkM0SjNUTGlrVkJmd05ha25Velho?=
 =?utf-8?B?MkpWdnkyK2w3Mmt3YU9pQWtaekV0MHowL1ovNHV2Z2t0TDFpaURGWWYydUFB?=
 =?utf-8?B?YjRkZlpmaVFvVE42Sk96L1oxK0JFcDdPS2w1a0YzeURCWmp0Z3BvQVFEZ3hJ?=
 =?utf-8?B?dlBnRklDNGJkU0dJQ1lQeVhnZGdFbnlKSjBvOFVibWg0TmJKblh6OE9hQXJ0?=
 =?utf-8?B?RlE5QVFNR0paekNmUXZXQ1dDMU1NQWsxQUpmRENCZjdJMGVSQUo2dWhQRExC?=
 =?utf-8?B?S0ZHbGtPK2dteXdJK1cySmxoSzAyU0ZCT1NaKzNyOXQ0dWVwYUhzVEtJbVpI?=
 =?utf-8?B?ckdSZmRXUTBVZEsrSFpIc20yRnlmUURzNGVITERrYk5wUmxMWG8vNDVTT2lD?=
 =?utf-8?B?ZUNHQzJSeGFxN1ZGcnM5TUpNdXBHUXV1clNvaVFQd25CRGxxRlpKS3hvREtF?=
 =?utf-8?B?dEY5Tjk1SEdoYUtLZk9ia2phOVAreEErTG9qbk1CZmQ2Vmt4UnMvcnFiMElp?=
 =?utf-8?B?Ly9UeHF1OWJ4WUJDRkNwUmpDMWM4WERSSjBjUy90bVVoS2RxRm5EbHRkemZ5?=
 =?utf-8?B?bXY0UGpTSTd6Y2dJdTRIYXVqYncybUpjMFJpRjFvMGJUaUNLZGM4Mmx3dDVC?=
 =?utf-8?B?WDg4OHlySStpb0ZXMTlGQWw1NFllZHpvQ1Vsc3poUStkdkpUUjcvMHlpRnB0?=
 =?utf-8?B?am0zazNjSmI2NmoyWnQzcms5eWh1byt3dk9XeFhjY3ZjRXVkRmVIcDNDK2g4?=
 =?utf-8?B?ZEN1S1o5VThWNmhnZyswTFFCMFdDazM3anRWam9TMVRPOU9DNDY0dlczaWp5?=
 =?utf-8?B?Mld1V0tmM2FhLzZHMFVDczk1RW51MVBpRGFndnJOSHM3b2MreHM4L2NERmxz?=
 =?utf-8?B?ZktxUDcvMEI5YjVqNTcrdnl2aG9aT2FGR2VSaDJmbUM2a3ZzWUkwaVQ0Tkt3?=
 =?utf-8?B?b3ZBdVdXMzV5MW4zTVA5VW5pVDVCZDRiR1JiVzRHZVNtVmMwUkI0T3QyTG8v?=
 =?utf-8?B?K3A2V0xpUGxJdWhtYWloN3J4VXJVQWxtRlN2SnY5dWk0MHhqN0xpRU9OT0ho?=
 =?utf-8?B?RTZrZUxlUDhGQXVBMHRyZmd0dms3N3VQWmJmblJLbE1KL2h6WW5oNVF2VmVq?=
 =?utf-8?B?d0RJdko0c000QzYrQndNY2VER2QzeSsrWmw3YUdENjhRcjZkaVNlcFlTZDNt?=
 =?utf-8?B?SS81SzNRM0VOZWhLNU15c21GMGNPVHJOa3FiNW9aU0c4STBhRXdLcFlaSm5K?=
 =?utf-8?B?VXVXcS9HYTFsZ2tCeXJqUldUc05TeElRa0ZwZE9NajZsdmhzejE1Ynhucnlh?=
 =?utf-8?B?VXozQ2puNXRBZmxVcnFNTjhqZWZFdzgwSms4S2ZKblpKcGtvM3htWEdXVWRw?=
 =?utf-8?B?MWhhdmE3UjN3TXNkRW9LajRMekdQS244a1E3OStzL2ZjaHJGSHpaSHlIZElR?=
 =?utf-8?B?bmRUMnZhZEhnb1I0NFFQR2I5akRZVE9MUnppRUc5WGxYRHZ0SWFEZEQ0RTQ5?=
 =?utf-8?B?QmdQUk9TR1BkVkVPM01tWnRMZlhJcmZZQU9jQVNreUp1QWZTaHJNREVGNFBT?=
 =?utf-8?Q?MQ4HC8+1aPF/2JRY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e33e46-4141-47b9-ab0e-08df208567f4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:25.8128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gs61j3pH4vWO8spezbkJMZfoc9kge3xCF4pS6S3SPMunlUmxJjMW+oyD2oCMOPW9Jks+cPRetbyjAszZGnDGdPrafgkZCBIl7ESJgnr7KVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIWPR08MB013052
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

Migration target with a vhost-vsock device in the .post_load() hook issues
VIRTIO_VSOCK_EVENT_TRANSPORT_RESET event to the guest.  This results into
the guest tearing down all its vsock connections.  That reset exists
because after a normal migration the cid may change.

However it's not true for CPR-style migration.  In this case cid remains
the same, and we want the connections to persist.  Thus, let's customize
the .post_load() hook to skip the common transport reset part in this case.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 503d248a617..c582ac9fcc8 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -20,6 +20,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/virtio/vhost-vsock.h"
 #include "monitor/monitor.h"
+#include "migration/cpr.h"
 #include "migration/blocker.h"
 #include "migration/misc.h"
 
@@ -110,6 +111,20 @@ static uint64_t vhost_vsock_get_features(VirtIODevice *vdev,
     return vhost_vsock_common_get_features(vdev, requested_features, errp);
 }
 
+static int vhost_vsock_post_load(void *opaque, int version_id)
+{
+    /*
+     * Only reset vsock connections for non-CPR migration.  For CPR the
+     * guest cid is unchanged, and the cid-change reset would otherwise
+     * tear the vsock connections down.
+     */
+    if (!cpr_is_incoming()) {
+        return vhost_vsock_common_post_load(opaque, version_id);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_virtio_vhost_vsock = {
     .name = "virtio-vhost_vsock",
     .minimum_version_id = VHOST_VSOCK_SAVEVM_VERSION,
@@ -119,7 +134,7 @@ static const VMStateDescription vmstate_virtio_vhost_vsock = {
         VMSTATE_END_OF_LIST()
     },
     .pre_save = vhost_vsock_common_pre_save,
-    .post_load = vhost_vsock_common_post_load,
+    .post_load = vhost_vsock_post_load,
 };
 
 static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)

-- 
2.47.1


