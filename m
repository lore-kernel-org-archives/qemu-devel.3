Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFBAC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 04:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfWsx-00005g-0V; Tue, 04 Feb 2025 23:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1tfWsw-00005T-2Y; Tue, 04 Feb 2025 23:19:34 -0500
Received: from mail-dm3nam02on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2405::62f]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1tfWst-0003BC-GA; Tue, 04 Feb 2025 23:19:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IglqyWeTzdcWCflnQRAAmLby1o0IM+foQ1zFu/tGkKc/LtVnXW79qqMhc3RdJYoCDI1Gjx7mdjAxgIsAWzmhxvK791yDD2cdxkLpsGM34v/Ej+kOhlAsxpevbDgku7DyKX0S3yxJS2H2J+TfsFb9zObsYS4qdVepGXtyKlzP8ser+2FEdmbUp9v6DuoJblFTpMHjb/lO2wq5qdxWx5SFDKuqqHsDJ88WvmXdE4u37k7ytZv6rKEUsmPu5Lmi6AVoW9w4wjzcDnLzhW1nGdOXOJJ8gQb4Ov9wahq2mWNBcP0cuzdNkTYXzn78j1RK+pWni+IKhkDhBLg98scybCpVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNyG4a8mXZHuVnlS53JB/iEIUZoorq5O6cS9MeAqvJI=;
 b=KrNKIkmhcjf3Pz9kOD9DEzts2JqVNnafT+7+LadjW2eLzDWohUZ/2AycR0Nak5mgba2x0dAE4bRjU+gMAh8yzNZru3tTh5qMc5vd+Yzg+QW6X3yFx2MaDU21Mh5aT/VcL8ncgSRw5dzoZW6D/r9b3iFuVhTV2i9tyLo7afMkx1vvDnp9u3JGoN7q/S62PXeAnUJq5CXfB6d+lDU8NX1T+9mcE1/IniWLSrdqqVI1U2xpMnBZZ2dRITrpDr/l1ZOj8pzml3tJNZ5n2Dq1NzXXkC8x1OKGwP1VqQMHDmqqNc+3nhAC/2Qmn05i1Th59GBrT1LFWvPbCCKUmJTn8wfP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNyG4a8mXZHuVnlS53JB/iEIUZoorq5O6cS9MeAqvJI=;
 b=EIbGMYAEJE6HWIHGIZsDTa9tjHLxKZQ+V2/wQeJS3fBYwj732M0b6Zjzyl6TQZ9aqFn4yfim2U07NzzfwA+DSS2R7jUvUaYz94Bq+J7VccQ7pqDaKd8C0tUfq4MKi1V4/rumKWKZeZ/kvTpgxKWN8asH8ty9vIV3xkyaeuI21gbuYxtYtXjzJk33hS2WxcH7t719ICDqIxczVY4uU678aVcWmnwtcFklO+HdzpQZ291rjxkbEGU1rBVyxQWkGdA42ut1Bm5esjuSIrhoKdY8LqGNEHecrH2vjuc7voqg64fs3Lsa4un/rIJExh3xQI5iMH4a+djITewTzyjK1nq81g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 04:19:25 +0000
Received: from MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971]) by MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971%4]) with mapi id 15.20.8422.009; Wed, 5 Feb 2025
 04:19:25 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: qemu-devel@nongnu.org, shameerali.kolothum.thodi@huawei.com,
 nathanc@nvidia.com
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, ddutile@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, ankita@nvidia.com
Subject: [PATCH v2] hw/arm/virt: Support larger highmem MMIO regions
Date: Tue,  4 Feb 2025 20:19:18 -0800
Message-ID: <20250205041918.2340237-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.46.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::20) To MW6PR12MB8897.namprd12.prod.outlook.com
 (2603:10b6:303:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8897:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f241928-2eb6-4cc4-7a9d-08dd459c4611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MouONbdrQpBXwyE+Vp3c0vQiXkM4cQvd/LaQJz1geFaZdxXveC2Jk0Jwn9YN?=
 =?us-ascii?Q?3l2rlVR2e8r1ulbSjU8sB0p0AJo0pPUitEjF+JoCt6OYpHa8RM2cVYxxsAuX?=
 =?us-ascii?Q?+H2Ab5Erk2CNhR+qTbNIG3AfjNjbrBB+UP/FkdPUwW9P1MU2lwcmllbHwRFg?=
 =?us-ascii?Q?6BxfGAy0Ests1QWD123wZP4e7KwdZExDSyeaxYUPPpC55VywztSiX8K6oLSi?=
 =?us-ascii?Q?2He9E3rvs5kRc9Py9L66Q4J5vbac+DYW2C+T3F74LsO3dqJdevj47SMOM+/Y?=
 =?us-ascii?Q?LKeBBr7h1M3hc4SuXmcUIlzSuFYfbdQ8L7RpAfk2Fe+CmcMu7BgThaRbkQR0?=
 =?us-ascii?Q?dIjmcsyehhIiI4WJxEYrfQn0k5g+nQO8arNfH5szW09npcUXmZdnNYUjmH7x?=
 =?us-ascii?Q?le4Kf1zURyH27JdHcLvsMEgkZL//sq2Gk+roSrkVGSjAhfx9oFbtaaPQmNDl?=
 =?us-ascii?Q?bz5MAP03v9bZxTH30ORwnntqtZNbafeLK4UTCtFWAJxdIYG+gBCbb3gtMK3x?=
 =?us-ascii?Q?eQOn0UEYqaZIBBxI0x+tY4JBZZf02Z39OTnySzcr0MQIBfpD+50n0qLTIDny?=
 =?us-ascii?Q?HTvOt1BhCU9w+jilp6JBnBMUuu2oxXd6FJdNEPi2APhh7FInFhuu4e+wMVOo?=
 =?us-ascii?Q?VH9TgWThtidONBY1WSZ5p3/UfqncrSrs0xh1wmmzkYMilGZjCHx4Ewc2cz96?=
 =?us-ascii?Q?2uCSAYK4X8fvacHGbyJutOipidEmMUm+T4qQIT0jKCPU/gAb5QNfb+d5FNPC?=
 =?us-ascii?Q?rq5Zb5V58LVABUdou8de4dczsfarrdaN6SROq14w4YyFH8mGFKSY/C/qIYgn?=
 =?us-ascii?Q?M2cDsEVcbG3eu9YWvB7QOQmPYJszHx5kTh3EkTvd78xIOBUnLAcYuSb1DU4f?=
 =?us-ascii?Q?3k9iIiZRLBjoc6Fzs0te+v1c1bijRBFH6713JeAFNGS+A22RfEpkizzpG7OE?=
 =?us-ascii?Q?nmX+AlFIkRJtcx4QKRAoxFPDFVc7/A9CDcb/+6XBwt825Ui8G9wQ/N7Uc93h?=
 =?us-ascii?Q?kbnq5cfFAZoILL4Ik8wOGy2Tw9RS1dLmGhl/C7KJ88Nb1XL/a2qqgrMs0py+?=
 =?us-ascii?Q?N9+d3F9bdWxGQC7cEzKfayaRMZE+7ZL5rX6Ft4AkUsLMSdVM1TECS31UYILw?=
 =?us-ascii?Q?7K+do+58FFHbBxNocyvQc+Qo9RnnkCwcWMpp3nMIpLAa20+VuQRyaYXsQrDW?=
 =?us-ascii?Q?Gtzre2FeVqI7K95p5QEHTwnFLUBbMIsPgfBaozYqdWIKGis3fNO0SnardZVu?=
 =?us-ascii?Q?dQTYCHCKYjxqMIGqx9yHM3HQREkjJdQ7wCn3B9BxXTwcBJE+g9JEFCzS6DVs?=
 =?us-ascii?Q?0va7fqmAIyxaS2GDfXda5N2uc8VzPQjSn7EFlcC3fBF9CH3Fs9GxAW3QZ0Hi?=
 =?us-ascii?Q?9J7F0vJDnRcsatpfGwqcIkC2u3/y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AwIvisKlj5b4/1OIFzdS/PRrujjGZfzITGWiIdm1uAdU2RtE8ldgxmqbmlLa?=
 =?us-ascii?Q?2yYLDIq39XDsqKNaF5Yh/3qjOUdXnDxzbTmI3oQsSh7Aqpjug06/r4Z/f2ul?=
 =?us-ascii?Q?bFYA0/mLcceV1+24q0pGhLhTPCpy7tjSYfJmlbl5qRFG9gPRKOxSevnF6ZGf?=
 =?us-ascii?Q?2Pv1XcpJx8jIqat3UDt5V9hDxopxEkbZxQT18qCNDJfSkfQhnw7QE4IzEg+4?=
 =?us-ascii?Q?Rr9qmXtv6aPO3FB2qLrzqd5JWqab8KSOQQbeMBBL/WJ14fheMitSsaaBjbLX?=
 =?us-ascii?Q?W0yghrjEo+5U0VRtm62SxlgCOxhkSjNjpqjZlcxg5ssx8NFPwK7cAE1fLZbG?=
 =?us-ascii?Q?0t2zN2FPzQn4ioBT35O5ozByZI3PZn1Qy6q1Y+EOL90w9Vy53VhhEi0YRzKM?=
 =?us-ascii?Q?1fEdHNUA0hCI2gs5ojHcQbko9CkS2fSc+sPcPKgO321tMcakj01OcvsaqE++?=
 =?us-ascii?Q?blyRmnC+S4PAanlih2CUhGChevGK2CSycFI0w/9rIXsjoSm/zMmCAvpM74h5?=
 =?us-ascii?Q?7llO2UazV3heaf2dWVI+FPCWuGU3BSqjwIB0XdVIPKnpt0StW9qErwOysM9D?=
 =?us-ascii?Q?DJE5wsvYXVV/uSkaahYHEbrovbth0iZWpCjeOpiUUn14UZ2JTmIlXSeM/rBW?=
 =?us-ascii?Q?30oqSzSKif8AXhPVOSbataoGoHs9HasRJP6yPcUDj6Itb8y2VJ0atMfA/wFW?=
 =?us-ascii?Q?8awZYZ/kK2IG0ajgbN1sCRw57UFHgYeQdX2RofFm0/+Y+BaJA1fTIVl0IPsA?=
 =?us-ascii?Q?ija2nMA/3wAWBc8bnl8kfd0650SwRgWykIhETwWidREiw7qrn5LXLmv7tRkT?=
 =?us-ascii?Q?vWg4OjEemYycXkBMHYxAWBvjMPgEzIySmxeBO4Irbf5jJn+WwssQLkTckoVJ?=
 =?us-ascii?Q?Wqv9v3GrDSZxVX0bLoCimWBxyNePMkzQjIemJyV0HryCR+A8HhnkYEVKsy4h?=
 =?us-ascii?Q?nA2voshQu3mppFJ9R3QCMEdR5vwtwhlYQtVN8ymUyhJRO+afCV0Y6I9VwF2Z?=
 =?us-ascii?Q?0gG3jzLH2e/Ju9nBqbrMh17PZOFpcegiv6YN+OfU0bg2cqJx00EMLGa+Rtjv?=
 =?us-ascii?Q?RxBdLCtKx4zrOwdpSTV+tzfnHbOf3fN+Vvkf6VAW1K8NRYKzg564Dq9QsZVA?=
 =?us-ascii?Q?jXjsGaWLzGrN8E5nuyRqNSDE9AqFWWUjyU9dsgDtebO0OEqA4MeTksLKyShu?=
 =?us-ascii?Q?sgMVCLm7JbwAw5HkUV0A5f/AN2u7JF7PFpaW80si+NeHstPmams866HRJ6ED?=
 =?us-ascii?Q?5wuRm2ARVwFywXHL/vfKnjPHbDCdY/qoLNVBg9tU3tC6uXuhv4o3E8cdEC6x?=
 =?us-ascii?Q?ducSbdSwXFTxsPYlL6wpAl3vM9ZTPqvC/ELziYM7QfugngJvi/YRoUUw7bie?=
 =?us-ascii?Q?P9nByFXlwesNDV9TWsclLE6Elrsxk66TFrB71ac48rjGIrDX0gpC1CVuYH04?=
 =?us-ascii?Q?pxy4lOd5nOG4epliAm3309TQWGuUvKtSOaQ7KURlfiVzVe/lNNIiDxjhhWwW?=
 =?us-ascii?Q?X5389OLaXrM+BqBcKs9bkcb88MhV0Im1xuwCTGz29XRj+OzywpZ6DMZRYyp/?=
 =?us-ascii?Q?H+3ifXY0xh6+7YQo1xKMrByb893PlZL15L/3lmEW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f241928-2eb6-4cc4-7a9d-08dd459c4611
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 04:19:25.0403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddDPNXx4DMisXQ/vYcKp5Tz+GAxeJKROMWG9QRHYPG8fD4Y/vO+nXhDH/QZTl/X8JlSgK3NGVQvsed93nTVG9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044
Received-SPF: softfail client-ip=2a01:111:f403:2405::62f;
 envelope-from=mochs@nvidia.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
---
v2: - Add unit suffix to example in commit message
    - Use existing "high memory region" terminology
    - Resolve minor braces nit

 docs/system/arm/virt.rst |  4 ++++
 hw/arm/virt.c            | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e67e7f0f7c50..f96cf4da2a78 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -138,6 +138,10 @@ highmem-mmio
   Set ``on``/``off`` to enable/disable the high memory region for PCI MMIO.
   The default is ``on``.
 
+highmem-mmio-size
+  Set the high memory region size for PCI MMIO. Must be a power-of-2 and
+  greater than the default size.
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


