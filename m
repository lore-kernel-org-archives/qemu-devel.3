Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0570E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 02:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOT2H-0001vD-Ue; Thu, 19 Dec 2024 21:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOT2G-0001tw-15; Thu, 19 Dec 2024 21:46:40 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOT2D-0000IA-2a; Thu, 19 Dec 2024 21:46:38 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7292a83264eso1306481b3a.0; 
 Thu, 19 Dec 2024 18:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734662794; x=1735267594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/gqB0EFOflediWblib/x6PojT1X7ZGctVzz4h+o860=;
 b=i38KUUF6RVCIMLhgP4HvwMFrrsrn6xHtkZ+DPYr3AsTfixW4h18yQ5jJh8DkgD7vgp
 1flleHwe8hfzlOh2eev8zdHTI+E4odZ8BHKnyjh+kThcYe/WPVPkMvTyqcH3TpPU4qfh
 TPYjFXU4T9IHLsYA9fvgtmSIhZl9S37VzH9I8J7FyothlxtcDKcfDpJDYWkShqEccFjS
 nnUaal6faJGs5+3fYbWLfdYm7tGw0/fzO3IJrm6HCg3HdkthfMsE/Cg+Jlldfwn3hrSy
 xElWuzTfarv66lqIJUOnx7bVQm2VOGuljbrHg7GAJ/NpCitycTgl/yse7DxgrQdp3mO3
 ne1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734662794; x=1735267594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/gqB0EFOflediWblib/x6PojT1X7ZGctVzz4h+o860=;
 b=uyAzfbxr7WSWT5dml4YoqAvu633GdKcO3Z7oZXsFbUsZ/DD81QPSz3owRBQnKqvR09
 n+X6USVGMubrFEA+gZit8nTLiNFYHAsVY6ZLrrKXKjg2ljz0nOitRU+KAwfKR7pf0zR5
 UjVpGur65iN0Jg2qsHp20bohNQJdcWITRkMw65WwIXxbE7JeGWT14/4bxDbmHbCAWeez
 iKRDbfj0uj40MUJwBvg6ChXNFWBhru37ln2ncSznF2H2gA4UdOcBmoDAtQQS8xVXnQmn
 c69OJKogxFX4aiuaInf735FQvS9hdq/u1EWaHON2Bktv15k82VuR8PMWOWubCYdhu4np
 gI9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8FubsH2WFhMwhcKI3CRyYiyeBWgHZZdzgAVW4BYi9eVpJt/F/9NDvHuWUdrs17U7vBPGFELpweg==@nongnu.org
X-Gm-Message-State: AOJu0Yz+rO3yHkJVauV4OnTaGs6iyX/pj64c5lKfJnjWNLIL/xZ6WwWa
 R5ZFuLS9bsNIJ23UbO5qWQKMkpwZvB3wnMZ3FJ5K6rkjOhbxkG4Ak66goQ==
X-Gm-Gg: ASbGncsVGMts0OfYUeL3mE5RME1D5cJbKpW5GrpAxsJ1Y5n1H5LlTMm2p277jdOSZVs
 VMBP5VvdwAqR5iEhXd5H5czei2alyv2RZSM6lzK+LF1hulX+eMa4eSk+zGu3+5o24/vFUXI+8dx
 jvqPkR2R7/SFO/9ALBUf9k/V9dLAJWe4mApVxQ6Dr/l2FFxyrEp0DdjSoNb4OFIbmJ7Vy4pXE1N
 PtyVktATDyJ5lmvh9+Escueq6Uwh4u4OVjcDAwyDSgbydMMaPu5/rmEO5tYipAysODWKMZZv897
 io6ISXnGpg==
X-Google-Smtp-Source: AGHT+IFf9N30gN8QAQPjV3GJSValNAtE+UfHt2DeURUnnucrg+j8T4D0UEkQzyWc66bU042Hv5JVjw==
X-Received: by 2002:a05:6a21:3994:b0:1db:d932:ddcc with SMTP id
 adf61e73a8af0-1e5e049f462mr2328172637.19.1734662794491; 
 Thu, 19 Dec 2024 18:46:34 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dba99sm2037830b3a.92.2024.12.19.18.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 18:46:34 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-ppc@nongnu.org
Subject: [PATCH 2/4] tests/functional/test_ppc64_hv: Simplify console handling
Date: Fri, 20 Dec 2024 12:46:15 +1000
Message-ID: <20241220024617.1968556-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220024617.1968556-1-npiggin@gmail.com>
References: <20241220024617.1968556-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Since functional tests have character-based console output parsing,
there is no need for strange hacks to work around old line-based.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/functional/test_ppc64_hv.py | 43 ++++++++++++++-----------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index d97b62e364f..afc8b9a3106 100755
--- a/tests/functional/test_ppc64_hv.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -12,6 +12,7 @@
 from unittest import skipIf, skipUnless
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern, exec_command
+from qemu_test import exec_command_and_wait_for_pattern
 import os
 import time
 import subprocess
@@ -102,31 +103,28 @@ def do_start_alpine(self):
                                     "id=drive0,read-only=true")
 
         self.vm.launch()
-        wait_for_console_pattern(self, 'Welcome to Alpine Linux 3.18')
-        exec_command(self, 'root')
+        ps1='localhost:~#'
         wait_for_console_pattern(self, 'localhost login:')
-        wait_for_console_pattern(self, 'You may change this message by editing /etc/motd.')
+        exec_command_and_wait_for_pattern(self, 'root', ps1)
         # If the time is wrong, SSL certificates can fail.
-        exec_command(self, 'date -s "' + datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S' + '"'))
-        exec_command(self, 'setup-alpine -qe')
-        wait_for_console_pattern(self, 'Updating repository indexes... done.')
+        exec_command_and_wait_for_pattern(self, 'date -s "' + datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S' + '"'), ps1)
+        ps1='alpine:~#'
+        exec_command_and_wait_for_pattern(self, 'setup-alpine -qe', ps1)
 
     def do_stop_alpine(self):
-        exec_command(self, 'poweroff')
+        exec_command(self, 'echo "TEST ME"')
         wait_for_console_pattern(self, 'alpine:~#')
+        exec_command(self, 'poweroff')
+        wait_for_console_pattern(self, 'reboot: Power down')
         self.vm.wait()
 
     def do_setup_kvm(self):
-        exec_command(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/main > /etc/apk/repositories')
-        wait_for_console_pattern(self, 'alpine:~#')
-        exec_command(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/community >> /etc/apk/repositories')
-        wait_for_console_pattern(self, 'alpine:~#')
-        exec_command(self, 'apk update')
-        wait_for_console_pattern(self, 'alpine:~#')
-        exec_command(self, 'apk add qemu-system-ppc64')
-        wait_for_console_pattern(self, 'alpine:~#')
-        exec_command(self, 'modprobe kvm-hv')
-        wait_for_console_pattern(self, 'alpine:~#')
+        ps1='alpine:~#'
+        exec_command_and_wait_for_pattern(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/main > /etc/apk/repositories', ps1)
+        exec_command_and_wait_for_pattern(self, 'echo http://dl-cdn.alpinelinux.org/alpine/v3.18/community >> /etc/apk/repositories', ps1)
+        exec_command_and_wait_for_pattern(self, 'apk update', ps1)
+        exec_command_and_wait_for_pattern(self, 'apk add qemu-system-ppc64', ps1)
+        exec_command_and_wait_for_pattern(self, 'modprobe kvm-hv', ps1)
 
     # This uses the host's block device as the source file for guest block
     # device for install media. This is a bit hacky but allows reuse of the
@@ -145,15 +143,12 @@ def do_test_kvm(self, hpt=False):
                            '-kernel /media/nvme0n1/boot/vmlinuz-lts '
                            '-append \'usbcore.nousb ' + append + '\'')
         # Alpine 3.18 kernel seems to crash in XHCI USB driver.
-        wait_for_console_pattern(self, 'Welcome to Alpine Linux 3.18')
-        exec_command(self, 'root')
+        ps1='localhost:~#'
         wait_for_console_pattern(self, 'localhost login:')
-        wait_for_console_pattern(self, 'You may change this message by editing /etc/motd.')
-        exec_command(self, 'poweroff >& /dev/null')
-        wait_for_console_pattern(self, 'localhost:~#')
+        exec_command_and_wait_for_pattern(self, 'root', ps1)
+        exec_command(self, 'poweroff')
         wait_for_console_pattern(self, 'reboot: Power down')
-        time.sleep(1)
-        exec_command(self, '')
+        # Now wait for the host's prompt to come back
         wait_for_console_pattern(self, 'alpine:~#')
 
     def test_hv_pseries(self):
-- 
2.45.2


