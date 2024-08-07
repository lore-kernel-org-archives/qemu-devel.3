Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA29FC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 11:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbf2c-0006Nf-OP; Wed, 07 Aug 2024 07:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbf2Y-000662-9P
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:41:14 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sbf2Q-0003AV-80
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 07:41:12 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-530c2e5f4feso1726978e87.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 04:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723030863; x=1723635663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NIuSypWDg9XREmCR8A6U0uVblD/PqIkJ2Iws02lA4d8=;
 b=DTpmJ2C2wtL6DIGpH5+aapz+6yZMvVdJtLMMK2+d1UKX5UHF6z86vdIdvNEd46X60c
 sugYAq3km6i5M/fV5FcDU/nGwe+Jr45Y3LuraIn83Rc6Ku0DUo0PCz9gDMX9KFqdM2PH
 FZ+/yBVHnRIk1sSSMXzE/Mfvfg8YZPW6xes8/Iw+XUyfjFx0pB4/FpgW1yaKc1V+b6TZ
 2D35gdk0p9xjRsmRgtnloppCsG7ZRCjYIosYVGPC4kTZPXAyvR/9nBssicAP4+bwN3ev
 ECWHx5uMqNiDRb50IOJW1agsqllZ9r8bQFegXJGVObis82ihuphDlGBbrOUCqnREYTBA
 u2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723030863; x=1723635663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NIuSypWDg9XREmCR8A6U0uVblD/PqIkJ2Iws02lA4d8=;
 b=YA2yacBUxP4XVMARhyDbejsxmFeQAR0mIpqnSOdYfyn3uB9WKltUM9aXuJvkKUO8Ve
 xVXaWmDIH6PCctg/GB0vXuBZo+V8WIAMH7EJwTlJ4C4PkzmThVOPGJhWMP0KO5z1K6j/
 HxUYPGHAP2MRF3i1LFLWuPc84HEjqSAJm4JJ1zGpVvv2ztr1mlbbKt7YQtcz4cinwSVX
 DuTBeeGn594KrBVfxMgo0jpc+tzzLe4CwbBSPKGxuiYaJl3M7A8sXoDfoOCCQYt09GUS
 nVzeNzYnAAynCKaq5impsbvY8C3kuv/7z2f7jFsRdu6aUe/4GkkC+YWMTqc/RHAwkj45
 ne1w==
X-Gm-Message-State: AOJu0Yy3aiIoFSWQz2ULk5HHYweHFhbO7R4+xYbEOgrT7CswMmpfgXrx
 2wrVBCclB3Z5NqoAwunavHiBzZJAxkB8MP4PYF68ZGVXVvsbNn7Gy5ORVAFok38=
X-Google-Smtp-Source: AGHT+IEAkPcegYL7qZbgKzviMSOfeP+HNgfUJLPPcdlpaWw4tbtZ8EFM+49OGoV0U77RtQYWRC8neg==
X-Received: by 2002:a05:6512:3c94:b0:52e:97b3:42a1 with SMTP id
 2adb3069b0e04-530bb378859mr13292253e87.24.1723030862663; 
 Wed, 07 Aug 2024 04:41:02 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83960f313sm6951570a12.17.2024.08.07.04.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 04:41:01 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 02FB65F929;
 Wed,  7 Aug 2024 12:41:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 1/6] tests/avocado: Re-enable gdbsim-r5f562n8 testing U-Boot
Date: Wed,  7 Aug 2024 12:40:54 +0100
Message-Id: <20240807114059.2339021-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240807114059.2339021-1-alex.bennee@linaro.org>
References: <20240807114059.2339021-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We disabled all RX tests on commit 9b45cc9931 ("docs/devel:
rationalise unstable gitlab tests under FLAKY_TESTS") for
being flaky. However I don't recall the U-Boot test to fail
(the problematic line checking the 'version' string is already
commented out), and I'm running this test reliably, so re-enable
it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20240801172332.65701-1-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/machine_rx_gdbsim.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/avocado/machine_rx_gdbsim.py b/tests/avocado/machine_rx_gdbsim.py
index 412a7a5089..a83873b738 100644
--- a/tests/avocado/machine_rx_gdbsim.py
+++ b/tests/avocado/machine_rx_gdbsim.py
@@ -22,8 +22,6 @@ class RxGdbSimMachine(QemuSystemTest):
     timeout = 30
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-
     def test_uboot(self):
         """
         U-Boot and checks that the console is operational.
-- 
2.39.2


