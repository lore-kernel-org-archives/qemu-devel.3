Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32AAC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 13:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txmvx-0000zJ-Dx; Thu, 27 Mar 2025 09:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1txmvH-0000jG-UX; Thu, 27 Mar 2025 09:05:29 -0400
Received: from mail-dm6nam12on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2417::61b]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1txmvE-0002M4-RK; Thu, 27 Mar 2025 09:05:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CH+uT9+H/7dKdCvQgxQNW9ijPTbkUuogGBZpLy5ZSzyVaB0Vw8AkXQLObHEeiIlXq36+ZwGzanfqisCA/x9HY8Rlc7H4w3Wh/Rk6gdkd3CrK75dg4foFO+3gRJLKI3lCC8DIAMHQXCAvlrsOnx+yEWtdG+7VHj563HpKR9lEa4nnPBPwBZJjrbuvBfu0O6n18DfgaRd5OtjpxKn88v7RrsQ58X7Z43WOdWMVxNcxnWuii/HBaaCKSmjRbGUTgsTq/baDsyFKmAFonbVQJq3x4PVN/+LEWSiz9zytvNaboN3Fuw9vdBNq5yixlOFLgQnTMcIj2fvKT2big8LnCUAhmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIU0pbd/AI5BzDjdm09x4D4LC9D8v5pdu2L+CGeu158=;
 b=eULrQTwEQisA0nEcBusbQZeuRHp01F9wQiKATnFWXUfXa60H0992pOzxVfR6pZfFHb/lwBq+wB+QF2kHtLfCFBk9B6McHWNAoGc8inabQ+mlLjJtnyGNBjdYOgCQWdJpYYTsOWFH/XGoPJUvwjJqHWPXQgdGstBmN+FsV6yqYlwglcP/GsAZ48PiPqlCgqc2HQ0ZMaiJh+bwOZcTmrBJurygrImpMEAsJrldLRC9VW0eyUED0LdGpyN0p7VmCpuN8RlpIHfpnzMRR0cqG4DmZE8wLM4qnV/66ycu2Ri3c7A22SjjrFi/9fQOAme9fNgELrAb63A5hsHZXmtjGXgabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIU0pbd/AI5BzDjdm09x4D4LC9D8v5pdu2L+CGeu158=;
 b=f5W+Ob04r6rWQhH6fq3b0Gn+hFDXAuK0CC4qS3/d1e+XfCVr3bjh1vHVbOrHUOBboDBL7uVgdNJxYb1vb7tHE/6CJFYUxIAqYCMaHYlhdv84Vi4QKmjPK8vvHpT8+ZtdaXFS09zdJYGAJJaoCc1BhSP5JuxBWnDAmYT1NPN2CK7fKb/34oXvFuVmd2vig9scRROMirzxboT26J38LswdZM/oGUM3WURt2s3mr4j6NShD04C/hD6S9ZeLVMe/o9r+tdL8OvHHksyyTs69wc+owJRdNo+1kbYrOGK4zyLw6/sPMdAe8aQXKFGXA/BCgfrfx7++MH2xCxNcIrfM0pMEFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 13:05:08 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.042; Thu, 27 Mar 2025
 13:05:08 +0000
Date: Thu, 27 Mar 2025 10:05:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, nicolinc@nvidia.com, ddutile@redhat.com,
 berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com,
 smostafa@google.com, linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org
Subject: Re: [RFC PATCH v2 17/20] hw/arm/smmuv3: Check idr registers for
 STE_S1CDMAX and STE_S1STALLD
Message-ID: <Z+VNA+hFu0LJn19l@nvidia.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-18-shameerali.kolothum.thodi@huawei.com>
 <477323cb-12d3-484c-8ad9-61229ede3efe@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <477323cb-12d3-484c-8ad9-61229ede3efe@redhat.com>
X-ClientProxiedBy: BN8PR15CA0063.namprd15.prod.outlook.com
 (2603:10b6:408:80::40) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3028ed-3932-48f4-ad3c-08dd6d300030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Q1QPP6R7gwvNKyXwNICPvZJZkBCEN6v/5cNu8eRvwU7LpxXEs6pXQFwT0IG?=
 =?us-ascii?Q?viDw0IHNlzIIdE8rnDTxGGocorC9DHdVxE+9/OnCThLxT0mNpQ4ereACf+c8?=
 =?us-ascii?Q?cW8CeZBlihvJlTFkKdhh+FPdFb1BWzwGYBNl6b6iADVsTbIwll0Uri+nnoWq?=
 =?us-ascii?Q?YmkXWUp8pD2q2/t7kJHPog7MP2e1eswLH2aiKs0+bQdeNFsjS7+WIq9sU3UI?=
 =?us-ascii?Q?zGC8B6KltJDZTzThRGNH7SCsH55JNC8ZikNnFsvPJc69p1URQnFtKBjWDsXQ?=
 =?us-ascii?Q?rNv/vkjD6LE2HPDBMApf+qmAvFfWmWg4slotbTOizhX3M8ODOg6gSSlfUwnK?=
 =?us-ascii?Q?4ICHf2i3ZmxDChWgynsHzhniRGFpsujqYtyg3V7d1ZWQBA2INdts491BjImf?=
 =?us-ascii?Q?Z3Wt6jPqLdNfUly2O0O/KefIr5R7FI8tYaqzOpvrA5GgLWwOrXQrDOHUOIu2?=
 =?us-ascii?Q?Ute6bhh7tbfI+MHsHo/2uY2yiZRy46rDbZdkJUjaRuOUKu0wao9ZJB4+UvsC?=
 =?us-ascii?Q?yWKdXR37l3ocr4omEyrR0UkhufdD+MZpJugZeqdmDYekkLak4NZ7mKDiT+X2?=
 =?us-ascii?Q?DR38p8sPG2bZP6sS2zgLQj504S1ZUH6MYT6UfrSjkd0dTzIBjFKAAFvteZLo?=
 =?us-ascii?Q?heweJ+qwa3YtXGLiKu3YojTVfyhxzX6FhCImc3i4DpsDKA96YORncXzlKfYi?=
 =?us-ascii?Q?6EomXlmdXQ2EC7GexnC53stBs7gSUGFf+J9smYGlvdc8tZpj4+XuL5ZBcE9y?=
 =?us-ascii?Q?MmkmBqLjn9QvBdlIiy8IuKwUnnB0GSb8nJ2zKe9N52XR8/IP3tR0tUcvEt5l?=
 =?us-ascii?Q?brmminzS7l0UWkN0IhAL0N9cUZpDVzKlhFJY+rIrtsDriJ3AW5cBk6baDtrg?=
 =?us-ascii?Q?qPaCZEt5GuG45l0U6cj9NBiTkC+MVu4btxVbd8gRjfhuVnGQWq2Crt24USWh?=
 =?us-ascii?Q?Jtj+VoiByKn6AxYUs4T06EsWMLkrlPKEiD5VSNFdayT0BTx52VIXFoBS02nG?=
 =?us-ascii?Q?+k9c+CaVa9n2zuIz45ppCKjD2Do/M8WdsugTr9sRXDDbgEmHk4n4LCOKcwBS?=
 =?us-ascii?Q?BSbx3217VTQNjjhBch+2LqZ7ljD7UCKZu0hXLRFT2KzuMMEb4A86LkgkbROe?=
 =?us-ascii?Q?GI22aeFkM4kK/zxLwUq/eoazk02VRwhdPOM86JL1whsfvM75Fk7OcxaYN8pU?=
 =?us-ascii?Q?xG+Bc8U5mciD3Rtt2hFmc8UgI7S7yPpR/Am+tWRcTnXJ6AksSjomLgkqKjtP?=
 =?us-ascii?Q?NDgMJQWsca4GDH1V/PTcUVQpT4oduzu2VaPyly9E5/Rxegh4t/yG4vsmHXiI?=
 =?us-ascii?Q?yqh5M+2h8IDdqlTdYJPHu+Pra2YegBI77F/CMPfJA8Cmjc0nTBAgOW9yX6DA?=
 =?us-ascii?Q?QS/R9N7kDu2RpiWytPafFESFo8BW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jwMEu1FeKCHrhAbZuujrqDaOecbAAaD63TxuZacs1AaD2w1gX798AiPXar0T?=
 =?us-ascii?Q?hTbe/3C3R3+NIlUumJrJuNHHeyxgAwAPA040u5C5v+cS1MHhTsrpYxyXdNEi?=
 =?us-ascii?Q?eYwtwg/h//u3hDqOVO+bn2u2F8CjO0jha1E2PkvEId0gzhpZhpEXKnP3KXac?=
 =?us-ascii?Q?8fESPpYNq2N1SEgjTvOothLeLOwBU14a4zpE1+RMW10KhQYZkPUm4hfXWkCM?=
 =?us-ascii?Q?juRDaXzD958rx1jo/1MIkbw3JCbh37pIVW5BgWAxSxdkGXtLRZwDAvcWTGC+?=
 =?us-ascii?Q?uf5gBM4e2TAiVl5O9Rv4IscWcBalmOU7UL6hHeLVZ7ehWF/Xp6IoExMDCqTz?=
 =?us-ascii?Q?0NH41yESuMF+RZltJtdaLKZSoliA6jpvP43FbSqBPNw5V/xrccX+QxSB9q/7?=
 =?us-ascii?Q?uF3CmmcdRg9RqgHESDDb/yA1/yXdCRpSuge9w5I4NIPi+XH7vznVea4kvmmZ?=
 =?us-ascii?Q?T07uJiwcrcJg6BKUZKSI1OU/E1adHj30tMi2k2y3CXYOw/SKj00HRjNeg+D4?=
 =?us-ascii?Q?Bf6by+lp+w5ip+p3uyPJC0rTGQsi/3F+U14Mj999SbcKgWvLFySNrKf1STls?=
 =?us-ascii?Q?CBN397/BkG3vCU535WCpdrI24zqPdC18orKtVM0PZjqb72TEdzdWddgl2otZ?=
 =?us-ascii?Q?64nZ9XfncvpOvnNsM0t26S0Qe+0qE/daoFBMqhjgsLSyrcZNFEH6Eh3x7dk8?=
 =?us-ascii?Q?qSugIu6uPez3//IVMeSXbGqVUK9w2tFNNmoaESlQlRwtK+Va53STx4NG1A/T?=
 =?us-ascii?Q?xgSImegmvhIrlPzUzB17kX8ttT7lpi0CHab43N8dkp8ApR9+nDm0UMPpPjsx?=
 =?us-ascii?Q?EPFlD8I+XR6dgjoWkqfiRKLLsYpNia8AqCmlMyIW7TkWTGCpR9iFCYPP08RS?=
 =?us-ascii?Q?AOA4Q09q6vVcNGzYTfCBvVqG+NK1w3f7XfTXt1ho96zMmNGwdfY9SNznHggG?=
 =?us-ascii?Q?pAQJ93nle37Axw81wBvWORcMdAE8d1B0+HHEjCpFkPpTOPHBrvHm7CoQ+ubl?=
 =?us-ascii?Q?lFIy7V9suNU8YF+Szak2ejAvSnxjRhPU2yIj7CAzaBhH3Ekldrhl3UR/RlrC?=
 =?us-ascii?Q?fnWYF5JKA+ghOTVhsY1AgJg6dpZAEim+C0M/kOXC9/NA6CB/DP7LlxvLTWaj?=
 =?us-ascii?Q?hmNk1qrgo4MmUDVBdzVqc4AaKDrsof8q4CMfYfDrpCHRQQMP+AvVjpiGWOx9?=
 =?us-ascii?Q?9Ib0diWZhf4AjOzRNlRK/wN7Kx50K8p9VdBXnj6WjF2qiGkFLTJbXS/XuEtX?=
 =?us-ascii?Q?vXqwbCnuhTP/it+7AKxwLYMqHBztMj7mKt7t/fxRhSrKqNM9Yana0NzIFWdz?=
 =?us-ascii?Q?uymt3YCUK5ZYverk/cr0ezqkAh4wg8mDBuRfMhvcrBM+0ovPqzuGm7fhuVr7?=
 =?us-ascii?Q?14KcDrjtsJv2EyInrdTULW+iDbRMVD2DpoqR0ER/U2rWS1PVcE69zR0o0YNU?=
 =?us-ascii?Q?x+z+jXWLKcIsGHfpjQKNGJNk3jvG+aTzBixnrSUtg2G4McQlhefHpte60yZq?=
 =?us-ascii?Q?tX3ryPNFi++zxVyitZudugGju77/CjZ3yWxMQI/NrIGmng+Y/eN3BmASLmHG?=
 =?us-ascii?Q?MCrYHKxyOqAA5HePCDo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3028ed-3932-48f4-ad3c-08dd6d300030
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 13:05:08.7519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1sis5A3h4xKyfJIGIx2p4vu6k4IvY+iezkdJKTSehhWoJPI4kSeFXY/1QdQ1GUk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012
Received-SPF: permerror client-ip=2a01:111:f403:2417::61b;
 envelope-from=jgg@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

On Wed, Mar 26, 2025 at 06:18:49PM +0100, Eric Auger wrote:
> Again I think we need to understand the consequence of having a more
> comprehensive support of SSID. This also holds with old the IDR fields
> that may be inherited from the HW and we don't support yet in the
> emulation code

To be very clear, and this is in one of the uapi header comments, the
vmm should not be copying IDR fields blindly. It should refer to the
physical HW IDR to build the virtual one only for bits which make
sense and match its own paravirtualization capabilities.

Also, I don't think any of the emulation SW in qemu can use a pasid,
so isn't it OK to just ignore the non-zero SSIDs in the CD table, and
continue to advertise a vPCI device without a PASID cap??

Jason

