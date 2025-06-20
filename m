Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35430C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfLT-0002O7-Hq; Fri, 20 Jun 2025 13:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKY-0001P0-5x
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:13 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKW-0004SU-Kz
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:09 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso1373222f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439707; x=1751044507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=veQWKG+tAZzHOxq5ZSFoWdE7WJpX7Ekw5t3gq6/7ihM=;
 b=gVjhKtwRoN+FQNCHZAeaPEQXc1QSKvVuWQctMBTq0AhhjaBK474h/PHEpYFyRtmOHg
 ZxhrsEHZdPY4RQhvTgZESFHK3j/Cm2QX7U06pVhMqspZtuwdEYR14rNLcUh3sblnBzlT
 OWe4+Gulm4zyCEsWAFxGe9CLLLJe2aX1mTauX2xMFQNn0+6dnDyYOAR0IhvVgiCrfAX6
 ZzaasBFFYRBsvfYj8r0StIvMBXNTerQioNORTYjgXwrjxxCkZMSoiUU6j3lH7ORsQt6k
 u3gGjp1p6NbXLIqTNQmOeJgSYJ2QKAEt+kIxPkq48U177qgO/l6fCXyPmJOAQkWdMSvX
 vJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439707; x=1751044507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=veQWKG+tAZzHOxq5ZSFoWdE7WJpX7Ekw5t3gq6/7ihM=;
 b=dsVhwHxbJYhk4NeTS5JiM+R+BFWblZOQf5AUKVoBQFDC+wxwjiFWyLT2aVDL9LpXs3
 +5moSsJ3tkKXlfxI7ut+SjZJZ7nWFcsJy2FR8crISU+1S1f1fak+wygqtTlXmHYry4xi
 /nHG4T+KD/WasWSO2HHDtjj4aBShz3ppoY/ZkMR3XVQM9mpG0J88MVMHpfpWiKf+wOej
 dEdWTM43CW+pmp7fAtJdQ47ACtt1VTeQFvwJMw7Nd4Lz6osh6gBWhHsaJ6TMbTaLzeZ/
 fWUy8gwc5gaKQFVJSFVKgJk4du4R0YZJxVoKhEuVUwCM5JULFxfFOgG3jZXomgaGNu63
 5Atw==
X-Gm-Message-State: AOJu0YynzXgM3O5xe2oIZkJW4JlqWX9QX49/ccrlEyo1J7DlvT4De/bG
 TsXobH13WLmCRZi0VPyju8GosBQB0Dyvx+vSa6303mE8CwQTemiApSxe3ljiEMu/znGeRoahTUv
 Koarzyz8=
X-Gm-Gg: ASbGnctJLwGB+L5ZKp8EPvcrmkNqb6Tw2iNZR4MZHCcWYmG2Y3RvD5dCns+w2+VyuCK
 2HJ/UlvTQc/nRkG6SEfIuSn3gxuD8XmSQnvRhRIEW/f0AZEJAd1C/qQDGJIVwGqGlqitVPVPp9Q
 cnUJBHBvzJ7OXoTpCinQquf1fN/VoH4jwG83MV7m34jhZw7lnm7KDCrCM/9hoEN7/Ew3X1Zvj8O
 Joxi0lGv7+uKcnwrDgBn0hqWvgYq378Eka4oxRdNTdOS3m0abQx4lH4bZUGRIyh2SNPjKtOto89
 bWIta3st22OjScHMEUD7lpt4dcYpBVPGVMhqVs9zeKB3vVf56iS7DIf9I3rfd7CfxevpzroilGM
 N5FXDMb7u3z0JJ5gSL46zwR1OttYCVb2vXlI/
X-Google-Smtp-Source: AGHT+IHhqqj76H6dbDrcxZA7pa4kPGKUVj4LlGXDs+aF72DBrfgN4/jTH92YaaBeLR0H73z6vJwd9g==
X-Received: by 2002:a05:6000:2308:b0:3a5:88cf:479c with SMTP id
 ffacd0b85a97d-3a6d12d52c5mr2945845f8f.30.1750439706646; 
 Fri, 20 Jun 2025 10:15:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0ec947fsm2601237f8f.0.2025.06.20.10.15.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:15:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 17/48] accel/tcg: Implement get_[vcpu]_stats()
Date: Fri, 20 Jun 2025 19:13:10 +0200
Message-ID: <20250620171342.92678-18-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
 accel/tcg/tcg-all.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 28206ca5e76..f5920b5796e 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -239,11 +239,17 @@ static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
     }
 }
 
+static void tcg_get_stats(AccelState *as, GString *buf)
+{
+    tcg_dump_flush_info(buf);
+}
+
 static void tcg_accel_class_init(ObjectClass *oc, const void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "tcg";
     ac->init_machine = tcg_init_machine;
+    ac->get_stats = tcg_get_stats;
     ac->allowed = &tcg_allowed;
     ac->supports_guest_debug = tcg_supports_guest_debug;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
-- 
2.49.0


