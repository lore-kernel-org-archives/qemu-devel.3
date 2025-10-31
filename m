Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605A7CCF9EE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 06:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEj3A-0002Yn-9p; Fri, 31 Oct 2025 02:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vEj35-0002F5-PB
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:55:48 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vEj2u-0004xq-8k
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 02:55:47 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4eba313770dso23476811cf.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 23:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761893729; x=1762498529; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghAoP8st044RskeUJ6cxZ2oYcSM/lanKEKGQqqfEWzo=;
 b=N0zZmrsXdTffYhUneIibef37geYMdu+27MO/5vU7bYaYLzRCQGrxWkBGSXb0vHBTac
 yK9pZt4JGkbzOzrHRnoUVvSsaufqc24xNQyNZOlKs8Bh/BCN5Q9v3q/ns5hHcGItPehl
 rT5WdmTiMOH0pnmsZ7+Jm+AGwFVwrMt5SAmWzPR6RxIT3JLJzOJTIvAmqoerat3coqUn
 a2D/o9ZV4CcwijTYBgQ9W6JvbOCh9fwBuP9SfcSHWSlruHm8TPxpgMzlYdafWbm5L0qb
 xcB/g1yQIFZjhbMUBiIha1jj7OjyexvbWNlP96f/x3jyORYN88a/9H1LRxaT0AyaMiS0
 U63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761893729; x=1762498529;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ghAoP8st044RskeUJ6cxZ2oYcSM/lanKEKGQqqfEWzo=;
 b=nYKg93OEm3Phjkx8OTUAQyftU3A7fxIYGbSbewLBFi8Km+SanoO9wsjz4QdsDEHrid
 dH/P3fKE0lBnoSH9CtU8v2C3ideUFdNX0+oMLgJL0k+XaKgzL18kManZpfgX1UCNvl16
 QEI8uaOtV4cpZS9STxuZzElpEEeoJesLhcWXEaQo6uRvzSoeFMCg+REp8c5sFO0u9Ozz
 ox7tqJAeBzuXODDd9AS8A1jSCu8HBvnmWlioJDvKrgn4JB9etxf5j8+ZnwjDUFmdV1tn
 M5/5sgMFhD67vnLW1Mb2AXQ38ZHUNOIYGiEIZufnhNTzQWuarorjFvVmNv/lbugxz4Mr
 XW2A==
X-Gm-Message-State: AOJu0YxbU3Vatq3TxW67Tiw5qaXZAO54BfJ9Q9x774cnqmRYzMt7x25A
 +tVgooEqVe2lQf0cYCkz82rm4S0hSy1F//KHz54XwVk2Os3Q7A23c54aG349Y4ZUfylr0SvXTc5
 jiU8nZifgjmBP5g4u36NHXf3QOcZjJNwbcxVx884=
X-Gm-Gg: ASbGncuSGhQUSr1xc1FqnWmaJ76Kbs5WN1uafbvs4BQwkiGitnH4GbOL+Ad2xa1nchb
 DWhB/8p+q9GyiTlXGUI1GQYyXGhO6ToXTG6JF4hQ8s3WzvfvIJ4wfovkqrJ/FVuhtIjOY5JW8L8
 4kus9iZqBZ5K+K9UuhVmL4TMep0u6WwmWFRuSc9SV495C76xk6gooKYAhejBjO1JUiqFdq6mnMf
 oAbumpWcgkKryBR/s7mHwbJ7Lgm6gk9XaMEMxd3sNSUxAhDmK/blD4OFssKdxok/VJpzwh4SvZa
 0hx8LG0+l0BpLQFCG1rBHr4Bo9k=
X-Google-Smtp-Source: AGHT+IFz407ugaQ23ZvnhuRtEdgXFpq5nZXIu3VTIO2o7GwNMQ8zjk0Z3kNFGHTI43FHTU0WtQ9C2a55swrjb9ZM14o=
X-Received: by 2002:a05:622a:15c6:b0:4eb:a439:5fe8 with SMTP id
 d75a77b69052e-4ed30c13241mr23310461cf.0.1761893728662; Thu, 30 Oct 2025
 23:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <20251031064631.134651-1-marcandre.lureau@redhat.com>
In-Reply-To: <20251031064631.134651-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 31 Oct 2025 10:55:17 +0400
X-Gm-Features: AWmQ_bmWdZ6n-hZa4Y0OMtKehBFUx6I94mbHb-U9_SdoFgcv4jjxgXQa53y80yA
Message-ID: <CAJ+F1C+Tib_oDihxr+9AbFt-4d_K1D+GmZP78jc4Pfe7aRv32A@mail.gmail.com>
Subject: Re: [PULL 00/36] Audio test patches
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi

Nevermind the thread title, it should be just "Audio patches"
(git-publish used my branch name "audio-test"...)


On Fri, Oct 31, 2025 at 10:48=E2=80=AFAM <marcandre.lureau@redhat.com> wrot=
e:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e=
4e:
>
>   Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into =
staging (2025-10-29 10:44:15 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/audio-test-pull-reque=
st
>
> for you to fetch changes up to 05404916bf89867e613da271ebff1a556c206965:
>
>   audio: deprecate HMP audio commands (2025-10-30 22:59:30 +0400)
>
> ----------------------------------------------------------------
> Audio clean-ups
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (34):
>   qdev: add qdev_find_default_bus()
>   hw/audio: look up the default bus from the device class
>   audio: rename audio_define->audio_add_audiodev()
>   hw/audio: use better naming for -audio model handling code
>   hw/audio/virtio-snd-pci: remove custom model callback
>   hw/audio: simplify 'hda' audio init code
>   hw/audio: generalize audio_model.init()
>   hw/audio: drop audio_model.isa
>   audio: start making AudioState a QOM Object
>   audio: register backends in /audiodevs container
>   audio: use /audiodevs QOM container
>   audio/paaudio: remove needless return value
>   audio/dsound: simplify init()
>   audio/dsound: report init error via **errp
>   audio: simplify audio_driver_init()
>   audio: move period tick initialization
>   audio: drop needless error message
>   audio: keep vmstate handle with AudioState
>   audio: register and unregister vmstate with AudioState
>   audio: initialize card_head during object init
>   audio: remove some needless headers
>   audio: remove AUDIO_HOST_ENDIANNESS
>   audio: introduce AUD_set_volume_{in,out}_lr()
>   audio/replay: fix type punning
>   audio: move internal APIs to audio_int.h
>   audio: rename AudioState -> AudioBackend
>   audio: remove QEMUSoundCard
>   audio/dbus: use a helper function to set the backend dbus server
>   audio: move audio.h under include/qemu/
>   audio: remove dependency on spice header
>   audio: cleanup, use bool for booleans
>   audio: move capture API to own header
>   audio: drop needless audio_driver "descr" field
>   audio: deprecate HMP audio commands
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   audio: Remove pointless local variables
>   audio: Rename @endianness argument as @big_endian for clarity
>
>  MAINTAINERS                                   |   1 +
>  docs/about/deprecated.rst                     |  20 ++
>  audio/audio.h                                 | 185 -----------
>  audio/audio_int.h                             |  67 ++--
>  audio/audio_template.h                        |  44 ++-
>  audio/mixeng.h                                |   1 -
>  hw/audio/lm4549.h                             |   4 +-
>  include/hw/audio/asc.h                        |   4 +-
>  include/hw/audio/model.h                      |  14 +
>  include/hw/audio/soundhw.h                    |  13 -
>  include/hw/audio/virtio-snd.h                 |   4 +-
>  include/hw/display/xlnx_dp.h                  |   4 +-
>  include/hw/isa/vt82c686.h                     |   4 +-
>  include/hw/qdev-properties-system.h           |   2 +-
>  include/monitor/qdev.h                        |   3 +
>  include/qemu/audio-capture.h                  |  43 +++
>  include/qemu/audio.h                          | 150 +++++++++
>  include/system/replay.h                       |   3 +-
>  ui/vnc.h                                      |   4 +-
>  audio/alsaaudio.c                             |  37 +--
>  audio/audio-hmp-cmds.c                        |  11 +-
>  audio/audio.c                                 | 313 +++++++++---------
>  audio/audio_win_int.c                         |   2 +-
>  audio/dbusaudio.c                             |  20 +-
>  audio/dsoundaudio.c                           | 213 +++++-------
>  audio/jackaudio.c                             |   3 +-
>  audio/mixeng.c                                |  12 +-
>  audio/noaudio.c                               |   5 +-
>  audio/ossaudio.c                              |  33 +-
>  audio/paaudio.c                               |  24 +-
>  audio/pwaudio.c                               |  15 +-
>  audio/sdlaudio.c                              |  15 +-
>  audio/sndioaudio.c                            |   3 +-
>  audio/spiceaudio.c                            |   7 +-
>  audio/wavaudio.c                              |   6 +-
>  audio/wavcapture.c                            |   5 +-
>  hw/arm/integratorcp.c                         |   2 +-
>  hw/arm/musicpal.c                             |   2 +-
>  hw/arm/realview.c                             |   2 +-
>  hw/arm/versatilepb.c                          |   2 +-
>  hw/arm/vexpress.c                             |   2 +-
>  hw/arm/xlnx-zcu102.c                          |   2 +-
>  hw/audio/ac97.c                               |  36 +-
>  hw/audio/adlib.c                              |  17 +-
>  hw/audio/asc.c                                |  15 +-
>  hw/audio/cs4231a.c                            |  16 +-
>  hw/audio/es1370.c                             |  30 +-
>  hw/audio/gus.c                                |  17 +-
>  hw/audio/hda-codec.c                          |  21 +-
>  hw/audio/intel-hda.c                          |  22 +-
>  hw/audio/lm4549.c                             |  12 +-
>  hw/audio/marvell_88w8618.c                    |   2 +-
>  hw/audio/{soundhw.c =3D> model.c}               |  86 ++---
>  hw/audio/pcspk.c                              |  13 +-
>  hw/audio/pl041.c                              |   2 +-
>  hw/audio/sb16.c                               |  23 +-
>  hw/audio/via-ac97.c                           |  11 +-
>  hw/audio/virtio-snd-pci.c                     |  18 +-
>  hw/audio/virtio-snd.c                         |  17 +-
>  hw/audio/wm8750.c                             |  37 +--
>  hw/core/machine.c                             |   4 +-
>  hw/core/qdev-properties-system.c              |  17 +-
>  hw/display/xlnx_dp.c                          |   8 +-
>  hw/ppc/prep.c                                 |   2 +-
>  hw/usb/dev-audio.c                            |  17 +-
>  qom/object.c                                  |   1 +
>  replay/replay-audio.c                         |   4 +-
>  replay/stubs-system.c                         |   2 +-
>  system/qdev-monitor.c                         |  25 +-
>  system/runstate.c                             |   2 +-
>  system/vl.c                                   |  14 +-
>  ui/dbus.c                                     |  13 +-
>  ui/vnc.c                                      |  10 +-
>  audio/coreaudio.m                             |   3 +-
>  audio/meson.build                             |   7 +-
>  hmp-commands-info.hx                          |   6 +-
>  hmp-commands.hx                               |   9 +-
>  hw/audio/meson.build                          |   2 +-
>  .../codeconverter/test_regexps.py             |   4 +-
>  79 files changed, 898 insertions(+), 953 deletions(-)
>  delete mode 100644 audio/audio.h
>  create mode 100644 include/hw/audio/model.h
>  delete mode 100644 include/hw/audio/soundhw.h
>  create mode 100644 include/qemu/audio-capture.h
>  create mode 100644 include/qemu/audio.h
>  rename hw/audio/{soundhw.c =3D> model.c} (54%)
>
> --
> 2.51.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

