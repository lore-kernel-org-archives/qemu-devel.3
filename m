Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40438C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbN0-0004Gu-VG; Tue, 18 Jun 2024 12:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMl-0003kl-Sm
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:31 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMk-0007x9-0z
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:27 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35f27eed98aso4572035f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726844; x=1719331644; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PS+Ds4Sxagrc7IIxNg9ZZud7Od1JFilSTGGm4uz6pIM=;
 b=VFY+lOI7zzf0/XZQybqtM3JpQ6DtCRlgf2AOnKK+kfgWfajTzrVDA/joRvWpOYpknX
 1/w65l8As+IbXLEqrsvUQh99BEvNT4MblfyxXTDgYt8goYR1oslGMxNrPd1oG/m+ePkZ
 JzhKM11nJK+X0ecSI4rP37RZ4wY1EAlAsjGrwVIlMAutWwjC+EKixlBzz8ZVZduOKYRJ
 9UDHladWGcPYO6EbNToEAYGVWRKRupEF0zYj9VtFdGR1CcPFqYWTUeFwIeaAqqNKYZBC
 tEZICAlwazTidHgeMipXD1r7YoffjT9xz5cLUGq9TmtFXGNVqp5lPAPyNgb+/jOMDkwW
 +DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726844; x=1719331644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PS+Ds4Sxagrc7IIxNg9ZZud7Od1JFilSTGGm4uz6pIM=;
 b=XSQKh5KeXCXsEw+DA2UehkpuYM2LrOkn1p+73rjD+ZN2vyvOispT5o18SACp7OSWrM
 MwOCZjbG4x/QgP+yMMtVsJT63UbvgMrLx4BB1duiesBDzIN/K1zIF9HfXyREyh3bu06M
 zxqpSD+zQ2bXPE28piyIpbyfITbVkK3JUBXQdruUMkSEyxOUJJTUySggzrG840bvQ+ix
 4c0h3gq6WNYmlLLgKeFhguwifclXfmY6jxLkSEjPblC8kHqrIVqlXOyZfRhjwrQ1ETb9
 qaLNqCDW471LqnwSmPfA6Rv/R3LdN97xuJsEu0k5fJW7yiDd1dlDGf4Ngmat+oshQgeo
 xURw==
X-Gm-Message-State: AOJu0YwPMsd2BDLfSTm6I7quVJCaHUVUu9vVQYuTh46g4KtEAeBZeaCx
 aTf4z3fYKwzg//UiKt6DB1UYxDiy3WqgUwr0e1mTDgUS6zp5RdeB5odtS+Vdc3fGuWzEYOOgcvd
 7
X-Google-Smtp-Source: AGHT+IGi3VzVcvL6ex49fTwXCvHpveX6tnI8uRX6liAzQLeRBpi/A70gdNZ6IQReoMYj3ER30bCMzw==
X-Received: by 2002:adf:9789:0:b0:361:d3ec:1031 with SMTP id
 ffacd0b85a97d-36317b7d4e1mr28270f8f.31.1718726844276; 
 Tue, 18 Jun 2024 09:07:24 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607509c9a0sm14398446f8f.27.2024.06.18.09.07.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:07:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 70/76] util/readline: Add C-u shortcut
Date: Tue, 18 Jun 2024 18:00:32 +0200
Message-ID: <20240618160039.36108-71-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Add support for the unix-line-discard readline action, which erases from
the cursor position up to the beginning of the line. The default
binding, C-u, was chosen.

This is useful to quickly erase command input while working on the
monitor interface.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <6772067e1c0d4b1c5310e5446e9e3e1c6b3b5bc0.1718265822.git.manos.pitsidianakis@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/readline.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/util/readline.c b/util/readline.c
index 0b627d62ad..0f19674f52 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -271,6 +271,14 @@ static void readline_hist_add(ReadLineState *rs, const char *cmdline)
     rs->hist_entry = -1;
 }
 
+static void readline_kill_line(ReadLineState *rs)
+{
+    while (rs->cmd_buf_index > 0) {
+        readline_backward_char(rs);
+        readline_delete_char(rs);
+    }
+}
+
 /* completion support */
 
 void readline_add_completion(ReadLineState *rs, const char *str)
@@ -426,6 +434,10 @@ void readline_handle_byte(ReadLineState *rs, int ch)
             /* ^P Prev line in history */
             readline_up_char(rs);
             break;
+        case 21:
+            /* ^U Kill backward from point to the beginning of the line. */
+            readline_kill_line(rs);
+            break;
         case 23:
             /* ^W */
             readline_backword(rs);
-- 
2.41.0


