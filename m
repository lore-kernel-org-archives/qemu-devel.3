Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6508C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 21:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3LwH-0003tG-I3; Fri, 11 Apr 2025 17:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1u3Lw9-0003sc-AD
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 17:29:21 -0400
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com
 ([40.107.94.41] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1u3Lvr-00076H-9j
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 17:29:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EU2fJT3H0SeteAVGJwsxRGPlE99Ubg+1LQkji9SG6iKTL9lh+HO/OdVnBGQHZPM3ay+h+HZqcMSPGxRdZmIOFf0KMo8JjA+vf6jcZMRy5tl2dwmUZclAIskIqsShfuPfVRQ+OuNAfmWKmzakc2BcJ/AM+f1kidY02amk+m4a52Fm6LfbulIPEhmuUGpbDUw3YaHI1emETw89flHCc8vMBzRZVEeYi8dhQ9ivYnHgwXA/ySSmQd0FodKwk7RYSNdP5cI74lgXKdSoGri+wm6ak0ZHh31B6JVhCeTWIBs1xEW+CuzgNm7Ga2hpCm3D7i7tZF/ypLcvTxyrSvWOCaw20Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6+8b13Dqp6MbCL6b9qkTKeLoLFT/cqonHxxox2jT2w=;
 b=U/fii4YL3P+uqec2GgpxjhGwFCs7GUXJRRHommyc5C/dGC/yihMW9tgPMX0Ld9o6N+2Rg5PTOSi3m7LtWdflFy5ebjfFcUACkAGkrslg2gTYi3w2ekvRoi285Jo+L2xw9p+4mruTWN1rd/Kx4b0bDRBBkzT34Pjw4xqXJgicsyXgr2P4fiKuuBJgZhBL3SxkvOmhsRV7/Znhw7E5H3bpfcHA5xC4k6M2o7PIMFDIAErQYhGzyNCYlzgkcWKMwIoi6dV9ctQxIBBDLUq2hhhp44yQfX0gHN7TWZxNpUCgQ9kYcDYER9R8InDpgyFF/ldxSOa4rnwxDhCZrF8VR76AUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6+8b13Dqp6MbCL6b9qkTKeLoLFT/cqonHxxox2jT2w=;
 b=ydRGvehAeHSBRHsG27nYguroxVvn74+J5NlXVZySGCZu7sJPplfp7Vz5W6h/G9Q6GcEdKvvmk2bFfiF/aVUOg/lXonlW9JcY2ekQl4dqHWoIM5yM7qWzhBy8R3ox/ARF3DPB2o3VrNBrApCqXJBKBYPCOlWJlW7blGGb4BV72qQ=
Received: from BN9PR03CA0536.namprd03.prod.outlook.com (2603:10b6:408:131::31)
 by IA0PR12MB7750.namprd12.prod.outlook.com (2603:10b6:208:431::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Fri, 11 Apr
 2025 21:23:52 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:408:131:cafe::a2) by BN9PR03CA0536.outlook.office365.com
 (2603:10b6:408:131::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 21:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 21:23:51 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 16:23:51 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.0.0-rc3 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 11 Apr 2025 16:23:36 -0500
Message-ID: <174440661624.3334756.17990862921703010890@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|IA0PR12MB7750:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db14ace-6c8b-4fa9-7b1e-08dd793f282b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UE5mSXNKQ2RGZk9YVCsrQ2V5NG1zVFFUNDZjWDE1aXNMcTBzaTE3OEtNR3Nh?=
 =?utf-8?B?MlRuNEVFU3JjdmpEdG9zRTVQWTZRUEZ5TEloMFJnSDczUXdBRUhUMnRpNHlL?=
 =?utf-8?B?NXExNW56YnZCcnNHVXc0NGVwWmJBbkNrN1BOa0p5T1ZTbWFFODQ5amNudTBh?=
 =?utf-8?B?cGg2cVR5RzJXRVREQUpTNVhoSlcwcWpISDJPTm9Id0EvR1Ezb0VFeDhoSTlT?=
 =?utf-8?B?VGVJT0luV1V0UjMzbzhLRnd4ekZDTjN2YWNocTNiWWJRTk1TcjgwY1RpTFlK?=
 =?utf-8?B?RmE0a2xIOWlpa29qNExWRk5FOWRLNklHOEtSdlNEQ1NFUFdWM1h3MDRqK1R3?=
 =?utf-8?B?T1RRajNLTlZxWXhrK1J1ZUdNUmJPMkx0RzZuMGd6WWo2eGh1Q0ZpeTAxR3RC?=
 =?utf-8?B?V1JiMURqRHY2Z0hjazJVa2xwWmxjNGljanNZT2lXT2R0akZ3dkt2V3BzR3hR?=
 =?utf-8?B?SURYU3lFL1pXeU1NY0ZZS0hxMGRVcmg3dWhGMHVBQmUxcHdFTXRLQUZYKzJZ?=
 =?utf-8?B?cWRVbEpvVFgxMnF3SzRRU1k3MU9LYWMyeTE0M0huTytZWlprM3U2KzQ2bDdE?=
 =?utf-8?B?c3poVHhtU1ZEQ2lHN2RJWVAzOXJnQkUvWDVqZFBPK2pMME1ZN0JXYy82UVBq?=
 =?utf-8?B?R09rN3dYUDN6Nkd2aVdUQjF0VThaVXpOSkkzcGpiWHBreS9MVnlFNFRIM1VJ?=
 =?utf-8?B?TUhxcUNxblhBM1d4U0xHS1FmUnArY0RCY1pobHgzd1lJUkN2S2FSRy9zejdC?=
 =?utf-8?B?d0FsZCtWZnNTeWxkdzQzSnE2L1V0K0Fubk5JUk9odFZUcFozZ2tzOU1iYTZQ?=
 =?utf-8?B?YW45S2ZVQm5sNnVEU1lEcDhqSHQranhrZWRJb05qTkJzVmxIV1J3dVFuZW5R?=
 =?utf-8?B?Z1RXTHNKVkdJd1NxZXhuYlN1R2RQNk1RK2F3M1NhRmRWR3E5bHJrMHViU3JF?=
 =?utf-8?B?dGEweVd4ZEE4RUgvZHNtVEtUdGRZNmY1OExOTGMzSmV1OE1WTFJXODkvK2p4?=
 =?utf-8?B?QVQ2M0Njb09RZUo4UEVTdEFuRjd3cDFTTnV6T2RjTFlaT1RqWmFqaTdYbzFE?=
 =?utf-8?B?WDZlaEtlbFJVc2VEeU11Nzg0L1QzWUg3SU9Qc1V3b1B5bzA2OGF0MFJGM043?=
 =?utf-8?B?YkdiWkppWElpWXJIdE5LdURwKzBMZjU4ZU00MFQvb21ycWxPeU4yL3hxUHBJ?=
 =?utf-8?B?amJ2eUxPbEdTK2RvQmFibTlMUW9xN1dJaVQ3Wmt1NjR5MVpFK1Jja0o0Q1Fn?=
 =?utf-8?B?TnpFZmpxRmZHcENZY0M4UERaU0x3ZmlVWG9OTGR2OElGbU1RK1l1MlJ0dFFy?=
 =?utf-8?B?MUd0U3kyaDI0MzRkUUUrZnZCTERLbXU5KzNRdGI0dG1EMDFBVENOWHdXZWJU?=
 =?utf-8?B?SXBHcGFhcDlCVGtGOEtYdHMvdjY3NnRkVjA5N1c5d2hFU3l6alpEQjV1THJY?=
 =?utf-8?B?b0ZGK3FCUkxSUnVlTjlTN2ZURVRlbUhGLzgyNmxkQmRiNU4wUTQ4OURDSU1E?=
 =?utf-8?B?YlBlazFmTUlLUCtoWTZFRjd3VlJRRVhqT2laT3lPS2JsaU1McnR0MzltcHVi?=
 =?utf-8?B?SGZJQjV1ZXR0eWZtK00xRzd4azNZVmdEamFtbW9ReEtlOFhlUGNPR051S0Jq?=
 =?utf-8?B?elkxK2VVeDBwWUZDZVVPa0plMFV4eGZaWG55WDZuSnd5akZCRFhpVy9yREdq?=
 =?utf-8?B?MlRBUjhyS1FsZDlaOGtvKy9PN2V2TUVsTERJZmZYU2V3bHF3d2FobGh2MndP?=
 =?utf-8?B?TWkvNVZyWUJuNDdUaENaNGJTNHdzSk9PRGpwZ3FYaFRjKy9sQTJucmNCY255?=
 =?utf-8?B?bTJ3NXJpOVpqenMwVnFlUWJHU0NBejdOcWxUNjRLMjRCcTJFUzFwaFVGa0Rv?=
 =?utf-8?B?cEtvZDFBRG1HL3FOUXBNOTV2VWhyY1NZdHpxbVpXelovUzh3Q1lYd0xZZ3M5?=
 =?utf-8?B?bEtUUGQ1VVFmMmVQTXVBUk4xcUovTkFnQmdFVG93Q1oydWRsblVwR0FPZTlC?=
 =?utf-8?B?RU9Ydnc4Q3dBPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 21:23:51.9848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db14ace-6c8b-4fa9-7b1e-08dd793f282b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7750
Received-SPF: permerror client-ip=40.107.94.41;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
fourth release candidate for the QEMU 10.0 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-10.0.0-rc3.tar.xz
  http://download.qemu.org/qemu-10.0.0-rc3.tar.xz.sig

You can help improve the quality of the QEMU 10.0 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/15

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/10.0

Please add entries to the ChangeLog for the 10.0 release below:

  http://wiki.qemu.org/ChangeLog/10.0

Thank you to everyone involved! And please excuse the delayed
announcement email, which was meant to go out yesterday after
publishing.

Changes since rc2:

56c6e249b6: Update version for v10.0.0-rc3 release (Stefan Hajnoczi)
ae81527b43: scripts/checkpatch: Fix typo in SPDX-License-Identifier keyword=
 (Zhao Liu)
8c996e3271: hw/nvme: fix attachment of private namespaces (Klaus Jensen)
f978f410aa: hw/arm/imx8mp-evk: Temporarily remove unimplemented imx8mp-fspi=
 node from devicetree (Guenter Roeck)
764ca3ec89: hw/arm/imx8mp-evk: Remove unimplemented cpu-idle-states propert=
ies from devicetree (Guenter Roeck)
535ef19566: hw/ufs: Fix incorrect comment for segment_size and allocation_u=
nit_size (Keoseong Park)
2ba700a501: docs/arm: Add apple HVF host for supported guest CPU type (Zhan=
g Chen)
15a9fe6e35: hw/core/machine: Fix -machine dumpdtb=3Dfile.dtb (Joel Stanley)
a7a05f5f6a: smbios: Fix buffer overrun when using path=3D option (Daan De M=
eyer)
f8222bfba3: test-bdrv-drain: Fix data races (Vitalii Mordan)
61b6d9b749: scsi-disk: Apply error policy for host_status errors again (Kev=
in Wolf)
b3d47c8303: target/ppc: Fix SPRC/SPRD SPRs for P9/10 (Nicholas Piggin)
9808ce6d5c: target/ppc: Big-core scratch register fix (Nicholas Piggin)
8e4ffb4ef4: qcow2: Don't crash qemu-img info with missing crypto header (Ke=
vin Wolf)
6b36a57831: qemu-img: fix division by zero in bench_cb() for zero-sized ima=
ges (Denis Rastyogin)
8d41a7dfc2: qga/qapi-schema: Add a proper introduction (Markus Armbruster)
5e03548bf2: storage-daemon/qapi/qapi-schema: Add a proper introduction (Mar=
kus Armbruster)
9199d324a8: qapi/qapi-schema: Address the introduction's bit rot (Markus Ar=
mbruster)
d0ae5a3058: qapi/qapi-schema: Update introduction for example notation (Mar=
kus Armbruster)
6d7b3efc3f: docs/sphinx/qmp_lexer: Highlight elisions like comments, not pr=
ompts (Markus Armbruster)
bc361f2f9b: docs/sphinx/qmp_lexer: Generalize elision syntax (Markus Armbru=
ster)
e27608d053: docs/devel/qapi-code-gen: Improve the part on qmp-example direc=
tive (Markus Armbruster)
0d4c7ea0f8: docs/interop: Sanitize QMP reference manuals TOC (Markus Armbru=
ster)
ae75c37e50: docs/interop: Delete "QEMU Guest Agent Protocol Reference" TOC =
(Markus Armbruster)
2f0bcc65a8: qapi/rocker: Tidy up query-rocker-of-dpa-flows example (Markus =
Armbruster)
23d017ca84: docs/devel/qapi-code-gen: Tidy up whitespace (Markus Armbruster)
fa0dde12db: hw/loongarch/virt: Replace destination error with error_abort (=
Bibo Mao)
988ad4cceb: hw/loongarch/virt: Fix cpuslot::cpu set at last in virt_cpu_plu=
g() (Bibo Mao)
d31d37fded: docs: deprecate RISC-V default machine option (Daniel Henrique =
Barboza)
49551752e8: hw/arm: Do not build VMapple machine by default (Philippe Mathi=
eu-Daud=C3=A9)
51514a34b3: tests/qtest: Skip Aarch64 VMapple machine (Philippe Mathieu-Dau=
d=C3=A9)
bd20bc46fe: tests/functional: Skip aarch64_replay test on macOS (Philippe M=
athieu-Daud=C3=A9)
00f119f4c4: tests/functional: Add a decorator for skipping tests on particu=
lar OS (Philippe Mathieu-Daud=C3=A9)
4412d71382: tests/functional/test_aarch64_rme_virt: fix sporadic failure (P=
ierrick Bouvier)
e139bc4b17: tcg: Allocate TEMP_VAL_MEM frame in temp_load() (Philippe Mathi=
eu-Daud=C3=A9)
961841472d: Revert "iotests: Stop NBD server in test 162 before starting th=
e next one" (Thomas Huth)
719255486d: hw/i386/amd_iommu: Assign pci-id 0x1419 for the AMD IOMMU devic=
e (Suravee Suthikulpanit)
c17ad4b11b: virtio-net: Fix num_buffers for version 1 (Akihiko Odaki)
c0b32426ce: migration: fix SEEK_CUR offset calculation in qio_channel_block=
_seek (Marco Cavenati)

