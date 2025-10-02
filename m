Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203CCCAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 02:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v48hV-0006rA-4w; Wed, 01 Oct 2025 22:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v48hR-0006pw-1k
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:05:41 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v48gz-0004tQ-5L
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 22:05:38 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b553412a19bso374909a12.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 19:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759370706; x=1759975506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=36ywwA0xwnnyvEA2yV5ieTqkFpwxjO0iulzgzaKGyQg=;
 b=XpxKLQlIKCw1swxIHeL2NzdxeHdo5mMfauq6XvHCu+ITEUcKwedvZ2QVPzJZHTCLD/
 6+e67kLSyWQGA/U8+hp8kD0kcnqwyI0Q7eKAElHZwi3t1b8BBUL6q929eDifI9oPsxeK
 1WOudWkwF4SRaRDBX8EA5Qya+UWLBd7dPbZ0DSKSXkXt8lVWhpMlMMQ+TR0viDeaUA39
 xqe0omuD5Ql9Bm5ekNG0skgRt9j15TsJEzN1xxnKvm9wAiSAiZCIYuv3CST8ThKZuWQb
 DD2ebVDghQysXvv4V0QhvrBBDSI1SLgTfGA9bSWCnE3T7fTvzaMZ+mo9rdjWNKCmmYIN
 NR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759370706; x=1759975506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=36ywwA0xwnnyvEA2yV5ieTqkFpwxjO0iulzgzaKGyQg=;
 b=W68ajo/Tdt1zneRhBQOUm7KIjMiqdRXXbYfFP5bwh7/fuV/1UfdqVnILGi+0s49jKM
 tOBuBN/aX3rnCh71DGCAJCVQTgNhtnUoblJZSzLt1pO8LE84neSqHevC+F3yQdPHaRiw
 tvfsOiAy+vmCEs8QdyoOUdsws3MzRgm/ANCcmXe8Q5VR/S6SUMGEJt/3SwRCWXqz8t5Y
 hw5n8emt77R1qbWA7075OOJHm05HaG0BAcEBHo+T5hWqOm+PLFF+Cdt8zw69uRTMUD4Y
 8Hf2QVnJudfJdUr/DEg39jRRKcsv/WKWzZZGSufBGlYdzy/nHkmb38UCl675OHEs6IK/
 gL4A==
X-Gm-Message-State: AOJu0YxNrIG1y6mHeWZITBeSBpmeAg69ieU+xqR0B6u/i3SGo8gy39yp
 MnCv1chkr/Paeuj9dcglfwk9tUX2Zxy0a94LGbbbtcYGMcUgV/mI//DtGr8VDoal9vCjJS7NQN+
 BF8+Q
X-Gm-Gg: ASbGncs59wJPzqFL+FGefuZr4BPxBRchMWN5XL8MssFsCURlsvcDJwvHumNXvNuGMY9
 q7ZxQX7ifXXCOK6XKswIB6n08Vkj57LxUinxCuLh6/l7rf/EJxTaGvJe/VEW4xyO2+rTD6a2fVP
 y4vZ5rAZXNM6xxbowqP2zTfAIf1RZ86ym6/DO+1Pij9h3Xa0WAdgUv0mjbJV5MQ9piqmdyrDV5H
 sCCJq76d9fO9oMsjWBKMP2cmt9h/vTCzwZmLW9zeVKmlfn0SOUn7+HrHUQQuKZq2LX3PzwFlLt1
 im+gF+sQfE9Ke9CUAxH3qMBVXmXqPQbTkMjmmsn8ssW6UYX3uvh0eDdAvzR9jfimVi4c7LGqNqe
 DHzlNBdn7achuf+/BKZ+fPb9blHUByy0R7rNr5x7Ql3pbc3xjkNOGvVYo
X-Google-Smtp-Source: AGHT+IEGzQJxhSLkM/78K47iQMjIFI3ZVf2uxUHftZi3defK8u6IpGpxLsHAzq8F9CBnHMn9llSxxQ==
X-Received: by 2002:a17:902:c404:b0:271:479d:3de2 with SMTP id
 d9443c01a7336-28e7f291facmr71074395ad.13.1759370705708; 
 Wed, 01 Oct 2025 19:05:05 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d95bdsm9476735ad.119.2025.10.01.19.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 19:05:05 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v5 5/9] tests/functional: replace avocado process with
 subprocess
Date: Thu,  2 Oct 2025 02:04:28 +0000
Message-Id: <20251002020432.54443-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251002020432.54443-1-gustavo.romero@linaro.org>
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x536.google.com
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
---
 tests/functional/reverse_debugging.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/functional/reverse_debugging.py b/tests/functional/reverse_debugging.py
index f9a1d395f1..a7ff47cb90 100644
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
2.34.1


