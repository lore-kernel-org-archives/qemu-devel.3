Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23462FCB602
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytYy-0005Np-04; Sat, 07 Mar 2026 10:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytYw-0005In-4p
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:30 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytYu-000878-IO
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:29 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439b7c2788dso4740778f8f.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772897246; x=1773502046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WHfk4tegfEqAizkt/EcVWOA+WVc3XLIBmbGzuDnS9gI=;
 b=V+xUljdb7SAYLESiT15DhT1D8OJyPvEhS8ipXH9QaTnvEt3zdZ3lUMOTysprvUdEB2
 1vxtdTuQgk6e7W+EEsxYn6cFhbkkoXYHTtKS+YtYa1MoLMgPQNwsPvIvLV7y5/Z6dObn
 mYY4UseK8KVs4pUSmkqZciu0WDEYlwb6aOkmxzPkjI3cWFTotjpX/0PEl/fiBJOY/Ozg
 mliZMsc5cTqUcGH5et7Mb2mayhn/hdqTBSDS7/ujSBrK10PBLh6T/JfFJItFDnD5yt19
 gMziAElxvzVHG83p+RsGxaLWNm0K6RjhTqZUerIw2M8Ju/5xPlRENnepzcTuClkdf+kN
 x2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772897246; x=1773502046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WHfk4tegfEqAizkt/EcVWOA+WVc3XLIBmbGzuDnS9gI=;
 b=ZTF44VLxDyiKQ5e5CEUOFFKKZJDNi/ZhMvE1mT5HZuNx+RN0ma7hP1aMkhf/Busaxa
 v3xZHmS12/5iQ+lP9ddv4l0vveO3imu/Oy4joYwZazqcbn3eJUsiAbkCUnzWq1RwGf2s
 Z8vHAZnxZkN6CEMalwQlR52NgNL+XNluZZ2GkSPfLphMQMIEQ07OS/wzwthXg/lQS8T4
 HBFTcrvR42wx0yTth5Xy0VOj4VWL2evRWzrMgQGXKt1bHBGYVoVlwlJZPJN+D57uqPgr
 223yed9E0uDAOaOQ2hhPGmS6WiNzxM6kgT6PFH0qyYDHvvejPMOIZB4okNRw8Zep6HBB
 7zLg==
X-Gm-Message-State: AOJu0Yz1zXy8smrC7S4KXyPuzCo8m/cLZcE7zobUb3VosUGb0UiBYBY8
 R3dTN09wACn7ITFEf9Vl9xnCmvJP2jZyOPAzY3J6+5x1r2HcXKjHtq5z8dzx+akGaujDiObnri6
 LmsToaO8=
X-Gm-Gg: ATEYQzwG4OnYFkmtS0QS6xzwh/pUQv62csiDdl+SSIBJZWty7A6ru3pHzq8XDcIamBx
 ysJPl+hNTwCEzdb1u0MjHDrhhsl3/lr80hzus1w2IHZNkzGyKLEEJBdXMvSjYW2TQlR2ew4PY8e
 +oWFgI+eG1sEFFYpSnbHOgYiANDj10/9h6aT4yOFkaweSclcfquiGDXlxtQQDXBrJ8MXbDGRUl5
 7OKPFgdq52BW0u4a3MUAUowBz/B0mQzhp/MVgyUjhRT6YCRj/WxPux9JU0ybYEJsxmxmUjomHpK
 djXO/VBniHitZ5c4mtXSGssNwaZh1t3CRIYH7he/8dRSAspYa8uQ02j5sbcFCcuVZvCEIfiE3OQ
 vIMN4L+mlbZA36AoIAisZ0Wp1y+ojVQaYRPJtNjrEJywxL0s+7G8PEdMWE+k1U1mGJ6b1Jl1oXL
 uJjgcH9h9Th+fI1myRHMDlkhGawh9vk02KZCPp4nE/Dv9plThRhIVr8o26dJh8NgsvGA1bKVh1V
 D7RD/YO6ak=
X-Received: by 2002:a05:600c:c87:b0:477:54f9:6ac2 with SMTP id
 5b1f17b1804b1-485268bd533mr102571425e9.0.1772897246458; 
 Sat, 07 Mar 2026 07:27:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852e38c013sm108804195e9.8.2026.03.07.07.27.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:27:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 07/10] target/i386/cpu: Remove X86CPU::intel_pt_auto_level
 field
Date: Sat,  7 Mar 2026 16:26:31 +0100
Message-ID: <20260307152635.83893-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307152635.83893-1-philmd@linaro.org>
References: <20260307152635.83893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The X86CPU::intel_pt_auto_level boolean was only set in the
pc_compat_3_1[] array, via the 'x-intel-pt-auto-level=off'
property. We removed all machines using that array, lets remove
that property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.h | 3 ---
 target/i386/cpu.c | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2b70d56e9b0..5a62aa61579 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2457,9 +2457,6 @@ struct ArchCPU {
     /* Only advertise TOPOEXT features that AMD defines */
     bool amd_topoext_features_only;
 
-    /* Enable auto level-increase for Intel Processor Trace leave */
-    bool intel_pt_auto_level;
-
     /* if true fill the top bits of the MTRR_PHYSMASKn variable range */
     bool fill_mtrr_mask;
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c77addd2c25..d8cd0d81d7f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9565,13 +9565,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 
     /* Intel Processor Trace requires CPUID[0x14] */
     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT)) {
-        if (cpu->intel_pt_auto_level) {
             x86_cpu_adjust_level(cpu, &cpu->env.cpuid_min_level, 0x14);
-        } else if (cpu->env.cpuid_min_level < 0x14) {
-            mark_unavailable_features(cpu, FEAT_7_0_EBX,
-                CPUID_7_0_EBX_INTEL_PT,
-                "Intel PT need CPUID leaf 0x14, please set by \"-cpu ...,intel-pt=on,min-level=0x14\"");
-        }
     }
 
     /*
@@ -10589,8 +10583,6 @@ static const Property x86_cpu_properties[] = {
      * to the specific Windows version being used."
      */
     DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1),
-    DEFINE_PROP_BOOL("x-intel-pt-auto-level", X86CPU, intel_pt_auto_level,
-                     true),
     DEFINE_PROP_BOOL("x-l1-cache-per-thread", X86CPU, l1_cache_per_core, true),
     DEFINE_PROP_BOOL("x-force-cpuid-0x1f", X86CPU, force_cpuid_0x1f, false),
 
-- 
2.52.0


