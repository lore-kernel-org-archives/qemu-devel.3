Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD811C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 20:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWhgH-0002AF-Ov; Tue, 01 Jul 2025 16:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uWhgD-00029K-Re; Tue, 01 Jul 2025 16:34:14 -0400
Received: from mail-bn7nam10on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2009::606]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <etanous@nvidia.com>)
 id 1uWhgB-0000h4-Oe; Tue, 01 Jul 2025 16:34:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0wAmlyp81tkpkxhB03SyWXGfMeyAwv0D1CwOaPy+j8iAloDFXuWkS28e0GyPnRioMh8MLjZjJgCu3GjRztkynGg4smuh0a0eaEptOgt0COCuRuuR6Pbqg34pUwxE45qSHT9ENwtLNuv6gV56Wqxv+7/JuQphbzoXv1e3ez3Q/FhN1joevwG8oOhXu4iHxJIISko+mH198sA1QteV/vIevYXnruLj8DTRD+eo84jyWgElwHq6hhmkzqCk7wUyUwCIC83kIGZ+B47VJFN0+uBlCxK1t1BZ9EsiU15t2C6TZ07Iw8WLS7AaHegbJe7DeSKQUJoaRKhxVe9dWYCuLunSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDGk7sjDnmNRBX0Tbvlh7EjogFfYLcSTU2RdHIUs7YE=;
 b=nOa88C5ZLHUKNytO7PEAGDUmv4uek5W593lLwATGtyF6W6Sux2RPBLUUmD4YI43EctZd4nEdR3fJH49AVZUxVe62CGchV2RlVEvcSOA+2zsmlc0doTR2vosUQoplxF2hDlwu6XfmTb6Q6UetCddkgC50MBOh4un9RJzEOwY7sF5Ifa1X1Cg91EeO87mfGW82ysQtCKU9I2iUYkcRLkZw0AS2iLF8YVe4QHcvFj3tV2PWpbfeBnCatapobU/1W//njdQXqjx7702tM0E2ceWu4Uwe7BMPkmkUwlcWishiafPc7Rf36YwYvFio1NTsbBR0K/d1x2jf1doi0GjjWugS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDGk7sjDnmNRBX0Tbvlh7EjogFfYLcSTU2RdHIUs7YE=;
 b=RJkn+s7k5ieereTAor5ojzzw5VFUy+TxEnEdyhU6iN1Y/kIMUhr+tJ2ysm4bK2gh1LlFBW+w+Ga0YNi5J720HZvFH9c6n2r8wTR/7c1CLvI54mpj72wY43AxJm6JHSk5PY7lLN06Z8+h/PsnDLQzOhn7fGj35B15R7ijVGSOAvHj+4BIYlMBgZDxmRjI9G7PffmhdEn8TQl/arQSgfx5ED3+eVT4ETRudiZQoct65NZ+mcjOHUre4SYPwjUY6YQvAcNDeUswF4ZdTNxUSOxhLABUBASK7xuQl53WZCvGd9RuBfc23nhyX2/UIhnzEZuRig/qHIpLUOerQPvT43ABxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 by BN7PPF0FD1DEA27.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6c8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 1 Jul
 2025 20:34:04 +0000
Received: from CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787]) by CH2PR12MB4277.namprd12.prod.outlook.com
 ([fe80::8857:98e9:8b64:787%4]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 20:34:04 +0000
From: Ed Tanous <etanous@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Ed Tanous <ed@tanous.net>, Ed Tanous <etanous@nvidia.com>
Subject: [PATCH 1/4] hw/arm: Add PCA9554 to ARM target
Date: Tue,  1 Jul 2025 13:33:57 -0700
Message-ID: <20250701203400.71677-2-etanous@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701203400.71677-1-etanous@nvidia.com>
References: <20250701203400.71677-1-etanous@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::35) To CH2PR12MB4277.namprd12.prod.outlook.com
 (2603:10b6:610:ae::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_|BN7PPF0FD1DEA27:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d03dd4-5405-47eb-2090-08ddb8de9e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lG8TZMkZFE1QqHk45reKruO1Wp0FPQtygvWDHPngmcJwIeFkXEUPMvR8uWaQ?=
 =?us-ascii?Q?UNm2bFD885DcCJQTi1k+9BE7Mo4LF7iDHoQAAtLSZS3A+mH5Is1Zb0nliImG?=
 =?us-ascii?Q?E/PDL56f5v0oRgzCcwOUxAd/1l27mM1QKVkuPYbcrFZZcX/bsDkR3zEoEUbW?=
 =?us-ascii?Q?+/z0p2TnSZUsIBUWgAAWTgM5UjeTvvwS0BlY+FJsCpKpHq9vtdWwDU8IdIUE?=
 =?us-ascii?Q?Ca1Jz909fMqBUVHgMP0cWSPW1CWL+jHIrYfGuW2YIErKg0HQ4Ph/nsNqme6R?=
 =?us-ascii?Q?ya7109e7Z23bfu2J6PCA5BS7TT/1Xr0cOb1W+hSBkKsR1HPOiZImR98nLdqZ?=
 =?us-ascii?Q?uFQk9v/9J14UPjrMi4PfvkOxnbPzQMyj8IEPuhUq+68khhexWLQ2h6vXrJB8?=
 =?us-ascii?Q?Me5df98dx0k6oyAPqSbklzb6Y0l9oqSDD8IAmfisOe3qONK4ny46Dy+3gTNq?=
 =?us-ascii?Q?u7mu6Lj6q9U7vCMi8xabu9M1LsJKpYh1W7v/WS9RgB34tCJyweOSI1CkJC3M?=
 =?us-ascii?Q?1Du1XUdcbIqVBXH9cIaf+N48XSE04zZDb351U9JWwoPzn1VV0TXm/LTV6XxQ?=
 =?us-ascii?Q?G8/UbWEjHG0Su5GTgRUgBylmReeGsGn6lbhqE5zHdLx1foFcw8h1hcyUPrpC?=
 =?us-ascii?Q?EPEYTztlkuoA6qRQPkNKVvKx3439CMVvQHF0D5kNGUfOGhIUf/PVuHPkzrM5?=
 =?us-ascii?Q?Ypffu3cQIUX7XcUsvkmjhuAgw0buvk7vFQ+eao1M4u8BBtz8TU0ulTsOMMa7?=
 =?us-ascii?Q?RKYkxKbnwYIfGSM0S/uT+EyvVaTxWkQtu6xv7+2JMB69A8gT5Q5o3KvthOcQ?=
 =?us-ascii?Q?rYdm0iJRVbgveJn3qyom9ID005eiGGfJtKwsskKlV2/WWEsHyROj2bJfXLM2?=
 =?us-ascii?Q?rOl6a1q9Df21+v2Hd+W8JyT7i74r+uC9aU6c7VXN7WoW0xocIHslgtXoPiWo?=
 =?us-ascii?Q?WVdqoCurCFhn3ex/lb8iUHKO4B6prDYMl5gAByQvEz7D8w2OfXGnAHcIZCIT?=
 =?us-ascii?Q?UAadFBADGSm3Jz5BOrLokL7ROqf/WEgnSWShgNCEmbI2kyOFFYp6jLxGbsQ5?=
 =?us-ascii?Q?4hvzWFqi2XP4vY1Ge3yPKMxawUJZikw5Wda8svJruElKKaqy8lEldYJbxDvF?=
 =?us-ascii?Q?nxUIWLP9+6Nd2UqCp+Z+AZ67mIfM2xFU+73bccMtI/K4ugWA6NVRJC7VuYLA?=
 =?us-ascii?Q?0vG19glg5fuPIU6xzq4feckkSA5g+l/BunmAvcp1Eq1F8bM/m4iyUZ1i+kdM?=
 =?us-ascii?Q?ebK6Ezdxf/4PpZZhDIAxJxDvbfJ34EqXK7cLMZ1Tfkq0+XOWYvCyeS4uj7UY?=
 =?us-ascii?Q?rWgJ2gLeYljnZh2mBZk3E2YNQ6ja9IR+xLinj9aXjlRQBE10+Jx4ad7Bx5Sp?=
 =?us-ascii?Q?p00g8VSCWP35+8rzoyVueuJM/8RFlyZ1GD6U+9x6AyccmCGEaT1qkKPkl3Vv?=
 =?us-ascii?Q?8YQl02C+2lE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4277.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b7ud41ccmYT/+G0Nq4SRB/CuX9c4jlI7M/hxIJaAzQdP4Tn+nT0U3V8EQ3GG?=
 =?us-ascii?Q?TeVuJSeixTqCUA+y2ezg9ZafEFV+0hGvxIi/v1epT1S8SCTWpoFrPYhArAqt?=
 =?us-ascii?Q?GyiVCgacEVx7unahFGSu3yjkufhXfxqhKfrIuxlK6vSErxqNhCXnkHKT6ooQ?=
 =?us-ascii?Q?1HpU1N1OwVCCGhVYJVgTy+G7VeKPSp67efIiJMhRdB1j884KwkL+COz7YNTk?=
 =?us-ascii?Q?kRPmDImr7VBjnvastanJ9eufo0q/D0e9pa1nIzA/PVZY4BD6DtHw6scxg94f?=
 =?us-ascii?Q?ioTrOE3SyCfup98Zc/EOJeLiOQknJNlr2+kULyYozxcJbg6CQBizZFz5a2L6?=
 =?us-ascii?Q?qU4N6JKOwrLW5LOU+oHHPjjnKuCn/WvKchA3E08OwMEre/F4IeMmRSziCwoR?=
 =?us-ascii?Q?cvUIxo2LQdUb8YJefo6bM/DItjvIz71f/YDuFDX2I+b4P66YqdC/m3o8Hf9I?=
 =?us-ascii?Q?49kYX1CvygvEglvgOAiv40wy2z0CFBt4r4BauJ1+ZsMbpWNOXC1VR6QfHaml?=
 =?us-ascii?Q?/9Qgs1JH9DAkbN/42eC9a/cPLHn0Mxkv2SIa/2JWUIGlIWZcbOJX175gGiek?=
 =?us-ascii?Q?w0c+YFQo4gP6GFou+q4I2fFuoTzfWXCHxCXe3mWLhmGnokGp9u+KqTtC8Av8?=
 =?us-ascii?Q?6qypy1L2Y2+IHgknayA8B0v0JCQA6Lx9OwcLjqGxGoZqdI0bTkvugzsiZRbC?=
 =?us-ascii?Q?xI2y4kGRHZuMKHzUWaf5AS69lCFs1smpdgWSbqq27wJAS9K3rAIrpfZ0tUdE?=
 =?us-ascii?Q?O44XnN+thhQYkCCLWiSzY7iD5ePh3PI3HnAFFEBDC3Ru2YEyEy1WovE9VXod?=
 =?us-ascii?Q?M7relkf7KufuealPUVEWYJL5e2W6+9fSu1yzgSbGwZAIOguNFsTENgHCYNjH?=
 =?us-ascii?Q?/rGPuMTQqaItQ9DZsqh2akfPIDLz78MYm8K0f+WQiZIVjaI+CzpB3ijnnAMP?=
 =?us-ascii?Q?YoQZ0lEXp+Y/O+ekJyZyoOJhL9ffUUR39hfzCjtR7WJOv/1WSWHtkeUqrg0u?=
 =?us-ascii?Q?RT+etPB4X/+MeEgP/cNYqvPxFE6z5QBqhyf5x0xj3ghQhs/Hxxt4m83vXPqB?=
 =?us-ascii?Q?NJmy+MdjA0hd09frdcyllwh6hZh/reDYrd85Kh6XF87Wm+HmrP0s/VSt06cn?=
 =?us-ascii?Q?2bpMGTUhGl22Ygn4oXMnq/YFhmMBIAqM976Ix8ZHavD3RnKTpzHDAMCGf6TX?=
 =?us-ascii?Q?KVDln3K11wVIOjHToGtfclDqNPr1y96IQ1Eh/XkXmRZI1wuCfsgD8+SnVqNP?=
 =?us-ascii?Q?FVib6jLZ92lG9ahh6C3COXF6zGK0XsqrIkKj4Bvd1FdPPPZDXjrukW0rO9bj?=
 =?us-ascii?Q?pC+tVugoz84fmPqBnIk//PB1ytEFBmY/hWFviYqeyTYU0dGfpsurn0NVYs2X?=
 =?us-ascii?Q?dn7MB+zTsGfI3QlHT6qQe/57vg+gDpvT56hZWcIQdFjd73vYzMD2hCiyGWEe?=
 =?us-ascii?Q?lERCSRBbdriy+iLBQHLA5/TH7iERldSljisRapl5Wdxo9XLGM5n2GYPBZ6g3?=
 =?us-ascii?Q?NQMBI7bQrr4ij8sY2g9kA95jQfw0T0jodJ+GHRhKTu6oNQA7EnuxlmlbT1cs?=
 =?us-ascii?Q?oA66ZFQqdGFMOKjPetPVztwUaTl5YkDlPNXQzbv/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d03dd4-5405-47eb-2090-08ddb8de9e8f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 20:34:04.1762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYaPjVNf8cunYmmKyvAM+dMwhiHJPa73HCgOmJg+mGX+F4xWgdpB+XI4nKoWMflcmV6YapHWqD/kTdcE9CSf9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0FD1DEA27
Received-SPF: permerror client-ip=2a01:111:f403:2009::606;
 envelope-from=etanous@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

From: Ed Tanous <ed@tanous.net>

There are arm targets that are connected to this io expander,
specifically some varieties of Aspeed 2600 BMCs.  Add it to Kconfig to
allow use.

Signed-off-by: Ed Tanous <etanous@nvidia.com>
---
 hw/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index f543d944c3..6ea86534d5 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -532,6 +532,7 @@ config ASPEED_SOC
     select I2C
     select DPS310
     select PCA9552
+    select PCA9554
     select SERIAL_MM
     select SMBUS_EEPROM
     select PCA954X
-- 
2.43.0


