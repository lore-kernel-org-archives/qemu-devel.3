Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C6FC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wcz-0007wO-A3; Wed, 23 Apr 2025 05:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcL-0005tT-NB
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7WcJ-0008PX-B1
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745401326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5ZZDK1xtBvzs1i5YSsys1Z/LypJHoXPwiGBorvIHkE=;
 b=MNTEH/I4t2rT7wBOjfeJdjIwqxHsSvcbeveJNmfXPOhwy4V9p9lPHikjRq/qC7TCs5cKC/
 g3ajOdqHfHT2LhXVrRBdtyJM9U95ZeeeeeTf0l7i5l0PEhgwGXvaZ55utCaycCVUXl1iWJ
 BAgJKyGXMFjFfogN8yDe/hEXqCgaQTY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-h-vwT6C3PVGZiL9IkVbHoQ-1; Wed, 23 Apr 2025 05:42:03 -0400
X-MC-Unique: h-vwT6C3PVGZiL9IkVbHoQ-1
X-Mimecast-MFC-AGG-ID: h-vwT6C3PVGZiL9IkVbHoQ_1745401322
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5f62d10edbcso5294194a12.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745401321; x=1746006121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g5ZZDK1xtBvzs1i5YSsys1Z/LypJHoXPwiGBorvIHkE=;
 b=iFMpaS83hQSSLiKiGFz8POZaR0/gqUHfgvSwo42Aiqh2vF3qCVVc8/WVQ32y/Mmqxk
 RD09mG/1Oeaz5cgYn9hWmeKeGu1Ju4doc38j5wA3Asjclrhpi/WyqCJLCFd7ZPTgS1bB
 +joYk37v/NfHGVUiIN7qFriIyOk0Iv5toCW9gZtv7RaDZ/blnuhfRfmhGMleVxtRoW4C
 SXM52PhF/kBG0NUJSY0zAOEbqbN4Ybiqz0Ei12dIxM7T+RWKM4OSsmdavSWDRhw5lIRJ
 MwJwKq93wLgLhkuTp5+JAZgRU1rTg/pRlJc+UNyEeX9hOwgiQZ4qAmG2cU1+sxis6wpI
 oquw==
X-Gm-Message-State: AOJu0YyiE8Jv79JlVZ0Duwt6fKplvFqIYtP7jUNg7SnMNe+Rnx1bnva8
 NOqfK2IbwJGQ/v8mN8EtO/kg0EGSYZuA99moPe4dcjl025Wjkg12zwkg+mHcWvbETolqcgMGbi5
 ECSjvC1GhHQCtn8q9WWNmRVttsY2AUWIcImWzUa4xhErwkfDe3Db09ae4UOdmfQ8bGaYIMrCrvA
 3E63Sd13P5ZGog14wKAQxxoIYMRttqTzHJTJ/n
X-Gm-Gg: ASbGncuXKN2+YOquNKT0TiKWx78udiojJVkTPoszIQW3vPEHfrh3qEUv6TMhRf5Tc0z
 qhjiEKjjGCUcAfz7FM9g4Z+fPvvFl7ZS1Hvf1W6vbmRUW8ahoCJa6WYolCe43VvenE/ZJM+ndHf
 U+9VJF44sdFoHapGQahDyBBhUQPQpj7hhAngZgk01pTVYAdSyko9eYdZEpoP9ibLbeCw+cztv7z
 jPEJvmVqk77wJqmAtt1520CebvYaxFp9Uh7+swS9/g2OCesoxYFoxAKlmrBDcpl1ZTKwLp6iRrO
 T/nMuB7kD/wiqrzj
X-Received: by 2002:a05:6402:210c:b0:5ed:c09c:10f with SMTP id
 4fb4d7f45d1cf-5f62854b063mr16708271a12.15.1745401321542; 
 Wed, 23 Apr 2025 02:42:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH7h4U2LWta3MMkiRBJEe3xr4vsq8vA8Hi5wsArE6TTO3Zt/JL1/YqnIf0WvJ3knjyqVE92Q==
X-Received: by 2002:a05:6402:210c:b0:5ed:c09c:10f with SMTP id
 4fb4d7f45d1cf-5f62854b063mr16708247a12.15.1745401321100; 
 Wed, 23 Apr 2025 02:42:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.233.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f62557a151sm7224747a12.32.2025.04.23.02.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 02:41:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <liuwe@linux.microsoft.com>
Subject: [PULL 25/34] target/i386: move x86 instruction emulator out of hvf
Date: Wed, 23 Apr 2025 11:40:55 +0200
Message-ID: <20250423094105.40692-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423094105.40692-1-pbonzini@redhat.com>
References: <20250423094105.40692-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Wei Liu <liuwe@linux.microsoft.com>

Move x86_decode, x86_emu, x86_flags and some headers to the new location.
Fix up all the inclusion sites in hvf.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
Link: https://lore.kernel.org/r/1741377325-28175-14-git-send-email-liuwe@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/{hvf => emulate}/x86.h        | 0
 target/i386/{hvf => emulate}/x86_decode.h | 0
 target/i386/{hvf => emulate}/x86_emu.h    | 0
 target/i386/{hvf => emulate}/x86_flags.h  | 0
 target/i386/hvf/vmx.h                     | 2 +-
 target/i386/hvf/x86_descr.h               | 2 +-
 target/i386/{hvf => emulate}/x86_decode.c | 0
 target/i386/{hvf => emulate}/x86_emu.c    | 0
 target/i386/{hvf => emulate}/x86_flags.c  | 0
 target/i386/hvf/hvf.c                     | 8 ++++----
 target/i386/hvf/x86.c                     | 4 ++--
 target/i386/hvf/x86_cpuid.c               | 2 +-
 target/i386/hvf/x86_mmu.c                 | 2 +-
 target/i386/hvf/x86_task.c                | 6 +++---
 target/i386/hvf/x86hvf.c                  | 2 +-
 target/i386/emulate/meson.build           | 5 +++++
 target/i386/hvf/meson.build               | 3 ---
 17 files changed, 19 insertions(+), 17 deletions(-)
 rename target/i386/{hvf => emulate}/x86.h (100%)
 rename target/i386/{hvf => emulate}/x86_decode.h (100%)
 rename target/i386/{hvf => emulate}/x86_emu.h (100%)
 rename target/i386/{hvf => emulate}/x86_flags.h (100%)
 rename target/i386/{hvf => emulate}/x86_decode.c (100%)
 rename target/i386/{hvf => emulate}/x86_emu.c (100%)
 rename target/i386/{hvf => emulate}/x86_flags.c (100%)

diff --git a/target/i386/hvf/x86.h b/target/i386/emulate/x86.h
similarity index 100%
rename from target/i386/hvf/x86.h
rename to target/i386/emulate/x86.h
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/emulate/x86_decode.h
similarity index 100%
rename from target/i386/hvf/x86_decode.h
rename to target/i386/emulate/x86_decode.h
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/emulate/x86_emu.h
similarity index 100%
rename from target/i386/hvf/x86_emu.h
rename to target/i386/emulate/x86_emu.h
diff --git a/target/i386/hvf/x86_flags.h b/target/i386/emulate/x86_flags.h
similarity index 100%
rename from target/i386/hvf/x86_flags.h
rename to target/i386/emulate/x86_flags.h
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 80ce26279bf..3c56afc9d3a 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -29,7 +29,7 @@
 #include <Hypervisor/hv_vmx.h>
 #include "vmcs.h"
 #include "cpu.h"
-#include "x86.h"
+#include "emulate/x86.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
 
diff --git a/target/i386/hvf/x86_descr.h b/target/i386/hvf/x86_descr.h
index ce5de983497..24af4946cd4 100644
--- a/target/i386/hvf/x86_descr.h
+++ b/target/i386/hvf/x86_descr.h
@@ -19,7 +19,7 @@
 #ifndef HVF_X86_DESCR_H
 #define HVF_X86_DESCR_H
 
-#include "x86.h"
+#include "emulate/x86.h"
 
 typedef struct vmx_segment {
     uint16_t sel;
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/emulate/x86_decode.c
similarity index 100%
rename from target/i386/hvf/x86_decode.c
rename to target/i386/emulate/x86_decode.c
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/emulate/x86_emu.c
similarity index 100%
rename from target/i386/hvf/x86_emu.c
rename to target/i386/emulate/x86_emu.c
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/emulate/x86_flags.c
similarity index 100%
rename from target/i386/hvf/x86_flags.c
rename to target/i386/emulate/x86_flags.c
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 8c31d2e0cf7..23ebf2550ac 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -59,12 +59,12 @@
 #include "hvf-i386.h"
 #include "vmcs.h"
 #include "vmx.h"
-#include "x86.h"
+#include "emulate/x86.h"
 #include "x86_descr.h"
-#include "x86_flags.h"
+#include "emulate/x86_flags.h"
 #include "x86_mmu.h"
-#include "x86_decode.h"
-#include "x86_emu.h"
+#include "emulate/x86_decode.h"
+#include "emulate/x86_emu.h"
 #include "x86_task.h"
 #include "x86hvf.h"
 
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index a0ede138865..5c75ec9a007 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -19,8 +19,8 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "x86_decode.h"
-#include "x86_emu.h"
+#include "emulate/x86_decode.h"
+#include "emulate/x86_emu.h"
 #include "vmcs.h"
 #include "vmx.h"
 #include "x86_mmu.h"
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index ae836f65cc9..fa131b18c6d 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -24,7 +24,7 @@
 #include "qemu/cpuid.h"
 #include "host/cpuinfo.h"
 #include "cpu.h"
-#include "x86.h"
+#include "emulate/x86.h"
 #include "vmx.h"
 #include "system/hvf.h"
 #include "hvf-i386.h"
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 579d0c3a4cc..afc5c17d5d5 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -19,7 +19,7 @@
 #include "qemu/osdep.h"
 #include "panic.h"
 #include "cpu.h"
-#include "x86.h"
+#include "emulate/x86.h"
 #include "x86_mmu.h"
 #include "vmcs.h"
 #include "vmx.h"
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index 161217991fc..bdf8b51ae67 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -14,11 +14,11 @@
 #include "hvf-i386.h"
 #include "vmcs.h"
 #include "vmx.h"
-#include "x86.h"
+#include "emulate/x86.h"
 #include "x86_descr.h"
 #include "x86_mmu.h"
-#include "x86_decode.h"
-#include "x86_emu.h"
+#include "emulate/x86_decode.h"
+#include "emulate/x86_emu.h"
 #include "x86_task.h"
 #include "x86hvf.h"
 
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 531a340b37c..2057314892a 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -24,7 +24,7 @@
 #include "vmcs.h"
 #include "cpu.h"
 #include "x86_descr.h"
-#include "x86_decode.h"
+#include "emulate/x86_decode.h"
 #include "system/hw_accel.h"
 
 #include "hw/i386/apic_internal.h"
diff --git a/target/i386/emulate/meson.build b/target/i386/emulate/meson.build
index e69de29bb2d..4edd4f462fc 100644
--- a/target/i386/emulate/meson.build
+++ b/target/i386/emulate/meson.build
@@ -0,0 +1,5 @@
+i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
+  'x86_decode.c',
+  'x86_emu.c',
+  'x86_flags.c',
+))
diff --git a/target/i386/hvf/meson.build b/target/i386/hvf/meson.build
index 05c3c8cf18b..519d190f0e6 100644
--- a/target/i386/hvf/meson.build
+++ b/target/i386/hvf/meson.build
@@ -2,10 +2,7 @@ i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
   'hvf.c',
   'x86.c',
   'x86_cpuid.c',
-  'x86_decode.c',
   'x86_descr.c',
-  'x86_emu.c',
-  'x86_flags.c',
   'x86_mmu.c',
   'x86_task.c',
   'x86hvf.c',
-- 
2.49.0


