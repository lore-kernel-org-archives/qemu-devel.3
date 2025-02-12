Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5F7C021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 14:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiE8x-00029t-Te; Wed, 12 Feb 2025 09:55:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1tiE8v-00029O-Nd; Wed, 12 Feb 2025 09:55:13 -0500
Received: from mail-mw2nam12on20629.outbound.protection.outlook.com
 ([2a01:111:f403:200a::629]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1tiE8r-0003Zg-Dl; Wed, 12 Feb 2025 09:55:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pViXoIxxclphL8le8zY6CQYJwWCEmSP6+hhe41P6MgzHArFLfyhY/q7ILOXLjTPjoWWGk3NaNILwHGv4MWovtljfmHOs08W1H0gatbQ+hcVBTXhEjpBnj9yTstzDUUVgImnVPeskvE9Cs0BXgNo7kQp+nATeSDtpX8mXdOUZGxK9aWzOzmKhW25tT+xvi1D1g9WiY2EjgRYkwkGFOrrWte2ah6ZUdQ9cRQe9ebhzpouFGSqdzO1a/sALGCmC2gYQNfoNO1jA4ILaN8pVvyCT6lUE2N+tQR9cF2Lj1mJJHCwOl52szHW/xlnZUlmErnbwyyOP/DBMXB8NdfzmvbNsJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzWCt0avLbV0er/quSlNkL9UqVqF0BnC5ub28xuK6Ok=;
 b=vwXiiVKIhkQn7/tgCR6u0rXZ6egsii2j9IIIwV5BX/Phr+nYZo9PoHs3a7g4nqwzqljUo7u6Me8A9rW1PkFwpt+3kN5eeW33Rly6R/hWbyJHhHyfmvTu3z1fQBNcJ+T01DupVm0yli5O8d5kUyIv6sj5fPS28xwTfJyuLBwzFhGTVrvLeijNNsWJA2b9QnbLdXj7VWikynx2glbWENDJhV+QyCRRcqNvcyzW9ZNaKtneH2cnRgLL5dLVzbierdS3zfkZQ7v5iWb7QWioafuxbR6JFnEFfOQiEG5nWowIca735u0M9eKe4O5YDMLd8eAwgH+ABXOoNdiY6/VozPSXLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzWCt0avLbV0er/quSlNkL9UqVqF0BnC5ub28xuK6Ok=;
 b=bwWGghZECo2epj+IagDWPJzPlAMsmL024KXeu0aVa0RVweyqBcjkNhxCpBUNVfmeldaMsQYP63zARaIQ/D8IJWal21E7rSyNHh6Os9RJsO6z/P/6oL5BqtpwZMr0Z6RFwJradsbgNOOR6T7Gq8pmy1do8ScgM2+YrQ8tGDnCBrB0h+hDFBLOwXYuB+HFjZCmsD4PMhRqdLAVlIzJSqEeUApsdf6WXdMccafKSeHkUTLBO5PXyoTBSgl5w9GYzGwey47hmBwyagyJSikqq1ekcUB5ZMeXmdMIGoGcUjzP9Ez/LUdpCBBaWBIeqdPSqabRje+QEo3FAan3o+P4nw4lBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 by PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Wed, 12 Feb
 2025 14:54:59 +0000
Received: from MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971]) by MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 14:54:59 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: qemu-devel@nongnu.org, shameerali.kolothum.thodi@huawei.com,
 nathanc@nvidia.com
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, ddutile@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, ankita@nvidia.com,
 philmd@linaro.org, gshan@redhat.com
Subject: [PATCH v4] hw/arm/virt: Support larger highmem MMIO regions
Date: Wed, 12 Feb 2025 06:54:57 -0800
Message-ID: <20250212145457.1899954-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.46.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::35) To MW6PR12MB8897.namprd12.prod.outlook.com
 (2603:10b6:303:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8897:EE_|PH7PR12MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f92666-5dfe-4935-3753-08dd4b7538ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dUM7GDpDCjGko1agtju+YHJEHyqTJZsF+TbpGacgZdi49FnIZhJ6MhjpSjvs?=
 =?us-ascii?Q?4jsKfLKl+z8WAsWnKxRZ6zjpZUAGZcWXeDNR/GHBzJ2jxF0junD4sCi7gbSE?=
 =?us-ascii?Q?MH0o6ZcarxbyugXwcW72j55sbHchSl90EbXAMBuHk6+qfpjBbjYjPBUMQTKP?=
 =?us-ascii?Q?/P6+gHDdhYp3kT7lDYIn11HFA+0AomuHye70/RQ3A86j2WENGQA9UlxILbWj?=
 =?us-ascii?Q?55+BFuZEC3RzNCj0Q6mvLJD29dSsp3V2G5NHykpls3mdc7mdvlrZ9NW8AdK3?=
 =?us-ascii?Q?xFtsy0RvtB1E/uWp6WvIDYroobPlH+9lxc9gynNetxqfV+Jbi0zD+aV6TinZ?=
 =?us-ascii?Q?DrXWitu+D0QTBJMl0ZlsQOzLZNTZMBRBgmvXQ9yR5rlGkBVET/FUB3x+htJD?=
 =?us-ascii?Q?HCefTskCnsX5vypNlJDcGUGsCvpVHJ5T+jcDU4Ow5n5+rt93h/OVzeJZFpdV?=
 =?us-ascii?Q?FvWEq8L8kiSWQUOc/fqJbtj4s05NMdOE+BgrKAbAGwduS6+IRYZw2U0qiOal?=
 =?us-ascii?Q?pk/ss/MN4JFmSVO+9T67VFWO96DxK64In8JWC8bSlIgKn5/XMunmApD2MFLo?=
 =?us-ascii?Q?Omv1svR0zFfuLtY1je7vmXkZWq2j6lnjSwVbQRp0yRK+XNDNqPkcs3sIA4SX?=
 =?us-ascii?Q?94niCEQ9SZmaDrgKcTGHubdB7EMxceLID1/6HVqBztcy1SFpU8vAhzDgYJWi?=
 =?us-ascii?Q?nzYBhPQ8HXsH5V3hhx7tPH0P8JTxaWT25aqC3Sq5IEazp89brwrVH5zuWmwG?=
 =?us-ascii?Q?KG7W3N2pQLwm+Kg5CiheTeWr1TcKMUDaW1fxlhmYPxy8pG0W04RIFNq4lI+V?=
 =?us-ascii?Q?OKPAEvZ4Ss0E4NmOcL0k0YXJsngnC6Wv9zm7qSwVQ7q1P9BUoT1B808cYapi?=
 =?us-ascii?Q?mO4S8adqbtdgTO1S6Y73k15mrMXEJGSMEiXfsOWyvwp3RpmJ6Fw/jv4sF7n3?=
 =?us-ascii?Q?x60P2XZSXicoVotZ0vvJTzftszezSgzjThLdm1DCMUsXAmeeQfhM4BVBNxew?=
 =?us-ascii?Q?pXj8qdgaC9opuvzKgvW6SepW+kZxm2JTO4vd/v7W7KKcEjDDuxTsxuyGIAj1?=
 =?us-ascii?Q?9M/9O4n9FbeORgbUWIP+Ds0SGJxMie/g4NI5mNFQCC4yZ4vKgDCOGA5YnJ+Q?=
 =?us-ascii?Q?P+ZfbUV8EDcKVPVByBJXBqxWqas9vhCQ78cJtT/+XNCtApZ4kdhXB5Q5lXd7?=
 =?us-ascii?Q?SABBwK/lXrGcdEuhlWk4fJJZ2hY8274xmpcQTMRpn7Faqg8BPiFQyMRhLF+r?=
 =?us-ascii?Q?OX3d2BN90dvPHX+mD8P6C3N53Ap6osHsMZNtMJKCWj8wXYsZYagXJfoeq7Ed?=
 =?us-ascii?Q?ifZazhmdLxN9By2BpG0Ll77Pt7Ng+fCGyhTJiv0PYRaJmC5+wNhnHEukO+G5?=
 =?us-ascii?Q?+zbHzWgN6cHbnrH6Ut9F8rs3ea+l?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9QrSzh2/j+p2FgFadkgGEsmslADjlbHAyveKQ2Q/j1PMRRTKCYpvf68khVWx?=
 =?us-ascii?Q?GTuo+RrNEWDYY7RRbYejPAoasfiO2abeY6dfLOr9aXc7tGGIylJKGoruI6xK?=
 =?us-ascii?Q?27hombPj8QDpDztqo1PdVtyDZoj61Spx8se9e9imFhhhj4jeV7z873JdmzjZ?=
 =?us-ascii?Q?NpWx6ESoxkW1xtsVry6WKxX7n7Cni2kgfBUMEoSnDTMpTtMLw4lN8P/IG1I+?=
 =?us-ascii?Q?fA5e391V/jO8A4i8k/mKLMuMrHmG3ItKb3/fctXYTWk+ma2UCWA35JzZF9Y3?=
 =?us-ascii?Q?tjio459VyP5PZj7c9jriz1OpgiJfbgZlKxvnjJ22Cm3vSZT1TnphXx04F50j?=
 =?us-ascii?Q?TJ5d9YolQKbgsNE+hpl6TKMLaj2feFmRIl7LSnHgAvbxrC7B6kpYXsGvo28w?=
 =?us-ascii?Q?gk01viTqXqAiANpEkbXYX2rCE79dB6VlvTSBJd8pQVqf+gm3lzQrkOMKDCOG?=
 =?us-ascii?Q?+XMKrvohZ6iANM7rxBx9xbFf2ORLTL5oEGjRnOSsadxMvcMLKtvpqrvVK0KG?=
 =?us-ascii?Q?tN/qYeM7BI31BaHj9GKcdYaaCkHXuQnCIaW1+ZSDsovKHS0ZBbdEMQKTdY/4?=
 =?us-ascii?Q?yuMkQ/b+uryoEZKBZhfLRsBs2GWvMPGqo4vBRWclUrQcQY/HTl55FlIUWykg?=
 =?us-ascii?Q?fuRNCtvH8y1gb/EvQAGXfN38UIolDUOpwNgSIKhDXSRzNOQO0xBDQyMmTnVS?=
 =?us-ascii?Q?Cy4AHi3uYJqClDXJJmnKfp17tgyrhNaOXNUDhxQ61JwzEbK/ssCX0YSWVfpf?=
 =?us-ascii?Q?bUqWHatjvO0EzZhtyLP9HqIEzLgFvcPTb8tlgazgDewOcrPDSk7D08evOvE7?=
 =?us-ascii?Q?VIet378CR6SWy+1aJxp4OEi5lQEZAbSVe8A6rzuby02Bqi1VL7D+eQ1rZrVw?=
 =?us-ascii?Q?Z2UpYP98yOX6t8bCmInTGXiUquB8rBCV+0OAtSMxhWJD7JCWTvBuuz04ejdJ?=
 =?us-ascii?Q?qJIdODC5ppASZAHDUQYHQ7vlkHw7DCccFfQgV0guOWqV5HHHzRragnEgk3iS?=
 =?us-ascii?Q?O0IJysV4odpuOUmRNh77gjPzyVg/tnI2MZxI9n4GOE276Hs87kGfWU1iqRt9?=
 =?us-ascii?Q?OBaCTPe/RpZdAn4nhYyp8brQtiXoOUZ7TEl5m5GWKuu27t1piYLgDfFTyoqp?=
 =?us-ascii?Q?7SIgF1q16MXbNL2LWl3YbBXxI5F/MIKabhSKeYmXgcOwji27AN2LlobzL58B?=
 =?us-ascii?Q?Zw9PTzI90UUKn4I6C4Oit9RfdHxSv2WFrDHkV6EhWe2dP1nVU53af/kv29Kv?=
 =?us-ascii?Q?zrCESSd1Jn+rZNMFGNUaPZOW9Io9JiypelbKurNwGzOXYl/yKcb7FCLQ5XNv?=
 =?us-ascii?Q?85zzyykx0yZGxipniOamWlFmD1p60x+yJL0XKVkFDvYHzgZz+N9jz2fQdRW6?=
 =?us-ascii?Q?os5ge7zQXelnxdT64Umf3hGHNDAH2hfhhrBiMQ2it9H4AK1QuF5TrldZC21d?=
 =?us-ascii?Q?DxnD9xdmSvotDejGkNObUGU6S/nyjRX0g6/YALSDuMzkgihNR2rME2PMdLo2?=
 =?us-ascii?Q?CuzdodmCTD4KVTHjzs/l4CFXB8gNgAs3ro+y7WL45gXTH6pgMrMH22Zvk2TW?=
 =?us-ascii?Q?5ci5ZI9vyvYtk/QqOaQF9AxUrpUnadpNbbEG7oe1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f92666-5dfe-4935-3753-08dd4b7538ad
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 14:54:59.1813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18NM4lbuog8ojgPBhfYuY3VldQg38D4RhAUX0AexlUwpHTbkh9sRvJPX4/mtOXtps3uDkZQj+MzPZ/hQUMJyMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425
Received-SPF: softfail client-ip=2a01:111:f403:200a::629;
 envelope-from=mochs@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The MMIO region size required to support virtualized environments with
large PCI BAR regions can exceed the hardcoded limit configured in QEMU.
For example, a VM with multiple NVIDIA Grace-Hopper GPUs passed through
requires more MMIO memory than the amount provided by VIRT_HIGH_PCIE_MMIO
(currently 512GB). Instead of updating VIRT_HIGH_PCIE_MMIO, introduce a
new parameter, highmem-mmio-size, that specifies the MMIO size required
to support the VM configuration.

Example usage with 1TB MMIO region size:
	-machine virt,gic-version=3,highmem-mmio-size=1T

Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
v4: - Added default size to highmem-mmio-size description
v3: - Updated highmem-mmio-size description
v2: - Add unit suffix to example in commit message
    - Use existing "high memory region" terminology
    - Resolve minor braces nit

 docs/system/arm/virt.rst |  4 ++++
 hw/arm/virt.c            | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e67e7f0f7c50..6ff1de1ecbba 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -138,6 +138,10 @@ highmem-mmio
   Set ``on``/``off`` to enable/disable the high memory region for PCI MMIO.
   The default is ``on``.
 
+highmem-mmio-size
+  Set the high memory region size for PCI MMIO. Must be a power-of-2 and
+  greater than or equal to the default size (512G).
+
 gic-version
   Specify the version of the Generic Interrupt Controller (GIC) to provide.
   Valid values are:
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 49eb0355ef0c..d8d62df43f04 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2773,6 +2773,36 @@ static void virt_set_highmem_mmio(Object *obj, bool value, Error **errp)
     vms->highmem_mmio = value;
 }
 
+static void virt_get_highmem_mmio_size(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    uint64_t size = extended_memmap[VIRT_HIGH_PCIE_MMIO].size;
+
+    visit_type_size(v, name, &size, errp);
+}
+
+static void virt_set_highmem_mmio_size(Object *obj, Visitor *v, const char *name,
+                          void *opaque, Error **errp)
+{
+    uint64_t size;
+
+    if (!visit_type_size(v, name, &size, errp)) {
+        return;
+    }
+
+    if (!is_power_of_2(size)) {
+        error_setg(errp, "highmem_mmio_size is not a power-of-2");
+        return;
+    }
+
+    if (size < extended_memmap[VIRT_HIGH_PCIE_MMIO].size) {
+        error_setg(errp, "highmem_mmio_size is less than the default (%lu)",
+                   extended_memmap[VIRT_HIGH_PCIE_MMIO].size);
+        return;
+    }
+
+    extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
+}
 
 static bool virt_get_its(Object *obj, Error **errp)
 {
@@ -3446,6 +3476,14 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
                                           "Set on/off to enable/disable high "
                                           "memory region for PCI MMIO");
 
+    object_class_property_add(oc, "highmem-mmio-size", "size",
+                                   virt_get_highmem_mmio_size,
+                                   virt_set_highmem_mmio_size,
+                                   NULL, NULL);
+    object_class_property_set_description(oc, "highmem-mmio-size",
+                                          "Set the high memory region size "
+                                          "for PCI MMIO");
+
     object_class_property_add_str(oc, "gic-version", virt_get_gic_version,
                                   virt_set_gic_version);
     object_class_property_set_description(oc, "gic-version",
-- 
2.46.0


