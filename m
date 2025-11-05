Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD08CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 18:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGiiD-0008SL-Qn; Wed, 05 Nov 2025 13:58:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGiiB-0008Rr-Q2; Wed, 05 Nov 2025 13:58:27 -0500
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1vGiiA-0007e9-5W; Wed, 05 Nov 2025 13:58:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WnEKxERg2bcoKe0Gl+As8CYIoAsbl9Du6ajxm7YVH3NRPK5j6oEOpDM4K9NWfmXOD45pqwiQCTHSW+Dp/5yr4S35uMXFG+x32m+uo7WAzxgKkIyC3xwA/UgA3KZih05jwGVxpTdZ8D2GjILUV5gN60aOOZluMJgSQ7XLAFZ3zYE2bdRkp89Gioxh523nunLNtEBqnjFwrUzF6nnAzgWx8QcqgxScE7yrwdbxETO02BHEfyZC2VPxslGpQw5/N8bSsQApA5bpOlbaj161H0wLX2rqhvR651eMDTkmICG4QziSZsrzZ4EOvC/AikumunHo5hhvVvUgdRT0Q6ghHhofHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5j410Bo1UD6AoN/fZR3WEL6fDPrzNL/U6dAcfIfqkE=;
 b=YjJSf7kFQGMHFOC0gP8Ry9+SXSGc429YSmxinNE8Gn31/eAVnQPlj7xLjcN5wiMSpleS2+q0eyPJVbHyc7HTQE9QKog4IqRK0G73TtrhcOkSxHO4HZQqdEk7T2ffKwMj9gRK/4eo8Sh02gU5WpynB4ti8Dsu4qcUCwBoZT5TgTyBjj6v1bRe0Ejdi76YgnqDaWS+Tys9R6bm7M2GZnNxOyCVafQeTKLefYHKn8lmD2I3pTzdluuK5pFXSur+sfeE7SZtHS3ln6xa5ybiz5Aa7ZQA3n6CrLZ19bCau7730f9G0ELhKm6wHijgxiK7Juq/7FPOPnIG9Xv0HCNrbeBI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5j410Bo1UD6AoN/fZR3WEL6fDPrzNL/U6dAcfIfqkE=;
 b=W77L/V74sSib1ebFiXTiCPMC14P6CEAuMgpyhWSdZmiKNAE83mgIQ46lTfqFP6D+KZqxQ/0XVt9PI2e/Z9SCYu1L3NzVuKzL94rM1rZ9ui8sPZlGAD1aJFMDUVDRzPY10wZ3Eh8b9tGi9ypnDT9fh5k96Zteh+hmEV871cpDusoUCVGR/QsG2rbiSW1RsDW2V+KV/r0UJmp61wIIatRjPaLwm8sU3g9Cm54ujw+WJUSpL1iwUnWjx4PHcEO7vRuxjN/Mj0zKSAjorWtE8hSq2oZ/9wFyAbaCJKLVn3qrs9PEGuXDu3FfYnMXf+xDDBTGJxuf7tYoaZEvVXXg4OeHKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 18:58:17 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 18:58:17 +0000
Date: Wed, 5 Nov 2025 14:58:16 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Message-ID: <20251105185816.GW1537560@nvidia.com>
References: <20251031105005.24618-16-skolothumtho@nvidia.com>
 <318947de-4467-4ced-a5d2-929e3df210ef@redhat.com>
 <CH3PR12MB754815B9B902E7EF66B0A1B9ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <85f315a2-e49a-4330-9419-48a8a3a4a3e3@redhat.com>
 <CH3PR12MB754844745DF256D7FF2CB07AABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <e4fd6d1e-3fca-457b-ac6a-69e721d799f4@redhat.com>
 <CH3PR12MB75489F2161213432D34688D2ABC5A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <7ac24d9a-0caf-48cb-832c-812fecc5c82c@redhat.com>
 <20251105181049.GU1537560@nvidia.com>
 <aQuYZM/8SX+RtDtv@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQuYZM/8SX+RtDtv@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR15CA0008.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::21) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN2PR12MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: 299cb526-112e-4a20-f11f-08de1c9d4776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J3wfJ+CupEojpEsVN5JOsDpv9npjm7d0xigUgMcXDd6YXoQtMPiawHdYShLR?=
 =?us-ascii?Q?tqxWyoZDfvaDkTEOEdKxKMF2SoIDDMVU6WQ6bI/Fp8TMsGFnLVXfSrd5qq4r?=
 =?us-ascii?Q?v+qR8QgmiQvC/N2sj8ZiwlopgXxVwC3dfSVRCcn7R2qcXWA1vJukBffd44MJ?=
 =?us-ascii?Q?2MG6mQhKL/69L3t5GpxCo3mof8/I7ya7LRrG0scsAqUW3eeD9f+0CNtSJ4jZ?=
 =?us-ascii?Q?J/oC2pyNaPswYpe0KZZtJi+0Fi33Ylh96KTfHFKYhyha5YayeIFhuepzyFP9?=
 =?us-ascii?Q?p+RpZjXXUcbUkgtCJSP8X5EVXUbTsiV342yAh9IAx2pubFFqQSyoOH+d0tid?=
 =?us-ascii?Q?RnqtvkwSoy4/tJ+Gn3HdZZb0rcr40DOC8ligE9ZdOYZWtfJ7wyMu0IjLLIEV?=
 =?us-ascii?Q?iXFHxDB3FcKEwRbkpKld5H6NOKdW806AyG+oWrq+E5Mzu6JimQ9NHSdFRMvJ?=
 =?us-ascii?Q?uI8i2jgkyvDGihV9Znz19GAqHBqh2WDrAI8MfpxD/9OnI61/D/OUoRr6Ka81?=
 =?us-ascii?Q?wXXgXDFO3M9EzuEU/+hoD/MJqVTB/jMha/F1s4Mfa2+T0AGRt5HlaSWz2lm0?=
 =?us-ascii?Q?VJEKUSZCe5U+IyjlLCTE5qL3cwtwBZqcRdkvbU7l4bW4lt9NOhpkNMX3OUJP?=
 =?us-ascii?Q?i3774nqqxqxzmNbeunnXSyl9jUH9O3k1tnlluk0tCpYrQ5mmvcnsrp0dGHkR?=
 =?us-ascii?Q?eBclRZ4jJqMhRcC9fXk+jDmRq4dT/BwDPWWRcCeJtk1bjKT5ns/SSiUWY4KH?=
 =?us-ascii?Q?hzVmx24Vgxe+SgJc6TFZ+xEIKm5SszjafKe1lk+zhr3WB0CjooRw4Sds7fJS?=
 =?us-ascii?Q?+E8+5pIoIZ/zUBSkNdnCRWu1StpLQ5ptczXgmiOsojYyFodzxh+X4OZPWiD+?=
 =?us-ascii?Q?x7H3t289oZOfhjFEjpf1UojmdvZvZTut74yFfb56FCPUVXvSuxaBbIFwiP1Q?=
 =?us-ascii?Q?thNrdJ3AD8wH1rGn+QeLbK15KaqBYUH/PpEa4fg11UIdelvSpLM3rL63+joy?=
 =?us-ascii?Q?MSa+qWdW+fedhrmBMlmbhP7eIJNb9Lneei0eavhzsWVsxpIhoSZiVlZsv3WT?=
 =?us-ascii?Q?Ng/ZmEOh8IYRK38qxV/gbGb84K7LDxsUFGVtGyFS8PXLmZAXo3QPNESN9WSD?=
 =?us-ascii?Q?I6WAi9ESadef6b/Cr9rL2L8rO16OdRGzHAXMdsjDO8erWRkx7ArhSHeXHE50?=
 =?us-ascii?Q?pQi2NG/3hhHa50dPKWx5lfJmmlyeyRMmqxF0GDdsE2Cpfw7QUYuffXIAGMYa?=
 =?us-ascii?Q?RTSa+1WFh4TljJFZxgPFFGRQ6bK/b5xaGI+5IORa6+eo1yETxQ57k/KghmIv?=
 =?us-ascii?Q?3WEpnk7ryVXchsQy7nDKi+KTcDgsIWw26Sz8QNx9z/x/09ZPp7wUv8+PrgOy?=
 =?us-ascii?Q?OG2zSXr65wjS8Y6qxxLjJ2gjEgF4t7jocTgExtHc7QLWDLs4sQJKKlDsi8kK?=
 =?us-ascii?Q?vncQ5EF9cY14IWYTwmd/Ln/m9TT90lzK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3613.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e2xrV8v4AP0th3iekCoRekq6HjoZZQqp3dl5oCYjru97PaC3quC4pTbKeeAy?=
 =?us-ascii?Q?m46NdROg7ixHMd+WQbKM2R4UfB82qHXu7bfufRjQbUQw7n/PKKz8ONCgOOza?=
 =?us-ascii?Q?iWAxOmiW0IJYiIl8ZTStqvu8ejbdw8VFSKId2owlWxpKJcpAZNorfapCXh7V?=
 =?us-ascii?Q?q+aSgjnTLPsX10yty2uDoVHXGphBip27bs1pKvAQeWn1KwJ7H/77NqJQvxap?=
 =?us-ascii?Q?irdNRJdz6agH5hzGo7nFpda0beAgGBHAO6rRFythhwj0XjoQMAOYV2wStQA+?=
 =?us-ascii?Q?JYnHeuPuqsJ4JrWy+ZpZM29XiE8lP2IGuP6E2PxcvjF+0hBSHIUAOYm5T9kC?=
 =?us-ascii?Q?lbBJ1wkyRCxAIYu5MmbWm/eYWwgW/nI0NvYJ1OxbzKZE/0KnrQwXKF53PN05?=
 =?us-ascii?Q?slKTIDColz7O++y8qwxwM/JvM4M3L+Kq2Jawc3KNcJTXCgvX173/yhmDS2/X?=
 =?us-ascii?Q?OQaxT9KC97Y7Ql2DokvyeAoqOjeFdmSf2YrIZ5qqzNimbGS/y40Njpu6cBom?=
 =?us-ascii?Q?k3OUEhwBRcp81DdaMld7ndW6NKa6TsXKfe4jXOo2pzQ9OckD3ljybL6ZStMk?=
 =?us-ascii?Q?mini8Kj4+JRGEP/4lu1JCU83954X2v69LbpuI76tKaBv+Skc+15i6jdeMuou?=
 =?us-ascii?Q?vVRLCzNdXda8Z+P+YSBfxK4IFtY6RFf9HKgF29ta07oEb+4VdThxh7IisCJT?=
 =?us-ascii?Q?VzIX9h9oMz0X4AwDZeYtD0rJVIEob+xnAXwoFA3XEdH54uwvQaie6W/yqcaU?=
 =?us-ascii?Q?Uh5BpTKR6tNIOmSFwWvNu9eBqXW/v8rub2QEMLo7UXNqk1o+jr2rj4RQ/lWn?=
 =?us-ascii?Q?HlJ+02aw5qOHe36wsNpS1A0k3ljwNlVcswLQJrgtbxTKN/FlZ2ZHWf6QhAgv?=
 =?us-ascii?Q?1nF/GavOynMxexV7yObPz99rh6Sb9YpL6E798OhLcDb0nIBIs+BM+KyapXBx?=
 =?us-ascii?Q?Mw+59qa7VAeQjc65oDqC2NZ0Cmq+UXVvDj5uAICb8yX/e8M/ngRNOR/95Lag?=
 =?us-ascii?Q?yRwDokYsReYkpHxlkt+zkV+tOA7mcLdmwoCd+8pX3dHowQmL7UxFuBYw1+fA?=
 =?us-ascii?Q?h2NKaXH1SQ54XkHQlCyQhT6mYK6Q2MGJ3STXYNq4agjpdTSTbcisSD1LBjNJ?=
 =?us-ascii?Q?YGLUns0vw46H/Ks3JZqJPwDIcPSKpM2+ABqNSdkaTkIaiDoRGNZDXmrda9dX?=
 =?us-ascii?Q?bwm/pK0GesPAEDmW9FukMjbrEiWpxWmHa5jXSXrZsOGZ1tu7MmI79LyLt4Dz?=
 =?us-ascii?Q?Bv1pVTadWoPg8z/HXpiIPcTLhFTJyiNitxs7uU1svwoNhg3pmTd86F0bhPSu?=
 =?us-ascii?Q?WEs9MRSvoNmoqzBwUhOAb97E3PrVtHDrWthPgSDMTOXaezkgIGU422DXthm7?=
 =?us-ascii?Q?0dJJoFg5g1FuTwMit1tIoBfodyOw6ZpItaDPgDjdVvB4NWTOgplyqEe5afnQ?=
 =?us-ascii?Q?Vymm0ntwor2nFn9BXyEgEzxlIpwc1DsLNkmEEN7UJx0M3KcDNUJxEu2VGdvQ?=
 =?us-ascii?Q?FFIGHwGcXaErqj7zwBvE1s41JHkSvpG0mWab7Y4jYmERbJ/fwSSRJiCLobMi?=
 =?us-ascii?Q?ckvcPUHNlgm6Idl7ezI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299cb526-112e-4a20-f11f-08de1c9d4776
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 18:58:16.9550 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wi7ruLKpOmqdtalTG9q7NA21YNPwa/GenBdI4MKpOM9hBZOuTQqShYT99yfe4Qp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=jgg@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Wed, Nov 05, 2025 at 10:33:08AM -0800, Nicolin Chen wrote:
> On Wed, Nov 05, 2025 at 02:10:49PM -0400, Jason Gunthorpe wrote:
> > On Wed, Nov 05, 2025 at 06:25:05PM +0100, Eric Auger wrote:
> > > if the guest doorbell address is wrong because not properly translated,
> > > vgic_msi_to_its() will fail to identify the ITS to inject the MSI in.
> > > See kernel kvm/vgic/vgic-its.c vgic_msi_to_its and
> > > vgic_its_inject_msi
> > 
> > Which has been exactly my point to Nicolin. There is no way to
> > "properly translate" the vMSI address in a HW accelerated SMMU
> > emulation.
> 
> Hmm, I still can't connect the dots here. QEMU knows where the
> guest CD table is to get the stage-1 translation table to walk
> through. We could choose to not let it walk through. Yet, why?

You cannot walk any tables in guest memory without fully trapping all
invalidation on all command queues. Like real HW qemu needs to fence
its walks with any concurrent invalidate & sync to ensure it doesn't
walk into a UAF situation.

Since we can't trap or mediate vCMDQ the walking simply cannot be
done.

Thus, the general principle of the HW accelerated vSMMU is that it
NEVER walks any of these guest tables for any reason.

Thus, we cannot do anything with vMSI address beyond program it
directly into a real PCI device so it undergoes real HW translation.

Jason

