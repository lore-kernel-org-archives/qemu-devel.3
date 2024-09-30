Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6264CF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svCSG-0003lb-6n; Mon, 30 Sep 2024 05:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCS0-0002tA-9A
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:12:21 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svCRy-0004eO-LY
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:12:16 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42e7b7bef42so32923935e9.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727687532; x=1728292332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uCiZY+YuwU08zy4bXykcCZ7CJfeAV953m1oo4BHo/5c=;
 b=w9cmntIjhopWQZQqtwSRnzBzsoK0qJgqvXmJAoLXJMKw9UQwoUW2xfYgyuQxhG24IR
 zyYyi08CgxPmRodDzx2xX+ilDomS/tiJR9/NGystWpfylG4ak+gci3LtkqUFOFsc2mRw
 fz6L8BWiRWVNnbu0THmHxkwGbhoQBADy7is7pNu9jv1nguxEgG5HojruuTZLx9gwWas9
 ogvrYM5yAWbX425MsSW+9LbDLCdXm7v4KTiEadnF008sOFPR9X+sPWOB2weXF6Zn5/V3
 SAnRSvKngVaauBWWJekS1XkX/pvsuPAPhMrKLb5b8P8vl/NwjweXwMBaF8T0iOs19A63
 cHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727687532; x=1728292332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uCiZY+YuwU08zy4bXykcCZ7CJfeAV953m1oo4BHo/5c=;
 b=XAZCHQqRHStva04Z8NfybyJG523yqFVTUJNDKkNzKFYpRP7BElCCSInaDi4LLUKPNU
 XRr46ct+VaL1CgSHOqIA34xeJotyWyI9FsF5GiLoYMd1WNa8Wc+siNLMrA+97ns+/d0/
 udCbZrgrOqvvBTkYX9bHmSAhaZ7yVihLD/9gyNmlXEo7N88Ik0FBoXNEZNtJuUy3OcrU
 UchwUcw7ww/eZpf3B9I/vqyA/gxjZO5C0UfMZVUyJF/ivWPdHXOIfRxdaXZW4lGKBgjz
 ObyaphYPqSls1ZIH6UXOSsmXtxLMMq78/oa5wINM0Qg1OVYF6xt1Fmyy1XWPD0Xsbd0L
 7JXg==
X-Gm-Message-State: AOJu0YyV9hcgA2moImXF8u6oXAr+Udz7MdiyJhRSpZxucMMVnwXAH39Y
 6UnKvpSlqO3T8BgG4kbl3m5Tm1R4AdtBBQt3ETt1BTm3zl5JIomhUFoRMFHbylutHBWx0lCJFqn
 o
X-Google-Smtp-Source: AGHT+IEpC7xT+I+0JsJnymmQxAWzUFTkEtZ3ucW8tIEyTP63uiOEz9MGVs19/RBtsAgR+MmdmhJYeA==
X-Received: by 2002:a05:600c:1ca1:b0:42a:a6aa:4135 with SMTP id
 5b1f17b1804b1-42f5844cbd7mr77550695e9.20.1727687532163; 
 Mon, 30 Sep 2024 02:12:12 -0700 (PDT)
Received: from localhost.localdomain (183.red-88-28-18.dynamicip.rima-tde.net.
 [88.28.18.183]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e969ddcc4sm144070915e9.10.2024.09.30.02.12.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 02:12:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 09/12] hw/mips/cps: Set the vCPU 'cpu-big-endian' property
Date: Mon, 30 Sep 2024 11:10:58 +0200
Message-ID: <20240930091101.40591-10-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930091101.40591-1-philmd@linaro.org>
References: <20240930091101.40591-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Have the CPS expose a 'cpu-big-endian' property so it can
set it to the vCPUs it creates.
Note, since the number of vCPUs created is dynamic, we can
not use QOM aliases.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/mips/cps.h | 1 +
 hw/mips/cps.c         | 4 ++++
 hw/mips/malta.c       | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index 04d636246a..05ef9f76b7 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -38,6 +38,7 @@ struct MIPSCPSState {
     uint32_t num_vp;
     uint32_t num_irq;
     char *cpu_type;
+    bool cpu_is_bigendian;
 
     MemoryRegion container;
     MIPSGCRState gcr;
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 07b73b0a1f..13046628cd 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -77,6 +77,9 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
         MIPSCPU *cpu = MIPS_CPU(object_new(s->cpu_type));
         CPUMIPSState *env = &cpu->env;
 
+        object_property_set_bool(OBJECT(cpu), "big-endian", s->cpu_is_bigendian,
+                                 &error_abort);
+
         /* All VPs are halted on reset. Leave powering up to CPC. */
         object_property_set_bool(OBJECT(cpu), "start-powered-off", true,
                                  &error_abort);
@@ -167,6 +170,7 @@ static Property mips_cps_properties[] = {
     DEFINE_PROP_UINT32("num-vp", MIPSCPSState, num_vp, 1),
     DEFINE_PROP_UINT32("num-irq", MIPSCPSState, num_irq, 256),
     DEFINE_PROP_STRING("cpu-type", MIPSCPSState, cpu_type),
+    DEFINE_PROP_BOOL("cpu-big-endian", MIPSCPSState, cpu_is_bigendian, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 6e73c896ff..a0757f251a 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1055,6 +1055,8 @@ static void create_cps(MachineState *ms, MaltaState *s,
     object_initialize_child(OBJECT(s), "cps", &s->cps, TYPE_MIPS_CPS);
     object_property_set_str(OBJECT(&s->cps), "cpu-type", ms->cpu_type,
                             &error_fatal);
+    object_property_set_bool(OBJECT(&s->cps), "cpu-big-endian",
+                             TARGET_BIG_ENDIAN, &error_abort);
     object_property_set_uint(OBJECT(&s->cps), "num-vp", ms->smp.cpus,
                             &error_fatal);
     qdev_connect_clock_in(DEVICE(&s->cps), "clk-in", s->cpuclk);
-- 
2.45.2


