Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7FFFEDA06
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ZJo-00047r-5l; Tue, 17 Mar 2026 14:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJm-00046I-B3; Tue, 17 Mar 2026 14:39:02 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJk-0002wk-O5; Tue, 17 Mar 2026 14:39:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/B6bGkDboC/hg6owHJslSVluNcDz+7b/3LA6diffGsxLe1yt7yuS6UHUX8RZDl9CEKmAKhWDFsY21nECDq7rquH7Q05HVj1MLFy7DgVqLPS9KO8+k/sqFXIcFl2KzNWZkQwx0d70FISKbfxMpaAoQVDHvvf9MC+nxcRpbvGefLEu/oBVQxDGldrJRmHJurKGZxWuxFDk1SG6TEsqAuIoS6kfXG4nwORCF3P+6B9DGPS5dnTPTSVySA9Uqd1g9i+rC/ZiNB/nxiAyTyqCWuPW+sP8ncrJZQmUZpjQkZ/XtPlzHpAE12AChxDO52x39Qi9Lxtngk0ai3tXuSns5RGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtRhmAefhqW4InoubQRgR1tkUAgghoY58XCJCYSvIBg=;
 b=PrUO1d6ipqV2LrETL2Kpv7XunEvqTQhAVAJTnrxdoTR6RiOzfLzqJMFE5V8iLjYBtAwqAl80oD+xL0vwQzrlqb67BuSyfcw8GP5Y532JifPdqt+apSXfyr816Ijt1jVosTIymeSD/BjxnWiaKQ37pcYxbg7mCf51TinZpQc3LAkjXqGiE6OdSMEEGOQSgUvWu+6CRRsDn2NrPtu5mDn516kSdKmOW9oaCyq32xg2voEla/3RUD/jF1NK1hvWO+Ifw71G9xwsUnBWeZllhH8XtqD6ZkonY6palTDwhu51eFenQrXLVdL2RT/vk/V4MHLlr1EBqLXihvyLcuJSwsLKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtRhmAefhqW4InoubQRgR1tkUAgghoY58XCJCYSvIBg=;
 b=iFvZ3JdsacB8EHDeh/WZTrrbPkLy6UxhRMFWXl0dyZarvdl4dd1sIsAsE7O7rnhI+kubqVSYW4oyCXMMqGlJV78HEht8hqhGQPVtoo0divqg0gMSjakokgx6T4EVmgf7MUvObvaTD6pc7XPJQ+tJFIl8VCWd7gsEmXrCGVFyfig/Dzk1UCXv0OoEs1CZQs3qjCxdxA0A4xNM3i7n/uolPM3+IdSN2uA1tTZAkhnlh/b4EUWhgRNuS5qzg3aFe4KKVQ0LS71pMlj2CjeaTZzF+l2t4IZ11sK5QnhwlvaYazds/bOKkS77F3D5kPDJf+uJD0TjX2g7VTCXHuG3SCcoYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 18:38:36 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 18:38:36 +0000
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
Subject: [PATCH v3 6/8] qdev: Add an OasMode property
Date: Tue, 17 Mar 2026 11:37:53 -0700
Message-ID: <20260317183755.3721625-7-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317183755.3721625-1-nathanc@nvidia.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::27) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 0232a769-3728-4fe1-2732-08de84546658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: i9gHDS7rDD9mYh7oPsxnXdBocv3A35fSGx3X6AEqfopl3kP+cDm2p1O9X/s8PW3vBxHmrxgLLplYpm4O/nyJ/x4pwfnIkLTAaSpJR8YK3cAeCXP3+qyiUxWJ6C4j1U8VlB7h81JuodhezwwP19+nS9ISn6caXIwloTBgrbEy5nPUHQOutrM9jRESMlAmdlTq5dv8y4w0rGWz4A3e+/4wLVkytiSkLw5GorakecYhdR73hC7+k4jjfX7vxd3XRoouaEnknSq8qE5LXAvsPP51fnO5NvB0XwXUkoTy14HPeEtzJROoGJsiQxwc2cM2ISoMoqU1xsVpZAoDGAjlAoInyzgltcDaITgE1vCUtpxBMLE37s0UFtEndq1v3KenvyflE8cDf3JOwHX6d2TdU571q7P4zdK74SE3rWOaDhTazeSmd05ZET6h5Vt2Kti0wJPOCQqcHGLy90oBEY1UtWxKa6hf0yYiZclHrZ3YnZA1G3V2A5OGO2B3ww4Xfc+s3e+n9TB5bzpzoNxSf89iI8t1uBucaHz7I99uFBwVesMpnWePORdUMsaj7zzrKmPOFrw11CEkYE8T90JIdee0tlFQPtUUPo7jAAbZjabaM6dDYStVLFET0iRWcbB35vazobAIp7ctV6uZX3Hr50jHdBTpk2dl3xPnr73UJ722wmpeqpT51pvc6fZFJhbgjw1Vgdnpy2HIQqIpd4Sw0NX3Yoo0JtHLJO/0H8N8/mL/tnB5BhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uALINdwJPF735+elq3FyEUv/v39TweWSMYtk6P9jie+7D66ueQRymLb13m0a?=
 =?us-ascii?Q?OUyr0k5119atDt76ZuZt4CphrPT5AXzWC7kfd5dX2H2wWLXTu60nkhiywMTb?=
 =?us-ascii?Q?fISlbcM7+h8awsI+5CdvJsqdslL9bDTIGJfD5YkOzcud00jUl5V31J22aLZw?=
 =?us-ascii?Q?bNv/DdWUNrEH4joFUenmcIlb5R5MM27mYbyff4C12EOeXtUkuuMAY4KcyMHE?=
 =?us-ascii?Q?nXMbSqEZXtaHme+2UqOBiaQk4qxm1nNB1t8XTBF3JtDvgAE226hSkCcrUWRk?=
 =?us-ascii?Q?V51hkzwq65WjU8u3HMipvSya3/B47SfWcBzRFrG36/UimKknfvKGDb8y7ee6?=
 =?us-ascii?Q?wCNmU3+NaOTW+EU18VKDkqwtFjmSQzD3nfNAhfC2N0YCTyFqDr5yoIhfluKN?=
 =?us-ascii?Q?AdgQOlvRTyXzFTN8XDCHvYs0iaL0G4xmdMkt2nHKoEdXoMaVUIneOXU4uB+n?=
 =?us-ascii?Q?5xZIUFtHad2Mh7hLqaN2PQNa8mES8DiiCV3wOaN62SVfuCS8LRNOjLj2gUSJ?=
 =?us-ascii?Q?+I2DOzOr0kOBvBU8yDyt9E1Cmq2MxGcDldqRLbItmmQ9+lZEQGPxkWGGLyZZ?=
 =?us-ascii?Q?LKR9Gf8s/Sbw0NU6F+p7ydcCEOwzlx45R8kWFOUbcMHzJZjVahICsujXVjzd?=
 =?us-ascii?Q?IYkV1RhyyF/j5gnQIifYYinoa5EionECqR3mPxtDfwmGiPeb0dIn8UkAaKbK?=
 =?us-ascii?Q?SVPQc1RDRtIu/ue0XzjTxWWpIk7PKAYZE7MHkqK5utV0rrhHoOTOx0LZlfv8?=
 =?us-ascii?Q?qX0qrEPeURjPkEnBp0xoUbYEx4putW1QQ9GbMMtv1cjYlLnBL9/RhizfPgDH?=
 =?us-ascii?Q?Yri/1K7FOuGjfV9GkBB2c/2YmcereruZ9PJ8c1dhXINld+EH6cZgXzDuSyrj?=
 =?us-ascii?Q?McBUlyrUdFpZ3HY5Yst3Ra38+rNR+Nic9OJSo5zYcbP+0+pqVBpnRJPU6VxY?=
 =?us-ascii?Q?1064Iny7cgzpzjPHCexOKWfr+NyhLHnZ8HktKsuArMs1UMeGa6fhHhWOdrJA?=
 =?us-ascii?Q?Z9BGGmqnOxYWYXp35etm4lewHZuRfobhPc7bTfpCKSCJoCk/WXTeWjP8SOT3?=
 =?us-ascii?Q?3dcU+lAcqtzzj64HfvBgvAml9DOIX00Zg2DGUf6Gna1eUJz0xVbRtk4h11Qj?=
 =?us-ascii?Q?6apaz+3bH/sCHO0UV1uY9Q/kpEXNS8+CkY1psCo1574/Twb9W1jULAN9kF0s?=
 =?us-ascii?Q?tYFX8iudoH1FkW11VRBO6TAPI4VtqQDi6Z8GGmNPU5SILQ9oyRhx8mbTpG5J?=
 =?us-ascii?Q?LXxpsQaDRkqLVOtvnjL+h2koiiXinNcE06IIj19HBRAUceTJOVZaXXQDeKxh?=
 =?us-ascii?Q?MgjVdSHDcZYlVUV9Vd9r4Z+VDyebvHKYruiTlX0jWbQfi8DFitFWulOJRAFt?=
 =?us-ascii?Q?MnEShdAZ4zA3WkLYDVft8qjUU6HWK0uIbliO7cAunq0PjrUJxt38VXE4Zhg5?=
 =?us-ascii?Q?Mi+GOwR8zNeOfZ3JiKeZ9Qyd98+I1UfqUR9TPSz54Jp4JPZjkEOO4uzstHmg?=
 =?us-ascii?Q?I0r/PaBYbXOsnqPpFZI9qydRqN/NRo//LiWeZq8bOX8Ye1/5SO5UnZPLAnzD?=
 =?us-ascii?Q?IBVHbJ8sZDe74O2doLk22wq9zLCNVcLu5Iy4SG27VgTb0g2TrHw7dT5oLGiW?=
 =?us-ascii?Q?7BKO3y77ZPXgf61Y4EjmrFZDF1rs0hN3pyeWGW/K0mg2itfflY8+YcdT7bIR?=
 =?us-ascii?Q?Ad7etKBvZQUWxoY9Bi0WPYfVn+MJ5C0E3OK4akeNkopaRBGSjSINMz9xakLR?=
 =?us-ascii?Q?/bJs4nNRpw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0232a769-3728-4fe1-2732-08de84546658
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:38:36.3647 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dk0NwgohltXjxcD8hPNQisVVo1qeQ59Y1d7aUf4a1mrA71F7gOovJ6+9t3NO33noMNUa7JLfvK/PYCYOmfYAtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452
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

Introduce a new enum type property allowing to set an Output Address
Size. Values are auto, 32, 36, 40, 42, 44, 48, 52, and 56, where a
value of N specifies an N-bit OAS.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
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


