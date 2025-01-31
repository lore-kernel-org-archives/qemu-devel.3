Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468E8C02192
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyCq-00060x-Qi; Fri, 31 Jan 2025 16:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyCi-00060R-Qm
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:33 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyCf-0007mT-HL
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:05:32 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so24151955e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357527; x=1738962327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s72GUTdS6dsdZkDxXVs2tqlGQvWBVt1iK6Rxz8AAe/I=;
 b=nPuRo0rL5007ePXnkbhOf6RO+XIPFwCEd1RFLR9NTiIlQcQ6YNY63guFfPT4xWaV6L
 GcSrE+J2LYpM+Gz6LKl08OlX4sHRYd55Q0pssVxfHjwEZgtG4AjqtDIZTNVjyFWg858r
 y/XT/IK5771lnCXjOhb25P41egLCd21EIOGjZQXm9PMLYqE7zHAKz4HIri4ynlA4w2Bq
 7OX1Hwd3vg5gmweMLVP/oVUHH/mEtTwoS95e4KRaK8jpQc6ZqOJSFmvBbEEfD+nLGuCi
 xb74lHIgjNM9eFy+Sp2eciFvnCsMJno3o13xsOQls0xdX9Yyg1arr9sJ5x9uCNSKuA6B
 VMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357527; x=1738962327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s72GUTdS6dsdZkDxXVs2tqlGQvWBVt1iK6Rxz8AAe/I=;
 b=NvvouJj7ruk+y1eB2qVnd84HCCsb2jqHHFB9nfnVVr6dyxInR42bQ5/dUPqUo1ORBn
 toolc9nG14OTDrrp2dxKzjivzoR1XTXnytTZVImzNsRhERorUJG2uZjzNkXwwfp2tDco
 eXIZOR1/toqC3GfWZ8basLtvrj3ZOl5N5HdCoN/mnIJlN+I0svwE6/nRd07nE6a1FYaJ
 4rZ4cfggkyd8pkagwAULm6tuBedKwXqczDG7j5ovJoRj4I1tyNq1TXq8azeffP02XZig
 Yqp5N3XOe/o6nMmg1MS0iu4OuQNFBGEyluleQf4Bucgnq1ovHGsqT2FUw3NI6cQ6v0uX
 hNCQ==
X-Gm-Message-State: AOJu0YyA/jkF9phvV0Cyp2UQ7JbvWEzzQZfRpiURfOPaN4kOaSEriKX4
 anoTZkzbX5PTNmv2/Fmkep+bYfDLZXpcxuANNWdTNoeVspuLw5LrIwjLUebOPWHiErMbvTjP0Ab
 KqrY=
X-Gm-Gg: ASbGnctujeiBkk84jp9Cuv+Vk1+8yV4YCbRPb5Mk7Bs9veyVrf86D/FLipFWRbNxvZL
 IfXcMpoaBFlPoIuGJT661U/jbo/hlEehkuJUjB7dr1z+B6niIoehgIUfWNN2sW1xS9CWvAVcK0x
 lLOQKwCLZOqcQBzDXRpI3E6Rw7myy48JCdj/O3e41J69jo7A/kDpF3jmgJ/AYvI7QmQyd93d+Bz
 cOpRQpWsh65gxzxpNnpK4d1G2r/WOj2x47rJZI+6qICP1VoFHMuVw5B5Y2Z/vs+A3/SmWYRaY3T
 Bxhpe5RNQ5cRHRU/1KULURoXsmDJsLZOEophOMHj3M1tf3Qmn8dcm8dxm2DqLNWmXA==
X-Google-Smtp-Source: AGHT+IFZ3TZ8OXarUXcKsF2bo615PqD9J1ID0OU4QgUVebpMnJY0hFBkbzi12Fc+6EY4wXKvHj8F3Q==
X-Received: by 2002:a05:600c:4506:b0:431:58cd:b259 with SMTP id
 5b1f17b1804b1-438dc432b13mr117494885e9.31.1738357527120; 
 Fri, 31 Jan 2025 13:05:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc26b15sm101989505e9.11.2025.01.31.13.05.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:05:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/36] hw/rx/rx-gdbsim: Remove unnecessary uses of &first_cpu
Date: Fri, 31 Jan 2025 22:04:44 +0100
Message-ID: <20250131210520.85874-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
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

rx_gdbsim_init() has access to the single CPU via:

  RxGdbSimMachineState {
    RX62NState {
      RXCPU cpu;
      ...
    } mcu;
  } s;

Directly use that instead of the &first_cpu global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250110180442.82687-1-philmd@linaro.org>
---
 hw/rx/rx-gdbsim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 02fdbdf824b..88c8f12c101 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -127,7 +127,7 @@ static void rx_gdbsim_init(MachineState *machine)
          * the latter half of the SDRAM space.
          */
         kernel_offset = machine->ram_size / 2;
-        rx_load_image(RX_CPU(first_cpu), kernel_filename,
+        rx_load_image(&s->mcu.cpu, kernel_filename,
                       SDRAM_BASE + kernel_offset, kernel_offset);
         if (dtb_filename) {
             ram_addr_t dtb_offset;
@@ -153,7 +153,7 @@ static void rx_gdbsim_init(MachineState *machine)
             qemu_register_reset_nosnapshotload(qemu_fdt_randomize_seeds,
                                 rom_ptr(SDRAM_BASE + dtb_offset, dtb_size));
             /* Set dtb address to R1 */
-            RX_CPU(first_cpu)->env.regs[1] = SDRAM_BASE + dtb_offset;
+            s->mcu.cpu.env.regs[1] = SDRAM_BASE + dtb_offset;
         }
     }
 }
-- 
2.47.1


