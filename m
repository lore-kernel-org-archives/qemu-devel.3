Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B517BCAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 05:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v20p4-0004pX-5T; Fri, 26 Sep 2025 01:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20ov-0004mC-Lv
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:38 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v20om-00060k-AC
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 01:16:37 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-27d69771e3eso15166345ad.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 22:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758863780; x=1759468580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbcIM6Ru+KfZSzivGndOpNutXXn65xOK6v6HYqWFFQA=;
 b=RlxoGNi9EkVISz1yxgW+/7q+h2uKZrvIGgLLhx3hkYZxKoHWNRUq2Ht4nnYa/3qpOO
 HRfqfJFug3niFqBI+lrws4J1VOsAwSAJ42PiVXl61S+95drWrRYWXj7SdRI7opU8y+u5
 nyESgAPd7dcnfI3qJS2tTuaF/hk72flcxgVF2Z+lso8uGhUz4oQ4DQZig6CFyFtBl3g/
 CWVTnbIKgLM5fq6+NQ+//9Vuy1oDdo/QeTPJxGW8rY3O46KLPc5w+yXMeQGv7I9gZSHG
 N4NmJoAmWsxapFVSHBpq1hWFZOhaLOGLM1x6eVmP2qmhTi6UElHaFelrpBL3/WwQUaXS
 q0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758863780; x=1759468580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbcIM6Ru+KfZSzivGndOpNutXXn65xOK6v6HYqWFFQA=;
 b=VNl0AWHyJaWALC3Cqm9lbMXF6oEV+9xAgL4z4mjfKh127LcGAJugAtfQwOx3urLn27
 4BrIpJcUCLznU7ZxysEfJaoJWWatLzu/t7ED3wfPAKRjJTnMotEKXqFMGuRvvePP2UAf
 97M5QWGQzxHTo01N8hAJ9kIsBzrZGubxQN8oprrPIcpJdyYk2aT4gJt+M5vxlJs1gIKK
 Ii6OrKeBG2ph34sv70tFyuAYTEMbR6exJsR1NhoFo7Y57jf1IasInnvJEY9ApX7V4Cm+
 /fC/LIFld2qT1zRheMFesrFclHPGZ+QQnNGvsFoWQ1Xv5RGVlstT3SKMwekIvOC2Z3dy
 G1/A==
X-Gm-Message-State: AOJu0Yz9ctcifyCprAncobSSbok85814nJ4UvQMMGXgQnea/9a9UwyHL
 oeIYaofeljbUZ7VX8Za7iGU84MIonRLz+j8NtJDFfK9fpjhQ4eq2jrAM65YLfAvMWajmuZ7cMgk
 fN80E
X-Gm-Gg: ASbGncszJb+tpqSsPAvnwrJu33600rlwyEAKvQh+n+iX5xMcPQPtlfcacj0MF9D8Alx
 DO66L6rhbWXX02R/MKxEx38eQI0JoRfADRLPBchB10cAOIAgounx/yOX/MCWw50KO8ukFUKbYQz
 +pytUu+wDtc2iNNXSjd+gGsk1ZS895yhChM7iB4RpZorMoYxCTIXLJSagxDQrbiibi++0PRPDRq
 pIs1YOOXseP/UKY/kRNlNLz8PoaOwvtU+0jKG9FLleAGXvDbLyBzfVwQEFMRUMz3pIlndWRJLAX
 sNOr3J4Pe9+YilChvgppzi6bZQktmi3HlJ5OLGZt6Ap4KVOg7oI/UPqcKDBdTGdP9mK3bffJans
 svqgS03094n/PzXw1quMfzIyl0SWu/KOKdlqmb5CGMs+a7Q92ICz4OBz9Zg==
X-Google-Smtp-Source: AGHT+IE/+rh4i8OLGMJBItC4kYEuKliujmcOCqYvDVB8J8+aqhIAeK/4Jk9/mQ9ydvoYLkPl36oEeA==
X-Received: by 2002:a17:903:1a2d:b0:25a:24f2:af00 with SMTP id
 d9443c01a7336-27ed4a06c8fmr64226065ad.12.1758863780084; 
 Thu, 25 Sep 2025 22:16:20 -0700 (PDT)
Received: from gromero0.. (189-47-45-49.dsl.telesp.net.br. [189.47.45.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed672a51fsm42160085ad.63.2025.09.25.22.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 22:16:19 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com,
 berrange@redhat.com
Cc: qemu-arm@nongnu.org, gustavo.romero@linaro.org,
 manos.pitsidianakis@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v4 5/9] tests/functional: replace avocado process with
 subprocess
Date: Fri, 26 Sep 2025 05:15:38 +0000
Message-Id: <20250926051542.104432-6-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926051542.104432-1-gustavo.romero@linaro.org>
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62e.google.com
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


