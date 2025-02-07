Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F69CC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 00:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgBvg-0004aK-JV; Thu, 06 Feb 2025 19:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tgBvc-0004ZI-Ss; Thu, 06 Feb 2025 19:09:05 -0500
Received: from mail-bn1nam02on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:2407::61c]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1tgBva-00019V-NY; Thu, 06 Feb 2025 19:09:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOswSofc5sXxZKZK1cBW5/mGuwAfWRTBTb+ou2gOXjPpS4ABwuVkf2sxJj1S7BOTzP5cX1n8H+IcagFu6Sd39RAtVaeNIqQeWnujGOj3Bii8JKBTClfD2UhnJauukDq/GISrTyopCTuz2TrrxRG8dnBtJaa3B1L8msD0+N6sCVAHem+VtJQQxSq60rSLG5YZW4XTcKcrAaMMyJ9jwUtSu//gMPONAkdMunJx8qNChZt1r9i+sY2zdwxJ3y6zNuuUinkSUNoX3n+e2MWftKib5C+QnbvF5O6YWRzmq16oCaoTLqWrze8K1gdPmBOD995DyN9WT4iyI6HOjc+GB4FYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPs/LcdhyfUoM1ZDnpL3RAt2vSe3DdWH/zVS2FYb8do=;
 b=ySoj307WHfgs/OOy57tQDg6/8zN9wCPlQftrnal7iNfMZqTEs8PAaL6I6mZsKWJb4mtlo6dltBC1ww/qkBFvFy37a5xuzLrKn1C5wcexQYoRJUdv6bc92xnedgcw2el01vbvbvfW+um9DT7MyE7rgjCW3LKN0krQvuua6hcAf/Z66zBgmY7lyh3r3gtb1OLln4cVqoBXthfV6gKFRDZ26QkvANSsQcOxS+Ik4tYSbUM+tqS7h2/etMq5z7C4H3lNNmAkQXVJjyWbUDH1ls4S0TJuNEqcT83sORL2eUAl4hbD9mtGPwJYjVazXK1SfSsH3TCBOd7ZFTlKpfDKs5zrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPs/LcdhyfUoM1ZDnpL3RAt2vSe3DdWH/zVS2FYb8do=;
 b=F/TozAm+RcTOueIYgrEcEaSwpW4ujSf3IBSIgMdQOP1SwV7SgdC7g1DCUU9LX9icVA+AA0pROk30WI1obnBCfTCKjPC5H+Em3ousNDpkF4Ko8N/aZ1MDZFHSZWe1Z6yvSyrwRbDK7a4e3tBey68ijUns94Nohsa1IlvrO30EJr4LzyVlx/fdTtkD5xSpwmxpsnyDMQuWfZ5b07/niDi6DcdmEaEChk+tsvqEhOyJ61CiroB8rqyTV62ag35oSoAhN+j+ef5ND2H0IXL8gHa9ERqH12cy4AKnySEbNAsWLvcgeXrEF8LIxkwJo7vtAhI4dQw5rVuR1AYxXkYI2HMxlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Fri, 7 Feb
 2025 00:08:55 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 00:08:54 +0000
Date: Thu, 6 Feb 2025 20:08:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Message-ID: <20250207000853.GO2960738@nvidia.com>
References: <20250206175843.GI2960738@nvidia.com>
 <13b1d8b97a314cb28b87563fa9b45299@huawei.com>
 <20250206181306.GK2960738@nvidia.com>
 <02a0080a4a1642d69b7f5dd4707a5b3d@huawei.com>
 <20250206182201.GL2960738@nvidia.com>
 <Z6Ucj/u3wt9muakb@Asurada-Nvidia>
 <20250206203855.GM2960738@nvidia.com>
 <Z6UgKHfGD34K3Rcs@Asurada-Nvidia>
 <20250206211113.GN2960738@nvidia.com>
 <Z6U70maXhx8UcMID@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6U70maXhx8UcMID@Asurada-Nvidia>
X-ClientProxiedBy: BN9PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:408:f4::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ae2f13-174f-43f9-5b05-08dd470b9c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1iMeGyuahBdpc9YuhCAMxEhao0OiL9LrkRImQFB73JSHxY51D6KgjqveZ0KQ?=
 =?us-ascii?Q?23ZLaSNozoCbRoSsWn4GEeQel7TM/kqAgj39af4IN1C3B1wKrWkRsQ4lzSqj?=
 =?us-ascii?Q?U0vn60sSDkqGBguZEdzDAehoLZ6jgSXcWE0lqTuylA3pzIs4QaHMQMmeJfcO?=
 =?us-ascii?Q?aDNjZIN7FktWnsOkRy1i0JLZUYzhgVlOy/ya82opLV5cp5tVkXE3wUwcOYnH?=
 =?us-ascii?Q?U9FmceL/bu/hgrsL/XnCcqryP5zjNL1KlPLJl0gigbqHkNmN4vs5L2J7L6jk?=
 =?us-ascii?Q?em01PzRu/k2sWt9ZWOE1yt2YCJB5OwZDYds8Y2uawnQQQtAgRJn/HhylpTgv?=
 =?us-ascii?Q?xWhHdR6Jg1JF67GQBczz9bqgXJpuZjkzgbXfa0kcovk8P9XMue4a1n7gy/Vd?=
 =?us-ascii?Q?E1qUBvsJc6E72aHzIyTaTpi5VKlJwrvKOUg1A+DHYVZ57RDCT0twa1CdSaN0?=
 =?us-ascii?Q?7NYl/HPpyxQwleFFqiV60j4TvwM0/bMGxl4pN7hGtEIGJc/DhsKqXWuf7LwT?=
 =?us-ascii?Q?Ebh0zM+cplqrVUfs4qad3m5rnVt+x9wOGjsuIr9x2IedIm/Xh/baEIIHZFUc?=
 =?us-ascii?Q?9h0VXd8FC7t1PoKNs3rvVmNo4AKxk+lveLIxxmBmfDUW/9/2NE+xL9X4LS0i?=
 =?us-ascii?Q?2YA6NsadJvBbd1k3XYt3f4ZJZfnfPAKmw6UnZ8SFKm2y/nrzVTbKDQXrH+V2?=
 =?us-ascii?Q?f6ZgYAWKOBJ4OkDNdWGubpXxleysxxxy43ybLY1Mk9aqco3zTmN55T0JA1G8?=
 =?us-ascii?Q?IZKtxLYQHi2iaPsnV2Fw7lnTk1jz3knjyl/lJgOHzmgNBN6eibFhBJ/qJGA/?=
 =?us-ascii?Q?nUUrR/tcQSBft2PEQFtcCnsyPqSGqV/pkYz3oUWiJGyAOyYzF0dKTvl+Ya7N?=
 =?us-ascii?Q?Za7MMqlGhwFjVd/5XDtYH6dpnf0CpejInZhWqXR5ax+ELG++NZD1JeytU42f?=
 =?us-ascii?Q?cJ3BTVyMxBwPxS8sCc+4x4x2oO2kSUoCM3zK614Z0rN4it9631Dg3c8nwavm?=
 =?us-ascii?Q?owt4DAmek7ZT+H9k1v5ifRMob2CZ/fDGnxdgSYPBinV9SrOXzL47QCj/WZH1?=
 =?us-ascii?Q?tLYi9VKUQDjoItzTrvdKZ2i9YMaGl5vHugIbzptoYeh2/Hdqn6bi9HAQW8Dt?=
 =?us-ascii?Q?y6D/0/WBoChvhVobFpYQms7NGLixq0WqzZD4nu+0QTsHBdRRw1VcBe7Mp3vC?=
 =?us-ascii?Q?7pWTR4pX9IHdY9z6Uj0NZ3e8NAGex9DaoMP/dctpPhJCC8wYkdh+DRIXWjJZ?=
 =?us-ascii?Q?08Y5QKGX6qV9ay5dAQ4dd5H+xqc05ezAw0IbHQqxmhmk3oFlw7UmMMTlj4md?=
 =?us-ascii?Q?rRpaEvH7aRprfqf2vkQFlIqfXVF2LmlNLxwiMhLlSJi3GMHH/LhU86gclLNK?=
 =?us-ascii?Q?MR96ZcVfd8TAk+Vr8GorzYLTbaLa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vuwLLTb030eg9FzttPA3Y0C/ndHvqhZJXaKSctNLwHGGGpj+pHNh503Vu7O0?=
 =?us-ascii?Q?Rr6Ia3LjVXL4MwznHS75Px5U3vVqxKC+4tZ6H6PPG+Sw83rP5FLz9qQwyazn?=
 =?us-ascii?Q?a4b0h1FBuUouBkc8t9ya+c7484d4Qatq319Kq4WT66wuDpm7h2FYobnzuMms?=
 =?us-ascii?Q?LaoPJNSkYSqvYVoYTIX1v0XT4CTxnHqO/0MH/shACsf6+he5WahdOZV0KUZE?=
 =?us-ascii?Q?eOP8pUtCAOOxbFKEosDKKiNz++mZ8XonoWRYtRYqFop60xst5pDbMR0owm90?=
 =?us-ascii?Q?33jhuaiZA0KU7uQAKAIdMGpiPoYc9InxiYz2kv66Fvcj6WrF5Ef2a3vN7s2A?=
 =?us-ascii?Q?S3JOnLdr1D3NAUX3r2dQZwCvYLYV8VMBAhKv5xHPLo3RpmMe5RsTyv+qTcs2?=
 =?us-ascii?Q?9+2GXxddkzDmqN2M9Inr1HjvqK+yodsVHmgQyagUHrH6vUDpoPZu0zADcS7a?=
 =?us-ascii?Q?iW22ufnFx/H1g/r5fKOCfejrjZ7dksC0axRpdtI8dcDNdNosQswTpHK4vrzz?=
 =?us-ascii?Q?O4gWgVcuZJU5QNwS1ZwVNl1Y0symPVbky0FUQBU/+C7irtcCBqjaMUdHxzKs?=
 =?us-ascii?Q?vASiW0sMOHWmqL7Rlj2IkncL1g02P44iv13Wm2ha4nAjvXyCYA/9VT7EBLRU?=
 =?us-ascii?Q?xIH7fNHVIn4uIGYo65nk7nmY4xPbq+E2TVugatOtl3DKPi9WuNDivxtZUhMF?=
 =?us-ascii?Q?PsF27Stvo7HIQ3/S4TQ6SV16qbii1UjtTZp56LWs41pr4o5iOWEFPS9y9lxC?=
 =?us-ascii?Q?bQ/wt89mYdgzktjzsSJ6aggvMzyRDRluLh4c1bVZ9wAE3GvH4qHI2KhO0nKv?=
 =?us-ascii?Q?9zanp/K3B9wzoul9BsSd8TPrdoyVCr8AhN3WXk8cvMk0ucLyfhl3rx0TKeeq?=
 =?us-ascii?Q?u+4IrThi4y+zyBkEFFIAlm32KDBKZKzebeanLcbqJIUDeqxHfjopGSagoZCe?=
 =?us-ascii?Q?uhvlavgWP/XHSSxEuoRlLVMgpz3uGM6EXxWOBIeLhhO1V8C6stKkSbr1m+tL?=
 =?us-ascii?Q?5wb+7BRcMqG06rEKf7V1OX3/YtZQYRGKL1xmGT45zLB9j+GJHIaSzStQi69l?=
 =?us-ascii?Q?k8Q3WLN/39Fsn4d+oZrW3lDessMs8itPzFe5Oc14L4UC/sXNtLzOw72OpdSE?=
 =?us-ascii?Q?qzOf2XajBGm1snDgS97mvbM/6LEZ0Bt1r7OdhQ9OX5//rgcgaEqf1bTItj20?=
 =?us-ascii?Q?BHCDr5u9/RRLrCUulFMCDUSWTtxWU107NnfnomaUeJX6AYP29cKoP4Ej8l8e?=
 =?us-ascii?Q?PARcyWD7xhc9BNJtd62EaDELXJhkXFQkCWiU0iXcdV/szeDGWwLd+hTuj0pz?=
 =?us-ascii?Q?tVdJ0JRn3xyChz0qMVsejx1yIwT4bG1QaOdv9iqgJKbgp2Tv+CwfXr09eE4u?=
 =?us-ascii?Q?JH3VtvlsVSszAF4y/Z8fP242WsUp6kM3hhbQg/fVPRmz9c8UtjMleiDNhUwY?=
 =?us-ascii?Q?FYXs//iaW1fSFOnOcIV28+8O0VONJEo4GtWgxkeaPP1gMB7ZQc5WT/mIzcy6?=
 =?us-ascii?Q?y+it0ZUON/TMAgto9Gsxy6vGkNnoDIyxsdmTdaPpSNGuLTPnq263gnsupNet?=
 =?us-ascii?Q?ys5k1C2SxyfEwvHCe2U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ae2f13-174f-43f9-5b05-08dd470b9c25
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 00:08:54.8755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2tiSC0gMZwCnTJ4bL56c7OUgs3xx81KB1444xjbjenRJE7Xf9O2SUlvsKp/W0/i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
Received-SPF: softfail client-ip=2a01:111:f403:2407::61c;
 envelope-from=jgg@nvidia.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
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

On Thu, Feb 06, 2025 at 02:46:42PM -0800, Nicolin Chen wrote:
> > You'd use the command line information and wouldn't need GET_HW_INFO,
> > it would be complicated
> 
> Do you mean the "-device arm-smmuv3-accel,id=xx" line? This still
> won't give us the host IDR/IIDR register values to probe a vSMMU,
> unless it has a VFIO device assigned to vSMMU's associated PXB in
> that command line?

Yes, put the IDR registers on the command line too.

Nothing from the host should be copied to the guest without the option
to control it through the command line.

Jason

