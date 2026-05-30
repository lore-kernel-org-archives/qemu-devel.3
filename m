Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5ACCD6E53
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 21:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTQzU-0005e8-Er; Sat, 30 May 2026 17:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzI-0005cD-Ng
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:12:56 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzH-0000ci-1Y
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:12:56 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2c0c3184c71so911655ad.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 14:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780175574; x=1780780374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHVne7fH+oibUgn5TdPb39Q4wG+yDX1OLcAi/wlCZfA=;
 b=heq1mmDj6iXjg/mILjK9gVgMSaVz/8Hhu0iwE0ENenNq3j4JqqcB6b+0gEj7wzfwzg
 wIS13V8n3FfymPi5j2L94M00vpwn5yjZG3rDUIXKBb+UNpS3ixJiDJPLwI2CwUZ0AM2t
 ADsr2wgw+RZb/oYAHnO260Y5LDsIJKLQf4tGwJFPLGvQxKT0onm35YezxFeYl4b+NDgo
 hEfmwxkrZorlg842oOod//6PEv9QnoIcBU7STclqbTvRNtL7RHobE8JZt0W4Trb5sp1s
 6yozVN6l3xipfZYYDsrj5ymEAeb0y+jJi+9tSEC6RMi7TwNsGnhhbsI9Y/WbXLWNLC++
 3OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780175574; x=1780780374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hHVne7fH+oibUgn5TdPb39Q4wG+yDX1OLcAi/wlCZfA=;
 b=YS0RyOb5lBXBtRgi/sImaW3R5g2ZV2h0vshcj/tn1aQZ6/MdLa8SigrRWKa35VvZH+
 fZTNblCQNPzum2459O7sW1Pbkl7aIMoPQ0lnqsz1/DD3TPT4epTT76YWnmdjyifVOtj5
 BOpoA+qtquHMKbC2LNMM/D5mOwAFMtd2Ph+6dBbI/C62Kp9mqtFYU19Ha2p6/y0gcl3S
 bSkz0t66Xp6uNUdQ2bQOrDKoAXMSCJQwOFn/falA5aEfiiORsGt6vvgHsPU6M1O9fzSR
 ZQQBjlgKgK7M2KoFlKLVgpZjsEGias7NF4PGbmf7osWQGF9P5VxFpZZwk8va2QyetTV8
 1OvA==
X-Gm-Message-State: AOJu0YzfPcHsGgTFwmyI/AhHtDLCDY+1N1oZhuPMSKWFjFNkxLWhH4cA
 VlqbCUw9KkFrNy8lptqtjRxeUP+c6qjz31kMn3BwVJDEvD3+/I8t3NU7RFvMyhlI2T3Kbqj2k+w
 M6HQTOIg=
X-Gm-Gg: Acq92OFc73RhZ1OBBHTCFVdJw15k2z56NgjZmEWbrUDYDCxNeb5lO8I9sQzfqkgYOwN
 7EIAnZjil6VmU4J/6bTlCJQbpmoDaavlrOiUsvebaJ4fqubxpKg6aE7RaYOmHXWnCmfey+0vaKm
 bdDi6AneJah7lRlF9PQGXiJd3XSTdc+Rc/O78Fp8C+GVEBh5STvmsF4iy9vYNNjOFtTkPjhUdR3
 g0eXJyhnVsKmeuXusQfTmP2ydOIDNgzlAYR+vBlmp5lNJqFFLcUF/uNDPTK0EI4j6azBoRPBQuL
 MwFl/Gnn3cJxYc1aK5NJ2zfL4jfOvYIICSa+uClftWpuQ9AFnPiAuA8ruMHsL48vQEI+TyMTSzA
 PhUZEr4hUH1CPInl0Y6puG0lylQapj/8dYsVJb4bVr6UtdoD563+UdTY/RHfsjrPDjSRs+Fw80L
 AtLcVLy5/Oe2B7jwf8WRFfGTjc7Xd70In9UFkIyL0=
X-Received: by 2002:a17:903:2304:b0:2c0:af09:f3d9 with SMTP id
 d9443c01a7336-2c0af09f5afmr29498525ad.36.1780175573543; 
 Sat, 30 May 2026 14:12:53 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23c580c6sm59592895ad.82.2026.05.30.14.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 14:12:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	deller@gmx.de
Subject: [PATCH 03/13] linux-user: Drop hiaddr out-of-range check in
 probe_guest_base
Date: Sat, 30 May 2026 14:12:37 -0700
Message-ID: <20260530211248.375318-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530211248.375318-1-richard.henderson@linaro.org>
References: <20260530211248.375318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c  | 26 +++++++-------------------
 linux-user/flatload.c |  3 +--
 2 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fb774adf25..33565ad7be 100644
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


