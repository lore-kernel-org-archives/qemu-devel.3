Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7423FCB61E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXsB-0000DT-89; Fri, 06 Mar 2026 11:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyXrw-0007OQ-C1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:17:42 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vyXru-0007kf-AM
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:17:40 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48375f10628so62476635e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 08:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772813856; x=1773418656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rFrNo7xt4cWsD82/Y1vv1GAovu90HiLaptxTyNhWut8=;
 b=xjhH6QY9jrEXCaQHUNhsyHO4PWaffxYDeQagALEseE5Um7alA9OlYXrB64IWF6eBjM
 wr1MxQmaZNWElC6aeYowqPf+MWUdMPjGQPTpnOvqNoYU+IYjkXBSugnmti+7Q1op0rra
 C8R7PU84fqqGv+D/d9o7dr3yngwF5cBHOOVjpff9RFcr/7Ic7dTqq+Jqz3g8mua3ePJy
 nZN5vys9ZDULLTtX+lURP+IPZ4GG8Ipib6dK51Du8ipBeiyugYcxiFFnAfu38/XGNL89
 BV1Mj9LD1mG930onC+CVlUcTGQ+rJIFwIIyDpNXAcHJLtr9eH8ifIPuMrJXxD5SMp16j
 VcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772813856; x=1773418656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rFrNo7xt4cWsD82/Y1vv1GAovu90HiLaptxTyNhWut8=;
 b=kbJI/AZMvQC17dmpKkKwqr1kMUmS6OEueutJQJYEWNV0GItPC8X6zve+3f5l7uGafT
 iWLMGVZVgwTc2wqkXedeuhB4j6i7mx+TsFQb8x/bnpDXAmHfsMsN5LorR19GmsJPrmWj
 MrtBXQhRBYM9Hb7YBCVn+3p0E19V337xqWuaaYBP6KKBAtGGTYP0KrSHuSlO6f87nS8k
 VD2cVu+OAgGztsaX6kiYxWSqMondkLbbyHCYnKx55GOY7fIzEWEgmRRzgNhteEX/c5Ok
 m0GnQ0qi7z64RXk/7nNWdk5a3eGqs39QCq0vJv17yMkSOuQpEmdl0AybGv3iLPFc+ybh
 7aOg==
X-Gm-Message-State: AOJu0YwcK/CsLnPoGtBoJI3beSmZqczrCwDTCdlHLaVeJVwpukudoo/w
 ylfF0iVO5pVzRA7RKGu/Ipo5rB0QGTN3E6KzYQxphEIepIFaoccSIYHE381PS1d+iQk=
X-Gm-Gg: ATEYQzzQE0j85NuHEMu89sji4hXrPshkxdBc+h031CRMs6rUTuhgVtWr68ixsH15wGs
 3HIN4krRm/kXc9hnKrLmGgFgsJqnvDj42pfgXz4Qn/Up1LUf5fmLMYLJiFRhy0Fv18XWh2m4C8h
 McCiilvIjf32OPRhjQDAx5isjOJkoCO4yfkmGz0f3+XbPdmJaHbE26FNESKJ9Gr2QkXAtVOOW0x
 8JiZlDicY9pAwsLJ4nHIW71Sf8cxNaZawMwd4UqxLW2NGRpJ3tXojDPinBuyzp0/IxTlBbXAvVF
 A5mKQk5E1f6sCS4Ge6y7FbTxH1b+DTU934BA43vyU5emryL306aB3uEOV3e9pm9iqgGVPdE3Kob
 Pu4FwhZ1T58JACdgBx3sDCUt0PVFbJVvaslZFlU7Z44O1gDPME2P8OcmkC2EdnS2WoITQwDumXZ
 HRiWPq+Qe5B/AOzTfjM3MkRyc=
X-Received: by 2002:a05:600c:45c6:b0:480:3a71:92b2 with SMTP id
 5b1f17b1804b1-48526979652mr41566045e9.26.1772813855827; 
 Fri, 06 Mar 2026 08:17:35 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae00absm121465195e9.4.2026.03.06.08.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 08:17:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6CB69689D5;
 Fri, 06 Mar 2026 16:17:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 6/7] tests/functional: add the ability to send keys
Date: Fri,  6 Mar 2026 16:17:27 +0000
Message-ID: <20260306161728.2657486-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306161728.2657486-1-alex.bennee@linaro.org>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

To navigate things like grub we need to send individual keys without
trying to look for success messages.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/qemu_test/__init__.py |  3 ++-
 tests/functional/qemu_test/cmd.py      | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 03e5c73d39d..9ed8c6a4b53 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -10,7 +10,8 @@
 from .config import BUILD_DIR, dso_suffix
 from .cmd import is_readable_executable_file, \
     interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
-    exec_command, exec_command_and_wait_for_pattern, get_qemu_img, which
+    exec_command, exec_command_and_wait_for_pattern, get_qemu_img, \
+    which, send_key
 from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
 from .linuxkernel import LinuxKernelTest
 from .decorators import skipIfMissingCommands, skipIfNotMachine, \
diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index f544566245b..381e5162f02 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -142,6 +142,21 @@ def _console_interaction(test, success_message, failure_message,
 
     return out
 
+def send_key(test, key, delay=0.2, vm=None):
+    """
+    Send a single key to the console.
+
+    :key: key to send
+    :delay: debounce delay to wait
+    :vm: the vm to send to, defaults to test.vm
+    """
+    if vm is None:
+        vm = test.vm
+
+    test.log.debug(f"Sending key: {key}")
+    vm.console_socket.sendall(key.encode())
+
+
 def interrupt_interactive_console_until_pattern(test, success_message,
                                                 failure_message=None,
                                                 interrupt_string='\r',
-- 
2.47.3


