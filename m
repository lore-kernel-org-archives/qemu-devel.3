Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD1DC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 23:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFLj6-0001b3-UH; Wed, 14 May 2025 19:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLj3-0001UP-Hp
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:25 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLj1-00034B-PU
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:25 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b061a06f127so155779a12.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 16:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747266082; x=1747870882; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fhznFiZ4DXOyyQJkQhZKKsgkcFXUowb7pCXLQasEuQM=;
 b=cq4D0JnVKyRtZ4vaaOe4X9xOQyCVjy4bXGBxSV5rmSC2juf6LRf8Z9hxveXtDHUQO0
 cjgsd3nZJHoombGJXLPZBdQIR01yakw1Z2G3NEEh4+K+mopoCUCoJwlW4lFHR1KF+QT7
 u1p8ioKt63ijjnAi32k2sZuCwZ8lfxihQERtpRzSUouAgajLD+7AnltJ+6V12Xlzz5QG
 597zb0WrGN6bOTd/hK4AJ6PkvagrIB6akwRct4MpqIui8uvg/sjl2NPA20smdCOk/dpp
 pPycFai4F8WR290UJMPQn0obPxML2FGkMPgEOu3xqt/hV8gT5aUtNYKaEyya+QXR6poJ
 xv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747266082; x=1747870882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fhznFiZ4DXOyyQJkQhZKKsgkcFXUowb7pCXLQasEuQM=;
 b=eUiFiVjlbRFVegg79svQcQKuoQUnJOjeoSgtOsoa87LnCbtkuByx8Hw6RtIzjSJWVo
 r+ts0nWbx/v/oY+7Ytgl22BOW+/JeyJhuF7c0vYYW9TuXgLqhG//Rg8rAAYYBciuswPu
 1RxkgZkr4d9ADZHrsFFD3nKd6HeEPWQYgLTwIwcRQHagAdDRbC3mTKf41O0NZ7J2V8Xx
 kdU6e9JZoFCRrK0UT5zRSUq6Ft+GXBX9GQ6K5Xq/DqjWOzPwBqTdHKSxDNZjp9ILFsZa
 u2LJlUDjq6H+t6izNvu4Hv/YehHdJPecb5630FsFWkvKwqtnBRaZgZpBkfxgrc0NVtU8
 XQeA==
X-Gm-Message-State: AOJu0Yy/hhx9Fe3WJhICxxlLPAu8TKepyxv/nHajaUZt8OGUuLKkltpm
 WrUiRaKP0qnnx/bLxgZGGabSIq6P7X7SzrxiQGd6KY7iPqyAL6gz093FAyjLBZs7u4yCbbJlt0J
 YM54=
X-Gm-Gg: ASbGncseJMLDhfL5UH5M0jyYgXNfnxF7fYQqdldZN4vXn56CMe2XQ2Z6b9rB5e86uS3
 6mPbzQBPQuADAs8i3n4xm8db4XqXo+cerqiSwHmbH+I51hJzA3b6rlKFBAsLotnsZS6F42m5Y6A
 BWp/ISkEeOh+Tp+j6JGtn/LesAF0D5RMdOIAjQ/9MLN1iw7MzL9F+7QIDUABYQs6wZ2mZVggljH
 SpTNuDZAovILjCc1B6ep6NCi7u+iinUvShdfsn1qXgvV3C7oj2U6xlrQVx0uZhuE34oNppbMM6e
 K9EeTwvjJroxWyTHZW6XIeetwHnm1J1jn6spmE2rrSCj8m59awk=
X-Google-Smtp-Source: AGHT+IFLAwzV+QjWM1Pm8uGfJ3BjybdSDMNP4ia3o3nBGZVI3Z+oYY5EhbWHgreNYVLDQlBEcQ817g==
X-Received: by 2002:a17:903:f86:b0:224:11fc:40c0 with SMTP id
 d9443c01a7336-231980cbea5mr76350485ad.11.1747266082331; 
 Wed, 14 May 2025 16:41:22 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc828b4e4sm104583615ad.182.2025.05.14.16.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 16:41:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/12] qapi: remove the misc-target.json file
Date: Wed, 14 May 2025 16:41:03 -0700
Message-ID: <20250514234108.3746675-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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


