Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A37C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCq5-0006HO-4J; Wed, 15 Jan 2025 18:30:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCq2-00066h-Ra
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:18 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCq1-00052X-91
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:30:18 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso270003f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983815; x=1737588615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lQE5apo0BwOCfvKDAYCRzW+MfDklvN0VdczsmfqZ8+c=;
 b=g2aXa7dTkqWaCOGs3xMpKwOIa4gh63hN0eHbpPgcbDPNmr90aSHOmHkaxt1qNuctEc
 I8oqfZz6RuDW1T08xd6yZDqnIhFdOcM28YZUXOU16JGtavUFrGB+DscKsjq0xaaQUmkM
 GFJDK1OA2Vb1Xh6FXUA8i8JwnTJ/15/rGkJPc+2Zcizew3TLFR124lHiD5Whtig7kofu
 NX8392GB4sMTrnVAGNIsYXvPoGp61jIHlF581mRpqaeChk7/uNqkjputdoEJF+95IrKw
 b7TSWBreQbu6gQ5VQJxRxypZeG0J4Suvgc+YuvaO5M5YQg+lw2PY+pkP7FKlk2TTM6eQ
 7y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983815; x=1737588615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lQE5apo0BwOCfvKDAYCRzW+MfDklvN0VdczsmfqZ8+c=;
 b=B+5W+g0C7c5sjk7EcbFRVBwvxbZfAIhk9dFf7BdLGOtk9wnNnA4FH2QTcquJA8sWT6
 ZMZdcY9kPIcRANWe4FUUqZDcY1Uk6pw0OmnKeeUQhQZVaR7GtOT4zyN3K1ltNftlhv6N
 JxgrtoVHLqRoisFPk4fOoQjGE3JPL4rUlK5KcbgFFmJcYazywnUG3jiPxjssYEAM9DnU
 n/t0lg0uvQ6y3WX+2rKGyFqMP5tlX7/XqcDROdoIKO2gBfSRtzAoGxb3Rg6Te9BAoS6V
 H5DUMwloylRTTd/yS3dXzjp5333H/kP5xQfCoLXdzDbS7lwymM65bW8z6DFDD5GcdU5H
 ZfxA==
X-Gm-Message-State: AOJu0YzhrYu8HxekkhzQ8yeI2Dl4cqdAIeV3kkcwkRAIQlpoD8W36ynV
 rfyVh7bnLQh4kmG3NBBEGp2EXMiiXFKqWwvrV06qVWDL/DTucgy3socs60aovNoiHzuabgwx6p2
 hAZk=
X-Gm-Gg: ASbGncuStcKSWFE6Blm28NXWPJZaQoZrmhBnq+6Bk4ZdiWtVe2K0lw5zM2K+xafWbNX
 uVWLr9ry7AvKM7GABFRmGWM/rpWwLCa0Zk674sl18Xj8No50CMQRKCmzovy/ihHRDgJLN4XlIeQ
 YF2GgfCLdDeFcenA9B3hWLEUN++IrCBWPh0aPY6yw1bEt+EFK7XPC+pJosy2HydEAFIoxinDAKq
 QwBjXa55zI3rwJGyVN9lSeTiY572fKH/DKR8sZV12x/tiMYq/5ai+CL0ftOkEYXsdvqp0fMF3yb
 /VzMHDtI8DJwqxtxjSg6YHDKIYrBV38=
X-Google-Smtp-Source: AGHT+IFlVLkcGIhwUJu3Yrlfva+Jv9uwjPcqHOeDjhlAm5gZICd70ZEhCL2aObmd1Nb2cNDe/vXmhA==
X-Received: by 2002:a05:6000:4618:b0:385:f560:7916 with SMTP id
 ffacd0b85a97d-38a8732aeefmr32441179f8f.35.1736983815580; 
 Wed, 15 Jan 2025 15:30:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499932sm38704655e9.7.2025.01.15.15.30.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:30:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 04/11] hw/mips/loongson3_virt: Pass CPU argument to
 get_cpu_freq_hz()
Date: Thu, 16 Jan 2025 00:29:44 +0100
Message-ID: <20250115232952.31166-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232952.31166-1-philmd@linaro.org>
References: <20250115232952.31166-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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
---
 hw/mips/loongson3_virt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 1f5952d7082..9c2001295d1 100644
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
@@ -632,7 +632,7 @@ static void mips_loongson3_virt_init(MachineState *machine)
      * Please use -L to set the BIOS path and -bios to set bios name.
      */
 
-    loaderparams.cpu_freq = get_cpu_freq_hz();
+    loaderparams.cpu_freq = get_cpu_freq_hz(cpus[0]);
     loaderparams.ram_size = ram_size;
     if (kernel_filename) {
         loaderparams.kernel_filename = kernel_filename;
-- 
2.47.1


