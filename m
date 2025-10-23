Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A4FCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtnT-00086U-6u; Thu, 23 Oct 2025 07:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtmu-0006Ha-Kb
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:47:25 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtms-00023Z-QW
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:47:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47495477241so5785305e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761220040; x=1761824840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYEkDKuUtDiIDypQqJeptd+MMxIUvh06oL1URWY/YY4=;
 b=a/fIixeeUnJxEJPzxeF4R84t8pTZg6iWrUWP5acbqxvBKJ6/JxsiWpq1HJQIvVmSOX
 Q2ws39zRUq9O4cG4kEGbiHTptPk4Bz91TgaSJVvL/aCxLdS3BTy0E035qumDTI6BcS7h
 IM7cOFuvaE8lFLfLp+rN+zHZ39mNGfCe192wiIigqU4yDr4jWndcB/l4jWuByGgrmIb0
 fegPav8wK/8VuV+3uKuRPGi+0sUxeNZywIwz8CjBu0DtTLLyrkV/ywD1rygUqTIwrbHi
 X8370bj40fczUhk6MWuzaak0Q1LopNTvDy2H2XchUsOtYFCBEQCi8+aT1spxmOkh49s0
 MIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220040; x=1761824840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rYEkDKuUtDiIDypQqJeptd+MMxIUvh06oL1URWY/YY4=;
 b=ohoTL43XNzVgqzozCy72EQJkyYS91xRK+etaIwHmsoYSpikbosZmdzikNBee12IMkQ
 S2OQ+hpMVETVRzyzIcV2rG/voIQ2s243SOGcJNnf27Mhhf8cs9iMhTbptFRKICrOQqX8
 gww3NtJ1/af0ThxKENey0fqcEnjoxbhIFL/ql7h9x3zAYOPo3UinmXlzl81Jt9mjQeJ4
 +U7J/HgEx6sc7BsQDBmuZqPcN0I6bNwygYDMzVNmVQ91oN3MlVfHykeY6SXWoNiffBsr
 F5EN6cL9MZ/9D2LyataFe+Fe/fEYq+x3dFe6DGRjxeSTwsHYwGE+WGYIgZfizG0gqCcf
 g7Kw==
X-Gm-Message-State: AOJu0Yx741T7Fo2mvFsyP1la0HP+x6h/47j17UE8Iz+Fd6/UJEiTt+aC
 LnCd8LVpVxp7aS4xf6L+ucEs6UqnD07peXzneiFTI7pj8moJdQzUVfwL/yrInJPGWQgCIdfBmSs
 katHE9Rs=
X-Gm-Gg: ASbGncsXsRFk+vNoVcTqxrXuTB6LtyTiwWj5S+M6UHLU3fH3aS4Hle4Hi89FL8H7OY0
 7NCgv4sA3QX6wo+9KM2x7JFfUJ9lQ9IIzsgV7UTpgUdBkRsOAQUDaXdDsgZBwNEV1nPD81EI1t5
 NiBOmcJWGzkGv5rZpmlAnIWChzwxh8qEVV+RxBpe/anbZZ/lQi27Mid6s/TNDKVOBK6YFeEXs8v
 aNMIY4skCUxI6Nbb7X4mQsNb3vH/l2xpvRF5GX80lNNG1qqAJlov17RFbbcjhrUYPR7RPnGo1/d
 0YQMDMTrJ1frE6y9EHgg3Fe+28NcFeephn7sOOCETnIlPLUwL+wYm2jTZo1d+LGOL41cXg8erzh
 IdTttsZCvwxcj/bqVZmAU0bk05MDFkz/geQtVgMZjrfPU5SKYRkYCLjt/NzIdsV0LnGgt1FORTK
 Mzc+8+/QN38JykVkWrIEbeZPi5g0wvHFtssHUpr4UZ5B3fHcmliw==
X-Google-Smtp-Source: AGHT+IEhCa8nWJvZxaZjBO+0dwM9Zo+hrjKGJMN8shQIydDxpRkwClXOwpsN6LKP9DFFgH5B0VHDPw==
X-Received: by 2002:a05:600c:1d15:b0:46d:d949:daba with SMTP id
 5b1f17b1804b1-475caf93244mr15127945e9.4.1761220040426; 
 Thu, 23 Oct 2025 04:47:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898cceebsm3538175f8f.37.2025.10.23.04.47.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 04:47:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Collingbourne <pcc@google.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 08/58] accel/hvf: Mention hvf_arch_init_vcpu() must run on
 vCPU thread
Date: Thu, 23 Oct 2025 13:45:45 +0200
Message-ID: <20251023114638.5667-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
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


