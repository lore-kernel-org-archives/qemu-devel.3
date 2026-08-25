Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FDFC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 16:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyu3e-0003dL-VA; Tue, 25 Aug 2026 12:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1wyu3c-0003cw-07
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 12:31:28 -0400
Received: from mail-southcentralusazon11013070.outbound.protection.outlook.com
 ([40.93.196.70] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Benjamin.Cheatham@amd.com>)
 id 1wyu3a-0002x2-1y
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 12:31:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNYuFpM5ovuXBKetG3eFoxB25mMSdMn+q9KJ1b1CWwx1xvIb/V8CalFJ1QJmnA/Wdx0jvNdue8ngHosBao7UtcY6+05ndWgWtPqMS80345ff3BTvb0NaVFMwbHh0l09Y8LHVwU2kxVNo1BTp3SJ9LnucOd0NrsR3Mzg/pqZVsaecUk3PJ88/by6Pat41eTqdjTsgYkZVlYMHALdUKH2HDvn7oG/SfXwxF59CvQoZp0FwYRlF5etVxaUARbcEyeQvHYQmLjGtNcAfgcDgafHccB3+UQsrct4CBtpJ789KG/Aq7j1scnnXQjXF5edU6B2zYU2HH5yuB2r6M/SoV9SkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJ0SzSnCKu5WmmPqQn66/wv5vX0gbyNwCKRGmDFAbss=;
 b=Ek4eViA7CmWmT0wAblvvVXN6SR2brhM3XQjL0R+rIHWr5ZAqFku55bX6boGZlaFkATWyjJ1ew4BRDT59++9OOXIJ6+NadfVQnwu3jwk0DQiz5ubP4cObT5+a7Y/5YxyCKTFeBpRbH+YtKZXlCDPPkM/UJ/Ik+rB4yJzGrnxPHlCfJLc39MS4FtNABSgEGH3s67+mVgy6U1Tk0AnbhKRf3+iOXuQhEd5q0C9hkneo2wGOnUpVuX4SFNkROL3Jclj15G7C1xeRZkkZFXsKcUz7w4YxdQ7alzpHfOw0Wh65EP2vQ0Cqhnt+S13OX9PvVphOU5h2P5IuzvrsDdtnSFRS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJ0SzSnCKu5WmmPqQn66/wv5vX0gbyNwCKRGmDFAbss=;
 b=SZCvqiTzoBK07927D2qoO1KNCqcBaNw3obWZIG/PQR9U2KrXs0kuoiAnhPGtX5wnCE62hL7IQTHw5qxivWamuyqFHOz3LStAc0GdGl9Cukb0Dh0Q/l0a4M5VoFRjuIHsYObvhj1+oq9iJ8OIDtiACdRTXXN14CpnxnopIOklAso=
Received: from BY3PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:254::14)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 16:26:18 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:a03:254:cafe::80) by BY3PR05CA0009.outlook.office365.com
 (2603:10b6:a03:254::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.6 via Frontend Transport; Tue, 25
 Aug 2026 16:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 16:26:17 +0000
Received: from ausbcheatha02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 25 Aug
 2026 11:26:15 -0500
From: Ben Cheatham <Benjamin.Cheatham@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <zhao1.liu@intel.com>, <babu.moger@amd.com>,
 "Nikunj A Dadhania" <nikunj@amd.com>, Ben Cheatham
 <Benjamin.Cheatham@amd.com>
Subject: [PATCH v2 1/4] target/i386: Add AVX512 Bit Matrix Multiply (BMM)
 support
Date: Tue, 25 Aug 2026 11:25:41 -0500
Message-ID: <20260825162544.18633-2-Benjamin.Cheatham@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ea35f6-b9de-4b64-38f5-08df02c59741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|56012099006|10067099003|6133799003|3023799007|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: GQd6/tmMIDTWQWFk2hNlE5EbOhnTxuWsEu7OoKATTxKWHGLA20Rx6BuaanceJIg1noEHHIyaS2JByux1EEcUDyLTDXOs2m8/zG1k7OMQzS6r77FCknksvPbKMyAlbU1jh2gb+BuW+me35Po0gR4AXERDgje+gpFAcCiQW6juQekrSmmj3MoGgiZnprzMLwDWcU8tOFrZvE11D797zVFfZAV8UtWk3F+EJ5XVU1lvjpN++su6+wXXy4vq688Sn5krMZ5MrXHesSKVX/DFQs5jW67qwt1dweWnJij+/BDbHtpFRBFIzyzuE7VciFTzMElufvbXsuSqiNzjNVFNGll7Ex4W6z6tZNDxbAIxBPiHJ/V1ybg6uYQ9NJK59sugdYLx/qcMdzuWtWuOYtDvfRQ7xJssSbBwpJ8O7t9dMjsVd3QXoQrIstJE/zXt+WdEYJXgTesnacx2QH+6S/RENyKgT/F9YLeZvGdVyVM0LmJeq/MRHEQx6+dvpr9fX5U+xMkQmyyVSXixRmW5KVPi4a9jBtUpbX8YfXlbyQNNELfWpiQOtdkPnjap0BoemlYTzksQGHeCOMnkx4y9s/35bV1cAlLgzSP1+IwKVflVhWe9BFEGYauMrIcXBJ5pnEFdLGg8cAOwPsWzvZ0xn4Y9kvebgfRM40L6kRMK2XfOP1AHRYjTCJyxLQdsrr28NoveF5/3PPQo8rklMUsNzRPnW1s11Q==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A9k7N4cRp4oXSSG4ID7BtHWpepaY3ruOdw2eO2r2sDlGe2iw6bFy1YAkWTWGboIR6p8ytq09wr2GAIFoloExG2dp2qXrTj/JU120cqU9XNJw70htI82uxWah+k7unTr1f0WLbt/31GxVdpteeTuPsV1NkNsw16oeFeUPiOuhGJxbpKlu2CQPU3QxaFQm61juzbmyb6VJTmKqMm+olBc4rRKhvH3dJzVguto9pYR5CPDYNkD7CTexNQCeo/77zp0Jh1uAsTaBmY8T9CRuME6d6jhnZ+W+i/SAMiTp3VONVDwxotYj4eQSmkdknibOuoz7rq8PdoTy964SLMDkDBynkrfVjkF9CqmIciVBZS4UWBASYXEpqdlCrtyozXsQ9rglUP8QAPYhA4OO3g0aEc8cIyjr/IU8vyp/DIqIzdRyA5GN/Iy3qYUECJ6uUlfQ0A23
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 16:26:17.8630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ea35f6-b9de-4b64-38f5-08df02c59741
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701
Received-SPF: permerror client-ip=40.93.196.70;
 envelope-from=Benjamin.Cheatham@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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

From: Nikunj A Dadhania <nikunj@amd.com>

Add the AVX512 Bit Matrix Multiply feature flag at CPUID leaf
0x80000021_EAX[23], enabling guests to detect and use BMM instructions
for accelerated bit matrix multiply operations. Add the "avx512-bmm"
feature name to allow QEMU to expose this capability when available on
the host.

avx512-bmm: AVX512 Bit Matrix Multiply instruction

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e5ffb10d1565..3ece2e8b279f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1435,7 +1435,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "auto-ibrs", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            "prefetchi", NULL, NULL, NULL,
+            "prefetchi", NULL, NULL, "avx512-bmm",
             "eraps", NULL, NULL, "sbpb",
             "ibpb-brtype", "srso-no", "srso-user-kernel-no", NULL,
         },
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 641f3ee5c2fd..9ddbd1c447ba 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1207,6 +1207,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_8000_0021_EAX_AUTO_IBRS                    (1U << 8)
 /* Indicates support for IC prefetch */
 #define CPUID_8000_0021_EAX_PREFETCHI                    (1U << 20)
+/* AVX512 Bit Matrix Multiply (BMM) instruction support */
+#define CPUID_8000_0021_EAX_AVX512_BMM                   (1U << 23)
 /* Enhanced Return Address Predictor Scurity */
 #define CPUID_8000_0021_EAX_ERAPS                        (1U << 24)
 /* Selective Branch Predictor Barrier */
-- 
2.53.0


