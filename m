Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1484106ACEF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 21:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0nCW-0000wf-N7; Thu, 12 Mar 2026 17:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCT-0000v6-HI; Thu, 12 Mar 2026 17:04:10 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0nCR-0002qm-Vd; Thu, 12 Mar 2026 17:04:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2f/MqzAMwjSq/2sTags9ZCjzmKwNIQ56SYhO2ndq+Xu+a0iNBy1KTeEZzjbxNtnWzmGgdharTsQXA2Q1TAc/1Ys2a9GuR3WFa1ht3Gu3rizIihclGpuQ+q2L17BIW6XG+gDl4PQ0icSXYIzqX2U/IkpaTJxPxaeoLWJ5K7d3qqnMUx6N/AHlxyrnkVxGRJGPGtd9sNziIQWB77qHmNTKtXA4/N576sLmyCJ3YNVKMkv42BksHJux+T+kFZu87Bc2aYHsoYWh33LPV2eH2yfOk6uFOoVh3VFglxx0Dh9vBqlfTXM58VLbRTtlILWxN6Xv6Xr0MB2TtMG9mhinKsMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hW9brQNrgXS+3TlSC3rwlORo041/YXb2WirOUwB78U=;
 b=LYyJ/jZ/VS1AYr/XJJiu9hNH6WoUj/Bbl1Fr+wePhj7/SkyCdH6AjvIs7RWa6fk2lnOH9zS8ivI0Gnrd01y5i6cUgdedM+6R5aynrMtIVGB+GUmfcXQpI+YcSDdzbAi4JOkc0m+xpMKm3X7aydgTggGxSUV0cxpH2H2SELeDjM4/sjx+MLMd0bZYwFDvb49R3Ghb1qZFa572ik157IUHViz39UW9rm0EW8d3+B4mhqpz1KZehpFGfGnjYcazumWB4DRrLiPIiTBvYFLpjiInI4c2ptIcqXfB2wvPS3c8BXCApXJ5kkjwP3echztjasHNi8gKXb03N8BMt/UnWBD/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hW9brQNrgXS+3TlSC3rwlORo041/YXb2WirOUwB78U=;
 b=VHib1zuTcZiMoGGA5rc6ZTVGbljz6BjHW0HS7IMvinTMDhVRZWMlYM3F8LXHT9+xBbTNOx5fl1Mx1eWrX+56kOOTIIcfwPxX86rjIHsdGCKHkFhjIacDFJjN2UKin0BIqYSeUXU6RLpeu66jZOpF5RQD2tUGOeMwkrhjcf1G2lDcmWWyYxYv1Xt+4XSSexCqenFhGyEpOgitsjk2ljrMuLeFBzezFgXvxKisowjSf7R9UpnvIEarMc2oQDKNGoGr5RpznbUpHj5EVm58Cwk3WBq4oKw/qWGWgEvhHYUMXNxotStSOrYOTe41MnKStR7PchpMU8DH14Ge7lEp3yFNLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 EAYPR12MB999156.namprd12.prod.outlook.com (2603:10b6:303:2c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 21:03:57 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 21:03:56 +0000
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
Subject: [PATCH v2 6/8] qdev: Add an OasMode property
Date: Thu, 12 Mar 2026 14:03:25 -0700
Message-ID: <20260312210328.2016191-7-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312210328.2016191-1-nathanc@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:a03:338::12) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|EAYPR12MB999156:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c33d40b-9671-460d-36b9-08de807ae022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ivTeaY0b6z4dKApwfpqgfoRG6YqDj7c7zvurPm7irhhQa5hLIkqrnHtwSdhZwDSH9xXAeFE5fh6hqobyX7zFyb8dxteCjWgdO3fI6mIfPNEy5yFKMy69Bw0Lalx8Wcd3blsWmHaGNnTS2WHVqJOsVv5Kt4frEQxgi+LxQlXyS600Zo2ialHjuqG+s/to+qMQhh3KPrcbjRggMUVbnnoq453lSMDFjs8uBeCs1x99p/YZwO5hZp5V5NLPa4ANvgIY3+CBwlIXaFw63ZpnrzC4X//sGHPlMoeJs5RX18DGQbZERygrr/hO+i3yMjX5FWcRAq5SKMdwBp+t5SicCDBLMLkDmMv3hHZPmnwvKD4bereN38RV8jYhc4jc29ry5f9rBIyVAcpPB6odLtntV/UMAto5hRNU8Wcc4qXP2Ayt43bojxGNfoy5WFjWw50mEQg/kxu1qQ0qZaY6WUK2SmYmOsbcHml8RtBVRPOPzSItfZkMbz4FPU7Os8KTvDWr+MMCrfpbttlbHMbh9ZYxeHrKnTuEf7OgrZz85qfuCwE1y6pHpcD7XAvbz4LcB5SHLRftZdfugNZ+eOyo4VSWLroAO6mjySzw9vCt/wXeSuh0tvkh29DLFQ5lqxEb606vJnQcjbfaUXU4a+xX0AESU2OsUEvEN2kKni2DXruj966efD/ofTU4Th8IIL61fgNRof/Zy0b6SyyU1cD1z7altJaHlWx/SAIJKIffaSIuNMmZ+8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xhe1zgMUIPVNVtfbfCQTkU7KW+bTm/OYLSUk337LD9RroY/CSPU8dEaZYcAC?=
 =?us-ascii?Q?q7mUzcrcdMrdsvarpUOEtbnKHLU5Sy9usN397EMMOZhIURVBOX9rQ34iFgX7?=
 =?us-ascii?Q?Wu58V2zadqf3niPFtYfARpZxrSKGKImy7gQ6oaLdva1Olj+zlo80NAss7oHZ?=
 =?us-ascii?Q?ARCDOC1HnIIn0V8U7fR7++UCxBVvk5yiKyO7lP6acezzyRR42tpQgivui8lu?=
 =?us-ascii?Q?GidC258i/3ztyTPJY0gZYzgdOilqwT0smTHg8KFr/MAw/4kcQJdsoxTgQ8Dq?=
 =?us-ascii?Q?cALGXySU5fB9caRxmYOqsUdeXCFLpZEXURR9LSY8p2StKbRSBTgIjCjOcwG3?=
 =?us-ascii?Q?I+pVTKalJ3MEfyhMy1pLQccbKygqG8kgNwz0OmwUJf6mQseTLHAfmj1QD98x?=
 =?us-ascii?Q?PF5Qa8+zFlagWyHLGwwJlbZFtAthlNPLH2DVnaFzwvQ3inJtN38f5FifMvVc?=
 =?us-ascii?Q?sIYo0YkRQmRHbLtrt14jHdbms3BXgfcjxUBw7KTJAMXiWNMHHVRwuV6mFQ+7?=
 =?us-ascii?Q?SrDlK5IRILmmPiEyhxIr1Z5U6/Q1WSJfCqF7Yy95m0RDtCWVWbiQGoXMalw9?=
 =?us-ascii?Q?PqMbRm1yH/30cPLKSiqWF3+RFL27GladeoAe0T65etSlLk3qWPLKl9K7mDAZ?=
 =?us-ascii?Q?GQF66oIQJMbKzMJYPyBU35R5nKvNN96Xl9Q6G7noQSe3jaqYA8IUtaL5qKw4?=
 =?us-ascii?Q?/Dl2xAZLTHM8mdi/3lL+cohYYxADWEmeod9JnpLNJALylRxOiuuwrJWd3eBQ?=
 =?us-ascii?Q?BmHBFh2acTTULB/erGZpPiKPqTVbzXAj1nzfVN2xVuwX/DXARBvj8siWd29T?=
 =?us-ascii?Q?OV96EldplSaYaxmPjySiMF8V8n3eH77HjRI7Pf/8xp92zYHrRt3Ta/R3eo5M?=
 =?us-ascii?Q?A1gJa5v5zrNl9H18Cw9ZgGr/QXP8QDV6z2IvQtPfGkHyaub3E71KQMzb5QL7?=
 =?us-ascii?Q?ki1PJDf7o5vpt2ydV5s8pPKShfvC1vANHLsld/bNEYr9NYZhdtYfMX/O/fxL?=
 =?us-ascii?Q?RyPBhFPeSc3AmN4T2rBaEg5t1pEWq9jl+UkFvLL87Hx3YnffjAfNSF/vp4QS?=
 =?us-ascii?Q?o6FHn/gK4JHRb3unqMMk7J8p0chngDmub+n9B6GH9kAdnnS8bTFh+r8g+k0Q?=
 =?us-ascii?Q?IfnmIspNAXDm1AZrXCwA/odxH1Php35lE/4/BI/4erm71uy6XaK19K9ouNjs?=
 =?us-ascii?Q?TPgJ+jC2m0Lv+M+b2AtI1Nz5EcgTsRDxMgqoMaG0OXPkt+SqARehu61Wfsd0?=
 =?us-ascii?Q?oH5JFTCzjaAxlNPbZEGNuD1C1jS77ae/jqJnkrTNwEnUkcPUW0D5REKk5MZT?=
 =?us-ascii?Q?Lp4L5tJK95aojPlDH0LpoH/gezKi3RNAVDKpryTTxCKDf2N/Uk2/XwM9K4w2?=
 =?us-ascii?Q?nyb02HriXJu8KGEgzdNtgHpmIMz5zDLrVnGU4XRg+Gb/wJxg0GqCB8XeZ8ph?=
 =?us-ascii?Q?B9m3Pw7FmetK5L9HOjSedrXSZZThQXx+vCO6nHn2NhcYXdTvKIuiNq2kYMb4?=
 =?us-ascii?Q?MOM6UROc64XBiFie/nBM+vrQeFhgLm+UZSFEbkIroz339/fnwpfTaTJ3/Iuc?=
 =?us-ascii?Q?yFVgs4yNUJ0PBOipJwRXYw7cpZJ7jUVqKoFtST2G5fhbYJWe1Ed8Yzqn9HT4?=
 =?us-ascii?Q?yBRyfPcIc5sleaZSHpuhCLL6MtP5txEwCMFqC9KAI7HPtmQpcpF1hdDleH+k?=
 =?us-ascii?Q?hXteyislDyQpz/6moo6OWqvSvLuMPR/4pKULv2g6cQU/OQhu1gFoR+mmkzq0?=
 =?us-ascii?Q?7tj1NvQUjQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c33d40b-9671-460d-36b9-08de807ae022
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 21:03:56.9193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDVO1S5JWZu4BE0rLZIQyumnWLzAWvmaIPMKCpqG4gdFfP2BWHsadFrEaOuTsKIq1sdY0q72IuciRZ0Q0I0d2Q==
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

Introduce a new enum type property allowing to set an Output Address
Size. Values are auto, 32, 36, 40, 42, 44, 48, 52, and 56, where a
value of N specifies an N-bit OAS.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/core/qdev-properties-system.c         | 13 +++++++++++
 include/hw/core/qdev-properties-system.h |  3 +++
 qapi/misc-arm.json                       | 28 ++++++++++++++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 4aca1d4326..a805ee2e1f 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -737,6 +737,19 @@ const PropertyInfo qdev_prop_ssidsize_mode = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
+/* --- OasMode --- */
+
+QEMU_BUILD_BUG_ON(sizeof(OasMode) != sizeof(int));
+
+const PropertyInfo qdev_prop_oas_mode = {
+    .type = "OasMode",
+    .description = "oas mode: auto, 32, 36, 40, 42, 44, 48, 52, 56",
+    .enum_table = &OasMode_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- Reserved Region --- */
 
 /*
diff --git a/include/hw/core/qdev-properties-system.h b/include/hw/core/qdev-properties-system.h
index 4708885164..2cbea16d61 100644
--- a/include/hw/core/qdev-properties-system.h
+++ b/include/hw/core/qdev-properties-system.h
@@ -15,6 +15,7 @@ extern const PropertyInfo qdev_prop_mig_mode;
 extern const PropertyInfo qdev_prop_granule_mode;
 extern const PropertyInfo qdev_prop_zero_page_detection;
 extern const PropertyInfo qdev_prop_ssidsize_mode;
+extern const PropertyInfo qdev_prop_oas_mode;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
@@ -64,6 +65,8 @@ extern const PropertyInfo qdev_prop_virtio_gpu_output_list;
                        ZeroPageDetection)
 #define DEFINE_PROP_SSIDSIZE_MODE(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_ssidsize_mode, SsidSizeMode)
+#define DEFINE_PROP_OAS_MODE(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_oas_mode, OasMode)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
diff --git a/qapi/misc-arm.json b/qapi/misc-arm.json
index 76ea0a09fa..5dbb4add91 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -61,3 +61,31 @@
   'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
             '10', '11', '12', '13', '14', '15', '16', '17', '18',
             '19', '20' ] } # order matters, see ssid_size_mode_auto()
+
+##
+# @OasMode:
+#
+# SMMUv3 Output Address Size configuration mode.
+#
+# @auto: derive from host IOMMU capabilities
+#
+# @32: 32-bit output address size
+#
+# @36: 36-bit output address size
+#
+# @40: 40-bit output address size
+#
+# @42: 42-bit output address size
+#
+# @44: 44-bit output address size
+#
+# @48: 48-bit output address size
+#
+# @52: 52-bit output address size
+#
+# @56: 56-bit output address size
+#
+# Since: 11.0
+##
+{ 'enum': 'OasMode',
+  'data': [ 'auto', '32', '36', '40', '42', '44', '48', '52', '56' ] }
-- 
2.43.0


