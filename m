Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D09CC36005
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 16:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tven0-0000jO-Ko; Fri, 21 Mar 2025 12:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvemV-0000Wp-SK
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:59:35 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvemU-0004Pu-4n
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:59:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso22769455e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742572771; x=1743177571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IdWQEAlJXYaP7bzkMuhk/Z+35KZ7bM/L7F5PZbStOT4=;
 b=EaSwZNTmrNYa++qXNIpnxLlckykNmJPdUImERYkARU/2QkNSZJ6nfVrSUIPwOMA0kC
 b6ZzEuUKUX55BHzjGCQkLuthXyn7jJkdQ0fcNGgfbcEQiBFWFlU4sHJrLE4RmMWX6iLv
 WsdQewz6YLXxM4G5c/L89FgjqeOWeD8SFMuAVPGOxUXgcYuCqfFSxmGUB+BQ4jQdSZa/
 35ZkhSqh0Zpqk6nyj2zDmqd9JPQhuPycyF+Xe64WlVec56ZpGnmFutvdUsm0QZcXZ4ge
 mEIfTQb0haJQEESl9NKlqsdjiIjyvlI2qiLtuwJoSVxyFr1IhAoWH/jpADqBFWB6GPuI
 /dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742572771; x=1743177571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IdWQEAlJXYaP7bzkMuhk/Z+35KZ7bM/L7F5PZbStOT4=;
 b=QABl0WYDQft6M+RujKUX6uqtrfBf+bcCWxJfqx3fMUts8EBybh8wxig0/5aTsuI4YP
 A+mBIwupgw/8aZuOGaMHjNqI5LSG2E0u4jvS0WazcZZ6QSgJ8MC8o6JJx5p101UzVsjm
 wOiMlAVDvIrBqLmHT84zWP15YX5u6CDjX/TXGZIDd/+KMFBD4XSicinvqmyGbHCP0ZsG
 sQW7KEhjvgtTEzDTvpfuP+KSKLLL2rmXUlSxpFmlChK6+wHypWtlZ3zaHnKvauHu5ULC
 QMjTKEOGTIqszxp1VAOdxZfLvinBI2sjt6aP+AMIBgUusrw48kQdBHwFNMHbkgD5odLX
 R6GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKPwj8e535okBukp+i4Wnj30SSetFwRqEXno4PtS4MFlG+i7E3I6/sJXIZDz9n3RtVzwvODRqwJywk@nongnu.org
X-Gm-Message-State: AOJu0Yx/8H1GqQGaH0eXlVYymy5qEa8tLmkVGMnPEYb+NrCA27IZkZNH
 fe1GQoL3o//CdLrwEzc1IQYyyNcsmJ5/RGEVWIEydmW1LnyaHLnwySp97ozpJUk=
X-Gm-Gg: ASbGncsfGp1X/iqBx7KAlwihFS2oMEHbSUnVJYyouz8HsMLcSIguiWk7tuy4JfZ2Ttp
 d4vmtahlaRlkz3YMbPrCwA2dqQ69jUYCA+4fvAJQGhacjZrCsi3iOXWqz7uPJ09gzAeo7zUlQJg
 Tz+5rhp9nLQ+eu4Q8MWAr3nYspO++Jg0fJ51xca/tptdFIji4eUmFxPW9WhCgFZdxSojRs/UQ4x
 TEKhrD4OyHildhovjOk9gtYdwd6QpgrxN/T06jJgVUhNWYd8sTyBZ8bWh5om1446yCn9te9ULKH
 8m+7nKY9oao+hh+Ks+TufqoAxpQoJqm5vCxHuBtcHCIYJiljTshQh3gGvKANAWl0kLue7P+Lwus
 msnfxGvD/KBKqkg00GHg=
X-Google-Smtp-Source: AGHT+IG4wAU+ijp7t02UClIF3uyB5VinEn1gtPj4JP6E8Uim8XrsY8U2yp96DIxDnI2fDebBAlTO1g==
X-Received: by 2002:a05:600c:331c:b0:43c:f332:7038 with SMTP id
 5b1f17b1804b1-43d52a8ff41mr13730375e9.21.1742572771420; 
 Fri, 21 Mar 2025 08:59:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9efe61sm2747267f8f.97.2025.03.21.08.59.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 08:59:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 1/4] target/riscv: Restrict RV128 MTTCG check on
 system emulation
Date: Fri, 21 Mar 2025 16:59:21 +0100
Message-ID: <20250321155925.96626-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321155925.96626-1-philmd@linaro.org>
References: <20250321155925.96626-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Multi-threaded TCG only concerns system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/tcg/tcg-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index fb903992faa..60a26acc503 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1050,6 +1050,7 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
+#ifndef CONFIG_USER_ONLY
     if (mcc->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
         /* Missing 128-bit aligned atomics */
         error_setg(errp,
@@ -1058,7 +1059,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
         return false;
     }
 
-#ifndef CONFIG_USER_ONLY
     CPURISCVState *env = &cpu->env;
 
     tcg_cflags_set(CPU(cs), CF_PCREL);
-- 
2.47.1


