Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865D7F8924C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 10:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF8FI-0001M6-8D; Tue, 21 Apr 2026 06:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sertonix@posteo.net>)
 id 1wF8FG-0001Lj-Mo
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 06:22:18 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sertonix@posteo.net>)
 id 1wF8FE-0004WA-0H
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 06:22:18 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 593DA240101
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 12:22:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1776766931; bh=9JGwgImOBy5qZgg5s9M+ocvXeG26ocJn4YKw3MHyvbw=;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
 Message-Id:Subject:From:To:From;
 b=goAAW7sG2yHcgel59d1mtSlYcvC3U+JF4ICbk4OjxMwBmEFOPzieLtjAKQhIkpWCF
 GwtOaqRjCpSj+66ckyooyPQkpPf6FwDq+aA8sb6qfgC0JLVnorv95rMnV6NrMWgzj2
 Jr9LybIF6iZ5G9t9hRmstLWw608oU/aVCwzMf6KAKjEXYQD5tPIAhVlAFGhtrj/gAX
 pgdSIykRArHBeGWZemLukjVhjmLGmLyG9naWuje3mHBdSq+T/mA01BFzvAWlPlGIjX
 a3ANw93Ma/X4BmphSk1BO87k1D3I3jPLEK0pE/SK5wXGEp+44sBl3eho3m6LSAA/W2
 4BeMmLKLNqaGA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4g0JLq0kfFz9rxM
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 12:22:10 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 10:22:11 +0000
Message-Id: <DHYRB7QIPFB3.3VG2UUUIXCBZP@posteo.net>
Subject: [PATCH v2] hw/i386: Use qemu_open for kernel/initrd
From: "Sertonix" <sertonix@posteo.net>
To: <qemu-devel@nongnu.org>
Received-SPF: pass client-ip=185.67.36.66; envelope-from=sertonix@posteo.net;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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


Allows using "-kernel /dev/fdset/0" and "-initrd /dev/fdset/1" (if the
file descriptors are opened read-only).

For the sake of consistency it would be best to do the same change in
the other hw/* subdirectories as well but I lack the means to test all
of them.
---
v2: Use qemu_open instead of qemu_open_old

 hw/i386/x86-common.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index fde05fa7d7..2e4fee3e87 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -650,7 +650,9 @@ void x86_load_linux(X86MachineState *x86ms,
     uint32_t initrd_max;
     uint8_t header[8192], *setup, *kernel;
     hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr =3D 0;
+    Error *err =3D NULL;
     FILE *f;
+    int fd;
     const char *vmode;
     MachineState *machine =3D MACHINE(x86ms);
     struct setup_data *setup_data;
@@ -664,8 +666,13 @@ void x86_load_linux(X86MachineState *x86ms,
     cmdline_size =3D (strlen(kernel_cmdline) + 16) & ~15;
=20
     /* load the kernel header */
-    f =3D fopen(kernel_filename, "rb");
-    if (!f) {
+    fd =3D qemu_open(kernel_filename, O_RDONLY, &err);
+    if (fd < 0) {
+        error_report_err(err);
+        exit(1);
+    }
+    f =3D fdopen(fd, "rb");
+    if (f) {
         fprintf(stderr, "qemu: could not open kernel file '%s': %s\n",
                 kernel_filename, strerror(errno));
         exit(1);
@@ -719,12 +726,18 @@ void x86_load_linux(X86MachineState *x86ms,
=20
             /* load initrd */
             if (initrd_filename) {
+                int mapped_file_fd;
                 GMappedFile *mapped_file;
                 gsize initrd_size;
                 gchar *initrd_data;
                 GError *gerr =3D NULL;
=20
-                mapped_file =3D g_mapped_file_new(initrd_filename, false, =
&gerr);
+                mapped_file_fd =3D qemu_open(initrd_filename, O_RDONLY, &e=
rr);
+                if (fd < 0) {
+                    error_report_err(err);
+                    exit(1);
+                }
+                mapped_file =3D g_mapped_file_new_from_fd(mapped_file_fd, =
false, &gerr);
                 if (!mapped_file) {
                     fprintf(stderr, "qemu: error reading initrd %s: %s\n",
                             initrd_filename, gerr->message);
@@ -860,6 +873,7 @@ void x86_load_linux(X86MachineState *x86ms,
=20
     /* load initrd */
     if (initrd_filename) {
+        int mapped_file_fd;
         GMappedFile *mapped_file;
         gsize initrd_size;
         gchar *initrd_data;
@@ -870,7 +884,12 @@ void x86_load_linux(X86MachineState *x86ms,
             exit(1);
         }
=20
-        mapped_file =3D g_mapped_file_new(initrd_filename, false, &gerr);
+        mapped_file_fd =3D qemu_open(initrd_filename, O_RDONLY, &err);
+        if (mapped_file_fd < 0) {
+            error_report_err(err);
+            exit(1);
+        }
+        mapped_file =3D g_mapped_file_new_from_fd(mapped_file_fd, false, &=
gerr);
         if (!mapped_file) {
             fprintf(stderr, "qemu: error reading initrd %s: %s\n",
                     initrd_filename, gerr->message);
--=20
2.53.0


