Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F86DC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 09:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEPrG-0007g7-Ne; Mon, 12 May 2025 05:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqt-0007av-2P
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uEPqq-0000gp-Eg
 for qemu-devel@nongnu.org; Mon, 12 May 2025 05:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747043615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7MGJVPPJWE0M96U7YuxOdFMN0noWY4dRSxZ4X+eNHc=;
 b=Acp0HhA81rgPAw3E8V0ry1wmt0yOeFWMDfyAPQ7qPMtj3WCHkhv8T8EeRR06dqDyEpHamp
 SJM60DwUPmmalbKQbK+IUQTbaczUgITuxZWnoZ2BU1VEFdWJLwxxxsOAKMgrEMg2fsuqNx
 vXxo2P4JuMq1r6VO9uIJNenME+cNN7o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-C5-2JWlIPiqttO4ao2jrTw-1; Mon, 12 May 2025 05:53:34 -0400
X-MC-Unique: C5-2JWlIPiqttO4ao2jrTw-1
X-Mimecast-MFC-AGG-ID: C5-2JWlIPiqttO4ao2jrTw_1747043613
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5fc86ce3c54so3181729a12.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 02:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747043612; x=1747648412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o7MGJVPPJWE0M96U7YuxOdFMN0noWY4dRSxZ4X+eNHc=;
 b=h+1ostc4rcLw5X99bWzhSxhfczcxTi+q/ZoUOwoLBTy7KxV4FHCdKgFwpApQ3NehJS
 TBxajVbzehO3Q9KYHTK2wjhQEgs1LUwJOHaguCjZD7SN6s7/POjWg1Hk/Xz20tlgH9rI
 pD25Ynwge/5R4CxA4tWStqoxEGUxzOVfyOiFA6aVAw71USxdvw3V7/KIuyWiuKXj7ZOr
 yPBfpLyiE+9H7fiE85P5ardl6K0RyqFpKCocPbMPw3xNDzZbLaoCZgfTPdGsreFPg453
 YH9xO7xWRkbSmX7j3ggJGFltbM83CaQ8w7A/cSsd+EQR50mdq0wbQOz9aY5m+QfykiXg
 wOlQ==
X-Gm-Message-State: AOJu0Yysqz/KuzpbsfRouj1va37F84VtstO13M9WmazFJijMIW9jl9rD
 hi+bDqcEJ43O8JLSL5EHg4MTWu0aIdJopnQlcddpvDP87jEVHbgs1V/naV3Lh6q+VjgrR1KwxK4
 NSzJwaJsqM/7jgH/tbKj5aVXUhCqjuig3GZdoxy0eTt3Cm4uqY4HMvuUrFzFYMZIxbDejEfExzf
 LraDqHCIBENeN9ASJuJCoiHrWTjcfQ5FOFNxnN
X-Gm-Gg: ASbGnctygL7fQYau3TokMSueDqF9YLQQIDUeSTabNDtuXj+WPmFZm0tZGwrQgYCABwJ
 JappNcKLWjNNlqfPjBP5CEHZ3VwlLxcDmH3RwdnhFyWOqIagcTGMNQt+LgAeOM5UO6VmAqJ1t9Y
 8FubYMexNqpLMi9/xiYZ7MQS5fs2hlpY4aLu5HFfbXLma88I4DbRLINFXb8ZmFUnrPEe3Ug4Zjk
 h7YEPL5KHyito6qknzWlwYXLj4CZGHsDCuMQJO2xZhJOoWvQFsFBA5bNRd5f1D80CZAIysvUlix
 oDMgADHwvq+LYJPpnqdLOCLivAS46w/XfAsA2+VIvMWijKw=
X-Received: by 2002:a05:6402:510c:b0:5fa:f7ee:191f with SMTP id
 4fb4d7f45d1cf-5fca11df2c5mr11602467a12.32.1747043612482; 
 Mon, 12 May 2025 02:53:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjdjeHHZwD7ZZrgGYUbhyKioOw10m9DlcHRXlD4E6o8Gz48S7xZUP6BwT+DvIt5p87p9UEfg==
X-Received: by 2002:a05:6402:510c:b0:5fa:f7ee:191f with SMTP id
 4fb4d7f45d1cf-5fca11df2c5mr11602443a12.32.1747043612056; 
 Mon, 12 May 2025 02:53:32 -0700 (PDT)
Received: from [192.168.122.1] (93-40-56-213.ip37.fastwebnet.it.
 [93.40.56.213]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fd20468681sm2425791a12.72.2025.05.12.02.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 02:53:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: dbarboza@ventanamicro.com, alistair23@gmail.com,
 richard.henderson@linaro.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 08/26] target/riscv: merge riscv_cpu_class_init with the
 class_base function
Date: Mon, 12 May 2025 11:52:08 +0200
Message-ID: <20250512095226.93621-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512095226.93621-1-pbonzini@redhat.com>
References: <20250512095226.93621-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 02f2073441c..ddade8a4370 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3080,15 +3080,18 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
     } else {
         mcc->def = g_new0(RISCVCPUDef, 1);
     }
-}
 
-static void riscv_cpu_class_init(ObjectClass *c, const void *data)
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
@@ -3188,7 +3191,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = &(const RISCVCPUDef) {                \
              .misa_mxl_max = (misa_mxl_max_),               \
         },                                                  \
@@ -3199,7 +3201,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_VENDOR_CPU,                    \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = &(const RISCVCPUDef) {                \
              .misa_mxl_max = (misa_mxl_max_),               \
         },                                                  \
@@ -3210,7 +3211,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = &(const RISCVCPUDef) {                \
              .misa_mxl_max = (misa_mxl_max_),               \
         },                                                  \
@@ -3221,7 +3221,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = &(const RISCVCPUDef) {                \
              .misa_mxl_max = (misa_mxl_max_),               \
         },                                                  \
-- 
2.49.0


