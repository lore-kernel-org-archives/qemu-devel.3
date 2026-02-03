Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4BCE8784E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 17:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJzb-0006nb-Ku; Tue, 03 Feb 2026 12:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1vnJza-0006nI-1g
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 12:15:10 -0500
Received: from mail-eastusazon11012063.outbound.protection.outlook.com
 ([52.101.53.63] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1vnJzR-0002oz-LM
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 12:15:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj+yWP1FO23gQOUs260f/q5Ml8NhUif7GBwUWaN5TdryElsIubayUnQM4/M6J5WhYFTOK4s44pL67xLY/7EwF0oopH3hm4PmP7rmR4fNa2fTQ4s4BNH4DzhjJBrYw/yBejqKZiaq1bK9avaZ1T5emlWm4fsjGM4Ob4YcU19XohE5mc93690AP2DuJ2i8wQmBwKAtzD2mbJVNU614B/fyfvIfpMRs36qDmOJujWWHOC2eg1KvTubCctCoGSt3QdtL8KbnpUMawQI6+wshgb05SUJsBT/k1rgAmj/lqxhcoxl5K92nHhKRbYCb+dXKH1LII4YrbjOD7Zsr551DbRvtag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVOJYqQG0MekxtDw1n32VyGnw8lbMwtmNdVVe53AZlY=;
 b=RB/zjVino01x2ech0bZa3X9O1w5hNe11kOMdrL0Aw97eJWgbCK7SPv969JDzJPWvxYVtt0L90+TGgYCKym4HwGeT6gwPQNzIPIhdjgJ2oqbQQ+vNkealDIOPXpPFn+JyFCSnvsIf8otVuBYPPsLyuRtmos+w24GOKz2+MQ6Y7mwtbZBjjojyV+PO+wAypl889wex4wpj+zzn/c+0eP7t+Ct4BsE1oppl5PnCZtBIDXrPAAPRA3g2xG0gcgHsX9SJ+cxUv8FIMdjzCOtNy6jJdhrOMuPxcCsfvgRjRndM8Mk6FZ/+sKMdZPK1ZQJ4DPBD1vb5Yczr27Vtzj0ellh+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVOJYqQG0MekxtDw1n32VyGnw8lbMwtmNdVVe53AZlY=;
 b=eVjGXrpxrnzDqoB4WpUqmRO032aKdQXJNX7H1ZRlNv6LAFIZXIyi3wC/L0E27VMNRfP3DJknC+bQfwz3IH0F5yomOXlBEEnfDrI6FBWNCYWHhMEhchU1f96M4y+7+c7anPbrzuHS7uX7iHeBCeIAQUjGqqblMNEruo0gjUtjHLM=
Received: from DS7PR05CA0003.namprd05.prod.outlook.com (2603:10b6:5:3b9::8) by
 MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 17:09:53 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::e3) by DS7PR05CA0003.outlook.office365.com
 (2603:10b6:5:3b9::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 17:09:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 17:09:53 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 11:09:53 -0600
Date: Tue, 3 Feb 2026 18:09:46 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, <qemu-devel@nongnu.org>,
 <alex.bennee@linaro.org>, <bill.mills@linaro.org>
Subject: Re: [PATCH v1 0/5] virtio: Add the virtio-msg transport
Message-ID: <aYIr2rAPuXJJ-spR@zapote>
References: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
 <20260203082120-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260203082120-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2026-01-25)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 604677ed-95ce-4299-bfa2-08de63470c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WVWkVWRa0UyMgdgW/ntgIiftuwGJev6ocF8+y0KgT3TDmvwZg3E1308JVacX?=
 =?us-ascii?Q?HRumc7WT//RlWe11xiWDLajQ8h/Vl5oxSsXotYThhp1VHT6WixfjisQ2H6iP?=
 =?us-ascii?Q?EhCpAtMJ5P3mkD/oRak86cGR1sIvPcctkgUn3azqRoyMcztozFrjCGX+VCYY?=
 =?us-ascii?Q?pnj6WsaQEilPMtg/ub5GDiMNBH4J3ck4+t5b3Y+3hmIWW0c6rxGSRvMc6PlC?=
 =?us-ascii?Q?Xj6CB6LwtayF0s+tZBIA5kDlRbFs9k+iWhN3kpJTvFxUbxtdYfSuYaaBSXTv?=
 =?us-ascii?Q?9HB//bkW40oTPeuTCyfJbfoqpePJnhE6d6gYu+88gLZZEJuerQ6p3HipW801?=
 =?us-ascii?Q?TNpqb9SN1DHeQpOzx2dmQgrBkfrrb9iT/HxVVmW7Yy+bBIcyR0UC4g6hd2pC?=
 =?us-ascii?Q?2toKUNiitvzUzWKQ/P8Y6wLrGFcbSfwZBmEj89IbLEaHD16i9ZkMiUTmGDEL?=
 =?us-ascii?Q?9FPoIn0cC+I/5yTJ4TAosgl0rGfLiPmdT2YO/zK8xJmhiqjht8h0z3XfW5bk?=
 =?us-ascii?Q?xuk6ZpUZPlcQJsnZNVsWhegs5kPqQFWPTt4y2r+RpuKbVmXXJ+mILckaMcTE?=
 =?us-ascii?Q?AW5ABCY9D8oBhuACEh2hTwASVpt6/2/9PLHuWNa7rpKHd0zqFMSibcQ6NYqD?=
 =?us-ascii?Q?/UhEuDGFs6vL5jYni43zt56Y2rnFVw3BrpMyuyE9o+6GBS9S6a2goMPYdwMQ?=
 =?us-ascii?Q?hpNgylfdz7eA6HRG1ZOolrg0MnNgBCkyG4k46lPEiVfwAaQMpSVjQUIep6VT?=
 =?us-ascii?Q?KE4FGBtaM5jegnHJFmLtNoMSGACbduriO2nXwE8dg7YyeZQy26IW4RLnpSVG?=
 =?us-ascii?Q?BWk+9wUlpAXuolyETWZH4Cb8Eo/ZTbxVNrOc2tVjG4g+oJdqoQ0uegK3986c?=
 =?us-ascii?Q?zAGPDWkXwL50w3/gPScUluOSNlYMHsEvElh/m9Owpv8ISGPbXzYS2FSZwqhZ?=
 =?us-ascii?Q?tW72oDr0acAeqCuZjIHBBT+hfoqVekXuFJi5aAxTCZmzVnJ1zqIu1sznPa9M?=
 =?us-ascii?Q?qm6az2OnybqN/QHLO1KkSCo3gmJ2wO4ukNdhFIORjHpQ9XViO8Dp9IXO5Yzm?=
 =?us-ascii?Q?3D071AwtFYoi6jc7wKhrQaZ3hqi0Jchh+PZmGLTaDw2Db1SdtsAvxira1oAD?=
 =?us-ascii?Q?bM6xl7OmgFbJ77iPn9dDYLpx/ScPoBa4MBuzRYbKgTfWV1H4vcEzaZPPmbj8?=
 =?us-ascii?Q?Wv7cmMhT/FjcKDHDJ1kcrAq7o1CJCBgLCp47xBCeNHVeiEQredkxJ6yw9DtB?=
 =?us-ascii?Q?VRybJpmN/W+L1V0phCeCS8QegVy9PBZylQMMDybBKFTIFEp7pfIUDY8z4ANj?=
 =?us-ascii?Q?2FWexYt8HikBBBRjFmdCrEzQCU05QdLWcoOu4JSrGf8Dh6rRZ7lx/fyhvdSS?=
 =?us-ascii?Q?BX7NWobR6/HkJrp+48yEH9xeTFBs3a1ZF3Grs+t7a3oTJL3VBIx1hMtdpjBN?=
 =?us-ascii?Q?mxVfPbr9JA4SJzlxDgDWunAWoNJWdO6Zn1qAWtjjCycdwh841Im8xMGVhlmR?=
 =?us-ascii?Q?WTSRRmoPwNI1ziKX5BrqFc/lhr2avaD549Z1ql5wN+iTwYTb6uhOWMRYjYui?=
 =?us-ascii?Q?a2rxV43vBuzuG9vs7ZYEJ5fMEnvbi6T43BKaIMt8/EQXloEyEtGQ/T6dQPLw?=
 =?us-ascii?Q?S2oGlYaJizviXd1dPjj+kuCF7M7Gt7+6QDXAuxqYLGbfv2O6vhNU4ks1NUXS?=
 =?us-ascii?Q?c2T1tQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 67F4ElM3E/U9Q6ESbYcRXH5EYfNdATcrS4h+7s1fj10QqfZ7mV1XiWRdqB1JuTUSlwtSinefAjyWWwWaxC/O6g+gLlEXQ4BPcdrEjI8jy7JDcoeLUnRvOXcqExJBDCWSMcfnxK7G9HMT4FjC1FSoQ9BCAx/1bPil8mZ8HHKKnnG7eR0FqSmzt4uWDa+N9DloVU/RUJmbJWohvq9d0UphcK0fl4LYqwmk2zAOipfCtqen5UHd6Bkajy8lUc51WIIX4hEDaQUJR0a3D4ZSUikMjoB6zhn2Yr8l/HkGfBFXG00Gd68tz7Dfxd51MjsTbRMLlLevXXO0F+NnRQg2ac6z1sizeB6Q75Vt4uFpMjUox08Tz9d6zERF0T2qwRgI6FRi30sdIJh0cDZwp69UDBWiWBJHfhx3BAT+jd2Uc3SCBHAS1buSSoRYF3tFFdYvuJSl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 17:09:53.2829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 604677ed-95ce-4299-bfa2-08de63470c4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650
Received-SPF: permerror client-ip=52.101.53.63;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 03, 2026 at 08:22:38AM -0500, Michael S. Tsirkin wrote:
> On Tue, Oct 28, 2025 at 04:23:45PM +0100, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> > 
> > This adds virtio-msg, a new virtio transport. Virtio-msg works by
> > exchanging messages over a bus and doesn't rely on trapping and emulation
> > making it a good fit for a number of applications such as AMP, real-time
> > and safety applications.
> > 
> > Together with the new transport, this series adds a PCI device that
> > implements an AMP setup much like it could look if two SoC's would
> > use virtio-msg across a PCI link.
> > 
> > Current gaps and limitations:
> > Shared memory FIFO layout likely to change in the future.
> > Temporarily uses PCI Vendor Xilinx / Device 0x9039.
> > Documentation.
> 
> 
> I'm happy that the spec effort is making progress finally.
> Do you want to repost a version aligned to the latest spec posted?
> 
>

Thanks Michael, Yes, I'll repost a new version soon aligned with the
latest spec and addressing comments from Alex.

Cheers,
Edgar

