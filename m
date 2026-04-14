Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9F6F531CE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRgI-0001aK-QJ; Mon, 13 Apr 2026 20:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRg5-0001Nc-B7
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:30:54 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRg3-00036g-A4
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:30:53 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso52631345e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126649; x=1776731449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNmfOCyqLz0SabOc53BsZGwxrvu834OnrqGQI5BnOaw=;
 b=YASOfh4yha4PTARrxLs+CRUXTEeJdQlyYa7iQnHbbiJQ6dqNpgB7QAf2MCgSenYNdz
 t1KHxZxDAyaRcVD4eproJEIBgScRR9iDWRGHVWay+5ZnAII8XsPCsLjcuUAuORyDHpC9
 XjHn2hZntOhbQ/o5IeRuWBSZGmPVuVEWGvHQV/mMLEcryNn2Vfx8WI9Ap7mTuGOHOX7E
 BKRmyklh/ygTIgtQwd6jbQf0rjgl5ePs8Na2P+kuA7xjE29L2c/fSEzI8hvX4eOCdnn3
 PHe/d3LV/zG57Uvqzs3E6ZLIXozQ8y1j1KXDqfW2czivbg22DvziATI2QlkEK10wY2YR
 X7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126649; x=1776731449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jNmfOCyqLz0SabOc53BsZGwxrvu834OnrqGQI5BnOaw=;
 b=f/2FK3D7UBNYRCmGdJbvINGpoUD0xXl4/Fq5krebPdjmnezM38MAsVsrmrGiTtHbgm
 IbT4JJDTJNbJ/p7cYVAsw3g11lzvLzp1umOM3dRHu1tHEgfr7MKKGo3pm6dRqRfR/gaP
 VthSG95DaNETTXl3fHw2an29MesJI3QmN6qvfy/ddMsL2fkBzd4M5B3N/p1jvNlLsxPr
 5Hoi1C+xIrGhTLpFQT1FYSrvSWnIvtdTcuTGjSGzo7VWVMLbJMx9PO67rAQmPsl01J6+
 XdjEb8GqhBXjAeR16El0spVtdQZoe+Y7wLDTSkziAMWte67XgPWsNrKM50BOcpaF9lYV
 /mVA==
X-Gm-Message-State: AOJu0YwPYqJPXhgF4zZ3xowKQ059Nx+UzXAL4E+cUGZtl6y32TO4tt3m
 5dTc/E/kdWprAlnJuouV+01wZMRkJzM10ecudSy3fzTd0AbcHXSsQMiVFoFBNvQOGyIbQtxf1Ea
 Jy3Mrdm0=
X-Gm-Gg: AeBDiesmvZei1R3b2zRgyDJpIeDxZ2YDuHhNTwpqmwhWrKrkgSZZ6Rcr73oweVxkTIZ
 nCiqgLanptGUfUXMq/ypl3dj9OYVY6RayhNnIaNP5/HtuB1wi6QwGxjn7thPwVW/q/oKkFbs88O
 ZhFeEhl9nl/sBAzUwIqb/AAdnfLqn9xezXwinpr9aIiOo+b7b/C6dNnpfvFjpha7WEa+zjJPLrP
 KkKTXBQ/57dgUV/BLQvyYx3mkbtp+526Epqjx8eeQLhlmIOxUjiFyMbme8OnBIIZ8u49uK7XUkM
 VH1nGA6E3Wv4fuLjlqiS0wwRQBta9iMTwNTRgeObZDN72kdNjLShhEAQMlMrtYKxp0A9aMJZIIu
 A4igkVMCnQmNY8FzvdQEXNdQFeRsnm1IBncXftEUp17+v3CGn+Midd51+CWHKmcClwQSX360J5W
 Ytd4/vzSZR5R6QlZOlsQcs00bh+ISXpMo7ch6yrwJr9uLnDIu0lrebVGcnzPSP4WxeAJwd2oqgg
 ZSaDYewMkM=
X-Received: by 2002:a05:600c:19cd:b0:488:c239:d498 with SMTP id
 5b1f17b1804b1-488d68712d5mr212332115e9.8.1776126649309; 
 Mon, 13 Apr 2026 17:30:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee049333sm4619955e9.15.2026.04.13.17.30.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:30:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 06/27] system: Expose 'arch_init.h' as
 'qemu/base-arch-defs.h'
Date: Tue, 14 Apr 2026 02:29:38 +0200
Message-ID: <20260414003001.97571-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We already have a file unit outside of the local system'
folder which include "system/arch_init.h". We want more files
to use it, so make it official it is a generic header by moving
it under include. Rename as "qemu/base-arch-defs.h" which is
more descriptive.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/arch_init.h => include/qemu/base-arch-defs.h | 10 ++++++++--
 hw/pci/pci.c                                        |  2 +-
 system/arch_init.c                                  |  2 +-
 system/qdev-monitor.c                               |  2 +-
 system/vl.c                                         |  2 +-
 5 files changed, 12 insertions(+), 6 deletions(-)
 rename system/arch_init.h => include/qemu/base-arch-defs.h (92%)

diff --git a/system/arch_init.h b/include/qemu/base-arch-defs.h
similarity index 92%
rename from system/arch_init.h
rename to include/qemu/base-arch-defs.h
index 0c2b1f3a5d0..f33465738c9 100644
--- a/system/arch_init.h
+++ b/include/qemu/base-arch-defs.h
@@ -1,5 +1,11 @@
-#ifndef QEMU_ARCH_INIT_H
-#define QEMU_ARCH_INIT_H
+/*
+ * QEMU base architecture bit definitions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_BASE_ARCH_DEFS_H
+#define QEMU_BASE_ARCH_DEFS_H
 
 #include "qapi/qapi-types-machine.h"
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2c3657d00de..a38dffd4899 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -36,7 +36,7 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "system/numa.h"
 #include "system/runstate.h"
 #include "system/system.h"
diff --git a/system/arch_init.c b/system/arch_init.c
index 604d5909ed0..1ad2f3d6f78 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "qemu/bitops.h"
 #include "qemu/target-info-qapi.h"
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 2ed95e83602..2e9dbb9b5c2 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -23,7 +23,7 @@
 #include "monitor/hmp-completion.h"
 #include "monitor/monitor.h"
 #include "monitor/qdev.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "system/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
diff --git a/system/vl.c b/system/vl.c
index 0e1fc217b4f..c89fe8378c5 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -112,7 +112,7 @@
 #include "trace/control.h"
 #include "qemu/plugin.h"
 #include "qemu/queue.h"
-#include "system/arch_init.h"
+#include "qemu/base-arch-defs.h"
 #include "system/confidential-guest-support.h"
 
 #include "ui/qemu-spice.h"
-- 
2.53.0


