Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9774E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK4G-0003ZN-Ez; Fri, 10 Jan 2025 13:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK32-0001SI-69
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2w-0001Ee-VN
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3I28akyrgNRO85WGd2WX/Mawn2r7ecEtUfOeL4OylPc=;
 b=f+No8aihFMkcYOSMJllTWxu3BKYb50nw8j502ZPFp+vh/+J9XAMfEWAUiIYUKEKlBABNtv
 WQzojIfBUdQnVaGOtAwE7pPUz4o8dA6dz05c1OsVQuJ24WXpy496bFfmUveruYoq/mQlAs
 Gy44K8Bol7LFjBKoqiy5Ea25JoRnpDM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-Hfvfhgx-Pp-TynRSo7alvQ-1; Fri, 10 Jan 2025 13:47:49 -0500
X-MC-Unique: Hfvfhgx-Pp-TynRSo7alvQ-1
X-Mimecast-MFC-AGG-ID: Hfvfhgx-Pp-TynRSo7alvQ
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d3ff30b566so2427016a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534867; x=1737139667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3I28akyrgNRO85WGd2WX/Mawn2r7ecEtUfOeL4OylPc=;
 b=HPEaToPxuJSdbEgvJQtr1n0WJrv6WMB7LjSKVGhnpZEvZ237otkILYiUCVh41TN9qh
 7qrkbRSnC28pwfLdULSbYjttb/0cHywJSH0sEShjctW2DX5/KvUZpk+sVSkVK9Jqptx1
 MzwJgrjCRmgUGnH6F4+e92d510Q9PPNseDCpsMzJeEtON1o3Pvr2SrtXwOYLdNnwYOY7
 F9k4YcDXFQ5f1i1ow8KAKx/Qn8O0ePoTOebK/wJIaY6BxlYfAnJJY5gSYpheTzKE0O0D
 yLW2XePdAa8xynaz1CmgFuuuZUH1A3jVSX6rrpjfkDDwsjqbFZFRlgzHdIaZM4gyuj6U
 4rJg==
X-Gm-Message-State: AOJu0Yw0zkFDsUIYkK+IwsBF0HRLh+Qk14J4eY34zohYX0DY633NuAC4
 U2e9ykRjcw8SIt9MAwBb8O5EXAszSrec0plgs5PhrkO3R466ypMcE9bmAyNsYmS1ndH5Xjdg/BO
 7z3K+Y9tqxfcztH3mYvLg2Qal4FtGxJ5JWBtuit/R/5rm8nwASnycO7UvuYiA5MWaqNHkHn51S0
 bDosuMoQ3eHO/sYdbY15HPgrwLRewsoTcpO0KsT/c=
X-Gm-Gg: ASbGncuic1Y4PwsI14DBl/ljb/NiyS5IqwVEcOiP2OjqjB2QlwKjpDKoOPyNGiU20Mg
 y/7FIsogyVbWtxQivSeE5eIGpsBGCWSFnoNnn4VyaUKfI2hHPYtn0mfUrF7BUlmFzZTCB9KA3KQ
 IYJFcXD4j2i2GTVHC+4mZK82mv6B/X5a+igFXfwMeOHWkfwmfFolffyDqFcUF+pKGRItQllMbtZ
 +3mS69613Cf4njT80WKY4geSavkkDlyTeVSOpr7J0gcMh/zQvkOwNTC8FI=
X-Received: by 2002:a05:6402:354b:b0:5d0:bf4a:3dfe with SMTP id
 4fb4d7f45d1cf-5d972e4e7b6mr10309143a12.23.1736534866761; 
 Fri, 10 Jan 2025 10:47:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbby1OGsGkfTIQcEh7LJZw3q8Z7dQXwnh9y7cbY3Pf2UcNEBE0eA9lINn9sofDdRtCyXbkRQ==
X-Received: by 2002:a05:6402:354b:b0:5d0:bf4a:3dfe with SMTP id
 4fb4d7f45d1cf-5d972e4e7b6mr10309124a12.23.1736534866306; 
 Fri, 10 Jan 2025 10:47:46 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d9903c3333sm1980993a12.47.2025.01.10.10.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 35/38] i386/cpu: Hoist check of CPUID_EXT3_TOPOEXT against
 threads_per_core
Date: Fri, 10 Jan 2025 19:46:16 +0100
Message-ID: <20250110184620.408302-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Now it changes to use env->topo_info.threads_per_core and doesn't depend
on qemu_init_vcpu() anymore.  Put it together with other feature checks
before qemu_init_vcpu()

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20241219110125.1266461-8-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1797bd8c071..3f9475b4856 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7883,6 +7883,21 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
      */
     cpu->mwait.ecx |= CPUID_MWAIT_EMX | CPUID_MWAIT_IBE;
 
+    /*
+     * Most Intel and certain AMD CPUs support hyperthreading. Even though QEMU
+     * fixes this issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
+     * based on inputs (sockets,cores,threads), it is still better to give
+     * users a warning.
+     */
+    if (IS_AMD_CPU(env) &&
+        !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
+        env->topo_info.threads_per_core > 1) {
+            warn_report_once("This family of AMD CPU doesn't support "
+                             "hyperthreading(%d). Please configure -smp "
+                             "options properly or try enabling topoext "
+                             "feature.", env->topo_info.threads_per_core);
+    }
+
     /* For 64bit systems think about the number of physical bits to present.
      * ideally this should be the same as the host; anything other than matching
      * the host can cause incorrect guest behaviour.
@@ -7987,21 +8002,6 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     x86_cpu_gdb_init(cs);
     qemu_init_vcpu(cs);
 
-    /*
-     * Most Intel and certain AMD CPUs support hyperthreading. Even though QEMU
-     * fixes this issue by adjusting CPUID_0000_0001_EBX and CPUID_8000_0008_ECX
-     * based on inputs (sockets,cores,threads), it is still better to give
-     * users a warning.
-     */
-    if (IS_AMD_CPU(env) &&
-        !(env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_TOPOEXT) &&
-        env->topo_info.threads_per_core > 1) {
-            warn_report_once("This family of AMD CPU doesn't support "
-                             "hyperthreading(%d). Please configure -smp "
-                             "options properly or try enabling topoext "
-                             "feature.", env->topo_info.threads_per_core);
-    }
-
 #ifndef CONFIG_USER_ONLY
     x86_cpu_apic_realize(cpu, &local_err);
     if (local_err != NULL) {
-- 
2.47.1


