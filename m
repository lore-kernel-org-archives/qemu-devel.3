Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75F8FEDA05
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 18:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ZJm-00046X-Sz; Tue, 17 Mar 2026 14:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJk-00045J-6V; Tue, 17 Mar 2026 14:39:00 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2ZJg-0002xI-Kx; Tue, 17 Mar 2026 14:38:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBly+on6IsWiVpJNjVPwxAwwVhSTwYp0W4Xf3jt90UszXi2MfCkq4HhbKx2e9Hsq9FpV1WPPDWsi4c73N2V+KZ2GbAIefybbs8Vaz4pshQFcr9vr4mWEPyqbOoMHt1DD9TtONKLlwUo3ccZqLeqQYzsrgq1WAyE7D8a2AMaDt0ucVSlqkV+VYp/4GHBfPIxpbmBzgGb/fXhm6NJcGSe5PDcDqe5FjLC0ZuSea7967PE+J4ImrvPvTNhrxjAlb4KljcT0XVaw5PbiSo39G7A3vRjs/gcRipHFt2QerLLKVrby++28Ic8pYa5/hE0uBuQOgHEms3Wbhkx9S7GmrpmOgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG+2H53YN9jdd3s7fipu4DxkNVL/TwFnA7FwcbyOpeM=;
 b=DnFVgKI7Y1JDh4eVxyOIuMnMXuuFHOYS/NPt/N/gTOZjV38wMsrxEcjEjTvzmUZGPaNiO/6l9cuLZAtjIfAlFwS+GPDnRuCE1uoEtEOMOyLGlyeScPBwVtUKkQg7HRj+4GefG+h4fVmXs1XZvrlgmm/X6l1lJlMIkuL8O0360iilwPr7217omdr3wl1cqtTwvLuRQEi5F/UfwbWICqDsDCihlxIGYYTWBsEU6u+M8Iki73UdAN0FtSmd1BXnwqb/fFQSDv5CQgDhwGPcnJziTNIYq4wgwqxMUNv5/fxQjxsqBc0OhXHEPPYqw9y+SW0NTRLHB09Rc2Gt93Ds0Jh9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG+2H53YN9jdd3s7fipu4DxkNVL/TwFnA7FwcbyOpeM=;
 b=t6cQ1AY6NDP12NS4TzMfQYEVLy5fN3Gl08hDzciAgLh81RqE41icArc4jDKB457/ZymyuFi6MstGST7Dv1aYZj1PHLggGu8ToBema0LSsLIfwzj5om/rWxRGefZ46fHCN6YCmml5tKJSmr+qXXZkC+R2XmKK22iQgQXYQR0MdZyTK69YQ+apV44etWXboPZclLhMyetIhdVS9cyblNy/LPsdjFFeLrU/uVpA2E7p1hBWbYcHlGzx5sLv07cPtg9EBKqUHySbYMg23xwMszIaA1CFXTG5q0iySJpQw5IQA6POJ9ef4ct/IWQWAZZF2zgr64MA/pva8mlCaNGW+rXGfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SA5PPF06C91DA0C.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Tue, 17 Mar
 2026 18:38:40 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 18:38:40 +0000
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
Subject: [PATCH v3 8/8] qemu-options.hx: Document arm-smmuv3 device's accel
 properties
Date: Tue, 17 Mar 2026 11:37:55 -0700
Message-ID: <20260317183755.3721625-9-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317183755.3721625-1-nathanc@nvidia.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:a03:60::20) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SA5PPF06C91DA0C:EE_
X-MS-Office365-Filtering-Correlation-Id: e44e07cd-6366-43e3-9640-08de845468b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zJ82v5zkHAucdEcFKtW6DLtMc4VWov3JPpMiVNsTrmMGkgvDFEq7YyRYtFaTHCCCo96NtDsNYMa4YVnsGkw90nsvtg3V1hr0HX236mB2UO5uA0epTjYqRwedGKvIXfrZSRdjWVprK5OINZkj5vSngLm8j68yNgDau+3/i3P1+K2XPXc3U/WYC97CzANtzW03eFPO9rbLsueIXhBoFJrz8TWEB0lZ/a2zxsHy6gCKY46UOZ4WOdKhXCW3yYJE68loz3QAST+YjlpgoE1oSgS3qzsM/AYK4jwppBeVdiMl9JiQ85H6s3kr6yileyNdwPCY7btB4zkiq0SXDymS49aVvarTUXWudPqgMoZtTN4c6nfqjkPGnAaRN2KhCO86k7zwTOVjZrfkK4KJWNsL6b4HtOWOemGbOT5o2xR3jFhIZk8kiKM/o3P/H/VIbpnD2R5NTWQCllUOtYtkVRlsw0Kk2yofjm9R3XmWC+VDm7tbCLYQJwTYMFepq7nEMYvem1CIgTGJl+1FjWKRisziIkeoDkZf55/sLRrGTK08kPkEzbc3l/moXPL2b4yHPW8RittMx1tPi5pajdBaMHIRSmnEIOOGvftm9gZw2BFMLFNfJWL/mYbDv9E1+1Dp92Evty4O6l6sek2Ev5EW5jr28I3gobIV4At1LLjaRM/y/eA4g7PDoa593EAdvayGgmkx8+E79btIkQaS/xzGpZqFtls7bIMqeKrXRcM1vqOs9cUErHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mP0LPHfb/WhnruCu/HaUoEFAPsxHhR6NMYofyrJn55WV/OSvRM/nwdgZojeW?=
 =?us-ascii?Q?1HtVd+VQ7sqPV4P4xE1Pbog87fJgrCWGs9myNXkE7wMMsH1wqU8AUoy3+jeG?=
 =?us-ascii?Q?d5KiaHFZanwR67ZE3Acb3HJx25jrhG2hPSEG28rQEAwFDEUrVKSmIkSZyZkT?=
 =?us-ascii?Q?94+H7hEpbLF7H+ZnilqXbhzNS0ybEQgIIWUSGP5AA2LndtBXmgnKTRN5BXR7?=
 =?us-ascii?Q?uYvBRgMaMG5/0YWlV8Kd0glcaMz+L9K9dpH/9kF17uOh3lv5KS7TcOczI0Fg?=
 =?us-ascii?Q?voh9mkzWbWPApaLJnqbi06xEGmeQo33E+QW1TgznDm2Oeu5BNYyoufKGOg3j?=
 =?us-ascii?Q?z2IfP+PsP6d24TGHzMk640Hsl6ZaGUTjDimhvmHijeggD4hDpAuRvyO7Qlrt?=
 =?us-ascii?Q?+DI4JWvtVtSwJIbi5/QIjrAEOIdj9tbZKZA7WSS/ymR04KS2ulGUgkui4sMG?=
 =?us-ascii?Q?LvxPj8gUG8dUYqKSwf2Hr4G3Pb9P5gOYc3zNu0ODx7qYC7ackYIrxxN+Y3og?=
 =?us-ascii?Q?30IU8Ci2OGjePcJSQviD4uWfbZqlWw37WtVxMtdZkkF3pbd76/L9H0jzmWN9?=
 =?us-ascii?Q?c4sj/ef0wAviQ/fLquX1cYlQRrDlJJdpXqjEwUIWjAVrICc+CHk+nWmCO33H?=
 =?us-ascii?Q?ZxElW5il5kIdH1e3M5+c2puMIhfIFS2FgS0O/h+YHY/qATa+9vKsRe6OeLKP?=
 =?us-ascii?Q?71JIJ+mN+kX7J/J47kAvw255DunXpmc9nbFiYm5g4TWXESRfkeyEx7o8Dbgb?=
 =?us-ascii?Q?aditDUvhVXnWLGlnKwLn48iWyD9lYQM50JpBEsZXwyQmJ7jampk4+NNdgMnw?=
 =?us-ascii?Q?BKdq/Qn5QleHtErjWuRxWdW+03HtPQXHnCGudoYHw6unviWrETQIp5yPzzIH?=
 =?us-ascii?Q?U+UfC3iqKaJ6rIJmoQxds/Su96pBW+WWg4xu3p4lZLIAlfkDF/O6Ec37qp5l?=
 =?us-ascii?Q?BCbZbzooKdopYkyBB5WCkXenfViLmI4Y/c7gent8Uzkn77TvKy39BvQbHMVZ?=
 =?us-ascii?Q?DmCIbCYBbqEXwl797/QTTGdUBwMuArt4zSUOmQQLhYmvF94FyFjbzZxbxcit?=
 =?us-ascii?Q?sm3FAn2OFNlVSwnnQ3tpY/iMw1DEFRbWha8ALKOhA4kSSBUbexXO94ed8rnt?=
 =?us-ascii?Q?P70kVYdHk8d9suIcmcWVu914lQGSBvIOdDA3yLHoVqPNtlkSHmNJl0SBbUal?=
 =?us-ascii?Q?9rt3imgR0dphGFeF7KfYsUfjdO0axabLt/jaAewX7rwkO+hsfsyJZi5jA9HN?=
 =?us-ascii?Q?2kPtAZUox3LUgjwSulLuLTY7X3yz5h9mkW90xforUR7tdz0Sigd9dUvxLFBB?=
 =?us-ascii?Q?vuJqAWuyCarx+O25NnukDmTHyqwHxwCB8yh0+yvi86bvZ0wcPhlKL7pavkdU?=
 =?us-ascii?Q?h3qgyna2wqXwS3BHS5xYy+8olD8Z0GMn6vK2fG8oIeGaozawOha0RVTLPhW5?=
 =?us-ascii?Q?oKwUL84h155t7Sj3cvKsougI7uVlJFa1gzRnoY59mJR2dq4CtCd/e0ofjXak?=
 =?us-ascii?Q?LSWL9yE0BydFvjvG9SBu4RvbVu014bYOCYqzcKdFvbDF9q5eS4d+y9hp6W39?=
 =?us-ascii?Q?BMeg5cnR3xk7DsRffe1tkRgy7z3I4QzA42me8f2f6iZT++9bzt2eCS5A+kw2?=
 =?us-ascii?Q?LakH+MU881+a/MfKkh5FGQIUB9xFNIupyBtQG5UOBw9VLs2nB2Kr9NJkr9UH?=
 =?us-ascii?Q?xggxHfDJiOpntfjxUTsSr0Bp+fp9MfibvrgT6xAN9XTUHucQjy31CUU46X3U?=
 =?us-ascii?Q?1tSCSGUZ7g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44e07cd-6366-43e3-9640-08de845468b5
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:38:40.3495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Umybkf/6U0baqnpn4M2F/zh60WS9Bh3DdsiSjNqFnKTkxarn21wgZDcZqcAsdmjdlkviJguMFArBUSWeD8EM1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF06C91DA0C
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=nathanc@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
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

From: Nathan Chen <nathanc@nvidia.com>

Document arm-smmuv3 properties for setting HW-acceleration,
Range Invalidation, and Address Translation Services support, as
well as setting Output Address size and Substream ID size.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 qemu-options.hx | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 69e5a874c1..0ba8322695 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1279,13 +1279,46 @@ SRST
     ``aw-bits=val`` (val between 32 and 64, default depends on machine)
         This decides the address width of the IOVA address space.
 
-``-device arm-smmuv3,primary-bus=id``
+``-device arm-smmuv3,primary-bus=id[,option=...]``
     This is only supported by ``-machine virt`` (ARM).
 
     ``primary-bus=id``
         Accepts either the default root complex (pcie.0) or a
         pxb-pcie based root complex.
 
+    ``accel=on|off`` (default: off)
+        Enables guest to leverage host SMMUv3 features for acceleration.
+        Enabling accel configures the host SMMUv3 in nested mode to support
+        vfio-pci passthrough.
+
+    ``ril=on|off`` (default: on)
+        Support for Range Invalidation, which allows the SMMUv3 driver to
+        invalidate TLB entries for a range of IOVAs at once instead of issuing
+        separate commands to invalidate each page. Must match with host SMMUv3
+        Range Invalidation support. Only applicable when accel=on. Setting
+        'auto' is currently not supported.
+
+    ``ats=on|off`` (default: off)
+        Support for Address Translation Services, which enables PCIe devices to
+        cache address translations in their local TLB and reduce latency. Host
+        SMMUv3 must support ATS in order to enable this feature for the vIOMMU.
+        Only applicable when accel=on. Setting 'auto' is currently not
+        supported.
+
+    ``oas=val`` (supported values are 44 and 48. default: 44)
+        Sets the Output Address Size in bits. The value set here must be less
+        than or equal to the host SMMUv3's supported OAS, so that the
+        intermediate physical addresses (IPA) consumed by host SMMU for stage-2
+        translation do not exceed the host's max supported IPA size.
+        Only applicable when accel=on. Setting 'auto' is currently not
+        supported.
+
+    ``ssidsize=val`` (val between 0 and 20. default: 0)
+        Sets the Substream ID size in bits. When set to a non-zero value,
+        PASID capability is advertised to the vIOMMU and accelerated use cases
+        such as Shared Virtual Addressing (SVA) are supported. Only applicable
+        when accel=on. Setting 'auto' is currently not supported.
+
 ``-device amd-iommu[,option=...]``
     Enables emulation of an AMD-Vi I/O Memory Management Unit (IOMMU).
     Only available with ``-machine q35``, it supports the following options:
-- 
2.43.0


