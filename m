Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCD3C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 06:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSWKp-0002Do-H5; Wed, 24 Jan 2024 01:02:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rSWKh-0002D0-OE; Wed, 24 Jan 2024 01:01:56 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rSWKg-0003Bu-8C; Wed, 24 Jan 2024 01:01:55 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2903cd158f8so2929722a91.2; 
 Tue, 23 Jan 2024 22:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706076110; x=1706680910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ImfGyjfA4EuJ2Nqadid6cTGtn5ZwpnE/HWJORfnVe/g=;
 b=elWqbzAXLteo/lmmaeLqhehX4DXNXzkOe8ZHygOdNFYN569mUr5nhMwg8GCffE5LE+
 VWJxbGzoZS6iZh6wDLIv4Jq0fel0b31+iYzH073KLpN5RxIj3aDcHw5wDIMUClCraoVk
 Bttzomq+w7rHETN+9BE5+GjvZs7Gp590qNP10fHTsx2Kat8rcV1u390l86aU+5IMRMYH
 g6Q0aTKEDxMABOyVZoTBN5Jkxo4x4lAvuwfcCJIEO1nwPcjwuYaCdANGVgnujNOTZ2UK
 xsrzSI5VHKGAp0HoOU6bbdXsZmOphLjY+6JQ9Fni0O/G3gB927ZpgPAZAu0SGr5XVRt0
 WmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706076110; x=1706680910;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ImfGyjfA4EuJ2Nqadid6cTGtn5ZwpnE/HWJORfnVe/g=;
 b=DVHNVPw1WG9gFrbFtBSwCWLY1rpV8uWPN/n1TlbdX/+HBnXYGmwP1FHneMXjm0Njxt
 whw2PmibN+hOYbrYwR7MZCi+SrP5VrVb7OSEh7KjqObOmtlPKPgqz8Pmflqg6f11Yhqo
 81InXM7nC5F8TlDY1aNH+ANkyw1PYh3gkh3SY6bOKsa/0QLyhGf5bV09EchxlaNFZU/H
 EfJkUfeLI1nCU0RQrpruxel9dSDZ3UUmBRtC1ypG76LyI9imJT2QQ/17b88kQQ7dXVSF
 CDf8q9ETv9QccZrDHst2fqhfNnvTrmvv01QH9PC97AREohUrZgUzd0ZIS/u7kwls1vFC
 XxFQ==
X-Gm-Message-State: AOJu0YyGLima2RZT/9dRKt7+NUWo03xI1/N/wINrJ1Bx44sFiDzD4/Jq
 QVog2Qa4v/DBwUcfyL8R9kNUOLcd58HQL4QkNbnxiAjafS/QBQ5w8m63gCHO
X-Google-Smtp-Source: AGHT+IE/AjU3mqd9R7nJU+b20B9g9pzBZa2/lQ55+PKX0N1jl2V5IxGRPWgU3teZmHAE+T2hDAPzug==
X-Received: by 2002:a17:90a:8281:b0:290:170e:2e21 with SMTP id
 g1-20020a17090a828100b00290170e2e21mr3392316pjn.35.1706076109524; 
 Tue, 23 Jan 2024 22:01:49 -0800 (PST)
Received: from wheely.local0.net (110-175-3-177.tpgi.com.au. [110.175.3.177])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a17090b004e00b0029020be4298sm12783325pjt.0.2024.01.23.22.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 22:01:49 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] tests/avocado: improve flaky ppc/pnv boot_linux_console.py
 test
Date: Wed, 24 Jan 2024 16:01:34 +1000
Message-ID: <20240124060134.406331-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The expected MTD partition detection output does not always appear on
the console, despite the test reaching the boot loader and the string
appearing in dmesg. Possibly due to an init script that quietens the
console output. Using an earlier log message improves reliability.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/boot_linux_console.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 3f0180e1f8..922a9e7b79 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1368,7 +1368,9 @@ def do_test_ppc64_powernv(self, proc):
         self.wait_for_console_pattern("CPU: " + proc + " generation processor")
         self.wait_for_console_pattern("zImage starting: loaded")
         self.wait_for_console_pattern("Run /init as init process")
-        self.wait_for_console_pattern("Creating 1 MTD partitions")
+        self.wait_for_console_pattern("rtc-opal opal-rtc: setting system clock")
+        # MTD partition detection output is sometimes cut off from console
+        # output, suspect S14silence-console init script.
 
     def test_ppc_powernv8(self):
         """
-- 
2.42.0


