Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFED107760A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vxl-0006md-OA; Wed, 18 Mar 2026 14:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxk-0006m9-5Y; Wed, 18 Mar 2026 14:49:48 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vxi-0004y3-NR; Wed, 18 Mar 2026 14:49:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZkJo/XthC0XyTy1V8EakOZSrsFBmcqOfKi4Wm44MQF1eCg2QG1TaKbgp7/DGAMV8wYU7Ss7I0e+Q/oKhGh5YqycQ78FZS8AtK5kVP17wxDl8z/xw9MJvrme9WQjnnUAtURmRV/xhn5i5cNgO8uA1JU4FT58FU1+MrtOwCKGz90pLIPdu5CShCgiQdAWrl8wk+KIit2GTuQngaYeLyW+E4z4GNvI7eIBzFbiuEz9TFK87Y/mXzGbbbekYe0iyEX+9nXtJi+RSBAuzEEoVrDan5uD/c8SXok5DVEsteCtLVJ+f5eTeDGa62SXp/4FfNlJGzr5aG0wmLBUA8R03QeM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxZqU0HrWJwpTcncjX/b6F8vQPilW4peCev9OOt7cFU=;
 b=Uyq8I5cffLhLfrMA3tTZTW+wSukZ8j77BJzeRvTkZNBr5+AFGG0b+C/X87k33PQGgEc4x0yOKqDVJpvLieTRTNmioLjIWqtJHBaIGo0o4B28OdRuHVkpv94cZLk7C2DLoh9yOMRAQIT+gsi0UfcA2KPFRR2yUuBGRpucMyBN/VeA1f+vqI2zLQ/FHUmwOgBtUAnk8M0VTpg4KGWYCjjVQP0oZKL37z3K4x6ocNlngjSrS/ST6u7f+HB5qo098he2o3jbsfnEwM384Z7WDCJlkwmqWJuCzK1orFzMGAMWuX5AW722p28B4xRT1Ef0ZaSFydfewmeWU/5f/FvGKuRGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxZqU0HrWJwpTcncjX/b6F8vQPilW4peCev9OOt7cFU=;
 b=hiWh3QlgubTRY3T9VPJ6v6cayxj+/PWSTshOLs7VsDqlLujE3+dYTpuIKq1F2JG8UlvAOzceOXsoF5J3602r/8l1NrZfT7so3vIzfdwm6813lZf4N/aTu9kwJ0Y8Xpidfa8y2+KopvGfHPoVFsJ2a+GnTpdl8NjspaOgnhiV6a43vOJ6K1NP2cksfJ9uvX3uMB3nOjpkBjWsFwIM7XQJ28On/IxGfX4udwpq+0a14hwfHIrtdBWlQuf8D/ZEzG5HzgK8Ih267SeDrR4kclphEriks6Q8Z92OYps2e6tdPKxiA/65o/S6riBCU8DMZlXG/mkbG/FCiahdd5+xtZFuDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by CH3PR12MB8233.namprd12.prod.outlook.com (2603:10b6:610:129::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 18:49:39 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 18:49:39 +0000
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
Subject: [PATCH v4 6/8] qdev: Add an OasMode property
Date: Wed, 18 Mar 2026 11:49:05 -0700
Message-ID: <20260318184907.4060030-7-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318184907.4060030-1-nathanc@nvidia.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::22) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|CH3PR12MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: e23daa60-38fb-4ba7-9fe5-08de851f1c05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: m/UliRDIvz3qDRLZruSmyCQOME3H6iWSAuZqi9D43ZPuVtNMT941j0mSWK4D5Xk2/Jyf1F6EsPfhNn+Z1+VmLwHCWr2h0GlqNcy/NUnl3Pn7PVHxNMFVSzuhss8ysSOESdczSlqV2B3EJUdX9XcE3pOOnLsfkkDN9jZ2DboG+VFm+ICAVdl95hIFeeb7uo9A23tap68YA5vRP7iWU7eHX/pjbN1a08fvqxNHpIajO8CEjXeliQxaMYg88aHL3tUvbiCIO0W7CLVUUqcaExEvRU8FV+6PsiM0BHbhyvHtYR7DXsWsDPY/RnxaImdyh6miTnoYSipvLknrbPjLzAsx1xl9hJfVot8IlPUNGKcVseb9H4EWzwebIepdqagwWgiRKWfzxpn+Z867V7JupXClofvrZ5l0J00JJ3HE3rfIGaKeyUztNL83tg2TX4h1Qil8uDO5GegTJ0oqRGMgEs9AkXPTbKV8Hv23FNGPtgzB5ynkf1hJ2y76bsKBZ25R+tJPaqpf5BcCg1wQlDb9Zw6cqjKXv1PgSMSbh0q+9YT+vUm1fBGqKx5eDdMRE7RZTpuTeRVo7pCUiEgX2i0H/IJtUf+XU9jYVRrFyXHpx9nejUcbn49PijayVxTYv77tkuQzaSfOQMcWYumtDa8doWNXl8SVYYVuhWUsrqO1Kj9EySvrV/as0ymK6xoZCdMmNCCrHeQz2DeFpRwAFIk0s8eOzhCjOU7vGMuYm1/CUgrMFBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aYcDhM1NlLaN328pOVg+iQ0sCWr3hz3SN0Ju5cA04LmTP1cSMwQywxIHFUkx?=
 =?us-ascii?Q?s2v6LRoVQbEP6YUhE1H3yDRCQ+4AxHTC6c069STbqmWaUdny/aYsLDlMoPgS?=
 =?us-ascii?Q?z6M1h86F/FOjNipPRa6r27cozI03LQatrDMi85gpqEywDuNNAGfl7S7IOwwQ?=
 =?us-ascii?Q?15d4E9o7SRt10a2wqOoWZPwmJUCTEXmbfnWgYkGwqQVHgs/IyAS8R4KvftB/?=
 =?us-ascii?Q?kJs4pbvS+nQin+1ugsvF3IyfZ1pDUGTMacS/2mVKqa9jsd1n4sr2CbBK5oSf?=
 =?us-ascii?Q?WHPFCANR0KtJJI4zNp4qmjWaUvtUYYRC8h+hEewT9P7AsvTrRsU+gcQt7/gW?=
 =?us-ascii?Q?NhHgvhCSEjssKnAYoAaiFqf0DfOTyVnqSRUZ87tOIYXzidbFVyofcTpJbuHD?=
 =?us-ascii?Q?sC1di3ISz+KRUcc/YTHu4QDhStARroeJ1wRfbiN+JV0vI5qXesVY24CXOqRW?=
 =?us-ascii?Q?NHvlyj1+DaaNVJ1qfm2q0U18RJMEVbvARbz3TAodS1Zn7MMPD63ws2tLtYKj?=
 =?us-ascii?Q?cWikJ4KQx7ntRFRPyiJEv86KUD71lyHLq7YxjsxgPri2WZawiYU61m9BadZH?=
 =?us-ascii?Q?F9cz+c+6vblGZ3/pzIyd2TGsv4Nlf47ktdHanH96wf9GrAyqpo8mu0ML6hOJ?=
 =?us-ascii?Q?J04yExRGp/XyM9OZaW82ntDR1tek/2ul+cDUw6As13TYbOHxTGseoDMSXRti?=
 =?us-ascii?Q?qqpBUEoXjklH7/np3Yeu0httcJoggwNUzUO1wdCupOmSCHz3R3wUwZEP8PJ2?=
 =?us-ascii?Q?zFPPm2tbKCe3f1dIMfyCVGdfxOZAvd+DQQpJ0CrAes2gSJ5UqO1ygQo82jwW?=
 =?us-ascii?Q?tHgcdYG6BO/NZKRXHuU5KsWmQNcMSNc4TLZRLcDhrr4L7UexZ5RF+xq/MqaF?=
 =?us-ascii?Q?OVJLCSUfkMhfZgaHWG+tW3BhP9sdfRZ5cme5Dp84ikdkSfb5iFzYyd0rsMxS?=
 =?us-ascii?Q?aEMIpnNGCzJvELU51AvubxsBAuQKQQxdls0T5D7h0UXkOQSzld2JFsL/7D2s?=
 =?us-ascii?Q?OnR16eNy16jn3cOp7BITaGGi3wbBri0ZfacuJr9kRp8Do3cQFht8yvHTKGwB?=
 =?us-ascii?Q?6uTo8QVD0ffGjAj2xZUafQ3nLuWVjzL7DtxLzq/UrnG8IFTZjOynzGv6Dm0m?=
 =?us-ascii?Q?PjiM/Dqkj/8Hk53qMAObymDq1AUckuzDYPUMHooNFQeIyF6GARQ/4dEN1s/8?=
 =?us-ascii?Q?aRW/bnBa0YLKWaOdLO3WKZGwFL5mhZ3ZvuN6hixO5k6cNjftvRlRXiBOtuLA?=
 =?us-ascii?Q?FVfmrPyrIh6tYF+tFjLhCxbfM0XDQ7JJ/Uz88Xrm6N9Ou8G+V/DRYIUQcBmu?=
 =?us-ascii?Q?otO97D8ae+BlVSwaZ/myWnSkyi+4R2mnMjpf7Lt5B8pWhSXxbCAhXmoo8y3W?=
 =?us-ascii?Q?kYAzrMWpWNksXeEXDBcquWRNVmXEiwnkyqQ5jxSlnqRDewNqZ0UCOwQY8Nd3?=
 =?us-ascii?Q?bbXkVp1jH7aWtF+V+3NIuGl9MTdjoSN9+7+4coY6YjZwWn93LKvYLHSwFlsa?=
 =?us-ascii?Q?rfSkwnly1DZdb6DvTXsW8p7XIHVv4YD0Qe3i9V/U9/mYQmEl4/cpK8iXczd4?=
 =?us-ascii?Q?szHzp488Jm60Kos0+y+YFOhoQRw+R9w8d2UALuJv0ujLftJWftwMyw+rHJiL?=
 =?us-ascii?Q?vbWP7jN9y1MVijw1BnuMmzofjRyxXX4bZUxTgWfDUPZoDUmmLpyemyo11gF8?=
 =?us-ascii?Q?yMmtAclc3NMthHMVv2RTstTWFslo35McCLDy824ql4KSWkrzWuZUEiPIN+BL?=
 =?us-ascii?Q?9lVQ9YBAsg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23daa60-38fb-4ba7-9fe5-08de851f1c05
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:49:39.4810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vi/ECcKL4EnC6c1F5j5+92nqeEsImL38oVa+aqjys7jHMyQxSjUWKlBK+sE4DkAB8Fn+fa6iqkCJ4SzjD2RU3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8233
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

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
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


