Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0620CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 06:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v220r-0004ii-2z; Fri, 26 Sep 2025 02:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v220n-0004iP-Rs; Fri, 26 Sep 2025 02:32:58 -0400
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v220f-0000rb-1a; Fri, 26 Sep 2025 02:32:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2MUS1RcVAGOTBYJfyzci6NUQkbCwUUNFKZjkcNbSZpxGat91NnV+28VullU6MYHFPpi3Uq4cv7haKHelX5yPScgQhJpkbfYS+qYlAMhDW1TOZWNK6/0ZKUBQxK49G3APVxI5YgHGVvjKAHkDerUhefy8QyWDLyyY3gRA0B7GAzGcmdW9jnEf7wnU1ncGZrWXFihBSVukshP87z/6SuYi3aTGGU5ME3XY6psCgkM5WKIk2nC74xtsYx3po/cwroqik/310tuFBxBXWiCLxGA6NUgm+HGOWyux8Tzvu/sjstQRXk971/4FU3166yozJMkbqLMcxXBAjsUAdlCHjKUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNLcaK02sGFoQ1WZGTDG2YNOUc0VuIg6qVsnQjE9O08=;
 b=pjFe3VVZ7bZIqsTLQYTVBWCwocXswH6oGasBJ4rmpbvmppX71BUIr5GwfoDvryQMNpEUIWH/Zj8vwRb8qwJglyl1StvBI4MWv9vnhDJ+91NLBf1Rbc0uAEusM9adQ0nVp8fsYXV6f7hR7UyAkCCIR8lgdRB1/Yvl32O7aN+D/3wxwuW5udbiORiYzH9mb0Ax/ERhlPmvzWA2Yxh0qgaCpsJ5xdGz0XfPwOyQrv1tTxrjMB1WB+vULYQb21utuCQUtv9u3g8INrmHvWeA+rr7voZZMQM7dPV70Norc3+S/j+Za3TZWILgKwRA2VFGuPNhVqV8mwO8bLmP7svBqydxwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNLcaK02sGFoQ1WZGTDG2YNOUc0VuIg6qVsnQjE9O08=;
 b=eKk/Tt3Z3/hSe+hnVz1VX62pTOlIjrD7W8iJmnYqxyd5Fey3cQmk9oFKR+IOyPJXOOq0ErV1b5M5l3jxxDrtMhNJ0p30pPMuHPUm7T48b2w2ngDmhD40AzGVe9ajXUzQJspKFSXGruLkg1tNJUGD8YHPkPDAu+uGhCiSrTiEr/s=
Received: from BYAPR08CA0003.namprd08.prod.outlook.com (2603:10b6:a03:100::16)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Fri, 26 Sep
 2025 06:32:29 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::17) by BYAPR08CA0003.outlook.office365.com
 (2603:10b6:a03:100::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.12 via Frontend Transport; Fri,
 26 Sep 2025 06:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 06:32:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 23:32:28 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 25 Sep
 2025 23:32:28 -0700
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 25 Sep 2025 23:32:26 -0700
Date: Fri, 26 Sep 2025 08:32:21 +0200
From: Luc Michel <luc.michel@amd.com>
To: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, "Sai
 Pavan Boddu" <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v5 02/47] hw/arm/xlnx-versal: prepare for FDT creation
Message-ID: <aNYzRquHGMEG3LvF@XFR-LUMICHEL-L2.amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
 <20250912100059.103997-3-luc.michel@amd.com>
 <aMRVsn6cbN7fjPuq@zapote>
 <aMkR9fr7ITfggWV7@XFR-LUMICHEL-L2.amd.com>
 <aMugpMt4qU4XSnay@zapote> <aNWN3KxHvMlszraG@zapote>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aNWN3KxHvMlszraG@zapote>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|SJ1PR12MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dec5373-8226-42fd-b39a-08ddfcc67710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dn6vJ7uj86aueoE8gx+rhHuZXBiQBX2Y8cbTiIFkPJ8mjDX18v9v9HWOKXKT?=
 =?us-ascii?Q?yOxOdONwPiqEo/jESW5vC/A4z+/DjDMi7Oled8tEoofMAvp8Oqvf07cd86lC?=
 =?us-ascii?Q?Yh0J86GGVOlFJ7U2s8IkUeNxWXm3FwqTyZjLaTUv1Dp4+mKm/LQt3IJjBB0e?=
 =?us-ascii?Q?IcF4p6wk84EtMcKbxpGvFYIYD0ixlV0/cZ++jWkcyMwISiMIq2eczkIYPpnX?=
 =?us-ascii?Q?y1EtQ0pVPwyDRERN8aG7DJ4D+NjOYbAED8yRclBwUpTOP9WqmITVSjzHAmqX?=
 =?us-ascii?Q?gDekW1Z1Po1gbdr9D9EDDC35/nVlCxOXoDoq/3Y/FCyfmm9wlFXksE4aOp8n?=
 =?us-ascii?Q?hSG60V2zir4nZwBt6lC0Bhgtt30I1wuYYJfv98EdSN5UZiWrHpjr4IGIUJHj?=
 =?us-ascii?Q?9RUSGjMFJ/rhfAu/1PVI0gmSJKKVn0OmWdDVSh3RfD/UQ8E6VJX7avP2V9Is?=
 =?us-ascii?Q?39P43b6wgSJGvipx8Ks+etd70eVwqj6yfChBEwJvFktr3BDTCH6/o95hk9JG?=
 =?us-ascii?Q?QVvP+VmovSP0a7hJFZNvZAOF9Y+xhDUUMvh1RmVjDpprJXhKy8n0vDG+69y0?=
 =?us-ascii?Q?OwfSgTNij70C08qt6rY7RVktwhxzPEKledDlNPPIekwFGUrh6Q2MlSmyJVf2?=
 =?us-ascii?Q?RteAsAXF2I4jhOujibNONMkB+zW+USI7f72rG1RJ7l5tWnQpvEbnifNYGndY?=
 =?us-ascii?Q?C+MRQPGcDxbRkIljA5+8JA8PaFGKUrfOnrl3Dr8soWn+fVaC58ofy30om+UX?=
 =?us-ascii?Q?kHkkSROYh1kgmJ9jnZSKu7rMj7fF+dYNcmavNiZeOKz8rQlg/gP1XZh/DsGl?=
 =?us-ascii?Q?rdibIV+SYgq9d7NGCQRY8p2NrWjIy6wNUFtSaEQEVUwsUaxYUh1g7rq+c/9h?=
 =?us-ascii?Q?kFmmVVxCuRBcGmPCK2BzHx8hdKkMD6HLb73NtkWb9AcKTXyyc0MsFi9Nldfn?=
 =?us-ascii?Q?s1ZW+KIMeSGDBLgkia9Lb1Gsq47PURNKLcnmtx8udfTmL050mGMnCMkcmIB8?=
 =?us-ascii?Q?4MzD2UQhcecIPYvYtugjcPz/UHuOi3VT0iTpSiEf3MhCyEuDQXq8G12oeAYq?=
 =?us-ascii?Q?kldekuYqkX56EulbiMa7VNAPdTbE3PsLIYJK/YiCcxHkKdlfmVEahQ42X5ZC?=
 =?us-ascii?Q?QiShL7S7RdgZCp2TWVd+pgjjM/41p1oRcwA1yy46Pc2iDcCzVRPt5ulv0VFE?=
 =?us-ascii?Q?Wc1J/az82bTu+bDcOfc4TQnjDIQ/SPBMEZhcCHYz9vZGjKNj0y7dFEN3rHGW?=
 =?us-ascii?Q?7KjhvYUuZSjW3T6uyWbCXzg/ECydCQaD1rlZgtIzscnyKTVCXBv/LeAI7+2S?=
 =?us-ascii?Q?dALR2YlwSQ5IkENLdnnmQH8SFDEqCXbV7tthksm3Y24osjKtkzQFX/L6Xzi5?=
 =?us-ascii?Q?HC5VLCNUR7I+wpQyt6+ipeltiY8XTeRWzlPjVsJqh8MGyS3oSkadLcqTq6Wu?=
 =?us-ascii?Q?x5+amziotNKNRXiEFKS84OMVdfXD0lapCN2CsmVeGZ4lkiSRuR3bGZtC/rMP?=
 =?us-ascii?Q?v4SJT7bsiNRmca4xc1309Mx7A+yLxx5tkx2a?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 06:32:28.6446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dec5373-8226-42fd-b39a-08ddfcc67710
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145
Received-SPF: permerror client-ip=2a01:111:f403:c110::3;
 envelope-from=Luc.Michel@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 20:45 Thu 25 Sep     , Edgar E. Iglesias wrote:
> On Thu, Sep 18, 2025 at 08:10:18AM +0200, Edgar E. Iglesias wrote:
> > On Tue, Sep 16, 2025 at 09:30:46AM +0200, Luc Michel wrote:
> > > Hi Edgar,
> > >
> 
> [snip]
> 
> > > [snip]
> > > 
> > > > > +
> > > > >  static void versal_realize(DeviceState *dev, Error **errp)
> > > > >  {
> > > > >      Versal *s = XLNX_VERSAL_BASE(dev);
> > > > >      qemu_irq pic[XLNX_VERSAL_NR_IRQS];
> > > > >  
> > > > > +    if (s->cfg.fdt == NULL) {
> > > > > +        int fdt_size;
> > > > > +
> > > > > +        s->cfg.fdt = create_device_tree(&fdt_size);
> > > > > +    }
> > > > > +
> > > > > +    s->phandle.clk_25mhz = fdt_add_clk_node(s, "/clk25", 25 * 1000 * 1000);
> > > > > +    s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
> > > > > +
> > > > 
> > > > Should we be adding nodes if s->cfg.fdt wasn't created by us?
> > > > If the user passes a dtb, I wonder if we should just assume the user
> > > > knows what they are doing and use it as is...
> > > > 
> > > > Or do you have use-cases where it makes sense?
> > > 
> > > Note that the device tree created in the SoC code is just a dummy one to
> > > avoid crashing when the SoC user does not provide one, as stated in the
> > > commit message:
> > > 
> > > "If no FDT is passed, a dummy one is created internally as a stub to the
> > > fdt function calls."
> > 
> > Aha, thanks!
> > 
> > But then is there really a case when the dummy one is needed? won't
> > versal-virt always pass an fdt?
> > 
> > If that is the case then maybe we could just assert(s->cfg.fdt);
> 
> 
> Luc, up to you if you want to add an assert rather than creating the
> dummy stub. My preference would be to assert.
> 
> In any case, feel free to add my RB tag on the whole series:
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

OK, let me reroll with an assert here. I guess we can always come back
to this if needed (I think I had the user supplied DTB use-case in mind
initially when I did this. I then realized later that we unconditionally
build the fdt anyway).

Thanks

-- 
Luc

