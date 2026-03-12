Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3327106ACEA
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nCR-0000tz-UN; Thu, 12 Mar 2026 17:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCM-0000rb-Ge; Thu, 12 Mar 2026 17:04:03 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCJ-0002qm-Uj; Thu, 12 Mar 2026 17:04:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMeAg6yAQFlhf0qs39whqZFT84WyfXDqekkWjwuhUFBjKiUpH1ZIz/zrxDcqyHQfJPMS7W29sq4yF63V/PzGPlcQLIBNsDQMgAi/tMlzVCprtC2nqa1QKOuJlXGSVcnE/lIKNdPATjnOo0gRDFWOZ7rs4ieeaHHrf3mu4+Voq4Dt9otuGdxM1zVLG2rU7vt/4LtHbMp2ZIe2njRyUMWTow6Q67ZEdqRODxT7kbxwbMb/knttnQqJQPQ0P+9D5Bgo8ndMe09YmqcxqGnPrhNFmIAgXGbrBhXbXNSUS1o0Xyd91iA5iGhcgWpkuhQacsD5pc6JEZXb4QE72ipwgJ6iZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxhPNaMIXGBoGfc4yN4GxlPNFt5GfT4+651NG6tdfQ0=;
 b=NDmv+mCqG/KWs/bQ8+rOO8+TBWNC/rB/X2mCypmfL7LWlNvkzwr96tevu6Q9ajhZrC1tNf1DhoFyNalp6otYfTiXXxOlg0q+8xndC60Yk23ZVXX4qMMBFgbFEGIICIBeuZPIqu/z4NKxwRs2k9EHq0ZvH2UKvKIOCGUEAxbUYFTBsObeCvHJuoOHigcwF8H6AsLm43N04IMKl10HWymg63ebr+l9wzSd/p+xp8CEfZ3xoXXptWfGtWBytEWq9r4N8q2NAGuFRdseTQvHGaIysNz9Txk2w5OF7xWLHuNBiOdoA9YM+WPCVU2QRDUE5O7Don9nW5gOrTcL+ZS4DoK2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxhPNaMIXGBoGfc4yN4GxlPNFt5GfT4+651NG6tdfQ0=;
 b=kZrr6IV2CdcPuuWLrldGWrt6B+l8c+v0KrRrJrNoZ8YkigTABWZ+VHMlkoZclQm+rGH7oQGCxo084FHohwGRd/JIGNehVWApvgRJtwlsRLCUtiviytzSO+oCz7A0uT3jiN55Rza/ZEqlOce1zWXAeAV9txjW8NV4y0X95ad4RtHEx2K3wUFaiTnH7rxM4mYYhqi8k2Cs4Zt66GqwKxzbukZhutHclMh6Fod3gPcKaOfBgy4ydwA/vCNL1bX1IMBh271b5whdfzmA6CT1TH2COzhG1+fGUEm7E6JPXgv4N1SOKa3X7PHNANF/62i23R89jLK+jqmi/QctFhonVDw40g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 EAYPR12MB999156.namprd12.prod.outlook.com (2603:10b6:303:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 21:03:51 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 21:03:51 +0000
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
Subject: [PATCH v2 3/8] hw/arm/smmuv3-accel: Change RIL property to OnOffAuto
Date: Thu, 12 Mar 2026 14:03:22 -0700
Message-ID: <20260312210328.2016191-4-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312210328.2016191-1-nathanc@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::19) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|EAYPR12MB999156:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d8bd25-424f-4804-6db7-08de807adcf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EyIgZWFewdXNJL82XV4bXYCbcQk0BwgnUTDpiF0I42PlWYU0w8eF0a6bglxQ6813qUA2anuvIPnYSyXAPxYaNkh54u8Nz/pPMtWJmaXT8Unrvrhdoc8woUdJs9BXybF1zoYFHzeZ23/9ynOv2tyhz/6EEeP1/p7pv4TGaRCPi2UYJaAPzt8aUGeNSbVK4+LGV4CXXjsEZWzjkPDVoir4M6Xdy0+STWqoCNAq8QJLxk5R3ZN+DN7FIP0cY30ZpbJTghUxk8cEg7O9XMDFyavmtyhZaRjd8LGmUKnBhDOINXBtY93+2GIKAVxYiF+PLFYVAzeC0bglobAG4IRw2BEegbbzVDoBaVe6RPp+mHdMrwZrnaSrHM7AxKIA3znIPv5KG5Xms9N7KaQ847CGj3U+WT+cbc9A57W9l2WU2+mVaEVruvz7aE/lLe15rsuw4Kj0i3HY1+x7fLi6584lTFnx9sKr+yzJCh4MZLf+S9BtOcGkEwKdynCGwSP1VHpXE5JPxCWLyPP2J05uCkOhnglDQIt/kx8S/+B91p2vhY8u/F3v2T3HceA/I4+6zDwIXkJbK3A33/tqYKED2g6TEkuJrhCzTIuM/emBvwphOQ+EE75yBEi5wjtdZ8y1caIyEl4r4JWpFzW5kbA4Bh5dxhqVwitG52ljbcGi4ZvJy5p0kVsBgG9TGt2Y9IDbOx3A0PLYAASHTxgGIfxS1ovR1sye3NRhj1Gm1OYBO82f6VJTP14=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KX/glaUihgpRG2CAGAFQAgeYQ5P9MPe5Yf5zEyF9KR8wzGvHvooso6grGGPT?=
 =?us-ascii?Q?6x3qigAnnYJP0LxHW+WYVlLsEpcc+TQDWL6niWh90l+Hjh22Qz3LmoCua11x?=
 =?us-ascii?Q?IiXLM8ZzWYFfNA9Rcfy2L/UMubI4fvj0EIXi9vIxGdP9YBYZqXL9yYOFEFtd?=
 =?us-ascii?Q?nzY+s+uEO/mag0LZZJ1yOMd9B4fbGXQZbDvpV/N7dJPWHZlLNYuqCu5Ok6RO?=
 =?us-ascii?Q?TPQGj8NF9Ciu6kzAZdy3WIXRykm549TvyD2t8pzOubUziqvF4OEP30YZTLGT?=
 =?us-ascii?Q?pEeIb914h0jhPEMPch5VAynfmvg8wWzxj+8ciz0ayD+dib8/QscQgBm6oJVQ?=
 =?us-ascii?Q?7iTOeW5XD+f76Tk8/4o7ZMUAD3mXB4tdIGROj16o83sgYTIJNsGeKwRKf3gs?=
 =?us-ascii?Q?lEMs2bIZOgkDON9AFESolA+JxA7vD2y5c5YNy7d4HPAs69QWI2i5K1bEgHuv?=
 =?us-ascii?Q?EwfwIXnlpY+9YTaQ3JjC5qVB8hYl2gDSdWhqcBGuP4CtTn2XxY+4QtsJoWUA?=
 =?us-ascii?Q?B6hYiYTb+qmky76mhx6MgIMylg1PKL+SI+f4XKkqNM7aJQG7wYmwz7kypN+r?=
 =?us-ascii?Q?pSO5Ler2pEYR8av4kykPemV0k0C9o/sT1QLtKO6LlM6fT5xHpFu16z09ecDS?=
 =?us-ascii?Q?1fDLQdXD/wQwkMOzA7t8xL64HuvKaY2IaqhwvlZIsw85DRmNtkeHcH1iKZqY?=
 =?us-ascii?Q?N2bz2ud8o4u1MreW+8YlUges7iQeFixGwNtZ49SXDa/AJBtkOQ7ovU/pRqJB?=
 =?us-ascii?Q?i0ONvrvLEYF8r8RBm1iJGjTBXOd334A2W22syibhNgiVuMnPqCG5+LB4zGus?=
 =?us-ascii?Q?dAlW7arFhEUDp6RrE118uz2DIG/rW1xnZ2QaFXK4l+ETfr/cRIiKS3QYSNbC?=
 =?us-ascii?Q?UrTWSimMMqGDwQNVEOPrgYWkEqTe27Ic79QeAwBoKO1cnxnu2pxpNKl0doFu?=
 =?us-ascii?Q?zhIiya1RVGyD1BV8DewXbIqDGA053+0sOS7BqMfbXmGqFtKsJ2q5GIxPAciN?=
 =?us-ascii?Q?8HHLo1axpgLacatmBo824dJhnK88U3p+RtDvGl352M7qxsYc5SHHzMiBk/D9?=
 =?us-ascii?Q?hXNjPF644t5iu/MhB0t6eNiJiT7eY7s3Pd6BYDhDHJIQo9gSmkQ8/+r5RLBD?=
 =?us-ascii?Q?EREPJP0cx76mVwyYxej6cgLr6ozfoBYY0zx73GTYDqeG4wjGumZeW3cDSNRo?=
 =?us-ascii?Q?T06WQ+RMKPX1/HO4L1zBLYkOg1dJr86eKFJiwWO6UIggcCDbpRV0JMPqyy5J?=
 =?us-ascii?Q?UDYCV+TJcWtbkjcrrx1jCG3r9qIeKwVCmthZRZxbbDhOB3kIClVgkdxm1ljv?=
 =?us-ascii?Q?2DUyIo3UJSRgEvk/Fbe9KYIVesTi4Umf/81VT8W8hYuGl18l08lm1FU05cec?=
 =?us-ascii?Q?coNOvYsUt8uhSuLoFEZQWlsoAEOp/jWAc3ztw4OWas71VloUsjPu5YnwwrPq?=
 =?us-ascii?Q?5drZtlMzo4PZdE5zTA0Ci8NveYobfV5kZvuLU1ocg7DLXdJhw4E2OsB93uPM?=
 =?us-ascii?Q?CuQTlCMmoQAF59JxQbZV6rZcq0MjU4+nnpkFR5jOTi5p+viaySQz9zKi5HON?=
 =?us-ascii?Q?6gKt0rL6ce258R/2QyKuVeb4KFS8USrb90HJCM2xkRhSx1xnsW2TFDPlr7bq?=
 =?us-ascii?Q?xaegmXXPRIIK38SwZGOGCu31F/8yMeycFYXhbUQz3XAxL/Gd/Mr58T/HEY/F?=
 =?us-ascii?Q?MCvgNXcl7kkE35szy1Rsm01W6YqA5R9lnLNEndXsYkldUa7VMz/9NRQfRJ2z?=
 =?us-ascii?Q?UQpu50G4YA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d8bd25-424f-4804-6db7-08de807adcf0
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 21:03:51.5388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoHtB9irB5ciw1Jh1BHiBitWlGu49TNQ6AK50Q1E6JDcqWSfkIhWQePlOE8WMTX6VDomvU0XyS/pfB3hud3/uQ==
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

Change accel SMMUv3 RIL property from bool to OnOffAuto. Setting 'auto'
will use the default set in smmuv3_init_id_regs(), i.e. 1 in IDR3 which
translates to 'on'. A future patch will implement resolution of 'auto'
value to match the host SMMUv3 RIL support.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 8 ++++++--
 hw/arm/smmuv3.c         | 4 ++--
 include/hw/arm/smmuv3.h | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 5d14abe307..6f44fd3469 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -824,8 +824,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
         return;
     }
 
-    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
+    /* Only override RIL if user explicitly set ON or OFF */
+    if (s->ril == ON_OFF_AUTO_ON) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
+    } else if (s->ril == ON_OFF_AUTO_OFF) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
+    }
 
     /* Only override ATS if user explicitly set ON or OFF */
     if (s->ats == ON_OFF_AUTO_ON) {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 862ca945d5..acbd9d3ffe 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1972,7 +1972,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
 #endif
 
     if (!s->accel) {
-        if (!s->ril) {
+        if (s->ril == ON_OFF_AUTO_OFF) {
             error_setg(errp, "ril can only be disabled if accel=on");
             return false;
         }
@@ -2132,7 +2132,7 @@ static const Property smmuv3_properties[] = {
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /* RIL can be turned off for accel cases */
-    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
+    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
     DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index ce51a5b9b4..c35e599bbc 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -69,7 +69,7 @@ struct SMMUv3State {
     struct SMMUv3AccelState *s_accel;
     uint64_t msi_gpa;
     Error *migration_blocker;
-    bool ril;
+    OnOffAuto ril;
     OnOffAuto ats;
     uint8_t oas;
     uint8_t ssidsize;
-- 
2.43.0


