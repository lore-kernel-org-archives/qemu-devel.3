Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EBBF483D7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jyF-00023S-Fc; Mon, 23 Mar 2026 14:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxm-0001pO-Tf; Mon, 23 Mar 2026 14:25:21 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxi-00043g-Jt; Mon, 23 Mar 2026 14:25:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsRHqdkTNI9LVSJLXltpsZZM+bh0MJ//xLDCszFN/VKwT5WHYlmz8IQMMVBIR39BhH73/mAXIvwyF0EX7/DimD+tJO3Up+HP2XOehk+xkVu5c3zLTDyFoowhfaujQ92/DTZU4SvN16BEyMi6v0VXvu6g8nn8t8IOhLSOis/rbLlHIQuQc/hLSGiMMfewwXHLVWqRSTRFqNfn+u0GNHgzcZTU44c9iD9fCWiLCmvLuzUw+kcAMN3yoQnEP1oyYheO2SS/zhf7S/GdI8Da0YDDCLe62GTYJTuEq+EEf/RGqBUL0rq9iPXC3OWnxM/5LN+4/kYtSqvMG6zYMQrFC+t9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDVWvSyB2+dsmTbfmka6Ey+uR0C7I69YNwZxFaXkzVA=;
 b=FpNXRz1/wWI1AtjH3m0lD80vv45EUoxTzfeOhbN+EGNXtXD19ZAniEUtyFtCCQz+7fw0u3cosN0NsPzbouzqGJb4wS3sI87h+vmJq2SkIjVY02ee/c/FxAlehMDaB6qvB/AJiQea9N4U7pq/oatU7HWKpzEvt4pOJAF2TD10e0ng+xzud2OBiOO8DHIfIRqx4MyVw+iBBB/B8Mzfv/Zrhn0XALu6aqIF3DMennMZMgiRavz7EpboBOqQu9A6eAC/T4nlmBqXTaDNUP8NzLKUzJslV5yMEdcakUJ5FypCgN7QahjsTSfG5zin81Cr9MLF3IMTBjXCLbPkHivxAdbcRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDVWvSyB2+dsmTbfmka6Ey+uR0C7I69YNwZxFaXkzVA=;
 b=fwDu9tp74hj5m1xnQcf+/cxlwThxJJOXPrSwCRS0Gg/WLrDg0uj8BEMGQw2C/ZBTk3ycDcMX4gguX4hN1PrxTS1cBAy0ECAGwgYD7RQMAtVSGPXR7h09rUDfA6DBRbtOhKN8kH+9UHiQaYAw7fVzq+SLUDlJ3DSBSYQ3iB17lD5gt3bhD5xslYEu8UAmpNyL4CBwn+iO56/cuOkI/IF1e3nxqtLVT8sc2JuoyCRGPsxbiI1p1hjo67AFgqArnJ2lK20EnBu3klx/cTis1rZsSek/NixJK1MVlq8eXvAWB3O1mA1jWuk4qYUyMOz/dtzTEUmzDfvbCaDtzr0JnlDXqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CY8PR12MB8268.namprd12.prod.outlook.com (2603:10b6:930:6c::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Mon, 23 Mar 2026 18:25:06 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 18:25:06 +0000
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
Subject: [PATCH v5 3/8] hw/arm/smmuv3-accel: Change "ril" property type to
 OnOffAuto
Date: Mon, 23 Mar 2026 11:24:49 -0700
Message-ID: <20260323182454.1416110-4-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323182454.1416110-1-nathanc@nvidia.com>
References: <20260323182454.1416110-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0031.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::44) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CY8PR12MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: c585fcef-8d5f-4835-99f6-08de890981fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: DA9BQWQD4xLYQ8A2woH+MbIL6cZ+d7qPlTV/3jnAs8wcBOiEazQh30ZAYEk1Lk0OLqDpBC+xqi4+SSUZwsTPfjGlz1Z3B8pVZcnSCOooMiiN6rque8lcMlTejt0EheP9crPplzqjBSLI9TgvXzsCro6J6YijuZpK7XrSGFPWI2Z7H+E0h/hUI70rRDIfANBK44mTPmyujJNYp5FCkyzbUxoRtnPDm1asCGtCNxf+h3bBGARZ3a6HvjMDgWy52HaXAm21z/f3YHdB/8g8Ff0NkPwr9vHkoSXsSKsXWBJvqtJC0rIRjLy1KQiHhzG+wn7VAtnwUi+iuA6xOg5rZdPnT+uOkiJOdy3Mv5LRL42tvQhVIrcYE5LOUMK6fxoQ0mxuDGw6JRitighorYHiJlNOjjGZm54D3zVcnDsST9sWGwwvbreDW/7T3sXGpOVMFIp/RpKvwLgcHhhPvbkyAXYj0tIgNq0DHEkqXIyh9CV5oS02+FfLb4l0ajAzhe6DSi6Vg+aOefuO8r9paYGczN9ShwyCAIxhA1KizosVaeocS8nMwyotJ6o7iAypFNv72j+hYmd7gQTb7hEbjgytIG7UNOfW/2GEQW/zMO3zw9+qBEO2aOm3lDRslTrQ7Bbp1d9BqJn8s1bwE6huuSoDXIcVyFb2+3KeqYzf2FONBWA3iELuEIWtCCnoC+uLqNXEM+6UPdIHX04xIIx6pIZqL9yXdt6xe3YQGK1soXWMxRvGfPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a2nPMEXps479uvwiW1Q62XQF07YbREulSrcnD1PuAfwwqv1xp+QlP6e6L0rF?=
 =?us-ascii?Q?8JQ4Zh24xvhf7q+xPoT8zePrOUWPD3yWNQtm6orSKMKIWh+FnMwAVCkDSkdB?=
 =?us-ascii?Q?D9ERVoLcvIOxmChztsm1cY1fxmk6TnzSif76VwmKWMRhpETcBODyUXSXndiP?=
 =?us-ascii?Q?fqQ+4TsGSAI4uPiVSu0evWPqoeyHxdROU/ldGdq8HrFcV/eeZNPnis82QRrn?=
 =?us-ascii?Q?QIaEp6N0VF4izKxXPgAJ48XuIcXVZAiR84IdGyDAAAxmSlDKYBRyvpPJynpJ?=
 =?us-ascii?Q?C2KNb1iaTDWI8GO/0BR0gLIe74A1MfN5YlhGqkHenrqfRAvCsK/gci3CTl6v?=
 =?us-ascii?Q?r+BHP42//fPt04nDGAO99Ro50nlsuoCEmq92uxffW4aAEKYTvuw8Joo/nkpf?=
 =?us-ascii?Q?mR1lchl3yvvp/5cKmJhXIYIy3p1WlVx+wRVe1Yrv9S0C1u9jqP0QPvOljQ9q?=
 =?us-ascii?Q?rMPHezyr43d51aQpZdEjOA+bQoOnX08E3FvKtW4c3KLnuAoOVda37VGsJNRY?=
 =?us-ascii?Q?1tPHai0srNP6n96IIqFMgaCGdRypzTpdTo7hk9mcVDGc/QxsyIGboszkXxnL?=
 =?us-ascii?Q?BnBz6aOAUyyN69SY1hQSmtcSimZVLgdzO1gdD9VofdY4hMQTO9WjwHzwoOdO?=
 =?us-ascii?Q?4mrfWGxb3tK03lV7gFxP3wxz7LurhL5+kt1LJdUcgj57U5mfZjXYMinDzUFD?=
 =?us-ascii?Q?lxvfAmB7GSJcjDK6C7smsxqtZ4Aem8hhEblP7sPLoPebZt9HRcWXBs1hFnUG?=
 =?us-ascii?Q?YY4+R+sdfB8Vnf+QcqfDBz1pNZUfTMCyFI3WxVyT1n3bplPYdavLqHU1+gss?=
 =?us-ascii?Q?nrcTZaBRbv0KYi7cgpe44PF2q/jbDsLmwkLXB5DRqY38REBbN1x50/HNQitU?=
 =?us-ascii?Q?ZlCsawJwl8VuyzLu0yXH+pzfZwG1prQvWsFUQeMPC9ddz0KiUXuuqkEms+9F?=
 =?us-ascii?Q?rn8lmL3BnveUcyrDT7IzVM5ER/A8lMK8I+SsZirEtVGIRrC12PMKGyafxkPF?=
 =?us-ascii?Q?LjKnboWVqOy3bdQsBTDhlFom26gJs7QpVxXVR3acqVgX6xxpJvKpogp/W8bb?=
 =?us-ascii?Q?N5cxhgs2ybxPAghe5VDj0ojV3ElkUGoXfuAl149IHY12RMI8UKakWnXPJpsh?=
 =?us-ascii?Q?488e0XgU+XkdkIkXYS9ObJWD8f3Qh0dGBTGIqT4HAsZHgov+9J78hBif1wUc?=
 =?us-ascii?Q?HyE4xHWxnY6AX7eOXn427MRrBuUVTQpzUr9Dxkfmucj4vBxPTcOhtdpSaTpu?=
 =?us-ascii?Q?/ZWRCRok7dMZt5ytAxcb5g5gealkXPQXcnFRL7aL0TUEYrVRsui6NchC6SpZ?=
 =?us-ascii?Q?QzctJkuX4NqDZ6IEMoL2sTTJtSzE1PqFUyU8TfWYVMMEhrC6BwXhaKUBu/dq?=
 =?us-ascii?Q?61j2fP0/8YPi2TRoVcgYunko3N6B4CmF9NXT0hXPD3gazt1RRWyKn3LmepCo?=
 =?us-ascii?Q?ozPFcYrl3LRGd2Tdqj88uNwVbqQlvViQjYrO+yjOW1jdaYjNTdeT2dcibwSy?=
 =?us-ascii?Q?aBn74javo/y4yC5ncnI6Ir4wIDntfNEB/2J2LlgwbplMekuxm3N6zeu4FvZX?=
 =?us-ascii?Q?IRSoEu3/900yMnzyPmgWXos+nyYCAkR1oUoCPKzt5NKNrig8zAxddxqv4RIP?=
 =?us-ascii?Q?nyaskId+tq3LbfQ0W15+1JEIm4QeU6UZuFA8Vbibqi/FcA1c4Ti9fpBGA2HZ?=
 =?us-ascii?Q?GjH3z4K5Qe4fCx382+lFAK2leTpefNQt2HMpM/CUx02L1h9bJFrSnlJxN+qN?=
 =?us-ascii?Q?cMgmwi+Gxg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c585fcef-8d5f-4835-99f6-08de890981fc
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:25:06.3246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQwenOMPnHmY6uAoBhyYyIcMfwvSvC4hdo6qk3aghIDRt6X3dK/dPx6ztMSmSWOlZaUpeTnOatCkghjTHyAYRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8268
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nathanc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Change accel SMMUv3 RIL property from bool to OnOffAuto. The 'auto'
value is not implemented, as this commit is meant to set the property
to the correct type and avoid breaking JSON/QMP when the auto mode is
introduced. A future patch will implement resolution of the 'auto'
value to match the host SMMUv3 RIL support.

The conversion of the RIL property type to OnOffAuto is an
incompatible change for JSON/QMP when a bool value is expected for
"ril", but the "ril" property is new in 11.0 and this patch is
submitted as a fix to the property type.

Fixes: bd715ff5bda9 ("hw/arm/smmuv3-accel: Add a property to specify RIL support")
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c   |  6 ++++--
 hw/arm/smmuv3.c         | 11 ++++++++---
 include/hw/arm/smmuv3.h |  2 +-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f21a6a9997..c31b64295e 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -823,8 +823,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
         return;
     }
 
-    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
-    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
+    /* Only override RIL if user explicitly set OFF */
+    if (s->ril == ON_OFF_AUTO_OFF) {
+        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
+    }
 
     /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
     if (s->ats == ON_OFF_AUTO_ON) {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index a683402a0c..ea285bdf64 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1975,9 +1975,13 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, "ats auto mode is not supported");
         return false;
     }
+    if (s->ril == ON_OFF_AUTO_AUTO) {
+        error_setg(errp, "ril auto mode is not supported");
+        return false;
+    }
 
     if (!s->accel) {
-        if (!s->ril) {
+        if (s->ril == ON_OFF_AUTO_OFF) {
             error_setg(errp, "ril can only be disabled if accel=on");
             return false;
         }
@@ -2137,7 +2141,7 @@ static const Property smmuv3_properties[] = {
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /* RIL can be turned off for accel cases */
-    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
+    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
     DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
     DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
@@ -2167,7 +2171,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
         "configured in nested mode for vfio-pci dev assignment");
     object_class_property_set_description(klass, "ril",
-        "Disable range invalidation support (for accel=on)");
+        "Disable range invalidation support (for accel=on). ril=auto "
+        "is not supported.");
     object_class_property_set_description(klass, "ats",
         "Enable/disable ATS support (for accel=on). Please ensure host "
         "platform has ATS support before enabling this. ats=auto is not "
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


