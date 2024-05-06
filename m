Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E3E7C25B74
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xbO-000192-AJ; Mon, 06 May 2024 08:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xbM-000171-0u
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:37:53 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xbJ-0001w3-2S
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:37:50 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34dc9065606so1000840f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999067; x=1715603867; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCUBMQRGERL5OWJijRjLr72zABwTKcx4Ah85U5dJp20=;
 b=k1uhOOT//esL4aBxB2DvMB20Ge6ka2w+db3JmW06vDsnfQXd+w3LzBLoPf2tt7GTvU
 8AI7UImEux3tOAGiUe4zqd8afQzaLJh/bjesJb+ACZ2YFYBQB46c7P4k3aOBBkps0T/9
 /WCyMimbWgSGKd9aHN6tsZrLpcwm7WkUcsK4JC3vddiQZGF+K0I/gxB4GE+/HjPtNztO
 gpXyKG04gmRpvWJMJKbISeN0aTaZxQW2tqPmNTjV/ZfsVIkT2DiWr7a5pxUR9347WsPR
 CNDQY/JU6aKwNnpkdL8k8qRlR+HydRTCm5Y7rBOvExaOemnlg85giS7PThm6t5HcwodG
 28pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999067; x=1715603867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZCUBMQRGERL5OWJijRjLr72zABwTKcx4Ah85U5dJp20=;
 b=SpL1b6ogQz/oWJqXo4EidbUdmByCw96nyxV554TWEyIRXRH+dfXc+UgJe8BQ1O79N7
 J5JCu2bnTp64jjJVJZ2eq7H77SqgcOWqIXk0pN7cCZgtN7kASS7FAUky1ia255fnocWa
 cPHzFZ1GqSy4EZVL6Iu5ii5tFphjI1iHYtd7SMOqHvfyUxYWTsCipW8W9n63Z7M48p4O
 kwyyKUkGBnZUk44lhbX1nZ/vt9bQM1SOxmzbZ5RLs+p3jYlA725yCdXQcDigQv3t2Yxk
 fEzeSYVQVacDm7BHV9ygX5JwNjc4NBE/h10rV1gjjWhwZNUGtNfERjy4l54N65zEQqZy
 RyHw==
X-Gm-Message-State: AOJu0Yztd7+4pPzig+1ZkABvz+W8G6tGLd5IlJB4i6V5lfjILpT+J0k/
 qhD/u5mp7SwzFrCC0N59u7B4m0L/hxAsFCyNXJELe/ghSEmmgXdCxWbJGQ8PGjLVnFbAvnrxo/T
 u
X-Google-Smtp-Source: AGHT+IHf3CCge2tV6zKOEO9u9KbV+CFIZPKI3Gt2SLSZD8OnbU8h4KtCnyFLbHcaTDEC6n/gi2f1Kw==
X-Received: by 2002:a5d:6a11:0:b0:34c:ce6a:96fa with SMTP id
 m17-20020a5d6a11000000b0034cce6a96famr11528646wru.34.1714999067021; 
 Mon, 06 May 2024 05:37:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 k5-20020a05600c1c8500b0041bab13cd74sm15943592wms.17.2024.05.06.05.37.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:37:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/28] exec/cpu: Rename PAGE_BITS macro to PAGE_RWX
Date: Mon,  6 May 2024 14:37:02 +0200
Message-ID: <20240506123728.65278-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

This macro can be used to abbreviate PAGE_READ | PAGE_WRITE | PAGE_EXEC
for which PAGE_RWX is a better name and renaming it also shows it is
not related to TARGET_PAGE_BITS.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240505121008.44A0D4E602D@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu-common.h  | 2 +-
 accel/tcg/user-exec.c      | 2 +-
 bsd-user/mmap.c            | 6 +++---
 linux-user/elfload.c       | 2 +-
 linux-user/mmap.c          | 2 +-
 target/cris/mmu.c          | 4 ++--
 target/microblaze/helper.c | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 8812ba744d..a4bb4e6680 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -212,7 +212,7 @@ G_NORETURN void cpu_loop_exit_restore(CPUState *cpu, uintptr_t pc);
 #define PAGE_READ      0x0001
 #define PAGE_WRITE     0x0002
 #define PAGE_EXEC      0x0004
-#define PAGE_BITS      (PAGE_READ | PAGE_WRITE | PAGE_EXEC)
+#define PAGE_RWX       (PAGE_READ | PAGE_WRITE | PAGE_EXEC)
 #define PAGE_VALID     0x0008
 /*
  * Original state of the write flag (used when tracking self-modifying code)
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 1c621477ad..a81e3cc920 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -765,7 +765,7 @@ int page_unprotect(target_ulong address, uintptr_t pc)
         if (prot & PAGE_EXEC) {
             prot = (prot & ~PAGE_EXEC) | PAGE_READ;
         }
-        mprotect((void *)g2h_untagged(start), len, prot & PAGE_BITS);
+        mprotect((void *)g2h_untagged(start), len, prot & PAGE_RWX);
     }
     mmap_unlock();
 
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 3ef11b2807..c785615392 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -96,7 +96,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
             end = host_end;
         }
         ret = mprotect(g2h_untagged(host_start),
-                       qemu_host_page_size, prot1 & PAGE_BITS);
+                       qemu_host_page_size, prot1 & PAGE_RWX);
         if (ret != 0)
             goto error;
         host_start += qemu_host_page_size;
@@ -107,7 +107,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int prot)
             prot1 |= page_get_flags(addr);
         }
         ret = mprotect(g2h_untagged(host_end - qemu_host_page_size),
-                       qemu_host_page_size, prot1 & PAGE_BITS);
+                       qemu_host_page_size, prot1 & PAGE_RWX);
         if (ret != 0)
             goto error;
         host_end -= qemu_host_page_size;
@@ -174,7 +174,7 @@ static int mmap_frag(abi_ulong real_start,
             return -1;
         prot1 = prot;
     }
-    prot1 &= PAGE_BITS;
+    prot1 &= PAGE_RWX;
 
     prot_new = prot | prot1;
     if (fd != -1) {
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index f9461d2844..41fae2b520 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2361,7 +2361,7 @@ static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss,
     if (start_bss < align_bss) {
         int flags = page_get_flags(start_bss);
 
-        if (!(flags & PAGE_BITS)) {
+        if (!(flags & PAGE_RWX)) {
             /*
              * The whole address space of the executable was reserved
              * at the start, therefore all pages will be VALID.
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index be3b9a68eb..66a1631094 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -117,7 +117,7 @@ static void shm_region_rm_complete(abi_ptr start, abi_ptr last)
 static int validate_prot_to_pageflags(int prot)
 {
     int valid = PROT_READ | PROT_WRITE | PROT_EXEC | TARGET_PROT_SEM;
-    int page_flags = (prot & PAGE_BITS) | PAGE_VALID;
+    int page_flags = (prot & PAGE_RWX) | PAGE_VALID;
 
 #ifdef TARGET_AARCH64
     {
diff --git a/target/cris/mmu.c b/target/cris/mmu.c
index b574ec6e5b..c25c31c9f8 100644
--- a/target/cris/mmu.c
+++ b/target/cris/mmu.c
@@ -333,7 +333,7 @@ int cris_mmu_translate(struct cris_mmu_result *res,
 
     if (!cris_mmu_enabled(env->sregs[SFR_RW_GC_CFG])) {
         res->phy = vaddr;
-        res->prot = PAGE_BITS;
+        res->prot = PAGE_RWX;
         goto done;
     }
 
@@ -344,7 +344,7 @@ int cris_mmu_translate(struct cris_mmu_result *res,
         miss = 0;
         base = cris_mmu_translate_seg(env, seg);
         res->phy = base | (0x0fffffff & vaddr);
-        res->prot = PAGE_BITS;
+        res->prot = PAGE_RWX;
     } else {
         miss = cris_mmu_translate_page(res, env, vaddr, access_type,
                                        is_user, debug);
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index d25c9eb4d3..ff5f86ddc2 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -51,7 +51,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (mmu_idx == MMU_NOMMU_IDX) {
         /* MMU disabled or not available.  */
         address &= TARGET_PAGE_MASK;
-        prot = PAGE_BITS;
+        prot = PAGE_RWX;
         tlb_set_page_with_attrs(cs, address, address, attrs, prot, mmu_idx,
                                 TARGET_PAGE_SIZE);
         return true;
-- 
2.41.0


