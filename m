Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B944EC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:03:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIec-0005N3-5T; Wed, 28 Feb 2024 07:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeR-0004ql-Ku
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:09 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIeO-000361-Sa
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:03:07 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412b434effaso3787155e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121783; x=1709726583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LrGWCpGE1wAXQ1EpZJv0VK14aG5z8id0pl8bqptEn7w=;
 b=QhluJfGh0dSDcVpc3ccYVXEReYSjjMqjoisF9vbMkRkM/gEMShXNEF8bgHKTRs1Q4Y
 CWzNk1Jui5f8YQDisKXTU7Y0AzJDkakQAX0gL8mxiSkrrrk9v6WvXQwuelNm3W3qLFyT
 AdVWxL89WsOipk7FtMlR/zNefb6EgHjkczK3lokN10tckqBksP/J96Orcj8qNXBKelkf
 c2LzMGK8TQEkKVipoi62DALYEljd/0KPc0EJe/HzFMFb17ylRNlJOOo2C4f0wj3NuHSC
 9s5TD1tQwxThzna9I1iiZiajnDNdZFI18WQOR+VBNf54zU7GdsJkCWn7B10BwQ/YvIlZ
 Oumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121783; x=1709726583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LrGWCpGE1wAXQ1EpZJv0VK14aG5z8id0pl8bqptEn7w=;
 b=kaYcc0foHxRDAtq7XROXsP2Rubwx3/RpYvrrOt7ZnGIfyj+PyxS6Sr60JQAaw9ykEs
 DXdqQnf+CUb5Q6pdlDr8ob41EgL/8LPuloa3x9jh7zsvxKkFVl6V1YcBWXceOyH14NcY
 kssG9QNM7Wcudim1wWP09Uy6/LRk9tTMlN+XzLfvmGThc1NqD1zsHN5GDTuCoMl1yMpN
 xsxMBO0zhgUnFyvKBJlrgXDm2bZtznOTN8BctIGG0VfwfHWMnYIQcXE5Sax4yP3siIIT
 pXVRO0Gf0vgtukEwJmNXqkW/9zvq1bzzwaVW30JhueaiVmXJwO3p3Ijz9CmhrdxEfw//
 ZrKQ==
X-Gm-Message-State: AOJu0YzK3r/fBAqMikH93eHIjbv9y+bBYiG/wKjTKKWVDSffcFHaCk4X
 3x249NfRw/0ETBD8cKpa4rHGNbme1E5PTqw3+M0XsLeB2/4UwLVOkrpuKe/wfho=
X-Google-Smtp-Source: AGHT+IE7A6TmrrcqiD8PtUWkCNJgDnf+IPkugDDwcKK20pPE6IkNkK6VmeoHwSTiuxo7jMwmiyCx8Q==
X-Received: by 2002:a05:600c:3b84:b0:412:b53f:99e4 with SMTP id
 n4-20020a05600c3b8400b00412b53f99e4mr782387wms.40.1709121783177; 
 Wed, 28 Feb 2024 04:03:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z13-20020a1c4c0d000000b00412b390362asm1851564wmf.17.2024.02.28.04.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 04:02:59 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7B4A75F92E;
 Wed, 28 Feb 2024 11:57:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 27/29] docs/devel: lift example and plugin API sections up
Date: Wed, 28 Feb 2024 11:56:59 +0000
Message-Id: <20240228115701.1416107-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

This makes them a bit more visible in the TCG emulation menu rather
than hiding them away bellow the ToC limit.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-28-alex.bennee@linaro.org>

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index fa7421279f5..535a74684c5 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -143,7 +143,7 @@ requested. The plugin isn't completely uninstalled until the safe work
 has executed while all vCPUs are quiescent.
 
 Example Plugins
----------------
+===============
 
 There are a number of plugins included with QEMU and you are
 encouraged to contribute your own plugins plugins upstream. There is a
@@ -591,8 +591,8 @@ The plugin has a number of arguments, all of them are optional:
   configuration arguments implies ``l2=on``.
   (default: N = 2097152 (2MB), B = 64, A = 16)
 
-API
----
+Plugin API
+==========
 
 The following API is generated from the inline documentation in
 ``include/qemu/qemu-plugin.h``. Please ensure any updates to the API
-- 
2.39.2


