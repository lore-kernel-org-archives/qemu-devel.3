Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B96AC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkWA-0004ui-L6; Wed, 06 Mar 2024 01:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkVo-0004rx-MF
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:23 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkVn-0006EW-27
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:20 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5dbf7b74402so5044431a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705537; x=1710310337;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WBQ8wkR+EtpXcrRFUmJL0m8euRcerqarx8Jtcq9C72A=;
 b=m+tGelhNmNlAanBrZzij9XJZvXOk1Y314VSTCbEaxf3jc2bIUHs34YgwfI7Z52zA8s
 KF23YFLGKux27vOr7prQOc/OZFhml3GKRLLN1S/YpiI7AOlE2fBdmI3/3Omd1als40VQ
 eC69yRmO6K+ipBY7cQR5OC/kYhLf+Nx4VXpUSiNqH3kIlnqWL3RWgeLuNz1ChgT8Zl8h
 SHM918i9PTraXWt5ypWrW3cSMBybx+PlTJRp+UKFJCLKIAVIkP4zgWkKq5ssw1iXcP/Q
 OJDtrkeZRIDtLGIKrgdMVldDp4sBgh6B1C6FrHhzrbKA2zkRcY73deyeR8l848if1xbw
 qv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705537; x=1710310337;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBQ8wkR+EtpXcrRFUmJL0m8euRcerqarx8Jtcq9C72A=;
 b=eJcHdywgEfo58sbnMvExduKlzzAkYwVnsSJ0z3eb+6O0eQFNF2Ci0XzKwHGXd7t6QJ
 DFwf8GwIuIQ5+dAp6nm3ErShQyiYNgMv7XaxNKRAxQW4pp8X0RQXATao6dFNuoskwNzr
 71ef0KC6lvwI5hwHvWPT7nJbVNjdJXipml3QO/QpqD/g4zbZ7v7HblRYHNIvnM63HFE6
 FilnJBuZl9Vhl0/l/64g38m0PX3Hh8ReO84EG/ZlRdWrXf4RVlEXqs2Hz/mGWa8ro+BS
 h8vXEdvUV5vOHNweuc7hhd+N1y7iz22VasqOMjhwiNZytI7saLN5rU3bw8aKSVNtI+a8
 ELkQ==
X-Gm-Message-State: AOJu0YyweOG4uukyX3EBWMrG03FUF+xS1ELfoJXBP31ZaQzn6ZL5YPf4
 /rBgqEzfjAYArWup4xmyQF57uMXqVzKwFIJ3XZLd/znfgvV/A29LOBHmQu3dJXaDKhAYLozVuOZ
 W
X-Google-Smtp-Source: AGHT+IFahrNPfKTTM6khN4VxVixXHJ9gz5wNPqxzqetlgCi8BcLgd7BKAp/DoA+HPd3eqE8i3p5euQ==
X-Received: by 2002:a17:902:e805:b0:1dc:f916:6b07 with SMTP id
 u5-20020a170902e80500b001dcf9166b07mr4511069plg.20.1709705537598; 
 Tue, 05 Mar 2024 22:12:17 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 mm12-20020a1709030a0c00b001dc96d1a662sm11646117plb.197.2024.03.05.22.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:12:17 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:08 +0900
Subject: [PATCH v3 02/19] contrib/elf2dmp: Assume error by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-2-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


