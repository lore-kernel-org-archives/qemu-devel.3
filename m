Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B38D58D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFatr-0003za-Q8; Mon, 25 Nov 2024 10:21:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatp-0003y2-Ao
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:17 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatn-0001mE-PS
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:17 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43155abaf0bso42349395e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548074; x=1733152874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u553UREy8BrfaQ1eQJGRMRlQygWldbMBkNQMqilnB1A=;
 b=QGyxGRbKvP9kS3faklCLMlSS9RBfhaLteMl6xOXYLgtwT7R5yhmKZ+hPL5mCNRRjP4
 JFgAVbCdSGsG8gu9c3jwRpaqjIsw2WhqKBkxS2G2UVQR69S5qb+OC0fCMTPKc/v4F5ea
 mDZFSvVvqnHGqXCI/6PicTLzBT+5SJICpZzuqJURYRaboYAC+qij/AFh3O3LdHppUN8l
 ZNHuG6URS0I5nro7DPvyhrlAS1HNfGan04sxnQX7ktg7KZiB0ItA6XUCjpxWDR3tWF3f
 A7jNs3ttxhTpgkgwMVThjfcdW09yzayRdWs+d4tXpqb5xTj64ERHq+GXL+G809dVohjb
 YskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548074; x=1733152874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u553UREy8BrfaQ1eQJGRMRlQygWldbMBkNQMqilnB1A=;
 b=wD3Q+otCe5m5iTUNJrguxVk8IPIvwvAzpUd6ZGchEGtovraqZxDeT4yoZfaodM/UG/
 mzFKCdh+ZP5bRGowp5NFfP7VElOwk+DBsMvYHJ8VTtq10qBIF1KRp6ggSn0Lo1rlRbM5
 QQeC6gCqK8yoSc0E3w16x+TxRZT2xGlRz7Kb20QTrW6dystZXVdJFlt6mz+IS4r8zptB
 V1j57DP4+zfkqmZd+aiJyQYgXPtz9Y4zSO1ulz9VGXyywC4590YyqR9sr/JSav8hmmTl
 3YX4f2u4F5/jy8ox2ye7fS0h74gXjOktMwgPhu7tEOxmJEXVfr/icQevE2j3VoIPU2O0
 ZqGg==
X-Gm-Message-State: AOJu0YzmgzSJ7LrxU/BaiOOGx6OpN4M+pMIrY1MDIlWZ5SWFKpr6RxHU
 LoMe9HKuRjhHISi9eV4bCFBrHN3P6w3BjnG9si9LjvQfRBzi0u+F/oh6HJKG2Ik=
X-Gm-Gg: ASbGncukGhqdqGQEpErEMm/YnrcF3r01+5udaF3lbUVRuSMoBU9i/Ae0nSxYmzS95Qh
 TwNDwe1X1TT9vCTF6fmDwDtiNmiJRiwP3YOutGforh478mQYhaSBeG4GB6p0Qmj9BDdaU+S55AT
 be/8h1kOs5Isk29Nie31BqBQSAi6kXlSyHV6V1D9TpIpQT0XxCqqfjE0zI/J2HtwXUTdaQRBViC
 JlKQAT/s8DTidpZWPJmfchawbIarcuulLwgU91DVnlF4Gxb
X-Google-Smtp-Source: AGHT+IHqER4S1kj95mLNDBKF6qTdGBXKaSnt35oeHHi3bBEhzR/I2JsZekcbVlZlUHz9GZr12gG27w==
X-Received: by 2002:a05:600c:4e91:b0:431:6083:cd38 with SMTP id
 5b1f17b1804b1-433ce417b2amr108505855e9.6.1732548074155; 
 Mon, 25 Nov 2024 07:21:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb30590sm10692523f8f.57.2024.11.25.07.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:10 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E10DE60B68;
 Mon, 25 Nov 2024 15:21:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/28] tests/functional: logs details of console interaction
 operations
Date: Mon, 25 Nov 2024 15:20:49 +0000
Message-Id: <20241125152105.2100395-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

When functional tests go wrong, it will often be related to the console
interaction wait state. By logging the messages that we're looking for,
and data we're about to be sending, it'll be easier to diagnose where
tests are getting stuck.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-13-berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-13-alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index cbabb1ceed..98722a9cf6 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -85,6 +85,9 @@ def _console_interaction(test, success_message, failure_message,
         vm = test.vm
     console = vm.console_file
     console_logger = logging.getLogger('console')
+    test.log.debug(
+        f"Console interaction: success_msg='{success_message}' " +
+        f"failure_msg='{failure_message}' send_string='{send_string}'")
     while True:
         if send_string:
             vm.console_socket.sendall(send_string.encode())
-- 
2.39.5


