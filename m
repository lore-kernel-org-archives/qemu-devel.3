Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C912AC38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPl0B-0002pr-OK; Fri, 05 Jul 2024 11:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPl02-0002dl-Qa
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:26 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPl00-0001JE-0m
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:26 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a77b550128dso228461266b.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193842; x=1720798642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n236Rd+ZsQdBpOfpU2JzZjmyVcpBVPLX43laLzo8bCU=;
 b=fcMOHP/xRw1Ihu5WbaqRNOzWTzsxWxKQCxeWvoMez8bFVb071MtwFBvbXh9VhqlJ8p
 ZpQjbA3Q72/0oy6Rg4v4dsBTcy9TPChd0PnayRYLDgEwjzW9LGXjTwx3vkaCqR8kaDjj
 e1A82X2qKIAeAzCj1T660VOoJWS6Y4DDgUh62uWYq5IeaUDbedwOL4u+hyw3wZWVI8OV
 vF77wxCruGyCLpSrSnC8p6f1pq2ZROihwopmA/nivRIm2XnQzPAbVt2wNgavz0M/Ea3H
 rtCchRTs8+xhLiqOMoJwSnfuFPki0hgif1AAO2ePiPJVQmQb9DYKOVfSkPaQrIukiKHV
 viVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193842; x=1720798642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n236Rd+ZsQdBpOfpU2JzZjmyVcpBVPLX43laLzo8bCU=;
 b=f+3JnG/0i/hMjon9GCb9j4jDVj3bEF1Bx+zF8uc0ZyI9rZgG3q2ZJgw4cVuC5xFRa3
 ewRp0n1+QTU/uTG35mMQoUA1GptLbBq4vE4yEHMzXMT4aKuNkXTRDA1jxh4LDjfFPCnz
 CWarqb7SLzDmHCxsEQs9CsF99fJay/rdUf77o2zEcFZeDxjfmBGBo9evTCKCKbSP1wUZ
 MrB5tLfH6tLi/WlsNVe31VjvGw79qenA+WDKU+pnD6BbVkzpolwhcM8+V0tcS9Xw/4qr
 bLx7dCTJ4X/QXfPUyi7KZ8TtI7bVigu2peh8523ZncGxTTIwhMTPOd0xrzFCUvR/zX5e
 fuxw==
X-Gm-Message-State: AOJu0YwvWWUeXwPiO/322npYd1z6qAGzE2cg0JM/Ftg4XRBQvPTG/xGh
 +0bau+XJRe3CdID7xcuk58aZhJjSbXDV+T/kbHLeSt2oQ4P+uOnafD/eqUnQqG0=
X-Google-Smtp-Source: AGHT+IHEyA5Tw15ixlH7b6MQBwt7uQYKFPV7w9u6HhVlGiGwOvgNj3lx2hQhViuqIaw+/8lNk4n3nA==
X-Received: by 2002:a17:906:c00f:b0:a77:dc23:5625 with SMTP id
 a640c23a62f3a-a77dc235698mr55196266b.22.1720193842229; 
 Fri, 05 Jul 2024 08:37:22 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77dba80177sm25511866b.30.2024.07.05.08.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CB2666211E;
 Fri,  5 Jul 2024 16:30:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 19/40] linux-user/main: Suppress out-of-range comparison
 warning for clang
Date: Fri,  5 Jul 2024 16:30:31 +0100
Message-Id: <20240705153052.1219696-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

For arm32 host and arm64 guest we get

.../main.c:851:32: error: result of comparison of constant 70368744177664 with expression of type 'unsigned long' is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (TASK_UNMAPPED_BASE < reserved_va) {
            ~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~

We already disable -Wtype-limits here, for this exact comparison, but
that is not enough for clang.  Disable -Wtautological-compare as well,
which is a superset.  GCC ignores the unknown warning flag.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-15-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-20-alex.bennee@linaro.org>

diff --git a/linux-user/main.c b/linux-user/main.c
index 94c99a1366..7d3cf45fa9 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -843,6 +843,7 @@ int main(int argc, char **argv, char **envp)
      */
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wtype-limits"
+#pragma GCC diagnostic ignored "-Wtautological-compare"
 
     /*
      * Select an initial value for task_unmapped_base that is in range.
-- 
2.39.2


