Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8E8C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWRh-0004tF-W5; Mon, 10 Feb 2025 11:15:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR1-00047F-3K
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:00 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWQy-0001Ud-Tn
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:14:58 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ab78e6edb48so454676666b.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204095; x=1739808895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cgHEs4UjXEPONNRSfBLs6a+I9ub5T+ewhfrcjtrhUWQ=;
 b=La1vGC0ddQglcVkkun47313KFV30aByQDJ2Hr612sSdPJuci/wQ0RM4PcLq9NfeNCp
 MnPT039Ms87IO5lzrLEwyaOu38uGeEYm8qTE3eCo5mmIMikMXqbb0AW+47mzmxqPdI8v
 TD94y3fKke0/2WNmRdDjtUsVmBFtYMvLNcvX/Llwc1v4+3i5B7a8BAXvTVieRulbAcST
 TIzasjJej3yGisdtTMNcKHprLPl2cn470NmgCRfpOH1nH894JUJg9s//aT9AXRvfkpV6
 XlP58lsuoy9HESUY2xMN06dJn8EJoCzyLHauC0+bZ3XdR0BEUIJXs/Rkx/Of7TxCE1+3
 +1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204095; x=1739808895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cgHEs4UjXEPONNRSfBLs6a+I9ub5T+ewhfrcjtrhUWQ=;
 b=vOPi2FI9VjY7y9wAHJW6ugIkXT+qe+qDTyiiLgKzuXesBwrQHLUwzAfPctL/6oeUqi
 Tfq23hNqExEDYIID5mO0CdBKNj65hEfNf1WqFWgFaH1G4c1lNxrSMCviIvE+eG00rahl
 q3WsTRIlrEWZIDc/aBk5nyBYFfx/vo18U0QqrWaqLo4Z9qSbVSnFwHGIqqvOA5yRL91O
 2Cvd7mveBroVTudIvy+9cKcjYwd5MiODGbCJuzSaV0zRAD+9brGPauuQvVRtsuqSLGR/
 AfT8+xwZ29T7U8ICh7WuU5jr8HxBrTXMhXHQ855l+N6FThkTJz/1rjZoePRd3XJgCqJQ
 m4DA==
X-Gm-Message-State: AOJu0YyizRxB95pjchQYoCjm6LwvY94FydqnlU2TY7TV9KAljNuyQrWi
 h8YmY8Z5hNNLquW6jqSSkLY/N6sslDxGxSMKhEDJ+8UGV4YHJWK//ndqAIfE/s8=
X-Gm-Gg: ASbGnctYxp96A/CldaSAiSjTKuQKja5v4T5NlHiBJUty8cA4TxVnWVas/mcSlkvccRJ
 OkzC9sDofQ4MFeRZgZ70xqn8onFXaW670Wvln13sV96YaO9TMlQChDSxT4OVAC8l7hmKVmGtol0
 a8nWdJyS8tVM9D6bbbg39ssERh+kNxqHgNG/wCVZ5T53liA+JThTRI84W2Ic6CL3vozz194oluf
 EPx0LHe1g1xbrSQftU5hYeM0ui2AZjpC8ujGH5FnzkCkiMLMEbPBSysUNDqmx4fTy8AOK4AajWK
 H8G78viFF/tHtahzAQ==
X-Google-Smtp-Source: AGHT+IE+1nSSACPNzPBxGI3gEjERuVGGbI12sXgyLDT9D246YqT3THYbiTqgghfFY1LgnZJ/r/ZEAQ==
X-Received: by 2002:a05:6402:194b:b0:5dc:a44e:7644 with SMTP id
 4fb4d7f45d1cf-5de44fe95c1mr38189449a12.2.1739204094616; 
 Mon, 10 Feb 2025 08:14:54 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de4e6d60bbsm6224628a12.15.2025.02.10.08.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:14:52 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 11D805FA16;
 Mon, 10 Feb 2025 16:14:52 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hao Wu <wuhaotsh@google.com>, Tyrone Ting <kfting@nuvoton.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org (open list:Nuvoton NPCM7xx)
Subject: [PULL 03/17] tests/qtest: don't step clock at start of npcm7xx
 periodic IRQ test
Date: Mon, 10 Feb 2025 16:14:37 +0000
Message-Id: <20250210161451.3273284-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210161451.3273284-1-alex.bennee@linaro.org>
References: <20250210161451.3273284-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Until there are timers enabled the semantics of clock_step_next() will
fail. Since d524441a36 (system/qtest: properly feedback results of
clock_[step|set]) we will signal a FAIL if time doesn't advance.

Reviewed-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250207153112.3939799-4-alex.bennee@linaro.org>

diff --git a/tests/qtest/npcm7xx_timer-test.c b/tests/qtest/npcm7xx_timer-test.c
index 58f58c2f71..43711049ca 100644
--- a/tests/qtest/npcm7xx_timer-test.c
+++ b/tests/qtest/npcm7xx_timer-test.c
@@ -465,7 +465,6 @@ static void test_periodic_interrupt(gconstpointer test_data)
     int i;
 
     tim_reset(td);
-    clock_step_next();
 
     tim_write_ticr(td, count);
     tim_write_tcsr(td, CEN | IE | MODE_PERIODIC | PRESCALE(ps));
-- 
2.39.5


