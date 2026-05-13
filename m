Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B099CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 19:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNF4I-0001wn-6l; Wed, 13 May 2026 15:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wNF4F-0001wT-Ga
 for qemu-devel@nongnu.org; Wed, 13 May 2026 15:16:27 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wNF4D-0005UR-Fu
 for qemu-devel@nongnu.org; Wed, 13 May 2026 15:16:27 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-2c15849aa2cso9631269eec.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 12:16:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778699783; cv=none;
 d=google.com; s=arc-20240605;
 b=H8QKCOg6PMLI6U33t34wLOXi0LhfwBJLS64RpZhqenclG8i6FlZx0BspxfzFZkq1o/
 apJK0qo+wNHOFcDNFIyBArGwW9cUVOFB3/iXZCh4FgtQRqaUTgeP4O0XwaGrDqDFfn/T
 7/2wQtO5AdQPeWlkaNRCtWGkm9GiRRXbXD+PgbO1RdigYLrZiXSZUps41i31IjkfLWQs
 KRCBBZzfL1LckE9P3l4qQsAYOQ+urGOYkkSIXJ1ZuW8sCM+jVkAU81lEZ3GNLdzBJUno
 Nx7qHKqRMuSMu/emQkp1M+bWDPjjHqsWKvDVN7pzcqTrNr+lGey4xK+I7MkEuyEGC61Y
 VHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NdinE/aAtwwXOMyG/CdOceveOmEVKyKTZba7H4aUGwM=;
 fh=pQfrUsPvuHwuGmXnByWlUoSLEsSGHDyjQSnThozXPak=;
 b=W3xMWjgLE6vDK4vfQ7VhbMmvj6qi8/Rh42j/KGnm29rJfh57LCM1Swz8fbmNHXsOcR
 /6vmktKx0QWPJI3q6cNzLstgIJm6Bh6nORDlv55lNTaf0qV2whEmCKmgVowScNPO841X
 BVmGmKLhvtUKBzRBB6s+B9+ctCRPSEoRdKF1JdP5V35WnMp3F6qsq90+PHJE6iLihQkn
 YZp1cxioBX8KtTVWyY1Yabc797TahVMXMtCDAte57X7UR7PgapPgP5sHngBww0B8YU9s
 bdngN+4h1Gdx1VX7bd6TXl8KKPjAM6ADfcHBMjXyetGWsOV/xFv0lGp/70sNpf+tukKd
 Pe/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778699783; x=1779304583; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdinE/aAtwwXOMyG/CdOceveOmEVKyKTZba7H4aUGwM=;
 b=J5rYztOjZcGRZKL1odtFHF0ueblCxnIF7RdQaCKu1C3GNo7aElaWJY1D1Czvz5HcP6
 2w26HD6w57Z/aNvYB4ZzHFFJWqdIYYqdG/WxjGuwfU99IbBblI7VwgMdN9QTcYHvvP3+
 MsjjSg0oRX1SkAPcWCKbdKNupZNPpXv6k1f/l18fb21KUi2fjG/5PEnF2UgL9hRFcFu0
 XsJOFa34oQXbWfgQ47g4qmJHeeLXchbKxE8/+JP0akfqcAAFL2Eir1klw0N4cw3lNMcQ
 fvcsQjKVOT1VYlVn4/uvqYQ6Dx2K8Z+RfjM+4gN3puMqHmGm2Hq4a2cTcujtsJXM321k
 IByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778699783; x=1779304583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NdinE/aAtwwXOMyG/CdOceveOmEVKyKTZba7H4aUGwM=;
 b=OZr3YSQzscODn1Xn8G6GPinEQtu0M3s6olHpjElhJyNo+RXS0cSBRqn1DGiuk0uGJd
 ZpySmpu83eVUqceVpRHHrBL6lv2ZKVX/LGpPvctSB3uxcZo5l2oN8TGQYV17p8nyAcCi
 oFuc9LgiYfcg2Nk5Qxhvm8K9NamaJAxJFcgo5AaRPPvUtQ3J4k8ri/apnIlachUimloV
 s9ob+nhThOjLklH3Q3IHjEhaLq6ztKwOhAfMGhK4nhmBMd6AH9tW2W4lDWYhWSMAPFoF
 utI/NFb783k8A+3xp9/wrp9HADSJbXzvG09TXlIoDaIUYXVWgaQgnLaS2g8mjccilbs1
 IgMw==
X-Gm-Message-State: AOJu0YxkS/3K8vpyde+ecn2j1K67cVg7CtpCF4W7EiROV2bAsrpwjo+M
 0FkhJdEA+L/Jd7KTSFgUiPotlATJZRqFmGkB2d/dkmMh4/RvqMvTmq8BrWCRUYf2k6xX++OWIUh
 WGaa2PpgweQPvLIbS8rZmEYQrAtpjO/VsNSmuuXY=
X-Gm-Gg: Acq92OG100A/nP/hWtth7WD1NEORzekvxiUaIqKJOv02D5N86OY8z7eCymZlKrF+jjG
 zVFdqLsXlGlwEUlmvHcC1MGgWsBuZYd/bvKqIr1j0JJhVI46tzX5RFtoPB0OsGDhV22zmFTztgP
 H8+YRsXiDdrhEvZXkkpx6L4Be82n8jxghsttRSfUasvBStXnnulcKAo0bcYJiUGVXyBcE1Do9qN
 VbuuKbTgW5GMUy8IlOS9qFjAOMDU9fCiUFwf+cbymnT9A+rB1Snj6P/txy8cawIlNsuJLWecE5N
 QE68tnBKINtS+2muIFnhi6/3rl2MLovohH9dzhZo4cph/dGeZw==
X-Received: by 2002:a05:7300:c618:b0:2ff:c611:82c7 with SMTP id
 5a478bee46e88-301174807e8mr2944495eec.12.1778699783188; Wed, 13 May 2026
 12:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
 <CAJSP0QVw+GHOC9_mOcn+V6BHZe5BR1jQyDJ1GocGaqiB_GSoBw@mail.gmail.com>
 <CAJ+F1C+-cr+Sa557xLFcHhCEOsccUHAJSyjPF5E8sGULEKQPhA@mail.gmail.com>
 <CAJSP0QVgGW74x4o3EfY09g0ErgoGvwBhck4iNC7RDe+9CC9zOw@mail.gmail.com>
In-Reply-To: <CAJSP0QVgGW74x4o3EfY09g0ErgoGvwBhck4iNC7RDe+9CC9zOw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 13 May 2026 23:16:10 +0400
X-Gm-Features: AVHnY4IIqE7tk2UIjJBGj60-Wv2PwV_HkwyQkKi900aM8NoY4aO5fXHcnctupLc
Message-ID: <CAJ+F1C+5szDcAd2ut4-=FEZLPXyZudwPiybFfgbMOGfj4fEOYQ@mail.gmail.com>
Subject: Re: [PULL 00/24] Qom patches
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1336.google.com
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

Hi

On Wed, May 13, 2026 at 11:05=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>
> On Wed, May 13, 2026 at 3:49=E2=80=AFAM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Hi Stefan
> >
> > On Wed, May 13, 2026 at 3:20=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail=
.com> wrote:
> > >
> > > On Mon, May 11, 2026 at 4:21=E2=80=AFPM <marcandre.lureau@redhat.com>=
 wrote:
> > > >
> > > > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > >
> > > > The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb=
574e953b:
> > > >
> > > >   Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lurea=
u/qemu into staging (2026-05-11 10:49:53 -0400)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   https://gitlab.com/marcandre.lureau/qemu.git tags/qom-pull-reques=
t
> > > >
> > > > for you to fetch changes up to bc61a3209bf064826481a5f8f2b4feb47c70=
b02f:
> > > >
> > > >   target/s390x: add gen-features.h dependency to s390x_system_ss (2=
026-05-11 23:59:33 +0400)
> > > >
> > > > ----------------------------------------------------------------
> > > > QOM object lifecycle fixes
> > > >
> > > > ----------------------------------------------------------------
> > >
> > > Hi Marc-Andr=C3=A9,
> > > I'm not sure if this CI failure is related to this pull request, but
> > > there is a dbus-vnc issue:
> > >
> > > >>> ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=
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
> > >
> > > 754/1075 /x86_64/dbus-vnc/password-auth -
> > > ERROR:../tests/qtest/dbus-vnc-test.c:621:test_dbus_vnc_password_auth:
> > > assertion failed (qemu_vnc1_server_get_auth(proxy) =3D=3D "vnc"): ("n=
one"
> > > =3D=3D "vnc") FAIL
> > >
> > > https://gitlab.com/qemu-project/qemu/-/jobs/14337427774#L5512
> > >
> > > Any ideas?
> >
> > Embarrassingly, I have no idea. Before org.qemu.vnc is exposed by
> > qemu-vnc (and the auth is checked by the test), qemu-vnc must have
> > started a VNC server successfully (vnc_display_new)..
> >
> > Fwiw, the tests runs quite smoothly locally with meson test --repeat
> > 1000  (some time out sometime, due to heavy load).
> >
> > Let's mark/run it as QEMU_TEST_FLAKY_TESTS until I figure out?
>
> If it helps, your last ui pull request seems to be the first
> occurrence of this failure:
> https://gitlab.com/qemu-project/qemu/-/commit/5e61afe211e82a9af15a8794a0b=
d29bb574e953b
>
> If you'd like me to run CI on a test branch, just let me know.

It's new code, from the patches introducing qemu-vnc & the test. Let's
just skip the test for now by default.
(https://patchew.org/QEMU/20260513082517.1720433-1-marcandre.lureau@redhat.=
com/)
Would you like me to send a new PR?

