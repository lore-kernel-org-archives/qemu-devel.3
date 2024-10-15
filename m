Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077B6D1D879
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jl9-0002EP-08; Tue, 15 Oct 2024 11:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jkO-0000tu-LP
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:13 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jkM-0000oH-9b
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:08 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7ea80863f12so1040569a12.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007164; x=1729611964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wE+j6sYSDQnj04FOXSrYmsK1n/6FhkfUBDKG2lPE568=;
 b=CzqHmWxM8wAqvx+avqXhpJQxTYV8lPbZNWc6+YLlYu4giE0JWOdfh+qyceECVFBYlr
 1HGIGbDVbtY8KjS8jRsXpRjW9B8jEO3xNaRFvzWYLX2Nb/LM1HjuorXysHIFhd1CkZBJ
 11STLNr5OSpjgF8S8mnvYDXuRZDO6QxQ5ZnaC6pomeZ/aXooAQ10EPTpwBEg0xG+3EIH
 53JrbF0D2bL1r7mGfFDGi/KXgTVUaOraNnflcnyOpU0o5OqMjiENc30Pf7mU0o16aMVi
 KmbhyFiLwJ8fllQxXeijNzpzHC2FGgWYiF1Xl6/h8uWh3wX3wIYUO5Osd19/oiUvtZcX
 05AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007164; x=1729611964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wE+j6sYSDQnj04FOXSrYmsK1n/6FhkfUBDKG2lPE568=;
 b=kHOtZhug5xCSBf42TUU5B/Phtw01HFLsSYhayWXSJurCv3GryH8bk4NrtJJzvSClEg
 ILauftPj7tisCOefDoaUZklbN7zNYyFo0TP36S64KsgDCthHCpIb5prZevokL2l542EE
 n9R3K7/82OuLtMTQnpU/wACWvVKHcBgqF19HK/OYylr5uchUHPYgq53GIHzhXt96N+eY
 K3MvK9d4PCx/amUL/KXce0uVDhXojASZPbQ7soHCi+EWtXdp4UJtY68NvuGD7jdhHJhi
 41MDO22FwpkNVRB9jMspr2RPu8BhIZLf5cc+5lWl8qjjj9eQ4RU3SkUhudSrrq50u2To
 XrQg==
X-Gm-Message-State: AOJu0YyFqYKm+alMB1GhRB5k8uJT44d8qOecf+AAjTvBhI5taseKbkD9
 QWZNRmAuXwMiV6BfRyWXAb5HovWrukuHT6FkC1Oop4JoRf4brGzoTiFcX62litBZfQ71f4alimK
 s
X-Google-Smtp-Source: AGHT+IG1yj44MqeuJgA21QW4HzJTiL7IB/LAz5feLWuAOXG9Jr+e4Nntj4InOfBlfAJ67X75y2S86Q==
X-Received: by 2002:a05:6a21:3943:b0:1d8:af46:2152 with SMTP id
 adf61e73a8af0-1d905ec45c0mr886004637.11.1729007164507; 
 Tue, 15 Oct 2024 08:46:04 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77518a5fsm1398077b3a.214.2024.10.15.08.46.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:46:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/33] linux-user/i386: Use explicit little-endian LD/ST API
Date: Tue, 15 Oct 2024 12:44:20 -0300
Message-ID: <20241015154443.71763-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x533.google.com
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

The x86 architecture uses little endianness. Directly use
the little-endian LD/ST API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20241003234211.53644-4-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index cb90711834f..0f11dba831f 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -754,8 +754,8 @@ static bool restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
     env->eip = tswapl(sc->rip);
 #endif
 
-    cpu_x86_load_seg(env, R_CS, lduw_p(&sc->cs) | 3);
-    cpu_x86_load_seg(env, R_SS, lduw_p(&sc->ss) | 3);
+    cpu_x86_load_seg(env, R_CS, lduw_le_p(&sc->cs) | 3);
+    cpu_x86_load_seg(env, R_SS, lduw_le_p(&sc->ss) | 3);
 
     tmpflags = tswapl(sc->eflags);
     env->eflags = (env->eflags & ~0x40DD5) | (tmpflags & 0x40DD5);
-- 
2.45.2


