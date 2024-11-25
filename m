Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B32CD58D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFatw-000432-0E; Mon, 25 Nov 2024 10:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatr-0003zb-Du
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:19 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatp-0001mz-NK
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:19 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3822ba3cdbcso2844996f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548076; x=1733152876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTSgqyxDsK0Oo0m3pWRtTEQfgAp9aCc6vBTDVarFPdg=;
 b=ZbDwWsNvDXx/EO+4d/LZVF2EMpBUvtVfX5k/1/k8jLpXfqOwatKjd81WBGAAkl4RDR
 LruPgLbtpkHCHdA3bLo8VMZOgOEHd14dtAI6qgm2ad8+7GXcqf8lj+SEzdPBDfRFwR74
 Vjoz2PiiufDNnULcqAaD2n3PPnreSy3jHu3Rwu8C6jPxuIq7QR7WBDmjKaW03YFZisXV
 8E3mNdVRKWcnzehwgKyVM7c6cDIVv3pWKfS5kZvl9nJwYVTFKkrN5xO93ZcxB1iiqJEs
 r85O+KFK2lpwT4HzO2/swuw9ahV+XzXSiRze2RaAu4+pgHeFG7nRU5fLNdko0Z5VqKAo
 gbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548076; x=1733152876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xTSgqyxDsK0Oo0m3pWRtTEQfgAp9aCc6vBTDVarFPdg=;
 b=Fl1iKz2rCBXSgdmvOs7x8pUOuXGyMlVYfCPx1La3T3uCT460VDMqaJr0eJCtb6TPAc
 pIltzfbAQUh+/utrqRsrXCdK12gyD7fcI5dbETyun6PJU6G1PRQgqSiZEa61+LpE9pDI
 tE0SlNebm2+8AzN6yVCFxOxzuytcRkj/s70ODOzlVnglD6ICysucrwF3C3VAwdBOMz25
 HQVkQno4VJwEptw63VzFLjFLuFf5IZ13FmdnxvJIuXkQnp4WxtTJDkGo9m2FvStpoHjl
 Mn0lKIR7Z1gwUC/U0HefZmiMZVJnEkNPCWajAS2PRLoo+dydkvZL3sHsbuenmVPL8Fd6
 MPCQ==
X-Gm-Message-State: AOJu0YydMfUXQhuoTU3XOzNQMpm9emZJ/y11etpe+O3BALYYYHqHsAVq
 yTkZkzpSYlYC2CrvkSg8LvLRrsRMp/UsEGy/779XpB1Xab5sN5YjIO/IJmH6deM=
X-Gm-Gg: ASbGncvTmYxqJMp3uaa0QLgOiCrIdXXBttA90bDhiMiLEHOWyROTTONbYRaIsttbQml
 96fpJdAr/Qc7x46ySAUiVxkLXcoyQXcnXXb+J0Drszzz/Sdk++2FDdT0MC+K5g0W1yUjpSxE3U7
 y3DdeaA/0thqr0hnHghs5fo/s3cNjMmnDUwKQLPvRhtfASdWiNmcA10/hoQ6o3TKHwSxRDKO5P2
 lTxi2spIr1sdL5fFyzuZT/8JxmMcCbkUEFmpAXz6SrDxZvL
X-Google-Smtp-Source: AGHT+IEG0zIqaOlFy68rp/k6386Hc7lJsMMHijoofJHfFGo5MCvZvb7KVO6F176TIf37mrTGvKIq4Q==
X-Received: by 2002:a05:6000:4910:b0:382:50a7:beef with SMTP id
 ffacd0b85a97d-38260b6cc86mr11938162f8f.24.1732548076243; 
 Mon, 25 Nov 2024 07:21:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349e47f3d1sm51561925e9.17.2024.11.25.07.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:13 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 17D2560B84;
 Mon, 25 Nov 2024 15:21:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/28] tests/functional: require non-NULL success_message for
 console wait
Date: Mon, 25 Nov 2024 15:20:51 +0000
Message-Id: <20241125152105.2100395-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

When waiting for expected output, the 'success_message' is a mandatory
parameter, with 'failure_message' defaulting to None.

The code has logic which indicates it was trying to cope with
'success_message' being None and 'failure_message' being non-None but
it does not appear able to actually do anything useful. The check for
'success_message is None' will break out of the loop before any check
for 'failure_message' has been performed.

IOW, for practcal purposes 'success_message' must be non-None unless
'send_string' is set. Assert this expectation and simplify the loop
logic.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241121154218.1423005-15-berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-15-alex.bennee@linaro.org>

diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index 98722a9cf6..f6c4e4dda1 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -81,6 +81,8 @@ def is_readable_executable_file(path):
 def _console_interaction(test, success_message, failure_message,
                          send_string, keep_sending=False, vm=None):
     assert not keep_sending or send_string
+    assert success_message or send_string
+
     if vm is None:
         vm = test.vm
     console = vm.console_file
@@ -95,7 +97,7 @@ def _console_interaction(test, success_message, failure_message,
                 send_string = None # send only once
 
         # Only consume console output if waiting for something
-        if success_message is None and failure_message is None:
+        if success_message is None:
             if send_string is None:
                 break
             continue
@@ -107,7 +109,7 @@ def _console_interaction(test, success_message, failure_message,
         if not msg:
             continue
         console_logger.debug(msg)
-        if success_message is None or success_message in msg:
+        if success_message in msg:
             break
         if failure_message and failure_message in msg:
             console.close()
@@ -138,6 +140,7 @@ def interrupt_interactive_console_until_pattern(test, success_message,
     :param interrupt_string: a string to send to the console before trying
                              to read a new line
     """
+    assert success_message
     _console_interaction(test, success_message, failure_message,
                          interrupt_string, True)
 
@@ -152,6 +155,7 @@ def wait_for_console_pattern(test, success_message, failure_message=None,
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
     """
+    assert success_message
     _console_interaction(test, success_message, failure_message, None, vm=vm)
 
 def exec_command(test, command):
@@ -180,6 +184,7 @@ def exec_command_and_wait_for_pattern(test, command,
     :param success_message: if this message appears, test succeeds
     :param failure_message: if this message appears, test fails
     """
+    assert success_message
     _console_interaction(test, success_message, failure_message, command + '\r')
 
 def get_qemu_img(test):
-- 
2.39.5


