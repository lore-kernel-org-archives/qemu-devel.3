Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D979106ACEF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nCN-0000rZ-7q; Thu, 12 Mar 2026 17:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCI-0000oG-4H; Thu, 12 Mar 2026 17:03:58 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCG-0002qm-HT; Thu, 12 Mar 2026 17:03:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJE9AF/+7F6kvBcpE8zxkk+1v6WQiqg7j198opXdAFJsbCYj6pSr6abe3mdjo5wWZmDRnB7xXWmI1/2GGPHp7VhoNNuN8o+l0QHChh1gXM2nlnkPxApRPcwr1ypLYUtaDeQ7BPkTIIYhJx94XW9XqsJREzJAs+3mI0vhz0jxl4ZPmxXelniqnHvItltWiY3WDF5URp5h3daQ6GtbxxTWB7Mfst4DclvnqPVNxh+4ty12T9QYxbiW54OSWdH68/YYdzF9bfxfdTS4+C6qP+NE56euB7IvsF21Kc+Gwn/O0JnIijH8KddIc3Z3lZrp/r9k6a0NDw3miXFOyT9jt8Tcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCD7b2eJe8KqR9M4o0e1QWk4MFuntMjW3WnmSgZc0fY=;
 b=HP1yIOMuX7cTsf0hMfjCHzcximfXqG16MKx5NArdhfxOeHeMhZxMFYtCmvZK9kYw9ESHxK6CzneooEgMrkwgK9c9Nt2czDjpeV3vdFgsOjtKOlofYMTa7ZSdKS4EpdYe3HHYD3vF4r6bhvj6eCwKlgPO34mu04e62CUA5eC666we/jU36xXiRHUJ/9YfpQZ7MVPI9/ckUiujxr+tqa7WAht83f6rGXYS5knKX1+ijgDaLVRTfNsn7zj+dPl9exMY5KOD925GYuZpvv7TOX634NW5IPXbFKmgPZCP0YxmdzLY1J6ofhDN/ox1tIVLjKh9tyoxZn3Ak+hvMyfYrYmcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCD7b2eJe8KqR9M4o0e1QWk4MFuntMjW3WnmSgZc0fY=;
 b=Tw2elBEQ8BaLbdOwpyIDk9KARXzR4w4mOqqmiJGYS3Ow0X9r1KT6oG6EVZtmMcH8wtSuXoZM8Go60MtnvmtI0/fs0YFhhU46B9BFmnr/gUZOGhoUTDAE0zSSFuXXw2hG5OB29GGC90ZOvG2f/e0CWGl/zbp5QymLVer3pRdleTJLVPS1CRzXxrNmfaXIi0RhayWC/gNO7SPjPf0FTyvqmfT5kLCdFqcQg9MCpCSUMqi8ph7VByCpNVf7ixvHmpLxB4otMhh5IP3MxBQlCGoh7QZism8U5ZVe2lTQZMp8TO2aeb2F6u0QM8QhhCQoFJovV1cuyZtHCCMPNiP6i1FXWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 EAYPR12MB999156.namprd12.prod.outlook.com (2603:10b6:303:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 21:03:49 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 21:03:49 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v2 2/8] hw/arm/smmuv3-accel: Change ATS property to OnOffAuto
Date: Thu, 12 Mar 2026 14:03:21 -0700
Message-ID: <20260312210328.2016191-3-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312210328.2016191-1-nathanc@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::11) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|EAYPR12MB999156:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e136733-86ef-4ab3-d38a-08de807adbb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: symiH6z3UwMueYTJFzSMLnyapmylF3IEZ6BawkmbhUxhWBqWkd7hKRhugPHx03fDzF+bWfFhZJWgvp2gf/9f2KmTDImvQgGAQw45UOOpa28nPysSIB9Zda0yhxC6t2PtXWAGBB6Q/j3wbgK9TxSzKNic3KcS+w7tZvfaDz8/A74PrvZRQ/V4HqTpS4Cu/WpLkTfQTmmCu93XasmnLZ2Y4lr62vh8oyo3ysSZeOSTd5EEbiuBgwiJWOSCLGkUVxlXpkK8VztH1IDZv81YOtmY+uoydyF/C9FNeEp72RD3XRdBlsu4NjcrWyrhqXT2MhgOk1sxzr6w1MOUebkLJBInb0KalXfsfQBtftVseew9dn0qJ9o2KIitLClfBW0JAqUZuAV2tivjZeiiqsJBoslAPVi7cccPG6JT8ehHmTURnx/ZvFCEdH6BH4gaDal1xPbzCk1HKvmKoccUeX8iC++vK5PPLhkySnSv67k18gp7V926N8qrV/J1orf5PTRWvQt7EQUZ0Xo0ghxcAASSBtQNwcF6xj392gz9+aw06E7okc6AG6UKY4n2hAuKCeDhiV09xPcQgPtdeFdOnUMda+Vu5rO6GSE9oQQ+VKkbodpBk4NDT0pC6gE6GomohMEDM9Py3s/6gnBte2LfqPUOZ+ZvV+WPULo9Q7bZ7Lz+sb+cGhc89Z/wxHNevT7QnqLzykGQ9UhILeDiG8JfaYnWpuiHIwTf3N3GUWJNWQWVGCncRkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xvQv/PEPIuJqMiBZ1quSY4lQZN9htCE9rxAyrAI7V6LBrHzmHs+S4RkRxUQ1?=
 =?us-ascii?Q?c8dBoobs78CpUatgP9s1YfvQDAh8HX6YI/z3TkXxf7nCHCregOuf1FoCNyf4?=
 =?us-ascii?Q?bkc3TwLjs+ku90BDUr3vUsOTkcnyAUp0pRJmp0F8ha8WHJInWOjeAJdo7IZZ?=
 =?us-ascii?Q?aeAEwqQcMmTqKGArZphSYJ4xAb4h3rRrOH6UP8eXpul4694v/Xsu8b2BbsT5?=
 =?us-ascii?Q?j7xdXVb71WY3HMg9dJYjfudYXDfOtjtG059MLjeYIHw/avumcjz+umigCy44?=
 =?us-ascii?Q?9Dh2nE3xexDpp5+18fg5j/X4Asrc3u9w/26MG/mviAQJ32VGUdVHKxOyrMMG?=
 =?us-ascii?Q?wcRuFzu88vAibWxiRODnwz+TlCPfr7lbz+5wBV0RRePesXtWBaopq2S2FBMB?=
 =?us-ascii?Q?jo1TCRjUpzwYtDYdkg7+C0u5ORyu3aHQTjA81iTLmgsril9npZa9e+E1+3mS?=
 =?us-ascii?Q?eP6qcs63JoV81ewkYS8RlgUmh6TPe5U8pkxws2NOjSin3Yu3NcH9dJ65/V1L?=
 =?us-ascii?Q?bjXnMyaLMigo1fN5qsrxihMMEaFjKhjdF6SiEpNAAOYGo/lHjkzkifsjXkNH?=
 =?us-ascii?Q?Jbs67cPwrWmwZI9RY4ntQpwovUjtbvx60GwVhNpyjWZXWxxRlyTL7OtH+fmF?=
 =?us-ascii?Q?IeqWtlpWglRaRx2VFzfz2+IGRvHGqyMiwGcSKi+7Js2PbpXUmJoruNx9JcUc?=
 =?us-ascii?Q?JHXhgb5mGmSJ+Y3rGa7rnSuTFuh1X2ovEIEjcmA8ePJ+MB1bV9Q9ygJzv7Gu?=
 =?us-ascii?Q?HawiUoiU226F0GfdAZQ5Fnj/eGTVDbcNLKQjEgSTBlzoezPAM3LdNiTA0+3n?=
 =?us-ascii?Q?CXsX1r2wbBaXTv7M2zh6w34Kchxdozc0EFkEeGHfif7yFezRCnhqXmILAso3?=
 =?us-ascii?Q?jAwLDN8iLwvmfoScu3Pn09wT2adoUVrWKj37CD4AvO2MwD0ve+Zfb+uWPnTF?=
 =?us-ascii?Q?pDByUMF1l6QfoNv8ZnhfJGKGXanJTl/25QwdzPphDj8Jbc1U2CJsm79lQjfM?=
 =?us-ascii?Q?gM2vYzxW3PTZSt8x7+z17N+PxFubFNwOv4boI0g3sBnOG5ALJEY2N/tD4a7f?=
 =?us-ascii?Q?ZMCQN1IEk0GIGdD6ksmklNB8+GVIaKwm7vMugvr5baALb+ZwkGmzuI+VThV/?=
 =?us-ascii?Q?WEHxpAFM35uy8MSwwyHw2dCkOGWUFZxqYknU0oQ9oMvLZXulgltGatL58J2a?=
 =?us-ascii?Q?IdgtCgOEoZwPPDo2i+DuGS1c4pm3dWunJ9JE7jFQoLGJQIgBGj1LyyqptWXT?=
 =?us-ascii?Q?217WDBP9iJ4Z5e2reJiYOnoLatBe2yQ6IrtYCLURR+PXb/bINTKBVhYLwQcs?=
 =?us-ascii?Q?2HhTEz+Hgdue6ikd3YNAXVaE+zjTdP/5+1fp062RAkIR0zEpXX+hiwcg+eWu?=
 =?us-ascii?Q?yiFQltM7fOP7VFvg9p6zBSDsQgkZlZVt6h+P904nod9XRLIg5n8T8Ll+/tU9?=
 =?us-ascii?Q?3yNyioh4LnOQDlG3/1p5WzgBiYsIJfXGm5GG/Dm16EgIBbtnC5uDsxfcDZrQ?=
 =?us-ascii?Q?JAto0LCxNu2E9/DYU4XJ7iLfOzupld4RSo4/VjIhNQoKH4OuKRUu91yhz2L0?=
 =?us-ascii?Q?3VR856bJGch3M0McNq5Sj5dXOOvVoGwgoWps8gPOKQ2TclAJeVoHyYO0jJCs?=
 =?us-ascii?Q?3KbKfyhHRKq0PQ0QDyFrMPdbAuFNCKqo+qEzQFQNwcKBQLriupSfqSbPLBwT?=
 =?us-ascii?Q?WMlgA7Lxv/HzveK91FXAvcjbiCg1E2+U8dz7M9SgMQgKrkfK61HDsveT7ton?=
 =?us-ascii?Q?HdKBa086Ow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e136733-86ef-4ab3-d38a-08de807adbb9
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 21:03:49.5118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y0qiAc4koD4QiSQ7dt+jSMxs9HcGCmLn8LL44w4ym+kleGeplo/Wn0ehR4WrLhEanPQ9w3EhF+ObK7SLieF0fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999156
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nathanc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

Change accel SMMUv3 ATS property from bool to OnOffAuto. Setting 'auto'
will result in the default value being used, i.e. 0 in IDR0 which
translates to 'off'. A future patch will implement resolution of 'auto'
value to match the host SMMUv3 ATS support.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c    | 8 ++++++--
 hw/arm/smmuv3.c          | 9 +++++++--
 hw/arm/virt-acpi-build.c | 2 +-
 include/hw/arm/smmuv3.h  | 4 +++-
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index fe78ce69a5..5d14abe307 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -827,8 +827,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
     s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
 
-    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
-    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
+    /* Only override ATS if user explicitly set ON or OFF */
+    if (s->ats == ON_OFF_AUTO_ON) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1);
+    } else if (s->ats == ON_OFF_AUTO_OFF) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 0);
+    }
 
     /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
     if (s->oas == SMMU_OAS_48BIT) {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 068108e49b..862ca945d5 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -317,6 +317,11 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
     smmuv3_accel_idr_override(s);
 }
 
+bool smmuv3_ats_enabled(SMMUv3State *s)
+{
+    return FIELD_EX32(s->idr[0], IDR0, ATS);
+}
+
 static void smmuv3_reset(SMMUv3State *s)
 {
     s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
@@ -1971,7 +1976,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ril can only be disabled if accel=on");
             return false;
         }
-        if (s->ats) {
+        if (s->ats == ON_OFF_AUTO_ON) {
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
@@ -2128,7 +2133,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
-    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
+    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
     DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
 };
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 719d2f994e..591cfc993c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -402,7 +402,7 @@ static int iort_smmuv3_devices(Object *obj, void *opaque)
 
     bus = PCI_BUS(object_property_get_link(obj, "primary-bus", &error_abort));
     sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
-    sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
+    sdev.ats = smmuv3_ats_enabled(ARM_SMMUV3(obj));
     pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
     sbdev = SYS_BUS_DEVICE(obj);
     sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 26b2fc42fd..ce51a5b9b4 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -70,7 +70,7 @@ struct SMMUv3State {
     uint64_t msi_gpa;
     Error *migration_blocker;
     bool ril;
-    bool ats;
+    OnOffAuto ats;
     uint8_t oas;
     uint8_t ssidsize;
 };
@@ -91,6 +91,8 @@ struct SMMUv3Class {
     ResettablePhases parent_phases;
 };
 
+bool smmuv3_ats_enabled(struct SMMUv3State *s);
+
 #define TYPE_ARM_SMMUV3   "arm-smmuv3"
 OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
 
-- 
2.43.0


