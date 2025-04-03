Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90394C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ULC-00049G-MI; Thu, 03 Apr 2025 19:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UL9-0003vi-VS
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:51:20 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UL8-0000qz-Ag
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:51:19 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso10148175e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724276; x=1744329076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9D7OVdkybNmWN2++NNfk6FW5LKGK74MGZPvn0u97ZU=;
 b=hbCX75dGzV61rvsaqORDQlXql59mPdvHBd9bXleksi4qlHwQWkeQE2jb8R6ve7BzYI
 up+jR91Vh8JVVsAYmsLws2mh0xTS5rPFxebeqVIpIawPPE8shOds4VjyGm2QJL/iTw9i
 N7aaOdYrtgqZMnOxNozUQ45xJ2an/HD933ZQZ1pz5quaN0C27UXxUId1d9mUW/eUNCqQ
 6N/JwO4iFzn8fhqOEI5DDrexXcUGDmLKFvfW7FL/LX2XG/NHXxS88zgoCQPI6HZXBnfu
 dqnGVikn7L0sFv5HZpLtn2mc6MlI51FH6TftGUGpipVO9S+E83K+1YRG+EOzYNUY1Pla
 I3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724276; x=1744329076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9D7OVdkybNmWN2++NNfk6FW5LKGK74MGZPvn0u97ZU=;
 b=lGHq/WHHa+bcUGAzzIXwRytMcvOuXrFqwCkDO7UgVoD6yYWhRHBdZH6+E3T3DkGd4X
 3vN9Txa8yV2Dcouakr4efohiABvOjq87vcgSDGrmBomD8YcHPs6y3gqlKI7ehmrzkPG6
 EpbPyvWyqYtxFPPMucQoujzLJEdoZkjhv3sRPdo0c3SxxpD/o9Mxu89tLelD+xsHM7FS
 VKRkWd8J8bST7Cwd2rmXGIn/sysbGHBGR6t0fB87jxklS0odDuFXmcr+ARvpwXr8nyUW
 OQ1Papnoms4eJW5abItQBNFYIBv7AekzDwD2QyzcLyzWbE+wpntenH0R2WhYTNBjzjm1
 nInQ==
X-Gm-Message-State: AOJu0YyVWFQQZHxqygHQx6VpJ8V2uc83V4BF9lnRi32j6mzXFXB7WyfN
 TenkWZPIdfdb4Xf328PGi8bEPbEoykLqv0pQVHa9WJfR9KVOt4pDVpDXwl+zW9PzJhxvx4ePpMv
 A
X-Gm-Gg: ASbGncsnWkgcsLjTQkCjoYdhNp9TUkCsLN5pKGdVWHinuX1zmOM1XAcmqV50xFotvnR
 15X3pTzrGuhwr4q/CclasIF2hhwRQK8hUyrNXWFg8JIeh/XDQxKJTIPX8h94dbQVqwjTXcu816L
 z1tS5TO5EDvdkvXlc2sZtHnn8PrvLrdQuEJf3B6Kha7sdG6a19UNZKV4f0qpbRYLsCfhWR8FvIA
 RTBbx2a/iS8/C9f8R8VUYUJerlVJJy1VRq7bD5rPC6LgrA9Z5WtXZmckZaXP6EoLExsRbpZBHVX
 49xGBSFPYx7PzxgzccyyDBsTotn4V2Eet1cb6wLFdiiDIOh5JQ9HuWo9TtHHFtgRHMqIeNY4gS1
 fKluesiYJeOYMW+EQkws=
X-Google-Smtp-Source: AGHT+IGQzFOPVd9EfblnjuoEmyq1WBRQCz9jGnAsvNTRikdtxoigS6IWtlOwtCWoUW5IeHoP9dQbew==
X-Received: by 2002:a05:6000:220b:b0:39c:2692:4259 with SMTP id
 ffacd0b85a97d-39cb35981fdmr993481f8f.21.1743724276616; 
 Thu, 03 Apr 2025 16:51:16 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a67a1sm2918546f8f.24.2025.04.03.16.51.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:51:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 19/19] system/vl: Filter machine list for binary
 using machine_binary_filter()
Date: Fri,  4 Apr 2025 01:49:14 +0200
Message-ID: <20250403234914.9154-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/vl.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/system/vl.c b/system/vl.c
index d8a0fe713c9..554f5f2a467 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -27,6 +27,8 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/module.h"
+#include "qemu/target_info.h"
+#include "qemu/target_info-qom.h"
 #include "exec/cpu-common.h"
 #include "exec/page-vary.h"
 #include "hw/qdev-properties.h"
@@ -833,14 +835,29 @@ static bool usb_parse(const char *cmdline, Error **errp)
 /***********************************************************/
 /* machine registration */
 
+static char *machine_binary_filter(void)
+{
+    if (target_info_is_stub()) {
+        return NULL;
+    }
+    return g_strconcat(TYPE_LEGACY_BINARY_PREFIX,
+                       "qemu-system-", target_name(), NULL);
+}
+
 static MachineClass *find_machine(const char *name, GSList *machines)
 {
     GSList *el;
+    g_autofree char *binary_filter = machine_binary_filter();
 
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
 
         if (!strcmp(mc->name, name) || !g_strcmp0(mc->alias, name)) {
+            if (binary_filter && !object_class_dynamic_cast(el->data,
+                                                            binary_filter)) {
+                /* Machine is not for this binary: fail */
+                return NULL;
+            }
             return mc;
         }
     }
@@ -1563,6 +1580,7 @@ static void machine_help_func(const QDict *qdict)
     g_autoptr(GSList) machines = NULL;
     GSList *el;
     const char *type = qdict_get_try_str(qdict, "type");
+    g_autofree char *binary_filter = machine_binary_filter();
 
     machines = object_class_get_list(TYPE_MACHINE, false);
     if (type) {
@@ -1577,6 +1595,12 @@ static void machine_help_func(const QDict *qdict)
     machines = g_slist_sort(machines, machine_class_cmp);
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
+
+        if (binary_filter && !object_class_dynamic_cast(el->data,
+                                                        binary_filter)) {
+            /* Machine is not for this binary: skip */
+            continue;
+        }
         if (mc->alias) {
             printf("%-20s %s (alias of %s)\n", mc->alias, mc->desc, mc->name);
         }
-- 
2.47.1


