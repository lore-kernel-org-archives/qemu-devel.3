Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED5DC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JJ1-0002u2-55; Tue, 22 Apr 2025 15:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIV-0002W5-Ae
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:48 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIR-0006E4-2a
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:46 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-af523f4511fso4745201a12.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350121; x=1745954921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXxySmM5H2uZxfcMpHXVVabc3DpRRBx3hmcc7DOhhC4=;
 b=IYM484aP3CZY4OOhegmYBKTLIPdHTw3PNnhBnGg0k7NrdYaWuxP677JOCJ0PFdr6ZI
 c1WBWFZZoX27TwXyCV50+26fIWUu6kRPIkeMYybYqhs7lIlSzeA+i+XjETLmi9b3APno
 0ZHJmSiokYUhNA2ls5sh/YCyCwlCUHW7HGlMVZKJDGeLCo4OIbApaHmwKxyHQXSTQySX
 Y6kK01q1ZLloGZ0k/RKrMI6i3urJqrjcVTayog2fSWDUs2hs/7GDEOdrex0EnPHtF/j3
 xg9/tpSr6LycPSANtC+MJuKTha4AOb7uWraxYfjpFxNI5DHGRYJhF89KADMxP5jOXXIJ
 Ec/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350121; x=1745954921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EXxySmM5H2uZxfcMpHXVVabc3DpRRBx3hmcc7DOhhC4=;
 b=PMZQXDTd9Yl8ZvmAHvdiZuvt3yokYeMu9RQw6JKAvSrOYGtinw1o2xcocR+KqSo9dn
 nS87GbySA6w7GRN+aaQ6vRUU0GFWH5rehIxqkNeuuc85iK+AzxJm8F/u1xsxJttANQQc
 xkBzNfSpcev94TcwmHbq49TcBmWqtdbYsbnfuM5TT/4J9FVoSNq//5NPdfckCskMRaOX
 I4qpB4J5q/sFFcDGSVyS+0hJ7xNqyrmD54L1M886kI2Qd3abQPUYFNTD+t3HNCjy/Y12
 MlC5L9uPcKTi1gfGvAduKcqfoVgdDESb1zDSUay4ZWV7BElqumkSyqteJrkHHkuKIQj9
 8mDg==
X-Gm-Message-State: AOJu0YwSJJhsYz/cs8Cb2NMqB9jNSjaWDYXcO8g7w0nzvajKmJ+oOXZF
 fw/n7s6MKGy1uiURG8G/D+HzOtBzo1DtpXS3jUFd1PEEVQ8Z4ab0LrzwaV3WQNRnNI6IjliBove
 N
X-Gm-Gg: ASbGncvNnRoGuFeoerElxh/fQSh7CJUMa6IW5XVLAQTEuxNoraWB8j+x8JzD1YNx+fF
 gJglwy8c53JFlnF15tr2uYf6IcWKTQwS3lSiEGQW3bKZQlGXySNNq5KvvUla4MB0Vx/k3wSduph
 5KW5fh5/qaJZflkwJ9xeTn4+urL0vjaUCRsgQgYI0kxdBEZ/hHSyj2BfpiDOLQ+bv1J20TpUHr2
 G71Va/hK49UlBdZADJULp9Y4eXXAQNDaP8k1+DqHnMKC31cnY8NzqAM8eWDuEwKZPu5AzsIaXGF
 7iHLSXlCfkzLxma/CchSXhvjhxmYS9jnVrIQWeGgfpA2K2AmB0aHFEyENA1oLVbPv0l/YtJhdlt
 KD2uHpygy7A==
X-Google-Smtp-Source: AGHT+IFYJTdTUxGCbycuUuE2IW9ONJSEuAHMG7ztwLNGsjBWkU3mdiQUOMIEIqu/Tirzak6pW1CUJA==
X-Received: by 2002:a17:90b:2d0d:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-3087bbbddc7mr23918181a91.28.1745350121583; 
 Tue, 22 Apr 2025 12:28:41 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 032/147] accel/tcg: Remove mmap_lock/unlock from watchpoint.c
Date: Tue, 22 Apr 2025 12:26:21 -0700
Message-ID: <20250422192819.302784-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

The mmap_lock is user-only, whereas watchpoint.c
is only compiled for system mode.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/watchpoint.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/accel/tcg/watchpoint.c b/accel/tcg/watchpoint.c
index 65b21884ce..cfb37a49e7 100644
--- a/accel/tcg/watchpoint.c
+++ b/accel/tcg/watchpoint.c
@@ -124,17 +124,14 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
             }
             cpu->watchpoint_hit = wp;
 
-            mmap_lock();
             /* This call also restores vCPU state */
             tb_check_watchpoint(cpu, ra);
             if (wp->flags & BP_STOP_BEFORE_ACCESS) {
                 cpu->exception_index = EXCP_DEBUG;
-                mmap_unlock();
                 cpu_loop_exit(cpu);
             } else {
                 /* Force execution of one insn next time.  */
                 cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(cpu);
-                mmap_unlock();
                 cpu_loop_exit_noexc(cpu);
             }
         } else {
-- 
2.43.0


