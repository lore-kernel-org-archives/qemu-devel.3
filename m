Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438BCC10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzldL-0003h8-IM; Wed, 24 Apr 2024 19:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldJ-0003fz-JD
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:33 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzldH-0002cZ-Q1
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:02:32 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ed2dc03df6so424223b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713999750; x=1714604550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=luXE4K25FW6HOCJ1kHOE0xkHZzSsFeoNOQtESvbBF/8=;
 b=kCWe/70P0yUgs4cU1sCjBT8ddpGJ4cuFGGRoTzqhObE/HXBOaRGH1YXvtU9l1CcVZR
 uxVULAE8JsBCgGPQW5ZfO2oSbd0vgRvDS8P9ZncG88U3jHNVMjngQcOQ/dheFuQMwo05
 ySBRw6p81XH7zPLgqXT/40bcdXyrxk0QVSJl8jPk8c9m8NjedHzwvi1eIIlMJk7CwAXn
 Ssj3EvS+oZ3xgl8dzpLqsNKlItLgd6k29UM2ovSVTulu1E6psJ3JNssnO3GWcOfTx9B2
 /C8oeqtgkMw1C/NBkCAWtwENXlmyZKSwvlRkgaS2Qv3EonFSDkybB2iXlQOy5YFhm/7f
 QPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713999750; x=1714604550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=luXE4K25FW6HOCJ1kHOE0xkHZzSsFeoNOQtESvbBF/8=;
 b=sHIP2RjAxJf2BGpy6qTMNFntBKxWn/eSNOnHb9k5nGdao6DAarUGW3MRIhAhF51Ohr
 CmkBT0fBxND23DuZR0p7u4D73n5izDVRXAlpvOhL5yntdhELIo6w51ztqKdub53TkSCr
 d0qDxqi/PsTnSM2cEWhwRlfwExXxwny5J4dVgOHcoXKHuebPIaumPWbyzvwbJivBVnJ5
 w36kNHw+WRgnu+yXGt5YTTSQAYJqriocH1aG0JYQRR5797VwlV6YExc8s/hzfFfQG3KF
 2vubqqOqDTyHLtUCWhDgiOMlqOUSfFBAq3xPaOewbP3gE4RnLz1agQZEYruLvZYlDo2k
 RWxQ==
X-Gm-Message-State: AOJu0YwNEeicrtqwMU8MitYOFcpwlnTJWbfu+Eqvj809PgHXD+xR/uxS
 Xl5iTSQ+PauiiEtATY/v/xn0wwSbw0fMqSP1hHBwmulba4uJZWGv/Mme/sM6o2MZHMNq/kBp6yE
 r
X-Google-Smtp-Source: AGHT+IELpJV9fX+N6Hfailu+PuSucYZE9zOfTsrqldiy9ASLMMwR9oDf0BVamrLXyrt7J+ceCNsM/Q==
X-Received: by 2002:a05:6a00:cd5:b0:6ea:e2d2:5e68 with SMTP id
 b21-20020a056a000cd500b006eae2d25e68mr5349618pfv.27.1713999749995; 
 Wed, 24 Apr 2024 16:02:29 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h5-20020a056a00000500b006ed4aa9d5c0sm11981405pfk.188.2024.04.24.16.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:02:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 03/20] plugins: Zero new qemu_plugin_dyn_cb entries
Date: Wed, 24 Apr 2024 16:02:07 -0700
Message-Id: <20240424230224.941028-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424230224.941028-1-richard.henderson@linaro.org>
References: <20240424230224.941028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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


