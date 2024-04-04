Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F75CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 23:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsWA7-00020y-8j; Thu, 04 Apr 2024 19:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWA1-0001zX-VB
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:24 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsWA0-0007i8-GD
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 19:06:21 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5ce6b5e3c4eso1040187a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 16:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712271979; x=1712876779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=luXE4K25FW6HOCJ1kHOE0xkHZzSsFeoNOQtESvbBF/8=;
 b=Opls4Y9Ccq0Lt//5b2zKi1giZvoVPfiOY+nRza6mvvHei62PfIuulITHPwLruXytvb
 IW6QifxFnHxQR6opToK6IWw4mdLuto8cYcsj9RWoYE7cMUSJ6GFGq5UIim7mCt52saCQ
 VdNbQoK4ZBacnv76gO+NWBJWs19cIyJb+m95KaHbWtp8TUZ+dK+P9suS5gNetFJ/2ft2
 t1ZbHNC3kqkbQC2XdOmwsqMzFAn+Oj1pKK73JpAaHqJLZuBoWdbglphFszIYJh3OcyQ5
 CLbiwxVSyJf8jSDCPYoFgdvew9uAl5NzidI7sk5pNkJiu4p+owlOa1RVDvB9R8JpbjOE
 04pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712271979; x=1712876779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=luXE4K25FW6HOCJ1kHOE0xkHZzSsFeoNOQtESvbBF/8=;
 b=P+yBHgy1dlyAPL5mvvMRWLEjH6STMQSDGYFPKPVvN+3cqzan/UcwngX5qdzaqpTz3k
 DU5ZsmuMroBWe1smbU04Z/6AJtsabV9B11YdNwsxxEBWmRDDQs2PFSi02PW34v3kx0+W
 OVHBl53NjhnaKL3imZoYR3BjJ1RhYuepI1nlp7D8Hymp5QVQAbv1+nB1SWJ98GSfbNwu
 JwpKGjK2uzt/8JQZO7TjywZE/68lEVN/Q9khZmDQSAhd0dsNn+z4UB5IZ8ikxUQJok29
 eIay+t+Ieu/xVorr7zNuJ9SUnKUVMyJgxwclU+Ewglg45sTSCCq5gPvOmu3HpJJLxm87
 kHZA==
X-Gm-Message-State: AOJu0YyuzbQ3sbXyDlXmQKce+bsjqI27b7KZ99BKnC4iQQ/Veb22g71H
 Z8AsjIsY2Oq/Y85DS6PtAUirI94pW8CDKqEQ8bReJLkukOytEPzuzTOCMWIK8GEmyV4OcwvHJnO
 v
X-Google-Smtp-Source: AGHT+IEKxLaWH7IH5//wNamr7fIGcdvfonJfI/txwiSlxWalg54Eufn6njELtiyoaWDefLpJ5ISsBw==
X-Received: by 2002:a17:90a:8a81:b0:2a2:5ec9:3754 with SMTP id
 x1-20020a17090a8a8100b002a25ec93754mr3598172pjn.33.1712271979199; 
 Thu, 04 Apr 2024 16:06:19 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 q36-20020a17090a17a700b002a2f3cfc92asm1052592pja.16.2024.04.04.16.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 16:06:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 04/21] plugins: Zero new qemu_plugin_dyn_cb entries
Date: Thu,  4 Apr 2024 13:05:54 -1000
Message-Id: <20240404230611.21231-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404230611.21231-1-richard.henderson@linaro.org>
References: <20240404230611.21231-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 plugins/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/core.c b/plugins/core.c
index 11ca20e626..4487cb7c48 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -307,7 +307,7 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
     GArray *cbs = *arr;
 
     if (!cbs) {
-        cbs = g_array_sized_new(false, false,
+        cbs = g_array_sized_new(false, true,
                                 sizeof(struct qemu_plugin_dyn_cb), 1);
         *arr = cbs;
     }
-- 
2.34.1


