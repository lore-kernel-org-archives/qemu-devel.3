Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51467C3ABDD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrv5-0004fs-EO; Mon, 19 May 2025 00:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrob-0007zj-1V; Mon, 19 May 2025 00:09:27 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGroX-0004Kp-L4; Mon, 19 May 2025 00:09:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so3965280b3a.3; 
 Sun, 18 May 2025 21:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627759; x=1748232559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwEOicLBArpbP54gxHI3sjHHqXAz8WjPPZUAxbfz9kM=;
 b=FoB2R746JSZhMUZrE5YFxF/un4jZnsPJ26g6pIqCPVryAHLP3h445ePASB7DvYm4JA
 12p7XMiDdRQhxdFfkNArwTc884u/kVJMOIX40FU+X9tEGa+S6v7BC2MPd8AP2xf0Lrjo
 7kfAxm6EtJTITV3EiGOedqgFiUIkgmZdklryIxNJfusLFdvbc3iqSy6TrD5QsvFZH+tk
 uZ0fxVZswmYe2qfTHfi2wiXGtyOHpztOcGbBwuBCM83hTepOGuuqQX82B1Fr8CYpaAS7
 2o9YeCvXG1Bs8wRimAOm8kcl39axpknmIbB4j+2qiBRjXtUsM61d5VnpOKVuNyOZwbW0
 jIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627759; x=1748232559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SwEOicLBArpbP54gxHI3sjHHqXAz8WjPPZUAxbfz9kM=;
 b=fHUyLz0Y+uifo40/77A6K+oEcNbOJ5PmPQM9aBqhiUubJM3X20at1YHGKVPr9i0ahx
 RlXN73KDNA837j4ZdUYrO/FHPau5Fos2y6Hh9zvdmY2lV+SSEdkjDpIYiQkjExTTF6ti
 vkg0+hAIa1vVw0cZdocXurM5U6eXLS8Hi018JaA+PC5zdXS9NiM7VwO91EHFGoJQBkR4
 odM6DlCWXneoTLuYxok/PAYYlAbIki/idIYtLuc449tzBahryWc3MWuVvZz9J5RDMZm+
 SNuZrwQgv7w7tdDV7AljWnGLigJOJBbYqpprILH4jdqWQoLGjcVJOr8bQeOV8nWPMG29
 GiRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtcJ2q1d1qa+4AeQ6mgQyZIf11kUcHus79iKIq0SEVzHjTl200wXYAwI74mJeyzwIJKX4h5cPCxsYpMQ==@nongnu.org
X-Gm-Message-State: AOJu0YwdIJPa+ml5gwNsE1t4mAHYFTqXzMgHnP1SmdH38/R5aVmqMg+u
 wWBG+X/kMvuGkvWkVuXtuBX/AnsHeWl0oSeD7yQKG4oqPOqGQj545fw8F2x/cA==
X-Gm-Gg: ASbGncsPKQZe1vxHxlesXhNMMDYFl1yBmA4sjek4wBY0d6wOpa1eq8KDgXK5R7mfAcY
 C6rgwW94Ddek/kez4PEmDhp4+7Q27ZK0qxfDGHu+FAD7hYRbXwLHvX0ktzVqXqqzgh+nsS+JVAO
 ddQp4GaHXzDZvudytoXjiDP8Vzgy6x0xzAGpdewNikiK5h/Cac47YXDQ2Dd9KOU/uh0dvQbHuwY
 AuzdaSY24O4UA5x4lpsji+dX5Agz1GDB8NH/D2pDAO+9vEV5XQrMIRw9Mxn9823sEJEXy/KYdLG
 vT6FOYG1vtbSLVT7dghCctwSPK63LDj8B+3NM1Fa64iCob7NaprG06xFlPkh8r3Qfo/FFD45EKF
 /bbXBkxHIFH+MWPNvefmWMcrkGsWrl51UNknsk9fRkpzUiCTWbMbu3blf
X-Google-Smtp-Source: AGHT+IEdz+5jzmEVyeJ/pawFACwegxzNkEdAywn6AZ7hv1wHLpW1V9Ukf4Q8A3a0/veVQJy6EGQrAw==
X-Received: by 2002:a05:6a20:9f43:b0:1f3:40a9:2c36 with SMTP id
 adf61e73a8af0-216218c3e5amr15944486637.10.1747627759453; 
 Sun, 18 May 2025 21:09:19 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:09:18 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 41/56] target/riscv/kvm: turn u32/u64 reg functions into macros
Date: Mon, 19 May 2025 14:05:38 +1000
Message-ID: <20250519040555.3797167-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

This change is motivated by a future change w.r.t CSRs management. We
want to handle them the same way as KVM extensions, i.e. a static array
with KVMCPUConfig objs that will be read/write during init and so on.
But to do that properly we must be able to declare a static array that
hold KVM regs.

C does not allow to init static arrays and use functions as
initializers, e.g. we can't do:

.kvm_reg_id = kvm_riscv_reg_id_ulong(...)

When instantiating the array. We can do that with macros though, so our
goal is turn kvm_riscv_reg_ulong() in a macro. It is cleaner to turn
every other reg_id_*() function in macros, and ulong will end up using
the macros for u32 and u64, so we'll start with them.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250429124421.223883-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/kvm/kvm-cpu.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 86eb3c2e3b..b037cb2781 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -58,6 +58,12 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
 
 static bool cap_has_mp_state;
 
+#define KVM_RISCV_REG_ID_U32(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U32 | \
+                                         type | idx)
+
+#define KVM_RISCV_REG_ID_U64(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U64 | \
+                                         type | idx)
+
 static uint64_t kvm_riscv_reg_id_ulong(CPURISCVState *env, uint64_t type,
                                  uint64_t idx)
 {
@@ -76,16 +82,6 @@ static uint64_t kvm_riscv_reg_id_ulong(CPURISCVState *env, uint64_t type,
     return id;
 }
 
-static uint64_t kvm_riscv_reg_id_u32(uint64_t type, uint64_t idx)
-{
-    return KVM_REG_RISCV | KVM_REG_SIZE_U32 | type | idx;
-}
-
-static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
-{
-    return KVM_REG_RISCV | KVM_REG_SIZE_U64 | type | idx;
-}
-
 static uint64_t kvm_encode_reg_size_id(uint64_t id, size_t size_b)
 {
     uint64_t size_ctz = __builtin_ctz(size_b);
@@ -119,12 +115,12 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *cpu,
     kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG, \
                            KVM_REG_RISCV_CONFIG_REG(name))
 
-#define RISCV_TIMER_REG(name)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_TIMER, \
+#define RISCV_TIMER_REG(name)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_TIMER, \
                  KVM_REG_RISCV_TIMER_REG(name))
 
-#define RISCV_FP_F_REG(idx)  kvm_riscv_reg_id_u32(KVM_REG_RISCV_FP_F, idx)
+#define RISCV_FP_F_REG(idx)  KVM_RISCV_REG_ID_U32(KVM_REG_RISCV_FP_F, idx)
 
-#define RISCV_FP_D_REG(idx)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_FP_D, idx)
+#define RISCV_FP_D_REG(idx)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_FP_D, idx)
 
 #define RISCV_VECTOR_CSR_REG(env, name) \
     kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_VECTOR, \
-- 
2.49.0


