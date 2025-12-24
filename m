Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C605E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRbt-00013H-Hz; Wed, 24 Dec 2025 11:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRbs-00011U-2d
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:21:12 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRbq-0002dq-Gc
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:21:11 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-430fbb6012bso4885891f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593269; x=1767198069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gw6zJJATkMntpQgl0lyz1VPFZ+J53HgzndYRrDj9pqE=;
 b=cBuEkiCTqkDYFFX1/C0nwFTosFa+UB/O8w0PgaSloc8JeYow6+jhZ9rFGZhp2SVnCp
 lrO+xqo9g3vyV7QDsNzFmNTX1PSiEflb5Dx6k5Ue7SD35peZAkZqLnMy1S1rU3R9zbef
 YcWw7B48+7hwDZDoKWPEvC5hsz0Th5LzhP2SsGZkW+ep6Q0zFQGi8BAtctxZowUeuwLO
 zzxyZkymffAUvUDmyK9zMcYFMLs7mAFJDsSIaYtQ7Y5ZIACzSfrjxuyeY8ulB5o+wf++
 EmVtibcdD/t45EkDYsf8dV8wHoT4pnl0rRD8Buw8lTdGBRKuPSqJb5ajk295vmVRn0gp
 kOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593269; x=1767198069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gw6zJJATkMntpQgl0lyz1VPFZ+J53HgzndYRrDj9pqE=;
 b=FX7X2BNTha70vBBd6sIHafM/DzWW6MDK1X01TvNytjr+mqmqHRa4Kje/sGbtOJskZe
 uxjrlRd8BAcg2JmtMh5mleH2oAH7B6BcTrQDxUeB9TSgzvm3XlyoiW5pr2utZ4xAI4Eg
 ZSxZaGyv/LbyWGFOW0iqT+/SIaHczKi2kOYuTtz0R+zceLvHns+hDZ3km8QuJ4OopySh
 0OUu6S5DIpoqV+Yp9xiOkiyXQY7fEuH0SR/ZShxb4R4tqcXpm30NMr96y6ao5VWyYgk+
 hMgmlhGp7EmX6MBcvVUgqTWo+XhYwFAOlsAVJpyF+l/r7cMfimyMciCYAFpPt6AbR4Qx
 npLw==
X-Gm-Message-State: AOJu0YxWS7DIcb5ZyggthKj8kkX5gcabv/jb4maiQb6ol2hbSqrvXdm4
 esw22IEqF0lfwNuTYFvWvZZ7mJ+9MmZ0FJOWasoLj8w+E5KFoLn+s0Hbm7filwf1vq+SQH6+sdX
 jXcgOkuU=
X-Gm-Gg: AY/fxX6NUugfde3S0yqsoWTm1ObcT4gRuqbdZOE0qIWZtKSfaPIZDvBXRcD4oHGBSmT
 /w6UFwYAZMgMELqiubi3/sXu5rUX6k7EKAshJUA/MHIJRXlwLI43X5J8PLKNwrINQB3vZJy+MxF
 van/1+Nnir0xaKE9CDSbtE0Mf2iW8hLDCJJlfV/tUMdmUWDcHHy+YzD21YiibBvUKivAnJc86bJ
 Ajc+P1C8OZa5X8liq3tcGuyuBR8YIdunBmHZorodo6M2HxeHVWa3nLZ7jBKfclp1mGLSqgeqOQs
 m1bJhzuktti4xDuNZx5INaiDiBKG87xv3xlNZGvavXZ/eA+8QERL19REiey21gzMk46zDPV6hjP
 I7NLLlFX2Q4BVlUiBAIIDyjI9+HJOHpmqImmn0l7hh60pBJecGIsRZRtlVYCKgyqN2IdP3kYbsP
 zkPvAj+M6ka/r72YGepD/9mgbbYgzdjqDUrJbXKoYT44PYK0y3eDI9nsk=
X-Google-Smtp-Source: AGHT+IEk98b5Hw1ttlsHZAmR2fvnmQIaH4FAwIXse8VLWBUG1yIKgRl62G15yJCoifF/UjpUhMDGKg==
X-Received: by 2002:a05:6000:400f:b0:430:f742:fbb8 with SMTP id
 ffacd0b85a97d-4324e4cc56amr19685812f8f.21.1766593268544; 
 Wed, 24 Dec 2025 08:21:08 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1afbfsm35434200f8f.9.2025.12.24.08.21.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:21:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/8] target/s390x: Replace gdb_get_regl() -> gdb_get_reg64()
Date: Wed, 24 Dec 2025 17:20:30 +0100
Message-ID: <20251224162036.90404-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224162036.90404-1-philmd@linaro.org>
References: <20251224162036.90404-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We only build s390x targets as 64-bit:

  $ git grep BIT configs/targets/s390x-*
  configs/targets/s390x-linux-user.mak:6:TARGET_LONG_BITS=64
  configs/targets/s390x-softmmu.mak:5:TARGET_LONG_BITS=64

Therefore gdb_get_regl() expands to gdb_get_reg64(). Use
the latter which is more explicit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/gdbstub.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index 6bca376f2b6..d1f02ea5ce4 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -34,11 +34,11 @@ int s390_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
     switch (n) {
     case S390_PSWM_REGNUM:
-        return gdb_get_regl(mem_buf, s390_cpu_get_psw_mask(env));
+        return gdb_get_reg64(mem_buf, s390_cpu_get_psw_mask(env));
     case S390_PSWA_REGNUM:
-        return gdb_get_regl(mem_buf, env->psw.addr);
+        return gdb_get_reg64(mem_buf, env->psw.addr);
     case S390_R0_REGNUM ... S390_R15_REGNUM:
-        return gdb_get_regl(mem_buf, env->regs[n - S390_R0_REGNUM]);
+        return gdb_get_reg64(mem_buf, env->regs[n - S390_R0_REGNUM]);
     }
     return 0;
 }
@@ -190,7 +190,7 @@ static int cpu_read_c_reg(CPUState *cs, GByteArray *buf, int n)
 
     switch (n) {
     case S390_C0_REGNUM ... S390_C15_REGNUM:
-        return gdb_get_regl(buf, env->cregs[n]);
+        return gdb_get_reg64(buf, env->cregs[n]);
     default:
         return 0;
     }
@@ -227,13 +227,13 @@ static int cpu_read_virt_reg(CPUState *cs, GByteArray *mem_buf, int n)
 
     switch (n) {
     case S390_VIRT_CKC_REGNUM:
-        return gdb_get_regl(mem_buf, env->ckc);
+        return gdb_get_reg64(mem_buf, env->ckc);
     case S390_VIRT_CPUTM_REGNUM:
-        return gdb_get_regl(mem_buf, env->cputm);
+        return gdb_get_reg64(mem_buf, env->cputm);
     case S390_VIRT_BEA_REGNUM:
-        return gdb_get_regl(mem_buf, env->gbea);
+        return gdb_get_reg64(mem_buf, env->gbea);
     case S390_VIRT_PREFIX_REGNUM:
-        return gdb_get_regl(mem_buf, env->psa);
+        return gdb_get_reg64(mem_buf, env->psa);
     default:
         return 0;
     }
@@ -279,13 +279,13 @@ static int cpu_read_virt_kvm_reg(CPUState *cs, GByteArray *mem_buf, int n)
 
     switch (n) {
     case S390_VIRT_KVM_PP_REGNUM:
-        return gdb_get_regl(mem_buf, env->pp);
+        return gdb_get_reg64(mem_buf, env->pp);
     case S390_VIRT_KVM_PFT_REGNUM:
-        return gdb_get_regl(mem_buf, env->pfault_token);
+        return gdb_get_reg64(mem_buf, env->pfault_token);
     case S390_VIRT_KVM_PFS_REGNUM:
-        return gdb_get_regl(mem_buf, env->pfault_select);
+        return gdb_get_reg64(mem_buf, env->pfault_select);
     case S390_VIRT_KVM_PFC_REGNUM:
-        return gdb_get_regl(mem_buf, env->pfault_compare);
+        return gdb_get_reg64(mem_buf, env->pfault_compare);
     default:
         return 0;
     }
@@ -330,7 +330,7 @@ static int cpu_read_gs_reg(CPUState *cs, GByteArray *buf, int n)
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
 
-    return gdb_get_regl(buf, env->gscb[n]);
+    return gdb_get_reg64(buf, env->gscb[n]);
 }
 
 static int cpu_write_gs_reg(CPUState *cs, uint8_t *mem_buf, int n)
-- 
2.52.0


