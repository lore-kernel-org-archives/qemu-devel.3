Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C56FC44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 23:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk9Eb-0006NG-5s; Wed, 15 Jul 2026 19:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wk9Ea-0006N8-CI
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 19:41:48 -0400
Received: from mail-eastusazon11012035.outbound.protection.outlook.com
 ([52.101.53.35] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wk9EY-0002Se-5f
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 19:41:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6iCFU9U06cbSHexpvd2nbcqPCOo9y/lFoZpsm+qH6UU7k7M2zi5p/zKGMalhhCuS0rNW47sh7Sq6vkE6Qq+hTPsMZlopEIRIGGGK8taV2PmMcpWQr+v52+h3sBDXl9549CFmtst7SbKcqLPbTV9q6enXiJqWJwZm/U0xy2iB1q4lLiw1KmFgSKOtq2dgbXxlX6UTUOHtoaLa4Ae9VkP8Bce18d5Ttex7RN9OiMldVfVzL/N++1FI3CA1T/QxsgbVSIF0WbdgaP6I3wXdqPYPjWPHNnAsdtIric3Z1tXMZt7FkVpIrNM44HjYXV/KoyGGLdbQySPKzYToTWvILFa5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0vZKfBD6bkPdEYT3pjA13E7f2qcIHGIhpY64eFO4C0=;
 b=fJckCmYqhpn9wGxUHwnIMrX0vF9s1yaxsuNEgp2IMY2x3oFRrdXkXp+Dcq4kobnk6MBH49ewxXCG8MCyTimfKzaxt7QdmTht3QBJieSz0mGPmzbh38Hk2bv0NXfsxT50x3u5E1oQZ+W9lhGjWvV/WKKQ1vdGo11lvnZsQ7oW5Zz5sSo+Cg79U0c4lfqCJaX+3ZoXEVXLI7yY95rysA1+QJaI6A4Wh0jd7iT9yYL4jkSnvSLpA6Oqe4Cu86TV5FDEa91sao5A7r83AHY5I+NZom8sGvXuueMwtWnS206rCw2MNteL37nSC3716WS/BWRwnPmJzun4Hdgta7WNx9hsTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0vZKfBD6bkPdEYT3pjA13E7f2qcIHGIhpY64eFO4C0=;
 b=ZHRHI6FOlzhebcm2WZCAXW3K0V34eQeZlcusznjCikYXDyw70h0WRVieEcXK0bUeeZqmT9UPmpJ0A+R3S6LO7yZeczNprM2pNgBSphXSALoBKR/T8PX7fwY/R4cmI9oJta2GXTf1N10pR5vSufEZrM0dDTFhtSpPXUcR7WCrAnw=
Received: from BL1PR13CA0026.namprd13.prod.outlook.com (2603:10b6:208:256::31)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Wed, 15 Jul
 2026 23:36:40 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:256:cafe::49) by BL1PR13CA0026.outlook.office365.com
 (2603:10b6:208:256::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Wed, 15
 Jul 2026 23:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 23:36:40 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 18:36:39 -0500
Date: Wed, 15 Jul 2026 18:36:16 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>
Subject: [ANNOUNCE] QEMU 11.1.0-rc0 is now available
Message-ID: <vp7afccmso3bcf6bgrlfz34cqek324fmx7lq5664vsabwy7ucg@evu527w6zhoi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb9b65c-52fd-42fa-36d8-08dee2c9eb8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|11063799006|56012099006|18002099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info: TJsKjvgssBC34WkMTh8p2UvAVuW/uMtqGzVsW7CXCSie9aaTEnkQhIrZyxYOu6CHHgyxnMJuDACc26SkaKu6mtgKdzvegQyX2b5CQf2TmPc9SaRMlqR/jZj4tKiFc8wozPMi/cDwMGwztPSUcG6K+ZUS84f/yLdJdIiPOW8L6o1LovSO/4AOzYqkcDQ66qSXlvUiTq5ulthsXIul2hdNV7GIoGy7iD8F64LaqhecN2ZQNvKvwgcNLao78rejmpBMJWn8zS2Qai1ZUf7KM4yLVhfCbmybN7wa5umjvzVydaCCrG2+HafDKCw3Jawi/dPzGa2OxS9DezmUJ3FslleUZZYlGkUdEq5s/h1+qlDrxwN89cPpA/QoHNJQdINdF1pBS0wj9aybB4rEV8YSUKeu4GPWS1LpCjhiGdY29zTixzoOx7brHW7KomZRX/75847Tck3ry37e9MCBnHga7pzXlAz1voNI686M4g9GgJJIsuZowqbTG9HKSim3IrA7CS4Q0+r6jDBcJwshcRzecIEqOenIgTjoHS0fZrGRUbW4aPfbdmx73aukFxVR/6cMoDC+Xcgpr72PzC6piAVVcMrCEBWMLIefNSe7S/d4bJeWqPcwOFJLpDp29dg0x4jNby7rYKo/CRf4cHPabmyV+h+eeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(11063799006)(56012099006)(18002099003)(10067099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mBnYWNet3gf9c232hZ/MAfq4/pJZQ5p42W26mfBPIuzYJM06d/6FpCdbs4ddoa/ADYiqUyTCOcSOYshE7rb2/wFtrgW+oODEDXI9o7+2arT6w2r167VLbe9+akavTOx5rSy59PnGeylO7uGxN4BadnyyzWYoTLNy1Q+uq9Fhrt+2H+YVrZ2rb44ST+Cwo3QfiOlFPFGEuOhl3BxM84bmk02pLWcS6OenNxhLorkD0m8dF82RqwuJ2o+dFqUKL1MPM3mQ8hEYXACOp7VQ3SwbVK9QZ85/g0RzLr6blMS4kLxUt9DFw/ZSmEgmpDBsSgQMv6w9EK7uffxVKo99K0s3YJpDG+duV8ITKBAwRYhwVDWjJslhceEAFPXGsMakcCv2QhKMWC2bCLXahq/liQdYgLSVGKJkeuIMSJSEowT66rtbNht5pI1bwI99FvKRI7Yn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 23:36:40.0890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb9b65c-52fd-42fa-36d8-08dee2c9eb8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
Received-SPF: permerror client-ip=52.101.53.35;
 envelope-from=Michael.Roth@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
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

On behalf of the QEMU Team, I'd like to announce the availability of the
first release candidate for the QEMU 11.1 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-11.1.0-rc0.tar.xz
  http://download.qemu.org/qemu-11.1.0-rc0.tar.xz.sig

You can help improve the quality of the QEMU 11.1 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/19

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/11.1

Please add entries to the ChangeLog for the 11.1 release below:

  http://wiki.qemu.org/ChangeLog/11.1

Thank you to everyone involved!


