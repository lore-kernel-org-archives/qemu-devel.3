Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A25C02192
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMKi-0001ok-7Y; Mon, 27 Jan 2025 05:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKg-0001nS-74
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:27:06 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMKb-0001zk-6A
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:27:05 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3863703258fso3281569f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 02:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737973619; x=1738578419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXRYcwTEjcVPemISiJ0oN9v7hHJA///00CaMfmTQwfo=;
 b=JmL7tgaxVDHnrm3W+gN4SPWIkrTKN9Qla6jGM7e3KlEx1oQ1rud0CAAXlWj2lsDWig
 T4Z8mQOwFVHhe2KZZlJX/8mFp0pIN9I7qi2f1n6wHNOSzkHrK2INLwsdJHkdXcwOy0U6
 A1Hhbie4kV0EYTJjmgmr4jBQ1iq9s99b+BXa08M4GlG8hZJXBh+o/qJAW7Z1PT2Kjy2n
 K4F7RLfBcApp4s79qwPzeG7SfryHiVO8mhsNTfDVHFjAtVUvrS0kodDk9YBVBw94yiQ/
 OAzcJvMs7eIighd6EEtM/sjHdHp4hEBAB2rY9mob14VDrsTB9wlpbMgy4qbVqBX1hcFc
 GyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973619; x=1738578419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXRYcwTEjcVPemISiJ0oN9v7hHJA///00CaMfmTQwfo=;
 b=LgCxkFHbuM6z8mF4ob4zQWNSs8yCx6DLzu8OyHbECmbUA/h+EPnD1cDab9Eu24jurU
 h/trERJf9frilN517FOr/EOUQhE4elPpRmjapDFRQmZjqdD5PZa1VKnVpsKhvVK2/3iY
 suG4Qk7bdqIGn93D8PUa8QZUoWzQ0LBxKjs7FmNyFoYOewD6b/i+clMamnay/kHXbS4z
 X61sInTfcgbA5ejTHGTomns+qZwMnyEsoqZn1dIEihWoBDl245cpuSTGLpgIU/XG1+iq
 cA9KueECJK3TBC5TW/svkoCKR9UVtyxCnjVwQ0mW88AtEd9spDeVqFTfv74xP2rRuSLL
 lkjQ==
X-Gm-Message-State: AOJu0YyAiybd6atFSJMfyBv7lUPiZkl+q6/o/DzsQ+FqFJVKchemZbQ9
 9p3Rv1XoQUo+jLM3kh3oTLmmwxsi6bpWyjGmGFmw8lsQqWLtsF/WrJlESol6pb5J5EEtC75epYb
 Bk+g=
X-Gm-Gg: ASbGncsQ/Qjx2IFCWOFTF2Ub9XA00Dr6oG0VeP3vIWugAQKLZGp3uncRJ4FgLypwJab
 L9nCXOSv4PaHuFGggYFIuPaexzZV8kKlWQsaINioKgSJqCh7eZ7zBNJmG/3Rik3NcF35Jq+PFgv
 CGsrusCByN3S8rAwgvIwvq2iU7CPBG0yHOp1zarBNRpiFz4rSOGINvHWODwu6rTQQvDD6sur8oy
 xmTXUKFE9fYOXG+wwxY9uHuG4o8MwwHMOWFu/EpH7H0uS8q6VtAbR4mU+LB4AAuFHu3UFDItoeC
 oXKRFEzwuzT9owgFwR5cF+xSSSLvPi5uP56kQQybTNdFhXwkvl5+thI=
X-Google-Smtp-Source: AGHT+IEj+dsWKGUowODS1HjmRuiJU7nLV2DBokWMTj+WGXp9BLCjTH5ZP5hmta9K4+xVoX4FK99fWw==
X-Received: by 2002:a5d:6d0b:0:b0:386:3d27:b4f0 with SMTP id
 ffacd0b85a97d-38c2b783f66mr11182677f8f.14.1737973619515; 
 Mon, 27 Jan 2025 02:26:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188c28sm10892167f8f.54.2025.01.27.02.26.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 02:26:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/15] target/ppc: Remove raise_exception_ra()
Date: Mon, 27 Jan 2025 11:26:12 +0100
Message-ID: <20250127102620.39159-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127102620.39159-1-philmd@linaro.org>
References: <20250127102620.39159-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Introduced in commit db789c6cd33 ("ppc: Provide basic
raise_exception_* functions"), raise_exception_ra() has
never been used. Remove as dead code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu.h         | 2 --
 target/ppc/excp_helper.c | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0b8b4c05172..4ca27d6b389 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2753,8 +2753,6 @@ static inline void cpu_get_tb_cpu_state(CPUPPCState *env, vaddr *pc,
 #endif
 
 G_NORETURN void raise_exception(CPUPPCState *env, uint32_t exception);
-G_NORETURN void raise_exception_ra(CPUPPCState *env, uint32_t exception,
-                                   uintptr_t raddr);
 G_NORETURN void raise_exception_err(CPUPPCState *env, uint32_t exception,
                                     uint32_t error_code);
 G_NORETURN void raise_exception_err_ra(CPUPPCState *env, uint32_t exception,
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 236e5078f56..9e1a2ecc36f 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2528,12 +2528,6 @@ void raise_exception(CPUPPCState *env, uint32_t exception)
     raise_exception_err_ra(env, exception, 0, 0);
 }
 
-void raise_exception_ra(CPUPPCState *env, uint32_t exception,
-                        uintptr_t raddr)
-{
-    raise_exception_err_ra(env, exception, 0, raddr);
-}
-
 #ifdef CONFIG_TCG
 void helper_raise_exception_err(CPUPPCState *env, uint32_t exception,
                                 uint32_t error_code)
-- 
2.47.1


