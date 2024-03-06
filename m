Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5F7C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhkVz-0004sP-No; Wed, 06 Mar 2024 01:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkVl-0004r9-Kj
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:17 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhkVk-0006EG-2E
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:12:17 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dc1ff58fe4so5122725ad.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709705535; x=1710310335;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D5kUM6n9+j+qbS1SUPTKf/+dgcMdpwuEc/L8WCg7irw=;
 b=qzYdz+B3bhg6deitxqgQQpvrww9xtNEtmYvo9RD+IHj5E/9PiYZZA3ICaKekAu3yFD
 +m8ekUqyX6oNSGb15CQtPY95lhGrGHcT/yAlQNTovZK/P9H7u1nQGr89BgX5S+aoq72e
 xmJPQT/WrPw/cXQPtuZxBqRZzlycd85MP5LE/Vjk846Yd+e8lo+hpIVRqDMadGiY9e/e
 VTdWZbKexLhhv2tXYxN4/vsPQAayxqzcLjo+inLExjYfGm6F4U+drdZAveFnrW1L9HPJ
 ApOONmHot9p7t2rKLANi/P0V/pB6qgYXlZf/IJWBr2Avv73IkfVN8/XoP8yRC9nilMoC
 CaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709705535; x=1710310335;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D5kUM6n9+j+qbS1SUPTKf/+dgcMdpwuEc/L8WCg7irw=;
 b=uC3glGOLKUgaaAFLJHstSe23p+tmb/qoOv7lIX2LS71eXsNnizxrD7n9PXi0N1z5NE
 sn6td+/UZPsZ/IaCIi3uE726aCwacaSL4BZWn2+9Sfw/X4zLdrLelW5+WAAQTStBrK7u
 3Ntl8ghasY3kKx3S7O49ocWPvzG/4cUtJcS0lRwPp4QmtaQPfmSXtIN1nDiKmlX3csoZ
 +r3/p1w/FOobH+M2IJwxE4iaL9I0Yb9As6VVJYuqOYPYxz+lhYFuAYauUW/HpS/vAu3G
 HaagdqCFIEoUDXWVPyrg0yag4FHGXNKBz4vR8mJHb+MdV48MUQSnznc7ZRbqsMR6+j+o
 gAlg==
X-Gm-Message-State: AOJu0YzyLwFv5ja5iUz0oK1tBO5N1MwXqxAMjMFMHgj4BwilLOGlB73O
 Wih3AWS1HAAqqGBsWvZzEufnqzHUPBHoD4pz7wb4qeZ41YgzAA3EULlz5cnmzLU=
X-Google-Smtp-Source: AGHT+IF8OqExUQQ6CavhinnjOtEXRdeV9Gm7Gn2xwByK1EE3PxUW+Wm0MVhZ66EDdZYUGMNrMwMJuQ==
X-Received: by 2002:a17:902:ee8b:b0:1dd:22e8:bdb5 with SMTP id
 a11-20020a170902ee8b00b001dd22e8bdb5mr3888794pld.16.1709705534774; 
 Tue, 05 Mar 2024 22:12:14 -0800 (PST)
Received: from localhost ([157.82.206.27]) by smtp.gmail.com with UTF8SMTPSA id
 z19-20020a170903409300b001d913992d8csm11625037plc.242.2024.03.05.22.12.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:12:14 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 06 Mar 2024 15:12:07 +0900
Subject: [PATCH v3 01/19] contrib/elf2dmp: Remove unnecessary err flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-elf2dmp-v3-1-d74e6c3da49c@daynix.com>
References: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
In-Reply-To: <20240306-elf2dmp-v3-0-d74e6c3da49c@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


