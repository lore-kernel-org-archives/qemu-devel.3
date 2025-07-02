Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C996DC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2ew-0002Zm-Nz; Wed, 02 Jul 2025 14:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2el-0002O6-Oy
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:08 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2ej-0002kM-EZ
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:58:07 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso5024137f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482677; x=1752087477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOj2l0QjwiOWVtDmZos93I73sy6okOj775eGXYWLug4=;
 b=synLrVvpxC75dPSiLgmo+afK8EobBuu8I4EW6gmJdaNYklWw0H5l+3YxKJkugOsgZO
 KwvbGGPNAgkprIrwy0/hLLHEzzBgDjFHzCg+kUrZ1WOHjPVJhMnusFIbqwtJDEyXJ7+Y
 snRl8qnVoLZutlHR3JOsjDBrkHN5lRSwyh//+WM0qaS0Z69C0+C6T6ulEQaNvdiiy1CN
 S7hmAgO5QKh7t4klzkeZXF8RWAUxlbYDPsg/A9rcjIYXNksVFIuONaml8XS2Pna2Y+XT
 BtuUEBRKYVWsyxfadfXHedDmDTk8OciHDgADBrqimJIQrm/PZtPWMCyowjQW+uH+kLr+
 s0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482677; x=1752087477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zOj2l0QjwiOWVtDmZos93I73sy6okOj775eGXYWLug4=;
 b=C947wjAzVw3KvtzkstTCBtsNaOXtYpAIrIEoKjlEadjRzmS/HlCpA9sTQYgueMztBS
 K1ywnlFymyILLEN3JQ1RPH+4+LQgEXdMoPMVkSwS1EAwvC9bIoUQHG6v6AhyLbDmsOHV
 RBuaKwL2vaQ5OgPpseSnrRUSKnhq+1nepl7jpLid7IaabEk/uh61neiZ5GkdLY65V1AC
 CQUHt09e4MquMvk7FShB48XGtXJGordQtmEcCXcN+Hl0FtiSmQwZOXgW9HYjZov8hvrs
 R5UqNWuKsJx+BdBSdO6h+9eltNKC1p85/locmO2TZnzRkxGwwbS3sqk3i17QkqO+XluN
 Of9w==
X-Gm-Message-State: AOJu0YzCPaiDfkodOK8CUTYKgV90wPORek05bv2x4AAsQhcollkGd9AG
 6tVVPTW5JwQvPMAs7DjtF4wHaUHGjiOo3hP9OHdm8aUkRpQSO9uzk6EGmdHicyVHaWiFb+nZtmw
 YFRvN
X-Gm-Gg: ASbGncvMZxLsW6mhywIN6FOUA0qWIQ88Mkp19gRaRXltJXA1aE5zns73QiW6n5/D9H/
 u+NS3QLwCpQY5kH4I9tki3pLQjmzdmJkQJ+25j2YDnjRSFuSod5E96i3ht3FjLHcblP1Nd18VH/
 m5qDJfDOflrKnmqJ7hRzOB1vxzBxnyGgArFV/NS16jy67CU8TPV2/FZQeAGt1PBICke66FcAtX/
 uTBkilSnasT3I6o80/nLfXar/i8ajb6KGbdj00ABPlT+p5FL4XaIeo01mFKhZYXdruvwRtXb2wN
 tz/3VyKzZMcK6M1kLUrcPt5j7JNVaNeKFM6p68H5KKkGRQhEKobtVFMHr8f8Zhaz1ipwkLCvGKz
 Ott/bTOPY6q+YBGGLUT1AJ6PCUMRiu8Ixbq6T
X-Google-Smtp-Source: AGHT+IF6RqLjg+vn4QGMC4sTXHfVfU93wY6vxLMBCeNTzfIOZZe23lOIWbUk4TcPLqEvHidDXetMCw==
X-Received: by 2002:a05:6000:4408:b0:3a4:ef36:1f4d with SMTP id
 ffacd0b85a97d-3b20067c8a8mr2567192f8f.38.1751482677289; 
 Wed, 02 Jul 2025 11:57:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a99b6d6bsm5505475e9.31.2025.07.02.11.57.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:57:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH v4 36/65] accel/kvm: Remove kvm_cpu_synchronize_state() stub
Date: Wed,  2 Jul 2025 20:52:58 +0200
Message-ID: <20250702185332.43650-37-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
to accel/kvm") the kvm_cpu_synchronize_state() stub is not
necessary.

Fixes: e0715f6abce ("kvm: remove kvm specific functions from global includes")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/stubs/kvm-stub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index b9b4427c919..68cd33ba973 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -29,10 +29,6 @@ void kvm_flush_coalesced_mmio_buffer(void)
 {
 }
 
-void kvm_cpu_synchronize_state(CPUState *cpu)
-{
-}
-
 bool kvm_has_sync_mmu(void)
 {
     return false;
-- 
2.49.0


