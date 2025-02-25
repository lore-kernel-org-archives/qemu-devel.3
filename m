Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00B3C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzJh-0000EE-7b; Tue, 25 Feb 2025 13:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJC-0008LB-N9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:34 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJ5-0002Ce-5X
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:05:29 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4399ca9d338so36673305e9.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506720; x=1741111520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vw1t9QIVdlVnLqSekAuGvE0EepElq9dIPlsJJu2vCBg=;
 b=E0M3qNgTyrBBmY1viw42cqF1Ib4AnLblvPK9Dv89oC3FlUtlnLiwCrJ044tGJ+VHx2
 wHmgq+iPfjsFLD1XlZA/vxG5vS2KZG0kA+MT6Y41kRsRhrHOJwF8qVTYbLYlco73HIcD
 B6CnOmAY6McCm2Ru+ueVugcK5NawzNag0gWOgouRDLuki0qWKHq1W5MWHUmu+OG/cbb9
 GQtN+0tR428QjEC7bjuEVu6+K232J8P/902t3x/ImMVxQRZE78BdSPFUqU4ThNQN2j23
 1lyuQ+zS+nPrCYc4yMe+wOnnz46fGd+oW5dV392e2mGT5qruffDgg7Cl47gWVoTGy1tf
 ZmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506720; x=1741111520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vw1t9QIVdlVnLqSekAuGvE0EepElq9dIPlsJJu2vCBg=;
 b=ERl5NYaOqBBwTGPPiHSGna9yTiTHx3WYblGKBuD4fyXORH8Q6YoHTp/aztM49JarIV
 aHr+AiXpFfE0O6tHIxU6AERiauZu0oXRF0U5gke2D611HKDySto38SQ2Paozm2JP34AF
 aah4J6jiYJAbxfjeKOVmwoukVnG3sq7/v32O2yJw1NflLADnlMHWYV1LzczNP402O7eb
 iGYBy08ckGUhePPib3aXSK+Xp89ci/bHSPBUAUOASsUlQLnI9C2QQkPNXDCHPIROW+8Q
 e9/PoDGmPSX13LswOZOloV/ZnM1PSVp12LFsuFK+IuWxiG0uKc9iHM9xh9LqSIZKsuVo
 tMAA==
X-Gm-Message-State: AOJu0Yxvvm2ruVPMfElE0g2zf8zXGRrdQI4ZX5JMECgq3n8qlDGBumUW
 1lqZk2dWRnjqGlCrZWz+17HNvQ4G6HnvhJ+q9RcJObCWJMF1dh1fxW8aE2Ft5PPWwcGDoOhTy8F
 J
X-Gm-Gg: ASbGnct+uf9DqV8n5GKrwZ/to0SN35oy5K1FEWf/uvXQRAV8CSNJ4nooMpxSAqURSIq
 oMKlVR9o7RYoXN9PRij+XVGOI5dWZz/fLBSjK+4WaUqKprHEj5iLHA3nLXGxT2LS6kFHQ7EzyQ4
 DWQTEqO6kLGeNv8FYxbKP4o5vox5lVqOCvx4fSX2eRLJyaY3qSj1nG9mNyZ4FdYmy2G31oQ7LQd
 GDUdozEzLyu0E9DgtyUfytkG3XMv+0wMx4UIm9a5xbz/+zU2/A8aQEVxkFMvdr3u83+goKEcK2O
 pMJL/zP7YP3ilN5Kab/iFKs5v1yjAEbK
X-Google-Smtp-Source: AGHT+IGj+QL7LfUuRYEVWQ6FD0CDJA1xLGN9q9xOwyHGXoOzNkKnndCC9hmpX0ZnVVBe0mr7M/RMJA==
X-Received: by 2002:a05:600c:1d0b:b0:439:8c80:6b02 with SMTP id
 5b1f17b1804b1-43ab0fa35d8mr43026495e9.31.1740506720559; 
 Tue, 25 Feb 2025 10:05:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/43] hw/mips/boston: Support dumpdtb monitor commands
Date: Tue, 25 Feb 2025 18:04:32 +0000
Message-ID: <20250225180510.1318207-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The boston machine doesn't set MachineState::fdt to the DTB blob that
it has loaded or created, which means that the QMP/HMP dumpdtb
monitor commands don't work.

Setting MachineState::fdt is easy in the non-FIT codepath: we can
simply do so immediately before loading the DTB into guest memory.
The FIT codepath is a bit more awkward as currently the FIT loader
throws away the memory that the FDT was in after it loads it into
guest memory.  So we add a void *pfdt argument to load_fit() for it
to store the FDT pointer into.

There is some readjustment required of the pointer handling in
loader-fit.c, so that it applies 'const' only where it should (e.g.
the data pointer we get back from fdt_getprop() is const, because
it's into the middle of the input FDT data, but the pointer that
fit_load_image_alloc() should not be const, because it's freshly
allocated memory that the caller can change if it likes).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250206151214.2947842-5-peter.maydell@linaro.org
---
 include/hw/loader-fit.h | 21 ++++++++++++++++++---
 hw/core/loader-fit.c    | 38 +++++++++++++++++++++-----------------
 hw/mips/boston.c        | 11 +++++++----
 3 files changed, 46 insertions(+), 24 deletions(-)

diff --git a/include/hw/loader-fit.h b/include/hw/loader-fit.h
index 0832e379dc9..9a43490ed63 100644
--- a/include/hw/loader-fit.h
+++ b/include/hw/loader-fit.h
@@ -30,12 +30,27 @@ struct fit_loader_match {
 struct fit_loader {
     const struct fit_loader_match *matches;
     hwaddr (*addr_to_phys)(void *opaque, uint64_t addr);
-    const void *(*fdt_filter)(void *opaque, const void *fdt,
-                              const void *match_data, hwaddr *load_addr);
+    void *(*fdt_filter)(void *opaque, const void *fdt,
+                        const void *match_data, hwaddr *load_addr);
     const void *(*kernel_filter)(void *opaque, const void *kernel,
                                  hwaddr *load_addr, hwaddr *entry_addr);
 };
 
-int load_fit(const struct fit_loader *ldr, const char *filename, void *opaque);
+/**
+ * load_fit: load a FIT format image
+ * @ldr: structure defining board specific properties and hooks
+ * @filename: image to load
+ * @pfdt: pointer to update with address of FDT blob
+ * @opaque: opaque value passed back to the hook functions in @ldr
+ * Returns: 0 on success, or a negative errno on failure
+ *
+ * @pfdt is used to tell the caller about the FDT blob. On return, it
+ * has been set to point to the FDT blob, and it is now the caller's
+ * responsibility to free that memory with g_free(). Usually the caller
+ * will want to pass in &machine->fdt here, to record the FDT blob for
+ * the dumpdtb option and QMP/HMP commands.
+ */
+int load_fit(const struct fit_loader *ldr, const char *filename, void **pfdt,
+             void *opaque);
 
 #endif /* HW_LOADER_FIT_H */
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 9bdd4fa17c6..6eb66406b07 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -32,8 +32,8 @@
 
 #define FIT_LOADER_MAX_PATH (128)
 
-static const void *fit_load_image_alloc(const void *itb, const char *name,
-                                        int *poff, size_t *psz, Error **errp)
+static void *fit_load_image_alloc(const void *itb, const char *name,
+                                  int *poff, size_t *psz, Error **errp)
 {
     const void *data;
     const char *comp;
@@ -80,11 +80,11 @@ static const void *fit_load_image_alloc(const void *itb, const char *name,
             return NULL;
         }
 
-        data = g_realloc(uncomp_data, uncomp_len);
+        uncomp_data = g_realloc(uncomp_data, uncomp_len);
         if (psz) {
             *psz = uncomp_len;
         }
-        return data;
+        return uncomp_data;
     }
 
     error_setg(errp, "unknown compression '%s'", comp);
@@ -177,13 +177,12 @@ out:
 
 static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
                         int cfg, void *opaque, const void *match_data,
-                        hwaddr kernel_end, Error **errp)
+                        hwaddr kernel_end, void **pfdt, Error **errp)
 {
     ERRP_GUARD();
     Error *err = NULL;
     const char *name;
-    const void *data;
-    const void *load_data;
+    void *data;
     hwaddr load_addr;
     int img_off;
     size_t sz;
@@ -194,7 +193,7 @@ static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
         return 0;
     }
 
-    load_data = data = fit_load_image_alloc(itb, name, &img_off, &sz, errp);
+    data = fit_load_image_alloc(itb, name, &img_off, &sz, errp);
     if (!data) {
         error_prepend(errp, "unable to load FDT image from FIT: ");
         return -EINVAL;
@@ -211,19 +210,23 @@ static int fit_load_fdt(const struct fit_loader *ldr, const void *itb,
     }
 
     if (ldr->fdt_filter) {
-        load_data = ldr->fdt_filter(opaque, data, match_data, &load_addr);
+        void *filtered_data;
+
+        filtered_data = ldr->fdt_filter(opaque, data, match_data, &load_addr);
+        if (filtered_data != data) {
+            g_free(data);
+            data = filtered_data;
+        }
     }
 
     load_addr = ldr->addr_to_phys(opaque, load_addr);
-    sz = fdt_totalsize(load_data);
-    rom_add_blob_fixed(name, load_data, sz, load_addr);
+    sz = fdt_totalsize(data);
+    rom_add_blob_fixed(name, data, sz, load_addr);
 
-    ret = 0;
+    *pfdt = data;
+    return 0;
 out:
     g_free((void *) data);
-    if (data != load_data) {
-        g_free((void *) load_data);
-    }
     return ret;
 }
 
@@ -259,7 +262,8 @@ out:
     return ret;
 }
 
-int load_fit(const struct fit_loader *ldr, const char *filename, void *opaque)
+int load_fit(const struct fit_loader *ldr, const char *filename,
+             void **pfdt, void *opaque)
 {
     Error *err = NULL;
     const struct fit_loader_match *match;
@@ -323,7 +327,7 @@ int load_fit(const struct fit_loader *ldr, const char *filename, void *opaque)
         goto out;
     }
 
-    ret = fit_load_fdt(ldr, itb, cfg_off, opaque, match_data, kernel_end,
+    ret = fit_load_fdt(ldr, itb, cfg_off, opaque, match_data, kernel_end, pfdt,
                        &err);
     if (ret) {
         error_report_err(err);
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index de6ce1f163d..79410dabe7f 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -358,8 +358,8 @@ static void gen_firmware(void *p, hwaddr kernel_entry, hwaddr fdt_addr)
                        kernel_entry);
 }
 
-static const void *boston_fdt_filter(void *opaque, const void *fdt_orig,
-                                     const void *match_data, hwaddr *load_addr)
+static void *boston_fdt_filter(void *opaque, const void *fdt_orig,
+                               const void *match_data, hwaddr *load_addr)
 {
     BostonState *s = BOSTON(opaque);
     MachineState *machine = s->mach;
@@ -797,7 +797,7 @@ static void boston_mach_init(MachineState *machine)
         if (kernel_size > 0) {
             int dt_size;
             g_autofree const void *dtb_file_data = NULL;
-            g_autofree const void *dtb_load_data = NULL;
+            void *dtb_load_data = NULL;
             hwaddr dtb_paddr = QEMU_ALIGN_UP(kernel_high, 64 * KiB);
             hwaddr dtb_vaddr = cpu_mips_phys_to_kseg0(NULL, dtb_paddr);
 
@@ -815,6 +815,8 @@ static void boston_mach_init(MachineState *machine)
                 exit(1);
             }
 
+            machine->fdt = dtb_load_data;
+
             /* Calculate real fdt size after filter */
             dt_size = fdt_totalsize(dtb_load_data);
             rom_add_blob_fixed("dtb", dtb_load_data, dt_size, dtb_paddr);
@@ -822,7 +824,8 @@ static void boston_mach_init(MachineState *machine)
                                 rom_ptr(dtb_paddr, dt_size));
         } else {
             /* Try to load file as FIT */
-            fit_err = load_fit(&boston_fit_loader, machine->kernel_filename, s);
+            fit_err = load_fit(&boston_fit_loader, machine->kernel_filename,
+                               &machine->fdt, s);
             if (fit_err) {
                 error_report("unable to load kernel image");
                 exit(1);
-- 
2.43.0


