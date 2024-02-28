Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C82F4C54E49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIYh-0005hS-TJ; Wed, 28 Feb 2024 06:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIYf-0005es-Ip
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:09 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIYb-0005hg-MQ
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:09 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-412b434effaso3737105e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121423; x=1709726223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BHV/xSviQ+mksdG51pmI4mQIX2turcSeLOZCoK5M7sg=;
 b=l9S9IMzDxy9+OL3L2W3b1aoEzV9VAVdh95fQotjqCEpPN5jwA1e7cMgJ+X7AkVq6c0
 IU3hQNS4HyHpssItGBRPsmh2M+lHVDHYRFKKPJi8KumDq15YzqIuwxdgaoc6VKBsOOlh
 4edpedVAZMdKHT5vMQVKlP70B1CrxvmkXTRVIycKdKS0hlKKnmTrqXXccU3AwjoyMWba
 08JqXhfgyK4OkhyXuprb4NUhmS7xUqMcCkQJnaHcN9cyTkFtPjiqxqMEHwIzmpTuZ1QL
 0hR1mEeR0h4ixhi2Zo9OKPYoP3DUGD/CfscTtseS+uH9GR2g/Nox4Q0msx1Dw0wcuVp3
 H/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121423; x=1709726223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BHV/xSviQ+mksdG51pmI4mQIX2turcSeLOZCoK5M7sg=;
 b=QwsWXRZW5yt1GkMa5WMWYBxOdpvTzA+O376/ERU10O30bL+dhNV8ewKjvDKXkAk1Oq
 2enEPC0AU62JisG8RE6lwQrqArv4WeJF9A9fh/cZvJdhr86zFustwwtFsMrId29ncIKM
 HSG6p7rfXThsDQXsYojT/NFlMEl/IhyirbaDJsqncTcg3a653uW5rqtUq4ELVup121zN
 yy7qLW8RMliq7Lmdr3u9v2oMcRjrcYcJgbeff1MDW6V2KfDfOHH60NYGo7q8lHLTlT+Z
 YAqUPWy4K0ZHSTKGJdnsWZTm70zPnBKBTdoPre414XAP9nl7IZKJEIkiQpLHNT3MRaIS
 Fh5Q==
X-Gm-Message-State: AOJu0YwkVrhiAgVCD2gH5L4J/8uQtXSfojnAQGKCyBTjdTMXIr5aTcOe
 +7GlS4N7kV9ayqHQ/pPqfBMFTsOxk5O0/OqpIwJle8L4h+3TDw27MVq8CejXius=
X-Google-Smtp-Source: AGHT+IH3KWBdhpampjnJ11TdGZH3IuZIrJPtwksjMveiXG0eEX0zFV7ifrNUq/WTdlz6c8n5bXgKTA==
X-Received: by 2002:a5d:4fd2:0:b0:33c:dd02:f652 with SMTP id
 h18-20020a5d4fd2000000b0033cdd02f652mr9238497wrw.10.1709121423348; 
 Wed, 28 Feb 2024 03:57:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f14-20020adff98e000000b0033cf60e268fsm14397650wrr.116.2024.02.28.03.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:57:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1A0B25F8F7;
 Wed, 28 Feb 2024 11:57:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/29] tests/tcg: bump TCG test timeout to 120s
Date: Wed, 28 Feb 2024 11:56:34 +0000
Message-Id: <20240228115701.1416107-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

This is less than ideal but easier than making sure we get all the
iterations of the memory test. Update the comment accordingly.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-3-alex.bennee@linaro.org>

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 8cf65f68dd8..a4c25908fb7 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -93,12 +93,9 @@ QEMU_OPTS=
 
 
 # If TCG debugging, or TCI is enabled things are a lot slower
-# ??? Makefile no longer has any indication that TCI is enabled,
-# but for the record:
-#   15s    original default
-#   60s    with --enable-debug
-#   90s    with --enable-tcg-interpreter
-TIMEOUT=90
+# so we have to set our timeout for that. The current worst case
+# offender is the system memory test running under TCI.
+TIMEOUT=120
 
 ifeq ($(filter %-softmmu, $(TARGET)),)
 # The order we include is important. We include multiarch first and
-- 
2.39.2


