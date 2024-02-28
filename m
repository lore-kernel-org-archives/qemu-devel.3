Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EE1C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIeZ-0005E0-7v; Wed, 28 Feb 2024 07:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeR-0004qM-8y
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:09 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeP-000367-E0
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:06 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-512bc0e8ce1so5767154e87.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121783; x=1709726583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mr8xNnhDGY0/lMKUx04e9LXvXJNCxTVqWEKyAEz4psM=;
 b=f+A4ehjjMLGBP6JR8CMIOxaSAqnZvKkPFtzAD2sEMlkR2kIlI5e6GXD0SEMrCXQnzt
 OaylmzMhHCFoIYBfK2tH78nMtV/eR9Bucjhr9y+XN1V3JJ4hxz4jiT/4RTj7/TPbsvUL
 rLI+kxUtq2wzPathn23pC73/iqDYet1Q4CiiXCeMwVNgpkjHp8/TcuPNq8Gr2XBpKMlp
 QazevKcHpFs4KzrP6Ggcp7jxwBXg+Nmr/2JACD8kGxIn3pcRAIDSs+uXtz0STNZUFyZF
 7xAih89/vWhkJu6qGX0k8Yz+vBlSuKkabG8QMJqtCXTGBKzHe1eJPA18F/D5E6Ovpjp3
 VBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121783; x=1709726583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mr8xNnhDGY0/lMKUx04e9LXvXJNCxTVqWEKyAEz4psM=;
 b=s3zpBGPLBtoRGVuvklJrMxEPhHfHpP2aM/OztfndruK9jp8m1wzgU2/K9KKLLasu7B
 4EWXER+WUTUPV/buXfLc1LHKSoFNHjPqtdj0wiHg3UVu7yC3DyVamW+pKELe6kBjjGOn
 ojy3qU2Rrebxe1reMeWrDZ1gXmy3p67GSRpDrMOcwtOK8AAHJ7xpvd/LNE7QYE4cSf6q
 nczPCBsRvXZdtETHiIDPgcm1XulAh+drokiV8XOcwgUd5QlLwT9AtYouxkVQw4Ix2WG9
 Z4vqH3RyLSANiQ4GooilwqRx/KAnIZXdj4SBfGztIDj0djEwJgAJzWjFztOlMYgktCVX
 oETg==
X-Gm-Message-State: AOJu0YzzcVqQHMzfr5hO8U3uA0LSJH8rkJjWCF2CADeAwuvGWwukly7Y
 7WTZjvdyO8SjQ2gK16tjlp56MVXIGloeObwbdLQc9MVWSD8UoWOJCat+b6phX6E=
X-Google-Smtp-Source: AGHT+IF1nPVLVkNp6JLIjXgjPYdh4//ezKDtWRVqfYwY5IqzookWyFGbk/y+v7Q+e6wP2XPRrsW7Zw==
X-Received: by 2002:a19:5e19:0:b0:512:b27c:18b5 with SMTP id
 s25-20020a195e19000000b00512b27c18b5mr8018445lfb.30.1709121783438; 
 Wed, 28 Feb 2024 04:03:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m21-20020a05600c4f5500b00412b0ef22basm1918683wmq.10.2024.02.28.04.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 04:02:59 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B2E465F920;
 Wed, 28 Feb 2024 11:57:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 18/29] linux-user: ensure nios2 processes queued work
Date: Wed, 28 Feb 2024 11:56:50 +0000
Message-Id: <20240228115701.1416107-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x130.google.com
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

While async processes are rare for linux-user we do use them from time
to time. The most obvious one is tb_flush when we run out of
translation space. We will also need this when we move plugin
vcpu_init to an async task.

Fix nios2 to follow its older, wiser and more stable siblings.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-19-alex.bennee@linaro.org>

diff --git a/linux-user/nios2/cpu_loop.c b/linux-user/nios2/cpu_loop.c
index da77ede76bd..7fe08c87501 100644
--- a/linux-user/nios2/cpu_loop.c
+++ b/linux-user/nios2/cpu_loop.c
@@ -32,6 +32,7 @@ void cpu_loop(CPUNios2State *env)
         cpu_exec_start(cs);
         trapnr = cpu_exec(cs);
         cpu_exec_end(cs);
+        process_queued_cpu_work(cs);
 
         switch (trapnr) {
         case EXCP_INTERRUPT:
-- 
2.39.2


