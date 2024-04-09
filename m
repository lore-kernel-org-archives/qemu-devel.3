Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DF0CD1296
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 23:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruKaJ-0006Rb-Qt; Tue, 09 Apr 2024 19:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1ruKaI-0006RQ-4u
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 19:08:58 -0400
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:200a::601]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1ruKaE-0005rA-7G
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 19:08:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li8FY+uASyt5O4DJHqEaGvq4UfQ6sT2pUQJGFcl7SQKd+thjJBmQ0hwRAamU5MjfZmP2SgYJK+rZyUjTjPt3kSGsizUXKBKe7Z9h0rD0W/iUuacO5RPjvwh54VqUgZpIA+z86pt/61ZeUJvsESM4fJTXIqytwDo+abnGMNacCjt/d5Uai7zX5JK1EtFE9/L0hoKU0CMvVKnVrJ1cD5bl9MvVGY/MjNT6H/z0l4qi30STEkhXBdU0NNnK/GMLBDyg0DvQDRW47Rjatz07ZBA6ogxL8cGQTb7Kes/PZ2lkrfwU6gbl9p7unLv2VjodoBVgsRBeSpOHb/pGdfPQrl53Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUfDcZ4aJXQtcKU6F1ZlhhY9dewB4OXBpJdZIZ3pzpM=;
 b=EjCD5LGNtfls1geRdVut22T2pY6IaZSa9r1U/3lrx21qbw/CUdugYjLxrQaOp+qteCdUopfH9d5Eg17Uzrgem9h/Tll7dKyITRC2iddv8CMJpdvofrQz7Bpes8PCZaXm9sWRKZjmk+rkIpTVxc+mQ98QDMd+vNBDJKrzcdyUQPBWDxDjol6s7HbQzF+BqmGgp/bKbnFKe9c2VKk0BObdqEkjkKNas5h2V3otWXM8iPkhrEpmDKsFGScMXpzkrvqGch+53iwvJXXqxMvEgKyxlpS7/en/UE4zUp9EtGfwMOZKVBdrzDMAoCd2f7SxsM/xXGPkka3Ohys5eTJpz0oudQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUfDcZ4aJXQtcKU6F1ZlhhY9dewB4OXBpJdZIZ3pzpM=;
 b=0Xd1+sWo/Z4h1vMRQad1jYpX31o1CslJaUQEeOS3Rik77DX7otJnLtAAK/L+6DYnWuDKod/AqFSHEmeLtXsyB4YavvGj46WYcMzNg98VIDJCgihcTV4zD5uOdpQ08huI416Rd7dTlQOUnH+5YqhCF9wWQ5wRjYL5ARJk7WI7rek=
Received: from DS7PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:3bb::28)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 23:08:50 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::6e) by DS7PR03CA0083.outlook.office365.com
 (2603:10b6:5:3bb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Tue, 9 Apr 2024 23:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 23:08:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Apr
 2024 18:08:49 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Larry Dewey
 <Larry.Dewey@amd.com>, Roy Hopkins <roy.hopkins@suse.com>
Subject: [PATCH v1 2/3] hw/i386: Add 9.1 machine types for i440fx/q35
Date: Tue, 9 Apr 2024 18:07:42 -0500
Message-ID: <20240409230743.962513-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240409230743.962513-1-michael.roth@amd.com>
References: <20240409230743.962513-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2da514-12dd-4594-5b4e-08dc58ea046e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/fyFr6sTx+lK6+CM/qBeRsqJevmdzYgAmyICPmBcPfH6+GAjsyszaBHXw4m+5oEcMq58JiTWME8oMxRqO6cF6miLOKJz9XO4iW+sRCRLe1VJSI4ZeyVpCyuyVqIGR/OwXBYRriuV+feWGh56XoWxEjgFry5IppwHqKBt/dEO5nkiImw7oJ5Mz8yuLCs7/zvsZoGOAkPh/A4GqQyPBf+//DBPVCqm0qoTG0sTXQW4/1sUglfqcvXgVpM7Zkog5zsmeNSFhT+WQMjONu8Etk6tdNc5EvKl2cE+Y9YOoDcvLz415dMtXDWfs+OiJeGSW9Jm2+4Htdp7zPLGfBE3hj2TVKWTaROEfcCi13XxvMqllthVYr5iR2Lzp1TDpPrEa5tseMS5KwsrxOOiXmYG6853sfnvOd9c0Ihp6a6dsFgMMzfxNYxQ4cuJ0eNn61oVK7b0v9cN9i5dsNytgGeIr5XBMYSXnmp/04SKu19jjCaH7ZcGmXzuNqELig0mhH6wxcdx8XHWKSgBpjy1YGfVhoRtX8z6zEfKZJdDnJpdHfpwJGHgTRvCkNIu8T7MQKQf2x2w9rNmyyhahcFSGybXoepdqYKvnCr89QNoNOwepMgrXZl2OFw7DtwdrpkXgiaMshW3K2m9wD1Wiyju9EeEIsD/9Txp+Gm+TJ6UBefcMAUTP6ELx9P9xAr1mThTgN5Nzs9HAKplmGWQbXp+dA8igP8tFkMoQP8KZK9KZ3bHjFcZHav0KkCjm2J8a1mg5WoC1gB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 23:08:49.8606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2da514-12dd-4594-5b4e-08dc58ea046e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871
Received-SPF: permerror client-ip=2a01:111:f403:200a::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Define the 9.1 machine types and make them identical to 9.0 for now.
This will be needed to add PC compat options for 9.1+ features.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 hw/i386/pc_piix.c | 12 +++++++++++-
 hw/i386/pc_q35.c  | 11 ++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 18ba076609..069414a1ac 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -513,13 +513,23 @@ static void pc_i440fx_machine_options(MachineClass *m)
                                      "Use a different south bridge than PIIX3");
 }
 
-static void pc_i440fx_9_0_machine_options(MachineClass *m)
+static void pc_i440fx_9_1_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = true;
 }
 
+DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1", NULL,
+                      pc_i440fx_9_1_machine_options);
+
+static void pc_i440fx_9_0_machine_options(MachineClass *m)
+{
+    pc_i440fx_machine_options(m);
+    m->alias = NULL;
+    m->is_default = false;
+}
+
 DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", NULL,
                       pc_i440fx_9_0_machine_options);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 7f2d85df75..77d7f700a8 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -367,12 +367,21 @@ static void pc_q35_machine_options(MachineClass *m)
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
-static void pc_q35_9_0_machine_options(MachineClass *m)
+static void pc_q35_9_1_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v9_1, "pc-q35-9.1", NULL,
+                   pc_q35_9_1_machine_options);
+
+static void pc_q35_9_0_machine_options(MachineClass *m)
+{
+    pc_q35_machine_options(m);
+    m->alias = NULL;
+}
+
 DEFINE_Q35_MACHINE(v9_0, "pc-q35-9.0", NULL,
                    pc_q35_9_0_machine_options);
 
-- 
2.25.1


