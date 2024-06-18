Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F721C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbMl-0003ez-RT; Tue, 18 Jun 2024 12:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMg-0003Wb-Q4
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:22 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMf-0007w1-1V
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:22 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-52cc9b887f1so265302e87.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726839; x=1719331639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EZXir4tyTbilkK4IBj2or6kvXipnQF2t170oQXRmlK8=;
 b=veCTUDeUOqojRNpix/sHUi60FGTI7ra2NE/S5TFVOh6km5bPIIYWLSAX8r95Z8qDTv
 3X4dccb2JX4M6fEYOsASDcq+UoIWKLMe3FIrdTSrFSw4UDy4NnPikR/Y5LeK0AqPYGwN
 jcbUcILqGTGi6hsVhPqcIeePjKfBC1a1Vgyroa3TO+tmNyxw3vsFzE26Qf2STHrlPvzN
 lfUy75wnbjpfptKDspajF/JNwbqNAuJvX113/QuYYry1uh6rWyxRCsMLCduO0Mz7w+Sg
 QcvubhOZpUmOL7wU690GIoe6ngZ/17rJou1CiRNHPgV9O3yUuzlCU7QUdjAjF8eUzl4B
 P5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726839; x=1719331639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EZXir4tyTbilkK4IBj2or6kvXipnQF2t170oQXRmlK8=;
 b=ZWsmDzFBY5g7etOfNPp88fKciwsFEC44l4UqHpqTGqEWg1YxEePRG5FUy0e3WtLDsc
 Gp5kjqTNNnOr5Jeb02VucAKWmJBgyxeKy2FFgaeync3MmJqKH8QgbgKQrcOJtg8AUgI4
 E3wd1JEatoEBuuWmMVMPy/VFy8m/MNDMsyeVXRodG6GfqjZ4fh11sj4zC/Fvnk9yjmCo
 Rexh8MeHKqmM0o+aItF3SXpstBYaH1UX+MneYdWoI92Kxwc0Txz8z36N5jgoQj6HZt+Y
 fJaAwrCUEKtNDJTHL/Sm/PRismUbANjNj2llEnjNS4bfZC6eqNld1ZKTfopBJfIbJB8H
 D5Eg==
X-Gm-Message-State: AOJu0YwKouFn4Rsbc0tjwgLInLRm0TCBUegTyyh4tNgZyzhmhCuw6pDy
 4u3yNcTe0hwPnYtTqTglExoVQpIOPJuH/RvKCivVqxgYUBUBVx6SLuH0rF2y+8rKiFsmmtPXv6O
 +
X-Google-Smtp-Source: AGHT+IGMvNGt/7j5haK2xs4kFhNUsZwGuLzK3/d27Cn0vCAZWhH61pW6jJsTxLrrSLozPSacwCxHdw==
X-Received: by 2002:a05:6512:3285:b0:52b:c08d:d947 with SMTP id
 2adb3069b0e04-52ccaa62665mr36547e87.35.1718726838926; 
 Tue, 18 Jun 2024 09:07:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422874de68asm232231605e9.29.2024.06.18.09.07.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:07:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 69/76] util/readline: Add C-n, C-p shortcuts
Date: Tue, 18 Jun 2024 18:00:31 +0200
Message-ID: <20240618160039.36108-70-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

C-n and C-p are the default bindings for readline's next-history and
previous-history respectively. They have the same functionality as the
Down and Up arrow keys.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <9876594132d1f2e7210ab3f7ca01a82f95206447.1718265822.git.manos.pitsidianakis@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/readline.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/util/readline.c b/util/readline.c
index ded31b04b7..0b627d62ad 100644
--- a/util/readline.c
+++ b/util/readline.c
@@ -418,6 +418,14 @@ void readline_handle_byte(ReadLineState *rs, int ch)
             rs->last_cmd_buf_size = 0;
             rs->readline_func(rs->opaque, rs->cmd_buf, rs->readline_opaque);
             break;
+        case 14:
+            /* ^N Next line in history */
+            readline_down_char(rs);
+            break;
+        case 16:
+            /* ^P Prev line in history */
+            readline_up_char(rs);
+            break;
         case 23:
             /* ^W */
             readline_backword(rs);
-- 
2.41.0


