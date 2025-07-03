Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07427C83F04
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNoT-0005Vy-QK; Thu, 03 Jul 2025 13:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNoO-0005Vh-2B
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:28 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNoI-00086h-SK
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:27 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-454aaade1fbso1227235e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564001; x=1752168801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLkTPhlZ6ATb7AAc3VGQov8gsRhAPF8MN9ZoezL4e2s=;
 b=pEFXOpPsjGOxmEBVLb0YlV05H9JeQPnZ9KgooZK3Srk++5bqe9VNFvqA4fdMYzinac
 MrlTpokIAUpFQBJJFq3MHh2ZYkio6kpWmGmywaZ4KbJE6dIApz6vRardgFeT7odkFBYX
 aGJinYoZWwEYl6CeDtXMTFBNnMjvHp6zsIs4/Zwx/i5To8EeMTN1gb8ko9fjWFN+2K6R
 XfAS+T845Zz8jcR6ecNLR/OScJrHSjO1dcnriWYaWPGoJrds2sQ4swzLuiEpUF/AD2UT
 vRTRzvspe7KYh+RjC6wOwH/E3rYCDbixXlqYs/eM3l9RYWm+ecHl538l8z1p+OXF+XRX
 CBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564001; x=1752168801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZLkTPhlZ6ATb7AAc3VGQov8gsRhAPF8MN9ZoezL4e2s=;
 b=RVwvgAI6YG2zs4c/xmhbOoNWGMQmGmXxGslEovNURM1kAy/pwIPDOoOKl0Qa1mw4H2
 gKBKkv+aEtGZvPlZTUu4P8IjysA5Ajp3/SdXDhyntcDJG7ZCafH7FgTl/6GgjFxJ9+eq
 JCe5uUlcRdFSlliSpvysnRYK7ys01PFrwejXFJ2PrRlVg2i61FFGnrBfAy8FE9jXz3OQ
 kPicP8Rcn49XUHVhaI1jieuOw/r5pjn75sKBjJz5BF+KHV7DntGWJLSxvDJwzSFAwhjq
 8rclz1w0NzbAIkgEK1/YEUBNc1Q32sRwoJv1RV6aF5GhA86u8Oi3bq8QLxgOnHdyLCiN
 8KVg==
X-Gm-Message-State: AOJu0Yy8HZuV7z8S8T6tt5oaBGI2j1tc3CcCSac7QayNAP8tst62EvGD
 LKp/HiSGGk2+kOLu2HRs5bEmRnYS2r/Z8zBLrQ9Rwuzrin1LR87LZDypEChFV8wlZwQBCbcnqll
 2NhY3wQU=
X-Gm-Gg: ASbGncsc5VdkJIzvXCUxxH6fqQM174olNMgOU/16SebIpAEPYAUYcf3VePML+KYaZ0S
 jnRvUfBOYI5wbF1LqZtDn9d3SmlxTqLjCEi8fkjRat4yWK9kYs2YDiUiatg4d+FiKjLNgE0lcxU
 5MCkk5aHwLG7SW0TlEfDJJDUTC6BOXSrDtcDGs47eT4x8k0VqBT1b6scT7Z3LM0Cvbcp34hnQUi
 Y5vZSmIciROkRGxaofTlYKE1JAz5gZ1L/rR3Ve0fIBAl37SGncWWD1mz6fM8vgkWxFR5CDwP3eR
 t9gpZNcXIK4fD8PIRAUYauAP++mcu7A4muRTwrqfIe0e3irgi+hSY2EGuAGhBEXCbBt39B1rCtW
 B8MNIz8z/PIdkMt7ICBUcf6GoHW24rX3dCxAQ
X-Google-Smtp-Source: AGHT+IF7y0Ub+Cf0w0FURKaEgGsSG7UcWWxJaioorDsaWNR4xJx/xmz1NjsWoloY7AE88tq2thGyYg==
X-Received: by 2002:a05:600c:4f84:b0:450:d37c:9fc8 with SMTP id
 5b1f17b1804b1-454a3e1a96amr87058205e9.13.1751564000930; 
 Thu, 03 Jul 2025 10:33:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b4708d099esm332340f8f.21.2025.07.03.10.33.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:33:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH v6 06/39] accel/kvm: Reduce kvm_create_vcpu() declaration scope
Date: Thu,  3 Jul 2025 19:32:12 +0200
Message-ID: <20250703173248.44995-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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


