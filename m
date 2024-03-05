Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C0AC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPMA-0006AT-N6; Tue, 05 Mar 2024 02:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPLq-00067X-HM
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:36:41 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPLo-0005r0-Hz
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:36:38 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dcafff3c50so45399955ad.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709624194; x=1710228994;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3+MISxZtlwMc4Gir9xq5Ye6W+11swb1BIKOj0oAvifc=;
 b=jAN0gZHCCbktr00EwleLS6AB8V9p6t2tIM6NU7GR69fxFHHIMn7cX3ijot0/yrF9ZK
 RWarvHK5vUNImaIvC82G4ccOj8GgTtrtutC4W/RL3M84uFtIxhlIqKo1OICWQzktEf7H
 yHt+6RE6LNCez+iv2RdD4HzUKWbq+QvH4noiEGzHuhxqcpOHqKA7PbgOmKj9X9b+P51W
 KZew4kPePoCf9DWyFb+gQ5Hly785WQEl8gNqNwtZJTwZGFFumAWsaiQOIsGOZ31jV94h
 Ob4wmk2JJWlsO5I+D7kgwMB2u/VBo3hRg7l5qg2bEMZCX1jPLUgQhjVLKTm4qiRCoT5y
 4Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709624194; x=1710228994;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3+MISxZtlwMc4Gir9xq5Ye6W+11swb1BIKOj0oAvifc=;
 b=R7d0fj73WuZ3fB5Dee1mxl70Gex5fL/nqNjF19ftq9OZ0MgsrV1uAWQhCdRzZK6zZc
 9ObcijtPhYi8vSvAqklO2RqcCZ1OkXn2V4ibP8N8QMh8ANy27W0yLRull4+6xAAAH4uk
 rii6nCwJaoao0VCCADiW89aOTJh8ssxcR8T5TBiGcuTt0mVprYZNwxvUR3QC2BI5v02h
 HDEhXrh8HkcLMZkTGXQl8s2GkxmfSI5/HFicptp+A/hjW9hySQzc3CKPyTaLoOiVKdeE
 N08+LPTEzzDYsjB++6UCRBd1EoZXontsKoGYqpTqb7tL4aivnHz0mV4QuYd502fVdrTS
 fdog==
X-Gm-Message-State: AOJu0YxXbro99K5o5pYmiEo/5zpHVLd4b9ADW9gC2+2mJcQbUp5ybvCE
 uE03Wj9axqgq0ssFUM49aUThPk/iQyPn4dPtrxvjNEpFidZV+ZCZMXKJgFTTGzojlgDvCsv0eAT
 N
X-Google-Smtp-Source: AGHT+IHmSrfJoLyrzvt0blBRQYEd5VBC9C6HKXHEig6HcAvhB5OoBpdiwbx0pkYRaeAmNQxSnJ+nlw==
X-Received: by 2002:a17:902:e74d:b0:1dc:26a1:d1da with SMTP id
 p13-20020a170902e74d00b001dc26a1d1damr1413957plf.13.1709624194680; 
 Mon, 04 Mar 2024 23:36:34 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 s13-20020a170902ea0d00b001dcc0c84721sm9803962plg.99.2024.03.04.23.36.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:36:34 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 16:36:19 +0900
Subject: [PATCH v2 02/13] contrib/elf2dmp: Assume error by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-elf2dmp-v2-2-86ff2163ad32@daynix.com>
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A common construct in contrib/elf2dmp is to set "err" flag and goto
in error paths. In such a construct, there is only one successful path
while there are several error paths, so it will be more simpler to
initialize "err" flag set, and clear it in the successful path.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/download.c |  4 +---
 contrib/elf2dmp/main.c     | 15 +++------------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/contrib/elf2dmp/download.c b/contrib/elf2dmp/download.c
index bd7650a7a27f..902dc04ffa5c 100644
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
index cbc38a7c103a..9b278f392e39 100644
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
2.44.0


