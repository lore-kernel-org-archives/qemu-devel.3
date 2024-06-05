Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC95C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExyu-0000co-88; Wed, 05 Jun 2024 17:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyt-0000c8-4k
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:39 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyi-0003Pq-Q0
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:36 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7026ad046a2so193465b3a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622127; x=1718226927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8p2HosDvmS098I1PRmfiW9ZIdsUwMQx7c58R0dSQai4=;
 b=R0791uS8OGP1PWYcA/klgSCD4zbtg8gWGfQsLXvZ+bQM4a1V1RYx8MjtYilRy2UkzW
 cJ3f99PtFZViwUmKXLpnxabMHuddx4QZbzrARxdY80QlnM6xV6IiwIS0eCalluu00UJk
 akDpPrzNwtXmyidXdAItXV/xRanMPmFoxzYDVS3JHrjvlVGZoCKfNT7SWzvasAU86MyJ
 Oxz12KtvsMzPV55rXLlomUQEgbpRPJX+MZqGkwLRkEHnQ0rIyWkxI1LyutcB0WkdiWLb
 bFfYrn1O0zaAsGd0qu72Z+x6haQq6gQwDIZGBc5+DXMyzBGbotjIfXpzZxq6Hlr/BRYK
 EUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622127; x=1718226927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8p2HosDvmS098I1PRmfiW9ZIdsUwMQx7c58R0dSQai4=;
 b=PNTZPvjwpUk2AllTnpv2g/HS1rf1ZpZ2C+RhSLXpvFjmrKO6F/PtKzTsWMluElTP60
 4Vr0zTpjyLANhQQmoRBnHkRH3vqlXbvRJqDkW3z/KJYTKQgdpI/FNBXc/n4oSmcePu18
 PXd7tmWMeHdifc9J+MsnURfHfUZKhW4PPGpaZWB3DSNDs4uEVkyEuRQs6OcXmZMCnh1A
 dzb+fftNH2wyats7OD2NISSQyWXzTRw55evEDQYV4WewA5eZ1FrjpSmqpat5BLadYYdy
 PtXI0AfLMr4BXaIcmYPy3pG6PeDlVKjS0xw7NdzmwS23Tgzk5aVUCHoJLTiEdcwJ2++R
 HnJw==
X-Gm-Message-State: AOJu0YycHwauV5dcXGkJ2P8vuS0ve419Ht7xPnUUW4fap0cGLVQq7zWq
 TGm67lvOe4euRDMiFvXQr3ORUbhR+jbXVZQEDokKEWttk6qQxHNQXwbjuBLIr1l/Q+YBlwZAFmW
 l
X-Google-Smtp-Source: AGHT+IHGBYDVAIQ7dD/AKLK7uk8IbGm1F14FneNA7R50j4r0jsnaGltUmJv/TT3/3qXcjclmh+TURg==
X-Received: by 2002:a05:6a20:a122:b0:1af:d19b:a76 with SMTP id
 adf61e73a8af0-1b2b6e2a28fmr4536166637.12.1717622127326; 
 Wed, 05 Jun 2024 14:15:27 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/16] system/qtest: Replace sprintf by qemu_hexdump_line
Date: Wed,  5 Jun 2024 14:15:10 -0700
Message-Id: <20240605211521.577094-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
References: <20240605211521.577094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
Using qemu_hexdump_line both fixes the deprecation warning and
simplifies the code base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>`
[rth: Use qemu_hexdump_line]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240412073346.458116-8-richard.henderson@linaro.org>
---
 system/qtest.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index 6da58b3874..507a358f3b 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -601,9 +601,9 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
     } else if (strcmp(words[0], "read") == 0) {
-        uint64_t addr, len, i;
+        g_autoptr(GString) enc = NULL;
+        uint64_t addr, len;
         uint8_t *data;
-        char *enc;
         int ret;
 
         g_assert(words[1] && words[2]);
@@ -618,16 +618,12 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
                            len);
 
-        enc = g_malloc(2 * len + 1);
-        for (i = 0; i < len; i++) {
-            sprintf(&enc[i * 2], "%02x", data[i]);
-        }
+        enc = qemu_hexdump_line(NULL, data, len, 0, 0);
 
         qtest_send_prefix(chr);
-        qtest_sendf(chr, "OK 0x%s\n", enc);
+        qtest_sendf(chr, "OK 0x%s\n", enc->str);
 
         g_free(data);
-        g_free(enc);
     } else if (strcmp(words[0], "b64read") == 0) {
         uint64_t addr, len;
         uint8_t *data;
-- 
2.34.1


