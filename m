Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686A7C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7LJ-0001Jo-7R; Fri, 15 Mar 2024 09:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7LG-00013c-8d
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:11:22 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7LD-000057-IC
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:11:21 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a4682272ff6so89356666b.2
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508276; x=1711113076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0JRGXmaH9yCo1gEGbOzPrdlVZvoU4tW4IJan5xxXVU=;
 b=dpSYf7EoNPRPNeSq2HIQBoHLvFQ2UGcH1RvNBtHwGT/soD+2Dlic7r908QHtOndpA/
 Zrb8pkasLpcIIZUv7MwWCdF7mYHXpu9ikJp2Toop3c3q1wC6isOM19NrA+nbbDFoZapX
 WJ76pBVlSC74QPoPDN4hiBosYmkTHQphJ8CuiDqQsrJc96sk+uOOuOV44kaZ+85kgbPK
 F+bw56lqdzyar5CPVtEzO7McUXQfGttVLEOi1KG61itplUWLtPWdmVXkhtDsEC7noLLF
 bQFyRHYCZdQ5Jv3nfuejymu3wbZWkg2tyISHT7HhDXCzLmc5TViLOvv0eUUWvJwcvgW6
 jK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508276; x=1711113076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+0JRGXmaH9yCo1gEGbOzPrdlVZvoU4tW4IJan5xxXVU=;
 b=HAa0nnhUUCtGxTgQ27bIEdsl5NwYo1StE4IHXquk+NPr7ysSwyD3IDmz0lBWs8JQUF
 UpkvDcVNwmB4Oma4NQuZ5rhYd6pSNxn61Ur/cBdXsWRyacQYEQ8Cz801cUKTDahAlahI
 7w7ms+/XDSqO005mXs7P5mdpdfT3+UX3rXMNMef/+Qc5becQjIRGU9UkzSHkjBlz+KDC
 am9zW37s+wZ3nomXUIGn6bTh5Ed9dW6vyN7u3MGmDAnQ3cU4uTUnl7DJHf7DRhT9eVBT
 wUCqbcAGqj4J/wJuh98NngJFQrPZmGFyMLhdY1zbOem6OnKx4VGPbkLD2T+NtSJL5iN2
 7joQ==
X-Gm-Message-State: AOJu0Yxy/CwVoo04QD2dotWyO8YATPlc3ISTjOtihy07k7IJ9Ul/nW/A
 EhrXrkVBWW7nbNuKwt82uMavvQQRtzKbvPvNBjWKE9U29EKauARQ4F6SftZcnDRQDZ+/8ZO16fO
 j
X-Google-Smtp-Source: AGHT+IH8DC/lPhj5k3DkFaXoEv+D5iiSC1Us/4T3OryunIMlcb3vrVAMN7YjcE7wkczxqJzYpIahqA==
X-Received: by 2002:a17:906:29d6:b0:a46:bb:c4e3 with SMTP id
 y22-20020a17090629d600b00a4600bbc4e3mr2733759eje.32.1710508275761; 
 Fri, 15 Mar 2024 06:11:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 dt22-20020a170906b79600b00a4669f6c2e2sm1672024ejb.44.2024.03.15.06.11.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:11:15 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 18/21] target/i386: Use QMP
 generic_query_cpu_definitions()
Date: Fri, 15 Mar 2024 14:09:06 +0100
Message-ID: <20240315130910.15750-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Register x86_cpu_definition_entry() and x86_cpu_list_compare()
as handler so we can use the QMP generic_query_cpu_definitions()
method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 07f64c1ea5..e5dbd307d8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -38,6 +38,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/reset.h"
 #include "qapi/qapi-commands-machine-target.h"
+#include "qapi/commands-target-compat.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "hw/i386/sgx-epc.h"
@@ -5667,11 +5668,7 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
 
 CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 {
-    CpuDefinitionInfoList *cpu_list = NULL;
-    GSList *list = get_sorted_cpu_model_list();
-    g_slist_foreach(list, x86_cpu_definition_entry, &cpu_list);
-    g_slist_free(list);
-    return cpu_list;
+    return generic_query_cpu_definitions(errp);
 }
 
 #endif /* !CONFIG_USER_ONLY */
@@ -7937,6 +7934,8 @@ static Property x86_cpu_properties[] = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps i386_sysemu_ops = {
+    .add_definition = x86_cpu_definition_entry,
+    .cpu_list_compare = x86_cpu_list_compare,
     .get_memory_mapping = x86_cpu_get_memory_mapping,
     .get_paging_enabled = x86_cpu_get_paging_enabled,
     .get_phys_page_attrs_debug = x86_cpu_get_phys_page_attrs_debug,
-- 
2.41.0


