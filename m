Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC080C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7La-0002dV-Cj; Fri, 15 Mar 2024 09:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7LM-0001Y8-6F
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:11:28 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7LI-000073-HM
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:11:26 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-566e869f631so2383325a12.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508282; x=1711113082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JlSnNkdCGhkGJY+zh070ayuUxIbMNrgyLxLLZYypnXY=;
 b=yx8CFeUcg5ujfCaMKT3THBflLS7I4ltCCOI+0Mpd+ZL8cVVLbQ431Y96W/IvF3+cf5
 m1JcXoknKpWaYT6rJrvJe+3ZS1tLB3ZnRhMTlw8UkqX2dAyOHI2P5c11g2jaMCC5iEzm
 b3zLWtqGm3H+wJtlK2mJaJAAjOydrgqNmRyWxQ57li2pUYa3xQUGWL81A2hJOOaeNhyH
 +tX9QJ36aXlA7qNGw3kQeeJ8KAe7OfNWIQ61dlMpMX9wgWtnLlOEdeVuEwLrQpNLthzD
 fR6s9+Z0eKGt9SnFXnLeHa91YINZkJad0foQ/a22J0ON/wl3EdYW+fxvoVkoFU3ilYSL
 aQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508282; x=1711113082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JlSnNkdCGhkGJY+zh070ayuUxIbMNrgyLxLLZYypnXY=;
 b=BEYhneevTCYokAvDVSo+f9Ly8bC6tA10e7ZIBVwwLkdnHH1VQsBfATVWgjWC9ifz1h
 q1mIRpzg9etDW2K7gLiyC6ZAFiPNuboVB//e8wB+rwPuOxzZjnj8rd9xUTPi667lTtmN
 nsTFaUm1VUiv2rJIebkmBYmnFUYIWjNRZDlLiygq01arnkj2GeXQqgo9iatb50GTW/ld
 Royva0Lbk3YWQuG68e2LNiODFesKlvorzPbUZvVJ2Jtjl+kcWII8uwB0+6GLgK0QWSYW
 PsJ3iWLXppr7gAb5K25UR2YAh3yFWX9GcAVD8Yoy/pWjK3CPWqIvgg2xFxITGTAr6qGJ
 HnXA==
X-Gm-Message-State: AOJu0YwEGh9CQRCKlGgNUkFbTgpio0d3qLURZfBELa+x+zoxrFcEUJPr
 KieKvI4XRa8Qqvix2CCqkRj559VTa2u+Sk2qr76YmYhMWnVwemPFaxBnFLIWY8P6nJ3A49ErZJ8
 Q
X-Google-Smtp-Source: AGHT+IFr5RaqknL50rJ/ULGqKtzSQvYODwR3uxqq5WvgAEMCCYd8EWNHRLvED+eSeGFqUTaVtHbaiA==
X-Received: by 2002:a05:6402:3819:b0:566:ff31:7974 with SMTP id
 es25-20020a056402381900b00566ff317974mr2662833edb.34.1710508282572; 
 Fri, 15 Mar 2024 06:11:22 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 er18-20020a056402449200b0056899fc9a94sm1673226edb.12.2024.03.15.06.11.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:11:22 -0700 (PDT)
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
Subject: [PATCH-for-9.1 19/21] target/ppc: Factor ppc_add_alias_definitions()
 out
Date: Fri, 15 Mar 2024 14:09:07 +0100
Message-ID: <20240315130910.15750-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

Factor ppc_add_alias_definitions() out of qmp_query_cpu_definitions()
to clearly see the generic pattern used in all targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu-models.h   |  4 ++++
 target/ppc/ppc-qmp-cmds.c | 26 +++++++++++++++-----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index 0229ef3a9a..89a5e232b7 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -21,6 +21,8 @@
 #ifndef TARGET_PPC_CPU_MODELS_H
 #define TARGET_PPC_CPU_MODELS_H
 
+#include "qapi/qapi-types-machine.h"
+
 /**
  * PowerPCCPUAlias:
  * @alias: The alias name.
@@ -480,4 +482,6 @@ enum {
     POWERPC_SVR_8641D              = 0x80900121,
 };
 
+void ppc_add_alias_definitions(CpuDefinitionInfoList **cpu_list);
+
 #endif
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index a25d86a8d1..528cc3e4af 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -189,17 +189,9 @@ static void ppc_cpu_defs_entry(gpointer data, gpointer user_data)
     QAPI_LIST_PREPEND(*first, info);
 }
 
-CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+void ppc_add_alias_definitions(CpuDefinitionInfoList **cpu_list)
 {
-    CpuDefinitionInfoList *cpu_list = NULL;
-    GSList *list;
-    int i;
-
-    list = object_class_get_list(TYPE_POWERPC_CPU, false);
-    g_slist_foreach(list, ppc_cpu_defs_entry, &cpu_list);
-    g_slist_free(list);
-
-    for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
+    for (unsigned i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
         PowerPCCPUAlias *alias = &ppc_cpu_aliases[i];
         ObjectClass *oc;
         CpuDefinitionInfo *info;
@@ -213,8 +205,20 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
         info->name = g_strdup(alias->alias);
         info->q_typename = g_strdup(object_class_get_name(oc));
 
-        QAPI_LIST_PREPEND(cpu_list, info);
+        QAPI_LIST_PREPEND(*cpu_list, info);
     }
+}
+
+CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
+{
+    CpuDefinitionInfoList *cpu_list = NULL;
+    GSList *list;
+
+    list = object_class_get_list(TYPE_POWERPC_CPU, false);
+    g_slist_foreach(list, ppc_cpu_defs_entry, &cpu_list);
+    g_slist_free(list);
+
+    ppc_add_alias_definitions(&cpu_list);
 
     return cpu_list;
 }
-- 
2.41.0


