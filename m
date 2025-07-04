Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85CAC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdRg-0005yi-16; Fri, 04 Jul 2025 06:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRX-0005vu-2j
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:14:55 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRU-0006Au-K7
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:14:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso5757155e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624090; x=1752228890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g1qUi+6m397zoKQpfNej+VqjNFsZRTFYtagMj07jt4U=;
 b=zcQwY8zxSd4HGsirKLKZFDViTvkIQhS2LGAiNwOQfLB1nNIWsolxUVtsmC+LfF4fLS
 Cp73joyYhm+/i+6rs9SXrsd5IrXXS2lhFDhnWkI6J1B2XS31OkBNE3816ectAWepHpN3
 XEF8iWt7i76jqs7EvxtGgjvc2CUAg18LWBIa36ANaqHOaOUA3aeegLS4NOHz/jZz6f6j
 27VcbQMTtajlRDK9pLy2VNFn4JYvLwmPezYHB+Frj1NtBqHEd4JDtmjSsrDmFiTs7S6o
 dyqdlPNMhfDHb1y7V0MEqJmUY7vFJKMEIDyzb5DmHRwkvS5/ccXNTNuUSoDDdtCyeYj1
 POsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624090; x=1752228890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g1qUi+6m397zoKQpfNej+VqjNFsZRTFYtagMj07jt4U=;
 b=dwEI3puQSqTItMlbL/1kzmYl6k/66rQILQDbxqxOoKQz5fjYkho+TMYyjaAiIF/Akp
 CKWD1lnlc/tyyRXZzAUynLHgAPtBGdjS/N62A+D31L/XDXGyexSObTQ/OidW+dpd59yc
 4f3pitbTrE9bYUXguiHw+z3xgjXb++mI9bypxxdzPanfnsEhU6BspxeERkVhcJb25QhM
 BN5wrUfz6Q3oVRm1meREDOqs6YZZSPABV8wGmv9K/jCT2EjkRW4PVvAaGUgXOngyLLSy
 jNDJk6e75mfzLRJam/PUFns5hiK4kAwua3jdRKwh5BWuopIPNB7U04sH2m9G2W2OW0T4
 ijDA==
X-Gm-Message-State: AOJu0YzOBi++amEEJM+IDtEyhbqDFNAZRf0mDemzjeopHlMVJh68GBi/
 F1EG1COzayZSsFcbaI0IvMsUZCfcmR4ppsrk9xw3JipnVPvkt/LmWEIOcOY2zfUwTH506OGqCf6
 NpFiHeMg=
X-Gm-Gg: ASbGnctrH118L3lNgI3mi9J54xpLZHb3ppdlgR31HulSIOXSrPMyg0ll2wyNAPKnixD
 msuf0vqFVGPJO8hfOJ8uPxx4iCXDdZCIL8f26XxknR5Cy9iujlqtPZ+3nxExWKg5Q7fw87IJnWh
 k/4HRzqK+XeKjg/0/f9W/LjCGBu2dsVhoH8bc818M/vkXVxDftrVbp0h1BEhC5xtgvIB7U9wkf/
 /MgqP8PRlh/mLDVZ5sRgMFPson2/bpkU5NPCTMk5rrdqAoQAJqp06b2Wc34H8nBcFSnt5M/dROE
 wsaIKcAu4eLplnLafBmP5+zhfbcp5WOb0XVcnIM1ddHTTDsYjyQPyrQ9uAqcfswohT77WkyzM6D
 8/k/6u5ovMO1Dvy8or9PyhGwC+2n4Uzk7fjCq
X-Google-Smtp-Source: AGHT+IGbV2KHuWPiLNbT3/342ZnMYwodrHJWWLDozZd3WAa1wCGRj3YhdF+8YnZENcmhm+76zwUc/A==
X-Received: by 2002:a05:600c:19d1:b0:450:d61f:dd45 with SMTP id
 5b1f17b1804b1-454b4e6b9fdmr15451665e9.4.1751624090262; 
 Fri, 04 Jul 2025 03:14:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285d3bbsm2110255f8f.96.2025.07.04.03.14.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:14:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/31] accel/kvm: Reduce kvm_create_vcpu() declaration scope
Date: Fri,  4 Jul 2025 12:14:04 +0200
Message-ID: <20250704101433.8813-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

kvm_create_vcpu() is only used within the same file unit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-7-philmd@linaro.org>
---
 include/system/kvm.h | 8 --------
 accel/kvm/kvm-all.c  | 8 +++++++-
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 7cc60d26f24..e943df2c09d 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -316,14 +316,6 @@ int kvm_create_device(KVMState *s, uint64_t type, bool test);
  */
 bool kvm_device_supported(int vmfd, uint64_t type);
 
-/**
- * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
- * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
- *
- * @returns: 0 when success, errno (<0) when failed.
- */
-int kvm_create_vcpu(CPUState *cpu);
-
 /**
  * kvm_park_vcpu - Park QEMU KVM vCPU context
  * @cpu: QOM CPUState object for which QEMU KVM vCPU context has to be parked.
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d095d1b98f8..17235f26464 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -453,7 +453,13 @@ static void kvm_reset_parked_vcpus(KVMState *s)
     }
 }
 
-int kvm_create_vcpu(CPUState *cpu)
+/**
+ * kvm_create_vcpu - Gets a parked KVM vCPU or creates a KVM vCPU
+ * @cpu: QOM CPUState object for which KVM vCPU has to be fetched/created.
+ *
+ * @returns: 0 when success, errno (<0) when failed.
+ */
+static int kvm_create_vcpu(CPUState *cpu)
 {
     unsigned long vcpu_id = kvm_arch_vcpu_id(cpu);
     KVMState *s = kvm_state;
-- 
2.49.0


