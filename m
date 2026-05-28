Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2D2CD5BD0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 00:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSOGm-0004hh-In; Wed, 27 May 2026 20:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSOGb-0004WT-0G
 for qemu-devel@nongnu.org; Wed, 27 May 2026 20:06:30 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wSOGY-0004B5-58
 for qemu-devel@nongnu.org; Wed, 27 May 2026 20:06:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qubWJtcLa9WTJIVwZvUf3rkcIYx08BuMpJTcZQbFQ8hJXyiIev9FL/9h+LDOb3xvLeZlpYGeAjw9xuUX+aaEe7ENNQPE4SqLC35fTHOD5BezlTNGIsx/HwC8iuQpSx911OyVl6ID8nvg8Ym8kjW8HefdwLVIj0DEAyFK4o2DAuktQukbIYdsTIDQyVFzUI21n6FJ9qED4rSFGfX/lVnegZ9EZdRwjmLrLsRjG1Qn7yqTFgkela/4wYWjBuAGs/GCe+REyJasPWG80SByCfAWyGYrDBbeZ+5TX0lSQyLHBaw70l9PyP4oxs4c18AEb5aBITa4DVenAQSjb+h0COYCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cG3Q7+qHT52hwX2Ng4cfBIUV6VEH5tQo/77caN3Jw84=;
 b=VDWuJI6e8ZTevkJ7+ABVsMqxK9b+rg6+Lx0k34ravj+g43C59J8ULffQN6X9UoMZV4syyHwMhDrZ1bOHIraRQJ209gUVVhDbf6O5drF+N3AinXpVfmuVWax32HUpQCd3sn6p5yR6FVfXdfOuHJXRXlpvw0eI1NSvED4TTIcfL7muCN395XLEXaDwR8wGJd5cQSeU5zWfOJApPhdRbyiW6ViAQTUVXVfXqqr3q5nt0VfDpN8idnmm8D026SOM4OqnMjEGEUViPelwl9+6Eqz9yIbLeOQAKaPNbS70/fcWzlx10aeQUOfw0/xIpxEkIaACDY6EspqiU8G0nfaQ8IaqRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cG3Q7+qHT52hwX2Ng4cfBIUV6VEH5tQo/77caN3Jw84=;
 b=eqQvw9IwEFZETtGwzoBxObHC8BjsKzuoQzh5m77+TZm+kGF8QW4vQABpsxEjdPTXYaCeQv01DzK3rnxk/cvpPE/bkeUEf/F98cQbEncD+ek5BAPkBIT3Ht3blgS8EsHx/png+EshHcTgAaYNP/uWGbjTz8p6wyz9xNT+pTTm8TA=
Received: from PH8P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::18)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 00:06:20 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::78) by PH8P222CA0003.outlook.office365.com
 (2603:10b6:510:2d7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 00:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 00:06:19 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 19:06:19 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>
Subject: [PATCH RFC 12/12] i386/sev: Allow in-place conversion for SEV-SNP
 guests
Date: Wed, 27 May 2026 19:03:37 -0500
Message-ID: <20260528000416.8161-13-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528000416.8161-1-michael.roth@amd.com>
References: <20260528000416.8161-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b664089-72b2-4b03-720d-08debc4cf1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: i97pEEyQRK0UrM6bHhS3Vi2wWNi55FCwFz8hQkTx49OYxOg1fh2YpeexEXZfmVIHouq26tqRQRkNaabuWZRyksLBoYjXmzBGYc304o9UD57Y7IEPxPcgbCuenYZzFD6VkhguuBkIOx9bQqSWvu5z0q9ShoGTFe8TGHWGG1u8MXvb3I/pyGWlQEYCv7lcoIQuMVhPnGs8V0PXjmiIMaANjBnmLsmo6rgRBPvbsORvP0sMDc3tXKh7AqkDL67Gg8VbFeQ8w290U1OHQv3oUT1AAvYJGbpWQB6t0hVZzumEE5mx9Eiq9wcE0OWPXRvkcIvrti7XYmqXjsAUIfczJLykNg8zceNZhIMuH3ki3EYg+SB2BaoBpTDAQnFeXMjY8d2n/2WfWzRIO2pQaP3U5LYDwT3iRXlyp9wfp9eKfnQb/DTWUPHEOrzHGqp7FwLczeaY5Q7gzh5LRwQ+jH+ywaJcdshiXoRLWosx8OLqieW5ADUy/XU87x6vQlIdx2pVGNs+J+rXSLVxsrS3bt+W+20Hisc1ZjdQDD8HORF+a05GllvbLkjegH4ZEKmNanBF9bhFaqwR6N+MuH9SknJrIIiU3nHvX4/uqLcsNYdc8LH6li26kOxF43IJIaeL3nI2RtK4e3nreEFUJI4Q4QmoUkE2jQnijgCx5qaKnFv2in2m7P7vad8ISAL9N7NOlUqYlfLET2//P/6TiQ6XcHUMOYikPVxHbE4PhJWJINbLHQZmkmk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bbdkIzd1TWXPRDIN9wxSYyT+LCXnLfbuJCuIoi8M6RGurYpUrzZdznRTppQCLZjdYMgnRK2NhrFlzr9ZxqTcUk7N0cYZqb8UIwXnwPlQj74i7kDU9uCUmQXa9jx4y9oiPa4c1VKrPS2xQcrhBAF1gLGRmteTojWwb6iZFnfAXQxtMTeSQc5JJAXHurk9fgTaAkLUhuOEm/WHrK1ROjDnfEkDxuU5+lPB2srAHpuyZe8zRGRw5d3OFmqM/oiLx83NRqzDISAaOTQnMFzplFGoLB72J7sW4jvLbkQ0Ls4hyGT6kTcgKtjvVQlpyE30CPWiE2cF/kxuPveWlIu2kK/w9PKfyKxTPxpDiDxCRF13w08BTbp6EmoOvMZnADychUrLfGsQGy0lXbMA9xvb6569D4FNjmaMJzcGXr8qpSzG05Mtu9p8dsFFcL18IP7VliH9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:06:19.4862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b664089-72b2-4b03-720d-08debc4cf1eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Michael.Roth@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

All the necessary changes are now in place for an SNP guest to be able
to leverage in-place conversion support. Allow it to be switched on by
users. KVM-specific checks will still gate whether or not the option is
ultimately allowed, this just allows the option to be set via
command-line.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 target/i386/sev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 32a5e605bf..a56367aa5e 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -3198,6 +3198,7 @@ sev_snp_guest_instance_init(Object *obj)
     SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
 
     cgs->require_guest_memfd = true;
+    cgs->allow_convert_in_place = true;
 
     /* default init/start/finish params for kvm */
     sev_snp_guest->kvm_start_conf.policy = DEFAULT_SEV_SNP_POLICY;
-- 
2.43.0


