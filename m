Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7C2C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsoI-0001b4-JC; Tue, 25 Feb 2025 06:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmsnx-0001XX-A0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:50 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmsnv-0007kL-Pv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:49 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-439ac3216dcso31534665e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740481726; x=1741086526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXCoC3AjlvjFHfpG46LUtIZq27ESsMFw+aj5c/6HJiY=;
 b=pI2JePBOnvXQUHQSo5AX3g+2f0Xwe5/c6MSSC3V2XSie8bh83+XtaKs9clCZ90nhkD
 ubHxRGwyMW5nHOUG+8Tknv1dUxmM4sWqgRLJ2GunwBW8onmoSrCMq0MVZ8B8CZqz6uCO
 okVTH9mQy67ncjHKuL1sfnTdH1kuCoINWY0ZlswvUiNLa5i5REiffuGIh0HAOMmZC6TM
 ydz1+jD/OIxW3wjF+ku+JxRMP5QtHYw9i7NIdcshQrRoeBPFRPe/AszdnORe+DgHphf3
 lO0FB0rgvR0NCjkgal6OxTHJUUNt3I8eqrwh0qvXxflSw+SYS8e0k4dzWvgeh2gdFOI4
 h6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740481726; x=1741086526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BXCoC3AjlvjFHfpG46LUtIZq27ESsMFw+aj5c/6HJiY=;
 b=XPKNl58SoC/q0hJtaiG/1Ni0UaTQs9qnk+hBp+uwt/NIiK2QR8VgxP0q3vjakuwPvL
 7dMwI8CZ6wvxWNppZn6Q2Aa3V0XMIrkL0oUKZFCt7I+T5hTEoCpA9pYLFMlWiB51ss4d
 vWDlXP30/j+hgncDZLItae0KDSoSWGILRnZ2mMpkj9uadjDAYTJtmMMSOHiF5FBP4YA0
 39ABrRvwIsBJaFKyNfcIM/et4j6CWHopBtiabjjGh1q9Q1yL10BRtrBeGGsKmBbOPg7h
 z3gz7Mf01oGgohLvTod8GA4zwnpIE+mELBFEJp/S5CBMIR8bKDDdDBRZIjFr1q6NjYvY
 GOLg==
X-Gm-Message-State: AOJu0YxHZSCo3NQXFlhyD3K7iEo22l4dC7guDbGPgQydCMB1dNHMLvSm
 t7ajQQFMEzfvOza4Rq0kN88zYwMYT3V6PdcqHhOXXFS+7MO6lYHMjDXiQ27vWZglfkzwcKQON2M
 fTJU=
X-Gm-Gg: ASbGnct9j/OUp17sjRShRtg28H9fF1YToy3ww0kQBDWE0kTiRQxywWfD5XlXzQ8GSoP
 KCvO2drVQ0GiWPMcdE2lUQDe9DFyGI8EvaRu453zZ9c435qCyL7AQEnKc3VHRT874jmJsvlrOSJ
 tjSTzE347geICq0M3Eqq+CCxY+XPxG2ObB5QnMJoULxqDEDdrFblncjSj+9BK1qby7xl4qgitIv
 etYgx6qgu4id+oWhydp0qAiW1s61JEmRepCdPDo+pHU6d5x49WAQHsTwKZmtoxhJZpDUI0BtrWH
 LMfjnbwGbnc3Zit4KAw5lmakxsiI
X-Google-Smtp-Source: AGHT+IHEUDqi/lWHUnS/yiCwRNbVZjHheB1kM2eycQhr+AtOAs5gPi2q0Ksc9MbN+Ppw90+weFe6CA==
X-Received: by 2002:a05:600c:474b:b0:439:9a40:aa19 with SMTP id
 5b1f17b1804b1-43ab1823448mr19381435e9.12.1740481725960; 
 Tue, 25 Feb 2025 03:08:45 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab1532f20sm22530435e9.8.2025.02.25.03.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:08:44 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 56A605F9D3;
 Tue, 25 Feb 2025 11:08:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 02/10] plugins/loader: populate target_name with target_name()
Date: Tue, 25 Feb 2025 11:08:36 +0000
Message-Id: <20250225110844.3296991-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225110844.3296991-1-alex.bennee@linaro.org>
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We have a function we can call for this, lets not rely on macros that
stop us building once.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/loader.c b/plugins/loader.c
index 99686b5466..827473c8b6 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -297,7 +297,7 @@ int qemu_plugin_load_list(QemuPluginList *head, Error **errp)
     struct qemu_plugin_desc *desc, *next;
     g_autofree qemu_info_t *info = g_new0(qemu_info_t, 1);
 
-    info->target_name = TARGET_NAME;
+    info->target_name = target_name();
     info->version.min = QEMU_PLUGIN_MIN_VERSION;
     info->version.cur = QEMU_PLUGIN_VERSION;
 #ifndef CONFIG_USER_ONLY
-- 
2.39.5


