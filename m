Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108A4C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrbt-0005XT-1K; Wed, 20 Mar 2024 04:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrbr-0005Wv-Pr
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:47:43 -0400
Received: from mail-mw2nam04on20600.outbound.protection.outlook.com
 ([2a01:111:f403:240a::600]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrbi-0000NY-9a
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:47:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5prRKH0OrKOG/h4k6zSwNGtEKv4dB9NJhep/y4HTYdCwC+2GHR1ENNu8RNeE2H/8wzdJMOC+YS4ZHe0jtid2Hfrc4oWqp6geZtFOcH0Bx6YqK7SCdukQDntGETdgeyUkFRaAlRP5digE7z1n0JbDmt8/VNQOtn0aOTG67kn/nheDqsjqhu3il9lAaLrFB9SgBQRTmQ/nRsfRjMYsd0/3IdS+5j8mHe0aEHaMREFS0zqCfh2P3OTXrjBxZTOpzGSbdQq29BT5XEq1FS4nK8L/fFZ4HiZT/IGVprfIsoArZIwXwkLStEBDvkQ4AzYG+Qa9PCu/N1p7wtTvlVAov5csw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=409eVt8P+OBu2rRFXQ6ZZ6hlrPE6VnzyvWs+OExqOYI=;
 b=OaBioqeEZ+dYr53KjF9nr09ZEw+BrbtlDzCIzXjjmSM5HKbnUXmt+VR7h8Rq5gol0ByXwEJtPFpKKUr5z0ZdDd8L6UeLYCY/iaRf64My+1RQ4M8MLuPndjVmeQpaPH62fCzyHyyjbB1Q4mPIcWj98cRoNdqqdt9zphDCp5bGyO4VvPYLhKSepLoSS1Rs9eW1WY36ljRTs1hIRoiSokdY0b81RlvzAuzuVLXTXQK7cY0kvgFULqT3fap0JvWRY/FQG7siGDA/F2DKbQ6ot52qXdKGe+R7sQex0a35jaZPwrP8wmPgbsyvY6hAo39DrEDKOGKUwynukycdVBobTChL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=409eVt8P+OBu2rRFXQ6ZZ6hlrPE6VnzyvWs+OExqOYI=;
 b=Ie2ux9WVtkV4aEKU/3alSRm+VAVTE1TKDfZPgy6gDDCxe5y0Y++0kzkFQv4cplOjcxlBgCADAEVtk5l68IZep9QF+qa+jz01YZQmIQymIJPGqNc8mR49MG5nzOhuwcQlJf/P2Vnx/x+jxX7nytEwRwmy8JXMWsW1stfo2WzBcS0=
Received: from MW4PR04CA0033.namprd04.prod.outlook.com (2603:10b6:303:6a::8)
 by PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 20 Mar
 2024 08:47:26 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:6a:cafe::a9) by MW4PR04CA0033.outlook.office365.com
 (2603:10b6:303:6a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Wed, 20 Mar 2024 08:47:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:47:26 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:47:25 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 25/49] i386/sev: Skip RAMBlock notifiers for SNP
Date: Wed, 20 Mar 2024 03:39:21 -0500
Message-ID: <20240320083945.991426-26-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320083945.991426-1-michael.roth@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: a64caa0c-a721-4255-d145-08dc48ba5e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yyfd9qXk0d6Nb9lNYhvt8KK+rDlHGF/ppH6LsxxNu/6Lh1MSRv1RKyoTyBZS3FB4mV5lGyV0nV5sQCvodtu8xmb66xBWELF9yAYY4N4vcIv+QAnvVOxyH5pgIE1LBd325oqmg0ZChg9HyWiMrDDSR0j2zyuGEqUvYvzfK6NeN3XaTdyk/rXqqmN1spc3EV0qimZelVcOdPdiUBvw3IoRE5HAOE0Nns2pJdx3aBLXFJmGYcdUzBo+XeBrPVxLUsEz9Py9ajqFINgoSjjzv6SD+pkd/ghTD7sF+NszvZEPIJEG5DNVMbZq/wOC2AdveHX2dW41oaXo4TOI/YzUl7fzjWi1MampXEndec49wwFGsLEbUK7q92kJHnoI59aevCvcR0P7DFL70Tk39kFdJx2dJbuPL9ZTPuYm7GVlKtYgb4VTXP2iqRTKM3NmiOY3XKGMByoVA6OYjbDy5LQBHEu6TkjPXg8mUeVyOsJn7XDjXXxvddy9l/5AKFPTjNwB49zgUwFXkoYa5lGn0xkg3f1SlsKXo4uJ/aQpSAHnmkh6ICSm8WdSkQcOYlMlcmtU4Z/b5o7QqRrIhPmltmwGKMfCCMyyUOJogbDFU+tqryYQTd+TlmqtiNVFTdkfC16kx2hHDBDzCnheb9Abv4dn3A55rrZ8rAzqaysmUizYEkWjMNvBAEYAe9KdCGjmP4osHRma3UJX3rRsMHqtddUjovZcAiOkhg7kZtPqF0auXU5T3RXYHQoBsaM3Qgtwf7AXJBoo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:47:26.1808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a64caa0c-a721-4255-d145-08dc48ba5e52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
Received-SPF: permerror client-ip=2a01:111:f403:240a::600;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

SEV uses these notifiers to register/pin pages prior to guest use, since
they could potentially be used for private memory where page migration
is not supported. But SNP only uses guest_memfd-provided pages for
private memory, which has its own kernel-internal mechanisms for
registering/pinning memory.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 61af312a11..774262d834 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -982,7 +982,15 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         goto err;
     }
 
-    ram_block_notifier_add(&sev_ram_notifier);
+    if (!sev_snp_enabled()) {
+        /*
+         * SEV uses these notifiers to register/pin pages prior to guest use,
+         * but SNP relies on guest_memfd for private pages, which has it's
+         * own internal mechanisms for registering/pinning private memory.
+         */
+        ram_block_notifier_add(&sev_ram_notifier);
+    }
+
     qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
     qemu_add_vm_change_state_handler(sev_vm_state_change, sev_common);
 
-- 
2.25.1


