Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A138CFA1FFD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFeR0-0000YX-JO; Wed, 22 Apr 2026 16:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQj-0000S9-U6; Wed, 22 Apr 2026 16:44:17 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQi-0006uV-As; Wed, 22 Apr 2026 16:44:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihPg3EZQ0I48cXRKIfXNls+9bDhJnr1OvF+Q6VvT+UJE8l6dzRljdHw6Kzs0y8goi+yrsiohNiuyIdtfM8xAI1vHeqDswDyNxTdK+d27N8N1L47nZRhpdH3wgWqjNTYV0J06+C1iCSnyH51bHcRZl71axB/pMSbWo8j3kwrs4i9cPqUu5JYkcPqkRM2v2+MibtNgWJ/MCaP9bMRZ6ENkOycazF3w5mPT1BvGcW61sTByyXdepAPUmPnQyMUt9qsDXejI18vg2jc665538DeoVQ2QdnVJ2tJ3B86J/Nc3ju3JCXO29CyLWtOGHEWqu3+RU7rAPh58z+er6r8HShzhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wuzgUWuG22tUnk54XqZ8K2I0Otl5uf8XFNoNXC2O7E=;
 b=ClMNs77/5OLhemcTzL5PyIs6dmrxuVpSko/B4IgMhymHzYjNaLCw3KAdXaPgYMV0nIJG67mZS7w4BdUkRQXaIGfy/e8YyWdqRv4iT4H2Hq8TkYKZBmdZtbVMe56/SqmwkH6jvRyidd6incJpH559o5EfzAFs2rUc9GytJvH5sQj9BT8XmbAPv12vDI53LMlXLXRwaluIoa7490kfFO581txRgKUeP6ccJ3ebMJkFsUzg9CBD3ED4NbH6df2hi9HzSoJ9QJV1YSGNQNp1Ovz1FVQKwNZx05NYquqE2V3lSnzliAW2OFXeuetG5SsmHq4zStVOTjC5bkdjst1n6ghF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wuzgUWuG22tUnk54XqZ8K2I0Otl5uf8XFNoNXC2O7E=;
 b=i6OJFDK33J9NawdIW+a46cOwcVj8Kqa+aaC6/sIqxBGSIVbdLK652IXodonDJiS9XXOIOAC6Un70ixt838ijPn+O5EAd9BbGD2T3yzDsa6kUHXK2xGnZuzYmyztD1zW5l6bsNLw6NNcJ0p+TsZo2g9PSfbhhhv4V67nApl4IWYJcUSYjH+LSzVg6xKsEv46lESBMp3ooV+t1JmYsuYA7gIZNtv8gY4Ltz3fMzFdgcIC6ENxIxiHkayFvFUK6lGVTpnD2an53qyWYLHy75+8doUQWKU22ywCI+8svRm5z/Iihjt1y7DrkS42myCp4AtX3Oer5mQhVNLeLbQJSinHEyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Wed, 22 Apr
 2026 20:43:56 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 20:43:56 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v2 4/7] hw/arm/smmuv3-accel: Implement "auto" value for
 "ssidsize"
Date: Wed, 22 Apr 2026 13:43:32 -0700
Message-ID: <20260422204335.23116-5-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422204335.23116-1-nathanc@nvidia.com>
References: <20260422204335.23116-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::30) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b482e7-2f23-40b9-b7f4-08dea0afdfa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: hlZXx0vwZI4punzes3J/T0OgnChsmIZ6YfK7AMe9JgftbWRY/7rlr63n1MOY3pOJaqBjoKhuABTQEdzZsvfz7fHzVhgzZe7l63OZpi0VY/QCQMdO+ONBG6Za3D7K+u7aZ8b21sWvO5voUrKRYgSYQ6s+INkfSFB28bQzwqPATXP2azD0jaR/sNRENX9XWN5JNZnHCw1DVYtuEuc5ZRx9M+nTQTxdPWVNeG/VmD4FrKvLPI0L0YzjeIRcgRNul9xqJDLyiNHcFx85lrqE8b3VZmRPdGitAbQ8s+/kM354vyy6uNc2UFu+pMb0xsrv3NtiSnW+VqQmcmHFAmPoCI1Qh+eIGinvQjvrNxsKId9FWgq9Tmo8GSxSy0vhu2TepWz4gbvoVxsKn1QHTxJkuS/wmO48teDUA7Airnwrw8+/CQ/zwdtA4ZbgmFuztJYTvOFw6ZzuHAHU0AECjcf7s7/wV9+uHkAURSEfsWHlx2ltqOs50QJu68cXqkmiJ3SHiow+90Rc56+egYJyXi7CNRGnMsUxclJzMzr42aa3yhoQ9pVMdw3KeokZt1Ial4Ox+ffAtfOt7eAfFAAvGKYNgSlHZNc003XBYYvmEtxGGhX87we1uBarJlMPStzYniJ6mEs2h0tah94b6aSz8ma5aiYk/Cb7THiOJxCSBPtazxoZoHl/xi+EOm8ikJG/jRXH0WXjAkp65aM8bF2rifm5YXKzCjumNYFrmKfJ7nYgN5MnS7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ktrDb/QplnyNK4b72RO4kJIsXBBWLH06TZ52xm9XBPlvAysU+6ibLWrdctiJ?=
 =?us-ascii?Q?Tr0P92yjWJRkQAseH+pYe+JENTm/h4k/Ayp79G4TpucLifMSIiA69AGZOQ05?=
 =?us-ascii?Q?+ZLqk44pMhPTUOmMdtitgIijrBtwJZafZrp1NPp1reYJDKsf9YCc5+cdpu9w?=
 =?us-ascii?Q?5XhzVaMaWAV91eshq5yAdT0Eme+IP8a8MZa3Yn1/kBWYjlcN4bK8/2ZUg8O2?=
 =?us-ascii?Q?Jw+lF8Gc9OwPsgBTVvkOy/IiiN626sD1N/zui1n+4fXQJQMM1Ben6Zs50gAe?=
 =?us-ascii?Q?//2LZH2cbC2mY+2aLEzzdUaY3Q53J6aIMce99pfl2U3IBMWDQezxqlAQZWyA?=
 =?us-ascii?Q?MGrik170gd1mCdU3oec1/GMZgQtwmsmnYVGOHtof90HZWu4YXSSCvuoQCjHi?=
 =?us-ascii?Q?fNvxSbsYERxFqBKfMOu/idM1XGrPe3M8zWv7/pF9rot5d0mH4s+vB40zSq99?=
 =?us-ascii?Q?YEux0xJOg1dKTfOHAMNLwBh9/KGBGqLhEeyNpANHZ9LUI2HHBQPGc6qjjci/?=
 =?us-ascii?Q?EgKUp5thNLe4XyZyehwKOqkTw/Ko7Rk6H/O40ys+hYvNwY0ZTQUlF9bESNJn?=
 =?us-ascii?Q?v3WHJAfZmsGJsTh9ReVRYkJCRmcDeGNgEG9e5xIdG4i05ms/6RGobQ6ErfWU?=
 =?us-ascii?Q?sl7+Jceja10tAWkaZ+HPB896J2tiUxeOtxhUQUlRTW9z8ibaE0D66NC1KFnZ?=
 =?us-ascii?Q?Zt/nwpvXHfkNyl1pX//6jOtZWw9ivY+oNh++/4wlWOzgrlebcKdzmlGqd5ZF?=
 =?us-ascii?Q?/rCg8T5M95vMoYFXoxv1+N3ZeSHci4TiPl2z4oU14VZBKdgW85VECbNq7+id?=
 =?us-ascii?Q?nRXnY87sAF+bDmlu53uPp/8oVEJIwXKExIW8mMNWqpEmUNfR/EI2YxObtTFY?=
 =?us-ascii?Q?JLf4K6XvPbZvV3Jt5NlmeNv9JJ9+AqFa4WtD0fPBhUJnbu6gRiztKSU27J9z?=
 =?us-ascii?Q?nwkh0t14jWy5X4owTPHDaPzSLi9FXGyVXnbY+Ii5+4Q77ZanTAoTobXGQc1z?=
 =?us-ascii?Q?+n/TE2xTghyDx/y5D3OQRaZLUFZ06/7Ov+jwMm9fwQYeSluKNoY9dE0rBsj9?=
 =?us-ascii?Q?/IAtulF4sHZBRiki3xC5Ne0v52f3oyVtb6+jWDL9QPhQsD9dOKKaRiQ8B8Bk?=
 =?us-ascii?Q?7u1KyK0S5gFSwXJnZHQHXKx2lWFBBUtGDCvaTytl9133t8gnNYzWrsqwvQdg?=
 =?us-ascii?Q?KtT/YUf3TuxFgiTyKT47kyePKnuCpOB8KJKePq/2WNa4qxbB0LzYi+Bts1Pi?=
 =?us-ascii?Q?jXHvnjdc9ProCjFOlg5U2frjDPdRjwMAXPii4ujLhGErk+q+MD9OKy1wty6X?=
 =?us-ascii?Q?hgVoL4TCMxikZ/uQNFEOsaXESKGBCrOlf38iazlYUxUoljgAMiy0VtlvnP3W?=
 =?us-ascii?Q?8Fa2rqlrKwGKiFls7ETDHNuqjWLTYl5zXeVegbU5UCTA1TnY5ZJ5cx6k0yhU?=
 =?us-ascii?Q?RD1aKwOooC1PvXTZo8Aw6gue0dqLItpgmKZbtnBBciOhWRZ8Xtu90P+qtdU1?=
 =?us-ascii?Q?derAFlsybqlrcoK6T0g+yxVdXVa2xJRA7F9gJQpYOcKAvh8S88IYmFri4303?=
 =?us-ascii?Q?QFBvIs6iOD2hd7HaUHJ31+RD6kWvW4QzlxgwyKOfQ+a9eqA0RglCC2zuD0/V?=
 =?us-ascii?Q?gUF0EWSpwE2LTEXbGfzRxZjXNLhQ3UJmXIgkxkn0ZHbdbKFCnlIsnHiCp46N?=
 =?us-ascii?Q?hhstCHBHJtDR+muahaSFZ+SQPc7xAWgfnPA1ltTVDq1CR9jWybPnTspKmCAl?=
 =?us-ascii?Q?4W/FZ/q3hA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b482e7-2f23-40b9-b7f4-08dea0afdfa8
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 20:43:56.6401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8uIwmpAwVKjfhHpqaFhzyVFWO4fzAxX1gG7K2ZNyDiEN69G9aNN4R8RZ6T2AfSVmbGbTjok683T37Y2DNOgZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nathanc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Allow accelerated SMMUv3 SSID size property to be derived from host
IOMMU capabilities. Derive host values using IOMMU_GET_HW_INFO,
retrieving SSID size from IDR1. When the auto SSID size is resolved
to a non-zero value, PASID capability is advertised to the vIOMMU
and accelerated use cases such as Shared Virtual Addressing (SVA)
are supported.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 18 ++++++++++++++++--
 hw/arm/smmuv3.c       | 20 ++++++++++----------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 98c2cdcb5e..d13d15a11d 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -62,6 +62,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
                                FIELD_EX32(info->idr[3], IDR3, RIL));
     }
 
+    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
+        /* Store for get_viommu_flags() to determine PASID support */
+        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
+                               FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -822,6 +828,13 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
     }
 }
 
+static inline bool smmuv3_pasid_supported(SMMUv3State *s)
+{
+    return s->ssidsize > SSID_SIZE_MODE_0 ||
+           (s->ssidsize == SSID_SIZE_MODE_AUTO &&
+            FIELD_EX32(s->idr[1], IDR1, SSIDSIZE));
+}
+
 static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
 {
     /*
@@ -834,7 +847,7 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
     SMMUState *bs = opaque;
     SMMUv3State *s = ARM_SMMUV3(bs);
 
-    if (s->ssidsize > SSID_SIZE_MODE_0) {
+    if (smmuv3_pasid_supported(s)) {
         flags |= VIOMMU_FLAG_PASID_SUPPORTED;
     }
     return flags;
@@ -974,7 +987,8 @@ void smmuv3_accel_init(SMMUv3State *s)
     smmuv3_accel_as_init(s);
 
     if (s->ats == ON_OFF_AUTO_AUTO ||
-        s->ril == ON_OFF_AUTO_AUTO) {
+        s->ril == ON_OFF_AUTO_AUTO ||
+        s->ssidsize == SSID_SIZE_MODE_AUTO) {
         s->s_accel->auto_mode = true;
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b7aa4122eb..07025245e2 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -626,7 +626,10 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
     }
 
     /* Multiple context descriptors require SubstreamID support */
-    if (s->ssidsize == SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) != 0) {
+    if ((s->ssidsize == SSID_SIZE_MODE_0 ||
+         (s->ssidsize == SSID_SIZE_MODE_AUTO &&
+          !FIELD_EX32(s->idr[1], IDR1, SSIDSIZE))) &&
+        STE_S1CDMAX(ste) != 0) {
         qemu_log_mask(LOG_UNIMP,
                 "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
                 "Configure ssidsize > 0 (requires accel=on)\n");
@@ -1972,10 +1975,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
     }
 #endif
 
-    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
-        error_setg(errp, "ssidsize auto mode is not supported");
-        return false;
-    }
     if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
         error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
                    "OAS; other OasMode values are not supported");
@@ -1996,7 +1995,8 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             return false;
         }
         if (s->ssidsize > SSID_SIZE_MODE_0) {
-            error_setg(errp, "ssidsize can only be set if accel=on");
+            error_setg(errp, "ssidsize can only be greater than 0 "
+                       "bits if accel=on");
             return false;
         }
         return true;
@@ -2177,11 +2177,11 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
         "supported.");
     object_class_property_set_description(klass, "ssidsize",
-        "Number of bits used to represent SubstreamIDs (SSIDs). "
+        "Set number of bits used to represent SubstreamIDs (SSIDs). "
+        "Valid values are 0-20 and auto. Defaults to 0. "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
-        "Valid range is 0-20, where 0 disables SubstreamID support. "
-        "Defaults to 0. A value greater than 0 is required to enable "
-        "PASID support. ssidsize=auto is not supported.");
+        "A value of 0 disables SubstreamID support. A value greater "
+        "than 0 is required to enable PASID support.");
 }
 
 static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
-- 
2.43.0


