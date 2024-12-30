Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8509FE7718F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 15:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSHeD-0002bM-MH; Mon, 30 Dec 2024 10:25:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHeA-0002aY-G2
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:25:34 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHe8-0001l5-Tl
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:25:34 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso64197915e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 07:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735572331; x=1736177131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAtXelESZqP9EpLglyIc26IsQk/mXnYos/ye7zC5LFE=;
 b=fKbED+iHAeCBO/RUzSyNB0HTk8icBtqHxh3t6pSXjPAAsSSBy/abGFMiLtPDzG934I
 mSXoP2+UExDm1LYWhv8c6rt1ia0YgrOtaAOLfH5tI9hmu/aEu+BSPOhKg0KocMB0KKP9
 oi4D2Z8DSdHT/ZB0U6K6PIn07wsEZ5lA9oY9Iv2WHRxvE0+li5bsSHz0AR0D3anbNK1l
 PSCRd/7qzlGTKa4OySd6yWHHdTX3RmUSQoj4c1sIIZ/uk+xVZRrgkpu5Ws8D/bgLhsOe
 nfzwynCqgD9JpcUH9wBW+2ZWfEjQVzJGQRkr3l8GzSYun+axVOtTc+c538fI8dWl0ZxH
 IiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735572331; x=1736177131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAtXelESZqP9EpLglyIc26IsQk/mXnYos/ye7zC5LFE=;
 b=rka5uGqUBxEh3FbhT9gs13u7AsOulq7Uge6dlQ5y1EkAsX4O9Rr//sR+2FXz0Mhd5z
 PUA+IKBw+CjcL2PdROGxXAGadtCKIcU46p8zxQndeFbQvj02aL6DtrpIhvXv204ZRBZw
 8Aw/0608EcgCCS43KO5eeOPCCuSoPpGxXIyQbzQ+4rMp0MjKjYHZCUpjhlEK2WbK+IH9
 I4k6LGwtOeo9Wt/jBVScmELOvhEkXrV6B3Pd5uX8O5r6lR1xKg4zb9tlXF74sPu44Gzh
 m6Op1SQ2ob0RzbCOdPX5fLdufCbi5H0N7xuIjsQfjbElcd4lmKjguq6AifxoLYSYaTYk
 qBmA==
X-Gm-Message-State: AOJu0YyEvvc/rt6YHoKq/XmFgBdhihTs8WNNfJFDK49BR1ztW6VFJPVd
 TOqD1Uqu8x15SLKZ5MUiYKyyZnOFs/O2LiFNu9uhEV8h58FiD/24uQArEIBttAX+JQPCPERcZQU
 p
X-Gm-Gg: ASbGncuA4BOHkGSUqJwiDVesulH8wBXpndVQEIYoOrKtM4C695TXCNJWvuOjTtgY/BB
 4RAexCgbLIWTDvlJlE4hcuuro9/PSXulyAi84FjpabA3p8ahbq3fdVXO8UWsdX4qrmCEq2Wy+bn
 UPkLzTJadWsad3jtCK8OQ072HH2IgomPxE+KLH8ywQF23NR5nzwYY/17nwinB7JLzUEIvUHghBb
 1xIE5E7BKQ/66MKshdIwpbZ7O0GfE7Er0KRRZUHdVpTJTKTV8wI0morpp5yHT+FLS4HG7sSEf1D
 KW7eZXBxmAqDWGLDSphtgi8ZmxOETuQ=
X-Google-Smtp-Source: AGHT+IHI9+2p8U6mmafyYGc9fI3EOpQrSvGCHTuMoo9xsrWiQwSS/ftftGsY3ybfGjpNM7DC8mBdrg==
X-Received: by 2002:a05:600c:1c91:b0:434:f219:6b28 with SMTP id
 5b1f17b1804b1-43668b499f6mr272074075e9.24.1735572331112; 
 Mon, 30 Dec 2024 07:25:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c84840asm30283337f8f.61.2024.12.30.07.25.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Dec 2024 07:25:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/5] hw/hppa: Reset vCPUs calling resettable_reset()
Date: Mon, 30 Dec 2024 16:25:16 +0100
Message-ID: <20241230152519.86291-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230152519.86291-1-philmd@linaro.org>
References: <20241230152519.86291-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Helge Deller <deller@gmx.de>

Rather than manually (and incompletely) resetting vCPUs,
call resettable_reset() which will fully reset the vCPUs.
Remove redundant assignations.

Signed-off-by: Helge Deller <deller@gmx.de>
Co-developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/hppa/machine.c | 6 +++---
 target/hppa/cpu.c | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 65259308e2e..8230f43e41c 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -655,12 +655,12 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
     for (i = 0; i < smp_cpus; i++) {
         CPUState *cs = CPU(cpu[i]);
 
+        /* reset CPU */
+        resettable_reset(OBJECT(cs), RESET_TYPE_COLD);
+
         cpu_set_pc(cs, firmware_entry);
         cpu[i]->env.psw = PSW_Q;
         cpu[i]->env.gr[5] = CPU_HPA + i * 0x1000;
-
-        cs->exception_index = -1;
-        cs->halted = 0;
     }
 
     /* already initialized by machine_hppa_init()? */
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index d784bcdd602..41538d39d62 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -204,6 +204,7 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
         scc->parent_phases.hold(obj, type);
     }
     cs->exception_index = -1;
+    cs->halted = 0;
 
     memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
 
-- 
2.47.1


