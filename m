Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53FFCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMZW-0005Ka-VS; Wed, 27 May 2026 18:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYm-0004nl-W3; Wed, 27 May 2026 18:17:10 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYk-0002Ly-UI; Wed, 27 May 2026 18:17:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYQOMkO4Z0nLG7UL4FEtBrZOwbm4k3m2gZ5UuYwG+decWkpv+Oi4VjA5+aJGCB9k5rzWiHm500+XIjewxfJbvaMZA+gd8YkrrcWd1huCy678p4+Q87/XAV28bbN3KG26o5kv74DZQM1BTIdj2gBIx3ltoGyd7u2sy+RIcvo2SOLR1XFigy/j+5F8C72WkOpaGzlEauTab105ARnuk5YXIwNaWq6ILM8JWF6+kQU9v61b/45vMYJnTWcj19i4XaFd/7M1qljvlaxzt/LigOur/dzyJF/OZ1Fj0zwV8YKvrSK+7OORboGdXeTZ3QP7plK0K8rye+0VQ8mfuKPv/inyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+OPgbF7GpKxWgGZBTqEMSDNKJ48qDej/TFZhDgRJhQ=;
 b=w6s2BXJ3EJOUN57cGay5e2j9U4Wu7ZubLN1gAD5sbVRM+PRbqNzNy3zD7Zh3mUi+MuHLZrAhqfi9PD3KuzbwETDJq95NJWKAk22/59N9gtQVfTU8fMwlBymT97BR9O5cmG+rVGInCSdwWqJCuhGggqV/EHyzIyzvYLb1njbmMnmYY3HMZvR8o+1k0UZ5sm81rT9qjiznhj3ZKbVAQzK95ltDodoBjecffHxFts/jLn1HHMGUxOIU1e/Mvr1qCUp8U/Vo9wvFTuq7mfPNH1pancGxWZQxsxPWE66PvhswSHaNl3eCLyITFmnd470skbnzQTTrQ/mGEcfU4t1gqPwWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+OPgbF7GpKxWgGZBTqEMSDNKJ48qDej/TFZhDgRJhQ=;
 b=bXXhFah0Fu83lmRiFeVB3F23tlimi4YVfBpOuHQRBejjzm13MENgGZQbemkkm3vfTuzSm8vr2vWUHkmSFYxixnhILHfQnSoDyXjpHqbH2Qa9SmChIN4VpbrZKT1QhzpZjbGla5BWshLervrRWPR81kDwQdId5KlZqD0/mVMgHfy7dmfz2og7Im/9dQTm0zTCQWfDb8D2LaTYjthjA4C+a7Nt1oAnBH9LfTKCgdlFAgaP5SoKX/vJ/KjOOOKT9/etHhjad6TKH3uji9uOzZuwwqH64YEtAgMRykSmCUJlunlDHclEA3AGaBn6+ljbXsKtyetHNViYWrl0nK0U1pNHJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Wed, 27 May 2026 22:16:58 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 22:16:58 +0000
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
Subject: [PATCH v4 8/9] hw/arm/smmuv3: Set default ats, ril, ssidsize,
 oas to auto
Date: Wed, 27 May 2026 15:16:30 -0700
Message-ID: <20260527221631.612026-9-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527221631.612026-1-nathanc@nvidia.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:a03:331::30) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5b9113-179c-4fbe-d8e2-08debc3dab28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: MIEWU021ZK8+EvH3Kf5S+kELDXG0s9oIYvL3l0K1VzXpV1gi2rMcBYOJIbhF6MK7aEo0mMD4GcjQ3dMIYfyjFI107Ie6E4F5KZiH+uEeLqV9wHdobCavtTnLeb/p5lYacDAlItrEc8yVpzFOwLe8WFJh+rWCzWzSw+ALNAh4sF90MMmvidpD9ZId4OQPCCD4pr2gI6+i05T5beGtHMeLUQckeNFnJD+0I16mj8m0wnwA0Tb/FugWAMF9ilMzCJVCMHhOTZUMWusadwz5tNGsjPFNThlAMXm2Kyp4ZXoaGEsrKkj0OQZOerwQRAsFLaCNZtZA/e4zHR5WpHoOL5Ck6v58LmewjZR/sFiSBtZhXV5vTw7ftPJWTO5XMRSRLZsNBWqB9206G2EWITBF7C/ouFV1FqwEeo+voDWUKJqCD4pVeCePCNN2Lo+krR2jDDADon5R4Zv2v3shNqHSQ2tKWOV+mXhIbQG5tDk5C6mk8SRayCBHaVXx/ZcPgqN9gB8tAB4Ha26ZEdhqdA5t5mfp0+Tk7PTxUpOKPrtzgrpvJ/48qe94T51zG7Di+va5WEiYvccPCdF+KD51F2xeMeNIRIA7F+HjDo+UvdhS98ZfPXmDo4Y8sOE5b6LUlkFFrFry3wqTc4u8wYsFzgusMUJUAhXeUaJD3sbTd467FkBtep9bzM4ZoouMmrt2qjZzbyDm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rxsTyNANyJRakz4uYwlkN8tpGGKrIFbDBHJfasohJdajApLTXydec6MbaaHC?=
 =?us-ascii?Q?hxu3ZZT8m+mObjE/lT0B2pHDeKkDyORSTw010iUPURm+YwjYOFUdGngvzGb/?=
 =?us-ascii?Q?ipnYhfwFNQRX7IYpdNbZF1J/aer9DODptyknKeBzNjPAwSrxoh8DpFhow4/z?=
 =?us-ascii?Q?Yq9XWvqNS0ivLHWgQwkLa2tYP1H2T4qsGRf/eq6IDtRaD47E+hQel02pwV4T?=
 =?us-ascii?Q?e58QSgZq7luFaaJtITKiaJNhMPJx7ceBZ8CH5EEAx9FUaMVBdLxacgcy9QXA?=
 =?us-ascii?Q?8cTw7DFvD/vOaXwBofsP5vGSBtHPIcEh+yZ7gMU7ujpZmym/hkr1HOyXf5Ir?=
 =?us-ascii?Q?adTV8Rj2oWgZmSc4fmz7Xj9Btr6lI49pw1AT++faZAhdjFhHvtm0CQ/9sLgo?=
 =?us-ascii?Q?OXc26NDsnU7Ctv9mqJKBmhRXSft5LAkNC6+xhTvOuMuwJ6oS0lUPmCkxrih1?=
 =?us-ascii?Q?bXP1w61FNgzO0c9HYt87SgN0ZTqPQ9cPlmV3u1OgrNPGL1Dp7xW0B0puxL5s?=
 =?us-ascii?Q?ehh+Flcv3zgpiI/lkV7Taq+zr43modFxgJntTkGgm5ab6Td0c/VAVd1aqIxi?=
 =?us-ascii?Q?+N+jPkHBNISBfBV0y2iSj1sxSOkdTmXHNpw+t9+bs6F9VZagxveb0DzDSjUv?=
 =?us-ascii?Q?p5nJqGdteBQXdg2FHvCrBTYijr6LAt5qIar/hEu5+2zac5KSEZNt//WWNrKM?=
 =?us-ascii?Q?Rz8Uxn/ckGYwjNdpUx3SPyxNlFmg9XUDk6L8OtFeF/LUVitbUeq/XsVoEifF?=
 =?us-ascii?Q?WR46ZTmmmvMgg/bWNvmOaj+498+rIxH04TrL5Sd4oAtKjeRNxVzRv1a2J+IV?=
 =?us-ascii?Q?Ua0ZEmox4/D+dqM55c2micdwj3z/m/FMUOjKkAwgEwEy6FBOYGzxhXrcuxNh?=
 =?us-ascii?Q?9d+dJ5lLislznbqzbSsr2LNnUj4pDctujHl0tzD1I+wBmvNolWd75yTe/tmf?=
 =?us-ascii?Q?DHQxY68hKjAM8QEB+qx/+jSSrV/08m1wwxq2HK18SCzyjfHx6DNCihRZnmYC?=
 =?us-ascii?Q?UuD86MLTaj7JU7a/XijsbThOOSkrebGArDqk5N37g5VfR2mIK9rXM1I0SkBX?=
 =?us-ascii?Q?vMbY094rWERebF/eMc8AEuR5ucA1rhdL9vk1cZB1iIHUYFxnSodSIOvkE6X8?=
 =?us-ascii?Q?t69CMD09ZmAezokcBcmGOn1V2+oJZA14WllGcdTF7Y/+Sa9mVsTKtK2ZVNDG?=
 =?us-ascii?Q?/DiD3AquYjAHgIIfJScVg8U2r7KhGM8nUb4AcTVuhbzoOb8RCoqtwocMuFeZ?=
 =?us-ascii?Q?FlBNOx+tTbz2qC2LD4sJYStfiCBeVWuy164GWXcgYum4+ua0PK61A2g0KAML?=
 =?us-ascii?Q?k/IFifakV50h7M2swD24n1NWHTt/oBw79zJjJBNriv9Bj9HKLzB/fEvaOPtv?=
 =?us-ascii?Q?P43UiVMvPSBRREkU0ZNSaKhBbqnhbDWzmwnGNtnhH9FS//3nuMGLO/0rImgW?=
 =?us-ascii?Q?X8GJL91y7+LhXzd0Rc50muuVNU4eG4klNClkt4ju1KoFOKMdOIltIzFFk3Ix?=
 =?us-ascii?Q?a8WrLp6khi5rDLXW1l/qsJuVXNZDsGIw8TMnTtF1ceAECI9Hd3MJlmVqYbml?=
 =?us-ascii?Q?iGGumQBb9vB3uSpGdGlN++sGW+Dgy+qGDXOnjVuR7erjJmfRwNhNJW6701m7?=
 =?us-ascii?Q?H6izlmf6/kbIheciIqAT5ZWCiHEsu83s7Uvwls/TEMp30cCmELLD6G17nLs0?=
 =?us-ascii?Q?rjtKbaWnDc3oxMUg0nerIxNzUp8zP3Zz4O1xxCetoHedipyelyWtQVf+iGBh?=
 =?us-ascii?Q?ykdMVucC2A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5b9113-179c-4fbe-d8e2-08debc3dab28
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:16:58.4852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jT3EBBHSf3SRAFvbP+ysKb9GQiUwk4U7q7sHZ/otP9nmKgqTGa1NkSTplpoOqahx0mw7ynIZGoghMTKONknrbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nathanc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
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

Set the default value of ATS, RIL, SSIDSIZE, and OAS to auto, in order
to match the host IOMMU properties when accel=on.

If accel=off and these property values are set to auto, the default
property values defined in smmuv3_init_id_regs() for OAS and RIL will
remain unchanged, while SSIDSIZE and ATS values will remain initialized
at 0.

Introduce a new compat for the changed defaults.

Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3.c   | 23 +++++++++++++++--------
 hw/core/machine.c |  5 +++++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 97ac893d86..4e630b6403 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2129,12 +2129,19 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
+    /*
+     * AUTO values for accel=off will resolve to:
+     * ril: on
+     * ats: off
+     * oas: 44
+     * ssidsize: 0
+     */
     /* RIL can be turned off for accel cases */
-    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
-    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
-    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
+    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
-                              SSID_SIZE_MODE_0),
+                              SSID_SIZE_MODE_AUTO),
 };
 
 static void smmuv3_instance_init(Object *obj)
@@ -2164,22 +2171,22 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "device assignment before enabling.");
     object_class_property_set_description(klass, "ril",
         "Enable/disable range invalidation support (for accel=on). "
-        "Valid values are on, off, and auto. Defaults to on. "
+        "Valid values are on, off, and auto. Defaults to auto. "
         "Any attempt to turn it 'on' while the host does not support "
         "it would fail.");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). "
-        "Valid values are on, off, and auto. Defaults to off. "
+        "Valid values are on, off, and auto. Defaults to auto. "
         "Please ensure host platform supports ATS before setting it "
         "to on.");
     object_class_property_set_description(klass, "oas",
         "Set Output Address Size in bits (for accel=on). "
-        "Valid values are 44, 48, and auto. Defaults to 44 bits."
+        "Valid values are 44, 48, and auto. Defaults to auto."
         "Please ensure the value does not exceed the maximum "
         "Output Address Size supported by the host platform.");
     object_class_property_set_description(klass, "ssidsize",
         "Set number of bits used to represent SubstreamIDs (SSIDs). "
-        "Valid values are 0-20 and auto. Defaults to 0. "
+        "Valid values are 0-20 and auto. Defaults to auto. "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
         "A value of 0 disables SubstreamID support. A value greater "
         "than 0 is required to enable PASID support."
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 63baff859f..3339da99ee 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,9 +38,14 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
+#include "hw/arm/smmuv3.h"
 
 GlobalProperty hw_compat_11_0[] = {
     { "chardev-vc", "encoding", "cp437" },
+    { TYPE_ARM_SMMUV3, "ats", "off" },
+    { TYPE_ARM_SMMUV3, "ril", "on" },
+    { TYPE_ARM_SMMUV3, "ssidsize", "0" },
+    { TYPE_ARM_SMMUV3, "oas", "44" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
-- 
2.43.0


