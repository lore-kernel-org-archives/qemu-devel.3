Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723A3C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 19:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u82Zi-0003In-E0; Thu, 24 Apr 2025 15:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u82ZU-0003GA-ND
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 15:49:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u82ZS-0001PI-U6
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 15:49:20 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso9910925e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 12:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745524157; x=1746128957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gAInPnbXVwc6+e5dH8946wooc5VHdtYj4fpx4QEz7pc=;
 b=wKMdzNDipCnyKvjQmBkItOIIZ7jlQJxTRCDLOCoN34YLDv8HT4Sqru88C1hko301nU
 fyT8o55vDFvaO2IZB4s+jdn5H1QiV97XqBT1rGzbfnwM0+3eN9oY6rMw0G4Ig4DkluH7
 qlqJf5mGmLMIdMDYQ4eUH8Y0XRAnLBc+2asdZoboery0Sx1tgjOaZcErmmRWb2unZL9G
 B7fk3ckSdI/PxaTNuJcCpThVG+vBGtw597bgsbmQy1CPKcHTn97foL+SvSgilcQ5Q9g5
 mUuOAoAlTKj+xggHnz0eIbs3yVW1eBoV40DtEAotsCoKffAGalFyFW1Lzo8odkLyWyc9
 SnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745524157; x=1746128957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gAInPnbXVwc6+e5dH8946wooc5VHdtYj4fpx4QEz7pc=;
 b=De6HNjMeu+giHb1ZRgql6SgG1789rW2/+Z+GhqHBlZLmsAafaq4lJDV7jT/Gd3oF/1
 JtFPOoRsmrLHbWLd+Z9zTzJ+hMc/iL+jMFwRwdqLBgkMUq0vKnzugh+Ux5tJR+PMmmmo
 JfZ8Z/C3n5DkH+vWJFq9VM9V+U0yR9X2F7vOC+ZtQh5CeEhHbAkPOvvA4uf5E7VbDxOj
 tMEnjF31Q1P/O0y8vGgwIlBA7jxujCkFJlvkNIuOHjdoBCmYyfbqmL0ZqzIm1Idf8PLT
 OfalWo/HlSO7IUK4/S9BlGel5IJVz2jmWzITuKRb+TN7Be52YviyZrZIF5tr3Ziskl9u
 reYQ==
X-Gm-Message-State: AOJu0YxfNmbdk0YyE6q+g6FQS+oXW9Cc91xvaadWbTx0Msmd0pCeJDd4
 VI40L+/o0Ub6b9cFwV25VUPmhWu0/DrH43zbS50OZ90L5zFbvhvOQqNUBJfnfqHjo49VexFs1j6
 C
X-Gm-Gg: ASbGncuNZQQlgvvvZum3KF3C2yn6lsbTyGqZ1uMvs/4+oG/6KB2eKxBWOS4vbrEx/0R
 AtO9ddRng8T1QVSCz03d4/wYWG7JbhYleLYoOYj+GfFL8HHi2NvRja1EbqEgmto8CRitkoaRwJ/
 P5oFHVVPY2aJ19jhaQa6EIjRGRQyn47tGf3X3hM+Z1h+C7miESXfBB5H+aQ9ivr49BsvGgztecs
 yn73waVatCEQMwlf74PqJ4OZZxgR/qcLzC+3fh+gtxFACSQuvxBaESnuIXK77IWXZoyYxDMYtwl
 Iil4Q/AxUlhL3caHnKmHi/sQNPYNkSchBeu6UdZZvX0U0GPhiiqsky/cCG7W8LL9y5rV8MrzLnj
 1BeDe539jBvkfMjU=
X-Google-Smtp-Source: AGHT+IEZggntGg0Y2GfDPjGUe3t1IEQTiLf9O7i4rEM7oSms+1vMwz+NlTBFTQQrU4QwCejdH7ZB+g==
X-Received: by 2002:a05:600c:a47:b0:43d:fa58:81d4 with SMTP id
 5b1f17b1804b1-4409bd8e123mr35290315e9.33.1745524156869; 
 Thu, 24 Apr 2025 12:49:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2a13bdsm32016265e9.9.2025.04.24.12.49.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 12:49:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 2/6] qom: Have class_base_init() take a const data argument
Date: Thu, 24 Apr 2025 21:49:01 +0200
Message-ID: <20250424194905.82506-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424194905.82506-1-philmd@linaro.org>
References: <20250424194905.82506-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/object.h     | 2 +-
 hw/core/machine.c        | 2 +-
 hw/core/qdev.c           | 2 +-
 hw/pci/pci.c             | 2 +-
 qom/object.c             | 2 +-
 rust/qemu-api/src/qom.rs | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 9192265db76..7bb14ca7067 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -487,7 +487,7 @@ struct TypeInfo
     size_t class_size;
 
     void (*class_init)(ObjectClass *klass, void *data);
-    void (*class_base_init)(ObjectClass *klass, void *data);
+    void (*class_base_init)(ObjectClass *klass, const void *data);
     void *class_data;
 
     InterfaceInfo *interfaces;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 63c6ef93d29..32f43f61698 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1240,7 +1240,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
         "Memory size configuration");
 }
 
-static void machine_class_base_init(ObjectClass *oc, void *data)
+static void machine_class_base_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     mc->max_cpus = mc->max_cpus ?: 1;
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 2745b5e0929..1e0f47cc848 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -693,7 +693,7 @@ static void device_finalize(Object *obj)
     g_free(dev->id);
 }
 
-static void device_class_base_init(ObjectClass *class, void *data)
+static void device_class_base_init(ObjectClass *class, const void *data)
 {
     DeviceClass *klass = DEVICE_CLASS(class);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2844ec55560..475b97c649e 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2809,7 +2809,7 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
         "access to indirect DMA memory");
 }
 
-static void pci_device_class_base_init(ObjectClass *klass, void *data)
+static void pci_device_class_base_init(ObjectClass *klass, const void *data)
 {
     if (!object_class_is_abstract(klass)) {
         ObjectClass *conventional =
diff --git a/qom/object.c b/qom/object.c
index 01618d06bd8..dfd59502d11 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -55,7 +55,7 @@ struct TypeImpl
     size_t instance_align;
 
     void (*class_init)(ObjectClass *klass, void *data);
-    void (*class_base_init)(ObjectClass *klass, void *data);
+    void (*class_base_init)(ObjectClass *klass, const void *data);
 
     void *class_data;
 
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 34d7bc0ef96..03fe6247ff6 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -492,7 +492,7 @@ pub trait ObjectImpl: ObjectType + IsA<Object> {
     /// the effects of copying the contents of the parent's class struct
     /// to the descendants.
     const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *const c_void),
     > = None;
 
     const TYPE_INFO: TypeInfo = TypeInfo {
-- 
2.47.1


