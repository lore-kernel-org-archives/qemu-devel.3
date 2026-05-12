Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1867CCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 23:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMwOI-0008A6-Fl; Tue, 12 May 2026 19:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wMwOF-00089v-82
 for qemu-devel@nongnu.org; Tue, 12 May 2026 19:19:51 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wMwOD-00017F-Ck
 for qemu-devel@nongnu.org; Tue, 12 May 2026 19:19:50 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bd2e8931915so199256566b.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 16:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778627987; cv=none;
 d=google.com; s=arc-20240605;
 b=MVxAC5C+m0OuCPZJUiSIl27jG9ZIS3WeaYvVWAIIMkJR8PbWvEppM2xKmIj9VUACsv
 tSj6zcEflPSv7o5oZCBBm5Esheh7lBhGa9DSm42sCu2bBiQQ1pO/NbGTHsWOHU+nfGg7
 Ptww4Axx4H8PswIUoIIvosxVWBdoDO/JYZWFL/06TQGzVnAi8absZlbOg8R6viXMk2Ct
 iUbLj4RGndz4N8ZuoahA4BwOLRYgDft79ED8bJi+gcMFVTIhPyHVYlouV6gVAOI9uLiC
 0v0F7IJ/4plwUyW4f8va9WwTRsCe3n+OhANp3YuEMaGd3nwvdymhbxMvir3zETIuWK6L
 RC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x91go3p3VWjB2inSAggxXEB6ysyXGbtQFiavM72zwgs=;
 fh=zRgc5xzNSs1AAdQsbexii2liNpOwvH6igPx1QTv2Phw=;
 b=fYg/aMtHzkTBL2gqMOzSrGom+sSqCnaTu044v8Nqzz+gu6H/iV6PxN7H//6XGjUj6y
 Ig9d6cGRal5GA0ljgo1LLe3N0La9DpYQHULAfGhBrB0bjr8QSAnhDn5lEgkpYlusSZgG
 i7+DaCYpXf072Btd8244ILfj++ujoUE237j3XkKClRMuHqNbubffQXItgOzmiQ82CFdc
 o3ni19TQEC9TKvVWST8LqTglyCW12f4kzXakSpp8t5it/1hGh3zSBFLtg5Pfin9BuxOv
 iFTf3XA1E6fnEJ/yhdZwsqPQBK0OTMdqux1dL0M3rHcEmzKBWcprLxvdm4M0vUY8lOKc
 aB+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778627987; x=1779232787; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x91go3p3VWjB2inSAggxXEB6ysyXGbtQFiavM72zwgs=;
 b=FAsNeiTAfuReqnfyoUPVldbttb5W7yz6NuUTmhpisNa/flvFlLl95RVzINwFV5bOxA
 mImdkn3Q4fqJf6YZIPEHOAeGkTzo4IqtsEHBvHGwiOulZfNuzGosAaIsQe6A8jZ3Pgx1
 9xUnE0vO7WRvYiRbtWc5UpKXtHSsgye1K5ccuud1lyHjgHrBqe5ZQJCQAGxEXc1Yy9nw
 axtIKI4+JOn47TPW3AgASIe59YBMzknbseUlsZXCG1e6BmqCqJByV2xHxKow580a6j+r
 t9/FuL4M4sxHp36xIk61zb7o+wXMYDym7isVIfTENzKLHfEGq4Zsh46Y50l1fKM17z+n
 QBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778627987; x=1779232787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x91go3p3VWjB2inSAggxXEB6ysyXGbtQFiavM72zwgs=;
 b=jgcswmJHV9tC51fWQCaqij4LAHblCAj4AYEZnOWmWGp0HFA9n794/AD8cEAzJHQDtn
 fUg/31ibARqcp20Zav97BOvV7gFxLq5GxSl8XpRrm4e9tbV6LQJdNF72qyjzZq9ploct
 VcpiEBegq9tMCfzlRCGRvyh+3Y1c/Mf/FqjGqSRpKlfl5WjhA1DVhWbh+d8rZf393D9e
 kaAF7UXHym+pGqk36uoMH60Vzfpl2fXioc7E+bWj9zK8La/pbTLMT8wcWP357H5owRN6
 QGb4oqorWvVb/KIEYDtFISKixfO8ht+3wxNXa66D7fCbhPPaQSIbtuJvORl8usk8MSyq
 tXQQ==
X-Gm-Message-State: AOJu0YyPjbxa0He+83XgpaTG0OjTYuW7SmRrT/xPmq/nCVBku2u7NL7e
 xsYNfVNJfE1n80cZECgjumVC1xKvgVjT1K5ImfM+aBJOITcHGoGC/cuGQuXSApu5Ss7SSxqwww4
 9rK1sdrW7T7WCANWYBU4vb8/tcCrhEg0=
X-Gm-Gg: Acq92OHFTcJSRjgeIg2qaGpVi958RXWxn8SxrYpOA0ZWzMKWCnr2V2yRgxfLJhlL8RW
 R8S3fDHYa0gxJRzGVdDBYzlsrYXrfOUuPRYrF8/W61VnaDFv2drBUTMM5wODExn3jAlyrap6uPT
 EDChbg162pSqMKBu69ORjWtFNIG/mE2lsKGKuqS2i0+bkXQDoQQTeVt4nCPbjSdsJ8OrSz6JkGW
 bG78u7bHSL8Gj1/Y31TpUZgG9NhfJbXsnZG10c++Vj5iTsxMLbORq7UWDPL8XHTf1V0XxsyqA8n
 VAFUPALpraU2bw7TDiYGDztoYAI32q7S3sMuevBQvfI/uzS1
X-Received: by 2002:a17:907:3f89:b0:bd2:3726:79f4 with SMTP id
 a640c23a62f3a-bd237b6d3b2mr350180266b.0.1778627987021; Tue, 12 May 2026
 16:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
In-Reply-To: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 May 2026 19:19:33 -0400
X-Gm-Features: AVHnY4KvmUpr_Z5xnoByPKeZ9gq-vKG0MAn_fACn-trgVU-EuyL5IyaRH_v0oZg
Message-ID: <CAJSP0QVw+GHOC9_mOcn+V6BHZe5BR1jQyDJ1GocGaqiB_GSoBw@mail.gmail.com>
Subject: Re: [PULL 00/24] Qom patches
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x630.google.com
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

On Mon, May 11, 2026 at 4:21=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb574e95=
3b:
>
>   Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu=
 into staging (2026-05-11 10:49:53 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/qom-pull-request
>
> for you to fetch changes up to bc61a3209bf064826481a5f8f2b4feb47c70b02f:
>
>   target/s390x: add gen-features.h dependency to s390x_system_ss (2026-05=
-11 23:59:33 +0400)
>
> ----------------------------------------------------------------
> QOM object lifecycle fixes
>
> ----------------------------------------------------------------

Hi Marc-Andr=C3=A9,
I'm not sure if this CI failure is related to this pull request, but
there is a dbus-vnc issue:

>>> ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 Q=
TEST_QEMU_VNC_BINARY=3D./tools/qemu-vnc/qemu-vnc MESON_TEST_ITERATION=3D1 P=
YTHON=3D/home/gitlab-runner/builds/P3MFS4LUf/0/qemu-project/qemu/build/pyve=
nv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-sto=
rage-daemon G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/P3MFS4LUf/0/qem=
u-project/qemu/tests/dbus-daemon.sh QTEST_QEMU_IMG=3D./qemu-img QTEST_QEMU_=
BINARY=3D./qemu-system-x86_64 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_er=
ror=3D1:print_summary=3D1:print_stacktrace=3D1 RUST_BACKTRACE=3D1 MALLOC_PE=
RTURB_=3D211 MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summ=
ary=3D1:print_stacktrace=3D1 /home/gitlab-runner/builds/P3MFS4LUf/0/qemu-pr=
oject/qemu/build/tests/qtest/dbus-vnc-test --tap -k

754/1075 /x86_64/dbus-vnc/password-auth -
ERROR:../tests/qtest/dbus-vnc-test.c:621:test_dbus_vnc_password_auth:
assertion failed (qemu_vnc1_server_get_auth(proxy) =3D=3D "vnc"): ("none"
=3D=3D "vnc") FAIL

https://gitlab.com/qemu-project/qemu/-/jobs/14337427774#L5512

Any ideas?

Stefan

>
> Marc-Andr=C3=A9 Lureau (23):
>   hw/remote: check visit return in vfu_object_set_socket
>   qom/object: update doc about NULL values in link properties
>   hw/remote: guard listener unregister in finalize
>   io/net-listener: move mutex init to instance_init
>   net/colo-compare: guard finalize against uninitialized state
>   ui/console: remove console from global list on finalization
>   hw/i386/x86: free oem_id and oem_table_id on finalization
>   hw/core/resetcontainer: free children array on finalization
>   net/can: free ifname on socketcan finalization
>   backends/igvm-cfg: free filename on finalization
>   scsi/pr-manager-helper: free path on finalization
>   accel/kvm: free device path on finalization
>   system/qtest: add missing qtest_finalize()
>   hw/fsi: move OPBus address space init to realize
>   hw/fsi: move OPBus qbus_init() to instance_init
>   hw/gpio/pca9552: fix state_str leak in pca955x_set_led
>   hw/arm/aspeed: free fmc_model and spi_model on finalization
>   hw/arm/sbsa-ref: free unrealized flash devices on finalization
>   hw/arm/virt: free flash devices and OEM strings on finalization
>   hw/ppc/pnv: drop extra ref on PHB after adding as child
>   hw/riscv/virt: free flash devices and OEM strings on finalization
>   meson: drop sphinx-build < 1.7 compatiblity check
>   target/s390x: add gen-features.h dependency to s390x_system_ss
>
> Peter Xu (1):
>   system/ioport: Fix qom-list-properties crash on portio list obj
>
>  docs/meson.build          | 14 +-------------
>  include/qom/object.h      |  8 ++++----
>  accel/kvm/kvm-all.c       |  8 ++++++++
>  backends/igvm-cfg.c       |  1 +
>  hw/arm/aspeed.c           |  9 +++++++++
>  hw/arm/sbsa-ref.c         | 12 ++++++++++++
>  hw/arm/virt.c             | 14 ++++++++++++++
>  hw/core/resetcontainer.c  |  3 +++
>  hw/fsi/aspeed_apb2opb.c   | 37 ++++++++++++++++++++++++-------------
>  hw/gpio/pca9552.c         |  2 +-
>  hw/i386/x86.c             |  9 +++++++++
>  hw/ppc/pnv.c              |  1 +
>  hw/remote/remote-obj.c    |  4 +++-
>  hw/remote/vfio-user-obj.c |  4 +++-
>  hw/riscv/virt.c           | 14 ++++++++++++++
>  io/net-listener.c         |  9 ++++++++-
>  net/can/can_socketcan.c   |  8 ++++++++
>  net/colo-compare.c        | 31 +++++++++++++++----------------
>  scsi/pr-manager-helper.c  |  1 +
>  system/ioport.c           | 11 +++++++++--
>  system/qtest.c            | 10 ++++++++++
>  ui/console.c              |  5 ++++-
>  target/s390x/meson.build  |  1 +
>  23 files changed, 163 insertions(+), 53 deletions(-)
>
> --
> 2.54.0
>
>

