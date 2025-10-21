Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FADCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJJR-00053U-Ow; Tue, 21 Oct 2025 16:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJJJ-0004wn-8A
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:26 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJJD-0001X9-HN
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:50:24 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4711f156326so46984295e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079814; x=1761684614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oo0V2NSC+Um6jMwrxg0bGYRYcKSTrlyh1iPnhHilHTI=;
 b=uEN5KHScp8VbtV9T0zn/Q/mAVqNnoHlqdhAcuqWrm1u8uUVmc/wCUsZU76TvhUD41N
 gWfVnXkvFQXWZCzH5NqBPZukR+Bx2UjzTusH/v/HwLEq4hrgCHBOtLgYXgkuPieF2mvt
 c5TKCcFwWwYINWjxG9k7PSEVy3x1yjJpG13jzQiWmsvzm7sBewWe3gqtngaOLyly3B3f
 CLbZPPuwXmuRZiaE+kXbDzdurnrNuX5rk8jVgB1hKI5zps74eG8FumBsPmzM5DyXU9I0
 2dncPY0u6kwk2Ez7IoONxP+2ZsCjAZaquDjxgdvNm3NP3hK9poPhohRyWzrzr15M9Afb
 DJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079814; x=1761684614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oo0V2NSC+Um6jMwrxg0bGYRYcKSTrlyh1iPnhHilHTI=;
 b=qJh3IVGS8Pj0nPAL+SHNrklnGBqL6e9x9eWvIPK/xZxG4M47gs8S5w9dosxvB0AC2c
 YCnnTVg0acTeb42D3ssERKNaFDPu9dLfp2HTE837SOT9idD/nsKri2CU3HYLUWEODbe2
 5EpLBlrafj+5mD8c/3Su69NwRwihMGvbb+/2978bp4/YuDslln8B7O/P9FSXWCPg4YOi
 rcLGM4524ra8588VIkYWYCp292Ohm+VGImMJJKJw7DgijdOAsi/zf6V39IzEEzH0NfWe
 r9qPJ88tVitaIHnMbuE32JVWKFaJJX52hl06Bb6K9M9APLu7oov6n0pG9hti6xn63ywB
 v0Ow==
X-Gm-Message-State: AOJu0YwkvZVnZhh+FPRtyQJToPPPXYfR0oHd7GNBFLOUGCPWckdBc14c
 hiay+XG4D63SJmyUmhwU9J/M3gW+nU8a3GaxRgUjit2se8+NOG3E5YJorzN6oXPtjkMZKeRppVI
 /NOLHTZY=
X-Gm-Gg: ASbGncvlFXiW8496zbvKO7UxjArZUt71x0aW6Sz0A4diYA/pGRcGa2xhJ5BMnM0dP4d
 zTvyXjP7xapMhShbrTCq3E7uqNVEIwksudUXGb51kjyP6BFdNxqDv32GVxNBl2rgaW2646Ri6Ue
 3QMkLqJhC1e44U8ki0JGuAl1c1Jde9H6jVQEOR6pTdvGX+DRy8xopKOcKtHn2LHbIkgRdvmhlM5
 Pwrfd4RndiVIhZCcRJu9jMLNPM4Qnsp97d7EcDkuKFPjt+q6s0bzhBAhxoyE/LnyMcIu0biXFdB
 v2KjDxYekUWchzI/FqxJPnDgCqfizspmNS7klVHOWg6WYnBqWnDo6TvXyExJHO+hJQttG7BWAoP
 iPpTna9FdK3Xgkohc0jMS75lIdC1Vcn/omWCeA/n49TKnipRim5GIyAKWZ/EF2UgudwNtWZJ6nC
 WGal+gslWQV06Ye6G1c3rg+1fe/9AN5A+YDGShOpx4SYS4WOMcuMWZfELlhjz8q+k+3xPvmqg=
X-Google-Smtp-Source: AGHT+IHW9KWXdQ9OX3Lnp+QOQw5xni6Go8DaTVEzBnIrHOe65hDSyauG18ERjCA+0sgirIl14cCE/A==
X-Received: by 2002:a05:600c:470d:b0:471:a98:998d with SMTP id
 5b1f17b1804b1-471178a4ac3mr123228265e9.12.1761079814429; 
 Tue, 21 Oct 2025 13:50:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4342860sm9313135e9.11.2025.10.21.13.50.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:50:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/45] hw/ppc/spapr: Rename resize_hpt_err to errp
Date: Tue, 21 Oct 2025 22:46:55 +0200
Message-ID: <20251021204700.56072-42-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Vishal Chourasia <vishalc@linux.ibm.com>

Rename resize_hpt_err to standard errp naming convention.

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251021105442.1474602-9-vishalc@linux.ibm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 97ab6bebd25..e0a2e5a984d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2817,7 +2817,7 @@ static void spapr_machine_init(MachineState *machine)
     int i;
     MemoryRegion *sysmem = get_system_memory();
     long load_limit, fw_size;
-    Error *resize_hpt_err = NULL;
+    Error *errp = NULL;
     NICInfo *nd;
 
     if (!filename) {
@@ -2845,7 +2845,7 @@ static void spapr_machine_init(MachineState *machine)
     /* Determine capabilities to run with */
     spapr_caps_init(spapr);
 
-    kvmppc_check_papr_resize_hpt(&resize_hpt_err);
+    kvmppc_check_papr_resize_hpt(&errp);
     if (spapr->resize_hpt == SPAPR_RESIZE_HPT_DEFAULT) {
         /*
          * If the user explicitly requested a mode we should either
@@ -2853,10 +2853,10 @@ static void spapr_machine_init(MachineState *machine)
          * it's not set explicitly, we reset our mode to something
          * that works
          */
-        if (resize_hpt_err) {
+        if (errp) {
             spapr->resize_hpt = SPAPR_RESIZE_HPT_DISABLED;
-            error_free(resize_hpt_err);
-            resize_hpt_err = NULL;
+            error_free(errp);
+            errp = NULL;
         } else {
             spapr->resize_hpt = smc->resize_hpt_default;
         }
@@ -2864,14 +2864,14 @@ static void spapr_machine_init(MachineState *machine)
 
     assert(spapr->resize_hpt != SPAPR_RESIZE_HPT_DEFAULT);
 
-    if ((spapr->resize_hpt != SPAPR_RESIZE_HPT_DISABLED) && resize_hpt_err) {
+    if ((spapr->resize_hpt != SPAPR_RESIZE_HPT_DISABLED) && errp) {
         /*
          * User requested HPT resize, but this host can't supply it.  Bail out
          */
-        error_report_err(resize_hpt_err);
+        error_report_err(errp);
         exit(1);
     }
-    error_free(resize_hpt_err);
+    error_free(errp);
 
     spapr->rma_size = spapr_rma_size(spapr, &error_fatal);
 
-- 
2.51.0


