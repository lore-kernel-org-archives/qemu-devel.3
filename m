Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D09CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMZZ-0005XM-EL; Wed, 27 May 2026 18:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYo-0004oY-UU; Wed, 27 May 2026 18:17:12 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wSMYn-0002Ly-HN; Wed, 27 May 2026 18:17:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsAQKN7lUTdTCZehyVMxq86veW2vpfDlvLeScx2DxhDWWyBFnfRiU3kDUfgm5JlYX0nQ89yOLcHT8yUWYhGFUr6poJa+Op5I88AUCOLTRKIlyrM3LVsJFAPBfkhdhX5hjchhHyp1jrGSXQP3o+Em9PNAWuckA5OHTCg5HGbOxCWlKpDBSyFcE1DJ9E4zZgsav7onfwclQu1L//a7Baaiah54mk7+SxjT3/wAlc9u41S00vJ28cwoSdaBm55zU2RqS6fQN6YZiXFo4Oao4lI8z/yCb2e6WL5WxYErww2e/ggAdkVDZ4Yr+uwNOLY03HLqDZhdMIlsil8LfhcJNoPgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRpTkywSvs1F+63XR2xpPPTaoSTwfkGKSKqa2MKGHeE=;
 b=FrTEIiRLuua8sj9MA7cEIOeP9kP6RS+boid1DQPmQsBZPke66nwPszA14xtocDJmk7y940+B/bQe34QPQNqMtVLk8DcVoagSkPBzakHmbq8OommxFiyKwg40zIIz+NVbp/w0gWQX/wORnpFV/E5a5KGtyCpm+TXVKQItErhKvK62zWCXPqsP5BOxng6bYra0o18Ij4BB+yWYcCoHjPcN7koOjNuIKyakH+hDLIXBvoVhxhR2bDHphkr8u0PTwfhmDoFRmAbZOfMggkr+vss3AIOxfhnb1zr2qT4fbE9JE7R3d9JpW5z5olRXfij1wXhajxPBvWpmgwOKNkz2/KA86w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRpTkywSvs1F+63XR2xpPPTaoSTwfkGKSKqa2MKGHeE=;
 b=KqX05NktsQoPzDkc3C/NlRhuWdvgm7GbFVPuOXa64JZpJUYL+5AQFImklXnrkfPUfaLu2PKvnynP5WxfLr2vwpE4TG/gx/VWbEcb/L9AYxc/ueCGqZhsQ9YgL9DXS+i68XtDVTyg0zf0ZdPviFuRNpYj6zxqrIZp4kWA6pwC6APde9G+/x2X0bM2vZCxN+AmmQrZiRKUXnzhsmezJJrOhG4vkiPzP/L/Zxns2aPSVHwfaIkvaNMPkPBjX4eoAeBcBejAWIWFkInlx4Xv8NyDbanza9/Jop73azAzPNio6oeCCNIIm3DLNRsfcn5WSGw2HDsPVmUrthlkUnL41Xocsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Wed, 27 May 2026 22:17:02 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 22:17:02 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH v4 9/9] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
Date: Wed, 27 May 2026 15:16:31 -0700
Message-ID: <20260527221631.612026-10-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527221631.612026-1-nathanc@nvidia.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:a03:505::16) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bda5f7a-f074-497c-041e-08debc3dac26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|56012099006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 3tktWTsQ7c1CDSddDvT6G3XgqAx8NrVoE7+wZmCqlIouMFfT9AkpZcFM2DpXdr4c8S45j3uosa/Hs9rUY3ZCDkiUqW0OuD/tcVcvhHnLLRjDNYgRsdySPqXsPbS2Y6rO8YPrjUobll72FvCQo484MHEOVNQYgtwScuDM/NrsJnabm5/DtXk4b5pcN8ihE0okIEJrUXXlR4REEEi+ViTK1vxlfNjvs+dsg492+iBcyu4UHrr+0EH/h+JuCdXWRTs1hlGtyqIr1RFqMYkt+6OytOms1TKlAxO9PrrhNS8DVENdXwriZVwi7enRYiUg1TWFjfNxDwmfLU3Lk/jUM5dc9dYo/bC/fKweqCnUIBXRaZHjrzvKB09gRs0N46LUS7WNm8w/qdjNhCVXfgjJY7Gyx07e1asbXysGMCx8Awp5BLjXblXcTrFjqLOX4edH2K7ccYYY1w/K6TcnxJq+xlSa/VnKA3btOMON2IVqY4/zAcHglAEr9E68M8jOKVkN/BOyIS/fr+5XKKMXelyJeWe8rCezOk6GkyYJYQh5/O7dSV+PGASKWG7fAO/7K00N0H1DvrAKVsBsOTYfFfYkiRNd0CDbKy4cebF1JsqgEB3Rsr9A5XdMCmD0h1Jca9XsTa23PyN5WZ4wXR4E28Rjoe87cbWEfNwPOMH813ygXarMwf3GHv9ihBFkbTuSk+J/5jzr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D4b+59+1xEE10ljEsjqh7mUb7uaeYeEJbKTnZaI2Fc6kNj/aRvN9AbZok8Pb?=
 =?us-ascii?Q?t3VUpwGti18Iu2QtGToJHvXBZpgyVk0zEufMM7MMlbf1QSmjct7hMdvVPuWK?=
 =?us-ascii?Q?wxWHQo0QuvtZrhiXvg0PxTGb6uW59A+OIZNoZoviFtbNI5WvafexJlNfCGou?=
 =?us-ascii?Q?UFGOBPMWeypBCpyhKW0QvCswj58uQH4CGNRl9bEzVja9dFyzHF/fkVNedOyZ?=
 =?us-ascii?Q?jz+TvEKkHojgzECIhaFOvlggBQ4OvOcW78yiem1zTbz81pFwZF2OEnf6+ckC?=
 =?us-ascii?Q?OaLd0sj0C+B5t6D3/Ewnc/g/OUTRx6mnY8/npGyKCLT48r5lHE9iRiT9/ASo?=
 =?us-ascii?Q?LxhevUzfxDCyrGxKX/1R9rC0KUckSxiWc8Ln8owXCVvE06TizUIq/ZNlMqnA?=
 =?us-ascii?Q?sKoORc7RuB4zuzZOl1Pq9Op6DYN0yf7qblv4uqyn2XuVS+PwdCffH/ksPOcL?=
 =?us-ascii?Q?SwcxwS52eSzo54B2vviYdiFBBky6dWDdGs6Dzt/G2MroaYQRg4qDBLtYi5GG?=
 =?us-ascii?Q?OE2qhN55Qzenp7Mk96BBiDfMJFQT6m2M+VopEqHvcMk1VjwOf0940QO66WOt?=
 =?us-ascii?Q?jLR5F7VNLxrUkEk3b/L0JYwf137cmmoRlsf3mcDb88TlPTLKwt2DmhM2O/oZ?=
 =?us-ascii?Q?hdc921Nq4y1zZDaFU0ObttextZC1hig14t/qHDwG+qTaVhgh8TMPNLLAmBFB?=
 =?us-ascii?Q?b4WFRhhRFVQ2U7AmV99VC+cfyQGXk21q7Efkq8/ex0Lxbd0u3zTJyyhhivYP?=
 =?us-ascii?Q?5e5TKObA4/ojj8gzhpy6GhtBgJUql/bbsvb5ilXqq5c7CixE4f/85xJtDXS8?=
 =?us-ascii?Q?w8OR4RL8bA+YtDYC7Xr6y1ETLOeTG+6JLC9Kqi3KDcwLG+JSf7JbleAY0kL5?=
 =?us-ascii?Q?kHdOJ9KmpZ8Tc67JRaewDXAV+7ETkDlIG1Ls/6s263TdtXgWkVxcUrzbLolQ?=
 =?us-ascii?Q?+nlYwP1rUdogQhLr+y7W8YIgJtb58oKCjOEqTvX/ZdEBftUmMa6CzhQMzMrc?=
 =?us-ascii?Q?UEWVk53CszCSi5ROC4iHjl1E/1uTj/7vLJ64KcvboG8NjA5H6I1XcRYGZpU1?=
 =?us-ascii?Q?IZM3fk4IAskcEaQiesO6HjBnljAQojq0BhsFfyp1n6t8T3XRmV0mBeDGKBTH?=
 =?us-ascii?Q?OrTMwON9Klf6kN7z7eHinC64XiETjcBx5PK3g6uKX6oDr+/9rfOjZ7oZULhq?=
 =?us-ascii?Q?6J2ogRg8vvyaaLC15GDTE99V1HGd7lBW/fYru1QnkbAAUYsUpOTboqYPPXN7?=
 =?us-ascii?Q?J0IHd8dWVPGv/sy7pvFa2d7eIuT3swxWy3pF5A1krGanG2cXXI7L8RA1UaKQ?=
 =?us-ascii?Q?zG5jCqb9rQDc8LJU9SizKqI1122mR4v4Ynht8JY19dW8fnZASuKGsZxV9Bjw?=
 =?us-ascii?Q?L5XN541Qa0o7Nlt1q7TfBlJwEkUXqLQlEgQvGIriHobUnFZxBYuCJVDryDXi?=
 =?us-ascii?Q?+VRDusHcZn222yMQGcO84m5W3wPkwbFRXtDF684WnG7jroM3Vbk/O5UciqeE?=
 =?us-ascii?Q?LQ/GpoTGM7u061GdfhNrhAxptQ9A1qR4Jv5oCgpDXHZF1xWOqfLkntfr1YMh?=
 =?us-ascii?Q?H208RMNffgbkaa0CNpA46q2WsOayqBLW9m6Mt0UF2+57HivrYNNshsnH3uHP?=
 =?us-ascii?Q?U4bZmQ0W/H2AsOlvgzjyLoy4kUd6WLICqUz8fLfLpue1QVMo6krauKUHVbaa?=
 =?us-ascii?Q?vOVKFeeSCc1Hc1ONhZpBkZ5mCge0pjch7SAjK/ftLWUYwZASIFT5FH7XoytG?=
 =?us-ascii?Q?rtImKIUL7A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bda5f7a-f074-497c-041e-08debc3dac26
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 22:17:00.1633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCWectVDOEzuQe7pvfjzZZPl7ZiXJnf7esyfbJpKwrzUc6HVGOCjDCL0qt1BxaqF71Ok6JTsB0ITZaKkPQsxyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=nathanc@nvidia.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Update documentation now that "auto" is supported for accelerated SMMUv3
properties.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 qemu-options.hx | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 96ae41f787..d7e48688b5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1291,31 +1291,44 @@ SRST
         Enabling accel configures the host SMMUv3 in nested mode to support
         vfio-pci passthrough.
 
-     The following options are available when accel=on.
-     Note: 'auto' mode is not currently supported.
+    The following options will be set to auto by default if not manually
+    set. When accel=on and these properties are set to auto, the value is
+    derived from the host SMMUv3 capabilities via IOMMU_GET_HW_INFO. With
+    accel=on, this requires at least one cold-plugged vfio-pci device; if
+    none is present at machine init, QEMU will abort.
 
-    ``ril=on|off`` (default: on)
+    If accel=off, auto values resolve to the non-accel defaults given below.
+
+    ``ril=on|off|auto`` (default: auto)
         Support for Range Invalidation, which allows the SMMUv3 driver to
         invalidate TLB entries for a range of IOVAs at once instead of issuing
         separate commands to invalidate each page. Must match with host SMMUv3
         Range Invalidation support.
 
-    ``ats=on|off`` (default: off)
+        - With accel=off, auto is resolved to 'on'.
+
+    ``ats=on|off|auto`` (default: auto)
         Support for Address Translation Services, which enables PCIe devices to
         cache address translations in their local TLB and reduce latency. Host
         SMMUv3 must support ATS in order to enable this feature for the vIOMMU.
 
-    ``oas=val`` (supported values are 44 and 48. default: 44)
+        - With accel=off, auto is resolved to 'off'.
+
+    ``oas=val|auto`` (supported values are 44 and 48. default: auto)
         Sets the Output Address Size in bits. The value set here must be less
         than or equal to the host SMMUv3's supported OAS, so that the
         intermediate physical addresses (IPA) consumed by host SMMU for stage-2
         translation do not exceed the host's max supported IPA size.
 
-    ``ssidsize=val`` (val between 0 and 20. default: 0)
+        - With accel=off, auto is resolved to 44.
+
+    ``ssidsize=val|auto`` (val between 0 and 20. default: auto)
         Sets the Substream ID size in bits. When set to a non-zero value,
         PASID capability is advertised to the vIOMMU and accelerated use cases
         such as Shared Virtual Addressing (SVA) are supported.
 
+        - With accel=off, auto is resolved to 0.
+
 ``-device amd-iommu[,option=...]``
     Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
     Only available with ``-machine q35``, it supports the following options:
-- 
2.43.0


