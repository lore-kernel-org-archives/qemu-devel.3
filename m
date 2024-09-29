Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849F1CF6495
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 18:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suyKf-0003Yz-Rz; Sun, 29 Sep 2024 14:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1suyKV-0003WM-K1
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 14:07:37 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1suyKT-0008UN-FI
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 14:07:34 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 171295C3A55;
 Sun, 29 Sep 2024 18:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77D4C4CEC6;
 Sun, 29 Sep 2024 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727633251;
 bh=gaTEkzSDeytW6SwTF1R7+8EhibjOouFicNyg1NxbWWo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jJtk6rSCHFMzfVhPopq9giLbhUOa9I0ItG/GJLOfbpfmK7dGzJrO+x1KWhMz0NzNa
 v8OUCrMQNUlAO5smFpUjF5CurkoYND5q6MlJXe2we1GECByDfWtduPGi1W5lyMyUuF
 xDrjd5ca2BKhPApIx4aMnhCpqvMv9fX7bM8HuCJ2G/tGKczUfbhLr3ANAw7SwXA1fd
 AbAhZzVDw8+7UasUSlfasDh4OkLt1otwcg5gZCZYcdFuxTEa2Tjza5QJNjqYCLn9xZ
 fCB9DqE2DaJgJJYPcY1nSL9SzjVPJ5Oj+EehAYWYxdb/fm8CtAHyGMD45bKuftNEoo
 +oAQBp7mCaEIA==
From: Ard Biesheuvel <ardb@kernel.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 1/2] hw/elf_ops: Implement missing endian swabbing for ELF
 notes
Date: Sun, 29 Sep 2024 20:06:57 +0200
Message-Id: <20240929180659.3598-2-ardb@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240929180659.3598-1-ardb@kernel.org>
References: <20240929180659.3598-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ELF notes have type and size fields in the elf_note header that need to
be swabbed before use if the host endianness differs from the endianness
of the ELF binary.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/hw/elf_ops.h.inc | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/hw/elf_ops.h.inc b/include/hw/elf_ops.h.inc
index 9c35d1b9da..8b563db2a3 100644
--- a/include/hw/elf_ops.h.inc
+++ b/include/hw/elf_ops.h.inc
@@ -41,6 +41,13 @@ static void glue(bswap_shdr, SZ)(struct elf_shdr *shdr)
     bswapSZs(&shdr->sh_entsize);
 }
 
+static void glue(bswap_nhdr, SZ)(struct elf_note *nhdr)
+{
+    bswap32s(&nhdr->n_namesz);
+    bswap32s(&nhdr->n_descsz);
+    bswap32s(&nhdr->n_type);
+}
+
 static void glue(bswap_sym, SZ)(struct elf_sym *sym)
 {
     bswap32s(&sym->st_name);
@@ -275,7 +282,8 @@ fail:
 static struct elf_note *glue(get_elf_note_type, SZ)(struct elf_note *nhdr,
                                                     elf_word note_size,
                                                     elf_word phdr_align,
-                                                    elf_word elf_note_type)
+                                                    elf_word elf_note_type,
+                                                    int must_swab)
 {
     elf_word nhdr_size = sizeof(struct elf_note);
     elf_word elf_note_entry_offset = 0;
@@ -287,6 +295,9 @@ static struct elf_note *glue(get_elf_note_type, SZ)(struct elf_note *nhdr,
         return NULL;
     }
 
+    if (must_swab) {
+        glue(bswap_nhdr, SZ)(nhdr);
+    }
     note_type = nhdr->n_type;
     while (note_type != elf_note_type) {
         nhdr_namesz = nhdr->n_namesz;
@@ -306,6 +317,9 @@ static struct elf_note *glue(get_elf_note_type, SZ)(struct elf_note *nhdr,
 
         /* skip to the next ELF Note entry */
         nhdr = (void *)nhdr + elf_note_entry_offset;
+        if (must_swab) {
+            glue(bswap_nhdr, SZ)(nhdr);
+        }
         note_type = nhdr->n_type;
     }
 
@@ -603,7 +617,8 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
             nhdr = (struct elf_note *)data;
             assert(translate_opaque != NULL);
             nhdr = glue(get_elf_note_type, SZ)(nhdr, file_size, ph->p_align,
-                                               *(uint64_t *)translate_opaque);
+                                               *(uint64_t *)translate_opaque,
+                                               must_swab);
             if (nhdr != NULL) {
                 elf_note_fn((void *)nhdr, (void *)&ph->p_align, SZ == 64);
             }
-- 
2.39.5


