Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21FEC87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 21:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umIgg-0004bV-Da; Wed, 13 Aug 2025 17:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1umIge-0004bI-Aw
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 17:07:08 -0400
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com
 ([40.107.236.64] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1umIgY-0000i1-V8
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 17:07:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQShrCrAayBvwm42ALI0NzT39Awku27bnWfPCqaXmNMz9zrt15eQ97veHkc1cAO6Lt1SdWku1WUnjENGkncWKeqWQDa7Rx+8cSe5SJpb1WAS3nv2bEFif15A3WguvYjxEj1j7IB97gi6lQgxhNTraVfxT89OPHoGlKyW2DoShJXox1NHl/vxfD8dTSalBEbWnbZHRYl9z5hZsuslD+Czxv0LothS0gLPUxFCO8sOAb7pr8Smn9WLjFg69s8u0h2BcWKjnf9MeMU4pkGB6vABsl7CtZA/OzIDpT6vgTPLfqBVh0qJZeBnncrrTA8rdsktnv2stnDuv1+Y8nNogvppnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yf4uMU9FQzu3fognrZ+TFquV22yCC7Ih/dOznrdHkGo=;
 b=ZbSrra5UZr5HdClFNm0MNUBXUz3DNuxxjhJWssMrI+R7YGcR2hKaN54YFUd460r8LgSwndPLXoe00hJ7flNSLJMSGmecJLFxzumMFaCyqtPqx0/H2Dkmo/eaA3v6cKcHo4/caJd7zPiKI0OUIp+zZtBFPhFw48m/jwqwOnXTfQKm5dQx+BxgdgDQkccXTso5ABdRODEy6udiTKJTHjpmh37X6SkZAX1whGLwXyT+1TLxk3n1L/R3nb3zXzKy8h7+C8OWqlo06rk7E/8Viv+jdr02zLhMA467S4+vkqCPRWAQe2Sc2bJwOgndrzMldNAsQytX3iDqXNpoaAG0VrI/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yf4uMU9FQzu3fognrZ+TFquV22yCC7Ih/dOznrdHkGo=;
 b=woonz58lbt5Eikh00PNGlHMCxQdN1kCyikp4V4I/bTMnyTdb7BNF+tuY9ptcysLFXrkx2KBov8Dop41ilAoVXzhYre3C+Y+DSoE3C9mlqE285gbQLjO4nn3QxzHyr3ckrmIwLMfbv3O31m8m5WpDUKs65F/BnALvylEcCZllE9U=
Received: from BY3PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:39a::30)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 21:01:52 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::1b) by BY3PR03CA0025.outlook.office365.com
 (2603:10b6:a03:39a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 21:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 21:01:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 16:01:51 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.1.0-rc3 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 13 Aug 2025 16:01:35 -0500
Message-ID: <175511889543.3775407.17880470159729384156@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 901c246a-e73d-4f0a-1e3d-08dddaaca0d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm5qb0Nyb1Z5NE1lVHRwa0F3NFRXdjkyVDhIcVJpSGtJQXpEVTF6Sm5PSXY0?=
 =?utf-8?B?U0Nlc1dTZG9UTHovbVgvN2tudi9NZUJpZVhKWER4QVdwbkJlYmhKZ2xKU2FV?=
 =?utf-8?B?eTJValBJWHdSVDkwR2tXMU9xdTcycUJvb2I2NW5IRmgwcitOamh0Y2l3NGpE?=
 =?utf-8?B?bzhVLzh6Y2FHV1Axdi9qbGVoR0NFZmFPaENlWEZRclpiWjFqaXFpK1kwTHZ5?=
 =?utf-8?B?S0dVZVpvcTlsbjk5N0JiekdrblQwSG1LVTJBMG53eFhUeDFjMlNHc1pLbVdx?=
 =?utf-8?B?VHFvZHI0dFBwNTdacGM4d25KdVlIN0xvS0dGS21SYTJpazNvRGlnSVR2WFQ2?=
 =?utf-8?B?YVl4b3JoeVpXUGVmdE9QZS9WdUFwUVNXTDNXZ3lSVWhORVZyS1JlcU5wY01v?=
 =?utf-8?B?ckh3SlptNHdtb2VLdmZiQVJkVENqZm9DUTNPaEN4Q1d4QWpUbWFOUG5jRDJx?=
 =?utf-8?B?cjlUanhSNXc3Q1ZuZit2bVRHQ2xwbGFUbTBRdWFWUVA5MjRBb1NGbFFGOTJi?=
 =?utf-8?B?eFJOKzYyL3BoemoxVG92UFphYWdmNFZNbEpmSElWS2lPVHBVOGNpMmREZ2U5?=
 =?utf-8?B?QmFFbzdpbVdwT2FlaS92T25udjRSWU1CVDR2cDF4MjhQQ0NJZFRTZUpDYnlR?=
 =?utf-8?B?OStNWEpJV1lxYzJVSU5SZGxpVFNTVkg2VjkvUitINE5IT2ZnaFpQbE90SzFq?=
 =?utf-8?B?YXdhVDFtR0szcUFscG81NHVpZklsanZqUnNwdGc2ZEpDYkRhV1hGenlOaFhj?=
 =?utf-8?B?d3NMd1h5YlVVTTYxeFdiV3BqQ241U25DNWtCM0V1RzhHNkFUK01ZckNPVHR2?=
 =?utf-8?B?czlxd2JIcEZUSVk4N2ErclJUKzdUeisxZFlVcXFvWE5wWDBQa0NUNkVNM1VM?=
 =?utf-8?B?UW9yTUp0dDVqWUNNSWljbU1FOWhidlUxTC8vRmdDM0l3a2RabjlwbEhQamRJ?=
 =?utf-8?B?Y2o3SnFXdzUrbVV1QUlnQTNJS2lTazNaeXdDUlhmUHdHN0xoTHNDRkZEMGlG?=
 =?utf-8?B?dVlNOWY5VnBYOEpRTCszTzRveGd2VW56c3hENjNIZVFmMHlwWEIraStFMFNh?=
 =?utf-8?B?Z3RvUUNJZGxrV0YvT2QyaVBJTmtpRU00NVQyR242S2NFRmJoQ1BTaVRSbXhM?=
 =?utf-8?B?Q3h4QWZEMTZZVWJvd3ZMLzhMN2ROK0JzRGoyUjh6UGtMSE1MZWMvcW1NNVRP?=
 =?utf-8?B?QVJVS0NYMEVndktmTXQxNWhHTUJuZGo2VGNTV0haQ3hPZytWa0tlVjFLUHhp?=
 =?utf-8?B?WmxoM2JFcDJnRWxlRGV5QXVETndqWEZ6aTVmOFl0N2tlMzVGV0hCV0RkMGl5?=
 =?utf-8?B?N08wMXI5RTVzV0RmQmhGQmtxWldPREUzamZDZUl3Z2ZzV0ZFYndKREx1UGJr?=
 =?utf-8?B?b1JkTGtoK0djTVIvRmk5K0tnRWNiRmNQeVZVYlhOV28vTTNEeEZCRzl4U3Rk?=
 =?utf-8?B?U2tiQjhyNlJRQ21sOHZlRk9OK0FQSnJvREo0cFB5UU5CVHZhaWttazE3ZzVP?=
 =?utf-8?B?Q0VxQUFwemw3R2wxd1VML0dxeXlhZnRFQVkrRVBsVmJsRTAvM0x0eEdPNGZl?=
 =?utf-8?B?eXplUTJPbUM5djlTT0s5aXh2RXVqMmdDZE9FZE1RQVhoNnp0QUFyMFRJb2hI?=
 =?utf-8?B?Z2RwZGVqenUxQWR6RFVDYVBLYXFaczZLVzg5THpGSmlwdHRVWStmYnQwYmo3?=
 =?utf-8?B?QVkzOWJWaXIyeGp4TWhzdUVaSytpMW9BS3BSRjQzZHdPSWMySnVTa2xYUi9Q?=
 =?utf-8?B?WUg3RVpDSDB2bWQ0TjlzeWdEaXBDQitCalBSMlZKRHJqdnp6VGlETFJNQTFN?=
 =?utf-8?B?blNvNUhkdEtITXNDK0VueUVaS0xhZWNxREJkT3lGMzdWSGNEK1JSREZXYWVJ?=
 =?utf-8?B?NVZJVi81M0t0TzNTUm5zZUFaVzdhM3BhTDllVWExck9tODA3MWhkbnU3WmRu?=
 =?utf-8?B?WmxJSFBMaGJsUTVHdUdudEhleGI2WXlxejViR3hnMzEzMlVqenZ2MXhhNXdQ?=
 =?utf-8?B?dnRudnJKWHhnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 21:01:52.2359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 901c246a-e73d-4f0a-1e3d-08dddaaca0d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796
Received-SPF: permerror client-ip=40.107.236.64;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
fourth release candidate for the QEMU 10.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-10.1.0-rc3.tar.xz
  http://download.qemu.org/qemu-10.1.0-rc3.tar.xz.sig

You can help improve the quality of the QEMU 10.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/16

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/10.1

Please add entries to the ChangeLog for the 10.1 release below:

  http://wiki.qemu.org/ChangeLog/10.1

Thank you to everyone involved!

Changes since rc2:

de784dc0a0: Update version for the v10.1.0-rc3 release (Stefan Hajnoczi)
0c0729b46a: ui/spice: Destroy the temporary egl fb after the blit is submit=
ted (Vivek Kasireddy)
b2a9482207: readthedocs: don't build extra formats (Alex Benn=C3=A9e)
6ad034e712: mkvenv: Support pip 25.2 (Sv. Lockal)
7db162fa01: tests/functional: Test SPI-SD adapter without SD card connected=
 (Philippe Mathieu-Daud=C3=A9)
e262646e12: hw/sd/ssi-sd: Return noise (dummy byte) when no card connected =
(Philippe Mathieu-Daud=C3=A9)
c0df98ab1f: qemu-iotests: Ignore indentation in Killed messages (Werner Fin=
k)
4af976ef39: rbd: Fix .bdrv_get_specific_info implementation (Kevin Wolf)
65677b7aad: configure: Don't disable Rust for too old meson version (Kevin =
Wolf)
621dbaee01: tests/functional: fix URLs in PCI hotplug test for aarch64 (Ste=
fan Hajnoczi)
53493c1f83: hw/nvme: cap MDTS value for internal limitation (Keith Busch)
bc0c24fdb1: hw/nvme: revert CMIC behavior (Klaus Jensen)
31b737b19d: hw/nvme: fix namespace attachment (Klaus Jensen)
79f57adce6: docs/devel/qapi-code-gen: Update cross-reference syntax (Markus=
 Armbruster)
60e847dcf0: docs/devel/qapi-code-gen: Fix typos in QAPI schema language gra=
mmar (Markus Armbruster)
13b4d19ced: docs/devel/qapi-code-gen: Add two cross-references we missed (M=
arkus Armbruster)
d9f4b45713: vfio: Document 'use-legacy-x86-rom' property (C=C3=A9dric Le Go=
ater)
322ee16824: vfio/pci: preserve pending interrupts (Steve Sistare)
76cfb87f5f: vfio/pci: augment set_handler (Steve Sistare)
e66644c48e: target/loongarch: Fix [X]VLDI raising exception incorrectly (WA=
NG Rui)
8c9aae4364: meson: Fix brlapi compile test for Windows builds (Stefan Weil =
via)
5a5d18c756: tests/qemu-iotests/tests/mirror-sparse: actually require O_DIRE=
CT (Michael Tokarev)
c7ac771ee7: ui/curses: Fix infinite loop on windows (William Hu)
a04ba043a3: meson: remove 'gnutls-bug1717-workaround' for migration TLS cra=
shes (Daniel P. Berrang=C3=A9)

