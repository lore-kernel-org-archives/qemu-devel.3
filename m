Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921E2C36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 12:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvbwn-0007lO-BR; Fri, 21 Mar 2025 08:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvbwj-0007kC-7X
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:57:57 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvbwh-00031A-NI
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 08:57:56 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-399737f4fa4so1197624f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 05:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742561874; x=1743166674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VI0tJYTkCb6gsC09E2J8+oKikCYS17hZ29QKB1qjUsQ=;
 b=Gt+11wjYIqVNjFfdRobtxCVUHAWaY0MvTUYSyxzk34LmgdtZOY77q5gWyxy/dyXjOh
 4QKwGpPjC1/MMJ+dTkkqBDrTOJCuHODyfWFFwhNWmZ+gVnB38YPMAAkUryS1HJXJ1sow
 Uu+uclkSMkNcQxC1fYh9Ixp7/+AkMhl7d9zMQaqV3FSwfULINC+LM+osFOQ5b+s3c0JD
 19szF+Elcb1Qzxqh/ru0wtSggoWvJvVP6E4kGNGOFjQV+MDRBzfLVaxDQ3yMc327ZTa9
 cY5HQzzoj5MkbaCg6heH3ZOEPs2MnUBc8788zJ/tjPRHuBb/hlVw9NplGxCUdUA2GvN2
 pWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742561874; x=1743166674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VI0tJYTkCb6gsC09E2J8+oKikCYS17hZ29QKB1qjUsQ=;
 b=vcY1x0sgYSXebZh9fiLANy5KeogbwR0Zu7cQa27/K3ZRHE0OV8aKDo1ckA6ek3HE1I
 anQtMT/dy7ZEWpxlO9GIDswOfB6K3PQmiNTZPP80c+T6WDUMU+r0UETux74cY1/NZ9ap
 MWoP116hovh6R9K0USOYZVXfzvOZPPTQ7AOlXluSZaVXSvxgoX5520RAHO0XWHBXHTwZ
 +Y6yvjId4dTnn+ibPwH2x1WUSre4Aj6413uNMuzqIWdB5/qCEhRJFCB7H8e8Wq6rFSTX
 vVCaMq6p7wRFWJP8lUbnEZkWVb0EPeUKg8eOVEt+AWPMJebc3dkw3JX1KjNVxqUrdjPK
 LrJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbNYh1mqApt/rG6ZDEDdvqTX+n5X9ixj/pwaVK/amjdBqeFBOvR5zUL2Y/57Xri9G5AMQIfT5c9cs+@nongnu.org
X-Gm-Message-State: AOJu0YxBMiMbCeKKPQYh/hV8vVRY5djwB/lD8P2az080shWLYvr5J5uE
 RUK67a8CWhw/I7vWu98zIY3gjQ4vwGZKUlJF5tv+AnLMjVkZk+78WF9sqEEb3bQ=
X-Gm-Gg: ASbGncuCc6WvlHWT6uWqKvZK+sCDi7JgLFU2O6Jr7x3sRULQZ2W55rPcsrPedgFuxz8
 KhPbt48kQFg5e49kqPiQKncGpzyG3hWZmtEackAnwD46/EJUvBZdz1RNtltVWCNXo0LFiaQ0G9X
 paAH9RabJYu4w/wYglbkgYw3cLHrwa6osc4ENr3/4UNNpgvoZFPyypSyHKIsAUtFA3/m2NX6ilf
 +xgL1+dRVyI5LFxZWq8lBgEb/ShtTW/rAHTK54UfVe0WTxHdoG0AWPIlsslhVcnCKMc3pnqzHM+
 Ke5TVS47ohVQmpaLG7khA34T9WKFEul4dkAH+aRTauSRw2AlkOBZ5UdTvieVdcAw5BBFnkDtYFB
 0GpNuNlhchYBdunaZNa8=
X-Google-Smtp-Source: AGHT+IFsArRFc0g2J0pBty//+Qzu4yGU7UQStM5FjybLlQmONS24avAOKz4i7RkDGRlkie9AmzKbXA==
X-Received: by 2002:a5d:5f8b:0:b0:38f:231a:635e with SMTP id
 ffacd0b85a97d-3997f912722mr3297314f8f.25.1742561873979; 
 Fri, 21 Mar 2025 05:57:53 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6539sm2305615f8f.77.2025.03.21.05.57.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 05:57:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-10.1 3/4] tcg: Have tcg_req_mo() use runtime
 TCGContext::guest_mo
Date: Fri, 21 Mar 2025 13:57:36 +0100
Message-ID: <20250321125737.72839-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321125737.72839-1-philmd@linaro.org>
References: <20250321125737.72839-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

In order to use TCG with multiple targets, replace the
compile time use of TCG_GUEST_DEFAULT_MO by a runtime
access to tcg_ctx->guest_mo.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-target.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 1cb35dba99e..014ee756f9d 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -49,11 +49,9 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
  * Filter @type to the barrier that is required for the guest
  * memory ordering vs the host memory ordering.  A non-zero
  * result indicates that some barrier is required.
- *
- * This is a macro so that it's constant even without optimization.
  */
 #define tcg_req_mo(type) \
-    ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
+    ((type) & tcg_ctx->guest_mo & ~TCG_TARGET_DEFAULT_MO)
 
 /**
  * cpu_req_mo:
-- 
2.47.1


