Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAB2CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDcZO-0007jg-Ms; Tue, 28 Oct 2025 01:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcZL-0007iu-2C
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:48:31 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDcZI-0003bY-1V
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:48:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so49703795e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761630504; x=1762235304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYEkDKuUtDiIDypQqJeptd+MMxIUvh06oL1URWY/YY4=;
 b=Uy9Hw0noKAobPRyjBrzomsRiZkyS+L41V8dqQZKNMQt8VKqfkyHFUjk+OoYX93y8bc
 mwDCzLljP6M2H+Lm2zVCaTrgc1xp8U/sAPWAQP2YhE4Gy9eWhghBhe/juxHP0Obw/Zs6
 1E8RrQox5GDG3a++LeIoYKCKNNFhTOp7+BKUA1Wr6nSjpwbXTUTUygyIgEjNPn/jcSFa
 re9FxWkiD5Xn9t2FIsfypNbFKrrcWLxOwD9clJnAAcStzYVGTl+2f3XWZiFa1X0jfbEX
 y6mfG8FomyiUtjWp/R8Ol9wxQv+OuB5U1TfvKN70v8L/UUzZNN877y7tXV1EM0SR0LB1
 EqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761630505; x=1762235305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rYEkDKuUtDiIDypQqJeptd+MMxIUvh06oL1URWY/YY4=;
 b=Fyc+R7r54gu/uZ4s/9YuAmXD7A/w6y9EGMlcSaO8jh+UHi2WMpG5ytVQnl2T9CL+QJ
 vFdBdaZcvCF/Dtyiwyf60RI8srlYK73Ws1tejNA8jqxzkfsAb7INoNztV9j1LymrnaDr
 dPOAAbc8HCp9h9f341X6b9iGPlYMn3wzywvhmowwDuNBrTqhHVtWqnDBsZcyWdRcMfFN
 liyxBQTybMmUuVOrNua0AXgKYYLBV7n7QRBlpYb6/rWTxTNGFXtORHnHgOZLrQ5iy560
 Kg79quiulBmogkAyrAicRp8NCxByGYZKAG5G4Y/Oio30lLC0AOPgrc65RjDHsngLZjpJ
 zxnQ==
X-Gm-Message-State: AOJu0YwkpjHu/ejaTtuXojdbuH6a+LZeExjP/w0d+meeaNVhv1BkTs5c
 6J4v8Ez1DQt/cS86UpRjZgCIVqomn08KnuLPSXLasl686b9ta3XhH/HE6x2SYyFXo3Q+v91/BvO
 rhZ6zXIw=
X-Gm-Gg: ASbGncuMtYH9jGnpkctPmLGCXJz5WD6QPKjavEeiq1kAL6JEO/xE26ISkCFSostObhF
 tr9EZUJba+McsvU820o/INjJu4admJfzSXeEMChVlBPdsg7C/CCeUcLJA8HL7ChyGdzjhH9ypvF
 rUZZzoiR/M7WJO2a4ubJVgEQ8+jj3e1ZzFkPaqZB4we2gGJP9eQULhaDM6FmYL1AXB2uPKdOFU3
 1RCQKx3Q0seQPPgDqhD1TkCcD9Rvr4ttqQrPSOhCt9Oy+GHo4830B2H6W+WGMB0NdfCLMvGAz7L
 +pcxhuEszRgy16YJOqXtI0JleVlCtMnMYoXOf34VknzEA87ErJO/p3qUOJruCuA2Mhb89fOgBC0
 7Yx4oK/bKUayCrRQz4B1BPh75BDCKjY+12IPeuciF1Cn7eXMCzfzXuOwTJu3vdYRtokxJUrzqfJ
 lOt+cBh3uFrhK+6CJ3x6hKt91T9T+g6cIDXgRogw4YYwosA9G/7AoCIYE=
X-Google-Smtp-Source: AGHT+IHM+kAezokZJtXoKMzXP0KEVS/yoTTQJemYR75pNp81Qss/46nC8PYy1BpmidoU8Dm42Rf2oQ==
X-Received: by 2002:a05:600c:19c6:b0:45d:d353:a491 with SMTP id
 5b1f17b1804b1-47717def79fmr16592475e9.1.1761630504585; 
 Mon, 27 Oct 2025 22:48:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475de57b156sm164744945e9.13.2025.10.27.22.48.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 22:48:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/59] accel/hvf: Mention hvf_arch_init_vcpu() must run on
 vCPU thread
Date: Tue, 28 Oct 2025 06:41:44 +0100
Message-ID: <20251028054238.14949-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028054238.14949-1-philmd@linaro.org>
References: <20251028054238.14949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

hvf_arch_init_vcpu(), along with hvf_put_guest_debug_registers()
and hvf_put_gdbstub_debug_registers(), calls hv_vcpu_set_sys_reg(),
which must run on a vCPU. Mention they also must.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 include/system/hvf_int.h | 3 ++-
 target/arm/hvf/hvf.c     | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 8fce627b08c..0c335facc3b 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -71,11 +71,12 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
-int hvf_arch_init_vcpu(CPUState *cpu);
 void hvf_arch_vcpu_destroy(CPUState *cpu);
 hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
+/* Must be called by the owning thread */
+int hvf_arch_init_vcpu(CPUState *cpu);
 /* Must be called by the owning thread */
 int hvf_arch_vcpu_exec(CPUState *);
 /* Must be called by the owning thread */
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index fdf8df09d4b..8095cb0805a 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2119,6 +2119,7 @@ void hvf_arch_remove_all_hw_breakpoints(void)
  * Update the vCPU with the gdbstub's view of debug registers. This view
  * consists of all hardware breakpoints and watchpoints inserted so far while
  * debugging the guest.
+ * Must be called by the owning thread.
  */
 static void hvf_put_gdbstub_debug_registers(CPUState *cpu)
 {
@@ -2157,6 +2158,7 @@ static void hvf_put_gdbstub_debug_registers(CPUState *cpu)
 /*
  * Update the vCPU with the guest's view of debug registers. This view is kept
  * in the environment at all times.
+ * Must be called by the owning thread.
  */
 static void hvf_put_guest_debug_registers(CPUState *cpu)
 {
-- 
2.51.0


