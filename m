Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F27CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN4M3-00020J-Fa; Wed, 13 May 2026 03:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wN4Lv-0001xl-5b
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:50:00 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wN4Ls-00046C-W9
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:49:58 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso4609902eec.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 00:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778658594; cv=none;
 d=google.com; s=arc-20240605;
 b=jSnuYJmtoq0Q8JhebvG2j3DRXwdPJRVnTL2QRbg9e61GGwKojMzgCLJ7C5sY/Op+li
 tXjaOgFxmng/vaBIJxFSq5DmZmDyhDFLq5s5UTRaah2WHQrWbGpUXflMO552jIiTS+NT
 O6lI9PGyqQwHHBK2MFgrwh4pax4ML0vpru6dY6kX8JgWmuxLOKIH6NzD3DshAbyK5i1l
 Hu3B15jtuIAac2Fs9bIZ+3RdplXGc/5HxcAcEGzSKLPqG0N2O+vNogFEnTY1JDVZitwc
 826vvoc4XxFROBvQQATebSTD5h7tLJluHDIBYR4dg9/cFJBSWD6XhYavga8YUznyhUCB
 o9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/kFzL6D9qE9RNDpFQ+ZWN/C0mU/Tx12PGGFWuSCkpv8=;
 fh=pQfrUsPvuHwuGmXnByWlUoSLEsSGHDyjQSnThozXPak=;
 b=IzwinLyLcInS3i2+oiOGMFjpKEHWLJdsEg9Fy649m5miBLCnCDW1Nq1OHjSCipf+CC
 x++bpX9an2w8zFnuUfOcczNTwmiuX+urF8QDeMs/O49lUUEDuGbra3nfHoLVNwrSYY2p
 rUnHOZMjwGy8BXy4PsB72XkqlQSs0b3fWcrrOcBI0ZsF/+LYjF1FjZMlaB5vOz4c0T3Y
 ZNBZXILbPfIwn0/p4caf4NIDs9G13H9BsFPnUmBuIzu7AoiTeby+hlj0OQGPmnRdPCyk
 78E8EIyJXdq9HXM1ep0frt9PVIjvLD4Hlao6LiXpiWV0fdOiALLTg8ct3ZoHiw+oKsT2
 xWew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778658594; x=1779263394; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/kFzL6D9qE9RNDpFQ+ZWN/C0mU/Tx12PGGFWuSCkpv8=;
 b=WeBXJWjt2ijDwQRJa6SWBv7Py/vrC3QVEd7I897B+a0C8x7YlSCJJFlPIN/VTjwRgP
 BjXHrYNQe+U4kPUvPmDXutdUgO2JRZxsyQujWCmdn660oefFxz+uz1IxsIuIXbAtJZao
 girq8tMJ7o+Wg8wgCC2DvDgDd6648qf6/rFXRc2RWaEhSOMu6fSjLCBejPjKyK7bspsv
 +feeOyF9U3YdVQrWFP4oz38BL8wPY0X/E0uA/SOTnKcsabL+Itt/uoF9JklFlDpCBjOl
 mIhb5HNgBwn68r+ODlPbCV0ft9sMUt7tgXt22/cYvBOjev/2F3pV1H7vQb0MkYtGvwXL
 I8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778658594; x=1779263394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/kFzL6D9qE9RNDpFQ+ZWN/C0mU/Tx12PGGFWuSCkpv8=;
 b=R35Ha9Hi9WQP/Wjh5NJqmpuioVwaEid6LRyqHAxPlHU3uSAIBI582hJkYILaPnn6y9
 j5Yt8nYa/azxRkLePlkH9cyoXBHX7iyMO56xmJFTGpICnQx6GXX5YFFU6w+FLZptByIA
 /ljo+bsubMPTFlI7/VulZ+6VQajeXUSbHR3UuSpg7WtnHaY9JGaul4AmzzXTVcuaUIe5
 zAMFvxfkNzrGDKJ1eAOLZHZ+4hs7v3RjLg1/oXUNC/K35korhuktUM1kexIUvibLNEpZ
 4jxtK/JehXFJS02prHDZXvBC/rxPB7JtgO7hz3Kc5+1C3MRiYMxiFyK0oBxYt5mRxnkL
 cuKw==
X-Gm-Message-State: AOJu0YxdjAlr2rz/QhWRzPgz0GhGXe/es4l14S7GdrDnK9m13BYVUrH/
 Fy+NMSKqSvDQLWZCcPrdp63cd2Fo49k1B2Zn1ZIC0wunahoi33O+9bRS16u7IynSy/XB3cdfe3j
 Dpa5dX2uISgOUWX5gRuoRiYkWWTi6E74=
X-Gm-Gg: Acq92OEStgl1Q6jUNAQIluVXeVMBlkg9CnL7v4payxjA10RjKHfkIopptnYqK8NzHSR
 ZnuKVllmCyVMjXvbIda1yrQYDohuRBwGox9GJlaoR4g3+Y9ZhtuZrLNt6yuE0AYnzPLKETKKFIH
 h/4hqEwKrCvuhEF1KuZ9Qx1/phix1vDtzON7qaau5DSglk/xpbhlJ3MK8TTykC/lgxrGzVnrl/1
 v7M9NrLsedXwqaOtLr9JEyazU9x/4FaXBcLNbvowLxtipUOHOMU2/QHqlO7MLYlTKD23kroYARy
 EipRQkj7N3aUnV6LJKEw9braWutqtg7SXSnrRCw=
X-Received: by 2002:a05:7300:5720:b0:2c1:7480:ff9b with SMTP id
 5a478bee46e88-2ff95e5e1cemr3461089eec.18.1778658593880; Wed, 13 May 2026
 00:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
 <CAJSP0QVw+GHOC9_mOcn+V6BHZe5BR1jQyDJ1GocGaqiB_GSoBw@mail.gmail.com>
In-Reply-To: <CAJSP0QVw+GHOC9_mOcn+V6BHZe5BR1jQyDJ1GocGaqiB_GSoBw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 13 May 2026 11:49:40 +0400
X-Gm-Features: AVHnY4KDvppL1dCNrx6dNHWBiGNcpLBTKVx-bs_R9Tgn8cA_yj10GCQOwAEtKRg
Message-ID: <CAJ+F1C+-cr+Sa557xLFcHhCEOsccUHAJSyjPF5E8sGULEKQPhA@mail.gmail.com>
Subject: Re: [PULL 00/24] Qom patches
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1332.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Stefan

On Wed, May 13, 2026 at 3:20=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Mon, May 11, 2026 at 4:21=E2=80=AFPM <marcandre.lureau@redhat.com> wro=
te:
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb574e=
953b:
> >
> >   Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qe=
mu into staging (2026-05-11 10:49:53 -0400)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/marcandre.lureau/qemu.git tags/qom-pull-request
> >
> > for you to fetch changes up to bc61a3209bf064826481a5f8f2b4feb47c70b02f=
:
> >
> >   target/s390x: add gen-features.h dependency to s390x_system_ss (2026-=
05-11 23:59:33 +0400)
> >
> > ----------------------------------------------------------------
> > QOM object lifecycle fixes
> >
> > ----------------------------------------------------------------
>
> Hi Marc-Andr=C3=A9,
> I'm not sure if this CI failure is related to this pull request, but
> there is a dbus-vnc issue:
>
> >>> ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1=
 QTEST_QEMU_VNC_BINARY=3D./tools/qemu-vnc/qemu-vnc MESON_TEST_ITERATION=3D1=
 PYTHON=3D/home/gitlab-runner/builds/P3MFS4LUf/0/qemu-project/qemu/build/py=
venv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-s=
torage-daemon G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/P3MFS4LUf/0/q=
emu-project/qemu/tests/dbus-daemon.sh QTEST_QEMU_IMG=3D./qemu-img QTEST_QEM=
U_BINARY=3D./qemu-system-x86_64 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_=
error=3D1:print_summary=3D1:print_stacktrace=3D1 RUST_BACKTRACE=3D1 MALLOC_=
PERTURB_=3D211 MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_su=
mmary=3D1:print_stacktrace=3D1 /home/gitlab-runner/builds/P3MFS4LUf/0/qemu-=
project/qemu/build/tests/qtest/dbus-vnc-test --tap -k
>
> 754/1075 /x86_64/dbus-vnc/password-auth -
> ERROR:../tests/qtest/dbus-vnc-test.c:621:test_dbus_vnc_password_auth:
> assertion failed (qemu_vnc1_server_get_auth(proxy) =3D=3D "vnc"): ("none"
> =3D=3D "vnc") FAIL
>
> https://gitlab.com/qemu-project/qemu/-/jobs/14337427774#L5512
>
> Any ideas?

Embarrassingly, I have no idea. Before org.qemu.vnc is exposed by
qemu-vnc (and the auth is checked by the test), qemu-vnc must have
started a VNC server successfully (vnc_display_new)..

Fwiw, the tests runs quite smoothly locally with meson test --repeat
1000  (some time out sometime, due to heavy load).

Let's mark/run it as QEMU_TEST_FLAKY_TESTS until I figure out?


>
> Stefan
>
> >
> > Marc-Andr=C3=A9 Lureau (23):
> >   hw/remote: check visit return in vfu_object_set_socket
> >   qom/object: update doc about NULL values in link properties
> >   hw/remote: guard listener unregister in finalize
> >   io/net-listener: move mutex init to instance_init
> >   net/colo-compare: guard finalize against uninitialized state
> >   ui/console: remove console from global list on finalization
> >   hw/i386/x86: free oem_id and oem_table_id on finalization
> >   hw/core/resetcontainer: free children array on finalization
> >   net/can: free ifname on socketcan finalization
> >   backends/igvm-cfg: free filename on finalization
> >   scsi/pr-manager-helper: free path on finalization
> >   accel/kvm: free device path on finalization
> >   system/qtest: add missing qtest_finalize()
> >   hw/fsi: move OPBus address space init to realize
> >   hw/fsi: move OPBus qbus_init() to instance_init
> >   hw/gpio/pca9552: fix state_str leak in pca955x_set_led
> >   hw/arm/aspeed: free fmc_model and spi_model on finalization
> >   hw/arm/sbsa-ref: free unrealized flash devices on finalization
> >   hw/arm/virt: free flash devices and OEM strings on finalization
> >   hw/ppc/pnv: drop extra ref on PHB after adding as child
> >   hw/riscv/virt: free flash devices and OEM strings on finalization
> >   meson: drop sphinx-build < 1.7 compatiblity check
> >   target/s390x: add gen-features.h dependency to s390x_system_ss
> >
> > Peter Xu (1):
> >   system/ioport: Fix qom-list-properties crash on portio list obj
> >
> >  docs/meson.build          | 14 +-------------
> >  include/qom/object.h      |  8 ++++----
> >  accel/kvm/kvm-all.c       |  8 ++++++++
> >  backends/igvm-cfg.c       |  1 +
> >  hw/arm/aspeed.c           |  9 +++++++++
> >  hw/arm/sbsa-ref.c         | 12 ++++++++++++
> >  hw/arm/virt.c             | 14 ++++++++++++++
> >  hw/core/resetcontainer.c  |  3 +++
> >  hw/fsi/aspeed_apb2opb.c   | 37 ++++++++++++++++++++++++-------------
> >  hw/gpio/pca9552.c         |  2 +-
> >  hw/i386/x86.c             |  9 +++++++++
> >  hw/ppc/pnv.c              |  1 +
> >  hw/remote/remote-obj.c    |  4 +++-
> >  hw/remote/vfio-user-obj.c |  4 +++-
> >  hw/riscv/virt.c           | 14 ++++++++++++++
> >  io/net-listener.c         |  9 ++++++++-
> >  net/can/can_socketcan.c   |  8 ++++++++
> >  net/colo-compare.c        | 31 +++++++++++++++----------------
> >  scsi/pr-manager-helper.c  |  1 +
> >  system/ioport.c           | 11 +++++++++--
> >  system/qtest.c            | 10 ++++++++++
> >  ui/console.c              |  5 ++++-
> >  target/s390x/meson.build  |  1 +
> >  23 files changed, 163 insertions(+), 53 deletions(-)
> >
> > --
> > 2.54.0
> >
> >
>

