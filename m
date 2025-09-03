Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07276CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkX7-0008Tf-CV; Wed, 03 Sep 2025 06:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkX5-0008SO-LT
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:16:03 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkX1-0002gM-HF
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:16:03 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b03fa5c5a89so616287266b.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894554; x=1757499354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XUv2o7XYM3Yj8bVioCcShOQTzM/BJdBEyBoIR/9VMY=;
 b=JsWw1Sy3k410x3zRvV4ucOhTg5djPkmphhnE+pB0iO3D1UApSYR/RyxuYEu4gOHHt7
 vS3SL/lxZAD6aOE+hC3stSzIAhrKO0Vm52QJSPE4MSSRey5STJhqy10cDY4uq8Unyk1o
 rdrsk/qyq228EVABu7HBtXfeS/ptEdGozjjYekmTYhvgugxmme/D2eqU1O2FAnHPIMd/
 ffrvlH/9C3P2W2sDmD70PlPTC4gxg3AAwJP/UFJYGLkZ/n532QNTKdZG0FIZL9+HL2BT
 ETFXNv23vJL9ZZSCU44ooja8aDD3dC9RdKqTnMWZY848a/CXhpSj5XyAUKguHW7ckykk
 NXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894554; x=1757499354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XUv2o7XYM3Yj8bVioCcShOQTzM/BJdBEyBoIR/9VMY=;
 b=gAOJyg0s3IlUrI3GqptI+TsPgmY68IM2ZvOSJbx6BsE5JbxXzWx50tOKtMlVxVMD8p
 MH86l+rezpnJrIULGdg4rSS29MPCKskZsPJ1Xiu6A+cEQ1tBblmZF4reV6QYt12Doah4
 262bebIMQRErEEnkDyqE3fNSkNQ5DEAkf5dlDWVrf8F/6yUWz1Le5XougCbh1GvidC3o
 vi0GAEWcOo+ZEEa70iisVF5/4CFMdgzHbTVDINXkqj7TapUYV/WKsNJXXSyFLE/fVv9k
 SQyAQhB6QNq0dHeNV/B4ETOehqQm84bH5XKF2UzJ7r/WvNPGh9Kdb2sKkCRtlrj5FAkH
 KiEw==
X-Gm-Message-State: AOJu0Yw52Dvn2ycQ9pzXB3TNWn6NOhVXVmIhoH66QzY0hknwcuj8FvCZ
 T9qMjeGlDBzAGf/X4YMnOB+eoztAy58yrUO0e+LJ/XfHEE+4ih6b4oD+iHrUR1R48yd2XCia3Ee
 YtBp8sC4=
X-Gm-Gg: ASbGncvNSvwxbccpUvHd62DMLAEs9A0SbqF0i7YvY0EsJGrRTp9wb5l5NvmdkYgZzJ2
 FuxxAP9mdNM1NtIBy5RWxDEQq0UpfoVMQaJ3L1/jxTa8gltXypyIryIBGv9hVPSfyvDMGkj4nOD
 Shh8Y+WzmTmiCbGue9lpRABoBAISRIBABgwW8btjQ3F8jYmXIG5r1JzIv2/dEI12iSFzXYnZotp
 07nXWDadpFF4DgR9sah4JrMCwZsOLKuKTf6PEjKkxbf0s6GDB/lOQ0B5FPMHcNdZi4D6uEqwypl
 ssi9sZ82KvcBCdNum6CONPvBkEsZtwOeBMk4NEBTnUm2e1FehDM9PT4ClYSg4Z6zkqucMR+FXeI
 eA3cGoHQNHuwdM1QTXHCsJjHln7LEx1a91kkHzorNmTAkWYI4c3kn3T09fqYzsMsGM4je85jGbS
 ZJMLaoPQ==
X-Google-Smtp-Source: AGHT+IGKdrRh3wKSM6O6crTgtfB53HxsgLd5T4oN7jiPq7tKuTmdzD00tnwfs9knYbfO/yzbvm349A==
X-Received: by 2002:a05:6000:2585:b0:3df:58c5:ef94 with SMTP id
 ffacd0b85a97d-3df58c6025emr765309f8f.40.1756894127917; 
 Wed, 03 Sep 2025 03:08:47 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d701622b92sm11754594f8f.58.2025.09.03.03.08.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:08:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 10/24] target/arm/hvf: Mention hvf_arch_set_traps() must run
 on vCPU thread
Date: Wed,  3 Sep 2025 12:06:46 +0200
Message-ID: <20250903100702.16726-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since hvf_arch_set_traps() calls hv_vcpu_set_trap_debug_exceptions()
and hv_vcpu_set_trap_debug_reg_accesses(), which must run on a vCPU,
it also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a7e4b869b04..a9793060579 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2317,6 +2317,7 @@ static inline bool hvf_arm_hw_debug_active(CPUState *cpu)
     return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
 }
 
+/* Must be called by the owning thread */
 static void hvf_arch_set_traps(CPUState *cpu)
 {
     bool should_enable_traps = false;
-- 
2.51.0


