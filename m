Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB07C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo3Q-0001eh-3a; Tue, 16 Apr 2024 15:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo3A-0001EL-Am
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:01:01 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo35-0005fO-2o
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:01:00 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-346b09d474dso4528654f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294042; x=1713898842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQMVapEs3CYgmDweUYusfpnz/y/x604jp5xhdw8yVc4=;
 b=acK2nH/iOAcLpljIsEsiOJUMdpm61hJPryla2KMCSgsXLML1h3/OqFn383FOjvuN9B
 kb84VAIS6HukP4bLC75U7moyVGmR9k4Y5OApDsD6iMHBPlWJMjobbSI4Jyb9T7SifMLt
 5xA329nfZvrmQ7GYGbDgodBIBZXtJJGa0yQJLmnZm49aWk6TDf1p9QAmcu9RflzPlWp8
 A4MNT1NIW0L8ugPCkWWgr7JVkr3wdIj4TaohP4OnpU3qMmUCfpYDF5C5xdjpP0lU3SR5
 gayCS4DgOAuwohkys6j8jEqAoaM0YKQNDy1ZWbyH6lN5RcHH083R84qiOtMZjYN+1J7w
 ucfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294042; x=1713898842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XQMVapEs3CYgmDweUYusfpnz/y/x604jp5xhdw8yVc4=;
 b=E9b7VdeaWvZNJZWysjhezykLwh2hgslnHKqxH3zOxPQGous6LyLzLBsDNRmrJbJCsP
 x2xP64usadmaJ72LJfX8S4Wf/kW6BFsVHpm4Zs6hT+HwA+TOeS1DzLnmjdnH21vsOYI/
 /YV9so4kue9PtjzS5Ndik0Ivhw7nW43fdqfXHeHsCOpjQaCFDurepwZy+F/V5SQ6fEZo
 QkcjFK63dj4soZUIUHcHO75TWvuOrYMooDzR61LpEjPT4bu5Rq6PjaoH063Bv5Vc+gSw
 wVR9zCIj2eRFRx017Og9MjrDPx0wWk5xPO4SUzOtfL1gAqhlwdjf2rhO1a02yOJhooyY
 H89g==
X-Gm-Message-State: AOJu0YyYAbUhLsxZBbptmXJLXdLsT4Tg3hvC5a0wKhfDnCSjmVW7et0q
 8s9Rp/zCSait7cxWRJvjcJ04zHdCJoXZnahdQVm7ejxS+2PkkW/LA6ORWX+DR2GivpnyiGg+euB
 4
X-Google-Smtp-Source: AGHT+IGnL5JmbtDDZEIcfbVuWwS/E0VTaHNwOqYN0lHrO8H585nWin8P9SPUGxY4DS0gePAUMMYiYA==
X-Received: by 2002:a5d:6703:0:b0:347:82b7:abc2 with SMTP id
 o3-20020a5d6703000000b0034782b7abc2mr6710909wru.15.1713294042538; 
 Tue, 16 Apr 2024 12:00:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 sa30-20020a1709076d1e00b00a522e95a580sm6417803ejc.217.2024.04.16.12.00.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 12:00:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v4 09/22] target/i386/kvm: Remove x86_cpu_change_kvm_default()
 and 'kvm-cpu.h'
Date: Tue, 16 Apr 2024 20:59:25 +0200
Message-ID: <20240416185939.37984-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416185939.37984-1-philmd@linaro.org>
References: <20240416185939.37984-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

x86_cpu_change_kvm_default() was only used out of kvm-cpu.c by
the pc-i440fx-2.1 machine, which got removed. Make it static,
and remove its declaration. "kvm-cpu.h" is now empty, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 target/i386/kvm/kvm-cpu.h | 41 ---------------------------------------
 target/i386/kvm/kvm-cpu.c |  3 +--
 2 files changed, 1 insertion(+), 43 deletions(-)
 delete mode 100644 target/i386/kvm/kvm-cpu.h

diff --git a/target/i386/kvm/kvm-cpu.h b/target/i386/kvm/kvm-cpu.h
deleted file mode 100644
index e858ca21e5..0000000000
--- a/target/i386/kvm/kvm-cpu.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * i386 KVM CPU type and functions
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef KVM_CPU_H
-#define KVM_CPU_H
-
-#ifdef CONFIG_KVM
-/*
- * Change the value of a KVM-specific default
- *
- * If value is NULL, no default will be set and the original
- * value from the CPU model table will be kept.
- *
- * It is valid to call this function only for properties that
- * are already present in the kvm_default_props table.
- */
-void x86_cpu_change_kvm_default(const char *prop, const char *value);
-
-#else /* !CONFIG_KVM */
-
-#define x86_cpu_change_kvm_default(a, b)
-
-#endif /* CONFIG_KVM */
-
-#endif /* KVM_CPU_H */
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 9c791b7b05..cb8c73d20c 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -10,7 +10,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "host-cpu.h"
-#include "kvm-cpu.h"
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
@@ -144,7 +143,7 @@ static PropValue kvm_default_props[] = {
 /*
  * Only for builtin_x86_defs models initialized with x86_register_cpudef_types.
  */
-void x86_cpu_change_kvm_default(const char *prop, const char *value)
+static void x86_cpu_change_kvm_default(const char *prop, const char *value)
 {
     PropValue *pv;
     for (pv = kvm_default_props; pv->prop; pv++) {
-- 
2.41.0


