Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F30CF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swl6B-00012W-CP; Fri, 04 Oct 2024 12:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl60-0000vM-LG
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:24:02 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl5w-0004Xv-Cu
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:23:58 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5366fd6fdf1so3343835e87.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059033; x=1728663833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nhw11vsNB7sU+tP522HMuXKhN8uIssw/t+jNogdyCDQ=;
 b=JSCsNJ4/h4mDFcEIhn6sh/a5cHlTQB0CClsvKocKhtPvyhyblvIgqCujFye5hkL9lC
 P4HGffO9jgJf/A3qRR+AUliJMiJ1vvDTpBAEEpO4bJy8DgfTUAMMi3M3aiOkwy8wkNlJ
 T6XDK2shCOscBdQjIaeBIzFTLvig6SBCHKtqdTEmn3q3cmjpDN/LqrPoJp9VCf1nsE0r
 JmbEM1eq6FynZsw93quaNYNC1jDTPNfIPHSunCwGpbTFZB5bKjHZnehhxtLWk6Wp5145
 F66b2OaScIJ3gzd4NvFlEBWVMPF5jENLCZZaE7oYbi0tM1lm79ULgYTDppaJWmWhBs5K
 S1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059033; x=1728663833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nhw11vsNB7sU+tP522HMuXKhN8uIssw/t+jNogdyCDQ=;
 b=ZM2bfjzkD46huaIEwicHi+Wk2+PpuGQisohq9bwM1ZMAMj5+8Czia5VKPi8ZzEVej5
 3Z416jimIIS/AAi5A6lprCUH++uBtPJsLgW6PFiqEA1tRuA0a8rf/YjMo0WZvbm+uRw6
 mpFOcIM2/OcIwuV0dZb+ZANEF+9K2xVEjBp30OJY5CoWey6ZK6nBN5jS/ye3UKAd99um
 Wz9E5yq4xyjzGBlCD2K/PWknfr1Xif6eFvk7uoY+g3KRU30CXgC00i+z6ExyicDaAm57
 aN8EcS4fd8FFwWhpcBmQG3WTcflogdmT1LdnBXomloj/W0c8WW1iwQltVGgmXWnJ/pgx
 YZmA==
X-Gm-Message-State: AOJu0YxxYpNtOnUo+l9PSamYjp4CUAJO4N1jtS4F3URGmiv9sQpzu0RR
 x+EeSk9wQik6UnJfscsL5+G98VB522BgCsEzgH8jBjuhKg2UF6LrKSH7DdJA8AKX7LdrxuGpnE8
 9urJKmQ==
X-Google-Smtp-Source: AGHT+IHWTTiAZOwthxRrD0LHwYIRgQaHTbQjlLwjBS4Gzn+++9wvg+ZcwP4Fw3jRdEsMVW1LFfnmoQ==
X-Received: by 2002:a05:6512:a96:b0:52c:8979:9627 with SMTP id
 2adb3069b0e04-539ab84a43cmr2465175e87.3.1728059033509; 
 Fri, 04 Oct 2024 09:23:53 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539afec83efsm684e87.75.2024.10.04.09.23.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:23:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 8/8] hw/core/cpu: Expose cpu_is_big_endian() method
Date: Fri,  4 Oct 2024 13:21:18 -0300
Message-ID: <20241004162118.84570-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004162118.84570-1-philmd@linaro.org>
References: <20241004162118.84570-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 8 ++++++++
 hw/core/cpu-common.c  | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 22ef7a44e86..2550bc98dee 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -608,6 +608,14 @@ extern __thread CPUState *current_cpu;
 extern bool mttcg_enabled;
 #define qemu_tcg_mttcg_enabled() (mttcg_enabled)
 
+/**
+ * cpu_is_big_endian:
+ * @cpu: The CPU whose state is to be inspected.
+ *
+ * Returns: %true if the CPU runs in big endianness, %false otherwise.
+ */
+bool cpu_is_big_endian(CPUState *cpu);
+
 /**
  * cpu_paging_enabled:
  * @cpu: The CPU whose state is to be inspected.
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index aa5ea9761e4..277c4ee6720 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -66,6 +66,13 @@ CPUState *cpu_create(const char *typename)
     return cpu;
 }
 
+bool cpu_is_big_endian(CPUState *cpu)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    return cc->is_big_endian(cpu);
+}
+
 /* Resetting the IRQ comes from across the code base so we take the
  * BQL here if we need to.  cpu_interrupt assumes it is held.*/
 void cpu_reset_interrupt(CPUState *cpu, int mask)
-- 
2.45.2


