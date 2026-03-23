Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59027F483D7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jyJ-00025A-V7; Mon, 23 Mar 2026 14:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxx-0001zT-PR; Mon, 23 Mar 2026 14:25:35 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxw-0004GC-10; Mon, 23 Mar 2026 14:25:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cg2DoJrudFmzEToliO663IfHLWlKiWKo1wmGhJgJfDLpw9HSZ7aVmgXda3M0/fba9yzBSHZggPy4qIxGzj6yao8FCtZtJuK1wluFJTYCr+61/AzEticMStWN7KYigYpiRCbB/WEYrIT2qPcEPW3BqpsXCsOuEKkxTjYFeEdUIbhKNZwPP+NfrsYpJEp9CpdfAInLqalD2bbps9J4mJAZymxVY4hMJPfBivNPdCRC8tcRF1umykN+OADqqv6EJLsP1SEnUkMlgFSZZpeErybEziQwuUBa3rZ/YrWAhdKDS283laWbPYd2gAOW0iBjOIN4jUO8TDTHgiFyq7aobohfEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cXpm2fNsxO5P+KOSahq7bO9I9tw1QCSyTxb4BzLokE=;
 b=Oh9wER3wH3BuXuPzhhCO4gFsh99qQKuiTo0xle6KlnIUZbEFGtAQUMmhEjWOn1ee6+LfnDY6dBvbeCefMCDk/d7KIGUDfCQ6C4hQdO48XMvw41qSAzvvUlpwQPwFUCXsuAT1b1m621XGd1v3OqWDYFKyJbARFpej9HQkX43Fhbdn5Za4+IADqUx9pTW/AP3RcrY51IU2Udexgwz7VMxb8VYbZ0jhKfKI6v09F76RmwPKiano04BqufPQRoyWnWA2ZSM9yDsqGuvD98K54a2PsqmpVt3z6RqjcVgw/jPNj+40fOa11PsN67rn1gOp7sOP2u/CBxX2/sZv5JThCB6QIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cXpm2fNsxO5P+KOSahq7bO9I9tw1QCSyTxb4BzLokE=;
 b=Sknu8hzf791iS0BXWRil2izljV84dJQIOM8P5NV3fJFZk9g3PMkQ3wa2C50mIkcqu5Qd5MaxUTJHC5vNqtB3DfsmXXXq+YWhcAOiDYE4auoLy8sUKqsFvXvQN5ssmXXXLTrCsQjgRfDhLX6zkME4JFxw0rGC8DVUHy+JHIFng12wcJ6w5i+DOzI6byT+XM1YRcXFzz/FkMxhjJmy5DVUnLwsd2unLfWofUu17pGffZOvydgSZHOGEFRSmGKBQCgFkZeo1TR2zdcI2wAc4D+HZJgNxFiDjnHp70EgPltX8ml6bnNM3jMIFMrrbErOXDPhEgRrkskn5xN//EI1D86MZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA0PPF12042BF6F.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Mon, 23 Mar
 2026 18:25:17 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 18:25:17 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v5 7/8] hw/arm/smmuv3-accel: Change "oas" property type to
 OasMode
Date: Mon, 23 Mar 2026 11:24:53 -0700
Message-ID: <20260323182454.1416110-8-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323182454.1416110-1-nathanc@nvidia.com>
References: <20260323182454.1416110-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:a03:114::30) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA0PPF12042BF6F:EE_
X-MS-Office365-Filtering-Correlation-Id: de0d2bb2-ec10-4195-318b-08de890988b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: a+vAG/pudBOcCUIMn0PkDbkBHafX9pbAOUDIzggrbF6Nca8aMXQRGGTFQRtGtT3SFvPW5xRyz+5xqyp80Sz8M0ZxbKTz0shywICIRXAAb6WUZyhmlC/j66UKeruFOOOpV2ovj8NGTvgB+1KNYtCfKHe3XgE3nKw1/z1v+cUtwlBswF/bskLlisFr65x3b2aC9KYqBznvr7F5ZKKV7chgS2ePO7TBwElVuqNowj49Y0sB1jwuHDaqYxU7yKjc3LNui0FOZGuSKolzUtUJ9Wvnqo+kl+cchK1ugn7mJsM7bf3+Hk/amftVqAMx1Ndp7nVyY0/+KicJBKSxbbcxDQhyqIbaFh/MxQXJJXoh6wPJlH2ZjzTPrqcV++6A7l6U/zHJSSpc/m8bV+E5avTz5ICTT0jdH7gb0pT80yVoy+iEVPRvNU2FECDAM+kk33M7wTYbSVbRcjUoj1N4UWZyl3Dqq4lvp/jRr+hGPbrv63oUXgTve8fAWM3xMkdZ9/4Q3J/K9dYLIhlG937Jfvq46pGSvlPktvo6vnCoonSBH0F+1TXgjrOlWMaFI0c9ZVZggZcm9Q/F+eKhXNz6BhhMX91Wp9Bp9pS01NNTe9LpC8hwiewoq6CFRtLgeaQP50K8ZxthT++OBJb/r1JVqqlVHNzHP6uz+i23s9Rlwf0Dj9qxrGCda4+L2HEyd3EKczNn+qk0yqa/NrieBWrvBRpLrmT7UnV7sJbMkDP0SJtQ/X9DpMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kVXNoCOLM4Y7uh1RFbfZiGyjBG+lPAq6aPqwh1RH58gvKd6lVN0AL0WbC1Np?=
 =?us-ascii?Q?Nn5BvTSD05NqoBZXhYlpkAUneocO9TE+O0+2d4ASaid19my9O/GCOfFzdHlY?=
 =?us-ascii?Q?H+MA1zYal3KaqIOs8jlWuOZKiC8zw2TZUnyR/S9CZR12rx4nBgDUizxFCkYS?=
 =?us-ascii?Q?RG6WI+S3VRtU+CGzz/Yfad3/A6c6lgb2YdEIbmr09lwflpirZMygn2G/TQHR?=
 =?us-ascii?Q?8PaSHZKdmqCwjUdfH9CW9lReidadf7EFgsTN92lbhzJycvUNCRL0pCryxYwr?=
 =?us-ascii?Q?V9lBPAff9DeAB2DQzuH0/+mRzZ9aD/+udL5sGB2VBrlhK+kSKifo1ZJLUrJG?=
 =?us-ascii?Q?jJ+lTDKIhEYJrSSQXqqOYJWA/7cXaw0POhf07zpiHBNGTN++m15/UksB6HwA?=
 =?us-ascii?Q?yJBFOWLPqFq9UFUFqm2L+H96p96IxonTRaZZgNB9Q7oqmr8oKGMDKenUbxg6?=
 =?us-ascii?Q?OPw0kHB1L2iVVk3QnrtOf+RDbYTTL4EPiD6zOPEPYGBtdPPiwvoRE4gfZ6Mc?=
 =?us-ascii?Q?n4hs3/ae9ecHCFmcAQBpcV128kqplMt5PWomW/lqvwahKYERo5+A+rLml9Gw?=
 =?us-ascii?Q?GZ4MGbujAooqBAyTP78JLi5gA3kt+tkxeahSm++idnft0sBRZulEd58F7krR?=
 =?us-ascii?Q?Mnn+g9BaOtC7jToMZ9FzsuI5+1mOQrlHcATFhrMVKvqIqJ0do+gaySXiT/mZ?=
 =?us-ascii?Q?qP+kdI3asEEaOlyz3N3xEksiz6adM3j8nkz40B4P+NrXATvN9rUHau4+gwkn?=
 =?us-ascii?Q?AojoHKzISrGuR+S1sYsT1s23KoxX2T2cysaap2uiO3MX5kOA2Cbc8XRFJAxT?=
 =?us-ascii?Q?YCAtXmDxsUFW9VX8SblVB/DKKQMLSQFd4n+Lcs76L15lbOGTITNIvdDtqUO0?=
 =?us-ascii?Q?9vp1eLIHmjGxOd/Rw4LdU4qzelpnqEHzAUA4xMJhtdVRv5KuSah3HMp77LqC?=
 =?us-ascii?Q?aqhhflHjYpbXVEp7aDsUvZu8o1l+tcIAhG125BgBAsk7IMRDJ0bnSocscJn5?=
 =?us-ascii?Q?1/CXINYAscXCZAVAZ+A5kPGfWuKrqb+xZZwC5P94YuAJ3rFYxjvC8GJ7VWn9?=
 =?us-ascii?Q?bE+REhnWTOa6TUVIUwIyJo4pZB+kiL0ELqNgAW59uyv5Xn1bEVzMzE98sLp/?=
 =?us-ascii?Q?KunoQWP/Ive3mjozwX7A/qIQDzJmn3Ham7OdM2AW8y35L3ZmH1baxWfRIb9v?=
 =?us-ascii?Q?n6iP2KBjlwLZEvGbrJJDJc0PN1nbHyjzug7Mq75gc68Z6FsDE6tV7b0+vKnh?=
 =?us-ascii?Q?0XNZj7koAJe3t8YFiGup2s3rBtvK9eZt/HyLVO2zLPdwn+8AnsXix05Cj6Y4?=
 =?us-ascii?Q?DKKnZ6zPOD3P0MSXQ5oStpSSEaz1wKWa4ikUt7vouPSYqtgs8yDTT2N6oo83?=
 =?us-ascii?Q?ybMg/aWBwzU5xgKmio8Pi2NjR6TOh2erSu7KRKFYaMor0i06dM31fVpIRZ8A?=
 =?us-ascii?Q?YPdC78d4UWAbWbGv1bCEXjnR1RvXsySgocqeGjCbrNV3jfWH9A2q4Xcn8tTZ?=
 =?us-ascii?Q?+2OqVa1wTBZBI7mPixne7oyo6TUpSRsF0nS1tG/qUYnIFwYNA3KNbizqpL3C?=
 =?us-ascii?Q?nuVAu0tly1AHCr3y2269fuCpXI7mLRPpiEA2JtTu0/Q2sB6ZaFGI3WIFjJXa?=
 =?us-ascii?Q?giJmSzXSCxnOzjb48O8frl1Yvkv99fSAd4hwczgwtp2VGIDmEQnGhOW70lNS?=
 =?us-ascii?Q?InbOeSYGh5QPSWHEbYuksvHcMuIa9xxwrGldC8TBchUZ2BojHT8W9Gayiztc?=
 =?us-ascii?Q?ACFjUDG5Zw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0d2bb2-ec10-4195-318b-08de890988b1
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:25:17.5878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyK7nruU+YiBSYVMFlLWGB2YrV9fkrNT1NheGtQ1w4Limd44b0WiWAZoezzCGf6pVfliDfBxYVu0OwbVyeWy8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF12042BF6F
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=nathanc@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Change accel SMMUv3 OAS property from uint8_t to OasMode. The
'auto' value is not implemented, as this commit is meant to
set the property to the correct type and avoid breaking JSON/QMP
when the auto mode is introduced. A future patch will implement
resolution of 'auto' value to match the host SMMUv3 OAS value.

The conversion of the "oas" property type to OnOffAuto is an
incompatible change for JSON/QMP when a uint8_t value is expected for
"oas", but this property is new in 11.0 and this patch is
submitted as a fix to the property type.

Fixes: a015ac990fd3 ("hw/arm/smmuv3-accel: Add property to specify OAS bits")
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c          |  2 +-
 hw/arm/smmuv3.c                | 17 +++++++++--------
 include/hw/arm/smmuv3-common.h |  2 --
 include/hw/arm/smmuv3.h        |  2 +-
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index bc6cbfebc2..65c2f44880 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -850,7 +850,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     }
 
     /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
-    if (s->oas == SMMU_OAS_48BIT) {
+    if (s->oas == OAS_MODE_48) {
         s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 79018f8d66..7fead1c3cf 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1984,6 +1984,11 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "ssidsize auto mode is not supported");
         return false;
     }
+    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
+        error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
+                   "OAS; other OasMode values are not supported");
+        return false;
+    }
 
     if (!s->accel) {
         if (s->ril == ON_OFF_AUTO_OFF) {
@@ -1994,7 +1999,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
-        if (s->oas != SMMU_OAS_44BIT) {
+        if (s->oas > OAS_MODE_44) {
             error_setg(errp, "OAS must be 44 bits when accel=off");
             return false;
         }
@@ -2012,11 +2017,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         return false;
     }
 
-    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
-        error_setg(errp, "OAS can only be set to 44 or 48 bits");
-        return false;
-    }
-
     return true;
 }
 
@@ -2143,7 +2143,7 @@ static const Property smmuv3_properties[] = {
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
-    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
+    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
                               SSID_SIZE_MODE_0),
 };
@@ -2180,7 +2180,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "supported.");
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
-        "are 44 or 48 bits. Defaults to 44 bits");
+        "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
+        "supported.");
     object_class_property_set_description(klass, "ssidsize",
         "Number of bits used to represent SubstreamIDs (SSIDs). "
         "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index 7f0f992dfd..4609975edf 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -342,8 +342,6 @@ REG32(IDR5,                0x14)
      FIELD(IDR5, VAX,        10, 2);
      FIELD(IDR5, STALL_MAX,  16, 16);
 
-#define SMMU_OAS_44BIT 44
-#define SMMU_OAS_48BIT 48
 #define SMMU_IDR5_OAS_44 4
 #define SMMU_IDR5_OAS_48 5
 
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index ddf472493d..82f18eb090 100644
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


