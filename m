Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BFDC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2eL-00017X-VS; Wed, 02 Jul 2025 14:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2eJ-0000v1-Lt
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2eG-0002fX-8V
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:57:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso71861205e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482651; x=1752087451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Uuv2h3s82hPAzYpnhwyO1+75T5oRaTFf+ZSAVIOeJ0=;
 b=bT4Ep4R8xkdGwZJVKP1OucxHwiqfUcZYUxIpiltffoh3m88DB0NlCkzhNhY7+i4tfL
 wU+rM+7pZE9BGnD3VtFWosnV7PzobMqJpTk/i5o2i6se8JBUv+93aMPB85zGSBMEK04V
 qYrjhAowWdEm/rNlW+wHzLAm8ya2yyWrESAnSoLNxx40XJXU3KvoGVSH5ozJ3THVwGYo
 lsjOfr/r07zLJW562d0RxIVUW31Uq+vF4N2cWZAZmk1IUOXKt5nG6TBdLn/LZ9xWiIJA
 6CC32YCdpHzI2QU+B+4yi2z9UcG07LoF0QeC+rduaHz6/tbN/zKsPWV/UaHnDtPJCBov
 Oshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482651; x=1752087451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Uuv2h3s82hPAzYpnhwyO1+75T5oRaTFf+ZSAVIOeJ0=;
 b=xRallnHcZh1ZHHROPjeutYyKnVWPA/a9e7m77igVloxwSfjn4Ss+2ScWHZwW9l9aDO
 f2d395lW8NZ31nI20OQ0QK4gCQQErgdGG1KQZ4h6WvbDtUS9bRmhcjyiTio98MqeRy/l
 QfcWl1K16dvMKxo15KoineE8timSJlb4Tct+RNH9rJ0ETqnCx++t7MXdmAyyJGCBkVJc
 5JR12o/9MAilvGBMrN7JpBoLCEqi4i77GPucpe4fsfBmod2E69BknI4TOne9V8z6MqsO
 HdmwBvjeDYqDcJmbfVhoaA0W9nOLOIfaAHm809gLyoU5Bgx32vqZZ7kflqJLVDa75qMl
 G/Og==
X-Gm-Message-State: AOJu0YxcQakOIqRV2TexsrEcspRrvufYsipewkqajPLbArYKhQJ5nMcy
 Fha9zv7GBRQPPk4NQVj0PVxpS/t/3nNE/rxQVuYQ3NohcwdZb0QYWc+whvLOF6pcmIrWKEX8R3c
 IOiy8
X-Gm-Gg: ASbGnctOVBfFitzTEQrHz5y+xb+G9in4svg1tR0o77HSHo4ctyyE3vYWwcoHYWeqkST
 m5OYE1jxqGfAB4otKHirvDPU50r1X2oT/qVK5920Fm2RC2mcVoZ6wWHJ8LtKaSpGUpkoigynmSb
 WllroMA4qz62WSwHr5AVCc3aab+kJTqfg1c/EcFXRufrUtN/Z15yLj+87KwK7ILwzrZoUUVnez1
 O6BW/UFiVKxmsHMkxY1q9EEjnEzhcs4R0P2BgvgobMMi7Ij1FyLNMEA2AMhQEfajONQUPp6JfLF
 hm7vDfH57N5h3S+KcFT0EaaUWP98Bq/ZBOMfbkQTH66HIgxHhIURq6nq8KKJ/KAhI7w2V6Y9pEd
 rNogiN19ZAIJjLflubHbMtrlCH0UmHYPZWYn3ipKxSxedkRM=
X-Google-Smtp-Source: AGHT+IHgAyhCxjFsA9NzItI2EGTKnAx6F9/L8rpT5NSOEGlBiuPzecYt0n7TLGCXafSE/peWTW/icQ==
X-Received: by 2002:a05:600c:8b06:b0:453:d3d:d9fd with SMTP id
 5b1f17b1804b1-454a36e64c5mr49065475e9.12.1751482650566; 
 Wed, 02 Jul 2025 11:57:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a99b1c2esm5565905e9.30.2025.07.02.11.57.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:57:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v4 32/65] cpus: Document CPUState::vcpu_dirty field
Date: Wed,  2 Jul 2025 20:52:54 +0200
Message-ID: <20250702185332.43650-33-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 33296a1c080..726427449da 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -441,6 +441,7 @@ struct qemu_work_item;
  * @opaque: User data.
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  * @accel: Pointer to accelerator specific state.
+ * @vcpu_dirty: Hardware accelerator is not synchronized with QEMU state
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to @work_list.
  * @work_list: List of pending asynchronous work.
@@ -537,7 +538,6 @@ struct CPUState {
     uint32_t kvm_fetch_index;
     uint64_t dirty_pages;
     int kvm_vcpu_stats_fd;
-    bool vcpu_dirty;
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
@@ -553,6 +553,7 @@ struct CPUState {
     uint32_t halted;
     int32_t exception_index;
 
+    bool vcpu_dirty;
     AccelCPUState *accel;
 
     /* Used to keep track of an outstanding cpu throttle thread for migration
-- 
2.49.0


