Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F92F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcut-0003so-7l; Mon, 09 Mar 2026 11:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcuo-0003fI-QN
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:07 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcun-0008Aj-7j
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:06 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48534237460so18200765e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071582; x=1773676382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1Uao/CKWcfJ+UFrA+3AmPlD8nKqx8My4/8hpgD51tDU=;
 b=eRDOXr1SP3uMSoDwnvKAo2Lp2lQQVqE0Zz+1bp3YD1pXwUEN1PFpPANZ7804giyam6
 RRGo3tlRKZa1BIFOyNOeP6UL1yla0ocPVyz0cgMUbFXwXk+YrFOcPHfWqCdRWKnhA+Ku
 fAgrqeQgrppesfn/0e/RHpYAtmJUHoLA1ce3QglUKHYEjgP8zDtRSL/mUYR+FzQBuYVv
 sIAPJ/w01FMnLL0KGf5crQt1V0IfBmUo4bFJW15fyxSkAD1pi/IPVI12B4UG7FlEO5Vw
 BfpIdoUkhfqjFqV3tFnPs11shdCD6+lOzf+253XUTj7mQYej5qdMpO8dZad9er3zkk2i
 UhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071582; x=1773676382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1Uao/CKWcfJ+UFrA+3AmPlD8nKqx8My4/8hpgD51tDU=;
 b=riPL10ze7zKW5WLpgIzJKGs5M3LThRnSGoKRTRXZRS8lIczkSi7noSpx3i/RA8aX5h
 QIAbunf/z9pJ3KPHR4tY/lunDXyYB16xGwxTbl+n389zribzf841AWhuT0mTJ05UhNZ9
 ryd+6iwVmeLgODHGkFh5ajclsWiR0eWF45DRZIWP/dlubW/C6wf+9GC8KErPRttvaNs8
 kWjtiqnQLO7IgjBvfb2Uge3muPFKDtF3RaixVNZo/sHRPchgLUzvsb/k2tfnyIUQGUDZ
 Pqs4ZYLWVlWUi0mglKeCYa9XvNnht/7wDdGWdBoIDDhyd+ubc76wZ5ZJF6B2NERDRv8W
 0KYg==
X-Gm-Message-State: AOJu0YzG632hRQPAEgcB+Bwyd2oeUddHG9AgLZOiW/GOwnMfalvVQb9R
 YKjMpqFO+vod0ZIDGUFL5NAP03a88TxHal5jymJlYZk3yzeTXH5648nw29hHqa7FDA3t0l2mvt0
 sC8ryJjw=
X-Gm-Gg: ATEYQzyBrLAk6aYalbs467wuR9/K9HJUJuG7k1N9mdo821ZJjjOvpHf7Uy8i40eCjme
 NOm3erYUa107Q+iye9hBolRSDlf9jaYjmjw6rZ/cvBj4tRkIoReL1L4N0lZP+RufFt0mr7E83VN
 +GyzjjsgotuNN2LaiYwCbK6MU1H4rhosg5MsdNJY0oMSJL6mLEBbsBOsAbhxXEEZGWbXNBb0fOV
 5pEuGDBpGZkO1KbCpYwM64CfN6vU8DloqEsLqWKNLHNwBN+p/xQ5LZrhPa3CYpKXsfzY25UwV7h
 HwoIJAGxLfpoDnvcKiAJFilrKGIT8ABynQ7IEKXfNt/CoU5U7K/boZaCC69yJt4xEbuyG4RAVyZ
 LFboPqXpqAwF5PefGemLDsOVrBg8SqUSqcNMEjfQjTPAJDF8KmEsWt5O3kB0dZlufxQbWegeJRQ
 1+gnu05bJoPJaVGbp+3myc774PdG/oHe7z4Itlkyg+COgj1JtpR2+HQA96YELmFKwGtdJnTWDs
X-Received: by 2002:a05:600c:3b17:b0:483:7903:c3b1 with SMTP id
 5b1f17b1804b1-4852695aeb9mr186807515e9.20.1773071582512; 
 Mon, 09 Mar 2026 08:53:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853a59fc36sm195786325e9.9.2026.03.09.08.53.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:53:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/49] hw/i386/pc: Remove pc_compat_3_1[] array
Date: Mon,  9 Mar 2026 16:51:36 +0100
Message-ID: <20260309155219.62400-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The pc_compat_3_1[] array was only used by the pc-q35-3.1
and pc-i440fx-3.1 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307152635.83893-6-philmd@linaro.org>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/pc.c         | 25 -------------------------
 2 files changed, 28 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 908de5e1eab..4e1dd436ab7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -271,9 +271,6 @@ extern const size_t pc_compat_4_1_len;
 extern GlobalProperty pc_compat_4_0[];
 extern const size_t pc_compat_4_0_len;
 
-extern GlobalProperty pc_compat_3_1[];
-extern const size_t pc_compat_3_1_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 00581dd8b44..f33e3f72656 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -180,31 +180,6 @@ const size_t pc_compat_4_1_len = G_N_ELEMENTS(pc_compat_4_1);
 GlobalProperty pc_compat_4_0[] = {};
 const size_t pc_compat_4_0_len = G_N_ELEMENTS(pc_compat_4_0);
 
-GlobalProperty pc_compat_3_1[] = {
-    { "intel-iommu", "dma-drain", "off" },
-    { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "off" },
-    { "Opteron_G4" "-" TYPE_X86_CPU, "rdtscp", "off" },
-    { "Opteron_G4" "-" TYPE_X86_CPU, "npt", "off" },
-    { "Opteron_G4" "-" TYPE_X86_CPU, "nrip-save", "off" },
-    { "Opteron_G5" "-" TYPE_X86_CPU, "rdtscp", "off" },
-    { "Opteron_G5" "-" TYPE_X86_CPU, "npt", "off" },
-    { "Opteron_G5" "-" TYPE_X86_CPU, "nrip-save", "off" },
-    { "EPYC" "-" TYPE_X86_CPU, "npt", "off" },
-    { "EPYC" "-" TYPE_X86_CPU, "nrip-save", "off" },
-    { "EPYC-IBPB" "-" TYPE_X86_CPU, "npt", "off" },
-    { "EPYC-IBPB" "-" TYPE_X86_CPU, "nrip-save", "off" },
-    { "Skylake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
-    { "Skylake-Client-IBRS" "-" TYPE_X86_CPU, "mpx", "on" },
-    { "Skylake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
-    { "Skylake-Server-IBRS" "-" TYPE_X86_CPU, "mpx", "on" },
-    { "Cascadelake-Server" "-" TYPE_X86_CPU,  "mpx", "on" },
-    { "Icelake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
-    { "Icelake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
-    { "Cascadelake-Server" "-" TYPE_X86_CPU, "stepping", "5" },
-    { TYPE_X86_CPU, "x-intel-pt-auto-level", "off" },
-};
-const size_t pc_compat_3_1_len = G_N_ELEMENTS(pc_compat_3_1);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.53.0


