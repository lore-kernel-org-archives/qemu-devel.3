Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB949C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk7I-0006dA-RD; Fri, 20 Jun 2025 18:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfaf-0007px-O0
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfad-0006Yi-SX
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:31:49 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-453643020bdso9571705e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440706; x=1751045506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnoK/XSz4Qzzeu+eF5hoQ1ML+ghfljCey3DKK+8BhQc=;
 b=RGdRoVk+uIHVsHTcIqswJa+3WjjCNhwvTZoRhbYe2lIUnXX16jALOP9iPR3NEhi8CI
 wBeNYhPTpa6BrRD1owBjFClz0yS8CVOr0mr9DOCh9JodGa44GdbUgpctWzKk5DrITmR5
 IE3j68ceC458hfUJgZ6nd+/DDqdkdt6Tf/l5fjDdJlqmoKgUICSlVmV22nNczEm5EN3P
 pzrkf1+REUnc0aPd1RhTB0M+0EJeGmTp9ty7I2jFpjWGu11E8bt0L6MlPn6sKnwfAQVA
 kQ3PYvaI1sy6bYv7OAKSGynpyQKpUvRXCBHT8srwYxjyNLwxLHbud+Eo24rfN6i2FzKv
 Pm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440706; x=1751045506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnoK/XSz4Qzzeu+eF5hoQ1ML+ghfljCey3DKK+8BhQc=;
 b=O54+pycuuFSOAbUjfQ2zJ69vk75o26lBGMqtZv4hN+JwACMFwUqaGei3OxdFnxFHKG
 Re6VwraXTBgADbf+jRdRHJehj4Jt9YmyjGwetPC+1z5mbrczT8bwbrw4/K5AK3Q8Lt/s
 3R1yDmRBCK/oAgOWnlt0b0ptRQafUIyEsKUkSDIcFKuH8+EkUJ8L7QrIJJO/mE5qmGUA
 /IwyaNF4XbrWF+53G0BEulj1o6r5sKN4zkgSZC58k865XrbwSreYzvFA2DjigTsMbgrE
 Ct4apziPeLr6jdpglQqgEKH1R2XtUCHT7vyIlNFFiWaT1x8q3So0QxReEHGs3hy6Og8q
 n85A==
X-Gm-Message-State: AOJu0YxVJAG8SQNiuFVSikILlXl3jiWrw5uzHrd7IKKhVHojftzd6hA9
 Mu8T+0pXcs5sSN5ibybDNe5bldsguknx6BJMCK1Pi33c8pa1pXIvqBkKc+R1YA+Gau2APve6k1x
 Hfv1dgPB8/g==
X-Gm-Gg: ASbGncvv45i1TVWQUg8cHIWTo98Mt8Suw6kJlkchjIB1YsIpdnNRCyTRbIvyWZGv+NR
 sBHxOULbzaFtD1XXsOvbYsGdOpiITHJCYOri3bvwlfnszQWWAksZMPfYi8QEEZ+yBeE9yS+YL/L
 iHH3IUsYH6jIAdhFvgpW69qMXXymfhZuBq/MLHc0V/OX0An8YkkQMQsUkwZwQ6CA4Rt4CLSdfew
 IPaouthm5XpMWN755VJAkP6idRSThwVdzHg6zD58RQp5jMuzGdytgmUD+pVnlrXDjjEmyPolaJi
 lbDZ1YFbSQIepGZVxenph+7RxfJdWOW7JpBiQ83oVZw9HsDVPJW/+DwarI+0TbG9ragLW+k3OnG
 nKVg+S87w3e5tLHbAr1tW1MoEjSu58vqt3C4ClwGcMePkWI7ZjTUlXoDMhLnfRl2MgE4=
X-Google-Smtp-Source: AGHT+IHWtPYzYzvGUq7hFFiKpoAiJnKKEs0+J4TahMcGytzrk3WwebXkdgm2FOZAMoEkGSD2upd+0g==
X-Received: by 2002:a05:6000:64f:b0:3a3:7593:818b with SMTP id
 ffacd0b85a97d-3a6d1302e03mr4074987f8f.21.1750440705777; 
 Fri, 20 Jun 2025 10:31:45 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1193792sm2634974f8f.97.2025.06.20.10.31.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:31:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 26/42] accel/split: Empty set/get_virtual_clock()
Date: Fri, 20 Jun 2025 19:27:34 +0200
Message-ID: <20250620172751.94231-27-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
---
 accel/split/split-accel-ops.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 375821f1064..d19b4641a2e 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -255,16 +255,6 @@ static void split_handle_interrupt(CPUState *cpu, int mask)
     }
 }
 
-static int64_t split_get_virtual_clock(void)
-{
-    g_assert_not_reached();
-}
-
-static void split_set_virtual_clock(int64_t time)
-{
-    g_assert_not_reached();
-}
-
 static int64_t split_get_elapsed_ticks(void)
 {
     g_assert_not_reached();
@@ -317,8 +307,6 @@ static void split_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->handle_interrupt = split_handle_interrupt;
     ops->get_vcpu_stats = split_get_vcpu_stats;
 
-    ops->get_virtual_clock = split_get_virtual_clock;
-    ops->set_virtual_clock = split_set_virtual_clock;
     ops->get_elapsed_ticks = split_get_elapsed_ticks;
 
     ops->update_guest_debug = split_update_guest_debug;
-- 
2.49.0


