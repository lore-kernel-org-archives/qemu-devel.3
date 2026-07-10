Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7A4C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:02:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKE6-0004Qq-Jh; Fri, 10 Jul 2026 19:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDj-0004GN-5c
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:23 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDh-000313-5o
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:22 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-381891a9525so1792874a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783724479; x=1784329279; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0a+Tjei23EgueA74aObJAM97tufvPB2kilv0MMrOaOc=;
 b=VBlKZmTNl5EMzk5tpajiic01wQSXo3Mt941bK9IAf/j54i2VxElxXV/70MWchJdwwl
 5QfujeOp2NEOxGP8nLnahPmXCOq3gjp5/9oSDDCDdE0hDpt3TS8ly4dZyJLFEJPa3wVk
 g5LghXYJEM+TVNeGxMuIa8I0fT+o9RjtJwj9ttLtckJlmZNxysLgkPzee+XVo+hqKRIs
 BeWEVvCtwDEGncuc26vFcfvkbf1UWwDmoUOayEXuElyf4l5tuNzjbnYd06ZByuIrpd9H
 1FvpNqWyX45rsXXdGlAzGEzVYjAjGn1IvWopLSN5KPIrvQPa9mHNrzBT9/3aP6sR1Dyw
 0Y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724479; x=1784329279;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0a+Tjei23EgueA74aObJAM97tufvPB2kilv0MMrOaOc=;
 b=B96O4rlJiNf3l3oBWTDrJJCenKhiGD6uOHzZYV3xE7NHBstv6tFUn3qR2gn0qgubWT
 FPFdtNla8rHjGCnVVUaPz25/mCnVwiK4fsgnsfpHWEq+TkVL/49njAawKBC5X5GvU9RS
 o2NusDYe4HOy0bMqkoVOd9AwIy/2Zrv+epqkB1de+HR5IIPI8DZSW02hjnbJIsPZ6tvh
 /0ejVrSgfxl9diO3/IRlz5Zdok2V+VAcA4OkZ4hRySq6MIgGP5u8HlNK6ZNGLSyePhYw
 lI4TzR3cqEtCqKwKxMq2fpvsGq6a0FUv3qXlhOy4vy4dHJlQb/7AxKcn9HVFigZLoGZs
 Tinw==
X-Gm-Message-State: AOJu0Yz1mJDfZ02lr31FipD6mxjXnCBKA75aAE41dt5q8LNvt0eJyZYo
 TlVlgqKLC1adIF/3RFpOSIJD4reosWuGA5gRdZmO/vVSvle0jWoaV9VF2ivKJUh9GW4m/u0weU8
 tFZdn
X-Gm-Gg: AfdE7cmXRXl0uyH7TzQESe4EuOScx/LgIGpKG/wS5bQb3RR8awlSb2/gnWoe984JYwl
 kBsAAjATcIP0cAiMc/vsygUn1YKq8eXdtSenKOjXWAKskVtVRoG6B9sPbPMjCVLGc245xf9b4/1
 QEZ6CRs9XpcQT1IGQFzErsFTpp16vICb5y1UG/cY1towLBMyWxH5shdJUkWm3fLiJxDsoFPAW1I
 AheCBwP5Pl75jDsWxqALFaNPdURtnPkQ2SE+gp9SinXr/XpYrSbV/ddlVh2tInDzhf4AFDEzNzi
 zV6xfNxAa9G11TjkpjSKYDCBANmGzdzGL5lKYssLg6VJZtd6DHr2pzK9JhUKg7m03kUjPGqwmYO
 Lg8PSp9cPQsPLh+WNdnWqPrfeJueWimUXi6Qpp4q5bfshxrgp6t7rFsWW+/zTbRfc/5hcAu2Zb0
 K5tjG0omxDMzKhM1IBgUHBJkHuO3+1
X-Received: by 2002:a17:90b:4ed0:b0:37f:bfd6:8b40 with SMTP id
 98e67ed59e1d1-38dc74c25d3mr797273a91.5.1783724478879; 
 Fri, 10 Jul 2026 16:01:18 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55b3c9eesm3426569a91.11.2026.07.10.16.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 16:01:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/13] linux-user: Use PGBRange in load_elf_image
Date: Fri, 10 Jul 2026 16:01:05 -0700
Message-ID: <20260710230116.900171-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710230116.900171-1-richard.henderson@linaro.org>
References: <20260710230116.900171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
index 2566c2f54c..30d7beb562 100644
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
@@ -1480,7 +1480,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
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


