Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342F7CCF9FC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 13:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vESwd-0005mQ-VJ; Thu, 30 Oct 2025 09:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vESwc-0005m4-8Z
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:44:02 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vESwS-0000Eu-DY
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 09:44:00 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4ed101e8496so7795471cf.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761831826; x=1762436626; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7SM6iVZ8tIoRmPPhiv2mZYf+U/m9GFpGEhVIn4YYxVY=;
 b=nh/GTaPheyd3/HxFUhY8+3BS/xOkhmu8uN1tEeChu3Fk8apPwzJQp/Zf2B21mjy3yz
 5c+ZK5rzmM7zCoCD3hudHJnVBAdzs2AK9w3oXr6yQ1+uiPl/6JcM4jTD3yFPK3HN7M2R
 +QjlS1WdgxnDofjhfm/0DqPthOrT4OpcGZRvXN2cflSZ3njij2CIfd4elQbZ12MDjo92
 FCHkCuWL/qSl6MUDjDjElZt6O4AKIzVKB0kXrE+xJo0kL3SECk2sD025KMRI5V4HjJfZ
 SbDZcVNbP+ZqWz00oAS3BXPtHI/Nhb1nSYg0kKVl0jH3UxJMZuJEcseqsM2TjnMtGJen
 eVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761831826; x=1762436626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7SM6iVZ8tIoRmPPhiv2mZYf+U/m9GFpGEhVIn4YYxVY=;
 b=Vw233aurwyZtJ22SlC0VBcBE+vD1A9IWqQl52A/vFT+6ZK5gex4ttuNr3WHaKPmflU
 JP12XbuY9hvoqANrhwbeydJqrrnoWF2BR+Z2d6ZFzfnHFzebAP6Hmx/eDuMzimZhBaW5
 yhX/RJMLaqHKBweK4TlaPpmgqvnhvU22HW8CfbjfSN3fZlJN+0dHJ2oS9ydHDexP/lVi
 zCiRZzRCWEbwCP6rBPHEI1A57CO5CLKELH5hQx6rfhbzGzp0qHSE3X05jvtkwLs3qd5i
 gWCsmPtj/MqNnLOKz7uz9VM6mg9tR1bEDvRT4z0eroRe23df/e4z3nHhqmOGEqIoVaxO
 olmw==
X-Gm-Message-State: AOJu0YyHbMr+KFwggPw7T4cmh62zXC/lt+48AJX4Wl18ZVY5NbE3Lrv0
 ySAR/QEhXmfkcV/qEFsHWlV214AjOVjoO3E/t7wtl//4Une/fbs4slyZUVRN3w3WDG9b38muHpc
 aK4YvgNRzhD50ngX9MMKRXKRSdPmayo4KgF+wnh0S5A==
X-Gm-Gg: ASbGncumxpREIgrEK+W3wR7RrKu9pWmFuZG/v+0s9MQ4fNuIdAHtWesbawT8LEXBzg4
 UYIefNxcskyEEXSdpzVeSAxk8Apdy7+xjrAd8GXfSKE1wlkHatgUX7Ow+WncEVjpAAzkMWmJULw
 QhUyeBKHSSB0Ui04icN220hviy7NZ36QtyDYHqsXHlmId3yAAp1OMNXE09+KQu0GEREtVbpQqwQ
 SHwGW/sRjwpi8WRBUOwBFsGcddOVTOPFIAcyFTKKrgjP/G7YHqiIMKQa69sI/vOqgdgBFySh2/G
 /J5OhN9Ut9LOcW2O
X-Google-Smtp-Source: AGHT+IH8RR95azdak4Ftt/D03nnvFI4Tgx//KgS7dMUYFcyYcenqUI2v0FEDBeDinPuBfk5H5pT4Q5a/1pDxOg+gYmA=
X-Received: by 2002:ac8:7d13:0:b0:4b3:475a:e2fc with SMTP id
 d75a77b69052e-4ed2211bd0amr34852471cf.3.1761831825559; Thu, 30 Oct 2025
 06:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
In-Reply-To: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 30 Oct 2025 17:43:32 +0400
X-Gm-Features: AWmQ_bkFzEZH-GdWJh91jMb701YRULFFGmm_DUllXAxJ4nf7FQYk0HHyYxYR-1o
Message-ID: <CAJ+F1CLN_iozWRN96qQ=ckkvzt6bvyN6LyGhTOSn+wmVfN+hSQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/35] Audio clean-ups
To: qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>, 
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 27, 2025 at 7:13=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>
> This is part of continuous and overdue clean up / modernization effort fo=
r the
> audio subsystem. (there is more in the pipe)
>
> v3:
> - rebased and dropped applied patches
> - fix some checkpatch formatting errors
> - tweak commit message
> - added r-b tags
>
> v2:
> - renamed AudioBE AudioBackend
> - "qdev: add qdev_find_default_bus()" report different error for full bus
> - added "remove QEMUSoundCard" & drop AudioFE renaming patch
> - added "docs: Update mentions of removed '-soundhw' command line option"=
 patch from philmd
> - added r-b tags
>
> thanks
>
> Marc-Andr=C3=A9 Lureau (33):
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
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   audio: Remove pointless local variables
>   audio: Rename @endianness argument as @big_endian for clarity

Only 3/4 patches are missing reviews:

audio: register and unregister vmstate with AudioState
audio: remove QEMUSoundCard
audio/dbus: use a helper function to set the backend dbus server
audio: move capture API to own header

thanks for the help!


>
>  MAINTAINERS                                   |   1 +
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
>  {audio =3D> include/qemu}/audio.h               | 137 +++-----
>  include/system/replay.h                       |   3 +-
>  ui/vnc.h                                      |   4 +-
>  audio/alsaaudio.c                             |  37 +--
>  audio/audio-hmp-cmds.c                        |   4 +-
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
>  audio/meson.build                             |   2 +-
>  hw/audio/meson.build                          |   2 +-
>  .../codeconverter/test_regexps.py             |   4 +-
>  75 files changed, 758 insertions(+), 848 deletions(-)
>  create mode 100644 include/hw/audio/model.h
>  delete mode 100644 include/hw/audio/soundhw.h
>  create mode 100644 include/qemu/audio-capture.h
>  rename {audio =3D> include/qemu}/audio.h (50%)
>  rename hw/audio/{soundhw.c =3D> model.c} (54%)
>
> --
> 2.51.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

