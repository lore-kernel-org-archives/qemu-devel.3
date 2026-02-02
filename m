Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C3EE7DEF2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 15:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvi9-0003g5-BY; Mon, 02 Feb 2026 10:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vmvi6-0003fP-1l; Mon, 02 Feb 2026 10:19:30 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vmvi4-0000lA-IN; Mon, 02 Feb 2026 10:19:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdOljKWk+ZCSnkbwfJ6PmmbQQWZ05EayK0S9KugfxXGdVjqqBRKj9VRdCYmmA0Jv8Tt/dDX1KSmokYJ3WxGRd7u3v4FToVVKP7rXVj5AmvyglrpbEK5pqX7EQ5j1/IG3vSzEV4/mpeLznIWJMs905C8oZyH5KNhjRXPKrwA1eT4HmK0q2Fqmuh3MfPy6M5EZ+AwjtDpAbt/WCBhVleHrgwowo20pFEy5zDZcMfoZZPqp+QewVA2nyIRpWSkZWpWXZQ7XzptPElXbI5jI1p1wAgGb793Nf66Eydp2tzTyIKP/ogoCQNN2DEdU+Rc9Ui7LCENdsscKhSZURjZLmlLdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuDJARtSTMo/HQIiLzFrJOfkXhAOs0e3kY9YRunFhkc=;
 b=IUrDOp8Y4hY3jf84YXI0WXFtEiCv2/sM/OBUfKBmJRbeUWdyEbrGARjLTjbtPJRhHbgfY8ArtDSoz+82vlA0egX3FTa18Tp1NyfBBDvQElUuHRXwAfGs77bq+grkoK7lyKKWzZ4maZ97EV+izb/S/NMZQ8uHqge1Vq7O36D5T3YIhJN3K/7RGUAUX3yuLRjFW4uH9mqmbAcG3t7xIk4Mw6CWNR6njAi3iNeQKHizkKEpbqcmVqob/zgyuTgf9OCPO/Bx9fBW9+0ss5Qhwtg1bdGG5nVBVK297uDHYxX4jNYN3Lf3Dyy6QA74104kaaJ83QqdDzdjtjFNZ9CX3peVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuDJARtSTMo/HQIiLzFrJOfkXhAOs0e3kY9YRunFhkc=;
 b=GisXYg/8w8VzMLSNZ9B7SwkQk3xXbUWmthI9iNayqdyJEgzD52qplga2801Rb+Hviia598vVGYbVXir7iFMEL2s88j4PvWNLaASoyjzcH2ksVA7bXqwzNbWH23vEgsyza5F6f4TD9FEfELPke+HzTKroOwDkdTaP7KnAgAFrwIqi0cqPPCiDSjwyUb70gGg7OnM2lSNgG4OFZ8o8ys67vnOp1CaHdxS3ncDthnQGd1gSQpyOyUWbK1icA0M7jq82wC8vV47bD+rhrNMcDqPkQcP89HsF5Whc+png+vjHuVZnfrq0D4KDBu6mz1FyQHf4lDgknqExARwevqdX5S+yyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 15:19:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 15:19:18 +0000
Date: Mon, 2 Feb 2026 11:19:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v9 31/37] hw/arm/smmuv3-accel: Add property to specify
 OAS bits
Message-ID: <20260202151917.GO2223369@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
 <20260126104342.253965-32-skolothumtho@nvidia.com>
 <d9192ae6-a94f-479a-b19f-734cc52a6be0@redhat.com>
 <CH3PR12MB754867E986856DC7718D4051AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR12MB754867E986856DC7718D4051AB9AA@CH3PR12MB7548.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN2PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::39) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 910c65f9-eed4-475f-bdc4-08de626e6f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uXjJW1YmqNjqHCJndZVMFpFOHJQTJpktvhSyZU9fFjFxg7l3NH82+3R2hsVx?=
 =?us-ascii?Q?H4JERqcsfLfDNTm51g56ae1ISMjONnbzizAvw5RsZM48J5SR/YNjYCHPToO6?=
 =?us-ascii?Q?YRorD98bUh1l+3tVzcfTBlMFsFNkBrHCX+B+iX1Gby1fFpw20ZB9qyBNgnTu?=
 =?us-ascii?Q?djLM7oQh36+emS9uqHqmhkY77/f1BmaF/BQQjbe9DRwMTbvCn7rMzvT4oDfC?=
 =?us-ascii?Q?wn4u05diuyuhd0q22sqzqyeExdBY3nA/roP+n4ggbvfS3Ttn6n9Nk4MmWHGD?=
 =?us-ascii?Q?7G78x0ligTKZEpBk6Wjv7LLC0IrOJMgQ2NE5JmGQ5HrpGJ6BUr9/St4fMLwA?=
 =?us-ascii?Q?QuP4JIcXMoLRgo87ZBdA7XsOFQ2gclRZ8lJpQuqhavXwY+uHSs7ESN4OwK/r?=
 =?us-ascii?Q?nS7c0rHCp8p570waXWh6DrcB0mvfN9lvpmkhrW6w8+MJC9ktO0gP1jElqLNm?=
 =?us-ascii?Q?sSS8meovOSDBkY5V+zxmwdJSue9+bvJUfvtB0+xjrMzwOMnN8iCP1dUQwZ/L?=
 =?us-ascii?Q?tesMf3X0Eftz9v9vdC8i1kOFBhepD7eLhUyQ/n7TvjpKYx8jZ1saMkHyGU06?=
 =?us-ascii?Q?n3DO4pW1+LPWQ7bgg/LC3cWTFXtAKMQ9BvNiiDc1D1CE+04Wm2zYGlGXYAaF?=
 =?us-ascii?Q?AL6cYHLtTi4rO2QeXept+MC5IugaYoWKGUgvRGdSApW8ovpVLLYAGik1M1Xs?=
 =?us-ascii?Q?wQ2z/EHiKp7PSGhPWXRQ0FuL47Z7Y9+AXUjlkZd15EzJd6r2RoEgJrVDzBQd?=
 =?us-ascii?Q?H/ZIMB8a/9XyFvQDyYQsJrOagvnqSbbhMAHQxGWTze98gosMBoOiELLJ37k4?=
 =?us-ascii?Q?VvcuGM90FQQpfz/V1kMsGiXO5oQerdeDJG9J0EZVo7CmNfAtFVpQLwIKNTtc?=
 =?us-ascii?Q?a2Yfike7WjfP6naFNR8z8Bm1PkzloB+ozndTrQoaiarDKfwSqJbNRx7b2BTt?=
 =?us-ascii?Q?ly8KBBaC50t3r6UVKiRjKa8AkK+Hgmsg05kOTGtX0aoVr/pDvUmLpr4gWwe1?=
 =?us-ascii?Q?u2ILhFGONDVQDGw0p1pYVqWlOpYocoHeLrlmF6lReMz9ZFweLSe2POKt12aP?=
 =?us-ascii?Q?Q+XlZssZ9hEuXGh536LP5KvfjCRBKteo2pvCq3OUOWYfuHnQKSJb28jKMf0v?=
 =?us-ascii?Q?7qKUDxLNPI7qeF8vWt24PnQaXYnr8qCYMHPF9Rw12MHmH6hEWpxeHgvuDrnZ?=
 =?us-ascii?Q?d3fRCZ9Id8B4hU0e/ozo8QpCDH8Xt6RROKkoyiMhbMJNu3F+4SxLjxwnnvno?=
 =?us-ascii?Q?NoyHQHYlRzRdiUl0F0zhiwWD1ovxdoR5u6V3Rlf/gBzlyMH51VuEulQyT0jz?=
 =?us-ascii?Q?X0rMbHWN5radAtu6MsVhIb7OC7SU+T7W9KAOKM6URb0Jnnbvf3NjY2Z4pOqZ?=
 =?us-ascii?Q?AgPKGRj7Qk0sKiT+ZwDa4U7K2jRncAqYj7WOAO5GXx2RoiQKcYUfXz6jU68D?=
 =?us-ascii?Q?AfKi7sznI339hjg9rNacAM5Oc/CCDV9gctsYvKOdixopSa3zXGQhPCDQQKtu?=
 =?us-ascii?Q?ywRiQIsPIdN11dy1JYkI13YCaE/JEJQVKpmxH7deQLo7RaHkOqqi3XEaZZZc?=
 =?us-ascii?Q?VtYtZpQ4LufHf//2VFM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR12MB9620.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j1t8Rz19/9TYcvEgFr/kA3XcjeWHMl81bOPjhxI/vWW3iTbL19ZquHO5NXPE?=
 =?us-ascii?Q?aD8v8zePSfELVX8/m7DdTCFoKccUpNzxx/BIBpVa7xYtBDLbwpAjX+77ZVB4?=
 =?us-ascii?Q?feCjs7XTVDfzchM8sIbFQTjk+xUIGo79+ltQLeVBzFUkHFscblhJ/qnWqNoy?=
 =?us-ascii?Q?KT8tgc3Sr7EJtVqBc/c2o77Pkts9LcKyW7skmOla1Ql0ayjzjTU6vNoFs7qe?=
 =?us-ascii?Q?aPP3A2BsbU9r59y5j7+Ir6VxrBFPcrtSUXtBCEnaGh0AsbpBXp8nA82JuN7B?=
 =?us-ascii?Q?lM6At7MRr7M2jqlS9kRaS+gBhjledV8/DocVFIKuqzcBOrydEKiu9mokkwEe?=
 =?us-ascii?Q?pMh/1w0VnW2ud+CBHXiBh+MzO4qxrQQqelEDv3w+lgqMXzskttQmgpH99Q44?=
 =?us-ascii?Q?KzfayuXrAgGRIy5Jnf1qOoleEcSYC2EWeiiB2CJEpYQktjqbH5ah1sMAYafu?=
 =?us-ascii?Q?54RfKKU+sJ3ngR69+W4nUvZoEg9NI7dj5asQU1i4VH+Turz1SWcqIFRYcaz4?=
 =?us-ascii?Q?Yd1jPXGVQ9q66GSKBzq11cMt/gBLC7T1b2CeIW8/AE40ZR0xHY4lS/eQkBY5?=
 =?us-ascii?Q?LrqfFBBCG3cCW0jsmIC62WaJxH928w12ew7MEDVOjZk3Ov4eUpLx2s7HtKq/?=
 =?us-ascii?Q?yHD7vHB9f1kTwll7jbFHFmQ1qQE6V4LjpGXLA22UJq0uBaF0fETiiz51T1X5?=
 =?us-ascii?Q?Dxp9Vq5jf8EmxiGkC70G0+iKZubHmmfjbS6o9dGZRyEiFV+g6x8Cef5tg9j7?=
 =?us-ascii?Q?6RagJ4CfH0QjAeteblyWD4agJwpb7E5ctVvWBbi6qqOc+5TCKSR638phNBLQ?=
 =?us-ascii?Q?KoiBoIUykbV7yBEDM81i7iN5daTQvtJ9ic5NeqvM3OyHHyWheMwnEwA3RAgv?=
 =?us-ascii?Q?9n9OCSFx5r3inTz76tvIat+Eo6reMlB+qBpQGMJy9ysUM4ayo4dQv4UaIbAO?=
 =?us-ascii?Q?zLSAQzZvCS3wtC+cbS7hnlzsPyVeCqSOuBLHWm9gQmAbY/V/l3W6FvrUabmj?=
 =?us-ascii?Q?Tvy2E+OvX3UxZRpKRPRDXbeMTVb36Uw0Y7ox+DJ+IMGdX78lQepBAeSR3Vje?=
 =?us-ascii?Q?XuLwyu7AuKgj991Xp7HFH317otF3Pc08yJonEeqF/Sbvhqy3pNKPJY3pSzl3?=
 =?us-ascii?Q?7hlzpx1D8CQoxVg3Gt1QRy+U+DfKVY2tvIU8hD2GSJgBn4afI10i7sQZKrRR?=
 =?us-ascii?Q?7jRcf/UsRFNFMug6874nveG864Lx/uoybxZcj+8p54oVupaRfKeGJQvOdNwM?=
 =?us-ascii?Q?a/n2OXCsv7vyAQH/bmvO+J6d7dfYcRxzrqOUomK0j9YqJTD8H/1kM1bkSPA/?=
 =?us-ascii?Q?CoCcUw1phckANHv8uThM3ZcEMEM+pSzCtoSnVFdehzhDoBjkYrBO8lXe7+tS?=
 =?us-ascii?Q?Fe/p17YH50gipVXkGrv/ujy/19qTX6H8wJur1p5xXTpC4aPCVyTQJsi9fuN1?=
 =?us-ascii?Q?/eK0hBxx92OXyY34p/LO2vm22ZYp2eJrYsZIaVKI2alkg1zdQH99LWlbxcem?=
 =?us-ascii?Q?QYme0ETPz2AlZJ7cVXRGxzrrK3qAYf4EcNvP6nhCNVOm6SwtLMhYiD6E0tpl?=
 =?us-ascii?Q?qh7PEnr5dBeE5eioijZYsKxppRzzPBsuPiN0NIGkyaU4Mh7CGZaMgbvuCl+k?=
 =?us-ascii?Q?CHZfTXghhgwPChnOcJEnSxwqj1PN8jpIet5Bu/GOCmAtkIGOeW7ytiy0X/At?=
 =?us-ascii?Q?zSSBLusZ+6woh7MX89+e7Rg2gBOQjqZJHnFzl78R2f2yuIPe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910c65f9-eed4-475f-bdc4-08de626e6f42
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 15:19:18.7840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mhwBxgm+MuNC4Uj04Rgpf8DmL7X020JPuOD9xO1ef1RReMEOa5oo8ZtTVCN5qJ7Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=jgg@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Feb 02, 2026 at 03:11:28PM +0000, Shameer Kolothum Thodi wrote:
> > RIL is in IDR3
> > ssidsize in IDR1
> > OAS in IDR5
> > ATS may be more touchy but maybe this can be introspected too?
> 
> Yeah. ATS might require some kernel plumbing as BIOS can override it.

We can treat ATS as a per-PCIe device property.. I think it would be
fine to tell the SMMU that it always has ATS support, it will never do
anything with it unless it sees a PCIe device with an ATS cap, and the
physical STE generated by the hypervisor should sanitize the EATS.

BIOS overriding it should be reflected as the devices being reported
as not supporting ATS, qemu should have a per-device flag to disable
ATS.

Not sure that helps libvirt side though..

Jason

