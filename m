Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F557E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK4E-0003TT-Uz; Fri, 10 Jan 2025 13:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2m-0000Vb-JK
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK2j-0001DD-Ht
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fJMQwMv56LSiqWYeYKdbo7EuNXacm0XCkWqmd0PHSvI=;
 b=XFTrrVPqvdiwwhjwfpGMJ+4y0gN/V2HAR4LP+5erKYL/XddAI8y/YobCewmNXLMxrYlCRX
 /QJHjXIkQJ0wVlVHt8XUCBGXxXuumsEfnULbiTuPJetPCVi4W8aS0tQ8ZxHq344IcdTunM
 LPLTyPWGNErlCpSgM+cRB9pvPr7pe08=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-QTEA5NPfNMWMyyCLvhuScQ-1; Fri, 10 Jan 2025 13:47:35 -0500
X-MC-Unique: QTEA5NPfNMWMyyCLvhuScQ-1
X-Mimecast-MFC-AGG-ID: QTEA5NPfNMWMyyCLvhuScQ
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aaf921b8a85so217744566b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534853; x=1737139653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fJMQwMv56LSiqWYeYKdbo7EuNXacm0XCkWqmd0PHSvI=;
 b=prLZ7hj95Ff3o8Wn8rJJon8ncA0GebFwTyIJFYtllD4BRRtelL8Vs9WMg9sVMl8IRg
 1klYNe7JqHsQSo4gXHtVTVw/WcG+vwWTX0emd95Y56OAXHSUG66hxPUylt1pmBMO36nj
 38b37f6f4qJpYuXHJf/t8e+aLzd+Vj4QPmE8feiYPs2gIQFpdGpw1ciY9ayExmPUWWvY
 8JisV7OWn7KT4iCZA8fdx0owbM2lYrNZa+tGbchvlbDca2oNxEN7DIta1xj1Hg/g7p92
 M1puxTQHQ5RKtcUgThpA9qld/jQWPlBBxzfjdy2uE5hCk15q0vVKu4KG/0WKYxq+dVkx
 EmhA==
X-Gm-Message-State: AOJu0Yytq7EfbNIf/29Ax6F4PL9gmZGQBf6MG7hDY+9H8GxY40V+fjtC
 TL32pEPqDVFJUQFJONlsDgyN/xx6VjmfMR8xA/bDF1kE2xTe7u0qeSe/N+tg0dNR/r4RoFqS1a+
 cgzGMMZ2P56Dl15gmM2vEm5T6nSBp6PMCUXfOtA5mhT/qzjv6GaYynAgWvPqRzoDI/GuQugYMxY
 bcPwyLPUxTkxqUKnFaHF8eYoykqG9NKGcdvFGC+pE=
X-Gm-Gg: ASbGncv2pBrGjflmJHuUYTbGP6TncbDXOK3O152kbr6yO9brKzP64ouYq/GOnI4gv3w
 oXDDbilBMtoKwzUe0wKaHyblSN2igmlOeETvNOJ8u6USvkC0R+FCGRNz9ft0vW+1kPa0yst7eUz
 //XaUVL4gRTc28hX/3ilmDcOVeAMAiTEf9nBrJf31PCtbtq8hbNzj8F2A/xUNsjUQ2mxlIpvbGz
 7iSdIu8kT+6BbsXXler/OddS7MKc2YOfNMibSsM0dUJiyWlRzB1XVOnX3o=
X-Received: by 2002:a17:907:9491:b0:aa6:b5d8:d5c2 with SMTP id
 a640c23a62f3a-ab2abca7737mr1222597066b.41.1736534853482; 
 Fri, 10 Jan 2025 10:47:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoyJ4mD42/O45kHGvZGOebOQ4srHmzT+UlkzwzYenVGgRxWeCiaXIj2Kpx+yqfBOJ5N3shAA==
X-Received: by 2002:a17:907:9491:b0:aa6:b5d8:d5c2 with SMTP id
 a640c23a62f3a-ab2abca7737mr1222594866b.41.1736534853110; 
 Fri, 10 Jan 2025 10:47:33 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99046dbe0sm1833189a12.64.2025.01.10.10.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:47:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 30/38] i386/cpu: Drop the variable smp_cores and smp_threads in
 x86_cpu_pre_plug()
Date: Fri, 10 Jan 2025 19:46:11 +0100
Message-ID: <20250110184620.408302-31-pbonzini@redhat.com>
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

No need to define smp_cores and smp_threads, just using ms->smp.cores
and ms->smp.threads is straightforward. It's also consistent with other
checks of socket/die/module.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20241219110125.1266461-3-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/x86-common.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index a7d46c31059..5b0629f9ad3 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -248,8 +248,6 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     CPUX86State *env = &cpu->env;
     MachineState *ms = MACHINE(hotplug_dev);
     X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
-    unsigned int smp_cores = ms->smp.cores;
-    unsigned int smp_threads = ms->smp.threads;
     X86CPUTopoInfo topo_info;
 
     if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
@@ -329,17 +327,17 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
         if (cpu->core_id < 0) {
             error_setg(errp, "CPU core-id is not set");
             return;
-        } else if (cpu->core_id > (smp_cores - 1)) {
+        } else if (cpu->core_id > (ms->smp.cores - 1)) {
             error_setg(errp, "Invalid CPU core-id: %u must be in range 0:%u",
-                       cpu->core_id, smp_cores - 1);
+                       cpu->core_id, ms->smp.cores - 1);
             return;
         }
         if (cpu->thread_id < 0) {
             error_setg(errp, "CPU thread-id is not set");
             return;
-        } else if (cpu->thread_id > (smp_threads - 1)) {
+        } else if (cpu->thread_id > (ms->smp.threads - 1)) {
             error_setg(errp, "Invalid CPU thread-id: %u must be in range 0:%u",
-                       cpu->thread_id, smp_threads - 1);
+                       cpu->thread_id, ms->smp.threads - 1);
             return;
         }
 
-- 
2.47.1


