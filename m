Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D3DD7879B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEAWP-0005YU-EV; Thu, 21 Nov 2024 11:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVs-0004qq-2S
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:41 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tEAVX-00085S-8H
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 11:58:39 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38231f84dccso794580f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 08:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732208297; x=1732813097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvB0S+SuI5gT8c9EFIym95gTJAjNroOOQ4+Yq08R388=;
 b=xo9Kdtktd9NXpw6xO/IyMs45YoVfmkzxkTq3+0KmHFOV62FEJ/XaWtM02xCvNFFBTL
 8Kdt7rxrW2UsfCUzJ7uUvAcAXJkAc9YKlToGVXooqnTZlVzc2hefYpNrDa3gUKU3pT7N
 BGUNoaSsRuUQ/ONp4t6fCNlvtWSHoECFegrScaaZDxNhqRTdZKvz3I+6B0Kf7fwXbnte
 iE3sg4OfVDAMOP0rpchUwuD1LbZzSY+mXaFagJz1mLZYtP9/Dv1/eEJdMlCrgBi9u3mI
 ox79p4phw9Is1OLsJEx48sOu8IP9bB6PBjmtZtnbDRmRaNiEyRVgvd1aFzdSu52uZuiy
 Iysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732208297; x=1732813097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nvB0S+SuI5gT8c9EFIym95gTJAjNroOOQ4+Yq08R388=;
 b=YeDEQ7GiOcCz7pHqnxNS4OJEZsJ5JpdhKRrrcyIeAH9KwPceANZ+/VOA/b+UheIoJm
 rr3sM+ZbSd6a/FutDuqEAhYg0GOoVKYOILWs418uMd8YXKG8VBJQ1RYUAkP0blq3tq4a
 C2dwUVywzLelw7VTNFULj9RyQfC0L64nffFrjzwZZxHK03zvDx6e6H4mo/Yp4vDUPHVn
 5L0GoNoKLrBkkg6Nt9Vi5YkcEt8rkrTbiIORBs8smoUaVXdWee2GeHNoO/AaBHYhLIji
 C/rKLGLqA1Os4BsnddU2HVK4HmGnVxAm0uCY/ViA+Bfu9UouRbyhnFozKmvIQCAIg5yT
 my+w==
X-Gm-Message-State: AOJu0YzeN9vli/gPwLly2Py1v188Hf21UPALuQueK6xPHZYhs3th6IvB
 sacZ9e2jHD37z83GbbFya16xQUWf1bvkTi+xyPTWqWq0e9Ig3a/QKtuOpxBcZrI=
X-Gm-Gg: ASbGncvnJd/sjJRyCrR8twz6mF2mdVMhbMaQBKWrWVJRfJGiiqDREMS0w/9DZyJsUFI
 wO/2flsG68KMwMUV8u4go5jZPl0Dj8I+PM121PsV1gmuxFdTwoWz5iFZsoXk8wl9Vm0sKif7w2f
 umKkq0RRAXxOJmNQgJFx44yvcmXXhs5d96CtxZDV1L5S7k0Le/nnaL0eEYAVMemvsgdiNA9cZ2c
 86eMeWI7U8yy4XiDGcXQua0frCwOs6HkKhcKFhcdeHyRxMX
X-Google-Smtp-Source: AGHT+IHQjeBVkEQyiDQNZ18M0mfYWvrNmDsPSaNfb+Oc21EWZo3NcDg7uEMtXkjcsrBIT2YzsHGzQQ==
X-Received: by 2002:a05:6000:178e:b0:382:424:94fe with SMTP id
 ffacd0b85a97d-38254b15734mr6840684f8f.36.1732208297548; 
 Thu, 21 Nov 2024 08:58:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedfccsm14917f8f.101.2024.11.21.08.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 08:58:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B718F603D3;
 Thu, 21 Nov 2024 16:58:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-riscv@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-s390x@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-rust@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Markus Armbruster <armbru@redhat.com>,
 Weiwei Li <liwei1518@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 14/39] tests/functional: require non-NULL success_message for
 console wait
Date: Thu, 21 Nov 2024 16:57:41 +0000
Message-Id: <20241121165806.476008-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121165806.476008-1-alex.bennee@linaro.org>
References: <20241121165806.476008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/qemu_test/cmd.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

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


