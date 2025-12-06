Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337DBD3B7D5
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Dec 2025 13:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRsQ5-0001SW-No; Sat, 06 Dec 2025 08:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1vRsQ3-0001S4-Q2
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 08:33:51 -0500
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1vRsQ1-00073a-7I
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 08:33:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQD0E7bMlww0M1hU4nanitW9k+YMossuyW7ObY5PG7K0dbAmtSZHXin7+0sNDshgsQ5Msgtv7beQfJe0d7VNWtFsd/73AUi1aqhuDlXb8SreHWIvNK0sqzs314y9+OSuQPnWFz6wjz+g0dYlltgEWLOITnsOwwOtwE+/R5VhubwdPcGVe2KSUDdVWrqT3Gbm57Z/ECwfSVS8kIGZZSIzeg0nfBDTIqvUpT2CoyViaLuhf7pSNno9rAIzHhI4zI3nFk4tRivQJmq6kWiblCsCFbpSMsApcwDX1C/xlihVXII1ILv9++Tl0qGYT3p+RWMZeywhbbEV1kZTOVWIcKXHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKM/ugxC+8Rqzc5CouXgOFo4LEa6o+TxNYF5MQUMUYk=;
 b=TUCBR18v13nofxElkKAxlp9E4cHL3TyfUACsSuFSzrlKcbqNc/x9h9PI0zu/KMtOSWYuOZuDVboXUvjKNFNHrwChQBQurwMO/VKuI4xUrXwln9xtbfVhQIGpa3gs97nX2QzrrrD2VPCnmIaJCohJJ7U5mZ5jl3oHk03+D908DwobfQtRhtriNkTtpSFMxOAGLCBj2Ztc08+rs9GWJPHKg2VwcIyfIiSu+1IHgEg/T5KzB+BlAoFFfyklafmbnUuVm09A5qOgnsRUfhXL/Af3BfuUIKNZTdqasDC/SnxsuQJa7BYhoTa8nBlcXAyC5gwCuzGbhWJVtkvcnpGD+JzhZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKM/ugxC+8Rqzc5CouXgOFo4LEa6o+TxNYF5MQUMUYk=;
 b=y/qU/WBqPuQrsHnYMUSEB0w43sLqNVnSWxC11KmSpSJFKeAHbtt3GqJECXfuIPC2tYdociqVZEnoCRhu8eIYfR8qONMA3oGL0mN6udBAlSwz8CkjXpmKbTq20vHuP9Fg/cRHh7VzfpTbwgAGi6vzroR8XwRTXt+xImRLs+kpBVk=
Received: from SJ0PR13CA0199.namprd13.prod.outlook.com (2603:10b6:a03:2c3::24)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.13; Sat, 6 Dec
 2025 13:33:41 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::26) by SJ0PR13CA0199.outlook.office365.com
 (2603:10b6:a03:2c3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.3 via Frontend Transport; Sat, 6
 Dec 2025 13:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Sat, 6 Dec 2025 13:33:39 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 6 Dec
 2025 07:33:39 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.2.0-rc2 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 6 Dec 2025 07:31:25 -0600
Message-ID: <176502788510.2989135.14299176029694137005@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d9dcfb-dda5-43f4-ad42-08de34cc1149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QkhINXRYcTN4RkpwdDVod3ZXNFZBM3FzSngxRnhQNGtoMjJDVjV1NjR4aXdF?=
 =?utf-8?B?VFRwb25KLzNwMGdkQWdoVnNWRG44bnF0Yml6YlhzT0ZLNnF5UVB6QjB6a1lh?=
 =?utf-8?B?R0F3V09WWHB0MnVYWWlLd213UFZTa1FHTGJENzZUNVQ0dnJtR3BjZkEzZzc2?=
 =?utf-8?B?am9lTFlha2U5NEhlWmw3ckM2V0UvbWhiVnlDWWY2WjRMOEFVOS9pRnpmeFkx?=
 =?utf-8?B?TGVpSENHYmcyVG5IWFJqL2FlbXdxa0JMY1c0SVhUUjdoMDRoUTI3b1RJM3Mx?=
 =?utf-8?B?dVBiVHFxbjlkdnYrTXFQeEVmdkR6TlpTNW1zaUpWVlRacGx6M2hncURUdmRT?=
 =?utf-8?B?Ry95WG8xS1JGR3RnYng1Q3d5Q1hGZjF2UVp5SnorbGZoWGxGZlRwZTdHcmhQ?=
 =?utf-8?B?QmNsTFdNbGxwKzREd1NlQkxvQXY5dUtxS2N4dVhpMzFGUnRiZU9aUmFZV1pZ?=
 =?utf-8?B?R29GelJPVjNNY0JvUnZkdDhpTGZNcnQ4eWxIK0piM2tQMU15enUzSUh4aUlx?=
 =?utf-8?B?QitsbVJ6dkxmY2dhRXdzY1BaZnZJU2R0aXVYOUZIc2tSSnc2VzFtQW0zWkli?=
 =?utf-8?B?d0czTERUbU5MbFVmb2licUZXd2VKM0U3V1F3MkhpVHp2d3FmZFV4Z0VzYmk4?=
 =?utf-8?B?WVVjamxLWTNtUmJCMGNNaGU5LzJyZWRqRExtaXZpNlNxNWdCSnlPU0NuSVVq?=
 =?utf-8?B?Q29zQVo0M2R5ek0zODdqVjN3enlBRzhpVmljQ3BodFY4RUszR0RnTVEyOEdt?=
 =?utf-8?B?aW9oWDRoRkl6V2lQNGxKMkxWZ2JKRUZTM1dZajNEckRZTWtzdW02ckNEZTdL?=
 =?utf-8?B?bWkvRHNFMStha3duMHVOcHJsaUNTVUUwQkJmRFRMbUtjRExJdXp1TlFCL1pQ?=
 =?utf-8?B?azlDZVM5YjlOSER3a2NUWnFnY0YwTlVUajMyWlJaSVRJTXVGUE5qelZNU2VG?=
 =?utf-8?B?YU44WlV4Z0tzU2YxeWtWTVVGRE4xaVNYRHM3dW1VY2FTaCsrMUp0L3grYmRK?=
 =?utf-8?B?Y0xrZEl6dEhHT0Zjb3c0NVVyV3paZUpXYUR2VGVWM1VUSXpqUnNiUlJLeWgz?=
 =?utf-8?B?a2RWVElkTUhQMTNUOE5lMnBzd04zdnJZL1pLUFFSK3B0aS9ZckJUeGQxS29y?=
 =?utf-8?B?eGRjVUsvK2FkYWlyeENPMUZEUGxiRjFQdkc1bWxVL1NtYjRXblpNTlUvUDZN?=
 =?utf-8?B?N3Z2UFM5ZTFLSjVVL1lmMUpMYkVpamErUzhWL2xHVWhMd3BROFlkKys1Y0FR?=
 =?utf-8?B?MEdlYjlMdEpHbjBtWjRZOU9PcXFMNzAvYnhvakU1N3lSWTUxdTRpSzgrQncw?=
 =?utf-8?B?MXMzWlVMRjd5S1gxL293R2FaNnZ5TnNFNWdYR3g4aW5EZFpjcmFuVUdDZkFm?=
 =?utf-8?B?eFpVejdmaHQrNDVDS2NvZFlwZVcySURVd1Y1YVErMjlIR3hZenlkbDhtcGND?=
 =?utf-8?B?aS9udDFnNEgvYWhKbmhSQlJWRWQ4QTNBakhlZkRCTDFsdnYrUTh2TEV3REtp?=
 =?utf-8?B?NkpEUnZySCtRNUIwN0pZaThIa09Id2kzWEpaenFTSWlNYTNKVjRVajVvK09C?=
 =?utf-8?B?MkJpeS9xSHVIWmhPUmo0Nk4xUWJGcjUvMWxtTTRSZ3dJV3VYbHhUdVpkSXpr?=
 =?utf-8?B?VHAyUXRuQlh3c3FsMnVLWmVkMHp2VXdqRWZNblZVRnduQlRqS0FtRUxyL1pO?=
 =?utf-8?B?VEFnNnlIS2JGUnA5aWFSWjNBTVlreGVaRDArSndIY3VXdzVmV09Sd0tvYytx?=
 =?utf-8?B?TVdyRXZ6VVV2RXlYK0NKN2VJamE3RzJyYkZkeE9iVzQyUFE3RnRoM3B4RkMy?=
 =?utf-8?B?T3RtLzkrME4vcHlZRTljZUNLN0VJYzJJREJFeTRFNlhVWWlKbnhKU1V5QlpC?=
 =?utf-8?B?VmxEOGh2cjl0QmJVZGZzWkd3MWNXdzl1NW5vb3RzNnYxakp3eE1NbFZwUFlO?=
 =?utf-8?B?S1lZZWN0U25UaTB6ZjBENDUzdldnTjYrdnpaRmgrNXpuRzF2NFV3b1VMNXNI?=
 =?utf-8?B?UldaZG83ZlFORDZkRm9kN09wNzRiNVNaM25lSHlsU09naHpUL0wxS2V4ZHdo?=
 =?utf-8?Q?VqpQae?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 13:33:39.9849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d9dcfb-dda5-43f4-ad42-08de34cc1149
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Michael.Roth@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
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

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
third release candidate for the QEMU 10.2 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-10.2.0-rc2.tar.xz
  http://download.qemu.org/qemu-10.2.0-rc2.tar.xz.sig

You can help improve the quality of the QEMU 10.2 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/17

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/10.2

Please add entries to the ChangeLog for the 10.2 release below:

  http://wiki.qemu.org/ChangeLog/10.2

Thank you to everyone involved!

Changes since rc1:

05f36f7c05: Update version for v10.2.0-rc2 release (Richard Henderson)
88be119fb1: kvm: Fix kvm_vm_ioctl() and kvm_device_ioctl() return value (Ma=
rkus Armbruster)
c1116b1d73: migration: Fix double-free on error path (Markus Armbruster)
3bee93b9ab: accel/hvf: Fix i386 HVF compilation failures (Nguyen Dinh Phi)
ebb625262c: docs/devel: Update URL for make-pullreq script (Peter Maydell)
7248dab3c9: target/arm: Fix assert on BRA. (Harald van Dijk)
57756aa01f: hw/aspeed/{xdma, rtc, sdhci}: Fix endianness to DEVICE_LITTLE_E=
NDIAN (C=C3=A9dric Le Goater)
98ee8aa92e: hw/core/machine: Provide a description for aux-ram-share proper=
ty (Peter Xu)
78d66a25c5: replay: Improve assert in replay_char_read_all_load() (Peter Ma=
ydell)
77f4f14e08: hw/virtio: Use error_setg_file_open() for a better error messag=
e (Markus Armbruster)
6d85f1d449: hw/scsi: Use error_setg_file_open() for a better error message =
(Markus Armbruster)
622a0c9dee: hw/usb: Convert to qemu_create() for a better error message (Ma=
rkus Armbruster)
a5da8dd90b: docs/deprecated: Remove undeprecated SMP description (Zhao Liu)
ef44cc0a76: hw/pci: Make msix_init take a uint32_t for nentries (Peter Mayd=
ell)
3de6afef49: qtest: Allow and ignore blank lines in input (Peter Maydell)
59a1cf0cd3: iotests: add Linux loop device image creation test (Stefan Hajn=
oczi)
d704a13d2c: block: use pwrite_zeroes_alignment when writing first sector (S=
tefan Hajnoczi)
98e788b91a: file-posix: populate pwrite_zeroes_alignment (Stefan Hajnoczi)
8eeaa706ba: block-backend: Fix race when resuming queued requests (Kevin Wo=
lf)
4c1646e23f: ui/vnc: Fix qemu abort when query vnc info (AlanoSong@163.com)
bd3ba0d342: hw/nvme: Validate PMR memory size (Philippe Mathieu-Daud=C3=A9)
cf6a1592f1: hw/nvme: fix up extended protection information format (Keith B=
usch)
3050b34921: hw/nvme: fix namespace atomic parameter setup (Klaus Jensen)
303f604935: chardev/char-pty: Do not ignore chr_write() failures (Philippe =
Mathieu-Daud=C3=A9)
313f6884c8: chardev/char-file: fix failure path (Vladimir Sementsov-Ogievsk=
iy)
4be62d3117: ui/vdagent: fix windows agent regression (Marc-Andr=C3=A9 Lurea=
u)
579be921f5: hw/display/exynos4210_fimd: Account for zero length in fimd_upd=
ate_memory_section() (Peter Maydell)
4a934d284d: hw/arm/armv7m: Disable reentrancy guard for v7m_sysreg_ns_ops M=
Rs (Peter Maydell)
fa9d9f6b71: hw/display/exynos4210_fimd: Remove duplicated definition (Phili=
ppe Mathieu-Daud=C3=A9)
697ccce3c5: hw/arm/Kconfig: Exclude imx8mp-evk machine from KVM-only build =
(Bernhard Beschow)
f5b6ca5606: contrib/gitdm: add more individual contributors (Alex Benn=C3=
=A9e)
e4799403d1: contrib/gitdm: add mapping for Nutanix (Alex Benn=C3=A9e)
93d39daebe: contrib/gitdm: add mapping for Eviden (Alex Benn=C3=A9e)
b6690596b2: contrib/gitdm: add University of Tokyo to academic group (Alex =
Benn=C3=A9e)
9b6ceb6855: contrib/gitdm: add group-map for Microsoft (Alex Benn=C3=A9e)
4a5df19293: contrib/gitdm: add group-map for Huawei (Alex Benn=C3=A9e)
e9a8b04dbb: hw/pci-host/aspeed_pcie: Update ASPEED PCIe Root Port capabilit=
ies and enable MSI to support hotplug (Jamin Lin)
510d5c61ad: hw/arm/aspeed: Fix missing SPI IRQ connection causing DMA inter=
rupt failure (Jamin Lin)
cacd8fb08d: hw/arm/ast27x0: Fix typo in LTPI address (Nabih Estefan)
6aef825073: tests/migration-test: Use MEM_TYPE_MEMFD for memory_backend (Pe=
ter Xu)
c2f2470e31: tests/migration-test: Add MEM_TYPE_SHMEM (Peter Xu)
b1d67d86db: tests/migration-test: Merge shmem_opts into memory_backend (Pet=
er Xu)
b187a183b1: tests/migration-test: Introduce MemType (Peter Xu)
bfcaa18a14: migration/postcopy-ram: Improve error reporting after loadvm fa=
ilure (Markus Armbruster)
ffaa1b50a8: migration: Use warn_reportf_err() where appropriate (Markus Arm=
bruster)
93817ec396: migration: Plug memory leaks after migrate_set_error() (Markus =
Armbruster)
911bdd34ca: migration: set correct list pointer when removing notifier (Mat=
thew Rosato)
0b5bf4ea76: migration: Fix transition to COLO state from precopy (Li Zhijia=
n)
5f9ac96373: Fix the typo of vfio-pci device's enable-migration option (Yang=
hang Liu)
5fbcbf76a1: qmp: Fix a typo for a USO feature (Jack Wang)
bba249a256: qga: use access(2) to check for command existance instead of qu=
estionable stat(2) (Michael Tokarev)
efbcf49ba0: MAINTAINERS: update email of zhenwei pi (zhenwei pi)
88175cff49: MAINTAINERS: s390 maintainer updates (David Hildenbrand (Red Ha=
t))
2bfba5d94b: tests/functional/aarch64/test_rme_sbsaref: Silence issues repor=
ted by pylint (Thomas Huth)
76da444a53: tests/functional/aarch64/test_reverse_debug: Fix issues reporte=
d by pylint (Thomas Huth)
dffd646ae6: tests/functional/ppc/test_ppe42: Fix style issues reported by p=
ylint (Thomas Huth)
5560bad695: tests/functional/ppc/test_amiga: Fix issues reported by pylint =
and flake8 (Thomas Huth)
d0d86db5c9: tests/functional/x86_64/test_memlock: Silence pylint warnings (=
Thomas Huth)
e24882e848: tests/functional/x86_64/test_reverse_debug: Silence pylint warn=
ing (Thomas Huth)
c0e84b9223: tests/functional/x86_64/test_virtio_gpu: Fix various issues rep=
orted by pylint (Thomas Huth)
248b7eae44: tests/functional/arm/test_aspeed_ast2600_buildroot: Fix pylint =
warnings (Thomas Huth)
e5cb62e7b6: hw/s390x: Fix a possible crash with passed-through virtio devic=
es (Thomas Huth)
58f88d0bf7: replay: add tracing events (Paolo Bonzini)
5f9d28a2f8: mtest2make: do not repeat the same speed over and over (Paolo B=
onzini)
b1085f87ef: mtest2make: add dependencies to the "speed-qualified" suite (Pa=
olo Bonzini)
50797af6e8: mtest2make: cleanup mtest-suites variables (Paolo Bonzini)
106d766c9d: target/i386: fix stack size when delivering real mode interrupt=
s (Paolo Bonzini)
9c3afb9d9b: target/i386: svm: fix sign extension of exit code (Paolo Bonzin=
i)
ebb46ba6a4: target/i386/tcg: validate segment registers (Paolo Bonzini)
ebd9ea2947: target/i386: Mark VPERMILPS as not valid with prefix 0 (Peter M=
aydell)
46b06eaeb4: target/i386: emulate: Make sure fetch_instruction exist before =
calling it (Nguyen Dinh Phi)
799fa30a6e: ioapic: fix typo in irqfd check (Paolo Bonzini)

