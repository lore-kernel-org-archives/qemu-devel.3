Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4ECCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQnG-0000ad-8B; Tue, 02 Sep 2025 09:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQn1-0000XN-Vb
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmz-0004Tk-7q
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:11:11 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45b88bff3ebso15809195e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818664; x=1757423464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MtRFtCAAXDtFa8mvdL9ZNn0tvJmLxLIbWyzszL4emGE=;
 b=pAKswTnOB/l6PG80Rwpzdc5ZxmT2kykwicPFL3CzfK/Nk3a2nUCQ0OIKXeSetO5Rhl
 PC7Oi9nFlhUBO5Tidu+h2ZUQXKefFLS6ZmbHULpAXWsr9iYyJng1e+zAi+fQyDSgyr6g
 9KLNXx9G7Je/XUjNVlcZB3YlsDpVeota3zAwG9X97xxosT2nKUW2IyL7y+1TRKU62zoH
 6I7bs7+V34y0QcGLEr+m923YA6vMX2qK0r+urquad0ls5hZfrjzFHVo+jt17fdCERs/Q
 +yF92rBFMbeaxkzEQH7TV3KWPB76DZKZHqS623LiCfkeEmiPE98c3ms50BhnaD7JtTKH
 ZZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818664; x=1757423464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MtRFtCAAXDtFa8mvdL9ZNn0tvJmLxLIbWyzszL4emGE=;
 b=nKchKHOnKISxq46ZtHbbhP//3HIVoklmMYSejbDSPcY0chtDV8B+7qffjdLsyg2tmT
 dLGVYN4FUDUgV8OyzO7AucN1FNKYt2kdrohRg4oEE/lMsz4ajmO+5z1bVCgHcVe41m+l
 Lm+POz75DzKPSEj9YAH1cQzQ30PfP/wj33IfAEyaOCFB2r608+wew9Q8PXBBJJzVTB1d
 W6chCCXR5zzYkZNpIxyEHtIrCA2l6bsrhhU9M86Gikb59RM1tZ8MCYKD3ELNvRmv7SK/
 TqjVchBEJITHx3+4IW8UYXz3tNG/GCWTWRh+Jp5rRZ55r4LpwTAYKBHjW3hGwx95w5qv
 gEPw==
X-Gm-Message-State: AOJu0YwgJnzKG6meOVmbKpCxG+WZvksKCbul6Q8fGhMKk2CzzGAGNFrU
 3juaBE2/Rxn8CAfXxuOqRbDOptC0/MU3+72ESJJ9mqDmrQuBKpfdm0qC85d6+2rMqLPY1gzBCiR
 Neu5L
X-Gm-Gg: ASbGnct1bVDIXW+WvCfaGgyt6EZJo0m8zsn61tNBU5Mztj7rGzgaRtfvqpTgEcX88eG
 9MwUDAYWLVtdFU1mJ7qopFl8bbjto7esnKeKJZ8pxXCM+h2pr4pxOwiZbtZ23sZZEoLWTk4vHFm
 nVf0Wz58J//OlgBp2mTONATIjQTyJ1HuR74RFgIts/i9kwW8H8uKLq2XjLjmmdcHNXAQZTbwK5D
 TvLOBzNieqby1leual2fF+IX8j1GBJrV68c69Ek/dvbb4+usGOiQMycb4jp/PGGdtXyzdhEVfk5
 Zh1pGSqANGbFav3lIGWvO17fIakHOQnAr5kx6N0x9hQHuUjsSR/fdzvKsJZ+/OAOagQBumvvQgh
 zkHFQ7NL9UpkFWXyg7rkJzqRJYv6d/J/ED6fomZwgqAF3h4Tl2wQj8cmw5RC1qYo4C6WDts9nP7
 0fLNknSMg=
X-Google-Smtp-Source: AGHT+IHF5CwLu8xipLp/GA24kmgu6oGz+SVE9DQlP+85/c3Jt+mzjHNeo6gMP4OPSGb2Ku97cH+4LQ==
X-Received: by 2002:a05:600c:3556:b0:45b:8822:d6c1 with SMTP id
 5b1f17b1804b1-45b88321bf8mr85484995e9.12.1756818664255; 
 Tue, 02 Sep 2025 06:11:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7d1319sm213632775e9.5.2025.09.02.06.11.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:11:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/39] hw/intc: compile some arm related source once
Date: Tue,  2 Sep 2025 15:09:47 +0200
Message-ID: <20250902131016.84968-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Let kvm related gic file out for now, as they are compiled only on
aarch64 hosts.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250801174006.2466508-3-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 3137521a4ad..3efb276b6e6 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -38,11 +38,11 @@ if config_all_devices.has_key('CONFIG_APIC') or \
 endif
 
 specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
-specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
-specific_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
+arm_common_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
+arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
 specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
-specific_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
+arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
 specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
 specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_LIOINTC', if_true: files('loongson_liointc.c'))
-- 
2.51.0


