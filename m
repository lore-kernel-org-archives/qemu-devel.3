Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4524CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 23:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpGMQ-0007eR-Sq; Tue, 26 Mar 2024 19:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rpGMP-0007d8-80
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 19:37:41 -0400
Received: from mail-mw2nam12on2054.outbound.protection.outlook.com
 ([40.107.244.54] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rpGMM-0000fc-9s
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 19:37:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzyNY6Fk7HfplorXX0g5c2hD1YkgS4/R0YA+xoi58BnOgow98A8M9QAHgTN8uEDjYu7RT/7KaULbWfs4cLOb6T7ZiACO65m2z3RIbLXj6kcC9DW2FVfZU/oMFllpUB/V3ZL65e0+eJ9wYldz3CWAMyeMMKgdqHLtDZvmt1OX6ZZgPHigOmWlEChU87wNpDHBKHwmnVRRNkLmzNfM3jSGIX7T4LVSjLAiBAqzGRHOxjhQ2uZxSOuTDwG9Wq2uMocOsFC5QeSVUjtGQroGvjQyfagfNcLLQvIip6sbaut3NqUxi0bVSvMKKmsSb+hG3Kf+YPxiv7FlY+8vxt2VhMK6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afd7ZmXvDr9cNRRsXoDTUarS21ReHkgGlhEmnqmrwco=;
 b=IvDGvcqFia5HaMypvyS+beJHjkdydNBxk771Gpz7zvObzZGKjU1aVFYzXRC5VE6qzvTcZVnqz2oBFZG9Lh3hrR6A5vUYLiOBQk3apfTqKEDKKcfAHk2eJEsJaEKYDb8Acqet1FNxxAjbh3Si507L/X3bSKcgevaSZFtUjsgslR/G8SLcPv2lZDJoD6rYDEQs2mPP1kanwqVF0yIPXWKtvBvnOJ8w0ESPp0gKciWWxT/iXwtdpCHJyPZXUrYbEH3S2hi87CQZDHnglq7FLxVBLML6AXk2YSBky3XeQu6M/2DBqHm2EcPjD5D+zAgHntuiSHEQD1l1bZw56xubeN7M2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afd7ZmXvDr9cNRRsXoDTUarS21ReHkgGlhEmnqmrwco=;
 b=zLS+UjQW3xYvj+20+qrZH8Opt+d07HqJn8ClT6C6il+KFqPJknUG2KcTkFUZa9tFy6q1lhJAcBlno7sB4LyL+IqePfETRj2s8wAVjBhFmH/b1X/nni8LMEeO4N7seJ5hUw/T1XTR09doAOiZGbpOtj3WzJGucI06QYCksoDw+G4=
Received: from BYAPR07CA0050.namprd07.prod.outlook.com (2603:10b6:a03:60::27)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 23:32:32 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::58) by BYAPR07CA0050.outlook.office365.com
 (2603:10b6:a03:60::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 23:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 23:32:30 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 26 Mar
 2024 18:32:30 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.0.0-rc1 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>
Date: Tue, 26 Mar 2024 18:32:09 -0500
Message-ID: <171149592996.223644.7508048150772844364@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 505e0857-8344-49df-55e1-08dc4ded01be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZtpTD3IWgzMSrxRQbe3DaP9u0ZS3OFBkuIeUE8uoSb7t6ja5/fL2iLlHuQC/hRrxkSBAweyimPj0AEcgPa8RU4CcxZTWIsi2UJqw3EB9o1wFkkSdNFHR1eeFrnSSYka7WvXt17KtuKnhoJUpkuSNGV8xcPY1US9QakLd3qks+GvHBkwx2w2PD6ahyEaGexdW+qaJWPd9D+JOhs7rHA8ezuwr0TNMJ+Nxrt4RZKhNr6w8XL9wDbWPbXFFx/ZPE0mhwNXrRSBIxwqYo/pNMXaw8oZ4KwyXlr1gPtMimwabaqSm5ebWwrM8+TWAc6gOKZJhbou5eAdX/m7/2acs/XwFQkrazwQZaOYaKQqUVklw3Hnls/8Bxmj3E2mC3HVDQAOV9stzPhYXsHaXQ//ObZBpZrOqR3uhvDZiTKxNsUEhfhWjCauVZjtUTK+kkFNVwDkqe4WuhZGT8/kOTLsvHp3+sJzrCcc4mh1Gc/LP1MNFUHA222rhxcuaBVJZxcZ0vDwMdfb0vLJL7rvgP2dIX7knCFUHHeH5tQl74MnpVQdicUrJEXHmxYCxSCqbQrBikyOv/1i7i8zw/CSVtv/yFpDH90vcYpKm9dLxAZZJwAcNyhkeOSDog3/k9ENiMhAft02Nqz8VhqJyFFR4KfgsBHhV6IOA7AhfQmc4CJl3xaPviZB/BkzaPegbvjXm8imZdEoAzjb9KaSCii8ZIJOgauUOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 23:32:30.9731 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505e0857-8344-49df-55e1-08dc4ded01be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087
Received-SPF: permerror client-ip=40.107.244.54;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
second release candidate for the QEMU 9.0 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-9.0.0-rc1.tar.xz
  http://download.qemu.org/qemu-9.0.0-rc1.tar.xz.sig

You can help improve the quality of the QEMU 9.0 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/11

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/9.0

Please add entries to the ChangeLog for the 9.0 release below:

  http://wiki.qemu.org/ChangeLog/9.0

Thank you to everyone involved!

Changes since rc0:

5012e522ac: Update version for v9.0.0-rc1 release (Peter Maydell)
ccebb9ae35: ui/cocoa: Use NSTrackingInVisibleRect (Akihiko Odaki)
f69a6f0413: ui/cocoa: Resize window after toggling zoom-to-fit (Akihiko Oda=
ki)
d2ee0420a3: ui/cocoa: Fix aspect ratio (Akihiko Odaki)
5c5d00df67: hw/smbios: add stub for smbios_get_table_legacy() (Igor Mammedo=
v)
d5866a7a4e: contrib/plugins/execlog: Fix compiler warning (Yao Xingtao)
1dd7754aca: docs/system/ppc/amigang.rst: Fix formatting (BALATON Zoltan)
32da7e207c: hw/misc/stm32l4x5_rcc: Propagate period when enabling a clock (=
Arnaud Minier)
1f439706a0: hw/misc/stm32l4x5_rcc: Inline clock_update() in clock_mux_updat=
e() (Philippe Mathieu-Daud=C3=A9)
52405b7f69: hw/clock: Let clock_set_mul_div() return a boolean value (Phili=
ppe Mathieu-Daud=C3=A9)
e66d741467: target/tricore/helper: Use correct string format in cpu_tlb_fil=
l() (Philippe Mathieu-Daud=C3=A9)
a158c63b3b: monitor/hmp-cmds-target: Append a space in error message in gpa=
2hva() (Yao Xingtao)
7c7a9f578e: hw/scsi/scsi-generic: Fix io_timeout property not applying (Lor=
enz Brun)
9dab7bbb01: target/i386/tcg: Enable page walking from MMIO memory (Gregory =
Price)
12d7b3bbd3: iotests: add test for stream job with an unaligned prefetch rea=
d (Fiona Ebner)
bac09b093e: block-backend: fix edge case in bdrv_next_cleanup() where BDS a=
ssociated to BB changes (Fiona Ebner)
f6d38c9f6d: block-backend: fix edge case in bdrv_next() where BDS associate=
d to BB changes (Fiona Ebner)
3f934817c8: block/io: accept NULL qiov in bdrv_pad_request (Stefan Reiter)
2c66de61f8: vdpa-dev: Fix initialisation order to restore VDUSE compatibili=
ty (Kevin Wolf)
d9e4070603: tests/qemu-iotests: Test 157 and 227 require virtio-blk (Thomas=
 Huth)
1a533ce986: qapi: document parameters of query-cpu-model-* QAPI commands (D=
avid Hildenbrand)
125f973cc2: qapi/block-core: improve Qcow2OverlapCheckFlags documentation (=
Vladimir Sementsov-Ogievskiy)
1de759534d: qapi: document leftover members in qapi/stats.json (Paolo Bonzi=
ni)
b2913cc2a1: qapi: document leftover members in qapi/run-state.json (Paolo B=
onzini)
6087783ea7: qapi: document InputMultiTouchType (Marc-Andr=C3=A9 Lureau)
7270819384: qga/qapi-schema: Refill doc comments to conform to current conv=
entions (Markus Armbruster)
5305a4eeb8: qapi: Correct documentation indentation and whitespace (Markus =
Armbruster)
209e64d9ed: qapi: Refill doc comments to conform to current conventions (Ma=
rkus Armbruster)
1e6b0505c4: qapi: Don't repeat member type in its documentation text (Marku=
s Armbruster)
73c67f3851: qapi: Start sentences with a capital letter, end them with a pe=
riod (Markus Armbruster)
7d08424cf7: qapi: Fix abbreviation punctuation in doc comments (Markus Armb=
ruster)
8698e1447f: qapi: Fix typo in request-ebpf documentation (Markus Armbruster)
aa03e16383: qapi: Fix argument markup in drive-mirror documentation (Markus=
 Armbruster)
7d50757c65: qapi: Tidy up indentation of add_client's example (Markus Armbr=
uster)
b5e29402f1: qapi: Tidy up block-latency-histogram-set documentation some mo=
re (Markus Armbruster)
f972ed5925: qapi: Expand a few awkward abbreviations in documentation (Mark=
us Armbruster)
c15fbc66e2: qapi: Drop stray Arguments: line from qmp_capabilities docs (Ma=
rkus Armbruster)
e6c60bf02d: qapi: Fix bogus documentation of query-migrationthreads (Markus=
 Armbruster)
8eb0a257c5: qapi: Resync MigrationParameter and MigrateSetParameters (Marku=
s Armbruster)
e8c5503a5c: qapi: Improve migration TLS documentation (Markus Armbruster)
fe3e383901: tests/qtest/libqtest.c: Check for g_setenv() failure (Peter May=
dell)
43199b1393: tests/unit/test-throttle: Avoid unintended integer division (Pe=
ter Maydell)
f9b29c6364: tests/tcg/s390x: Test TEST AND SET (Ilya Leoshkevich)
272fba9779: target/s390x: Use mutable temporary value for op_ts (Ido Plat)
66e411885a: libqos/virtio.c: Correct 'flags' reading in qvirtqueue_kick (Zh=
eyu Ma)
6328d8ffa6: misc/pca955*: Move models under hw/gpio (C=C3=A9dric Le Goater)
b13ba381ca: hw/nvram/mac_nvram: Report failure to write data (Peter Maydell)
c67f758069: hw/misc/pca9554: Correct error check bounds in get/set pin func=
tions (Peter Maydell)
bed150be5b: net/af-xdp.c: Don't leak sock_fds array in net_init_af_xdp() (P=
eter Maydell)
e921e00d4b: tests/unit/socket-helpers: Don't close(-1) (Peter Maydell)
80e9791a93: tests/qtest/npcm7xx_emc_test: Don't leak cmd_line (Peter Maydel=
l)
1967e9e067: aspeed: Make the ast1030-a1 SoC not user creatable (C=C3=A9dric=
 Le Goater)
ed6d5c2e58: aspeed: Make the ast2600-a3 SoC not user creatable (C=C3=A9dric=
 Le Goater)
ed355dc107: hw/microblaze: Do not allow xlnx-zynqmp-pmu-soc to be created b=
y the user (Thomas Huth)
8c37f869f3: .travis.yml: Remove the unused xfslib-dev package (Thomas Huth)
0235540bba: .travis.yml: Shorten the runtime of the problematic jobs (Thoma=
s Huth)
8fa1a21c6e: migration/multifd: Fix clearing of mapped-ram zero pages (Fabia=
no Rosas)
910c164736: migration/postcopy: Fix high frequency sync (Peter Xu)
bd4480b0d0: migration: Revert mapped-ram multifd support to fd: URI (Fabian=
o Rosas)
1590154ee4: target/loongarch: Fix qemu-system-loongarch64 assert failed wit=
h the option '-d int' (Song Gao)
385e575cd5: target/riscv/kvm: fix timebase-frequency when using KVM acceler=
ation (Yong-Xuan Wang)
e06adebb08: target/riscv: Fix mode in riscv_tlb_fill (Irina Ryapolova)
c9b07fe14d: target/riscv: rvv: Remove the dependency of Zvfbfmin to Zfbfmin=
 (Max Chou)
078189b327: hw/intc: Update APLIC IDC after claiming iforce register (Frank=
 Chang)
0a11629c91: target/riscv/vector_helper.c: optimize loops in ldst helpers (D=
aniel Henrique Barboza)
bac802ada8: target/riscv: enable 'vstart_eq_zero' in the end of insns (Ivan=
 Klokov)
d57dfe4b37: trans_rvv.c.inc: remove redundant mark_vs_dirty() calls (Daniel=
 Henrique Barboza)
b46631f122: target/riscv: remove 'over' brconds from vector trans (Daniel H=
enrique Barboza)
df4252b2ec: target/riscv/vector_helpers: do early exit when vstart >=3D vl =
(Daniel Henrique Barboza)
929e521a47: target/riscv: always clear vstart for ldst_whole insns (Daniel =
Henrique Barboza)
7e53e3ddf6: target/riscv: always clear vstart in whole vec move insns (Dani=
el Henrique Barboza)
768e7b329c: target/riscv/vector_helper.c: fix 'vmvr_v' memcpy endianess (Da=
niel Henrique Barboza)
0848f7c18e: trans_rvv.c.inc: set vstart =3D 0 in int scalar move insns (Dan=
iel Henrique Barboza)
d3646e31ce: target/riscv/vector_helper.c: set vstart =3D 0 in GEN_VEXT_VSLI=
DEUP_VX() (Daniel Henrique Barboza)
68c9e54bea: target/riscv: do not enable all named features by default (Dani=
el Henrique Barboza)
9352f80cd9: coroutine: reserve 5,000 mappings (Stefan Hajnoczi)
05007258f0: meson: remove dead dictionary access (Paolo Bonzini)
55900f5dcc: tests/avocado: sbsa-ref: add OpenBSD tests for misc 'max' setup=
 (Marcin Juszkiewicz)
385ac766e8: tests/avocado: sbsa-ref: add Alpine tests for misc 'max' setup =
(Marcin Juszkiewicz)
21f123f3c2: tests/avocado: drop virtio-rng from sbsa-ref tests (Marcin Jusz=
kiewicz)
06f6bbc3bd: tests/avocado: update sbsa-ref firmware (Marcin Juszkiewicz)
9837697b7f: gitlab: aggressively avoid extra GIT data (Alex Benn=C3=A9e)
732810235f: tests/plugins: fix use-after-free bug (Paolo Bonzini)
7fd226b047: target/i386: Revert monitor_puts() in do_inject_x86_mce() (Tao =
Su)
d4069a84a3: ui: compile dbus-display1.c with -fPIC as necessary (Marc-Andr=
=C3=A9 Lureau)
e99441a379: ui/curses: Do not use console_select() (Akihiko Odaki)
ca3de7b5af: ui/cocoa: Do not use console_select() (Akihiko Odaki)
d4c199566f: ui/vnc: Do not use console_select() (Akihiko Odaki)
271a197425: ui/vc: Do not inherit the size of active console (Akihiko Odaki)
77642f92c0: target/loongarch: Fix qemu-loongarch64 hang when executing 'll.=
d $t0, $t0, 0' (Song Gao)
9c70db9a43: target/loongarch: Fix tlb huge page loading issue (Xianglai Li)
0a57a96ec6: hw/intc/loongarch_extioi: Fix interrupt routing update (Bibo Ma=
o)
518d2f4300: target/hppa: fix do_stdby_e() (Sven Schnelle)
b5e0b3a53c: target/hppa: mask privilege bits in mfia (Sven Schnelle)
ad1fdacd1b: target/hppa: exit tb on flush cache instructions (Sven Schnelle)
ae157fc250: target/hppa: fix access_id check (Sven Schnelle)
d37fad0ae5: target/hppa: fix shrp for wide mode (Sven Schnelle)
c3ea1996a1: target/hppa: ldcw,s uses static shift of 3 (Sven Schnelle)
46174e140d: target/hppa: Fix assemble_12a insns for wide mode (Richard Hend=
erson)
4768c28edd: target/hppa: Fix assemble_11a insns for wide mode (Richard Hend=
erson)
72bace2d13: target/hppa: Fix assemble_16 insns for wide mode (Richard Hende=
rson)
c3b1aa1c1a: crypto: report which ciphers are being skipped during tests (Da=
niel P. Berrang=C3=A9)
48ca1cabd3: crypto: use error_abort for unexpected failures (Daniel P. Berr=
ang=C3=A9)
e503fc55ac: crypto: query gcrypt for cipher availability (Daniel P. Berrang=
=C3=A9)
eac57306d8: crypto: factor out conversion of QAPI to gcrypt constants (Dani=
el P. Berrang=C3=A9)
038b421788: Revert "chardev: use a child source for qio input source" (Dani=
el P. Berrang=C3=A9)
e8ee827ffd: Revert "chardev/char-socket: Fix TLS io channels sending too mu=
ch data to the backend" (Daniel P. Berrang=C3=A9)
8bd8b04adc: chardev: lower priority of the HUP GSource in socket chardev (D=
aniel P. Berrang=C3=A9)
e79f8b8b2d: seccomp: report EPERM instead of killing process for spawn set =
(Daniel P. Berrang=C3=A9)
4a1babe58a: update edk2 binaries for arm, risc-v and x86 secure boot. (Gerd=
 Hoffmann)
1093201857: roms/efi: use pure 64-bit build for edk2-x86_64-secure-code.fd =
(Gerd Hoffmann)
2ffd75ef62: roms/efi: exclude efi shell from secure boot builds (Gerd Hoffm=
ann)
a3eeb4f646: roms/efi: drop workaround for edk2-stable202308 (Gerd Hoffmann)
a406930968: roms/efi: clean up edk2 build config (Gerd Hoffmann)
3343f296ff: vl: do not assert if sev-guest is used together with TCG (Paolo=
 Bonzini)
7ea9cfc8ab: vl: convert qemu_machine_creation_done() to Error ** (Paolo Bon=
zini)
2cc68629a6: target/i386: fix direction of "32-bit MMU" test (Paolo Bonzini)

