Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFE6FCA17B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 19:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzgCN-0005qA-Mg; Mon, 09 Mar 2026 15:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBs-00057U-Pa; Mon, 09 Mar 2026 15:22:58 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1vzgBq-0003e9-Bc; Mon, 09 Mar 2026 15:22:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKXtUZI253SPKRP07+F9YXo86zgxq4xlanjanKsvbPi30oOpnZY83RvNb6B+Ra2OKpP8f88V4QgXTzNrt7jF1p163xSJU4DzPdrBDBRcZlwhUeizqaOHM38otAKe954ZPghjnBThtMK05NMi8FIGIIUWppPUkRKGRb309lbivAUqM3nvyJ2H+hDLgmfqQ69O/1gsNyTO9Ica1OPdIJGsWP4phuvJ1cnN5NUU0JeSVtrnS6xo4uaFbKHlqV79GrG5TLQab7cRDMD7RkH9agbH+TNv7WuqOpTsGswZwKt9AVoJ/AOIbbNsOHQfA8T/eSTr5pULYdqvL+nlfVp1knR41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqpVNhhniqfIdNjdwtEUmHviLPrTXwTBrOGVY0cVyqw=;
 b=ZA8uuhFu5T8E7Lar15ayrcN0gujTG1cKHziJfkewaMGLXyYOur629nXEPQk0edExZt+MWvSL5V+rmRpM3OQT6BglfIzzyElxD5B2pyQS9hdey01nqwA6RzZoynH0X0bvlNL0/Ke6+IqWwyYnkqTdlniQiB9+xw77bx5fQ4Tj6Z4Io/tOyKzS+svys2ToUCacnqNPJ09urYGuLu49+sHVbM4YN6IpJBmYVF2ZENH4lp1h4GjV4+iY3def86XWXnj8updRGhwpirQiZPdtYv5Qj72Cl1NmPZbyD6EVx2ficjgqVBYjGWtWS97T50u2lUXKV4FQaBeGmNOhdpRdHkxbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqpVNhhniqfIdNjdwtEUmHviLPrTXwTBrOGVY0cVyqw=;
 b=RcvoWK1m3kg7ve0PTTYXxmx51IQKTS9HG6V/iFo+G0Rdud7PsvSmW37sYhj6ctw/k0MnflGBFu6VdtK7qMRiVV9/JPtGrGQK/UVYjxf7BuALh3o3giEamaIgFAQgDwKDUzBl5+4hSMa67HkeOQVHBAw2dKkl2MJJewwphz4/sofnacD06aBsXnc3r6nItevApgHSdNaS6f/kkfvCiPdP4IoIZTApfXkJLG9A0tyNuqrDSJMbJjNGEGhLFiQTq1mD0wuS1trB/IV4vX+zDTkuJouj84m2+mv+Q6tIkTir07fsWwIN/Eu9Pu2RfztWdDi3dhuoG8R+4P0bb4Ab3zIb8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.8; Mon, 9 Mar
 2026 19:22:32 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 19:22:31 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [RFC PATCH 7/8] qdev: Add an OasMode property
Date: Mon,  9 Mar 2026 12:21:18 -0700
Message-ID: <20260309192119.870186-8-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309192119.870186-1-nathanc@nvidia.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0082.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::23) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: a3881c7f-419f-4b93-0d9d-08de7e1135c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: 1LDZijIKRyNNUT1L1Kkac37v/bvhseYPUhqEJ+I2/0KK0n8+kolX08nRSpBeiLkULBrlwvdI+2vz5WdA8kuw9WAPkAGsnGBmv+vDCA/MaRGHJe6e3auWevoX0PmI4oRTjEzdNG731stli+tGgjsdJutrnzdNiwWl8Q9LJ7dDTzjAazpNdApCnsqXmAFoJJGaaSSAjUmJbcYRoJSmXaiDHAATtDmfJQG0t7CkNCCXSLcWX9YzGdzn9DjMrgJqaHVqr89wy+lsOdbonJaetOAoLPutG2tHj2So2xIrLJktiePaVcECUF0UlaawrAav06t2k4qGB+Qme2e22WgQV9wnt3+q9SAu8+luMVNa4uU4no1BsAbo5ufvgxR5ar4GZpCVN+QoywOQDZJ30tQrIYolQwyxYgiqb3sG+G9ZGA3Sa5FdWrW0GvNvJTip4QoBGVOL9948PnelG/7XHrlyak7lqZ9yB8IhkJ5xGj+a/DlCERVnpAxsufwBHjc69raBH/Wc00ibRSUYKZBbFbAqZKGm7xU9hIAEbTWGUCmGpoQJ/sGdOF8gStZJIWgYeOgeUHZCxIYGA1kMM0iMpAo0MrOLyV5x26zhAgDoJK3N+gUCvcJVSgLPM3g6yiXldF1PYzpiKR7/NGuE1V6I/qsZErd5g6XV9qXzc/vdEcwegY6kqPiLKlONI7LLSeiggiXHeGd1rZ/Jswhv83CsX/FbIqu0HIw+AooK1dRJHzVd6ptf1RE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?49HzntY11f/0yELoDIqVx9MtQbvtBMpiqVzeyULyPM97427m927+yTJhntVB?=
 =?us-ascii?Q?frow0+jmyS/d6gLTQZH7k0P0V759y+Vu0E8XGcVdjzlZdFYjTxQ5RJeqrWBF?=
 =?us-ascii?Q?Ce+BFTta4wpQcFs7lp2VZpHGsSYQzSvNROlJBu3kyoD+Ujrqdiu6nnAw4aaX?=
 =?us-ascii?Q?9Sq+d3/J1GzghC0HkA2el92jCugUpaag+5ql9AWHfUWHs1ZjFaN28O0EUCn/?=
 =?us-ascii?Q?SF57ilyl91AytVBJxQAXy1JseZdjYru6Gi7K0DCWU9ZdYp9Ug0EMTAA0+GGk?=
 =?us-ascii?Q?WoOlp+6+xwb5TbsdYD5fHYgDD16aCmf/BPSDxeIBvUlmay2JXMldnvlthVIZ?=
 =?us-ascii?Q?m/KHEl60lTIGfA2qrMN4YssL7StpYg0q8QW6P3AgThGUB+oaUtuBW67ABeIS?=
 =?us-ascii?Q?vLGrBDhliQ9+dM/LmLVUws9rNX/g++dRF54dY1NVtjpF7bTsZyp2GwuKW4pQ?=
 =?us-ascii?Q?u+vl+eQds9H4EzdgLamIeJp+XRMfDLgiJ/GXpTEMhhDg6+6b+p7ObBFgDPW/?=
 =?us-ascii?Q?BnMlQ4LnedP+jNGoQSzhXZhWGakZteW9OFXhptoZbHuaQPv8TTcYQa06FKrj?=
 =?us-ascii?Q?EOcQD95+LTlfF61VOEsAWJi+bK9/eUnDYbfv2Ns3tLBa0E9WOwaq6kEwfHhu?=
 =?us-ascii?Q?tN5JExkK95Q2tN18hgCjeA0szYEnNUgFZmtUUeSfsi9kBWuh3qKo2pgRZdYq?=
 =?us-ascii?Q?GVvTitEreeinCldwXYa4b6ISOAGlfTzUSs70Tn6IykDbuvMfGETd7678PZ0A?=
 =?us-ascii?Q?c4A8bx0ht/635D746HxsiK9q5M4rAqPU5mfkNTikg2Lk0sEYDyjXsYpL9xL6?=
 =?us-ascii?Q?ViChV/IKULKA8nlAh2YYbgOVDge8aB53P1Jy2BkrJL4CwHLD7aYxV60c2g69?=
 =?us-ascii?Q?E79vPpbijqZ4zSAK3pN6jczhcW0xyzMAqrOr/D7uqw6B4P25koPudHEPhAna?=
 =?us-ascii?Q?hXTRJ9dqwLCcXLGOI+mB38yvo255q5UDOOogeEhzPmJP0o1iOt9L6uydhDb1?=
 =?us-ascii?Q?xMKWL8/V3KDBQ/PN06OHMuYhw+JFoahiQbOhUJDlTKjHkz8OwFVbqJLi9e48?=
 =?us-ascii?Q?4ditF1dlOFZtmCMH7YXQka9WVpHklMqSwC5YjqU9Ghko3lXeqVRLf6FDWgq/?=
 =?us-ascii?Q?Kq5YcLjhZ9cx9Sx2atkElrvlIBOCkiXXWRZdO+iFd2resg1GUmT5PYopKyId?=
 =?us-ascii?Q?thHvNGwhqBU04VcxgsW0MgZfwjgslfj/rDCCTZq1a5HrvM9ctCsCp2NOJaSe?=
 =?us-ascii?Q?M5Mrjq+NuSgyhtO4GSWtQXd0DXi3sW7hN7Xad7tERWmEO2EF2+98ICpWSicE?=
 =?us-ascii?Q?/QPIhKXJ8B0c3hu9hLJTZQ5bNkogCx5QiJUEtcbKa11dJLAh/gff9aAdBUXd?=
 =?us-ascii?Q?w+kPzt2drIAhKTPV0Vgk8VVXMndSn3Wd5Bs2eclSHMMech5piQOPIJctnoQi?=
 =?us-ascii?Q?KqEDlW3RvnME4QiGoXYKGouW79fpkhNn0tnr8RdEAUczWb1W+qiMBTsFhf0q?=
 =?us-ascii?Q?12jceQHwL17U2arQOj74glL/XVYc3hVMc4IR/DhBfFUSZqAkIHugsZiR7Eh9?=
 =?us-ascii?Q?KY5XjGhXgJE19fcBnckjekRwiELYrPv/UbHJ2T2UGjWPxRXP/1GqxdjR2U31?=
 =?us-ascii?Q?G340VYW3Dxc4iGDkCTf2GM4OYWGVEiMaYvo/a9fov/wU0oMtUYiM29RD/cCB?=
 =?us-ascii?Q?+wQefTkTzjjlvaMHvtgAL8BwkgJzBfCTgMhQxOxfMEL5sz8RHbn+MZ6GqlOo?=
 =?us-ascii?Q?pfC8J+MthQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3881c7f-419f-4b93-0d9d-08de7e1135c7
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:22:31.6386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lq1GMyw60wCWC9YAA7RAIX4v+UiQajAZZO0aa+wykr6ebFwlcPjKvJ39TUWwNmQEgb++GbJuOte2oNpITRlzAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=nathanc@nvidia.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
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
Size. Values are auto, 44, and 48, where a value of N specifies an
N-bit OAS.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/core/qdev-properties-system.c         | 13 +++++++++++++
 include/hw/core/qdev-properties-system.h |  3 +++
 qapi/misc-arm.json                       | 16 ++++++++++++++++
 3 files changed, 32 insertions(+)

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
index b372a3661b..76b6965502 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -60,3 +60,19 @@
 { 'enum': 'SsidSizeMode',
   'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
             '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20' ] }
+
+##
+# @OasMode:
+#
+# SMMUv3 Output Address Size configuration mode.
+#
+# @auto: derive from host IOMMU capabilities
+#
+# @44: 44-bit output address size
+#
+# @48: 48-bit output address size
+#
+# Since: 11.0
+##
+{ 'enum': 'OasMode',
+  'data': [ 'auto', '44', '48' ] }
-- 
2.43.0


