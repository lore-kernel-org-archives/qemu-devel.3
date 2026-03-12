Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34C9106ACEA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nCX-0000xO-Od; Thu, 12 Mar 2026 17:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCW-0000wk-Ks; Thu, 12 Mar 2026 17:04:12 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCV-0002qm-2K; Thu, 12 Mar 2026 17:04:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fi1v8AunBOIJfoFHC1PKvFRABfu9Sb/OsPCKErFFqWheGk4PWrWO5mXZW3FyjmXnWISlMq+I33UXJqPrlQKJuQIzEVnnC9chbopGAyHtaF4zFidhz87ZaNszG4HWDdqIAiphmvymbPHxZfqMWAdPcaw5BU0/rjkFxETRdkHlWuSxgMIYeEJnZ2q1uBZz+NgosJ3OvuD5eeUeQBs5FRv7XOhz26pGOSoWCtaYxqBb3BNc1gJ68DTOjEtsf8nVPRIMYouMH6FGjK+TOEcbCv8WTtbkq4+WzAvM/q7HeQaz14kySjTt2Whnrex4KNk7V3QrMvT9j7hPhO4sm9P+wDJ6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcWDXkg85lWAoo4pjSXip5cyPMnsXoQEoLFjx0ug0gk=;
 b=mnUjfUPdi+AEg0DvqiLkhhKyJtQpWux1sTJkfV4hU+rMXZNUPqG+BKm3XlSTFKuePMWLU2+o1230O8N8EmNdnQgoJzZI7zNWz191J63gyVramJ422XEGgzeAhVqoLka5EacuQKA3trpm+YE+RXfQOK0JwSzU1+BPDsYjKGoNUdNpY+0ekKsIQRluYrs6laeoi0ZSowK8UHdT9KHOXUm2x/5EPmdbAFPgsYQyBr4WzSWaWXEeSZOCWJjYcDTNrnm0fNepJR3Ra1dIOjIILLQ2GMNmEl6VsHoI668RY3/8xTq+1485jj7+PSF1BD59MR5u15QGQFj4Vh3UXgoC3qSEaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcWDXkg85lWAoo4pjSXip5cyPMnsXoQEoLFjx0ug0gk=;
 b=hyC5RD9ytAWQid6R+uAmy2v5SPUzBH7v/CwKwvldoectbXfsCVg5EmtWV/oE9xJl+RtcqLBbWBuyANIbHjF1ZY0IQBq/ClSPJ7jWyPq13UyMHJVZg+bk7AEyl/OFQH/xrTqjcMhkdKZaa+BqKYf3MWmYNNWJQQSSCdsthWe7kfXe3RTuLqvgl2hzaMRSTKELsYk0OnWVHcyEuE05ldJIWSjpWgeyZfVwADa6GpW/97gmXA1HWK4n3BodVwc+SG+GyXZKH8xUKj9rqCZi8l0x4mz7+6j4jRdat5WJyim781Faz2AKfW97Vp7/mT+SXVeh1eN1H+OAxuEG5stF9bYRKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 EAYPR12MB999156.namprd12.prod.outlook.com (2603:10b6:303:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 21:03:58 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 21:03:58 +0000
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
Subject: [PATCH v2 7/8] hw/arm/smmuv3-accel: Change OAS property to OasMode
Date: Thu, 12 Mar 2026 14:03:26 -0700
Message-ID: <20260312210328.2016191-8-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312210328.2016191-1-nathanc@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::34) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|EAYPR12MB999156:EE_
X-MS-Office365-Filtering-Correlation-Id: f07edabd-2aa3-4788-ea1e-08de807ae117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ql/0hRcFgPo/XqaLtfcfOuBEtrxkJX49AKG9RV2zoDst+/BaJsuobulhPhcYMjSPyo6cJCj6bjfQiinL/VpRH2SeUILykvY/q47+Obxkq70AqsZQZE8jIBqSpY2IKtn3obIF/10e4lE3EB+u2KR6nmkfWqveFZSAtXyK01XwPKvnj6XcuBwghLv64wINZSO00Z0vcNWawsihmadMz/naS4lNsK5JuS/xswROFvnys525OsruZQgiFJvgwY5tIlWaRzHIwEqIWDps/1sm3gDApNJBJErkO/wGRLrCBZ5cOl89clBoVtYOaggPgDPtoXo4r9L4llbmkO+RDzUwlazbCol7zEbGga6RIjzYzPQ3C51aWmcI/ANH6f5PDCBMoGtODc7/CpPj9k6xtBHEQ5bA6XlHXJ77eNoFNQaZtnq2TlY6+hW7xM8i0+B9OtG1jz1+WfYMvJW50lJBmBZbh2EQPvmR3mb9AixyVz/cBBdmXs7c458Zje/wDzZxs9fDDLR5s9/WqQ06ynD55p5sbhHJ4OSXoOrw9g7rFGaEjr9j6J5eOzLDltrx4sMLyy+X6cIatoqa9iViL/sVPp5pvtwk07AGt2+ENdCmT6SX45lvZW2hrYLme945+JojIH8DG6CTeNIN5IDbkBnQE9+yvGv6xtwBkwc1tj00MjtPblFWryXhQw3s85ENKeOB9lr7JslxwCnWjE7gm//ZQtwPkpsBwjZsu730EfGQeUuwK+FJbFs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4wLYK5C1wEKa4QxNDdF6Z1ayTXWpj+XNcfzN+ahBfZkzJlkA3YNOje9FWo1k?=
 =?us-ascii?Q?YoQ9CDTq4HgSF9SP2qkWTiZaIQ4eJjqwsGL++OzMYqHlr7wlosIuHFZGjiW6?=
 =?us-ascii?Q?rcBdJBDA25ha3a9/wHyn4iJAG+RwOMB48xMfTkoxks1gaC+FivJgT/ty5nxC?=
 =?us-ascii?Q?7EaZr2x+Abwc5lKgOmIOJyf7sPUvsHt0HBX6UAm/wnCyJ8tK65XyJcMj5p1h?=
 =?us-ascii?Q?s2ZLNLXnNiYMSlmLiREU3x/RchE1rmn0a3YYd8a5ESkfOhNp/j9yJRmVEaPa?=
 =?us-ascii?Q?ZVhMTutD8cPcmF2PaBfw80/FJc6ooo5pnJgG4ESyO3QuTDEVToLD1k7cUcR5?=
 =?us-ascii?Q?BOkENQDaoDmWn+dWrThyfVF5J1iFEr8ZY3wZ9NfSNuyOgeiYxrr+OJ9ZgE0O?=
 =?us-ascii?Q?jlyEF++s0dSYeoIf91i1VfwskI9Zf78AsBXlDJDNT0Ts8IQHib2+kIFC7vTi?=
 =?us-ascii?Q?3x4Z1mXFY2001aHNSBdPeGaKw7kuE3+9z0IHPZooB9ORAQysEFihQ+S7cD5f?=
 =?us-ascii?Q?S7j794vsSRZ3qDZMtNQigUY0pI7fZXzBre7gp35GhL5fzDSbyfXFSPAiEDlU?=
 =?us-ascii?Q?/kkQZxzWq9qXQ1l+iixAKm45h2rKe0KhQDvnDxFmiUjd94u9uDzW3ngyjnRM?=
 =?us-ascii?Q?INHRZwIGgD1vmNRFUhuyasaSuxuE0ofcUfVwsxNFHJvwnLCakcVQzFplPxa3?=
 =?us-ascii?Q?wPhrfG6kPodf1exOU+GLjYLKCFhco5F2v94UvA8ocd0txG8zkPYiinO40Ca6?=
 =?us-ascii?Q?RBSHThkvKb4tCQNtAddQb+z6NGMqKgOuSqgOZ6QcK7XMVsVK2MRaryUyfH3L?=
 =?us-ascii?Q?vO7imfhRs7XEoNo/r9Yx0+Bqgd7B2nPP5rbmffsomlwN+d6zeT1Dw1GN5ENu?=
 =?us-ascii?Q?Z4jYQOvv8khA2YXVNEqFrJQM9y6TopjFKeee9dNu4VLncjFBywkPllTDVgAk?=
 =?us-ascii?Q?/417Zyy6PXi3K00cE41VQleq0GENbqcmfPzMkTYx1XQYPvpiKNSsVvHmziXr?=
 =?us-ascii?Q?3lxALFfnQ9qfKbn0OiKuMqOSY5DrS7UcxR8J2+Ce1OvLtTJuetVAh5R82vg1?=
 =?us-ascii?Q?JCJkhJIU2kwHovjmpIqWTbQQUJZAYtIeZAPMJeVfSZiVuQrx1nCjUh+hDLRF?=
 =?us-ascii?Q?lGS8NQ7RAVPE/ar+h3ZSMuqc49WlS8EU+0vai4jLGtyQr/iDbrZsAwNBlKAx?=
 =?us-ascii?Q?opL9soYktZEBn/5FW8KncvycWR8h9EL6/muN2v2dz4dLzT6UnRgXUkMg+5T+?=
 =?us-ascii?Q?y6opWk0f9mhPvXTcQypqnXTtOX1Kb/Hvm5YTckxh9AcNEyBDo/IcKmX39/xO?=
 =?us-ascii?Q?mrABR5zakyMpoaN62y45u5eVyQH3E5fi+NRdT45zt71IwgsOvdDdYuio89+0?=
 =?us-ascii?Q?D7/kb6Iz0aZiI/h3SQYmmXl+ZCRz8fyz/PddxftL1KffcKt+f7KhGeyu2tnE?=
 =?us-ascii?Q?C4ygMHFKwgP/uFYHA1hi8xWtnqFz/qTzcR2j5HL54ZMf/Oo7CThezIV+nXvL?=
 =?us-ascii?Q?No/qzUb6OCsONDZhJwkwrZ76ovpCGay82/sppVIm/me/K5LuB0ml8baMo5X+?=
 =?us-ascii?Q?VpBze14lZoPbmcncIjeFxraiZAjTghF69+HEesFmho71hhDkySKWhAQ3+zlN?=
 =?us-ascii?Q?23vkx0ai1x7QHdoixxRLBJqUd53jr5+BOMzGrVvtwh+R4AuMZIJSllyl+jw4?=
 =?us-ascii?Q?fzZ0bqyo9byYy3l2rXkODJ0K5OeHjEB7OtlDSsZ3wVJ4oCboQxI/ISgT78Vq?=
 =?us-ascii?Q?MVDf9HTc8Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f07edabd-2aa3-4788-ea1e-08de807ae117
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 21:03:58.5760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+mB5w8ReVTjMs6xusqZU4xTyK5Wc8fjdCucfWQ789VZ58O1kuJIMrcw/cFw9iKT/9JJxVFrBZMlKlfMmQ9J0w==
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

Change accel SMMUv3 OAS property from uint8_t to OasMode. Setting
'auto' will use the default value of 44 set in smmuv3_init_id_regs().
A future patch will implement resolution of 'auto' value to match
the host SMMUv3 OAS value.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 2 +-
 hw/arm/smmuv3.c         | 9 +++++----
 include/hw/arm/smmuv3.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index ab037df7ac..5073f74b8b 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -849,7 +849,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     }
 
     /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
-    if (s->oas == SMMU_OAS_48BIT) {
+    if (s->oas == OAS_MODE_48) {
         s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 8b0121c0ed..9faa9c8dfb 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1981,7 +1981,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
             error_setg(errp, "ats can only be enabled if accel=on");
             return false;
         }
-        if (s->oas != SMMU_OAS_44BIT) {
+        if (s->oas > OAS_MODE_44) {
             error_setg(errp, "OAS must be 44 bits when accel=off");
             return false;
         }
@@ -1999,8 +1999,9 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         return false;
     }
 
-    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
-        error_setg(errp, "OAS can only be set to 44 or 48 bits");
+    if (s->oas != OAS_MODE_AUTO && s->oas != OAS_MODE_44 &&
+        s->oas != OAS_MODE_48) {
+        error_setg(errp, "OAS can only be set to auto, 44 bits, or 48 bits");
         return false;
     }
 
@@ -2130,7 +2131,7 @@ static const Property smmuv3_properties[] = {
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
-    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
+    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
                               SSID_SIZE_MODE_0),
 };
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


