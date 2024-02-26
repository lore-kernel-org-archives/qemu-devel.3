Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467B9C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeAT-0005x1-90; Mon, 26 Feb 2024 11:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeAR-0005wN-JX
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:49:27 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeAO-0006Dp-Sl
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:49:26 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33d36736d4eso2066152f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966163; x=1709570963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSB3DjDUt1VhXKQ8ZY2Xf8EIy3NhP1lIXSTZpypndH8=;
 b=SBa4VDo4zhD/+XOWE18BHzX4zNMessHPaigsKq4GVKh6Q/dOCJaVOhlM2FuBRa7B3w
 re3SAJvr0zSC2Z7ohpPBHll0VDhlnu+58gNWpFxLBj7M5W3fSb8LIK0w+jpZT8WJs1e8
 UJZRAxaQtGmO9hwLi+fl9avAXdkriEsr2HIRcWlid4SgwowK1ZLb6UN0C6qV904+tFSH
 zUrACsugDebTPHIk4i1d/FBaDrcjkH51L0oNVJRD0Lw7HSxE4HAH3ZT1JTp6Kjc4X/9+
 wbCJc02pmKK4ObwGb2aCXGzLs842a8wwUrUstELnbylHiajSBA63SDwWbbjM2dZvEZdl
 vJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966163; x=1709570963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSB3DjDUt1VhXKQ8ZY2Xf8EIy3NhP1lIXSTZpypndH8=;
 b=FmRpt/e1d6VawrCnmPmF+PLW1x3RfLB4G5XXQMEpstRVqs55QjcPnwYydJ0BAsRX1h
 6YKY1DtJNocQlyBFb9Wev1/YOSQJvSKr1UCpAKYRrAWIjhaNA3o+kR6UxcSBO2VH/jug
 RV70yD9PM8Z8MlsJmcszTdPp+5IT/rHxuHZycf2vaqd0FKLklaN6raF5xDXUSuzNSaXt
 3HDWqbmngdQU6f+TNEEt7yrwIz9JYkSsctt/zpr269d51Cdy1IAy7Xk8My6HSprtMnhA
 yMb02AlicoV5FqTHhisUupEukCWWNVx8VhFWvNltSUIpbbsvwi/4757VNTJY6GNtqbLg
 /ZlQ==
X-Gm-Message-State: AOJu0Yx3j269rc6cOKiCYn2IzX+VCj+DUeU6R5XtV9W+6qCv/PtJ+TjD
 jEEafQLwd07rr0kvK/njfbdBOfvpGLEoHDqxs1Fq4wzI6FZFfMIEOcIKAm/Fw+Uon4PHDwzqZoI
 T
X-Google-Smtp-Source: AGHT+IF059EUPAbCL7SWAkMPG8gvMdciEhLUauFFOGEG0lnzdfLarfDOY9vlKU1SjU6UIOnamaswsQ==
X-Received: by 2002:a5d:64c6:0:b0:33d:db2f:b0fd with SMTP id
 f6-20020a5d64c6000000b0033ddb2fb0fdmr2206800wri.52.1708966163240; 
 Mon, 26 Feb 2024 08:49:23 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a5d4304000000b0033d6c928a95sm8771903wrq.63.2024.02.26.08.49.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 08:49:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] target/i386/cpu: Expose SMI# IRQ line via QDev
Date: Mon, 26 Feb 2024 17:49:08 +0100
Message-ID: <20240226164913.94077-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226164913.94077-1-philmd@linaro.org>
References: <20240226164913.94077-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In order to remove calls to cpu_interrupt() from hw/ code,
expose the SMI# interrupt via QDev as named GPIO.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu-internal.h |  1 +
 target/i386/cpu-sysemu.c   | 11 +++++++++++
 target/i386/cpu.c          |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/target/i386/cpu-internal.h b/target/i386/cpu-internal.h
index 9baac5c0b4..9d76bb77cf 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -62,6 +62,7 @@ GuestPanicInformation *x86_cpu_get_crash_info(CPUState *cs);
 void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
                                 const char *name, void *opaque, Error **errp);
 
+void x86_cpu_smi_irq(void *opaque, int irq, int level);
 void x86_cpu_apic_create(X86CPU *cpu, Error **errp);
 void x86_cpu_apic_realize(X86CPU *cpu, Error **errp);
 void x86_cpu_machine_reset_cb(void *opaque);
diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 7422096737..7684a7f01e 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -370,3 +370,14 @@ void x86_cpu_get_crash_info_qom(Object *obj, Visitor *v,
     qapi_free_GuestPanicInformation(panic_info);
 }
 
+void x86_cpu_smi_irq(void *opaque, int irq, int level)
+{
+    DeviceState *dev = opaque;
+    CPUState *cs = CPU(dev);
+
+    if (level) {
+        cpu_interrupt(cs, CPU_INTERRUPT_SMI);
+    } else {
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_SMI);
+    }
+}
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7f90823676..6b4462d533 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7463,6 +7463,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
+    qdev_init_gpio_in_named(dev, x86_cpu_smi_irq, "SMI", 1);
+
     x86_cpu_apic_realize(cpu, &local_err);
     if (local_err != NULL) {
         goto out;
-- 
2.41.0


