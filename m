Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88F0C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WZY-0003r2-Aw; Fri, 04 Sep 2026 12:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZP-0003pk-9V; Fri, 04 Sep 2026 12:15:15 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1x2WZN-0008SI-Jh; Fri, 04 Sep 2026 12:15:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuqOjV1TTnhP0v6PSiiuzhld5rskt4RqKq8xAq/pntpts2+4g0szv98OjPIbDL7ml4IWYFqGc1etD8oh6/E3e5h5AvDzQagAMsjz7fF2mResGFD8qEPCWHv82tXWwxUavfbGlJHsnsxr6bnk+uLglsdn8n2bCYwTvh+1dNuSJKuZHciSXFPIxXcslPo99eShKsmDz8FSW+oAbz4LsCEObnOveTFDSVmHGR4MAtT0uTJ8+s2R/GDr03+tv8tmo923Q+rSH9mlF72HM7+6qiGKunJGxcGeWvznVqeUsBabfzCSYYNu51Ts55tBIRPz9d+p5bCSyrqiSjLYi1eV94KTjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RfRBjO/Q/kLresP5/KtJ/NLlw5Z5auJPVHgTReUN0jI=;
 b=swQF65AOOVgnZ1vInOLc2jWTon92Y4gTCWovPsJMLJnoXdx8UHEpnTlTe6mp7ltcQTn84g1hTGTzjS2pNNmGbeL+37iPWnk8FByC5D0H7MgLSQORF7SQNGRkNmBHPP5egJaCDT8NsT5jhqlJ4O66bRa0LB0HCsqHNcMEX7hewnlHtW5XONAyNUF7VqaZmqwzCFb7cUhnZGBySjQiXTRA+2Gjy0S3kAeE2+zAdEM1hh5ZHJrt1phlBSkc6n8/OtK+nrWQfoNUZYcsFiQXEgsbByghoUEpMXTtMsq+rmtgnIemXV7NGOk85BBoor2F7TYvQTM7qkT+sjOhQEGTiGgfzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RfRBjO/Q/kLresP5/KtJ/NLlw5Z5auJPVHgTReUN0jI=;
 b=RdLPwBc21FB2dvyChengI0CYwBuAolNTy35pdLp7DdjKyYek6KgNBeM3AGH6L9khBykp2Q5kriZ6qdyn2ZOvOuPTejBxaCLpuqlBtddu8ISb+dXYSWsma99Gj34/8H/k+xvgkIp5NUs/AkNtsVWnspWwR1vf6gkyW2MvWVtbXlNfIUNd1wt9GW9XSM7o2Ix/QKqzKhQn7CB9mWXB+FyvnfJ4HyZYAXxTPe3/tgciqwHyLfqghkR+FHKlkSWP9d+6rIhiPknY17MV7SFQCzsmuzt+LcILQZFv+w7eYmBuNHEp/o5+KbnlzxaZPIfE/ahzAXB055p/2Vx2o+lBcP3bzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by KU2PPFE04A6CE19.apcprd02.prod.outlook.com (2603:1096:d18::46b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 16:15:05 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0382.007; Fri, 4 Sep 2026
 16:15:04 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 01/10] hw/arm: fsl-imx6ul: Add SCU compatibility window
Date: Sat,  5 Sep 2026 00:14:24 +0800
Message-ID: <20260904161438.3838261-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904161438.3838261-1-bin.meng@processmission.com>
References: <20260904161438.3838261-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0120.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::19) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|KU2PPFE04A6CE19:EE_
X-MS-Office365-Filtering-Correlation-Id: 5895cdbd-33d2-425b-d581-08df0a9fae30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: jHgx2FJJqT7CvSxpBSJLRo0sFVoQRbGiIxuUddV1G1kyLC8qbDIcWIydnrMryTrC3N46LPB1SDxQAgP0YCagtT8U+3zvdJKJebwWFIvmChndcoHn6bYwu2SiK20leXI21wcpa1czRzv9BFtUTzF7M2OYUjZrxhkHsQ08xcQi+yAKHckqopnBK6KmeN+E2NTiEv/qHF3DeM0+RlZr7FFr2SvzRGYrgbtem81SBk1le4HGQXR8AQcTx+Bj4u0hviNwvIcxuhcrsB499IG9Az9xDxGXgpu6Q3XnuM9TcSzKKbAvQWjlCu37AmGeUqCMTcYrCUrS8VTPUFvjvdxhMybAmyN/iX1i0Y8NU0rDt7P/LL0iVZjwdSdp1I0F+QNZDxjGZgT8RCCXRqChCqXEBdTKyAey22HUZFjhSSWOCeP3sLHSlb4ydH3xWJ6hDU43nNC9eUzZF1XATvlx7gLkX57CsUXNGEAbw/Eab3i53OrvxMFrjuLJXyHJE7+zyVJ+4rBnDbdIyDZ3dmPbVSUB+NAJvKWs/ciRz18dhwpabTzF803BrDTInz4oHPNYNZseoZL38MQQPU/dadnqfQIAWWvAwMVlqRBm9DGr+ZI3e4dTThdzLkNiYP0GBrWJG+C9JMrWWl/zKJe9YHS5POLWACBBMb+jxCrytitWRCw9ikD7Lx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9HePDpdxMpZja19X2ew1HmuCNtepvI0WeYs7kw0oeIeUgmmDf605bA0mLh5n?=
 =?us-ascii?Q?zwwPexQnaxuy7aETVtQQZBivKmU0vXkLZvJ9zZVKhEMdXFw/HiWfn9XOJDpt?=
 =?us-ascii?Q?GiWt3jaDB6CzQanXD5nyAjBHmniTjk+Vck8VrBHkZ65Oq4ExM5wIDfqD0XBd?=
 =?us-ascii?Q?p5EvDv2VJzGq7RREmo2cqre+2pXWoN9VnD0+s+lVI5ecV49j6hL+Z7T2oHQw?=
 =?us-ascii?Q?FZIln6jiosmTXr+K8HNo/YaYMPlvE58iJr9Q+iiv1j7BB2Tt3p0Hgg7IgnJq?=
 =?us-ascii?Q?quYVPLAUUECAvqLLZ3xmlPenKMb2fYf2A/uqA8Ji3CS7qVllh7cXpLyCKi0r?=
 =?us-ascii?Q?S1UH0Qydg2sGZz+M8vCdYseACeqFknGtHhXueeIY63IHzusfMSBXdw4W2Vys?=
 =?us-ascii?Q?+QW8z02L0o9fyrZD6BQzgANyqUfR+kuu9H4hXylTlpWBnoaB9udl5sczD37t?=
 =?us-ascii?Q?/E0UN6ow0lcxmJjmNwidzeLvJrsT/M0Owi+wZf/zEaMtQMG1eQ9h/uGau8Qg?=
 =?us-ascii?Q?t8QOyuMdn7mfV4K4IeTuxOh4zLr/PDxmL3HugDuSt406pXme0c6GzoJml2Ny?=
 =?us-ascii?Q?NIhztJ35YUyqXzRRKzhVinEO7pqVvaNB9Ve4VR3HwSrd5yW8mz7jbObVWUFq?=
 =?us-ascii?Q?V2oT/8qDxuKtI6sl/m2cxYj1LFpBf4B1CXURWui6smpIQ5YpSe7XaM/TL6MI?=
 =?us-ascii?Q?Go1S+lDZocFbYx3u4WedupfsPE4gbErxBGfqPnAyyc0azp9iBhA977eMRKZx?=
 =?us-ascii?Q?2ykAvMF2AYAZ2w+WBA/vM5pUgH/WVi3tCzWtc/eZBkurlhFMH4bjieb6i+tg?=
 =?us-ascii?Q?vYW3MPYYNOK/kd89uJUxuFSZzFj8ncKR6wLVMCBi4aruOt4YEegvAlJS99JI?=
 =?us-ascii?Q?/Ax1KbJUHxcCinBudX0Uqk5WFn4oh9JlOK4XFGapAeNQ3TGgQkJ/krbYcAqb?=
 =?us-ascii?Q?earZQZ1wxK9Hbbqa1cYyoK4G4h5Jw7UyWf7ArhEqD66rfuMeBKWHyV4SmozU?=
 =?us-ascii?Q?AV1RaP1YYugi8HYb9xuMcEgPlPFeWKqT3mOjuoiyZ6bEedYFcgrMQRFP3Bck?=
 =?us-ascii?Q?cT9nf6WS1lliylknqVTYdeIrc7rkpFIX9k3L0aIno1ZafafKK997IjBDigmu?=
 =?us-ascii?Q?TZc1HteIn9m1wKfreZLrXoFhXRHEjU2kvw6KZCa1tHqoj17cODeh0uzdpVKl?=
 =?us-ascii?Q?jNv48SX10q6wJdrZeFntCViN26oqdwpXjLZGKL6UiZSDL/rdMi7GVVWolyPp?=
 =?us-ascii?Q?9yEstSr93sNbCdrrsgNSDxErr7IXg2s+wS/OsOETaWX8h6znOXlAcIoDVw+g?=
 =?us-ascii?Q?QXSDLGuZ8VQR9wbcRfyy+YWlSGp5W7n9FE+x1JPseFfz7PXxDStHYr5IY/yT?=
 =?us-ascii?Q?OjtxNDBj0Cvr6o/BrtfHmCDWvcHr4LV30ChqKJgqwGTWOD+gjKRZ1QL6cqww?=
 =?us-ascii?Q?yCnRbHIytfyoau3pPDxncB+PYZ3G4g9heCQJ9xcDzaXv134n/Fj3F0f3sAGb?=
 =?us-ascii?Q?RU0a3gHOPTThRaq05kYMjvTd5MOblHvM1ETnjWYd/4Rwfxy3jfgX1Og3sKI5?=
 =?us-ascii?Q?pGfGUxwYH/53+Gj1DC/a/01RRldQDZhq20745mUc/5SZb7jCxiySkvdpkpFy?=
 =?us-ascii?Q?k0ql2AwdAaeeUTNCG62RQi0dRfmO2KXVrBEBPDogAu1D7jQ12REQAY8+JQhN?=
 =?us-ascii?Q?aqVrjOjz4IfOdg4x9tls8eAFf/hphJ1iHcfcSeYtyRav+jAZfJRCr0LFGH45?=
 =?us-ascii?Q?y6Oavmd3E7ZRxV8+VKYjnBc88z+EjQg=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5895cdbd-33d2-425b-d581-08df0a9fae30
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 16:15:04.9167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TTqAaBsND4Xu8wznjuLy2pO+sE77YAP3MDbbSm2OoHQVnXHZVFFqZKZpD7a82jE0qlIlXZZ8QzsMR9/B2ToDDZlPEP/G6D/kTc/gnXfaY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFE04A6CE19
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

U-Boot's common i.MX6 CPU identification code reads the Cortex-A9
SCU configuration register at PERIPHBASE + 0x4 even on i.MX6UL.
The value is only used to distinguish Cortex-A9 i.MX6 variants.

Cortex-A7 reserves this address and reading it causes data abort.

The same U-Boot abort was discussed on qemu-arm in September 2024:
https://lists.gnu.org/archive/html/qemu-arm/2024-09/msg00072.html

Map only the four-byte configuration-register address as an
unimplemented device. Its zero read result gives U-Boot the
single-CPU encoding after the low two bits are masked, while
the remainder of the reserved Cortex-A7 page stays unmapped.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 hw/arm/fsl-imx6ul.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 1863558a0d..d6f662efe4 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -187,6 +187,15 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(mpcore), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(mpcore), 0, FSL_IMX6UL_A7MPCORE_ADDR);
 
+    /*
+     * U-Boot's shared i.MX6 CPU identification code reads the
+     * Cortex-A9 SCU configuration register on i.MX6UL. Cortex-A7
+     * reserves this address, so provide only the compatibility word
+     * needed before the console is initialized.
+     */
+    create_unimplemented_device("a7mpcore-scu-compat",
+                                FSL_IMX6UL_A7MPCORE_ADDR + 0x4, 4);
+
     gic = mpcore;
     gicsbd = SYS_BUS_DEVICE(gic);
     cpu = DEVICE(&s->cpu);
-- 
2.53.0


