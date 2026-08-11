Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D307BC5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 23:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtwLM-0000Oa-45; Tue, 11 Aug 2026 19:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wtwLJ-0000ON-Tr
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 19:57:13 -0400
Received: from mail-westcentralusazon11010016.outbound.protection.outlook.com
 ([40.93.198.16] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wtwLH-0003SY-Jp
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 19:57:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZMB56jJif3jlEHLea1BuEwaSUxQdBEr0zyOXD2LI+HVmzoFQizCg4ad8Phe1+iTEH3vLIlEmM6Av0xduodhTK5ksXtoNMh2vgKkXgIFJmK6ZUGA8Uq+KyDGswdk6ZtAWaHYpf4nqn9ZN+BvWctLRwsBklaeLL2UAXj9n79U32Qsmmtg8ema+1M1cbJlE7o8hOJarqpQ5nkHRFtqXshe0MTnMDyVhRefbp9PtztgYhC3oowqcyZyEsQszDKHBdpCJ2DEoNokCYkSgfL11qk2+Xa9xEVcQwS0++YB6wcIXoAF9hR2wuzGft7DNZdBjizdJllYNTds2djEYHqF90a2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMMCkMCarhasAn7SaRWbwD4v6nVMB6fQ6sfeZuPPELs=;
 b=WDnr+SD3PU3VdWlV3L2HY4JtytBNhL3Ckbngw86St4YLrhQN4J3fWdrdezI8bBYD1Hwr8eK4pdiyDgU5MU+z0GVV1bMbVHPhCpvSPIN6olpqQLGhmS89msNfxMQ0YojYDp6i//VuLwSFY7fgS4+4d8LlHcL2V9QjTaPnlT36S0jObSPHLZOysiUnNnwhIjoNhv7e+2l9yb8m0Y076LyiM2t1PXPMkxuxMm6An8nGUS2GqASBTubaFIFt4fX15XV2e5H2bJF+PQUok1efYGXahC6Ii57KJZaWqSoZngxQ1YhWUMZMNvHy5DljEAxFY9z4QokdiDlkHzP2Kc33eOMGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMMCkMCarhasAn7SaRWbwD4v6nVMB6fQ6sfeZuPPELs=;
 b=3Z14k/1223Rwq2PfRdIN8VIXI0SSst+mt6k1OTQzm2H9KjExhrDvSf6LaHExfxXeyml7ftx+mfkST3LGICEuQSkZ/KvjktTg5B9aLgXv5zE38L4J5Lo/qNDOhUCzBgnjyNMzJA0FhZk87x4E4+++6vLaR7f+XEjYCETRmowJjN0=
Received: from BL1PR13CA0244.namprd13.prod.outlook.com (2603:10b6:208:2ba::9)
 by DS7PR12MB6216.namprd12.prod.outlook.com (2603:10b6:8:94::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Tue, 11 Aug 2026 23:52:03 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:2ba:cafe::2c) by BL1PR13CA0244.outlook.office365.com
 (2603:10b6:208:2ba::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 23:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Tue, 11 Aug 2026 23:52:02 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 18:52:01 -0500
Date: Tue, 11 Aug 2026 18:51:45 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>
Subject: [ANNOUNCE] QEMU 11.1.0 is now available
Message-ID: <vp2x63qeslklzybw5lzy27hh4vzklfvgsbqrnwmrsghhyftfo4@qkibdawt6gnr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DS7PR12MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 91940269-46cd-4b47-6a65-08def8038abf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|13003099007|18002099003|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: ltK5uyT56aATYBtJ9Clj+GWN4mSZqPGry/Vdg0JUW34kd+f3wUi9LwM0i3FIu9DtUGLQSO6QFg6R9HNPpkumk5N6zEiCHl82G2AuwEvZILNN3TsAAu7OEYHodK2B4oWz/RE1FT2wXSfamwGIDQBKpKj33RgrOqi4M74vwENPiYB4uf93z9xp5aPYUeMTEjopPdw10sfQ+fepooKiqwppqNl2AsBL1+y08mcKeCp2I3QQaMdmYwm5wupsbvPQUp+JQLt25Sk6vNlYtAA1pptut6iQKopvXjmCAR8MXjN6RY4xVlWmgv5Kx88+PONlCj5HmTYxuX0BuOiCd6q1RHfCbE9s3hE51sguC8Uie/jiM6mlKc+XTkHSZd7sN8XJPu/2YpKHzRU0UzOmmFd7T0jFPXWVoJ8D7NL6YEjzk6dke+RTN74F403udDk1vzu8VB4LfVbYWdWg7KkOkn3ZPPsj/LOunsVUDr3hOgSiJn3DQQwvhtbYvK0TB6x3wWji4WqiMyttjgGMqnuhbfz2YwaaGnibL+NJkxTHVhtsgnHAmbxkUVl+B67IIdnIz0ZnpleFtR6v35BPRv7+q5QvYQ53gAOMmWJQPDqpPOiOEvpv/1S1NcDf5R8cxcJQZpt2/mmCyg3Z9lAAWdyamaseuluayA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(13003099007)(18002099003)(3023799007)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +9A86Xxq3Gkph8LRofQN1zqBrZynVoE/9H8AL8K0BzBtPhy5LbQypVNemCTtEFDuh5zQDTOTyYvoC6m43Vtam4MT9h727UiZI6aRZbhKSKA4yVclK7mBT7ZS7HG6624AxDt1F2svbLLuWZvflZ4YL2VP8aA1M5qS1Z40uNQpyUPN1E0FsxH5HLFUyP06bvVukzBsNeQfOr76w0zB9HIH1IVj1ZLNzYPUZjIsPdY7mrfG84chCcMKrmyEGCdUnjoO5i8YQYVK9JElGLHhphoexdHoLrOQqp/E0xgVjsHGSJOBgcgOb4g8qM0OLqXYVqLwfGTW7yeYiZnMPpwgCAYqmtyidsW3J/CddKS/LSZBuQ2d9mCArkTNR+YNPOPQRYhADIB9WW2+b2dJ6kQTraxExBplFM/NgqjJNulx0tsaP6VBfkLuKGziECb8lJW8pHJT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 23:52:02.9143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91940269-46cd-4b47-6a65-08def8038abf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6216
Received-SPF: permerror client-ip=40.93.198.16;
 envelope-from=Michael.Roth@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of
the QEMU 11.1.0 release. This release contains 3200+ commits from 285
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/11.1

Highlights include:

 * Universal Flash Storage (UFS) emulation support for Write Booster
   (device-level caching) and Host-Initiated Defragmentation (HID) based
   on UFS 4.1 specification
 * vhost-host-user support for offloading real-time clock handling from
   the hypervisor when using virtio-rtc
 * GUI: improvements to virtual console handling/specifying of different
   character encoding and GTK/VNC improvements as well

 * ARM: support for new architectural CPU features (too many to list
   here, see full changelog)
 * ARM: support for new imx8mp-evk machine type (based on i.MX 8MM
   Evaluation kit)
 * ARM: 'virt' board support for specifying cache topology, 'hvf'
   accelerator now supports nested virtualization and vGIC
 * HPPA: updated to SeaBIOS-hppa v25 firmware, TLB insert fixes for
   HP-UX 9
 * PowerPC: MPIPL support for PowerNV to preserve memory after an
   unexpected reset, as well as support for emulating a nest MMU
 * RISC-V: ISA exstention support for big-endian, Zbr/xbr0p93, Zvfbfa,
   fractional LMUL on vector SHA instructions, KVM support for Zicbop
   and BFloat16 extensions, and more
 * RISC-V: new board support for K230, support for Tenstorrent mvendorid,
   and other misc. fixes/features
 * s390x: KVM support for ASTFLE facility 2 (for nested)

 * and lots more...

Thank you to everyone involved!

