Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79471CCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJGx-00054H-VA; Tue, 21 Oct 2025 16:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGi-0004xx-JX
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGf-00015H-IY
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-471066cfc2aso14340715e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079657; x=1761684457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=143/y5s/Vd8n0Hn2bxYMjnN4uzh0g8+kJFFukw13gN0=;
 b=xJibc5ggTWdlB6efdqYvT3kDFqrUn2DKOD1XrDhOvZ2OjPqL5iwUy+axO/PK+XIwIr
 4jPhIhSPCjijk0EL1otPmQ5W2T0eGgDzv6fDVI3Wn1EYWgwLQyT+JCTCFHhxRv9Sl2jt
 K8nCeoloJSbFlA84raQPCpYtjJzrjA3oJByKsTwwBy2r7K7t7IF4j1oi012ARhnITCml
 U0QYVezog653u/dgdVAVcbYBzvGxZzhx/DxkFkAVbzP6S3LUXCng9RHixNWUXOZxV6Lt
 l7hp3z8cEt4hK9nlDQL7l/cu5ByqpBegJegn6+MSQODQ09gPnbxv60U/bn2rH/VU/ZSX
 Z2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079657; x=1761684457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=143/y5s/Vd8n0Hn2bxYMjnN4uzh0g8+kJFFukw13gN0=;
 b=P/w/tJWNIDilIg6TiRhZ83mzcKSgA6nH3mtd1YDSVhXxq3tgWik+/RxF3AQy0yxYOE
 GZuTdjbmpqLTh4TifJNydaf+96/AjhxE/QlzEhexfBF+6s82T8joaU6ms9zDGVXUV069
 LwUcdKM23bfkWMfkR598GL72pW+Ubz69t9iAwwqPYEFXsqB1D+ljP/mt1+MkJ0OknMZF
 3eQUTI728JlzZSAaJQ/ouqGN4L85dZA2VtXakypAebrm/9vwrV8VyDx2OB8yJmoXzLzt
 t2bEJMp3H4ZW701e8ZWvWkegJ4HrTPVYa2kqJfOh9/UfZAJVko9v5d4gg1j9/2xAZW+x
 kF0w==
X-Gm-Message-State: AOJu0YzsYbNPHQkcq+NBak4dpGErIA2T/sDlzNdIhJ4cl+/cSFJegOuX
 NePDoCo1oUXRDr43Ac+2AP1QjcKBD8RfLmthuKtYXPFvhsIThI9HCE8SiWBc9I68XKG2FlZPC2n
 EVFiXejY=
X-Gm-Gg: ASbGncuzD8R2RlXyPpEFYyfipQYCY9F5BPRi48rjG5ePtYRAzgJNCLGmYPA0jGv+0fx
 Kq53HnYUEfu3wsATKCZEELF2cAEafoH0l3yi0DNRVO7h2dvJvmjX9waagkm7/77KJWV82yuJxmj
 hFh2o/ueRrv2mwU509JYCWKy2eozDklndMcEOR5nyXxUEI16UX1NBmekW2m78AyzqWnfda/ueli
 YbkDVf01oqf1Dni0ITz4ADZlYguPRRFaTSJw0DVyIL0jwq4vJ/cvnX804gQc4HbKd/EoUNWQx3n
 7eECWpnouzsJQE/uPUrdveApjIfW2Pq4ZLTR2loeBZgQT5n111ZNZUuknCd5fDoZcp7pNuHrjMc
 JKips7K1U23sFU/nPSBF/+ran7wkLDoH4nxcoO86N5e0CoehgGtnLqBjm946xnpP9czt5uXg5DU
 AaZsICDIXDiG54C4qHmHNbVd6d1uA6pYNpH26DzFzlp/lgfym67w==
X-Google-Smtp-Source: AGHT+IGL58exd3XSoWGVbMb8B9CeCRHWSdOQZkDgYOhFx9gs88WiXAo7b668WHJMxcaHcNLGttYAgA==
X-Received: by 2002:a05:6000:24c8:b0:427:690:1f7e with SMTP id
 ffacd0b85a97d-42706901f8dmr12796260f8f.45.1761079656672; 
 Tue, 21 Oct 2025 13:47:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce586sm22403052f8f.49.2025.10.21.13.47.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:47:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/45] hw/core: Filter machine list available for a particular
 target binary
Date: Tue, 21 Oct 2025 22:46:21 +0200
Message-ID: <20251021204700.56072-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
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

Binaries can register a QOM type to filter their machines
by filling their TargetInfo::machine_typename field.

Commit 28502121be7 ("system/vl: Filter machine list available
for a particular target binary") added the filter to
machine_help_func() but missed the other places where the machine
list must be filtered, such QMP 'query-machines' command used by
QTests, and select_machine(). Fix that.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20251020220941.65269-2-philmd@linaro.org>
---
 hw/core/machine-qmp-cmds.c | 4 +++-
 monitor/qemu-config-qmp.c  | 3 ++-
 system/vl.c                | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 51d5c230f7e..28dfd3e15bd 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -20,6 +20,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
+#include "qemu/target-info.h"
 #include "qemu/target-info-qapi.h"
 #include "qom/qom-qobject.h"
 #include "system/hostmem.h"
@@ -94,9 +95,10 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
 MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
                                     Error **errp)
 {
-    GSList *el, *machines = object_class_get_list(TYPE_MACHINE, false);
+    GSList *el, *machines;
     MachineInfoList *mach_list = NULL;
 
+    machines = object_class_get_list(target_machine_typename(), false);
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
         const char *default_cpu_type = machine_class_default_cpu_type(mc);
diff --git a/monitor/qemu-config-qmp.c b/monitor/qemu-config-qmp.c
index 9a3b183602d..8bd28fc2328 100644
--- a/monitor/qemu-config-qmp.c
+++ b/monitor/qemu-config-qmp.c
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qobject/qlist.h"
@@ -128,7 +129,7 @@ static CommandLineParameterInfoList *query_all_machine_properties(void)
     ObjectProperty *prop;
     bool is_new;
 
-    machines = object_class_get_list(TYPE_MACHINE, false);
+    machines = object_class_get_list(target_machine_typename(), false);
     assert(machines);
 
     /* Loop over all machine classes */
diff --git a/system/vl.c b/system/vl.c
index 646239e4a69..a96063f9901 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1672,7 +1672,8 @@ static MachineClass *select_machine(QDict *qdict, Error **errp)
 {
     ERRP_GUARD();
     const char *machine_type = qdict_get_try_str(qdict, "type");
-    g_autoptr(GSList) machines = object_class_get_list(TYPE_MACHINE, false);
+    g_autoptr(GSList) machines = object_class_get_list(target_machine_typename(),
+                                                       false);
     MachineClass *machine_class = NULL;
 
     if (machine_type) {
-- 
2.51.0


