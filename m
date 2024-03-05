Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BEAC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV51-0003EN-KZ; Tue, 05 Mar 2024 08:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV4l-00039Q-Qh
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:43:24 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV4d-0003zS-8K
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:43:23 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-513181719easo3867075e87.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646193; x=1710250993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OT8ZTO+xhnK0H2YL2SoKQeqlcBWyfPJJ6GJXZNxMx34=;
 b=bHPj+mugg4L3i0GiO/vNIiBqQI41PbZnOdRagshb++dvMKvQQeSZQc3hdzHexmRwl3
 QaxmPMvDJIO7i+j8VyZch083Sev37eBt1PEhJMJHPH8Se5vYmuIwesgLULjQ4caGL/aK
 F8DdYk11KIV//YFS7XIG5RCMYEXK5yEFf2Mus/CCC7bRN5DtFw+IUtxpxlUk2eMC5XdO
 vQNbLRc62SGI0vQ84HEKQmflq9Se+daT/SJpyAh7J99mXmf4+xAF6Bftqcah7p1O67g9
 TY3Ybw1opri0UQHSs84nVATjLD5l8SBGtix6fccGkhC8nTjpLbZE3FcxbroRMYPjY+a9
 jEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646193; x=1710250993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OT8ZTO+xhnK0H2YL2SoKQeqlcBWyfPJJ6GJXZNxMx34=;
 b=m9ThkiyzknDv6s5O1UgCEgMtBhyZjCFsB311KrVhSmpgGwPV1+9YdlkmhbRakKOcca
 mSYLEQjSDG6N7TX3MpxH1yUg9q1/SkaeAp8ytV1sMdnpC7ymcKg66APJBnwIbhGNjznx
 /0qbYerVKZAw3Mct1NOtYMhb68oH6m59QgzgUtrwnKM/Yi7hYeg9oOzuVHSXRRAhEOnm
 LHG9xwNKB9y6YbOho0LdROBtnbdvflCuPrQpp9HGIhpLMezzAbONVgl61gw7Grof7TkG
 TfRB5DJg6Q+ptOq7N8JfOX6Qn7pbg7xMoyWmdq4PS2/h96LCc4pH7gCiU/ZkQT35+Lne
 tQRg==
X-Gm-Message-State: AOJu0Yzg5fqOfwDUcMG0I7Wk2qA3IDKyWkhEnw6DlRQCKxAJF+AV4zv5
 Tj7jPxLsZ1PWuBI703V2dS25TwpvHiL9NIT2k1F3XF6hnQMm6xTuZ5jD5/oWjyWfu0UhwXUccaz
 Y
X-Google-Smtp-Source: AGHT+IHLwmHlfKl35XuwdEpGZVpnOk61AIZfeU4H/uc9w8OSaeyHZp72bMkq1nwPsKgfBewcEeKcwQ==
X-Received: by 2002:a05:6512:39cd:b0:513:46cc:8966 with SMTP id
 k13-20020a05651239cd00b0051346cc8966mr1840957lfu.2.1709646192884; 
 Tue, 05 Mar 2024 05:43:12 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 k13-20020a1709067acd00b00a44f3fb4f07sm3564090ejo.191.2024.03.05.05.43.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 05:43:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 07/18] target/i386/kvm: Remove
 x86_cpu_change_kvm_default() and 'kvm-cpu.h'
Date: Tue,  5 Mar 2024 14:42:09 +0100
Message-ID: <20240305134221.30924-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305134221.30924-1-philmd@linaro.org>
References: <20240305134221.30924-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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
the pc-i440fx-2.1 machine, which got removed. Inline it, and
remove its declaration. "kvm-cpu.h" is now empty, remove it too.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


