Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50125C3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpcf-0008Sc-OH; Tue, 30 Jul 2024 12:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcd-0008K9-Ks
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:47 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcb-0003Xm-Vh
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:47 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52f04c29588so8630818e87.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722356564; x=1722961364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D5h3hA9rJCoPrXhXtX9PMhPKr74TW2tQR0MpOfcAcjo=;
 b=FcjYqtiha3YmnN3ZoHHlFU1tVyWvoHfx8Ng7aAyfd6rk/EDJa4sSSmtyYDKUbXNBCy
 syC54lqTbKEDvmnbZv6bpVOFJLXt2RMnBoUhetB89hBndwWRkqnyArbCviLMibHdvu6m
 eT91K4znIjNFi80WGfzlhZo7/ciZuD5q0bMKOkhyvLaE13yKPy384l5Wp9GVTgzGnoCQ
 k6iKwAh2UrZAZP3LpXNPk+klU1CV/XYtd1hZzeMQRjsbEZ881HD02ioJPo8U+LIl27jp
 xO7XuqtMFUmOr9/kYWnHq7JaxAFNSN6ZcfHkBxLnzFVr6R51hPk9v6mFA+g5njYGZ5yn
 rjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722356564; x=1722961364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D5h3hA9rJCoPrXhXtX9PMhPKr74TW2tQR0MpOfcAcjo=;
 b=pdo+zSbslSIEvEJtHXnZiw8EJTz8frv5+tUdfwrFdxjh+ZNA7GVnL+A85uj5IFCKgc
 avDawBlYPQWyAaLe1OuM4cbF723K1kY3a7+ipdqnFv0D25qoJNn9CBk5yKUd5gxuWiX6
 gAHFYD7TvXe8CoTgn4FYD0z/K0R4RakYeBQcKNF+rFs9mqct/Q+oAbjZDwXFZ+a1IXzR
 t0TsPwMJAcELd+U0Jwl/RG//sf+J6UfJbGA3S2Ocsy44xNDncAEDHFOpRd49hGkO50B2
 UHJW6qHb+9uo+ysxE7altZtN+Z+AEKce4mvuCZEISRpfqc8GwFKcQq1LFlIWuhgUSxqH
 PVkA==
X-Gm-Message-State: AOJu0YxImOyrWXl3YoneXFrXrg9TaLBaJSntLCFUzmcrVZQb2pxpF9po
 +E9AySKANzkiraVoO7s+RrpmOC0qM5Saab+Pw1J5Kh1BN8y0HX7GDsVG5SmJRJY=
X-Google-Smtp-Source: AGHT+IEkGhkZUMmuVnhbHlHFnM8S4j5Crjw55lnORY7DKtdmh0BHS2zcfPVdpCuXNYzPdUprZm16xg==
X-Received: by 2002:ac2:4f09:0:b0:530:ab86:3 with SMTP id
 2adb3069b0e04-530ab8602a2mr1700605e87.1.1722356563626; 
 Tue, 30 Jul 2024 09:22:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad90e34sm662539466b.164.2024.07.30.09.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:22:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7B3325F9CC;
 Tue, 30 Jul 2024 17:22:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 07/14] docs/devel: document how to run individual TCG tests
Date: Tue, 30 Jul 2024 17:22:30 +0100
Message-Id: <20240730162237.1425515-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730162237.1425515-1-alex.bennee@linaro.org>
References: <20240730162237.1425515-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x130.google.com
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

Since 6f6ca067d2 (tests/tcg: add some help output for running
individual tests) we made it easier to run individual tests for a
given architecture. Lets reference that in the developer
documentation.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240729144414.830369-8-alex.bennee@linaro.org>

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index b984c5dd26..af73d3d64f 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -1490,6 +1490,19 @@ And run with::
 Adding ``V=1`` to the invocation will show the details of how to
 invoke QEMU for the test which is useful for debugging tests.
 
+Running individual tests
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Tests can also be run directly from the test build directory. If you
+run ``make help`` from the test build directory you will get a list of
+all the tests that can be run. Please note that same binaries are used
+in multiple tests, for example::
+
+  make run-plugin-test-mmap-with-libinline.so
+
+will run the mmap test with the ``libinline.so`` TCG plugin. The
+gdbstub tests also re-use the test binaries but while exercising gdb.
+
 TCG test dependencies
 ~~~~~~~~~~~~~~~~~~~~~
 
-- 
2.39.2


