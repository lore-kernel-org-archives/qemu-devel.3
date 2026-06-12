Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA7FCD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 12:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY0nR-0001TM-4d; Fri, 12 Jun 2026 08:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wXvxU-0002tL-T1; Fri, 12 Jun 2026 03:05:41 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@processmission.com>)
 id 1wXvxS-0005yW-Nr; Fri, 12 Jun 2026 03:05:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwFGz/ubf0OneDWmrWcY8snsEGfguyZ5fwUHxailQOQTQWEE+C0fUCsOeYXKP6uSGd6XDMxdFMHg4QNrcQUQL6axVk0KnZJzHTXjjfJfY7AHmd/z/n7/DC18kNfRVtBkKHCN1dVcJQcBh2qJYvB3kB3ejLR7Cpo0Vgvoo4HEG+x4Hu2Ny7mHYaIBAdZOD7rrPAOZbN9fOQsTLga8Q5XuI5//PLSlnbM7RjYGDRNJMoZwoWBk6Zijl7UcE7ed78Re7KM2T9nmIX3NJ1vFWUrIEQRhd3KRinvjrcU8xcu48okhsuLgzbwA/xWpGBf6yrHAoI6nBSsxdXfG8Gytn3KNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOUbFphJ2hiU7vmiaaMoOfaAdsGCnvVCpbgFx/HgfDk=;
 b=iHWx5KCb/EvCb6fFkfKFbU+85hQ7knLmg9ydfDOUn0YE8qAE6QMiWh+xjVhN8iMeZg//BzMNGVvLPkCbaHIXEmeZznCVT+m8hOyjU9DPjWouRDItsbMsrdXbPdRIf6vPZwmep0vtcSfYZpQoo+aoxP6QjAhqVY23oGT/TRLuUIzjup2ESnNosD2UY9d1b15GuYalYoCmVz2PMEjvESqd5chcCwxez+tkykHhZPJ1sWU4JjbJzM8k0QOfW0YwTUobx/7AnX4E07jDE5oyvsH4X/Vw1Cj27IgMJtUsmP3oRqYHIKEIN3oUnsDhoVAizJaEPCCNFtPtAUTst2mSQckvhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOUbFphJ2hiU7vmiaaMoOfaAdsGCnvVCpbgFx/HgfDk=;
 b=DE9Qr2gQ5sV7Dq4pvb3Hl9414OMSdpfG3c1kkXsmZyW86WrRjf2byFcUjh3+AJUuotV8aQdg7QTkVgM2n0vVXU1PTrUOfNjzmHVsm3HEGWz6SvD/9m5imqlJxDiOO7OPTUGVO7tZvBKlLMzah5l8ujBMzaVL+y0t3xtaa61P8qpV51h+0Op2b2kIacBvTcdKDPG5VOz0PBnwSH6gvpUKJFaw/Cgfy7dF9UDkutQ+efumHOuOqstAxVNljdHlkzWKLlfNIgLHauibojd9u3Jooa43MKmMEFeIwCUtCkywCUHgwoHzWG45xTMJC7uuQYIKOPDpIKPoi2uZO5EBd3tbzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by SEYPR02MB6457.apcprd02.prod.outlook.com (2603:1096:101:13b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 07:05:25 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%4]) with mapi id 15.21.0092.017; Fri, 12 Jun 2026
 07:05:25 +0000
From: Chao Liu <chao.liu@processmission.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v8 5/5] docs/system/riscv: add documentation for k230 machine
Date: Fri, 12 Jun 2026 15:04:08 +0800
Message-ID: <81d2e2fa42ecabf638f841321cf36cee8f10af01.1781246408.git.chao.liu@processmission.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781246408.git.chao.liu@processmission.com>
References: <cover.1781246408.git.chao.liu@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::24) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|SEYPR02MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: db90eee8-366b-4651-7817-08dec850f9dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|34096008|366016|7416014|586017|376014|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 5ZSSnxdUiMa8f3Mx1SnvD5UmHSvRCLCiKJgffKsOSfUmCDreLuZrt5yOLTeIAbiiEFugxodxXEFcANW7Hi+GYIOXn0huLA8PiU4abx9r+qG1DozK0Sny3kUcagKjGSBpsYFGZwIcvB6ESVgnTAIcN4PLHrWvMW4loG4QAmuPzqtCSiF4ynZuWUQfPkMjOpi4pGADCRR3IU5qPWYSwQZmM5QtG7znqU4fIfCZBIHwmsXAGrcrfRSMZYpBsg5PKxynRncX4smg5auXgwNiH2RvIVwPkGbdfrH7OGOySPUsU5XKKhmITWGGrq6RRMF/6isJiFpSRUALkjjZ133VERCrWWEzKd6wbFlLpKFzTkhBMSuJCH4X2DSa/LCkpbG4BmDLkwg5CGDYsMv+GS9C+pbs8YrToIymRlvJMhU/VlQyLrTzyemL0GAni0z/AL5vrxYCbssuaHt2mqbuIxYmtHnjS4QLGfQvPKAQDeVJ8X53yXe2Vga603IbyNVOggkVqT6Zh46udq9/kl4cpMCayJud8vW+W3El5oNsIlmhNRMSLlkIyWrqKgdihgmfvR8QiOMW8MfhDeDYgSb2dxwALABTmJYMCmnhoehdKAdK1+ET+pQvrapf71ud74bsxUrNlhLGKggaZrjR0/lWRP9Q7JYzBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYNPR02MB9351.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(34096008)(366016)(7416014)(586017)(376014)(3023799007)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWl0LzBDT1ZzVHZjMnI0M3FiVjZHUTIxVFMwODBIQTJvcWdYeDVxY0JwUjZT?=
 =?utf-8?B?NnFTdFFYRkptUStCNXBsakpBMlVlWjFZTTZwU2VjcEZBSzlRUW9SNHd3REo1?=
 =?utf-8?B?U1RnZS9TRmtNVU4xTGdPeGdkelJPeDRWUmZRcFk0ejhEU3VtdHdkYVpKWHEr?=
 =?utf-8?B?VzRwNmtjTytJeXVHZDg1WDNQRTNLRUJmdEZvNGtmYWU0WnkvMkFmWk9nb3Nq?=
 =?utf-8?B?aXpCQStzNDZsaW9VK3J5cHRNam9TSXd0bkVVNGkyOTFpYUlOODJlWTRzN3kv?=
 =?utf-8?B?YUludk51OENJaEN6NVhVd0o2Y1k3WUtKQjhRaWhubDRpck1xeVR3cUpvVmtR?=
 =?utf-8?B?OGlQYWJrSzRxZWdLNnVCVnlRclEyMlljejlFNytHK2JGRGkyMlBWMzlRVlB4?=
 =?utf-8?B?ZWRvNkE1UHJETzRRMzBBV3k0c3VQZjI2bVoxSnpzTW00SmFWNnFVOTZwWmwv?=
 =?utf-8?B?aW9uakVzUWMzSXFOMm5ZeHlnYVZSQzRKVm5ZVno5Z21lVysrQThYcnlOY2hP?=
 =?utf-8?B?RGdjaHVYQXpJNC9LSVYyN1VoWWpvZ205cnI5ZnlLWVhjT0c0WXVUWk41NVA0?=
 =?utf-8?B?U3VuQlRsUVBsMzMvQ2s1aDJNQnhLajA2MzJiYjJzRnRNbHJmaTdtZ2dRcndQ?=
 =?utf-8?B?R2twN3l2N3Q5L3pkZGFtRnF5YkpLbUZXWFJWdjNUb05hNFJ2b0xqeWw2K3hK?=
 =?utf-8?B?UGtuQjRhKzg2dS92cnJZL0g1bDdzc2FRZzgyYmhJaW8wT1licHU2SUIvcXVx?=
 =?utf-8?B?YXFGQzFKUEltcVlXVFF3T1ptOGVuVSs0aC8vbjZ5VjVQL1pheHduSzg1eUU0?=
 =?utf-8?B?ZWxDZldUQWJWMU9VTUlDd0UwakQ0TUg4Q1psMTcwVU5Nb1FmaUJJOXdJbU0z?=
 =?utf-8?B?czdYMGxNQVhSR0JMNXNjTzhPRmkyMFNFdGRIS1IzVTM0anl1OURoa2x1VDJ5?=
 =?utf-8?B?SnF0dENwOEVURm9veHZ6TFA2YzcvcVVYNmZIRFZNZU1DZ0E1aEx2b1cxb0Fs?=
 =?utf-8?B?b0JJZm9JME1jVVE4ZXd6clpHMWFCSE5KV2ZGTWQ4U1NRR2VQb2plUHI2QjZB?=
 =?utf-8?B?eE0xcHVyeG1uMmd2cFY2THNzUlVIUnNYeVpRQjh2WVF2ZTgrS0h3RHJZL2Iz?=
 =?utf-8?B?MisrM0FScFRxc09DYkJzVGlyM1paNndPM21vUFZ4NWNQT2lLVFUzNGY4Vlcz?=
 =?utf-8?B?N2NWNkV4S3hVOU52LzFUU1pMTW1jd1dWNk1iY3JjZkNISkxZODlSREkxNElh?=
 =?utf-8?B?WEJKdkw2dVU4bHJ4NEFXOEJGK3AyR0dxVGdQYWFxQkZRdmZnc1dscFVqbkJU?=
 =?utf-8?B?cnZCOHhQaE16VVR1VWlvQ1E5Q1VrTy9pUDhHei9nQmxxbE1qeXRnOTNUaUVu?=
 =?utf-8?B?WGtWK3N5TVdXQUxaQ0pUU2dBMjI2NXNUMGtNY2QwODByS2l1MmlBanFXT0ZU?=
 =?utf-8?B?dWY1bkw1OWZXTWpXLzRLaHlqVm01Vk9kYmVYL0FmcHRlRFhPR28rQ2p5clBC?=
 =?utf-8?B?TjY3TXJYTGUvWmdaOVRnbDl0VGZxbmxOK3hqazRpWnplKzN0djRjRmhKbUE3?=
 =?utf-8?B?R3RQaEc3RUd6L1hYcllGOVhTV0p1RE9UakcrdHgwOXRyQnhTUEQ4ZktUZUFR?=
 =?utf-8?B?aTdCaTJRTXpPQXJqaTl1d0hNZWJZS2pBT2ozenFaNFVJbHp1TmtOZ2VFSXNn?=
 =?utf-8?B?UDg1SUJQMDhUT09QczUxTG9tcWErOXZSUSt1aUsvTVBGSGY5cGY2c3NGcFNJ?=
 =?utf-8?B?UG1mTSsrYWhLL3kxbGtLemRLZEZwOVROTjFxU0dTM1BlOEt5M1BwMlhJbGpm?=
 =?utf-8?B?ZHNybVgycGdhMmN2RUdLVzd2QnVIcUlxVEh1V1JyZkRFYU1iQ3pIdzQ3Ukpm?=
 =?utf-8?B?dzRkTSsydE1abENrem1EaDFjVDlQL3k0d0tYKzdhN0NUR21tbjJPRE9CSitQ?=
 =?utf-8?B?aUJRd3BOU1d6Qy9IaWxmYkdSNWR1N3prMjlHWUMxajgrNkNXdkdTZ3UvT3dp?=
 =?utf-8?B?ckhSRURGSjFDMVFGdlNjQlIwZlNqc2RFRDBzQkZ0U2F0cWpNMzVFaXRsRi9Q?=
 =?utf-8?B?ZHJLWWdTd2dTKzhXM2oyNnU4Vzlrd21sSlNKWEtKTzc5YXpHOVFoTzZtUjJ5?=
 =?utf-8?B?V0dlalZQOFhnNmRoOWt4R0xtUlZFUGFlNGQ3R0diNTFsYlp0WDJxRml1K0tW?=
 =?utf-8?B?Uzg3S3d3NzVPUnZnMHBlT05HdG9tM2pxUG13Q1JKeXo1OVJNR0VhWk43M3pz?=
 =?utf-8?B?bnYxSmt1cXdmSHp2UmFYYlJ3RUFkcU8wbWpzVUZxMkhULzRtY1RMVXpDT1JR?=
 =?utf-8?B?UmlXQURhWXRYakt0OGRRaHN0TXZ3TnNHYkczWGxmZmV6anZvcGpxbTNQU3dE?=
 =?utf-8?Q?Iic9T4QAbQrKa5ks=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db90eee8-366b-4651-7817-08dec850f9dc
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 07:05:24.9533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sM33HaxqQnyJ6mLAmqYsn9BC228gHw0HnSkhMosvie9rrSyBFnbXON+wq9Lz60Tc6+gxjp8GzFtukFHXNKJ1jGUnFaABo1lmVy8ZfX943uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6457
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=chao.liu@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 12 Jun 2026 08:15:35 -0400
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

From: Chao Liu <chao.liu.zevorn@gmail.com>

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                  |   1 +
 docs/system/riscv/k230.rst   | 113 +++++++++++++++++++++++++++++++++++
 docs/system/target-riscv.rst |   1 +
 3 files changed, 115 insertions(+)
 create mode 100644 docs/system/riscv/k230.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index 44654b5798..4fc073b7ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1790,6 +1790,7 @@ K230 Machines
 M: Chao Liu <chao.liu.zevorn@gmail.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
+F: docs/system/riscv/k230.rst
 F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
new file mode 100644
index 0000000000..cea8202e55
--- /dev/null
+++ b/docs/system/riscv/k230.rst
@@ -0,0 +1,113 @@
+Kendryte K230 virt reference platform (``k230``)
+==========================================================================
+The ``k230`` machine is compatible with the Kendryte K230 SDK.
+
+The K230 is a chip from the AIoT SoC series made by Kendryte ® — a part of
+Canaan Inc. It uses a brand-new multi-heterogeneous unit accelerated computing
+structure.
+
+This chip has 2 RISC-V computing cores and a new-generation KPU (Knowledge
+Process Unit) smart computing unit.
+
+For more information, see <https://www.kendryte.com/en/proDetail/230>
+
+Supported devices
+-----------------
+The ``k230`` machine supports the following devices:
+
+* 1 c908 cores (little core)
+* Core Local Interruptor (CLINT)
+* Platform-Level Interrupt Controller (PLIC)
+* 2 K230 Watchdog Timer
+* 5 UART
+
+Boot options
+------------
+The ``k230`` machine supports K230 SDK boot through M-mode U-Boot, which then
+starts OpenSBI/Linux with ``bootm``. It also supports direct Linux boot.
+
+K230 SDK Linux kernels use T-HEAD C9xx private MAEE page table attributes. QEMU
+does not implement MAEE in the generic RISC-V MMU, so such kernels need to be
+built with standard RISC-V PTE bits before they can boot under QEMU.
+
+Running
+-------
+
+Direct Linux boot
+~~~~~~~~~~~~~~~~~
+
+This flow lets QEMU load OpenSBI, Linux, initrd, and DTB directly, without
+running SDK U-Boot. The Linux Image must be rebuilt with standard RISC-V PTE
+bits before running under QEMU.
+
+.. code-block:: bash
+
+   $ SDK=k230_sdk/output/k230_canmv_defconfig
+   $ qemu-system-riscv64 -machine k230 \
+      -kernel "$SDK/images/little-core/Image" \
+      -dtb "/tmp/user-k230-qemu.dtb" \
+      -initrd "$SDK/images/little-core/rootfs.cpio.gz" \
+      -append "console=ttyS0,115200 earlycon=sbi cma=0" \
+      -nographic
+
+Direct boot uses the SDK little-core RAM layout for OpenSBI at
+``0x08000000``, Linux at ``0x08200000``, and the DTB at ``0x0a000000``. The
+initrd is placed by QEMU's generic RISC-V boot helper, and QEMU writes the
+initrd range and kernel command line into ``/chosen``. The DTB passed with
+``-dtb`` should be derived from ``$SDK/images/little-core/k230.dtb`` and must
+describe that initrd location as usable memory and disable any devices that are
+not emulated by this machine.
+
+U-Boot boot
+~~~~~~~~~~~
+
+This flow starts SDK U-Boot in M-mode with ``-bios``. Until the SDK storage
+path is modeled, place OpenSBI, Linux, initrd, and DTB in RAM with loader
+devices and run ``bootm`` manually. The Linux Image must be rebuilt with
+standard RISC-V PTE bits before running under QEMU.
+
+.. code-block:: bash
+
+   $ SDK=k230_sdk/output/k230_canmv_defconfig
+   $ IMAGE=$SDK/images/little-core/Image
+   $ INITRD=$SDK/images/little-core/rootfs.cpio.gz
+   $ DTB=$SDK/images/little-core/k230.dtb
+   $ FWJUMP_UIMAGE=/tmp/k230-fw-jump.uImage
+   $ INITRD_END=$(printf "0x%x" $((0x0a100000 + $(stat -c %s "$INITRD"))))
+   $ "$SDK/little/buildroot-ext/host/bin/mkimage" \
+      -A riscv -O linux -T kernel -C none \
+      -a 0x8000000 -e 0x8000000 -n opensbi \
+      -d "$SDK/images/little-core/fw_jump.bin" "$FWJUMP_UIMAGE"
+   $ qemu-system-riscv64 -machine k230 \
+      -bios "$SDK/little/uboot/u-boot" \
+      -device loader,file="$FWJUMP_UIMAGE",addr=0xc100000,force-raw=on \
+      -device loader,file="$IMAGE",addr=0x8200000,force-raw=on \
+      -device loader,file="$INITRD",addr=0xa100000,force-raw=on \
+      -device loader,file="$DTB",addr=0xa000000,force-raw=on \
+      -nographic
+
+The loader addresses mirror the SDK ``k230_canmv_defconfig`` output. Read the
+U-Boot addresses from the generated environment, and read the Linux RAM base
+from the generated ``hw/k230.dts.txt``. This replaces the SDK storage and
+decompression steps.
+
+Press Enter to stop autoboot. At the U-Boot prompt, run these commands:
+
+.. code-block:: bash
+
+   K230# setenv bootargs console=ttyS0,115200 earlycon=sbi cma=0
+   K230# fdt addr 0xa000000
+   K230# fdt resize 8192
+   K230# fdt set /chosen linux,initrd-start <0x0 0xa100000>
+   K230# fdt set /chosen linux,initrd-end <0x0 ${INITRD_END}>
+   K230# fdt set /soc/sdhci0@91580000 status disabled
+   K230# fdt set /soc/sdhci1@91581000 status disabled
+   K230# bootm 0xc100000 - 0xa000000
+
+Use ``setenv`` so ``bootm`` writes the kernel command line into
+``/chosen/bootargs``. The ``fdt`` commands select the loaded DTB, add space for
+edits, describe the initrd range in ``/chosen``, and disable SDHCI nodes because
+this machine does not emulate those controllers yet. Replace ``${INITRD_END}``
+with the host-calculated value above when typing the command. ``cma=0`` avoids
+the SDK kernel reserving too much of the little-core memory window for initramfs
+boot.
diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
index afd86ca2ba..896f14e78b 100644
--- a/docs/system/target-riscv.rst
+++ b/docs/system/target-riscv.rst
@@ -66,6 +66,7 @@ undocumented; you can get a complete list by running
 .. toctree::
    :maxdepth: 1
 
+   riscv/k230
    riscv/microblaze-v-generic
    riscv/microchip-icicle-kit
    riscv/mips
-- 
2.54.0


