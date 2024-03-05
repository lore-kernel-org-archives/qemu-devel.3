Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C42C5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 07:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPM3-000692-1g; Tue, 05 Mar 2024 02:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPLn-00067B-Bj
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:36:38 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPLl-0005ql-Gz
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:36:35 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc09556599so50923585ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709624192; x=1710228992;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cmLbJ+esOto+sw6Kux2WlDr6cZ4EBSoYVYY0hVqqE28=;
 b=VRqTLIJgIZaTzYjhc+OfxD1OpRn8Ou+W6U5mkJXZLizwHGTwThrrKuptlJ5qjOW61/
 aKKqC1QgyqJqjQmKqBxnl6fQ1CluB27lZSq/e0gOKOFWjdfiW1DWQHsoJ8a/vf7fBesM
 Of3vWrsZIHLHLu6hZJOedOegwmk/oqKmmlmF9K5MNxzcNsMIKjSH4ud6gJeDOH+srUnY
 sUCCyoYORyCJBhxN5Dc/734GuvU7j3ZILAta7gMtfKp1k5GLnKPqqh25/mKSjMZWXqhM
 nU86edkS+jKaZ15Jw1Eln3y4PppB54rsiv97WGPsR86lsMOwRtPp9klqzKiI4Rh9+fPe
 9ObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709624192; x=1710228992;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cmLbJ+esOto+sw6Kux2WlDr6cZ4EBSoYVYY0hVqqE28=;
 b=RpIZvnTsjWJSmsjvHFz5Qggfbjgz3xe6GATUL5SHLwpce62QoFHsCOBBDS57QHHrby
 RaJEValACLvoCJV76xlflSTct4fl7TfUiS8RYeyjZCr5ZPt/g8SeKwzKEXbWv07QvKiK
 nXa+P2ejeOR/8dD5yxDY47aUSnhTmNvbgiMDckE0dlHgnXqIbdgh41Av/XwZQW5Wr/sJ
 iOZB2BTcHEvIVIgEFtzqNG+cVffAHr1HZvaZxKJB9sN6k0sJ1i/ShcV6qMfPyBECai3y
 l2YybrgsXmGePqlWBvWTLhtKKvEHOfo2t4c0o9+I5gJlajXt/bqHLzKm01Al+/t7+9Lc
 6oHA==
X-Gm-Message-State: AOJu0YzcoO7oGncUQWN6WwtkQYIcrbuluGxoQmxhjY2XkZ8Up8sfkKJ5
 Nva0qMKfqTG/gv4s2JUNXDFme5YfQHFh1D6NvB8vSPZEJ/OImYUm+3m8u2+H8ABM8Ms2i9LWxks
 8
X-Google-Smtp-Source: AGHT+IE8HDgHCaRHAIauPCvp7oS/+g+NrT7DNjoACgvxRHgyV6y40GQ3KNsimXRnX7lHDDqOadknOQ==
X-Received: by 2002:a17:902:eb89:b0:1db:c90f:e189 with SMTP id
 q9-20020a170902eb8900b001dbc90fe189mr1027261plg.57.1709624191799; 
 Mon, 04 Mar 2024 23:36:31 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 g7-20020a170902868700b001dca9b21267sm9755313plo.186.2024.03.04.23.36.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:36:31 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 16:36:18 +0900
Subject: [PATCH v2 01/13] contrib/elf2dmp: Remove unnecessary err flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-elf2dmp-v2-1-86ff2163ad32@daynix.com>
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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

They are always evaluated to 1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/pdb.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 40991f5f4c34..abf17c2e7c12 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -177,7 +177,6 @@ static int pdb_init_segments(struct pdb_reader *r)
 
 static int pdb_init_symbols(struct pdb_reader *r)
 {
-    int err = 0;
     PDB_SYMBOLS *symbols;
 
     symbols = pdb_ds_read_file(r, 3);
@@ -196,7 +195,6 @@ static int pdb_init_symbols(struct pdb_reader *r)
     /* Read global symbol table */
     r->modimage = pdb_ds_read_file(r, symbols->gsym_file);
     if (!r->modimage) {
-        err = 1;
         goto out_symbols;
     }
 
@@ -205,7 +203,7 @@ static int pdb_init_symbols(struct pdb_reader *r)
 out_symbols:
     g_free(symbols);
 
-    return err;
+    return 1;
 }
 
 static int pdb_reader_ds_init(struct pdb_reader *r, PDB_DS_HEADER *hdr)
@@ -228,7 +226,6 @@ static int pdb_reader_ds_init(struct pdb_reader *r, PDB_DS_HEADER *hdr)
 
 static int pdb_reader_init(struct pdb_reader *r, void *data)
 {
-    int err = 0;
     const char pdb7[] = "Microsoft C/C++ MSF 7.00";
 
     if (memcmp(data, pdb7, sizeof(pdb7) - 1)) {
@@ -241,17 +238,14 @@ static int pdb_reader_init(struct pdb_reader *r, void *data)
 
     r->ds.root = pdb_ds_read_file(r, 1);
     if (!r->ds.root) {
-        err = 1;
         goto out_ds;
     }
 
     if (pdb_init_symbols(r)) {
-        err = 1;
         goto out_root;
     }
 
     if (pdb_init_segments(r)) {
-        err = 1;
         goto out_sym;
     }
 
@@ -264,7 +258,7 @@ out_root:
 out_ds:
     pdb_reader_ds_exit(r);
 
-    return err;
+    return 1;
 }
 
 static void pdb_reader_exit(struct pdb_reader *r)
@@ -278,7 +272,6 @@ static void pdb_reader_exit(struct pdb_reader *r)
 int pdb_init_from_file(const char *name, struct pdb_reader *reader)
 {
     GError *gerr = NULL;
-    int err = 0;
     void *map;
 
     reader->gmf = g_mapped_file_new(name, TRUE, &gerr);
@@ -291,7 +284,6 @@ int pdb_init_from_file(const char *name, struct pdb_reader *reader)
     reader->file_size = g_mapped_file_get_length(reader->gmf);
     map = g_mapped_file_get_contents(reader->gmf);
     if (pdb_reader_init(reader, map)) {
-        err = 1;
         goto out_unmap;
     }
 
@@ -300,7 +292,7 @@ int pdb_init_from_file(const char *name, struct pdb_reader *reader)
 out_unmap:
     g_mapped_file_unref(reader->gmf);
 
-    return err;
+    return 1;
 }
 
 void pdb_exit(struct pdb_reader *reader)

-- 
2.44.0


