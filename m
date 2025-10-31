Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B94ECCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwTm-0000Q2-KN; Fri, 31 Oct 2025 17:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwTf-0000L6-78
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:16:07 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwTX-0001z6-Nn
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:16:06 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47114a40161so30247775e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761945353; x=1762550153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HFZ3cOuhc8mkvqGRr8iMXyeFtjdCa5BH/GDXyvHjKUg=;
 b=BW7Yi++QISnKp/mB6lZv+ovAOc1tnmyDERn2fIkV4coA2kBRNope4qYvxjEpmriItl
 I/lpchfNrhKW/XJElCAdkURUn86btwnQpP712m8nD1wiJRKKAYim7QmZ4/ju8YcH/i4S
 ehLuN4LUxWUWyPjDuj5GOgLYoOOCo2lAG1PefqEirc5AiseEkTxxPleibIXZKOxhaJ/H
 oWN9XBMB21wJm3x4fs+9ptslU0BlLNDmg6sMpsr5CsHmYI55P/6Zojmg7P9qu67YoMmG
 MQqgH4kNo4SZr1ep6XlZoHqofkuWJqTC/SQflId505HZ5z7BVrUNUBcuZbBDfZw4/VFK
 zvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761945353; x=1762550153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFZ3cOuhc8mkvqGRr8iMXyeFtjdCa5BH/GDXyvHjKUg=;
 b=cW0K+86vbmqTyYX4kuOGYQKP8+/oTooaYq8i58pqK5q1PDhuEDuYgU3T90is4WfsV8
 yO403CAhcnoGUjh91Tm0asXZJ3Yvd/mOUpcBWpyp4oQl7Ux/+9fKSItbvZkcOmAnNodz
 rGX2FRDUZTKydf7v3n61nC4FmMm08NIpuWa7ATGTS160678WXflffCe2L+ykFzb8Au4I
 8vMSMy/JGOnJgkh0NHV5iOQdZ8S4E/HSc5LroS5Yt9wEq7RgiADPmpIBkwsb5jSC1fey
 VYjh+wfEb5OmGhpH42ZhzmBwRjkF3AhVGk1Cq5+grm1egGifTwkKOR/NKpTTXc8eIvoE
 AZow==
X-Gm-Message-State: AOJu0YylD5kBdP4iA0GkZxP0fdJtN+d5YsbIs3AAuaRhsmEJIJgR0kZw
 qzqqv/U/ogV+kwJERlxnqIyvpiamQfdTXeyHT5IBdLheGJV/NzVx3sWgnlzdRZsNe/qE8YDPMal
 7rf2H9DBztQ==
X-Gm-Gg: ASbGncvWytQuaUczEq9z/guSxo5OFj6na7rqbf/yzuL9ZA+2HI2AuSkR1NVjWtAHxO7
 eKXlJymRI5s2a3gwgTCU1pKX21GY4mpA73gMn0F2hNUQxRpefMisgr8+Zpy7TJH4V0wtLc+0hRi
 mcxaAC9Os501eUKL3bBOgYeXClyRXfnD8I2IplBegft37DM2CcB8ec3tIop7tt7fPk7CXFCd9Sy
 MqNZKsU2yFa8PSa7ZWheexg/TuedxuE1BjpNP1P7wyN86b7KLTSZi8em7q+5pfOhB38qel5UL1m
 dzVKqll9lRAXhS3VXqfzYZNR2lQcrmLH1KVGJshKYfeZOtzMOQGTYA042tY1180pLI4nTB1zqHj
 XBeN/9AZroZTQLQ5NG8C8wihXl7cgSNwg9NMlILaKNSAppD8gV0fkXeqAW0jq9kbP2FBQ4wRd2P
 oLPctzSXQjL6Zq75DInY7g4Yg7ergCAbIMlJ61Rm/ZlzaLUzFelfa3XQVh59tcFtmf
X-Google-Smtp-Source: AGHT+IHjug+um51Ev2IgrHFR0N/6rD4FjmdTDnTbuhjl6rFOV9bqbpaHIQQgGmg2Kl5MSW0/Ul1CEA==
X-Received: by 2002:a05:600c:4591:b0:477:c37:2ea7 with SMTP id
 5b1f17b1804b1-4773089c4acmr51129835e9.21.1761945353186; 
 Fri, 31 Oct 2025 14:15:53 -0700 (PDT)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772fd38c4esm28114095e9.12.2025.10.31.14.15.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Oct 2025 14:15:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/9] cpus: Access CPUState::thread_kicked atomically
Date: Fri, 31 Oct 2025 22:15:10 +0100
Message-ID: <20251031211518.38503-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031211518.38503-1-philmd@linaro.org>
References: <20251031211518.38503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

cpus_kick_thread() is called via cpu_exit() -> qemu_cpu_kick(),
and also via gdb_syscall_handling(). Access the CPUState field
using atomic accesses. See commit 8ac2ca02744 ("accel: use atomic
accesses for exit_request") for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20250925025520.71805-3-philmd@linaro.org>
---
 system/cpus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index aa7bfcf56e5..74f5a5bd4e2 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -480,10 +480,10 @@ void qemu_process_cpu_events(CPUState *cpu)
 
 void cpus_kick_thread(CPUState *cpu)
 {
-    if (cpu->thread_kicked) {
+    if (qatomic_read(&cpu->thread_kicked)) {
         return;
     }
-    cpu->thread_kicked = true;
+    qatomic_set(&cpu->thread_kicked, true);
 
 #ifndef _WIN32
     int err = pthread_kill(cpu->thread->thread, SIG_IPI);
-- 
2.51.0


