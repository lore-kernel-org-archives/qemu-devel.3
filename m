Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFF5C52D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 23:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sejhr-0007p0-WB; Thu, 15 Aug 2024 19:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sejhq-0007o5-9i
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 19:16:34 -0400
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com
 ([40.107.237.48] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sejho-0004cl-3d
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 19:16:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilst0fQH9A8EjMfoIP9PwvDz39k4vCVJPM1ovPBfw2Vft+jMiLmQaFYd0ReZSFXHvHTmPEzeu4uxQXX0OiGREmNIf01+yNSbA1txQcWIonb+ZVgK8qbfeRPtoBF46p/Xx37GqbDw8Dc1hJYqKxbZ9i4AwmUYeFpPB+MYMOduUd7SwsGD+eRPtsDnP2IRUcs5srGMbkAzMJVsdOYyZp3fNYOhSAawSqOAuk8ZLDWZ0RVAmMKWqnTZzJx0ulYTxqt87sq72hJ1sV9qP9x36f9e5TtDdzLVwLyFIjjdWIqU1E0oNNXFTtq/FJ7MwYModpMHILlj7YeAL58sWeYu3ONlzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ho8l1Isz5xVgx4wVIOGtMveZWOuJCJ3rR94/QQHOr+8=;
 b=h8T0CY4S5Nm/46wcy0JohMOdmv1eBFhjJRxZlkXbVrT7Gyh8Jj8CKrL5nXf0QJn0Z9Hbv8YYgu3CAgS2PZO3g0asYkFYtY1eqdhRBfI7vGKkUlfsC54P2zq9VGKhGA22DNO46OlThcYme5pESZJt+A9Ogn38RTxiSn+y1nbCvXkIletQyAD063h7k4DaeNLoBLEBVOmOHXzDOOc/AH1rtrE0o3GwyvaIMNl3+CofgJ1CIcm9A+nxD6Z+tf0fttxQagzzT4TPTdvucUCHy1jo6iKAjVNa+iPXA6VTWqu7Yp3XBzFssTgGFJmHwWIVlbSjuicykT6Tr2+R8lPqWn0P7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ho8l1Isz5xVgx4wVIOGtMveZWOuJCJ3rR94/QQHOr+8=;
 b=Pa68B2yb+tq+9TAYwIAFxS/RTI75yz4T4vX9SVzPdUsOLlMnK40UkODF9sG/LyfqfgNzGXqgORduo9aEmhlNwq0CfHgwaKsJtk9+CtO/Us7ceBwb4Irj67tKeEm/vuAvlJjmW9o7z2W2GcGoVIp285Xow86Dzg/w3+lAUxngHhw=
Received: from CH2PR14CA0041.namprd14.prod.outlook.com (2603:10b6:610:56::21)
 by SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 23:11:23 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:610:56:cafe::61) by CH2PR14CA0041.outlook.office365.com
 (2603:10b6:610:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 23:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 15 Aug 2024 23:11:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 18:11:21 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.1.0-rc2 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 15 Aug 2024 18:10:53 -0500
Message-ID: <172376345372.2114103.14180975170706929450@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SA1PR12MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: cafd1488-5210-4f53-de12-08dcbd7f9474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUZaSG01anRYSDhUMjFyTlBsUllTU2NHd3M4dmRjY1lMV2NVNUQwK0o2V1FQ?=
 =?utf-8?B?Rk5lMEFPS2g3aHJzbGNzZkZTWEU1YjR3S1RwRjk4VFVwdXExcDh5c3FkTG5J?=
 =?utf-8?B?VGl6c0Q3UFlDcElKWVNSMEtWa2ZpZnY5T1Y4UDJxTldUUWphdlJ2Q0YwalVU?=
 =?utf-8?B?QTg2MTZOWDNGbE1tbXNPZ3E0Tk1ObEtDM2U0TUVaOE00aGlIV0JPSUhOZTNG?=
 =?utf-8?B?ZmJ5dlRiM2hiTHk2dVdQWUJ1cTFPcnhGSklVTTFCV1Rid3pWenlRWWFubWN2?=
 =?utf-8?B?b29yOEFUQm45Q281S0hGWkh1TUtMclRKeUkvSnYzNWNKaTRRaE1IKzkwbS9a?=
 =?utf-8?B?ZUNkMysrelhrV1EvUmN1ZDNlVndiQWl4Q3ArMHhaMzVWUnIwWUhza1BRZGwy?=
 =?utf-8?B?WDZzWUtpTHJjVmhRZ29EMWswTzJKTGkvSjJHSWJ0aC9iWGZReDBjUjc4Vm0y?=
 =?utf-8?B?WEtoaWdyaHBHWVd5SjBMWjlvU1p4ajJKZ0wzSERDSDZqWDJDcmw4dnRGeDRi?=
 =?utf-8?B?Z2g0b3NlQmVPZ1dEWmNLWS9lS2REVUkyTjlqYTZ0OEhNS1ViVm45RUhCM3I5?=
 =?utf-8?B?bTh5Z0s4MUgxMzMxdmdCcHo3dDFDUGJyTnptZXFucEloc3dMSTJ2eVhpTElC?=
 =?utf-8?B?LzU2SHY0QisrY3lySnZHYlZlU1Y3RWp2dEJpWEl0SmRDUTI1cFNWeE9LWVZt?=
 =?utf-8?B?cllrT3ZvdDg1emtPOEpZeDJacitPc2dXOEVKOUlUSXhMUmFzU3pyOXVjTE84?=
 =?utf-8?B?RTltdEhmWkFObDZ5VW1FNlRYU3RRWWw4VU8rVUc5dHFibGlORG56Wm8wcDdL?=
 =?utf-8?B?eUx1SGUyTzdFUVpRd2dMM2VIZEhMa3hRdi9yUHc4KzFnb29NRDN5eFVKWjZR?=
 =?utf-8?B?YUl3NXB3cENxb1g4QTg3N1VqQS9FSjZveGFWRDdkTmxOeGJRWWRsSUJpTWFC?=
 =?utf-8?B?bmkrd2JMb090TVorbzI2TlZITEpxQXZuOUZZRFNVT0p5d0VWTUZ5VTF1WkZV?=
 =?utf-8?B?MUlKSWduZmJGMGVkbEtZbkZKSnNyaWlIUm1KZTJXSFJrUXlTT1Yvbkd3QVhO?=
 =?utf-8?B?SkM4TlhSVVplTkhweTgwQW1GdzV6bCtCNUxvbzdoSjVaUXlhUWtaTllHVWtt?=
 =?utf-8?B?eFN4VVVGL2NuQzl6eG00M2hQOEI0Rjh5NDlVNEkvWnBvaTk3MmlENVZSSEFU?=
 =?utf-8?B?RmpGNVlXeElxTGhicXNiRFdqUmw0MnZwZW11UmU5TzVVenF4Nk5KcnRPc0l6?=
 =?utf-8?B?Y0RJREJkOEhPVnpqZ3BRL0dnL0I0QjZSQjdZNDhiaHdKaERsZFk2OENBUFM1?=
 =?utf-8?B?V3ZxTWRmdzZXME1mdkFaTHJjUEFQWlZDVW00dkNrTU5LYmNLUDNLdXZVcjBa?=
 =?utf-8?B?bjFualVubmVjanJkNms2UEYxeloxbk1jTkljVlFIU0ZYR2RSQmtialpxL1Vr?=
 =?utf-8?B?NTF3cDVvanBCcHAyTGplSjBGVVlQbUVRSWVDVHJueXgzQUhYSGtSTTVpL1Y0?=
 =?utf-8?B?QjU4dGV1d250VTdLWU82LzBCYXo2M1ZEZEl1RFBLVUpqNjBjcXVPcmw4K3Fo?=
 =?utf-8?B?djd3bU96aXBCMDRKd09yQStYdll6SGNENU42NG5FSzgxM1dNSGdzRlVTVlhs?=
 =?utf-8?B?Lzg1enhQYkx2UGtva1JBUWVIZVc0UUpWcm9EbzVpbDJLR0xjZC9QeW1KV0xO?=
 =?utf-8?B?T3BBbGNrUkpGd0hkSEJQKzhlTTZpTXR2dGpkMXp6WGY5Qk9BeHVCdUpPSjB0?=
 =?utf-8?B?N0grRGFrSWxwbEw1QnZqS2htbERya2p0eWYvNnkzc1liZms2WDBqcCtldGhv?=
 =?utf-8?B?QTRrNEFwNEZUUENPNXphU0NPSmxDakxGdThKVFFTZ2RpWW9SdTgxNHpueVpT?=
 =?utf-8?Q?6Wcw7WEdNDKW/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 23:11:22.7701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cafd1488-5210-4f53-de12-08dcbd7f9474
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917
Received-SPF: permerror client-ip=40.107.237.48;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
third release candidate for the QEMU 9.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-9.1.0-rc2.tar.xz
  http://download.qemu.org/qemu-9.1.0-rc2.tar.xz.sig

You can help improve the quality of the QEMU 9.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/13

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/9.1

Please add entries to the ChangeLog for the 9.1 release below:

  http://wiki.qemu.org/ChangeLog/9.1

Thank you to everyone involved!

Changes since rc1:

b0d6c037ea: Update version for v9.1.0-rc2 release (Richard Henderson)
3aefee3ec0: linux-user: Preserve NULL hit in target_mmap subroutines (Richa=
rd Henderson)
a6e65975c3: target/i386: Fix arguments for vmsr_read_thread_stat() (Anthony=
 Harivel)
3ef11c991e: po: update Italian translation (Paolo Bonzini)
940d802b24: module: Prevent crash by resetting local_err in module_load_qom=
_all() (Alexander Ivanov)
7700d2293c: target/i386: Assert MMX and XMM registers in range (Richard Hen=
derson)
4c2c047469: target/arm: Fix usage of MMU indexes when EL3 is AArch32 (Peter=
 Maydell)
150c24f34e: target/arm: Update translation regime comment for new features =
(Peter Maydell)
8e0c9a9efa: target/arm: Clear high SVE elements in handle_vec_simd_wshli (R=
ichard Henderson)
20516e8d0e: hw/misc/stm32l4x5_rcc: Add validation for MCOPRE and MCOSEL val=
ues (Zheyu Ma)
45230bca85: target/i386: Use unit not type in decode_modrm (Richard Henders=
on)
416f2b16c0: target/i386: Do not apply REX to MMX operands (Richard Henderso=
n)
fe68cc0923: target/hexagon: don't look for static glib (Alyssa Ross)
547c4e5092: block/blkio: use FUA flag on write zeroes only if supported (St=
efano Garzarella)
ed5031ad5d: arm/virt: place power button pin number on a define (Mauro Carv=
alho Chehab)
446e5e8b45: hw/core/ptimer: fix timer zero period condition for freq > 1GHz=
 (Jianzhou Yue)
fa62cb989a: net: Fix '-net nic,model=3D' for non-help arguments (David Wood=
house)
a8e1ea4c97: docs: Typo fix in live disk backup (Eric Blake)
09334420d2: docs/interop/prl-xml.rst: Fix minor grammar nits (Peter Maydell)
7d9fc7e74d: docs/interop/prl-xml.txt: Convert to rST (Peter Maydell)
1bc0fc0a0b: docs/interop/parallels.txt: Convert to rST (Peter Maydell)
8dac93a8ee: docs/interop/nbd.txt: Convert to rST (Peter Maydell)
9ca6876dc0: docs/specs/rocker.txt: Convert to rST (Peter Maydell)
0554840032: include: Fix typo in name of MAKE_IDENTFIER macro (Peter Maydel=
l)
64678fc45d: target/arm: Fix BTI versus CF_PCREL (Richard Henderson)
3e7ef738c8: nbd/server: CVE-2024-7409: Close stray clients at server-stop (=
Eric Blake)
b9b72cb3ce: nbd/server: CVE-2024-7409: Drop non-negotiating clients (Eric B=
lake)
c8a76dbd90: nbd/server: CVE-2024-7409: Cap default max-connections to 100 (=
Eric Blake)
fb1c2aaa98: nbd/server: Plumb in new args to nbd_client_add() (Eric Blake)
c719573d71: nbd: Minor style and typo fixes (Eric Blake)

