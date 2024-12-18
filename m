Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FD8E77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuLR-0002rR-Bu; Wed, 18 Dec 2024 08:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKq-0001cZ-6o
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:35 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKn-0005iy-Ey
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:31 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3eba0f09c3aso1893519b6e.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529408; x=1735134208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvujwnxE8Fg/BvBXGOdD9Awx1XXHKb+jgFuuM9+zV8Y=;
 b=aOQhHeMCYbeiKkF1FYBTXq4Ni4lGIQrMtxsiL1F86mr4M90nE5Z9chb5oTGKj+Stk5
 mn1pHmF+85ux54g5fqlffmorFsnprpnXOj4wHQAm6nqfSSibSHHh0S3JDtEnN02eHRkR
 owa3XO7y4QZgCo35MhWUhXdkaTrYk3QsOr72haPAOTe8Km2KoHk6Fv1OG593bhKeCRV4
 66WUrnXhQNkyKG6cZ3AWj4VPVLQyMiHn/YHB7h7801tfy7mxQHlyHyOs4kGqb0NXx5dS
 oVFbXBp9oXNbQgwMFpwFN7dO4yjOmdk76uvsCJ2a6zcOHUoLfxD1px6p2ZY3BjGvpWCK
 smKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529408; x=1735134208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XvujwnxE8Fg/BvBXGOdD9Awx1XXHKb+jgFuuM9+zV8Y=;
 b=NpIeMZGUvL5pUx39hW96iKaaDt1YKjxGv3PB9yvYy7lBVlD7H1+Af/PGo8UdHyDgqv
 luSS78+kazA9m+6BDwAmZIqVtjvmZ3N4sD83rtkNtl6Xaoqd2ili9Wbp9O19H1CHH5jT
 At0WhDoX9PUXxJDkoNYG6i+BSfkOF+ByBsvwmVM4yYc9BRnHbSTwQiYYsnOlG0OFJt/9
 9idQvWSVIpmi4TTc7ZLhGY6rvvDaZtY7cBKQrKPNNOunadvUVPuapgkrkKqMAq9Fzj2K
 kX14tX07gDq0AvXh3R/ONyJmPrWCFfDU0H9YgR6oe6m6zX5sL1OSSzr/h4psn/r19Z++
 YVEw==
X-Gm-Message-State: AOJu0YySc6LxkDD3ccwmH4FM9ol5p+Dnkakoz43OeAa6piuqbAPX6lGv
 B9HW1+glnTd2g78/hBIFiP+LSm14wfNeZ8wceymnD1sJcjMf7YGSvmwTEaJivALITKpjKuE0DPv
 YH3NJ/0Ln
X-Gm-Gg: ASbGncttkNeqG4QRIp0w2auBPRWOQgO3J9SO0JH93Ma1fbh7maB/Q3hNc2hHPZQhcfQ
 4AHfnlQRTnyDR2BrwgOO1Raa6CZxpe/aIcpwqjf6ZGWNNycgBEJ1O7xqB7j5F+LC6SpgFJoBbCb
 WiLMyyJ67NFPV5oBjMBMyXRHf1k/Dwm0NrBYNQXcloSpZLIXG1wWgKajQVdSmI0H9yIqqzYJZf8
 xTHYjFqmmz0tw+vethFH/gaZWPRAqqPGmqY3/hDERh/TQaArE3qDSMuXZJ+UyXP
X-Google-Smtp-Source: AGHT+IFqT0VdVm/V0DUG08Ks1YA2WWz390tidaiKjh0s4obZWN/otXf/wF2LQlAwGlpV/zvOGM++oQ==
X-Received: by 2002:a05:6808:15a3:b0:3eb:3d21:9d02 with SMTP id
 5614622812f47-3eccc093886mr1952144b6e.32.1734529408058; 
 Wed, 18 Dec 2024 05:43:28 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 22/24] hw/core/qdev-properties: Constify Property argument
 to object_field_prop_ptr
Date: Wed, 18 Dec 2024 07:42:49 -0600
Message-ID: <20241218134251.4724-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

This logically should have accompanied d36f165d952 which
allowed const Property to be registered.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/qdev-properties.h | 2 +-
 hw/core/qdev-properties.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 3680cd239f..447767688b 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -201,7 +201,7 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
 /* Takes ownership of @values */
 void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values);
 
-void *object_field_prop_ptr(Object *obj, Property *prop);
+void *object_field_prop_ptr(Object *obj, const Property *prop);
 
 void qdev_prop_register_global(GlobalProperty *prop);
 const GlobalProperty *qdev_find_global_prop(Object *obj,
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index a3d49e2020..61929b2865 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -51,7 +51,7 @@ void qdev_prop_allow_set_link_before_realize(const Object *obj,
     }
 }
 
-void *object_field_prop_ptr(Object *obj, Property *prop)
+void *object_field_prop_ptr(Object *obj, const Property *prop)
 {
     void *ptr = obj;
     ptr += prop->offset;
-- 
2.43.0


