Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA394CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8SM-0004Uf-0w; Wed, 29 Oct 2025 11:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8SI-0004Nt-5D
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:22 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Ry-0002sw-KW
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:21 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b6d402422c2so3064566b.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753054; x=1762357854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UwjbQOL3SNK3XYyw4bXRUjK1Sm/B26LNqTre7AraQmI=;
 b=im5Y6J6BLCCx0ScQRywDnqhrVvUYLMOfO/Wp7eGJuTGLqGYpWSIowe+RBHnRzwtAfm
 aBcB/EHOPvndQFNTlP55EISLp1Suj+wez9O+naYGpovYiVNS8EDCIsl1kefu2NAxZkpZ
 ZBAaaQNgFdkTIPwIcF5PlZXl0HP68JbSrrTHm8P2iK35DitWETZA1EoQrcI1vIsKCcRH
 W3WhOlWRW843q3a6kEdb8gW5fgkQ/hTrWksMPB8Bk+pIfH0BuyLvtmjJmx3xSK7aEnlw
 hbQmz2e2iI1UK+EMIGLm6laHQLwbgG5/dIntxGTMWa0StFzi9WAKtdaA5GwqTp6OX9a/
 QkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753054; x=1762357854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UwjbQOL3SNK3XYyw4bXRUjK1Sm/B26LNqTre7AraQmI=;
 b=nTmIeSj+gB7jC+nMy2AbB+uvjwI2JxNAecyP0FsRDtxfdR7rw/P+Cb2ZSouP1iHdmh
 xOMza1Oza2B5OOeM+/M+VjxXbpqlAuPraOcWZGDJe8In8n2KhyYfqp4wjxz+tbkFXSv8
 C00vJTWUXarc+/TePxISk3bNoFBsEYBMnX+ax9CxrFkQW5AOhHFczfCCG7x/8ILcWMpr
 l3ZdZzUMewHQE1OWDTIvxESNFIY4HltnNNdihm1EQGerCqGzrz9BODgSpZ8V04epynTY
 9GB/1MzZeMKqfnzalh0IDdUm48MVJ9TC33jjKod9sEdb+P9DSm9C/khWqszWpSCtCzRO
 DYog==
X-Gm-Message-State: AOJu0Yye7Epi7ZAh47LF3QXetnDaB96Ssf5LWCUugF/Hysl9nCpxzIaw
 chMe4aELJFnbgd5+mHPlL1CsSjZMa/QlyFB0RN5SiU2Z4lwKnkCMg/Q9C8vMd8EY+QY=
X-Gm-Gg: ASbGncseLC9LCxKdSWorPgJrdrT0FThMRAWgUYMe6MbwAwRnuxH4pEQNfdfji49ZnD6
 5te4yQy/Xkl+DsGHFXm9wOIO9TilyTnt1VqAVfcwfdWPABNVtzmMiNBz0POt3vkN7DCLfmRYXEQ
 HRhtCw1/8CP8NmtGybmoiGi9gBRxhd0y+gzfQU3POGIhh/d5T1FF9R5t5rY0SCuyA8wDI3ufZC+
 0Q5k8exUygswTc1JHcYPD8Qwks70Pm6mPzz8OXIVL/co2ip4J6PMWcA8ZJlht1Q6WfsAmCZ6X6/
 hNSzDT1rd+RwBVF02W5JMgqIDQpgdMBigIzwvoBNNfcfI03PTSDK83ZVmwjqqFtnY1ndpZq1QeM
 PYyluq98RkTpHIgbuMeZGUQSL9WJu7d/eLoMSJ1MyGnnfE/UM1Gdx6yI0tUcGh9m4rML7QDcVa3
 7h
X-Google-Smtp-Source: AGHT+IEAAVxjum6pA9Wytr0y5DHwzasYY9KJeQ60p3l5A1/ZyPaToyX2rSTRaO0ycP92T+2VnDZZsg==
X-Received: by 2002:a17:907:7247:b0:b38:6689:b9f5 with SMTP id
 a640c23a62f3a-b703d294f7dmr378168266b.3.1761753053792; 
 Wed, 29 Oct 2025 08:50:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85369697sm1509121566b.26.2025.10.29.08.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D3157602AD;
 Wed, 29 Oct 2025 15:50:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 10/35] contrib/plugins: add plugin showcasing new dicontinuity
 related API
Date: Wed, 29 Oct 2025 15:50:19 +0000
Message-ID: <20251029155045.257802-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Julian Ganz <neither@nut.email>

We recently introduced new plugin API for registration of discontinuity
related callbacks. This change introduces a minimal plugin showcasing
the new API. It simply counts the occurances of interrupts, exceptions
and host calls per CPU and reports the counts when exitting.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Message-ID: <20251027110344.2289945-11-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 8a5e128f677..92c219119e8 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -1015,6 +1015,14 @@ interesting to generate them around a particular point of execution::
     # generate trace around init execution (2 seconds):
     $ uftrace dump --chrome --time-range=1753122320~1753122322 > init.json
 
+Count traps
+...........
+
+``contrib/plugins/traps.c``
+
+This plugin counts the number of interrupts (asyncronous events), exceptions
+(synchronous events) and host calls (e.g. semihosting) per cpu.
+
 Other emulation features
 ------------------------
 
diff --git a/contrib/plugins/traps.c b/contrib/plugins/traps.c
new file mode 100644
index 00000000000..d5ddc0f3dd6
--- /dev/null
+++ b/contrib/plugins/traps.c
@@ -0,0 +1,83 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2025, Julian Ganz <neither@nut.email>
+ *
+ * Traps - count traps
+ *
+ * Count the number of interrupts (asyncronous events), exceptions (synchronous
+ * events) and host calls (e.g. semihosting) per cpu and report those counts on
+ * exit.
+ */
+
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+typedef struct {
+    uint64_t interrupts;
+    uint64_t exceptions;
+    uint64_t hostcalls;
+} TrapCounters;
+
+static struct qemu_plugin_scoreboard *traps;
+
+static void vcpu_discon(qemu_plugin_id_t id, unsigned int vcpu_index,
+                        enum qemu_plugin_discon_type type, uint64_t from_pc,
+                        uint64_t to_pc)
+{
+    TrapCounters *rec = qemu_plugin_scoreboard_find(traps, vcpu_index);
+    switch (type) {
+    case QEMU_PLUGIN_DISCON_INTERRUPT:
+        rec->interrupts++;
+        break;
+    case QEMU_PLUGIN_DISCON_EXCEPTION:
+        rec->exceptions++;
+        break;
+    case QEMU_PLUGIN_DISCON_HOSTCALL:
+        rec->hostcalls++;
+        break;
+    default:
+        g_assert_not_reached();
+        break;
+    }
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *p)
+{
+    g_autoptr(GString) report;
+    report = g_string_new("VCPU, interrupts, exceptions, hostcalls\n");
+    int max_vcpus = qemu_plugin_num_vcpus();
+    int vcpu;
+
+    for (vcpu = 0; vcpu < max_vcpus; vcpu++) {
+        TrapCounters *rec = qemu_plugin_scoreboard_find(traps, vcpu);
+        g_string_append_printf(report,
+                               "% 4d, % 10"PRId64", % 10"PRId64", % 10"PRId64
+                               "\n", vcpu, rec->interrupts, rec->exceptions,
+                               rec->hostcalls);
+    }
+
+    qemu_plugin_outs(report->str);
+    qemu_plugin_scoreboard_free(traps);
+}
+
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
+{
+    if (!info->system_emulation) {
+        qemu_plugin_outs("Note: interrupts are only reported in system"
+                         " emulation mode.");
+    }
+
+    traps = qemu_plugin_scoreboard_new(sizeof(TrapCounters));
+
+    qemu_plugin_register_vcpu_discon_cb(id, QEMU_PLUGIN_DISCON_ALL,
+                                        vcpu_discon);
+
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+
+    return 0;
+}
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 7eb3629c95d..eb944b5159a 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -1,6 +1,6 @@
 contrib_plugins = ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotblocks',
                    'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigger',
-                   'uftrace']
+                   'traps', 'uftrace']
 if host_os != 'windows'
   # lockstep uses socket.h
   contrib_plugins += 'lockstep'
-- 
2.47.3


