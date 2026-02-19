Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28480E9A056
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7fT-0005Pr-N5; Thu, 19 Feb 2026 12:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fQ-0005Mf-B5
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:20 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fO-0000R5-A9
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:19 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-65a3fdeb7d9so1569613a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771521497; x=1772126297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3rDXWxTc8F8CeotEYArZQgzd6idckf+iX82oWokDYc=;
 b=Fq78MWP7URx3I24UvNwCju1I+GME4or7+mfquZKfxoTHytjiImdDZELS4ncEftjO+O
 +Ui9uMD0oeinPhZ6g8JHk0rl9orI3SsUeHEUAZvM/wmFiGnafbHHmiESyuQBqG1RnzkM
 GOU4XJwX7DATwKj2nwzL6D9wUFMneoSfXbA1ceZuIF66EMNydnBhoZg3D02ceXuMftXy
 irSmZs3Otmw9AS3OP7w4T9vy4zvf9b4bPOvXeO1K03aPI25XjKH2uH9T/CiXB33Nh2GU
 lSrLB4TQxIcODV5D7MSbfSsdU1s6wpP3gbFu8ORfc/qAnWDV9IBqCj2PqHmVuoJ4npHR
 9j1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771521497; x=1772126297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+3rDXWxTc8F8CeotEYArZQgzd6idckf+iX82oWokDYc=;
 b=wp5Nhi6PHB6/4n/lt9Rz/hYFrbz2JnZkgsbO3xzNbupF7xjHMLSIjpZi5ZdT+hdbsK
 Gz9ArM36cmABUkmTgB077zzhOtNgYKHlwNKhq3BYDeKnY4JuirzivBtlQ8EK70OS7VMQ
 OfODYLnsaLSzwxORr5IdEzjEq8wFRZzRiJ5LcO4g0mcfsIia6yOWvA8I43Lnnkt9MfT1
 bDyzQfLkwQGcek7Kw5nmwW1w/9moeqaCE5G02uylSNdlvPeY/y/ADH0Tdy7zaZuQiO3+
 JoRusmG0AVY9rsrufjD6Klk38tD4Hbvs9dBvoi1z4IzE8dK7VysFgbj9SMoRlGsWuVuv
 XISw==
X-Gm-Message-State: AOJu0Yw7+uOM2DJ//6VnQjPUAs8bei9OHeQ1YYddgGEKsSRPKINnzl8j
 uIO8Gk1SSojMooPmRmv44wCA9L/PoMlYTijCQvgnXrcLJH8HJ3vP60aBUdG29RipI5A=
X-Gm-Gg: AZuq6aKiDeOYnQ4Xkp3Qg6ZGbTgCNOzooHerlLyvUkH5oJWtFK8TIbW5J2WGVWr1xHK
 pyO2a+nLRAwAA/gsr3I8Q9gAOgbDfu0UNs1PgdQQmc7E9GiVa5qyHUt9PwhOufcvcLEMk6MnpwL
 ogb6u4gjEnxxShEWLJlw7HFasGFGXmS/8NE+JvMoxohBFpWXByFaNbavQLdvYO4wcTyCLWtW9Lh
 Na0JjaOoxnA6w7LsRmyqilIavDVAXwi160t+HbzZHP/ls6ttM6UtYDoifS70+OFxe63JnWAGth0
 8e1Vwj+q8+J3Wv+KTB2xHiBt89g7NzwdYeqL4BQoAKHMG9L0Igl2QDifnDs+/VN3MEZgdBNEWu0
 8UFn5f3HNTsBZxifVPUVsankSdlnU3sKWTC7LYjh8afkZ5KPDJ7JGYaa3KYzTphBJGmcq+vII6J
 ObX34n3O2fH23kHCHkSjUKqBk=
X-Received: by 2002:a17:906:d54a:b0:b8f:1c:e815 with SMTP id
 a640c23a62f3a-b8fb44fd4b4mr1289377666b.48.1771521496614; 
 Thu, 19 Feb 2026 09:18:16 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc7665563sm589027366b.47.2026.02.19.09.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:18:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3E8835F8D0;
 Thu, 19 Feb 2026 17:18:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2 08/14] hw/mips: drop cpu_reset in mips_cpu_realizefn
Date: Thu, 19 Feb 2026 17:18:04 +0000
Message-ID: <20260219171810.602667-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219171810.602667-1-alex.bennee@linaro.org>
References: <20260219171810.602667-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We will always do a cpu_reset during mips_cpu_reset_hold().

Message-ID: <20260108143423.1378674-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/mips/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index e424d115018..f20613f1223 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -488,7 +488,6 @@ static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
     fpu_init(env, env->cpu_model);
     mvp_init(env);
 
-    cpu_reset(cs);
     qemu_init_vcpu(cs);
 
     mcc->parent_realize(dev, errp);
-- 
2.47.3


