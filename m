Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7210CC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 14:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubJj5-0007vz-PD; Mon, 14 Jul 2025 10:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ubIJR-00063e-Vl
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:29:46 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ubIJP-0007ot-GY
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:29:41 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4ab7384b108so5024571cf.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752496177; x=1753100977; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3p9+D77WQL2SxtSAMAv5J4Cjw5KswjPok6KJO2TJKY=;
 b=i0L9ab5oK6DWdFcPn6NjBPnHqHJmv7g00LtTbYgoi6i8WVYnDJbhVX4M5ped6Ng3t0
 g3VKD7788IrmBaaSFhfpD8j7NGTPGfOoTLvzIubRhgZXz4cYi6bqRlZ4om7x+uj//WWz
 8UkOQAzagvyh+JwaO1FeRXNpuKK4CMzrMceEwL6JHHNFb4SBsEDiZL4Ow7nBm3pb03tL
 wZcfepkYFC3yRnqMexTPGj/kV80Cp2XG+lWwfwPm53swPbhq8WOTUTRUCHrviXTdm1PU
 5jRw2Q3I5fT8Ds0r4JUUniuex4Cz+LiBunFEartrBZAP2pFABMA6fKwpegpbB4u48F4Q
 e8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752496177; x=1753100977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3p9+D77WQL2SxtSAMAv5J4Cjw5KswjPok6KJO2TJKY=;
 b=pKnPTjcYw2tGm5B8H7cso8px+i1iy9T7YRt9nl72gpeIwMjKZ5IOESGpTDRKoiHvk1
 Nyk4JJ0rRL93HEFcmcH2ESrcunIq6lOSthGiV9/Vlcqlt3WGhw2ZbuaIgmVZHpd1L8uz
 XRiBj++nh4CSW8Hl6JlskByC7Re/ftvZaRDXOmOmfI7jR4YaM720QpVwCgb01Upuu1VB
 AiYJHcXQUQfuai4d47BKoTHqlaxlGipuHnSf2ITp7Po6TaWpHHohPyVk5FvbI+NrNBDW
 VIxPDQlaqGdlJqVvX8hol4mC/TiCeAcu8g+98IxRiL/F6CMRoXRADY+rR/g/zUf0YGgi
 c9dw==
X-Gm-Message-State: AOJu0YzcENAbtEFcNyACQZzl+KPpG93dKWxPoJlZSKtmUZYX9FZxGzRF
 bamtTjTR4rrmXd7zHKuMeHixpasgF52K5hCoCafzKpX+AkOVPtP7ct3TSiZFKj6JHDKd1IUhAD8
 sg0O5YdS0zFVzIJb5MFqVPCumktKL/lGhN3uqh+Y2vg==
X-Gm-Gg: ASbGncv1AzIM6/J25k0QsFYu4643S6J9D8AN6oNTQaExytaq/Jfj6ShhDwMuqaPL3ng
 tvH4fRE0f0YWMVNgs4BNJE9WYPfal4nU396dQr7In0aaVNsEi4hCe2XPN5G7bAz7O4+7IkaPNiV
 r/IwBzuzrQpcjGAGlV22Oisl18SeEYuUXOwACuKLUofqehMkUtsClFFnyA2krwTOnH7Hiab7fkV
 Ju0Fc3qbhZRGR1luw5ryGsun/xdvGZmA3/iqKlE
X-Google-Smtp-Source: AGHT+IF4LJPMIzBawqWO2PbRqqkoUInZcnsFMMKnLc3vZce++7TRsR1Nbt/0WvBx4Ky2lBScFC84hk9DNyjox7jN/Bk=
X-Received: by 2002:ac8:59c1:0:b0:4ab:7755:ad8e with SMTP id
 d75a77b69052e-4ab7755b4f4mr15321121cf.34.1752496176849; Mon, 14 Jul 2025
 05:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250714111039.4150419-1-marcandre.lureau@redhat.com>
In-Reply-To: <20250714111039.4150419-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 14 Jul 2025 16:29:25 +0400
X-Gm-Features: Ac12FXz0zHhsZemoPKyveP3ebTdK5tV6VwGu_2OcEmhIIHHss7F2VY_Rd6V6ues
Message-ID: <CAJ+F1C+SsUmNYVxMgRMBor+gxv+Yc6dz=4ZnmkY7pNisdgf+sw@mail.gmail.com>
Subject: Re: [PULL 00/13] Ui patches
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

On Mon, Jul 14, 2025 at 3:45=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit 9a4e273ddec3927920c5958d2226c6b38b5433=
36:
>
>   Merge tag 'pull-tcg-20250711' of https://gitlab.com/rth7680/qemu into s=
taging (2025-07-13 01:46:04 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
>
> for you to fetch changes up to c99b7e6d4aa8bcc12d47483ebe81072168de56fb:
>
>   tpm: "qemu -tpmdev help" should return success (2025-07-14 15:02:00 +04=
00)
>
> ----------------------------------------------------------------
> UI-related for 10.1
>
> - [PATCH v3 0/2] ui/vnc: Do not copy z_stream
> - [PATCH v6 0/7] ui/spice: Enable gl=3Don option for non-local or remote =
clients
> - [PATCH v6 0/1] Allow injection of virtio-gpu EDID name
> - [PATCH 0/2] ui/gtk: Add keep-aspect-ratio and scale option
>
> ----------------------------------------------------------------
>
> Akihiko Odaki (2):
>   ui/vnc: Do not copy z_stream
>   ui/vnc: Introduce the VncWorker type
>
> Andrew Keesler (1):
>   hw/display: Allow injection of virtio-gpu EDID name
>
> Marc-Andr=C3=A9 Lureau (1):
>   tpm: "qemu -tpmdev help" should return success
>
> Vivek Kasireddy (7):
>   ui/egl-helpers: Error check the fds in egl_dmabuf_export_texture()
>   ui/spice: Enable gl=3Don option for non-local or remote clients
>   ui/spice: Add an option for users to provide a preferred video codec
>   ui/spice: Add an option to submit gl_draw requests at fixed rate
>   ui/console-gl: Add a helper to create a texture with linear memory
>     layout
>   ui/spice: Create a new texture with linear layout when gl=3Don is
>     specified
>   ui/spice: Blit the scanout texture if its memory layout is not linear
>
> Weifeng Liu (2):
>   ui/gtk: Add keep-aspect-ratio option
>   ui/gtk: Add scale option

NACK, will resend because when Spice is not recent enough:
../ui/spice-core.c: In function 'qemu_spice_init':
../ui/spice-core.c:673:17: error: unused variable 'video_codec'
[-Werror=3Dunused-variable]

>
>  qapi/ui.json                        |  15 +-
>  qapi/virtio.json                    |  18 +-
>  include/hw/display/edid.h           |   2 +
>  include/hw/qdev-properties-system.h |   5 +
>  include/hw/virtio/virtio-gpu.h      |   3 +
>  include/ui/console.h                |   3 +
>  include/ui/gtk.h                    |   2 +
>  include/ui/spice-display.h          |   5 +
>  include/ui/surface.h                |   1 +
>  ui/vnc.h                            |  49 +--
>  hw/core/qdev-properties-system.c    |  44 +++
>  hw/display/virtio-gpu-base.c        |  27 ++
>  system/tpm.c                        |   5 +-
>  ui/console-gl.c                     |  54 ++++
>  ui/egl-helpers.c                    |   6 +
>  ui/gtk.c                            |  58 ++--
>  ui/spice-core.c                     |  31 ++
>  ui/spice-display.c                  | 226 +++++++++++++-
>  ui/vnc-enc-tight.c                  | 456 +++++++++++++++-------------
>  ui/vnc-enc-zlib.c                   |  47 +--
>  ui/vnc-enc-zrle.c                   | 122 ++++----
>  ui/vnc-jobs.c                       |  13 +-
>  ui/vnc.c                            |  83 +++--
>  ui/vnc-enc-zrle.c.inc               |  20 +-
>  qemu-options.hx                     |  13 +
>  25 files changed, 882 insertions(+), 426 deletions(-)
>
> --
> 2.50.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

