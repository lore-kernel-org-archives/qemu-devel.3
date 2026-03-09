Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1754FCA17B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzgCN-0005qd-Rf; Mon, 09 Mar 2026 15:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBu-00057z-Ql; Mon, 09 Mar 2026 15:23:03 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBt-0003e9-9X; Mon, 09 Mar 2026 15:22:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wv2+7nfmjFgX71/OTEiJgEmyUL49Kb74uFmSmLdnxcU3ZCexPvtVAx8twYRp/TnS0UeZ9FQKCAbr7HtmQWwkcJUWrrm88iesbOFyxSdcu5+SvrRaqRYeqRlBv/Z7hfx2BJMF8PoNhgyWr++iXCEatP4aYBq2v4WuKsXTi6vpz/9cQC+HrDjHw3wF9LtxlpR9acMErfsLzJyiUdujXbaLE53L1SDWp/x3MQ9ytO7GHRQpuJPKRXtKvKZ4jswQ/MDBQoDMLRRYeiU4N9RoSpx2lcUgOEObAkGvP2qikM8OFIcu4nO4KhjFGf9XwQ5SdkIbbmMOmou7IfVC9p7wsDcaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbNA6p0hoNpfE8u7NfCJK66dZWA98WHVBJpEp2+06sE=;
 b=QGzccIR0QbqopQmRrnL9Lze3HlPZ6+Rc4zJ8yN7Q8JBgLcax4a7itae94POoY7AO/XpCRYlfHXFr2JsS+2ozvxSPWLlO/1shXfYFBq+uPvo7qcEs0mOwrTHIr/CLVtvJZcHXoPCdTMakdDyTE7/S4Wx8VZBx6y3tbiw/i8mPfzsYXeYXsekNiDqTV4+smUuQNRNOXnpXE+IdgmUjRWwnPBkIw0f278xe3LSRfC09AUwpxIDxUJuiVTwFaWpwbPymKtPVAJiOwHV/dkqprqGWpllQ+iE2INo1gToG39be795nrReFVWFCBy0KdtNIp46ZgHYg5p9iMMgYX8lkd4w6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbNA6p0hoNpfE8u7NfCJK66dZWA98WHVBJpEp2+06sE=;
 b=kVrg+Q5knZur5oKgmXHJIbJVyDCqVPUUOPo4nB0iluCDpVAHlmIBdGcgmjrVZhDiUT/DtBQVIIj6L0n8en2e6WuclZ42VYik5jEmTpbuFgI27RxD414UJ+SjvBzJqEA2nQZQqSD0Q4/PIKAK41+6qUq4VgMcxL7iOV+oEyRdBs7UwIx4R/HfgYfqqExjgJIDyqREi1IAFAYPknxesiLAX8GNV3VYyVoG921qOhCoYu7OIPvsGcXMJgy6YRXyiIiy8iEM478wzNS9JPyeg/cxVSIoWqbl2uEloJWTk/6n2Y97iUysjfawZ1ORYE5qnGxLJCzGXdsKV7ZPhiK5uu59rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Mon, 9 Mar
 2026 19:22:35 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 19:22:34 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [RFC PATCH 8/8] hw/arm/smmuv3-accel: Introduce _AUTO support for OAS
Date: Mon,  9 Mar 2026 12:21:19 -0700
Message-ID: <20260309192119.870186-9-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309192119.870186-1-nathanc@nvidia.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::8) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: cd8b12fd-c466-4df6-7b42-08de7e113756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: AB55cDJtIiGTjNwOR72HV7Li424yE1higz2OYqob+4zDQWWn2Um6djScrUaWM3Wv1tmVVaAUdF9fJpakRNYvQb+24Jmer/UngIH4q1xAq/mNDI6zhjqBQ/UnO6GsYaJVpqnIKOadTizl8z/Np2WBXEUC+J6Hp4bmsK7ZM/clW0jUap9bGYQ2AKv8rEV9AGymXfbHe7Nmmos0w72EKSB77zQaxYeIJVpVARzamJh2J7n5b5c2WkdYmp503LBosRRdXQCreLJBGcxPCJDkB1z0q7pus2wEY6K+00MErqtdG/xnxE8qN/KbId+x1u/fxhyifxFrlzTbWJsY4cyiSs5eqYFKAJKbDmlfln2AJU7f1phe5dfwTrsHGHKra1vDqUdQlfFUlZ4bitJRhUGbWP9ciXgGPoDVG+Ukyxz067zEmTc2GkU53Ih27yuZMz6y65kj4nJnDtG5VcMoE7l0d33VXLAmgOuJYa+ksfLKEWJbLLncepeGnBnTnSkDNeXN46fi7DprqgYk8Vj6k85XG5QZJlD6HicKVAY8kVvGBmqjJWQfDpt2fw2a1RL/L5UdC7ZniWc1gUEjLyd7F5vXhecMAKZQSULBlGU+G0XsI63idOTXE3A6yUPvnPMxefnq2SD7fj3cLOWc17HNZN5Axbk84agArPRS86nPymeIDOObqn0pSsSIcw86f/cmn3d3wezHl/QEWqXekv5MeXXLwiZyGLpniz31mZZ2ewRSxzPsWH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VzV8TWOs4ehVzwqsexSo2yFQI8OEyhPtN+yEnEQI8iHCiQE7PYWG05kUswhT?=
 =?us-ascii?Q?4AeebgW5ZbRay26XKqC76zs17UzECd95BY3Bla6apxyaw8GQUlRTmSk6cCh0?=
 =?us-ascii?Q?CS7Mpnfxp2Wjtihwelu0af/hFaq/JuGahcVi3/eBaUJ9PfpnHucgwU7WrNQQ?=
 =?us-ascii?Q?SNoGdLy311R4pspdNQr2fldXUxx1NAKRomqX/HoLrpJJvyrLUWbx9YsUSWFh?=
 =?us-ascii?Q?dfTzhwlKoO/Sq4VTdQNaUuPqOvRoVntfe3Mqdd6vw4GTZsy4aEWsnkl5tfHg?=
 =?us-ascii?Q?x1luYaMQYSmkFpnGUW21ES9926XmXh4DjiFXpnRRvWsL3fTk6Qj1qloYjaVX?=
 =?us-ascii?Q?hNJ1WoCXPVMh00wKy6xrYnoVZa7ujQLDRgXQauyfwgZ0ew1jv5srUPoRyStH?=
 =?us-ascii?Q?Q9JxT4APLWGLQpLwWszbokKalrYi1waaNegx3YLf/AqAcEuvTU52OD2DdQbE?=
 =?us-ascii?Q?zU1ffJLgZIXMfrzWB5WNIrTwEqtaxpIe3VtzIi+PpQypv6byJvpyLPFFPUHm?=
 =?us-ascii?Q?9PgcQIrYwBd4NCXlYkIompUz5gbBOgoggn8kKWjvBzBjRjE0VUDZ38Km+Und?=
 =?us-ascii?Q?EjLqZ6KbD6RisgKKbTf3vDqlWYZFnRWWmGloa5Cx+7puOyboDrC9wyvWj2o+?=
 =?us-ascii?Q?AwVBh4sBuCE0DPiPUMdSkyR+rTBOXcSFUW1uvt38EGnuAgdH5bR1EhbkN5Tr?=
 =?us-ascii?Q?iqfuXa3EM7wonEFhEnE23LGfmYzDUXL5XJfMeqs8yDK/U//tliZV+KGx5t52?=
 =?us-ascii?Q?JsHqxPjjJhdI+V+xYiIBNJUCT/cRuEC/J2eKkHlgH+3Th3TviRXv3RX+vrCo?=
 =?us-ascii?Q?gTdfYifn3udIYwK/wy0oovf2hZbsLzvyHOuofWYqEUlyYbuOCBRrbEcxix7X?=
 =?us-ascii?Q?QKlga+UJg1oj2mHKjlU/qh7+txr/8z90tEXjPxpHUf1Kj0kUq6Ii7g9UNsiE?=
 =?us-ascii?Q?9e0XqRLozguQfLVtfp3ywv3UawDyiSZRaS0vNzU+fjbERIz+9XF6X9R05f4b?=
 =?us-ascii?Q?ileyuzPu65USGobFnom/f4KFGjyEX3aDfF74V50DELhG2tRpdV27+cOiF2p1?=
 =?us-ascii?Q?8Se3cyLb80UI2gFEgT/Un4mxyvfbf9tGRAIfF82WwzLjYy3CIS5FJEU0mVvS?=
 =?us-ascii?Q?u7lOp9ZG5hIJXk1TnU+vxYJ9k+Sl44R8ntVoYYu14EUNPtTDd3T8Q6ipzoWi?=
 =?us-ascii?Q?1Ecutf9cnBRHUiL9TON8ZpNbLJC68wusFEVStr6D32750/qha8OKtVj/4Ag9?=
 =?us-ascii?Q?WX5HIIJecRVhVq7XKfCLNIfjq/7lr+dqhCgwqqDyaSJvHYa5e7wi0ZGZw8r5?=
 =?us-ascii?Q?TLjIsSyl5p7qPBr+RQ58rvXd8AwXtTj9p8mwxa1U3My85fpyYg7kYe1nJ3RB?=
 =?us-ascii?Q?fRPK+8CfI52MCVclWepuB9pibPtY2pqb+nKddi1zJZDEXMlqHOw37I+9C+GU?=
 =?us-ascii?Q?hlO1ckbzaMchHB4CEg7Z/CDt0ygOTbOtzP0AzOf4511v3s4vXig/F1ngQViP?=
 =?us-ascii?Q?Afbpic6Q0U0EiBSa0XKJNWogF+h3GQEpx/ilcOWGW75AuovuYGAJ9hh4QiVj?=
 =?us-ascii?Q?DwiSGTIs+MK5OWoAR/zdr7+a+0Faa5ISak/3dqBX16Ct3ieN1oeIrXg+gp6Q?=
 =?us-ascii?Q?OwPAzhZGEFdFXwtk+Bq640LuEzATJneMCL0+MH4G8Rktza/eqdFiMSvdkMwW?=
 =?us-ascii?Q?WOv+e0p1UXcTSOc+PSc//8vQKPpg/lK47bf7G6IgUrQy4xxo0K1xU9h65evV?=
 =?us-ascii?Q?mghPZztNEw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd8b12fd-c466-4df6-7b42-08de7e113756
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:22:34.2168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuHbTKNkNMlEL0yO+HUfAmvL60oE65fCCA3Lyi0Bt4IGSJf/FubLnKO4cWfavBB6CcyZvRlxWfK3/+bCtjaGGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nathanc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Allow accelerated SMMUv3 OAS property to be derived from host IOMMU
capabilities. Derive host values using IOMMU_GET_HW_INFO, retrieving
OAS from IDR5.

Set the default oas value to auto. The default Output Address Size used
to be 44-bit, but we change it to match what the host IOMMU properties
report so that users do not have to introspect host IDR5 for the OAS.
This keeps the OAS value advertised by the virtual SMMU compatible with
the capabilities of the host SMMUv3, so that the intermediate physical
addresses (IPA) consumed by host SMMU for stage-2 translation do not
exceed the host's max supported IPA size.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 11 +++++++++--
 hw/arm/smmuv3.c         | 11 ++++++-----
 include/hw/arm/smmuv3.h |  2 +-
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index bd27b0da7c..03950a4cef 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -71,6 +71,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
                                FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
     }
 
+    /* Update OAS if auto from info */
+    if (s->oas == OAS_MODE_AUTO) {
+        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS,
+                               FIELD_EX32(info->idr[5], IDR5, OAS));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -898,7 +904,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     }
 
     /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
-    if (s->oas == SMMU_OAS_48BIT) {
+    if (s->oas == OAS_MODE_48) {
         s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
     }
 
@@ -979,7 +985,8 @@ void smmuv3_accel_init(SMMUv3State *s)
 
     if (s->ats == ON_OFF_AUTO_AUTO ||
         s->ril == ON_OFF_AUTO_AUTO ||
-        s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        s->ssidsize == SSID_SIZE_MODE_AUTO ||
+        s->oas == OAS_MODE_AUTO) {
         s->s_accel->auto_mode = true;
     }
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index bc03353759..4fc4ed2c06 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1982,7 +1982,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
-        if (s->oas != SMMU_OAS_44BIT) {
+        if (s->oas > OAS_MODE_44) {
             error_setg(errp, "OAS must be 44 bits when accel=off");
             return false;
         }
@@ -2000,8 +2000,9 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         return false;
     }
 
-    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
-        error_setg(errp, "OAS can only be set to 44 or 48 bits");
+    if (s->oas != OAS_MODE_AUTO && s->oas != OAS_MODE_44 &&
+        s->oas != OAS_MODE_48) {
+        error_setg(errp, "OAS can only be set to auto, 44 bits, or 48 bits");
         return false;
     }
 
@@ -2131,7 +2132,7 @@ static const Property smmuv3_properties[] = {
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
+    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
                               SSID_SIZE_MODE_AUTO),
 };
@@ -2168,7 +2169,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "platform has ATS support before enabling this");
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
-        "are 44 or 48 bits. Defaults to 44 bits");
+        "are 44 or 48 bits.");
     object_class_property_set_description(klass, "ssidsize",
         "Number of bits used to represent SubstreamIDs (SSIDs). "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index ae8158a5c3..3bfee63396 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -72,7 +72,7 @@ struct SMMUv3State {
     Error *migration_blocker;
     OnOffAuto ril;
     OnOffAuto ats;
-    uint8_t oas;
+    OasMode oas;
     SsidSizeMode ssidsize;
 };
 
-- 
2.43.0


