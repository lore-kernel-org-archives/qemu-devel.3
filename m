Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB6D1077608
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vxj-0006lp-1I; Wed, 18 Mar 2026 14:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxh-0006k7-6Q; Wed, 18 Mar 2026 14:49:45 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxf-00052b-Jt; Wed, 18 Mar 2026 14:49:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPWd6SNZiaqHgIxVzDR5bgE1D3G1Fg/deql/MjnbKf4ST+xLJoupzWX3Xd0+e4dXu46pgm5bjz9IXKG0Iy1e4EnOSOD5NTfUZVW4p0Y6jts8ahPsnjBWViOWg78Pv5x5LcLX3eOBbcQDbk4TR+Qe/FAV1xxXjiXAI9Bm9rsN4nEcuLQMOpM+nFMdYtOcppAeydSuIg/NnbBQnw3n3aS9yjTZm1BVBT+cdEuYOkgaqIGM2/m+u59AD8gbwUG939qyqwghCOc6F5gUtNrvgDPoHzt8hy/yKl0NqpXslI9ZSX04H2g+6MOfRI3Jg7WCViKSha2r5a5B8z/AzHNlHWavqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nahABwqXQfyZnC/MrvN0iF7YZ+VHMN3mySAEzB7igKM=;
 b=IjJjTS7tdNrA9glK7BeJSQ56MhNKw3SlKJyvgLdcz/UwGsgnPWazlD2XLWfbuwpLmyZJmAfH10p1QUQ9414JmWi1P6DwajFZNUcvuBxkhVMjBK1hceFpRFeMJTjWKWjCml/GK4h02GDmPDo8hE2NIuPegtjxo6+WRWvCc/CZPw0zK7DZ4kVEkRKVmfYiFdTVAzzdOkg2tUxmBYpj7ge8wVr/f9wAb6LXzBngyIfb9eqI7mqDz7+MbcFIsIabrQ0MgMfoM0Cyy819gKHHDzUBn6UBW7W9AXGj9aHyIGhP0Sm49V/Gn90Q29xCupuJtyhxVorNopcoxLIr8jVRfg4JvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nahABwqXQfyZnC/MrvN0iF7YZ+VHMN3mySAEzB7igKM=;
 b=JChm2L7fkzU754tJ34KdZmhGagXJOYxjc0M39PUdOihAEZrW6d3yvNi65HwRIpVEwuRE1nPInlAkFlYK3cl6TXBFYs57zPg3U5gFQHARLiy5Yr1a1LyfZR5HdZypxkLxH0zsZd9R9K7So8tcLNeNhuzNsS3BsLP4Hntyx5SdP4iDGckWt0ZR9NE6tAozeQ1PXfoBH+17kbrhoFCfv3puRHG3sM67ggs1UP6T4UuyXDVXYIAlqAC9C7HaYjwl4yDS+PjFo/yTCnLb0XiVmDsmCJQPGExDFNuvZ8SWL0ZBOQW/KZuN4XfSETGIm3C2fANC1CeKjEPn3uiFVVjds9HPsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by MW4PR12MB5601.namprd12.prod.outlook.com (2603:10b6:303:168::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 18:49:35 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 18:49:35 +0000
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
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v4 3/8] hw/arm/smmuv3-accel: Change RIL property to OnOffAuto
Date: Wed, 18 Mar 2026 11:49:02 -0700
Message-ID: <20260318184907.4060030-4-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318184907.4060030-1-nathanc@nvidia.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:180::38) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|MW4PR12MB5601:EE_
X-MS-Office365-Filtering-Correlation-Id: efed61e7-188b-4615-243a-08de851f1962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: UxPCRawCI7vW8n+Dw66tVBRGWd3bfZ6Hkwk86TmBcbv15fWp7qnBk0Mrp48v6Teqdj6nyP92A/eWbxH9TXm27ue8wqHYz5y3dzidhuRdNVbL9Wchjw1pN3L2USzsIczu+PvPEP4Cdhwv6TWWNVAIwKgVJsaNAPsIs6gHW4mS3z1Qx1f1PM+RJetNP8IFjQ6HPh+qVOGIwJRi02MxglXtkk30Uo1Uo/WIz94Ko/CHtN/Cf0sN0bgxzCIfNM/EZDBIbXzlcvW9+2GE2lDM1CwbG4RwH90bIzD+LHxue9+jei/DSIHB+w80f8fRCm2f7EKexvQwjpKCGrEv9y23ZkJVT17ZBjCXGs51UtxnU0sC2CpoTqeSWSce/aM5RLgQrLskX6VqvuJhlS65tF86C+ltX0B4wqrAB2fgFrwG8K04pZUHsn+3p4ct3YgRfGPfVVCSnVrp3ZjXGMJpoodiiR0M88ad+TuIjArMCz6l5MrxEM8QWKz8uivmDH0qwIkDpGLwe7kYV1GBoJuC+/LZmB2airDLPIV9NPXHl92rdDgpILp1nSUJdI8OGrd4ups8/2qq33sfYyNh6WAqPwpXmXC6+UVOAgGZPQL4n+fNO6OVPbRVSiUAOq2rrp0usztxhZv6JprKE9UmcXaQnmbzGNV3YmkBzdtKOvDFNGcVduibtddhRbmolPU/ZqoROahMJuoSN4hQE8iXP7FNKRsl7MsbjGEL3DtArCO375GcY/fEzSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zNmaNxTEBvyyjVoHXnm+nwsfgpP6UJ8gZMnOaEitIVXF/t3YSmP6FpoJ+i+I?=
 =?us-ascii?Q?wteSqxM8a47mgIMrfi8LhUisVdBUEI2qIZ9HFeLTvK5zv86tgcfJTXLWrvuG?=
 =?us-ascii?Q?tUVBLITWrA5cIhoGP85eVtV1Ja+sy1ZT8MAcT8HqzhEVTW1MnquHA+4lc86C?=
 =?us-ascii?Q?q5NWvPFDcivzebf+YrjRqe67Sl4cLKYxm18rEIhv1UodvqipyeyrA1rAeZNd?=
 =?us-ascii?Q?WJ50EJ4Ja1Lu6ZkgoWc++vWvzkTZPz02JGNfM++y7YzR2jbv3yo8LxdnY9Ms?=
 =?us-ascii?Q?3mZvq8d1U9rg0N7+BSyQWqSWDozNj5XdCkgvmTcJkYJBUb0O1uUv7Xc5agfk?=
 =?us-ascii?Q?TwBk5ghz8/rCDybp4HnAVKcEthdNEhLW0RymIeOpkZdHdpO1fbKqXM2m+rDU?=
 =?us-ascii?Q?1R+XiXONz7/n7zWWAs5YQilS8dqxXIBC5VwX8uOGBvw2oMl9u/UESAmrbOu7?=
 =?us-ascii?Q?xZqM4XZZFhu5333p3Bof9vHVyJRVvjCTDzhONerz57AgQDMyE9Fy62O+5HZZ?=
 =?us-ascii?Q?4QpGZ2b5dcQCk4K1MZ3BOnD3KDdA0BVKVTzHAjz/Sj4dk+bXdx7oKVrNyNUe?=
 =?us-ascii?Q?GcvMzEabayAGaNOWRa7qz9BMRSbqBC7OlBHKvu+2rXk0Zyy1lQ8+JiOIuV7e?=
 =?us-ascii?Q?//pBP0aNxSAtxv/TQQIue/KSgRxCi+d3tx99X8O3H4ZGikjRj/xjL8goDmzq?=
 =?us-ascii?Q?qxGQGNIihQYR8GHkvihGz33Gotd9mDpd3aW/sAtfNeZj/YEVYJGtvxZWUVw3?=
 =?us-ascii?Q?/AG9N3urc5oulan8WVMedSq8mKD2sEmlhLAsSFdXnm1lL2F9n3gH4CbfjN55?=
 =?us-ascii?Q?2x64OWqXxzdeLR59RYo/Mo6DTlKd9YFpZWkYNJcajqjy/K7TXzLCge+HCWE0?=
 =?us-ascii?Q?v+khSLrgCRnSSBsLEhPd3eCOJx8CZ0hRMh0klA5Ig4J/MoVv0YGrHiQd94tG?=
 =?us-ascii?Q?1sMSa2mimsT6fPNmFsAEk+EgkeTDmJq0AVbtKibbcxv1bKQU/6vaL84+WU6b?=
 =?us-ascii?Q?pt+CKJaduvqR0CErZEtcjD4uCLMA/3oHl4SWOJLAOBKpCwprL4XXiq/ZpJUH?=
 =?us-ascii?Q?uvyBnL8O/bmb53p+3204uvKtqHTBMLuEQvn9NVb9n7bilDUK0AEmMGwG0cpP?=
 =?us-ascii?Q?i8mvrLm+chJecadh13dJDXjqOefBlYIMOSFbDmZB2nw0oEnHGf1uw2wXYaxE?=
 =?us-ascii?Q?85HvzzBvUiP3X0o+4k0tJFQiI4/GKW5W+t3h8knnmtNFPcSBU+IaD9yp5CWt?=
 =?us-ascii?Q?UeQQ82Q0MgabuSz17BAJN+wRnLho6Yl90JNR0tsGJrrSoEqczRbzPkkI/j3n?=
 =?us-ascii?Q?V6U9jU319xNUDy6DRnZKNiUHo+YnHdRvfeAcnwfGp2IkvZ/z3FHyfBsdSQ96?=
 =?us-ascii?Q?QIKj6wHPS++EJ06FGy/jFlz7auTYUt38c+KqzEBxOf3M7cfWZjkfNntiYqWm?=
 =?us-ascii?Q?U0RaPhGXs/YZhr4zXJiNLkEpRWSS3rWy95oZkdlz1gLtFx9nMlc53WM4jyd+?=
 =?us-ascii?Q?JvujtHz3pnWn8OKzP1g95u1xOEOnkhCtugwq/QsqgiBte8Hk3AtpEirwvhka?=
 =?us-ascii?Q?1PkK/l/rArGcNPWhJMw4uUodPZjmZqb5CtzwSSRWfBwGHR9+xQLvoPzfXSa4?=
 =?us-ascii?Q?quWUxpxpv14WHf9adCCXoOEvK/d4V47zqjykyZkvJoKl6Je0rU9ZPvmzM0Oj?=
 =?us-ascii?Q?LXVLeqw63cRuoA4ZNZg08woYtQmNBm5zQ0agtXmBdL9lAXfCIL+aNaFvSRqQ?=
 =?us-ascii?Q?n+sXfzEXmg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efed61e7-188b-4615-243a-08de851f1962
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:49:35.0736 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7jOmrE/lLsIrUY/S/5i7pw9fUGT3GQziDhuLYxuIHx6bmhZ5OT5TDQ7SQYNwatliA/bZbko1blaRzPKDyQgww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5601
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
Tested-by: Eric Auger <eric.auger@redhat.com>
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


