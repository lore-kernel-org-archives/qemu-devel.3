Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C52C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdSc-0007sr-So; Tue, 04 Mar 2025 20:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdSa-0007qr-Ej
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:22:08 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdSY-0006tb-Ha
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:22:08 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bcf9612f4so6813285e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137724; x=1741742524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hSEi0FhosgxuvGNlDjYLhuekfWSpIYsUVfwm4laOPdk=;
 b=HAqTVITlFOIuP9xemVAFL5ccf2nSwLbJYIepQ1r81irpIczm6W1GC8cgmssWY0IpRp
 F9iKhQjDUD07XSBS+KLBHkKoiVRdo6L2+ggwxU6w6iDkKxVBr26iEMKvn4+8fY3uQroc
 zD3X3M8hlXXKE6t4xqQqYAkQH5/DCariNsq290iS/95Z3Zuz03KLGmLfny0mtELhQNvN
 VrzGscaiGkj6Ih1ICmOnSP+PhHJZ5MiR124vNawosuBlp6I+Pe954aZSv60rwXnnps+E
 Xx20T4wYlpxCXFrHyuSw1i6FYIFJmv655WCEf8TsRU6/3rre060tfN2dHP5yGmw0OYIH
 6dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137724; x=1741742524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hSEi0FhosgxuvGNlDjYLhuekfWSpIYsUVfwm4laOPdk=;
 b=Rm1piNq0aAAVQhLcNtIh6V9XOFfEHnQt/b8LPbJDvuMn/oaz+WUvaZH8478rcnn2j7
 WqFKmSeJVIa0RTQdOTF+BIsX4SxK7oELz/t1Z5hYJLpOMeAGaoBup9zIyn1DKTInoF5i
 ES0PhvIbCB7z8eQq+Q1xd1dz9gramDPmF9FHDHTXLnEIE8Bl+I7sz4HSzZ5i8yqwiVJc
 VvstULsreWIKWRGVgj5EOybqH4aY3hxlrqV0yfMMGWeW2ts9GGmUyYxr1cHFGuSDt4D4
 BEmxa+yVtqE7p3sxBg4am6Kh79c8FJKdUEFI9YGzwVHLecB+wdtecs1SN1oy09A3Bxay
 1cOg==
X-Gm-Message-State: AOJu0YzpF5+14zN73PMjTme5tmEexhHizjebttng+1caqoLYFSR4+zIG
 3lI6grX7s+A83U3SnCjtnMn8CTSkGrkk0+E4NYs+EB7ATShEyubOYs5oTBUd2pYovNDXPjYXypt
 xWsM=
X-Gm-Gg: ASbGncs7+61BjTpNUfrC0oQV81NWiQ/jxjiE7meZ+EK9PF3Ok3IWIZFCQouJE4fBrRM
 jGy4Z7TW7vHoVhJK88XtSBmBTqHDdA1RMFBQfC+kJgzK9E/b/waFFWLNqFLbKjFzkPpchIixwRD
 tEuvJy6dP0OWeRz+wgmCZDiU8gEKW1uh2UjVp58SSkqVjIu4rLAN7QejYA1oNCRM22enG3jWS+x
 gqqWTiCPRuUYYcYbDCDZwFqEEzPXFXNquyhUT5UqSNVHbiRuYlObgi15QjaYJ4UivLI5GHVEj4q
 /v7X9ifqGsyGd1fjul6bb1oG/3SLqzkhwKdOUq6OXjR+8iSuJ4v/5y0Z8Aw+jfOAGcrMbvRkvAX
 P8ZE4/5Yjgi994BBVUr0=
X-Google-Smtp-Source: AGHT+IGmPCj6OLKM48knjp6GAd5/ofkT7EJWI48/PBPO1fXViLa3Ar8sLEBHbk29lR506fRxz4tkWw==
X-Received: by 2002:a05:600c:4ece:b0:439:5a37:815c with SMTP id
 5b1f17b1804b1-43bd2ae5547mr5352495e9.20.1741137724121; 
 Tue, 04 Mar 2025 17:22:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6a9fsm19525804f8f.36.2025.03.04.17.22.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:22:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PULL 01/41] hw/intc: Remove TCG dependency on ARM_GICV3
Date: Wed,  5 Mar 2025 02:21:16 +0100
Message-ID: <20250305012157.96463-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

The TYPE_ARM_GICV3 model doesn't have any particular
dependency on TCG, remove it. Rename the Kconfig selector
ARM_GICV3_TCG -> ARM_GICV3.

Fixes: a8a5546798c ("hw/intc/arm_gicv3: Introduce CONFIG_ARM_GIC_TCG Kconfig selector")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
Message-Id: <20241227202435.48055-2-philmd@linaro.org>
---
 hw/intc/Kconfig     | 6 +++---
 hw/intc/meson.build | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index dd405bdb5d2..7547528f2c2 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -23,13 +23,13 @@ config APIC
 
 config ARM_GIC
     bool
-    select ARM_GICV3_TCG if TCG
+    select ARM_GICV3 if TCG
     select ARM_GIC_KVM if KVM
     select MSI_NONBROKEN
 
-config ARM_GICV3_TCG
+config ARM_GICV3
     bool
-    depends on ARM_GIC && TCG
+    depends on ARM_GIC
 
 config ARM_GIC_KVM
     bool
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 510fdfb6886..602da304b02 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -6,7 +6,7 @@ system_ss.add(when: 'CONFIG_ARM_GIC', if_true: files(
   'arm_gicv3_common.c',
   'arm_gicv3_its_common.c',
 ))
-system_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files(
+system_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files(
   'arm_gicv3.c',
   'arm_gicv3_dist.c',
   'arm_gicv3_its.c',
@@ -39,7 +39,7 @@ endif
 
 specific_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c', 'apic_common.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC', if_true: files('arm_gicv3_cpuif_common.c'))
-specific_ss.add(when: 'CONFIG_ARM_GICV3_TCG', if_true: files('arm_gicv3_cpuif.c'))
+specific_ss.add(when: 'CONFIG_ARM_GICV3', if_true: files('arm_gicv3_cpuif.c'))
 specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
 specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
 specific_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
-- 
2.47.1


