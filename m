Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9608D58D5D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFatq-0003zI-Vj; Mon, 25 Nov 2024 10:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFato-0003xJ-GR
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:16 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatm-0001lj-TH
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:16 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3824038142aso3011698f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548073; x=1733152873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=75aAdTQGB89uDYpLUkbXQ/KFedluLHMzOUSJGMjOfUE=;
 b=kn5/qhN8pJWzefUOE9B3+IyswA0MsfWgGORUJ/BJJiYcYNhdwgPPDEEefJ4yQL5B7q
 AMZqxk9o5p59UAQ9c2cJSE+t0HhaFzoSH+QfYRI70Wtbo24ptk5AmTXitGW/N3TnNo3H
 blNRpB0noIYERyJoZ+qVYxgd/H0CUoj+YBpqmfjcVHbeUsSQGKP0xbggDFk2RBRQ4L/X
 95sxTb1B5AhxVPO6FxELAFnzPa6gAjb3dhDa3VHBPn5z/HUBLAZXygXRBF2hqLoUtqKc
 HZp0J5cqb8q6FUxECddqW/AnQIeQob+LuSO31AI1ORM7t7BOuVEvXVWQARJyXhStvDU7
 RB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548073; x=1733152873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=75aAdTQGB89uDYpLUkbXQ/KFedluLHMzOUSJGMjOfUE=;
 b=O/go3Y3RHSaLUndadbYeoZFcYcQyBreY3NLmxofbhyMb3BrzlD1PUUFMxZeadKtMLq
 J07ZCs08JukphH4HHM5jXONG5ZS7kWMwYD0mvSr2bRg/qNS/VahUDysha4sk9NjZ88Pe
 dbKkH14j/4HCXN8HGkJCUEJbxvdtpjPBZIP0oQbOKgYrKvS4MooaJAwYqs/6TEHMGabK
 XkAgqAM5p8ms3cGXOHU3o8/bbVfcC0wBEltLvnKRIpoVWNH2Hf+F3S/Ii9BW4mbh3HYm
 nSbRr5WiyYR252FSoyEC+xnfzPanfqPv/RSdQTzgSlbVlu3g3G9rne7o3wrVZE0aHNyc
 ls6w==
X-Gm-Message-State: AOJu0Yz0KmZmWoS7IbKQ+WQ7jhzOhVMA11nyFUd//IWRo+F+enI9DbJi
 kuxTwgrfhHF5xUDFW686tgPrszNIovEdqwmJuRYU7fInMBQBqP+6Hu9XSQEaezI=
X-Gm-Gg: ASbGnct1qH98hHF0NjpD9N5VucE7h3kR4Au9kkTZpTLggGjaa/km7cE3cK2So9PtJjt
 gKtFggEFf2xEmSN5iap45A7uxyxuUTI3sYtTK2TGu57WveUzqOQmMuxRi1mJjguqUKCckEO+v8P
 kKnIayrD99kT8UiD4HDVnXJrdSuE/8AkHJGpH0ZdyPJ6Q0WPdLhtJImzOpZgzOz2zodqQLJZ18B
 tWNDzMQq/hRoXYZ2YA85Nz/elz9UFAEr3tIRbFzTgq1PCmw
X-Google-Smtp-Source: AGHT+IE7q3edF5KizPAMTnUHFCjhnm4T7xPP5lob2NDTxOFeNh308FMQ2g8W2AXghjZmkK74livIrQ==
X-Received: by 2002:a5d:6da7:0:b0:382:4926:98fa with SMTP id
 ffacd0b85a97d-38260bccdf8mr10429308f8f.40.1732548073107; 
 Mon, 25 Nov 2024 07:21:13 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b01e1188sm202319975e9.1.2024.11.25.07.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:09 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CB8C060B5A;
 Mon, 25 Nov 2024 15:21:06 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/28] tests/functional: enable debug logging for QEMUMachine
Date: Mon, 25 Nov 2024 15:20:48 +0000
Message-Id: <20241125152105.2100395-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Set the 'qemu.machine' logger to 'DEBUG' level, to ensure we see log
messages related to the QEMUMachine class. Most importantly this
ensures we capture the full QEMU command line args for instances we
spawn.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-12-berrange@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20241121165806.476008-12-alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index f9c9de1166..e2a329c3e5 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -57,9 +57,15 @@ def setUp(self, bin_prefix):
         self._log_fh.setFormatter(fileFormatter)
         self.log.addHandler(self._log_fh)
 
+        # Capture QEMUMachine logging
+        self.machinelog = logging.getLogger('qemu.machine')
+        self.machinelog.setLevel(logging.DEBUG)
+        self.machinelog.addHandler(self._log_fh)
+
     def tearDown(self):
         if "QEMU_TEST_KEEP_SCRATCH" not in os.environ:
             shutil.rmtree(self.workdir)
+        self.machinelog.removeHandler(self._log_fh)
         self.log.removeHandler(self._log_fh)
 
     def main():
-- 
2.39.5


