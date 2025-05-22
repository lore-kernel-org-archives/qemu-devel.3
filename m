Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4D8C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBFA-00012R-8T; Thu, 22 May 2025 15:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEz-0000wV-W5
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:06 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEr-0006TB-Fm
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:05:59 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-742c27df0daso4788451b3a.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940756; x=1748545556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNI2BFFgTeljdJ/HtYFFxLLCliw0wPHFB2HapKUt6b4=;
 b=Rg8ehPIWU6S9leFG50xQ+fs1L6+VLfeiA7pE/QPeS7my63CaLfno77OD/pEXAu5uA/
 bQkZ0lYfjn0X3bA0fs+YcJoOmL1H6B95aJEyv8OSg6bPE2Z2mtKK8mthDT+y2FRyFNvh
 FQ3FB3fR/U+up8pYDhuVG0BLwKp9K96V1QbQArDvGgVM/ootzRE6kFMSJvZVntKoCZNR
 tGGEzU6YB8eCj2UCX+Hhz0c+D0nx8CECHWzFOx4CCTI7IwMDgkqA6L2/m1xC/PhFmb1E
 xu8l4whZckoZldb5PqPBNDGxvp6/yodtWa6cwAlqdEhQylDPOO5S1X5apy0fKSb/qSWX
 JhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940756; x=1748545556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNI2BFFgTeljdJ/HtYFFxLLCliw0wPHFB2HapKUt6b4=;
 b=qBO6FJT/wJL538fgtRMyIYtkSsQ6qB0dAXwUuPngyfz6dr4XIWNty+kxz4rBaST+nd
 Td+X6uvSWqaYClFCNyOE84/9sJq/Tiu3gbXUQvdggwCqMdRuzyXgpvKVJ5SP00Kros+L
 UAPHa+o+CxzL6+MmwF9EP/dMB59MsGixMp6HN3Hyc8t3pKs6vmuhmEFu1Zk3nCFlkVmA
 ybTZH8jVwOk8fLTkQH/skG2DU7QiD2QiqOoMM1bhJHRZsHQjzXhYkYIdx3j9XefAWc6I
 aun0jP9asKMaroi6Tl+1wM2xRXI8R+SG1b8pdRuFvC0G4zEGa9gNWjFtGA4UbmxzCj6x
 yegg==
X-Gm-Message-State: AOJu0YyxUF5G9xuLnauIfeYtHvfG4ZwdZitJ+fo8Szg/a5WQf/41PqYA
 UxvrCQTo6v/euQ0cHftHc3xZm/n6eP18lx6RHD57PWnWzvXvVtIRRo4Bk+pq/3ukRA/ZdBLEP2X
 cnEIa
X-Gm-Gg: ASbGncsBIqpopCEUhj1b/Z72iI5GTREKRGTh6dgYqg7DgsWkyinzdgkTzQeUPlQc6Ll
 TR+iGn3P7qvlZv9E6ytRwcqVdKg7OPitMehIjfiNzYwe9EFUAix1PuYq1gdKgV1+Z3Q7PBxemtu
 59KJbSRp79r/+vJEtMxZy+b1tD9D61BWBP0qeu3pYCtGuwCQq2cx8Nfynx6FM/a6ufesKnUQJWh
 RJFG3Q1K7bO+Q4KmjrlmL2m3sjyYF6Rr0Ep9MPNWGoe34FRf5bOvsGGfc4Hk6lIvaPVMSIGB9aD
 TBDmbpOKtotYhpAUWBHH3XQSYErQMnL4jFUz3sipBkjDcunADoF42U7NGlOT/WDGa+1Pa/4q
X-Google-Smtp-Source: AGHT+IEraNe+JzcmkB/LQFd8mdu9SOCRU8JiB/bWAFRAi2X2AeIelW/BUn/ItJbeDdqDqsHID1/6dg==
X-Received: by 2002:a17:90b:5750:b0:30e:3737:7c71 with SMTP id
 98e67ed59e1d1-30e7d57e4e6mr37868026a91.20.1747940756020; 
 Thu, 22 May 2025 12:05:56 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb082c66sm11625565a12.60.2025.05.22.12.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:05:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, thuth@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, armbru@redhat.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org
Subject: [PATCH v4 07/15] qapi: remove the misc-target.json file
Date: Thu, 22 May 2025 12:05:34 -0700
Message-ID: <20250522190542.588267-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

This file is now empty and can thus be removed.

Observe the pre-existing bug with s390-skeys.c and target/i386/monitor.c
both including qapi-commands-misc-target.h despite not requiring it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/misc-target.json | 3 ---
 qapi/qapi-schema.json | 1 -
 hw/s390x/s390-skeys.c | 1 -
 target/i386/monitor.c | 1 -
 qapi/meson.build      | 1 -
 5 files changed, 7 deletions(-)
 delete mode 100644 qapi/misc-target.json

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
deleted file mode 100644
index c9ea1ab23e7..00000000000
--- a/qapi/misc-target.json
+++ /dev/null
@@ -1,3 +0,0 @@
-# -*- Mode: Python -*-
-# vim: filetype=python
-#
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index e96bff8d38c..d8eb79cfda6 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -63,7 +63,6 @@
 { 'include': 'misc.json' }
 { 'include': 'misc-arm.json' }
 { 'include': 'misc-i386.json' }
-{ 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
 { 'include': 'acpi.json' }
 { 'include': 'pci.json' }
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index aedb62b2d31..8eeecfd58fc 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -17,7 +17,6 @@
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qapi-commands-misc-target.h"
 #include "qobject/qdict.h"
 #include "qemu/error-report.h"
 #include "system/memory_mapping.h"
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 3ea92b066e1..3c9b6ca62f2 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -29,7 +29,6 @@
 #include "monitor/hmp.h"
 #include "qobject/qdict.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qapi-commands-misc.h"
 
 /* Perform linear address sign extension */
diff --git a/qapi/meson.build b/qapi/meson.build
index 5e93e6b8cfd..ffe44f9e0b8 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -42,7 +42,6 @@ qapi_all_modules = [
   'machine-target',
   'migration',
   'misc',
-  'misc-target',
   'net',
   'pragma',
   'qom',
-- 
2.47.2


