Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F66FC5479B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKnZ-0007sJ-AJ; Tue, 20 May 2025 07:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnT-0007bm-Q7
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnS-00038G-6e
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9jTCBoT4fjDiWE43eOzjmB5Ao3aqWWwZwOIympmqY0=;
 b=FbSzkMVNiiEZwtocd+OkN9qc+RYNZw+s2FKDKf0OCzZt0jRa6lNDS8RJ14KNInymNqmEd1
 pmuyXXNNS/eGFzL4hXglxwN4IhphYQivZtXzYw6jkhq8o5y1hdBURp5MiTHdLonJhr0BH7
 O2a/BZzqIbGBkSRYy4r7njW0WiVagN4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-c4zRCJ2JOd6Ctcs6wydXwg-1; Tue, 20 May 2025 07:06:08 -0400
X-MC-Unique: c4zRCJ2JOd6Ctcs6wydXwg-1
X-Mimecast-MFC-AGG-ID: c4zRCJ2JOd6Ctcs6wydXwg_1747739167
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ad56c5412f2so159391266b.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739166; x=1748343966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A9jTCBoT4fjDiWE43eOzjmB5Ao3aqWWwZwOIympmqY0=;
 b=iDuWRk1OiyUO+ATs8MVGE5cWS3jfLx8mgFJMqAao/PlZN1kyVtDjJ8UzBzvp0UCjLX
 bJYR2MZSzvJP/+yyKUqhRL8FMj7ikQz3Wl9mgLK7+H2Ob+h25et4Uand2pgOL4qb/+7T
 9QGJThsNt+uXTMOHkNtvUjYzLeoqjE1Hw8sR3KqRzJ7XSWS0qO9xN6EwEmurIjzwrmG0
 Ht9f3pDCvVmOa5yrEw68V61Pme2txDN2bgh2oHDNvs+Mb3dDnrQ17HEMMklQZk4foMfx
 xXxcRDGVgL5+akVCLZ0FWlkwf8Nu5HPkb90E6Wq9RbcKgE3I0lf8+62wpGnt+WucbZe1
 8OZQ==
X-Gm-Message-State: AOJu0Yz2Vi5nEMY2S8KW6nwa3T9V1DeCj5epsSVIssri2rajHk39goUF
 B1m0C9QRHxpBeQseKAiPPGeefzi9radw4uH1rKTZSpGOI4emxyYmainoKAGODeZnm40QVAMuynB
 0brg+QsQlM9X1AkUGHU9CBVkbbSIc3tD8oUcEX/AEicgdOTl6S0qC5M5xtrznD0YMDY80IGs11D
 ytfBeVGO9HyQogeCvpbU6T4tvHNtHttgrjPNoemhMo
X-Gm-Gg: ASbGncvSjmBBUqw3Vxts4kDq+hjq5GyIj6GBcxsdkFwbAwIphSCZFZQcT55XDKSJSHW
 IObDbpoefk+fuIzyj/P1N8zhGS+ZZ+GYk4cOeEwLwY+muRNFnh5vWzR87e/O3ZB747+ce3Egy0v
 GpYPCGTe1F7L0F2SSQPSYzjXOtUbPCRLq8FezVrADAei0XDMxy04ksGwTA/TT85HMo6lgcLiBs4
 8Ex3R7RqHFwunJbOowzoqfXSLcoiAZ7yBjimfG82kpO4LvHsAypRQze4GF+IL1d9XZVkLL+mlP6
 8T6n+bFBgMNjzQ==
X-Received: by 2002:a17:907:3e16:b0:ad2:3fa9:7511 with SMTP id
 a640c23a62f3a-ad536dce687mr1566825466b.41.1747739166451; 
 Tue, 20 May 2025 04:06:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs2cxroTfvAWEaKtopxIAhFdhfBy06xh+Uz1wkv+9GuwaUY7DbB52JXZk/XCZxDnJP985HHg==
X-Received: by 2002:a17:907:3e16:b0:ad2:3fa9:7511 with SMTP id
 a640c23a62f3a-ad536dce687mr1566822366b.41.1747739165982; 
 Tue, 20 May 2025 04:06:05 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d4ca654sm705669466b.158.2025.05.20.04.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>
Subject: [PULL 15/35] target/riscv: introduce RISCVCPUDef
Date: Tue, 20 May 2025 13:05:10 +0200
Message-ID: <20250520110530.366202-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

Start putting all the CPU definitions in a struct.  Later this will replace
instance_init functions with declarative code, for now just remove the
ugly cast of class_data.

Reviewed-by: Alistair Francis <alistair23@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.h |  4 ++++
 target/riscv/cpu.c | 27 ++++++++++++++++++---------
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 731ea2540cd..9de3f716ea6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -538,6 +538,10 @@ struct ArchCPU {
     const GPtrArray *decoders;
 };
 
+typedef struct RISCVCPUDef {
+    RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
+} RISCVCPUDef;
+
 /**
  * RISCVCPUClass:
  * @parent_realize: The parent class' realize handler.
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 54a996c2927..6e92fbb9928 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3073,8 +3073,9 @@ static void riscv_cpu_common_class_init(ObjectClass *c, const void *data)
 static void riscv_cpu_class_init(ObjectClass *c, const void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
+    const RISCVCPUDef *def = data;
 
-    mcc->misa_mxl_max = (RISCVMXL)GPOINTER_TO_UINT(data);
+    mcc->misa_mxl_max = def->misa_mxl_max;
     riscv_cpu_validate_misa_mxl(mcc);
 }
 
@@ -3170,40 +3171,48 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
 }
 #endif
 
-#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max, initfn) \
+#define DEFINE_DYNAMIC_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
         .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
+        .class_data = &(const RISCVCPUDef) {                \
+             .misa_mxl_max = (misa_mxl_max_),               \
+        },                                                  \
     }
 
-#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max, initfn)  \
+#define DEFINE_VENDOR_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
         .parent = TYPE_RISCV_VENDOR_CPU,                    \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
+        .class_data = &(const RISCVCPUDef) {                \
+             .misa_mxl_max = (misa_mxl_max_),               \
+        },                                                  \
     }
 
-#define DEFINE_BARE_CPU(type_name, misa_mxl_max, initfn)    \
+#define DEFINE_BARE_CPU(type_name, misa_mxl_max_, initfn)   \
     {                                                       \
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
+        .class_data = &(const RISCVCPUDef) {                \
+             .misa_mxl_max = (misa_mxl_max_),               \
+        },                                                  \
     }
 
-#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max, initfn) \
+#define DEFINE_PROFILE_CPU(type_name, misa_mxl_max_, initfn) \
     {                                                       \
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
         .class_init = riscv_cpu_class_init,                 \
-        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
+        .class_data = &(const RISCVCPUDef) {                \
+             .misa_mxl_max = (misa_mxl_max_),               \
+        },                                                  \
     }
 
 static const TypeInfo riscv_cpu_type_infos[] = {
-- 
2.49.0


