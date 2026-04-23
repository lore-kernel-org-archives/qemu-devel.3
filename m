Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8405DFDEE28
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 23:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG3M1-00019B-LN; Thu, 23 Apr 2026 19:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wG3M0-00018p-3f
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 19:21:04 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wG3Lx-0000zB-Nj
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 19:21:03 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ba699316b42so860523466b.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 16:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776986459; cv=none;
 d=google.com; s=arc-20240605;
 b=Fh2rZ+Gy2mNuxOnkOP+m2O4U5LAR4EhDVN6S1FHWE7oXYgBG4XpCsAr7Ti42FnmDOt
 ZlIE0xnQegyPDy03uw4ZIXJ8c04eKVxoQ/eA9R0PPDAnBdlpulNC5ecPS1vmJZCw/yTC
 jErcdu94W3QQbOP62axpWvrtpNKJ0Wbtk1PP3AmZT0P1frgTyHRRJumlAUcB/C9NgUkS
 IpxLLSThtFtDOGInwgUy7cWr/SdrPFs5oRfEGOrPHUjcWL0RhaKmfYmCRwqJJgiv6MWO
 f+4MpN/G3RgEVIFdN68NDLSF40Zfnw+7iJb9aMGLUuajvMaIwLHKNsiO5u+QKWACV7AJ
 tM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sunHjT72rjHAhOEyPji1ubMQtWaRJTiTQvIp9Wuy0r0=;
 fh=0gw5nfXnh7VFeoy1bdl11avC11t0a9fpFz5v6uZHFHI=;
 b=e/ertBS3m17/hG7VlLJBesJOiBZyt6u7KXzQsSX5In3IBM6PDDcC7aDOXC+xf8N8w1
 9iAS3iUu25bZHjxdahQmc4W3fT6+8h32I95w7Jfr2ebuu80frniGlELMOKEVN3dNZqvi
 hxlr52d4lKI1mMnBZ7kOj0L/X2RPfGpaopq7xiFG7EEK9Jh5xbDt4d5OmmqQ2eMWbPSp
 tvNMYlxpNH3WXUow8Z2kJiKpP3vIYYxuU/SmR36sGNYWRHd1M0QVOFB7MhqRaYOlfMlf
 m6q6zNOx6MFXFnbN1r7IWqNRSekUkUTAEE9zePZ0djWlnDSuMaf4SjI6d5a6Cs/u/BwO
 RYbw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776986459; x=1777591259; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sunHjT72rjHAhOEyPji1ubMQtWaRJTiTQvIp9Wuy0r0=;
 b=V9boVdNqy2uMDdRFJwDRxhUpCgARddVUoNIur/pz8h0zwEfYqYxVcOU7YK4B06NMuJ
 irG6VitE1fQ9Qf61lRH8890Vp9yNvREd2UuvmKBR/77cPwjlM8zB+d1lr/q0iLfZ0jOn
 EmRk3jU9IHk2ZhOuvpSYvz8hXQ3qbhmN0T+tWDSC8LRUql9aNpQ14JGIGwwJTB8nOV83
 IKYT1efXvxArFOfv+P/88aSKHu8Pxz3Tg/ErC/9VPpzKBUQOqf6mW7+C5EojKRDVVlVd
 ZWSPRZ1HCtnKYNaYpFO130uqbJ58ADcEyhrGHaGiZf7N/7JUGgdOCxeX65Wq05EjCnH8
 7Fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776986459; x=1777591259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sunHjT72rjHAhOEyPji1ubMQtWaRJTiTQvIp9Wuy0r0=;
 b=iAQsn2FFdnsRNvZqw7Bq8Vso/AwfkPRw9p/scz/ZvK2j6gZzPfROEy5hSARuiOc+80
 X2A+bR1zFWcQCf1ba5YK/9WVeIhf3rgvArmz3+NXgeLcoMNeQwWPq+LehpyRGjdMFP5T
 kDGKx6Bcc/wmGIiUiZZrjAguWIUrFlT2MJh5ozeDv2JrnG4p0QA0fjSpBKQtFAYHI8/Y
 3nyf/gT7n1Vr4hasSEAT79W31zEw2/e5039qA18Nn1nOQhcpTFDugCd01VQ2m5+FTC7l
 jyrb/CZZAVKCC1SMMN7qDfDqJ/sRiaWqnEWJMUe11OZiYT3KAHYeuqDxs5P3jCM5vkNB
 lNTA==
X-Gm-Message-State: AOJu0YxyZDsA46ycq4pRHaUias2paIEmFBieTH9BHgTnEThY+GVMNf7e
 tyK84OtPpCoSa0IFGZ81b5zUFtI9RJzGllpV1eRoXQ5poKhP4/gtoRvC816YnnHFpDZ+xUpkgLB
 M6uvtvqQu03tQiXgpyl/K6YLx8zDTIbY=
X-Gm-Gg: AeBDieviLjT3QhFcu5nb8LGzoszsIWBgE65zOxsf5jgZgya6xw5QCW0UwLyDSrBaL+m
 4Z7U1NnxSPybI1TRxuYb6CkQp4V0s6GqxuY5jOEEwwtuKlA/fRc4ZTLvv9FtBy7wasZwMwDUb+S
 UIbPrdGi6izNXIL6uEpGv7QdqNXey7F6ex7icbFcHRI7u+6CpIf+9+hhp2Ofcqy55cCOoLEbS86
 hHp7OnOK7ergQI05RM4seG+rXhyt1AC6Edf5mtGu5WvL9plnlZ76L8GXC9j2Ezki8M8HTIpooZP
 9oHo/bgUtqPxeZyDy3ggNqatvL7kOGtJD81rOcAh6oGoNpWF
X-Received: by 2002:a17:907:94c5:b0:ba9:c0cb:f951 with SMTP id
 a640c23a62f3a-ba9c0cc0a0emr731330466b.48.1776986459074; Thu, 23 Apr 2026
 16:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260423094856.270215-1-cohuck@redhat.com>
In-Reply-To: <20260423094856.270215-1-cohuck@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 23 Apr 2026 19:20:46 -0400
X-Gm-Features: AQROBzDOjtv6agDs93jYFqblIaTHof0f1imBR3BqCRA6hbimMkErRurR3W4L5Tk
Message-ID: <CAJSP0QWFK9noq+CRRG4E1DM4HSyaHxHqmZytqzUHnu-_VsRjUA@mail.gmail.com>
Subject: Re: [PULL 00/11] 11.1 compat machines and s390x updates
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a9f49d065028e619"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x635.google.com
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

--000000000000a9f49d065028e619
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 5:50=E2=80=AFAM Cornelia Huck <cohuck@redhat.com> w=
rote:

> The following changes since commit
> 98b060da3a4f92b2a994ead5b16a87e783baf77c:
>
>   Update version for v11.0.0 release (2026-04-21 16:28:47 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/cohuck/qemu tags/s390x-20260423
>
> for you to fetch changes up to 83f5164d25634f9104b5fb4a6772766ae646ad59:
>
>   hw/s390x/ccw: Disable legacy virtio-pci by default (v11.1+) (2026-04-22
> 11:28:03 +0200)
>
> ----------------------------------------------------------------
> First batch of updates for 11.1:
> - compat machines for 11.1
> - s390x: simplifications, cleanups, and a new test
>

Hi Cornelia,
There is an s390x timeout regression in this pull request that reproduces
both in the CI and locally:

$ make check-functional-s390x
13/13 qemu:func-thorough+func-s390x-thorough+thorough /
func-s390x-ccw_virtio         TIMEOUT        420.07s   killed by signal 15
SIGTERM
>>> MESON_TEST_ITERATION=3D1
QEMU_TEST_QEMU_BINARY=3D/home/stefanha/qemu/build/qemu-system-s390x
ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1
QEMU_TEST_QEMU_IMG=3D/home/stefanha/qemu/build/qemu-img
LD_LIBRARY_PATH=3D/home/stefanha/qemu/build/tests/tcg/plugins:/home/stefanh=
a/qemu/build/contrib/plugins
RUST_BACKTRACE=3D1
UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:prin=
t_stacktrace=3D1
PYTHONPATH=3D/home/stefanha/qemu/python:/home/stefanha/qemu/tests/functiona=
l
QEMU_TEST_GDB=3D/usr/bin/gdb MALLOC_PERTURB_=3D1
MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print=
_stacktrace=3D1
MESON_BUILD_ROOT=3D/home/stefanha/qemu/build G_TEST_SLOW=3D1
/home/stefanha/qemu/build/pyvenv/bin/python3
/home/stefanha/qemu/tests/functional/s390x/test_ccw_virtio.py

Please send a v2 pull request with the issue resolved. Thanks!

Stefan


>
> ----------------------------------------------------------------
>
> Cornelia Huck (1):
>   hw: add compat machines for 11.1
>
> Eric Farman (1):
>   MAINTAINERS: Update s390 trees
>
> Jaehoon Kim (1):
>   hw/s390x/ccw: Disable legacy virtio-pci by default (v11.1+)
>
> Philippe Mathieu-Daud=C3=A9 (6):
>   target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (cpu)
>   target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (mmu)
>   target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (tcg)
>   target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (kvm)
>   configs/targets: Restrict the legacy ldst_phys() API on s390x target
>   target/s390x: Prefer MO_128 definition over magic value
>
> Thomas Huth (2):
>   target/s390x/kvm: Simplify the async pfault handling code
>   tests/functional/s390x: Add test for booting from a disk with 4k
>     sectors
>
>  MAINTAINERS                            |   6 +-
>  configs/targets/s390x-softmmu.mak      |   1 +
>  hw/arm/virt.c                          |   9 +-
>  hw/core/machine.c                      |   3 +
>  hw/i386/pc.c                           |   3 +
>  hw/i386/pc_piix.c                      |  13 ++-
>  hw/i386/pc_q35.c                       |  13 ++-
>  hw/m68k/virt.c                         |   9 +-
>  hw/ppc/spapr.c                         |  15 ++-
>  hw/s390x/s390-virtio-ccw.c             |  40 ++++++-
>  include/hw/core/boards.h               |   3 +
>  include/hw/i386/pc.h                   |   3 +
>  target/s390x/cpu-system.c              |   2 +-
>  target/s390x/kvm/kvm.c                 |  64 ++++--------
>  target/s390x/mmu_helper.c              |   5 +-
>  target/s390x/tcg/excp_helper.c         |  21 ++--
>  target/s390x/tcg/mem_helper.c          |  12 ++-
>  target/s390x/tcg/translate_vx.c.inc    |   2 +-
>  tests/functional/s390x/meson.build     |   1 +
>  tests/functional/s390x/test_boot_4k.py | 138 +++++++++++++++++++++++++
>  20 files changed, 287 insertions(+), 76 deletions(-)
>  create mode 100755 tests/functional/s390x/test_boot_4k.py
>
> --
> 2.53.0
>
>
>

--000000000000a9f49d065028e619
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Apr 23, 2026 at 5:50=E2=80=AFAM Corne=
lia Huck &lt;<a href=3D"mailto:cohuck@redhat.com">cohuck@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The foll=
owing changes since commit 98b060da3a4f92b2a994ead5b16a87e783baf77c:<br>
<br>
=C2=A0 Update version for v11.0.0 release (2026-04-21 16:28:47 +0100)<br>
<br>
are available in the Git repository at:<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/cohuck/qemu" rel=3D"noreferrer" target=
=3D"_blank">https://gitlab.com/cohuck/qemu</a> tags/s390x-20260423<br>
<br>
for you to fetch changes up to 83f5164d25634f9104b5fb4a6772766ae646ad59:<br=
>
<br>
=C2=A0 hw/s390x/ccw: Disable legacy virtio-pci by default (v11.1+) (2026-04=
-22 11:28:03 +0200)<br>
<br>
----------------------------------------------------------------<br>
First batch of updates for 11.1:<br>
- compat machines for 11.1<br>
- s390x: simplifications, cleanups, and a new test<br></blockquote><div><br=
></div><div>Hi Cornelia,</div><div>There is an s390x timeout regression in =
this pull request that reproduces both in the CI and locally:</div><div><br=
></div><div>$ make=C2=A0check-functional-s390x</div><div>13/13 qemu:func-th=
orough+func-s390x-thorough+thorough / func-s390x-ccw_virtio =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 TIMEOUT =C2=A0 =C2=A0 =C2=A0 =C2=A0420.07s =C2=A0 killed by s=
ignal 15 SIGTERM<br>&gt;&gt;&gt; MESON_TEST_ITERATION=3D1 QEMU_TEST_QEMU_BI=
NARY=3D/home/stefanha/qemu/build/qemu-system-s390x ASAN_OPTIONS=3Dhalt_on_e=
rror=3D1:abort_on_error=3D1:print_summary=3D1 QEMU_TEST_QEMU_IMG=3D/home/st=
efanha/qemu/build/qemu-img LD_LIBRARY_PATH=3D/home/stefanha/qemu/build/test=
s/tcg/plugins:/home/stefanha/qemu/build/contrib/plugins RUST_BACKTRACE=3D1 =
UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:prin=
t_stacktrace=3D1 PYTHONPATH=3D/home/stefanha/qemu/python:/home/stefanha/qem=
u/tests/functional QEMU_TEST_GDB=3D/usr/bin/gdb MALLOC_PERTURB_=3D1 MSAN_OP=
TIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stackt=
race=3D1 MESON_BUILD_ROOT=3D/home/stefanha/qemu/build G_TEST_SLOW=3D1 /home=
/stefanha/qemu/build/pyvenv/bin/python3 /home/stefanha/qemu/tests/functiona=
l/s390x/test_ccw_virtio.py</div><div><br></div><div>Please send a v2 pull r=
equest with the issue resolved. Thanks!</div><div><br></div><div>Stefan</di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
----------------------------------------------------------------<br>
<br>
Cornelia Huck (1):<br>
=C2=A0 hw: add compat machines for 11.1<br>
<br>
Eric Farman (1):<br>
=C2=A0 MAINTAINERS: Update s390 trees<br>
<br>
Jaehoon Kim (1):<br>
=C2=A0 hw/s390x/ccw: Disable legacy virtio-pci by default (v11.1+)<br>
<br>
Philippe Mathieu-Daud=C3=A9 (6):<br>
=C2=A0 target/s390x: Replace legacy ld/st_phys -&gt; address_space_ld/st (c=
pu)<br>
=C2=A0 target/s390x: Replace legacy ld/st_phys -&gt; address_space_ld/st (m=
mu)<br>
=C2=A0 target/s390x: Replace legacy ld/st_phys -&gt; address_space_ld/st (t=
cg)<br>
=C2=A0 target/s390x: Replace legacy ld/st_phys -&gt; address_space_ld/st (k=
vm)<br>
=C2=A0 configs/targets: Restrict the legacy ldst_phys() API on s390x target=
<br>
=C2=A0 target/s390x: Prefer MO_128 definition over magic value<br>
<br>
Thomas Huth (2):<br>
=C2=A0 target/s390x/kvm: Simplify the async pfault handling code<br>
=C2=A0 tests/functional/s390x: Add test for booting from a disk with 4k<br>
=C2=A0 =C2=A0 sectors<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
=C2=A0configs/targets/s390x-softmmu.mak=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01=
 +<br>
=C2=A0hw/arm/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +-<br>
=C2=A0hw/core/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +<br>
=C2=A0hw/i386/pc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
=C2=A0hw/i386/pc_piix.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 13 ++-<br>
=C2=A0hw/i386/pc_q35.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 13 ++-<br>
=C2=A0hw/m68k/virt.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A09 +-<br>
=C2=A0hw/ppc/spapr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 15 ++-<br>
=C2=A0hw/s390x/s390-virtio-ccw.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 40 ++++++-<br>
=C2=A0include/hw/core/boards.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
=C2=A0include/hw/i386/pc.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A03 +<br>
=C2=A0target/s390x/cpu-system.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0target/s390x/kvm/kvm.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 64 ++++--------<br>
=C2=A0target/s390x/mmu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A05 +-<br>
=C2=A0target/s390x/tcg/excp_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 21 ++--<br>
=C2=A0target/s390x/tcg/mem_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 12 ++-<br>
=C2=A0target/s390x/tcg/translate_vx.c.inc=C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<b=
r>
=C2=A0tests/functional/s390x/meson.build=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01=
 +<br>
=C2=A0tests/functional/s390x/test_boot_4k.py | 138 ++++++++++++++++++++++++=
+<br>
=C2=A020 files changed, 287 insertions(+), 76 deletions(-)<br>
=C2=A0create mode 100755 tests/functional/s390x/test_boot_4k.py<br>
<br>
-- <br>
2.53.0<br>
<br>
<br>
</blockquote></div></div>

--000000000000a9f49d065028e619--

