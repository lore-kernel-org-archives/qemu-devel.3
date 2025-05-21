Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE93C54E90
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs4V-00069N-68; Wed, 21 May 2025 18:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4T-00068X-PK
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:37:57 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4Q-0005ZF-SJ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:37:57 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-231f325366eso54220415ad.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867072; x=1748471872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CNI2BFFgTeljdJ/HtYFFxLLCliw0wPHFB2HapKUt6b4=;
 b=v7aNJh8qe/ADLuGHtUs+g1GUWtDz3OjlZb7te0zH43f6efcS6QVGyVMVvpvza0cMlH
 gcffvWOkV1VFth86BlXm/Iwmhf8pvIggCi6U73bJ0U34xGKjXPt0mUS9s7HO9QsfJGkC
 t6zWtdyXYovuoaYUI8EX1ZZLMiRtaW2CbuCjex4gokJpDxSSWdubimf/qEZ0YDZJ6zvN
 N6FU0/pn5nwcwjgmmXqAmiHJ5TVDEBFbunHqvdGwQe8SDCJOWl2scJGIxlKVJTckqq0x
 I7bEiHG3SP+NZ4himnRUUJqCQitX1/1a1kIFEErB1xdUMKRN9fdODVN8NzaZjLjgxTKR
 14ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867072; x=1748471872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNI2BFFgTeljdJ/HtYFFxLLCliw0wPHFB2HapKUt6b4=;
 b=adIWXmzReNFA2UJX0G5bZpDD4sdJKzE0XB6hWWDOkb0xphyzV8S8+7SWuV5dhjBwfO
 i0MQYREkJWSZNB/DQTz3WGfG9jTrawPBb/edW8W4riO2AtCOTzcrE8zh/dLd6lAQAPwm
 1KVeL6qFh0Dvw4/orH0MgioXGKxT5OXiGzcpTDxWw2tu0BEc2fLsecE4f5K/j34c4DV+
 HgnxfqMejJUYXjk3cyNUjtW8o3WlhWPUQeZxOqFWi+2e8dTK+Tt5W9RuHGGv2u/mbxFG
 W1yDl0AP3UtfZ/Ne02bFGS1+weoFc4GWBMhCUluQvGSui0opTjSCRaCtxwTkPNMPYD/a
 NDTg==
X-Gm-Message-State: AOJu0YyEz4TQgpvSmCEeaMjvzRdRJxuEGq8wK++qZLIGoz/FeOCNSM+0
 XiAO1I3KrBKUYdYkI31QKqj+8SnJRWpkf5Coo/l2/XDXMG0llabVgk5k/pmrkekQ9gKwa29XH2s
 Diy27
X-Gm-Gg: ASbGncvVea/Fmf5B0bwRKhfqOPboi+ESZOo9fky1nz72t1scDcEaO3df9SF/qDuiXwc
 YeNegPk88uoaXlNErIMlTapWlyBlKre7d1Zd+LCM/ImipawSHdR30EJIUDGH+oBMZidQoOqM/jO
 HcjL+6jyGsevSENd/cwI0W0N4Uv4lRdWLsoUGEIrglZhu6NF86JWPjuy4Wh3XJrRLmzW1ATfI+8
 f7BemWLjVk15lWSZLJfOMHSXKVu5sMbO8Q9qswOgR+PzwOUyUMpxYUqZigRL77646zoThgQaSDS
 l7JbS92VuYkKIA4LuSMQhLok9cJRJCv6ahb3wpQFzDbuNv+LBu8=
X-Google-Smtp-Source: AGHT+IHpF3vp/q1A6PZTOwzZ4asCwNz93jgjFKoNIWjfUvpXIXv9hogujs6KBzSbOMSjQQLySNFpBg==
X-Received: by 2002:a17:903:174c:b0:232:2f8a:fbd7 with SMTP id
 d9443c01a7336-2322f8afee0mr211615985ad.11.1747867071748; 
 Wed, 21 May 2025 15:37:51 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dcesm97711105ad.121.2025.05.21.15.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:37:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 armbru@redhat.com, michael.roth@amd.com, philmd@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com, thuth@redhat.com
Subject: [PATCH v3 07/14] qapi: remove the misc-target.json file
Date: Wed, 21 May 2025 15:37:33 -0700
Message-ID: <20250521223740.249720-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
References: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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


