Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DBBCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZbDS-0005TU-Om; Tue, 16 Jun 2026 17:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDR-0005Sc-4q
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:01 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDP-0007N0-AB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:00 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-37cae11ba85so3860a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781644858; x=1782249658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sb+MPff6QX844HAYEHBQvEZrKABgvd2wf2uC/76ZV/g=;
 b=yMXIIWbXhgBtdIKtya7j/uhxrKmX+r6V1RmbfoLMaSr6Sp91Sk6fGZJkejPWyvMlpe
 a2WeoylmRqw5ORjMznD58PRtfcnnSCsY7d09y/qkL9Y8dTSalBVKH4BS50iPX2CQL9Bp
 dlPvh8oOahb6FZjgqqFov7V2nohRwhwDuujTAdN59S1A0Q903KX0fAiJsGImPlvJo9Hq
 cDQQaoT8lH/mrMGmhEhN40yL6bta0SSaoqYMI/INQVTTdRbVvM1SVFNiozYoYYc7KcwY
 QK6M0DmPpCYGm0NtARD2ZciTLC9i2dFXJ+2wCuHzWfvNeC6POqYD/d9yM0EuJIBUR3PG
 DwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644858; x=1782249658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sb+MPff6QX844HAYEHBQvEZrKABgvd2wf2uC/76ZV/g=;
 b=cuGIhGExrfTwORubepNLkQd0V2rUrzD8cZd8sdDK+n+Zl5Sc3W64gq4vYQIxOvxwAc
 iTobYxXOw8h0zxIVKfjwXEvetfYOLDb9Flin7R2cc86eJ15Z7b35g8E8d77srjC3nXiD
 YqKvd6noyElMNPZr6ttlD1g6ddPqhClQEZ8OCl4VIHjTXqb0RxQU88wvflwWFw/zQthE
 G721a1tqoF9cKTBour2C6rgYDYPCmg4ae/dNDaXH7f/Cn4Ifrb907oTmD4S6WfJN6BRT
 O8jVeEcZcDUWCQITgy4TEV2Hew9LQeoMTxNQtM2jELCgFetYl3tBd+KPHViwqeytxboA
 1L/Q==
X-Gm-Message-State: AOJu0Yzj5CY/RsEsHur/nnsO9uFgXp9R0DSR85w5yCTQ1MF42fOwG6fp
 UK697EQZ0SB4ODumw1v9Q6a+/AxenCljkgn6DeIePM8FNqgaeOtseapFAPjUXrXyzIXzSoP8GDA
 tAZe7
X-Gm-Gg: Acq92OF2iUT8CEAPd42Xjc1zuQ3BhjDmYRho0D9hdBblWBCTeZbhjDNiM1NX2wzoV6p
 8J61M30phBi/6Xecl3gZyegfp6GV3lLfKeE+X/jCSqPbBqSpIkvKtWa5kI9d+y57tSCFCVM38Mw
 +7x5cZ26JkbnhernZSe1N6/Y96KePe1iBG5cKW6rOPKo0Y+vosa1PUIs3WMhnPl+WBTy80Cocid
 Sq0vP4WsUtnYU97kwUT6jAVXk/o+MpbjMifS3OytEOZiFO4vDqJTLxngLnUyJPWBgHC1Ebyj4td
 Zq8bHyehM7vLniLBIlnC0Ia5ql9pYSiHTHMqaVWhKGrRnEF6hp2gHqK2UeV0xLxtKgNt7BqB/kd
 wXZT8ZBl0z7zHS59GjhML3iowD75o+6MnrOpAQMwkr6gu7Bq3CxmZkVb9WtiPCH2K5tvp7kGv84
 iLUkOMxffmH/x5Wy8LA6EHUw6KvS9kUkEQMJDi8kXWA2QWvwn29cfyBcmTewon
X-Received: by 2002:a17:90b:1652:b0:369:69f8:ad6b with SMTP id
 98e67ed59e1d1-37c92e80533mr1274855a91.0.1781644857841; 
 Tue, 16 Jun 2026 14:20:57 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521e76d1sm3820063a91.8.2026.06.16.14.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:20:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/13] linux-user: Use PGBRange in load_elf_image
Date: Tue, 16 Jun 2026 14:20:43 -0700
Message-ID: <20260616212055.334466-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616212055.334466-1-richard.henderson@linaro.org>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Collect into range instead of loaddr+hiaddr.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index aa4986a3d8..b32abd569f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1278,7 +1278,8 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
                            char **pinterp_name)
 {
     g_autofree struct elf_phdr *phdr = NULL;
-    abi_ulong load_addr, load_bias, loaddr, hiaddr, error, align;
+    PGBRange range = { -1, 0 };
+    abi_ulong load_addr, load_bias, error, align;
     size_t reserve_size, align_size;
     int i, prot_exec;
     Error *err = NULL;
@@ -1318,19 +1319,18 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
      * Find the maximum size of the image and allocate an appropriate
      * amount of memory to handle that.  Locate the interpreter, if any.
      */
-    loaddr = -1, hiaddr = 0;
     align = 0;
     info->exec_stack = EXSTACK_DEFAULT;
     for (i = 0; i < ehdr->e_phnum; ++i) {
         struct elf_phdr *eppnt = phdr + i;
         if (eppnt->p_type == PT_LOAD) {
             abi_ulong a = eppnt->p_vaddr & TARGET_PAGE_MASK;
-            if (a < loaddr) {
-                loaddr = a;
+            if (a < range.lo) {
+                range.lo = a;
             }
             a = eppnt->p_vaddr + eppnt->p_memsz - 1;
-            if (a > hiaddr) {
-                hiaddr = a;
+            if (a > range.hi) {
+                range.hi = a;
             }
             ++info->nsegs;
             align |= eppnt->p_align;
@@ -1361,7 +1361,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
         }
     }
 
-    load_addr = loaddr;
+    load_addr = range.lo;
 
     align = pow2ceil(align);
 
@@ -1371,13 +1371,13 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
              * Make sure that the low address does not conflict with
              * MMAP_MIN_ADDR or the QEMU application itself.
              */
-            probe_guest_base(image_name, loaddr, hiaddr);
+            probe_guest_base(image_name, range.lo, range.hi);
         } else {
             /*
              * The binary is dynamic, but we still need to
              * select guest_base.  In this case we pass a size.
              */
-            probe_guest_base(image_name, 0, hiaddr - loaddr);
+            probe_guest_base(image_name, 0, range.hi - range.lo);
 
             /*
              * Avoid collision with the loader by providing a different
@@ -1414,7 +1414,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
      * In both cases, we will overwrite pages in this range with mappings
      * from the executable.
      */
-    reserve_size = (size_t)hiaddr - loaddr + 1;
+    reserve_size = range.hi - range.lo + 1;
     align_size = reserve_size;
 
     if (ehdr->e_type != ET_EXEC && align > qemu_real_host_page_size()) {
@@ -1443,7 +1443,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
         load_addr = align_addr;
     }
 
-    load_bias = load_addr - loaddr;
+    load_bias = load_addr - range.lo;
 
     if (elf_is_fdpic(ehdr)) {
         struct elf32_fdpic_loadseg *loadsegs = info->loadsegs =
@@ -1474,7 +1474,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
     info->start_data = -1;
     info->end_data = 0;
     /* Usual start for brk is after all sections of the main executable. */
-    info->brk = TARGET_PAGE_ALIGN(hiaddr + load_bias);
+    info->brk = TARGET_PAGE_ALIGN(range.hi + load_bias);
     info->elf_flags = ehdr->e_flags;
 #ifdef TARGET_MIPS
     info->use_k0_tls = (ehdr->e_flags & EF_MIPS_MACH) == EF_MIPS_MACH_OCTEON;
-- 
2.43.0


