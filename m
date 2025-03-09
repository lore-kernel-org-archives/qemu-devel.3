Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFD2C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKpr-0005NO-Lc; Sun, 09 Mar 2025 13:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpo-0005K4-SN
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:08 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpn-0004sz-Cw
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:08 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so1837001f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542785; x=1742147585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V4r396+mBV1+T5nOZp09H6dMWvs7dXGZXKliBRuJsUo=;
 b=ZPIFnL/LnS2xwmz4R5pNKW8brruisqsdv+x1wZhd42zymwqN910HH+EC54JPpIDaZp
 wZ1f3zELvZsPc8zwpRzdto2eqPvLSrB90Bh2GzivxKno4mwegCeKxAh+o9/+k0Lo5Ssm
 iUds+tMxXzR7vxvJ6EETXPzVFFr3L/7LjI64Cn6QVYY1JVVIl+7Fsy0SBap5an4jC2S2
 pYjvW7rd5TQJpFuNHEB4NDrzkaz7ED3jWmQL6FupPOxICzguVCvYjVG6jIso/hx5Kidr
 n1VlJ7UoLh+QMMQniFW0fsY8Ysv7naC9lKcR3WffRSvIQ/U08xZQVXiLSolzh9kl7q52
 qOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542785; x=1742147585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V4r396+mBV1+T5nOZp09H6dMWvs7dXGZXKliBRuJsUo=;
 b=ivwo6kHjdxAumct22CGUQlR7HSe9pfyZ2DB7GuGWEjO3iR265aLAcn4ybMslhTI0nG
 mFCzku/HOHtN7O4DgzsSTS8Djl/I0l+dfHUBROuUYBTSufyN1MqU5taKCp1i/j8HgWum
 J2wlf/3F1ha0p8uTgHj5zVSTLaBcO41gs7soTACdXDEBi9F9uPUsIOEmGJ4wl1sTGazc
 okKboyFAY7I5SsKQsjU0TLRpKwq3sG9CrUXZdaQYVg7HGpZJRany7fmaMDIxeC9h+IC+
 BpXcZgpKQrP4kUkNZjInxMJtHLAlLCjVD9h4DQo2OmKme4F3vyKXu4S4DrsFrtvSflHd
 U4TA==
X-Gm-Message-State: AOJu0YyuUO+e7g6o08zigM0o7Ifz/roOhPnpD4K7B8uvC6uLSJ7kd/71
 Q5AT8OKK8/WY1mqEhVvKmpJD6pWh2QzqwIO1Sg3Wr+/FF6Tu7T/K/+Y38Aq+lSH/09CysUeD5HB
 bya0=
X-Gm-Gg: ASbGnctovxVXCybDZfQJa5bIbEKdfWR04SMqq/n1txJ/Q1wjCAdL+xl+f8ju+ewvadU
 Mbwtad4gBG1HbaXO2Q1RprBGGFF6rB+hTvR0YRIohiKLSixpSoFrfFYhCFSRAL/yEdYULlhKoA/
 IZeA5l2n23dzhEv7ENO/SrYYyJhYDL5DUK8HqmkQteehD1LqjzTcbrCuXGWA9hEHbyorNT19ENT
 ye/7Z9LvbRxJO1zeUMi4+cLzcNPol9jsw/2R58Ao7iRUyzyDCo42KEujFDe4R1EKebxwolGEB6m
 Ft2D8lfl5oTNqDbzGZgSYd9Pa07XrA2VW+g9Cf/Cb1KlQxIizNbQBsGQCLZ+HmJ/mOVIhgOFCDo
 LNgCuIug8RMRRGzhryEk=
X-Google-Smtp-Source: AGHT+IEWFvjnOk/X3LjFrQMpgZe8Y1B5a5FpXBwK8FmgmwvCNBLbhk/1hO4rxG7ptKqUVwFSEdEbJg==
X-Received: by 2002:a5d:5f45:0:b0:390:f832:383f with SMTP id
 ffacd0b85a97d-39132d05b37mr6792404f8f.2.1741542785344; 
 Sun, 09 Mar 2025 10:53:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba679sm12286927f8f.8.2025.03.09.10.53.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:53:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/38] hw/acpi: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
Date: Sun,  9 Mar 2025 18:51:41 +0100
Message-ID: <20250309175207.43828-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250122093028.52416-10-philmd@linaro.org>
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


