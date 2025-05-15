Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B3CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVmt-0004KO-HK; Thu, 15 May 2025 06:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmr-0004JZ-DA
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:01 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmp-00087T-Gh
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:01 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so8013265e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304758; x=1747909558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q1yE9IE70+v4hZl3qoJgdI0L4GqLSUpkP/8flgn4noI=;
 b=yGJVnTInvsd8dIPAakjKgOBhjgBWrkHf7RrdiW3toM1YBD0w/x942Y3q3cKRKMdpFb
 toJfoU43/dwJrFoG/CxiCOR/diVrNfyWaT1kF7ZN+wr0NginrMjU3MEdevaolrfpxJIm
 wJt36fKIGZLJhWKluLUCJxFBB8AgrCVTKbda/og94uFe6OpD95xYOZsLWSHtgFfrckaY
 C1verJ1cyP8RQi0U+aFDS40kNqe6zpMoQBDE/p3caDBJYRmWNLemZa5/UQ63Y6f0JLOE
 4byiHdg+Kg3Hkk8t81+Pzmt3u5r39mw5LMr/AAMmlO0H4ko/oJutmgJZ0Zrb6ZBXYph5
 ytPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304758; x=1747909558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1yE9IE70+v4hZl3qoJgdI0L4GqLSUpkP/8flgn4noI=;
 b=J+HOPqDN8qSFwWTa3rnpPWnHTqds0ALB4p5wlgUeCcj1MwrNSLR8rfGpDPOfVFrbYM
 Ln/emWWQ01Y0qXD/KFWPQxDAF6H61TKoe4r56x74yjw+rodJaQHiqOLKag1xtNZDrPMH
 ogZ/frIzAShBDJRuVv1RC61ZaitMp3coz1k0zdbDif4U3v0slsbVZ6QhpTg8WWOhHVYJ
 UFUzeXHaVwrXPU4uXDwOA6iTloV+RN2T7rowfOm/tf+H8QpuLFXMQvaN5pJj8xF0LwKy
 /KtJlSd7eaQXNvNlnf8quHvETE+MkCJqfNHCWNyDxxT6lZBnAvfg2IUQYtgHjvSUTwvU
 2SJQ==
X-Gm-Message-State: AOJu0YxXmknUcRLcjLCd6pYameOH7TJwSu+m8vjkG16VV9GNYvTm2gX4
 FmbUm7di/zTFWRYr+Sb+6euCNhgRqmW7khsr/a1vFTburW9G39re3EPh3cQQkKvDhRmxFOrwQbA
 Dmh4=
X-Gm-Gg: ASbGnctqAvskGJ2e4G+OqXoxF44qkR7XmF+LbEi8BVYPMTuK2ONHpmmiEUfNKhe8KIa
 hFUrA9btGVIfx0w2hpn0LkQcN1eOb77gOM3MM8FlASE3QsDJnR9cIj5gEDLUhwcpZq2owkNUVsI
 sLqd8JwOdSu0fVSxqK/ZXR4vFP8d4KYP46WrsizGY45SBA82cZiF66qWnrWw8NmVLNcVTx6vgqj
 hBCGTWMYM786fUPg+rgb1UePPwY+OlJgfhci7u/BK5IHxjV0Yi4AqG7sLM9V3bCopECAwAphklZ
 C4/luFcFuAY991ur2fV6/bpuynhw8dNAUMoT3Yib6zM8gtQBiPaX3O0OYQ==
X-Google-Smtp-Source: AGHT+IGf0PBiibZVjOa5cxvBtxTvOfwzYzGPhK4aCTcjK0jfUczZnSf3zVLMkUBuKA7Jz5vY2U9MbQ==
X-Received: by 2002:a05:600c:4447:b0:43c:f470:7605 with SMTP id
 5b1f17b1804b1-442f20e80cbmr65442325e9.12.1747304757832; 
 Thu, 15 May 2025 03:25:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.25.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:25:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/58] target/arm/kvm: don't check TYPE_AARCH64_CPU
Date: Thu, 15 May 2025 11:24:54 +0100
Message-ID: <20250515102546.2149601-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

We want to merge TYPE_AARCH64_CPU with TYPE_ARM_CPU, so enforcing in
kvm_arch_init_vcpu() that the CPU class is a subclass of
TYPE_AARCH64_CPU will no longer be possible.

It's safe to just remove this test, because any purely-AArch32 CPU
will fail the "kvm_target isn't set" check, because we no longer
support the old AArch32-host KVM setup and so CPUs like the Cortex-A7
no longer set cpu->kvm_target. Only the 'host', 'max', and the
odd special cases 'cortex-a53' and 'cortex-a57' set kvm_target.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250429132200.605611-7-peter.maydell@linaro.org
---
 target/arm/kvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 9c62d12b233..85911e30242 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1843,8 +1843,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     CPUARMState *env = &cpu->env;
     uint64_t psciver;
 
-    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE ||
-        !object_dynamic_cast(OBJECT(cpu), TYPE_AARCH64_CPU)) {
+    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
         error_report("KVM is not supported for this guest CPU type");
         return -EINVAL;
     }
-- 
2.43.0


