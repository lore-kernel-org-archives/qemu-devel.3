Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A41CC25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 07:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9gaO-000434-Hd; Wed, 22 May 2024 03:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.lu@intel.com>)
 id 1s9gaM-00042S-NU
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:40:30 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.lu@intel.com>)
 id 1s9gaJ-0002Aq-Ge
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716363626; x=1747899626;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=yi1oMFbANMNRpCvtb+s8/XOyn1Pp72A//xGmzryHoow=;
 b=GjWjZzYxZrQf5Wp2w5hrdZL/RH+4jmxQl1cpwe08jKgl2BrVLhbYGDGk
 kG9sSmmlfr4QlRlogxXpxo/uQB7J+vpTda3dBhV1q6IV9+307RUAS7Dep
 0IfkxOw2wkHae/6RB7XazesQxFntuGAtZxrfRhQgaa2ZopZ+zacZ/vDCv
 6lZ0C9fnvVInaBIHLgTUEKo9DTCGXdYUD4MvFkpKDMNnPqaxaauNjR8y/
 YyntbGTzQ9Sgjb9gD8zO8woLsJ7/y1Zp6Bfr4mIGXLIf2fcHIroEMQ53g
 iHDOVaKb58ZlqniaB4E6IUVI6jr6Fi2d8c+vX/aOXiacmhcdKwHwxCdfq A==;
X-CSE-ConnectionGUID: ECbXE2eXT02IU4Ln1ufTEQ==
X-CSE-MsgGUID: pqh86+BxR/aollbh6rPTBQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="24003510"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="24003510"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2024 00:40:19 -0700
X-CSE-ConnectionGUID: qSXxhZzmQOefr3Y27IA84Q==
X-CSE-MsgGUID: 74kMYNxoQTmZip0ose3H3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; d="scan'208";a="33617507"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 May 2024 00:40:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 00:40:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 00:40:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 00:40:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA6Gs0rcgUTmpizqWFjqOveRoJh21b3qedNZGcZtsBsacThSaLDedMcWj0zIUhG7cJ0t7RBupNkZDPpvywWkkW+9/GAZqrAobNfmH+lQXPNDvEzv6CqhgAC7jvgxoqp39ktO+0yUDJ5Dp0m+B9ETmB2NIGN/aa382JtwDqKt9fNfxKdfuCENwZ0cro1rTMtJr5mGj8o3fI8Q34ODGDAt1T0cq9ej+77QmDnUnXEBHC2tqhI41TR04O4YsrEzPmHJA6PyxL3NQx1kx6qEK6+El13Aiaa3+cAxnfL26On7/KQz0Mg7u5xhW2ztiMayyipniGpGBhaXdxIH3T7adOydYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPSHCYuP+ZcbZZbpgBfQei47IuAHhq/X4X1yA1evew8=;
 b=J7XjKl+W8OrP5seu4APsNmaIGC8lsvSGP6k2lZlXgoeH6wLPnv4ALoPhtzSIfxYvHCeUpYugyllglIlkqYYPeXIdVdYDYWDKLL9PWg+R9i7IGX/ZF6WiSx5dEyO18dXqN1JpxA4J2nPapTl9chg1z3pBr1HigeQHpj5AOuY9AMFVngnohpLouEet3QaSYrlzFom4X7/507IAwu2krJMN/3bMsEPXNT1l3K4qcOHnY2NjmB2gSrLVY3TN1KBd1Iqq84wBJZpF3uWduaBT6wWkTk0r33ILCE5APZ8qi3cS8SyFEogYA7kHVKodGpBfSH6Q70WQh1Qk5Lz9exJoaYHIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB6985.namprd11.prod.outlook.com (2603:10b6:930:57::6)
 by CYYPR11MB8330.namprd11.prod.outlook.com (2603:10b6:930:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 07:40:13 +0000
Received: from CY8PR11MB6985.namprd11.prod.outlook.com
 ([fe80::77ac:889c:cfd9:b9f5]) by CY8PR11MB6985.namprd11.prod.outlook.com
 ([fe80::77ac:889c:cfd9:b9f5%7]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 07:40:13 +0000
Date: Wed, 22 May 2024 15:40:08 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: <qemu-devel@nongnu.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Juro Bystricky
 <juro.bystricky@intel.com>
Subject: [RFC PATCH] docs: Enhance documentation for iommu bypass
Message-ID: <20240522074008.GA171222@ziqianlu-desk2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: TYAPR01CA0005.jpnprd01.prod.outlook.com (2603:1096:404::17)
 To CY8PR11MB6985.namprd11.prod.outlook.com
 (2603:10b6:930:57::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB6985:EE_|CYYPR11MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4619d3-a08b-439d-dc48-08dc7a326a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y/wec0bIFQy6Rzfeue4WoysqRxJMUa2q4rL5oyJtcq4U/IqOCK+BFzx51yHo?=
 =?us-ascii?Q?nLJsJtNzCRBvJfOV6SD343hkxfkkoaRrBdXumR8A4gGL8vAJFJtRNpnLlKuo?=
 =?us-ascii?Q?iOtPKLOt2Supx+7bo4DK02krHIotCoeIW8v/JQ3hwfWB+qXgL5LVFnTrzFsW?=
 =?us-ascii?Q?35K4FX0V422ozKJ09F23wmthyeQNqHTpiql3GAtLQRutSK9KNDefwZyLTqb1?=
 =?us-ascii?Q?7LuK+ZrRkaRuL9pgxMGd92wKIzI5Eeuoev4P3riRgRZvCXfHjm+sO1gDTbUY?=
 =?us-ascii?Q?iMAioK36jJDqTC+6UuBVGOLlAmQ1DPzMY/iQPr5otJnsv+dmiS5lZ8xCLoPI?=
 =?us-ascii?Q?3+DJvWzo+9JR726RxbTR8qmmPcCEvbLJ+JwMlqtKxrfsbGOvA6hFaoWO7AdZ?=
 =?us-ascii?Q?6Wbhj//FGy5eHZetJIMG+w9SscYLUq6b1nm1DjgV3wDYS5aB2SVnJusNrRxw?=
 =?us-ascii?Q?lJRiHw6kAXdvpoFwEoxW7xgSk7Oph2a5iI9o6Mi+NEClo57rXOmzv1NFaFiq?=
 =?us-ascii?Q?2lNBU3qjMBYkdYvC+vWmKM3TzBSbEe9qBtmZHDHS4yDJlDXYDtPfn7fE8MQj?=
 =?us-ascii?Q?tkrYEJkRuuk+PfLSKSrrTYyYjhELzuolWpzaVG3kZjK9QJWhQveOYaJWnH7Q?=
 =?us-ascii?Q?16+u5Hc9/RL0gVQmhS4/ZV4/7fpb07g6HauwRq/C4cC+iB7nZjnNOl6bb7rQ?=
 =?us-ascii?Q?H4IWN6SERqy9dFNmo2vp6GY2DGhwxvg4RuD7o1+ekRNQVS06cOQiVUMRur0b?=
 =?us-ascii?Q?1h2ViTDvaFnEMvd/xqoVWkvdZlGKICCdRQG6VL51+1PKg/nbanpqzozBeQov?=
 =?us-ascii?Q?A2+lMwKlyt7NhbKErHJckIqjZ2zhVGkv6TccU/N/HMBYWFX0WN92HQWxKca3?=
 =?us-ascii?Q?hlgaVpWm/QiJOLqIdRpGCx7BMXuTUp2uy0wwSpQTltrMgPrEzXFFJzm9TRM/?=
 =?us-ascii?Q?RKEhbiMbgeWa72EK35qry3KKSzyB5Olt3UHmhvwhhch7RcnrY7ijpXgvesuR?=
 =?us-ascii?Q?EVgpcwiNgSK/OD4NKsUkPN5CMaLuBsDjDmykbkIUQKEWbHB8RTe9cmLREonm?=
 =?us-ascii?Q?fQN5SNEHtVdEQYHyF9+UNFBPqHAJExsBXUVMYA3kT4Uv6CYFJQmypl6/HYUf?=
 =?us-ascii?Q?uuAkl9MIGuursEuPNqdX1Mw4I/ci8BlV0H5ATDQeV4sERv9dUEkKqwFqOccm?=
 =?us-ascii?Q?BYAiJLjQvhvipTteqOo1APddbq/iJhgDjAdvcuWkwhTbgz3sm+LSfT2nJVg?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB6985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JbOc9s+o4Eu1tpAHaY+flZCKo17DdTv0FgP6Cs1LTe4yNy9NOeSEH4j1gmlO?=
 =?us-ascii?Q?Z7FBAY0V1f1dS29Ifs0yMmmoBlbloRe/S/go2xOzAx+Ur6HOR4p2YBx0yLg2?=
 =?us-ascii?Q?03tPtboAe4X3Ac/+7LwwDTeiBOM3sUCQ8OKkFpjNVvVWY9v8LEVQ2qQRvfE/?=
 =?us-ascii?Q?VkMyfWxIxio65qkMZ/MtlLYIf9cjLQvBbFtt4OvRugLLD2V8XqW0UFUVyid9?=
 =?us-ascii?Q?9UfU05rpzfsbvfRMi/qekoWb2MKTWWKGlvHtbC8AEzRQ/XTr0d1nFLY3Qj8a?=
 =?us-ascii?Q?1C6geIYqUIwtVFutXVnbp+35yusbK7fTvyIjakU7S73hj1++k4sRB1PG4N0v?=
 =?us-ascii?Q?c0/llBR+435GRABVD5IYqQ/8ICPaZRrrHb+Qx7A8knF/FVS4AbqRic2T+LGj?=
 =?us-ascii?Q?2p0lVcFjNl12FeAReHyyYsfQnZ1/1LVA40IY+2by+4ZTOsTZDNIdp7tGhknj?=
 =?us-ascii?Q?ZQ/znII1t0cugjOJAcgMunf/ej3sy6IscZGiIe1SEPkFcrhHlPiWDivFG/x1?=
 =?us-ascii?Q?eoSonROYLpkPXWf61TkdH/z7hqeSfnBUImPtUi6wJDg8BdDUnVcRVTffmOQ6?=
 =?us-ascii?Q?PUobQvcqXMRRo1NsiEFMH49i3vQ6l6C6ztx5g8bgmrUsZEczBBTK0yuQ3hvA?=
 =?us-ascii?Q?1BAv9QN+Chmc6lYDEae+IOnms4uaYss1sErBMIJAnX3WnFHvvwG1HqbfHHUc?=
 =?us-ascii?Q?WP1bFzO+2CnbYmLVKvb3Z6aTKsb2ANg2y4TQb3CE5fxdP5Y/qprFyIEd0L5z?=
 =?us-ascii?Q?Nuz5V/ZGd32VYa/wBNO1G/v+Fg8qOmYSnhiEg4qYLGMlkLwoS43i++7r6MRB?=
 =?us-ascii?Q?lj4jorMRTAdKbgAmr1zr0qAeR8MGUXHT0xOnScn0W/6QBZH+qTYCm3tveH6q?=
 =?us-ascii?Q?4Y9jF/fAhbguyOT1M1FoXso+S0DmPbsdKSbcGkYOlgVBuGRdQrKgdwxRBqkr?=
 =?us-ascii?Q?eki6KBtFfZBXmlMxHHzQYTLSJ9nCfJiLftNbDm2MF9A4Uv0LIofkPdbAbJ8Y?=
 =?us-ascii?Q?SiqskCqN6P7ZKMbybfCYkxSbn73xWmcXvqTDP3C+5h2v5+8+ElgIRGhM4Pa0?=
 =?us-ascii?Q?twzB5IkjQfu/FodaZaHn3hfibIjNTvfzcbjv/2v5v8oLZAQEdewGCzzG0t4R?=
 =?us-ascii?Q?MfzMFuwoMrtX3Csojca9Z1Qku2wlcSFSVSKuMfRM8akVrjLe/1uZkUfL4eto?=
 =?us-ascii?Q?x6xgGabyo8GEkE0lx6ENladyxOOZCX6a5jMTlhPzxc5ATxvAH7nWcCJ7OrAe?=
 =?us-ascii?Q?j5+P07WsrNeBeP/8dhEJfuaDEFctr3RSjW6PuLU11rap37aPI37ckiHy9u7I?=
 =?us-ascii?Q?xbUmk45hsgFmstD+5ONJeV0c1s1splpejQ8r7KQyCFFNk4rvfDKWTrxKxLsh?=
 =?us-ascii?Q?lpyGxcyT4zkMnvEu6xhhBwRRfQ0Ouyx3bkbjkipfERPuDBrvGDEHEqcHcYjG?=
 =?us-ascii?Q?eETvvMsHgWMY+RjN8Jps33zHJQt0EvfHKpn0k4CdB1lej8+gYvsQYmOvCdCM?=
 =?us-ascii?Q?LDqguqTjrfmsB0NO7Ht8xQSxEx4iro8dkyUgyZDYUrJJS3kHrC1qtEO5Uc7K?=
 =?us-ascii?Q?IgL7TYhuLp5lHDkPc/DcFVIxqUHwSJiAjtdIjTch?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4619d3-a08b-439d-dc48-08dc7a326a66
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB6985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 07:40:13.3419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57/vRJsjwrnx+z84BbOmZ9pKwK9RqPMtbdQGYjIdG9L3c8YHykcXYTWdHiI9+hJzOfCW1LlRY3aUTLlwBFb+dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8330
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=aaron.lu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
bypass_iommu will cause following two callstacks dumped during kernel
boot and all PCI devices attached to root bridge lose their MSI
capabilities and fall back to using IOAPIC:

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
is used.

For detailed qemu cmdline and guest kernel dmesg, please see:
https://lore.kernel.org/qemu-devel/20240510072519.GA39314@ziqianlu-desk2/

Reported-by: Juro Bystricky <juro.bystricky@intel.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 docs/bypass-iommu.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/docs/bypass-iommu.txt b/docs/bypass-iommu.txt
index e6677bddd3..8226f79104 100644
--- a/docs/bypass-iommu.txt
+++ b/docs/bypass-iommu.txt
@@ -68,6 +68,11 @@ devices might send malicious dma request to virtual machine if there is no
 iommu isolation. So it would be necessary to only bypass iommu for trusted
 device.
 
+When Intel IOMMU is virtualized, if irq remapping is enabled, PCI and PCIe
+devices that bypassed vIOMMU will have their MSI/MSI-x functionalities disabled
+and fall back to IOAPIC. If this is not desired, disable irq remapping:
+qemu -device intel-iommu,intremap=off
+
 Implementation
 ==============
 The bypass iommu feature includes:
-- 
2.45.0


