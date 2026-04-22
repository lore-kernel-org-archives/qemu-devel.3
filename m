Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988CFFA1FD3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFaJx-00032x-Bs; Wed, 22 Apr 2026 12:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wFaJv-00032b-70
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:20:59 -0400
Received: from mail-eastus2azon11011010.outbound.protection.outlook.com
 ([52.101.57.10] helo=BN8PR05CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wFaJt-0000LA-BG
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:20:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMHig6uSU6RJfBpgl24vGbK4e1KYXsm8Y31K169gjR6Xk/1aFw8hIVYZLLoCr1YhpkAWqcbNo4CvmGXdPV2Ot3p3k7Vaw08JYfmPKydMpmHsY/SbdXpC41CZOm+qrxJi9nafJBCdplSCactIuqbamzfj9AylyheuZPMwVbkC/7ScHo2XzFZMDGa4ZYbZcEYoAOnGvWxQJmV7So1rJahVyhiUf4IgwfsrBbAF1oz2DpzjxF1wlUEXSJTFac2bCH+xIiRAzmmsgHteZOfvOKIeOMUocLvj2TGlC4Y4B8QOkjj4WL8J12XJFcQ/PsgXN8hRJ/KlnfSJLKeJFXvacSDYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfjJeucrtflYRYwqM+XIcMJRTFhTNKhCUyZ8yjyam/w=;
 b=Ef4Wy1yPASbjLvZxkuL/qWORKL53mt/zp0pHmuQt6DPFeMqg4Pbw8L4Ur+hk1G+Tytt9nvklr08IVeG2ZpJzIDvjEvWq7WT7Brm97V6qSN0j/Ro6W7IFcwzFD6m4KCHIquZjzE9ZzJm+F3TPuBw/0rEkBqtyCghvbDyM2OU7XFg9LRbWC2RsIielmeAPAN36m8gRdDq6bApugoHm1xMeAJPWRXvDu+K5/HkDB+TzE+ml93OzplqnbacnUB/bQsFXrfO3CTBDb63suPupiaD2e57AnULRTzpPWeIC9O51ONhdpTHJQogCMGPCPIcxdiVJw5dTwVk1M1ayZERsMOtbyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfjJeucrtflYRYwqM+XIcMJRTFhTNKhCUyZ8yjyam/w=;
 b=JqOjn6hfx4agRmN+jyNU1Lg+yM+1PQZce3l7mrk+eD/YVD1bxs3r7KitsS8HA4o3wbdmWlUul50F26MXyyiBQS/NsJCQ9Wb1Hg6wDyV42eQ/WnRVihnm0D6zDZVa320lHJvyaPLPPqE5DGykdcOXZiHKxV/QMM3YIAJ30BXpMiE=
Received: from SJ0PR03CA0226.namprd03.prod.outlook.com (2603:10b6:a03:39f::21)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 16:15:49 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:39f:cafe::24) by SJ0PR03CA0226.outlook.office365.com
 (2603:10b6:a03:39f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 16:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 16:15:48 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 11:15:47 -0500
Date: Wed, 22 Apr 2026 11:03:55 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>
Subject: [ANNOUNCE] QEMU 11.0.0 is now available
Message-ID: <lfvqs3kqiaqltw6xlolu224gz32sp4ziggbfbtyldhf6ydre7m@efqv6sb5riff>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c44beb-55e6-43ae-5508-08dea08a6a80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: w1lp6LRFCDbb8E5YpShUA6iXpnt2MWCbO+q/S9doMDW/Oc9koM/oDEwlVN4Kyfm1EoNsJdgTGErn8d71TC9YFwXnWe5/hKEXobzwrx0e2buBGF4HTMMQ1PtEHk60lrw19tcJDeGkdcqgUyU6wJc6oRQOwCbNxgzxY4lxL/a6HwPQI6/51jT2587Ta7c6kk5H7hFKUxoaLGIa6wjlxVok5Jz60BbytINYl3jTN30kpHCqHStYvDMTKs6Y2hCaChL5SOJrWoIggzvBpn7DZcM95Vd9308fvt+Z0cgJdwNaYArdvPGVznuCpbhAXmqr4HIIZxX5XBSQnRk9d4A7Fm0Ut9irMQqEy9XJjjUdLDBOrp0q9Av4lPtEomjytUiHw2dloU9zdonZMFztizXKCSoDZn/m4RioYqcPBmcrTXXKYxZ7XG3KocTnrc+yv/EOwtV1sEyQszerS7VBKuPEqA6z85B1hm+nxXo3Q05yFW4NZN5O6G75laMQpw7g6sGMt+p20UzcFGOvf3wyO2vDdbiy91H/fvg+Ldysbyl7+9pMSmRyUjrJO+2m+PSnPzj5dR6PXzCNt7Sohpmav1G7rfSFPPqXzLg6EGatYXvmlMUWhJTSHZs41+mDsMRrkFWbLhfvmF8Awl7wl21/JisSeNsAJUNkaGWCa2Sc2Hqtqmy3niAP5bWw7vqc5dkvQECC3ib8kUGOM8HAUVB02aeunKNWy6g8iSiDsoOfmuMXarAEyT8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7qT7+tj3iHr7rH8PhN9g1jSlsz0HGDzawbxYK79IAui5264X0qRNzqjm2ziI0n8fcs18EGTi94FC6TXR6KeMSDS7x7vG9MVKbghyaESBOxd9o0YVoYLATTvGm3bHdPaNDqzbpm1LJs57cy+1IEn52fFiyn5WU8ZyF6Aciq9QiTEJ85yYOcyaA1imMZ3yR2yXxJwZyYZgi065aW7RAHaVQufi0BDx3hWwkUMPPGoySelsBJ5VNO92OiqM2RrV59SpVuL9cfAqwyB9Idgbh5tQ144C8JDLbQPPbYZqU3YtV+4qyXLBr1v6fkKav/u0evb5TsVJ7h8OxjkW4gh9e8ew14sBmvzTu0wOV4MAkEStXLDCtLFKJDw/sV437MIm2InsyCuQxPIn4nZL0QfpTp9qUIBu3/hC64v0rnR6UijYb+HmdcGI7ZiaJsCBDJ1gesZk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 16:15:48.4582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c44beb-55e6-43ae-5508-08dea08a6a80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942
Received-SPF: permerror client-ip=52.101.57.10;
 envelope-from=Michael.Roth@amd.com;
 helo=BN8PR05CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
the QEMU 11.0.0 release. This release contains 2500+ commits from 237
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/11.0

Highlights include:

 * New "nitro" accelerator to run AWS Nitro Enclaves natively, and improved
   support for MSHV and WHPX accelerators.
 * KVM: Support for CET virtualization.
 * KVM: Reset support for SEV-SNP and TDX confidential VMs.
 * virtio-gpu support for native context drivers and specifying a unique
   resolution for each output.
 * TCG: in-tree support for C++ plugins.
 * NFS block driver support for libnfs v6 and various improvements to
   curl/FUSE block drivers.

 * ARM: support for CPU features FEAT_ASID2 and FEAT_E2H0.
 * ARM: TCG emulation support for SME (Scalable Matrix Extension), and HVF
   accelation of SME2 on macos (if the host CPU supports it).
 * HPPA: SeaBIOS-hppa v24 now implements the Astro PCI initializaiton
   (allowing for PCI VGA on 64-bit systems), improves upcoming HP-UX
   64-bit support, and has initial support for multicell machines.
   Prior versions also have fixes and updates for 64-bit/PAT support and
   other areas as well.
 * HPPA: Emulation support for 64-bit CPUs with 40 and 44 bit address
   spaces, and 64-bit GDB support.
 * LoongArch: KVM PMU migration support.
 * LoongArch: TCG emulation support for LA v1.1, sc.q, llacq/screl/ and
   estimated reciprocal instructions.
 * PowerPC: snapshot support for several ppc devices.
 * RISC-V: ISA extensions support for Zilsd, Zclsd, ZALASR, and Smpmpmt.
 * RISV-V: CPU support for MIPS P8700 CPUs, better reporting of CSR
   registers in 'info registers', and other fixes and improvements.
 * s390: emulation support for "DIVIDE TO INTEGER" instruction.
 * s390: support for booting from virtio-blk-pci devices.
 * x86: CPU support for Diamond Rapids
 * x86: support for a new "nitro" accelerator and machine type to run
   Nitro Enclaves natively under QEMU.

 * and lots more...

Thank you to everyone involved!

