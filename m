Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B3CC61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyu3e-0003dG-7J; Tue, 25 Aug 2026 12:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1wyu3b-0003cu-Sv
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 12:31:27 -0400
Received: from mail-westusazon11012020.outbound.protection.outlook.com
 ([52.101.43.20] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1wyu3a-0002x3-2Z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 12:31:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcCN8jg4COrIsXZ9g+fVVwQZpeTuYkAcgMB7Gg9CE9krcsCu5YoqPYKyZ60jE+ejmjUQ+0cXtzyTGzFIWBycM1s0MXU7WzoLW9EFFkdT2oeFcAsva/4ygyfIQWhuAoch5nAgnbnVtj96CA62SqHq6miF3mN1FmHtaAO9TclovZ1dBPYc182HTWd+xmaOCZ8BFyMEeLapTsxEAYYj785mvWfI9pVwxxX7EwSvBPrD2yZVeDkLntZNznfgROpsyTJLUXppjBsozVd5YapwRjRTPAepGfravha+nnEgOhJk/Eip68KU8xZNo/YoFp3cLa7GH83qg6LMeOvYPRpRtkgRDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBNJBPrEdTMZOp1KgiEbvBOnUAzOz8utSQ3+25qAcIQ=;
 b=IaxXqjlXIxpl2rB2XzMuSytppLMJNlhtDkuwpd8Nli3DzSlxa5wiMZXbFpXZh5IBJgkNh0QvjunMbmzVX+6Ef+QFQxBXjOAxzqNiBQsiMTUFLTvq0ApuHqSrL0r4vY7CsbGv79zfhalonyLCWAJCtDTMR99xI67TgV4j7Eqxkl1dX/VFFzbgG3uqFdiDJmmnI9gHSzIsuRhAoCVVvvMgJKJIJy4JZSD7v3SU6wDfPmbr9RWpX7iuzpIBaYK+lHgJWQK8WsWWtfh0Cns0pI4UvRbcd1hAdaPGEeBNr5JYoEzAHkr5y6nNciQU5UekpvenEzTKqliX4X+5AwX4G7YJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBNJBPrEdTMZOp1KgiEbvBOnUAzOz8utSQ3+25qAcIQ=;
 b=JtmEZJKBOqnqdxRkc+rFMnictjNpeJ4wo9V0Tr0bKidN0+OXQJhcUqKX8ZId/5OUlbzBc0lSAjunaPO3pNCWckGUZ9lew3LKo+IWuMmHhE0uflLmemau3nL83HZ0E5bH0wOKd3N4+sEVxJ7Azg2R3L7m2J12eGULn1b+Ah9glBw=
Received: from BY3PR05CA0020.namprd05.prod.outlook.com (2603:10b6:a03:254::25)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 16:26:19 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::1e) by BY3PR05CA0020.outlook.office365.com
 (2603:10b6:a03:254::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Tue, 25
 Aug 2026 16:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 16:26:18 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 11:26:17 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <babu.moger@amd.com>, "Ben
 Cheatham" <Benjamin.Cheatham@amd.com>
Subject: [PATCH v2 2/4] target/i386: Update RAPSIZE definition
Date: Tue, 25 Aug 2026 11:25:42 -0500
Message-ID: <20260825162544.18633-3-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825162544.18633-1-Benjamin.Cheatham@amd.com>
References: <20260825162544.18633-1-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: e02a0b7d-9ebe-406c-acf9-08df02c597ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Q0QJ/YQYUv/0wW2ZnYCjvU6td5eEOAA2kHFHpcL0jCVNCbtpgJwwDQGGNLC2W67aXF7xer2FEJ0DLvk/kXb1PLJXnFocpPK97RIFr0BRRvgiQWhLmHM462c5w9T4pTwFZ56olQxINI4053/WSi+JQaPKLOTGky5KIRDm6XWeCeiByOnK8hLgMU1qb6ejj5JB9jMHJeiokUmLQfAcJVHDFcDAeKL3Y506G+XxsELQnMuOMPCmaK615PZtAp28lLXGWK2YPCK/Oe+fNjI5E61VNHb69rJP6G4zY310Q/GEoUhnWeuyQpgVpsw8dJ8Nab9Q3Z8hQyRhCsPFGWCJ3a4o7q1+LH39hu4hbtm3LHpQeBBesFHHDqZ6XqlStlXRr64vcZa+OST2lIONPJvGUwdnJR+hjNydToYlkOs8Ugn5WI6w1uclDTiXxKagevFzGRNTVcwMKpwai8j8SF8HSAug4AjyuMVY7DZ6JRi32FlOwb9SOW9EwEdXQWnVCDHhHX1OcCuWcp+5idhh0d9CfSBQ+LhsbYBvCq3cqZwu0l/vqs5KwwYrOyQ92XCLMSnf081M9wvXcyF/tuMr+BwSu8wcehCx8/EW3gQxK7BNSIxFyUO9sMt8aXoYzlZTpzPZojV9UDYeR/40WgizhA5RsPhA4MmHeCuQKm3JExbtzz6GB/Yf6B4UpUMy5r/sy2i66LdDOSrHCvjr7sxdqZK3AXdAQA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +cmXdp7K+XWxEKcF7cuuqWzQtPGBIVLg4YCQifLj9W+oK3ioTV8fUpNaROBSDQxt3R/OFm8iPn5h7DV/QMDWwaSshbIUl00zAs+fyiNftBya8Nt5QBISfQ6UUUb9G99Ypfnef9lfDtzon0iQHY6S9vyTofcIdhQCg5f8qfVOXKJggwi2wU6ZoEG1ZSRc2wqNXx5DUZaRsL7FBOC2vdYQacJWmHButSD/+2lGSDv4emTqpqJ5aiFNvQ17Ev28ZYIknfQVdIMlOs2ikd5+cTw3i7UXIygqohtSC2puJqJoVlqajROTcgm9W4gtI5L8C/I5Lfkh6YrvjMVsHMpWU1Tz/b7UJQTeKpVM6xoKZubUPnhy7YV2TPbETq4CV1JXSWioRupJlgzXucqLAk6Guwls2Ua4LUggncG+ctjUfNnYvE8oKE+oS1bDUqqaupN7jZyH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:26:18.7286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e02a0b7d-9ebe-406c-acf9-08df02c597ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
Received-SPF: permerror client-ip=52.101.43.20;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The RAPSIZE definition originally introduced in 9c07a7af5da:
"target/i386: Expose new feature bits in..." hard-coded the value
of the field to 0x8. While this value works for current CPUs, the
value may change in the future. Update the definition to be a bit-mask
instead of a hard-coded value for future-proofing.

The field is currently unused, so no functional change is intended.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 9ddbd1c447ba..b7d135d610d6 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1221,10 +1221,11 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0021_EAX_SRSO_USER_KERNEL_NO          (1U << 30)
 
 /*
- * Return Address Predictor size. RapSize x 8 is the minimum number of
- * CALL instructions software needs to execute to flush the RAP.
+ * Return Address Predictor size. RapSize x Y is the minimum number of
+ * CALL instructions software needs to execute to flush the RAP, where
+ * Y is the value of CPUID_8000_0021.EBX[23:16].
  */
-#define CPUID_8000_0021_EBX_RAPSIZE    (8U << 16)
+#define CPUID_8000_0021_EBX_RAPSIZE    (0x00FF0000U)
 
 /* CPU is not vulnerable TSA SA-SQ attack */
 #define CPUID_8000_0021_ECX_TSA_SQ_NO  (1U << 1)
-- 
2.53.0


