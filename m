Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A506CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrJc-0000hl-Rn; Wed, 30 Sep 2026 06:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJb-0000gz-E2
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:31 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBrJZ-00045T-RL
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:13:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9HKZyjxGPSX76W3p+0Ll8A+qluvRHdsP5U5289mmI6aG35zXUdf9fzNK0cJwERwLZAbmoq8qI0LJNsdxrMm6+9Nb10kgOdE6cHKDInFonBpB1Zfz2dJw2Hoi8Y8QSJlQ1W+S+PINaattHjDs3IgF1HXLJbIGnOjybDLpSIYmnjK3jW6Ol01Uups0Y6hfFKyhG8mJCGLyYMocLh5XPy1PdARowiP7lhnKtoTHI8GuPW2fCqDBhKZ04fhZbfQ/lf84htPjo749UIYleYSUnKnC5yDje0gBWB3YZEqVmZGR+saMJDrN6bJgaBeYgwbRloG79J+rStcuN138K7SK1Xs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=JmCWBFTLKk5iiXNDESTxV85gt18SFrMDsiJzG0E7ZvHuP94LjmT1TQdlCK2NgMoYLoVB8gV/TswzEV7pu9V7UR1ROi31hUTZIhTLqFjzCTmbWGyn1enCh+8z6mbPUaFpX3ACddMyUJHSVH/nIs+C+a8aaeiqi0zMBjHs20wARdvnObvcEr1bi+JGnrrLHhUnFAHOq5/75xWtBBf4Vd6eEFffpfVBXvJLs9yB4oiTBfBH1YIpoT7D5/pUZ7U62Ck80E8InnejsiwKpVounSXKX8etVYzcJQ+O2XY4jglgqeM9ZQSoHS9IKbmO8913f/lp+uRqDUmcU/m9HyopTnY6LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5ksPgqxpkvwMZR46juSzPb3Jx553hY74OuSgtWMf94=;
 b=anSZ6eNaYD+CF1yhtbW3wZ7uYnRKzRz49AGK9bv2iVqWEdfgTr9wq/j3FIQCLLsPDk5r9bm9NM9rvTbS/PBWpFTzBAh+LlgWChJ3YASQ7AhqtCZIeIHDNIdYgu6NxtsySOcziC3Vu0rAo2Pr7OZb6U9GHdaha6Gqe7T9VLMCqcOafXimDies8+Tvzu5aqURx3uu3axhy2XYH+czDDhuG5/4r7GezNDAZEUb+F/TVDlMME4NvwW7bwVwwuNaOlQ9klPfYuL/7PXYd3DNhnTWmmBaABMLPDkrjb1a0Fy1idKiWlyOWCz66yLUA5e1bLjRa+RsRpimSmLhH76nhih8H1A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB6420.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Wed, 30 Sep
 2026 10:13:21 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 10:13:21 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Wed, 30 Sep 2026 13:13:07 +0300
Subject: [PATCH v9 08/18] vhost-vsock: don't reset connections during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-up-vsock-vhost-v5-v9-8-e9096f629770@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 50adb94f-0a45-4931-4f96-08df1edb74ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|23010399003|366016|1800799024|10067099003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: c7OlYdWvw7IX63I5SYDDA+FAATjzqISD7PKnEv8OQ1epXz7IXfvyKYCHVWAWKK9DyWVgBuFxi19/prITm0SFTEbiBT1zgK2DGAgvHifdl33ih3FczrGqQ6voWsNVLiNqvwWk8xIhdXujW0vBvXbv2/8ADkgfQ1Tr1MkGS94/kAxu0Md+iz2aXkow0nJbaoxYjzl2009u0OWE7a6Tvzg5ecNqUWF8f4c7JT35aporNx1esuOFCC+idFR0i9AnFUzmXPnN/g2vB8xmiDHUabRa4nkmprA0dg0DA6h/ylLaKl69u28kIa0YJoK8Z5aOhmervYpvyHAinFp7YBdx2xBZzr4bch4dEN3igNLAHXi6Hz55wbjPNOcsKimg8a1iGosjVSE3mp+fn1jDz2pPDH4e7KLMSXrounfsUrlDN/JmqweM/3e6cSwxzGa0YXE7yeV29abjOa60QpyM9sXdw04BRmOQjngJdxototKacQQP9YO9+NvPUW21F0HB0fKVizUTxSxeTmRVnM9nwStefX/TtNj2b+OVOpFAWzAxBoN9QLG32ETk84xYIQLyOOU8RxGYL2N6RI3EOjj9ysFIba7Fdv3yE8JtFMO5zdV08I9gvwTQSl8YCeAnTv/Tr+jsXqahODbbnEhSm62JIDsiI1PEPk2sC1qsr1UI/3mifsSTKWzFfjBGgkjkqtokXktyDIcJbS5dgj7hIMYyO8wFPg+ljayDLBjfVzabZnn0+DNqFME=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(23010399003)(366016)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWJldXVGb3pGUFZrbXN4eUtqSTIyRVJHTmlzakMxa1VYT01EbUNkQnRFQU9m?=
 =?utf-8?B?SmU2MVZYaHBPT2ZYN1VGK1ZDVkRuRWMwZW5ZVDM2dXVQOG9zMVJ4VjRFa3Ra?=
 =?utf-8?B?RUhvMTNhZ1lCQ2d1TlMrdnJ3OCsxUC90YlJETGhXbll0QXo3eXIvOGlMeExY?=
 =?utf-8?B?bE04LzZlRE9HWGUxdFF2c0d5R3hYZjd6V284MDl5VHdyTEtPWldDajBoUFF4?=
 =?utf-8?B?MWZ2M0V4ZTFUSTBWNCtITUxhRlNRcnVnamtnVFVFSHA5cTdpREV1Ni9JcjFZ?=
 =?utf-8?B?RGN3cEpnUDNBYXliVU1RZmJGR1BoY3lhQS9qN3hrSEpPbnUrcE5IRkhDeFBL?=
 =?utf-8?B?R1g2dk16bDRFbEFHbml6Mkhmalk3KzRGbEVGRFhlMWoyazQ3Rjkva2szcWpQ?=
 =?utf-8?B?d25STXZLNHVGWTVRZ0NWbUQzYS9EL0hrU3hWUGI2QnhpQzNFKzFsSk51U2E5?=
 =?utf-8?B?N25JVXdyNFFYVDZXV2ZXUGEvQTkxWHdZYVQzZURNZHlGc2NWUXVPaS9VS0xk?=
 =?utf-8?B?dndZQ1JGZG9NUU4zVUhnemQxRVZwM1ZjZ1dHV2VsKzZOV3VVc0w3VXpjRXVJ?=
 =?utf-8?B?OFpoR1BESHJRS0l4ZDVKc21wbzg3ajlWcVZIUWZFQzh6ckZYTFp0RXlQNXhi?=
 =?utf-8?B?WGN4TEMrSmppWnZOakUvS0kzd3ExRzhhUEV2d09jaHg4dHFiY0wvU2pNT2J2?=
 =?utf-8?B?SXhDRVAzajEwNFRKVUdnWHdCRXNUYWFhaEU5L2czbGRlck0rQVk4aUdhWjho?=
 =?utf-8?B?ZGRwTWJ6aEU1dVNHT1I0NTRYZlVwR3YveERKR2lYZEF1UnZpbCt0Rk95ZVNQ?=
 =?utf-8?B?bTZPWHBUOTUvTUVJcXoxeFl2bFJnYTlLVG8vWVRvTDNSN2ticStrTEtRWXJG?=
 =?utf-8?B?d01MK2VRS0p2ZVhDa2Z6a0NTVS9FR0l5MUlBT1JnQXJUdVFqc0crZDlZSlhP?=
 =?utf-8?B?Wk4yNzB3Y1hpcnlNTHRuWE9lckVXbC9mWFljbUpmMTFjZW4yMWJQYmc5Wjlo?=
 =?utf-8?B?Q0hPak5iWFpwbWwzckZKYkpram11V2thU0RTZlNpNjFpL3VabjNmSHhlaW14?=
 =?utf-8?B?a0xhd3FaQjlRbzhYY2pyUmlPdVorenVLMi90Zk9VeDdHK2doM2hTRFZNdUFX?=
 =?utf-8?B?R2dVL2lKenZoU2UzUUtyaHlwcmp2NjA0K0xLY0xOTGFMZEhQSFVmYnZpZHJG?=
 =?utf-8?B?Vm8rdzhuRWR4eGwvUzhTbk5VQzJQRmsrSFQwaHJjbGNnMHVqd0ZOU2lyZllh?=
 =?utf-8?B?YURvdDNtbk5PUEw3RzRDWE1YdzNkWUd6QkxDRWpEZ0hEVm91RzcwTWczTllM?=
 =?utf-8?B?S2Z1SHJ2MXV1RVpUMVZKY2pEV05ZVEl0Tmg5U2pNV3NpZVh6ZnI0aGJOa2o4?=
 =?utf-8?B?VlZCdmZ1NUpZZTNYbUl3Rms0QVBweUZjUlBRUm9veGZhdzc3OFp6RXNINUor?=
 =?utf-8?B?SG1meUxEK09oRGNIOEM3d0pmYXNkM24wVDYwVFl0NDJQbWhwYUVZZXphNm9y?=
 =?utf-8?B?T2JzWEFwaG9PM0tjanhQNytWTHNEM1ZGemtrbTZpOXRCT3BIZnp6Z3AvZ1Rt?=
 =?utf-8?B?RG5jeUpiSlRFM1AvSjY3K1JWS0thZ1ZkUno0YmtTaDV4T1cwaEVCYlZ1R0RS?=
 =?utf-8?B?OTBsWFJJL0pHM0VmZTBMNjdjbFJQZ2szTU40YlZKaG1PWC83N2ZEd0wvdXVG?=
 =?utf-8?B?NnVGRVJCaUFUUGZUL1ZqVVlOVFpKdWY0cGhaYksrZmFTYmEzYkxhRFJ4U1ZL?=
 =?utf-8?B?amk3eExZMVZCVjlDRkdmYXc1bmpPd2hTWUx4MWZkNkNxM1lJLzJxWGVTL0NO?=
 =?utf-8?B?QjRlOHZHZE9FclU0K3hPcjdqUmp5K3lxWjZWKzUzL1NrRDk1ZExMdjZMNmZH?=
 =?utf-8?B?S2t0TlBsZGczZmpRNXVxUkExVGtUZTVZQ25sM0dxWHZadnF5Y3lMT01Wd3lw?=
 =?utf-8?B?emJ0ZVkxTjdNMzUxSlE4Smo0M0t4akV6OVlzamxNOCtzdS9aelpKVVliZUsy?=
 =?utf-8?B?cDFZVjhyN3VDcmtZWkhrdFhTSzFyMG10OHZKb2dsRjlpZC9CUWEvK2MxZ0dx?=
 =?utf-8?B?Zi9FSHRuOTkyUkdOZlM4cWZpOHI2RFVVWTluL1loNWpNdFp0cGF3eFlHOVhy?=
 =?utf-8?B?M3FBc2lhYVJIMDV3RnR2M0hYbWpnOC9BWEtWZGJwYWpiUmtnOE12SGxTUlFj?=
 =?utf-8?B?dTJNUjVtZFVBWGlONGlyNjQ3elh1eTJ2N3BITFFkNnFhVGFlWFJXQkZ0U3BW?=
 =?utf-8?B?SDJnRVZaZnhZNVBhNXFlbWYxb2QxQzRlWXJpNkprdVVFR296b1RQb0FyNmJz?=
 =?utf-8?B?a0lvSFJzSU9IajhDU1loSDhmTzNVMlUyR2Z3VGdYa2FJVkZyc3U4dGU5YXpp?=
 =?utf-8?Q?XHCJPT3jiN52Z6BE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50adb94f-0a45-4931-4f96-08df1edb74ba
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 10:13:21.5884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Wjp5iJjkxWbn3lMG83YVJhLQht9TYwCz9D0DprXrb2Nv+4TrlxBanrssm995rljOTcqwrVK4975FHgVbq0SVrN14yxHaoIcle3dFvd83eQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6420
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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


