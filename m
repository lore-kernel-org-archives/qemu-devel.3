Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCFAC55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 06:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrrSB-0004Ua-Og; Thu, 06 Aug 2026 02:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wrrSA-0004Tr-05
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 02:19:42 -0400
Received: from mail-northcentralusazon11012054.outbound.protection.outlook.com
 ([40.107.200.54] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wrrS7-0008Dg-Mf
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 02:19:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uv1uoGynM9Bn/ojJwdpWZENdZaPFtTQkI+FjxooJ476bwyGylxqcwtCwZRqYc2jOp5fVmhafJ5bxKWVWDXR5jLkh4gjLqb3CNbebgysxfB6yzo5q+TXR//KIMOwX/Lg5+TQZy5xAET+qibkdYpikCkmo/HcHJKaGyg9naxGMAoenEM7OQrkodJzB/yMA0dxIPVfVcouAbe018QfGdK9ju2iH4zcBWq+xgT5pQS35v6XYrsBsgpq1oLe2w259ctUwoPBcRROwsWMT5+B4kwqY9nQMC+qYKMPk0f7m37U8jKc0NDF5A0yMhRg1SPGBhtxYt2oI36YK3TmrQfmtAZRS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUpecxDgKfdDwao9qV72PDvq60rjX1p1KS9YKziboqM=;
 b=rziBPVZg9/BXRkeZFEjovq13O/dcoqEv7XoFBZoaF5d9G6XAK2sx8XmhJVaDeFCl7LSxE5ASO8B6kDrcsSQWzO2ea27onjIrI5r9/ns7pYa5z8IJzf+tjUVnOcARoCDXNAmcjTODgZraIwcD9LZ+j4oiHEKUaCOpXvAJ+QPzedMP9e0K/e+/xGiTPR4pE8Hec89k5zMFHgjmF1Ueyu8QYUAtXVAtyx38x8eze1aXhsGw89MiQgHOLPbVG8tV+ydFfsBQ3GtRAtLEz6rhSbiYtVv9vcsL0KItYwNr8v23E7/qn/w3n33XeiwTU1+CuIFaikcBytwGlXDGUP5Sc2Oe/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUpecxDgKfdDwao9qV72PDvq60rjX1p1KS9YKziboqM=;
 b=Dny+QQf5RQ4y9RvTCAa1F6dLlhogUP+Ir1shvIZ++GKcAW6bnI5tLdAX7a+XFG/q41t7Xzb8E4ZVVkYk4jjASCktffIndQOi7Ei17h4xCh7FoxlknCNv064pv3sQtcztj9Xm7UGEXomK4vcBZaVEFT+4wAW3sOL43izE9TG8GMo=
Received: from MN0P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::19)
 by BN7PPF34483F4BA.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 06:14:33 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::7d) by MN0P220CA0026.outlook.office365.com
 (2603:10b6:208:52e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.20 via Frontend Transport; Thu, 6
 Aug 2026 06:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 06:14:33 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 01:14:32 -0500
Date: Thu, 6 Aug 2026 01:14:17 -0500
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>
Subject: [ANNOUNCE] QEMU 11.1.0-rc3 is now available
Message-ID: <fdnv6kmvgm3nbw7malc2ffejktenppbq7uupsj5cszgyaqf6wc@hlzlyueoqr3v>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|BN7PPF34483F4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: a26eba18-5dba-475c-04b6-08def381fba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|13003099007|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: BDoFsHeqALhLn/x+6gd4JmDmnsUK+1aSebDMerCeGQj6OUSbHQhmoco8E7bEgElPG9h6YuQXbku4t0foGnoeLLjtrvORSjGzxauyI07c/zRpdgoYsVb+3vO5PCw88AxClNcEyesEGkO/FpfXmxulVTaE+TtT19Dp8tcA0WuyLF0TkeH4ohw1ip0zTENidNvUu/GcE5+pMaQTRF3Jp6fGXi0e8AiHWlCooLM+2KB0+biJXGJ2HH782USYE1jVNXx2Gi6DSvD2FO8nPoie7tdle03OOsoRWrlERBlO9DzIVNiVlWYm1HV9gBInseCkzA+AAFBLEaQnvxJQObrdx6fZh4XZGd9Br1UeT5TAuFw+MVFoZsZu7xlZAmeHgVjTWbJfRxYBtFJyk0XU2thgxcIFAXgXg6lzf69nsOtE4YxdeBECrtRlM29ogd6CStKyZ3CHjo8J1whKO2SIuYch3/VSWOwEfAFaOKWkRbS9ZpEu6wxRzmHGRzq30z1DIdE4wpmqJ/NoEzp7iOGQQrqqiajBXUrb/CDLc8j3mJ6/XPHzey+fYeEh9pbN0Vu7gRQqgzQK9MeN8RMD/hckM+Xq/Pvhfv5iTSvnJN1JIXg+KMpJ6j7pWilGWUNXDBX6SFiMLFQwQAgPJD25gbAku26YomMcTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q21QOAXtnOBe0plzhTxDeDvB41KS0doqi2Z1O8jGzGPQ8W/dPAV09KyrKLhAuny+fBzoW0BEhv6DJP1tT40jRm6qj1bgJHi1Fr6gP4JjOIynuMqP1L/Tidl7kxLNajaNO66DLmp7IeZO68xy618MSQKFfh+Z0KCSxScIrEqreJi/UvgV6I1HiTaxlsGInQEysJZOqeOE/6mBtBAYEZ6E+4abc8VdYDLb3Je/j+kQF2NJM5h0QmH+vifVuu2oU0j1Fyf7VIQZp5s8OImh9LrJv7b3WAJLx9BU759u8bmBZpw/Qkh73MIiuyn7tajibDMIDTpOyltZ7mwljr5kH3ESDw1F44c8b1vtJt7zBjNh3R6McGLKG99PQss2gkJF4f7aHIFjcx7fEWVwZ3FYLldxGT4Ew/AuQ+O2fr/NXfuW6LJoAo8yo4N4IR6CwbrRwFrO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 06:14:33.0867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a26eba18-5dba-475c-04b6-08def381fba2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF34483F4BA
Received-SPF: permerror client-ip=40.107.200.54;
 envelope-from=Michael.Roth@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Michael Roth <michael.roth@amd.com>
From:  Michael Roth via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fourth release candidate for the QEMU 11.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-11.1.0-rc3.tar.xz
  http://download.qemu.org/qemu-11.1.0-rc3.tar.xz.sig

You can help improve the quality of the QEMU 11.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/19

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/11.1

Please add entries to the ChangeLog for the 11.1 release below:

  http://wiki.qemu.org/ChangeLog/11.1

Thank you to everyone involved!

Changes since rc2:

3e3ccab106: Update version for v11.1.0-rc3 release (Stefan Hajnoczi)
9232220004: gitlab: disable provenance attestations to work around CI bug (Stefan Hajnoczi)
dd272c8c87: qapi/dump: add allowed-by-guest feature to win-dmp (Denis V. Lunev)
5ce01c9238: hw/display/virtio-gpu: Unmap DMA regions on reset (Bin Guo)
d513c644b8: hw/display/virtio-gpu: Always reject invalid scanout bounds (Akihiko Odaki)
1f24066fc8: virtio-gpu: reject requests with short/truncated control headers (Ankur Saini)
555d0a1eba: hw/display/virtio-gpu: drop redundant node->value NULL checks (Marc-André Lureau)
b8ef970532: hw/display/virtio-gpu: fix offset wraparound in scanout_blob_to_fb (Marc-André Lureau)
a113e0c53f: vhost-user-gpu: fix integer overflow in buffer allocation (Marc-André Lureau)
95687639e6: hw/display/vga: fix panning_buf OOB after text/graphics switch (Marc-André Lureau)
241095547a: hw/display/virtio-gpu: validate blob iov size (Marc-André Lureau)
29922afeae: iotests: increase timeouts for tests to 5 minutes (Daniel P. Berrangé)
431f59a34d: hw/block/fdc: report a missing address mark on an empty drive (Christian Quante)
d00567f7fb: hw/block/fdc: select the drive named by the READ ID command (Christian Quante)
7d06bbb2d9: iotests: test O_TRUNC behavior for fuse exports (Fiona Ebner)
7a34f7b879: hw/nvme: fix leak on copy ranges (Klaus Jensen)
86f938333e: hw/nvme: cancel inflight requests on controller reset (Minwoo Im)
849ea354dd: hw/nvme: factor out nvme_sq_cancel_inflight() (Minwoo Im)
1d5e53df16: hw/nvme: drop AER requests without aiocb in nvme_del_sq() (Minwoo Im)
b9ad1c4396: block/export/fuse: fix regression with O_TRUNC when export is not growable (Fiona Ebner)
e554413bd2: coroutine: fix lost wakeup in qemu_co_sleep_wake() (Denis V. Lunev)
5add514ba3: iotests/migrate-bitmaps-postcopy-test: replace the timing assertion with a content check (Denis V. Lunev)
951227d375: iotests: skip FUSE tests when FUSE is not usable (Denis V. Lunev)
43e4791d99: iotests: run the test pool with the 'fork' start method (Denis V. Lunev)
fe0f9e3ab2: qcow2: do not try to clear the dirty bit on a read-only node (Denis V. Lunev)
370882d086: dmg: reject inconsistent UDRW chunk sector count and length (CVE-2026-65928) (Stefan Hajnoczi)
ab7b872f0c: dmg: refuse to open files with no chunks (Stefan Hajnoczi)
0c43f801c0: dmg: fix out-of-bounds load in search_chunk() (CVE-2026-65929) (Stefan Hajnoczi)
842c89281a: tests/unit: add reproducer for BlockAcctStats histogram locking race (Denis V. Lunev)
16f94ef4c6: block/qapi: take stats->lock when reading BlockAcctStats for query-blockstats (Denis V. Lunev)
5b0ba385a0: block/accounting: take stats->lock in latency histogram setters (Denis V. Lunev)
0d3db94a88: block/cloop: fix integer overflow in total_sectors calculation (malike)
338d81b22b: vfio/pci: Guard accel_irqchip_begin_route_changes() calls (Cédric Le Goater)
f498c21b35: hw/vfio: Fix liveness check in vfio_connect_kvm_msi_virq() (Tycho Andersen (AMD))
c25f69595a: target/i386: Update cc_op for SAHF (Richard Henderson)
c490037c13: target/arm: Remove stale comment about WFE/SEV implementation (Peter Maydell)
d88781a4e8: target/arm: Make YIELD, WFI and WFE be NOPs on pre-v6K (Peter Maydell)
dd0d695306: target/arm: Don't NOP the SEV insn on v6K CPUs (Peter Maydell)
702252a0db: target/arm: Fix b16b16 feature test for SME2 BFCLAMP, BFMAX, BFMIN (Richard Henderson)
8d0ac5933a: linux-user/aarch64: Fix SHADOW_STACK_SET_TOKEN (Richard Henderson)
518a4aa01b: linux-user: fix incorrect msg_l[sr]pid members of target_msqid_ds (no92)
9e3df3019d: linux-user: Fix msqid_ds struct wrt 32-bit big endian architectures (Helge Deller)

