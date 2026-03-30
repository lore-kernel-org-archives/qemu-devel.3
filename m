Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D211061B0A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 15:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7EKA-0006Hj-VC; Mon, 30 Mar 2026 11:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7EK9-0006HM-KT
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:14:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7EK8-0002WL-04
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 11:14:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-487012ce896so28358785e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774883678; x=1775488478; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rDe9mceskDtU6tRQQCH8dZM09+QgHTJN3mHBBgRHyng=;
 b=wfKquJCbg2qe/HUNfbJiJycMyk1eHfNL8YWcmftMq1pi5gHs1E8aqmkP2V54XO/ZqX
 ow9p41nmcdTOYJzkVj0zHx99cwcx8FBO359qExGRZHdEBG66pNTmrB5P/uNzsHi/vlCy
 s6LTwSA8ZlSj5Op2Z/8T4StTwmor3mBJd4Fce8WnjZayS2gINLnXDCqkl5un6jF5xmE4
 ml2wVPyNJwRy7d8l9IvEv6+28cJ/6Q8J6AfBpdqo8WxMuNwvuergSs7boYGRFh5tjetr
 CDz5ox9Ep5aF7vh9HPnMP1QSpznngH4io+hUkEnP/2z9g5YNOa5nSToMDPHdjY1Za76Z
 BwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774883678; x=1775488478;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDe9mceskDtU6tRQQCH8dZM09+QgHTJN3mHBBgRHyng=;
 b=feX+UEnK3PSjRZYucbbLMmaAcL44ecqO7XpHZFSFaCb133BNeD6Pjvs1WNgd47liGU
 kln2nKsm2qpxlBTbjoxiEjyXFHrgRs7GO6vYrgMktUn7JO3ZevXbthMUHI/0rH1LXDKv
 SAX5cmi0BUefWM/8PSxWPbyfzxrIGkWhR6c0h1wUx9O7c/FUaC3wRDGmQu+PclVPFbkt
 I06h4kZw0vVA8Un1/lNVJdGMO7lxocKcx2FfFG97GDITjpI4MI62J3YAqPMx5+IC4Wy2
 gU9XZWGLdbxZRXWbNUI7Hyc2Y7EtCMxVz1FpuvZndMWbi77NSlGMRMCUuauh8GCVJZ7B
 +a9Q==
X-Gm-Message-State: AOJu0YzhYZHz25VJExqgfgTwIjqfAIOfQhHf5RFVgKc6BKJR/7XqRg7c
 C9CpZSd5dlqrt9HDlu/v6T9QtRJpNKDOKmWUA32WXkT5mga1OWRe93yz8jDE0sc3f1yd2XTioE5
 zIQWztxQ=
X-Gm-Gg: ATEYQzyo0q3RTCDjQx7/V+cOiTOMp8t70hTR6+lZo4rdDx+sPC6b5v/VAVEXnk22rxx
 YapVwftj+Yog+h3A5kUXMWEXgj3jSEXt57BP3koJjhssyq8kqKNBltj33gmGk100Lo2NwlJQgct
 LAUgxA69G/oicKCIOEAJAFyesJ+Bf/ftHHI9Zvcr1MSZ/JkWuHsn0hNkAMeCjw6aFHYKTvPoEMK
 bf59aFnuinzeTbPSggjrIIzfWPGp2e8G23BEg7BAS7w3X57DIacaPWFLyoSGdfLXRPh0TanCBCZ
 lP3HUxql1Y7w/zSmif9DDJD+DEvmZqCJ3IaqwiPbGdlzbj2EwGBgPe0GW6J8zeGZ5Hmv5A4gfcQ
 u1GQcF1ZMk9Njnz5kdQVnRJnklawQlKuJzwyLzSdp79AaxR0fW5v/9woKe6/+cgS99UUpSlVZXD
 CVCWas4HecpXd4li3YJhq5/Bx11YMpMpIsocq78ozj/ga05NRcYiMKRtdSk02Q8f2ctQgbt2qQv
 ALxdad14nM4vvnHId4VZpjMkwEOZnU=
X-Received: by 2002:a05:600c:c178:b0:487:59c:2bb8 with SMTP id
 5b1f17b1804b1-48727ef16bamr220414415e9.27.1774883678453; 
 Mon, 30 Mar 2026 08:14:38 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c9506dsm274817715e9.7.2026.03.30.08.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 08:14:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH] target/i386: Treat qtest like TCG for supported-features
Date: Mon, 30 Mar 2026 16:14:37 +0100
Message-ID: <20260330151437.1787008-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

In x86_cpu_get_supported_feature_word() we figure out the supported
features differently for each accelerator. The default case is
"set all feature bits"; however this triggers a warning because
it enables two features which conflict with each other:

$ ./build/x86/qemu-system-x86_64   -cpu max -accel qtest -S
qemu-system-x86_64: warning: this feature conflicts with APX: CPUID[eax=07h,ecx=00h].EBX.mpx [bit 14]
qemu-system-x86_64: warning: this feature conflicts with MPX: CPUID[eax=07h,ecx=01h].EDX.apxf [bit 21]

Treat qtest like TCG here, to avoid the complaint.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This suggests to me that the default case is not something
we ever want to be in, and we should instead be exhaustively
enumerating the accelerators and asserting if we don't know
how to handle this for the accelerator in use. But there are
several accelerators that we don't have code for here...
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3b0a7c7363..c6fd1dc00e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8087,7 +8087,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w)
         r = hvf_get_supported_cpuid(wi->cpuid.eax,
                                     wi->cpuid.ecx,
                                     wi->cpuid.reg);
-    } else if (tcg_enabled()) {
+    } else if (tcg_enabled() || qtest_enabled()) {
         r = wi->tcg_features;
     } else {
         return ~0;
-- 
2.43.0


