Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1251FC36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 19:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txWj6-0000PZ-Af; Wed, 26 Mar 2025 15:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1txWij-0000Fa-Ci; Wed, 26 Mar 2025 15:47:25 -0400
Received: from mail-bn8nam12on20631.outbound.protection.outlook.com
 ([2a01:111:f403:2418::631]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1txWih-0006kp-41; Wed, 26 Mar 2025 15:47:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=efVTbtXOt11gIshGiEsG+ZQoB+TdfBqgwQNBra0nnQOX93kfG0EJbYKs7I8GzDLmHKoBhKrejq0DnnfdlrBK6hUeLnZmHLcl7/cg6dddFSC03dlmuq5vqQ2UFeDEnN0Se2HEPgs63lwDpsCiutQ0lu4sdtdjuBnNp/Q7odTxQ5Y5deMCtwkk0LPR3i2fGl9I2l44VuiSDSg8Gnf8iMvCl4SQrl0t/Eu1nd0FAMxjESawmc8x6Ny7a4va3NcCRWQg9DY747KeaO8h8hFShlUURYJ88uZ/U1cq+RqxTKYTL2XSeaiMdaHY7GPUfekcyqM0+DitOn2XxUf9Za/TWX+4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paGm9Cv0vr/FTYI4wEZ8MRUMcPeZoTErAF9cA6BwGmc=;
 b=vPRBeEkA4epnSUL9JprZWSOY9GikG0hSfSZ9cDFl+STtitPVSUsTpkZvhbZOhPtrpR1Isw0ocCXi2kmCO24DlEpImXW3RnWyr3usxbXYIr/XsvLX317mRO7RkiE10832dXBXh1yCm5aUhdFtE1a/6/fYTHzvnFW7727Wl/36/xJpm0hPX0JLDh3KeIrWNGbwISN5WTrh9ZyqJKcHElvL4HsQzK7mQ5NWNMnZt5nhJC97kOX2vdeA9zyndVX7YiEasix3RpS9B6D8g9Jnowe7pDtFW9ZLKolRP0ZoAeqEzp6qMT2I4b6ID7jiojPZpTOaxLoqviZ5YKshbPsvn904WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paGm9Cv0vr/FTYI4wEZ8MRUMcPeZoTErAF9cA6BwGmc=;
 b=XQRqpet2L7Av4MOvLyiselfHKnXSS9ksSKtsx+bzFGv/ElYgMBilO/5v/z3F6461JVbudF+NyJTQp+OoCzgh/T1seMiokHSAoRWaIE9aRQFNvGNh5mIyYMxSnC4T7RjP0z7f0i+zs6OaL2Pfig05+oCmmql+0xg+oca50mxGcNIsJKuzBvKU5nl/tJsjCZUua9alQCSNnHf40wEHSPqF6bAwL+j2Cm45ktIbcmsw+AOYqMBLbgJK2Kobqfn6+WYpYtc9o8yY0opqGwY9BEKfLp5FYv9OjbqBoaj9dBpHDjbX436UpOVV2S1dCGz3ucYiCF5s671Y30GOkLlbp+1voQ==
Received: from MW4PR03CA0340.namprd03.prod.outlook.com (2603:10b6:303:dc::15)
 by PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 19:47:14 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:303:dc:cafe::ee) by MW4PR03CA0340.outlook.office365.com
 (2603:10b6:303:dc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.40 via Frontend Transport; Wed,
 26 Mar 2025 19:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.2 via Frontend Transport; Wed, 26 Mar 2025 19:47:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Mar
 2025 12:47:02 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Mar 2025 12:47:01 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Mar 2025 12:46:58 -0700
Date: Wed, 26 Mar 2025 12:46:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <jgg@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <linuxarm@huawei.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH v2 17/20] hw/arm/smmuv3: Check idr registers for
 STE_S1CDMAX and STE_S1STALLD
Message-ID: <Z+RZsES0+Ywxi7Xx@nvidia.com>
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-18-shameerali.kolothum.thodi@huawei.com>
 <477323cb-12d3-484c-8ad9-61229ede3efe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <477323cb-12d3-484c-8ad9-61229ede3efe@redhat.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c33716-95f4-4824-9dce-08dd6c9f0131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bTFQTDJPOXMycHBNTUFVeldYMjdMNCtJYTJzd2Z1amtJcFJWQTExbFFvUWx2?=
 =?utf-8?B?YVhoMS90N3JzOUFaUVdrTDVGY1hEakp2RjBQSHFjY3V1cUJrMWp6SHd3bWJK?=
 =?utf-8?B?dkdaMFdnVVRUZC9IckJBUTFjQ0VuVHh2amRQdGxXcmRZbytNNVA5Qm9oV1hv?=
 =?utf-8?B?ZDdIUlJhZ3lzTU9VME9ZeFRjS2ZhdENoSXM0cHZEY3lRU1p5cjh3dGxTSTlF?=
 =?utf-8?B?djRpbDYvWCtkWWtpaG16QWZwNjQxWFp0SGZrR0N6NFZ6SS90b2VQK2tvUjVI?=
 =?utf-8?B?RTVmMUpBdTlXRHlYQlE2Sktnd3JCZEFFOCsvSHpIU3hoVWtERzVWbktXUDc4?=
 =?utf-8?B?UWFwelFlVmV6WUxydVZqRXk2Ym9hTFA1Ry91T2IzVTJDMmF3MytmenJVa2FC?=
 =?utf-8?B?dCtWdkZBQ3puajFjQVVaSFBlVUQ4bzJ5SHZ5OGhHNzZGVEgzL2JUdFRSVUpx?=
 =?utf-8?B?TFFya0NOVEI5MWZUNVprZnJDL1MvV2R5dGNTbnc3bXdES0dBbkJHUVBTanI4?=
 =?utf-8?B?VVk1a2IwaGNQZ3VqdTdma0NLT0hLZDFhcXRObW5LOXFRYkVDUTUzTUF3M1lm?=
 =?utf-8?B?KzRQMXNXRHBEcEZUa1JOOGNjK1I3Tm9wZUd6b2hKem9IaEovc1RkSjdFTERv?=
 =?utf-8?B?QWI4OG9TZFUzSWFMNlU4dEpjK1gyWWFzOUFJY0FzV2dSZ2ROeWZDbGJScWNH?=
 =?utf-8?B?bHA5L3EyY093QzAxYWtFUTE3Y0dqOG1UOFIyeDhxRE83bkpRbEQvdnozVGNQ?=
 =?utf-8?B?bXFHZG5OUlQ1Lzl6YTRLYTY1RVlXdHhhZ1B0Y1ZhaWNFekprNVVpbk0xbWRt?=
 =?utf-8?B?L29GM1lWd0FweXhNRmF6VTZhZ09KaWdwLzQwckhpWDNxRHhVdmJ0d3pqZ1RQ?=
 =?utf-8?B?MVUwRGtSR0RCKzJUQXVEUWFEc0JuRGIzOERFamZqUmVRUHNaVnBHUy9GNk45?=
 =?utf-8?B?SklsbTZXVEs1aURmckxIcFluTzhMeURGbDZkWUJaWkFwdHp1bTJwZEtsUXBB?=
 =?utf-8?B?ZXp1OG5ITFYyR3laRlV3YnhPMnpwMXFoYWk3RW9rblY4YmJuc0xCWEh0QWkx?=
 =?utf-8?B?S0xvaC9WODNyQzRVT1ZERXI2NzhWMzNINklFTFJSSEZpS1NEU05tSkJRekNB?=
 =?utf-8?B?NEZmRTBORmdXY2FHSEw0UHcySHNsWmY2NkFFWHc0eFZWSC9WRWV4UnhGbjlF?=
 =?utf-8?B?ZEJ4WWdnbDE1WjFuNGpPRWZXL3NTclNPZTNNL1BFa3QwR0c2eEpzclBoUG5I?=
 =?utf-8?B?clpaNS9QdzRyTTRPaklSd3RyempWQkZlZVB2TWw5bUEyNGVlQm53WGd2aW85?=
 =?utf-8?B?TnRkRXFDOTZRR3JyNEk3WUVsTUk0NlRxSVJPcXhZb1QrenQyV0tHZkE1c1Zw?=
 =?utf-8?B?K1llOFlzRHY5SE55TFBEczVzMWFBOHpwY3FqRjkzcCtVY2FCMWdGTkU3U01a?=
 =?utf-8?B?RmZSMXdvcVk0YUhNVW04cXhtZUUzd2dSVllPRnhwNlBQY2k4R2dHQndDd1p1?=
 =?utf-8?B?L2VKNkpUMGtOa0hFcUNUS0lTS29tN0hkY0d1UHZhYUIxLy9sM3JnZjFXU0Ew?=
 =?utf-8?B?cXhwcGRyeDNYc2dqelZmV1Vtb2t6ZzcwUm83eFNzKzZ2dEhjVk5hdWFiTVNi?=
 =?utf-8?B?TXA4LzB1ZzhyOHp5U1ZDS3AyMFg5TzkwQzZac1FlWU84Y2VqWE14MHJMUXNt?=
 =?utf-8?B?akdVN0xyN3N3VFUvNTlvQzZ5M254a3BrbWJaOElEN2toUVhZUG5LcjN2NE5i?=
 =?utf-8?B?WFpnN3plQUJVWFFZQ1NvYzl1b05LejNwbWliNzU5ZnA5NW0rdnhSZ0RZSzh0?=
 =?utf-8?B?K3c0TVdRNkdIR3dNYXBUd0pGSmlqMWk4YkRySmROT0ZjeDZEYWJFNEhaS2g5?=
 =?utf-8?B?blJYc1dhNjNuNko0ek56SkNkOXE1UG1OdDZ3aVo3aUVNWi96VnEzZ1FaVHFG?=
 =?utf-8?B?MStXeDhJUzRoUzNaOXpWS2hWYm52aTFEMjQ3anFKc1BheXE2bzhPOC83cita?=
 =?utf-8?Q?szv6mh2vRYp0D9jMo5qD9IFmkNDOjs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:47:13.1366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c33716-95f4-4824-9dce-08dd6c9f0131
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
Received-SPF: permerror client-ip=2a01:111:f403:2418::631;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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
> > @@ -561,6 +561,16 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
> >  
> >      decode_ste_config(cfg, config);
> >  
> > +      /* S1DSS.Terminate is same as Config.abort for default stream */
> 
> S1DSS. Termination

The spec uses "Terminate":
"• 0b00: Terminate. An abort is reported to the device and the
                     F_STREAM_DISABLED event is recorded."

> 
> > +    if (STE_CFG_S1_ENABLED(config) && STE_S1DSS(ste) == 0) {
> > +        cfg->aborted = true;
> The spec says:
> "
> When substreams are enabled (STE.S1CDMax != 0), this field determines
> the behavior of a transaction or
> translation request that arrives without an associated substream:
> "
> So I understand you should also check STE.S1CDMax.

Yea, that's missing, as spec also says:
"If Config[0] == 0 (stage 1 disabled) or S1CDMax == 0 (substreams
 disabled) or SMMU_IDR1.SSIDSIZE == 0 (substreams unsupported),
 this field is IGNORED."

> Also how do we check
> that the incoming transacrion arrives without a substream?
> 
> In general shouldn't we add the support of subtreams in the emulated
> code too?
> 
> the spec also says that in that case you should record a
> F_STREAM_DISABLED event.

Yea, that's seemingly missing too, for value 0b10.

> > +    }
> > +
> > +    /* S1DSS.Bypass is same as Config.bypass for default stream */

> S1DSS. Bypass

Perhaps, instead of FIELD.VALUE format, we should do:
	FIELD=VALUE?
e.g. S1DSS=Terminate (0b01) and S1DSS=Bypass (0b01).

> > +    if (STE_CFG_S1_ENABLED(config) && STE_S1DSS(ste) == 0x1) {
> > +        cfg->bypassed = true;
> > +    }
> > +
> >      if (cfg->aborted || cfg->bypassed) {
> >          return 0;
> >      }
> > @@ -598,13 +608,14 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
> >          }
> >      }
> >  
> > -    if (STE_S1CDMAX(ste) != 0) {
> > +    if (!FIELD_EX32(s->idr[1], IDR1, SSIDSIZE) && STE_S1CDMAX(ste) != 0) {
> >          qemu_log_mask(LOG_UNIMP,
> >                        "SMMUv3 does not support multiple context descriptors yet\n");
> the log message should be different because it becomes a guest error:
> qemu_log_mask(LOG_GUEST_ERROR, "invalid S1CDMAX as SSIDSIZE==0") or
> something alike
> 
> >          goto bad_ste;
> >      }
> >  
> > -    if (STE_S1STALLD(ste)) {
> > +    /* STALL_MODEL being 0b01 means "stall is not supported" */
> > +    if ((FIELD_EX32(s->idr[0], IDR0, STALL_MODEL) & 0x1) && STE_S1STALLD(ste)) {
> >          qemu_log_mask(LOG_UNIMP,
> >                        "SMMUv3 S1 stalling fault model not allowed yet\n");
> same here.
> 
> Again I think we need to understand the consequence of having a more
> comprehensive support of SSID. This also holds with old the IDR fields
> that may be inherited from the HW and we don't support yet in the
> emulation code

To support guest-level SVA, it must support SSID. We can keep the
SSIDSIZE=0 in an emulated SMMU. Would you elaborate the concern of
doing so?

Thanks
Nicolin

