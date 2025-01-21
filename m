Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECE9C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCdV-0005NW-Ki; Tue, 21 Jan 2025 06:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdT-0005MS-5s
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:35 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdQ-0003PU-DK
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:34 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so60364995e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 03:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737459690; x=1738064490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DeYTxKfeYGnuCZs4uhCLhCH6gP528hwEuAlYwVcOULg=;
 b=W3GP7sLeHtet/KBti2TeVQYKTq+uKCeFPGzKZo0EVnE5A9L+MdrCWkU6jEjYR4WJfy
 nkLVVxGhkLnKGSIJiuyMgHofvMajBw3Mndls4wkbNJwQM/WuALUdV8g+nw/Jcgzn3TOy
 dA7DFzPHXHPfSIJ1/LKU/dZXpTiuoSu+5A4J/bcjF53Je3ot5dr37xpwdVJmnY6bFtdL
 OmgK2l44RmdkV2faN9mOPFqCkJJ68uerM5xFt39FaW1l8CZqK6ZQeO7n5mlTRwBGPfyF
 cxglLsKloocSRv7dPvrgbVWcKKVIzf/BfCpOVuAKA8TitiXoMT2iW+V9AHRGuiO5oRUC
 hMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737459690; x=1738064490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DeYTxKfeYGnuCZs4uhCLhCH6gP528hwEuAlYwVcOULg=;
 b=LbXZcQRHaIBIbnkoXrQHyHTRWKAIqY7GYfQ0R7jCC4Ywdt7zKjugkP+pbZj3CxPPNQ
 ZULrq+yDyGl/Qy/mdbQgIvVtja8IezfdgYm6qRy9rTccfLSDehGmI1PIN2TOjrSllNOS
 aiFVFfPYQbCsA4iQBiYaU+PL9WwZPSjKNVp78EZOofffA9vfj6kIDlXWKaKm1+SKGi0d
 vyJ/VMWhm7FkBUkmNW4xI1/16Pzeyr/Vd0PIt1ufse/HkwJBJzzp2s3W3LsxfKUhKyyy
 VgbLXksAtrv8j2pT/Y1vr/Kl43bVq0CLLkZxRpnK22eS1rKZVQUv97uenXZATbumFstT
 C/zA==
X-Gm-Message-State: AOJu0YxfHW7/moh53HoFPiPuux4S8Bk6iLL3AS9cph5lWS9+Nepd9HOy
 8Uoc8tasoMIxC3rDl1qKc2CuOiFuLi8j93KwBKHTpYnQPbfdYEMtLRaZiNmZCaLRDymvss+aITK
 gWP8=
X-Gm-Gg: ASbGnctAvLuZV2ZJ5z2mmMwCCgBurJAWGX1AFYPoI/26h0gTvCxTaVF+WE0cCJ2fiz1
 8YdVNAzbzel2zCCRDCqE725ppyWdy76p2cDphMBa+iYIeB/q6er06SzJ0abRo8VBJzsTPtdOsv8
 lNYmBe8/Z9pWg0Bfs4rRMdsS3Ta9+XYVh2kdGtjCLc+EtMKxmAPYrYsasAjTh6/YSXHbKc8BwbI
 hlzDfqWeNhaFMCFKg9vPzhV5bpe8AJu1ctgvqGKr/RSJHRVYM9pcN5zBAcw8+jMVSpSBYBYhNVI
 f5YA37kWYZyBBlKUQ7ZK551FZmvA0EvSgnzuuVT2TLci
X-Google-Smtp-Source: AGHT+IFYePQ7W9qEBZjkBoTzSbXA4iRi/jfN3vePvpN5KZLxmU/7I4ErTsDfpMpd1xt0kQIOxaZvCg==
X-Received: by 2002:a05:600c:6c95:b0:438:a1f5:3e41 with SMTP id
 5b1f17b1804b1-438a1f53fa6mr113851535e9.12.1737459690343; 
 Tue, 21 Jan 2025 03:41:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c75290a2sm238291245e9.29.2025.01.21.03.41.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 03:41:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/11] hw/acpi: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
Date: Tue, 21 Jan 2025 12:40:52 +0100
Message-ID: <20250121114056.53949-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121114056.53949-1-philmd@linaro.org>
References: <20250121114056.53949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/acpi/cpu.c         | 4 ++--
 hw/acpi/cpu_hotplug.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index f70a2c045e1..6f1ae79edbf 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -235,8 +235,8 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
 
 static AcpiCpuStatus *get_cpu_status(CPUHotplugState *cpu_st, DeviceState *dev)
 {
-    CPUClass *k = CPU_GET_CLASS(dev);
-    uint64_t cpu_arch_id = k->get_arch_id(CPU(dev));
+    CPUState *cpu = CPU(dev);
+    uint64_t cpu_arch_id = cpu->cc->get_arch_id(cpu);
     int i;
 
     for (i = 0; i < cpu_st->dev_count; i++) {
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 83b8bc5deb8..aa0e1e3efa5 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -62,10 +62,9 @@ static const MemoryRegionOps AcpiCpuHotplug_ops = {
 static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu,
                                      bool *swtchd_to_modern)
 {
-    CPUClass *k = CPU_GET_CLASS(cpu);
     int64_t cpu_id;
 
-    cpu_id = k->get_arch_id(cpu);
+    cpu_id = cpu->cc->get_arch_id(cpu);
     if ((cpu_id / 8) >= ACPI_GPE_PROC_LEN) {
         object_property_set_bool(g->device, "cpu-hotplug-legacy", false,
                                  &error_abort);
-- 
2.47.1


