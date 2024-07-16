Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBF2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTme5-0004zS-Bc; Tue, 16 Jul 2024 14:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmdZ-0002OD-8U
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:56 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmdX-0001KC-Kk
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:53 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4265b7514fcso51435e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721153449; x=1721758249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VrGZmaUNm2C+uivQuRjRJj4n0srykunZLqWSf7H3M6M=;
 b=UVqfVx5Zg6JYYbRebn4ohEijgCGxs5yB9k2K8PL4rCDqdC3n9p74bB0sKCM9zudST8
 viJsVAlHC+Jo8S6ozM4Sc8jfrvdc961X2hzOdY8ppPN/aTFgCLe6DuoVTPY7p4vVh4JK
 X6Ujdvln6bIlpsmIaYOX1vHCeI3/6Ac310eOgC6zhPYWTcv5231gVwqElDq1WgZNPS7b
 ZhiNgtldmsQLuKUGjpzpGXV4IzWhGINto6Pfq27S63V79oBbCIsnewx4wBvEvjEJnxYX
 PIblKPIIMYqHZfwDckRkJNe7dkRUzpHTtXLe3P0Ziw2WcSLQ3beJ2/0MnEqsFdzsbbn/
 xpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721153449; x=1721758249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VrGZmaUNm2C+uivQuRjRJj4n0srykunZLqWSf7H3M6M=;
 b=eQ6jFrfQtuKoS5gvyJvIx77cqZe1/ZgGBYDw2JuBsXDPXAs4LH759XczivNdTv0gyr
 QdQoSa8JPLeVTPDP4/WmrrscE8n2RcZGwlAEkj059zxpSbRdcF+fqaKtl8tzIcjKaoHq
 XxFr8LLvs7vQjh8gMppwh9TrQvzVK4VtgzSXlPF5iZ4/tREYnd0Q8la/PwhZgTnAhFdu
 NP+swPkcs97ncHM5HtYrJcrpSRKktHKHS0y9iTlsfcy7qbBrHvaWWroblhfUXQBdzope
 Ngmn9eqWutyJEFzXjW/WWqfh2gLyBFzT/ZzeQGmpqpkbkZHfKIJRUYfwCc0MNQ5WC6KZ
 Fg6g==
X-Gm-Message-State: AOJu0YwQv/ZxHljAFt5ZzUy8s6tE6lsTRMLBXkWnxfIh2O+BIE/Q3q0w
 yBEihhA9j2VMnmFWYLFiJC8Or5C9xa9LF8XHBH3rNoOSp71d1j6doGijyB946wFRW+gSMsQ4ppE
 776TjmA==
X-Google-Smtp-Source: AGHT+IE4QT7PUFjdL7pi9Ig7YhVybjygWiS4Kug16Kte6eHA03IZGN7Lr2QhdKXedaDUjkza0lb6wQ==
X-Received: by 2002:a05:600c:310c:b0:426:5cc7:82f with SMTP id
 5b1f17b1804b1-427bb8c4cebmr20400235e9.13.1721153449549; 
 Tue, 16 Jul 2024 11:10:49 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dabf15dsm9745401f8f.32.2024.07.16.11.10.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:10:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/13] vl: fix "type is NULL" in -vga help
Date: Tue, 16 Jul 2024 20:09:39 +0200
Message-ID: <20240716180941.40211-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716180941.40211-1-philmd@linaro.org>
References: <20240716180941.40211-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Don't pass NULL to module_object_class_by_name(), when the interface is
unavailable.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240715114420.2062870-1-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index bdd2f6ecf6..9e8f16f155 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1000,9 +1000,16 @@ static bool vga_interface_available(VGAInterfaceType t)
     const VGAInterfaceInfo *ti = &vga_interfaces[t];
 
     assert(t < VGA_TYPE_MAX);
-    return !ti->class_names[0] ||
-           module_object_class_by_name(ti->class_names[0]) ||
-           module_object_class_by_name(ti->class_names[1]);
+
+    if (!ti->class_names[0] || module_object_class_by_name(ti->class_names[0])) {
+        return true;
+    }
+
+    if (ti->class_names[1] && module_object_class_by_name(ti->class_names[1])) {
+        return true;
+    }
+
+    return false;
 }
 
 static const char *
-- 
2.41.0


