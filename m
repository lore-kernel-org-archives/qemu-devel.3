Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5837CC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9J1Q-0006C7-2A; Mon, 28 Apr 2025 03:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1G-0005yQ-L2
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u9J1F-0001AW-06
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNKW+nKbNdvFEguo0/4mBWGSi8ji5hQjQQrP0NB+lJ8=;
 b=g8p0v+G+6oH0YYDSluwiV04iusSboY9P5x1HXH7sJM+hrRljvYRLXvDsKGtCWPZ76QF4Cz
 el7WQsReb0FuJIRu5stkgzzE7tgm5wf9s1VVqcsLxE+YSUN597VxxeQzLKRywcwTXWCudL
 FGDrdL6XS7NDLxzd29c7IqaCh9/6wg4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-k44_4xkVOXqg8AuqzGspIQ-1; Mon, 28 Apr 2025 03:35:10 -0400
X-MC-Unique: k44_4xkVOXqg8AuqzGspIQ-1
X-Mimecast-MFC-AGG-ID: k44_4xkVOXqg8AuqzGspIQ_1745825709
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39c1b1c0969so2714407f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 00:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745825709; x=1746430509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VNKW+nKbNdvFEguo0/4mBWGSi8ji5hQjQQrP0NB+lJ8=;
 b=F/2/ODygORoWC5pduLD0fDz24p3NWrqVqM67GBxeZShjRKULfHBHvT2fqKwDs1fcer
 1mjpHbgsmxjFHvMGy1P3XIRomlbcmViCj6Bf28xPFvFyCmPkM7J4LhMY0cHJnYe9Hzle
 Aw6GLiGYR5oBNEReWA7e8y2ANhs+bgneiY01TBv4rCVh2QXnJOiud/fKFqdxee1HSDUi
 SQSmAG+cnb8iRiNgIgS0sc+npTg6ooSb2x3t1f49FZlJG2MWLFNrg3PDBsG7X3edodKr
 auHx2y4ebJTllqMVwLmcv03gxMSKTDqv1b6B3AXzWA3VUhMD5iQv0g8z0OMEwiwegWHF
 VnZQ==
X-Gm-Message-State: AOJu0YznboybOWR94qBLvJO6sqRdMUhUJ97UZ7GDNDrqRsiaQ4G37ey1
 lWqOQeHVbzohBN1aEympaDIa3IPjh4BeN+qw5PF1GLxrRGii9K0A77xKeSj/1RmwM+B/bzMDPBp
 xX+yGuxqkDeknO4N48tZjr3xn8ViF5nwQts9GFLU/TuYlE8fS6DFKGHk0/9ZtktaKnfwe0U/hWy
 1zqYsWI7oC9rcU7Gq7r79NKxylZ3TEGgLzmAKe
X-Gm-Gg: ASbGncvDnWsBMHwWClDdyg2dO0AVQAKoL1FfxnSzpa0e5FoY4ernbRpM3lIbIOOGdYC
 ZlbDRQ3/Ov8BbGR3OgBpNVszO8zRExu65I3xL/TwIWhidgdrNZAxcS6+wpxXD/2gWTv+M5CrJjs
 KNa5MJS57+DPEWUWrXU9agWP0bSAVUZgnYT66McCwe5lTPsdivAIwlUd22jvJ5xRt3ykTZ8HII2
 t+tq1biB/JJ3Q6Txo82WOd/3dDA5n7Sprizehns2UylZvc8oKh07TSvaBL+IJMVRQmUhuD1vt2g
 Y1v578OTL/oK4L0=
X-Received: by 2002:a5d:5f4c:0:b0:39c:1429:fa57 with SMTP id
 ffacd0b85a97d-3a07aa5fe21mr5204204f8f.3.1745825709099; 
 Mon, 28 Apr 2025 00:35:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKZ2J9tNssOHsxnAtar/SDSWdZDeaSDIGOJmOkvTTXo3wKz3acDnbH0J2Ikdj6uoZmjxErRA==
X-Received: by 2002:a5d:5f4c:0:b0:39c:1429:fa57 with SMTP id
 ffacd0b85a97d-3a07aa5fe21mr5204186f8f.3.1745825708776; 
 Mon, 28 Apr 2025 00:35:08 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2e0241sm147573945e9.37.2025.04.28.00.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 00:35:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com,
	dbarboza@ventanamicro.com
Subject: [PATCH 09/26] target/riscv: merge riscv_cpu_class_init with the
 class_base function
Date: Mon, 28 Apr 2025 09:34:24 +0200
Message-ID: <20250428073442.315770-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428073442.315770-1-pbonzini@redhat.com>
References: <20250428073442.315770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
index d8c189d596b..0beaed2f340 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3081,15 +3081,18 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
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
@@ -3189,7 +3192,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_DYNAMIC_CPU,                   \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = &((const RISCVCPUDef) {               \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
@@ -3200,7 +3202,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_VENDOR_CPU,                    \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = &((const RISCVCPUDef) {               \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
@@ -3211,7 +3212,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = &((const RISCVCPUDef) {               \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
@@ -3222,7 +3222,6 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt, char *nodename)
         .name = (type_name),                                \
         .parent = TYPE_RISCV_BARE_CPU,                      \
         .instance_init = (initfn),                          \
-        .class_init = riscv_cpu_class_init,                 \
         .class_data = &((const RISCVCPUDef) {               \
              .misa_mxl_max = (misa_mxl_max_),               \
         }),                                                 \
-- 
2.49.0


