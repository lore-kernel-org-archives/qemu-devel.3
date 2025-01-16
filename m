Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9DCC02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSTh-0003PL-UP; Thu, 16 Jan 2025 11:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTd-00039R-PV
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:14 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSTb-0004RC-OV
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:12:13 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so7429425e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043929; x=1737648729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/xR1sdOln5uQTQB+HehunftAymFm05ADSFOJij2asec=;
 b=iiuoRKLjGRlVmkwluMh+Asqh6FoeT+QL4DXxM+4o1etriMpjfzBECAMoj6EDQIrc5N
 W8viv+cJNTDsi1p5uvGHAg0ityNpCPCW9ZTbhZeFbfKsM06kefgb3gTmnQ60zlbNi6te
 /sWa1m8+wehnX3X4zJuwRT9MMBZbYzEwqiPxIKiEvaY6AKpGM0z2F63UnqIYJW41y2It
 ZZyRhW8hcuKzaO57wMs9coMyLwCDur4QrAiX1AcgeAkacNvywNZUl+aAmGhXNMCq9R5R
 rOHCsKnoWik+ffveQR/LpJ9E4whSaBy6QyfJDtpZhJKz8sxuPBNy4cuRFo3Ed88gylpm
 utKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043929; x=1737648729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xR1sdOln5uQTQB+HehunftAymFm05ADSFOJij2asec=;
 b=Vf5NloSW5QaTO/PDH3wa0ATxXspXnddSXo3ZMVvAl87G58AOgwu5ieuIZhBqD9qzQ5
 RaLGdOJ6K6KqYAfyIJ3Vd0CK0bdcc0j8uEgJF7JRYVAMCI3g3bfnZUitrAE1SF9dKcIw
 EdvmHaFoZmzSEU3VGT8soGWqLdDpSKqKHTL36tNpwddmTEz+XeBtnfe64iLrJ8HYxVnp
 MYj3GPcAooDz6k9flAb6othKgoCIv+ReYGIrAkLir8T83OlRStlSIBMAwXG/tpN850Jz
 ARe8lIWWdkm7nrPWofM+81ECnL6E+SQgm3j/tOP0mKzZM39I8EPcjPysH+39PMnylkUH
 ntjg==
X-Gm-Message-State: AOJu0YzcOyExrxfd2h+NiMcgo+QLPIlyw9Dcde3xX1/WrD5E2YJ9HwDA
 XlmrR9xCqDzRvyUbCHnXUg/nVTvlndLuud3BC26RWPMTMVQ+F3pX4zg0MDo35oE=
X-Gm-Gg: ASbGnctNS71yAiYHypdFD92iUZtK/wC+CxGa50OmIiiYsTMmYDs4+LL0PyugvRiEHJ8
 3XBvaOW8KWGjeswaL5gEmFYAHQ4VwU76WshHKywAuSmH5Kkqt2cLRqXpwKRAoLLCTKOhgp+KDCA
 lNQv1kIhh1LUPJ2WQ4pZ2eJJwKdqIQjlPOG2kFkfYhN/RyNMP1nkKoXneELnE6SsnNtDaNV0+yv
 vCzBHBudZfa+tiwv/21GQJaABSqI+JcALx4nmPj75OHpLNGI6PO4qs=
X-Google-Smtp-Source: AGHT+IHdWFTZASu7Hc8sMZxPrXtsbEADpl6QGERQc2vb+b7U3ExpmtwhGcHbtIIQPwtCJyi+DyUFyg==
X-Received: by 2002:a5d:59af:0:b0:385:f677:859b with SMTP id
 ffacd0b85a97d-38a872f7fbdmr34031511f8f.10.1737043929538; 
 Thu, 16 Jan 2025 08:12:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322ad74sm242024f8f.56.2025.01.16.08.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:12:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 99552608C3;
 Thu, 16 Jan 2025 16:03:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Julian Ganz <neither@nut.email>
Subject: [PATCH v3 22/37] accel/tcg: also suppress asynchronous IRQs for
 cpu_io_recompile
Date: Thu, 16 Jan 2025 16:02:51 +0000
Message-Id: <20250116160306.1709518-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

While it would be technically correct to allow an IRQ to happen (as
the offending instruction never really completed) it messes up
instrumentation. We already take care to only use memory
instrumentation on the block, we should also suppress IRQs.

Message-Id: <20250109170619.2271193-23-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Julian Ganz <neither@nut.email>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Julian Ganz <neither@nut.email>
---
 accel/tcg/translate-all.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 453eb20ec9..d56ca13cdd 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -633,9 +633,10 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
      * Exit the loop and potentially generate a new TB executing the
      * just the I/O insns. We also limit instrumentation to memory
      * operations only (which execute after completion) so we don't
-     * double instrument the instruction.
+     * double instrument the instruction. Also don't let an IRQ sneak
+     * in before we execute it.
      */
-    cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | n;
+    cpu->cflags_next_tb = curr_cflags(cpu) | CF_MEMI_ONLY | CF_NOIRQ | n;
 
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
         vaddr pc = cpu->cc->get_pc(cpu);
-- 
2.39.5


