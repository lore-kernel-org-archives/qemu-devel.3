Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9B0CCD182
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 14:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4gd0-0004PN-Ga; Fri, 03 Oct 2025 10:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gcw-0004OS-K2
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:19:18 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v4gcV-0000N3-Vh
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 10:19:16 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b5565f0488bso1486866a12.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759501122; x=1760105922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=36ywwA0xwnnyvEA2yV5ieTqkFpwxjO0iulzgzaKGyQg=;
 b=N11enuMV3/IQMK1dIZ2GYzspzPwnt1qMRcOX3vusNGhOmiB+uo5yO+5v9BjmUbrA6O
 X8TSCjXOxy77pyxaTy9YtYEl9jVw5HIXqsIi0uxX/b5ajPnoYrMJrA8a2/QbzZJ8J2PJ
 C9sJlUfqIyTTNiQQ2EP5hGDRjxfMOqk+9DwWRjxxvopH1BSxCFHjb2ZswiJ1hQ3jN5vM
 AWXMbuHs/zSET96tT2uY0EceoansMe6Zx4+u2Wig7nSwhYXOMwyNp5PmkVKO2APlHYcl
 2vq9T968plII6aSYaOYj2sntKfxsV9QsQ2SjLFTxtkUO3dbsHVPbrRVpZqnKj/MNP9tV
 iVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759501122; x=1760105922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=36ywwA0xwnnyvEA2yV5ieTqkFpwxjO0iulzgzaKGyQg=;
 b=vx7HvLTkqrUa89lyEzxL3OAhw3WJVhEgoTyJj1qo4osW4DUOxVE/XKznWqJofrU0DY
 VqR9MmSMjBvdpIjlScRXXzteEWukPqvRkqiKDJK4YKY+wh3VxFHvBGDzaja77McOppAX
 qHreHBCGORacprAQcIxUrssYPSoHG9hajv8WZZze5SEBnStmdOnQl/vnraEW/ED0OAxl
 LsAZLXH1HL/+aoakCPC6XmHce+RW1LEvSSYH50vnEVnMZ8vPo+PzCIDDDAVNaImWbyIi
 UeHB+NYxZI8tmM1R73Un07iZtkT56RDpMRGtMMHQftR7YkYKe/VSpwfsBOlVxTisGAwb
 R7jQ==
X-Gm-Message-State: AOJu0YyhpV3/wwsX+VI1Y8+IB+KP3Jxx3yzXkMEn1kjMFuqp+FxV4qMA
 7SmQidPnKH8V97waG8+hEi6Ly5M15bp2IJ6W28uUfTPjrM9z5aJzjwPKBh00HkCojnO3rDZt1ch
 rzCAy
X-Gm-Gg: ASbGnctOF8XS2gd4ECLpd1UPOU8c6UEoFb5C1xqJ8i/0YuI45HjuxbIuMtS6ZzyMYj+
 pBcXjAGGwXk3xJlblHTsZ+rG80EZnwvK7IOrF/UVIcQQ2ilgkBubKIatjVU7rqG23BDyoBzZcW3
 CZv2yz8IjqPhH5lQ9XWTKy2BPMTN7NXvb+9FefuIAAxzTXg83ISL5i/yA7srJC8zG2WwoFndxVe
 3MxBO7jE+QbiDP/0UWF/0WbYkWXSUj8lVlwkhN2tpIBqKjIIfhOscNFHfaII79Mdkb4sMGiMbQo
 q38Un7aP7AkO0eix+23s33dmjR3MQOez4WpnxO2knlt6lOFFBsMCS2HapwpnIjF2PoutFrRRSVK
 6Lu/wG+/KZ2cSTY/ygJHiE8GKIDm09UXEteKjC1i4oedAGzwsX4hi/ML/qbVR4KXXZPk=
X-Google-Smtp-Source: AGHT+IFjhJCU5DxddGJuyYQME4TVXPdctW8arvWNt7QxkoBl23t6s/q6lhNoWz+yuanfdIP6PuP4rw==
X-Received: by 2002:a17:903:2f0b:b0:269:8fa3:c227 with SMTP id
 d9443c01a7336-28e9a543bacmr34428145ad.8.1759501121615; 
 Fri, 03 Oct 2025 07:18:41 -0700 (PDT)
Received: from gromero0.. ([186.215.59.111]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1d5635sm51759645ad.102.2025.10.03.07.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 07:18:41 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH v6 5/9] tests/functional: replace avocado process with
 subprocess
Date: Fri,  3 Oct 2025 14:18:16 +0000
Message-Id: <20251003141820.85278-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251003141820.85278-1-gustavo.romero@linaro.org>
References: <20251003141820.85278-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


