Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F40AC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDSB-0007Vz-36; Thu, 06 Mar 2025 10:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDS8-0007R1-LN
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:04 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDS7-0006E5-3E
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:48:04 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-390e702d481so459968f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276081; x=1741880881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xl77zu7UFkgjzNSNZL8yu/Xtui1L+RH1bzoJQrDO/y0=;
 b=UtpyE2533mn/PfGYekwnwwQGmecxETh8Crsryjh6dC4MX6JIh02bdHKqP2y9BYUYbU
 F04cmFXpcDF5MuQwV+AWWV8HGsoQsUjkpX17IPZAdF7uUDvu92v82BbukGKWlAZEWiog
 PIYID9IW94DeGQC3Gt/zWH3UUbKYSC855r0u4jgliqYS/4KDFcI8+UH54RkQIT56Qn0d
 4XHRhTxMO9pHReZ1ScfUtMJqKzfCQAf9KNoMg8QM67l2PATVWswxYLWfQyuywTWSIWzK
 hX/lzevaYexMm/B8J1O2MH3xisSyx4omfeNKTfnpYSNorm4PGoasteKCD4K1hZHscPoA
 XV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276081; x=1741880881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xl77zu7UFkgjzNSNZL8yu/Xtui1L+RH1bzoJQrDO/y0=;
 b=BshPQai7/A4sfEAIGU70+z4Zuk026v3T5pyXdSQTNVA/GfdULMKAgel5u01M+0vG2X
 xGaHaLGSIghRyZdHzw9+ml+Sjd2mLwETz0FQdZkUsWHWnUBS7Mi7F8m7OEmhaFvvVgZF
 9NPg4xYy1sbNjtMZnUrQKlQf+ZI2J+tTQn/b2smYCQ4kFYlSdbksYVzT3kRqDokgTY48
 YwVcwIrcOJ8syhywHH+9aHHW+kVFL/IPGi7YpECwvIJvJSNllysyn6yfseXKlscdEg9u
 xKMkOQqNFaqzCDGv2uC8NSAAC8MewEE78n93idDcdHvmfXeMAqtvaiOf3LBNlhgDJZSV
 BlUw==
X-Gm-Message-State: AOJu0YzFoiZ5ZVTB1+z4aOCY6jQl1DZCk/O4g4sUebS5opgfAFwPWqmX
 JwMnEu1K9G6+lZGqka06G20w3dm8wJA00C0F7VmbW/fJB2zy8eRi8viTGx3LCzqRAKyruvihkA8
 sVXk=
X-Gm-Gg: ASbGnctN50t3WxZncuvWpnwrDfevk/Oj2OHCgWSb0JoBCuNLprUyUrOBkV3bSGS9R3I
 sd/IoodTEJfBYQ7fgFihGwc+K10DBTqH3olS28/ZvBcAYqZkVdMaVSvhdJ5/Avzmgxw7ebnVRiT
 vkuPBnGfNLb0UTU3MerzQ0QCruz9CMfrEWNN7s+zxbzLQfEzmqyWFJSP4hbRF5sEjn3qwxWJaW0
 kilC8rBXWUOiDIuH1s4u5BQexG5tWdtt6qgcvU+2+o8+Z/aktHi4VbvrxmhdoCpt7cUFnCaFnkr
 0fVluncmjoYCDnpzPwd1Z/DBjUN5bnMWea0cfCJ6mK4dYk55M2qNN5+05ItQIWNrSm06VHIg0No
 1jaj8VW6IdhMvQrydK7c=
X-Google-Smtp-Source: AGHT+IFZdhFGEEfpxgU6yfQe65HH/1OZzribGyvZ0bV8cFsA+jLA+vTa7yh4v9409Nrwt4SAsBu0Kg==
X-Received: by 2002:a05:6000:1544:b0:390:e655:f998 with SMTP id
 ffacd0b85a97d-3911f756971mr6168915f8f.26.1741276081202; 
 Thu, 06 Mar 2025 07:48:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba87csm2457133f8f.17.2025.03.06.07.48.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:48:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/54] cpus: Keep default fields initialization in
 cpu_common_initfn()
Date: Thu,  6 Mar 2025 16:46:47 +0100
Message-ID: <20250306154737.70886-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

cpu_common_initfn() is our target agnostic initializer,
while cpu_exec_initfn() is the target specific one.

The %as and %num_ases fields are not target specific,
so initialize them in the common helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-6-philmd@linaro.org>
---
 cpu-target.c         | 3 ---
 hw/core/cpu-common.c | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index 89874496a41..75501a909df 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -234,9 +234,6 @@ void cpu_class_init_props(DeviceClass *dc)
 
 void cpu_exec_initfn(CPUState *cpu)
 {
-    cpu->as = NULL;
-    cpu->num_ases = 0;
-
 #ifndef CONFIG_USER_ONLY
     cpu->memory = get_system_memory();
     object_ref(OBJECT(cpu->memory));
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index ff605059c15..71425cb7422 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -244,6 +244,8 @@ static void cpu_common_initfn(Object *obj)
     gdb_init_cpu(cpu);
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
+    cpu->as = NULL;
+    cpu->num_ases = 0;
     /* user-mode doesn't have configurable SMP topology */
     /* the default value is changed by qemu_init_vcpu() for system-mode */
     cpu->nr_threads = 1;
-- 
2.47.1


