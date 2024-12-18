Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F241BE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuKb-0001Km-0o; Wed, 18 Dec 2024 08:43:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKS-0001IU-Nh
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:08 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKQ-0005en-Un
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:08 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3eb6b16f1a0so2044367b6e.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529385; x=1735134185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Da/WqYqvOtbbG4N3/jUJ/9lxe1TiWeaeAujQBtwkcw=;
 b=uXGzIsfr7tWaBj+TNfw+lh70w/pNi8mD6N3XxbAG30fg37U+eQW56iVQfb3nzhqm/6
 0B/AQ0MUAvL+4V8kbsA2yuG4Fw2MkiGTP4uTRlauIyssV8aXVK12TEDCP0jK1VLkTRKw
 z7f52qIPTuOxzY8jAw8gbRBSp+cDBWdACvrwOTbPgxWN1wPZfd9z+QfVcsSEgGmSAIvo
 BCcT4UJBjkX3z9BzyqWQriBO4MIBkQcJgAgKgHqMSrJS4qYEEjjI/07W9xcK7UL0RoQv
 eQzQS1SitoI8aojaMe2bFjcrFUIlRgq49qB6Yh9lg9UYcR0aGgXlDdpvROgw5OGlB9h5
 hOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529385; x=1735134185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Da/WqYqvOtbbG4N3/jUJ/9lxe1TiWeaeAujQBtwkcw=;
 b=Njgn/THfszBvWU2/LUOtcI61/ZJz3RGzs8I1Q0NUm95OaOXavn1JoakgUqUHrvY/TH
 eJt7eDUpiEQXy4HgI3Bx8sZd7NCOfva37cTXxPf/7GOe9hLyoZ6+OpBkky9vF8L65z+z
 yXhGRhWTyqRx6M02Tb9iSE20K5b0Dn4wRBNgo8dPp8HZ/KE8TC8t35GvOa8rQ/BctYJA
 7mbEnKdzY/kpvvirZVbgr+uVmuvwWIKUf0RmuX2xFN0beDzfpWgmzNp5rOhG+6AcVIjC
 t1cQ4jqeUA26Q6/eTaMRQR1IzoTpU/AeHOfGxk6yHw/PchdwMMeNjmQfys+t2k6Ksejp
 qQng==
X-Gm-Message-State: AOJu0Yyp/VTkav0bWyP08RGrgMlGwlYesNEomD8rM3vTHmYGFBt9+lD2
 76p4vSH1Aot/1i8/035hnl1p/4Gsr76UyULc4MFDLqtX+6GzWlBnJRhHTxNhSlet2QohA2OSDXT
 +wa2Uep8g
X-Gm-Gg: ASbGncuGjAldx3Yvb3yOoWdCiGLYD5LbNbDHmPz33ZwE6TaC65jaow2I4nJJQouRHnV
 OGUA2AgoYpnzhSxzaK6LE2UlVf5gqXPcekqDK9ZNQCl89vduKRIlo6tznfbBp61G6s43/hWqXNP
 Lxt0p4HMYOAqCWU5nbomE2pzFpz/FtcoSi95tJEP974GsJFjXUXZ96Nbm+DtrQcAPY2270qQ893
 MqGE+sJg/P6YHeILqb0PKGGNB2E6yvwEupXtsFXnhVV/n7HaptmjR3LIcqRXrLt
X-Google-Smtp-Source: AGHT+IFQFJYPMZAWOGxOyyW9orQ2xVkaN6hE0kMa1De2Hn9KH5R8+mN0FLNKqZm0ndIdIYPmY1n3Pw==
X-Received: by 2002:a05:6808:4494:b0:3e9:1750:426d with SMTP id
 5614622812f47-3eccbf5450bmr1837066b6e.13.1734529384666; 
 Wed, 18 Dec 2024 05:43:04 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 08/24] hw/s390x: Remove empty Property lists
Date: Wed, 18 Dec 2024 07:42:35 -0600
Message-ID: <20241218134251.4724-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/s390x/3270-ccw.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
index 69e6783ade..3a8930dfd1 100644
--- a/hw/s390x/3270-ccw.c
+++ b/hw/s390x/3270-ccw.c
@@ -150,15 +150,10 @@ out_err:
     g_free(sch);
 }
 
-static Property emulated_ccw_3270_properties[] = {
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void emulated_ccw_3270_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, emulated_ccw_3270_properties);
     dc->realize = emulated_ccw_3270_realize;
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
-- 
2.43.0


