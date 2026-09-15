Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D356C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ZsA-0001UH-O3; Tue, 15 Sep 2026 16:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zs6-0001TA-7K
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:19 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zs4-0005dY-3a
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:17 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843c2790ccso71008f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789504515; x=1790109315; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2ceqUPoH8MhXmSFtjgWPeXdjWgb1vco08D6FmhOncNY=;
 b=Mbx6VUjl8Xb+Qv6X2LzNnp/uvMjKHNbAiMUq2y2KxhJW0XZB5Ry+1pbBG4OGuM66y0
 IBqXtkVPKJPW/jWLFTPRLL8N+VeX3B2dFnXopLxHuyUXdoHAzxbRIkL5YJ9idS+eiZ8c
 WzRUiH+Ad66Q5XrFaaTFhlFWkk3LONePW6sBwAvy2gksxtDnd9Z62yUrg8s3TJtJhfC/
 /XHVm/oLHKVaoeiUhTb6DrWYiI0leZ+vFWydvDY9AxGjOWZ+nBlcSdhqYsOR733DNNNw
 sy1/58zrBDNvNHLuVLko8YL8ihniVz+RImqp/mxraB1W5wZ2BRuWNihE+s7KdoMIlepz
 s6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504515; x=1790109315;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2ceqUPoH8MhXmSFtjgWPeXdjWgb1vco08D6FmhOncNY=;
 b=ZBRwXw+go4RtY1Nq6c3npn1QFA/UKsYqw0fXqow0ayojb7XNqglIiYjEZ50iHY5nUs
 ZIrr46bjVyxOu4qe6S07QWm37BSBO7qSXQJ9FRgD8OVW8q1b/HOwOW+gDfbKgqxVm1Yj
 yfTWn2EHaLWj34+ZhfTtOlSzdX+9jx1gJPGiZy+A6ok3LagcHvN3qMLE7WdpW+UQwr+6
 zWufBGaGb+1MqE/SGJeptBZ1raDZbhQTrunpz/c1qP1oMaN6PxOasPRJoDIQfTnbzNsW
 C1qOrvAV4MYAjI66johtGTYFurAbUJKv/gYTWdgYdhsbVTvsDIGs4yGxKxoYLlPhzP7x
 UgqQ==
X-Gm-Message-State: AFuF++meiZemi+x4wqNJ8vqGgl1iEnarbh5cQOdpryzrf2GuoMN6jHMM
 UyC6uoFo8oLwhcOWi7GVAA2EvnOh9GfaqYA//4YHtVoSJnNJHuQMwb2z1r89H5rNc1zlZqpaNch
 cYG3L
X-Gm-Gg: AYBFou2aT9ihb5gM9+BrRmEhde6C92ZXMphJWSBLjSVS7ys8VrAbRSFMEgGUJxRHmpJ
 PaSKo999lcYnun4WqwdZYvM7kfu4pqgMGbqwzvoF1oynt9wykfG6k27RJTc1pbOJgkAkm0WUmID
 8SVPh+0uFjKQhA4bJMccb9b3HkFP/5QpPpoFMHS9zgI+8JlFXR+KsXV55A0/kC01Vvb9SNLrMIc
 21UgUEyVFIrOJReu6UgeYPGUK90O8fn/o+Ky2gFgnc2YTmUlsom/t7WmMGWICaim9h/Qc2ZhBE5
 VxvXTFJxpTobThVPRiLUJlO9IRk7XIRwmLVl6kfLZvFuMB+BcsiJS9QgftSAKNSwq4om7iDLpMc
 ogYScSvRfwz6wXEhutuzn7048UpkFCnekhLCh7gKIkuZ6z9POs8xAx+XyzYnZfA9BN1KS3aHc4X
 qWvV3qJBPo6HMNtDAXwKMMgFv9h2OBHDClojU/MjCxypmJ2JC13RunaliRDRoO3Udm+PsD
X-Received: by 2002:a05:6000:2990:10b0:485:8542:fee3 with SMTP id
 ffacd0b85a97d-4870cf29d43mr207690f8f.16.1789504514682; 
 Tue, 15 Sep 2026 13:35:14 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f0fe:c7ed:403d:e487])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf37e69sm1504073f8f.29.2026.09.15.13.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:14 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 10/10] tests/functional: cover the BQL watchdog
Date: Tue, 15 Sep 2026 22:34:54 +0200
Message-ID: <20260915203455.580999-11-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915203455.580999-1-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=den@openvz.org; helo=mail-wr2-x10.google.com
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

From: Denis V. Lunev <den@openvz.org>

Hold the BQL from the main thread and check that the watchdog says so.

human-monitor-command is not a coroutine command, so a write issued
through it runs to completion under AIO_WAIT_WHILE() in the main
thread, which keeps the BQL for as long as the backend takes to answer.
Point that at a null-co node with a latency ten times the deadline and
the hold is both long enough to report and short enough to end on its
own.

Arm the watchdog after launch rather than on the command line, because
machine creation takes the BQL in bursts of its own and a deadline this
short is meant for the hold, not for startup.

Check the quiet case too. A counter that stops distinguishing a held
lock from a free one would report a hang on a healthy qemu, and that
failure is invisible to a test that only looks for the report.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Cc: Thomas Huth <th.huth+qemu@posteo.eu>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/functional/generic/meson.build          |  1 +
 tests/functional/generic/test_bql_watchdog.py | 60 +++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100755 tests/functional/generic/test_bql_watchdog.py

diff --git a/tests/functional/generic/meson.build b/tests/functional/generic/meson.build
index c94105c62e..c20c2a91ea 100644
--- a/tests/functional/generic/meson.build
+++ b/tests/functional/generic/meson.build
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 tests_generic_system = [
+  'bql_watchdog',
   'empty_cpu_model',
   'info_usernet',
   'linters',
diff --git a/tests/functional/generic/test_bql_watchdog.py b/tests/functional/generic/test_bql_watchdog.py
new file mode 100755
index 0000000000..193dad15e3
--- /dev/null
+++ b/tests/functional/generic/test_bql_watchdog.py
@@ -0,0 +1,60 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Test the BQL watchdog against a main thread blocked on IO.
+#
+# Copyright (C) 2026 Virtuozzo International GmbH
+
+from qemu_test import QemuSystemTest
+
+deadline_ms = 100
+hold_ns = 1000 * 1000 * 1000
+
+
+class BqlWatchdog(QemuSystemTest):
+
+    def setUp(self):
+        super().setUp()
+        self.set_machine('none')
+        self.vm.add_args('-nodefaults')
+        self.vm.add_args('-blockdev',
+                         f'driver=null-co,node-name=null0,size=1048576,'
+                         f'latency-ns={hold_ns}')
+        self.vm.launch()
+
+    def arm(self, ms):
+        self.vm.cmd('qom-set', path='/machine',
+                    property='bql-watchdog-ms', value=ms)
+
+    def hold_the_bql(self):
+        """
+        human-monitor-command is not a coroutine command, so the write runs
+        to completion under AIO_WAIT_WHILE() in the main thread, which keeps
+        the BQL for as long as null-co takes to answer.
+        """
+        self.vm.cmd('human-monitor-command',
+                    command_line='qemu-io null0 "write 0 4k"')
+
+    def log_after_shutdown(self):
+        """The log only reaches the harness once the VM is reaped"""
+        self.vm.shutdown()
+        return self.vm.get_log() or ''
+
+    def test_reports_a_hold(self):
+        self.arm(deadline_ms)
+        self.hold_the_bql()
+        self.arm(0)
+
+        log = self.log_after_shutdown()
+        self.assertIn(f'BQL held for more than {deadline_ms} ms', log)
+
+    def test_silent_while_disarmed(self):
+        self.hold_the_bql()
+
+        log = self.log_after_shutdown()
+        self.assertNotIn('BQL held for more than', log)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.53.0


