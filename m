Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11706F9D0FB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 23:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCn0P-0001e8-M6; Tue, 14 Apr 2026 19:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wCn0O-0001dw-HM
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 19:17:16 -0400
Received: from mail-eastus2azon11010012.outbound.protection.outlook.com
 ([52.101.56.12] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wCn0M-0001RG-5D
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 19:17:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJkamTHHcaZxPVcCFke35J36w707wN/xjRtd7+ybOUbt/2VzQwlHaH9QAEKW0I3Jxi49k8xOZiaH8Vg72iSSgf6NLOzuaQbdZf13gcpWiSiFuEaEMRHYhQvnf9Gl8dF42dM9jHfTgPl5G/EV0pgX7/Df5d5fm4qQdn0CSC7Vl8SdD0EbPxxz6viw9Bkuq8p5btgvwN6PVt9nQ1NhPFTzhgPjgcR12fRMaLCuJ0bkvPN4p90riSeZq61wktHAzXTQJcT/uWQ1Use/To6NXBMNUN3rvWBWE7racqqLokWUESV0V6S16a1PVds3UN1yPYXXDuOf7cZeIkRO3n20ri7RAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjyPIficRSWBTfPQVE4WouOgVWaXXIeizcN/X0NPdwI=;
 b=l6e+sA4+2l3TpCcEJrolIr081WiJnPNWjr0Q9jnUuIFsReJwEuGPb0+2T9Ny6V9HK7GQ6j8lGdEoNnl12TjPJixZ207G4SODyxl1IIiNkyNu9woDB7nAJoqog3rrJ+uUONPNtghE8iwDeb3RRjRsGCo6OFKqHeUhytKM3hKls9nwqBWanjjCfv6KM5IRcJNMsqgaqCQETgeDE9kwfOheauCE2K/Aty4h/HFhI/FxIlqcS4Xa74ENAVsT7hn2XuLAqZstwEko9tNBLEjZlAftZ3tATxZwbjgMRwOhBTtHXnYPGjEAvkvrqlhk0EXEq2pBsuD40RUQzRU4cToQGLnYBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjyPIficRSWBTfPQVE4WouOgVWaXXIeizcN/X0NPdwI=;
 b=lrG/4QP8wgxRUgsXJXSYmm4flFv0kPkEPoNTUbpmvGpSrOx2zsKpp3xl9TId2dsrHQBoZ6yf+GmgciZYQrRgeZxBbjoXapHltW3JKe0Ge0+0l/FpM4Z3qoepOmU07aQ6in7f+ftxYM5xzb8sqE6QSgv0nqysC2EtPpb3UwWkySM=
Received: from CH0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::12)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 23:12:05 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::12) by CH0P220CA0010.outlook.office365.com
 (2603:10b6:610:ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 23:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 23:12:05 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 18:12:02 -0500
Date: Tue, 14 Apr 2026 18:11:29 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>
Subject: [ANNOUNCE] QEMU 11.0.0-rc4 is now available
Message-ID: <sao2pyf7vthekkik7m3zmj72eact6z6nd3b7kwth5l4znp2s5o@rn3gpzxee5qm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SA1PR12MB9546:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a391e07-d7e5-4c61-0241-08de9a7b3e64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: W0aEVq9m/j1nu15As0/bkWZGp/kM9+DPVywrQ3lTEGcFZ7/q1Zg9rIh6TurNOF0QBdpHyjmxKixvijk50tO+BzOlXeo19kKt+SswfimOmryTpno8Hia3qu25Xj//dZ1jnb4RSEURsYUzm1V+HSnZdcGU7Op/V+Ejs03V39nJs+wFOh3bU88T7U61+knDA8fVROckKErS2qg0ULhV5+YzZaZGnmbB/UKSfmEB+bUBgzQko5sV8FCpT7UUthvr9xHw7c6C0HSkUiE+v6Tkp6/TDAkhl0i5PWjizYjmHJQ0o+nb+cuJEKCtCQTWApUpkKdyiVMY31gglHBixh9xNkDouNIfetjoRo6dkYmQFc787O97fZtMPe6zEFCaciw2DVpQkmbPfLp57C6a/+YwFwOEMoIE4PW93kLgSReInxesIkT7Wokgl14GpsdnY0m1KsrDznIRpztO0UkY3WSape1F+U5Wxu75XHnqGIA9HESj42eesOvht4OqQdjuD4wcJ9H6Afb5kmxBcy2ZVplJx00wb9f3sjd2us4hvPyadatm7Kg4bnCJ9ZshI9VJ1zQqFqEw4QL6uS1nCnoTHPh3ZxLuL2b4+S1dLDXqZVS+jYVBddtzxlhV7t0sHpoIiQ2LEPTWkHvlgT7OndjNazTYmzhB/zBW37uoPOW8bZdXpveC/W312KnWHkcKiy8vJMz/rDQyQkZcFdfpQrc4Cs8QEKLWySJ/TFXPJ8D9Ys0+Ll16XwY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cpX900yQjCyu3ZtxIU+I7pihOqImCOZw9j62Pq462ueAMiIH7vYJptuB7LTeQcEzwAmOabdDOzJzQLsBxoOhISmTuWeYs8FceurksqTXvJgHhPOnnf/Qa7eCLtfrPFH6qR6ym532Wz0DCgIEoovKi6Rbp6ztJUvPWjGLJpw8h9AJGeJyEr8c2HtUQr+Z8yFWLi6DzUj/UZ33neRJhVa71yffaEoLr1POyO9Yy0meBU7DBxFVjwRsLvuOAspjodxpA9ciZC2RPgDMkU6SXrnlKqQPxwjtRJBru9XG1DG52K1VqXmenOCAPAxAi3EygKwUIiYfcba0/tqAUltL8U6V68fEB7G2TLbWh9BscrlleZJaQD0LcDfs6KuPW7Eqo23PD8sh/q7mfIpoG34y5kFVlGUefK8qtr7kk2JZk9HAN2g3WbN8BRO9YJzXmOca1sGb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 23:12:05.1033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a391e07-d7e5-4c61-0241-08de9a7b3e64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546
Received-SPF: permerror client-ip=52.101.56.12;
 envelope-from=Michael.Roth@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On behalf of the QEMU Team, I'd like to announce the availability of the
fifth release candidate for the QEMU 11.0 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-11.0.0-rc4.tar.xz
  http://download.qemu.org/qemu-11.0.0-rc4.tar.xz.sig

A note from the maintainer:

  This rc contains only a few fixes since rc3; barring any last-minute
  release-blockers turning up, we should be able to make the final
  11.0.0 release next week with no further changes.

You can help improve the quality of the QEMU 11.0 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/18

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/11.0

Please add entries to the ChangeLog for the 11.0 release below:

  http://wiki.qemu.org/ChangeLog/11.0

Thank you to everyone involved!

Changes since rc3:

da6c4fe60f: Update version for v11.0.0-rc4 release (Peter Maydell)
985062e231: migration: Remove unnecessary zlib include from qemu-file.h (Chad Jablonski)
750c2d53ee: docs: Deprecate Arm OABI and NWFPE support (Peter Maydell)
f1b1db98cc: util/cutils: Fix heap corruption under Windows (Bernhard Beschow)
afa63fc0e3: accel/kvm: return early from kvm_irqchip_create if kvm does not support irqchip (Ani Sinha)
4913ae36f9: virtio-blk: fix zone report buffer out-of-memory (CVE-2026-5761) (Stefan Hajnoczi)


