Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCB4D374A2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rl0-0003Uz-CM; Thu, 17 Oct 2024 10:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rky-0003UI-EE
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:40 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rkw-0005dB-Rl
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:40 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c9552d02e6so1306851a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729176337; x=1729781137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZr22C6GyP2zNyIOBJrfarPfi36zfJfEl98MesRI/BA=;
 b=curorWq933SuKtgCvjv6I0zkuJwAjHFQpwu/PH1GYprjyf1syEGbNnMmtKDGe4kp9G
 J1GVv6EoU3HJCCFzTx7y9rqIN6szXAb0XhXdKw6kdS9IQVOPC4awmdNec8cQ6DrumY1c
 fSw+P7YhaYGV5UuKydjsOK93rTTdC2gQA2FxzHeVcqpTa5aNrqpz3EBEjH2lLvVDAtNF
 SJWOQN8Y2sYP66FqAMH8VoBBwysD68VbLJGTRsRobZUurUZoXBB2M+UMvUZpDZnJA7GP
 IINMf5gTqPzpVih2SlHZSXhlL12ctNDVpq0LSA0dl0PmGxUVH/OFiKQSUFJcUnV0g+Cq
 ZfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176337; x=1729781137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZr22C6GyP2zNyIOBJrfarPfi36zfJfEl98MesRI/BA=;
 b=lh+6S/S7o3URD0K87zDqYdnZjdVC8wArvOtylGaZcNcxlxGJubd6E9fztoWx5dYnOm
 xQO2Xx/P6nGS3x/yHMI8eaD4on4xACVOhDQe97NJ4C4yeyt5f3keyLutrwu7Kj4v0ze+
 wXN4EFW47jz2hMokaAuHIvRZmDfAb85ekd/JzH5o/fPaIr6X1htkdbk/oFrrZ8kTNGCN
 935bYcrEBgz0AiuUOFilZ0RkR9FBXuLi5FlqfKArZZxhoMBkmYKiqp3SRA94rR6kSxvz
 azUNmeHghs1wRQCQ9snPm/2SssCuG3438ZpqfwELGB0cbMf+/Lz8ZznPydVndROWTQ+s
 c9gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNKFfejyVCCWKyOpqTXffTlAD5CAr5vx4SBEfNfmdlRaGMStfoYSG3tlwDr8hWRYQ8Fb3RUXgqmT7g@nongnu.org
X-Gm-Message-State: AOJu0YxSc0VU2tjrB4lVoG+lgJT3Dp2HQ36v8u61PT9Ritbsm+J3OVSA
 9zurndfrNwxwcR9yZx/cYXQx3YJlG8PuJtIz6Ns9gq5D5hpdvJVC
X-Google-Smtp-Source: AGHT+IF2YCixYqLfzI4/DGl98h6fPQzush1VKvg4kaTKTnP6VmKNDYdJis+Xyt7V+o1jBkWqmoNOLg==
X-Received: by 2002:a05:6402:2710:b0:5c9:6f56:b042 with SMTP id
 4fb4d7f45d1cf-5c9950946d4mr5724322a12.4.1729176336915; 
 Thu, 17 Oct 2024 07:45:36 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:9c4:b066:486:f408])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d507a14sm2867581a12.49.2024.10.17.07.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:45:35 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 2/8] chardev/char: rename `char-mux.c` to `char-mux-fe.c`
Date: Thu, 17 Oct 2024 16:43:10 +0200
Message-Id: <20241017144316.517709-3-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017144316.517709-1-r.peniaev@gmail.com>
References: <20241017144316.517709-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

In the following patches backend multiplexer will be
introduced and the implementation will be named as
follows: `char-mux-be.c`. This patch renames the
frontend multiplexer from `char-mux.c` to
`char-mux-fe.c`.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/{char-mux.c => char-mux-fe.c} | 0
 chardev/meson.build                   | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename chardev/{char-mux.c => char-mux-fe.c} (100%)

diff --git a/chardev/char-mux.c b/chardev/char-mux-fe.c
similarity index 100%
rename from chardev/char-mux.c
rename to chardev/char-mux-fe.c
diff --git a/chardev/meson.build b/chardev/meson.build
index 70070a8279a9..778444a00ca6 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -2,7 +2,7 @@ chardev_ss.add(files(
   'char-fe.c',
   'char-file.c',
   'char-io.c',
-  'char-mux.c',
+  'char-mux-fe.c',
   'char-null.c',
   'char-pipe.c',
   'char-ringbuf.c',
-- 
2.34.1


