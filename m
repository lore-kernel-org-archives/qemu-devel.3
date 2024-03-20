Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17865C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 03:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmmPh-0004E3-Ep; Tue, 19 Mar 2024 23:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmmPe-00045X-20
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 23:14:47 -0400
Received: from mail-dm3nam02on2088.outbound.protection.outlook.com
 ([40.107.95.88] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmmPc-0005zO-4a
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 23:14:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1jiFk7pkPBXBVVoQ2fDgMzt5vT1vGalgOW1eaiyVvhlxPuXSpvdJCigsKCIP54JoD6JWGScnB5+IApt+9I/PT5Hf21NqONrWHJrJipALAfa9kAHmzKGy8/rnT1tuJjjnWIdRO4xsKCnlMowdgrsd0Nj1DolMHPhZ3KeAqv1G+aOf+946g07geNKce7X6tQkJL4ajNFM15PaCZS5kE5JCqIDe+m8jVOMVYgdeWmA582Q8pt177PSz0AP/GKbrGSlp4k1nAFLw55OaPpEX9PzUqZM8WY9lry+HVbwZNFFqAy6K+XSY46jWQGpfxQ9C5pr5xs3WWuGGVbdPE03bkB5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQ24fwAYdvNl/hejg+d51uz8y7cckk4n6lvMw6Tir1A=;
 b=ZQ2GmEsdWU8bBf6wiHcfwF45pxFOi3MrjUpE2zxyY2UxshevXXGvE+GPgq+i9kBR0otGiLbC1Q7yshcd4yzHecSgUUqfa0CctXxdkudAhPcwGGXBFYEu1uIkOtTVwslyItrZMYRYjj09MKEAE4/PvjxD48NjXMD2Fj8RxDBLAg8kJFE6Um5OPLrLOyFJcROmLdrn56UFxjI03bx8+GDnZNd4+xEeyeoupGPHRo4DBx9TmBE4a2QUtOdn9+JsC2QlYgJur/h7rAsqQdl7biSKPPSpkKnyh74aU6wP44XD7tyvzCeD2XKHwCuqkn6f7+MUCFoRC1gB3gQoDPCbwYfDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQ24fwAYdvNl/hejg+d51uz8y7cckk4n6lvMw6Tir1A=;
 b=AH2bNjFZLCVeNURUmewMtYZLvOOoYodXTb64XmxEd4cfmo7I1oZTedik2TprMpOzcsca53N8sIdqLdOIN1sabEkVBYioH5S/kEvww8tO5f0ossAF7BpCVy8ZmhlMsrnnXjckE+SLfSfRffqBqI4mhdSs4hZkSMXGXM3xkAkD2t8=
Received: from CH5P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::22)
 by CY5PR12MB6274.namprd12.prod.outlook.com (2603:10b6:930:21::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Wed, 20 Mar
 2024 03:09:36 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::fc) by CH5P222CA0002.outlook.office365.com
 (2603:10b6:610:1ee::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 03:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 03:09:36 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 22:09:35 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 9.0.0-rc0 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 22:09:13 -0500
Message-ID: <171090415390.975466.1974348748307170830@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|CY5PR12MB6274:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d239b7-54b8-438e-3131-08dc488b2c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBlyfWPAwL/TyOnxRqypseBaXbaPuH0ReiSqDps83G7cJAbnS8NJFf0Eq3mOe55Sabj8ZquZTgPMcwPKL7uv8qDNI0ZT8QQBpL/r96GxtUHIP8ejKLJ3yla7y+kkw4Yr9Tpgcf0TarCxHlEW6LE0oNPBPBY6rSCqx4gEGmvS4hkkEFGwfP8JR1Rwd3ThIL0gNFz8TgZN+ppiZQlb8uvQt3TwFnJ2tsUcfNQVN82ZD4dqmHxRWn4M8ehmYAyoBa3RbsC/hZ3155YDtkQijjtvJ91MZcfx9TIMiuV145GS9gBA0Xw9ySHRYhSJqkWuuhLEmhkpALDzJ3DXhcpdhSUu0WkvLF81eYBjlkZ9t9ABl7RUyqefmOi1vuTyvGattWk+DslBhrqVGyWIaYD7AlP8scUsECej6q15+ywxIdj4SCFen+L+cIECeZPQ8ZLXu69fTkgOdoloMASSSwknGVAu07OJr0/k6tuDN72X8f/Ey9XggCGXKM8WmaPqcIEj2qiKYfd8EvXW3WMyBrLj4XSQqzBjyigHpdt93drwjvhiHLXs49rf1EA4R+QXng8bA898cyA1kReFIHAMER5tGJUbO4grjKlQIQzeDacBhjpBIC/24gT61ZyOxPjtVHXXS26GcfGKWaFH+mMlCn7FCVX/nbYOOmJMhpQ05kZsp5G4jRe7b5c5hNaw9g91Fb66vOJfLOJQJx3zBQUNE/XUHY+WIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 03:09:36.3042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d239b7-54b8-438e-3131-08dc488b2c7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274
Received-SPF: permerror client-ip=40.107.95.88;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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
first release candidate for the QEMU 9.0 release. This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu.org/qemu-9.0.0-rc0.tar.xz
  http://download.qemu.org/qemu-9.0.0-rc0.tar.xz.sig

You can help improve the quality of the QEMU 9.0 release by testing this
release and reporting bugs using our GitLab issue tracker:

  https://gitlab.com/qemu-project/qemu/-/milestones/11

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/9.0

Please add entries to the ChangeLog for the 9.0 release below:

  http://wiki.qemu.org/ChangeLog/9.0

Thank you to everyone involved!

