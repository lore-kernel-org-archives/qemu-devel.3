Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE59CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBv22-0001ed-Kg; Thu, 23 Oct 2025 09:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBv1z-0001ag-8S
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:07:03 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBv1x-0006Li-Cu
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:07:02 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-426fd62bfeaso398924f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 06:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761224819; x=1761829619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+rsabIigu6ZJnpLHCrRrLyKuMoQRw52Umv/dM+Zp30=;
 b=jUopyDBkRSqhs0VxKr4t7L1mvxivATRgJIeaMjtIecllx1/4Ptf5yLvj1wgoWL1t4Y
 GUm7rDpxBKmaSTvNCmIKYj2fcH8ZunGnffKiErqqsfwEsfg0va2a4Eu7otSIThDrWcCT
 12qrs1JKDyXTHYfVWyLKq5beyRDuMT6LnRnW5XxpIq68srXcDx3A71y6opG0mvE8Rby1
 xY4klzBXyxkwVQFOtjqAAzcBKag+YPq3icWDL3GWhvWW0x0DPa7OLnEp3YmRdV7TreCt
 ALPicvRKMJMU5ORDvumjJl26i5qk7UgH+XRj1805uJZ+kbJoQy58nmf0ufM89WQtVrQE
 abLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761224819; x=1761829619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4+rsabIigu6ZJnpLHCrRrLyKuMoQRw52Umv/dM+Zp30=;
 b=fZ+QIB0CcaTQ2BfRe4pVadEnXMOQ20O38XtXIeNy4io474GLQYjXFE2OLweSRXET8r
 oG5RsHnqm5mm7kOF0P2/IQw1yBIDSO3k36zhQV4+/KR2suIP3TgtHExnVzPvYIMdGI5d
 Z3G8cLfYYoUCN1tdWO1nb9p/8kEigQUvgs9LKx20TlAU+KxtrJ9vW1I3e6hAsrBb+dTb
 cE1cZm96Wgyp4h28PpwtBik3EvV79h+J4cSPblxM5OE0XVMJQHmgD1ARQh/83Cd8ZYOr
 ApEHv4Ov34jsitXBcl2l4oIGobInTW03TZ9TnGfFB+2+ha85/Oj4mGoK1oOudNOk4EXH
 eCRg==
X-Gm-Message-State: AOJu0YxRY7usD7EVVQmKHuE5DR4Oz5eQ/8YX0sJ2g+Tg8uxzmiU8CVIv
 fzvtDT8NsYkxF0YyZGL57vsLSXJbM4v+6HJxMayymvkulg5IcKz/+qhem6jTVm1eJsJBBcTP04z
 rQ2vefUo=
X-Gm-Gg: ASbGncvrlb860DpI/1VGB5YkJeTyW3fpDHCL+D+jTQLSZDucRop5H2PaWsmVj1dLb1c
 lDaImCYDnLhSH9MFHD44lDEgBFsaNk0u3Ns8mA40QcUawQsoQgavALo5wkonXM+VNs9ace4SWcX
 Nrg6OB6dKRcYtz7DOZ8FsDvhfl6peiBhS7nBRc3WU1NwlzP04sZQajIrhaRazBQi68fFWpD5mED
 yr/bv4KIB5bo5U+PDUxSIYIpWWrQRO495CNQWI50uj0IDp+MLev0CXR4J0N2jNLgC0hL6k+h0Jo
 pAk66oT7edYRY4AfRRsFr+Smkfn6n1da9KlhsutdEuEsTz6GnuhzXPNa0/I+iqh/7GEzam5RZ0Z
 Rb6D41p1nMjdobQ73S8bR+A5vUESQ3pzx5q09eiW8bEUMePkDrFRddCwoa1aauT1fgqds9M72Zn
 FHXmvjY5J4VFGurbl7cvmXwUzJs8rsKiaBNoT5UxdYgY5ocx1wBw==
X-Google-Smtp-Source: AGHT+IGujqbM2RjXJVAlLc70jZzuclKeSYJAFCyTf0DJOu/4srF0T9E+27x0dv/yqZGAmaStfXL5uA==
X-Received: by 2002:a5d:5c89:0:b0:426:ee84:259e with SMTP id
 ffacd0b85a97d-42704d558a5mr17702757f8f.24.1761224819006; 
 Thu, 23 Oct 2025 06:06:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897e75a0sm3907266f8f.5.2025.10.23.06.06.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 06:06:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Collingbourne <pcc@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v2 48/58] target/i386/hvf: Flush vCPU registers once before
 vcpu_exec() loop
Date: Thu, 23 Oct 2025 15:06:24 +0200
Message-ID: <20251023130625.9157-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
---
 target/i386/hvf/hvf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index de5e8b45d19..8acdfa952c1 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -724,6 +724,10 @@ void hvf_simulate_wrmsr(CPUState *cs)
 
 void hvf_arch_cpu_synchronize_pre_exec(CPUState *cpu)
 {
+    if (cpu->vcpu_dirty) {
+        hvf_arch_put_registers(cpu);
+        cpu->vcpu_dirty = false;
+    }
 }
 
 void hvf_arch_cpu_synchronize_post_exec(CPUState *cpu)
@@ -983,11 +987,6 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
     }
 
     do {
-        if (cpu->vcpu_dirty) {
-            hvf_arch_put_registers(cpu);
-            cpu->vcpu_dirty = false;
-        }
-
         if (hvf_inject_interrupts(cpu)) {
             return EXCP_INTERRUPT;
         }
-- 
2.51.0


