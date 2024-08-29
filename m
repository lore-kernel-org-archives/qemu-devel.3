Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C51C83F0A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 12:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjeDg-0002Q7-1j; Thu, 29 Aug 2024 08:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sjeDd-0002PV-VC
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 08:25:41 -0400
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com
 ([40.107.236.71] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1sjeDZ-0000W5-6w
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 08:25:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYnpVUuq7Pgd3adO6fo3YTLPM0zfn1PcZpex6DO0GEsFU/aNmzvTv258Lm6j6x/l+wrXYhNVhwXFqpNLNKLE3+tZ4dqAZM4coU/XGa3ihgv4jyUHQPeIFAHW1zJyKwVE91ifMT9xFNNuTqxLHWw7382Rx3hKpaAwpIE1vXzFrCNRV1yVusvT8EGWJDQ+U2QSMXT4RgH5JFRxv92XlqlfvAdlRffiZA/V7aKN72f48BCj6SSId9Hzc8a6deYiTDUpcsEyg5hWDUdYSVH+5F90hWkpieL1/IIRzMqWb6DNPtUL55H3dfjj3KFAdnsnDnSzKbb4/emrx8fT3JMci4u0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wecPkW1Su38h4e5heNvvaGqUYkIxzGHUeoR8MtCoP3I=;
 b=nNSAlibftYljz9FCfXQsZtTD+gV65gygY5qpoLE8OYdx7Kn+EuuwRJ1xN9Ajps5buMtZ7GgY6k/NY3iZtXAG9ms0eCsBALV5IocojTwTxQyLerPtiOCLHvuh383QesHwmsjyBx8lqB6gaMiYnipTyE1OSS6OvJ0FzQbLeCIxhzrCe2K00qCac7dXw2erWPZGr9HP5IwIC9pd097Ze429nOZq5ceXjOs9eSP3SM7W3AdSFVTHnenQq4ExFa7VFN67wH+ZX6tfATWeCchl2HEZwnSJbrXdjVsJKFqgvvLqg53MqTnQEdUvO7LlJnYNqw21dGeY0ekpLgN0jAOeMoALhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wecPkW1Su38h4e5heNvvaGqUYkIxzGHUeoR8MtCoP3I=;
 b=0cwM1f0tjrxgjN/HqdeFMWS/kxNQXENHIb1gvzRBSEQhDXIQU7odyscpwHoLUfNxb1xnREbKiGB7Fgw7kks97Rmf0ALXK7n17wJMHCMMw2BJGJUmzAmObdqNPWLHzEmk/C4D1/RohDg4MlXboJKfgd6rWMlQ2stdY/A0gJQkKvQ=
Received: from BN9PR03CA0589.namprd03.prod.outlook.com (2603:10b6:408:10d::24)
 by PH7PR12MB6658.namprd12.prod.outlook.com (2603:10b6:510:211::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 12:20:29 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::78) by BN9PR03CA0589.outlook.office365.com
 (2603:10b6:408:10d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 12:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 12:20:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 Aug
 2024 07:20:28 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.1.0-rc4 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 29 Aug 2024 07:19:37 -0500
Message-ID: <172493397792.2948649.489614605350422137@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|PH7PR12MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: e2d80f97-6c02-4897-8e62-08dcc824f86d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmEvMkdzNCsvNVBDa3RPZ0RFeEJ6bnZ3bmV5eGNDVWhxU0tROWtoRnloN2k3?=
 =?utf-8?B?MkRHd2VDZ1JhU3ZGSWpLdC8xQVhsOGRWNEJjdmhuMkpzdEZORE5QZFlZSHNV?=
 =?utf-8?B?RHdBMGRHb2pnVzFvT0FTSWdQdGRkc1pyaUxBaUlWaFNwZlIxYnRNM0RMSi94?=
 =?utf-8?B?UDIrbDlYTGE1ZzB1ZUVSN2VMeStueDNnalI4OHNoS0xxajBQWFA5Z1NsLzZu?=
 =?utf-8?B?RzBjZnBTMnpRQTF1dEZ5SDhoRXFiQlNQa21HYklhVHF3QVdEM2hjY2FPTyt2?=
 =?utf-8?B?T1BGVDRsRzRxUGNEYU9hdTc4bWcvVllibisyZ2gzcERkazZoNytrVTd4dUV2?=
 =?utf-8?B?WmxxQXB1NnhOMGdyTWhPa09UblBMU2tGdDlSa3pNWHQrNVNjZU80N2lOS0wr?=
 =?utf-8?B?WmJGVnJteG9RU3ZpVklIUll6cC9aMTFxRlMrRFBFczB2MzR0WHlCOGVlbTVo?=
 =?utf-8?B?RDlFZWJMNG41RVovNW5vb1Y1Nm01RWdVMmZKb0FtbEl2QkxKd2hwQ0taT2JO?=
 =?utf-8?B?dXJHZVMvUjdHMmkrODNZSjhsUkloWGxNWVh6RXl3cGNrRit1UHA2alV6SFJu?=
 =?utf-8?B?amdWYlo2TmVUUkdWVzA4OTZXNWlTU2pYZE8wY0pzN3o3bHNVcUxrRFJrNUVn?=
 =?utf-8?B?c29JdmMyalp3LzBDempadFFBTG91ZnhScjUvODNKWUpRZ0tZYmVGenkzeDRo?=
 =?utf-8?B?UUJFUVY1Zmtodis4bUtZai9rSmtHelpEbjlrbnBaZEE0aHhjSkRsbEl2U0Nn?=
 =?utf-8?B?RjJlU2s0UW9LQUJZMFZBM09yK0dReFFybC9GbUN4RGhkNWNoNFp6NFBsMGVk?=
 =?utf-8?B?QjBZUyt2U2VEdFM5cW8ycWd1eVNJTTVSeWJEN011R0t1QnBGNTl6YTBDWVoz?=
 =?utf-8?B?Z1JuenorcWU5elZYaDhKK253cFhzYldDYU55eEtRUWdVMmRoZk5HTnBhcVJD?=
 =?utf-8?B?Y254MGNqeGNJTFdBYmZiNEdQNENQOXFyODV3L25sNFF3QWFUVFpVUjNhcURy?=
 =?utf-8?B?bk9kcW1OZ3llaWEycjBWWlhqM0NuU3dJMGowT0pNK0JjK1VNaDFNUHAycE5X?=
 =?utf-8?B?cnhHbU9NWVZyRVI1dGJrQVFScXdpSlJ0M1JzNU93UXdZZzEwelg1eVRZYmZQ?=
 =?utf-8?B?emxQVWF5cjZCODMyS051a2dCRjFEenUwRTlSTTYzT2l5eml4dGMzeVlFWUhG?=
 =?utf-8?B?VVZJWVFaWkVESWpGaktkZ3duNWtrZGNwTk44OVZIOUFUbDRZS0EvZzJjZWdX?=
 =?utf-8?B?L1RxcFdUVG9Vc2RHSEtkdVF5aFoxNERRcUhkUWR3K2N3WDd5TlFOZlk0dkdZ?=
 =?utf-8?B?S0JPMFY0RUhVNUxrbEQ2RjBXOGVjbm9YNzFSQXREMDliczlBNURFWkp0THdL?=
 =?utf-8?B?K3dWMFozTVhiMDJGOXZZc2IzYStESE83VWNRTDhwdnNLSUlGS0hMWkhMdlRr?=
 =?utf-8?B?bURkdkdZdTB2dmVsamFMblFKbzlGaXhOYWxYclBQTStrMTJReWZPelRUMWw3?=
 =?utf-8?B?ZGpCWHFwYnIvOUdaTmtjdFAvTG1uTE9GNEtxcWpMcFhaTy81QSt3TDhhOFJS?=
 =?utf-8?B?RUxMNUdzcVQyZWQxNzcrKytqMHNpK2JCbVlOMktVeXhUOEJmSWpiSEY4b282?=
 =?utf-8?B?eEhyTlhObSsyTTFxaXh1UHRBSDREaklmbHZRVjN4dGt6UmdDWTNkblZGZ1c5?=
 =?utf-8?B?TzVKTENBTkExYnFONDM0cGVDQnhyV09PeWEzV3ZXYm82ekQza3UvVGt2WjVY?=
 =?utf-8?B?RWhLdjFUNGpaQ0FwcGl1Y21kTmI2SE1oK3h3VThSdzZ5eFJXMUNZMEt0QnNu?=
 =?utf-8?B?cVhldEhJYmwxOWdSWC85clpHd3piblpPcjAzOXY5K04xWWVhTEZPUmF2bWFw?=
 =?utf-8?Q?9IvGLC8viPOMb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:20:28.9887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2d80f97-6c02-4897-8e62-08dcc824f86d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6658
Received-SPF: permerror client-ip=40.107.236.71;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
fifth release candidate for the QEMU 9.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-9.1.0-rc4.tar.xz
  http://download.qemu.org/qemu-9.1.0-rc4.tar.xz.sig

You can help improve the quality of the QEMU 9.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/13

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/9.1

Please add entries to the ChangeLog for the 9.1 release below:

  http://wiki.qemu.org/ChangeLog/9.1

Thank you to everyone involved!

Changes since rc3:

cec9917193: Update version for v9.1.0-rc4 release (Richard Henderson)
43e0d14ee0: docs/sphinx: fix extra stuff in TOC after freeform QMP sections=
 (John Snow)
3874f5f73c: nbd/server: CVE-2024-7409: Avoid use-after-free when closing se=
rver (Eric Blake)
aee07f2563: tests/qtest: Delete previous boot file (Akihiko Odaki)
8f97deb99c: .gitlab-ci.d/windows.yml: Disable the qtests in the MSYS2 job (=
Thomas Huth)
eb9ca730da: gitlab-ci: Replace build_script -> step_script in Cirrus jobs (=
Philippe Mathieu-Daud=C3=A9)
d6192f3f75: hw/display/vhost-user-gpu.c: fix vhost_user_gpu_chr_read() (Hao=
ran Zhang)
d53bb908b5: system/vl.c: Print machine name, not "(null)", for unknown mach=
ine types (Peter Maydell)
80e3541282: hw/x86: add a couple of comments explaining how the kernel imag=
e is parsed (Ani Sinha)

