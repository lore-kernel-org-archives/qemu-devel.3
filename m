Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A41C25B78
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 07:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCZsN-0007wS-Ii; Thu, 30 May 2024 03:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.lu@intel.com>)
 id 1sCZsK-0007vv-5V
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:07:00 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.lu@intel.com>)
 id 1sCZsH-0003ij-7W
 for qemu-devel@nongnu.org; Thu, 30 May 2024 03:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717052817; x=1748588817;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=iA+jx9/KYk8lDLas0cIP4DTODGq4DuNh5fCgHvKnd24=;
 b=Ud/QzsCqo74oLKGX8IY/TsgTcmfQ2HnJ8oabXirS9xTldpsFWLeDJzdg
 0xovFAtYJl9TJEET2fk9228TJSm8d/owKhmKktlvq6Xs4QcvwFrsKh4UK
 leHP+Avl+gju+q/wBa05DdeXT7f2V6A1KdQ9zprDijny9jj4f3/LDhTEi
 sF4ez1DZG/4js3jH9IvjcI8fUkYOaSekghohqZx7tGyTPhZZo5rE7+LPK
 Ly7BoOmksadgrH6esAzFeaZRn3ZavMNNCaYbdJRW3xImwKhEga/DOjbRZ
 Q9OD6qehjTV81wr+8iK/hBO4j099Rvi2kFnArEh64471dbqmXWU6APWws A==;
X-CSE-ConnectionGUID: 2Iu5R+vWRV66isbLbbR4QA==
X-CSE-MsgGUID: 2rG1mRevSBWog9hjPWNGWA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13454832"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; d="scan'208";a="13454832"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 00:06:53 -0700
X-CSE-ConnectionGUID: LCuts1d7SkqEaK44iF+7ow==
X-CSE-MsgGUID: kNR0DI40Q1WMP9i3bez9DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; d="scan'208";a="35663892"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 May 2024 00:06:54 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 00:06:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 00:06:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 00:06:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWg3CHggxaMbQKbfiWbL92TxvRvHiXqX0HsCacGn8iQShFJ1h2SCXt9+muX6tpFbBsfYH9Ibi/QVufmrTiWwYFHHItJ2rg5yEp2/BFAQlBx3dRngzQqy7WRwqDzOBoR8Oi/ZIBdoDy7ykcc6YnWy6wq0IUU7f74vauPS27CMOiZSjU/saF1ZD+r337KEg9AwDCThdB+Rl9wr6vINTbX4lR/IoXA94YHnViAyxaOnf+w1zRNOpvEDw/4hjxnsqKW+wXmN9ThShH+T3dV21Pt2HjlzM7uxfNsfWndjm+rnCBsZqUh91TNqhkEM1zNu8bmalmhaczrGtf+wQa355CY3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsr9Y6ixjOspOmGJ62cCjnZTPt9FgjPVrO+gf6QVstU=;
 b=TkGFffDP/SRrk+edrWK3uvxQmilkvMpphOy9/t6IsaIDZSGqmIG3nML3iYGkIVcu9cKT4s4FHIu7iXOHeR5t2h+aACJetfLaAzVFZyyLXrBRGZpj1v26cYKnsa9zq0qdGzMcNN2zYxJ4vjuylML+/esTt4zGmt/y/bNOdkwmHE+wTuLqDUslUnZSs80b+I+vaAF3xAEDH93Y/l26gNUqO8F66MYNtyJ7A5tE1Jqgal/tzFtYyi5EBWlslWZ6J3F1ct5X54Fxbrn4ymnY4mm0GyvvWDV+WGAKafRKirCzcOjFHMBq3+oMAKhFtFF/Xt66OlHMEaUEw9wbDeOcR/GDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB6985.namprd11.prod.outlook.com (2603:10b6:930:57::6)
 by SA2PR11MB4810.namprd11.prod.outlook.com (2603:10b6:806:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 07:06:50 +0000
Received: from CY8PR11MB6985.namprd11.prod.outlook.com
 ([fe80::77ac:889c:cfd9:b9f5]) by CY8PR11MB6985.namprd11.prod.outlook.com
 ([fe80::77ac:889c:cfd9:b9f5%7]) with mapi id 15.20.7611.016; Thu, 30 May 2024
 07:06:50 +0000
Date: Thu, 30 May 2024 15:06:44 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: <qemu-devel@nongnu.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Juro Bystricky
 <juro.bystricky@intel.com>
Subject: [RFC v2 PATCH] docs: Enhance documentation for iommu bypass
Message-ID: <ZlglhDyJ9eupKC6K@ziqianlu-kbl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To CY8PR11MB6985.namprd11.prod.outlook.com
 (2603:10b6:930:57::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB6985:EE_|SA2PR11MB4810:EE_
X-MS-Office365-Filtering-Correlation-Id: d66df39f-ea87-49ed-9d3c-08dc807713b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z9f2rEPBbBT2d9IbrRQm/sQ7/isy6TDMfxHhm/XCSl2PdwNBQ1sfAKKqFw4r?=
 =?us-ascii?Q?fdHFwlmYi273iiHlcYYmOafjIDE2jnOFQbMV+gsftl6qm+8bIVnbGIbfC5U3?=
 =?us-ascii?Q?vdfdZ0Xoqoj2YrCWY1YNWBNzk+CLHuAU9QjkARWKiSZeJHCGTWjDyYR99xpX?=
 =?us-ascii?Q?+1uZm2DzhZhYQUbStIG8ZF3AV13mpxJ/xd8G81MNx8UG2YJIAZ+YEi5/wrnt?=
 =?us-ascii?Q?Bxmm5MUu/ijSKPhbVnLnb9iBboqREvl7w1AKe37TTdQut0tfq7ehlwEN7bqh?=
 =?us-ascii?Q?FNoxVrvVtFQY3tTE1+XoAJ6NL5UCJeJPDuhAqDFRaFgdesVkUab8c54qRf6/?=
 =?us-ascii?Q?dWlTEiLhKnX5Bl9NoyVnP030rR8hqLm44q8P3oQWuPrEtBojRe7Fb0QBHEHM?=
 =?us-ascii?Q?x+gdsp2FG1rY7V37gUf0ZWlWoHPZ3ZWdoBCmAi7yF7WCcMwAq2kBrNspQa2M?=
 =?us-ascii?Q?gep/ibwGDPFa61+UYwa/YLxug9hiD+E8QhLrCwvaqH7JYLk5uL0fvlt6+/Pr?=
 =?us-ascii?Q?L5qupZ1QCXoWMpw6XBWC2PSe0d2ERTwJuqV16g7sT9Ff8/BnoI68EhOUpVzr?=
 =?us-ascii?Q?RipPiMM4OoHzJF55m285+PmLpD7QQV1J6aIfMKqZ/E/1pj0A31Fl2oV1k6NV?=
 =?us-ascii?Q?Z5TX2at2ANywmNal20CuuS4w9vrjwBzWCPBQLHWqCi6EBqNeR+SX8ws77LW3?=
 =?us-ascii?Q?eRDcnXfD6ZKOg4MZWc5Xf/liAHZNa8jd5eA3VpShRqlZN2HCHBGiLb7CgRgT?=
 =?us-ascii?Q?WJjZPuEQ2mFUM6xudehJW2DxZA++3c9mBhP9IEcNtKElyuII7Rj3BK1zrDCq?=
 =?us-ascii?Q?cB3BgsuKNpytSDeONiycNFDRLIYvxhRMzJl6wnOWCJk9RKn7/t1t7jjO63KE?=
 =?us-ascii?Q?MPF+qeEnP7YERijLHIuExK4Juv+sp8GsHfATxYdoJ/ZXyp5c/jS1wQcv2Ir5?=
 =?us-ascii?Q?qkTa1ma9L59pW9S4VoLrNFSdQ3iD7ytBy7qAg/HqzAIslqzGHPQorDmGxvI9?=
 =?us-ascii?Q?qfJWf/wqYk3Jo6UwrWydCtbLeRFRoBxuvGUPkAIB2aMwIAy9fA3pi1t+utQm?=
 =?us-ascii?Q?7NP1pxJXKo4zH/BarMe1pG607uiG49fM1bRo1fDAD/KypJBLOc6iriejfLxG?=
 =?us-ascii?Q?eQD9XNHCDq7+Fovl8CXZYCCx7ry+Ezb7hz3b63gOheWYW9lbOIJ0Usy3fQc8?=
 =?us-ascii?Q?ujIM+6wH7jcdq8V90QCKafnY6pe6vuaj4E2L8Oww/lCtg8jJdrFp88/QfKk?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB6985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eQWFhL3CiZkz9b11K5b35cvN8e+5WhYVsrUEmz9XmdrSGsV/jHwiwoqev4Y1?=
 =?us-ascii?Q?x5vcCN4rVbaLntxKzfE5xKYNxx+QZ6vLqQExmZiI5owa8CX76pCU9H+K/5LJ?=
 =?us-ascii?Q?iUr7ncnxs21TftZHLecwivNLwtQetEora3fvlhKyaCafzrNKU5tVXXYMVtbR?=
 =?us-ascii?Q?9uJkTikecgDrbnkTuEHoRWNtqkH2wLZQNjvfp+2leO7jObwt0ACgeE+mmKYF?=
 =?us-ascii?Q?4bKi9mcm3bBXZnGzIcEIUA+29P7XPvUEwU+W/NWDEbYtVWgdiE+gh89lIkGz?=
 =?us-ascii?Q?DAL92j9WfTRu7yYkvhONPjrAnislc33J8ek24fQeJ03bFHzued9Am/exqdR6?=
 =?us-ascii?Q?LPG1dA+KzssBDzioqwknIF6rIXKD9L3VDFuWQr5pgswp2Vrg3QFkQKS4h8QM?=
 =?us-ascii?Q?niZZSMWcRC1y25gneVtOyUkAtk8f+FPL2jUCluplANv2nLp1ruV3RpOZFkUh?=
 =?us-ascii?Q?uqEdk5Cs4lF6PgvRNePxortqZTGZhUtbMosgszqEeXjy2E1bpnqxdH6ZwAvH?=
 =?us-ascii?Q?OzlWmQe6egef6Ph6JTmI1JNVCmI5BzFfE08uvXz3AEfcglcftBVle4DiaSNC?=
 =?us-ascii?Q?OUyokDYPEpT+z0XyETUtirMAHPGtGG7x4XKgQLY6bi5O49zU5+8lJuRc5llx?=
 =?us-ascii?Q?0dOpXdZpxZ3rvh5OxKkulMfRzENKvsp8xi8Ax9MUrUYBPnoq2o/xkkk5B+QR?=
 =?us-ascii?Q?X6lnuPzjjjTNHjWVjN+xqmpWTcd7RzgHSagKYYXke/hJfjNqzrMoU8yPNBn8?=
 =?us-ascii?Q?tR2TBofcMWsdu4ebHnRq7YE+4wYwF5oNVcth4jcRZxQlyuVEPqo3IgDT5O61?=
 =?us-ascii?Q?TFXw8hpEqlzO8+uNZR9VK8IonYkWWhzHwuM/7O+dEnVadaKPyulHY4TwP5Bd?=
 =?us-ascii?Q?sCEuuCT5I8qus4zWgqshxGEDpU58fZAcgsXpyLYquYuJ15ME3zL1EP+35HfB?=
 =?us-ascii?Q?wt9+QHIlRzG4zPLdgahqz/huhwBt7mN8DmFY8mDdT0/guvPNEFp+1Mp4WZLm?=
 =?us-ascii?Q?0HADrCyFOQPCMFeIuTl6b7RwnAk2c1u5RWEDnN8JLHEA32h2kmIfN9Uv0Lrl?=
 =?us-ascii?Q?cIhTKyDavCwftGIZAgCPab35Z1AOhD45wt/pEtcgqiXixQ8jGKv8ny8dW1l4?=
 =?us-ascii?Q?XzC8lZrPBxz0grFj106VAETxFA+4ILo2+ifJecheXymZhEJFx6jIzy3Fghye?=
 =?us-ascii?Q?XmK0QOlZw4Mz2OXJdLI8/KBjN2VphCX+TbkHv774dbLBgqxLCUymHXQKxrlz?=
 =?us-ascii?Q?4P09KaAlymx6uBd5U1uoI8elVftVxGCvj6qrv9lV4oafVu4NK65IcAqKzK5t?=
 =?us-ascii?Q?HdCjDW6pEN5pkgncRKpy7pOkOgX+o6o22HJ4ohRrq9yQQmghtzosZNFUod/U?=
 =?us-ascii?Q?TeWRxyZbR20tI0LVv5XHbKes4nOlWCoVF4jbx7XuScgC9En+FUmRple77HyP?=
 =?us-ascii?Q?GbDE954yay0PL6KZI9GmadGFcWT5isX7tbKVBWnzQyO+IR3LFv0tuu6JbJKe?=
 =?us-ascii?Q?26U6ldD9+SsJWI+34QiO0+b1TsLEUMbv9HbdBgTWycqnYp+8UXcu/kkDhog6?=
 =?us-ascii?Q?sDVN3s/2XCPzyNKKQJP7RtSM6maK5a057FYNo3kt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d66df39f-ea87-49ed-9d3c-08dc807713b4
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB6985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 07:06:50.0995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wn6/BpnJbATt8wOZ+AujOE6xOYxcBolGZfqbMsISDZKBzvEhHREEth253IGd7EcerxiJW8xLfLChUlOuTlNA6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4810
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=aaron.lu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When Intel vIOMMU is used and irq remapping is enabled, using
bypass_iommu will cause following two callstacks dumped during guest kernel
boot(Linux x86_64) and all PCI devices attached to root bridge lose their MSI
capability and fall back to using IOAPIC:

[    0.960262] ------------[ cut here ]------------
[    0.961245] WARNING: CPU: 3 PID: 1 at drivers/pci/msi/msi.h:121 pci_msi_setup_msi_irqs+0x27/0x40
[    0.963070] Modules linked in:
[    0.963695] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc7-00056-g45db3ab70092 #1
[    0.965225] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[    0.967382] RIP: 0010:pci_msi_setup_msi_irqs+0x27/0x40
[    0.968378] Code: 90 90 90 0f 1f 44 00 00 48 8b 87 30 03 00 00 89 f2 48 85 c0 74 14 f6 40 28 01 74 0e 48 81 c7 c0 00 00 00 31 f6 e9 29 42 9e ff <0f> 0b b8 ed ff ff ff c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00
[    0.971756] RSP: 0000:ffffc90000017988 EFLAGS: 00010246
[    0.972669] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    0.973901] RDX: 0000000000000005 RSI: 0000000000000005 RDI: ffff888100ee1000
[    0.975391] RBP: 0000000000000005 R08: ffff888101f44d90 R09: 0000000000000228
[    0.976629] R10: 0000000000000001 R11: 0000000000008d3f R12: ffffc90000017b80
[    0.977864] R13: ffff888102312000 R14: ffff888100ee1000 R15: 0000000000000005
[    0.979092] FS:  0000000000000000(0000) GS:ffff88817bd80000(0000) knlGS:0000000000000000
[    0.980473] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.981464] CR2: 0000000000000000 CR3: 000000000302e001 CR4: 0000000000770ef0
[    0.982687] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.983919] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.985143] PKRU: 55555554
[    0.985625] Call Trace:
[    0.986056]  <TASK>
[    0.986440]  ? __warn+0x80/0x130
[    0.987014]  ? pci_msi_setup_msi_irqs+0x27/0x40
[    0.987810]  ? report_bug+0x18d/0x1c0
[    0.988443]  ? handle_bug+0x3a/0x70
[    0.989026]  ? exc_invalid_op+0x13/0x60
[    0.989672]  ? asm_exc_invalid_op+0x16/0x20
[    0.990374]  ? pci_msi_setup_msi_irqs+0x27/0x40
[    0.991118]  __pci_enable_msix_range+0x325/0x5b0
[    0.991883]  pci_alloc_irq_vectors_affinity+0xa9/0x110
[    0.992698]  vp_find_vqs_msix+0x1a8/0x4c0
[    0.993332]  vp_find_vqs+0x3a/0x1a0
[    0.993893]  vp_modern_find_vqs+0x17/0x70
[    0.994531]  init_vq+0x3ad/0x410
[    0.995051]  ? __pfx_default_calc_sets+0x10/0x10
[    0.995789]  virtblk_probe+0xeb/0xbc0
[    0.996362]  ? up_write+0x74/0x160
[    0.996900]  ? down_write+0x4d/0x80
[    0.997450]  virtio_dev_probe+0x1bc/0x270
[    0.998059]  really_probe+0xc1/0x390
[    0.998626]  ? __pfx___driver_attach+0x10/0x10
[    0.999288]  __driver_probe_device+0x78/0x150
[    0.999924]  driver_probe_device+0x1f/0x90
[    1.000506]  __driver_attach+0xce/0x1c0
[    1.001073]  bus_for_each_dev+0x70/0xc0
[    1.001638]  bus_add_driver+0x112/0x210
[    1.002191]  driver_register+0x55/0x100
[    1.002760]  virtio_blk_init+0x4c/0x90
[    1.003332]  ? __pfx_virtio_blk_init+0x10/0x10
[    1.003974]  do_one_initcall+0x41/0x240
[    1.004510]  ? kernel_init_freeable+0x240/0x4a0
[    1.005142]  kernel_init_freeable+0x321/0x4a0
[    1.005749]  ? __pfx_kernel_init+0x10/0x10
[    1.006311]  kernel_init+0x16/0x1c0
[    1.006798]  ret_from_fork+0x2d/0x50
[    1.007303]  ? __pfx_kernel_init+0x10/0x10
[    1.007883]  ret_from_fork_asm+0x1a/0x30
[    1.008431]  </TASK>
[    1.008748] ---[ end trace 0000000000000000 ]---

Another callstack happens at pci_msi_teardown_msi_irqs().

Actually every PCI device will trigger these two paths. There are only
two callstack dumps because the two places use WARN_ON_ONCE().

What happened is: when irq remapping is enabled, kernel expects all PCI
device(or its parent bridges) appear in some DMA Remapping Hardware unit
Definition(DRHD)'s device scope list and if not, this device's irq domain
will become NULL and that would make this device's MSI functionality
enabling fail.

Per my understanding, only virtualized system can have such a setup: irq
remapping enabled while not all PCI/PCIe devices appear in a DRHD's
device scope.

Enhance the document by mentioning what could happen when bypass_iommu
is used under Linux guest.

For detailed qemu cmdline and guest kernel dmesg, please see:
https://lore.kernel.org/qemu-devel/20240510072519.GA39314@ziqianlu-desk2/

Reported-by: Juro Bystricky <juro.bystricky@intel.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
v2: make it clear this behaviour is Linux guest specific.

 docs/bypass-iommu.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/bypass-iommu.txt b/docs/bypass-iommu.txt
index e6677bddd3..fa80a5ce1f 100644
--- a/docs/bypass-iommu.txt
+++ b/docs/bypass-iommu.txt
@@ -68,6 +68,12 @@ devices might send malicious dma request to virtual machine if there is no
 iommu isolation. So it would be necessary to only bypass iommu for trusted
 device.
 
+When Intel IOMMU is virtualized, if irq remapping is enabled, PCI and PCIe
+devices that bypassed vIOMMU will have their MSI/MSI-x functionality disabled
+and fall back to IOAPIC under Linux x86_64 guest. If this is not desired,
+disable irq remapping with:
+qemu -device intel-iommu,intremap=off
+
 Implementation
 ==============
 The bypass iommu feature includes:
-- 
2.45.1


