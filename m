Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9416DCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMYq-0004on-SS; Wed, 27 May 2026 18:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYj-0004nC-GO; Wed, 27 May 2026 18:17:05 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYh-0002Ku-RX; Wed, 27 May 2026 18:17:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ArVD4Ln7aXJiKPxmGTeJ1rhWORhGaCVOiD4TPtgOZs/SsXh/lyl6w0cNhNi3YyTosPHgrDoGLnQVSgT0XQtFD2dtJFIgsasgE2qClciOUvHG5+yJ9ASOt9KRT5vDVFqFgzdKja+JwgdpDdbDKwJB7dpjCUln90Q5AIieIK1LAtT0ZFlJHG5WlLageV/eupLOLhMkX/D/3EF+qXfa4QKbHJr1dNDqwWOSqdUg+wPsXI565W0+NiEwEoXpF8mLYF5pd+vZY6z02PlYtabCvVGo6GR/FIDO1EZm0n+BYP6t6crn1ZrqQq+KkiQLFEm6Wg5tWf23Cek/sdvnquSGiROd7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6JY6J9XKmINcP+2jSwGLkhWZCXMSZsPslbNvZcOeO8=;
 b=UCSjAcyy6UcQlRMj78U7FAMnnpA8994kmpGk+cyx2J2zrey2OAHsT+ywDuZSJedPoPM2FceROnafOrsLI0tAOtURcJ7ZnMUJjBABWLQbYOL//ddFsPNNsIU+1bS6e7PxhpNOYFaA1JdhV7FAEnDS/+DsDcSXsYWcLU9K3oypzXwwb8qDgARgUaWqhsX0GNoRYBS0d3yxNK2sAXlo9q3Y6Lf6Zzq53oYBmYwprg/4pWlNvmpFX3TW5gqjt3hJjXXCtJzm3pSt2x9Fe+Klc+zq3tIzR+PPgFzUpoT9OPZtbzitx2jHDzoKGD6z7EmCMIMvHKN+iQq+1c3cell79uGh5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6JY6J9XKmINcP+2jSwGLkhWZCXMSZsPslbNvZcOeO8=;
 b=gt356x3MTk7ruInEdSohEd+EPWxTR6sS6/DxNGAypTa0oX2lf5v1h8DE+xhRA6Mbw6cSPXw/I5c6RLQFOb1Es8sxsL5RC4ezfQmSJMtkv8NEwbeHhfxhYGjGWWCut8fr+uK6/1qWl0Kv0Rwz6g2/6vVIZSOSNmccVUTH/Z+XCeCFB/0EuzqLZIZtH94KLc8Leb/NLZEMa2bUMVeXKSVtyum3KeL1a26VnuYLvR5em9IHtCA+v/wbCq+szpntIEpVhujLd6Mm39CpVv9TUm3+hbCD4iEpYN5U6g05wG3ZFZbu0b8OUpo/geXIQ9oBDZLH5lAqRrBMj03haPEvupB8rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Wed, 27 May 2026 22:16:56 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 22:16:56 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v4 7/9] hw/arm/smmuv3-accel: Implement "auto" value for "oas"
Date: Wed, 27 May 2026 15:16:29 -0700
Message-ID: <20260527221631.612026-8-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527221631.612026-1-nathanc@nvidia.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:a03:331::33) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 133fd368-9f18-48a3-dacb-08debc3daa29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: r3MFKHKqXPLFsfCq53MqvWt3H7MSSwejCJtyDGjPTGCh1ztFkXtA19jp20ceN14C+jz/UT3lnLPRpzY79qvEZzwI4t+46GjbdxwyxZ7qB0uGvmeCfcu6CYeMpsZf8XBnUSBQVTVxGYPzosIHLSOY2IfMVsdyhWSJs8y5hflrJLeIGJH3AusXb7mGzyLrkgcn8BlkGAQVMFVdOXjCepACCdExG55XdyjNvmwoIBAEQNpRHwySoGZJYNfL8dQ1siZZTBevvI1M4BYRGrRMPRmTWVoAWvz0qif07zLsB0XW5u/SNTpU/icD94Ab1pOUpHTZFDGB5cyGt2mAsX1L7BFsn+ZWc0KtvUCQnSlbyKn5hwRpD6duRZcou3WRhGfvPOgEaaWF3fgvqZEwgQVoKMyAoGaeH1caRsZqrGjQb2K6kh+SrDluJfE+T/kSRXaZGO10ubemrMu3ZuzhKWm7mM75Fv5+76UaTW7jcnG1hLT1j15z5hvpDhL55JQdzQiH3/EMrGArvsqqzZQotyEoC0+UpxxCHcWv/Df/OtpzMujpZ36hwh0gWlBsInTCmPgSjdXKrhD6xMvoflCNYVcUAQT0IFOVfF3+B3WrXi/JTCzwE7I8H8VVgZcrz59kDJ/v0CMY+1124yUWbUd1GmAsE9z56g6hjv15iThrKHFGweb3SA9rSqFkqMcw5ZprRAvxpuY/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H4ntSEj12jmkkbTNhNbeus9V7ftI295G8pGVykAG+USxPQoVS05nvnkr20qK?=
 =?us-ascii?Q?GuIbUJgoc8yHrDYyDmsjkDdiiQ1Szl9mBhD5YA5ZOmjiF/PrZTeQy76Bm2CL?=
 =?us-ascii?Q?nDPL92597yu6zFC/tjpNJkzgO5tm4A+LEuViFtqqov0HydXzf8PshjvIRmlL?=
 =?us-ascii?Q?tPYmkqFYNs3QNPjy9HfP2ilb+9Fm46rKG1d2yK11lRcLJhq7kIdm5aHN/GcD?=
 =?us-ascii?Q?5LZ+A7f59sGm39K0zkLnpN3FiO9xXB51NFT2Dml9R9Y+atavrr3m9FY9QSCU?=
 =?us-ascii?Q?cDA4Ub1EFfZNsqYTpIBZWiOGiqj9NJ4lyNgEnS7vubZThzYWhxndOBe17jBF?=
 =?us-ascii?Q?pYpcSdsLvFuHNK+SPt4Glei2F+iehulO43/am5m9qMdf5AydEfm1zMIuTsk8?=
 =?us-ascii?Q?CbwtJD02X13Ztg/Vk/L5Vs3ewYyT16gj0DV9B79rYeq8IlN3ynoY9KEgV6cP?=
 =?us-ascii?Q?A00JplUPjZLv099Z+Tk3YI5LRd9jUJCjeTmHScOjypLsjn+qm3MgjeH3xZKM?=
 =?us-ascii?Q?b0ySVSg/N0Y0KZulJydNr4N04kNmphtrmcrU6j+ORiN4UzihRUOfst2u7d5w?=
 =?us-ascii?Q?okqmY5VQy8qx8t26TtCLcNdlfzwY26b3VMEFJD3G4Gv6rEsaBY4npnr7Fa1W?=
 =?us-ascii?Q?EuK9KMvwcYQDXSSwXoqO41wgrliGSl+vXFLa/lb5vQHuw4H6z9IPN2mm9jkD?=
 =?us-ascii?Q?I4TZFOhvPWzjESkG7jGTOYqNI0fC4cf1c9bmZ39TT/A32OLxO/JYtRZYu61B?=
 =?us-ascii?Q?/Kugv2XKqta7ixlYFSbVduop/DHmiQhCNTlPSHqgB90AuL6YOSuEmITuHq6L?=
 =?us-ascii?Q?0XQSqDhbCtkDpOT1bh0/BPkUZDz49Do24/Ocjj1gQMY2+NpeMdA2lnR/s2GD?=
 =?us-ascii?Q?k0WezR1frEcc96CsT258TjSOy9FOdkqWiNEclFABtOXrqcly2jhaeqoBIedP?=
 =?us-ascii?Q?WJlgqXWk3HBq5vfia883eCD8lPruwEILFunJl85kFx0znpNg1fKzl4F4Lllw?=
 =?us-ascii?Q?P9lTNxRDkYpqSjX2zCiQnLNbBYGCoK9LXYhxlNtLj8gncRWOAQf/AW87xneS?=
 =?us-ascii?Q?gj1un3s85SWVN5G03ZTBprJSMKZFeIkWoZaP7n7ksEQ9ZQ2CoJCHWIpTyBVU?=
 =?us-ascii?Q?l/sFmpdQjRsWe4MzS8KihQeVzCuqs2H1M5aN4BLtOp0cXh7b2WGq3gZ74K1B?=
 =?us-ascii?Q?OGZWs/afwK3LXS6elJqg0jcOzUXeIvcwSlNUZmBx2nvTaw9KDGcEopbv15VT?=
 =?us-ascii?Q?20YGK9wx8D0DAp8hSOrg7eKbbvKQtkjPEqe0B/Fo+GZphyyzKlcrte5loVWo?=
 =?us-ascii?Q?1uDxJQ0BNi77CrAPzHHCK5RdcWf6K1kfI5wevmd4CFBKiyAJKkdg6HpMEeu7?=
 =?us-ascii?Q?OYHw9Jgs5pg/gNGUJVziTSu15ZFtDyU0DeGXLwcI2Xi9TYHpdPpKMke/1fIX?=
 =?us-ascii?Q?kfv39BrkTpSljkwibgDwJBQ/lDr0Pi3goBfVw7bOvKWvF6t+/quw034u3pWB?=
 =?us-ascii?Q?Hp7mIoBvjKxitSrfYzReRDrZvCdpIUd3UArKhmndcVne8xa6ZwuU09P961yn?=
 =?us-ascii?Q?kVeIId1fKqo0/It54N5yzBSiq2vgtSMPlTiwdqTtGVo8q7K8nmh0SOXooxTz?=
 =?us-ascii?Q?4NaaYH3GDI1bPFT9RnSCLAPsTYwNxOF3kx2KMlbHXTMQ1s1MHLTTj+Ffx/sQ?=
 =?us-ascii?Q?WziUeI+x+/NNoaAmdVU0yVGFLO77zc3cA6mNLf2gofs5d1aVLUcx/k+4n7Za?=
 =?us-ascii?Q?VfpV8GPpGg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133fd368-9f18-48a3-dacb-08debc3daa29
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:16:56.8245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VEfgIP0Su8Wc6pEt9nhW24VHvBTmlmMCuv2zhmRa7xF4L9ZyHEjdk0tE+k4bqrHydX5tautV/GbQSfl/qDozw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nathanc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This keeps the OAS value advertised by the virtual SMMU compatible with
the capabilities of the host SMMUv3, so that the intermediate physical
addresses (IPA) consumed by host SMMU for stage-2 translation do not
exceed the host's max supported IPA size.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c |  8 +++++++-
 hw/arm/smmuv3.c       | 17 ++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 3f141991eb..06dadf9cc7 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -68,6 +68,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
     }
 
+    if (s->oas == OAS_MODE_AUTO) {
+        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS,
+                               FIELD_EX32(info->idr[5], IDR5, OAS));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -985,7 +990,8 @@ bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
 
     if (s->ats == ON_OFF_AUTO_AUTO ||
         s->ril == ON_OFF_AUTO_AUTO ||
-        s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        s->ssidsize == SSID_SIZE_MODE_AUTO ||
+        s->oas == OAS_MODE_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2250a7361e..97ac893d86 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1968,9 +1968,11 @@ static void smmu_reset_exit(Object *obj, ResetType type)
 
 static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 {
-    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
-        error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
-                   "OAS; other OasMode values are not supported");
+    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48 &&
+        s->oas != OAS_MODE_AUTO) {
+        error_setg(errp, "QEMU SMMUv3 model only implements auto, "
+                   "44 bit, or 48 bit OAS. Other OasMode values are "
+                   "not supported.");
         return false;
     }
 
@@ -1984,7 +1986,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             return false;
         }
         if (s->oas > OAS_MODE_44) {
-            error_setg(errp, "OAS must be 44 bits when accel=off");
+            error_setg(errp, "oas must be 44 bits when accel=off");
             return false;
         }
         if (s->ssidsize > SSID_SIZE_MODE_0) {
@@ -2171,9 +2173,10 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Please ensure host platform supports ATS before setting it "
         "to on.");
     object_class_property_set_description(klass, "oas",
-        "Specify Output Address Size (for accel=on). Supported values "
-        "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
-        "supported.");
+        "Set Output Address Size in bits (for accel=on). "
+        "Valid values are 44, 48, and auto. Defaults to 44 bits."
+        "Please ensure the value does not exceed the maximum "
+        "Output Address Size supported by the host platform.");
     object_class_property_set_description(klass, "ssidsize",
         "Set number of bits used to represent SubstreamIDs (SSIDs). "
         "Valid values are 0-20 and auto. Defaults to 0. "
-- 
2.43.0


