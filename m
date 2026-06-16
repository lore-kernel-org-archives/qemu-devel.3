Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3707BCD98EC
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZbDU-0005UR-6e; Tue, 16 Jun 2026 17:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDS-0005TK-GM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:02 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDQ-0007NI-Ft
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:02 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-37c6cd1ac98so598152a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781644859; x=1782249659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwD+09xFgdMoZuAKSWmp8VsuyM0k0eLL68nRKXSEm94=;
 b=uGR5hpj69xPzM8Tg37lLGzJwnj68kSSAljtO4GbhWYi0gQE+v+5wGpmz6xjGinO1gN
 AVPwc4dheJn/SNIzuNsMBBK5E90iw/pKEmwdp1lBQlb1w82tcNBWnPx4r0QRSDqke4Nn
 XW8rCtfKPNYPDfkw1HRo3eY6dI4glcOhjWR5QASn8Z5w/ApYy26qO3MrYlASPEtswC6T
 0mUztSVVEVDyFAlYooHpdKrEnGUl8XXY3bls6PWbsSwxrrJ3XOCGdX6PM34XWKezm6Pi
 nf77LHs3DtR0NDlCkMLkg5ar/8gFYp2rB+pkN5lIV+v4h+fFkJZsVphHIbgZMIknV31l
 SgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644859; x=1782249659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZwD+09xFgdMoZuAKSWmp8VsuyM0k0eLL68nRKXSEm94=;
 b=k2oWaH4wevkSq9Xf83pM/BfwDHR3MpWlMpPwRfwOGXKR2+msgkd/whR5EjYTrO9Xhl
 buRWWHXYKcCaVoaQqA+zbFSVK7OWkT3IgAGlDjpbnOPXCTqMRxV5Q/DS1QOLA44LtdMg
 oIoBy+owEx6mV9YIw2ZjmtyW1Be5zxlvYrADZRXwz1MBBx5UJ/6gWaxonuhvUkgvu90x
 VH5IcOag4jnoo48c2EYkEY0NIk9Asc0dUNSEAY1BWJ2VvXBS9y778qpzQgLkhXe+ONBZ
 S5Fpb4XeEToWtncyK7yo5K8P7Mh2Hs4P+rHJ68UVrYNvBs3gwHVZvx8BWbdo+yYZPXUE
 bCVQ==
X-Gm-Message-State: AOJu0Yx+H0KssWBTmY0nbxGoZ5GrXHrk74e8WyslcUzW2+ZzYMD2lJ26
 qFp0uiw10Wp4c8FqE0QwwDzGtxO2+3o5xwlaH3qeu8pm4Saa+H2uh54Q963pxPTBYXvf5Ouxs/q
 4jYrH
X-Gm-Gg: AfdE7cnppbcuQlsbV/3nTgpHNnB4MRaZR6xq2V4fzVt3RDTDmWK2YXSxvMQzhHpETcH
 xLnUPAAhF7gRygYMsCqB5GXv3Q+jmnnxyoWGuFWQhEDo2ghMNFDCgwy2m7M+Q5+Slrv5IEOpM+X
 0s4j00K9iOXqCIulAhz3cd/uYxVIUaseh45Dcra9lDZBekcVJpRD33zMyMyWgAMp7v6xjoiouVo
 4e4xRBbllvsZpjwR59aV1X+kgV76thUcw8E/uJxpHnb/2sycIE18XA0huULJaTMFd9chlIsNa2m
 qiwLtvZ5Uwma9WMyECPKy9pIc1AAVvCIi6ltO7B1jOKRdzzEaodcY5BoqMi1CGSy9Bio2PXRX4z
 c7vt/bSmQimHZAa2Vy0KSfPFUcrb4HUvmuLuuAg+6SugtfXFRyM7bV+PdGG1txZMh04mM/DysX/
 Rq76/GjdAwPuM7/0s3HvrIKmuBfOir31SONizrFOg1rfPgVLpPZiNH1yQRNGhl
X-Received: by 2002:a17:90b:3dcd:b0:369:7421:75c3 with SMTP id
 98e67ed59e1d1-37c9e9c9d5emr663318a91.16.1781644858644; 
 Tue, 16 Jun 2026 14:20:58 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521e76d1sm3820063a91.8.2026.06.16.14.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:20:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de,
	Warner Losh <imp@bsdimp.com>
Subject: [PATCH v2 03/13] linux-user: Drop hiaddr out-of-range check in
 probe_guest_base
Date: Tue, 16 Jun 2026 14:20:44 -0700
Message-ID: <20260616212055.334466-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616212055.334466-1-richard.henderson@linaro.org>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Since dropping 32-bit host support, a guest address cannot
overflow a host pointer.  This means guest_hiaddr is unused
for relocatable images, so don't pass guest_hiaddr as size.

Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c  | 26 +++++++-------------------
 linux-user/flatload.c |  3 +--
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b32abd569f..960847fda7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1092,20 +1092,11 @@ void probe_guest_base(const char *image_name, abi_ulong guest_loaddr,
     uintptr_t align = MAX(SHMLBA, TARGET_PAGE_SIZE);
 
     /* Sanity check the guest binary. */
-    if (reserved_va) {
-        if (guest_hiaddr > reserved_va) {
-            error_report("%s: requires more than reserved virtual "
-                         "address space (0x%" PRIx64 " > 0x%lx)",
-                         image_name, (uint64_t)guest_hiaddr, reserved_va);
-            exit(EXIT_FAILURE);
-        }
-    } else {
-        if (guest_hiaddr != (uintptr_t)guest_hiaddr) {
-            error_report("%s: requires more virtual address space "
-                         "than the host can provide (0x%" PRIx64 ")",
-                         image_name, (uint64_t)guest_hiaddr + 1);
-            exit(EXIT_FAILURE);
-        }
+    if (reserved_va && guest_hiaddr > reserved_va) {
+        error_report("%s: requires more than reserved virtual "
+                     "address space (0x%" PRIx64 " > 0x%lx)",
+                     image_name, (uint64_t)guest_hiaddr, reserved_va);
+        exit(EXIT_FAILURE);
     }
 
     if (have_guest_base) {
@@ -1373,11 +1364,8 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
              */
             probe_guest_base(image_name, range.lo, range.hi);
         } else {
-            /*
-             * The binary is dynamic, but we still need to
-             * select guest_base.  In this case we pass a size.
-             */
-            probe_guest_base(image_name, 0, range.hi - range.lo);
+            /* The binary is dynamic; we still need to select guest_base. */
+            probe_guest_base(image_name, 0, 0);
 
             /*
              * Avoid collision with the loader by providing a different
diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 4beb3ed1b9..8abdd2aef2 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -261,8 +261,7 @@ static int load_flat_file(struct linux_binprm * bprm,
     /*
      * Allocate the address space.
      */
-    probe_guest_base(bprm->filename, 0,
-                     text_len + data_len + extra + indx_len - 1);
+    probe_guest_base(bprm->filename, 0, 0);
 
     /*
      * there are a couple of cases here,  the separate code/data
-- 
2.43.0


