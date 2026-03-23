Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E12CF483D7
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 18:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4jyJ-000259-Tq; Mon, 23 Mar 2026 14:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxv-0001yC-Fa; Mon, 23 Mar 2026 14:25:35 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4jxt-0004GC-Gn; Mon, 23 Mar 2026 14:25:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbUJdS05iWiLQXtUob0EN5YCU/5qT6z71IEhCoeCvOAAPYR9K3yNISQ0zEbmuNz3Ec80toY9sG3nM34zW4g5OOKjFgcq7eMFmsL6/kqH35cuS4WGmR1DCx1uySxzWsT7slCpiy0wFyjRndPoY4O1ZrJEF85w+8fNeg6d5EOPbVQImKQeZaUEYKhVowHb8sIn2HHci23mRN8ilEtKnxSKJs8JE3qIyE5IR3ycEaXgnAAb837miHNW77WV8HL3DzLzgvQ9Jth3Hhg13jlgwXqvvkOupKBCGrxCktlPCT8Bng1VD9UpYM36n7kmkrr1oOILroyaKSQatJ4lhy4mI83XUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+H+6Z52paFu/N0+YZuWPj+Ko4oZe1Z+S9ri4XOlRAk=;
 b=CUgoMu+lrMEmLGffxZ/fqskm6ySZxs8R8+46Z+sH53hmoOGp7omLJcXrFvHbHG1UOUdBXHSMLS4TgberoI5XzyqN1fd3LSsBiqjTY+mWeBexyzx48/OEWEh82pskQmdYtz2YTtqO6DpPkALxbLAns6XP9u3WHSyNx4xW99LEOIIpt0ZkU6ICHg2jGvH3xLu51hfjUJ6Lj20NGBLc5WJd3fHzluM4PQuWwamCAa8J5UzTADVBSPqNU9vdN+KfmSntl/j+EYakb5+k6+Zqu3bTIzdULrXqAZUKglJBcMh1Ab8TL5dIhl0ZNp5UuN8tNaztLPJNAfV3T7oejZtEG3w6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+H+6Z52paFu/N0+YZuWPj+Ko4oZe1Z+S9ri4XOlRAk=;
 b=OQLCzCzlu276iDPYahDp50ZCbtR37HaPN/MPTM3IqlKFEUbnqct9DiLDa+XwabSfDvXzOX2D2uEkM19h4v0jPDs+c+Y2RueYaAVt2K3mRWbntkFq6cO4awgqkmJ441Ro0hwHIPXGIwmjlf5Hie5IyvMWKUAckJFInPO7RmvrTPnUk14H6ngZXcMGpHyVKH7nBvzWdST4E0/cbPeN95uleCXw/5CvOrfy/Ri5tKDR9fPt0XCvihP91mMGQmlKMxeswsAHUC+8gq7EbxO+sjjsyV/TRFTW1vw4jKxPLpXYU2uixY5lUUITdBBkZwFEqTBwUEi6S1x8/a3W4mjgI56pwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA0PPF12042BF6F.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Mon, 23 Mar
 2026 18:25:15 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 18:25:15 +0000
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
Subject: [PATCH v5 6/8] qdev: Add an OasMode property type
Date: Mon, 23 Mar 2026 11:24:52 -0700
Message-ID: <20260323182454.1416110-7-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323182454.1416110-1-nathanc@nvidia.com>
References: <20260323182454.1416110-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA0PPF12042BF6F:EE_
X-MS-Office365-Filtering-Correlation-Id: f3806120-666d-4137-7b5b-08de89098705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: sZVLFCgB9YCDpLgrmewfBb84W4kTZQadkIAqlOSXpfeQrv6vaV2SRlUexqAGQaZVHLmfy9KRqG9dfhRgTiuuFhkpldfQ1AXmpioJygQiaYQ/3YtJYQbh0lIR9mnm9+iFgXtNGziDoiFnbjtS+g7yM57p4pDdoWSENK7qJ1PAssjFTkvFvTkK93lqCAGnY3c0F+kfLbbDRHcdkyCA047p/VTyoC+/Pp7bf+XNVR8XuddoqfYXFW+qtWEoRe/U3R7BSthEvk1bngR3tFn9ezZSOTY6jA4tmD6j/LgKBkeNEUMbYdt2AuhqeT7OL1EoNHK01rKmoO9axZzMlqojWKyCMqqOHTFpn5JFC4p3wIZmSVBliHCSef+Q+tK0Ord6zj3Fm9DgPMSNPa9naRihbjGYHPEjL+QkV1OUwCkcc+8+iaeIaiVsOcRM29etrd8SSLStOmbU4ekZK0a/wl8BdJt0lhan3VFgMBPe8oc3lezQBj6w+PsyxaeZaVCAgB1dkIv0DUNM/8ac+AqJ5GbtVNC/97t/aycZ9wyciVAtqjZha7avy0Gs9lBURapS6w6W+2lY89or4LjVvZa0QKJTBm9PKEDoIm5wb4C7RUiEk2Tz0dnck0tSNiN+xG53I9tWLpi6MFIqSdJ5oD99g6gagjvWWYrKyInV44FvukrO7IpWwCctM9a84irpskcrLjftev4ubdamkjHQ+api+nGinoxOe5CJ6Forl58lYJE0A6AEjdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/tmhpgQY/G1FPuEvF9SDgT9UvGN3teELBNVlKGjqG73PHb2dJHxCGmu2wbWA?=
 =?us-ascii?Q?Zb6fxMAHkGwokpTGBEhgGgJnEXBwfw0sBBK0ZapXnVCUNwzDuZDxfLyBSpOR?=
 =?us-ascii?Q?LZkbeckwnBrMnzNVsadoUV45A9AdGwRZRCoHLSrtU5ip+bs9Gmj3fj9dxr3o?=
 =?us-ascii?Q?3LEHtswxhrLl617YoEQtUZi32ZbJH3IOUdauo19NNc2ahJS7OXa4fpk+tR90?=
 =?us-ascii?Q?0SmnrQUZWyf9CUnBb8PEdhLXgqxxOg9TKcAN56BWBR2zEVs7mTzcXIcnpjMn?=
 =?us-ascii?Q?BfNcN+YdG+2mP49ejWYJwDbHYmDfQNW2EQiq11PiDj4OF0XY2MM9/ABEwzH8?=
 =?us-ascii?Q?tAHD1HFsi0GUjL8IDwbZBzwroVLYx2AdIyJH2qAS/lGjRtIWsXadcXi8QS0v?=
 =?us-ascii?Q?jdfUMPkoMIe+e7qQOLJ2BjQml/UZeZWXphnTHv8na1c4aEtq6WLQz9cw4fPr?=
 =?us-ascii?Q?KJMYT9gZMQbnrE3O0gfvr1XyyZPBOgVVy33wwyWAzIwYqNSZz4aBFPoSVFDt?=
 =?us-ascii?Q?uRpdlAionB2ckLyXReEdOgDO5yHsRO/oggmjGgbkU9VivXYL4WyeGGdp0QEd?=
 =?us-ascii?Q?WLL0WtUx8TlBcuiQCXUfnQXRaGIXWmc2i5/z+QEe4gfTiBFOv1cxwungO08F?=
 =?us-ascii?Q?uG2aFkxFGarquooN59U0Jm7uWS5v/pmL41UuqRSjjOZCWRrHDxZqsPG0JPfT?=
 =?us-ascii?Q?0ft6mokyuqaNh3IX1IIAlwZ5Ywh19b8n9apKfeGTrJP/C7YuVF9vN+OVy280?=
 =?us-ascii?Q?NvkqtDpv78GM8SSKKsjdQbeObTmwNgRJpZGFEBR6+QMNlEynaJhYW6ujlsKA?=
 =?us-ascii?Q?e6J2mAzvcd8fF72CdXSJcIGDhjyFrqSpiKR4LRaeh64saO2TSR5kLrp8Mjzc?=
 =?us-ascii?Q?++0wCzTG007ofXW3JmVT6iNYbZVsRfSPeQhESBTrpHwrfNCZnv/ZH2zrs+A6?=
 =?us-ascii?Q?lETZtOUTweJflmgKdBl/weGsKNiTVaCZapjqy4RM1icY4cSuKon9LMtqBIlZ?=
 =?us-ascii?Q?WCzuhMf6j412CA8IMJfIbPigmDUuK1Wp4SibREIhGfbYHKxYCC6BYfU7dfVv?=
 =?us-ascii?Q?86uHidgavVq5o6t1IN9CG7VMuqXx1l8BTO5c5XiIsZW+zpZcwmo0onPQB8lI?=
 =?us-ascii?Q?4/3LM+k5LMV3PKzy97qMZpRFRKm4bn+i7bJVMqaL29mvcljCL3MOZ5I2wUm8?=
 =?us-ascii?Q?9F0X66Pj37e/sWaKiDINdXdfDKMFFAZxr3/d5F0QRekhG5ez7XUeD1I7uZW9?=
 =?us-ascii?Q?GowqanaKuuQqhVH7JMQ5T1uONoTvjNzupiShQwtKczMDKB2tuGuqYw3IqXtx?=
 =?us-ascii?Q?qeimdDfWTt+DyKcJk4HVp9xrinjTKeHuVZubiLJQmg+BgkkeO5KfaXmiaw3E?=
 =?us-ascii?Q?7iyslsDSqaElApR7Pf/O9sYV8MujmDQow5DmECQCBSPwlszQWttLq0oQXHoN?=
 =?us-ascii?Q?mxZN7Q1f+XVDLJB1hg7rae/vprkdq6ad5DuDyKPuP/SQPghe6w7CjbOkx9Dm?=
 =?us-ascii?Q?eZxPMU2ML1LY4fSW0t+M8wOE/hUzbRufrpS54w3YDwBddApI8F1ulKSvPQg2?=
 =?us-ascii?Q?Hm5RVFz3nCajLUD/xBFQTEHvraAW1erPODxvz9/bpRtf7faa3U31wfA9uhdA?=
 =?us-ascii?Q?v8pKlvsKL+7EiCUckA9RnZhnvYYBxzyPqzxZ7PH7LbTWAxxzm8e5EX+pCKtf?=
 =?us-ascii?Q?R9p8ZQAPJ9zwWVVCViiuAN/EFxL1NAHg2Sd1oImCgvKoixBb7vTr5g8nMITo?=
 =?us-ascii?Q?wTmYIRXAnw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3806120-666d-4137-7b5b-08de89098705
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 18:25:15.2745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZGfGxu/C9X59ZKWOz7lpxft6M/LjLRvVUA+7C8xBnKrK/cO61aZUF2LwUtWzIfuCa7rq7HKRwQHHRv9jCNOPg==
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

Introduce a new enum type property allowing to set an Output Address
Size. Values are auto, 32, 36, 40, 42, 44, 48, 52, and 56, where a
value of N specifies an N-bit OAS.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
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
index 416b4240e2..4dc66d00e5 100644
--- a/qapi/misc-arm.json
+++ b/qapi/misc-arm.json
@@ -61,3 +61,31 @@
   'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
             '10', '11', '12', '13', '14', '15', '16', '17', '18',
             '19', '20' ] } # order matters, see ssidsize_mode_to_value()
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


