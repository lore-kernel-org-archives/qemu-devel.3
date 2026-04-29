Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98408FF8864
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwrF-0001LD-Ka; Wed, 29 Apr 2026 00:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwrE-0001IH-Cc
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:08 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwr9-0008LO-3u
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:49:08 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso75747825ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438142; x=1778042942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YzCQglAuFo55n1ndLCOchCoUqIiCrL+yg0KWpQOh6n0=;
 b=ENeIIFyB6cSeSKWRd0efUekk9TITZvBb5So5/cNPI2ZXOOT80C+viUbLG6OMp8vKkm
 jFF0L4WbUSH9PLB+pI4kvGyi7izeA2Y7VDoPcy9yzCwqDhEI73NqZ5cRkSHhthOWbp28
 EYvBZW7ZuIUbi4pueOy0FIPKahkemkUdWRlWO44mMhBCHQQ/+sdjv7VWeudJl8IcWiZK
 n0+Ui9HZgh9A30VwLSGy18TCedxaQzWmPFl8yX+xK18ZUJr1nhvhNBL/5fNgUZokzjvl
 InrJlc8GP2g76o2HRJJQF2DCrPOKHZ++zi90naqkuTdCvarh+oK51OyVd8uP2D/LDJbw
 EsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438142; x=1778042942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YzCQglAuFo55n1ndLCOchCoUqIiCrL+yg0KWpQOh6n0=;
 b=CZxP/6U/YL9yrhiBwgyTPYWZoydqWsXjIKJLy915LxjhjTXElCUqPHAN0v3b2T+Fs5
 gX/+UbYBhQFXQRZbt3Q6szo3vE6CQ0IKiquqWDIep1CEOd5YtqQvjx9a8KiHn9x4TiBC
 6QsUmIm2U4s2Zx2NT9QWEc6t+/hvPXzHuPk/ikkFSf7ivyFMKUUe6ylPokAJNyko9lci
 99Zw4DaSp2C0qGxGrFhrvzCrV/4IH4AOytScF2BnQcWaiBEz0MwSDoqwMGK6xPYnswyy
 QxdNzKUgx9ltEk0Nf6ZrTuF5KK8dXTkD5z8T/RACJBjcJP+kve7KLqzmO26pn6BJ4c/6
 TJVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+V4rCz3ZFs0qdInuLcpu0zamMxBrZlMljbG4ygddDua+LwfOL9gvx5CI4UAdZXMqcEWJLfriyx0CwQ@nongnu.org
X-Gm-Message-State: AOJu0YxxuhdCbJcZqnUxUUqQDj+le2UomdO+DxdgvZZPIgQ9c60uPDti
 QUqhdDorFYMOXiYfNmBZp4g6SN0XbXD4bcZVPIU70lWvN3GVDfSfO3J2
X-Gm-Gg: AeBDietn4PdOd8D+yVpPx7cIvENhcl/NCoMStrpDJNXy4EU8824+7lNEmSalJGTzg8o
 uXt7gau0XcUZwBnmGu8YBSywXq4gnQAO+UcRAqrX6sJFYk2qIS8LgiBHW+tWrr6JuRljJQaefi8
 P10RJCC9SYZd6I9xiApKNdwIAjCnjlbuyNk9Y6Twjc+hjyOpXbMhqW3upzVt10pHs+yZNvyYfg3
 UacBzTDLN8FwaGcHMb8fdswwgqN1r5pF5r4LpOYHLPUCHjcB/e2kpRiAJrLwJ6k+K9N+StJ5gAe
 VxQRrg07defIcKVPQKC88ca18FXjfK1aU/dZMS/u8J1h97aqkjG+kreoir2uTRHGK01NfYOh8Yz
 C6yA9Vp08NWCJ9GFcWEAPI1Tlfdyw/i+jjkUta0cko6+7OYJ5IRIjTZaHMzGg6iYN7QAqMjfuJ4
 1YxoThbwtYfH2b2hOUPNASti8u8YDOYQ/Wsq/TfwjPXJhqi6hVGzMrAihtPKS/UwU=
X-Received: by 2002:a17:902:e0c6:b0:2b2:49a7:a5d0 with SMTP id
 d9443c01a7336-2b97c43c7d4mr45808795ad.11.1777438141766; 
 Tue, 28 Apr 2026 21:49:01 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:49:01 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/51] target/riscv: Factor tiny ldn() helper in gdbstub
Date: Wed, 29 Apr 2026 14:47:11 +1000
Message-ID: <20260429044752.4176397-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In preparation of having this helper handle CPU runtime
endianness changes, factor the ldn() helper out.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260318103122.97244-8-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/gdbstub.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 6a5b7a82fd..be42566bcc 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -47,6 +47,11 @@ static const struct TypeSize vec_lanes[] = {
     { "uint8", "bytes", 8, 'b' },
 };
 
+static uint64_t ldn(CPURISCVState *env, uint8_t *mem_buf, size_t regsz)
+{
+    return ldn_p(mem_buf, regsz);
+}
+
 int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
@@ -84,15 +89,15 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 
     switch (mcc->def->misa_mxl_max) {
     case MXL_RV32:
-        tmp = (int32_t)ldl_p(mem_buf);
+        tmp = (int32_t)ldn(env, mem_buf, 4);
         length = 4;
         break;
     case MXL_RV64:
     case MXL_RV128:
         if (env->xl < MXL_RV64) {
-            tmp = (int32_t)ldq_p(mem_buf);
+            tmp = (int32_t)ldn(env, mem_buf, 8);
         } else {
-            tmp = ldq_p(mem_buf);
+            tmp = ldn(env, mem_buf, 8);
         }
         length = 8;
         break;
@@ -130,7 +135,7 @@ static int riscv_gdb_set_fpu(CPUState *cs, uint8_t *mem_buf, int n)
     CPURISCVState *env = &cpu->env;
 
     if (n < 32) {
-        env->fpr[n] = ldq_p(mem_buf); /* always 64-bit */
+        env->fpr[n] = ldn(env, mem_buf, 8); /* always 64-bit */
         return sizeof(uint64_t);
     }
     return 0;
@@ -162,7 +167,7 @@ static int riscv_gdb_set_vector(CPUState *cs, uint8_t *mem_buf, int n)
     if (n < 32) {
         int i;
         for (i = 0; i < vlenb; i += 8) {
-            env->vreg[(n * vlenb + i) / 8] = ldq_p(mem_buf + i);
+            env->vreg[(n * vlenb + i) / 8] = ldn(env, mem_buf + i, 8);
         }
         return vlenb;
     }
@@ -194,7 +199,7 @@ static int riscv_gdb_set_csr(CPUState *cs, uint8_t *mem_buf, int n)
     const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
 
     if (n < CSR_TABLE_SIZE) {
-        uint64_t val = ldn_p(mem_buf, regsz);
+        uint64_t val = ldn(env, mem_buf, regsz);
         int result;
 
         result = riscv_csrrw_debug(env, n, NULL, val, -1);
@@ -230,8 +235,7 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
         const unsigned regsz = riscv_cpu_is_32bit(cpu) ? 4 : 8;
 #ifndef CONFIG_USER_ONLY
         CPURISCVState *env = &cpu->env;
-
-        target_ulong new_priv = ldn_p(mem_buf, regsz) & 0x3;
+        uint64_t new_priv = ldn(env, mem_buf, regsz) & 0x3;
         bool new_virt = 0;
 
         if (new_priv == PRV_RESERVED) {
@@ -239,7 +243,7 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
         }
 
         if (new_priv != PRV_M) {
-            new_virt = (ldn_p(mem_buf, regsz) & BIT(2)) >> 2;
+            new_virt = (ldn(env, mem_buf, regsz) & BIT(2)) >> 2;
         }
 
         if (riscv_has_ext(env, RVH) && new_virt != env->virt_enabled) {
-- 
2.53.0


