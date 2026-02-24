Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36707E9B24D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqF5-0001vG-DA; Tue, 24 Feb 2026 06:06:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqF2-0001r7-Ps
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:06:13 -0500
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vuqF1-0006ni-6E
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:06:12 -0500
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-896fcfc591eso50667226d6.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:06:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771931169; cv=none;
 d=google.com; s=arc-20240605;
 b=L2QrrwIqdZXfptBmdE+Ll346gzfuM7CECF8jOTEeaLOacc3LUGbFtH/sigrPleid9r
 wfASSszD1NMry8DHuwZMPQUh7CqtBYW/642+AWemt2VysPHSNcJ1pE8hhcH66/5SZLRz
 HnJC6BK/wHr8/NqaXO9JpOzNkSu1RIsXnLaZpLHAWEyrHfs4wNkl2iKh65v+F5/3XOGE
 gS/esLNlwEk+XJwZHekQ58Blhv7+M/AF7dqb2NPZB/79iLPM/G3VmUR4UtvO6s/Nh6SQ
 6AiIsJ/OQ469z65TP7KDNA6OMWg1To7AT6Mbwk8asIXbtmPd1RShi1k05ueXfkxc11zX
 nxsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KIt74gGqLx6xHaOZXZZjs3Wcebpi4XUkgyZ1ms6/rcQ=;
 fh=9dqpPjrtVfoOV99Cw5UPSTWOClvvkBcwaQUCMmBtLzk=;
 b=CYFhgDMu7iUd/G6+loUcl5zw2JD6DpEiAXMR0sZYtXY3DJCv9zoDM1ypVWceXuzPK9
 QPK3DJ4d8uPmMGnXbGJI2YAY6mMIBf0lEDuritEbZMPfk/K4gVCsdrRVvU47bH6AkALf
 Xq3bOIAjbnba7gyMN0dAtmkdu/00sETnrReR2Jrqi/TIWMTbJO0/bEqLnF6f2vzsNmOS
 W+j3PWPEwysiHtQ0e1vNUiVkhIYxzOweZVHzjZzW7Ff7m5fzq03wHDbZwv7k7i2NssGn
 fjMj0UB+2JTjL5hZlYSJhqram7r2xeDumA2i3sKj5zxZefzNgPuTzNlChIvz2l0sBV35
 SCMw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771931169; x=1772535969; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIt74gGqLx6xHaOZXZZjs3Wcebpi4XUkgyZ1ms6/rcQ=;
 b=C/oW+iiMXltRqS3BXRHXIR1oQslGIFmecYYh8vEKEMJLkVEpdkUA+Uxy5h0/BTN+96
 2JaseMseeulgLFpH5c4eefm1/1/yTSfHQQuWyu9dS7VXfffpF45hZhlcooGbyuHYVaxS
 tVQ4PnSCCW4D9hUcjbUlkAMlXl3CfX1idKWU2Lf2oXYR3OPZQkavGhvNamhobjZrl9pn
 IoO0WwiIN5LVOU9hvEgDHyPVa/05rfMAU9hJZ/NtRhBdKBwdiXf5uHWEk354l0X/RGnW
 TW1Y/UAHvBTYO4IBczdGfvFkE2xs4ITljvAaEDXk99zcstgngSLa4hDEr74GRa6LvhiV
 VGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771931169; x=1772535969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KIt74gGqLx6xHaOZXZZjs3Wcebpi4XUkgyZ1ms6/rcQ=;
 b=h/u20dNR1iVulzJlOHNGBoyWioniXB1cz+SUE2GNtKEvb3Gnljt5BxzJWglSNDQaUz
 uTx6FUxh5EBGdV9WJjZ99zN3ES4swjcoVp0IDfyBXCWWmhFw7jQ2GDluBIIGZecpCrsL
 EU3N9g+RmTnpD19iQhLQChQ+py7mkpdoU0XoSiml3gOf4DEFY3ZhfVHvVJIzUSl8OULv
 4R2d+Z0XRAjDutFzldHREjdVKIB9mpt7UQWdrTf75FSqFgAZYncTxDRzCmb7LvtqLiaX
 mGrJK6oPTMBc9VfuDaj+cpMFu3S0zBPqvLTBOrLVBOMHUdvIGXRiCkKAvJ0mXiyzxQgJ
 bofA==
X-Gm-Message-State: AOJu0YzUtjwo/SH7EyRw5Pedt6yXpg7mMRKZ4WytFgupgj1J3lQ2K3oR
 PwcUyX6jQqlskku4bZgqhw6z5wfQU9Pyy5e8sILI4CKE486J1nqipdL/G9wSxd8WQvRfoTjIe+L
 +GeRlkKCpciLLNG3ZDuq/ncKAWKpinsk=
X-Gm-Gg: AZuq6aLhBjMgb3gD4xX7mYs/6Oy4uY7Z+ChPLNl0/UwV4hOuuvHA1EkXzey8YRa/Ezw
 4If7F4Tk0eV3Hql6d5+vk/mxBdB/pyBn2MD2IbGvfqjtAH/fciRgANTLKGuWfJmbXUjN56/vu/j
 j1owe3OcJcXc+XUf6R/k+f50ojuLEwipl04MkTrpAz0eRScjsyn/YCyG1m91QE6O+1mV7Vz2mbI
 h+7ncH/tyuJv1bp4b7gcZdjdFVxnPGv72+d3kmkL8zYMfcCLbOFisAZfT610QEsyNKJcNLojvoj
 34aUS2c=
X-Received: by 2002:ac8:5e13:0:b0:4e8:b9fd:59f0 with SMTP id
 d75a77b69052e-5070bcf1dbbmr153774311cf.61.1771931168881; Tue, 24 Feb 2026
 03:06:08 -0800 (PST)
MIME-Version: 1.0
References: <20260223202512.1308205-1-heifetz@yandex-team.com>
 <20260223202512.1308205-5-heifetz@yandex-team.com>
In-Reply-To: <20260223202512.1308205-5-heifetz@yandex-team.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Feb 2026 12:05:57 +0100
X-Gm-Features: AaiRm53U_QkfttI0HX1GOSsVPogC2dPI0wBXlIR9xKOkzjsWbv1JiOmreI5IAGc
Message-ID: <CAJ+F1C+hQSzQRronXoX=7-pC8mTYLnPbxYTJbeUXAZiE=-txag@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] hw/audio/pcspk: change PCSPK behaviour with
 --disable-audio
To: Sergei Heifetz <heifetz@yandex-team.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qv1-xf2b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Feb 23, 2026 at 9:27=E2=80=AFPM Sergei Heifetz <heifetz@yandex-team=
.com> wrote:
>
> PCSPK (PC Speaker) is an embedded audio device. We don't want it to use a=
udio
> when QEMU is configured with `--disable-audio`. This is achieved with min=
imal,
> non-invasive changes to the code.
>
> In essence, the changes ensure that PCSPK does not have a corresponding
> audio backend, while functioning the same way in non-audio aspects.
>
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>

looks ok

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/audio/pcspk.c | 12 +++++++++++-
>  hw/i386/pc.c     |  2 ++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
> index 6b826507ce..54e1882265 100644
> --- a/hw/audio/pcspk.c
> +++ b/hw/audio/pcspk.c
> @@ -48,17 +48,20 @@ struct PCSpkState {
>
>      MemoryRegion ioport;
>      uint32_t iobase;
> +    PITCommonState *pit;
> +#ifdef CONFIG_AUDIO
>      uint8_t sample_buf[PCSPK_BUF_LEN];
>      AudioBackend *audio_be;
>      SWVoiceOut *voice;
> -    PITCommonState *pit;
>      unsigned int pit_count;
>      unsigned int samples;
>      unsigned int play_pos;
> +#endif
>      uint8_t data_on;
>      uint8_t dummy_refresh_clock;
>  };
>
> +#ifdef CONFIG_AUDIO
>  static const char *s_spk =3D "pcspk";
>
>  static inline void generate_samples(PCSpkState *s)
> @@ -130,6 +133,7 @@ static int pcspk_audio_init(PCSpkState *s)
>
>      return 0;
>  }
> +#endif
>
>  static uint64_t pcspk_io_read(void *opaque, hwaddr addr,
>                                unsigned size)
> @@ -160,11 +164,13 @@ static void pcspk_io_write(void *opaque, hwaddr add=
r, uint64_t val,
>
>      s->data_on =3D (val >> 1) & 1;
>      pit_set_gate(s->pit, 2, gate);
> +#ifdef CONFIG_AUDIO
>      if (s->voice) {
>          if (gate) /* restart */
>              s->play_pos =3D 0;
>          audio_be_set_active_out(s->audio_be, s->voice, gate & s->data_on=
);
>      }
> +#endif
>  }
>
>  static const MemoryRegionOps pcspk_io_ops =3D {
> @@ -195,10 +201,12 @@ static void pcspk_realizefn(DeviceState *dev, Error=
 **errp)
>
>      isa_register_ioport(isadev, &s->ioport, s->iobase);
>
> +#ifdef CONFIG_AUDIO
>      if (s->audio_be && audio_be_check(&s->audio_be, errp)) {
>          pcspk_audio_init(s);
>          return;
>      }
> +#endif
>  }
>
>  static const VMStateDescription vmstate_spk =3D {
> @@ -213,7 +221,9 @@ static const VMStateDescription vmstate_spk =3D {
>  };
>
>  static const Property pcspk_properties[] =3D {
> +#ifdef CONFIG_AUDIO
>      DEFINE_AUDIO_PROPERTIES(PCSpkState, audio_be),
> +#endif

we could make DEFINE_AUDIO_PROPERTIES compile down to nothing if
!CONFIG_AUDIO, to avoid ifdefry

>      DEFINE_PROP_UINT32("iobase", PCSpkState, iobase,  0x61),
>      DEFINE_PROP_LINK("pit", PCSpkState, pit, TYPE_PIT_COMMON, PITCommonS=
tate *),
>  };
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 0dd3fd01d9..3992553c2a 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1679,8 +1679,10 @@ static void pc_machine_initfn(Object *obj)
>
>      pc_system_flash_create(pcms);
>      pcms->pcspk =3D isa_new(TYPE_PC_SPEAKER);
> +#ifdef CONFIG_AUDIO
>      object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
>                                OBJECT(pcms->pcspk), "audiodev");
> +#endif
>      if (pcmc->pci_enabled) {
>          cxl_machine_init(obj, &pcms->cxl_devices_state);
>      }
> --
> 2.34.1
>
>


--
Marc-Andr=C3=A9 Lureau

