Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3EBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSHf-0000hm-FT; Mon, 29 Jul 2024 11:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSHe-0000eG-J2
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:27:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSHb-0008Et-J0
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:27:34 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-427ffae0b91so23132135e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266850; x=1722871650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X07qTbL83zQOZhtssmu4m+yBs6p/aBS1K1qhIZAMOfc=;
 b=FejViZJrSDngSBRkiDR5RMhQ84XQHu8SdLms30SqjbdN9hANIlCAxQR/6PWaRnpWeD
 sggY/ClXqEjk94t8jlkyaJwalj6OY6c4vn9W4WWF0ZPaUWFGVfEjb4ijeHkvWc9CcO2i
 zSTmYVNnIxo/P/HYb6hA9Gs3kxD5WI6/ttVDoG8lJ980ljo94y94SQU3zi2LPFAQo8l4
 9k+h4hdpig26qY9pfXADnzXa04UJJ1TqrlGK/t/mNsyZRnniBfhbAhEDyYvGOcbERbSF
 PLx0cMZ5EuyR/8uyBRFWsZA4jLhN4f3/XfZjRAPZ9uveaqEGlFTaG/IiHLLaJnhk8ttZ
 aqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266850; x=1722871650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X07qTbL83zQOZhtssmu4m+yBs6p/aBS1K1qhIZAMOfc=;
 b=Fg/glw4MS3IxdJTuCAdP0q1KSmLLpPD+Ou+++/D3vTGYmMSZZ4C/nsKrsQtgE81FXe
 u8AoJf0ATHsvX4Bjv0VbjZxCzJh80F96JrNBux5RnYdoDH1liolMSgbKYZi4LwOopxuy
 p6rJ1K/YhtDrP/2SiKYJ8JItZlFxpYSDtdHm2toUdqJ7gNLQN9G7d2k5dS1umVHrWoJ5
 Ph3TrEwBprYFggFdlKpLfgSTLxeyR4Nz3krxcmpY0DWnZAnR0EjzSdqKrxRP5TSbptIE
 gOKYaewI0XchyUtFuqhgB8GfMV3zTlg1sw5ANTz7K6Pr9NBV7UMHSZhnssBSw06fSJG6
 cKQg==
X-Gm-Message-State: AOJu0YzfKquJz3K07678IXDfbpAGku7D5LgGyp/XiTnENWEsjqy2K7SK
 N5AQ6sz63XfY7/q0s3G3muTQ0j8HqVl532n/B0IMw/ogNDk0nw5i7V3z2vmOENfd8EANkCJLB+H
 b
X-Google-Smtp-Source: AGHT+IGO21+j3xAf5g1EFviOS/I4pXKtc1jgfOYi0YHS5yJPU2ag9DvRxonL4TwX48/7JVhPsIQ2kA==
X-Received: by 2002:a05:600c:4e90:b0:426:59d3:8cae with SMTP id
 5b1f17b1804b1-42811d8c44amr68772135e9.13.1722266849481; 
 Mon, 29 Jul 2024 08:27:29 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428068cda0csm175854995e9.47.2024.07.29.08.27.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jul 2024 08:27:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/14] docs/sphinx/depfile.py: Handle env.doc2path() returning
 a Path not a str
Date: Mon, 29 Jul 2024 17:27:02 +0200
Message-ID: <20240729152714.10225-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729152714.10225-1-philmd@linaro.org>
References: <20240729152714.10225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In newer versions of Sphinx the env.doc2path() API is going to change
to return a Path object rather than a str. This was originally visible
in Sphinx 8.0.0rc1, but has been rolled back for the final 8.0.0
release. However it will probably emit a deprecation warning and is
likely to change for good in 9.0:
  https://github.com/sphinx-doc/sphinx/issues/12686

Our use in depfile.py assumes a str, and if it is passed a Path
it will fall over:
 Handler <function write_depfile at 0x77a1775ff560> for event 'build-finished' threw an exception (exception: unsupported operand type(s) for +: 'PosixPath' and 'str')

Wrapping the env.doc2path() call in str() will coerce a Path object
to the str we expect, and have no effect in older Sphinx versions
that do return a str.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2458
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240729120533.2486427-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/sphinx/depfile.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/sphinx/depfile.py b/docs/sphinx/depfile.py
index afdcbcec6e..e74be6af98 100644
--- a/docs/sphinx/depfile.py
+++ b/docs/sphinx/depfile.py
@@ -19,7 +19,7 @@
 
 def get_infiles(env):
     for x in env.found_docs:
-        yield env.doc2path(x)
+        yield str(env.doc2path(x))
         yield from ((os.path.join(env.srcdir, dep)
                     for dep in env.dependencies[x]))
     for mod in sys.modules.values():
-- 
2.45.2


