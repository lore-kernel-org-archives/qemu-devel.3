Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FAEC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pWq-0002Eo-NA; Fri, 18 Apr 2025 13:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pWp-0002EJ-RI
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:27 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pWo-0008JH-1q
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:27 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so1314230f8f.3
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997364; x=1745602164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUv7xYWDzHHzMK/N8rDgT8hWryoWJfomJANZY/+TOFQ=;
 b=IwAonEaD/RQzgdTLFLRlvNPNbfViqS0trmWKlCHiUqIzO8mJ2PLmzeU8f1eWibb35X
 7XkrbrGt9qE23tTA4GfM7OT5qUQXTcAJH+2aZUmcDnnHqzeOywzcyv944ahhToahcAay
 wZmO+11YeDnE2csH9iv7ORvS2yZeEEgS1MpUCZZquteQl6c/9zSoRGp/dlOENnPaTK4q
 mZ0o8ELBKHr6gU0+69c9H6sz67iRirkefZUZH79ghiAOjwtb8r8iF4xo7N4dTiMSla6X
 tVToAKDgl0HzSTxx9YVwV0AYvcqSb+2YjIltmDdQXnpTZ+XLhep596Qxt6EpyvspHBgx
 k9Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997364; x=1745602164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HUv7xYWDzHHzMK/N8rDgT8hWryoWJfomJANZY/+TOFQ=;
 b=gp333s0wZZrp8Iw73ywsVTCkSIIcszQIXTkqARp2YElHa0qdIzne2TMac59ANBGiGS
 3XeErCpy0RtaEgrzP73fknlEhMoI0y2c35sa62w1Yz+xr8lLY8qe8hSs2fNLXNlarUiQ
 dxmxRCGVefV+ZqQ7N5FxruFVsNLrmLbN00OQZfD/lvTTDCUk0/2xDqsqIAPjMMta6TXh
 XYNgfWGPD9CaoXp6bDirkhU8qpqq2GM6gX3jJyPXTUiyTCGvnOLEEJq0doOe95itfe3Y
 OvMVBAlFHo7woYQ4fe7HNiJ4kA+VOSYFisQ79vsGzlGycU6zEB19QhljSC6pTmCWaJi9
 900Q==
X-Gm-Message-State: AOJu0YxcUePdgUR3lTJ5BUKK2hi4x6JaWEN3QBfnr/C9oJSjLcBCPzQg
 5h/bLwjD9aWWtdwp38Uwzc6aPNVEiiOILCEy5RlEqgxAmcWCV9TXS2uidhgrvdjqVpZKqpjtZ4w
 D
X-Gm-Gg: ASbGnctXqZcIFHswGotpYaPwlMHyOdg+QsJ5Svcxx/lckWAA2SRQ8riW5ptL+XDbJt1
 5BiXiKGNiiHLm2R0LM4Jp7SVzpw+jgxgxxRSusu69Mgzp+lYb4uL+UuR+bUa79pXXOnYdgZviki
 rBvJN0IWD+azl2f0d8hm0S0CpBAQPwPJ08+K6F7Hq4D/Jv9XzKKzF74Vf8m2S8wSOOyhF1609My
 g5V1pzXt6Uqc0YczDiUeI4r42hVpP0IAs0gx+3BnQSKR22v3FLVINRi6rwjB5E9D8pYUyC4hUd4
 rNp+K2LX3wJ2S+hql5NM6Tau7shWDKP9GPdhVN1Pn8+UBs3SqyTESPG7pgVqluVMqvh49vO5nM/
 cDiA2osyFBoL0OBE=
X-Google-Smtp-Source: AGHT+IGldGwn1GCDW4yVVSOvjg0PJ6K4CW+dwUxBKiKTRc6wnymhLmXz4FgDTf2uuMERYG3bJDZgpg==
X-Received: by 2002:a5d:648b:0:b0:39c:1257:c96f with SMTP id
 ffacd0b85a97d-39efbb1afafmr2695077f8f.59.1744997364004; 
 Fri, 18 Apr 2025 10:29:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4d67sm3338940f8f.94.2025.04.18.10.29.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 10:29:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 03/14] system/vl: Filter machine list available for a
 particular target binary
Date: Fri, 18 Apr 2025 19:28:57 +0200
Message-ID: <20250418172908.25147-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418172908.25147-1-philmd@linaro.org>
References: <20250418172908.25147-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Binaries can register a QOM type to filter their machines
by filling their TargetInfo::machine_typename field.

This can be used by example by main() -> machine_help_func()
to filter the machines list.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                     |  1 +
 include/qemu/target_info-impl.h |  3 +++
 include/qemu/target_info.h      |  8 ++++++++
 system/vl.c                     |  3 ++-
 target_info-qom.c               | 15 +++++++++++++++
 target_info-stub.c              |  2 ++
 target_info.c                   |  5 +++++
 7 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 target_info-qom.c

diff --git a/meson.build b/meson.build
index 49a050a28a3..168b07b5887 100644
--- a/meson.build
+++ b/meson.build
@@ -3808,6 +3808,7 @@ common_ss.add(pagevary)
 specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
 common_ss.add(files('target_info.c'))
+system_ss.add(files('target_info-qom.c'))
 specific_ss.add(files('target_info-stub.c'))
 
 subdir('backends')
diff --git a/include/qemu/target_info-impl.h b/include/qemu/target_info-impl.h
index 11b92796b28..e3344278a92 100644
--- a/include/qemu/target_info-impl.h
+++ b/include/qemu/target_info-impl.h
@@ -16,6 +16,9 @@ typedef struct TargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
     const char *const target_name;
 
+    /* QOM typename machines for this binary must implement */
+    const char *const machine_typename;
+
 } TargetInfo;
 
 const TargetInfo *target_info(void);
diff --git a/include/qemu/target_info.h b/include/qemu/target_info.h
index 3f6cbbbd300..c67b97d66f3 100644
--- a/include/qemu/target_info.h
+++ b/include/qemu/target_info.h
@@ -16,4 +16,12 @@
  */
 const char *target_name(void);
 
+/**
+ * target_machine_typename:
+ *
+ * Returns: Name of the QOM interface implemented by machines
+ *          usable on this target binary.
+ */
+const char *target_machine_typename(void);
+
 #endif
diff --git a/system/vl.c b/system/vl.c
index d8a0fe713c9..8fb18f82e20 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -27,6 +27,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/module.h"
+#include "qemu/target_info.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/qdev-properties.h"
@@ -1564,7 +1565,7 @@ static void machine_help_func(const QDict *qdict)
     GSList *el;
     const char *type = qdict_get_try_str(qdict, "type");
 
-    machines = object_class_get_list(TYPE_MACHINE, false);
+    machines = object_class_get_list(target_machine_typename(), false);
     if (type) {
         ObjectClass *machine_class = OBJECT_CLASS(find_machine(type, machines));
         if (machine_class) {
diff --git a/target_info-qom.c b/target_info-qom.c
new file mode 100644
index 00000000000..a6fd8f1d5a3
--- /dev/null
+++ b/target_info-qom.c
@@ -0,0 +1,15 @@
+/*
+ * QEMU binary/target API (QOM types)
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+
+static const TypeInfo target_info_types[] = {
+};
+
+DEFINE_TYPES(target_info_types)
diff --git a/target_info-stub.c b/target_info-stub.c
index f15972c5b22..14e6d5e68d2 100644
--- a/target_info-stub.c
+++ b/target_info-stub.c
@@ -8,9 +8,11 @@
 
 #include "qemu/osdep.h"
 #include "qemu/target_info-impl.h"
+#include "hw/boards.h"
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
+    .machine_typename = TYPE_MACHINE,
 };
 
 const TargetInfo *target_info(void)
diff --git a/target_info.c b/target_info.c
index 48c4a413326..1de4334ecc5 100644
--- a/target_info.c
+++ b/target_info.c
@@ -14,3 +14,8 @@ const char *target_name(void)
 {
     return target_info()->target_name;
 }
+
+const char *target_machine_typename(void)
+{
+    return target_info()->machine_typename;
+}
-- 
2.47.1


