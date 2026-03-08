Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565A0F55138
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 07:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz8S8-00035H-0y; Sun, 08 Mar 2026 03:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8R3-0001dg-4F
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:22 -0400
Received: from mail-dy1-x1341.google.com ([2607:f8b0:4864:20::1341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vz8R1-0002cD-Ha
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 03:20:20 -0400
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2be4781d2baso4107737eec.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 23:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772954418; x=1773559218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aLL7Tl0LDKOGqVdwmIrV20atrUT/3NfBWs1jccL/0l4=;
 b=VWs+YDoyAQ+ygW55D5fkKkgkK1XD2T31liHJgvToPdb5aQAtuUk5Uto7oq/DL33O/5
 fHR8PksmsdvERH0OucyXi4wIELohdm2Q3K+KUbxJZlK+DZBZkQrV/uW/LPp71hBkTrdJ
 EuTLv8L0Eo6CFSMICM/V//KvRXNjjt24tmcesD59SFofkHnGnI35LawPHcGpd/rDd2iE
 FPxuIg9teIMaJxGMk+xHlnfS1oneWbr8Mz0rhMmNZre9GDbhDg5Lnt320Du1h02rXOSg
 OPBkDIMIHhWYZYJy/3SxAY0n0Rl9yt+ZQ+qyZbYTK5N5ArwXJ4wB8EmqB+QiZdDYxqBB
 DsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772954418; x=1773559218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aLL7Tl0LDKOGqVdwmIrV20atrUT/3NfBWs1jccL/0l4=;
 b=nyiCI3ulhQzJuY+Anc3n3XXP7kuAINsBjcrU45LHYEgw5NyxhNEnhm/rrVmpNWGVql
 m2T3UVLlkvaD2RPH+69js4rYLIeHknvdcheEYw4mO8ku8tyVfqP7PMzx+F3no1UsQE0p
 RxsdxZ95aPb6v2le5MzulrtxEpfmxUgghdgQYAZfP2BaX7jVB3JKT20wvW/uVjcsLFZe
 yT1bibN69Jdfgj03AJInI6u/ZbPz4fVxeYM0Z4vi9RjPSC6Y8Vxp5z6AIbTPb2EP8g9j
 2YyO/8MQ87jwryxFQs7cOj33+sohWLrONJNar8U6Hvk+/GtXJuiUVklhXu3F/2tK12iW
 VO1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW108RHGaZiXItxrY1eBOkDImxCvXia1J762J2gYxzLYz3gaOGld4qp/XKgfL08DSWITHS7SmoF03As@nongnu.org
X-Gm-Message-State: AOJu0Ywc9dIK1VmbVUrTEaqH0LRjH58wkUrGfno19K4PLdEUWZ5cvcZR
 8O2LY1Z4+Bf26E7Z1qmSniIUKe8szRxvue1UNI8QaahupLOoegTYdh0R
X-Gm-Gg: ATEYQzzm7EEg53c5n8F+eKft2tYPU9kM+fWYRZ7rZAyyS/D4jTcQT/34IY75Z2XHctQ
 LowqcToNabkSb4XJMQDs9aN/j+dIgAbx4XfPw+4WtwTJtQggyu4kGFWrtCxUxFA7T3hl/MqfM4B
 /lS3WYge8TlZSz8SpsModRLr47HSANvon5Ec28eD6xoavgoogBRFDvj3ix1qPH0nSnq+g6Z5KR/
 IkbJSvSi1Yih0MZ2hRNhj8C1jI5VPEbjsJW7X4gyt2cXfM6uKm9GHHxV477DxMzmCm6k30jo0EW
 vXReeRiiRh6727d7KP1zadwnnqwOe1e36TSjqxmB9i8W9dmpySE20G6kW7zJQHWHV7Q6KxBsi/F
 6Y3Sz05XcHWMkycyjsi5EloxkNtzRIlcRa5D0ZY5c9tKk2OlQ5o3KGjhyEW4nNg8tklNbFFmWXF
 QMuYKH9k0b5CRl7cztJrjyAPl3SbaWKHxQloGa0M2xCSHb4TNeEe7uA7jq0zDuGGLyLHFLoZeF5
 T3/qsLKPzedEYpiH8a64R5+xD4=
X-Received: by 2002:a05:7300:a883:b0:2be:522:2edf with SMTP id
 5a478bee46e88-2be4e0d0aafmr3005632eec.39.1772954418104; 
 Sat, 07 Mar 2026 23:20:18 -0800 (PST)
Received: from ZEVORN-PC.bbrouter ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2be4f984ceasm6014081eec.32.2026.03.07.23.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 23:20:16 -0800 (PST)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Subject: [PATCH v1 18/28] hw/riscv/dm: queue reset halts from the reset work
 item
Date: Sun,  8 Mar 2026 15:17:21 +0800
Message-ID: <dc14e7beecb596bac6ca657fe9d34933b826df21.1772936778.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
References: <cover.1772936778.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1341;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Queue reset-halt requests from the CPU reset work item so the
halt is requested after the hart reset has completed, not before
it starts.

Keeping the ordering in one place avoids racing the pending halt
against the code that clears hart state and ROM mailbox flags,
and it works the same way for both TCG and non-TCG reset paths.

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 hw/riscv/dm.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/dm.c b/hw/riscv/dm.c
index d55b5b827d..760cae27e2 100644
--- a/hw/riscv/dm.c
+++ b/hw/riscv/dm.c
@@ -240,22 +240,20 @@ static void dm_debug_reset(RISCVDMState *s);
 
 static void dm_cpu_reset_on_cpu(CPUState *cpu, run_on_cpu_data data)
 {
-    (void)data;
+    bool request_reset_halt = data.host_int;
+
     cpu_reset(cpu);
+    if (request_reset_halt) {
+        riscv_cpu_request_dm_halt(RISCV_CPU(cpu), DCSR_CAUSE_RESET);
+    }
 }
 
 static void dm_note_hart_reset(RISCVDMState *s, uint32_t hartsel)
 {
-    CPUState *cs = qemu_get_cpu(hartsel);
-
     s->hart_halted[hartsel] = false;
     s->hart_resumeack[hartsel] = false;
     s->hart_havereset[hartsel] = true;
     dm_rom_write8(s, RISCV_DM_ROM_FLAGS + hartsel, RISCV_DM_FLAG_CLEAR);
-
-    if (cs && s->hart_resethaltreq[hartsel]) {
-        riscv_cpu_request_dm_halt(RISCV_CPU(cs), DCSR_CAUSE_RESET);
-    }
 }
 
 static void dm_reset_hart(RISCVDMState *s, uint32_t hartsel)
@@ -268,10 +266,15 @@ static void dm_reset_hart(RISCVDMState *s, uint32_t hartsel)
 
     cs = qemu_get_cpu(hartsel);
     if (cs && tcg_enabled()) {
-        run_on_cpu(cs, dm_cpu_reset_on_cpu, RUN_ON_CPU_NULL);
+        run_on_cpu(cs, dm_cpu_reset_on_cpu,
+                   RUN_ON_CPU_HOST_INT(s->hart_resethaltreq[hartsel]));
     }
 
     dm_note_hart_reset(s, hartsel);
+
+    if (cs && !tcg_enabled() && s->hart_resethaltreq[hartsel]) {
+        riscv_cpu_request_dm_halt(RISCV_CPU(cs), DCSR_CAUSE_RESET);
+    }
 }
 
 static void dm_reset_selected_harts(RISCVDMState *s, DMHartSelection *sel)
-- 
2.53.0


