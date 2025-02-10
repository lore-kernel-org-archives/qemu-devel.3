Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89806C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 13:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thTx3-0003HE-MS; Mon, 10 Feb 2025 08:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtb-0008Rm-2f
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:32:24 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTtZ-0006Bq-5G
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:32:18 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38dc6d9b292so1705290f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 05:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739194335; x=1739799135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rd5jit2Zo4hDbvhlEwG5B/rwp4ji/UNHa+OzvlV8vE=;
 b=aiPPt3w7WUh4csEDQlGr3e/2qB/CQEy/nWR0AUYnn9gBVXO65WZ0QsKp48vF9SxDIe
 SmmruLMN7nyFElRTrmIeJI/rgBV4OqeORoyNym63nN+fhzuiuan0U+OhWnYxDE7a5yV8
 RHyAvg4oQJI6jLtug0v0nDERYg1saBNdmpZuKCSn0a0671qCd+inwdVCbGV46Pwk7Ilz
 FXpsudgujAG8V8ye6XESQc9XWhVe0CaKjJcT3AK3CXXSzIgSQLxlYRPWAUck2JIQKkX5
 YkXsOymMYw1NG1TmYjnK0a+MddhUgYielqPNr6YFvwt+nZPnlvfaNvyCWqDjRFneOSz4
 5Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739194335; x=1739799135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7rd5jit2Zo4hDbvhlEwG5B/rwp4ji/UNHa+OzvlV8vE=;
 b=ODFVQa5CyU05si4aRi05P8m1ZOqCyDxO1BuODfvS7C6rJuJg4edMaLBbhOFr4xzIYM
 FM9FkvKdHQWbIvEMi+ZSbEy87N/oVibVcR1wXuBiNb3TPZlJZMX+Vv8sE+MnixVSZAg+
 83C6QcovpnOBQ3lgAm7uUrm1PWYgmD1/30VN0kSCBUYaVOpzF6WaFfYmedgktNa38aEB
 cTNIO84mHw7pvFu8/HYrYJ1W50flJDqJAsimYMYsPt+O1h4UJQa9ku7apoiL08n0t6DV
 bih2DzuR8hUa1RvdJBRpu/9RaWZDYBV7kNdP34CJZZWXRGBua3uBbvMvjja1635O3+YY
 2CxQ==
X-Gm-Message-State: AOJu0YwGI5KC8bEvWgBLuyNlG1O82fudozh/opjXm+tw7MOwqvToZXCU
 EcBKfbJ3W7VYyRWwrNswGF2sqBdT3TuohaiWnllqWDsTNPM5YIMhtnGUgZGqrEg8ysVB0CfrE4J
 0XMQ=
X-Gm-Gg: ASbGncvJf+YsCkSL70Q0f6tKWTde701V3P7OFkSiSul8PfQAzJHh5hd1KKGgphabs1h
 n4P4BQclsZ3i/3xvvjkq0zzlLjdwGxh3mi3KTZdaWihLdvTzcXdX4RYLpTPE+cL7fZ7NwfPUqo9
 4CJ2LAFOfwGPD6mfTe60gNgeG2tlSWQ65tOWEyffxkjQbSj+Kp9VfvypdJnloYuV+NcF59ijILu
 LHT9nIQI/JOq4PMaYnymxK39FvcLASZu6JYgQSxNnwRV9PDZTrhAz+3oGSrd+xGI6xKNANs08IP
 RChAGtcjs8NedgyNseDH1iKgyf8U/SMCfXsa1MEK380vYwNPWJBxtFF3ehU3BZ1gXw1jIFo=
X-Google-Smtp-Source: AGHT+IEQEKtcbE8XbljqH+3Iud8DzCIOUPxEo0tNNElgo/lKui5IlWCtoX6+P2Rfyz+KgmmTAdM7lQ==
X-Received: by 2002:a5d:47ae:0:b0:38d:e149:f863 with SMTP id
 ffacd0b85a97d-38de149fc3amr2007689f8f.24.1739194335138; 
 Mon, 10 Feb 2025 05:32:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd44c5e3dsm6907090f8f.62.2025.02.10.05.32.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 05:32:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/11] qom: Have class_base_init() take a const data
 argument
Date: Mon, 10 Feb 2025 14:31:31 +0100
Message-ID: <20250210133134.90879-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210133134.90879-1-philmd@linaro.org>
References: <20250210133134.90879-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
index 254cc20c4cb..7bdde9286c2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1236,7 +1236,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
         "Memory size configuration");
 }
 
-static void machine_class_base_init(ObjectClass *oc, void *data)
+static void machine_class_base_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     mc->max_cpus = mc->max_cpus ?: 1;
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 82bbdcb654e..54578299147 100644
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
index 2afa423925c..00f50e6f2cc 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2712,7 +2712,7 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
         "access to indirect DMA memory");
 }
 
-static void pci_device_class_base_init(ObjectClass *klass, void *data)
+static void pci_device_class_base_init(ObjectClass *klass, const void *data)
 {
     if (!object_class_is_abstract(klass)) {
         ObjectClass *conventional =
diff --git a/qom/object.c b/qom/object.c
index ec447f14a78..61ac8cd4842 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -55,7 +55,7 @@ struct TypeImpl
     size_t instance_align;
 
     void (*class_init)(ObjectClass *klass, void *data);
-    void (*class_base_init)(ObjectClass *klass, void *data);
+    void (*class_base_init)(ObjectClass *klass, const void *data);
 
     void *class_data;
 
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index f50ee371aac..f3d43e066ef 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -475,7 +475,7 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
     /// the effects of copying the contents of the parent's class struct
     /// to the descendants.
     const CLASS_BASE_INIT: Option<
-        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
+        unsafe extern "C" fn(klass: *mut ObjectClass, data: *const c_void),
     > = None;
 
     const TYPE_INFO: TypeInfo = TypeInfo {
-- 
2.47.1


