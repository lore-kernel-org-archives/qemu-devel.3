Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0E0C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 18:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkpi-0007dT-1D; Sat, 25 Jan 2025 13:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkpf-0007bz-Ty
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:24:36 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkpe-0005mi-B4
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:24:35 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385f07cd1a4so3216230f8f.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 10:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737829472; x=1738434272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JIgbmtfxOLMYajWOv1VhSlZC2BvLUVwsARR8MibuLw=;
 b=kV/mTQT5yAQj+nVF5fZS3MFglo+I3yhqnM2eI09nc5tOyuYvCPivKAUmAWMqSbQ25a
 sCB2CO1uHnQaG83fvBcZhyxOesPzO43UAi9f2yYqKhqHRFKZijnB27UpxTh7PJEslhGx
 SD5Jgynx8IrqWJnJXl9dwUlvuVMAR0VvlQk+qZwAPkVGU2tPb4yR1nfxB12CF9bhC60z
 ZOU5psVbF2m5QJzX7ES6RFHCQ/5U3nt7FUmdxIaIB0qXdLGTV9MYwzIceWwP+qyatK3e
 Jz1AZ6nvfqEd52UAt4nEA+gl4izip+GiYVkYM0Urxv1mOKiI1T2p3mxiaeP+u2B/IWG2
 2b3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737829472; x=1738434272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3JIgbmtfxOLMYajWOv1VhSlZC2BvLUVwsARR8MibuLw=;
 b=RUXz+ODpw6A2E8TLvb+H1+4z0NzkSF3D/hK24FZHYXBB50Jh+HmAXYGG2/teDLGkNs
 zh3i8ATKMwxNuR0ZuOXJHImTnFgIlDMrQSGJ+SX3pLSMc6daWAoiNDJjfHg9x8ILF5r+
 RnKsbxYUFhm9Jgj66XMoAHzm7WyHZZTyGSu5ViQp1kaJjMYTl4+ngS4gsQisE5ZfPrMg
 QUP+tfoWCZEd7uaOLc2k9hIz180T3pvXXjlZw+/9Hhhw3ozmr/R29/SK7L+bothL3xYT
 iMG1Dc9TCMugjMUKIKusseNZOSrANJ8AiEXLplxZEQ5CnN9wnX5KqgausjfCnmLAO6Fa
 dKdw==
X-Gm-Message-State: AOJu0Yyv/Qt8AWqHUdhvRxmZLUErS1IC3GG8gdtZMMkVEDMH+n+dK50N
 Y+84ZTh1PlDDjwoxhx/dQZe5eXCKjPMmpSDM97lfYdl4QZlprqIUbnFwqg/Qic4JUW+1GFDhqxv
 mehI=
X-Gm-Gg: ASbGncv8mWiC0EBL1rSrN7lPYN8K01ceIDdd4QimV7OlAV1RyJIGNfKKJYScqLgBa/e
 DdfXJqNyg76AgOQIj1aP+DTfIPBl85et5VVnXNIT1+FtZdahKU7A5V0zw9roTtlAFrXc2dAxLeM
 eSR0qNQhuieCbAlurbUB3EC7C5NA8AxHyNHOUoR92nGVKqgNXFWKxRpzpAEfgEkPxEii1DcB5us
 y8f252LDH08KSxAos2LGkkzO7UaFHbZGWc23NYt1Ywsva/ZlgPGBK5WGKER2vWthxbt8yFimFiS
 VK5TBRHwDHQt4k/LL8WWiFP8rrX8sEXK3Wllyrre1080dtBz7eUwghC/VSQ+
X-Google-Smtp-Source: AGHT+IHLUrit+dtI5ymZoE+Qk+8OkZBPP1pEe6eccWRUdAhaVPX6uVTlOJrlPoBlu+dYRl2LtM/ftA==
X-Received: by 2002:a5d:6d06:0:b0:385:fc70:7f6 with SMTP id
 ffacd0b85a97d-38bf565557amr29528000f8f.7.1737829472465; 
 Sat, 25 Jan 2025 10:24:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1baf65sm6248831f8f.64.2025.01.25.10.24.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 10:24:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] qemu/timer: Clarify timer_new*() must be freed with
 timer_free()
Date: Sat, 25 Jan 2025 19:24:24 +0100
Message-ID: <20250125182425.59708-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125182425.59708-1-philmd@linaro.org>
References: <20250125182425.59708-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

There was not mention QEMUTimer created with timer_new*() must
be released with timer_free() instead of g_free(), because then
active timers are removed from the active list. Update the
documentation mentioning timer_free().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/timer.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index cc167bd825b..abd2204f3be 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -507,6 +507,8 @@ static inline void timer_init_ms(QEMUTimer *ts, QEMUClockType type,
  * with an AioContext---each of them runs its timer callbacks in its own
  * AioContext thread.
  *
+ * The timer returned must be freed using timer_free().
+ *
  * Returns: a pointer to the timer
  */
 static inline QEMUTimer *timer_new_full(QEMUTimerListGroup *timer_list_group,
@@ -530,6 +532,8 @@ static inline QEMUTimer *timer_new_full(QEMUTimerListGroup *timer_list_group,
  * and associate it with the default timer list for the clock type @type.
  * See timer_new_full for details.
  *
+ * The timer returned must be freed using timer_free().
+ *
  * Returns: a pointer to the timer
  */
 static inline QEMUTimer *timer_new(QEMUClockType type, int scale,
@@ -548,6 +552,8 @@ static inline QEMUTimer *timer_new(QEMUClockType type, int scale,
  * associated with the clock.
  * See timer_new_full for details.
  *
+ * The timer returned must be freed using timer_free().
+ *
  * Returns: a pointer to the newly created timer
  */
 static inline QEMUTimer *timer_new_ns(QEMUClockType type, QEMUTimerCB *cb,
@@ -566,6 +572,8 @@ static inline QEMUTimer *timer_new_ns(QEMUClockType type, QEMUTimerCB *cb,
  * associated with the clock.
  * See timer_new_full for details.
  *
+ * The timer returned must be freed using timer_free().
+ *
  * Returns: a pointer to the newly created timer
  */
 static inline QEMUTimer *timer_new_us(QEMUClockType type, QEMUTimerCB *cb,
@@ -584,6 +592,8 @@ static inline QEMUTimer *timer_new_us(QEMUClockType type, QEMUTimerCB *cb,
  * associated with the clock.
  * See timer_new_full for details.
  *
+ * The timer returned must be freed using timer_free().
+ *
  * Returns: a pointer to the newly created timer
  */
 static inline QEMUTimer *timer_new_ms(QEMUClockType type, QEMUTimerCB *cb,
-- 
2.47.1


