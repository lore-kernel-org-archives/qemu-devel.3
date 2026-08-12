Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C55C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFhq-0007gd-5n; Wed, 12 Aug 2026 16:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhn-0007aU-1Z
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:43 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wuFhl-0001EU-DV
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:37:42 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C836600AD;
 Wed, 12 Aug 2026 20:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E162C1F000E9;
 Wed, 12 Aug 2026 20:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786567052;
 bh=0ySLC0onq2KT+3OSCY0ERN2rwLalUp40XUDPmU/u6rQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=J3mTZiLUKS9b8imD8wjhE2D4TbeM6MQUvDfDEPOfUEze6CVthqqDxgSMiiTnLznIk
 T7ShyShvGZatspcqBgTfV3ZqF3f9ebjpEsalETbWAG3sYEU07JkrmrjcIolQo1jdSd
 hHv94KfZOx1jKzQD5QLRl4fWJvBCT9vnLPupLGkIT6m6DWkL7KboQlGAHKpALWHwCo
 tFdz0eatRZMyOfDzEnBch0L3iF28TznD34AW3VCB6y0AKmXnPOqV3h6qQhC7ExSQDL
 HNBb4ImYyeMnF5ZG5GZ535DhNAzJWW39QCej6AXLmDdNXSsX+nUHwxmDe6V4N/+CQ8
 5wf2tqDFyh1Wg==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Matt Turner <mattst88@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 2/7] linux-user: support writing floating-point registers to a
 core dump
Date: Wed, 12 Aug 2026 22:37:20 +0200
Message-ID: <20260812203725.10694-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260812203725.10694-1-deller@kernel.org>
References: <20260812203725.10694-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matt Turner <mattst88@gmail.com>

Write an NT_FPREGSET note for targets that opt in: a target_elf.h that
defines HAVE_ELF_CORE_FPREGS and target_elf_fpregset_t, and supplies an
elf_core_copy_fpregs() beside the existing elf_core_copy_regs().

Signed-off-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/elfload.c | 19 +++++++++++++++++++
 linux-user/loader.h  |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index e7c56af8ed..88508deac5 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1887,6 +1887,17 @@ static void fill_elf_note_phdr(struct elf_phdr *phdr, size_t sz, off_t offset)
     bswap_phdr(phdr, 1);
 }
 
+#ifdef HAVE_ELF_CORE_FPREGS
+static void fill_fpregset_note(void *data, CPUState *cpu)
+{
+    /* Fill locally and copy: note memory is only aligned to 4. */
+    target_elf_fpregset_t fpregs = {};
+
+    elf_core_copy_fpregs(&fpregs, cpu_env(cpu));
+    memcpy(data, &fpregs, sizeof(fpregs));
+}
+#endif
+
 static void fill_prstatus_note(void *data, CPUState *cpu, int signr)
 {
     /*
@@ -2166,6 +2177,9 @@ static int elf_core_dump(int signr, const CPUArchState *env)
     offset += size_note("CORE", ts->info->auxv_len);
     offset += size_note("CORE", sizeof(struct target_elf_prpsinfo));
     offset += size_note("CORE", sizeof(struct target_elf_prstatus)) * cpus;
+#ifdef HAVE_ELF_CORE_FPREGS
+    offset += size_note("CORE", sizeof(target_elf_fpregset_t)) * cpus;
+#endif
     note_size = offset - note_offset;
     data_offset = TARGET_PAGE_ALIGN(offset);
 
@@ -2222,6 +2236,11 @@ static int elf_core_dump(int signr, const CPUArchState *env)
             dptr = fill_note(&hptr, NT_PRSTATUS, "CORE",
                              sizeof(struct target_elf_prstatus));
             fill_prstatus_note(dptr, cpu_iter, cpu_iter == cpu ? signr : 0);
+#ifdef HAVE_ELF_CORE_FPREGS
+            dptr = fill_note(&hptr, NT_FPREGSET, "CORE",
+                             sizeof(target_elf_fpregset_t));
+            fill_fpregset_note(dptr, cpu_iter);
+#endif
         }
 
         if (dump_write(fd, header, data_offset) < 0) {
diff --git a/linux-user/loader.h b/linux-user/loader.h
index da9ad28db5..5ddd140276 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -109,6 +109,9 @@ bool init_guest_commpage(void);
 
 struct target_elf_gregset_t;
 void elf_core_copy_regs(struct target_elf_gregset_t *, const CPUArchState *);
+/* Only defined by a target whose target_elf.h sets HAVE_ELF_CORE_FPREGS. */
+struct target_elf_fpregset_t;
+void elf_core_copy_fpregs(struct target_elf_fpregset_t *, const CPUArchState *);
 
 typedef struct {
     const uint8_t *image;
-- 
2.54.0


