Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DB5E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 15:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSHeL-0002fM-0j; Mon, 30 Dec 2024 10:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHeH-0002en-Fg
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:25:41 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHeE-0001lm-UH
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:25:40 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so4490673f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 07:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735572337; x=1736177137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAHxB+c8xZt/u0R303DHDB7l0FIhppIYTKedrojbFg8=;
 b=Hn24EyGoVCSmBoYGk2S4QC+7zg/xRe6MogW2eYTIrKKF4uK0LsZwWvWDpbHAQYTKfT
 eigF3i9imNtlPSqrIgSrEPWlHhbLj/Zb16s9rhFkcgPIqCf6Naxj+qfSP/2uVPj/qUQU
 JVa7v1mL9OU5xvJBB0PIJMi10nWtFmbf+O6Q7l+KZCLXfFtP2f2ld1n5bMzQd5cEXjYW
 D3Y1MVuQTJE7OpQPpSRMKPQmH1oofwNXpghKejGRiYkJsOBCCrERKKmlvU6JxAo7vamR
 mw/C/Mqxymr/4O5b2Awt5ajiIrVT8umxejoCJk4XwlR3cNGwXEI3KyrOUgrov4dEfXl4
 uuqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735572337; x=1736177137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oAHxB+c8xZt/u0R303DHDB7l0FIhppIYTKedrojbFg8=;
 b=auTsln8trpDCLWVFdK2VuSjlJzLyFrayuJkg1vrYFV8ZfBjTThp34URTvJlYN1CuF6
 D1movhvfA0T5qjYN6Z0NgP6YVXsTNRlqInRK1FYSkLZfe/4cjCS07QBPqifkzfABXjtk
 MV8oiJplQXEV1oE5mFVe96tnRjDbbnzscklzu/rMMlnWWY7YzUHZZpkfoDzyZBtbDSAy
 rvQ6LvNxdqLu8/QKv6pyWxv/8OehmO9byJOjHCc9bw9XUdZaOrl40y3RBrzHvIch3/u8
 Lpn86uY4+tZ6rLPrCrGxXrQCx+GQjGsfDjZA9ZmQ6SLm30dEusDhafLQbTQZEp6JLoWv
 Zy2A==
X-Gm-Message-State: AOJu0YwJNvUMMictyRfeCuAPj5QghwiOYEYDNW5qXnWCDFz/sMGADlQQ
 k9LT23gP4UNQE/DRrbSMv+zpeXhBmOKdC+rWB/TgdIuvs6P6Qv70qdsVe4wCYV14nzwtwjmhgRO
 y
X-Gm-Gg: ASbGncsjqNrZQJlhcw5ECxoc2+W9HoFQUOlu5E9iT9n/SOWKUfz4b8wb0MAKKBx+8xj
 uQMHGOGoOix3IAjT4VLH4mPrI/92954PQZymUxBftAbzxGeko4teUwhg/d88f6ShY4AubffKUKL
 F6gNyQia+TzN/jkKo0BnyxQmv6BxYe0r51xmJhuDRMNmSTBAKrIm+d02nWSnajZMPx67u90C4ji
 VHXxHxYWkaIhDJ2RLMhNSU+hX/tElOQ6+AjcqRTbFXIbH2XKJwoEgJzoWybob5q7jIsG5noeFyV
 k5HIlcVGWf1z/FPgLBbTRSB/fsi2j0I=
X-Google-Smtp-Source: AGHT+IFyVOPQuzvesGaSgepM8ATCxdSI/4AjAf36iwpayHRhTusBblFaMWAOGm674t2nnkQV/xTApw==
X-Received: by 2002:a5d:47c8:0:b0:385:f677:859b with SMTP id
 ffacd0b85a97d-38a221e2fb4mr33139769f8f.10.1735572335645; 
 Mon, 30 Dec 2024 07:25:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c833149sm30022287f8f.39.2024.12.30.07.25.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Dec 2024 07:25:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/5] target/hppa: Only set PSW 'M' bit on reset
Date: Mon, 30 Dec 2024 16:25:17 +0100
Message-ID: <20241230152519.86291-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230152519.86291-1-philmd@linaro.org>
References: <20241230152519.86291-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On reset:

  "All PSW bits except the M bit is reset. The M bit is set."

Commit 1a19da0da44 ("target/hppa: Fill in hppa_cpu_do_interrupt /
hppa_cpu_exec_interrupt") inadvertently set the W bit at RESET,
remove it and set the M bit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Only tested using QEMU mainstream test suite, IOW not much.
---
 target/hppa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 41538d39d62..dbd46842841 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -209,7 +209,7 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
     memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
 
     cpu_hppa_loaded_fr0(env);
-    cpu_hppa_put_psw(env, PSW_W);
+    cpu_hppa_put_psw(env, PSW_M);
 }
 
 static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
-- 
2.47.1


