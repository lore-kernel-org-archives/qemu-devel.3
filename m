Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF76C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 11:55:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc0hz-0003rV-Fv; Wed, 16 Jul 2025 07:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1uc0fh-00031o-SX; Wed, 16 Jul 2025 07:51:38 -0400
Received: from mail-dm6nam12on2061e.outbound.protection.outlook.com
 ([2a01:111:f403:2417::61e]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1uc0fe-0007gG-N5; Wed, 16 Jul 2025 07:51:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkzsAW94/Gon7rukOVGtNa0jntxgN6VGpBbgLz3XbBlJ15mpfkx//Z0qw4EgH0gi1pxs2qghsDvb7l/6EjEHfncx6vQZsfLNWRnRhdW0U2/7jkxKj1w59tSGxUD14OVaRHI3VVTmLLcR3crCkAVFltXqG1pTISSqxeBRkDAb+cTfEUPCttTd+yZI9VUyjFpcYeenYOj1vmuJ2F5vsD5bVLngNugC8X8lM6tL8PYV1FpvAiiacxBiqRJd5UpcDmOV6IzHVYB1yes6ewmD6CTaz+sog5YC7ESm11vvOAOzcLpeYtp8EbbYngzBV7vLV5SZY2KO0FjGUV6ykJDjTzsOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ivha2hVtfDBVEYYoxLJntk9SI00peb0Sjs68CdWHw5s=;
 b=gMmxV0++3KTrsfNhLJfhIj4Vq/dt7VH70txZJfO7Ppo/RGXRrOWHEQGXNvo8I5aV6XoRDgexBnK3woPhpNfsjLlASqQtZd+q0Z33oszNcCVYCJmI3pi75JaSFMRgNqoQcIxk81htCj9qH7sH4xU2A7bb0XiGBdQ9iOnOoDCscGUWem1NEkqEDsKtx6Z/gph2UyWKgaM3WO2nZO1Hkw+24zOu2vUowm/VazWi6VS4AvjDoTk2VJRRHCTod0Znxj39ipPMbqB5ciRLNPiog2Ovv/nbayoyIU7SlORLqf+48r8DsFJ7pFhO/OGxVrKHiw6hNWYavHz8LobpSUKh5JaVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ivha2hVtfDBVEYYoxLJntk9SI00peb0Sjs68CdWHw5s=;
 b=iBALguLeoTWHYjVL3DsSMAbglecjbHIENN1e3wZGO4i2aKY+KIzW5rXA3WGCzK1vE9Q0PgINFIg9skoAHhtnU7o3bupyw+Gj6HZ0o7IWYnSoZ08oU0V4LNc8jYRM4igkR27cQVZfZDLFi+JX39TwfIq3G4ufhpGDrD92Mh2H8C588VKP9ahGkoONA6+oC3m7MB2LYpZsXxnYKRFOVqYDzcrYOiTq7ImrDcZ5kFuMv6yOuuEUGdHdZz/1SAxsifDcaIphU0N3H9bhCT9FSmV2XiY8Jd/wWFNblQec5tpGehHb7cnhR2g7SK9Aw8EGkxMbI0eBgsyq9XVLvj3neiwMVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 11:51:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.033; Wed, 16 Jul 2025
 11:51:24 +0000
Date: Wed, 16 Jul 2025 08:51:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com,
 peter.maydell@linaro.org, ddutile@redhat.com, berrange@redhat.com,
 nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com,
 linuxarm@huawei.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com,
 shameerkolothum@gmail.com
Subject: Re: [RFC PATCH v3 14/15] Read and validate host SMMUv3 feature bits
Message-ID: <20250716115123.GW2067380@nvidia.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-15-shameerali.kolothum.thodi@huawei.com>
 <aHcVNYtd9qe+sHAT@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHcVNYtd9qe+sHAT@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f68549-593b-461c-b33d-08ddc45f16f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hs4B1pvr7FSuvdIerBlVotKdH1vhfR8WxMkFPLxtjDuDUkXAr4daCI70HxyA?=
 =?us-ascii?Q?3r5kCKG3fmjuQxU96jGfH5M0tU7VQwSJNwZ1QBrigGYBpfbF222+zfEDLHUm?=
 =?us-ascii?Q?B7HNR9RB1SlyTtGBII1MOxqeXIcCER9U1YnY4PYDOl5FM5Xpt8SqThnwLGmm?=
 =?us-ascii?Q?6E3f6c6ZLj6ibwab8AjwQYEYt+UR97Kxsz1yKl6XjvRQiSAi0osc/tG/QwEl?=
 =?us-ascii?Q?scpATyRtDJaQZ7QE7qqnoK5ESTigKy4mgj+kR8PhmJpZZZxib0w5b58/4iDW?=
 =?us-ascii?Q?iXge4tKbwCKpMq0gGxRSE6ZSX+lW4/OiGMqZ6ACPcAOwzTZk7k8C0M14GNKD?=
 =?us-ascii?Q?C6rHccuatmSHWZ3bKApjcXyQJypJI8567kwlqCinbZC7Y/XoIp25iuhYpVIV?=
 =?us-ascii?Q?/bIwqtJMGf2ANtyX+rw+2LUbgO83BwCHBXNlwA6ZtD3yipphITqhBX6eilM5?=
 =?us-ascii?Q?UPq/BdN4CR8NWjar1sozaGbwWgHFqL4p7VDK/4/KbrFJqDeUElo0Wwk+GPFr?=
 =?us-ascii?Q?iNAXOPawF3lttVASP4JlVf3sFxrWyoZ+3AMHIAhlE/RodURE5p555PwgsZAu?=
 =?us-ascii?Q?//rXlPvsKHIhXh04XY9Rj9atJxk98nlVa7YUIm7bz9SL7ReaGHVT9BUO92Ab?=
 =?us-ascii?Q?5iq0qHcoUgJLPMI4Y/DXeQNcEj577q8vsMOzbfFRM6UdCfO8zuEkkMrgiShA?=
 =?us-ascii?Q?bL4r91B8svysLYWpjCT27+EeCoSLp6BLyx6Jzh5o1OUQphNZepn5c7Lm8dKZ?=
 =?us-ascii?Q?Imd1RWmrdBhWCN3gTlBDUljfpjhaLX1oWRawltg95BsZQ+DuSQSu38jR9G9g?=
 =?us-ascii?Q?GCaMWMQv84QeRXmvgzFFUU+5fhbS1ITJIpz/EIaqB9nOt5DalcY9N8ZULI43?=
 =?us-ascii?Q?Eem31tRPcz81THIc8OjxKSM6kU5uI9F1r79ZGLMlsshl5MZV9bgrwz3jIIAz?=
 =?us-ascii?Q?JMmp8H12evjYeTFVXDbdP+SFG2GJX3CVTcFEht1FEyDCp/2zFfhsF5OAnNf6?=
 =?us-ascii?Q?2J90yrI14rmmUot617zWzEz4oD7rYDFYVm0V4N1w60j5gkvTpZv8uFXhAQeB?=
 =?us-ascii?Q?ycCg0KuxpIyVtAZ35yjlK5eg47zpuZHDT97s/Rxs8fo/d57EX0wW2gahVUe1?=
 =?us-ascii?Q?f9MZ5Djhl3Q6H4r9qgeV9v7yoW2MR80Cvj2qzzTOjOIJs5XqRHSD4yAoevAL?=
 =?us-ascii?Q?EIBN6sxsJTHfp4dacaT+TWa7DWH/6KaB/ye4rDWm3TE5b3ElxBz8mix4KKEM?=
 =?us-ascii?Q?BLDWKoQiaHcKSduMLEs2k7qJZ4AAjNA/kbWyrP87jqtLoeTBdQY2ndlpU9IJ?=
 =?us-ascii?Q?UCEUErLlR48uMKVkIYbICdwZg51ukLYfRTrB9rSFaXHBfLLnc8uQpqLB+isC?=
 =?us-ascii?Q?yDCTCWDfO1QQfu9n7v0xFvfsYK/8xhTg3PTlj74uR4D8k7MkDaLNfKQeqr5E?=
 =?us-ascii?Q?kk5/JOwNOcM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lqn2EmLjokEqZkAMdKtodhCZOa/Gh9pYhsJD7cIiOJJtEDrV241+ABv44GMa?=
 =?us-ascii?Q?OsIg4QzrtWJusRBZCHxmvQDX5nvqCVYcimN/hrdYoouM1omk7eJqWClIYrGQ?=
 =?us-ascii?Q?kDkxrLQ1hr0Eiz6094Gw1xilghP7mSc+9gMwgajR5+CDcdEmU2b+mjue0Byx?=
 =?us-ascii?Q?p99Y7jKTudfopVr/AdX+hEQSGw1ayLKZw3dn+7Dccc4LHtYe2+htylp2ERLa?=
 =?us-ascii?Q?dpyzIRxyPc7Xpj9mLsh/gttOuGkCtFDFbes1vcJm4z/dHWSd0qqkpdi8hHue?=
 =?us-ascii?Q?6T8xoow4YFvrRAh6Szu+JgRUX+4Vj79P/qeQ4CyW5lCvavD0Y6PUJlfG2s7L?=
 =?us-ascii?Q?+I9nS5b+cWyeYVhZ3rqnJD1TrCrHOGkCGKva4YOmmBX+HmwnVspl/ZhhWPN9?=
 =?us-ascii?Q?HezHyQQOaZ8FETOaXWKcQTt5/xGbzs+sXxw945LDNCPojA206BZk+sgV7IAx?=
 =?us-ascii?Q?ysDisDMpm2H4zNwE3Rgrrhq6yUSgYBZMpvCbzTfr665s+f5oID10r8M1/79g?=
 =?us-ascii?Q?orjhuet3vTEmCTG0vU00bBfopFLwJr7Ti2IU3HlUbSLy/SiMWcyy24LE4qUF?=
 =?us-ascii?Q?LZKjoOqOpZ9ABluknJhCWzddixf2gv3OqDirlXyH+NHZfnjM0By8zzqrk6N2?=
 =?us-ascii?Q?vvQlFuL2aU+auDu9+OWWU01gKIaLOIurdCTie/7DdoAk8cMWzOcMl1gD7zV8?=
 =?us-ascii?Q?fVhnHJTSoUtJD+PbeQ7oIeuXrtPAt7zr7/9yjsZpKV9gA0mlWa2qv25wXxkE?=
 =?us-ascii?Q?rBGEq697V+kvFaNOIQk3Xu5EdD2vjOk+6SvGBA4nFxB6qpFx6ot7iBj+8Up6?=
 =?us-ascii?Q?oLqXBoWh4XPF6GFjCXeAbLf1zPSeoB/2vI6cyKYGV5rFCSFMnfgnfxWz8oYV?=
 =?us-ascii?Q?tgOWannLc8bBq72p2lxjFru3Mw7aqeesyLdgXZk644DHYnRzRNR1wZ7eDdUA?=
 =?us-ascii?Q?Za1cuCnL6xIqHVR6ekCZ2mSO6gmZlSM0dgGm+Z9T/OALJnEAGrG1sjV4Kn3V?=
 =?us-ascii?Q?A1SPW9wHJ6JvTEMz7VkyreMKckrZy1fx2cNRARTyepJ5d0StM6oGzyuqCTMx?=
 =?us-ascii?Q?hgoDgQE5cfyl6rqJ1rMT/KqGwR2IEdFyGBGZF/JLF+TmKhZWuR2UNKqYCu8u?=
 =?us-ascii?Q?ew/h7eGpB9CrbimYeegKCpN3FqmCkqtQr9rW7tAoQsGK5oZTFlkmzgjbjA/t?=
 =?us-ascii?Q?1FSTMh/K7ocQjPAN7JHWyu4vo88A3+qx8wcZc6SGDq9G1hNa1QUiS6KBWW8f?=
 =?us-ascii?Q?CWyjzDiwSOVR2gObUezu19mPmi4sWEzcrbKPYe69C2zTNK5D0gSkK1Ga2s9y?=
 =?us-ascii?Q?6GzrTc3lRrt+lzIBAmlVEtL8Lhzoi1DB6DaxY1jlnpUSOcwvSONfPpUOWR9/?=
 =?us-ascii?Q?PpC/4adv4HrGT3PJFSU9p7tLxL96Sra+MyR29fXtxGRoAfAjD0WAV4GWSK9i?=
 =?us-ascii?Q?98318RYNruyKEUisnZH6cw9XiYbsjCvpHoNEHyf4pg0wkjiGul7hY2OMwzuN?=
 =?us-ascii?Q?FBan8r7zeGVQZaFFH1ncjXpm05YjdUueC0mWobwBOWcgkszYFvZU+EXYuDe/?=
 =?us-ascii?Q?RoYn2Q7XObH0bSFe+xK3zr7PFVTBQFF8anSIrak/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f68549-593b-461c-b33d-08ddc45f16f1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:51:24.4470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZQv2HtSDJ3In+IBJ5jPEN64ooQ0JxQrIKH/v5wn22Ja7ZvBskmk9R6NYualkgcG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106
Received-SPF: permerror client-ip=2a01:111:f403:2417::61e;
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

On Tue, Jul 15, 2025 at 07:57:57PM -0700, Nicolin Chen wrote:
> > +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN4K);
> > +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
> > +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, val);
> > +    }
> > +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN16K);
> > +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
> > +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, val);
> > +    }
> > +    val = FIELD_EX32(s_accel->info.idr[5], IDR5, GRAN64K);
> > +    if (val < FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
> > +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, val);
> 
> Unless there is some conflicts between the QEMU emulation and the
> SMMU HW, I think we should probably just override these fields to
> the HW values,

The qemu model should be fully independent of the underlying HW, it
should not override from HW.

It should check if the underlying supports the model and fail if it
doesn't.

Jason

