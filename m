Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F050C02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 20:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgV6V-0006pJ-II; Fri, 07 Feb 2025 15:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1tgV6U-0006p2-DF; Fri, 07 Feb 2025 15:37:34 -0500
Received: from mail-mw2nam12on20614.outbound.protection.outlook.com
 ([2a01:111:f403:200a::614]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mochs@nvidia.com>)
 id 1tgV6S-00006N-Ag; Fri, 07 Feb 2025 15:37:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTOdrgXjblsuhO6ttjwP4oUXtS76umbYALJLRsoZ2YXx6kb0Q13ckhyFwDkkN+pFVEvnmyIGjNzHXqW2zKLCBcT0xdQsanbfusgXGzZZv6VQHxsTMFqApdcANHg5ijobVO/sa+bFpauFdFiRfWmNeqt5IT0thHSH57VHl/fQNpXyA6kO9saOVOMkSwoiuF2AO8YvckeZTLiE1dbg6UyeZcnThll3gZBcW+ZGxTTGKCJ+hwMmx1pm3pJdlubWn4bq/uskxfjcjarwpHg0p18dyNNdCoPa3R+qbM87f+t4uT8AcYKZQG6KkDt4sXeCEWPyfr/WcezXeTww6eLRnJg3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DjF6AlmFefWU7Pa/XVVmqQzEwRt7+ijjXNqzZKKZFmQ=;
 b=iYaiu8mOffLnwlew/+WtZTDb0SPYLNlZTebEFeB+7dJ0I350I1Ts2mYR5bAwvYhV+vmoCMgEl26b2FaDIL1z8fRVaqGHa+GWU7khICaDtgRt6vKNDqRTMPvlaKcU005oUNdvLF7tY6X7CF36wKY2se5GGaIA7ZeX2Q8eVC7nuhNIk/+Qj9gca6UKchWzXLxRfiSOPUGTRWQId7ME3D7Dkj8pIP7z78EPCAScXbbGeeAzt5iqIBpwgixemYAu1tx5aOH0Eta3d/l/olgCjTp0+nla+noQfREGw19I34TLjwf6CCm5R3pXFUHiVbun7jaRgHEOwRvv+CJmr9XhQk6mUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DjF6AlmFefWU7Pa/XVVmqQzEwRt7+ijjXNqzZKKZFmQ=;
 b=RW1f6CgL0k6ofwT9gNmkLKxYMrVuvWdMtN9PUJB1E+mJGimAEBpT3b3v9G10StivGRCR0KVOxauqQgsRoP/EaJbISRfpWy3AuL4Zx7T4ila5Q7zaXfmlMlO28Wk7fJ9RRd7VYgvItRe9+FqfuTfhGCrbLVEd2vK5KHh38PtsU/U4XF9JrJPhoIGBsTOE+SbsJfZGYGNPT2UpgxqmO0k+eDf52ZE3okAEx7Ro5FjLxiEunZYsylG1tICkCIEFkr7KolJQQs1xISQXJqq0JkPK6ghq4/e+WVUhwDf/QKr2In3Opt1q+JJ9eEvgS1WtM/6s3WLiFHgADRHEZ3RcS1vcEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 by SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 20:37:23 +0000
Received: from MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971]) by MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971%4]) with mapi id 15.20.8422.009; Fri, 7 Feb 2025
 20:37:23 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: qemu-devel@nongnu.org, shameerali.kolothum.thodi@huawei.com,
 nathanc@nvidia.com
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, ddutile@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, ankita@nvidia.com,
 philmd@linaro.org, gshan@redhat.com
Subject: [PATCH v3] hw/arm/virt: Support larger highmem MMIO regions
Date: Fri,  7 Feb 2025 12:37:22 -0800
Message-ID: <20250207203722.304621-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.46.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0069.namprd08.prod.outlook.com
 (2603:10b6:a03:117::46) To MW6PR12MB8897.namprd12.prod.outlook.com
 (2603:10b6:303:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8897:EE_|SJ0PR12MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: e83e7469-ce95-4249-b2a9-08dd47b73a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z6xR5nxUVrK5qu795PBjax/azCa7RiERCKZcRLWhCpIUXNyR62X0gYcPli6s?=
 =?us-ascii?Q?6b3akL6EDmLz6Bhy4UhPr9GOoVIQSK0dZbFppukC123eSF+Zd/kZm3nNHO6F?=
 =?us-ascii?Q?nUUSJBvyIgwQ8ChZX3dHk2H6rTjbkTjLDbkx2Fzy8mVOJhx1f9WIwJm70IMn?=
 =?us-ascii?Q?ni0Pbdl0B5qPygjeAmmeiWEDFV18+aF6XXAg75u4VKkrEO05WvbUTd2VZ4DD?=
 =?us-ascii?Q?OcTx9vrZ/xoArCJOHvFSp+ckVz+TSxAVdbjppKgrri1ZzERn9/+W8xGSBGME?=
 =?us-ascii?Q?JTAZOwKCsH8fAfb//N55PkgQLvLOw1AHH8sOp2QyIKTOzp25sondOzMYGN5Y?=
 =?us-ascii?Q?HXlnJQMaB4uzZ+OZZnGB9TSewunZ77WClbisP5jQJqSRE9n4stdyZBDhJECr?=
 =?us-ascii?Q?fJQIwXkEKEFfXwPD0KZoFnni0SK5uGZ4eTtu9dgdZUZxKCFvTK0plutmJEeR?=
 =?us-ascii?Q?pTc39qv4nAxDIkZ0gJM+vOzUIyrZI23HZbOP+m+GcQxqhY13pQaDLDGu6GGc?=
 =?us-ascii?Q?MACN6pYMIwGIC6R4kOmraIUy2/x4G3Zcc2F41htTR8RczIv292/O8QuK5dSi?=
 =?us-ascii?Q?ZF8t0FMuYBMaTv1corqJBBRAcv0959M9yEBk4+VChncb2HGalFlXn64zqbdq?=
 =?us-ascii?Q?jeYpnD5lf/4rYXiuvm5n8MlLEOFSJJnKb3E3XtJrfSEWvWFi5IW+HZtt8WLb?=
 =?us-ascii?Q?D8SDbMrJIoV3cX5bOHT/Dkw8Z0SgaXY2NdHxx0FmGgWrtWEzPod28sKO4VQX?=
 =?us-ascii?Q?IeJj07wIjy8z0QW4eQVkVIfqKx/XGiih5rKu3iQezBVlWwF/jMT08KM89ybH?=
 =?us-ascii?Q?ZjdvbjciaDg5sUNAzPAAvwYb3OuJ938wRivMUtGrtJvSAG/t1VHMJ7BTmpZe?=
 =?us-ascii?Q?pbPAQ/4C1HxD84ap1C1I6GOdWsK7TKy98igd2ifm/0O6Alh+7qs0PWv/6DF6?=
 =?us-ascii?Q?fPikgj5KL0Xa8jreGM/4HJlFNa3KW0rVn0JI6GNRQaUfDD+/o25skA2Mw0Lt?=
 =?us-ascii?Q?3NGAdyRYM3V1ZfE1gmafzqIz4LNjNvXIPJdcvAGWzHoo03TBAWiRWtBx828s?=
 =?us-ascii?Q?+Jevu8CaZCZs4bTQKz1/c7dzLG7tO4MFOcnrZemjI3vDZFdaFKVYzk9czEBR?=
 =?us-ascii?Q?iMGaBlNCewozKg77YLee2ppdD2DgpXKfq6zQKNCvO7BXtHNGh+MKgJ2Xf7Rp?=
 =?us-ascii?Q?LHy//Vuo6tpvtMJT8QeLYnPAtL5zyO6mfhpJUqHKkeAhBHx2cmoWsMFqXySJ?=
 =?us-ascii?Q?xr1FXOqIXhhnC1qZvU5CjgEy/aT+BvHeEP5Bvmt+eqnpq6NGGjg2Ns8yzn/K?=
 =?us-ascii?Q?+HTMBVSQO0sENaDfde8hicESj7rKldOZKhgLwcvLuVYRDCcUciKCTc+DFsjZ?=
 =?us-ascii?Q?Z1zhf+F9mYw2V56j46CoWig3J0qN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YRZcQMDF9to0tCQDwN+SWqWnKJH4h9TBNyZcTXvZVENHeQlLRfu4W2BvMERu?=
 =?us-ascii?Q?A+OstJJOBUezTiwozQ9f9aBSz+kd6/5W2kMcOOcR8w4LyUC23D7ZOixc1kTl?=
 =?us-ascii?Q?nKnAUkiobBEByNZL/4E6TsELyWYVk9il8Zydy+Z0eGCvGNtV1vA5CUU6BNj3?=
 =?us-ascii?Q?m59fo3M6ISdD2aKI90OgsT/RNKEgULup0LzD5BKfDWU5K7Eax5rPx1hk8L9/?=
 =?us-ascii?Q?GcO+TzWyfZrmLCu+t56N3pz+1NDMiK7TSlvN2orNPy/2bqRleIh1oSfhVduV?=
 =?us-ascii?Q?/5RCqbOUYqTL2F3k3h/DrBTtM7Lo/2IGeLxatK+iUPWfLUA/QL+B8rQ3Ugsh?=
 =?us-ascii?Q?9wpe6PWvW/fP1pjMFKxfjZ7osPKXsCa74feRbpvG6V5whg/ZzsLy/R2O7MCO?=
 =?us-ascii?Q?kUPS6klDuIZIjNiQ/EKwHHjIKAq/r/MJuaKkTHkyZFp3oEr9QlfmA5Py3+bj?=
 =?us-ascii?Q?vSeHuMMdayjBKw6lf5P5iaDme3RK/HlkdePUMfD6GxK73tDFjOVIyQ5+txFa?=
 =?us-ascii?Q?pfNszE0iRGmzQh3kOLuNS+KD0JsQUqMClxS5wGsGpQ0IMDBaICv+5r9cTYix?=
 =?us-ascii?Q?v/VRDjFWcHsg2rUUhLjwFoBxYLwwsZFjr1L0mdFQWXvTOFg2Rt9jnKOQdi/U?=
 =?us-ascii?Q?KCpbcnmhh/5AIO66iNtIKcvoYF6MGscaEb7vfljeWeE3bM+BdhU2vmEYLsZ7?=
 =?us-ascii?Q?GPDLeL8+6x1MNSZGIAIapjurZhy+aMykLYaIvb/74K+BZLTPQNbQs6QLAZCz?=
 =?us-ascii?Q?kDy2cjNZVu1QPFZ32sT2sk7FnciV2okn/txkUcqN5L3AqR9UCjjp4iaOO7WJ?=
 =?us-ascii?Q?qnA9VVlSZL1o86ugFd6whz2ydv7n6F37Bzu0PkmLmxds/VvfE3n/BRkOaRjQ?=
 =?us-ascii?Q?NP308WfQDStnXWAL7FYAgoqNNzXHZKHqjsuVD1kekFIidZcQqTssAjM1NmkS?=
 =?us-ascii?Q?7Y+EYsN1457x2Cw5sXGUsyYFRyV/5HZkWhwzg5HAJjRQNCXFvWX+XB0JtmfF?=
 =?us-ascii?Q?LLpomjE53u3g4R1w4r4d0AB0CzImMYeWyq/OmexfVd+qPHCnnMyB9EJclxWr?=
 =?us-ascii?Q?Znwpvod9/6w48yl6mZA+Y9jr9M1c+J/r2evLwDzlypcE//CDvsG1ehtgTCrX?=
 =?us-ascii?Q?S5rL8NjsjijEFN+ZrMGx801ArSszTSSdmzvRc7W+2oGnL+QdJXgrieCLRYFC?=
 =?us-ascii?Q?OpMLx6isSMvGsN1N7wxR7CRCUjCSh/CdoTzjPxZkT2utaKcSz/tt2ltoXkNl?=
 =?us-ascii?Q?nabCzYpoGyi59/eEmA1BoxizZMr2pJh88XlsVqqc0X36p1gE7h0VsMzPlCT7?=
 =?us-ascii?Q?hZk+nedFboF2NJt0Y333Uzn57Q0mwXz38uiUVB2HrgUSuUZByWkUVBVQO3av?=
 =?us-ascii?Q?jeD4Nfz983l+SM2w5JTfIOVayGgBoE0MSmb5o7YUUSRldq/GWjo7Y99PEzr4?=
 =?us-ascii?Q?LPHVvtwAjyaeXrSnTxhWBxnOh6VFijbqmVlcEZ3YF5vrxk/OWcvz7DPXlSwd?=
 =?us-ascii?Q?gXAZxLuvp2hSb4VVQfEKkB0RhUZK8CNaMGDX8PebG3mHXolJge+a+kvXDqAk?=
 =?us-ascii?Q?e01IGBweSSkY1CSd1erTLtV0fMb2pZ0SpJtLEYAS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83e7469-ce95-4249-b2a9-08dd47b73a2b
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 20:37:23.8496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yztf/Q+/s7ISJHyfHHE7113vOv8Uws6R+vYHbAbf8wUMzK6a0YJxMTWQ1UUx0xtKl5RbN7J9morEvA6bdc5TPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476
Received-SPF: softfail client-ip=2a01:111:f403:200a::614;
 envelope-from=mochs@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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
Reviewed-by: Gavin Shan <gshan@redhat.com>
---
v3: - Updated highmem-mmio-size description
v2: - Add unit suffix to example in commit message
    - Use existing "high memory region" terminology
    - Resolve minor braces nit

 docs/system/arm/virt.rst |  4 ++++
 hw/arm/virt.c            | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e67e7f0f7c50..20b14c22b659 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -138,6 +138,10 @@ highmem-mmio
   Set ``on``/``off`` to enable/disable the high memory region for PCI MMIO.
   The default is ``on``.
 
+highmem-mmio-size
+  Set the high memory region size for PCI MMIO. Must be a power-of-2 and
+  greater than or equal to the default size.
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


