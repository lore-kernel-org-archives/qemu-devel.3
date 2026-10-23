Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F211B606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 20:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKLdP-00006o-GV; Fri, 23 Oct 2026 16:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLd8-0008QN-Jj
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:47 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1xKLd6-0006uV-Bl
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 16:12:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCoZhy7wmGXrY2WCjxB5toCZgpKMxXElji5cn6C7VpQIBAqgOhyfA7xN544oB19u+XQ7yjZx+UrmHdPaPXlWjI5iQ8rE+ffpK44jyI9rDtQKhuT/n1RKyEL51q2CZrm2rORHEIcJPOZmlBpzneh/GhRKr5cb7Zc6SPMd8LNqGWHWjNDP9hXkS7yooP4L0kNfzfWoePbzlOoPktudcphosgqWXzAYCnYIpNtTYwwXol99vAYnKolisKqNH10Fwej/6WeDrKUmQwJewS1xj0AC/0MBXK9WGSzjMftZ60Ux7/OsuuwEDK8zyEBlXoLf4gHXbwLm+yBN3Lw1K1yBuIqgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yxavzc22W+fdHLxIKyOk6W3Zh/eu/CdNgvmDVkvmmMc=;
 b=aGnE3HRT3mEpyM5bcmZyhaEKjek5QB8d3atf+C6mnTft67wzKuBy+5Ty6DnzNDgtTPwqkS5Ls9Z5i0HHGyPK+wc1PxRGeF7mU2JHZ1nztWEL8hnri35NhIh8l0qzkQbWlfjb9RnZmLuyFiY/N8jJeLU9pHTDE8flXmAjpKxgVqNnDK3/eOwy82yx/4NYXlQNDr+0JEpuzlCF2IP0vpPuBCF45CmgFFI1UA9baZ/YbgHSVjOvfAwO0pW14U3y1GIEAIUCDvkxef8BgAszBxLKDUks7cxqd6HbgxfOGiwbcvBO963zbs1P5vu0qQCokbGGFbkq+46nxS0BCXQg1HDt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by SE3PR06MB9019.apcprd06.prod.outlook.com (2603:1096:101:31f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Fri, 23 Oct
 2026 20:12:25 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%4]) with mapi id 15.21.0569.002; Fri, 23 Oct 2026
 20:12:25 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sat, 24 Oct 2026 01:42:00 +0530
Subject: [PATCH v2 6/9] hw/tricore: add System Control Unit (SCU) device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-6-c722e4ca5661@linumiz.com>
References: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
In-Reply-To: <20261024-dev-ifx-tricore-upstream-rebase-minimal-v2-0-c722e4ca5661@linumiz.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Saravanan Sekar <saravanan@linumiz.com>, 
 Dineshkumar Selvaraj <Dineshkumar.Selvaraj@infineon.com>, 
 Christoph Seitz <christoph.seitz@infineon.com>, 
 Sivashanmugam Natarajan <Sivashanmugam.Natarajan@infineon.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>, 
 David Brenken <david.brenken@efs-auto.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792786334; l=12610;
 i=parthiban@linumiz.com; s=20241125; h=from:subject:message-id;
 bh=JJJR74stPWN2Y7K8y8C7GqQXn7gPwXEGpDv4U8ywPEE=;
 b=EjR7JPI8GhbQLI8ZZ1ad4u47I8vv1f6Y3OFRq/LQuQ3xjMx9k44qKuR64n74mdsrn/Jb8zpJA
 ZbgbWOStXNuBqM91nlYaZN65MED5DUV81W2ec6gNKIori5t0EMAjF3A
X-Developer-Key: i=parthiban@linumiz.com; a=ed25519;
 pk=PrcMZ/nwnHbeXNFUFUS833wF3DAX4hziDHEbBp1eNb8=
X-ClientProxiedBy: MA5P287CA0172.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::16) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|SE3PR06MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b80cb30-cf30-4a21-fb10-08df3141f4a7
X-LD-Processed: 808466aa-232a-41f4-ac23-289e3a6840d4,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|23010399003|376014|38350700014|261009221227099003|261009223027099003|260925021311599003|260925021911599003|260925022911599003|261021121427099003|10067099003|22082099003|56012099006|18002099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: XAvt3+PfmN5CGS+WFPu2tZtab96cIkkS9Sa04PYC2S0aHLp0I/CIkSaKX2GfGG/im1l2GeldNhPj9x+sRpAWJqhZSjcyIUy6t/zdfHejRZn5UuB3Kh1RFFzwbb96uOgEGt1iA++CGzkQg2A2IUTCnrywIpLCKlJuLAxw8dbGxrFCFADPGxGIGj1SvCQpLDFSA1zqGSPF7Xgk/iWL/U6p5v+MbVyP43RI1MPZ8U778Cbyp6djxf5fgcqq2l4BSYkeCztovu/BWKc7xP/JODDllgVnxbwmCdFQpA9ga1JJ8ItlW1pNKN+noypHq3kf/vGhbWYHP0DXnsX1pCJSefVaOG0UBZzXa2p4jDIrbAUDA45n9XwS3idVMC+UKrROLvrAVQ0COHVIzWA9TGkgs6ojm5flz8JEisEP4Xv1UMBqh3zxHX2qkgDOYP3C+WeVPpfCe/vrAKkFfMLAtbDNPjNejLzUnwzdxEMttxsF2H0DkW480k7CksTTLUgA/n8ZGfHUkUb5MQmKNhFJbbItDgXUNc7+WJKJqZQUqg/upKLE7xOdmM5E69NAof/tSLGkykIWKRu1gusInovXOb5pDjGuCofV6XoRVsTRjRoRrr6Ta70uh+IhqyLuPq3WZIp5EtcFWGxMlhTbiiA7Uu1FJZSlOJD+JGvnP4hQk2FguQUDF+fwtULUaLCWBEQDHjMf7aXt42bZbrLN3m5P7c98qR4xpm9QFCZXhtQbV6k0FVa3yVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(23010399003)(376014)(38350700014)(261009221227099003)(261009223027099003)(260925021311599003)(260925021911599003)(260925022911599003)(261021121427099003)(10067099003)(22082099003)(56012099006)(18002099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG5JaW9HRi9rQ1E5eUVJcTE5M2tDeHVJWWZJVk1yTEVyeTRNaTVKdG05S3hn?=
 =?utf-8?B?MHZHMVlqVXNoU2lCUXBTcm5EVy96MW9vTHNyRlhnZGNlZUdiLzBCQjg1N2lx?=
 =?utf-8?B?clVXTDNoOU1PcXRpNDZIYUFZWEJIcFB5bm1hTXlNZENROXFYeUF6VDd0QVY3?=
 =?utf-8?B?b3llalJNQUs2alFSWXdXK3JhS2tRb3lxRDZyVThBQ3Z3L2t4dFBiY2Y5WEZw?=
 =?utf-8?B?VzNFdk9Rb1NidFpmdjV3UDhuNWM4ZzlNT3VrZmN6STR6K1ZrVk1wVlU0K2t5?=
 =?utf-8?B?ZGZlVUJ2RHNrbWJpV0owMFcreWsxd2QwRHhQQi83RGk1V1JUL2dGamhMdE5K?=
 =?utf-8?B?ckErQVlncDRPYmNTcnhUZDFpajZJazJXK0R3aDI5RkxTN2RIWVU2aTdDRGc4?=
 =?utf-8?B?N25JWktFSlFDUzVrR0JCbG1tUnA4VWpDWURsWEZtanBZZC95eTFtZ2ZoNkNp?=
 =?utf-8?B?c2JnMnNQcnhRK0RxYmZtVnZEY1QrelhpY3lSUDdmNEV2MjZPTlFWSTc4czIr?=
 =?utf-8?B?c2Y1TkQvYytHWGY5MWI0YnNLd1lkYkNSaHJxZTVSZ3JFTGlkc3FmV3NhTFVN?=
 =?utf-8?B?WXRMTDNocFRzUDhlei96eWIxMVFGQ2xIUS9semlJaSs3bmVNVXR0eXlYaFUr?=
 =?utf-8?B?ZnlaT0RkZXVuMWY3eks2VGExN0pjRnMveTI0ZHBVWCtGTmVpZEgzOGlUK1Rm?=
 =?utf-8?B?TUdmckhLbXhlamgzek0wd2VzNHJ2eGY0eTMrV2VrY0sySEpKTGNUTVBlSnEy?=
 =?utf-8?B?U1ZpZ0ZubDBWTnhxR082aytFMHppRmtSYW45Rzk2WW96WWoyQTdUMlpKS3NX?=
 =?utf-8?B?Z3lJUjVQb1cwaUxCZ2x3eXVuZ3c2dTVsUktmQlFtc0VPNXJmVHJJbHNMTWMw?=
 =?utf-8?B?OG9XS1ZqSzk4Q2tSWm9YNU84SmZMSm9URG8reTRuWkdzSVNRQkZmTXIzWTB5?=
 =?utf-8?B?Y2U5Y0ZHTkpFNnFSSEJqRHRGZ2pyZmgyNkN6Y3MvTzVTY0ZkaTJDWGdSbnVQ?=
 =?utf-8?B?cDl3ZDJER0FZbXF5a28vUk9XcmVVVzhaa2ZlK1JpdTFXUkVXM3IwK0VUUFVp?=
 =?utf-8?B?aFNaMkx1dmMyb1ZSZi9TN0JjYjJ3eDFqeUFoUGZaSlU5ckdvQnF2ZGN1NVF0?=
 =?utf-8?B?VU0yaEcwT282RFh2QjBvcml4YjdyVUtMKzE3NmJwaEc1cW5xSEx3U1lEV0lK?=
 =?utf-8?B?Rk1wV3VQOTRwWmRMSms5Wk9UVHRud3pLTlJlS0JhRWgybzhtY2lpTERzQUhV?=
 =?utf-8?B?bzc4TVNZOHVxTjdVU1kwM0JWbERYQVZOQ1FtWjJjeWRjZ0tzZE1jL0RZZHY1?=
 =?utf-8?B?enJJNEw2RitBUE12RkxISVFLSGVKUjRNOGhvdkdhRTE1eTBONHpZKzZhbHBO?=
 =?utf-8?B?SGZqVEFWd0szcDkzMGM3aUhmVlZ2c3cvbE5QdHkzcXc0Qm8rbGo0SWhDb0Jr?=
 =?utf-8?B?YUdMWUVOU1Q4M2VXdExEUDYzVlU4YUlZSFpCNUtPUmRCdThlZk9LVkxxbmlS?=
 =?utf-8?B?ZjROZE5WQzhmNElYaHQwTmdWR09NQysrREVFVE84bWlDdUN0RUxjbFJwdVQ1?=
 =?utf-8?B?Uk1zWkdXU0FqdmtXb095RlFWMDBmNTVKWjFvMFc5eGtoN0FFTG5jYnVDTTN5?=
 =?utf-8?B?Nk0xRURSUWtSVXc4UmlsZlN2MGJWWis4TFplSjc2WmtsWnFYZXMrSGpVOGlr?=
 =?utf-8?B?NGlOTXRGNzgxN2JFWkxEcGppTit5QnNJYmdLdU9MZnJheDdPVFBuVmxicXA4?=
 =?utf-8?B?bG5WTW5IaEswYUhERGU5ZVdTdHRNODN5WmxZalJvYjh3ZFcyRGdyR2dNVUdu?=
 =?utf-8?B?R3N5T1dMWGkxS2NNZS9id0puUTh6RkZoS0RzVzArWjNrQkE5K3JaMk5JdVdT?=
 =?utf-8?B?L1dSQjkwdGR1WlRhZmRrTklVanRjQzNqK3FsSit3TTNRL2cxYjZlWEFhaVVt?=
 =?utf-8?B?c0d4UVhqS1dBb2tzc2ErcVM2UWNjWTJjK1lVb0ZlY0c3RWNSOXVFMzg5L1Jr?=
 =?utf-8?B?RGZBbXF4RjNxc01WcTFJck00NjlUYVhLZmN6THpHSGQ3elhIMVd1TlEwVVFY?=
 =?utf-8?B?WkJxcFJ5cGJpaThVclJudEZ5dlFraTlTRGU4RTB3dHl2bWJ5MkRUQklER091?=
 =?utf-8?B?TVc3ajBBUlVZSXpvN2s1RUNJaUdqeXdMSlpTK1J1cUVKYzVSR2phY1BhOXpM?=
 =?utf-8?B?ZFlUZTVDb2JhOEsxdWQ4bG13WWdseG9mOWxESmxWaXhNbkdFU1J3Q3g0enRu?=
 =?utf-8?B?OGl2ZUsvYVdNcU1LQ1lGRVlVRUs0ZjRYekdkYXFPckN2UjllZUlWWUxmMi90?=
 =?utf-8?B?S3VmeDRNYS9SekpsbVptM211OGVLdWZSUlJvTmZZZEVhZy9nQnI2UT09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b80cb30-cf30-4a21-fb10-08df3141f4a7
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 20:12:25.8115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRxXW4tweQQZVBuys88hPrx+fGVgp+s0j2C2MWTMI3emh2WA6eZAuDiVEE0UVFUXOSbhFRhdYdz9feck9+V5iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE3PR06MB9019
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=parthiban@linumiz.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stub the PLL, oscillator and clock control registers that
firmware reads during boot.  PLL always reports locked so
startup code does not time out.

Originally-by: David Brenken <david.brenken@efs-auto.de>
Originally-by: Christoph Seitz <christoph.seitz@infineon.com>
Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 hw/tricore/Kconfig               |   3 +
 hw/tricore/meson.build           |   1 +
 hw/tricore/tricore_scu.c         | 295 +++++++++++++++++++++++++++++++++++++++
 include/hw/tricore/tricore_scu.h |  45 ++++++
 4 files changed, 344 insertions(+)

diff --git a/hw/tricore/Kconfig b/hw/tricore/Kconfig
index 6c04f64949..decf7c31d5 100644
--- a/hw/tricore/Kconfig
+++ b/hw/tricore/Kconfig
@@ -11,3 +11,6 @@ config TRIBOARD
 
 config TC27X_SOC
     bool
+
+config TRICORE_SCU
+    bool
diff --git a/hw/tricore/meson.build b/hw/tricore/meson.build
index 7e3585daf8..86c8c8dd9f 100644
--- a/hw/tricore/meson.build
+++ b/hw/tricore/meson.build
@@ -3,5 +3,6 @@ tricore_ss.add(when: 'CONFIG_TRICORE_TESTBOARD', if_true: files('tricore_testboa
 tricore_ss.add(when: 'CONFIG_TRICORE_TESTBOARD', if_true: files('tricore_testdevice.c'))
 tricore_ss.add(when: 'CONFIG_TRIBOARD', if_true: files('triboard.c'))
 tricore_ss.add(when: 'CONFIG_TC27X_SOC', if_true: files('tc27x_soc.c'))
+tricore_ss.add(when: 'CONFIG_TRICORE_SCU', if_true: files('tricore_scu.c'))
 
 hw_arch += {'tricore': tricore_ss}
diff --git a/hw/tricore/tricore_scu.c b/hw/tricore/tricore_scu.c
new file mode 100644
index 0000000000..882954ce4b
--- /dev/null
+++ b/hw/tricore/tricore_scu.c
@@ -0,0 +1,295 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU TriCore System Control Unit (SCU)
+ *
+ * Copyright (c) 2017 David Brenken <david.brenken@efs-auto.de>
+ * Copyright (c) 2024 Infineon Technologies AG
+ */
+
+#include "qemu/osdep.h"
+#include "hw/tricore/tricore_scu.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+/* Register offsets */
+enum {
+    A_OSCCON        = 0x10,
+    A_PLLSTAT       = 0x14,
+    A_PLLCON0       = 0x18,
+    A_PLLCON1       = 0x1C,
+    A_PLLCON2       = 0x20,
+    A_PLLERAYSTAT   = 0x24,
+    A_CCUCON0       = 0x30,
+    A_CCUCON1       = 0x34,
+    A_CCUCON2       = 0x40,
+    A_CCUCON3       = 0x44,
+    A_CCUCON4       = 0x48,
+    A_CCUCON5       = 0x4C,
+    A_WDTSCON0      = 0xF0,
+    A_WDTCPU0CON0   = 0x100,
+    A_CHIPID        = 0x140,
+};
+
+/* OSCCON bit positions (iLLD IfxScu_bf.h) */
+#define MASK_OSCCON_PLLLV               0x00000002  /* bit 1 */
+#define MASK_OSCCON_PLLHV               0x00000100  /* bit 8 */
+
+/* PLLCON0 fields */
+#define MASK_PLLCON0_SETFINDIS          0x00000010
+#define MASK_PLLCON0_CLRFINDIS          0x00000020
+
+/* PLLSTAT fields */
+#define MASK_PLLSTAT_VCOLOCK            0x00000004
+#define MASK_PLLSTAT_FINDIS             0x00000008
+
+/* CCUCON fields */
+#define MASK_CCUCON0_UP                 0x40000000
+#define MASK_CCUCON1_UP                 0x40000000
+#define MASK_CCUCON5_UP                 0x40000000
+
+/* Reset values */
+#define RESET_TRICORE_OSCCON            0x00000112
+#define RESET_TRICORE_PLLSTAT           0x00000038
+#define RESET_TRICORE_PLLCON0           0x0001C600
+#define RESET_TRICORE_PLLCON1           0x0002020F
+#define RESET_TRICORE_PLLCON2           0x00000000
+#define RESET_TRICORE_PLLERAYSTAT       0x00000038
+#define RESET_TRICORE_PLLERAYCON0       0x00012E00
+#define RESET_TRICORE_PLLERAYCON1       0x000F020F
+#define RESET_TRICORE_CCUCON0           0x01120148
+#define RESET_TRICORE_CCUCON1           0x00002211
+#define RESET_TRICORE_CCUCON2           0x00000002
+#define RESET_TRICORE_CCUCON3           0x00000000
+#define RESET_TRICORE_CCUCON4           0x00000000
+#define RESET_TRICORE_CCUCON5           0x00000041
+#define RESET_TRICORE_FDR               0x00000000
+#define RESET_TRICORE_EXTCON            0x00000000
+#define RESET_TRICORE_WDTSCON0          0xFFFC000E
+#define RESET_TRICORE_WDTSCON1          0x00000000
+#define RESET_TRICORE_WDTCPU0CON0      0xFFFC000E
+
+static void tricore_scu_update_ccucon(TriCoreSCUState *s)
+{
+    if ((s->ccucon[0] & MASK_CCUCON0_UP) ||
+        (s->ccucon[1] & MASK_CCUCON1_UP) ||
+        (s->ccucon[5] & MASK_CCUCON5_UP)) {
+        s->ccucon[0] &= ~(MASK_CCUCON0_UP | (1U << 31));
+        s->ccucon[1] &= ~(MASK_CCUCON1_UP | (1U << 31));
+        s->ccucon[5] &= ~(MASK_CCUCON5_UP | (1U << 31));
+    }
+}
+
+static uint32_t tricore_scu_reg_read(TriCoreSCUState *s, hwaddr offset)
+{
+    switch (offset) {
+    case A_OSCCON:
+        return s->osccon;
+    case A_PLLSTAT:
+        /*
+         * Report PLL as always locked: VCOLOCK=1, K1RDY=1, K2RDY=1.
+         * Firmware polls these bits during clock initialisation.
+         */
+        return 0x00000077;
+    case A_PLLCON0:
+        return s->pllcon[0];
+    case A_PLLCON1:
+        return s->pllcon[1];
+    case A_PLLCON2:
+        return s->pllcon[2];
+    case A_PLLERAYSTAT:
+        return 0x00000077;
+    case A_CCUCON0:
+        return s->ccucon[0];
+    case A_CCUCON1:
+        return s->ccucon[1];
+    case A_CCUCON2:
+        return s->ccucon[2];
+    case A_CCUCON3:
+        return s->ccucon[3];
+    case A_CCUCON4:
+        return s->ccucon[4];
+    case A_CCUCON5:
+        return s->ccucon[5];
+    case A_WDTSCON0:
+        return s->wdtscon1;
+    case A_WDTCPU0CON0:
+        return s->wdtcpu0con0;
+    case A_CHIPID:
+        return 0x47477172 | (1U << 31);
+    default:
+        if (offset < SCU_REG_SIZE) {
+            return s->regs[offset / 4];
+        }
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "tricore_scu: read at bad offset 0x%" HWADDR_PRIx "\n",
+                      offset);
+        return 0;
+    }
+}
+
+static uint64_t tricore_scu_read(void *opaque, hwaddr offset,
+                                 unsigned size)
+{
+    TriCoreSCUState *s = TRICORE_SCU(opaque);
+
+    return extract32(tricore_scu_reg_read(s, offset & ~3),
+                     (offset & 3) * 8, size * 8);
+}
+
+static void tricore_scu_write(void *opaque, hwaddr offset,
+                              uint64_t value, unsigned size)
+{
+    TriCoreSCUState *s = TRICORE_SCU(opaque);
+
+    /* 8/16-bit writes: merge into the current 32-bit register value */
+    if (size < 4) {
+        value = deposit32(tricore_scu_reg_read(s, offset & ~3),
+                          (offset & 3) * 8, size * 8, value);
+        offset &= ~3;
+    }
+
+    switch (offset) {
+    case A_OSCCON:
+        s->osccon = (uint32_t)value;
+        /*
+         * Real silicon raises PLLHV and PLLLV once the external
+         * oscillator is stable.  Mark stable immediately.
+         */
+        s->osccon |= MASK_OSCCON_PLLHV | MASK_OSCCON_PLLLV;
+        break;
+    case A_PLLCON0:
+        s->pllcon[0] = (uint32_t)value;
+        if (s->pllcon[0] & MASK_PLLCON0_SETFINDIS) {
+            s->pllstat |= MASK_PLLSTAT_FINDIS;
+        }
+        if (s->pllcon[0] & MASK_PLLCON0_CLRFINDIS) {
+            s->pllstat &= ~MASK_PLLSTAT_FINDIS;
+        }
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_PLLCON1:
+        s->pllcon[1] = (uint32_t)value;
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_PLLCON2:
+        s->pllcon[2] = (uint32_t)value;
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_CCUCON0:
+        s->ccucon[0] = (uint32_t)value;
+        tricore_scu_update_ccucon(s);
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_CCUCON1:
+        s->ccucon[1] = (uint32_t)value;
+        tricore_scu_update_ccucon(s);
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_CCUCON2:
+        s->ccucon[2] = (uint32_t)value & ~(1U << 31);
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_CCUCON3:
+        s->ccucon[3] = (uint32_t)value & ~(1U << 31);
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_CCUCON4:
+        s->ccucon[4] = (uint32_t)value & ~(1U << 31);
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_CCUCON5:
+        s->ccucon[5] = (uint32_t)value;
+        tricore_scu_update_ccucon(s);
+        s->pllstat |= MASK_PLLSTAT_VCOLOCK;
+        break;
+    case A_WDTSCON0:
+        s->wdtscon1 = (uint32_t)value;
+        break;
+    case A_WDTCPU0CON0:
+        s->wdtcpu0con0 = (uint32_t)value;
+        break;
+    default:
+        if (offset < SCU_REG_SIZE) {
+            s->regs[offset / 4] = (uint32_t)value & ~(1U << 31);
+            return;
+        }
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "tricore_scu: write at bad offset 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps tricore_scu_ops = {
+    .read = tricore_scu_read,
+    .write = tricore_scu_write,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void tricore_scu_reset_hold(Object *obj, ResetType type)
+{
+    TriCoreSCUState *s = TRICORE_SCU(obj);
+
+    s->ccucon[0] = RESET_TRICORE_CCUCON0;
+    s->ccucon[1] = RESET_TRICORE_CCUCON1;
+    s->ccucon[2] = RESET_TRICORE_CCUCON2;
+    s->ccucon[3] = RESET_TRICORE_CCUCON3;
+    s->ccucon[4] = RESET_TRICORE_CCUCON4;
+    s->ccucon[5] = RESET_TRICORE_CCUCON5;
+    s->fdr = RESET_TRICORE_FDR;
+    s->extcon = RESET_TRICORE_EXTCON;
+
+    s->osccon = RESET_TRICORE_OSCCON | MASK_OSCCON_PLLHV | MASK_OSCCON_PLLLV;
+
+    s->pllcon[0] = RESET_TRICORE_PLLCON0;
+    s->pllcon[1] = RESET_TRICORE_PLLCON1;
+    s->pllcon[2] = RESET_TRICORE_PLLCON2;
+    s->plleraycon[0] = RESET_TRICORE_PLLERAYCON0;
+    s->plleraycon[1] = RESET_TRICORE_PLLERAYCON1;
+    s->plleraystat = RESET_TRICORE_PLLERAYSTAT;
+    s->pllstat = RESET_TRICORE_PLLSTAT | MASK_PLLSTAT_VCOLOCK;
+
+    s->wdtcpu0con0 = RESET_TRICORE_WDTCPU0CON0;
+    s->wdtscon0 = RESET_TRICORE_WDTSCON0;
+    s->wdtscon1 = RESET_TRICORE_WDTSCON1;
+}
+
+static void tricore_scu_init(Object *obj)
+{
+    TriCoreSCUState *s = TRICORE_SCU(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &tricore_scu_ops, s,
+                          TYPE_TRICORE_SCU, SCU_REG_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void tricore_scu_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = tricore_scu_reset_hold;
+}
+
+static const TypeInfo tricore_scu_info = {
+    .name = TYPE_TRICORE_SCU,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TriCoreSCUState),
+    .instance_init = tricore_scu_init,
+    .class_init = tricore_scu_class_init,
+};
+
+static void tricore_scu_register_types(void)
+{
+    type_register_static(&tricore_scu_info);
+}
+
+type_init(tricore_scu_register_types)
diff --git a/include/hw/tricore/tricore_scu.h b/include/hw/tricore/tricore_scu.h
new file mode 100644
index 0000000000..f66e837b0a
--- /dev/null
+++ b/include/hw/tricore/tricore_scu.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU TriCore System Control Unit (SCU)
+ *
+ * Copyright (c) 2017 David Brenken <david.brenken@efs-auto.de>
+ * Copyright (c) 2024 Infineon Technologies AG
+ */
+
+#ifndef HW_TRICORE_SCU_H
+#define HW_TRICORE_SCU_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_TRICORE_SCU "tricore_scu"
+OBJECT_DECLARE_SIMPLE_TYPE(TriCoreSCUState, TRICORE_SCU)
+
+#define SCU_REG_SIZE                    0x1000
+#define SCU_NUM_REGS                    (SCU_REG_SIZE / 4)
+
+struct TriCoreSCUState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    /* CCU registers */
+    uint32_t osccon;
+    uint32_t pllstat;
+    uint32_t pllcon[3];
+    uint32_t plleraystat;
+    uint32_t plleraycon[2];
+    uint32_t ccucon[6];
+    uint32_t fdr;
+    uint32_t extcon;
+
+    /* Watchdog stub registers */
+    uint32_t wdtscon0;
+    uint32_t wdtscon1;
+    uint32_t wdtcpu0con0;
+
+    /* Backing store for remaining offsets */
+    uint32_t regs[SCU_NUM_REGS];
+};
+
+#endif

-- 
2.47.3


