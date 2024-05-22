Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6A0C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 12:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9lB7-0005yl-FA; Wed, 22 May 2024 08:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.lu@intel.com>)
 id 1s9lB4-0005wG-69
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:34:42 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.lu@intel.com>)
 id 1s9lAz-0006F4-Ds
 for qemu-devel@nongnu.org; Wed, 22 May 2024 08:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716381277; x=1747917277;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=pMsKVrvfFRFu1NKG/IzQyqiOIIEVtTWnFVA4K+hOIyc=;
 b=KF2NheNP4JKAZDAsWwaMR1fI7vQI5qvyVGIpNiN0oWyNKZnQZmvC+wYs
 YbPyQkaCV0Vhl19DYj7cB3rAi1DedO+YCD46PH0pOR45dx1ctw8OZGOPG
 z/2OfwnmLrj6EZg9OB9fvGFYE/g/A8aXR+Bmj01nH/lbf2AAUfNPupUBP
 rvELSl4z99DtYlkRDIbCLvQHjIjtRlhmz7e02JhAAbFE46qi+qP+cMvhl
 5PNvP0/a+r915Gaeb0QTL9b7TI5H2LEKv3ychzslBViPhaRuIOl+LcG5Z
 hK6i7nJw5n5H5WLd1VhxUny4otlvFHsqbeTSdJqneXpqrb6/zdVOII9oV w==;
X-CSE-ConnectionGUID: PGY2BEbYSXqmYUU6FvOdRA==
X-CSE-MsgGUID: A3M0L2PQTZ6IwjP+IncZ1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12857750"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="12857750"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2024 05:34:23 -0700
X-CSE-ConnectionGUID: rPkXz2DJRuCGFhu+hwrIsQ==
X-CSE-MsgGUID: 503zcXtXRRaqvMP3Te/k4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33145553"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 May 2024 05:34:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 05:34:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 05:34:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 05:34:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIRJ54N58gl1kjgicWUefWMpOST9086DKFYkxSaxkoaysJeAqa5GdWrIrd6E6ui1WZ/DpRcbW2JnVHVA75iOJU9YAdNLH6CGPCp1qkuyn9liLozI/MxvhZ5BLe77OF2UrghKMkZdSIiPWUYRjcvMoQvaVeOfCHYnaT2d0BHGByE8URuIB4h4Q0kUA497CLLQbPDFb7Z22/X+JGy3OP/Kvmst7uvI5qYeZd/0zUxiWq35rInfTF3BCIrq3ggflrYLogFwMvsBzg2CmCyh1TZidOw2t08nRQFQFVp+6yjbLNCTI5rWx7ALS0CwBSgOidv+3iqsthme4kt/xhVdiS3amg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXXcfVIyN2jK8alqHXrqhkJ4nSccifGLNUwPW1MlWjA=;
 b=mcEymDn6tt7oDTwIwjurUSwnhD6RKNGJjjMPFCnCbQku5EB7vRXWfstAp874ZTDLHldUhxGDBZ4ibh1HHqzHUUZZZGvvtm+T4wtH5TWsZcOPnkoCfl6P0IFoblNaXM6GdL9TmHTBzbcDl1lXHqTCcxbsNrlayhU0Axl2aeOs3YOXsYrhTXobus1RgSxIgaJowOg/37jSzRYZZ4Ti+kg1mYwOypPb85Xdr+xLdNh0D6nbEACyoHTO1sIfK2a7O7k0CiuZwMabhFCfJ0Ixr3rX9w1YW5zaNnhKzr9fjfKknVZdU3gqiZa2GYiJZkf4lN+BxqQZ4W7lhLj/n8iCsD0Ugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB6985.namprd11.prod.outlook.com (2603:10b6:930:57::6)
 by SA1PR11MB6943.namprd11.prod.outlook.com (2603:10b6:806:2bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 12:34:20 +0000
Received: from CY8PR11MB6985.namprd11.prod.outlook.com
 ([fe80::77ac:889c:cfd9:b9f5]) by CY8PR11MB6985.namprd11.prod.outlook.com
 ([fe80::77ac:889c:cfd9:b9f5%7]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 12:34:20 +0000
Date: Wed, 22 May 2024 20:34:13 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Juro Bystricky <juro.bystricky@intel.com>
Subject: Re: [RFC PATCH] docs: Enhance documentation for iommu bypass
Message-ID: <Zk3mRaoDGRj6Bw8J@ziqianlu-kbl>
References: <20240522074008.GA171222@ziqianlu-desk2>
 <20240522051403-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240522051403-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: TYCPR01CA0132.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::17) To CY8PR11MB6985.namprd11.prod.outlook.com
 (2603:10b6:930:57::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB6985:EE_|SA1PR11MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d2a46e-34ca-4a58-773e-08dc7a5b80a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tWExTpj1sW+LoVAEv+wv613Li8r/aAxA3mIxk0lDDvE0uzUdkt0Kxioiknvk?=
 =?us-ascii?Q?2v0OPJzUcen+icNCKtQhtWDUwHfaBFgK1sCwPhHrwfPHM1wpzipP1z05MMu8?=
 =?us-ascii?Q?DryCLR6ZWt6AxPdVBwEAWXovMbygDg3zHZn5B3/cLUg1n/8PnAxv+iaPA1+x?=
 =?us-ascii?Q?GfzD7kIpcaRpcVxnaRgCzhNAki8J8G7ZiD7UYz3PLhFjfGMHhqVBL8vCVMi9?=
 =?us-ascii?Q?YA65mjGyOfeP0ZZIA//9072IP1SxhQY2OE9pOHv3P87wh/ZYVhc7UxeyavlO?=
 =?us-ascii?Q?4nLSSoUvzVv6Q5vNXHtFVq/gkLqgdHw7ItQdfo814fKO8B/LQNzrg6kjG0FE?=
 =?us-ascii?Q?x6Ennp4Ig5Nc+WmbEDtnoomXE1e6inQ1ctm4VqIXs2zPKnOvUj0mVVMtriJK?=
 =?us-ascii?Q?8JnucYZU2V+sX1V+4xVQu1f/NaneaMd5B8YZ1bvPhhSQDoSpnsPJuJLjrV7F?=
 =?us-ascii?Q?ZTKIzKHFFK3rRSuDpSXMaOA3jhfGWEQWtEYLBKUvOwzRX7FW4UBM3FU0w2I7?=
 =?us-ascii?Q?JfaU1FbM6po1i0Y7oaOBzHovx50xfDZB1JcUL/HHCxvR5pndKiLNPQ5PG4O6?=
 =?us-ascii?Q?epwsyxDJr9MC3XSDLgP9OAO4T/T7bmppe0zoL4dAmlGry7untnivyo3N4ADV?=
 =?us-ascii?Q?z+bWrY8N389KYFCz5F5ZwSmk7BrsvJ3pRRD9oIZOquTCa/CE4m03XWNZTA1i?=
 =?us-ascii?Q?D0SzurgxEuj4JB58YXvCUIwXFd/WjiN6EryPgViX8CdXlgM7ThcZIHCtBd3m?=
 =?us-ascii?Q?gVBxnaL3OO+xqdvQFBXOj4VOzlcfZ5isRp/YbnkYue4H5P2xuCVId7ZP58yN?=
 =?us-ascii?Q?hD2vMlcYan4FDArZEaI6V9LlPBkxwtN+lbh/I16ybWOLXmIm9r7yi40F5zvZ?=
 =?us-ascii?Q?OH0KNo005TIjRxS9bKrV5gfPud0bytzOsi800EKnqcCmTmKRfTp8X8AOQP6K?=
 =?us-ascii?Q?qRKj7L5gdS4oFZTItljY6/1nrUqzD0SUpLTRV9jUyjGxcyTS/Pr4av2rDnhb?=
 =?us-ascii?Q?YICO0Bi2MYX+5lqwcowQqtP6DVGyeqDGBOlmlwwP5WlmTx7jHiYizDcY1xjm?=
 =?us-ascii?Q?Wk8WUUOYm6M37bBd4FhJpK8HaKkR517tDETvTZNzkKue2bmzveKtf3zDhGOO?=
 =?us-ascii?Q?ekcnDIXMnhAc0BwGJtaO1vBLfXWn5e6uMnv4SPry+ry79fuxhSHn+1Al9aQ8?=
 =?us-ascii?Q?ELHbha/6EHRVyc6dFi7PgS7E6HHKHk3WEeHfThe40cJZboNzUtiLuwHjvNQ?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB6985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RyFsvazakJlTnylN2CXm4XyLMal3UIyWOXCvR7PCu9WOpg/Y5gof64vYrvmo?=
 =?us-ascii?Q?vaMRQTyH9DXCl+bgHoRMx5K3kpuE1USQrpNPwRVAZkBEfA2VtHtMffBpERBP?=
 =?us-ascii?Q?Ja/DUO7dCQmY+nqQRxL9zYGMJgI3ZpoEWc8H57QcXyXHZTsBH9mFie6S/y5K?=
 =?us-ascii?Q?1K3VYMIjtgTLvDHUnngoG8rqX6Qk0so9j0Xqi2IQE65/FV5G/USLjekttKRs?=
 =?us-ascii?Q?9UpThJh1WxoMU/IeSRH1L3HssR+J0Tht10hzhlCT6ti/qHTc7w6XtXq4LvtH?=
 =?us-ascii?Q?E5Lke9H2w64kDiliqYpwGPiJtp/x4+Cd+jqXT1ey1IdpR7rFyykX3GaU1gLU?=
 =?us-ascii?Q?8mUHTYSR1YQHHQSUe07Ml6QLiCkMoBHvnuejwvd+kvC0S3AQWwJJefN5KYqI?=
 =?us-ascii?Q?9AX8WbDchZ7E8FrrNZxAg81xlnMRackV6OKVwKelxFlp+sn6x3AVsyC4jjGk?=
 =?us-ascii?Q?ajtOUWnNpc9gXDJjK9oeIC/mCxUPf/eOS5ah68D3geZgB5j0mcZyvR9vbhiC?=
 =?us-ascii?Q?w2dS6vfb5wRj7IHkObdweqnwD9XaIunvrXGfxJzwJYO3aHGfDHfozLPLuIKV?=
 =?us-ascii?Q?4opEO3rcxNhbi/iFVWoDL6OykOFu+NbWNEluf6TlCr0zxlfYfkKKO76yAbkr?=
 =?us-ascii?Q?np1KS2O27/tlo/n7+Jp//mHZOf3N5uLbazwxLVbqEgtabNE3JivYQrvWThKq?=
 =?us-ascii?Q?OUBBKfH1PyM0vcUZvTcMWtwAFztHDQO4kqlcdHAHwZvERFZKJRT0mPCOjSai?=
 =?us-ascii?Q?4gGUAKdGBIYXgaw8ol4OQw5+NvuFoVeCiTlX/gFzIaz5BEY3vaummLy68u2R?=
 =?us-ascii?Q?+nAfOLNK/wn8kHrFRyMNgBhexLB4dwVH5Fr6j62O0VpFtfSaAGq5r+nDR5GK?=
 =?us-ascii?Q?AFeKQns4tjMZ6ejOZN9CPbe/Uq5H0e9aydlglN/hT4nCV4pUFF1MDWU0Y1Yk?=
 =?us-ascii?Q?T+PkuIuNsRD/fsk04yiBj5D+3GgXYSyjTj6k1tAotDaMKyO2TJWJFBE7Rxkb?=
 =?us-ascii?Q?yXxz4q3CADAddTp6UoJTfKoAGt7Ib0wchfuM2pULcO0VNUP/wzqSIIpD7n7C?=
 =?us-ascii?Q?SllYx8SNBzizeklKFlQ9/+RWLZChP6e1p2OfuEwHGSrSgXkK3t4bojEy7wt0?=
 =?us-ascii?Q?EiGBndIliNG47oO5Kn+nIpo/6VyooJjrC85VruYC6r+OZWHIAl9pE5hSrCum?=
 =?us-ascii?Q?jW0NWEs19jhc/GXtxYq1lEcU+zhpMBvub1vsR/dYohIpB561HLDKQ2Wk9mMr?=
 =?us-ascii?Q?5CiLcG9ToS3TgqHPT1XXXzVxm59PsQLXYcm90gcBONk2nP+sGW7of8bkcI2J?=
 =?us-ascii?Q?vTEbKw6mkj7+lN93XJKUssU7vsFpaSXHjugGxbSI5Qd+GV228VmrbxYc2/rp?=
 =?us-ascii?Q?RhkkLwxttsNPTJVBHmBsQpNEH7xGHLqMLPlY+oUYXSkTIaj9nAyepgpfxGIc?=
 =?us-ascii?Q?vnaZgMZAUGXEfGjyKxEqE6VRC8Yd+Y9ZCh/DShiOYC/6Yxptk3yaiFuCS3G0?=
 =?us-ascii?Q?ufRDDyiE2DePHtqgpL7fhitZyWVDkx05nMk0VIGND1JFkpUz20xhO37My/LG?=
 =?us-ascii?Q?4kWmhpvnBCX4BSzI95xUW+JsXGpPHVV9wQCAUlEQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d2a46e-34ca-4a58-773e-08dc7a5b80a6
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB6985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 12:34:20.0415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHxepngbVws4XYKyvob4K/fauVcAS7GofzXzud/1gGp/14T6c5p3IyZOZZnEZj8zOF7PZkvqeFyXwxiIWkBGoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6943
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=aaron.lu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 22, 2024 at 05:28:50AM -0400, Michael S. Tsirkin wrote:
> On Wed, May 22, 2024 at 03:40:08PM +0800, Aaron Lu wrote:
> > When Intel vIOMMU is used and irq remapping is enabled, using
> > bypass_iommu will cause following two callstacks dumped during kernel
> > boot and all PCI devices attached to root bridge lose their MSI
> > capabilities and fall back to using IOAPIC:
> > 
> > [    0.960262] ------------[ cut here ]------------
> > [    0.961245] WARNING: CPU: 3 PID: 1 at drivers/pci/msi/msi.h:121 pci_msi_setup_msi_irqs+0x27/0x40
> > [    0.963070] Modules linked in:
> > [    0.963695] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc7-00056-g45db3ab70092 #1
> > [    0.965225] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > [    0.967382] RIP: 0010:pci_msi_setup_msi_irqs+0x27/0x40
> > [    0.968378] Code: 90 90 90 0f 1f 44 00 00 48 8b 87 30 03 00 00 89 f2 48 85 c0 74 14 f6 40 28 01 74 0e 48 81 c7 c0 00 00 00 31 f6 e9 29 42 9e ff <0f> 0b b8 ed ff ff ff c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00
> > [    0.971756] RSP: 0000:ffffc90000017988 EFLAGS: 00010246
> > [    0.972669] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> > [    0.973901] RDX: 0000000000000005 RSI: 0000000000000005 RDI: ffff888100ee1000
> > [    0.975391] RBP: 0000000000000005 R08: ffff888101f44d90 R09: 0000000000000228
> > [    0.976629] R10: 0000000000000001 R11: 0000000000008d3f R12: ffffc90000017b80
> > [    0.977864] R13: ffff888102312000 R14: ffff888100ee1000 R15: 0000000000000005
> > [    0.979092] FS:  0000000000000000(0000) GS:ffff88817bd80000(0000) knlGS:0000000000000000
> > [    0.980473] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    0.981464] CR2: 0000000000000000 CR3: 000000000302e001 CR4: 0000000000770ef0
> > [    0.982687] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [    0.983919] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [    0.985143] PKRU: 55555554
> > [    0.985625] Call Trace:
> > [    0.986056]  <TASK>
> > [    0.986440]  ? __warn+0x80/0x130
> > [    0.987014]  ? pci_msi_setup_msi_irqs+0x27/0x40
> > [    0.987810]  ? report_bug+0x18d/0x1c0
> > [    0.988443]  ? handle_bug+0x3a/0x70
> > [    0.989026]  ? exc_invalid_op+0x13/0x60
> > [    0.989672]  ? asm_exc_invalid_op+0x16/0x20
> > [    0.990374]  ? pci_msi_setup_msi_irqs+0x27/0x40
> > [    0.991118]  __pci_enable_msix_range+0x325/0x5b0
> > [    0.991883]  pci_alloc_irq_vectors_affinity+0xa9/0x110
> > [    0.992698]  vp_find_vqs_msix+0x1a8/0x4c0
> > [    0.993332]  vp_find_vqs+0x3a/0x1a0
> > [    0.993893]  vp_modern_find_vqs+0x17/0x70
> > [    0.994531]  init_vq+0x3ad/0x410
> > [    0.995051]  ? __pfx_default_calc_sets+0x10/0x10
> > [    0.995789]  virtblk_probe+0xeb/0xbc0
> > [    0.996362]  ? up_write+0x74/0x160
> > [    0.996900]  ? down_write+0x4d/0x80
> > [    0.997450]  virtio_dev_probe+0x1bc/0x270
> > [    0.998059]  really_probe+0xc1/0x390
> > [    0.998626]  ? __pfx___driver_attach+0x10/0x10
> > [    0.999288]  __driver_probe_device+0x78/0x150
> > [    0.999924]  driver_probe_device+0x1f/0x90
> > [    1.000506]  __driver_attach+0xce/0x1c0
> > [    1.001073]  bus_for_each_dev+0x70/0xc0
> > [    1.001638]  bus_add_driver+0x112/0x210
> > [    1.002191]  driver_register+0x55/0x100
> > [    1.002760]  virtio_blk_init+0x4c/0x90
> > [    1.003332]  ? __pfx_virtio_blk_init+0x10/0x10
> > [    1.003974]  do_one_initcall+0x41/0x240
> > [    1.004510]  ? kernel_init_freeable+0x240/0x4a0
> > [    1.005142]  kernel_init_freeable+0x321/0x4a0
> > [    1.005749]  ? __pfx_kernel_init+0x10/0x10
> > [    1.006311]  kernel_init+0x16/0x1c0
> > [    1.006798]  ret_from_fork+0x2d/0x50
> > [    1.007303]  ? __pfx_kernel_init+0x10/0x10
> > [    1.007883]  ret_from_fork_asm+0x1a/0x30
> > [    1.008431]  </TASK>
> > [    1.008748] ---[ end trace 0000000000000000 ]---
> > 
> > Another callstack happens at pci_msi_teardown_msi_irqs().
> > 
> > Actually every PCI device will trigger these two paths. There are only
> > two callstack dumps because the two places use WARN_ON_ONCE().
> > 
> > What happened is: when irq remapping is enabled, kernel expects all PCI
> > device(or its parent bridges) appear in some DMA Remapping Hardware unit
> > Definition(DRHD)'s device scope list and if not, this device's irq domain
> > will become NULL and that would make this device's MSI functionality
> > enabling fail.
> > 
> > Per my understanding, only virtualized system can have such a setup: irq
> > remapping enabled while not all PCI/PCIe devices appear in a DRHD's
> > device scope.
> > 
> > Enhance the document by mentioning what could happen when bypass_iommu
> > is used.
> > 
> > For detailed qemu cmdline and guest kernel dmesg, please see:
> > https://lore.kernel.org/qemu-devel/20240510072519.GA39314@ziqianlu-desk2/
> > 
> > Reported-by: Juro Bystricky <juro.bystricky@intel.com>
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> 
> Is this issue specific to Linux?

Ah, to be honest, I have never tried any other guest OS.

I just did a quick check using FreeBSD 13.2 and it appears FreeBSD
doesn't enable MSI for PCI devices even without vIOMMU:

root@bsdvm:~ # lspci
... ...
00:03.0 SCSI storage controller: Red Hat, Inc. Virtio block device
        Subsystem: Red Hat, Inc. Device 0002
pcilib: 0000:00:03.0 64-bit device address ignored.
        Flags: bus master, fast devsel, latency 0, IRQ 23  (<-note here)
        I/O ports at c000
        Memory at fc053000 (32-bit, non-prefetchable)
        Memory at <unassigned> (64-bit, prefetchable)
        Memory at <unassigned> (32-bit, non-prefetchable)
        Capabilities: [98] MSI-X: Enable- Count=9 Masked-  (<-and here)

and from dmesg, I saw:
root@bsdvm:~ # dmesg |grep apic
ioapic0 <Version 2.0> irqs 0-23

So it appears MSI functionality is indeed not enabled even without using
vIOMMU. Adding vIOMMU and bypass iommu doesn't change anything.

But I rarely use FreeBSD so I may miss something here.

I do not have Windows VM right now and will report back once I finished
testing there.

> > ---
> >  docs/bypass-iommu.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/docs/bypass-iommu.txt b/docs/bypass-iommu.txt
> > index e6677bddd3..8226f79104 100644
> > --- a/docs/bypass-iommu.txt
> > +++ b/docs/bypass-iommu.txt
> > @@ -68,6 +68,11 @@ devices might send malicious dma request to virtual machine if there is no
> >  iommu isolation. So it would be necessary to only bypass iommu for trusted
> >  device.
> >  
> > +When Intel IOMMU is virtualized, if irq remapping is enabled, PCI and PCIe
> > +devices that bypassed vIOMMU will have their MSI/MSI-x functionalities disabled
> 
> functionality

Will correct this, thanks.

> > +and fall back to IOAPIC. If this is not desired, disable irq remapping:
> > +qemu -device intel-iommu,intremap=off
> > +
> >  Implementation
> >  ==============
> >  The bypass iommu feature includes:
> > -- 
> > 2.45.0
> 

