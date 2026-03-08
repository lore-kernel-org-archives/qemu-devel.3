Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCBB8EA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMi6-0007ee-Ob; Sun, 08 Mar 2026 18:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMi4-0007du-GI
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:34:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMi2-00033c-Rh
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:34:52 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so127841245e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009289; x=1773614089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8eQ2jsUndrGbrbiy4u8g+gyu8EistUvOdyha5m9ALGc=;
 b=xBoVpFwUcXjAUVxVUgGXmaEp+BzC0plD12wstD7C6VbYwbxAT74aBu8xozPsI86KhM
 43h1jbpPr/LzyoNq/A579Et94Bv81qKLb5zmcpv/syktQCdrYzpLkog5TyW5dXWJGxd8
 ekgESmV3PFvv1SA08iuQwOUMqFwH2rBC4QWy1jLxxgI6GwSrlteF78muWAdz7T+bIFQS
 tuBpz2uhs8SnxsFo6XqCkGWE9zsvQTSalhDhwdvSNxZ+nk9Tk4nEV1GJ7mcoVQJfeMaf
 ko7FDzXrTdqyplCq1pRIkBwEaR+jmfVR7KVFXX0tQi5ALaNSsAXPzXTfwas1ZESNctsc
 M/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009289; x=1773614089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8eQ2jsUndrGbrbiy4u8g+gyu8EistUvOdyha5m9ALGc=;
 b=mAJdLVweIfhwMTjGbxvCbDv7idOvOB65NTB47V1Tf6eGIWR1D/xSJmn37e2wZELu+n
 hxutZLf49NRe/ChW/CgF44ZLOt2u5gokM6OsiYtnS2ZCtkd0KuhekG72QUbEyv2W0Qpq
 wgGo8LIVz/2T90aMS2XHuFyRla9H369H8kY3rjmsCJEkWwuAQU91G6BDyghbavy3Nb3k
 YXS7OIeXbpkfGgcofRjySup/kufxKcgVWH2o/rG+V23IBZyyYNHvO5gRt0xec76vO5Zn
 /MCjTnV5v9F/KOStA9JOledue16fYGXfsXjLqRyZJwk2UkVINbdE1ifOBitPx+0Zel1R
 klag==
X-Gm-Message-State: AOJu0Yy2x9H2HoYgS/8OVmiun3oxrV5KtDQCo7dzeuW4Cx5VxevSINF/
 sXRYh9Ilv8yoxgvORWBRjos+q0xonyloah1WnUjtbU7mb76wKM/yxFHhViwenyQBlO4LeDBW/O7
 wRcdlZTA=
X-Gm-Gg: ATEYQzxBWzwO7356AKeaKORxYFNOJ+6/ri0Bu6/gI8tb31V+6dhx4htSSPpBEb+NOu0
 Yk139CfhyCRRQ0KRDj7nCRr5P6LL5DNSgqyllRgXSgmnw6HyU9h4n1E1OLMvOviW7CGKqHG3FTr
 9OtrbFlHONA7Px8ub6qYvBOoOor7ymL4GBDZ2WIQD7z9rwO+ksbviuzYSmpdgKROd8sOcqFbcKw
 F1HpUwQ55nowkKzM9PIKAjJXETcmV1hzcwSb06VV7vgCQYUXc8MhVi6GK/aVpCPG064g7gG0oEr
 np29zhS0NLW/SyQ6Ru63rPeldiCr4OzmQESS6G/oYl9eegwi1aa/a5WC7qz3TO7Q/pc+572IA96
 tJH2jQ1sIWHctAYiR7BXlhwH2cKS6iqAfcVZfTYxlbD8BoSEbhSHg72sMkIfVnNJV20f8Io/OiZ
 aj+7WVHXtA9pxJC9hLdFTFgprNOHO/EaZaJjhE6mIMxOUklZpSG8mlfOLFUaHA+f9hD54MHurS0
 Rtf8g==
X-Received: by 2002:a05:600c:a013:b0:485:17a7:b9cc with SMTP id
 5b1f17b1804b1-48526958835mr148689045e9.18.1773009288980; 
 Sun, 08 Mar 2026 15:34:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fad27e6sm300901875e9.3.2026.03.08.15.34.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:34:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/49] hw/i386/pc: Remove pc_compat_3_0[] array
Date: Sun,  8 Mar 2026 23:33:46 +0100
Message-ID: <20260308223433.25503-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
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

The pc_compat_3_0[] array was only used by the pc-q35-3.0
and pc-i440fx-3.0 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307150042.78030-3-philmd@linaro.org>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 7 -------
 2 files changed, 10 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 113813c07d7..5623660f5dd 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -277,9 +277,6 @@ extern const size_t pc_compat_4_0_len;
 extern GlobalProperty pc_compat_3_1[];
 extern const size_t pc_compat_3_1_len;
 
-extern GlobalProperty pc_compat_3_0[];
-extern const size_t pc_compat_3_0_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 819e729a6e3..a38634e3577 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -214,13 +214,6 @@ GlobalProperty pc_compat_3_1[] = {
 };
 const size_t pc_compat_3_1_len = G_N_ELEMENTS(pc_compat_3_1);
 
-GlobalProperty pc_compat_3_0[] = {
-    { TYPE_X86_CPU, "x-hv-synic-kvm-only", "on" },
-    { "Skylake-Server" "-" TYPE_X86_CPU, "pku", "off" },
-    { "Skylake-Server-IBRS" "-" TYPE_X86_CPU, "pku", "off" },
-};
-const size_t pc_compat_3_0_len = G_N_ELEMENTS(pc_compat_3_0);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.53.0


