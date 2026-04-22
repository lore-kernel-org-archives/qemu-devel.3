Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA05FA1FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:45:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFeQl-0000So-IQ; Wed, 22 Apr 2026 16:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQh-0000Qp-Ko; Wed, 22 Apr 2026 16:44:15 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wFeQb-0006uV-Te; Wed, 22 Apr 2026 16:44:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaIQP6+pTjlu7wzPiqGJQyCG138+rFQgNYy0AQJI0St1F465Q3jnbHADP1u4JgPlC7lsZHZkYaLpAw8Lvy0RCvcyDWmh8T9eqalte5Rq6WqmqbStzFfXTc/RQrb43frw+QfqClQxMfynSBHRjZsJ+3zf23xd6dyossIPpbgvydWxG5cJ1wcY8y+wPI1VNo1zcnJOP16VVtzPl6cJD9omQwqkktR1jStVaNs6yELKV6buQNgazAg4sa84OGhN/MYzGKhgKenZvK4D5oXAmg926qAcirltFJj0a6RTmt3iUu+4BoKIPZfrT4lISG/mgajSewSngUQchknooJicr1vOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNQMk8199xNjxz/6z3c9BTg4hsIU2uR430Nbf/7d8rY=;
 b=bUL6ecziqMN/TbLhCZcMbUEiwjdVWa18o2VrQL8l7StRXBuDwS6gL6CtMM5JrQSl+Ao4m+eFMymzfA0YgFX95MDIJpqXu6hDiH90pG012H+lOUmTzHeDaBG3/K/rhhvip3J/K7FjFNt02Q9L4H09/4vGUCr+HJtP0f4fqssM9Cs6EekByyebirI/2cZO/eVtypbAbcTE55AVbfZMfjzolO+iDe275LR98ryIb7nVX6tNbT0p0EeY7Wu1G72JxdYUSApNprcvmiHYelqNXKD+5yXDOz/cwALftCM5jLIT2wj4jx6Ra5Q5gYPuIktbkpDty4yusPH4ITack9BhiouB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNQMk8199xNjxz/6z3c9BTg4hsIU2uR430Nbf/7d8rY=;
 b=JUrNNDsxTWeDb25LuVfwqg5WzRrod4KWGeI5NEJpV6EjKlv8LAwRT88wLxGkQEvNc1yVBwVsKtR/Dv2SOJp5B9T7oB7ROiDMHgVSwmlTca3ouFalzpgaVlkLMxtVODdpT+YX2NmmSlX11bboW6PHAINT6CeSP9YwtPPxl5diVk2N7LSAytSLwSq1MQBOwfChNWSIQgErtQKsOvJrwHNXoKCSK2AE2E3HWO9AQigcFTuD2nu+traEjIa3ePnKpNTTNjSml17cyuWln8NybzwD6a87qLUjNiBL+T/NJ2ldWwIjw/4FJHJ1d/1XXbZp+BC1elaSwCr3/UIYHCiY40mVcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.8; Wed, 22 Apr
 2026 20:43:48 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 20:43:48 +0000
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
Subject: [PATCH v2 2/7] hw/arm/smmuv3-accel: Implement "auto" value for "ats"
Date: Wed, 22 Apr 2026 13:43:30 -0700
Message-ID: <20260422204335.23116-3-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422204335.23116-1-nathanc@nvidia.com>
References: <20260422204335.23116-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::33) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c010ff-9c28-4de2-5887-08dea0afdad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: HBgFhrJbOj0ggQuyx6ikLMOPBoEZb3qesUPg5V8F1VGUmlFbYQ2vRBER8eRlijOmorKDWC9OrD3pBJ4v1zEoHFVSHXduMwDsqW0e2oMtWyDi4G8k1Bjuo2CNnWk+5MUjueTdTkkPYxryoOgmlkps5upLmzT3zNHvPVBHQhamE7mO8ooY2vRv5N6YD+FTgPYGn/TZ5gY1QdwOTp5nzMDavAdY/IMIQaC0FlRETaZ4XNJvcHC9XCK1izS47Q9k6XjLjrmaISxEJee+iXwCPAL6Nrxef3TTfBNrqI/3CUXDj/p+yLVWYhMg9C/y6Om4C5mxnpOe900D1W1lBtGegPkPzY6Q0UyozX7AQ70EsMDrQa8f3i7F73XAdktuMXS7+a8IOsZ+SvP3Ib3GRWn4+rytF8nxGfwWFC+RRA9hgZ+zUMPkxJTUodtBEcu3Wpb5VChEJJ0W+Ic0kGAsY8IEtCjTMQFin4K0jbjij2zf+WV/9lQX/Dwzu9YK/2GoMSWL9ACFjfHDbZ/7OL244gRzEhyxkb1h++lDNGdI29DHBtz91t1LKw25KAV+l4/VZA6klvQs3aIysGt1FmTFgz0JISgGBT3BZYmLCZivM1NbFwG8ixLAtYYB1zjyYBCbK8ARo+wy2MdPHeJ54EZ+MwBhnpXA18fBk7YmOTbt5xR/iQTB7bESYHET6yLCB/QdAQYr30dsfqUOHDR9X/Agll4m3P5ReFe0Hpsaw9p4EJ+d9nKJMVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SzuE4L5b83qAcUXmeNvbOhQxQurSehPWWEYDJ/NWLseuDhCGgRdxQD17n+Bi?=
 =?us-ascii?Q?ezd57w5IsYpPvIk9gvezVHvVR/YAYBlFMe54U7OnywxZJOwBg1CNyhRk1Ky0?=
 =?us-ascii?Q?ghmS0/5voPwAgBs/HokkKmkVOMYdPmGmJfZpOXpGdlp9tN2A66kuYqdNDuvF?=
 =?us-ascii?Q?FH8IfyctlSwJDA/mW8SNKnt1iwZe7zGuF6R4y5crKbMdSq5oC479X2eSVkVr?=
 =?us-ascii?Q?Jq/j27Cq1ADV2Jo8FuVKSEy3svMSyqAQRO117HfPBo6R7nfXHwNboHY5H9S+?=
 =?us-ascii?Q?/rigtqBUDncvjgWMb0lpfTKrz7LRahVAfpkdofrmdaBvOVpVBeXPtAg8ta9w?=
 =?us-ascii?Q?c2s2nMHSC6W7+gfEs8rvnCEXnQT8+tx0+hx1QDH15oJ/CqjFIa1ydbXjCejL?=
 =?us-ascii?Q?6SD019K2G/wYcsXS0nxdk42O2GxUc4SAgSCHlEiYBhWVMyg6T00iUN5WXwTW?=
 =?us-ascii?Q?N3Kvm6YsHEB9FuIb7AIWxjNjq9W0uO5o5UlXQnfz8oAIqVIlX9lR94uDd5ID?=
 =?us-ascii?Q?4QZAZpHIrGan7fu9AymhhPcxGMZaX+LUns6C58LjtwvXOA6BHULCITkUHK+g?=
 =?us-ascii?Q?IhUnrXE9zT5iO0MsYjLSHDmCo4cO3bC8IMtB15UQfGjjojwq79p2sMRGD1ez?=
 =?us-ascii?Q?YBf9a+tCaxcSARhXZ9Ymw/hvmBsYOW3dS5NsYQMr+fjAcH5uI7T5R5rG/nc1?=
 =?us-ascii?Q?5pmkOsRFYTqQbBHSatnRQCsAqeznpPCkjf4y3cbJUH35hrB1eprAkTNw5kUT?=
 =?us-ascii?Q?nWoQd7aVF+Ee9BQ2J3vB0fEWNe0mylt+GoqUY+VP5xH9utK2FOsbRL6157Io?=
 =?us-ascii?Q?8HxFeB1Fb4aKf68vZxO6/Sav58gr3swWdLWYPNxi4vVkE3bpjW9hple5PQ+X?=
 =?us-ascii?Q?+Fh7ByvD21IQp8QzqlEw0bztxQk2DDroGdSojCfdpGOHTU13leNAwWCNt1nx?=
 =?us-ascii?Q?uUsKaqB36xo3t1ECJIBL7IfG301Z4bpvVKRhO6IO/0v6XSQdEPM2sg8M66Ie?=
 =?us-ascii?Q?5mTTC3YpRzUmLjF9VECZPVWKOxwsCvb5INgVufpUW9YE5uZy11nMZLPZRx8/?=
 =?us-ascii?Q?EJp0QVGAekN7lEPd1alV4Iib9yvujGoEPlAQkXK9mMoHeq2mu4y2ObxtR/AT?=
 =?us-ascii?Q?JNv/ibJgFDnm7MZ5WKQIfjKzP8JpITzV+pX38Gn5O+XIUA2SutCBkqhEbaEi?=
 =?us-ascii?Q?k9kM9z+as6JJYd7+B8Gzy9euROTgVBLugDplULP7rlS1lJ5NVMTLxZdJ7fx2?=
 =?us-ascii?Q?uRaLXLfYvC9sL0wBcF31yJV+LZn9pcNhujHtRFY31PKBuCqRA/JxT0uZaBCi?=
 =?us-ascii?Q?wU8Mcvvc+nqzXJc3I4K8me3OWlMGY4uRCEQsq7kaNw9NanIXPRC7gC/NclCo?=
 =?us-ascii?Q?O1+tUZmzMqqrUps2SnTUnmNfqf7xlBALJSFLBfjF31i9PjXQI+jxEbh7qx2C?=
 =?us-ascii?Q?K+SgOYu9GNI0AUUgbIgvYkO5snI4/0rcSg1sv44LcGrh7kcuHezdEf8OtuEx?=
 =?us-ascii?Q?zwelxW7NzdhZvb/elxOLOhqFPPWFL5Kl5trHtVE9Qh80J4hZldk+xDrvsynv?=
 =?us-ascii?Q?Rchz1aao0HlQpM/510Y9MkZ3OSBbCk/tw+8XSNZLTuZRyq65yoMzo+ij+pMc?=
 =?us-ascii?Q?yKJG0Ivf2rITxGDmqD+GM8kTTNQHVfCpg9mOru5t2fJRNCYbM1w0NE03gtIn?=
 =?us-ascii?Q?zmBb4e5yLhFb3CEoCv5kdtJr76aaEs0jTpOLIkXt4EJa5CYw4VafzLWFyWZ5?=
 =?us-ascii?Q?jO/HUzrOKw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c010ff-9c28-4de2-5887-08dea0afdad4
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 20:43:48.5251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FJo4jEVK8WpGuLGS8hTknva0xuGP2qqhhhEbiKexaNNigNbhJahdzGCdZ9Ke9oASd7l/0BexJoUhOTJGn1Zs4A==
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

Allow accelerated SMMUv3 Address Translation Services support property
to be derived from host IOMMU capabilities. Derive host values using
IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3-accel.c |  9 +++++++++
 hw/arm/smmuv3.c       | 10 +++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 8b3bbf3ef6..b42d189d29 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -52,6 +52,11 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
         return;
     }
 
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS,
+                               FIELD_EX32(info->idr[0], IDR0, ATS));
+    }
+
     accel->auto_finalised = true;
 }
 
@@ -963,6 +968,10 @@ void smmuv3_accel_init(SMMUv3State *s)
     bs->iommu_ops = &smmuv3_accel_ops;
     smmuv3_accel_as_init(s);
 
+    if (s->ats == ON_OFF_AUTO_AUTO) {
+        s->s_accel->auto_mode = true;
+    }
+
     if (s->s_accel->auto_mode) {
         s->machine_done.notify = smmuv3_machine_done;
         qemu_add_machine_init_done_notifier(&s->machine_done);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 7fead1c3cf..5671649fee 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1972,10 +1972,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
     }
 #endif
 
-    if (s->ats == ON_OFF_AUTO_AUTO) {
-        error_setg(errp, "ats auto mode is not supported");
-        return false;
-    }
     if (s->ril == ON_OFF_AUTO_AUTO) {
         error_setg(errp, "ril auto mode is not supported");
         return false;
@@ -2175,9 +2171,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
         "Disable range invalidation support (for accel=on). ril=auto "
         "is not supported.");
     object_class_property_set_description(klass, "ats",
-        "Enable/disable ATS support (for accel=on). Please ensure host "
-        "platform has ATS support before enabling this. ats=auto is not "
-        "supported.");
+        "Enable/disable ATS support (for accel=on). "
+        "Valid values are on, off, and auto. Defaults to off. "
+        "Please ensure host platform supports ATS before enabling.");
     object_class_property_set_description(klass, "oas",
         "Specify Output Address Size (for accel=on). Supported values "
         "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
-- 
2.43.0


