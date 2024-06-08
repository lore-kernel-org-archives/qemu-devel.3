Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A099C27C65
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXq-0000qw-9J; Sat, 08 Jun 2024 04:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXm-0000pE-Lt
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXl-00006M-6l
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xc/U+YMat7XpkxN0Aso1HqXRcKOMnxcWoqmk4VW3ERw=;
 b=SOAwhU15EqHdwCS8DE6cHOaKb2aQJInkn0GMjZPDL9gHNXgTvYcDfRTh05oEPlUMlO6HcH
 zSlFuuOt1ikTyjy30VvlrO5IR05cULIFWqGo6pA/20W4U4UBEYfO8KB8pqa0eKCJX6S1/A
 wQqRJ4bR/nXciXcktbfA5mxcpP6VwCg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-OrUdCOVlM9OS0zg3_OJ66w-1; Sat, 08 Jun 2024 04:35:17 -0400
X-MC-Unique: OrUdCOVlM9OS0zg3_OJ66w-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57c602f0125so1047003a12.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835715; x=1718440515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xc/U+YMat7XpkxN0Aso1HqXRcKOMnxcWoqmk4VW3ERw=;
 b=k89Utsn/Q42JIUUnbLJC0s2+ClNV4KHLR8xcDjuF4pr2rWm5Nmrvp7ZW8+elBaNpTa
 3Ozr/00v8VRohMs944/lGrATgpqYq2fTigiep8CBdcX7BLuvQbam9MHLAbj03wfA+zNJ
 hTbsXJB+5TIf2vYMkjkm17oK9E7O+AwuiSyBj0Hxrvg5+VFAWGgHIK4qFR/T3QPFkRhC
 a35xW258nkSpBCwrkn0Y9zqbjUJoDMXB4U0StfVGytMpeidMYGdoyGIDFuRRAf7ky1eC
 vaJBG+lL6R5dIEQ5ANP/WCgLex1rjmewCIMTTzxCA6vz/LvscIV5Qc1EK6tmBXGonj04
 Pzng==
X-Gm-Message-State: AOJu0YyvCP1ySNng1TsDqoK1AH52D0ieODbWXlrppD2EggpcsOcgxhhn
 cS10lYhjyop9mCiE8t+Kln97iC/CbNYa1dAEh85ZUsUiKxvWYl7zXPoAjPh5hPSYQB0ZOCFwbob
 S7U2s32UBSWhwCJJLnFJCbdPi47yOiwgfamTli/I21uz6IPdNejvyvIbq6r/GH62AyIYo6kZPVj
 E7iW0LuDzbOxuR1PICN7ZQFd3aY9J/V9vBTJFt
X-Received: by 2002:a05:6402:3547:b0:57c:7340:304d with SMTP id
 4fb4d7f45d1cf-57c73403738mr48039a12.15.1717835714958; 
 Sat, 08 Jun 2024 01:35:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ8PM2rVXBGx+6cZeM9LaoO2f/6l0dsdxPUG9USlLDYlvBnpk3DvMmja7kytXcqTZxsNTe8g==
X-Received: by 2002:a05:6402:3547:b0:57c:7340:304d with SMTP id
 4fb4d7f45d1cf-57c73403738mr48028a12.15.1717835714631; 
 Sat, 08 Jun 2024 01:35:14 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae13dc46sm3970363a12.52.2024.06.08.01.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:35:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>
Subject: [PULL 21/42] machine,
 hostmem: improve error messages for unsupported features
Date: Sat,  8 Jun 2024 10:33:54 +0200
Message-ID: <20240608083415.2769160-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Detect early unsupported MADV_MERGEABLE and MADV_DONTDUMP, and print a clearer
error message that points to the deficiency of the host.

Cc: Michal Privoznik <mprivozn@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/hostmem.c | 16 ++++++++++++++++
 hw/core/machine.c  |  8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 1edc0ede2a5..6da3d7383e3 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -170,6 +170,14 @@ static void host_memory_backend_set_merge(Object *obj, bool value, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
 
+    if (QEMU_MADV_MERGEABLE == QEMU_MADV_INVALID) {
+        if (value) {
+            error_setg(errp, "Memory merging is not supported on this host");
+        }
+        assert(!backend->merge);
+        return;
+    }
+
     if (!host_memory_backend_mr_inited(backend)) {
         backend->merge = value;
         return;
@@ -196,6 +204,14 @@ static void host_memory_backend_set_dump(Object *obj, bool value, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
 
+    if (QEMU_MADV_DONTDUMP == QEMU_MADV_INVALID) {
+        if (!value) {
+            error_setg(errp, "Dumping guest memory cannot be disabled on this host");
+        }
+        assert(backend->dump);
+        return;
+    }
+
     if (!host_memory_backend_mr_inited(backend)) {
         backend->dump = value;
         return;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index a0ee43ca5c0..c93d2492443 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -428,6 +428,10 @@ static void machine_set_dump_guest_core(Object *obj, bool value, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
 
+    if (!value && QEMU_MADV_DONTDUMP == QEMU_MADV_INVALID) {
+        error_setg(errp, "Dumping guest memory cannot be disabled on this host");
+        return;
+    }
     ms->dump_guest_core = value;
 }
 
@@ -442,6 +446,10 @@ static void machine_set_mem_merge(Object *obj, bool value, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
 
+    if (value && QEMU_MADV_MERGEABLE == QEMU_MADV_INVALID) {
+        error_setg(errp, "Memory merging is not supported on this host");
+        return;
+    }
     ms->mem_merge = value;
 }
 
-- 
2.45.1


