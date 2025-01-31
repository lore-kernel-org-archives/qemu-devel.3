Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E2CC0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyD3-00063g-W3; Fri, 31 Jan 2025 16:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyCz-00062v-HR
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:50 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyCx-0007nk-Vi
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:49 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso17376505e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357546; x=1738962346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkI1x48a89NKwPE68PZIsmK31RuXF94y4KuLgkd4bSM=;
 b=fYyAMrsAj5uZZK+75jrb5P9sO90fr16Pb/Iv3WGK8OuMYYb2U9iSKpVXcXam82Sq0P
 rW3JIszyhN0UPAdGTkFCK0t/BFxQNOiC/qeu8G+72DW42wMHVXUoaJQtdopeloA8aTA4
 S4RkpclaPgniWSG2zFgUJCPgiFq+zKpalL+jBdhD6Sw63CwJN7ezXjVBRXKlWplD4L1L
 rqUk+USQkrUiinSBynOXAhbMM1whmdfKFyyohIid447l1PMxcyjffB+FfAOqC4+IXJql
 BVnsiMkDTogn+BaYAXK+CnFrtpsPZpfQ79MtjJ737SaI1hOClq4/PztX2D/ULCcIgGn1
 edrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357546; x=1738962346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zkI1x48a89NKwPE68PZIsmK31RuXF94y4KuLgkd4bSM=;
 b=Yk+js7z1Um0Q66T/db0zr+buMd5Zroi0HxTWoXKMb7h/EHtJNNmRoIv4d7r5IBhrVF
 gQUIz095HRgcTfr19baQ8RqCHokRf+17Ni6kzWYgfbwoayf2kqLQnzMGHT4kfQCpxHPH
 5AbP9nxG9hdRngh9afl3Y9Nlr/AYvsenrMqD7ThdBXs201DcZVAkUg6NzUMW8kdrrNDU
 8TxkAdf9ZB9AtyGiF6o2fDZitkfUDva+pLiVSS5Hp8WRkRitVnxWvuAf7rx1BrV7TWKb
 sjwbcuU6Ia6YaV7asQPtQ85IWg/PyMiXdZ3FF2XCLtFQiNJ1OPcH/N8WJrcdr2+1gupF
 C/0g==
X-Gm-Message-State: AOJu0Yw3Y0RmBkzl9OATTfnSpCykkaJNtqLMkEqEvUEDY00XhBXH1Btr
 6l2mN82AGxdgXGf8jVemCvh4+Ubge8gWM+Bs+/X6UxFzi15D+c697TqWxVm6JW9No2vKK8fYNUx
 d3IQ=
X-Gm-Gg: ASbGncvcggkLiJxN5jvwPakyY4Jm8M+CCZmuVySn91zAGS0gxq5g7S10aao4yk2HX7s
 2v+ZgTlP5pgXpBCNKSVcIjICwxYGxl4s7fIKMyJ+e4JDnf0SdH9NqhN3PPuET6iG1AKJkHTt1lm
 oaHYrDTMNIum31baTosdDp4nFEIWY0lRxtNfRwaxJVlOYuJ4LRoNuF+zk73qU0y97+ZFpT4xK69
 bvLxKlohVJGt1wNex+3TN1o+Qb/JwRe9+PwziVzg1bU+GmDeditoaV5fZFdHtogjTagwXAmkarI
 EvwWyDCDlbKIzQeRCJCUpH+X79B2FDmJ2ocyEpu+5jdlT79q4zl1ZlC0jYqFoYTKXQ==
X-Google-Smtp-Source: AGHT+IFdy0dfU2beutnOiaSLUR7ueS5s0ZLqXRxvaI8aZY+MNbF98PRL/wVpt1mxFtHHppG8P9+9BQ==
X-Received: by 2002:a05:600c:a45:b0:434:f7e3:bfbd with SMTP id
 5b1f17b1804b1-438dc40cf15mr105997925e9.23.1738357546296; 
 Fri, 31 Jan 2025 13:05:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c102bccsm5501317f8f.27.2025.01.31.13.05.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:05:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/36] hw/mips/loongson3_virt: Pass CPU argument to
 get_cpu_freq_hz()
Date: Fri, 31 Jan 2025 22:04:48 +0100
Message-ID: <20250131210520.85874-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Pass the first vCPU as argument, allowing to remove
another &first_cpu global use.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250115232952.31166-5-philmd@linaro.org>
---
 hw/mips/loongson3_virt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 45a524cca89..9f6fdd0f287 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -153,7 +153,7 @@ static const MemoryRegionOps loongson3_pm_ops = {
 
 #define DEF_LOONGSON3_FREQ (800 * 1000 * 1000)
 
-static uint64_t get_cpu_freq_hz(void)
+static uint64_t get_cpu_freq_hz(const MIPSCPU *cpu)
 {
 #ifdef CONFIG_KVM
     int ret;
@@ -164,7 +164,7 @@ static uint64_t get_cpu_freq_hz(void)
     };
 
     if (kvm_enabled()) {
-        ret = kvm_vcpu_ioctl(first_cpu, KVM_GET_ONE_REG, &freq_reg);
+        ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_ONE_REG, &freq_reg);
         if (ret >= 0) {
             return freq * 2;
         }
@@ -633,7 +633,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
      * Please use -L to set the BIOS path and -bios to set bios name.
      */
 
-    loaderparams.cpu_freq = get_cpu_freq_hz();
+    loaderparams.cpu_freq = get_cpu_freq_hz(cpu);
     loaderparams.ram_size = ram_size;
     if (kernel_filename) {
         loaderparams.kernel_filename = kernel_filename;
-- 
2.47.1


