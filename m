Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8BCEA7197
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 19:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEXvs-0003Qq-R7; Sun, 19 Apr 2026 15:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sertonix@posteo.net>)
 id 1wEXvr-0003Qg-DZ
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 15:35:51 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sertonix@posteo.net>)
 id 1wEXvp-0002O4-Hi
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 15:35:51 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id A1ECD240027
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 21:35:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1776627345; bh=IIIKnT3mHWISsNpkvQiYtjQiXvVqvr2+/Bnd7wluXDk=;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:
 Message-Id:From:To:Subject:From;
 b=rSLrMSOE9uswjqaYWX3RSHkMoWcpCKHZSkzOsqxRwzUClCKxIkpdW1ocFkoSLImpt
 mIXxWl2XSiDnO78FqBt60Z1F2rE+ctDpXPRy7oKU+RdIeq1QZUsxJ7xIDk7YowIfuc
 B7s/FQoATMHAgCNqXaylnO1wibVxjqB5Ys3anIVlghEIiRUeg4HCT+h+Es5VpSQOIk
 Q7TN9dzFZ4HMG+g8pkakEabl2FhW0f4Mp+PwQVAsAa/pigBhobu1RpWM1m3SU9c6kY
 oKYTmcCIG0DI9PITyWRggfacpxKTQeROLne/udtzQZyDUc8YQQnHTVwCcUibgX5ur+
 Y+EgJOgOPPXFA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4fzJkT15mhz9rxP
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 21:35:45 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 19 Apr 2026 19:35:45 +0000
Message-Id: <DHXDTYTOFYVL.3H531B0BJOQ22@posteo.net>
From: "Sertonix" <sertonix@posteo.net>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] hw/i386: Use qemu_open_old for kernel/initrd
Received-SPF: pass client-ip=185.67.36.65; envelope-from=sertonix@posteo.net;
 helo=mout01.posteo.de
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
 hw/i386/x86-common.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index fde05fa7d7..5d8be30f4d 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -651,6 +651,7 @@ void x86_load_linux(X86MachineState *x86ms,
     uint8_t header[8192], *setup, *kernel;
     hwaddr real_addr, prot_addr, cmdline_addr, initrd_addr =3D 0;
     FILE *f;
+    int fd;
     const char *vmode;
     MachineState *machine =3D MACHINE(x86ms);
     struct setup_data *setup_data;
@@ -664,8 +665,8 @@ void x86_load_linux(X86MachineState *x86ms,
     cmdline_size =3D (strlen(kernel_cmdline) + 16) & ~15;
=20
     /* load the kernel header */
-    f =3D fopen(kernel_filename, "rb");
-    if (!f) {
+    fd =3D qemu_open_old(kernel_filename, O_RDONLY);
+    if (fd < 0 || !(f =3D fdopen(fd, "rb"))) {
         fprintf(stderr, "qemu: could not open kernel file '%s': %s\n",
                 kernel_filename, strerror(errno));
         exit(1);
@@ -719,12 +720,14 @@ void x86_load_linux(X86MachineState *x86ms,
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
+                mapped_file_fd =3D qemu_open_old(initrd_filename, O_RDONLY=
);
+                mapped_file =3D g_mapped_file_new_from_fd(mapped_file_fd, =
false, &gerr);
                 if (!mapped_file) {
                     fprintf(stderr, "qemu: error reading initrd %s: %s\n",
                             initrd_filename, gerr->message);
@@ -860,6 +863,7 @@ void x86_load_linux(X86MachineState *x86ms,
=20
     /* load initrd */
     if (initrd_filename) {
+        int mapped_file_fd;
         GMappedFile *mapped_file;
         gsize initrd_size;
         gchar *initrd_data;
@@ -870,7 +874,8 @@ void x86_load_linux(X86MachineState *x86ms,
             exit(1);
         }
=20
-        mapped_file =3D g_mapped_file_new(initrd_filename, false, &gerr);
+        mapped_file_fd =3D qemu_open_old(initrd_filename, O_RDONLY);
+        mapped_file =3D g_mapped_file_new_from_fd(mapped_file_fd, false, &=
gerr);
         if (!mapped_file) {
             fprintf(stderr, "qemu: error reading initrd %s: %s\n",
                     initrd_filename, gerr->message);
--=20
2.53.0


