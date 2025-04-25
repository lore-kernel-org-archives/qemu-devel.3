Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99E5C369D8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8L2Q-0008FP-I6; Fri, 25 Apr 2025 11:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2D-0007I8-Jh
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:14 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8L2A-00048e-3Z
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:32:13 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c14016868so2262466f8f.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745595128; x=1746199928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IxXJRtg6QqaW97XxEFpJjDjkVurmz7fFxY1fgchqgLI=;
 b=SMijpDuspowig71cVJJYQu2E3zbDMNBRBC3SmwhC6w9XePhtVIYlXHTOL/MKo1bHJz
 bJ4COw4+08vVpLNfkjhowwY2bLsbptjxtTxr43hrKtHzppUGeW5XQkFA/soRxaNgor5p
 OZbEHWNarbEVzP5AZqD2uYkz7lKxX4kmeRycOujud5hompOIl9wTzeSAdjRkAutOJV8/
 Dt1R3eobBLOKOp/Cjk3ZUbF/oeP+eeQiV1T90dsFMRkv4uC4A3xLlfibDKh8EtVEEdUy
 THpmRlzvLc7ZrHeOA3TD6ctF4tHBKpfxPLCiTjowmMnV4r/lFz87qrZWl8xC8PZw4eCF
 z6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745595128; x=1746199928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IxXJRtg6QqaW97XxEFpJjDjkVurmz7fFxY1fgchqgLI=;
 b=OnuXeEWTH1+8eRJ1oD4cVQqr3uCIteNCPry2rFMFBPtV0LBwtNKvj0lnnStwnKNhjT
 fL69Mgfyg7ApIl1J0e31lHhKTAT6sWrdWKTvTELhS21t3zikQnLU9L/vtQ9lG/tnFl/d
 /tYX+aMkT4njA6fLO5iYycppBC3FXQYfXjlvjioxmZj0hNv9b/1qYhMs+K9LwqPVL5Y4
 y0WROA6TYadrFG3j9/xlKoYGzYKFyL8QNv8Hl2ldtEulIijkAoV4eap1TLt1Towg82Fx
 tEE39dY01Gzt6VIbjuA9qvOZ4u6neZOI0hBPoPEgus3D6ipAitx9QMdKOW3MR9qB70UX
 KeuQ==
X-Gm-Message-State: AOJu0YyvrPHTi9t2RFLA6ukAbBWpxT38xLorCHSazluSVGh1S2qdAoo2
 S5IlngAoaV98kKDOZ2CWXLitGdDrY/btVdeP0J3M25oog/w75sKefUeV5xxJbGrHSKGcoakIopC
 1
X-Gm-Gg: ASbGncvWMEQbmNi+7j1ASbx/EXDFREwP/C6+J9kA4ghWjdWW/QS9mRzNoYUjCUDJ6rn
 TzZv7nTG6zYF1gZMYIFLPPX6hiY98nIyEuHuZdaC4bZvrxXhX0kA2vW715iQQh5R4l8G71RDTBU
 oi07oW5ClL/3+FEaSxTUoVn8Hexfo0+xD5uVnqEGi206C+GJY9qHcRkbETjw2mAtdCRXq9n6NNr
 pr/J374x+MWfp1LNwoYxCWVfL3jQvPouYCUajpaYWIGh/Lb81HL8aK/890y5L1n+v2Jq5aC6LKq
 svnlbYgHckZe2A8Itf7LIwFt5r8mg0+ZLweYDJlapsNYBD0Z3gJt5CKY7dmHCTDlcN/YCAZlr9i
 fRB2QsETZ3dxUqoE=
X-Google-Smtp-Source: AGHT+IFDqQZSt0gYfJw2WCHXjGFKdP+LXp/4aFb+cw90md1BsyMSr957YnrFuFQHl2heFr3dzK3Oww==
X-Received: by 2002:a5d:64e4:0:b0:391:41c9:7a87 with SMTP id
 ffacd0b85a97d-3a074f79251mr2215414f8f.51.1745595128062; 
 Fri, 25 Apr 2025 08:32:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cc4153sm2726173f8f.57.2025.04.25.08.32.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:32:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 41/58] system/kvm: make functions accessible from common code
Date: Fri, 25 Apr 2025 17:28:25 +0200
Message-ID: <20250425152843.69638-42-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250424232829.141163-8-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/kvm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 18811cad6fd..b690dda1370 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -210,6 +210,10 @@ bool kvm_arm_supports_user_irq(void);
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 int kvm_on_sigbus(int code, void *addr);
 
+int kvm_check_extension(KVMState *s, unsigned int extension);
+
+int kvm_vm_ioctl(KVMState *s, unsigned long type, ...);
+
 void kvm_flush_coalesced_mmio_buffer(void);
 
 #ifdef COMPILING_PER_TARGET
@@ -237,8 +241,6 @@ static inline int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_t
 
 int kvm_ioctl(KVMState *s, unsigned long type, ...);
 
-int kvm_vm_ioctl(KVMState *s, unsigned long type, ...);
-
 int kvm_vcpu_ioctl(CPUState *cpu, unsigned long type, ...);
 
 /**
@@ -441,8 +443,6 @@ void kvm_arch_update_guest_debug(CPUState *cpu, struct kvm_guest_debug *dbg);
 
 bool kvm_arch_stop_on_emulation_error(CPUState *cpu);
 
-int kvm_check_extension(KVMState *s, unsigned int extension);
-
 int kvm_vm_check_extension(KVMState *s, unsigned int extension);
 
 #define kvm_vm_enable_cap(s, capability, cap_flags, ...)             \
-- 
2.47.1


