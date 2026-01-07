Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB32CFD626
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTIQ-0004jk-Mm; Wed, 07 Jan 2026 08:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTIN-0004F9-Vo
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:52 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdTIM-0000F7-Bu
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:09:51 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47d3ffa6720so20618025e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 05:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767791387; x=1768396187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=le/ZLytt6/xmq+ArK9Pel2VkKrzTlD3OED60/3igVmA=;
 b=ShuRX3n0xVv60DZ+mAkUj0gRjoOpmZQ7IN70DR2MFgZx5v9n9E7SkdjFZchpdL9bAk
 xfOhkUzP5iMA62o+Io6Z+HwJQDI53FfuybMLnZ/6PcqYSQmVfHLUZzCosRC6/zMB13Y3
 FuU6VWgrvb/hsY5hJ0bjCVuvxfFomBkLxtPVz/jp51RXMnRa3VwHGrDWG0IA24+1dzT2
 uHpfNnT8lUwn/Bv3YiZl620p26vlWVVyKe8kAEkDysDt0PVmUS2Bip0zbl/uVlhBS2wt
 hw091a0wJLYcIMJyJPAkG+DxSyu45nq/LysV265F9eOZN4zQrq9/wMzYnwXCQN6bPFnv
 lGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767791387; x=1768396187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=le/ZLytt6/xmq+ArK9Pel2VkKrzTlD3OED60/3igVmA=;
 b=aN7fLPhBj7hrypUY9VZ5soZCJo6UKwN5r0os7D1eW9913zTSeSrE+cFxR0nwSRRaCc
 x5JO0aXnTbh916q5vxROLE/EOzhzyFtCN3Alyh8F6TH2bWK4KNTkH3LaSkbXAGmNAsJd
 3fJ5tFWHt2YW1LWxYBLdiYttrTZ2Mdvmw9pd6J3xZy2dD/0McnSHdHT6xbR0hF1GKeB5
 A6NF4DAJQpVDWMkRj60DGUbUABUJhYpLDxfRWMfePYt1ieeVMusLyxtDBJ9m2ZOGvrjG
 qq1vbYIfI2Zz7BkCwvmjopYiPLFmQyJHGm2uhNDrBhHuTaTm8ir1Yx5SHfbUvJW0McdU
 U6Ig==
X-Gm-Message-State: AOJu0YygQQOcL2n9fuepO+x4cvxXgXav25vcsugoAaP00nH8OyAwG/8h
 7L0KiazixPKJsbYa3H38HeXutByvI8eGkeJTVrfVpVqg7cVgUDTlP3Y9GupB9gvAHUdPwTgysbj
 ifBovGaY=
X-Gm-Gg: AY/fxX4mhTPUvv+EED0vUQox5d1sZ5tGXlIleVWZpfxkHVs4XVYZmPbqm1uiKNgl+Ch
 2XC+Zn5c+LtCCaB746wtUFa036ecQtzWQ9R8Z0yjm88CtvopvizPZk6vGAzFId8oKfO4MmgQHPh
 hX/ACQSr6VSCYFLxRiNnA7k1OEZ/cYkT/b3aQjadMSyCL7ZEUogw2ge475dG22RtXtlq50Imk1n
 RgQcEhkw/vkjhxhM9zK3/xcrYIpBsUm7lDh/b10d+6BlmQYDsSVDSTm8ad36SIaaopdLAn9izF2
 kpC6WEPPvn9RFy2sVCnmRpYtaDzykNkxVCSZeT7V7jSPrbZCmUs3SX/st23mqEZA4CTS07QLWJP
 hVauDf6FW6u+IbxPKxrGvvdBauL6t4BtbfoYKliaiwD+16019o1x7bVO8OwFpceiPVp3i8tJgXE
 2m8GDM/4fKGcP+JbKl4NEpFmCsyR4vdVbVD/HPXpWuj8zVEH7AK+I+6BVtZC4/
X-Google-Smtp-Source: AGHT+IFxn3Jpyxx882d0d099+Zbp80TciSMTUMgzs3efjQRLxqtSsoN1VLJ4nH0mWo7akUhVYon/Mg==
X-Received: by 2002:a05:600c:4e0e:b0:477:abea:9023 with SMTP id
 5b1f17b1804b1-47d84b18e0dmr31207255e9.9.1767791387353; 
 Wed, 07 Jan 2026 05:09:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41f5e0sm95006545e9.8.2026.01.07.05.09.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 05:09:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
Subject: [PATCH 14/18] target/s390x: Simplify S390_ADAPTER_SUPPRESSIBLE
 definition
Date: Wed,  7 Jan 2026 14:08:02 +0100
Message-ID: <20260107130807.69870-15-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107130807.69870-1-philmd@linaro.org>
References: <20260107130807.69870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Commit 1497c160661 ("s390x: add flags field for registering I/O
adapter") defined S390_ADAPTER_SUPPRESSIBLE twice, one when
KVM is available and another when it isn't. However both
definitions expand to the same value. Unify them, adding an
extra safety check in KVM-specific file.

This allows removing the target-specific 'CONFIG_KVM'
definition in "cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/s390x/css.h | 2 ++
 target/s390x/cpu.h     | 6 ------
 target/s390x/kvm/kvm.c | 2 ++
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 0b0400a9d4f..d3326237c9f 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -238,6 +238,8 @@ uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc);
 void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
                               uint8_t flags, Error **errp);
 
+#define S390_ADAPTER_SUPPRESSIBLE 0x01
+
 SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
                          uint16_t schid);
 bool css_subch_visible(SubchDev *sch);
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index aa931cb6748..75608b038f4 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -39,12 +39,6 @@
 
 #define S390_MAX_CPUS 248
 
-#ifndef CONFIG_KVM
-#define S390_ADAPTER_SUPPRESSIBLE 0x01
-#else
-#define S390_ADAPTER_SUPPRESSIBLE KVM_S390_ADAPTER_SUPPRESSIBLE
-#endif
-
 typedef struct PSW {
     uint64_t mask;
     uint64_t addr;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index bd6c440aefb..54d28e37d4d 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2082,6 +2082,8 @@ int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
     return r;
 }
 
+QEMU_BUILD_BUG_ON(S390_ADAPTER_SUPPRESSIBLE != KVM_S390_ADAPTER_SUPPRESSIBLE);
+
 int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
                              uint64_t address, uint32_t data, PCIDevice *dev)
 {
-- 
2.52.0


