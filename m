Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9E6CCF9EF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDL2R-0001gI-9c; Mon, 27 Oct 2025 07:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL2P-0001eq-Ei
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:05:22 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL1a-0005dn-JI
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:05:20 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-63c31c20b64so7306306a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563032; x=1762167832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdYYc9UfPJiJOmUk4OWh6nheP5mSB2HOK4r3KtorV48=;
 b=iizFSWCne8dtm4AE8rAmqRWuFEYhpe7lTw/Fubft+FpBsD35TdVMUjHAkPmqX5LaGV
 xp/QOmMyPa2lFgTqnxaL7ck6WHWFzw3vbG8KiRcB74UobMCPLe31xWSv2Oj8O+CiS19T
 lBHluuZc4ZMw0JXGQSNr34koFzqJwtAmSIzKr8HxMu2vZXRSxLkSqWyOkEsFAC+a0nT2
 7TgU2OLerF4y6wJ5IcI1ffD/3HsV4yvwJaHXLOQosxyPYH7mMJzWvQ23NnqV3I6RMWYJ
 x/dulghvbgw2dJgteam8D9pYTaDBdnU9+vIIEv84uM15VjVzrGIte6a5JjNlAtiWKkrF
 WPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563032; x=1762167832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FdYYc9UfPJiJOmUk4OWh6nheP5mSB2HOK4r3KtorV48=;
 b=YCb+WbWsMkzmaMkLkE636/qf+AUlZV12J64cpsEx5uKLP9K6penEIi+fy25Xt2yhMF
 BA8e+OdX1hux/U3raDiIsNfy120yLOdo1GIMVTguBBFuKgDtRg4E2pmKuAitivTWScMb
 uxjMjbvnWpZb/HBelGO6NhMMk0BQVwlpN0z2cNmuNixttY1W0qwGt/kvV2tpEjqh4HMH
 iidgfjDW90co0fKY1++iDADcc9wjKoIsZa+lp0Xy8TAsFWe8BLhQU0iZ9R7d0sbVpSuA
 HdaqrNbeBxl3CNsVjKRnQBvY1mw2SBMro5u8qM8CNZ1ev8Ib8IGPI2d25OyGQRfZ9VAB
 qXJA==
X-Gm-Message-State: AOJu0YxS3O6bWFwFFQqH5APL3iATEy0YUspw6g9gNsa+CNbpaD+IoS7D
 sKY1bRomJaW42aGg47X2TXxSMXl2KztT+rvZb7lh65IEtwALA6qY19D5oblDEkKRxu8=
X-Gm-Gg: ASbGncuKB91JRvX7MFASM+UzHxc2NygC0D2ZEnWqSX1CeczeJ1kt70/duaZofwhkaGY
 9Kwe332BtDdrT1FxfvdXJ8yBgInUj904Tns7ng7WD/MqBkd7XtrDq106nR6iCkhha53MAPIRkoD
 sAT128DdcoWKfYA4m1G5OZZ1xpOkw7SXxz0ceG2l1ESnFlf/CEyQpXU8ThRYsLYTAp+ldE9ampl
 3zKymYzGynfjd1ThKjMrg7uHpUMYe4iBiJQ8eyu9PYHoVPbf0W5J8H/ziaXNK5MYUslwmPYxUY2
 YG0joMD4dOUY+NBUMkNs7Ca7cQkvEo9SL+Pt2AjXufZGX3+hFAFLhh80FsyP57SgjLvwaO6Qozo
 vhS9driXti3gG/zMZJdGdMc2lQdvU9dramT+RHb4JSegu7KQAtq5lgSJ8iy8daxg7x4kVZADUKc
 fQTrtDVrJjIVE=
X-Google-Smtp-Source: AGHT+IE146XaimMpIxyppkc5SJJoPLUyMmLDLovFokulHH30KUzEQB5Xf7fiUrkKHn734LTDcCF5qA==
X-Received: by 2002:a05:6402:51d1:b0:63c:3efe:d996 with SMTP id
 4fb4d7f45d1cf-63c3efeee79mr31902705a12.20.1761563032280; 
 Mon, 27 Oct 2025 04:03:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63ecf3686c5sm356035a12.36.2025.10.27.04.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:03:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 13AD460915;
 Mon, 27 Oct 2025 11:03:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH 10/35] contrib/plugins: add plugin showcasing new dicontinuity
 related API
Date: Mon, 27 Oct 2025 11:03:17 +0000
Message-ID: <20251027110344.2289945-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/about/emulation.rst    |  8 ++++
 contrib/plugins/traps.c     | 83 +++++++++++++++++++++++++++++++++++++
 contrib/plugins/meson.build |  2 +-
 3 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/traps.c

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


