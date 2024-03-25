Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C48C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1romFj-0002kd-4t; Mon, 25 Mar 2024 11:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1romFh-0002jz-5w
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:28:45 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1romFf-0000FN-Jf
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:28:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4148c2a3a3fso2442715e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711380521; x=1711985321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8n9QPEOuM1pBugupKeEtDOMCt4itsUe/QSxWC8eJVGs=;
 b=q09GVRf8AwVxR5MS0TPchAdJaDRMzVURCtc9cuYVI+V+V1Hg1z7+d47Ux37CrcjbLo
 Ow9pNs+gf/pL9cwyaueMJzKdXtT45PRMLM45Rh+cpqR4VEffLaP2f4c6J6w4uikfNezX
 LwlRzbqaXfOHV9YNHmqpjNFVdRqEUrD0+V56rCNhqFW4dV5kK41Q/64JdZe2RGs9GPQ2
 nbN/vIjhFBxPYR+ROB7Q4w/H5T2ki0GJbrVf6528KhZY+WC0NjbRAaKjnVW1SkHBV5SC
 NtQvMUSb10uqj8dMgmYfvpza5eY022zTiahARWLeRHlSmtAbb4eQKtZGeEqo8gRCqh+I
 fGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711380521; x=1711985321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8n9QPEOuM1pBugupKeEtDOMCt4itsUe/QSxWC8eJVGs=;
 b=oOg9xlK8Y6DrAWGvDVfJAJ72qtB8jnPGr/YJTUrd231o4Zikq+p0KbusPi8qBBhuNs
 izYCFgyGGBb1XpolDBSKw86I6TRWrcnP3Y18NYoHYLPRw5d8/ikD5CQp9O1qcSDS9tDw
 oi2bq0HHJW+7RuZqI3eyn0yRLnGHZqslDdapuGk07lHgt4QnAE613ik8r1pn+VWhPWDI
 0B8b1R81Ga/sX4dWq1cTzCAjvLzy+q/iNvKhvUIdd0jh4Pe5+QmdgJQGNturT4wn5ddZ
 EFJQQzTePy7QlyhwoZ4aJsxI76dyBEiaR8D0rDtQe2KMYQVIARwTWYbKJ5ks/tVnyGSn
 nnoA==
X-Gm-Message-State: AOJu0YyPYS1/djUawDTjG2NP5qBA1AswTzs26ov+K//5atp/UboC1ZHs
 WH48TRUsD3uEEW6BZpPuyw24YieaXWnIqzcX09eucwVhROfHK+aQlxv2jOYJO5el/vVl3/dkGKg
 W+RU=
X-Google-Smtp-Source: AGHT+IHAeXeWXLRp31cD7GvqxHEALRJ5TLv0S67oOXfzGfPkIgaBSH2RTfHmRUDz0t8jRdRCjeQv8A==
X-Received: by 2002:a05:600c:1395:b0:413:133c:b9c8 with SMTP id
 u21-20020a05600c139500b00413133cb9c8mr5519116wmf.33.1711380521437; 
 Mon, 25 Mar 2024 08:28:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 fc19-20020a05600c525300b0041401eb021asm8763725wmb.24.2024.03.25.08.28.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Mar 2024 08:28:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v3 2/3] hw/misc/stm32l4x5_rcc: Inline clock_update()
 in clock_mux_update()
Date: Mon, 25 Mar 2024 16:28:25 +0100
Message-ID: <20240325152827.73817-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325152827.73817-1-philmd@linaro.org>
References: <20240325152827.73817-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Trivial inlining in preliminary patch to make the next
one easier to review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/stm32l4x5_rcc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index bc2d63528b..49b90afdf0 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -48,6 +48,8 @@ static void clock_mux_update(RccClockMuxState *mux, bool bypass_source)
     uint64_t src_freq;
     Clock *current_source = mux->srcs[mux->src];
     uint32_t freq_multiplier = 0;
+    bool clk_changed = false;
+
     /*
      * To avoid rounding errors, we use the clock period instead of the
      * frequency.
@@ -60,7 +62,10 @@ static void clock_mux_update(RccClockMuxState *mux, bool bypass_source)
     }
 
     clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier);
-    clock_update(mux->out, clock_get(current_source));
+    clk_changed |= clock_set(mux->out, clock_get(current_source));
+    if (clk_changed) {
+        clock_propagate(mux->out);
+    }
 
     src_freq = clock_get_hz(current_source);
     /* TODO: can we simply detect if the config changed so that we reduce log spam ? */
-- 
2.41.0


