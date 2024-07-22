Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D64C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqzl-0002Ts-3J; Mon, 22 Jul 2024 07:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqzi-0002L1-Ho
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:14:18 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqzf-0004Jo-Rc
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:14:18 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2eede876fbfso56481141fa.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646851; x=1722251651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ql8l31gb6ox+2gEb124K+SkO2XK4Lwws9D+yeW2DVYs=;
 b=j9fww0gcbu+ApJfPWJdf+E0QELG0fKr/mC9ZZX9GTPkvrJw9zsQOTUZb1Wxvr7A8Nh
 yDdBXabrEadcjdrZeHEEoNj7ZKCGS5qCrbYIA0rXoZ4hA1YU9moA0dgov3MRWzKXxpYT
 Ccen9HwsqN+CdZwo8mM6Zwo9Rt9yF6xycpJMcIFMj4GT1pAdH3eCESErhNBpa0T+j1cc
 I5oI42DLCs9S0oBLEBsYqKBoZz5CgY3PZaON8ihjUy7ag6aLhbJOwp2NEnZgsMatQqSl
 p8CB2Hue3DwPdXaMltpN+YfkfM7tWcD9sQ4B16eZzh1pM6R5s4rOGcUJO+0FtU+qlN6m
 K1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646851; x=1722251651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ql8l31gb6ox+2gEb124K+SkO2XK4Lwws9D+yeW2DVYs=;
 b=hKnuUVdY/Xt/chANaKZekn8f9I81Boq8YSGUuyKbq5nVLJbSuyXWtI2ncwOVYTxaqJ
 X+Tyk7dwLIqP6THr7fRvH8P/xKJUp5/g3k/efU1Qaiw2R8vWd3TCXCctSIf+rCqyH2Wi
 ljwdVcX9svU+uCa6qUg1PZtqe5qIiNAGCoi4RPR3vvC/2XW9qXMec7Ki7xZYVBETMVnr
 YWBRi/8kbaMUEiRM3ofe6BABqnjIZfwtxLrR2yADRLqVyxk3CQtcf08Cs2xuS/Vsr9iW
 Pj8WzNPUVEvqxsyR3lQ7GO78yiNotxKh6zRh3PRXq8AcP0UVYmuLLsEh6dzZjoe+ZMFb
 ISUw==
X-Gm-Message-State: AOJu0YwHP0Q2X58WJR8zYo7lUqBNhIW7Fhzp3MuAbEYmXP1oy4k9VLUS
 FEQE033krn9UvRdNR+sWAvUVPMvJovEsXEBrTWfw36SJDSEdqDV6YE1DmzQFZJU=
X-Google-Smtp-Source: AGHT+IFZGAxYyXv59CEJBmZPfF/qJ3nLLt1DsmUUnYGddUlyDrtdhTBrTN8NuBqhJMvxRJ+GYwhlsA==
X-Received: by 2002:a2e:95d9:0:b0:2ef:208f:9ec5 with SMTP id
 38308e7fff4ca-2ef208fa19fmr41661291fa.31.1721646851030; 
 Mon, 22 Jul 2024 04:14:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa0a6sm123897995e9.9.2024.07.22.04.14.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:14:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E571A62107;
 Mon, 22 Jul 2024 12:04:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 14/16] target/xtensa: Restrict semihosting to TCG
Date: Mon, 22 Jul 2024 12:04:11 +0100
Message-Id: <20240722110413.118418-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The semihosting feature depends on TCG (due to the probe_access
API access). Although TCG is the single accelerator currently
available for the xtensa target, use the Kconfig "imply" directive
which is more correct (if we were to support a different accel).

Reported-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240717105723.58965-8-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240718094523.1198645-15-alex.bennee@linaro.org>

diff --git a/target/xtensa/Kconfig b/target/xtensa/Kconfig
index 5e46049262..e8c2598c4d 100644
--- a/target/xtensa/Kconfig
+++ b/target/xtensa/Kconfig
@@ -1,3 +1,3 @@
 config XTENSA
     bool
-    select SEMIHOSTING
+    imply SEMIHOSTING if TCG
-- 
2.39.2


