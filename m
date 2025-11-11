Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EAFCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 10:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIldI-0000ox-UT; Tue, 11 Nov 2025 05:29:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcT-0007tz-CO
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:29:01 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1vIlcK-0000KL-BT
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 05:29:01 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b72e43405e2so110708266b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 02:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762856931; x=1763461731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VswszwaiJ2zd/aEwrd6yTHXOVyT5h3XZLeUyB9lumkM=;
 b=RkuD7DHwLIcrHJg6ypHiNz+MU3EYDavIwtCaFj1j0lmQ1wrbNh/0y7hvcjqzJ9IxYV
 mu+ETOvMjNJRt1HC/gVkdgdeZVOdvzM+kHs2qrIgd3hYuBjrEEtHcu95VE3bbSQ5TAZ0
 kot1K9vXW4SuRPDvWPU2WEdGLrozqx33H5waRRrXKTLs8d74+UaYElwykhERZj7YrHXW
 JK82U0pB2lKbsNnfIYloIrYs5e55hXBwulZPwvhhuGBKZ2TZXCKFXdKHLzWVG1VJCWIv
 wLCa22j6vVSgUFazlILCYRGtV+CvFA32N26p6x1xpFvlOOb5w2K7fAeMj9StFzFvFww5
 uoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762856931; x=1763461731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VswszwaiJ2zd/aEwrd6yTHXOVyT5h3XZLeUyB9lumkM=;
 b=HzsjIHONFU/srzW+yIvWGs4rS1rRPS5SfJpPAg5jZgLvLOQkwSYz5D4uMZNUzsA0ey
 fFsyQpFzli79kDbB+peCSirbftSlVQnfU+ZWts+szcyAcAsFhYYJYAW5nRXMBipSIB+Z
 LdfNsuRr2iWgai4VshDuxL1pWnzUDh2MOniVlRwOn2rmV7z8K70fwANk12WcYfGqmyY/
 FR5SZNaJGtQ/xZuwEwfMgm3b4Y/1APgjNoGcc2Q5EgSRjrCVFc4/7QJiwc0WYOXmxnBi
 BF0VpIN6kRihfpfkMVKnFsUmGt/NbBV04pfyhN2rMxgJyFzKQxp0XHCHF+Q5tr878Wso
 6cMA==
X-Gm-Message-State: AOJu0YyWcWk8c+LxbsgrwPAsGUJB38TUoe+ugQgZU4CZZNWHpH204L9f
 rNcKNng/9oXQgcNNGuMOAYtlkT62PKsmsJkSbyMs3Kj1b8ZImm0kw11A0B+FkLus
X-Gm-Gg: ASbGncsocqhus9iH8HCwk2N9rpTk4kkwyKvuVpIUzZhKi5ysTbQTeBWL7TJLBMPc/6T
 L4dG7sjg+GmpZWXRh0ocX7BIBAcr40CAdsFG3oxcaUZiq3y3B1+5JMJuTLue83IiWQtnyt1rlse
 jzv3kGiNLAJwreo3UyHYCcBHdArnosV2HW9hywuDs+sDUsGdLnbNY4yRFpWD0D7lwRbrjRDoSKe
 75uiAkhObjH4qwJB4wSdEcPMfwaOQBPn3OT6BFMm4zVSvrZXB2t6FrlMK/qSjHHrNdnnliodKK2
 jGYT2HhNopUda30TC9EWMol2lXZb6eN5uQDaJsFrKQYGl+GjQdzHae8SiVK6WJgdz3cjwcI4ZIU
 CkFs66eJjz6IEHLGeyzXYvRDZVPT7cFkooounoRywPrEZrQ6AE56cGYB/TDesKoVeXfS5PxX2xS
 uD+CN5ShW9WzSo1WQNeP8Lhg==
X-Google-Smtp-Source: AGHT+IFVYfkIGyEMl+nO4AtaIfCzV8I390aFwnCxstmdAw0kA9L47FY93oxjJ+iRO97Gzkkz/ssy7g==
X-Received: by 2002:a17:907:d8b:b0:b50:94d1:8395 with SMTP id
 a640c23a62f3a-b731d1c00b3mr314123866b.9.1762856930619; 
 Tue, 11 Nov 2025 02:28:50 -0800 (PST)
Received: from PC-DA2D10.beckhoff.com
 ([2001:9e8:dc12:ce00:ae91:a1ff:fe8b:15a7])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bdbd1ecfsm1290619366b.10.2025.11.11.02.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 02:28:50 -0800 (PST)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Kevin Wolf <kwolf@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v4 14/15] tests/functional: Add a Beckhoff CX7200 test
Date: Tue, 11 Nov 2025 11:28:35 +0100
Message-ID: <20251111102836.212535-15-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111102836.212535-1-corvin.koehne@gmail.com>
References: <20251111102836.212535-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

TODO
---
 tests/functional/test_arm_beckhoff_cx7200.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 tests/functional/test_arm_beckhoff_cx7200.py

diff --git a/tests/functional/test_arm_beckhoff_cx7200.py b/tests/functional/test_arm_beckhoff_cx7200.py
new file mode 100644
index 0000000000..a7fb88ac30
--- /dev/null
+++ b/tests/functional/test_arm_beckhoff_cx7200.py
@@ -0,0 +1,19 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a bare metal application on the Beckhoff CX7200
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest
+
+class CX7200Test(LinuxKernelTest):
+    def test_baremetal_elf(self):
+        self.set_machine('beckhoff-cx7200')
+        elf_path = '/home/yannickv/git/build-TCRTOS/FreeRTOS/Zynq7000/DriveZynq_Fsbl/build/CX7200/Optg/ZYNQ7000S/CX7200_Zynq_Fsbl.elf'
+        self.vm.set_console()
+        self.vm.add_args('-kernel', elf_path, '-nographic')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot mode is SD')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
\ No newline at end of file
-- 
2.47.3


