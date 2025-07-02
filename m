Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3248C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2c1-0002XQ-VY; Wed, 02 Jul 2025 14:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2bo-0002GF-Cl
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:05 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2bi-0001qr-9l
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:04 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso3952623f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482494; x=1752087294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avPL5wc3uCAbxMdjiOjEAiPWhgKLP3dI+/bwFAvHMvE=;
 b=qmqFD2ucMZQMoA8BRErPD2HSlJEV+2+UEjhmuL0GqMRWoxE1YC+HiRCEAGev5boyGw
 zVyIMxXdI3PV+OlE4Q8YQ+i6F+5ekcnX7Cf+zr1Gu5QaIq8fgItSKBUGaR0dlIG8m4vG
 lvrCFSQh5ALPEmrTvlUwzKW088wk5GVulzIhkDh5soKuVP73gS1GsF8ftcXhECmS+SAx
 yrq0C9SBQ6GxRBAxmz9AE6iarJBoq0u5j/bCPNF2xngKA6dCjkFxccPe5YZ5Q0f3l/qN
 /RYmU8/NuT+3kM5OY/ExDZL+8CCzUMEBrShqJDCh26ExPcWFrVtnKb/ejSEZidktSueS
 S6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482494; x=1752087294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avPL5wc3uCAbxMdjiOjEAiPWhgKLP3dI+/bwFAvHMvE=;
 b=t9ucPiGkTq4j93N2VgmjWKV35ordHjJfz9JOztiS6zhK5UxaebRKiucpRgQYodELfh
 S5gZ4P2RdzvMhmLrRxQd/r0A62F7nicIz3I0Urbay2377ulG00q1/nmrFD4n99w93aLo
 rUpMXfzoKG9hMBYh6kiWvFkc8d/uEn9ZqLqIJkU3uzXuPKxOGTpaeYQPz0w3N/zafo5g
 WhvgS8y33Xk9CO1X3ovgwTce7L+WTVmFulWsc/O63qSudRzSHk3p+PmmYKXEVKOmDfes
 jYdka/qywsYYVQR+ryOR5+Ge67RUvkpOx7KLrMfxbNgzEqz6Kc8U5ZDXV0s3DkN3ZUkX
 DeUg==
X-Gm-Message-State: AOJu0Yw5FtK2GXNR9Qwg8fFqHRmGchRc153DPQ6G/129hUq4honB5Lr1
 lQsfRWB2OpRcL2AFE7aLnuMB2/9XHCoomQ3Mre6JC+Y8q3R0EyXs0Gi+/CGChfEfJCBCzX82A2d
 zz1aP
X-Gm-Gg: ASbGncuvDm+C2hge0b1butEt4sBsw8wj7IJTzY0u7aUbjinUO+GfOUQFhkaV500wIvr
 rtumo2MYL6IweR5Av22wvmchz4RmTwP/nsMbEr1yCBTJpI7rjogw/6/I+rT/HmMrXCr7g2Yyd17
 /5OD16eWhfPHL4QYmTq+Q1u/oNnWaQk1fexjvAP1FP+qbfGJ7UQsTDR2MUFvgdyV85U5ZxCAmaK
 trpstNIBosJCGrGi7mfxH9vinmkO6VXbQJjr7Ml8tkCPpZYfgLXGlwmLufcVjpIrmkLIRTOYXbE
 nI9wDrdipflH6RSGm/sva8EAxK75mv2tL1rgINSsAyvouMq/pAG9QgFAy8mZQSxNCHMi4EPOXD9
 m2XXsYMlPGNfbwB1L5BYA2S7kY15LWH73HJiy
X-Google-Smtp-Source: AGHT+IFPxUaRkpQPVrFQhhNRZZo6xt7TGmCXmlwydWWe7QOUOkZTx/xpwD6RHo8hsEvkUY1d+ceasw==
X-Received: by 2002:a05:6000:64f:b0:3ab:27f9:e52 with SMTP id
 ffacd0b85a97d-3b201203956mr3022804f8f.42.1751482494415; 
 Wed, 02 Jul 2025 11:54:54 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fab6esm17029477f8f.31.2025.07.02.11.54.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:54:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v4 11/65] accel/hvf: Re-use QOM allocated state
Date: Wed,  2 Jul 2025 20:52:33 +0200
Message-ID: <20250702185332.43650-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 6af849450e1..c256cdceffb 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -325,7 +325,7 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
 {
     int x;
     hv_return_t ret;
-    HVFState *s;
+    HVFState *s = HVF_STATE(as);
     int pa_range = 36;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
@@ -339,8 +339,6 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
     assert_hvf_ok(ret);
 
-    s = g_new0(HVFState, 1);
-
     s->num_slots = ARRAY_SIZE(s->slots);
     for (x = 0; x < s->num_slots; ++x) {
         s->slots[x].size = 0;
-- 
2.49.0


