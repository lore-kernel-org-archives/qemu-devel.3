Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6A2CC6B2A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 04:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHvZy-0001jL-Ki; Fri, 16 Oct 2026 23:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hooyan2024@gmail.com>)
 id 1xHtnD-00012i-0m
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 22:05:03 -0400
Received: from mail-ej2-x04.google.com ([2a00:1450:4864:34::4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hooyan2024@gmail.com>)
 id 1xHtnA-0006Lp-H3
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 22:05:02 -0400
Received: by mail-ej2-x04.google.com with SMTP id
 a640c23a62f3a-c350e54b6ceso28244666b.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 19:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792202698; cv=none;
 d=google.com; s=arc-20260327;
 b=pHPY8+MBMSqq9/NgThyS1copjQ4RS4n1TGOMJ0GwMc+/25v0jljxbt1HX7JYBTCYzB
 PQVIR/EAgYUbjJR92jHTVkDCfq6eip/dN93wdt17buYHz433YmsltTBjkwXLNkcWanx6
 1sueBqZy8x52SlbDpzQWaSCr7eV1TmVvZJS63UwPZg6pqnIK2s86rbyIEVHeW1SBqD0R
 ihCdFZHq+0G1NkI9nY6MDZXfNWsxRTSNYc45ydRU9g85zq5iNAM4GouOXe6z8brxqgXY
 LZejB+hSqs9TNOnr+8bxM4vYkldq8kHyKPGXncVUgxr8LUxotsUARgTgMoa6koBWwUKH
 EVaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=2QB6CHtPgeWxu8vcQikBm37clwMdTYgv9OW/qSjSv+0=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=XtbhQYY5qhTK/I28+EG5/UxMY7PMOPxpgLx5RSFdPpZUlH/20aozqvALnaL5ZX1/8W
 sFBcTgly9GXdNwcvHLJNYzwE4ZYqp97x9uUBiKpDyvY89AGF0szAPzrR4NzfEIfvCi6t
 Lg1MOHK0dISLv2u2e+YMAGKMVXXWsDNZc1depQl7TGLvvo8GI4rj4KyhH+tnx6XCYKia
 EZza0uTxVk9HJH+TzX8AOOXVXzjYNF7/wJb8XCpDjGEWeGTxOGV7UIMEUtRQP4cEWjZJ
 IZwcao7IECd8bOOmooFxF2iGzJLWFjorTPNWZohTkztGEZCJK8EvYJHhDlJpIfSlyJpl
 jHaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792202698; x=1792807498; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2QB6CHtPgeWxu8vcQikBm37clwMdTYgv9OW/qSjSv+0=;
 b=Fycgk3AiG9WiYt+DPNS1VZFiyP0v932lVAUaEVWxQ0EGihgQ4/7GO3fd+91Wvp3eCm
 eBMeJyoXNYIOq+Xe0P88sXjAglFKDW3xevt/ZJiuDAj4RYCgxsvWoXGkCDBisTrFikNG
 RuJ7Q+IlWLoOuSGvlyJAY6/oXXnZ1E6becXJ7gB0HirPZqPeaq3yl4T5xv21pGnBKuJl
 86kUpC+/JgYEHIAC9gUVkOi2z3lX23UNQkD+3DWVFvU+ssx6FaFLFE6t8Il4yovZ30hj
 230zPB8Fk/Int/ne1FXitme8PQ9YEFPlh4Nk/mo0CAZtS5Z+DB4f/MWueg+J9zF5mzGN
 d9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792202698; x=1792807498;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2QB6CHtPgeWxu8vcQikBm37clwMdTYgv9OW/qSjSv+0=;
 b=aKnpkxi121VpAbpbMXLyalzLQiyJImXiwB3APTdsh3ivpMyHjl0iUaOFSnLNbwRoaT
 /FwHyhG+LYjJaygobmscZhL2wIVHPGp7bEqy64ubmvRnuUaW29GeD/T3sRr8whBJPqL3
 0Rymbw2yS7YCp9yn7p02IHVzMiIXd74Itgge1I68JF16lljaRwbMgIbOq8SWKDtmB4LP
 9GwNa5spNW7Gr+cuSOTh8waPmtH2NoM/flrT+n/IrZyAlRq6eYsiYFZX01jSkssTMWg3
 lQ0jNGLU/8wS73AltQzo2IIDT17pmgCRIiRC96ypHHPBtLqb8UR7KfGL3fGc2h8ggrni
 sa4g==
X-Gm-Message-State: AFq9FYJKvT17vft2yXjPXrzDSlFYfzfM0wqecZTRJfRRbMgK6LQFiFoZ
 CpqSZasDx9MuhZSxphiVZes6M3/d6VjbAUW1ZpjSomd1OmCDApi6F8sHPlU/Vo8K7z1E9iLDSrG
 lUDiguwGr7vCqrScsNS2rgB1pVQU38fwE0zjfVX8=
X-Gm-Gg: AYBFou1ZBrduBkOU/U/RmC085lnZKjd38iOjbugfHSd48X319EQZGT1rTg4G0eGFHAA
 9/5XjPIUJBIlc/LjXfyFkaDwCuhl/iMuTMMX7u3kLZYWKJejRsV3bwPlREajHDBRTCPWQ7o2QqU
 yFmZFZ7SGPPXzMz2yQJjswqAsY9NitrotkL8Ff8IyEHuLHm9TeulbOKd/4iGJcYXiOgAiK5YwiN
 0oxz18j2gsmq2Xtmu/nd2CawDNAOdHvq683pxNY7qMBvrVNCs+wYlWwPHOpinHXJVp0peqew1a7
 kukEHNWZt4bxHUOTRtmiL+D2lHvfV8F7p8M5fphjAgAvWX+ba8h9wlmCkfI77jy1JgUH
X-Received: by 2002:a17:906:f583:b0:c2e:52d6:1fb7 with SMTP id
 a640c23a62f3a-c419e63d14fmr97608066b.22.1792202697806; Fri, 16 Oct 2026
 19:04:57 -0700 (PDT)
MIME-Version: 1.0
From: Jiang Yuxuan <hooyan2024@gmail.com>
Date: Fri, 16 Oct 2026 22:04:40 -0400
X-Gm-Features: AclHuK8Wrtca9DCnRhJkep9hOqib77FUz9RvXY6udKiXUd3QqyTfYIAG-DVji2M
Message-ID: <CAAt7E3+jVR+YHZC3996kdC_Xrh9aVJ4YLy8X7+1HyjvOQk09Ug@mail.gmail.com>
Subject: [PATCH] target/i386: raise #DE for INT_MIN / -1 in IDIV helpers
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002b1865065dffb534"
Received-SPF: pass client-ip=2a00:1450:4864:34::4;
 envelope-from=hooyan2024@gmail.com; helo=mail-ej2-x04.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Oct 2026 23:59:29 -0400
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

--0000000000002b1865065dffb534
Content-Type: text/plain; charset="UTF-8"

helper_idivw_AX() and helper_idivl_EAX() perform the division before
checking whether the quotient fits in the destination.  If the dividend
is the minimum value and the divisor is -1, the division overflows in
the host: INT32_MIN / -1 and INT64_MIN / -1 are undefined behaviour in C
and trap with SIGFPE on x86 hosts.  QEMU then dies of a host SIGFPE
instead of raising #DE in the guest, taking down the emulator (or the
whole VM under TCG).

Reject the two overflowing cases before dividing.  The 8-bit form is not
affected (it widens the dividend to int), and the 64-bit form already
checks first.

Add a regression test for both the 16-bit and 32-bit forms, run by the
i386 and x86_64 linux-user test suites.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4687
Signed-off-by: fujo <hooyan2024@gmail.com>
---
 target/i386/tcg/int_helper.c        |  4 +-
 tests/tcg/i386/meson.build          |  1 +
 tests/tcg/i386/test-idiv-overflow.c | 70 +++++++++++++++++++++++++++++
 tests/tcg/x86_64/meson.build        |  1 +
 4 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/i386/test-idiv-overflow.c

diff --git a/target/i386/tcg/int_helper.c b/target/i386/tcg/int_helper.c
index 46741d9..45fa0a8 100644
--- a/target/i386/tcg/int_helper.c
+++ b/target/i386/tcg/int_helper.c
@@ -91,7 +91,7 @@ void helper_idivw_AX(CPUX86State *env, target_ulong t0)

     num = (env->regs[R_EAX] & 0xffff) | ((env->regs[R_EDX] & 0xffff) <<
16);
     den = (int16_t)t0;
-    if (den == 0) {
+    if (den == 0 || (num == INT32_MIN && den == -1)) {
         raise_exception_ra(env, EXCP00_DIVZ, GETPC());
     }
     q = (num / den);
@@ -130,7 +130,7 @@ void helper_idivl_EAX(CPUX86State *env, target_ulong t0)

     num = ((uint32_t)env->regs[R_EAX]) |
((uint64_t)((uint32_t)env->regs[R_EDX]) << 32);
     den = t0;
-    if (den == 0) {
+    if (den == 0 || (num == INT64_MIN && den == -1)) {
         raise_exception_ra(env, EXCP00_DIVZ, GETPC());
     }
     q = (num / den);
diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 84bd680..5d88858 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -38,6 +38,7 @@ tests += {
     'cflags': [files('test-i386-code16.S'), files('test-i386-vm86.S'),
                '-lm', '-fno-pie', '-Wl,--no-warn-rwx-segments'],
   },
+  'test-idiv-overflow.c': {},
   '../multiarch/sha512.c': {
      'exe_name': 'sha512-sse',
      'cflags': ['-msse4.1', '-O3'],
diff --git a/tests/tcg/i386/test-idiv-overflow.c
b/tests/tcg/i386/test-idiv-overflow.c
new file mode 100644
index 0000000..e8fc55a
--- /dev/null
+++ b/tests/tcg/i386/test-idiv-overflow.c
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Test that IDIV of the minimum dividend by -1 raises #DE, which Linux
+ * delivers to the guest as SIGFPE with si_code == FPE_INTDIV.
+ */
+#define _GNU_SOURCE
+#include <setjmp.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+
+static sigjmp_buf idiv_jmp;
+static volatile sig_atomic_t idiv_si_code;
+
+static void idiv_sig_handler(int sig, siginfo_t *info, void *puc)
+{
+    (void)sig;
+    (void)puc;
+    idiv_si_code = info->si_code;
+    siglongjmp(idiv_jmp, 1);
+}
+
+static int check_idiv_overflow(int width)
+{
+    struct sigaction sa, old;
+    int ret = 1;
+
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_sigaction = idiv_sig_handler;
+    sa.sa_flags = SA_SIGINFO | SA_NODEFER;
+    sigemptyset(&sa.sa_mask);
+    sigaction(SIGFPE, &sa, &old);
+
+    idiv_si_code = 0;
+    if (sigsetjmp(idiv_jmp, 1) == 0) {
+        if (width == 16) {
+            /* DX:AX = 0x8000:0x0000, divisor -1 */
+            __asm__ volatile ("movl $0x8000, %%edx\n\t"
+                              "xorl %%eax, %%eax\n\t"
+                              "movl $-1, %%ecx\n\t"
+                              "idivw %%cx"
+                              : : : "eax", "ecx", "edx", "cc");
+        } else {
+            /* EDX:EAX = 0x80000000:0x00000000, divisor -1 */
+            __asm__ volatile ("movl $0x80000000, %%edx\n\t"
+                              "xorl %%eax, %%eax\n\t"
+                              "movl $-1, %%ecx\n\t"
+                              "idivl %%ecx"
+                              : : : "eax", "ecx", "edx", "cc");
+        }
+        printf("FAIL: idiv%d did not raise #DE\n", width);
+    } else if (idiv_si_code != FPE_INTDIV) {
+        printf("FAIL: idiv%d raised SIGFPE with si_code %d\n",
+               width, (int)idiv_si_code);
+    } else {
+        ret = 0;
+    }
+
+    sigaction(SIGFPE, &old, NULL);
+    return ret;
+}
+
+int main(void)
+{
+    int ret = 0;
+
+    ret |= check_idiv_overflow(16);
+    ret |= check_idiv_overflow(32);
+    return ret;
+}
diff --git a/tests/tcg/x86_64/meson.build b/tests/tcg/x86_64/meson.build
index 95c7ee6..4106d4d 100644
--- a/tests/tcg/x86_64/meson.build
+++ b/tests/tcg/x86_64/meson.build
@@ -52,6 +52,7 @@ tests += {
   },
   '../i386/test-i386-adcox.c': {'cflags': ['-O2']},
   '../i386/test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
+  '../i386/test-idiv-overflow.c': {},
 }

 tests += {
-- 
2.53.0

--0000000000002b1865065dffb534
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">helper_idivw_AX() and helper_idivl_EAX() perform the divis=
ion before<br>checking whether the quotient fits in the destination.=C2=A0 =
If the dividend<br>is the minimum value and the divisor is -1, the division=
 overflows in<br>the host: INT32_MIN / -1 and INT64_MIN / -1 are undefined =
behaviour in C<br>and trap with SIGFPE on x86 hosts.=C2=A0 QEMU then dies o=
f a host SIGFPE<br>instead of raising #DE in the guest, taking down the emu=
lator (or the<br>whole VM under TCG).<br><br>Reject the two overflowing cas=
es before dividing.=C2=A0 The 8-bit form is not<br>affected (it widens the =
dividend to int), and the 64-bit form already<br>checks first.<br><br>Add a=
 regression test for both the 16-bit and 32-bit forms, run by the<br>i386 a=
nd x86_64 linux-user test suites.<br><br>Resolves: <a href=3D"https://gitla=
b.com/qemu-project/qemu/-/issues/4687">https://gitlab.com/qemu-project/qemu=
/-/issues/4687</a><br>Signed-off-by: fujo &lt;<a href=3D"mailto:hooyan2024@=
gmail.com">hooyan2024@gmail.com</a>&gt;<br>---<br>=C2=A0target/i386/tcg/int=
_helper.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A04 +-<br>=C2=A0tests/tcg/i386/m=
eson.build =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A01 +<br>=C2=A0tests/tcg=
/i386/test-idiv-overflow.c | 70 +++++++++++++++++++++++++++++<br>=C2=A0test=
s/tcg/x86_64/meson.build =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A01 +<br>=C2=A04 =
files changed, 74 insertions(+), 2 deletions(-)<br>=C2=A0create mode 100644=
 tests/tcg/i386/test-idiv-overflow.c<br><br>diff --git a/target/i386/tcg/in=
t_helper.c b/target/i386/tcg/int_helper.c<br>index 46741d9..45fa0a8 100644<=
br>--- a/target/i386/tcg/int_helper.c<br>+++ b/target/i386/tcg/int_helper.c=
<br>@@ -91,7 +91,7 @@ void helper_idivw_AX(CPUX86State *env, target_ulong t=
0)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0num =3D (env-&gt;regs[R_EAX] &amp; 0xff=
ff) | ((env-&gt;regs[R_EDX] &amp; 0xffff) &lt;&lt; 16);<br>=C2=A0 =C2=A0 =
=C2=A0den =3D (int16_t)t0;<br>- =C2=A0 =C2=A0if (den =3D=3D 0) {<br>+ =C2=
=A0 =C2=A0if (den =3D=3D 0 || (num =3D=3D INT32_MIN &amp;&amp; den =3D=3D -=
1)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise_exception_ra(env, EXCP00_D=
IVZ, GETPC());<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0q =3D (num /=
 den);<br>@@ -130,7 +130,7 @@ void helper_idivl_EAX(CPUX86State *env, targe=
t_ulong t0)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0num =3D ((uint32_t)env-&gt;reg=
s[R_EAX]) | ((uint64_t)((uint32_t)env-&gt;regs[R_EDX]) &lt;&lt; 32);<br>=C2=
=A0 =C2=A0 =C2=A0den =3D t0;<br>- =C2=A0 =C2=A0if (den =3D=3D 0) {<br>+ =C2=
=A0 =C2=A0if (den =3D=3D 0 || (num =3D=3D INT64_MIN &amp;&amp; den =3D=3D -=
1)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0raise_exception_ra(env, EXCP00_D=
IVZ, GETPC());<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0q =3D (num /=
 den);<br>diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.bu=
ild<br>index 84bd680..5d88858 100644<br>--- a/tests/tcg/i386/meson.build<br=
>+++ b/tests/tcg/i386/meson.build<br>@@ -38,6 +38,7 @@ tests +=3D {<br>=C2=
=A0 =C2=A0 =C2=A0&#39;cflags&#39;: [files(&#39;test-i386-code16.S&#39;), fi=
les(&#39;test-i386-vm86.S&#39;),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &#39;-lm&#39;, &#39;-fno-pie&#39;, &#39;-Wl,--no-warn-rwx=
-segments&#39;],<br>=C2=A0 =C2=A0},<br>+ =C2=A0&#39;test-idiv-overflow.c&#3=
9;: {},<br>=C2=A0 =C2=A0&#39;../multiarch/sha512.c&#39;: {<br>=C2=A0 =C2=A0=
 =C2=A0 &#39;exe_name&#39;: &#39;sha512-sse&#39;,<br>=C2=A0 =C2=A0 =C2=A0 &=
#39;cflags&#39;: [&#39;-msse4.1&#39;, &#39;-O3&#39;],<br>diff --git a/tests=
/tcg/i386/test-idiv-overflow.c b/tests/tcg/i386/test-idiv-overflow.c<br>new=
 file mode 100644<br>index 0000000..e8fc55a<br>--- /dev/null<br>+++ b/tests=
/tcg/i386/test-idiv-overflow.c<br>@@ -0,0 +1,70 @@<br>+/* SPDX-License-Iden=
tifier: GPL-2.0-or-later */<br>+/*<br>+ * Test that IDIV of the minimum div=
idend by -1 raises #DE, which Linux<br>+ * delivers to the guest as SIGFPE =
with si_code =3D=3D FPE_INTDIV.<br>+ */<br>+#define _GNU_SOURCE<br>+#includ=
e &lt;setjmp.h&gt;<br>+#include &lt;signal.h&gt;<br>+#include &lt;stdio.h&g=
t;<br>+#include &lt;string.h&gt;<br>+<br>+static sigjmp_buf idiv_jmp;<br>+s=
tatic volatile sig_atomic_t idiv_si_code;<br>+<br>+static void idiv_sig_han=
dler(int sig, siginfo_t *info, void *puc)<br>+{<br>+ =C2=A0 =C2=A0(void)sig=
;<br>+ =C2=A0 =C2=A0(void)puc;<br>+ =C2=A0 =C2=A0idiv_si_code =3D info-&gt;=
si_code;<br>+ =C2=A0 =C2=A0siglongjmp(idiv_jmp, 1);<br>+}<br>+<br>+static i=
nt check_idiv_overflow(int width)<br>+{<br>+ =C2=A0 =C2=A0struct sigaction =
sa, old;<br>+ =C2=A0 =C2=A0int ret =3D 1;<br>+<br>+ =C2=A0 =C2=A0memset(&am=
p;sa, 0, sizeof(sa));<br>+ =C2=A0 =C2=A0sa.sa_sigaction =3D idiv_sig_handle=
r;<br>+ =C2=A0 =C2=A0sa.sa_flags =3D SA_SIGINFO | SA_NODEFER;<br>+ =C2=A0 =
=C2=A0sigemptyset(&amp;sa.sa_mask);<br>+ =C2=A0 =C2=A0sigaction(SIGFPE, &am=
p;sa, &amp;old);<br>+<br>+ =C2=A0 =C2=A0idiv_si_code =3D 0;<br>+ =C2=A0 =C2=
=A0if (sigsetjmp(idiv_jmp, 1) =3D=3D 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (width =3D=3D 16) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* DX:A=
X =3D 0x8000:0x0000, divisor -1 */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0__asm__ volatile (&quot;movl $0x8000, %%edx\n\t&quot;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&quot;xorl %%eax, %%eax\n\t&quot;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;movl $-1, %%ecx\n\t&quot;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;idivw %%cx&quot;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: : : =
&quot;eax&quot;, &quot;ecx&quot;, &quot;edx&quot;, &quot;cc&quot;);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* EDX:EAX =3D 0x80000000:0x00000000, divisor -1 */<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__asm__ volatile (&quot;movl $0x80000000, %%=
edx\n\t&quot;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;xorl %%eax, %%eax\n\t=
&quot;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;movl $-1, %%ecx\n\t&quot;<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;idivl %%ecx&quot;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0: : : &quot;eax&quot;, &quot;ecx&quot;, &quot;edx&quot;=
, &quot;cc&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0printf(&quot;FAIL: idiv%d did not raise #DE\n&quot;, width);<br>+=
 =C2=A0 =C2=A0} else if (idiv_si_code !=3D FPE_INTDIV) {<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0printf(&quot;FAIL: idiv%d raised SIGFPE with si_code %d\n&quo=
t;,<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 width, (int)idiv_=
si_code);<br>+ =C2=A0 =C2=A0} else {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =
=3D 0;<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0sigaction(SIGFPE, &amp;ol=
d, NULL);<br>+ =C2=A0 =C2=A0return ret;<br>+}<br>+<br>+int main(void)<br>+{=
<br>+ =C2=A0 =C2=A0int ret =3D 0;<br>+<br>+ =C2=A0 =C2=A0ret |=3D check_idi=
v_overflow(16);<br>+ =C2=A0 =C2=A0ret |=3D check_idiv_overflow(32);<br>+ =
=C2=A0 =C2=A0return ret;<br>+}<br>diff --git a/tests/tcg/x86_64/meson.build=
 b/tests/tcg/x86_64/meson.build<br>index 95c7ee6..4106d4d 100644<br>--- a/t=
ests/tcg/x86_64/meson.build<br>+++ b/tests/tcg/x86_64/meson.build<br>@@ -52=
,6 +52,7 @@ tests +=3D {<br>=C2=A0 =C2=A0},<br>=C2=A0 =C2=A0&#39;../i386/te=
st-i386-adcox.c&#39;: {&#39;cflags&#39;: [&#39;-O2&#39;]},<br>=C2=A0 =C2=A0=
&#39;../i386/test-i386-bmi2.c&#39;: {&#39;cflags&#39;: [&#39;-O2&#39;, &#39=
;-fwrapv&#39;]},<br>+ =C2=A0&#39;../i386/test-idiv-overflow.c&#39;: {},<br>=
=C2=A0}<br>=C2=A0<br>=C2=A0tests +=3D {<br>-- <br>2.53.0<br><br></div>

--0000000000002b1865065dffb534--

