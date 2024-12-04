Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A832E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvyv-0002hf-39; Wed, 04 Dec 2024 15:28:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvyp-0002ND-9e
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:28:15 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIvyn-0002cw-Jq
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:28:15 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4349e1467fbso1393715e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344089; x=1733948889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GX0z7ED1fpqqEX0e3FNGIrRnTBaZqIcam5D8KFO/APw=;
 b=TRTYqHQEIK04Y6ULZP4l0E5gbUgQjjF3PfhBSTltnjGYwpC/JHV4jAcApQSmXyCJCA
 W2zIRLb4VCipt856iw/ACgg71gUSPRwWnHC1+Tx4zFDQduIl98eO4zTbUOeazaEXemCW
 4GSC/z5Sb46hTUkXyFbux52R0A9C4G8gk3Us45PaI4kpvQGIw8QJ1aK0m2PL9AYBj1pL
 J4MnDOsCtfS+GEk+m9/D0yx8wMazQlltqJfRMXxiFxFKKczrhCbvqAUu+XsLsTrHVWRL
 V6J4tFj9LWGNYLslLXxIvGiyHk9cJDPzKJ/kQgCnJh0EJhP/Tfgn4X97F0/fpA1eGWi7
 SEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344089; x=1733948889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GX0z7ED1fpqqEX0e3FNGIrRnTBaZqIcam5D8KFO/APw=;
 b=KmGuC4JZbcuWWhwwf59UaZwqa77BRgV7XNkxcSdo/Qzj7JD29xaH7J4iKpzP1Fn1j2
 qhJNelo/OxsCM7oC5Hlb5/O6JnQZJZLJMLPFf2orLSWV6/T7VMyR3wo1lvMk7oaKwVzP
 zT0f+lE7Cc2/UXnZrMhzPB0628Roy8WrQLtZ+8x8zPvDOc4Md7WItmLlAX6kMg5JeBpz
 GuwZeXVcf6+0na+iJKUuv5Nospw/FiblPIZI9ECprS/+wRbgdtJuTSOZq61dznI2fq+N
 HNt/Q2M4NJQYOoF70EowCtT3lvPTNIF8miuIJjJNtTbL0Y7wDyibkbksDdnBqm2o98kF
 2vlw==
X-Gm-Message-State: AOJu0Yz5/EjUoVC6UysOrMPhSeBcGdDvI/TE9ktci9fLRCHrHnpybzgF
 IgPdO1/mqpZ6lCr0uocLUP0YxgHbTYs7Wn3HB//ZJ1AQZqgNyqedHpiSii6TJ2rdIdjH1dYwyaR
 C
X-Gm-Gg: ASbGncvPH2h/HskpUMJmDGeu0dSohlHePZk5ozxnC09L4k+eraRbEvFafzFuAM6vN5G
 /nS/teTENSgMLuF1neXsoILJtusC0G9TJxnJ9zlB1oGcpotT+6+2TfNQPG+fLrKKRvM7bLRTVix
 IK7NSRM7zuYuO1qYxITBM/ZZRF5QMDaduhqggylAPliUtZkXZowu1SJxXE2WXAZEaZ4SXTTBdJC
 HeWaCktN6MghFPsXz6hjmEkIraA4sfmr6RJX9fI81jWmcdy7y6EN+iL8VLL+CySrpwUJ/7mZa+B
 Hx0+2bGuRqpxqgzC8c50gA3C
X-Google-Smtp-Source: AGHT+IFQVlgKgXzi+WHSeKykqO09/qxwXPFKjgqPF3MN1t0t3YAGqhk0OGIb3lGnnbvtjy1rKap/lg==
X-Received: by 2002:a05:600c:19d1:b0:434:a4a9:5d54 with SMTP id
 5b1f17b1804b1-434d09bf794mr77784015e9.10.1733344089220; 
 Wed, 04 Dec 2024 12:28:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52c0cfdsm36598115e9.33.2024.12.04.12.28.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Dec 2024 12:28:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair@alistair23.me>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 16/20] hw/core/cpu: Expose cpu_datapath_is_big_endian() method
Date: Wed,  4 Dec 2024 21:25:58 +0100
Message-ID: <20241204202602.58083-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204202602.58083-1-philmd@linaro.org>
References: <20241204202602.58083-1-philmd@linaro.org>
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

All target implement their CPUClass::datapath_is_big_endian()
helper, we can expose the generic cpu_datapath_is_big_endian()
method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 8 ++++++++
 hw/core/cpu-common.c  | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 91c6581f814..5c75fe3a842 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -611,6 +611,14 @@ extern __thread CPUState *current_cpu;
 extern bool mttcg_enabled;
 #define qemu_tcg_mttcg_enabled() (mttcg_enabled)
 
+/**
+ * cpu_datapath_is_big_endian:
+ * @cpu: The CPU whose state is to be inspected.
+ *
+ * Returns: %true if the CPU access data in big endian order, %false otherwise.
+ */
+bool cpu_datapath_is_big_endian(CPUState *cpu);
+
 /**
  * cpu_paging_enabled:
  * @cpu: The CPU whose state is to be inspected.
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 09c79035949..92c0c4c6125 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -66,6 +66,13 @@ CPUState *cpu_create(const char *typename)
     return cpu;
 }
 
+bool cpu_datapath_is_big_endian(CPUState *cpu)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    return cc->datapath_is_big_endian(cpu);
+}
+
 /* Resetting the IRQ comes from across the code base so we take the
  * BQL here if we need to.  cpu_interrupt assumes it is held.*/
 void cpu_reset_interrupt(CPUState *cpu, int mask)
-- 
2.45.2


