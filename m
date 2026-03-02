Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24B6EA4E10
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx4iW-0002AQ-6y; Mon, 02 Mar 2026 09:57:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx4iU-00029X-8z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:57:50 -0500
Received: from
 mail-switzerlandwestazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c214::1] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx4iR-0003Z6-8G
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:57:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9hf/j3QXGKd8scisDQjWpEz6rOud/BkkyC6zM+wY6Q2/zAHfQcWHs1TmlOEx8VkiP9HajuCZJSgqVoZJVNN8898X7GF2rH+lgpPd5m+cDeTnMzHFyB7ralvq8s7dGPMWNtBauueeoxRuDiZz8W5q8yy2cTI+GyTurHMHOVN454IVTiQbYE9awwm2XYoMCYvrp46BjM7Pad3F5roo4Hqo4pSrZetBblxCCq679XYhYOhv8gvewjLyYk0DRbUVHlyAIuezdEJXj0n4d+xuvaBIls/pe6d6Zt7jErZZMUjVoDF5D+aTIZktFk7RMKLewDwfYg33l+z8WAv6AGYzLhsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFCN0v3UzRkRnerbYEOjh9g3jQ+fMj8Jixq6cuCTmqk=;
 b=zKBluXRrvttFik4/VOg8OwXtiXbwI3+U+FQ5uotJKeeomnTV+avtGdrXQ+uVrVTTFUr65LiLhR0IRwxCdPmr5R05CDu9biuA+/sLfdlC3iV+9MzeF9NOVNo5A5TWHgF5v/ldBlShXrP4GjiojKp5oVlc1T0uAXO5grObV9uG2bKqmq//Ez+g2RzOwDzaoGsf/ReYPGIOidL3n37UeMB1o0GE/8IpHqS/pGXgeS0gEGz090FvapmmwiGoJgT5huE91z/OM/6sRX4/zGJJA51a1w6WF7DoVR62XRt86E7IFL7JKqW7C3a+p9lZ8raQQ1RKUjENmkcxtGlDVfZxEAnJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFCN0v3UzRkRnerbYEOjh9g3jQ+fMj8Jixq6cuCTmqk=;
 b=mASyXRN92DsMTWS+n8p1lAJMx9Uol1hj3pdFurtBROU2JISYZJ0GRkyWpcQdPeCm/LnWhdRRglS/F/Y53iJg1PAqzmtAmG9tbF9M/WIwGK6Er/QF7yRhR5yYByuLoH+OKbl9RsT+zjdM7G/pvA4MDRYQg/7l3JX6Dx7FXpOQJNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1634.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:57:42 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 14:57:41 +0000
Message-ID: <244c66b5-482b-473e-92bf-fcec34e8c446@epfl.ch>
Date: Mon, 2 Mar 2026 15:57:12 +0100
User-Agent: Mozilla Thunderbird
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Subject: [PATCH v5 4/7] tests/tcg: add test for qemu_plugin_set_pc API
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <1739da2c-2ea6-4bc7-be6f-981f8658ce3f@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0029.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::16) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1634:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a470cd-6bcf-4a85-710d-08de786c0d23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|786006|19092799006|1800799024|366016; 
X-Microsoft-Antispam-Message-Info: pUhOO1FOXKgSkip7ni1TZrQvZ97sfQwqRPdwGXtdbW918Z2DtD52JC4LKruGBOmwbmJ+HrvR2CEbmBEixlA6ObabFIw1SWecWiZ/4RxOw7s22NFUPjixWv15DtnlWzt/lulLLZ7HBNfkEZ+UT+snIqhoRRGdcHjqNnP9sBjbj41LQa0GW4K1U60sMkL1CI+myHkc6YT0lTYko9N8hjnYlQItrc62hVwrF1Ei2RU/esVluNUKTObdvBJ6ml5BHZFzZVEZ1y2LG4UTFythicLBQ1r3cqArGoJ2k+27Q3smW4vwKnU/3Ojz+PLR8VMPhylMmtq8oHebj+dYnzABDNRZMPXIc2YfZITAS5FfYnuamR0u9f+qYHqJN9ebdo/o+Hlzaw18rP9ymRl9FHfC8cbqBCpvV7ZCaafqFSKfR1HdQryLJjmBr9VXtSEZ1NRe9PH9N3yOiRwON/vs4colj1J7ScAVspDwqMHgTWe0WYD5+e/nv3YSprXAqK5sO87zHNwZphm6q1aKiG3YQTSu+lBkiPcuHtvpv+D+H4AStJaFqCP6pgRu8WQPuCAuGwXzJz5tvuJs39aQ1YB1Fj4vYgAZXyOR22GFc4fO5oOlDNWKWaFJWLTyF6zPa+F3svZ85xiyrDixyP+uD0lEd5rHwflP0GxEzJc2h4V+QcMe5Krj1C0Nbd2BCTneA5hYraM9nCciENQtKAJMtxiESwbW8JahMyKcwOOephytqGJghJUIz5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(786006)(19092799006)(1800799024)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFBna1E3TElLRkNvOUFHZGNFMSthL3M1bEhONUdSNnFFRUM4aWtHWTFhSkJp?=
 =?utf-8?B?OUUzb3B3OXBINGhPM1NicGt0S3k2c1NUbDAzay9EbURZdndZUE9uOUJzU3p5?=
 =?utf-8?B?T3Z1NTFSRkxYTmljR2NDUldVeWpDZzBnajhsdFdSRlorbzg4Y3BwWng2NEtL?=
 =?utf-8?B?NURwemZlM3puVytIYzI0VHlBdGtCNGxlTDI2QWlUNmZkZnFhOFZnVHlsclhp?=
 =?utf-8?B?SGhiaEJyRVZyRzR6KzdJWkdyMFgycTA4cE5UVmZFUTJtOWdtUWRWK010Q20w?=
 =?utf-8?B?NnphSnVDUnhVaEp6YWtqN0lQSzZ6Vmo2Vm5tOVNkVEVIZ1Byd2d4MFBZLzdC?=
 =?utf-8?B?R0pwSUl1dnNZUmRlOVBCNGlVZDdBWEMwZFlBYmo4cWkwTkhvYXpzSkpZU2Zu?=
 =?utf-8?B?c1ZMTnF0b0xmVmgzWEpZK2VzempsWTVNeWdFODYxTDhZVlQ2TXpRWjQrSm9t?=
 =?utf-8?B?amhydmtFb1N3aFRYdkVVNHBUbEROeXhKai9tbHRaK0FYKzBGbml1MVdHaHpp?=
 =?utf-8?B?QVJCS3JUdys2aVkxNXVMc3VQWXZZV09adWFRRHZpblR3QWtlamVYMkpTdUls?=
 =?utf-8?B?VkV2K2QxdnRHZm9NcXVtQjZMMUJEZ3BmOHlqRHQwbCtlZmFKOEl1UWJHRmIz?=
 =?utf-8?B?dC9NQkFqLzEwR25wUEtodDN5dUVFWEpyaXc1OVBXalVzMHZEWHZzSnhWTm5Q?=
 =?utf-8?B?TXYveHBrWWJuNExrUUdlMnZlVlcycTY4eUh3VlNJWEQ2MUQ5UldwZ2MwRmhB?=
 =?utf-8?B?bWpYN3VDcHB0NlgzZHRNbmdTY2RWV2NwM2krOXNJSDluK05HSlg4bjd3UXJ4?=
 =?utf-8?B?amRuL2hLQ0JaMm9oNXBuRVhpK3BrRGlNMEtnQ3N6OStxclo5L2tkalY3ZnBQ?=
 =?utf-8?B?TWlTYkZwYlRkcFNYSHU2dkxJOWhwemQvK1U2NDk0V1JhMkFHaGkySlJSMklM?=
 =?utf-8?B?ZXhHNWV1Wmd5WGliUXVaNnlkS0o4RDQwM1U5ckR6Y1dtV1NWY2VTa1VSUXhQ?=
 =?utf-8?B?dGZaRjU1NDRwdWdHTTZWdEQ3eTU2NXpPSWNSQzBic0FCekhpVnlsazBaQzJa?=
 =?utf-8?B?TGxFaGtsKzNMTUp2QzVUMDdsMnFHWjNUQkdGbUdseHVPWUY3Y0VnU1JlbER4?=
 =?utf-8?B?REJrdzZIdVAvUTcvdkdrZ0lTckhUTXI3K3BXd25yejdKRmo3VFNkcVRJak5T?=
 =?utf-8?B?QW4yd3FtdjhVZnF5a01pZDdjNGdXTWJjVTFqeFE2c3VqSUR2dDlON2FldGpV?=
 =?utf-8?B?QmltbkFRTVVFZ004TExvYUpKdFVpcGxSNjVtb2RHR2NTR0lqWFdKSWhOT3VV?=
 =?utf-8?B?a2RrSWVGeTM5OGh1aHVpSitpVjd0aGhvNGtPRDBuZlEzUGNHSkhtNUVhT3ly?=
 =?utf-8?B?cHpHcGpsdlgycEJ1RjUzN2w2WHBoUk4vSG9IRXRielNFOHB5WGZlaHFmYjJs?=
 =?utf-8?B?d2dLRGNtM3dSNVJUVEovUWc2MFZzKzNRc2tYS0pFd3c3eXdOYlFxNjFMZGhD?=
 =?utf-8?B?QmdjcXRIV2JNbzlIQXdLOHhiZmJ0SFk5UlpoVldMYUZQL0RvSVFIUzl3TlU4?=
 =?utf-8?B?cWUwWktOVFdtTWxqRzZ5RlBXT2V6dmxRSjdzOEdRN2R0MEJYU1RRWUR4dklE?=
 =?utf-8?B?T1ZJSmkyc3Fmcnh1U3l6ZUNMSFVIcGtGb0MvMU9FK01BNys5UEJieGxzME5v?=
 =?utf-8?B?U0pnM3lPbTFaZ0dGZE5QZlJrVlI3aGdRL1llMlpzdDkybHhzbVAyOFFmekxw?=
 =?utf-8?B?LzRFL2hvWXdVZk50N1IyaVNFSjNjQ3RWRkVDaEhxaW1SQVRseHBNQVNnbDJa?=
 =?utf-8?B?clpEd0dxQTZkVWRmTEJKZkhWVXhFaklETXE5MU9xU1RqS2dXQ1pVY0Z4bUMr?=
 =?utf-8?B?MFRaUURwM0tqMzVnZW5HVGtCOXlJTWpyZ054WkFzV3oyeEd4VU0xelRabVVu?=
 =?utf-8?B?VTNaNm5Ncld1OW1sVk1uNnNtUVBHWWRweWZSQzltbTVaVDRCVXJMOThJaXVV?=
 =?utf-8?B?VHZ0L1BNM1prVmo2cWxGalBoWjZhbnl0cGxCV3dZN0VtcDBhaFQ1RkZuYldy?=
 =?utf-8?B?c2IycFZkdi9wQ05tYXdQL2tDc3FLR295RjJsR2EvSzBjWi8xcVVlT0YxN3BV?=
 =?utf-8?B?OHh3RUtMUUFIeTRRdEF2alNKS2FqRVhSamxoUEhFQTRVKytIMi93RHhDRmFQ?=
 =?utf-8?B?eURoTWpaQ1RZalFkeHBvR2psY1pxaDB0bTUyYjFwenNmT01WeVFyby9XZEpv?=
 =?utf-8?B?K2V6TnZQbmhKK3ErdExRcDVIRkp3d1ZjL2M3NHZ3Yk9CVGdraXdZcENwdGR4?=
 =?utf-8?B?emRFRFFISi85L0JOR1hONU1XeHNuK3hmMFR0ak1OQkNweWtXM3k5dz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a470cd-6bcf-4a85-710d-08de786c0d23
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:57:41.8354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeJ309tO7sdwDplDxezefJEt88jsTm+bqM1AEFeRyNyFBHDZigBgqD/WNQHG+uFgFSByTEoeAUcSv9hmhRJSq+06NuZLWFA3ALB8q1PE1/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1634
Received-SPF: pass client-ip=2a01:111:f403:c214::1;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The test plugin intercepts execution in different contexts. Without the
plugin, any of the implemented test functions would trigger an assert
and fail. With the plugin, control flow is redirected to skip the assert
and return cleanly via the qemu_plugin_set_pc() API.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 MAINTAINERS                                   |   1 +
 tests/tcg/arm/Makefile.target                 |   6 +
 tests/tcg/multiarch/Makefile.target           |  17 ++-
 .../{ => plugin}/check-plugin-output.sh       |   0
 .../{ => plugin}/test-plugin-mem-access.c     |   0
 .../tcg/multiarch/plugin/test-plugin-set-pc.c | 140 ++++++++++++++++++
 tests/tcg/plugins/meson.build                 |   1 +
 tests/tcg/plugins/setpc.c                     | 120 +++++++++++++++
 8 files changed, 282 insertions(+), 3 deletions(-)
 rename tests/tcg/multiarch/{ => plugin}/check-plugin-output.sh (100%)
 rename tests/tcg/multiarch/{ => plugin}/test-plugin-mem-access.c (100%)
 create mode 100644 tests/tcg/multiarch/plugin/test-plugin-set-pc.c
 create mode 100644 tests/tcg/plugins/setpc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 606b16762c..2746ec9a0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4083,6 +4083,7 @@ S: Maintained
 F: docs/devel/tcg-plugins.rst
 F: plugins/
 F: tests/tcg/plugins/
+F: tests/tcg/multiarch/plugin/
 F: tests/functional/aarch64/test_tcg_plugins.py
 F: contrib/plugins/
 F: scripts/qemu-plugin-symbols.py
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 6189d7a0e2..613bbf0939 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -78,4 +78,10 @@ sha512-vector: sha512.c
 
 ARM_TESTS += sha512-vector
 
+ifeq ($(CONFIG_PLUGIN),y)
+# Require emitting arm32 instructions, otherwise the vCPU might accidentally
+# try to execute Thumb instructions in arm32 mode after qemu_plugin_set_pc()
+test-plugin-set-pc: CFLAGS+=-marm
+endif
+
 TESTS += $(ARM_TESTS)
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 07d0b27bdd..a347efbadf 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -14,6 +14,10 @@ ifeq ($(filter %-linux-user, $(TARGET)),$(TARGET))
 VPATH 	       += $(MULTIARCH_SRC)/linux
 MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/linux/*.c))
 endif
+ifeq ($(CONFIG_PLUGIN),y)
+VPATH 	       += $(MULTIARCH_SRC)/plugin
+MULTIARCH_SRCS += $(notdir $(wildcard $(MULTIARCH_SRC)/plugin/*.c))
+endif
 MULTIARCH_TESTS = $(MULTIARCH_SRCS:.c=)
 
 #
@@ -200,13 +204,20 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
+	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \
 	$(QEMU) $<
 run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
+run-plugin-test-plugin-set-pc-with-libsetpc.so:
 
 EXTRA_RUNS_WITH_PLUGIN += run-plugin-test-plugin-mem-access-with-libmem.so \
-			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so
-else
+			  run-plugin-test-plugin-syscall-filter-with-libsyscall.so \
+			  run-plugin-test-plugin-set-pc-with-libsetpc.so
+
+else # CONFIG_PLUGIN=n
+# Do not build the syscall skipping test if it's not tested with the setpc
+# plugin because it will simply fail the test.
+MULTIARCH_TESTS := $(filter-out test-plugin-set-pc, $(MULTIARCH_TESTS))
+
 # test-plugin-syscall-filter needs syscall plugin to succeed
 test-plugin-syscall-filter: CFLAGS+=-DSKIP
 endif
diff --git a/tests/tcg/multiarch/check-plugin-output.sh b/tests/tcg/multiarch/plugin/check-plugin-output.sh
similarity index 100%
rename from tests/tcg/multiarch/check-plugin-output.sh
rename to tests/tcg/multiarch/plugin/check-plugin-output.sh
diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg/multiarch/plugin/test-plugin-mem-access.c
similarity index 100%
rename from tests/tcg/multiarch/test-plugin-mem-access.c
rename to tests/tcg/multiarch/plugin/test-plugin-mem-access.c
diff --git a/tests/tcg/multiarch/plugin/test-plugin-set-pc.c b/tests/tcg/multiarch/plugin/test-plugin-set-pc.c
new file mode 100644
index 0000000000..40d9a9e8f0
--- /dev/null
+++ b/tests/tcg/multiarch/plugin/test-plugin-set-pc.c
@@ -0,0 +1,140 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
+ *
+ * This test set exercises the qemu_plugin_set_pc() function in four different
+ * contexts:
+ * 1. in a syscall callback,
+ * 2. in an instruction callback during normal execution,
+ * 3. in an instruction callback during signal handling,
+ * 4. in a memory access callback.
+ * Note: using the volatile guards is necessary to prevent the compiler from
+ * doing dead code elimination even on -O0, which would cause everything after
+ * the asserts and thus also the target labels to be optimized away.
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <setjmp.h>
+
+#define NOINLINE __attribute__((noinline))
+#define NORETURN __attribute__((noreturn))
+
+static int signal_handled;
+/*
+ * The volatile variable is used as a guard to prevent the compiler from
+ * optimizing away "unreachable" labels.
+ */
+static volatile uint32_t guard = 1;
+
+/*
+ * This test executes a magic syscall which communicates two addresses to the
+ * plugin via the syscall arguments. Whenever we reach the "bad" instruction
+ * during normal execution, the plugin should redirect control flow to the
+ * "good" instruction instead.
+ */
+NOINLINE void test_insn(void)
+{
+    long ret = syscall(4095, &&bad_insn, &&good_insn, NULL);
+    assert(ret == 0 && "Syscall filter did not return expected value");
+    if (guard) {
+bad_insn:
+        assert(0 && "PC redirection in instruction callback failed");
+    } else {
+good_insn:
+        return;
+    }
+}
+
+/*
+ * This signal handler communicates a "bad" and a "good" address to the plugin
+ * similar to the previous test, and skips to the "good" address when the "bad"
+ * one is reached. This serves to test whether PC redirection via
+ * qemu_plugin_set_pc() also works properly in a signal handler context.
+ */
+NOINLINE void usr1_handler(int signum)
+{
+    long ret = syscall(4095, &&bad_signal, &&good_signal, NULL);
+    assert(ret == 0 && "Syscall filter did not return expected value");
+    if (guard) {
+bad_signal:
+        assert(0 && "PC redirection in instruction callback failed");
+    } else {
+good_signal:
+        signal_handled = 1;
+        return;
+    }
+}
+
+/*
+ * This test sends a signal to the process, which should trigger the above
+ * signal handler. The signal handler should then exercise the PC redirection
+ * functionality in the context of a signal handler, which behaves a bit
+ * differently from normal execution.
+ */
+NOINLINE void test_sighandler(void)
+{
+    struct sigaction sa = {0};
+    sa.sa_handler = usr1_handler;
+    sigaction(SIGUSR1, &sa, NULL);
+    pid_t pid = getpid();
+    kill(pid, SIGUSR1);
+    assert(signal_handled == 1 && "Signal handler was not executed properly");
+}
+
+/*
+ * This test communicates a "good" address and the address of a local variable
+ * to the plugin. Upon accessing the local variable, the plugin should then
+ * redirect control flow to the "good" address via qemu_plugin_set_pc().
+ */
+NOINLINE void test_mem(void)
+{
+    long ret = syscall(4095, NULL, &&good_mem, &guard);
+    assert(ret == 0 && "Syscall filter did not return expected value");
+    if (guard) {
+        assert(0 && "PC redirection in memory access callback failed");
+    } else {
+good_mem:
+        return;
+    }
+}
+
+/*
+ * This test executes a magic syscall which is intercepted and its actual
+ * execution skipped via the qemu_plugin_set_pc() API. In a proper plugin,
+ * syscall skipping would rather be implemented via the syscall filtering
+ * callback, but we want to make sure qemu_plugin_set_pc() works in different
+ * contexts.
+ */
+NOINLINE NORETURN
+void test_syscall(void)
+{
+    syscall(4096, &&good_syscall);
+    if (guard) {
+        assert(0 && "PC redirection in syscall callback failed");
+    } else {
+good_syscall:
+        /*
+         * Note: we execute this test last and exit straight from here because
+         * when the plugin redirects control flow upon syscall, the stack frame
+         * for the syscall function (and potential other functions in the call
+         * chain in libc) is still live and the stack is not unwound properly.
+         * Thus, returning from here is risky and breaks on some architectures,
+         * so we just exit directly from this test.
+         */
+        _exit(EXIT_SUCCESS);
+    }
+}
+
+
+int main(int argc, char *argv[])
+{
+    test_insn();
+    test_sighandler();
+    test_mem();
+    test_syscall();
+}
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index c5e49753fd..b3e3a9a6d0 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -7,6 +7,7 @@ test_plugins = [
 'mem.c',
 'patch.c',
 'reset.c',
+'setpc.c',
 'syscall.c',
 ]
 
diff --git a/tests/tcg/plugins/setpc.c b/tests/tcg/plugins/setpc.c
new file mode 100644
index 0000000000..72ae31a0ef
--- /dev/null
+++ b/tests/tcg/plugins/setpc.c
@@ -0,0 +1,120 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
+ */
+#include <assert.h>
+#include <glib.h>
+#include <inttypes.h>
+#include <unistd.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+static uint64_t source_pc;
+static uint64_t target_pc;
+static uint64_t target_vaddr;
+
+static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
+                         int64_t num, uint64_t a1, uint64_t a2,
+                         uint64_t a3, uint64_t a4, uint64_t a5,
+                         uint64_t a6, uint64_t a7, uint64_t a8)
+{
+    if (num == 4096) {
+        qemu_plugin_outs("Marker syscall detected, jump to clean return\n");
+        qemu_plugin_set_pc(a1);
+    }
+}
+
+static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
+                                int64_t num, uint64_t a1, uint64_t a2,
+                                uint64_t a3, uint64_t a4, uint64_t a5,
+                                uint64_t a6, uint64_t a7, uint64_t a8,
+                                uint64_t *sysret)
+{
+    if (num == 4095) {
+        qemu_plugin_outs("Communication syscall detected, set target_pc / "
+                         "target_vaddr\n");
+        source_pc = a1;
+        target_pc = a2;
+        target_vaddr = a3;
+        if (source_pc >> 63 || target_pc >> 63 || target_vaddr >> 63) {
+            /*
+             * Some architectures (e.g., m68k) use 32-bit addresses with the
+             * top bit set, which causes them to get sign-extended somewhere in
+             * the chain to this callback. We mask the top bits off here to get
+             * the actual addresses.
+             */
+            qemu_plugin_outs("High bit in addresses detected: possible sign "
+                             "extension in syscall, masking off top bits\n");
+            source_pc &= UINT32_MAX;
+            target_pc &= UINT32_MAX;
+            target_vaddr &= UINT32_MAX;
+        }
+        *sysret = 0;
+        return true;
+    }
+    return false;
+}
+
+static void vcpu_insn_exec(unsigned int vcpu_index, void *userdata)
+{
+    uint64_t vaddr = (uint64_t)userdata;
+    if (vaddr == source_pc) {
+        g_assert(target_pc != 0);
+        g_assert(target_vaddr == 0);
+
+        qemu_plugin_outs("Marker instruction detected, jump to clean return\n");
+        qemu_plugin_set_pc(target_pc);
+    }
+}
+
+static void vcpu_mem_access(unsigned int vcpu_index,
+                            qemu_plugin_meminfo_t info,
+                            uint64_t vaddr, void *userdata)
+{
+    if (vaddr != 0 && vaddr == target_vaddr) {
+        g_assert(source_pc == 0);
+        g_assert(target_pc != 0);
+        qemu_plugin_mem_value val = qemu_plugin_mem_get_value(info);
+        /* target_vaddr points to our volatile guard ==> should always be 1 */
+        g_assert(val.type == QEMU_PLUGIN_MEM_VALUE_U32);
+        g_assert(val.data.u32 == 1);
+
+        qemu_plugin_outs("Marker mem access detected, jump to clean return\n");
+        qemu_plugin_set_pc(target_pc);
+    }
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    size_t insns = qemu_plugin_tb_n_insns(tb);
+    for (size_t i = 0; i < insns; i++) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
+        uint64_t insn_vaddr = qemu_plugin_insn_vaddr(insn);
+        /*
+         * Note: we cannot only register the callbacks if the instruction is
+         * in one of the functions of interest, because symbol lookup for
+         * filtering does not work for all architectures (e.g., ppc64).
+         */
+        qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
+                                               QEMU_PLUGIN_CB_RW_REGS_PC,
+                                               (void *)insn_vaddr);
+        qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem_access,
+                                         QEMU_PLUGIN_CB_RW_REGS_PC,
+                                         QEMU_PLUGIN_MEM_R, NULL);
+    }
+}
+
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+
+    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    return 0;
+}
-- 
2.53.0

