Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060AFFEDA00
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ZJi-000440-Iz; Tue, 17 Mar 2026 14:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJf-00042O-Uv; Tue, 17 Mar 2026 14:38:55 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJb-0002xI-3p; Tue, 17 Mar 2026 14:38:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5f1wnZ5y07QlhzFOWhqxq7qyA8VwvpDWtMAdZb9AlUPkzSOTbQrP4AqDIuXlRhk38S7r4RI8woJZzm9zChn75U+MQTCz918TcLP4DqsjptMWT19oXEDD3zb+kA2wzRHFjoEY0hGNE3VCQKFQ2hEcXDBHurJWydxL7bAugkg/Cn1gnu/ynFShIcYxeGbQbvBYjFPdEJD/SWGrgMg5ugRBs8OeynQYtgeWh4dUod4KuwL5zU4Cn5qea9a1FsOH8Qg5ZlYx9/rnncOoKVv7af5182GXNn9SQmJPuEb0yfAIsEInLDx0jjU9kKGiv44N86v9NevZlZXJaVNdV56lDb6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruAHb2+xJxG3IOlRy+8UgPHu4B8jvGytKiHWNzmc0vU=;
 b=Bxo1P7+ab9nFzyuMZkwlwLOzJf1693hZLL4VQAB8hYapgKb1N8iNc060Pszj0d+EbunacYRivEQda4/qml2O7DUY/X7M2/VUmto/g22SNsk42AcIveMjuJb0rvXkfL1jOU0r73aVU969UcWtT8V42Pb7tiKkvDLQwmM+sXtw0xu5T06ZqJpIEA6WcoCJuLwKOJSSGca9hHzUkq/b4SSgHinI+I007nF+F2iACtahA+UhR6dZEORPj87zpccblyE/2GsZn7fzKqULgtaPZmjAAVYxTWAS57RiOP0ni3oQGJekCFPbhyZf7xeevsZQ0NZMthamz9x3Etqem/lbzBxMqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruAHb2+xJxG3IOlRy+8UgPHu4B8jvGytKiHWNzmc0vU=;
 b=hX7FOBaGwbz9rfSLc2QWJY2e8f7w1mTM9QOXhTT88eXkhAbMod1GHwJsZFhVdqrQZb5j+YSWXC1f2ARvz5xJPqhJnaPKcCTiaZEThndyRmJnVARGr8q4maV94GsHeeKo1NIWbjE2iMZfldExBCXno127bCnitHHI7vcjjJ+RIHcEsZ+wwyyVbbAAt7b/CdSSScBfnSPbl9dR7+tM40SCHo3eLztph7M60EZlNtgJBM/GBtgwsKgki23zhNiTTk+qaqqzqsoZNAC2ZgRhsKBZScC+tFxbP4XvtLBdCYhM87AZRZtm6n4YitSIjFl24p9I0CF55vscwmdGlZnkT4t+Aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SA5PPF06C91DA0C.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Tue, 17 Mar
 2026 18:38:38 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 18:38:38 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v3 7/8] hw/arm/smmuv3-accel: Change OAS property to OasMode
Date: Tue, 17 Mar 2026 11:37:54 -0700
Message-ID: <20260317183755.3721625-8-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317183755.3721625-1-nathanc@nvidia.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0092.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::33) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SA5PPF06C91DA0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea2a79b-4dd1-4522-22c8-08de8454676b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RWksCOMYJqS/3GruVwmLgIsCRqJNqlYNSv5DEhwwIP9H5eSiEpmrxQWjIfNnswVu1iVMVnFHSry/zeXlyUW8DLHv+jkuxH0SqmE5n/8YMsFAofh6c269wJtrG5aGV9RA1riYSTayX/fnzCCoMr96jL1YXsxq6vl9zg5xpXy2JBFCLoQlmZLCDFQrdAZ8cY/Zp9Qe+u0bZZb9WT6lUXbraDE2S6TuGv/B59t2PjOlAk6ItsL+4mG2530J41PQYeSupb6YAA/kTDtL2FkAk0ZfHMz5w3si4xY/CY5NEMkUCa2Y09FJy2Pd/h+qSb+TqaaYff7Kp9rfm+YeRVlmsBjCCnTnNfLl0gLh4v0P4uV/8fCPD7r6SmEX/qnoiU0lV4P2JZAZfptkaSif9il412j1hA1+QxdPyWUykWO/KgSo8u7wjcsheyfPqAVwtWCY9Y3HfR821GcdGZLcUvCqaWmlNtqipeRlOBhsbrcuPYAxTBEf12EaYirZ4Ww8Fapu/9Pg1FcG8rKhQ0kaj215mtZP1BLqFlo+qp42G7V3EH70WF6OypyhoIR6PDca/Caulu1cva09f/R21UadlbnYhf0M4Rk176dInda3Y8aqhQlBDPyz94j82xvDlYiL8k7I7lCmiVJFtj565jsx5cYJNs0vP4CvoApe85xqKVpaSBd4WI33IzpmQIPE0QkkfClxYZw6z5MnHw0m3gCF3QUGZ/vi0L3RFiuuQMlbJZx6JYwroW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m69VzWHscmf8pnnJI1HqGKRDFzCq3uch8iQ733DTPgdQeQdD2mpbRReJgT0T?=
 =?us-ascii?Q?B5ZWuywX1/l+MryfF53IYWWsAPIfy4TLbvTZ7IMq+rNrd8goMcJ0FdSB++30?=
 =?us-ascii?Q?Qr2Z3npx3n4vTJnJmT8tdG9ZfdxRMc6vj67rlJC2SQfGoc6QONaYZVdw9vCr?=
 =?us-ascii?Q?4BQAuRl4bOBpMYEJoQMbxbBM2fynZzIFA4ndj69F2ffnBy0+uxex/pRFB2y+?=
 =?us-ascii?Q?zjF6/rSoGxzIsbQOgOGxt+cRHDH6fk/PL6Ywa79q5o4yfx0gv7RI/OnoDgTK?=
 =?us-ascii?Q?13p7y+ClVcqHAfDAsppqa+PgnUFdN4DxhZxB4JxBxleOkI+XByeOTrGl9Er8?=
 =?us-ascii?Q?PGdczw17Py6IEBNHAAtGIT+8wKSdy4WYRgJ55jVsma3rGqmmUiHNS20EtnaC?=
 =?us-ascii?Q?HDBsMSPIjyCfcK4JtXqknkCEW7i69XPp1Df9e6CEUD/ILUQFgJAtbmtEnV+9?=
 =?us-ascii?Q?pGSox1kAx/Ng8KrSMosNw7Up1zitgVpceY3m1nGsqjIeUu41PZrTXQKusACa?=
 =?us-ascii?Q?R5LKcvBG2OvkEQgk5oU4lW2xcop/TIYHrYmqdf5lTFAvWFHZoVHRytTIoGA7?=
 =?us-ascii?Q?5DxFgRaiSY3/1E0W0rCuJa5+wV3wuAm7iAwhJnscH55d7EmaWmsTy8D5k6A+?=
 =?us-ascii?Q?Dh/iE9WPXurP8Z+fsFny48Hl6eYV4rHj4mt0GPrabS0EK9BnIdUeo7tuHo2H?=
 =?us-ascii?Q?lWMjkum1OBtnx1b9JkNWCWAXx25KU3SBdpiEy39i5/p2/khQbOXGIfNkW4o8?=
 =?us-ascii?Q?lZGzRcSSp18xOWSDsHfxxZ1h49sC0qv6ONN941XMgDjpPBfFd0uBeKITQZhF?=
 =?us-ascii?Q?cdYt82Z8TQGRFazTsClRWmb98uCIcf/q7FnlK/4YBaJHCKfnhB19n5y/6CKg?=
 =?us-ascii?Q?o4WGzaP6mnY5O4hk4VsGQnKxn2Y8woNsSfaae7vNYwepyQMREO/c3fricuEC?=
 =?us-ascii?Q?uxR+4kluBrT3FJ+PU5OXN/VfYMmtYZqlN3TA859g3NGxWyycXxMchpH9WY1J?=
 =?us-ascii?Q?Tm52MXNEo4I7ODhB+Xd3bcOgfK32gXg/k4/Gq1Ud7v0IMjNIUJHAGQciU9fI?=
 =?us-ascii?Q?xYW9en+kh5AV41P6mA0EKjo+kwYQiJp+P/hEowo3AbrE/5KlL5BP+SQAA5IO?=
 =?us-ascii?Q?J85wU3ZbR/1lsqAvieiKD3aftO7KgiQj9OfPOR/W2dJAMG9j3H9VIL/mcJLz?=
 =?us-ascii?Q?7CdJErhMcvyGY8YxlgTHxAVs41jPAPvHrz4XkkNJe7ty9bcZely3OuKVhPh5?=
 =?us-ascii?Q?DaWDKMhusUT8hCFbFsRCM29dVf/G5GXtbmc0dedVdY7ma9bsehPGjGBZZXWR?=
 =?us-ascii?Q?tcrosuKGkH7WXBLNJ7NFOmy7H78JrvOmvx3LAZTt2uDLPl8rBF5gyxDBwM/R?=
 =?us-ascii?Q?c+VFNP6BtpO/SaVhcgSPLpl6r8P0LHPj+1v5Mawl5+cqjTnKYolt5CAW+j+g?=
 =?us-ascii?Q?m9wqa1LcFxjXMft/H9Ea8le3rLzAwO48WUk50YTVSc/kusRi673UaLShXXnr?=
 =?us-ascii?Q?HbScWm68NS1sxg5jV5Q7WEPNQB/pnWDmMuJBif+JFLCL3oFgRlpfRyhH8lMx?=
 =?us-ascii?Q?dkF63yQvRUpUTHKw6UrrluYxnabshtvaiWYmMph01gtsDoqm3jrOyrWuH9sg?=
 =?us-ascii?Q?42oCYq/zbIHVuMud8Ng+YHRpjRdlJ7tC86FJ2DPBNsoD/iuGbqGQd8CAylvW?=
 =?us-ascii?Q?2Wx8MKHOkqGUwBBGrRXshxX/1h07/PqeRR/e8d3RsD4/MmxfeREsz2sDEpCW?=
 =?us-ascii?Q?XmoqPGAxqA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea2a79b-4dd1-4522-22c8-08de8454676b
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:38:38.1846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLHI7+5s+oP9jR3P+TT2xefoboqGy0hm4WS/8YA3t0lStVS3kvoH9yPYTvfDHs18mO1culAoeYQsnJe+ZugUKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF06C91DA0C
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=nathanc@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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

From: Nathan Chen <nathanc@nvidia.com>

Change accel SMMUv3 OAS property from uint8_t to OasMode. The
'auto' value is not implemented, as this commit is meant to
set the property to the correct type and avoid breaking JSON/QMP
when the auto mode is introduced. A future patch will implement
resolution of 'auto' value to match the host SMMUv3 OAS value.

Fixes: a015ac990fd3 ("hw/arm/smmuv3-accel: Add property to specify OAS bits")
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 2 +-
 hw/arm/smmuv3.c         | 6 +++---
 include/hw/arm/smmuv3.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c90fa9f5bb..08a4e2a1c8 100644
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
index e7fec7a69e..5b85247606 100644
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
@@ -2014,7 +2014,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         return false;
     }
 
-    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
+    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
         error_setg(errp, "OAS can only be set to 44 or 48 bits");
         return false;
     }
@@ -2145,7 +2145,7 @@ static const Property smmuv3_properties[] = {
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


