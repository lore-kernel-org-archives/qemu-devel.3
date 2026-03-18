Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480641088E4B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 22:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2zj4-0002mw-86; Wed, 18 Mar 2026 18:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1w2zj2-0002mi-Uj
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 18:50:53 -0400
Received: from mail-westcentralusazon11010020.outbound.protection.outlook.com
 ([40.93.198.20] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1w2zj0-0003lx-NV
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 18:50:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6sy79k+NkK0Oks0S22uk3i9ZPAMG8fh4BYwL/YKmVmfGSEZKrA7DKIB2cBG9TVVRfU9JWb/ve/68Pjbl6az8GGCyQHb6nn5B5vyZcSerJvYBbbGJDIcmQYJ8FDA/ezFG1ne7xDHUf8XyQhWRMXY7pMXYe5WcL5zZQPnW+hAtI04UdVn2QRbX4StvxjvEOxuHzTN/UB7yYHdLVIYfIMPPLBicFFy817VQLkEUGHogoDQarK31C7rzH1W69lTGOebv9zpNs3pX8ej9rPRaMjXMRZHIEjrjpgbTww4pMOOKUiD3R++tli83V46deuqx4rTfPvUVw5iC70VTUvmAqmatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvjFAyQI1k2G29BdjGOM7/0pQ2d5omtV7+p8Jo8Zv9s=;
 b=GSoFvqSlvRugUSfBm9TRxtUnECTUWD45l2G85WFzNRcqC6QPAoLTLZI0TWbyPFT39tTTigGIZAHmTf4KCv2tE+w+O2fiG5nOrDdGfp3pnKKQSN3H0ZoUYfB8+tEpO0mFu9f6g8T0dvAVCBU+wvMN2Hl4nhI8l6RcEHlLFPRYp8excoQrSp+qtLISyzgu1tBSdP/CRX7I2Lk7uqWawzBGRPSI3GFKvLUmDvxdynEql302/NG1nUEFPvkE3iXX6Q3Dd0upilwXn+dQDz+5pFp+FIYurtRBPAjkOUc/1/DSu8P6Nkn3nYgL7Kky3K05fXmvaNlsVnTxEv09T3U4DYQgRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvjFAyQI1k2G29BdjGOM7/0pQ2d5omtV7+p8Jo8Zv9s=;
 b=JTLyxqNMGPKVP/UjkthhjqRlnHyk0L1FHI95WAwgqYBU156hVoYhVj3R2ieWxTKrkf/27ZPN6zNTdmjjqebPdNFXYg2drjDilAWOZ+j+QVtNK3FvgE0TyxKcpI8hAMzZJyyuU0cnIoypdUp/A0SvVwXANUmpNMu6YtkbAayh+oA=
Received: from PH7P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::13)
 by SA3PR12MB8046.namprd12.prod.outlook.com (2603:10b6:806:304::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 22:45:42 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::c1) by PH7P223CA0013.outlook.office365.com
 (2603:10b6:510:338::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Wed,
 18 Mar 2026 22:45:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 22:45:41 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 17:45:40 -0500
Date: Wed, 18 Mar 2026 16:58:34 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>
Subject: [ANNOUNCE] QEMU 11.0.0-rc0 is now available
Message-ID: <mqiddietxtens5beqoev3dekswknitwtrsggyb6jj4a7h6qzkk@kpbhzzl2mq6b>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA3PR12MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a5cb13-e14e-4224-d281-08de8540155d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: eDrVmQxHpSX0IKJgIwv4YboFrtNGksAWAiFobJi1G+uDbdkpdzhJbPQ2p+yeYJaB8JNJuS+vtQVbmFdinf68zRf2di1zgIDNKUUNdmqofqpBhVYTQ4QjFySWu5e0O5cHdGIBbxdYtMYZb1DC6S2gdQdzD4r+Wg8qfgJkuu5++0k5jqOntj6abWgrfGeFDTvuh5rp1xFEitKILacf1+R+mQfKcffNdeYYAjJpMztehCcehvQ2g1FWNHRKYOc+bseiy7qCS+fQwANS548Cfn/l/VCRznXkTswk4ibw5xp0kCe0Avge9Df5ydU8QXw9cLxPsBPQtEQiZogS3b8bPc6VZDVtrotkUFqMwFIzKEb3nnaKYmI4mJG2ZfIUdLnBN8tcXDfKDZCopm+OFL7HiafpAC75UWNoTDKi9Z8EZ/+kndE4tW06RSNoJiq1NDVhIE1kGqsd3alW2yclChKbT0Wh2FB2m2/BeQsGg7lajWx4lkO4IZ1Qer2sfYtZ+36GzK8YqDXgtMuYnIlEkd6gqwhpbd0GEfVATvL21FVZWd4ZkTsTxlkzRA2AOMLQKXTTZgyY3fCqUwSwQj/gwhJM1JWZG10VFW9pRz8nG4ByTHgYBV3jmIdpGtShHaDO6F10ZfBtJzvKJndxJ1jqn8U2hGKHE0h3sAJ7WFKXFexS2OkTS6KBtm6I8Zcx5BLz+Vh/1s80dDnHHevidF6a8qZQ+fUGspjvg0ehYrVz7Yd+f35b4XY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oD/vkwe3hUFFc3w6v0MO1KQLmtj9cDgA1usraowi+2cVBTtONFEzwy0O0aRnYRcf62O54XmcvaRbn1/yvRpFXAQYT1orXy0Dz7T2vGMmXm7I/32TZmPjDhSFFBlYuKl3nsBS2x9AlufrFvyfn4jX2S2sDpN1TQdP/FR/f56g37HLlD+N25CgEgyuKdecuFPe2dUEYZf2pJwoxjHzql/JChY7LkHPQODvRXZ6INecPTujWk9R0vYnfSLdnZbcX6bzhaKYzLwHALb2JpY3Eivr3ljTpnAN6FKEnvcezXRzkZqQnpbQ9Pxp587YSmsO5oVZosZt6Q+Ih1n7bg9GJAdefxP6g2/aFVrduHWJ8GW3yATu+6+uKsADCoiR9pZJLD0CB24vwzoM4GuysIrcn4gp9VbJeGd1wyyQIyhTfSPDjXyIU86kSjvZXqtbLR3Ze/66
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 22:45:41.5178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a5cb13-e14e-4224-d281-08de8540155d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8046
Received-SPF: permerror client-ip=40.93.198.20;
 envelope-from=Michael.Roth@amd.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
first release candidate for the QEMU 11.0 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-11.0.0-rc0.tar.xz
  http://download.qemu.org/qemu-11.0.0-rc0.tar.xz.sig

You can help improve the quality of the QEMU 11.0 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/18

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/11.0

Please add entries to the ChangeLog for the 11.0 release below:

  http://wiki.qemu.org/ChangeLog/11.0

Thank you to everyone involved!

