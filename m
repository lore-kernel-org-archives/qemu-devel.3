Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC02CCA472
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66Io-0002lT-GB; Tue, 07 Oct 2025 07:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IQ-0002Xj-Io
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:59 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66I9-0001JS-CQ
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:57 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3f2ae6fadb4so1005375f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838135; x=1760442935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lay1dX0EgU7CquIWsqnJhTZhe2aTP4vB0W0SBlr2NqI=;
 b=CHPqXQmxQJukiViL+qZW+C4ey/6Ch6FYIvEGVx8YvXnHIBQeqYkAbcFAIK+BI1OrKk
 aMd+hNTPhwRmxqtoj/sftDm9vmX91bHGuvSaNDwwwz5FPVTjGY96vbm1awYWUw+lksa/
 /OWX3Af9SQIw53AzESYx3a/BrIA5C9Xyhm9xybOsOXyO9mCBC4OIeYrUzC+dkjCt93ny
 Il8bZyfgRt2FfzdO8DUgL7DkQ606LX+UCaGSdvyqoVvFhlp94T2+hwLgDdUNAgeJhp30
 bs4KksJfB5+63QSssyl12aX1UafYBjGVJBwV9mG0zXRHDqRjgvEdpOPOJNps8AIzyQKs
 ba7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838135; x=1760442935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lay1dX0EgU7CquIWsqnJhTZhe2aTP4vB0W0SBlr2NqI=;
 b=n71IiYNfuaMbxUkQ0It5fxfzPhuPGSxhF/tch9pqGENQgEKJjPWf5yFMUAyBh3s1w3
 RCKTJ6wZOMwSqtRF/+XXPq3L42JfT50nvylnbw2q5JOuri2AUhl0HEsc3abJhn/NwCMg
 rUl0SIZ0BIED8Lo9HYJP0CRAA85Pr/LKggzywWn6mXuyUBCI1aMAMYpYxywLiVX3LVtn
 N9b/7xAWdtbwa4MpgO5m6za148IXGFbLEt719IrZPqpZenWmLnZ/8vIwMNtM8LqnQOFx
 aS5o/YQMQV1Lq8XarKTY4HBGue60fjiWJTPvf8wqRI2iTE5Fil7w8tEbXcB97vGQs3jZ
 cMkA==
X-Gm-Message-State: AOJu0Ywx96+3H7p5c4mhmZllJPocUd3hWmvBwEgK4nxvRcbChHl3neeA
 srmBeIVWTyVjZmOMDsIV3UGPmXxvwsuD0rfJYJdXYIUWZx1L8U7oBoptLzzve+FACFM=
X-Gm-Gg: ASbGncsKv1O9FUfWiBoIYWTNrxw+P5NURkZbMImuyyhXXyQ/naGR+bTJOsaAvzVGpyI
 e7QezMnnC9q0CTyLH2NEuwLGZErPY5QnMCZFTqSyFoZr3FhfIW0vupIlwhmEnFlL7imK4TcNDWC
 iB9OQrKvCOA6NaR1c9vHc9dwUitQAh/HcdmMy2KbxZDlFYOu9ow8zm3FxtWMozlMHk5hD1FIuxC
 knk51nFNFa7tNWSSt7zaPoPOyJqq7E/XpHf7q9PdQ6MGh+fnlSXGgTZIEb2a4FlEs31+rsutwMa
 ZomuET7xstmmFP3Y/XPsZ35ega1fDZrbzDsfQhw42I/XPQLM7ssPKbBLkyNtZ5sLw/QlD38AqrT
 qzlswVzxUGnOOSzsXRThQTkNDETa2NcZOPaX3fHby9GcWR2LkGNo=
X-Google-Smtp-Source: AGHT+IE389ZQLAronRaEhh0Gbi3cWgpGlzqL1jLbiPcfO+LrMt45N4TyQ2d9OP++JGcH4Xx1OsKGaQ==
X-Received: by 2002:a05:6000:240d:b0:407:77f9:949f with SMTP id
 ffacd0b85a97d-42567165df4mr10003536f8f.28.1759838135232; 
 Tue, 07 Oct 2025 04:55:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6c49sm25322445f8f.3.2025.10.07.04.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 09851603D3;
 Tue, 07 Oct 2025 12:55:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 12/17] tests/functional: replace avocado process with subprocess
Date: Tue,  7 Oct 2025 12:55:20 +0100
Message-ID: <20251007115525.1998643-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The standard python subprocess.check_call method is better than
avocado.utils.process as it doesn't require stuffing all args
into a single string.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251003141820.85278-6-gustavo.romero@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index f9a1d395f1d..a7ff47cb90c 100644
--- a/tests/functional/reverse_debugging.py
+++ b/tests/functional/reverse_debugging.py
@@ -11,6 +11,7 @@
 # later.  See the COPYING file in the top-level directory.
 import os
 import logging
+from subprocess import check_output
 
 from qemu_test import LinuxKernelTest, get_qemu_img
 from qemu_test.ports import Ports
@@ -100,7 +101,6 @@ def vm_get_icount(vm):
 
     def reverse_debugging(self, shift=7, args=None):
         from avocado.utils import gdb
-        from avocado.utils import process
 
         logger = logging.getLogger('replay')
 
@@ -111,8 +111,9 @@ def reverse_debugging(self, shift=7, args=None):
         if qemu_img is None:
             self.skipTest('Could not find "qemu-img", which is required to '
                           'create the temporary qcow2 image')
-        cmd = '%s create -f qcow2 %s 128M' % (qemu_img, image_path)
-        process.run(cmd)
+        out = check_output([qemu_img, 'create', '-f', 'qcow2', image_path, '128M'],
+                           encoding='utf8')
+        logger.info("qemu-img: %s" % out)
 
         replay_path = os.path.join(self.workdir, 'replay.bin')
 
-- 
2.47.3


