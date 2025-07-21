Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79DAC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYv-0007xc-6p; Mon, 21 Jul 2025 09:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYC-0000AD-D2
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:43 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqY9-0005Hl-Gx
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:27 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso30303195e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104444; x=1753709244; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LDSwBUvksbhb5pjoNJUH79KfTb7ObxN8yMeFlhNrxSc=;
 b=H0RPS6Fn4WyMCgq2qBA3AnvEYVBW1dqdsmX8GZmErFHLXjq7R/tM3MNg/QJ+a5buCN
 3yUZ8oFb1py68WCoqO1f40PuqybV80/60UdTJ5k3Ryc31DZY/unBohPu6RzOUxjPwQlR
 hHCPgZf4OY0uYBnJ+/fDCyO6n7JDc6JJWuaD9F27+IeiAWgNh7+i8oMjDtusIZvk5RdH
 3QMxz/8gXI1hc/HWY/UKhJGSNxcw3RaNTwUezdbvPArJa1eNGTi1zv55ZvffHXItAN/s
 uTlOm4Li0/EVfvXFpzua0SHzk8CIklrLEAuSlZvIRFfXgK0JAwIMc+RyxFccRc+hC4qJ
 qK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104444; x=1753709244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDSwBUvksbhb5pjoNJUH79KfTb7ObxN8yMeFlhNrxSc=;
 b=DAR7gEKwwOafLrdYWcUpu0M+z59pQxNERzPr836DZcMz3moRTXkx+iGia1mvP22AWa
 CInHzbmX+lNIJyYoJscAEO+02KLQn1R3W++PNS8XkBnsaIikWMS3SLol+wLFuEJeiCzw
 lOwq69CQLSGL85RU+2cmUmC/mlG5u4EH/1PK37/t2nLxw7o3GkWS9Hb14rCAEICPABy/
 4ji52EqdmW/C0Nhc7qdFYw4ziQmRiYbgB7MZjANRmswDVQ8vG+zj3EX38yc8txTjDh1M
 c8oJkMz1PJAEY0ZPoMNMmNqAKMLeQAwtgv7HCetpApWGmowmanwIVhtqNDse+gLT6Jv7
 jSLQ==
X-Gm-Message-State: AOJu0YyPdFg4kB/WkBZcctHcEP8mcxzxE1uUBvUa7n0+VtlOykGZpGiq
 wHWS50I7c1fBIAr3DQKLTw1hJ0NS3RLzSo277YvYdjXHgDDUsl/uAWMeWDD67fs6bGQwNwxFxYA
 wRz10
X-Gm-Gg: ASbGnctRAb9o2Yqom/07a8aAaaOP7OJeM++WLfkh7X7iwYz+4FsdnDScgy4R8wlOgJR
 Z78OKwVHCWNgPP1Fk1+5nwdzzhdvxkPSiB6WJdBdsPkaRjP/iUr3Pz2GsKX9CdfVBTizVjipH9F
 TGAQGX0Y5IeUjPh82XDcoEwmsQQz57rFLxuyQpfFaeIjBl6QY9PvpqcgZrVmwL9AHaDta6uZvxp
 E3sbtWoJ6xO5NO4SOKVwpyHotjNX152mmBA+Nd++ESF8Ba4jwLwhalwwwPGRKSp661WgcbUU1R9
 GWlts6Gx/umANPiKqQ4ofH52x+A1GlUkrfrUVdp09QpAZEGSOlr0A7ptqjEwk/CjW8P/IFnb8EG
 p2StrIK4OKhQODxCJf2KeW7gtdy/U
X-Google-Smtp-Source: AGHT+IHDvFPdSvDPc8eD0Pc/bZi65+z4jukR1ZkCd1UO/Bx9Wu3RiXrRIq7PveoK6Z6w0DWzWks8zw==
X-Received: by 2002:a05:600c:3b88:b0:456:25aa:e9c0 with SMTP id
 5b1f17b1804b1-4562e355c9bmr204683365e9.14.1753104443603; 
 Mon, 21 Jul 2025 06:27:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/20] target/arm: Provide always-false kvm_arm_*_supported()
 stubs for usermode
Date: Mon, 21 Jul 2025 14:27:01 +0100
Message-ID: <20250721132718.2835729-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

If you try to build aarch64-linux-user with clang and --enable-debug then it
fails to compile:

 ld: libqemu-aarch64-linux-user.a.p/target_arm_cpu64.c.o: in function `cpu_arm_set_sve':
 ../../target/arm/cpu64.c:321:(.text+0x1254): undefined reference to `kvm_arm_sve_supported'

This is a regression introduced in commit f86d4220, which switched
the kvm-stub.c file away from being built for all arm targets to only
being built for system emulation binaries.  It doesn't affect gcc,
presumably because even at -O0 gcc folds away the always-false
kvm_enabled() condition but clang does not.

We would prefer not to build kvm-stub.c once for usermode and once
for system-emulation binaries, and we can't build it just once for
both because it includes cpu.h.  So instead provide always-false
versions of the five functions that are valid to call without KVM
support in kvm_arm.h.

Fixes: f86d42205c2eba ("target/arm/meson: accelerator files are not needed in user mode")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3033
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250714135152.1896214-1-peter.maydell@linaro.org
---
 target/arm/kvm_arm.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b4cad051551..6a9b6374a6d 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -161,6 +161,14 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu);
  */
 void kvm_arm_steal_time_finalize(ARMCPU *cpu, Error **errp);
 
+/*
+ * These "is some KVM subfeature enabled?" functions may be called
+ * when KVM support is not present, including in the user-mode
+ * emulators. The kvm-stub.c file is only built into the system
+ * emulators, so for user-mode emulation we provide "always false"
+ * stubs here.
+ */
+#ifndef CONFIG_USER_ONLY
 /**
  * kvm_arm_aarch32_supported:
  *
@@ -197,6 +205,33 @@ bool kvm_arm_mte_supported(void);
  * Returns true if KVM can enable EL2 and false otherwise.
  */
 bool kvm_arm_el2_supported(void);
+#else
+
+static inline bool kvm_arm_aarch32_supported(void)
+{
+    return false;
+}
+
+static inline bool kvm_arm_pmu_supported(void)
+{
+    return false;
+}
+
+static inline bool kvm_arm_sve_supported(void)
+{
+    return false;
+}
+
+static inline bool kvm_arm_mte_supported(void)
+{
+    return false;
+}
+
+static inline bool kvm_arm_el2_supported(void)
+{
+    return false;
+}
+#endif
 
 /**
  * kvm_arm_get_max_vm_ipa_size:
-- 
2.43.0


