Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086D8C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 08:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbbsU-0000JT-1n; Wed, 07 Aug 2024 04:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1sbbsO-0000Hg-Js
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:18:32 -0400
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin@zytor.com>) id 1sbbsM-0006ug-HZ
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:18:32 -0400
Received: from terminus.zytor.com (terminus.zytor.com
 [IPv6:2607:7c80:54:3:0:0:0:136]) (authenticated bits=0)
 by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4778IDpg735187
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
 Wed, 7 Aug 2024 01:18:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4778IDpg735187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2024071601; t=1723018698;
 bh=EOqBLubJw/7uH1jzE2oM60mOC+Vpg7yytT9MIukUwio=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FGgfm22Zyqc7Xt/cCdycWRchwzr+/6Pb2R1bnyWAlzygeorN7rDYVwPYKeb9NmV5k
 RrP9szGswvjaWAYAolNdkKs4odIqMCn2m4Vae9vfKUfUOhO8hnmdd9OeCAiMVP8uG8
 vmb4A8F8HlKomKPXcPrtzJUNvVJplUZxf0bWloaVstCuQXA7rGCNLfffuUR0r5BNLu
 jOFKPVNTbJZ/Dh9DEmNKGSoMvVmyC12tegVnv6Sukn588R1AuQFgXBh2rkASEvGXt0
 PXX5suiINPt3xcNWxZOS6PMtmGqUUamxjSUydcOB8IUKtU+5dKOBYwhFtT5BLBYS9+
 glGw8sV/2bmfg==
From: "Xin Li (Intel)" <xin@zytor.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, lei4.wang@intel.com,
 zhao1.liu@intel.com, xin3.li@intel.com
Subject: [PATCH v1 2/3] target/i386: Add VMX control bits for nested FRED
 support
Date: Wed,  7 Aug 2024 01:18:11 -0700
Message-ID: <20240807081813.735158-3-xin@zytor.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807081813.735158-1-xin@zytor.com>
References: <20240807081813.735158-1-xin@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:7c80:54:3::138; envelope-from=xin@zytor.com;
 helo=mail.zytor.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add definitions of
  1) VM-exit activate secondary controls bit
  2) VM-entry load FRED bit
which are required to enable nested FRED.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 85ef7452c0..31f287cae0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1435,7 +1435,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "vmx-exit-save-efer", "vmx-exit-load-efer",
                 "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
             NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
-            NULL, "vmx-exit-load-pkrs", NULL, NULL,
+            NULL, "vmx-exit-load-pkrs", NULL, "vmx-exit-secondary-ctls",
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
@@ -1450,7 +1450,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "vmx-entry-ia32e-mode", NULL, NULL,
             NULL, "vmx-entry-load-perf-global-ctrl", "vmx-entry-load-pat", "vmx-entry-load-efer",
             "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl", NULL,
-            NULL, NULL, "vmx-entry-load-pkrs", NULL,
+            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-- 
2.45.2


