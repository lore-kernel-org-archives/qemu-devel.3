Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874BFC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7Lc-0002lt-CK; Fri, 15 Mar 2024 09:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7LS-00023b-Sm
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:11:35 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7LQ-0000AV-Pz
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:11:34 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so5314645a12.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508289; x=1711113089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7krNd92WPqJ39NLap53W9GJe07xrMw6PHe3R7xrqxWM=;
 b=BWnjLFnXXlmJu70EwoZx5utFUbZESrOWOKiu08nol76WHKVaL0Gd+0+gxcYRBmdpZX
 Aa+cuIf1Zu+5IE/d1GUglvhw7IzgVhzSyZJDqU+FKkhPFPdhgPOIrsjYzmD5FvLlUp/8
 8coccDli3PEfCoLmdaa1YcKwLeDuK//3SP00SeZhtYlONgQoGAgrKvpUiStJKxPhkArd
 sG5PIXxmEMVrkOHxmQq8ZY82EMQCGR7qXNHKd3Z2yX2WoWzDgam4BZci4ymtnH3TemCu
 lHlbnj9SmBmhlRlZb5S8XPGldKGYtduBRbTAURJCBu/tgvgLn3ol1d/pEyhq6Bm8jq4S
 hmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508289; x=1711113089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7krNd92WPqJ39NLap53W9GJe07xrMw6PHe3R7xrqxWM=;
 b=DLFThhRPGJdS98pybXp6VRILLfpElPLLxsXQZbugfB/l1DmPbi6lT8eBf6+1r21eO4
 5bJMomunkIkMkGxiwHxRheajLEGZU80WOvCyAzM6PfsaH95fkVr4KCzy5yCkSCJknxWu
 Oqy+Z4q2GszKY8QYpRq/9A8FDomcpRe1LuTdpUtAV22b+4+aVQ6Ub1yw5R8V0G8K+M2Y
 owVhwx1s2fMbYLXsDmjnMW8MQXGIEokwKh3U+LRaVLJnlEFPzZz3NG3NHcIKMJogJvIb
 Z7V3P614mXeU38DpD8cFl/Q4TSpWXj8NMUhaWdvFx9os+z79tXn5I2Jo+k4EGH1WeonF
 IQPw==
X-Gm-Message-State: AOJu0YxDnRSJAeSFZH6nsj+ABwiyPeS5cQ+8QQprE9bbN8HLGoePs7K7
 49FosOCc4qPjmsSmzXL39NnPw9m7rF9aDVOwFEZNx8hoLEq1c3ZqdSi3VWfwSmtftd8kWrDAgf5
 b
X-Google-Smtp-Source: AGHT+IEb42cna/x04lM5DiSdhs0k3LjaIjnT6Wg5Bf0xjqY0TjKqIhJx4flZw37llsIVeEyPObqtng==
X-Received: by 2002:a50:8e03:0:b0:566:1952:afc4 with SMTP id
 3-20020a508e03000000b005661952afc4mr8530918edw.6.1710508289058; 
 Fri, 15 Mar 2024 06:11:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a05640243cf00b00566a461e1ecsm1656368edc.73.2024.03.15.06.11.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:11:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [RFC PATCH-for-9.1 20/21] target/ppc: Use QMP
 generic_query_cpu_definitions()
Date: Fri, 15 Mar 2024 14:09:08 +0100
Message-ID: <20240315130910.15750-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Register ppc_add_alias_definitions() as handler so we can
use the QMP generic_query_cpu_definitions() method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu_init.c     |  1 +
 target/ppc/ppc-qmp-cmds.c | 26 ++------------------------
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index d5e227a6fb..3b500c95a4 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7348,6 +7348,7 @@ static Property ppc_cpu_properties[] = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps ppc_sysemu_ops = {
+    .add_alias_definitions = ppc_add_alias_definitions,
     .get_phys_page_debug = ppc_cpu_get_phys_page_debug,
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index 528cc3e4af..267dd84718 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -29,6 +29,7 @@
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "qapi/qapi-commands-machine-target.h"
+#include "qapi/commands-target-compat.h"
 #include "cpu-models.h"
 #include "cpu-qom.h"
 
@@ -175,20 +176,6 @@ int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval)
     return -EINVAL;
 }
 
-static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
-{
-    ObjectClass *oc = data;
-    CpuDefinitionInfoList **first = user_data;
-    const char *typename;
-    CpuDefinitionInfo *info;
-
-    typename = object_class_get_name(oc);
-    info = g_malloc0(sizeof(*info));
-    info->name = cpu_model_from_type(typename);
-
-    QAPI_LIST_PREPEND(*first, info);
-}
-
 void ppc_add_alias_definitions(CpuDefinitionInfoList **cpu_list)
 {
     for (unsigned i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
@@ -211,14 +198,5 @@ void ppc_add_alias_definitions(CpuDefinitionInfoList **cpu_list)
 
 CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 {
-    CpuDefinitionInfoList *cpu_list = NULL;
-    GSList *list;
-
-    list = object_class_get_list(TYPE_POWERPC_CPU, false);
-    g_slist_foreach(list, ppc_cpu_defs_entry, &cpu_list);
-    g_slist_free(list);
-
-    ppc_add_alias_definitions(&cpu_list);
-
-    return cpu_list;
+    return generic_query_cpu_definitions(errp);
 }
-- 
2.41.0


