Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897B8C27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 07:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ6XJ-00043m-71; Mon, 17 Jun 2024 03:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6XH-00043G-Ia
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:12:15 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJ6XF-0002HZ-Nz
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 03:12:15 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ec17eb4493so38856011fa.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 00:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718608331; x=1719213131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvc+2nJitsMvQxJjJxYIfcnmMlZJKY5kgeCJ20XwK8E=;
 b=uQjs8mLS7/HH3ti4VN2+IeMi7uQF54xocKYiPRVGoK5EQcSzLnezsk61OqUjtFSKvn
 cIe6GsbGnZc738luNtMccrB8adqTUqI7pi2MWklUKXu1mhf9x+sAj9VHabMZYe/6eIo3
 h3w9ahDczmflutLeD351YGrhP38kBY/00I5r0B/tCzolBp/6laTinc/CKForPW/HZo6C
 h1ONVdGapXdNVcmGwQlZJQJ1G0tUh+OAE107sHKCEG033qeVLoxqzMDVKxPhpby175zN
 5ije2n0O1gYzyyL/GxPVRZGzkMqe0DWU/8uQGZMZyOQm3xATmG4SLe6UUVU5ThM9VIo5
 jWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718608331; x=1719213131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nvc+2nJitsMvQxJjJxYIfcnmMlZJKY5kgeCJ20XwK8E=;
 b=RL0DHxJYPfgiDfMetqeu5ygRgQjZWesIY+XBFSWq0LNlQ8BdP/qq8DwU6DcXPragMf
 sN4X2OUlqqhIj2/NoSNSmEKLZGHR/KZsr+DhDdlUYCAi//qyp7qzxNfyIF9VXnUB4trl
 4Prbb1iwtwcllx1fsmSZmAi9vCCfftNtrExzBig7kcTOOLYlwRxMNSPKUVuGuRWYSqdU
 k4fWnSd/l2lyxkE0gW1uARmrIJDK/a7A4UnrNgSDjENd0oYjl7CzkjX648Kbd2YYjzGf
 vJ4tgykNXMDidRzRgpzUk3ehBlenPQ2Ko4nth4h/8LsPxIWYdkFgR0vC64g99tur0G8c
 EiKQ==
X-Gm-Message-State: AOJu0Ywn/YMg1P1caCfCNBcpV09my9LUw/M42j0DuFNn5tKHuusOWEib
 K/jWn7RK5234B5VdFguQJa8hWTnbm6E5PhLaG5zXL14F/HIyX+eAXd0tI4HmscPtL7g/po00/1A
 Vs94=
X-Google-Smtp-Source: AGHT+IHfQZy61kL+HgRYKqrkUAOLe+Rg9UAMlmRtVWM95LMWxntUKXqGxbOtYYPfDxUxytrjggCsug==
X-Received: by 2002:ac2:5602:0:b0:52c:905b:ea5f with SMTP id
 2adb3069b0e04-52ca6e9b7eemr7219020e87.63.1718608331383; 
 Mon, 17 Jun 2024 00:12:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.169.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f427b0sm483367766b.156.2024.06.17.00.12.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jun 2024 00:12:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 09/23] target/i386/kvm: Remove x86_cpu_change_kvm_default()
 and 'kvm-cpu.h'
Date: Mon, 17 Jun 2024 09:11:04 +0200
Message-ID: <20240617071118.60464-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240617071118.60464-1-philmd@linaro.org>
References: <20240617071118.60464-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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
index f76972e47e..f9b99b5f50 100644
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
@@ -178,7 +177,7 @@ static PropValue kvm_default_props[] = {
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


