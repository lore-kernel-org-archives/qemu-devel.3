Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3124CC3600C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 07:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1K2o-0002yC-8L; Sun, 06 Apr 2025 03:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2T-0002u0-Q6
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u1K2S-00020V-5F
 for qemu-devel@nongnu.org; Sun, 06 Apr 2025 03:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743923006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0W5TW+PFsOIgpE3ckqKF8IGqThWiMPq7KeIJtLNbkTU=;
 b=dt4oUYQhxlHGsV1CCWasF/LOHYGT2vB/q96GRsmfTtwVJicI+XpWsIiSMKbTpKamALih4J
 BCEkrj/EhlGV4alXsq5BaS49hikRy1/fQF7ZqJ7OALaEzY9SXBhsmZLCgzTcQzRAeSYdJW
 qnrLQWzf1iI7aEUkUFkOUzx8tSYGVXU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-HWW0Gdg0PhSqh1r8PcBM4w-1; Sun, 06 Apr 2025 03:03:25 -0400
X-MC-Unique: HWW0Gdg0PhSqh1r8PcBM4w-1
X-Mimecast-MFC-AGG-ID: HWW0Gdg0PhSqh1r8PcBM4w_1743923004
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43eed325461so2565185e9.3
 for <qemu-devel@nongnu.org>; Sun, 06 Apr 2025 00:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743923003; x=1744527803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0W5TW+PFsOIgpE3ckqKF8IGqThWiMPq7KeIJtLNbkTU=;
 b=ZcaERonsIhJJU+kIB6+jNmc/HsQQ6DyqBMFqTctH4ePqmzPNi75EoYGbGoe4gHW+cR
 IkspT91t43s9SmQmCUpf+n46dhehjrMJE9bm3vx3KxS4xeULYyt5u7ZcqwmkSyw6wVsV
 RnhmL44ynYMs2Yq+f9VGZBgVEqUAKO63oVeMBa5dhmGhnhml3mQnJpDUC5oMgNpl0pA+
 Rzwd5fqtY715Ohi1uiGyMeKQEavkYU5jRWAuYNxDuDGtbh/WtZ9omyfD/ITRe+EyQHiq
 aLaK3OIPHhvi61WH6gqMWjoJ9Mp++W4Tj2YBQoqXGnyH8TgR3Gh9CR0XSOxaM3gDaBjg
 PzFw==
X-Gm-Message-State: AOJu0YwQolJAEqMxpl7XD3vxp0VqfBpZ/wO0scPlfioM7iUhP1/Vrrw8
 G2QxIXQ7Lx9WKe68mdMG6cY9Qhu9eHLBb3xvexZIbfxrUxEJ9tjUV3yYz+4R+RMgdIJD/s1vHE7
 XESO76FIaj24qJI6E0/peDSKW9RYc5nsZJSR3qpmJqBrOHWaDHCr2PzrKFK6J0aqZuxHkVubG8h
 9BHiPNHbr8Hn+DmRcF2bgdL2/lkjs6ZG2Q2ds1
X-Gm-Gg: ASbGncv8ZFrMlzvoQWSmoFo18OPSb8Wl7FJWk7n0g3ZGPfjaEev6hZU8PuqxxycCqp7
 Xc+c8ika/4ly0V8cTiY4J8YkbhR/yVypiuCZHSQhlHw9rLbVMhlO/4ZDorDlGYcR9McqNVNYA+z
 Q2YCbfudUeBDJ+2S87axU8co7iPhZXocTZSSM+mQqOSEFuqZAZdDNu4e8HZxbzgMXeV41naY6Wu
 2PI8uVnbZOZHlooWjIvpNpBVj7JIc4TRiUUqcTT+MTZxhuvMV3yak8alU2ohnJtpySM2USnbctq
 NB//2hvWwsy1GdvWRQ==
X-Received: by 2002:a05:600c:3586:b0:43d:649:4e50 with SMTP id
 5b1f17b1804b1-43ecf86a99emr84213245e9.13.1743923002884; 
 Sun, 06 Apr 2025 00:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ/c/Ckt3egWOzmrPUqDbmEKLU6fO2UUlU7V7QCa7hSpqAJsGBfiaiJBUvw0fwikXzj8U8Tg==
X-Received: by 2002:a05:600c:3586:b0:43d:649:4e50 with SMTP id
 5b1f17b1804b1-43ecf86a99emr84212935e9.13.1743923002505; 
 Sun, 06 Apr 2025 00:03:22 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.96.77])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec366a699sm91440215e9.38.2025.04.06.00.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 00:03:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 09/27] target/riscv: merge riscv_cpu_class_init with the
 class_base function
Date: Sun,  6 Apr 2025 09:02:36 +0200
Message-ID: <20250406070254.274797-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250406070254.274797-1-pbonzini@redhat.com>
References: <20250406070254.274797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.359,
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/cpu.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 25132e57380..58cc2743a53 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3089,15 +3089,18 @@ static void riscv_cpu_class_base_init(ObjectClass *c, void *data)
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
@@ -3197,7 +3200,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = (void*) &((const RISCVCPUDef) {       \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
@@ -3208,7 +3210,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_VENDOR_CPU,                    \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = (void*) &((const RISCVCPUDef) {       \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
@@ -3219,7 +3220,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = (void*) &((const RISCVCPUDef) {       \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
@@ -3230,7 +3230,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = (void*) &((const RISCVCPUDef) {       \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
-- 
2.49.0


