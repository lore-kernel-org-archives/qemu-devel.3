Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D71C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVmp-0004GH-1W; Thu, 15 May 2025 06:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmm-0004D7-6M
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:25:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVmk-00086D-6n
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:25:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso8439845e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304752; x=1747909552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jUxbkP+HhDnHsdXnm5ZqQIvQggnNxrTAh7W07VaYQEE=;
 b=WPeadnobR0g7cdFCbpy1In3VyqJkhtWgTcYbTMR88FS28lljQ6poq2AaKsMqgrxjHH
 HHMDWmzM1a3cFrynAdq+CRzbLo5ovKc9mo16QnTafXcMWNNZxYZtMDJKBGY0DD1uVP8Q
 KH7zeMm83xvNAmcJQAfMHsgYeATHXZF0nBg6iRmzAOh5y3mvxRg+zrzTdusrnoe+4sd1
 bp9jG4Nl85vXVSKCxfukhm91hNOJ2GzCfpP6qPd/9uFNi3kHemuuX83KLZPpNWHQwMsU
 NQVu9Z3hy90B6k8K3op15gNRV/KXzzZTtNS7jLBWJSPZK8t4odW/VKl9bcuA3vbldtRT
 S1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304752; x=1747909552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jUxbkP+HhDnHsdXnm5ZqQIvQggnNxrTAh7W07VaYQEE=;
 b=B4nqZzokAqgQZyjmx3aR0AZM547AOlmbi9Rbquddg3sVlhdbpQXfI7FK+ZZ457yqcC
 m6sAXfmYB/IOtG8xkVkuzXGtpqqDmxuoNvVcKExwrI+vi3H4TnpaAN8mG6OSEGxoiYso
 iqhp0jecAvzgf2PO+gEw08pWcjwdm0yhVpziz4JLSaG5Ha4aXKD4SKdK4ym6nzI6hiUa
 fpa1rPAz0koJGTfzQuXpuOLW21crGycQkTpihbjZO8/VpUl0AAIIPH75lTUO402pQxxi
 G1H7j4+NKQ2DVdfhFXyhb1EaGQMRX0CVsR+NKZdWj5xOKAYvQxOhXwIh/6rYAAYTYSjK
 SyQQ==
X-Gm-Message-State: AOJu0YwE0+GDQcBXEBHjAMm20F6Tc5Q9bHhcpqSJPsJD8kQoRS/Oayg/
 xfoN9oavvAF2a22fLKOGOLjZm8SFJzfRtbFQrpLZAUFdqZBchrLiL4eVkYJApkNRTU7GlDVCmHS
 7wuk=
X-Gm-Gg: ASbGncuClHjdLhAWppGuLcM1xauXsTxk2NYSzHfEmmmhI6ISIO1lI+FnEMHW8kv7j4V
 LoOpOGRZFLPil3yAMEY7brPEmIEC6jCd9naGIpKnCf1qN4TpJa+rW5d4zjS8pJZzmCAaApb6HVF
 9y7zLibODjqhFRXZVKz0k3W5hzbqyfGx0gwmp21047mqEZlMK1erstmNNkjXiwJDc84lD4gBgJ2
 RueDySqvlq7+zFKdzSry91L4DmabhBrzIavdM0e2ZD71EEwUYKzNlTqiZmyvx8P4W3PJnKZxSEM
 oNCquuwUo54K0hDVSPsq9uh+9ZQ7c52fBwUeVxNkExVq0oDjj2dgK2xzYw==
X-Google-Smtp-Source: AGHT+IGPdoxmrU9I5FL1bOyJAYbU7BuFnYDbMQ5zgXX9LWBMcy0Q+VTNN8Ycwe1izP38euQppcu3Jg==
X-Received: by 2002:a05:600c:1e02:b0:43c:ea36:9840 with SMTP id
 5b1f17b1804b1-442f970a8dcmr15025815e9.22.1747304752462; 
 Thu, 15 May 2025 03:25:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.25.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:25:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/58] target/microblaze: Delay gdb_register_coprocessor() to
 realize
Date: Thu, 15 May 2025 11:24:50 +0100
Message-ID: <20250515102546.2149601-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Currently the microblaze code calls gdb_register_coprocessor() in its
initfn.  This works, but we would like to delay setting up GDB
registers until realize.  All other target architectures only call
gdb_register_coprocessor() in realize, after the call to
cpu_exec_realizefn().

Move the microblaze gdb_register_coprocessor() use, bringing it
in line with other targets.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250429132200.605611-3-peter.maydell@linaro.org
---
 target/microblaze/cpu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index d895d683956..615a9592005 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -263,6 +263,11 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    gdb_register_coprocessor(cs, mb_cpu_gdb_read_stack_protect,
+                             mb_cpu_gdb_write_stack_protect,
+                             gdb_find_static_feature("microblaze-stack-protect.xml"),
+                             0);
+
     qemu_init_vcpu(cs);
 
     version = cpu->cfg.version ? cpu->cfg.version : DEFAULT_CPU_VERSION;
@@ -335,13 +340,6 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void mb_cpu_initfn(Object *obj)
 {
-    MicroBlazeCPU *cpu = MICROBLAZE_CPU(obj);
-
-    gdb_register_coprocessor(CPU(cpu), mb_cpu_gdb_read_stack_protect,
-                             mb_cpu_gdb_write_stack_protect,
-                             gdb_find_static_feature("microblaze-stack-protect.xml"),
-                             0);
-
 #ifndef CONFIG_USER_ONLY
     /* Inbound IRQ and FIR lines */
     qdev_init_gpio_in(DEVICE(obj), microblaze_cpu_set_irq, 2);
-- 
2.43.0


