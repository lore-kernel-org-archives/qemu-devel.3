Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7DCC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjl5K-0003TP-Fw; Mon, 11 Mar 2024 15:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4q-0003IZ-Oe
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:51 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rjl4n-0000Lx-MC
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:12:48 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-513af1a29b1so1089744e87.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 12:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710184364; x=1710789164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cG+mNjXKngqOkSeG7u+wCX4BlFv1Veow5VunaRM/YT4=;
 b=mGTiREYibluVYg94H8xMB3Z2/9Wwic4qVJYHSoZ4IT2XGSLO3euNHmBrZAASwgq8DF
 b70MayJBvB/IZGnTTsNd8d88X/ae5eO4J6Nol9fDie43TaRzdc+189N7QYRDfsLS9fCK
 VpDP07ANiOHtKtqPxPdigocJD9Wdkp4PuQ/I5CToNaLkvc8r2qv/sQZq5ZUp0+1wytN4
 HBz1s/yxcnv7OZwBc0tTBQg/jSZVFVXjhdkHxkBJNZ9SfVV9gS/6vWpnW+QlIdWCjeSS
 fGj4lJ/kU/ouvFxD8+2N992AzSqSjr1cEHiV+YF6GN6k8Sbm9+7Vp4trEcEieTHQLrSc
 8xZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710184364; x=1710789164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cG+mNjXKngqOkSeG7u+wCX4BlFv1Veow5VunaRM/YT4=;
 b=BRoZjsTuqf3C1+4RHBriLPpqQz8mm2UnJaSgkvycw+YcbeRirkveuTXE3CIb4dMSHf
 BZWvw3c8xv5oebdIWHdfeqNrdY+179BYkPtTKRIXbjXWdG/znLRLBiIGjeJmhO2zgOqy
 r7C109gbp4TViX8Mfsw8JYBslhj9yeT1XBHxy4iYYmsP0Tp5ae5DsOrMQXH0/6wl5y/f
 nzVKuXMckm2EDV73jNQR9a3xGr0t6QxTRxvegqRKUgyQD5aBX6ElplFazfo2dEHvUmta
 aG2Yxwq3ia+q4Q/P7xfjF0nWn7x1Zc/etJGIxxbyPSND+VonBR62obGaG2ooSXnZI051
 sBMw==
X-Gm-Message-State: AOJu0Yxttk/jMBv1/3dh52Leg4EFKgEalJTI7O3qzI/0zHh5Eg3rKWAs
 J4KA9pZIfP3/tF1Y1ToIz+UaGzgtgbOUxz7ATt3uuHjUZt6sUTAqK8WKqM8vae+EvqBETBJTaWs
 S
X-Google-Smtp-Source: AGHT+IH/6TAU32H8FjzKRLrI2WoOkk8GpWd9XrBXPWdFnvl2Nq4okV7R+a2o70kADfLTMul27ntRIg==
X-Received: by 2002:a19:3807:0:b0:513:8f53:cab0 with SMTP id
 f7-20020a193807000000b005138f53cab0mr5061837lfa.27.1710184363768; 
 Mon, 11 Mar 2024 12:12:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm14425266wmo.0.2024.03.11.12.12.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 12:12:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/20] contrib/elf2dmp: Assume error by default
Date: Mon, 11 Mar 2024 19:12:24 +0000
Message-Id: <20240311191241.4177990-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311191241.4177990-1-peter.maydell@linaro.org>
References: <20240311191241.4177990-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

A common construct in contrib/elf2dmp is to set "err" flag and goto
in error paths. In such a construct, there is only one successful path
while there are several error paths, so it will be more simpler to
initialize "err" flag set, and clear it in the successful path.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-id: 20240307-elf2dmp-v4-2-4f324ad4d99d@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/download.c |  4 +---
 contrib/elf2dmp/main.c     | 15 +++------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/contrib/elf2dmp/download.c b/contrib/elf2dmp/download.c
index bd7650a7a27..902dc04ffa5 100644
--- a/contrib/elf2dmp/download.c
+++ b/contrib/elf2dmp/download.c
@@ -11,7 +11,7 @@
 
 int download_url(const char *name, const char *url)
 {
-    int err = 0;
+    int err = 1;
     FILE *file;
     CURL *curl = curl_easy_init();
 
@@ -21,7 +21,6 @@ int download_url(const char *name, const char *url)
 
     file = fopen(name, "wb");
     if (!file) {
-        err = 1;
         goto out_curl;
     }
 
@@ -33,7 +32,6 @@ int download_url(const char *name, const char *url)
             || curl_easy_perform(curl) != CURLE_OK) {
         unlink(name);
         fclose(file);
-        err = 1;
     } else {
         err = fclose(file);
     }
diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index cbc38a7c103..9b278f392e3 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -511,7 +511,7 @@ static void pe_get_pdb_symstore_hash(OMFSignatureRSDS *rsds, char *hash)
 
 int main(int argc, char *argv[])
 {
-    int err = 0;
+    int err = 1;
     QEMU_Elf qemu_elf;
     struct pa_space ps;
     struct va_space vs;
@@ -542,7 +542,6 @@ int main(int argc, char *argv[])
 
     if (pa_space_create(&ps, &qemu_elf)) {
         eprintf("Failed to initialize physical address space\n");
-        err = 1;
         goto out_elf;
     }
 
@@ -552,7 +551,6 @@ int main(int argc, char *argv[])
     va_space_create(&vs, &ps, state->cr[3]);
     if (fix_dtb(&vs, &qemu_elf)) {
         eprintf("Failed to find paging base\n");
-        err = 1;
         goto out_elf;
     }
 
@@ -561,7 +559,6 @@ int main(int argc, char *argv[])
     if (va_space_rw(&vs, state->idt.base,
                 &first_idt_desc, sizeof(first_idt_desc), 0)) {
         eprintf("Failed to get CPU #0 IDT[0]\n");
-        err = 1;
         goto out_ps;
     }
     printf("CPU #0 IDT[0] -> 0x%016"PRIx64"\n", idt_desc_addr(first_idt_desc));
@@ -586,7 +583,6 @@ int main(int argc, char *argv[])
 
     if (!kernel_found) {
         eprintf("Failed to find NT kernel image\n");
-        err = 1;
         goto out_ps;
     }
 
@@ -600,45 +596,40 @@ int main(int argc, char *argv[])
 
     if (download_url(PDB_NAME, pdb_url)) {
         eprintf("Failed to download PDB file\n");
-        err = 1;
         goto out_ps;
     }
 
     if (pdb_init_from_file(PDB_NAME, &pdb)) {
         eprintf("Failed to initialize PDB reader\n");
-        err = 1;
         goto out_pdb_file;
     }
 
     if (!SYM_RESOLVE(KernBase, &pdb, KdDebuggerDataBlock) ||
             !SYM_RESOLVE(KernBase, &pdb, KdVersionBlock)) {
-        err = 1;
         goto out_pdb;
     }
 
     kdbg = get_kdbg(KernBase, &pdb, &vs, KdDebuggerDataBlock);
     if (!kdbg) {
-        err = 1;
         goto out_pdb;
     }
 
     if (fill_header(&header, &ps, &vs, KdDebuggerDataBlock, kdbg,
             KdVersionBlock, qemu_elf.state_nr)) {
-        err = 1;
         goto out_kdbg;
     }
 
     if (fill_context(kdbg, &vs, &qemu_elf)) {
-        err = 1;
         goto out_kdbg;
     }
 
     if (write_dump(&ps, &header, argv[2])) {
         eprintf("Failed to save dump\n");
-        err = 1;
         goto out_kdbg;
     }
 
+    err = 0;
+
 out_kdbg:
     g_free(kdbg);
 out_pdb:
-- 
2.34.1


