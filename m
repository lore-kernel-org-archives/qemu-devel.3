Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F788C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUaed-0007Cl-OD; Mon, 29 Jan 2024 18:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUady-0006ai-P7
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:23 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadx-0008Uo-4F
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:22 -0500
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6e125818649so1072695a34.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569340; x=1707174140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRwZFjq4cQsQYmD6HoikyRyAnRDJPSlCSVsphAQE8HU=;
 b=jPnXsN7a63Jo5SRhn+7XsyM6JYNB0yBDd0BsOtzKYr8enQtUiq6n6Sn5+h+Njij9VO
 MS0TsY+7Pbpm3BusDmziWvHlEJ/zM/M6CdOGUTNnU7ZCvyk4YB6OpLdBThKqANYjU67p
 vmYls2k4E4qEe82xQCBF1X4e24q/5Gx4oggACuL6Let3GSWUCzVH5sueeO+QdU+Vlmcr
 b0tY9Goz2PkvuZIiCnrBWUEcBq4jMAo+zOkIjTAonijddBv6kUPm2jPMLPkQBCZQOalv
 6OfSgsC73NbXLA5eqKWMQOBQEaPTWOWnJ+WqDfR9juE4D4v3gUrYTLt0SyXxtE33r6Pd
 nCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569340; x=1707174140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRwZFjq4cQsQYmD6HoikyRyAnRDJPSlCSVsphAQE8HU=;
 b=s6P6RPwzzYj1ejcfY43IgKnFL8meezjxOS3UZ7l2fLSea6MHc+4D1E7yJzJUxn9ah6
 x1LrSlgZJLRWHZ07DbbF1a2bNER2LwXs3BY2xgQ0wSULpFD1c9FyArrmxR+xP2vlb3om
 0lL0CHyh0SVA/G9939e3C6QVts9H3vxmym+Gbb940OREaHDv8Qwu01m7tnDJVMvSmgDe
 IcKs16jxTZotw7v2d2+nsNY/14TVrPaXXO3qdf8haNfBB5QY1X3UqIlStB5O429WaGct
 PjG5kyLImzh7aoHPLu/lxb7/27cm0FIOtQPbfH39Ayu7fvdM8k+K4gd39G8cHj4IrTzG
 XjjQ==
X-Gm-Message-State: AOJu0YxTnFP6FrPaajA7WZL5PtM4V515uAhJT8B7u0ECXSLRbNKz3AYl
 cR2xuIHAB+FkxWoQG3HpwWH4ZejfqzQefhlEJk3bhCJ+MGYAISl0v5NJiVT0GtTJGNGrjmTspKn
 UGDw=
X-Google-Smtp-Source: AGHT+IEvc7J8yHYX4/mdJEiooUFZueyqz8kgJTLAAwDuUrWpB4kZ0zbhHcuGr06gnx6+VGRjmR2JMQ==
X-Received: by 2002:a05:6358:5982:b0:176:80c4:a44b with SMTP id
 c2-20020a056358598200b0017680c4a44bmr6622585rwf.9.1706569339994; 
 Mon, 29 Jan 2024 15:02:19 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 20/31] accel/tcg: Rename tcg_ss[] -> tcg_specific_ss[] in meson
Date: Tue, 30 Jan 2024 09:01:10 +1000
Message-Id: <20240129230121.8091-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

tcg_ss[] source set contains target-specific units.
Rename it as 'tcg_specific_ss[]' for clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240124101639.30056-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 46f7d53eeb..aef80de967 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,8 +1,8 @@
-tcg_ss = ss.source_set()
 common_ss.add(when: 'CONFIG_TCG', if_true: files(
   'cpu-exec-common.c',
 ))
-tcg_ss.add(files(
+tcg_specific_ss = ss.source_set()
+tcg_specific_ss.add(files(
   'tcg-all.c',
   'cpu-exec.c',
   'tb-maint.c',
@@ -11,12 +11,12 @@ tcg_ss.add(files(
   'translate-all.c',
   'translator.c',
 ))
-tcg_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-tcg_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
+tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
+tcg_specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
 if get_option('plugins')
-  tcg_ss.add(files('plugin-gen.c'))
+  tcg_specific_ss.add(files('plugin-gen.c'))
 endif
-specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
+specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
-- 
2.34.1


