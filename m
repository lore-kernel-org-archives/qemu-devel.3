Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084B1C369C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 03:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6hlT-0001LG-Pv; Sun, 20 Apr 2025 23:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u6hlM-0001Dz-QF; Sun, 20 Apr 2025 23:24:05 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u6hlK-0002XX-FH; Sun, 20 Apr 2025 23:24:04 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30820167b47so3292232a91.0; 
 Sun, 20 Apr 2025 20:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745205838; x=1745810638; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tKpgRnNh0U38Le3i5dspQLi3SwFeogrfZxQNfKJq3R0=;
 b=fjsewEM3NoKWQoZ/9uBKziCFfFCaTHu1J0kPH0eQhFFJfCVA2y2xqVFAMqp7wNVj6+
 QyPUOEaGH+5ScjczahoBlJiZM2PUltejVy+k3NmEOvBmu9FPZQbfQ35iw2hH4J8TckVF
 rSOpsBmqjjWmo1MnM5dcSP8xM5bYX5rAF6ybrP1TQlkZfdfaoocVK9FyrCHOfy5E3HZO
 Hqx9CJs3bd6L7Andv/DhQ1Z5bfMonjmmdjOO11TQThvGWAGMjYXZuqbGlZGka4hqygPy
 U/K9N9lSlxkiWkvjsrZrpTTIBBtbzLiXXSdAumigLq37+++my2flfZineZ0E/pnb938H
 JreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745205838; x=1745810638;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tKpgRnNh0U38Le3i5dspQLi3SwFeogrfZxQNfKJq3R0=;
 b=eF2u99XjGe5bf5RNomL8XODrPDCIPDEHfl/GnbCKLBh13JSQcHnkqkKMd91YTwGrsV
 okTTrmUvaaf5+v87uOvVjVKLEO7ZXdM8j7GKMDZpDPuXZULNgeQ8Ki+ypR99CeGf0lAy
 P5HWJqwCVB++/5Or800kT2ax3FQjR3ibvxDxldqO7GA6wlFMX7ye15ZbKKivdsIDNDkd
 40xBdlYg+XaGKd1E1HtGQ4F+B1v1EqlM2gp6Yr5Vt+SNSAdUgHEeuJOulrCol/SRExuV
 lBSUHiHnDr0JqaK+QXeNKyPqgkMoDRmXqXenEv26tNyO0r/InMajSwWCJnQJA9IwWGqC
 i9EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx3hXYMA/et+9gt+jXYzJhGLqlqWnYnHOfxj2i8kJeP4h44kGGapEJnELi5MKXsijVgnIss6C/H8E=@nongnu.org,
 AJvYcCWCNXnCzl35Raj5C9Ze20uqJV5PIS/s6Ez3ezHtma4CnrRHh35Fkg0KKWofkZGy5GeIoC7o+oT8Ysw2tQ==@nongnu.org,
 AJvYcCWOrPQvt1vZ5f/sD1+KmHwhnBTWluTeetLnPDoLxVRxzyhFL20XgZ8cn3yWzT0lOi0g938SdofZsA==@nongnu.org,
 AJvYcCXDZ907FChFoZktnlo/4K3FITcLQUj+S1AUosTu7kQpK2x/xTcAq2EbZvoL9+/foogVSODvq0ZTAKF8bQ==@nongnu.org,
 AJvYcCXGD0K+RjqVMz/wQirMC0zfvOr+xt6zHq4Kb9pt0QDeVF61lFGaNVYHiHPlGK5DTl130HfbtCd4z+pVtw==@nongnu.org
X-Gm-Message-State: AOJu0YwU+SiwOF7BtmxDk2MDg/rIKCS1JICDoGfQMzs1ZX20x87snGoU
 ckO4rOfpezenqR+jfZKmWBtbU+DjXMrMzPmbAKmM30DT6IoRJF82NC8dHgYP7Oj7M4HOOsG+Nz0
 WpyTY1R2TsSR10Eg8ozL4JziEKKg=
X-Gm-Gg: ASbGncsYEy46RooBljZLahGwGJSa8IAKPwkyvfcvGQTpES7rManGU9GpoeGI7ByN8cF
 BJH1NCfv4IGo84hoz5KIuP4E8/O+dZ7X4u59KQPGhTYXWkGZmCa4SpUkEqaRXOeXjJF/z9yovO1
 B3vb0h7+/x9t495W4cwl9OL1XuXCbd9LmNMiWj0Ht10GlPhUlLnvz0
X-Google-Smtp-Source: AGHT+IHCaB055zoL1kSt2nejF9OG6vn+9UVi1woRfh23vbDtdyxHtCSay9c5mk6rt2bFvh378wpuoT6VqgJHu2ooXTE=
X-Received: by 2002:a17:90a:fc44:b0:2fa:2268:1af4 with SMTP id
 98e67ed59e1d1-30879ac20b7mr15984996a91.7.1745205838276; Sun, 20 Apr 2025
 20:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744787186.git.ktokunaga.mail@gmail.com>
 <7ef485c860a0c26d2ddcf6a96430f5443deb5aee.1744787186.git.ktokunaga.mail@gmail.com>
 <a92737eb-786d-4ebc-87df-a5518417195c@linaro.org>
 <CAEDrbUaZYYxvW_D8ZS=qxOai06PiQQnN4mO2fjupPkwiNqqQjA@mail.gmail.com>
In-Reply-To: <CAEDrbUaZYYxvW_D8ZS=qxOai06PiQQnN4mO2fjupPkwiNqqQjA@mail.gmail.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Mon, 21 Apr 2025 12:23:46 +0900
X-Gm-Features: ATxdqUGzPN5zwPQ2PhIfSgS3wTaWXk6CXzjm0P-q913OiQmtwBX2W11MHRIDA0U
Message-ID: <CAEDrbUb1zb1sVjBboSyq7Pe=MGJ+8mWQX8S3SQ0RiY05xHbWew@mail.gmail.com>
Subject: Re: [PATCH 15/19] util/mmap-alloc: Add qemu_ram_mmap implementation
 for emscripten
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 Vikram Garhwal <vikram.garhwal@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000cf21206334166ec"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000000cf21206334166ec
Content-Type: text/plain; charset="UTF-8"

Hi Philippe,

While working on mmap-alloc.c, I found that Emscripten does not support
partial unmapping of memory regions [1]. This limitation prevents correct
implementation of qemu_ram_mmap and qemu_ram_munmap, which rely on partial
unmap behavior.

[1]
https://github.com/emscripten-core/emscripten/blob/d4a74336f23214bf3304d9eb0d03966786b30a36/system/lib/libc/emscripten_mmap.c#L61

As a workaround, I'm considering excluding mmap-alloc.c from the Emscripten
build. Instead, for Emscripten build, we can modify qemu_anon_ram_alloc (in
oslib-posix.c) to use qemu_memalign in place of qemu_ram_mmap, and disable
memory backends that rely on mmap, such as memory-backend-file and
memory-backend-shm.

I plan to include this fix in the next version of the patch series. I'm
happy to hear any suggestions if there is a better way to address this
limitation.

The change in oslib-posix.c will look like this:

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index a697c602c6..8eb0e53458 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -58,6 +58,7 @@
 #include <lwp.h>
 #endif

+#include "qemu/memalign.h"
 #include "qemu/mmap-alloc.h"

 #define MAX_MEM_PREALLOC_THREAD_COUNT 16
@@ -210,11 +211,21 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t
*alignment, bool shared,
     const uint32_t qemu_map_flags = (shared ? QEMU_MAP_SHARED : 0) |
                                     (noreserve ? QEMU_MAP_NORESERVE : 0);
     size_t align = QEMU_VMALLOC_ALIGN;
+#ifndef EMSCRIPTEN
     void *ptr = qemu_ram_mmap(-1, size, align, qemu_map_flags, 0);

     if (ptr == MAP_FAILED) {
         return NULL;
     }
+#else
+    /*
+     * qemu_ram_mmap is not implemented for Emscripten. Use qemu_memalign
+     * for the anonymous allocation. noreserve is ignored as there is no
swap
+     * space on Emscripten, and shared is ignored as there is no other
+     * processes on Emscripten.
+     */
+    void *ptr = qemu_memalign(align, size);
+#endif

     if (alignment) {
         *alignment = align;
@@ -227,7 +238,16 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t
*alignment, bool shared,
 void qemu_anon_ram_free(void *ptr, size_t size)
 {
     trace_qemu_anon_ram_free(ptr, size);
+#ifndef EMSCRIPTEN
     qemu_ram_munmap(-1, ptr, size);
+#else
+    /*
+     * qemu_ram_munmap is not implemented for Emscripten and qemu_memalign
+     * was used for the allocation. Use the corresponding freeing function
+     * here.
+     */
+    qemu_vfree(ptr);
+#endif
 }

 void qemu_socket_set_block(int fd)
@@ -588,7 +608,15 @@ bool qemu_prealloc_mem(int fd, char *area, size_t sz,
int max_threads,
 {
     static gsize initialized;
     int ret;
+#ifndef EMSCRIPTEN
     size_t hpagesize = qemu_fd_getpagesize(fd);
+#else
+    /*
+     * mmap-alloc.c is excluded from Emscripten build, so
qemu_fd_getpagesize
+     * is unavailable. Fallback to the lower level implementation.
+     */
+    size_t hpagesize = qemu_real_host_page_size();
+#endif
     size_t numpages = DIV_ROUND_UP(sz, hpagesize);
     bool use_madv_populate_write;
     struct sigaction act;

--0000000000000cf21206334166ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,</div><div><br></div><div>While working o=
n mmap-alloc.c, I found that Emscripten does not support<br>partial unmappi=
ng of memory regions [1]. This limitation prevents correct<br>implementatio=
n of qemu_ram_mmap and qemu_ram_munmap, which rely on partial<br>unmap beha=
vior.<br><br>[1] <a href=3D"https://github.com/emscripten-core/emscripten/b=
lob/d4a74336f23214bf3304d9eb0d03966786b30a36/system/lib/libc/emscripten_mma=
p.c#L61">https://github.com/emscripten-core/emscripten/blob/d4a74336f23214b=
f3304d9eb0d03966786b30a36/system/lib/libc/emscripten_mmap.c#L61</a><br><br>=
As a workaround, I&#39;m considering excluding mmap-alloc.c from the Emscri=
pten<br>build. Instead, for Emscripten build, we can modify qemu_anon_ram_a=
lloc (in<br>oslib-posix.c) to use qemu_memalign in place of qemu_ram_mmap, =
and disable<br>memory backends that rely on mmap, such as memory-backend-fi=
le and<br>memory-backend-shm.<br><br>I plan to include this fix in the next=
 version of the patch series. I&#39;m<br>happy to hear any suggestions if t=
here is a better way to address this<br>limitation.<br><br>The change in os=
lib-posix.c will look like this:<br><br>diff --git a/util/oslib-posix.c b/u=
til/oslib-posix.c<br>index a697c602c6..8eb0e53458 100644<br>--- a/util/osli=
b-posix.c<br>+++ b/util/oslib-posix.c<br>@@ -58,6 +58,7 @@<br>=C2=A0#includ=
e &lt;lwp.h&gt;<br>=C2=A0#endif<br>=C2=A0<br>+#include &quot;qemu/memalign.=
h&quot;<br>=C2=A0#include &quot;qemu/mmap-alloc.h&quot;<br>=C2=A0<br>=C2=A0=
#define MAX_MEM_PREALLOC_THREAD_COUNT 16<br>@@ -210,11 +211,21 @@ void *qem=
u_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared,<br>=C2=A0 =
=C2=A0 =C2=A0const uint32_t qemu_map_flags =3D (shared ? QEMU_MAP_SHARED : =
0) |<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(noreserv=
e ? QEMU_MAP_NORESERVE : 0);<br>=C2=A0 =C2=A0 =C2=A0size_t align =3D QEMU_V=
MALLOC_ALIGN;<br>+#ifndef EMSCRIPTEN<br>=C2=A0 =C2=A0 =C2=A0void *ptr =3D q=
emu_ram_mmap(-1, size, align, qemu_map_flags, 0);<br>=C2=A0<br>=C2=A0 =C2=
=A0 =C2=A0if (ptr =3D=3D MAP_FAILED) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return NULL;<br>=C2=A0 =C2=A0 =C2=A0}<br>+#else<br>+ =C2=A0 =C2=A0/* <br=
>+ =C2=A0 =C2=A0 * qemu_ram_mmap is not implemented for Emscripten. Use qem=
u_memalign<br>+ =C2=A0 =C2=A0 * for the anonymous allocation. noreserve is =
ignored as there is no swap<br>+ =C2=A0 =C2=A0 * space on Emscripten, and s=
hared is ignored as there is no other<br>+ =C2=A0 =C2=A0 * processes on Ems=
cripten.<br>+ =C2=A0 =C2=A0 */<br>+ =C2=A0 =C2=A0void *ptr =3D qemu_memalig=
n(align, size);<br>+#endif<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0if (alignment) =
{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*alignment =3D align;<br>@@ -227,7 +=
238,16 @@ void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool =
shared,<br>=C2=A0void qemu_anon_ram_free(void *ptr, size_t size)<br>=C2=A0{=
<br>=C2=A0 =C2=A0 =C2=A0trace_qemu_anon_ram_free(ptr, size);<br>+#ifndef EM=
SCRIPTEN<br>=C2=A0 =C2=A0 =C2=A0qemu_ram_munmap(-1, ptr, size);<br>+#else<b=
r>+ =C2=A0 =C2=A0/*<br>+ =C2=A0 =C2=A0 * qemu_ram_munmap is not implemented=
 for Emscripten and qemu_memalign<br>+ =C2=A0 =C2=A0 * was used for the all=
ocation. Use the corresponding freeing function<br>+ =C2=A0 =C2=A0 * here.<=
br>+ =C2=A0 =C2=A0 */<br>+ =C2=A0 =C2=A0qemu_vfree(ptr);<br>+#endif<br>=C2=
=A0}<br>=C2=A0<br>=C2=A0void qemu_socket_set_block(int fd)<br>@@ -588,7 +60=
8,15 @@ bool qemu_prealloc_mem(int fd, char *area, size_t sz, int max_threa=
ds,<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0static gsize initialized;<br>=C2=A0 =
=C2=A0 =C2=A0int ret;<br>+#ifndef EMSCRIPTEN<br>=C2=A0 =C2=A0 =C2=A0size_t =
hpagesize =3D qemu_fd_getpagesize(fd);<br>+#else<br>+ =C2=A0 =C2=A0/*<br>+ =
=C2=A0 =C2=A0 * mmap-alloc.c is excluded from Emscripten build, so qemu_fd_=
getpagesize<br>+ =C2=A0 =C2=A0 * is unavailable. Fallback to the lower leve=
l implementation.<br>+ =C2=A0 =C2=A0 */<br>+ =C2=A0 =C2=A0size_t hpagesize =
=3D qemu_real_host_page_size();<br>+#endif<br>=C2=A0 =C2=A0 =C2=A0size_t nu=
mpages =3D DIV_ROUND_UP(sz, hpagesize);<br>=C2=A0 =C2=A0 =C2=A0bool use_mad=
v_populate_write;<br>=C2=A0 =C2=A0 =C2=A0struct sigaction act;</div></div>

--0000000000000cf21206334166ec--

