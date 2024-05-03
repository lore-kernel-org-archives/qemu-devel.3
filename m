Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FBCC25B4F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 09:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2p2h-0001hv-9X; Fri, 03 May 2024 05:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2p2e-0001hY-4h
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:17:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2p2c-0003aM-K5
 for qemu-devel@nongnu.org; Fri, 03 May 2024 05:17:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41b5dd5af48so63880165e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714727837; x=1715332637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8DwnhcqDdYLqJv6uh/ywG6qW/XlS7dFgSw/LzDaIEU=;
 b=JGWtKHlHW3G7TlKBdB1wnjwifucetiaBr8ST0mZfmhrdDjhzo5/gLwEqbCHguZKtdD
 zIjspNbo8OKSRfZHHx04ywMjC94r4CC2p6+mk1FZiU4fpM2kx23RQg4JJfcaryBkCAqQ
 pvcQSpRG/LIjABVxOydCtaExbRwCbe2QSzJ5EuL3jAlbnkSexbEYq2dV4wQyQW7RXHpt
 7ErwkLj1q0nl4IiM3Dx+2VA6h98noBWFY1gKLbtyOfyw9BW9AWD/m6u5ZXyBHqs1aU3o
 PVQHglDpi7IYeI+aXFshwSKNaVvd87X+UAbF7/Rc6Q//8j/pXQ1uizo+MoTxUVPmLZO2
 xkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714727837; x=1715332637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b8DwnhcqDdYLqJv6uh/ywG6qW/XlS7dFgSw/LzDaIEU=;
 b=n1VZSgQ38TAqZJGt5DZBTldXCAhmFX6FrauPQvDj1acnD7fT2Iybg/aMIGXz3Np4Xh
 2aNe5+nElPFLzwsmuTGXUUSLjwYuAx1nIhH43icXDnSyYvDd3i8Zr3yA4vxYn1buomcL
 2NapzXqJbGm0jprEDs7oebVix3vmM46EKQj3G7B6tkQEaHVrTj/OaHQetopkJBQVhr4S
 dg0TKE9x/wmpavLb1Dasp3q50EGixF128Zfw9s1l3igwKtobM/bUFsK4YQdVvuPoPNq1
 zF5wvtFVr5UHnJqCBot8cKEuWctDBMbL7Ko860Uee9qSskYoJfU19QgjveeaJ61Qe2MU
 tylA==
X-Gm-Message-State: AOJu0YxftHyJUzRJpRkFuJjKQE3M/tYo6d3wHXSKVSfPvr+QNLys3PpS
 dOUl/w6DmMBltroylBl8soeoyRQdyPY2S04QUyIQqZS7fobWZnReLqdunalfFrDiE5/iLaSwIB6
 s
X-Google-Smtp-Source: AGHT+IHibdFYFzUM3tCnTMBN3FzT5eHj6ak13Triqjj8pOwwoHrzAuumP7GpRpdo+l7l/Pmlur4hcQ==
X-Received: by 2002:a05:600c:1c09:b0:41a:a4d1:a896 with SMTP id
 j9-20020a05600c1c0900b0041aa4d1a896mr1749656wms.16.1714727837029; 
 Fri, 03 May 2024 02:17:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a05600c478600b004185be4baefsm6847025wmo.0.2024.05.03.02.17.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 02:17:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Kyle Evans <kevans@freebsd.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] accel/tcg: Do not define cpu_exec_reset_hold() as stub
Date: Fri,  3 May 2024 11:16:55 +0200
Message-ID: <20240503091657.26468-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503091657.26468-1-philmd@linaro.org>
References: <20240503091657.26468-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

In commit 1b5120d74b ("accel: Introduce cpu_exec_reset_hold()")
we defined the user emulation backend cpu_exec_reset_hold() as
a stub. This was a mistake, since common fields are set in
CPU reset, and user emulation needs these fields to be resetted.
Move cpu_exec_reset_hold() back.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/user-exec-stub.c | 4 ----
 accel/tcg/user-exec.c      | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 4fbe2dbdc8..2dc6fd9c4e 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -14,10 +14,6 @@ void qemu_init_vcpu(CPUState *cpu)
 {
 }
 
-void cpu_exec_reset_hold(CPUState *cpu)
-{
-}
-
 /* User mode emulation does not support record/replay yet.  */
 
 bool replay_exception(void)
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 1c621477ad..6a108eb212 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -37,6 +37,10 @@ __thread uintptr_t helper_retaddr;
 
 //#define DEBUG_SIGNAL
 
+void cpu_exec_reset_hold(CPUState *cpu)
+{
+}
+
 /*
  * Adjust the pc to pass to cpu_restore_state; return the memop type.
  */
-- 
2.41.0


