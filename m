Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DCCC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk59-00025Q-EM; Fri, 20 Jun 2025 18:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfbp-00080d-8z
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfbX-0006cb-B7
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:32:46 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so23719575e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440761; x=1751045561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JYNxm/9JR0usexPihGnBVtiBeKdjFkNxhBcLz6nJs/A=;
 b=EdmEqC59wSCNtc6YsdE/i2eOVRp6WUQL1SijiOYZn9mWAse32HH/o6Kw5zrcuWI/3P
 WLEgwrtHn2X08nMWpDIvrQt7KGgwQx6MH/2sZ7k1ukeN+Mx9gzGz3P711h0HyfR5/s/z
 GaQqcXtCFqRQuWRFvYhM6kojT1a8mHe7EBQl+UcgLbFr/XSd61mY893kBKwYM44GjD6C
 SKZ4cSJhdUBTVnnwv+cEnEoeZZttuN8AZYWKR26dINz7hnmtyHVlw8xTwpLwJ4udW1Hp
 m3vbrX/J9cWLEVQNDhnk+2/xHUE4OhSroN6QTy2H5xsTlHlisihs/KOg07XzsY/xz9JE
 t4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440761; x=1751045561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JYNxm/9JR0usexPihGnBVtiBeKdjFkNxhBcLz6nJs/A=;
 b=Rb/AjhNbOWUq3qoYmIN3CB0Mrhv4H7f3qNX8PNBQQRty1at4mVc+opXRvAo83a33dD
 BmcVaTKmEaFsYIfzAaN5RhYNMlQU3qxE30toAZOfCQUYSTsIBrGL8V7whKWk7myL3YHD
 VO0yeurhLEle1n5+DvDVgsw32xuFi3sp0FhZ9d8aRcRPPYzKWIqv7W0ZtgvN77iwO2aP
 juhTzx6IQaTaG9kyuEHJs+LFPeY9eYN0Q10feFQeqpt6V7reGbwlRN/VZpEiZXfwSC7L
 a6Tdd4IJfR56OgCoM7wP20kw8g5rZ2Fk5xN24F9ba6zxda2E1mQPhu5/wny01B5GGPlp
 7EaA==
X-Gm-Message-State: AOJu0YzgabW5jINHvwd017p4h1EH+peo2TDgw3ym3DMUbPfRcZhPb5/y
 BE3dtZnWHCWH+T5AgpowHm9xYI9mCntwX1gke0V+jtQA4ZxET1L47Z32xcHe4/iaplBao691Erz
 VIiWg4l/8yQ==
X-Gm-Gg: ASbGnctam68rOKUG5wIEQuHRLvHnMVf7YW6ukEah4VTiz/d/aHwFiCUxfYDqe2kqN3t
 rYFsf9BCfMn3ZXYmZO+G1NxYVhkNQAgowBILEv+pY3VfXOdLa0yZggAjgRZFvkevrZNA8DZLa/n
 WKy2ST4zmHg63VByNHzBGNbB09K7a4+NH4IWw1XycDfBZDQgIz7/x7PE8ZudvOCIpG+T6hJu5+f
 WixYFcNs154YlJ+XjG90suDZ8hXh2cwmAIzfoV6NUaEyOgpbb8TeYeG3h4M9NG72WDhNEoPGiSz
 E/4wXEo/PewZpUSYkOXc4eVvfV3eoJ+f68qohkvJF9SWt7bjvl1Gh+8znWHC9qCEPWpZ6bhzsCI
 5dwO8Ih32O6QMeBHZSxR83Bnwgh6dahZnI85v8+0jgLGao/V8e2kspMaO
X-Google-Smtp-Source: AGHT+IFl4ZuP/djvDRrRnO8PnTHZpcdveIu/AZ6cgZW1iGsqxiAwtLyU8SX+AkU1MehX1YmdaoCFLg==
X-Received: by 2002:a05:6000:2d05:b0:3a5:3517:de3e with SMTP id
 ffacd0b85a97d-3a6d1317833mr2604376f8f.35.1750440760768; 
 Fri, 20 Jun 2025 10:32:40 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646fd7aasm31533835e9.20.2025.06.20.10.32.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:32:40 -0700 (PDT)
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
Subject: [RFC PATCH RESEND 33/42] accel/split: Implement update_guest_debug()
Date: Fri, 20 Jun 2025 19:27:41 +0200
Message-ID: <20250620172751.94231-34-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel-ops.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index eb52d690c7c..d59e70e0d9b 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -252,7 +252,16 @@ static void split_handle_interrupt(CPUState *cpu, int mask)
 
 static int split_update_guest_debug(CPUState *cpu)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
+    AccelClass *ac = cpu->accel->use_hw ? ACCEL_GET_CLASS(sas->hw)
+                                        : ACCEL_GET_CLASS(sas->sw);
+    int ret = 0;
+
+    if (ac->ops->update_guest_debug) {
+        ret = ac->ops->update_guest_debug(cpu);
+    }
+
+    return ret;
 }
 
 static int split_insert_breakpoint(CPUState *cpu, int type,
-- 
2.49.0


