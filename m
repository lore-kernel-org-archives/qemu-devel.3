Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABCCC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxbm-0002YR-LQ; Fri, 28 Feb 2025 05:28:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbM-00028U-0a
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnxbI-0002we-6k
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=la8TMWiUc4c6B6qKoQZYzzhdkbdzanTSY+y/5+QCTRQ=;
 b=NlzhNTNTfpFj1vhQGhD+vTO2KnyWDXuC6XQeTuO7+YI1NceI9/gzmzZhadholxVeVR6WP4
 O4c8GgHICqBwkkoWaVVFRo64mmyKWglqO3eklg2RNIEKwsnxVPdficuQu592BxPIJ2JbFe
 LVgza21bAKv/2Wb9D5E9ARWiNEjlD7E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-40YGnmFVPcaJpeSqTV99FQ-1; Fri, 28 Feb 2025 05:28:02 -0500
X-MC-Unique: 40YGnmFVPcaJpeSqTV99FQ-1
X-Mimecast-MFC-AGG-ID: 40YGnmFVPcaJpeSqTV99FQ_1740738481
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-390e50c1d00so1352227f8f.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 02:28:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740738479; x=1741343279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=la8TMWiUc4c6B6qKoQZYzzhdkbdzanTSY+y/5+QCTRQ=;
 b=N5tweCt+E0RCCvSWd46pcNeZkiV+UnOXmzBtc6vlgAkvJ1PNt5dmDW3djh8PKidsaF
 /QAU2qcvdMCiYqGe+aA4UFY2etbUk7nVvHsgbaacbrzYTB4cPHWmKDfG0gzpiX1+ScMq
 AxbYesV5lq5pMAbV8mO92sukDFnsKY/qJOlzSu1VZTHs+bR0HY8Jz7l8+0xBLdiR+ttT
 IOQpy0g5lZVBa4hWrBbNcEvs+6p7wkAdK/kI7F6QM75aufadB74YWBzsVnVcvPxIbWxD
 hn09uHd/vPKnrZfstQiydUWzP3XouLoIh6eDdzI3Jz3b+P+Fi3ET4f+sZeRcoXwH1/3g
 MAQw==
X-Gm-Message-State: AOJu0YzyyMevJFxSGhu2XKNMkS3at8bwNWkZO6QGoi8IWfr9yaPxRGQa
 NIpwJsphLOi+na/f+GuzKUzIVbobfSM/6vPvGwkUjU1+xt1sMt2u9/89bVPOMQFK+R88fsw/FSi
 35BnlOHLm097dLgf3falgRQyjijRxRftI5lfQgtMJv5lGoI36jj6KdVsIoN8H9E+RrjXt7dxFfh
 ArpzJkbXYmr1S3jk5gfN4D6Cj6BQqTvvE1//cuD2c=
X-Gm-Gg: ASbGnctJSXQll4CZEwlXBxNyqMmgHGy1IPq9AFqcNSGrBe6ISjGlAHE8lMw7UgchM/P
 5vDycvGKHadRKusKhOjaFxN7qTUx5KLUQKmSkw93lQZw9x0+rLLgKIoyJuqVS2kHquZM15UnAiI
 VTAdne97IYMgvMzdvJ52LDRKcmIxVy58/F2B5AAD03qXYdeWF8SY2XXcV0nPYBNBlm4fBR+4C42
 kwmYkkQj18Ng7sC09QBE/PlTPOCQyXuw/FWR2AB0PIZw8ayC0jwE52+msGH6H0sOCsJ+xUVOZxk
 1vHSnq5TAqHzmKbT6s2E
X-Received: by 2002:a5d:5889:0:b0:38d:c087:98d5 with SMTP id
 ffacd0b85a97d-390ec7c9013mr2476206f8f.8.1740738479614; 
 Fri, 28 Feb 2025 02:27:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHipLc5fjYbdEdthQXb9qO74m26tOiODbFDKDjBiNj7sdoLYXkkmewB+mXdBLz1lz7Kocc9vA==
X-Received: by 2002:a5d:5889:0:b0:38d:c087:98d5 with SMTP id
 ffacd0b85a97d-390ec7c9013mr2476188f8f.8.1740738479282; 
 Fri, 28 Feb 2025 02:27:59 -0800 (PST)
Received: from [192.168.10.48] ([151.95.152.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba53942fsm83195395e9.24.2025.02.28.02.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 02:27:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 05/22] target/riscv: merge riscv_cpu_class_init with the
 class_base function
Date: Fri, 28 Feb 2025 11:27:29 +0100
Message-ID: <20250228102747.867770-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228102747.867770-1-pbonzini@redhat.com>
References: <20250228102747.867770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Since all TYPE_RISCV_CPU subclasses support a class_data of type
RISCVCPUDef, process it even before calling the .class_init function
for the subclasses.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 51acce07752..91dd63edc9f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2967,15 +2967,18 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
     } else {
         mcc->def = g_new0(RISCVCPUDef, 1);
     }
-}
 
-static void riscv_cpu_class_init(ObjectClass *c, void *data)
-{
-    RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
-    const RISCVCPUDef *def = data;
+    if (data) {
+        const RISCVCPUDef *def = data;
+        if (def->misa_mxl_max) {
+            assert(def->misa_mxl_max <= MXL_RV128);
+            mcc->def->misa_mxl_max = def->misa_mxl_max;
+        }
+    }
 
-    mcc->def->misa_mxl_max = def->misa_mxl_max;
-    riscv_cpu_validate_misa_mxl(mcc);
+    if (!object_class_is_abstract(c)) {
+        riscv_cpu_validate_misa_mxl(mcc);
+    }
 }
 
 static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
@@ -3075,7 +3078,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = (void*) &((const RISCVCPUDef) {       \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
@@ -3086,7 +3088,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_VENDOR_CPU,                    \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = (void*) &((const RISCVCPUDef) {       \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
@@ -3097,7 +3098,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = (void*) &((const RISCVCPUDef) {       \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
@@ -3108,7 +3108,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = (void*) &((const RISCVCPUDef) {       \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
-- 
2.48.1


