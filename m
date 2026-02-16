Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F79E8383F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 22:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs7TU-0003oh-Kx; Mon, 16 Feb 2026 17:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7TR-0003a7-5h
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:49 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7TP-0006kl-Fx
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:48 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43945763558so1140085f8f.3
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 14:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771282425; x=1771887225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcFDo0OGdAbFK/LYHLtyhoYdjn54Jx25hy6jAoUO6d8=;
 b=lEOyHr95Zr40Xcx9dvWbR1+wSgcgjq6z1KLb8aXt7L9fSQBfHVS7WH8fX3y6ul17pA
 7no7DCU4EOhZl8PiU2uIv4D5xQ+7cxNDAFeUSVJoc+aGlkhAp8YOQCMyJZYkXZyo9LPd
 mAUmayNBwAuevm2BHJZgDqwxyhQ09DXJfWJV/viVGSlJodm7b+kaa80gaWP904XvwaBd
 bgi2PmNq9W84L4nXsJDqcxF9s78BewDVz+AeTFUeaFl7N2KEN8hhmqy66a20Rmg/vbFO
 2OJ/DI6Qvimaf5/uYLKrX6v3BtYp7C/Zkia7dgrCD9qJIpaXtKbtaApZ1OW6k/7OOutV
 V9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771282425; x=1771887225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DcFDo0OGdAbFK/LYHLtyhoYdjn54Jx25hy6jAoUO6d8=;
 b=bU3N3t//PXoNOPF2cvynYv0sMLdIL09u03zwBgedJ8ayWbCkWSXL1ACyicbW5zSN+I
 OkOP7wBxjaO4JLY23T/enU2xEncbaiUs5oNJdmDIhf3AtpVOrrFbduYA3NC0ITvxT9hO
 MiJeVBSUB1jrEfJSd/0pnkWXTQ/KM7Fo2atlwvxQzH+KrIYEMm6Z0srErlHCp8AZpCcE
 kUHxR/HnMI55EX3X4iKnBLohUNs0t4yYrjzsMIk05e28l3gS74BrVcpGR1JN7YE5ElIA
 P4tEomeTBISX9TZxTnL79Yvb9zG1qYtSHtIWAHE0uFYA3hvoDncsFQqw60bywhwF20l7
 eNpg==
X-Gm-Message-State: AOJu0YxrSGknaQ9fG3zpto+IOEdQ6OLeuOESKm3dtyrG+vw6t1lFvLbx
 ckWQ8UAzoROiiLZrUV58sHR5tWkPOGVyYBBgq0QZNmaYWsO0mrkgrPUD8nsWE2f5KfuUzUrewYN
 1GuI5ESY=
X-Gm-Gg: AZuq6aIXidHNcLOntW9fVlwg/blmRSFNn0/P0AGuSw74odS3rInUhGuLQoc05ApoDZi
 3ILpuazc0UDjHiTRSOx2YU7nur4DG3W0c3YC5LDDrLGSd6CaqJcaIpYPf232E9A1B8sdI9UgrGy
 PC/wjdQIlpm5akVV95NLWRzNezzNS8FqqL4xKHQU+eYnNWb7UXcv7lTQw6LwsU20j69PZ/jBf4c
 zPNbjWwuHkqxcFshoP4uKoqZwLWgNU4insiB5PbhsZN3tLDYNU2wTEeQ6F11Dg47G6b12g82qkx
 vDC99HWXTGiEiU7DHCa1dMGdJ88RmHEVNmr5zxrD7x3RbXeJ7TLMNYmFu4J3BjMX3VC3jltCEzG
 u7mfEyl8j4BKCqdUd068MomG1iQO60OUMqhuZjGgAkHCPTAcQ8YOF4l0s1+EXWWFORagDDIF13j
 FMRwlcePbUreVnOmmBpTNzjhKIDmLpTHeZn+1qu+l/WxqEDjAvNrLfk0Fn5zfYCu7LsZMXyJhe
X-Received: by 2002:a5d:588d:0:b0:436:369f:39fa with SMTP id
 ffacd0b85a97d-43796af9ed9mr22202470f8f.44.1771282425415; 
 Mon, 16 Feb 2026 14:53:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5ac7csm26797305f8f.7.2026.02.16.14.53.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 14:53:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, unisono@quyllur.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org
Subject: [PATCH 10/11] target/m68k: Remove MonitorDef register entries
 available via gdbstub
Date: Mon, 16 Feb 2026 23:52:26 +0100
Message-ID: <20260216225228.53959-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216225228.53959-1-philmd@linaro.org>
References: <20260216225228.53959-1-philmd@linaro.org>
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


