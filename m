Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83609C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr2Dm-00029g-5K; Sat, 08 Mar 2025 17:00:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DT-0001hW-61
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:23 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DQ-0001vi-1G
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:17 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso16795995e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741471214; x=1742076014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b27xhBD0ksksCzDRiT3v7v4kY1rR1YfNmNHzo2TcGOY=;
 b=dkuSGDekNQe3NdGCIhoIQ6bRS4vVNmEo2bBKYl1H91cUNZN5lOKJxnLX/bAnNvh7bW
 kEUZZP0vuPui3DoNkFGo9WVa8dGDyxMB59mANkVu16QAj5yKj9M/CE47vHk9Or3UKwd4
 lLQy9WW8kEOnQLMFvvGUHUdcEWC6kzs20sHafn5qt+lUnRYvadbQS4hGF8bLEOZNUfRc
 18BG5EHDwf46W2a5eb/ak6l5VnhZX+3oitB44xs3bDprjLoNGErN4BudnyJVuwYSR8L4
 4Lb/vd/EJsl8iqN/Q3gn8+XUiC7EYNOCoOZTYNIhnmY7rzLfGMA0UBRwZRGTAwFT71RE
 lYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741471214; x=1742076014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b27xhBD0ksksCzDRiT3v7v4kY1rR1YfNmNHzo2TcGOY=;
 b=i3W+K/LR0/KiGWo0Zo7Xm06kWgj2t38HNVXXXV0W0jGx6ZS7MQzeEILo2ATum1X9oh
 3y0o2tf2uwCbanxgLEYkvAXqCVaiQzgBtpooRXMSJG3HOkAimry1PyXzhE1qLuE9Sjco
 bbsle7L2g8ITt14a/kzaVRJMcJG0+olvS6WxoMNNALkMJEi/JrJ+5YVX1rdGatz3UIaA
 LGvROphdh5GtK3SK4WzJVlhySmauDG9x2GO0juOT0p5CYF+fJK+0lOg27DUxP5uOKesG
 21xWYxATHHmRRFss4thOWdM+aWwjQaV9g3G9xxPGf/rZzsa/QvBvgGR6r0RANEpIv7K3
 UmQA==
X-Gm-Message-State: AOJu0YwOG0Bfq8OeavcYhppcpK11L7br4K45nX1ne9DOUoXwE12jAJhD
 ed+vbYAMwazRXMKH8ePIPbo5ccsqHuTNVE1WUQHJAFL+gY27z288L/FbJMu2yxw=
X-Gm-Gg: ASbGnctHIEN7uKAM4SonIq9D2UnZe0RX1NzIW7NkTe48b/k4bDqUzEaiFiQuMtT4qN+
 BDZySpfGc6MO5TomvwmQpfXKCeUGJ/vpzUbR0hA9Hx+ZiZsyvmwdoLlcPztp0d9YeYrgtlc93L0
 vU9+UzR2+abLrvI52xuTfT9oGd7OnxntqPW8QnGQjVS1z/crfa8DEZ1SInRRn1iUAuC+ujw6jDJ
 9LEKyjj6xoz+8UYMxMwUnO5mgtVG5qN+x/VPo+3bZrDNN4hcGCrno3hRJDA//p9enjhzXlSFPB6
 8X+QqY2cYuyuuRuy/Zvf8sU/f4nvFOZwfVpRAxiOnbsrIwU=
X-Google-Smtp-Source: AGHT+IGMAcPkKhISvEWjOOWBNpMuBc/yEBkdF+cEJsJ2YvwTWCOQlk2uDA7ZXUtWyE0XHoDHKvHIlQ==
X-Received: by 2002:a7b:ca4c:0:b0:43c:eb00:50eb with SMTP id
 5b1f17b1804b1-43ceb0054a9mr19550155e9.5.1741471214460; 
 Sat, 08 Mar 2025 14:00:14 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb79b9sm9804987f8f.3.2025.03.08.14.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:00:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 931D460794;
 Sat,  8 Mar 2025 21:53:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 21/31] plugins/loader: populate target_name with target_name()
Date: Sat,  8 Mar 2025 21:53:16 +0000
Message-Id: <20250308215326.2907828-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

We have a function we can call for this, lets not rely on macros that
stop us building once.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-22-alex.bennee@linaro.org>

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


