Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCB4C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcNZ-0000iH-8o; Thu, 15 May 2025 13:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcN4-0008Hx-BI
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:50 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcN1-00026e-99
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:49 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso1674330b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747330066; x=1747934866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNI2BFFgTeljdJ/HtYFFxLLCliw0wPHFB2HapKUt6b4=;
 b=c2Ib+CYyfD3gs345IJ1hW4Chv1HTMXFmSCzoY+JX9iqbvHaKuw4W80wMtOvO3F3sds
 EQmelCyrGYgoaeCzu7So2kEry9r5I1BDsHMcKO8wGwq1ef0BgOC1bDZv4AIf7AwK6udN
 DijLEJ71zosGcaKeAWIah9iRI0rPsNZ2pnRxQ8y7629niIZ9YpU6gvpBsl0uPHzwtp+8
 +lQ/8UbZUwgU9H3BnbvNgo0cc99mpz+vqcfJaLoelnV+3szSYKayMgZzeQT79Gu3TbnJ
 KyWJtkKw62ou4Odv8dBi5ovcOBq12IOFjTfUfqsgjPuBa2C7j+WquBRm/qmIsG6OvG5I
 72JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747330066; x=1747934866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNI2BFFgTeljdJ/HtYFFxLLCliw0wPHFB2HapKUt6b4=;
 b=m8Z2qQDJ+EQxBaD2X9mP4cKqDkFRvg0wXbWPi7Bpt6Kwj3+lr6s7bvyUQIjKEqgVmF
 5VOHmoWb91vpjqhCCGXLNOm8joUgE5V+vu1J9fret8skrs3Ud7kUjSE7yrRgEbjUe6Xe
 UpuowZ972xxUvzd4OPE7+HJ0vHcxFHnzc5b2zfMrNbTuygaIP6HLHuMDKptOUgm0HPTE
 m7EwhotCfXgN2DKCk0ES9rHnMZNm+rPD5+T1NyI8xbuyv+nnyK0A7QKRmi9JgJasQUNr
 tqnYKRtLRN8pyol+abJ/1GTDIblmtvDvW4sWRvfuLnKx98/YSSDfLiBUlrplYuVR3gPh
 Eksg==
X-Gm-Message-State: AOJu0YyVTcfswMjn/Ec37Byove4Y3J6hy5Ns3Zq+nJfxsxaaPBMkzSbS
 2MeqRmZaBbhJQOMK7VGHkBg/MnhPcb5NRSuJ3jcaxBdxBLWpsfD3hs/PeG7aKMB/PDqZUSVBGlw
 nqYhF
X-Gm-Gg: ASbGncsst6Mo4amH+Y/mncq6IiI/FCYcI8UzJSzfYqeildpB9yEnR3r7nGrT4Ryabpc
 wx2xb0YwmDmgBlqesKaupt/g/LDM6u21tQojuvzKVn6IhqbCoLUY9QbzyZeh8M5GE4HwqWNGL2s
 7uMMJ7vphsJd4MFQyQ68HhgDE1wntEMei1v8bSQo+bZuAVM9ZWZZZGVEQO+w5XCtlLQyUty5iWR
 KWjZzwI2ODUyMl4IcjdnXklwoQzCdJddEAcrOi5lqvoSE/cF0Y4hLNe1HFWawW+q/kqaIy25Q4N
 FrEP/C5oIBB66hOy7P7FXK4Lo7AFbgjsFTvwTEDjoFet+QSUija5afCU2e8chQ==
X-Google-Smtp-Source: AGHT+IFOtBX+PK4J5MAkSLQdI3ff/BySXyYknToFkSB10/i1EHm/I9TdHIitFPmpbIYFUhNyChvP4Q==
X-Received: by 2002:a05:6a20:7287:b0:1f5:a3e8:64d3 with SMTP id
 adf61e73a8af0-2162192a995mr497853637.21.1747330065758; 
 Thu, 15 May 2025 10:27:45 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96dfa9dsm79730b3a.10.2025.05.15.10.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 10:27:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 07/12] qapi: remove the misc-target.json file
Date: Thu, 15 May 2025 10:27:27 -0700
Message-ID: <20250515172732.3992504-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
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


