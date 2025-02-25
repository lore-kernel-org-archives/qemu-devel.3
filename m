Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF57C021B8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzxW-0002OA-Jv; Tue, 25 Feb 2025 13:47:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmzx1-0002Bs-1n
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:46:43 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmzwu-0000Gy-0c
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:46:36 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so3444428f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740509190; x=1741113990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDlMUFOwH6hJmcvGcn7JgUMSqs3wExou9nUbHU8n3vQ=;
 b=fx0CpoMXTEzbtedj2vYtIJWnBQhQm6UcKcwJxIr6nD0ouHCU4Y77qehgbzEcLUO5pn
 x+Wk2vLHP9FugnnbRoGIbY1d5L9bII2aw1wj7UbOrrqB/W2iquVZyJnrnmYiL7ZFkE77
 94cfoaHCCT/+zC1ImJ2/SRo+NwWbeM22H1NlppiO9Yu10GQeYMuiKkAKJeD5NxIZo0zw
 tLu6T3cucWm+FvYHRLEsnrvn3pRQbQ1WAPgJQRcNiwp5Pmx9kwxjTdAl0m4yaqRapDuL
 bRdSaEqiO95Caa8PDOVegzhoYgAIhwJTS5Pz4swes6h+Y2a+qYdzPxlPIHniOrKqX1oo
 kq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740509190; x=1741113990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDlMUFOwH6hJmcvGcn7JgUMSqs3wExou9nUbHU8n3vQ=;
 b=pVoL+xKGHXrLMFcNPkt9b7AsOM8XpP0BaEKz0PaYyKyJ1sczHKVkAsfLYFXwp3yeGv
 kUWWmtDHMkSZ39JmKli/o0inM18m3jF0wE8W+o0PFbMEKaKy0wVyhoKUFnEqAlABbKOw
 3YTIsnjgB/9Y+Q/uW/8dEMav+brYyjr93EH7kSo61QMyLBZNkWzY/lz2tyuNA56O2vpG
 Bc98LZng7Pv3GdNJT57/S/nptnHyWmI9Nl4xg0+NKx5vU8aM3yUVIsGtWapSNpdubOTh
 jKNNSktzEZV5ofYEsA7pFT9cyZeZoDl5QboS87l5FD+/cXLeLBz6ckYkOR+l24QgS+10
 a8vQ==
X-Gm-Message-State: AOJu0YzJlujNRFxET9cghWxcQ6rgoyshfHNLJHDBX1yXibqm8kqSmCpg
 AIjhYgDA2NX+q/LIJyQWVi0RFNJjl2DRE0tltgsqReSafPpY7L1ZGATCw7OV7OU=
X-Gm-Gg: ASbGncslD3VssObE6xcNSyYr6vvrvmnK0RLFoPyPRAiSHiqWeZHXIuO91q1oR5QIT4/
 w4B+BH2mcFemS/Hz3dc+hbcNA+u+OcBsflwS8Vs4PeqUYo+yZSXFi2AbI1ngUkYfL3JB34sEXtH
 3q2OCyw6R0lPj2PkSJzo1dEQ4H2Iev4Tmm4rxZjw6McBlNSsOVV18aB7RWjQ2NeUvTKXBc2IgYT
 WsVGd2bt0ikMWENNUXptMe4oX2FALnxkBveflq/9R6KS1leLg1fTE/MutlH9CxkhyAkAnqQ1ofg
 lU9SFbPNpD/n85unWFU5Qv6CUAzS
X-Google-Smtp-Source: AGHT+IGJLbbAIaLLV3V1DEScKsw2Hes3/JL7CKJNmV5zGM2ZYa5FuMt7B/RSZNDofv61do2GXB2OSw==
X-Received: by 2002:a05:6000:1a88:b0:38d:c55e:ebcf with SMTP id
 ffacd0b85a97d-390cc63e0e1mr2854657f8f.52.1740509190168; 
 Tue, 25 Feb 2025 10:46:30 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8fc1f9sm3107205f8f.88.2025.02.25.10.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:46:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 990E85F9D3;
 Tue, 25 Feb 2025 18:46:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/4] target/hppa: defer hppa_ptlbe until CPU starts running
Date: Tue, 25 Feb 2025 18:46:26 +0000
Message-Id: <20250225184628.3590671-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225184628.3590671-1-alex.bennee@linaro.org>
References: <20250225184628.3590671-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Since 30933c4fb4 (tcg/cputlb: remove other-cpu capability from TLB flushing)
we don't expect non-CPU callers to the tlb_flush() code. Normally I
would drop the call anyway as the common cpu_reset() code will call
tlb_flush anyway. However as the flush function does more than that,
and is called from helpers instead defer it with an async_run_on_cpu.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/hppa/cpu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 5655677431..b631af381c 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -168,6 +168,14 @@ void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 
     cpu_loop_exit(cs);
 }
+
+static void hppa_clear_ptlbe(CPUState *cpu, run_on_cpu_data opaque)
+{
+    CPUHPPAState *env = (CPUHPPAState *) opaque.host_ptr;
+    hppa_ptlbe(env);
+}
+
+
 #endif /* CONFIG_USER_ONLY */
 
 static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
@@ -191,7 +199,7 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
 
         cpu->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                         hppa_cpu_alarm_timer, cpu);
-        hppa_ptlbe(&cpu->env);
+        async_run_on_cpu(cs, hppa_clear_ptlbe, RUN_ON_CPU_HOST_PTR(&cpu->env));
     }
 #endif
 
-- 
2.39.5


