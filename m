Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CFEC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdmL-0005yP-AB; Thu, 30 May 2024 07:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmI-0005vv-TW
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:02 -0400
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2009::600]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmC-0001Qp-05
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXMcjqdTR3Xr+jfbLpKlJR7KBAHwtl8lJzJEVs94F40EjvHkaS584HNncDPIDuAfnP/YgA7NIzsUaoi/2x58W6qfjuHKGHgE0FhAbZ8JKB6SbPUfx+wyAoidGrJN3ZL0G6JZY2THQJVDhahwxztkq9wLqxLRzJ09ixDmuXEBQgrW1Nua7hkECJ0C9pLVLhMdK8gKnPEty+Gqw3AOue8Fxc1t+3QEpNTe9Hw/IpaLza0UeFkUC8nK8ahS+PZCMOXp8FCBsc5HYky2Fupl5e2lBgPHER74+uHNa0jRGYaZMT8t6OJn9Xe5oeJg5GWmptn/vyLv7DtJRvGkZr+MiaZy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfCXPruts55gOh3ER99dvMxSJNa8gwHv0r6YK/+ytZ0=;
 b=DVTz9uy86trZa+rGl+aFde84hG9piPq3HkltPB4uEGK9XnynMik2Ws03lQPJyz+hlHAb6A5fGa4K+STdEjzud/7qCJoSPgHOFdyoF0JOj3+NF69iK6XY3oW/ybRf3EEG7JZn+2Orj6Wq7/7o2jg29AHBfCAd5A1K4My8liVssxwaKOekEqiIWA2Lbb5SND0+q/vdc0aJB0q04wvJaNFtV8S9yELKTN7ESIekAuwHrx/jYoFKycRlQQv4E0Zd34n7TuZ6skQDZkzBqtFcA3uujNqszppoEgmFptEYhnjOPKBaMP29JgR+QNO7EQi2+h+5R519UL44uzhzCqj9gQEDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfCXPruts55gOh3ER99dvMxSJNa8gwHv0r6YK/+ytZ0=;
 b=hRU1zE+nkA8NbZzy9LGEQtDE5R5QXL6qvZ/x23m11C9cL0tauOL2slQRDfdsuN7IblIclTR7x+LfdyMoucZA0jfRI4GpKbQpy+6AscdNJkRRHG+cwmH9/dYOh7PrzMrboMkZIxSvqLdcGRWr63NpRVrD7M1me7//ZFCe+e84q04=
Received: from BN1PR14CA0019.namprd14.prod.outlook.com (2603:10b6:408:e3::24)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 30 May
 2024 11:16:51 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::cd) by BN1PR14CA0019.outlook.office365.com
 (2603:10b6:408:e3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Thu, 30 May 2024 11:16:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 11:16:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:49 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 30 May 2024 06:16:49 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <thomas.lendacky@amd.com>, <isaku.yamahata@intel.com>, <berrange@redhat.com>, 
 <kvm@vger.kernel.org>, <anisinha@redhat.com>, <pankaj.gupta@amd.com>
Subject: [PATCH v4 08/31] i386/sev: Add a sev_snp_enabled() helper
Date: Thu, 30 May 2024 06:16:20 -0500
Message-ID: <20240530111643.1091816-9-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530111643.1091816-1-pankaj.gupta@amd.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ce287a-40ac-4413-814b-08dc809a011a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TyWxKWOUfKYvrl0qvb9coAvnyrbe8RdfYZ3YrVEtXjjikKCQ8aIStv1HzMED?=
 =?us-ascii?Q?e81FPaPyua0Crukboo741hPj9yp7htzGiu2Q+9fSgeQKG+OEmt1nK+PiKYZa?=
 =?us-ascii?Q?biyXfA4Lrmx6j8gFAdKE7xom9Av44As9FQtJrEFJnVM928hfeX7HJuIeYINB?=
 =?us-ascii?Q?LkT+AF+DQa3o73DvbqbRlmkqvhLn9TmjUIqKgewWA/zfbLXWzEuERIIjET+N?=
 =?us-ascii?Q?12fVvLy98RSkSdehCFHRqtVklqHbe68Gy56TfsbZk2cyrDlAnxtCji+sjoSw?=
 =?us-ascii?Q?nU2BJjBzlSCfnPXJBKw9rr/sd613t06NwXm8S7xA0JJaNivmvzfWB3/HrQgy?=
 =?us-ascii?Q?BouEJltlNfdRLRf2p8VxI9KczeHImbf8UtwlH1y3gWGDktL0KZp+FxaG+Nfx?=
 =?us-ascii?Q?Qvp9bEGtu2ajvWBr/CE2k5Gff+7xnIdynYGd5fxRx7lzVwLtd44NuU1nTl7g?=
 =?us-ascii?Q?f1Gv2T+Ndq2/AAlJX27XweZTjR62JisfuVnB/KIUmOFrGvWidX0fAo3gPXW/?=
 =?us-ascii?Q?+g5PJWT9Bc5ST/HE/URmSuEu6rIgHgxF98PmPsoxNehxiYo/LReCyw5Jj+BR?=
 =?us-ascii?Q?rRd61RZC5rTkX1eBrnXqk+yXtwdZvDgdf//b2jHY0ls3QMZe4tdqA510ufed?=
 =?us-ascii?Q?eBc25Q1p8vJzTp55/yqaxAFoneic/cjqvr2+y2/wXpwMsIe6nkkOJFxHGrQb?=
 =?us-ascii?Q?/mw6E54gImIKk9SUEq6YV/ntT1dQ9uatKE/s5R7755UUkyJ1NAWs4kJDPaSa?=
 =?us-ascii?Q?KDcCR+lZE9HrGU6ZWhsDO/LQsKGWhUun+zUvBZU8TyIWb5PeTki9yN4+PdNV?=
 =?us-ascii?Q?bMzSrtc/xj2/zVy7RldocZO6bWaNBJGNtNC6jYyKP87h9NLq42C1pkJ+U2bD?=
 =?us-ascii?Q?84Ttye4QubyVejRj/TsuX/RFO6eA8Pzp+ev2uZo11S1Svqp2J3Dvh1kIhDFx?=
 =?us-ascii?Q?akH9njkHzqU/UOXd4t6U+Kyq70QyReN9BOAvyqdfsyKQAIIZVnWizmqXes8g?=
 =?us-ascii?Q?f0eyb3mzc/LzK55DT3Mh2c19OUHW361V+Ajfa5knNTCYkArwhmVbUuBVTiZ8?=
 =?us-ascii?Q?X3XnsvY6XRCm1PVlBmTBciW+dM0A9Bk/c1lfmvnBGMYmCKwk6KQ/dq5ZZjR0?=
 =?us-ascii?Q?4BQEK2J65KnX1owZ/imQdQPQRw1wYcubUQ1fLn3MaUxOuxO0D/k8oSft2hj1?=
 =?us-ascii?Q?ptbrC8EzP62W743Rq9VGEcqKmeoksp/jTMjHhlIDGG4ZhtxJcI6uXgKOlcA+?=
 =?us-ascii?Q?5QLUldO7MUs59uoQIyBPMYDMkezmbKVH26i51lc1FdfoN5W92DT6l9IoaCUd?=
 =?us-ascii?Q?EtwKki6HUbyp04YxjZedFmZr+/MCQG94Xq7j7QRjtJsik2DLPFV/6gve+tD5?=
 =?us-ascii?Q?aIpd7lKDN7j1njhvhokrGFxn2dgX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 11:16:51.1132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ce287a-40ac-4413-814b-08dc809a011a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
Received-SPF: permerror client-ip=2a01:111:f403:2009::600;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Michael Roth <michael.roth@amd.com>

Add a simple helper to check if the current guest type is SNP. Also have
SNP-enabled imply that SEV-ES is enabled as well, and fix up any places
where the sev_es_enabled() check is expecting a pure/non-SNP guest.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 target/i386/sev.c | 13 ++++++++++++-
 target/i386/sev.h |  2 ++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 841b45f59b..f4f1971202 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -333,12 +333,21 @@ sev_enabled(void)
     return !!object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON);
 }
 
+bool
+sev_snp_enabled(void)
+{
+    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
+
+    return !!object_dynamic_cast(OBJECT(cgs), TYPE_SEV_SNP_GUEST);
+}
+
 bool
 sev_es_enabled(void)
 {
     ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
 
-    return sev_enabled() && (SEV_GUEST(cgs)->policy & SEV_POLICY_ES);
+    return sev_snp_enabled() ||
+            (sev_enabled() && SEV_GUEST(cgs)->policy & SEV_POLICY_ES);
 }
 
 uint32_t
@@ -954,7 +963,9 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
                        "support", __func__);
             goto err;
         }
+    }
 
+    if (sev_es_enabled() && !sev_snp_enabled()) {
         if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
             error_setg(errp, "%s: guest policy requires SEV-ES, but "
                          "host SEV-ES support unavailable",
diff --git a/target/i386/sev.h b/target/i386/sev.h
index bedc667eeb..94295ee74f 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -45,9 +45,11 @@ typedef struct SevKernelLoaderContext {
 #ifdef CONFIG_SEV
 bool sev_enabled(void);
 bool sev_es_enabled(void);
+bool sev_snp_enabled(void);
 #else
 #define sev_enabled() 0
 #define sev_es_enabled() 0
+#define sev_snp_enabled() 0
 #endif
 
 uint32_t sev_get_cbit_position(void);
-- 
2.34.1


