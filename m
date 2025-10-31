Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D69CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtx5-0004um-1I; Fri, 31 Oct 2025 14:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtx0-0004tV-KF
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:14 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwT-0006ET-2s
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso28309905e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935614; x=1762540414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XYmvxURxPONYpllqUnIy8FBLR5WOckrc+aRse284MPM=;
 b=GuYv2l3HVBxdzdTZAq/cV0ZPIqkprR9G+agEyEN5X3CA3EO81OklGe0MpvHx1SMcgw
 D91PGfT5Tw0b5MfnfTmLQrIb2LuAGFKXUEKP5D6pZ0Ar/vftN8NSh9EV3LuO3gg1GHwa
 CfBxaD8HaTOV4n5phVzWSV2a/nS9chtCGEUgNBZuQpcYTutrLAO249X4FtKe4fBH+F7z
 GWnZWeaYbVE9g29k2kb8fBxuAUJ/TJwSH3Rjz+MwdJiL6n+EeGrhKeT1KbJ40K22URFc
 EyqFARi/n6XRsGbkTRxCrPT4QHv7ffxZacMGuX9ivu5eBMU9IQOeN+8farHtH0aB7Sf8
 qaDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935614; x=1762540414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XYmvxURxPONYpllqUnIy8FBLR5WOckrc+aRse284MPM=;
 b=HoMk/qU2YkEM0RnV2cvoJNHwpEc/sds4+549ajYfa8pEqm8qa3Jd3Og9ZRbBULn1WJ
 vEGmCsQIPfDZhyU7y+B1EPyL3Wpu2v4n/aJW/+Z7ib8XEKZZjbUp6lccZPN3NPcVNGJ/
 wvdqu4v5JcbSUKETD5rNMQCl7NPRSl46SIzpGx4VEa3WsvjS2vMLAVfUtnbnQCzJDCb+
 vbLVopFXearPaMNj5FHwubc9nQuaKxMf8N9rzKQRIXrkxyLgEU+SiVj3U+X8+5OXnvH5
 TLpZ5qEH6iENh3A0WlYiPgeLthxzrUQx7PnZ3JGQplUQzyq7dolIw70KT+g0V3tRw0yo
 BGsg==
X-Gm-Message-State: AOJu0YwLkO9cNNwvVUgAGXx5yS9colrURQIQg1lknCYg6Lr1MnGhNUH9
 9zQxokwZqaneN9U7i9oJjdfB92mGezjFj9JQAhI8nnVGNf6v1aBFItUFi903bmRXXPtb6ndBh0S
 kJnzO
X-Gm-Gg: ASbGnctU63+AjkIu2/+zlc6X+qCvWUoqZV5KY1BSMpCyNzfQNHJyutMC8ZTgOZvWsGT
 xHjXlWFejhesReiDQdi5L7Xo6VJ4d3gUbrlwIvrBimIYO2u4S/jsiJ3D9ejop8KC1N7+4Id/5tr
 ZZZrqCSrgdHmFRxJ49JLf3zVbFX+eaQILFB5rkz1Mv/zumzRfyw7QnEugIzu3l9E3JM1yAqUnQz
 /FvMCEGhVGVwv3tXFaOgTRuvqgjBFOcEvUaqdb4nj39lZ0SoUnFGsVzgt0qTkGMhknw7Zlg6wPW
 B5sWrPd7wqlVZKrHFbtuk5UlXtSCqyu5PVgDKu1KOxd5QxZeFGRQEki37uikOwRvcfBIkJgLYig
 eBKhgV8mShen7zY1yw78Hkrt/jDOYvTg4Y7OrEKwHENktbHjW9Qcun8IaPMe95iqZpApICNnAy5
 RwHbOK+A==
X-Google-Smtp-Source: AGHT+IFK4UblqWtn6XTSyDXYIqPfPnpuiWstSPz6cz+af8XrotbDF5WGsTCrf3TWTTs/fQIgnQNw9w==
X-Received: by 2002:a05:600c:524f:b0:471:c72:c7f8 with SMTP id
 5b1f17b1804b1-477308b6117mr45059175e9.21.1761935613553; 
 Fri, 31 Oct 2025 11:33:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/38] accel/hvf: Implement hvf_arch_vcpu_destroy()
Date: Fri, 31 Oct 2025 18:32:53 +0000
Message-ID: <20251031183310.3778349-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Call hv_vcpu_destroy() to destroy our vCPU context.

As hv_vcpu_destroy() must be called by the owning thread,
document hvf_arch_vcpu_destroy() also does.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/system/hvf_int.h | 3 ++-
 target/arm/hvf/hvf.c     | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 241c668795e..195d64dcf18 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -71,13 +71,14 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
-void hvf_arch_vcpu_destroy(CPUState *cpu);
 hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
 /* Must be called by the owning thread */
 int hvf_arch_init_vcpu(CPUState *cpu);
 /* Must be called by the owning thread */
+void hvf_arch_vcpu_destroy(CPUState *cpu);
+/* Must be called by the owning thread */
 int hvf_arch_vcpu_exec(CPUState *);
 /* Must be called by the owning thread */
 int hvf_arch_put_registers(CPUState *);
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0d8ff49ae15..d13ccf5508c 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -868,6 +868,10 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu)
 
 void hvf_arch_vcpu_destroy(CPUState *cpu)
 {
+    hv_return_t ret;
+
+    ret = hv_vcpu_destroy(cpu->accel->fd);
+    assert_hvf_ok(ret);
 }
 
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
-- 
2.43.0


