Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344DDCF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlEM-0005uh-Bw; Fri, 04 Oct 2024 12:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlEC-0005gG-NG
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:32:34 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swlE9-0005kj-W8
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:32:28 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fac63abf63so25047911fa.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059542; x=1728664342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QzpcifQjg9M7Tjl4Y4YKKldff3x1a+0LoVxsWg9JdC4=;
 b=R32ISY0a9VYrEpZe/73+yuht4TWKcVQ7NYJ0QKDbfHpJy/297pFRbhFfsnUiQqfSRD
 zvJSqDNyZXKBY8r3bctqFslhmxxdTl9bGT86tuxrNEQv3xLf01zrCPXiuwhuYoZcfqUi
 bTwefUDxfRFb69kEkedgLRBkQ6SD2wq38giNCNM0mxftTDKSc6GNpTvJIw7GgEWld6mZ
 oJadFK2DW10/T0UH8CAAsBFsnVWmgBKUvcVVHwyt6dDNaitvqqTISDaK3ONmbwTsb/9s
 /Ka9ns2ZL67E00Cu9WWGlPOPO7zJezWbeK48ZY8FNjipG3WKtxPoO6ZuLK+lclL8Daw0
 WdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059542; x=1728664342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QzpcifQjg9M7Tjl4Y4YKKldff3x1a+0LoVxsWg9JdC4=;
 b=v0WtcJmZTd/niV5nINO2K/IzJyzeYI2j2CpPKLwpiL3JoDNDoXaI0hNLiDqn3rZYXx
 ybZobGzrxGgMqoCPkYcIn9bWTcFYRzUhBdNy/rXrMmAlO2vO+AjVj7zEURYYTMm+Nrt4
 BNAHG7SkXpg4UE+PEqkYr+KIhV8cG4ssV1RCfT1Qfl5QasQdrdTkOHJNv+i+9YxejrzR
 iD9Ei2UdZwLKsvsZi/d4ei0eCHWayrNXar4F+6KI6Bk0esZnh0GnzA23NjNjWdVvTknu
 blluSa3XrzYkXYMFgzrsA2yWYuLqwOWuHaDFos4bPsfwio1JEHKi/2204hWvD2wDFSn7
 xL3w==
X-Gm-Message-State: AOJu0Yw9caXwOxctpnRTxCuw6x+j3tJRgZq7D+Uu/Q7qt7geu7nZsyty
 65wO350KT8bcXNAfL5DaJgDzF425XiFgPNmjZgG56bH9nAjNJJkXGJJPDC2FiWSfb71s1zfnZlk
 GtEming==
X-Google-Smtp-Source: AGHT+IGgWyImcEeFeTlRUGEKkfktsC4bhR7+Qv6CuiD2h3y4GK2dynOFsG0i2aNds4XPUlX7ZIWXMg==
X-Received: by 2002:a2e:a543:0:b0:2fa:d177:13e6 with SMTP id
 38308e7fff4ca-2faf3c416f8mr18290571fa.21.1728059542529; 
 Fri, 04 Oct 2024 09:32:22 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.150])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faf9b3374bsm195171fa.117.2024.10.04.09.32.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:32:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/25] target/alpha: Use explicit little-endian LD/ST API
Date: Fri,  4 Oct 2024 13:30:22 -0300
Message-ID: <20241004163042.85922-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004163042.85922-1-philmd@linaro.org>
References: <20241004163042.85922-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

The Alpha architecture uses little endianness. Directly use
the little-endian LD/ST API.

Mechanical change using:

  $ end=le; \
    for acc in uw w l q tul; do \
      sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
             -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
        $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/alpha/); \
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
index bf5091c2a6e..1a7e2dd9202 100644
--- a/target/alpha/gdbstub.c
+++ b/target/alpha/gdbstub.c
@@ -59,7 +59,7 @@ int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 int alpha_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUAlphaState *env = cpu_env(cs);
-    target_ulong tmp = ldq_p(mem_buf);
+    target_ulong tmp = ldq_le_p(mem_buf);
     CPU_DoubleU d;
 
     switch (n) {
-- 
2.45.2


