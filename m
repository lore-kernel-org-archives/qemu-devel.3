Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7364CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 19:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNEsj-0006po-9x; Wed, 13 May 2026 15:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wNEsc-0006pU-UY
 for qemu-devel@nongnu.org; Wed, 13 May 2026 15:04:27 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wNEsa-0001Bd-Uj
 for qemu-devel@nongnu.org; Wed, 13 May 2026 15:04:26 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-67c4aaf76ecso704283a12.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 12:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778699063; cv=none;
 d=google.com; s=arc-20240605;
 b=KnrVFTwqk9NqCGfC0eP1sv/clXLGoD+zGdZaubRRbfA1d24FNFEm2Hdo5masP8ZHRH
 5bYNw3xE8Go+IoiWly3CKKRAMd/gm3OCL9dWQLD/o1kZqgdqFiEB7zhx402213cvnKeH
 IDKD9ja/q6Q0AAdlmj/opU2cCAvTkuGaa1NC2yX3lyFUZYcqDlFQ7N9gvd+9PrmWtZki
 SwP9hPB6R45dDAzEYVXgYVYReSzcwipJvdZ3GHE7AF9nIrXiVo87gwBFlBtXmL8CJBeJ
 lXNmcobgklWmbvGba2PtbIQGyIIO40B1oDZ21k3YjZb4XLKWh44KSsPGtXVOQqPGCmhR
 6bNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CQCxF4oejo/BPt3zKjEa9oNaTXDZkLCA8k3cTamlkzE=;
 fh=2JT3TBmF0Tc/p6Wfzw7XGdyOLg9FkenCG4d1TATE9mw=;
 b=PYz4uzQqm2iKzRXNiMvEAP58Gfqo7i1sKNGN2x5l6BH3MUFGApPrLPy6WKkXtBAzTY
 7Byyb5QeY6aBN3Jr3zUmA1UORC11o9MmQNH9rwJ6l3pkHuokt+jVvfp39NfGriFOr+6J
 gkTDdvDt2nq1AKXVd44dk9HYYpcNZNZIx68HWdW/nz2jnct0e8iJv1HwoxeMLGu4UsG8
 OR+fsi5OMTkXTKcBGPqJUeJek5dUf2wUZIYZQv56Ea+IpVMlpinMfzQUDQATHj3eE0HV
 +Ys7QuVI/n0a72BNUGfTkbQZ9ZcBsdH6FDUVWkd8mizGq3kHvo6HA0tj4Spmdm0oMUxX
 +1VA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778699063; x=1779303863; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQCxF4oejo/BPt3zKjEa9oNaTXDZkLCA8k3cTamlkzE=;
 b=FVHFgCSgjNKj1G2i9XdM+g1hMmuAlWCSrx/gl5AKuMQG2g2B8eQolmaQZLPsJNBLf/
 m8f12ama6gnW7yfhe1Jb86C2LSOte/2DppeW0LkeMWh0jHNhfGFOdRir1kXfEB+xlzRa
 MeMJ5kiGVq1JvRJZpy1NEcg1b39zf1gxcvihMRoLPh1Ras2Xwqfe0o4E8bY950IIAid/
 pyH5fXOVhAl9LkveNBihNVpvSXETaWUVmYsKa9Dx2480u3YX1PNrO+IDrC1u6QhFi5tm
 Izo30wohjuFtvoUwj/amQwb5CCpHy110m8O1kWbb0ZUplvU09co6i9I0YROmW3fwhrzj
 FOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778699063; x=1779303863;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CQCxF4oejo/BPt3zKjEa9oNaTXDZkLCA8k3cTamlkzE=;
 b=RazZsAXIti6cHg3LOGAKFQ3LUMVSNAt4JehjM3wF4UD0NOd8ewALjU/Y+aIy2SzdJv
 YtvcWYNUbyPyqEJ/716O25bTbwyJhGiM7wlIZa8avd/+j/REN8gXwoL1A+GwZTsdXjlK
 7pH/I3KHvvg8t8kM+PrswH7l8b0DWGxo8HjHfmu8YadB4KDzWDQYXVYMh2BznGhoKCAg
 +BzvdTd5LJBB488BwC/j2sfzKHMyeWYNFRmpR8P1D36NqNE5yVbktCcoKumlmg8Rz/9f
 IT/d/6jkmKkYWeQPy4kfU2tPfear7EVwBNSuXBSnAN+Ber7qgW1RttFs1qKq3jMb5kp/
 mJdw==
X-Gm-Message-State: AOJu0YxQTbBtaAEKqFisrCDx/f8II8qc0qVYaRssBLkhJIzGTDns+7gZ
 ICIaueCIO9+HsxGAldZzelwsKmeTzdNhnOu72W27PvBuOYwR4N1mp3CEsEvDxY99BCqbXPGxs/0
 xBkkxOmawWA0xJ2TIiexuV7XpM52ln3E=
X-Gm-Gg: Acq92OGNLhZNvqaYbBKEXNuQrQjwsyEEkFtA1G4Aa78KC/l31L7wdknUIuA8vm56NWC
 UrkH0k/oSjZjSAu/9K6FxOhwzazZxQCxy0YkOxl79q9B9HsMd2cT1/mb5uNJyf7jhMtylDeiqrC
 ZpzYeXmVQWQeBUQN19qmJkgZnUJ6T3FgzZYpqTlJCN8t4yzCqTmO/G5MOqdDxuFTfvRyjBPNXP9
 k0W/iIBTGF4lHNou4Z8BsPme1MSZdF02nYhtvq7/oiZR65E+P1CKqaeEX/qwee4wWCGQ/EApoyx
 muHzJ9HRYKPeyxlTrvQM/Y4Ku7iLagRK2FSTZENt
X-Received: by 2002:a05:6402:2742:b0:678:a507:e837 with SMTP id
 4fb4d7f45d1cf-682a6e037a2mr2542645a12.1.1778699063080; Wed, 13 May 2026
 12:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
 <CAJSP0QVw+GHOC9_mOcn+V6BHZe5BR1jQyDJ1GocGaqiB_GSoBw@mail.gmail.com>
 <CAJ+F1C+-cr+Sa557xLFcHhCEOsccUHAJSyjPF5E8sGULEKQPhA@mail.gmail.com>
In-Reply-To: <CAJ+F1C+-cr+Sa557xLFcHhCEOsccUHAJSyjPF5E8sGULEKQPhA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 13 May 2026 15:04:10 -0400
X-Gm-Features: AVHnY4IT0h0EhwPFxhZDJSlR0S5uZyIsKa0IgZCd7x8UL6te_C1zwCD2vG4Y4p8
Message-ID: <CAJSP0QVgGW74x4o3EfY09g0ErgoGvwBhck4iNC7RDe+9CC9zOw@mail.gmail.com>
Subject: Re: [PULL 00/24] Qom patches
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, May 13, 2026 at 3:49=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi Stefan
>
> On Wed, May 13, 2026 at 3:20=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.c=
om> wrote:
> >
> > On Mon, May 11, 2026 at 4:21=E2=80=AFPM <marcandre.lureau@redhat.com> w=
rote:
> > >
> > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > >
> > > The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb57=
4e953b:
> > >
> > >   Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/=
qemu into staging (2026-05-11 10:49:53 -0400)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://gitlab.com/marcandre.lureau/qemu.git tags/qom-pull-request
> > >
> > > for you to fetch changes up to bc61a3209bf064826481a5f8f2b4feb47c70b0=
2f:
> > >
> > >   target/s390x: add gen-features.h dependency to s390x_system_ss (202=
6-05-11 23:59:33 +0400)
> > >
> > > ----------------------------------------------------------------
> > > QOM object lifecycle fixes
> > >
> > > ----------------------------------------------------------------
> >
> > Hi Marc-Andr=C3=A9,
> > I'm not sure if this CI failure is related to this pull request, but
> > there is a dbus-vnc issue:
> >
> > >>> ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=
=3D1 QTEST_QEMU_VNC_BINARY=3D./tools/qemu-vnc/qemu-vnc MESON_TEST_ITERATION=
=3D1 PYTHON=3D/home/gitlab-runner/builds/P3MFS4LUf/0/qemu-project/qemu/buil=
d/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qe=
mu-storage-daemon G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/P3MFS4LUf=
/0/qemu-project/qemu/tests/dbus-daemon.sh QTEST_QEMU_IMG=3D./qemu-img QTEST=
_QEMU_BINARY=3D./qemu-system-x86_64 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort=
_on_error=3D1:print_summary=3D1:print_stacktrace=3D1 RUST_BACKTRACE=3D1 MAL=
LOC_PERTURB_=3D211 MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:prin=
t_summary=3D1:print_stacktrace=3D1 /home/gitlab-runner/builds/P3MFS4LUf/0/q=
emu-project/qemu/build/tests/qtest/dbus-vnc-test --tap -k
> >
> > 754/1075 /x86_64/dbus-vnc/password-auth -
> > ERROR:../tests/qtest/dbus-vnc-test.c:621:test_dbus_vnc_password_auth:
> > assertion failed (qemu_vnc1_server_get_auth(proxy) =3D=3D "vnc"): ("non=
e"
> > =3D=3D "vnc") FAIL
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/14337427774#L5512
> >
> > Any ideas?
>
> Embarrassingly, I have no idea. Before org.qemu.vnc is exposed by
> qemu-vnc (and the auth is checked by the test), qemu-vnc must have
> started a VNC server successfully (vnc_display_new)..
>
> Fwiw, the tests runs quite smoothly locally with meson test --repeat
> 1000  (some time out sometime, due to heavy load).
>
> Let's mark/run it as QEMU_TEST_FLAKY_TESTS until I figure out?

If it helps, your last ui pull request seems to be the first
occurrence of this failure:
https://gitlab.com/qemu-project/qemu/-/commit/5e61afe211e82a9af15a8794a0bd2=
9bb574e953b

If you'd like me to run CI on a test branch, just let me know.

Stefan

>
>
> >
> > Stefan
> >
> > >
> > > Marc-Andr=C3=A9 Lureau (23):
> > >   hw/remote: check visit return in vfu_object_set_socket
> > >   qom/object: update doc about NULL values in link properties
> > >   hw/remote: guard listener unregister in finalize
> > >   io/net-listener: move mutex init to instance_init
> > >   net/colo-compare: guard finalize against uninitialized state
> > >   ui/console: remove console from global list on finalization
> > >   hw/i386/x86: free oem_id and oem_table_id on finalization
> > >   hw/core/resetcontainer: free children array on finalization
> > >   net/can: free ifname on socketcan finalization
> > >   backends/igvm-cfg: free filename on finalization
> > >   scsi/pr-manager-helper: free path on finalization
> > >   accel/kvm: free device path on finalization
> > >   system/qtest: add missing qtest_finalize()
> > >   hw/fsi: move OPBus address space init to realize
> > >   hw/fsi: move OPBus qbus_init() to instance_init
> > >   hw/gpio/pca9552: fix state_str leak in pca955x_set_led
> > >   hw/arm/aspeed: free fmc_model and spi_model on finalization
> > >   hw/arm/sbsa-ref: free unrealized flash devices on finalization
> > >   hw/arm/virt: free flash devices and OEM strings on finalization
> > >   hw/ppc/pnv: drop extra ref on PHB after adding as child
> > >   hw/riscv/virt: free flash devices and OEM strings on finalization
> > >   meson: drop sphinx-build < 1.7 compatiblity check
> > >   target/s390x: add gen-features.h dependency to s390x_system_ss
> > >
> > > Peter Xu (1):
> > >   system/ioport: Fix qom-list-properties crash on portio list obj
> > >
> > >  docs/meson.build          | 14 +-------------
> > >  include/qom/object.h      |  8 ++++----
> > >  accel/kvm/kvm-all.c       |  8 ++++++++
> > >  backends/igvm-cfg.c       |  1 +
> > >  hw/arm/aspeed.c           |  9 +++++++++
> > >  hw/arm/sbsa-ref.c         | 12 ++++++++++++
> > >  hw/arm/virt.c             | 14 ++++++++++++++
> > >  hw/core/resetcontainer.c  |  3 +++
> > >  hw/fsi/aspeed_apb2opb.c   | 37 ++++++++++++++++++++++++-------------
> > >  hw/gpio/pca9552.c         |  2 +-
> > >  hw/i386/x86.c             |  9 +++++++++
> > >  hw/ppc/pnv.c              |  1 +
> > >  hw/remote/remote-obj.c    |  4 +++-
> > >  hw/remote/vfio-user-obj.c |  4 +++-
> > >  hw/riscv/virt.c           | 14 ++++++++++++++
> > >  io/net-listener.c         |  9 ++++++++-
> > >  net/can/can_socketcan.c   |  8 ++++++++
> > >  net/colo-compare.c        | 31 +++++++++++++++----------------
> > >  scsi/pr-manager-helper.c  |  1 +
> > >  system/ioport.c           | 11 +++++++++--
> > >  system/qtest.c            | 10 ++++++++++
> > >  ui/console.c              |  5 ++++-
> > >  target/s390x/meson.build  |  1 +
> > >  23 files changed, 163 insertions(+), 53 deletions(-)
> > >
> > > --
> > > 2.54.0
> > >
> > >
> >

