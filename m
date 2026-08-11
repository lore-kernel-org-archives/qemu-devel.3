Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B1EC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtna0-000068-JG; Tue, 11 Aug 2026 10:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnZz-000055-3U
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:35:47 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wtnZx-0001oj-EG
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 10:35:46 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-51c05dcdf49so30248991cf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 07:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786458944; x=1787063744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qtwJ48c2jv1FFgaa3GcNc1BiQL2QiF7L65p40Cem4T0=;
 b=jCUPPo1PuVjifc5P8py4KEx+NyON8DhRqLFXi9mLb0Y66vOSSacHBZ7Z2LNaUKVD2K
 1SRRue4WS9UpLh+dq03RmC64++fbekkYnP9VB1zM3kK6EPMwRufv5z01uV76JOQO39ub
 9Awtl7oDsd4pDmZCI8U4HX4jVtU6e6Q3/16Eb2OFAi8bhgI6Ue2FEBKQjHpe0JMmDrPL
 unUM/20ukUZ+TuFf65XvoiGILyzwVUxQxkDKVtOg35arSSsdv8I5Q75nOL7kL7gJ5Rda
 YKGyMbPSvrS+blX8j/wV6bPPddXZkXolTnKyzP2v6z5/OGkEIs/CoajN/pnVyQ2903mJ
 e2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786458944; x=1787063744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qtwJ48c2jv1FFgaa3GcNc1BiQL2QiF7L65p40Cem4T0=;
 b=mXCa3sk6PmXW8l4y9i+SsTB9LBD7uPRdoicVoi6caggTUZcEjjPapcZ2K0MKOgi8nm
 JjOoJMub81Oi2ju5iinDLL9zv/Z6NwjzwPgsDuW7DbveRWARTULLdG8voSKZ529Cno/t
 lFnxg7mCJCvvJuP9b6BAk5tod2gTmZfGuqDZw7Yjm+P2rRydby34TcfFst5v87jj22DA
 sxdlevyKb+NPMDXv6zFNgnpDg9noBcPRYzMRnAfKfvV2E1bP5EPDZOmets27iCZwmJZM
 soN6YMkcfuH+qMg3TNd2ZWjx71tWbcYoPwY72+4ZSX3cm48OdweO6WeLpWOhCehBr+gQ
 qj+A==
X-Gm-Message-State: AOJu0YxbumwLP2WkpYya5W+S27Q/gj0Qyv7nuZQRfEy57VZ5nAMcrsek
 09TdsKLBFsYrtrGENz6FPgXoAntbrRxb1QUFgg85yT5nPO4H27sFtJmGP4ZeIg==
X-Gm-Gg: AR+sD127bPsvg/9ptVhCOBUvNd6plW/r6WgxEn/SPBjBkn0GN629o9aEbfdLBn3iitF
 5OcbqY9Fl+Kz+83/hUo426oSJBvzVFzE9kjZxY1pm4dD0bw25SrNTWQakJORhgnAkeMvq8jORja
 jufmSg2n98ITLyFAiYkLj4Ld8VXxXdVwDSo9BkVFsg+4f2W4NUI3VOK4Gs1IN/xAQipJH9a+cyF
 Qg6AF4qUEO18ZRxgTjukyq7N8/Dx7Xuze65MNl/wTUdM2jh2J2UWZso0dhHBe7jBnRlNugyXDY/
 adsk6lcKH1u0b0gulLAt3bwVOYEkNkK5S13jH4Bt46dJiDMh8GUsW1UPnjl+AfljpkV5tdnwfD3
 T7xF163gNdTFTwRl/5pLFg2WeHxD6dqD6RVEHFhRDQPAMtLmfzoodL+r31vUYM0IqcQOjWnqw/6
 yrujRTWCQS/I9e/q+TY1fvu+bLWjRMGIswiLtIAUgmdNP/eD1oCpkZOtHkhGE5p7q3pdgy4WQ+r
 jU7dcpIqQlYhjacv3U=
X-Received: by 2002:ac8:7f07:0:b0:51c:239:42da with SMTP id
 d75a77b69052e-52d584f6403mr33135831cf.15.1786458944155; 
 Tue, 11 Aug 2026 07:35:44 -0700 (PDT)
Received: from localhost.localdomain ([198.16.145.87])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90a6c3ec565sm376396d6.43.2026.08.11.07.35.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Aug 2026 07:35:43 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v3 2/2] tests/functional/aarch64: add raspi4b full-RAM
 regression test
Date: Tue, 11 Aug 2026 10:35:39 -0400
Message-ID: <20260811143539.7835-3-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260811143539.7835-1-marcelomanzo@gmail.com>
References: <20260811143539.7835-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Guards against the bug fixed in the previous commit: boots raspi4b's
default 2 GiB configuration and checks that the guest actually sees
close to that (>1.9M kB), not the ~921 MiB the bug left it capped at.
Deliberately checks a threshold rather than the exact byte count of
either figure, since the precise number depends on how this specific
pinned kernel accounts for its own early reservations; the threshold
is comfortably between the two (943524 kB broken, 1905824 kB fixed,
confirmed by hand against this exact kernel/initrd).

Folded into the existing test_arm_raspi4_initrd test rather than a
new standalone boot, since it needs no machine state that test isn't
already setting up, and the functional-test suite is already slow
enough from how many separate guest boots it runs.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 tests/functional/aarch64/test_raspi4.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/functional/aarch64/test_raspi4.py b/tests/functional/aarch64/test_raspi4.py
index 35ba6c24f7..8506854d99 100755
--- a/tests/functional/aarch64/test_raspi4.py
+++ b/tests/functional/aarch64/test_raspi4.py
@@ -86,6 +86,23 @@ def test_arm_raspi4_initrd(self):
                                                 'BCM2835')
         exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
                                                 'cprman@7e101000')
+
+        # We used to get the RAM size wrong; guard against a regression
+        # (see git history for details).
+        mem_total_kb = None
+        cmd_output = exec_command_and_wait_for_pattern(
+            self, 'cat /proc/meminfo', 'MemAvailable')
+        for line in cmd_output.decode('ascii', errors='replace').splitlines():
+            if line.startswith('MemTotal:'):
+                mem_total_kb = int(line.split()[1])
+                break
+        self.assertIsNotNone(mem_total_kb, 'MemTotal line not found')
+        self.assertGreater(mem_total_kb, 1900000,
+                           'guest RAM (%d kB) is far below the ~1.9 GiB '
+                           'expected for a 2 GiB raspi4b -- the second '
+                           'memory node above the 1 GiB peripheral hole '
+                           'is probably not being added' % mem_total_kb)
+
         exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
         # TODO: Raspberry Pi4 doesn't shut down properly with recent kernels
         # Wait for VM to shut down gracefully
-- 
2.47.1


