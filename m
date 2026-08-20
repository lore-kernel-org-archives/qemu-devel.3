Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB55C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx8NQ-0004CF-Ur; Thu, 20 Aug 2026 15:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wx8NQ-0004A8-1F
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:24:36 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wx8NO-0007eC-BR
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 15:24:35 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso160514a12.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 12:24:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787253872; cv=none;
 d=google.com; s=arc-20260327;
 b=WnrwNun3bWBH29ZG0ATNh8X1QP2dAe+SmvING6+x5L7fQ4IoIbe8T3PNMmULubpeb6
 y791gMS8bvCrmNVFQKHX1KZHr9SPhAg9+8Sbokgalr1KZutwL5pkyw8nvalmhLwNi4Vq
 plgnLmbNb68PsUvjQlpJHeAA6yg82Zb+gQE4CVePXAxmpX05R3aAADG9FGRbEn9SkRuy
 08/40Qkj4jBm58nKiwMAqDzqvfnThb68cxQW1c7OgBSYPawJNumRvhXMnMp1H2uKDL5A
 WJ//yjzMftHMtoKycB85aB3lwyweWiwYJTh8lqa6mYO7vrwQjXuSzbkNFiQc6cwNun28
 ShVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZUgOHRKd3y1O7SgFY/8oGN3tRWQXtEgyzNlERbf9Dxc=;
 fh=5717E/dCbW4+veQxTp+zvFQh05r3OH3Hzt1ZrbLZyKM=;
 b=FJhGYbc+1iSE1nHs8UJm+qJMapkb5kMOCKt3jRdbPWh10Ivkiy7ApFGSliPsa+gDuV
 DEe1f/3Nh76HG6XVMgq43hIch1Q584qvj7vjKZIPeTxQ1iEh5B5jp8pLvb8k56E1eXEz
 Hoqly9DBh3qKoqDmnhHCGxXp+GAWZjBih1MqAyqBz610TNe8IohCpKxhqjxFf3jWVxgI
 Shn3EOe2mrdTMPdpPH+uJ2gIzwVwfj8nYfppH/jCUnln/ivmsK8cT+fPZbkO8HZlczkx
 oDmV7ugEhIxch6BkPYJh72U7fOpxeJ5Y5COdkm/414ccXd/Nzj21yItAW+TLQAKwJX1K
 DucQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787253872; x=1787858672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZUgOHRKd3y1O7SgFY/8oGN3tRWQXtEgyzNlERbf9Dxc=;
 b=hXRq9wIhOEH+/GD9hWkjFtA94OjiQSEVRSd8+8bU3A7dQeByGN/RQVRj3LQ74yLi+s
 NdF+zFWK0JqTgF1AtgsqtTAYQluZhg0VkwB+DzmmPBvS89+ijD1/mw+SyqdnxbQx/OLE
 6pKX7eJVyRFj2A+iDietzSydVYICaKSI1XVvXIsi6NhJvqwj8A4r2EZjybjrsa24YhyE
 iZV02kD/MpSSG601bL98h5PA9jTg4mN6RxMKgcNEI5wkv/3DapOAoq9/R+4J3ctyc8qF
 x24/qbvj0DIkUZx/NUsMUc46x/Y8sdANe8lwFpshbiEemPdMyNaFMqzhVbOb/LNmt3OP
 3J2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787253872; x=1787858672;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZUgOHRKd3y1O7SgFY/8oGN3tRWQXtEgyzNlERbf9Dxc=;
 b=JVdc+SYkp1Kcgqm5t0bZmDeVr1tWNoqRv/1WmYFYNzOWn81/InCR+T/1ObIZ/0Rdtc
 TWeauohkzZsGcuaGs8MmZk/MghIMO5IlYCDWkqI+ajJKpXFQzHYAaLW6/EVeorGxbmjc
 U0q8NNGTGy8U5HCr9dTNr2LnRT9LzXCSUg1MtRv/WYkUhiMW1Zf+xzfZW5reBhBPohAO
 o5OHmhyb8AmZDoGicPBmxRVgG1ZVPkehwRroQQTRdd8Tal9bdlBnS5LSgN/zpd8bCKAu
 v36IrLmLLaF54b/NrqdRRvfzVIwzWUk5jpI3Ha3j3ElTmk4cptdZuT0wx/BhPMlNfLOY
 /pvg==
X-Gm-Message-State: AOJu0YzXQJsyWBlmImd67HO0LrFW1H428Yy/6NmEv5b5CyG1snQc4Hyk
 BhoYMIDvxNjG+ua5p00H1AS2Y3Kka/CUxvr/jN/oCiBsDKaOkNgaOP1694ZSLRM2EujZVfcum4g
 QCoyciu25ewW3PC7rH6gK/M511wkoeKE=
X-Gm-Gg: AR+sD10DPMZwxPNg1dUO925X9PIPzi+/ue9eo3mpyP23QYVoqF/GWYykqB/UIXR1cUD
 RhHoiCIi7xt961sU/1y28QZI9w4/nmQlKsnI2LzUrJKk0sqNIV763zV1r8s88Avdxk96FHOMw9Y
 cerM2oJuB6A+ciYqeJFsMSU7z8bkgCn8ImWJiQgOhfN5cjiKYyLoVhB7bIYjkgip+cnOhxL8p86
 jA8Hex6cveqEtyf5CHcp6LwZZMBufriycn/0EqBGWAo7SPxydGenrEB0jrJMzzELmuIXTVVUmeu
 I/nvbyhNYUWafeNRQutgolhoDlF1p9iyGGFJz5l48ZOKvwlfMCrojxXLOdPYHtc9WJlpKmLuZOg
 6AIn1OPUGOkHA
X-Received: by 2002:a05:6300:67c8:b0:3cc:3d08:da3e with SMTP id
 adf61e73a8af0-3cd2fdd1cfcmr1432871637.2.1787253872111; Thu, 20 Aug 2026
 12:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-42-e53fc35bc550@redhat.com>
 <54f7243a-aae3-4f1a-a213-bf302fc1b7ea@oss.qualcomm.com>
In-Reply-To: <54f7243a-aae3-4f1a-a213-bf302fc1b7ea@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 20 Aug 2026 23:24:20 +0400
X-Gm-Features: AcwNN1WACX_FtSDdSnDwafI69-1QNLV0P0_AZ2rIKZBtZ2IJ8QGvsL3cKXZ7Z1U
Message-ID: <CAJ+F1CJmf9spgeOpLSSK3KmaefGQUmJbfe70TS7qC-j9hhU95w@mail.gmail.com>
Subject: Re: [PATCH v3 42/49] target: guard MonitorDef tables with CONFIG_HMP
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

On Thu, Aug 20, 2026 at 6:40=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 16/8/26 21:13, Marc-Andr=C3=83=C2=A9 Lureau wrote:
> > Guard SysemuCPUOps::monitor_defs field and the per-target MonitorDef
> > arrays with CONFIG_HMP. These tables are only used by HMP 'print' and
> > 'info registers' commands.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/hw/core/sysemu-cpu-ops.h | 2 ++
> >   monitor/hmp.c                    | 4 +++-
> >   target/i386/cpu.c                | 4 ++++
> >   target/m68k/cpu.c                | 4 ++++
> >   target/sparc/cpu.c               | 5 +++--
> >   5 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-=
cpu-ops.h
> > index 9a45596169a3..e56eea18b785 100644
> > --- a/include/hw/core/sysemu-cpu-ops.h
> > +++ b/include/hw/core/sysemu-cpu-ops.h
> > @@ -109,11 +109,13 @@ typedef struct SysemuCPUOps {
> >        */
> >       int (*monitor_get_register)(CPUState *cs, const char *name, int64=
_t *pval);
> >
> > +#ifdef CONFIG_HMP
> >       /**
> >        * @monitor_defs: Array of MonitorDef entries. This field is lega=
cy,
> >        *                use @gdb_core_xml_file to dump registers instea=
d.
> >        */
> >       const MonitorDef *monitor_defs;
> > +#endif
> >
> >       /**
> >        * @legacy_vmsd: Legacy state for migration.
> > diff --git a/monitor/hmp.c b/monitor/hmp.c
> > index e5f8b9c576e0..3c70adcd35bb 100644
> > --- a/monitor/hmp.c
> > +++ b/monitor/hmp.c
> > @@ -1725,13 +1725,15 @@ void monitor_register_hmp_info_hrt(const char *=
name,
> >   static int get_monitor_def(MonitorHMP *hmp, int64_t *pval, const char=
 *name)
> >   {
> >       CPUState *cs =3D monitor_hmp_get_cpu(hmp);
> > -    const MonitorDef *md;
> > +    const MonitorDef *md =3D NULL;
> >       void *ptr;
> >
> >       if (cs =3D=3D NULL) {
> >           return -1;
> >       }
> > +#ifdef CONFIG_HMP
> >       md =3D cs->cc->sysemu_ops->monitor_defs;
> > +#endif
> >       if (md =3D=3D NULL) {
> >           return -1;
> >       }
> Logically we need to skip more:
>
> -- >8 --
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 22b1972d346..cb4e070fc4c 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1726,12 +1726,13 @@ void monitor_register_hmp_info_hrt(const char *na=
me,
>   static int get_monitor_def(Monitor *mon, int64_t *pval, const char *nam=
e)
>   {
>       CPUState *cs =3D mon_get_cpu(mon);
> -    const MonitorDef *md;
> +    const MonitorDef *md =3D NULL;
>       void *ptr;
>
>       if (cs =3D=3D NULL) {
>           return -1;
>       }
> +#ifdef CONFIG_HMP
>       md =3D cs->cc->sysemu_ops->monitor_defs;
>       if (md =3D=3D NULL) {
>           return -1;
> @@ -1749,6 +1750,7 @@ static int get_monitor_def(Monitor *mon, int64_t
> *pval, const char *name)
>               return 0;
>           }
>       }
> +#endif
>

Yeah, I will add a note, the #ifdef is removed again with "build-sys:
make HMP source files conditional on have_hmp"

