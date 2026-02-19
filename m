Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A91AE9A05F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9ci-0005tK-8z; Thu, 19 Feb 2026 14:23:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9bY-0002ys-SC
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:32 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9bP-0008Bp-86
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:22:22 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-483487335c2so12729205e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771528934; x=1772133734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcFDo0OGdAbFK/LYHLtyhoYdjn54Jx25hy6jAoUO6d8=;
 b=SWxSnr7ve9X8MUXo9Ic69HSZ/gOCm3ML8lrMpN+d2eo59Ul/wp43oAn+z1+q4QHhoV
 NAierCJ83cLPal01cbU3nl2rvaNAlVfq5sZSYNU5dVO5bJNxjSVGj+Gat/EAmhaStdYo
 LqM2DCHbcqPE3cA0kfDb7nMIx85fAuoDSGHCQtEcEbj/wV3Y+q4B8nNK3e94GmdFdvdk
 uJWckr08bwc5cYw8vK4T38IygTkzJ2tnpySl5DToSEdXmkJ0v/xU0/6AYaii0yIe81uK
 7FImTBrx6Qs6A7QY/Siz+2rhAwNxIcL+lgMvUjAnr5T0XhEqSm49Uz+skIw1pVhj+Djd
 MuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771528934; x=1772133734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DcFDo0OGdAbFK/LYHLtyhoYdjn54Jx25hy6jAoUO6d8=;
 b=w32nDPp+g+KtIBE2SXjwcU43niMJN0TxGPMQddFg6Nz4OYpYv7UrhP2rYGT54VjSQJ
 ZLh/9bU6RNC6wpBHygD+aQmEI26I38AxuoRT0puDUKKdU4vpBzb7Ycahb7mrvfBUYFjN
 JTG1Lm6d0itIbTbZd3J1kNJkM4T9ok80CUZQPRzhMBpgx9Du54qFZoxuF4H0sKdqUECc
 JewX0twG+5iAvn2J5DqtKt++EkMJAI1+sN8ys5IQYoMDUrpuuMmoe+QRBzZjN6oXTC00
 YOUEE2CCKVrvJGfoTHcqnYMDnreu7Qp0JvXdwS08O83Ie8y9MSye3q35L4/BRT1XW/h5
 MoYQ==
X-Gm-Message-State: AOJu0YyY7UaD4WtPa3eMHraRWK6nTVcdEs26Hp86o3kBpBF8UDrcf59L
 VTPbHnCNxAp4S6AS7Ev0HyvmBO0rUN+odUlMt11Qn1xhDwAAY1Ae/KslfS8cxoVw3+inKL7kmQY
 Qdjuhme86qQ==
X-Gm-Gg: AZuq6aL8xVPOtLU+hj3ejTA9xXXO6wA/4PZ32LBV4mFX5dz/HWfybhNWMiS9/3839i3
 LCCp2F9HmmE6EvuBM2hZiTkhCt+XyAd4Pv/QhlC8xa1evO6j4pJUu3XBXQIeAVfxBuHzOYAwr66
 QK3IoV5/+i0FBEDZmqZ48pdaoJ4FjCIq2HfsAuE6QZqAQMdCpqPYT3SmMZXhZVdDT0qjPcz2UBV
 raJOOsj/55yMZeSAJcHvAQnpt2KtrWMIGce7wPxCBOVuUu8G6ILgllNHF1ZeFWnhxeavtN93Rg/
 hc/LZ3U0o9b+1mSaoOEcqcd1gMSrUrCIAZu6/gqsc+3zQlI0Mns4ahqOq6CY+5CXUrEVQv4F7PQ
 Lxi2yplVqeXoK+YRiD54130NXVbxIVSkU9WbIEtxo1rJsW/QMXQpGb7UVKWIPVOml2vqHdQYlcZ
 dGahsEHlSm2Rg0SkJMCe7cwwC88wDZpTRc3lJ3r2dWQmhOUcUwDvP7APpsK2SOuTPKWa8+A7dY
X-Received: by 2002:a05:600c:5251:b0:47a:810f:1d06 with SMTP id
 5b1f17b1804b1-4839e6370e0mr50122305e9.4.1771528934266; 
 Thu, 19 Feb 2026 11:22:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a424048fsm274925e9.0.2026.02.19.11.22.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:22:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 19/50] target/m68k: Remove MonitorDef register entries
 available via gdbstub
Date: Thu, 19 Feb 2026 20:19:21 +0100
Message-ID: <20260219191955.83815-20-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

All these registers are already provided by via gdbstub parsed XML
and handler by the gdb_get_register() helper in the monitor/hmp.c
file. Remove as now unreachable code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/monitor.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 6d101c75df0..08ced037b47 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -24,24 +24,6 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
 }
 
 static const MonitorDef monitor_defs[] = {
-    { "d0", offsetof(CPUM68KState, dregs[0]), NULL, MD_I32 },
-    { "d1", offsetof(CPUM68KState, dregs[1]), NULL, MD_I32 },
-    { "d2", offsetof(CPUM68KState, dregs[2]), NULL, MD_I32 },
-    { "d3", offsetof(CPUM68KState, dregs[3]), NULL, MD_I32 },
-    { "d4", offsetof(CPUM68KState, dregs[4]), NULL, MD_I32 },
-    { "d5", offsetof(CPUM68KState, dregs[5]), NULL, MD_I32 },
-    { "d6", offsetof(CPUM68KState, dregs[6]), NULL, MD_I32 },
-    { "d7", offsetof(CPUM68KState, dregs[7]), NULL, MD_I32 },
-    { "a0", offsetof(CPUM68KState, aregs[0]), NULL, MD_I32 },
-    { "a1", offsetof(CPUM68KState, aregs[1]), NULL, MD_I32 },
-    { "a2", offsetof(CPUM68KState, aregs[2]), NULL, MD_I32 },
-    { "a3", offsetof(CPUM68KState, aregs[3]), NULL, MD_I32 },
-    { "a4", offsetof(CPUM68KState, aregs[4]), NULL, MD_I32 },
-    { "a5", offsetof(CPUM68KState, aregs[5]), NULL, MD_I32 },
-    { "a6", offsetof(CPUM68KState, aregs[6]), NULL, MD_I32 },
-    { "a7", offsetof(CPUM68KState, aregs[7]), NULL, MD_I32 },
-    { "pc", offsetof(CPUM68KState, pc), NULL, MD_I32 },
-    { "sr", offsetof(CPUM68KState, sr), NULL, MD_I32 },
     { "ssp", offsetof(CPUM68KState, sp[0]), NULL, MD_I32 },
     { "usp", offsetof(CPUM68KState, sp[1]), NULL, MD_I32 },
     { "isp", offsetof(CPUM68KState, sp[2]), NULL, MD_I32 },
-- 
2.52.0


