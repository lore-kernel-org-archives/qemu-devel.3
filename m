Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384F6CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWe6R-0006eU-VU; Mon, 08 Jun 2026 13:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6P-0006dk-Of; Mon, 08 Jun 2026 13:49:33 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wWe6O-0007Bn-4n; Mon, 08 Jun 2026 13:49:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1/6y4Ll8Eiy0cxgQNv3pvcY/S7+8qVstKCGpEqLh/lA5G/etpcxEU6JAhjhxHPeyi61c9+7LqBFM7i9zYFl5CHOh81ykJL/2EAnK8PyLcX4izJdnrpOpGjEH7S7EH2L2+SWxXwgqLMUW444zyFr+RjpoGHAvgo+zNeCiNwbOMvKtVqTv0sXp/Rg0FWx7YCKzTDk6LwBZnl4G9SU7jONoCxXbO/dG1ci8HypIJaSlyZ2LSdgkI13rk2WwovNbEidl1R1cy0SxTuvIjbrSb+foXMelL2mgH1zzv+nESG3qrvLvNLhfQTdBNe94UNwZ6aqDbMqlG9L2gEnX6QeDkW+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hY8iZz4ttOJgjcp3lzn/kSQcIbvJTBxlwQ+4/ZQVWgc=;
 b=vMCRd6a2P9Hs6Dn8oWUsS2XcuFGJNYyF0D780pxbqEgKdxXAXgqImujnKFnoGiHoylV//9NKrvoQqBKP/8oqB+3DzTIgv44fD2w7W8U8EfH2tmozNFrnEU24Cq+Iw9/m9ovXCsRYSDnCZz0tN8tZe5Ma4b9JqaTItfpW6QLs3Yqdzh9IUSCkz8S0bZVdp4rcHBnFEJJpIxEZ3bF1ixt5rHwFmpGbiW7xlsp/WW7IMTtuYBUIial2zNMGqwTuZzGmlTw0C7P0X6WJ+0tXX5VJIJS3vxrft0PURRuELrs3IhJ+25XjgaeejKGzmqwJ/O4pqbWAIWT8M5Bof/XAaz/Img==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY8iZz4ttOJgjcp3lzn/kSQcIbvJTBxlwQ+4/ZQVWgc=;
 b=LU+CipfPCxU256DabY3gFcCDU2NtF4FEK8HwYBJKZ/W6/njesMyGg28gtaZGEn18sFS31kNXrT7WH32fwLZIcTh/hrDL69Eh4ZR/JKrnyrtymlXsCVce8aXolgaHoye4BquxXLh7Vtmh66Vltk39EwD3ZbqqXt+ObURG7+sijE7wuNUyBXW85HkbieUj0fLWwp6sx2dL4iayg8ZNQH+QMosaLQTmZz5Q4mpbxApLuVgMVuyql6kgpNO7vwzJ9uy0/ubv2A86PrPy6iVHxhYBofkD52uqI2ZrJDqYRTnbk2+1WkNgOJn9vbLsb5sCV8/7Od5+NXgkjUOd2bBN7VFC0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:389::15)
 by DS0PR12MB7969.namprd12.prod.outlook.com (2603:10b6:8:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Mon, 8 Jun 2026
 17:49:25 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::2815:c27e:a0a:2720%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 17:49:25 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v6 5/9] hw/arm/smmuv3-accel: Implement "auto" value for "ril"
Date: Mon,  8 Jun 2026 10:48:56 -0700
Message-ID: <20260608174900.2227340-6-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608174900.2227340-1-nathanc@nvidia.com>
References: <20260608174900.2227340-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::9) To DM4PR12MB5390.namprd12.prod.outlook.com
 (2603:10b6:5:389::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5390:EE_|DS0PR12MB7969:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c725a1-f444-4faf-98ef-08dec586478e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: yTCAlEU1yJ2Bxk8mURdkthMXFNkOuVq/9cWbJZo/h5hK9cLezWQ2I7vvoqpr/BYPW+BtrRvkyPKFqlyOhLIfq0wNN/pnvUgUhP71d0/EbI9CWTCzGC5L7Y47y2gZhHfNT36TmyzKRb++UvbuSM69E4nOG9hj0G7Gy+56rPC7IIvKbo6xIbrm+82tQUj25Fk5OWw2q2QV4uN09AYVy4SotTKx9nG6P+rhqTHtFrdcUYu+vYhyP1xM65MXrIs+E1ZqBKobs6h269OOR/puekP0a7kkg3KGXykTTI+3LqjCXC41TbS4QhbvDeOfa4vwaWigRD4py27Pf3CIF9Xnv4r3sb0a+Wg9CjiuBq09XlaYFkTtLK51Jgx3DeD61zaofaq7GH6OiWHMRT/iRBR2Bw+COKR+rm9cNx0pzOdS+XnGvkul0Ehg8UCquNlRvGNbL+GKkVosAvJUP5n7Id8dUBkrMAMtDG3IFnAzvn5UHWG3Zgbs5VzS7jLr+o9y5TK81dqjqRXK8CV5CwfHhiwl5VW1aZ52TKWJ9D6RlRv0z0230UGE08FU1ytnmu/WXwRl1g9McqtvvKWcnOsDCOsW5dwnxnIoce2N3Q9qqjym3b613/7571I1bKJzzxzBS82ETWSLlrmoLrtAb9lGrD4MdmhnBq52zuWRucuOGnOUSRI7LoL2ACt0dcPRCto2S461y9Um
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5390.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U64xiDH2ALibXLjmD9zZ9wJRQKbUVgBJivHCqj7R0EVj1aK+O+U4z+hXXMKs?=
 =?us-ascii?Q?rDPXZEfh1jYrsStYKhDOP3ebCjyyiUR3CXEAfsj5wwMSABnBXuI5SHfIF8NR?=
 =?us-ascii?Q?gDw5s0ZGCUFNf3hWU9rteknAp1W6MkXhsgPKvuXF8ppTRQUUQKdnAzaDy15w?=
 =?us-ascii?Q?Z33J7o+gXYFPKC087BI1qLQoGz3ogXJzsa2ewLufOpeBElcsdEPR8/klUKx8?=
 =?us-ascii?Q?hqyFjIEff80hkW9wxXVMg4MmK6pLraBG6O0fVay9xoAj8tMv5gFRgz12rpd3?=
 =?us-ascii?Q?84ujoXJb8++OwXsg8njKQe5B4K65LOAQ6GiBRF6lRcQkWkFfyYZ3zUWPh4Xo?=
 =?us-ascii?Q?KLbOBZhyPFNbtILazfJTXVATo4wGzEgFzCnWofvakesciHg49Y45J9lrmXGp?=
 =?us-ascii?Q?LGJtGlfZkpZx6YCGgXTx/vKmfstc9O/hn4t19mld9shYbYxesWqx26QkMkAG?=
 =?us-ascii?Q?tUy/G/1iEKWgwvQ91iqGTxlDXPaVb/yKklUjP4EH6VkYUZ0PeNB8XVV+TshY?=
 =?us-ascii?Q?o9vlkwWoHRZnYTUNRxkHiPGYWjIf7HPKYTBJrvpWOF7jTq0rzXFU9mKlmGrK?=
 =?us-ascii?Q?EcRAkTqsaNwMau4I/xV/MgiuYQot4hyIV4miu0ATHp/X9x+mbqnb2IZ42cqi?=
 =?us-ascii?Q?pMaXS7WF9vjyDuNMAuRu4iaNxon9djJ8Aor1BLhj3Jy2zSlONvPVqUV4udoR?=
 =?us-ascii?Q?VwFHuBzX70n8Mlpe/lTYTe7B0IPSxiCsB1On74hF6Rie4+WHgMkWCePl9RQc?=
 =?us-ascii?Q?ofNuU8Red1KvNWU1bbmIuACK5Pg3KE+OuGbXvxrEwWq8OdVbTiJznar3TLjk?=
 =?us-ascii?Q?IowUr0sLqTulbb6m09CG4SVVQ6iYc5F5XqjYcEMGQmmKbYuxUS6LNWBI3sr5?=
 =?us-ascii?Q?uPPl5UDHIudcvogvmQYnQJyaBmySoWP2oSIKMMj8NujKfkOARSwZOAyvoubg?=
 =?us-ascii?Q?p+LZqqgnwuuCh4rVmEDEVYZHHpeWBjwPaEz+jgota2k3TjfQFuBCb2lXnFCR?=
 =?us-ascii?Q?q6lgCIiv8uofkhRRa2Pilqa1yH1BabUEweMjhr/GmiRnJhn03/Dpw8bf37LY?=
 =?us-ascii?Q?lOv1VNsaC/elvCrrVJV03ot2I0jDVSKevMz6V0qlhNl69UOJcEP2W9Cl5zKc?=
 =?us-ascii?Q?oLgYmlakIEwh/YZlVhtByaS3XjMVPkplFgBUNmDi6FCFLzTfrByiyl5lQ0YC?=
 =?us-ascii?Q?u3tQJp6GkcHsYlfOvcsCL08k2NLzpRnN5u7OILYKlubbblN08uKHy8HtkdBi?=
 =?us-ascii?Q?n3FNpQ4VIsbWonb/HbaoGwzq+Qn662IEYG/egIAIXmr28N51clYeGRACAjij?=
 =?us-ascii?Q?x3w7e8df6EWV3WUPR6KAGypv5pZasqmQDIkFB+CQVUoU1lBMAxgB3wtwCkBJ?=
 =?us-ascii?Q?e6HzKN2ZpnDiH1E7MEzLGJpM0rPtd5w5bY+0qDpMKzX/Fjc7eXCXw9OI0jtV?=
 =?us-ascii?Q?DiCsPPwj7YW7HLO6bh63sFbST4nUCwtiRukxSR/j3U+Bi6thNelj1nqXdR5N?=
 =?us-ascii?Q?XUO4KfyDu3apSL+FWvpYajfirOuWIgk4D2+N6LMFG8+N/4/dR/Q70d/FSLe+?=
 =?us-ascii?Q?hCjk4apunrc9ngVReOIt//nSdj8brnaIMqbfRaUL92Yv9e919sbGpUrUI+1n?=
 =?us-ascii?Q?yHZ/vN71A/gysvbPMkFuSCZSDLR6UxynaF17MqENRb/QPA8JVJIad+f8GOBJ?=
 =?us-ascii?Q?tfkjtZAN2un94rE0SY5GnI1hGI8EkYIUcD+Ti5WA331fkQBkHwQd/gnnhWq3?=
 =?us-ascii?Q?9zgOPUDIMA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c725a1-f444-4faf-98ef-08dec586478e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 17:49:25.0956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 64KmOg5KsbpCBOJO+S2qtUYfIdgTmsLzYUptBRRFWNG39QQzuMAPOAu5JXvMF4l2MHxTZQZAjtOAtTg+fduyuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7969
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nathanc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

From: Nathan Chen <nathanc@nvidia.com>

Allow accelerated SMMUv3 Range Invalidation support property to be
derived from host IOMMU capabilities. Derive host values using
IOMMU_GET_HW_INFO, retrieving RIL capability from IDR3.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c |  8 +++++++-
 hw/arm/smmuv3.c       | 10 ++++------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 4c2acbbedf..25699a1317 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -58,6 +58,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[0], IDR0, ATS));
     }
 
+    if (s->ril == ON_OFF_AUTO_AUTO) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL,
+                               FIELD_EX32(info->idr[3], IDR3, RIL));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -966,7 +971,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
 
-    if (s->ats == ON_OFF_AUTO_AUTO) {
+    if (s->ats == ON_OFF_AUTO_AUTO ||
+        s->ril == ON_OFF_AUTO_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 436155d883..c183964b2e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1965,10 +1965,6 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
-    if (s->ril == ON_OFF_AUTO_AUTO) {
-        error_setg(errp, "ril auto mode is not supported");
-        return false;
-    }
     if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
         error_setg(errp, "ssidsize auto mode is not supported");
         return false;
@@ -2165,8 +2161,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "ensure the host SMMUv3 supports nested translation before "
         "enabling.");
     object_class_property_set_description(klass, "ril",
-        "Disable range invalidation support (for accel=on). ril=auto "
-        "is not supported.");
+        "Enable/disable range invalidation support (for accel=on). "
+        "Valid values are on, off, and auto. Defaults to on. "
+        "Any attempt to turn it 'on' while the host does not support "
+        "it would fail.");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). "
         "Valid values are on, off, and auto. Defaults to off. "
-- 
2.43.0


