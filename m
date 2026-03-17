Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8342DFEDA06
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ZJi-00043W-31; Tue, 17 Mar 2026 14:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJf-00042M-V2; Tue, 17 Mar 2026 14:38:56 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJb-0002se-IL; Tue, 17 Mar 2026 14:38:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U90EznEyX37EJ1Iv5LYRXoiInPy6Bp8D4+ok/NfwnWjKsaE9QVH1RTjee7nA0kgwLRygiAFSSYQz19Sh/KjKSoA+kQhBnDhq97YoD/njnvBm1V8YpQMVAxpu1U6DZWtLWMhaKsFjXbc9VYfvWGASBJkmPUUexDc95QbTvhVikLhmm99TH0WYolvMuaDxNMa8/UrY5J5hd9OuQBEWYFN5rJhrslLGu033E/ZmKW5zbEz6uJjZn97Rwcu+RYLkE0lqwhDphv5pSjBOUbTvQytjXwngaXKHCoBQD0FbzvWAyISDnJXxecNlpREhKf8Aa0654+e1ZIcU1nSA6/abSzeg3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Y2k/dR2W3fjEHG6QwvmZDke2DFzs5Ak8XTckBXVy2c=;
 b=uScBwvDDMb5LsgSFj5q3iKt1ysb6RIH9+lbq58u9CzW4zedh7idZG6pB3+hWR1lC15TrpQUFkSldRj52STwfJS13nEUWv536oDgNXQ1YRKa4GyI1STl8QLfCVB1mB1bLexOvv+CD3O5GYjCASlmQRHgNo1At3DosZoed+IioSpqFGLf97eez3Jl0LooImryn0OBmnE6/gSTNwrFgc6omlkWbGD9SlsFepNLhR6UEYfLwGBDsLwUKQFTHewupda6p5eB2aOdcU8atBNfCO7CgywdcIhPT8N6xqMfN/Cm3toOrQdZcVrGfe9h3eDablRXe96rz2bENi6UkaKNPXEa2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y2k/dR2W3fjEHG6QwvmZDke2DFzs5Ak8XTckBXVy2c=;
 b=gkJHljCIH7KhRtGe0LWS5UsvZP46RSv1Ed/IEUvk9sqQL83mbUMAsjPV4umqDfQ2hs2WM0Edrp3MP/yMLd3lg80LM3fyRFJ4Vj6/pWnUneKBosQajUPhcXben1m2YKRNvV3/m/I63ld4Q7CRTWaegR6PqVWLZSwcUpxtjrvkU3RQcqviOAKUWgY58NcmWYGlIIqQ33P1MKjG/iJsnDuyZFXIE1cNzHb9QaE0R+VHrTuM3d0XAkTwW4uhGemS2Arorx3L2zLAiVQFINZwrJ5V/7koH0cX2YVlvA6UufyidIcolg9BGRWh1IVYAmZKmfyONoLAS1PPQxtCXSeOqFrbcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 18:38:30 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 18:38:30 +0000
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
Subject: [PATCH v3 3/8] hw/arm/smmuv3-accel: Change RIL property to OnOffAuto
Date: Tue, 17 Mar 2026 11:37:50 -0700
Message-ID: <20260317183755.3721625-4-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317183755.3721625-1-nathanc@nvidia.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0160.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::15) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3a571f-a3a4-42de-a46f-08de845462cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: kun/7Tz+xpFrCkdE5ke72YLnzdo9MsKV6BiZeNbFb+IjsSSkrJW6wfGMcAQkI0S71eWExbqkLjhC4PA92meJJxVDjiL7b2HtMA0xQCyuEPvS4vKAaAVgqoRB3msN+YutZtaqlLLxzw8OAU+gETEHAwo63O+8dwV2v19mVKQiiLYcky1Zq7PzFbrCdte7WuBf8OpGYHmV+Ur3tTVvj2Ach7tSqNdpAXHYre7tQa8lCKimGG8s86Yv6e2ry2mpRlxhvlY5DE6f+/mzFbNa4uOsU6ywpfoXj2PEdajgC5Lu35BIb3HT1elSUKU0NZVD8xg18fq0OKa8VQpWLWwW1JYCz7HUqUr4J3hdPomC7lGF4biNeK/Yr8Kq04FGlgmw/YnlY1xlx2Q9gPym/ETnBoOEIgcZoqkudGaMs854bX23SFItB7aBeczQJoQRitVeAcemDd+KUUfdWbrCRf5L0bxU/g4s9INrQjj86Iq8SwIWCxpJjafscedQElSGV31+HM9oW/8HGuUQ+exsSKwQQC+c24GdMsVfx/k1I2yIhIRUsqEUqGf53OeQX0dZ7pNfRkxNl8BMyZdUcPRmgI1BVfFoRpAoHjTEYwkAZiFIjqJKBkbtJNOU+OXUnWLa77GpqkUguIb2e4+Di496Q/+aD2Ebbzjuxu0HOiHQfTvjoSnv6KBSDy6EYC7YqOlIzbxN2/vpH8Vx+oEnM1Wa3pIVs0r9AATzqQw3NS+a2U97lnGVvnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vI+HWkQd/NBUqi8MBaoWXd0kBXe4NXyiJ//n8hnHmPh4Tl6q+oroi+XWVBIw?=
 =?us-ascii?Q?c82JUFWJyBTlm1avIM4N/GLSx2YcXmJmuG1wPSsDUQtTICvyCR5xfOB5y3y+?=
 =?us-ascii?Q?6632Msoy5esi5QLzc2Z0Zcj2fM9NpxBe5ySMwjkCSok2eY8mUHdUbqFVHNPr?=
 =?us-ascii?Q?YMqI3py07mr80gGhGgNKtZFhdVadYjPOSjQmbnqjEjrn+VrAmsfSsVAh/ObG?=
 =?us-ascii?Q?vY7jujC0gAHzGh1OZB35rctbozwfr9+jphSXnp9iQ8cGVdM54487INojYzNk?=
 =?us-ascii?Q?13W6++ydgNJdyhybNqXkBjSQ9vDNUYYO8n22b4gUIuAc5gG1obFr1Tt1XxwM?=
 =?us-ascii?Q?EH5d/ur6tC0C5CcuzR80v4p6QAuRyGkMwDijYj/S7XsVn6ViBaW5EqNEOyhc?=
 =?us-ascii?Q?R4OrirA0SG6k9llPIpTehNKxdr21jmgmVPIq6/yj5wD+OW2RYW6f0GFTKB49?=
 =?us-ascii?Q?Ij2HmG3bCPXJ7SfZGUGgfaNyd9qDXSofQPxsJ0V4+/1I+uW2iUVwdReYB8Kb?=
 =?us-ascii?Q?r9uMOC4dWGN3wg2v94AI39/2pduuMH96s5DguAFu7nx2kRScTBEr6X5uuYCK?=
 =?us-ascii?Q?FXjIzqhUAlMa7w8fDfgirYzvwQuWJe8r3ELP2wp+TtDxZ8IKcVGSfxZZQ3Q6?=
 =?us-ascii?Q?Ip7bG56NWkX753zmRa5WVLP+C3GMqgHDOi3r1MamFO+dTIUn/mDzBcI2femX?=
 =?us-ascii?Q?UtM+bcfdXlip/ugUf3B/jrvZfqs9JDLe/+Vs0FqJjq3bu9m9xFvW7lnSaPaj?=
 =?us-ascii?Q?ca+NGpv9ohhg2rNPajrlwHY7iNJmITKwNx06yA4WdyC/d7Cq++eObRxRv+mA?=
 =?us-ascii?Q?dyzC0dJgB6B/gqI3JCy4e/gp6r2f31Jhr2vcnkEPsk+lx2DZMTkUVSdFneiJ?=
 =?us-ascii?Q?GD+b7WJmDS4bDms9t+Tw3/6LkyK5tvijWOBxidSmI/Z/8TiWq7XyqyJJhbAa?=
 =?us-ascii?Q?ZbhuKM3OUhu1IB3TKEQlIpnzy8kJMnWkgDNAvD2SpU3crkLq/X3emlHlRzEe?=
 =?us-ascii?Q?OaNnko8OfzFi5vsGNMv7LbvkIvSyhbYEfUwTbRNPT1BZzQeIssvHjJKD7UVT?=
 =?us-ascii?Q?BWqUL8eZMH0umHLTyAFY0XIG4hThBP4lTz93IWroOlXq7/r4BnNcWcbrSlfB?=
 =?us-ascii?Q?BLImEXT3YwBUfuTTVNVR/FMi0arFEewBEigElUnMUhFGtlnppnxJot+x9AIB?=
 =?us-ascii?Q?nMwWNqbMIHFwDaBxlL5zMN7JcwwK2VHJkKdnBd1TLvZ87oa5D5D/xXNd1nb8?=
 =?us-ascii?Q?i9QV6Zx1mlw4bnEqDkv0uBXntF613qeqYleFhqVbCm0qiQZXCFJjzopyY8q2?=
 =?us-ascii?Q?f5Yps1LHAPWujW5i4invHxqugTmSvgOFBdDxO8+LyeITNQk201YcE2UF4gNj?=
 =?us-ascii?Q?tlBErQf/YdQKJV9AyE6FQwtnmVHOVfS3hGon9NhweiYY9khl+SaZg5gc2ZDN?=
 =?us-ascii?Q?K2XFKTMG+DpQGWHMF1V5ZZ5EwO11wW7CN0NnFkw+jykz07E2SNnau+4EZjaA?=
 =?us-ascii?Q?obh/Nu/ogYwMv4ut6gMmWlTGIvhvN3/MOlJXdm3c3sXJMDO68anWjgwTTLOP?=
 =?us-ascii?Q?pK2Hl0Ho/JjwSd0eLXbvbUAb4MRozFsXVIiIb4hA+jvEmnPtl3r8xCgGfFz4?=
 =?us-ascii?Q?X2YtXopxWGtstFsZgaI+0J8MgyXdRAb//aw5iFXryIlvBLoYPq4E6C6xuPNx?=
 =?us-ascii?Q?fOv12Ua0X86GB9rCEy2rRPEnugCskMBIhWJs5VB2NUbflGL6Z9D1nqsLoWhN?=
 =?us-ascii?Q?bOyVOS6y2w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3a571f-a3a4-42de-a46f-08de845462cb
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:38:30.3958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4xKVUYFTTYbsma0IMEF0Dy8vrI9fimGR6vUBlhpcnZHb6zWaioAxUbtES/ScU1jXVCAn5Z4zkKX6BTU11MNLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
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

Change accel SMMUv3 RIL property from bool to OnOffAuto. The 'auto'
value is not implemented, as this commit is meant to set the property
to the correct type and avoid breaking JSON/QMP when the auto mode is
introduced. A future patch will implement resolution of the 'auto'
value to match the host SMMUv3 RIL support.

Fixes: bd715ff5bda9 ("hw/arm/smmuv3-accel: Add a property to specify RIL support")
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c   | 6 ++++--
 hw/arm/smmuv3.c         | 9 +++++++--
 include/hw/arm/smmuv3.h | 2 +-
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 621ac531a5..ddd927fa80 100644
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
 
     /* Only override ATS if user explicitly set ON */
     if (s->ats == ON_OFF_AUTO_ON) {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 3dead0bcd3..40d6aca83e 100644
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
@@ -2003,6 +2003,11 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         return false;
     }
 
+    if (s->ril == ON_OFF_AUTO_AUTO) {
+        error_setg(errp, "ril cannot be set to auto");
+        return false;
+    }
+
     if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
         error_setg(errp, "OAS can only be set to 44 or 48 bits");
         return false;
@@ -2137,7 +2142,7 @@ static const Property smmuv3_properties[] = {
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


