Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D63CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN9F-0007wA-Ft; Wed, 07 Oct 2026 04:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI6i-0001WB-2m; Tue, 06 Oct 2026 23:14:21 -0400
Received: from mail-japaneastazon11022093.outbound.protection.outlook.com
 ([52.101.126.93] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1xEI68-0001VV-UA; Tue, 06 Oct 2026 23:13:48 -0400
Received: from SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) by
 KUZPR02MB9164.apcprd02.prod.outlook.com (2603:1096:d10:61::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.15; Tue, 6 Oct 2026 20:56:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fv573mO5I1Img8Qcu2oleyJlj+QxE0QkpaV56bB1EAo7oZQArAMq2N+rNx9I55npKTi4pnSCFbT2fSTpeaqvPXSzCrJ31aEQ3bUztsU7xgrI0Fm7zVWeW/Ql7QQ+Kb1ALDTP18kUPSnMN2EaLS2XJz38fjtvff/s7Twl0Aj0rjCOP5gX9AzpghnpHoGcjmAkG4jl9kdNyJ3yaGZ38TuzPlLQp5WBkWqVL2VqXixvqxXqz9rQnNGurdaFYFkPFvQ8X/qIRvpCbUMjpTDlhQW6OHv0M6aKFy3ZR5iYZMbj7TkGO5sU+NNo8V2J5gPvALlyfe6fOs2JH9TOymQ59YIZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IUWxRBBZCAPRVHWTWA+nQZ6XTDMFOSpTFatnnWcNTs=;
 b=T1gqzLOCzEwl0TBsUMX34KwyfVGR6aEL9r6jYI8sw3fIqIXLwj3x0kCHRN6/aUSL883+86LyjGd2sgpbHX6RZ4S4usf7nGab2pAyFmiaAjzQiCD5tjEyt13IvnJmRPuP6SxUwMIxRkwvO6CxafjXrSEeZ1mR7J2Nwtmoz0ICkNE6899xfPDTBFBUCCpG13S4By8nmiQv/y3LMeAjnc/LjGsduVSJ4VP+7Nvu9SGSDm4C6QNJfaIOldRw3tMsAdCygYNDuoBPq5bKqKHCykt6gPtN2JAkq/Iaw63+ecTpas+bQ4Z/LSCM/K4FA2XZYmzhx4hkjNgX99TdyGOn9F/z4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IUWxRBBZCAPRVHWTWA+nQZ6XTDMFOSpTFatnnWcNTs=;
 b=H6Lc4cALoTbEHPH/bvwigInbnxNEdpM6yE9Htyayri2EoFl2RFNAhNTTI4S5bg3icTVTtXmHx0tCvizW7jnjuwwko9ohnqsLFX8ulIJhc06YzuzcSciqmO2Og64jNkY4hitFZvR2ZdEDtOHs3pz2IBigwhLZiV7wo7zJg5K4OAIVOQtnfgYwsMkUHiQeJImtFpbCby5Mybfih54AWbgXP3bR2MOYYq8lsOt7i3Cke574Thefp/TrJLOCFp2IS12H3IobNg7ysfTeGaCVTkmwJAIcjxWUfszJrbq6nwrnwmJ4JrUtJuun7yrOLQJ6jwYSYw841OykQuAnU2YgK7mTDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by SI3PR02MB9388.apcprd02.prod.outlook.com (2603:1096:4:2a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 09:50:48 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 09:50:48 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-ppc@nongnu.org
Subject: [PATCH 15/17] tests/tcg/ppc: Add Book E illegal instruction tests
Date: Tue,  6 Oct 2026 17:49:10 +0800
Message-ID: <20261006094921.110871-16-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006094921.110871-1-bin.meng@processmission.com>
References: <20261006094921.110871-1-bin.meng@processmission.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|SI3PR02MB9388:EE_|KUZPR02MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f9d72c-5821-45bc-edc4-08df238f4c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|18092099006|18002099003|22082099003|10067099003|3023799007|260925021311599003|260925021911599003|260925022911599003|56012099006;
X-Microsoft-Antispam-Message-Info: iN6lHA1HAVwdQgNsG0+TxVA/NzVl5S9Pskifhts8LKz1vEfvhzzn9jEHrj4aUHzNJXqKJlQ2L01LiijN/+wPqZphOGhUyb/E+x6ZXlNuMg4Py4n9UFGzVLjo1utacl/q4QUDY6EKBmqpIsJcHjlYGLi3Jc+iPyVchDW2jLbM5P5kWDZ89YglLY68lnDgGAIkGp2m4QN++jErBJNAXUpn/6Q+3QOHynX2Jv1MIZg9I0nOQufx25GlJsEkFNHU/kZzfn658+ZCmMQYn311kX+t+XCwfI+dVr8hdVvEY0i5qfWIPUcCuEkeU/k+N6xY523VTbsPlI/CRxTZ5ZLkDeFKlII7ucjQXKAv/zdszU3o3teABHVUguK/L8dOQfAQXO/Z5e3vF6oiLDvccX5G4UrBBK49Bkf4Jm7/rLJOs619NcsDyzKQNID14UdN/Fdpq8StoEHb6nOz2LDYRIt1BdAaDR9VnEItcuSMSl7XdO42nSCG0etKpahPQW23doBk/OaDnB7dwo+NI2mRxnBWdEfu9KXiLGnMByIjibzap0xUapGZbQdQkdObYlpcZEGtVOoKE/1VPyOBMMiO3Es+wloF6pnu89X35nuhb+5+ZscK51KBDxb32/h4DGoGCwxyDiaPuhBJGd4lusuCOlxrGPoUlOR9GyfgwSj0T4tkVs01rl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(18092099006)(18002099003)(22082099003)(10067099003)(3023799007)(260925021311599003)(260925021911599003)(260925022911599003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zjLd9YwaQD34mCOmh2fcciTmBHkR1iUgM2r6o95ZMLNRk/UpiFrFyFJgfM6Y?=
 =?us-ascii?Q?+jKk8dDnF2kAKrchz4v+fq8zyTbrPxTT/aNwj6cNwM3ZGR83428O3DMY4PDa?=
 =?us-ascii?Q?jn212FFNPjAhh8uZn8ZAKD4yUcY3CZRfvJMLDDEjZej02DtZtUE8s04jdG6B?=
 =?us-ascii?Q?UmWSEyjo3ECOi4KLTizyhNy4x6eW4ELTKau7GYjYSEPq6/XHlsbF8YmLpEV1?=
 =?us-ascii?Q?Oa7nRqFEziFBYzggu6UvL4VW15MdMR9v4qTQk08e7uQLnKha73nP93a+mro0?=
 =?us-ascii?Q?PAa4SEwT1sFJgAc8zxo3zgX2wdPplKBCIjZHKSuQhqP7ySGHm6s2seW3EBze?=
 =?us-ascii?Q?WQyRCw60q0UQamPvvwYaQFCO1qSbl/xtYml79vTXtf5ni7FfXV+qR2MX87Zr?=
 =?us-ascii?Q?0wMBKPOQEqqIg2pXjVkTXunlXfaKp9ivJvhVtEvrd4Jpsd+ZqJTQecxvpaOO?=
 =?us-ascii?Q?RcEAxAEuxiTIjiEZAMAPrnkrrXzrTFPfgsgeZiEKWpLWCX9xHzY/zMMBeyU+?=
 =?us-ascii?Q?84sTEjCLnyah+Yg+rzv8lMBaDgU1lgAl7pL32efHrCnJ7M/izAf+DvsxuFOF?=
 =?us-ascii?Q?yd6KGWpbu9uV5f4/IVwzGgPwrBThrpO58OFDUMjxg8rkSHRgGxvTC7lIcHj2?=
 =?us-ascii?Q?zTfyZlvGPMkLQW5gvKwG9SkYvgr0//cWgQ85JJNb1olvQP/3K8m3yzyiErvA?=
 =?us-ascii?Q?TtBiIsuvjtLEVK7K4P7TnW6x7i/GlyucwBHo03SeE0VTAgPW0mT9oAF4F6Qr?=
 =?us-ascii?Q?vbjtI+zIhDybFcQdAG2BKDeryhDh02Bh06ae+pbp6jKGKu14Qxh/mM6CPb9f?=
 =?us-ascii?Q?heOjscqZ0Jk79M6DyV9j+Y2KSSdrzBDl7HDeNbAEcD3V/BWGVFcvgbssUqTD?=
 =?us-ascii?Q?2ErfXq1WVcMzly+ArrQ6WyTq3yuM5lRXkijnURQv3jL/IcyW0+o59EO2mlui?=
 =?us-ascii?Q?6oPmfeYcYUdRRHUK6HaWyBriXoCK1K3K1SjwatxDdSWDvMbAUwMYKvpAIEyf?=
 =?us-ascii?Q?T7muLgqwbH98SMUVf30WQ/c5fQGK4tfJPvtVL7sSu1T07Ma0GLHtaPzZDJ1A?=
 =?us-ascii?Q?h/rRieKCZnXdNEgC/JhcJruJT72T3743Lr5OrfPg4VARpOKITKFiYWeyY9WA?=
 =?us-ascii?Q?Gthb+qmUSfX2M+GIdy0xvlH3RckfRf3OOHzhF4q23rYFez3owQBqlTexJhAY?=
 =?us-ascii?Q?sYE3E7WRZjlgqDkXBzmuU1O8AZ3LKQYBrfgz98o8ueoWKQurl/Ibi3yl5TXy?=
 =?us-ascii?Q?jhd0lT0L19/OsDqKxtMr4K7PY44pf3Ox+LHqIlJB4ZIPN/fNSmh+KGTAlpkH?=
 =?us-ascii?Q?JC68jv7KnhiFxlvz3BlbVUQQffDxt0dElyeLpWO08VxtvzVHjoUUk2FzxdhE?=
 =?us-ascii?Q?wPFYPWp41kznT9T71YvRNDZAQsDfHMr9KOoe95228SbV0w7c7E9k5q1uF0qu?=
 =?us-ascii?Q?RNr3+oCGBzfRwlVULOhQrCF6+cuWLwyq55sd5TNhKI4A35M5/XUZJ0QlcIfx?=
 =?us-ascii?Q?vrnx2w04+HrKM7whEyTJ01VIqFmTXiQiJoNOIJxTC48gUkLJ0yLYpwTNUwwp?=
 =?us-ascii?Q?A/gdF2yiIu+T/V2Wtsd172z++R+1doCyM/5WE3AKzV3y8utfEmjbXRiwJrSi?=
 =?us-ascii?Q?T1U5entekHQhqo988ONdaI6vBvxybuy2Y044yTwlcTMSa7VxVYQ4I5EK8MeF?=
 =?us-ascii?Q?vWqziiDKfSf58qTm9pxoxzLlUXRIAwrg5gHGioFb1crSPZNzrZHzpsNvD3IO?=
 =?us-ascii?Q?JaIkBqLFIxmwdAVUzt1SqIMlAr1WLNk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f9d72c-5821-45bc-edc4-08df238f4c7f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 09:50:48.2203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yop9zWgDzQKg0DLqh8EUqtdS8hxkrZYzSvqpk7IvCIL09bT8OcDRAx2UWKqkYdbHknQw4gYM0G8sQkKA9zf2jvHkFGgnbj5HlNH5JXQyjIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI3PR02MB9388
X-OriginatorOrg: processmission.com
Received-SPF: pass client-ip=52.101.126.93;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Check the instruction subsets of e500mc, e5500 and e6500 through the
existing TCG test framework. System emulation allows checking SRR0 and
ESR on program exceptions. Run e500mc in 32-bit computation mode and
e5500/e6500 in 64-bit computation mode.

Add shared ppce500 startup code, a linker script and assembly helpers.
Use the existing UART and GPIO power-off devices to report results and
terminate QEMU. Register the system targets in ppc/system and
ppc64/system, sharing the assembly sources.

Test that unsupported floating-point instructions raise precise illegal
instruction exceptions. Also check cmpb, prtyw and prtyd on e500mc.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

 meson_options.txt                  |  4 ++
 scripts/meson-buildoptions.sh      |  2 +
 tests/tcg/meson.build              |  1 +
 tests/tcg/ppc/meson.build          |  5 ++
 tests/tcg/ppc/system/README        | 22 +++++++
 tests/tcg/ppc/system/boot.S        | 92 ++++++++++++++++++++++++++++++
 tests/tcg/ppc/system/isa.out       |  1 +
 tests/tcg/ppc/system/kernel.ld     | 18 ++++++
 tests/tcg/ppc/system/macros.inc    | 56 ++++++++++++++++++
 tests/tcg/ppc/system/meson.build   | 39 +++++++++++++
 tests/tcg/ppc/system/unsupported.S | 31 ++++++++++
 tests/tcg/ppc64/meson.build        |  2 +
 tests/tcg/ppc64/system/meson.build | 32 +++++++++++
 13 files changed, 305 insertions(+)
 create mode 100644 tests/tcg/ppc/meson.build
 create mode 100644 tests/tcg/ppc/system/README
 create mode 100644 tests/tcg/ppc/system/boot.S
 create mode 100644 tests/tcg/ppc/system/isa.out
 create mode 100644 tests/tcg/ppc/system/kernel.ld
 create mode 100644 tests/tcg/ppc/system/macros.inc
 create mode 100644 tests/tcg/ppc/system/meson.build
 create mode 100644 tests/tcg/ppc/system/unsupported.S
 create mode 100644 tests/tcg/ppc64/system/meson.build

diff --git a/meson_options.txt b/meson_options.txt
index c9247e9de1..c75c8d7db7 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -465,6 +465,10 @@ option('tcg_tests_cross_cc_or1k', type: 'string',
        description: 'cc for or1k tcg tests')
 option('tcg_tests_cross_cflags_or1k', type: 'string',
        description: 'cflags for or1k tcg tests')
+option('tcg_tests_cross_cc_ppc', type: 'string',
+       description: 'cc for ppc tcg tests')
+option('tcg_tests_cross_cflags_ppc', type: 'string',
+       description: 'cflags for ppc tcg tests')
 option('tcg_tests_cross_cc_ppc64', type: 'string',
        description: 'cc for ppc64 tcg tests')
 option('tcg_tests_cross_cflags_ppc64', type: 'string',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 064e1429a4..5bac2bcf7c 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -545,6 +545,7 @@ _meson_option_parse() {
     --tcg-tests-cross-cc-mips64r6el=*) quote_sh "-Dtcg_tests_cross_cc_mips64r6el=$2" ;;
     --tcg-tests-cross-cc-mipsel=*) quote_sh "-Dtcg_tests_cross_cc_mipsel=$2" ;;
     --tcg-tests-cross-cc-or1k=*) quote_sh "-Dtcg_tests_cross_cc_or1k=$2" ;;
+    --tcg-tests-cross-cc-ppc=*) quote_sh "-Dtcg_tests_cross_cc_ppc=$2" ;;
     --tcg-tests-cross-cc-ppc64=*) quote_sh "-Dtcg_tests_cross_cc_ppc64=$2" ;;
     --tcg-tests-cross-cc-ppc64le=*) quote_sh "-Dtcg_tests_cross_cc_ppc64le=$2" ;;
     --tcg-tests-cross-cc-riscv64=*) quote_sh "-Dtcg_tests_cross_cc_riscv64=$2" ;;
@@ -571,6 +572,7 @@ _meson_option_parse() {
     --tcg-tests-cross-cflags-mips64r6el=*) quote_sh "-Dtcg_tests_cross_cflags_mips64r6el=$2" ;;
     --tcg-tests-cross-cflags-mipsel=*) quote_sh "-Dtcg_tests_cross_cflags_mipsel=$2" ;;
     --tcg-tests-cross-cflags-or1k=*) quote_sh "-Dtcg_tests_cross_cflags_or1k=$2" ;;
+    --tcg-tests-cross-cflags-ppc=*) quote_sh "-Dtcg_tests_cross_cflags_ppc=$2" ;;
     --tcg-tests-cross-cflags-ppc64=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64=$2" ;;
     --tcg-tests-cross-cflags-ppc64le=*) quote_sh "-Dtcg_tests_cross_cflags_ppc64le=$2" ;;
     --tcg-tests-cross-cflags-riscv64=*) quote_sh "-Dtcg_tests_cross_cflags_riscv64=$2" ;;
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 4c0e30756d..5976540526 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -184,6 +184,7 @@ subdir('mipsel')
 subdir('mips64')
 subdir('mips64el')
 subdir('or1k')
+subdir('ppc')
 subdir('ppc64')
 subdir('ppc64le')
 subdir('riscv64')
diff --git a/tests/tcg/ppc/meson.build b/tests/tcg/ppc/meson.build
new file mode 100644
index 0000000000..869b8906c5
--- /dev/null
+++ b/tests/tcg/ppc/meson.build
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2026 Process Mission
+
+subdir('system')
diff --git a/tests/tcg/ppc/system/README b/tests/tcg/ppc/system/README
new file mode 100644
index 0000000000..37a0fca951
--- /dev/null
+++ b/tests/tcg/ppc/system/README
@@ -0,0 +1,22 @@
+These Book E ISA tests use the generic tests/tcg build and test runner.
+They run on ppce500 with e500mc, e5500 and e6500 CPU models. System mode
+allows checking SRR0 and ESR on illegal instructions. The ppc target runs
+e500mc in 32-bit computation mode; ppc64 runs e5500/e6500 in 64-bit mode.
+
+The cross compiler builds freestanding ELF32 executables for ppc with
+-m32 and ELF64 executables for ppc64 with -m64. No target libc or
+multilib runtime is needed. The boot stub uses the initial RAM mapping
+provided by ppce500 -kernel, maps the CCSR area, and installs a program
+exception handler. Results go to UART0, and the existing GPIO power-off
+line terminates QEMU. The standard run_and_diff wrapper compares the
+output with isa.out.
+
+Configure QEMU with ppc-softmmu and/or ppc64-softmmu enabled. Compilers
+are found through the usual TCG cross-compiler detection or containers;
+--cross-cc-ppc and --cross-cc-ppc64 can select them explicitly. Run with:
+
+    make check-tcg-ppc-softmmu
+    make check-tcg-ppc64-softmmu
+
+These targets are generated only when configure finds a usable cross
+compiler or container. If missing, check the TCG tests configure summary.
diff --git a/tests/tcg/ppc/system/boot.S b/tests/tcg/ppc/system/boot.S
new file mode 100644
index 0000000000..2176205bcc
--- /dev/null
+++ b/tests/tcg/ppc/system/boot.S
@@ -0,0 +1,92 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2026 Process Mission
+ */
+
+#include "macros.inc"
+
+    .section .text.start, "ax"
+    .globl _start
+_start:
+    /* Map CCSR at VA 0xfe000000 to PA 0xfe0000000 in TLB1[1] */
+    load32 r3, 0x10010000
+    mtspr SPR_BOOKE_MAS0, r3    /* MAS0 */
+    load32 r3, 0xc0000500
+    mtspr SPR_BOOKE_MAS1, r3    /* MAS1: valid, protected, 1 MiB */
+    load32 r3, 0xfe00000a
+    mtspr SPR_BOOKE_MAS2, r3    /* MAS2: cache inhibited, guarded */
+    load32 r3, 0xe000003f
+    mtspr SPR_BOOKE_MAS3, r3    /* MAS3: RPN and permissions */
+    li r3, 15
+    mtspr SPR_BOOKE_MAS7, r3    /* MAS7 */
+    tlbwe
+    isync
+
+    load_addr r3, vectors
+    mtspr SPR_BOOKE_IVPR, r3    /* IVPR */
+    li r3, 0x600
+    mtspr SPR_BOOKE_IVOR6, r3   /* IVOR6: program exception */
+    li r14, 0                   /* No program exception expected */
+
+#ifdef _LP64
+    load32 r3, 0x80002000
+#else
+    li r3, 0x2000
+#endif
+    mtmsr r3                    /* Enable FP and select computation mode */
+    isync
+    b test_main
+
+    .section .vectors, "ax"
+vectors:
+    .space 0x600
+program_exception:
+    mfspr r3, SPR_SRR0          /* SRR0 must name the illegal instruction */
+#ifdef _LP64
+    cmpd r3, r14
+#else
+    cmpw r3, r14
+#endif
+    bne unexpected_exception
+    mfspr r3, SPR_BOOKE_ESR     /* ESR must contain only PIL */
+    load32 r5, 0x08000000
+    cmpw r3, r5
+    bne unexpected_exception
+    mtspr SPR_SRR0, r15
+    rfi
+unexpected_exception:
+    b fail
+
+    .text
+    .globl pass, fail
+pass:
+    load_addr r3, pass_message
+    b report
+fail:
+    load_addr r3, fail_message
+report:
+    load32 r4, 0xfe004500       /* UART0 */
+    rlwinm r4, r4, 0, 0, 31     /* Zero extend the address on 64-bit cores */
+1:
+    lbz r5, 0(r3)
+    cmpwi r5, 0
+    beq 2f
+    stb r5, 0(r4)
+    addi r3, r3, 1
+    b 1b
+2:
+    /* GPIO pin 0 is the ppce500 power-off line */
+    load32 r4, 0xfe0ff000
+    rlwinm r4, r4, 0, 0, 31
+    load32 r5, 0x80000000
+    stw r5, 0(r4)               /* Direction: output */
+    stw r5, 8(r4)               /* Data: assert pin 0 */
+3:
+    b 3b
+
+    .section .rodata
+pass_message:
+    .asciz "ISA:PASS\n"
+fail_message:
+    .asciz "ISA:FAIL\n"
diff --git a/tests/tcg/ppc/system/isa.out b/tests/tcg/ppc/system/isa.out
new file mode 100644
index 0000000000..34dabaf8bb
--- /dev/null
+++ b/tests/tcg/ppc/system/isa.out
@@ -0,0 +1 @@
+ISA:PASS
diff --git a/tests/tcg/ppc/system/kernel.ld b/tests/tcg/ppc/system/kernel.ld
new file mode 100644
index 0000000000..3f18a3e087
--- /dev/null
+++ b/tests/tcg/ppc/system/kernel.ld
@@ -0,0 +1,18 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2026 Process Mission
+ */
+
+ENTRY(_start)
+
+SECTIONS
+{
+    . = 0x100000;
+    .text : { *(.text.start) *(.text) }
+    . = ALIGN(0x10000);
+    .vectors : { *(.vectors) }
+    .rodata : { *(.rodata) }
+    .data : { *(.data) }
+    .bss : { *(.bss) }
+}
diff --git a/tests/tcg/ppc/system/macros.inc b/tests/tcg/ppc/system/macros.inc
new file mode 100644
index 0000000000..ec58f68cbd
--- /dev/null
+++ b/tests/tcg/ppc/system/macros.inc
@@ -0,0 +1,56 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2026 Process Mission
+ */
+
+#define SPR_SRR0         0x01a
+#define SPR_BOOKE_ESR    0x03e
+#define SPR_BOOKE_IVPR   0x03f
+#define SPR_BOOKE_IVOR6  0x196
+#define SPR_BOOKE_MAS0   0x270
+#define SPR_BOOKE_MAS1   0x271
+#define SPR_BOOKE_MAS2   0x272
+#define SPR_BOOKE_MAS3   0x273
+#define SPR_BOOKE_MAS7   0x3b0
+
+    .macro load32 reg, value
+    lis \reg, ((\value) >> 16) & 0xffff
+    ori \reg, \reg, (\value) & 0xffff
+    .endm
+
+    .macro load_addr reg, symbol
+    lis \reg, \symbol@ha
+    addi \reg, \reg, \symbol@l
+    .endm
+
+    .macro load_value reg, value
+#ifdef _LP64
+    load32 \reg, (\value) >> 32
+    sldi \reg, \reg, 32
+    oris \reg, \reg, ((\value) >> 16) & 0xffff
+    ori \reg, \reg, (\value) & 0xffff
+#else
+    load32 \reg, \value
+#endif
+    .endm
+
+    .macro check_value reg, value
+    load_value r12, \value
+#ifdef _LP64
+    cmpd \reg, r12
+#else
+    cmpw \reg, r12
+#endif
+    bne fail
+    .endm
+
+    .macro check_illegal insn:vararg
+    load_addr r14, 1f
+    load_addr r15, 2f
+1:
+    \insn
+    b fail                      /* Executing the instruction is a failure */
+2:
+    li r14, 0
+    .endm
diff --git a/tests/tcg/ppc/system/meson.build b/tests/tcg/ppc/system/meson.build
new file mode 100644
index 0000000000..1598348656
--- /dev/null
+++ b/tests/tcg/ppc/system/meson.build
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2026 Process Mission
+
+# Shared settings and sources for the ppc and ppc64 system targets
+ppc_system_link_script = files('kernel.ld')[0]
+ppc_system_boot = files('boot.S')[0]
+ppc_system_cflags = ['-nostdlib', '-ffreestanding', '-mcpu=power6',
+                     '-Wa,-mregnames', '-Wa,--noexecstack',
+                     '-Wl,--build-id=none',
+                     '-Wl,-T', ppc_system_link_script, ppc_system_boot]
+ppc_system_qemu_args = ['-M', 'ppce500', '-accel', 'tcg', '-display', 'none',
+                        '-serial', 'stdio', '-monitor', 'none', '-nic', 'none']
+ppc_system_sources = ['unsupported.S']
+
+tests = []
+foreach src: ppc_system_sources
+  tests += {
+    'system/' + src: {
+      'exe_name': fs.stem(src) + '-e500mc-32',
+      'cflags': ppc_system_cflags + ['-m32', '-DE500MC'],
+      'qemu_args': ppc_system_qemu_args + ['-cpu', 'e500mc', '-kernel'],
+      'expected_output': 'system/isa.out',
+    }
+  }
+endforeach
+
+if 'qemu-system-ppc' in emulators
+  tcg_tests += {
+    'ppc-softmmu': {
+      'cc': 'powerpc-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'folder': 'ppc',
+      'gdb_arch': 'ppc',
+      'qemu': emulators['qemu-system-ppc'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/ppc/system/unsupported.S b/tests/tcg/ppc/system/unsupported.S
new file mode 100644
index 0000000000..1737646b35
--- /dev/null
+++ b/tests/tcg/ppc/system/unsupported.S
@@ -0,0 +1,31 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (c) 2026 Process Mission
+ */
+
+#include "macros.inc"
+
+    .text
+    .globl test_main
+test_main:
+    /* Valid memory prevents address faults from hiding decode errors */
+    load_addr r4, scratch
+    check_illegal fcpsgn f0, f0, f0
+    check_illegal fcpsgn. f0, f0, f0
+    check_illegal lfiwax f0, 0, r4
+    check_illegal lfdp f0, 0(r4)
+    check_illegal lfdpx f0, 0, r4
+    check_illegal stfdp f0, 0(r4)
+    check_illegal stfdpx f0, 0, r4
+#ifdef E500MC
+    check_illegal cmpb r11, r9, r10
+    check_illegal prtyw r11, r9
+    check_illegal prtyd r11, r9
+#endif
+    b pass
+
+    .data
+    .balign 16
+scratch:
+    .space 16
diff --git a/tests/tcg/ppc64/meson.build b/tests/tcg/ppc64/meson.build
index 8cca4d65a4..6aa79fff28 100644
--- a/tests/tcg/ppc64/meson.build
+++ b/tests/tcg/ppc64/meson.build
@@ -3,6 +3,8 @@ cc_feat_cflags = {
   'power10': '-mcpu=power10',
 }
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/ppc64/system/meson.build b/tests/tcg/ppc64/system/meson.build
new file mode 100644
index 0000000000..ca398860e3
--- /dev/null
+++ b/tests/tcg/ppc64/system/meson.build
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2026 Process Mission
+
+ppc64_system_cflags = ppc_system_cflags + ['-m64']
+tests = []
+foreach cpu: ['e5500', 'e6500']
+  sources = ppc_system_sources
+  foreach src: sources
+    tests += {
+      '../ppc/system/' + src: {
+        'exe_name': fs.stem(src) + '-' + cpu + '-64',
+        'cflags': ppc64_system_cflags,
+        'qemu_args': ppc_system_qemu_args + ['-cpu', cpu, '-kernel'],
+        'expected_output': '../ppc/system/isa.out',
+      }
+    }
+  endforeach
+endforeach
+
+if 'qemu-system-ppc64' in emulators
+  tcg_tests += {
+    'ppc64-softmmu': {
+      'cc': 'powerpc64-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'folder': 'ppc64',
+      'gdb_arch': 'ppc64',
+      'qemu': emulators['qemu-system-ppc64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.53.0


