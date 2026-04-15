Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C617F419B6
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0P9-0003Ob-8A; Wed, 15 Apr 2026 09:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wD0P7-0003OE-K1
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:35:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wD0P5-0006Oc-PO
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776260138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/LWM0XH+w9Th+O2oAJaXQO5PwnUtriZnxXEiyxgAhAY=;
 b=dZ21gyBZqWWoQKUPMJ2nFugWSbjOlDtE8NkS+eNdetssXTEZmu5zsbrdh3Xm3NgeD5KdTd
 AP5d0J7EjBX1keYj4mAcHDdNzRhHRvQWLcmNWRmCSvH9+xhxaBxGh2atw5Jp9IzaAAj/MG
 qVHZu3/nnBY+GPAN7yLorK+QgTK0dL8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-1VeL6PYbMUKbhbg_appEYQ-1; Wed, 15 Apr 2026 09:35:35 -0400
X-MC-Unique: 1VeL6PYbMUKbhbg_appEYQ-1
X-Mimecast-MFC-AGG-ID: 1VeL6PYbMUKbhbg_appEYQ_1776260134
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-46f083f82c7so11095619b6e.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 06:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776260134; cv=none;
 d=google.com; s=arc-20240605;
 b=h5v0IEqMpY87PhlI617jzFX7GY2dE2r1aCU995lCBjmbw63q+I/n2/If3ZxiKffxpD
 e5ORLoWh8Q+7JPsFP01UUBIhBd5SYujjeIJZL1Do8v7TUj41Mm4K0wfiO2zwdVHysYWj
 bipTadjT6JexjaXWgUKSnY8FlCZJMCKoiiyF7XFe+dSJdCJl8fXWXV6N64U2WbrC88Qj
 0NmjHE/OPrOGyiSgaZfgwXz1Qpf6J8I1ALN+6RNDWqw1SZmUWnVeMV32KVBHI21/lT3m
 ntVutQXhyqSnpvIcLZe0lbs8v0EzXqy9nSTJd4iSjQ2c97VsYrdg0S9Kh3RarrmkW1gB
 7MTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/LWM0XH+w9Th+O2oAJaXQO5PwnUtriZnxXEiyxgAhAY=;
 fh=ey4PBSvBqeQkg4f2UbbK4rf17z3h5yS3KmmMBcBtgh4=;
 b=MsI64z3/Jrbn+AmbxIAd6MHAAgl+ImHrujUo+gBrJr0Oof4ugt2Ct1HOJWSlfaruJN
 bHLs8fOPTxizmCkKUeYTEuMiCydcbp2LuI1ZYp90TYvLc5cPuvhXadME14tY1wHCXxlV
 ve7uQ+0Of5WrpZSciXkbiMtjyGS3DehZ6ZM9vzxm5TTWCkYpDieG+Eixld69L4XtM+9W
 vPFxRbc8l1jHEUIXrlpR9cu6HRZW5V9av3gxOh4Jy2ij0R4/nJqNZdyIm1MBQ5g65M6Y
 91/T6t8WZMloUiIqbDwKWhyTdbl8S6jniQ5K+UkL+ZUMOCLCc0x3lqlQZHnCDWPVxgoQ
 URQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776260134; x=1776864934; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/LWM0XH+w9Th+O2oAJaXQO5PwnUtriZnxXEiyxgAhAY=;
 b=RgFCDCWauqjSzW7nxMM7VOMdxIl2siGD7SB6nmaCXLO2l7+R81FMqHgDRRjubdksk+
 oqZqOhdNCH5Hq+ge/sOYxMKjaECwz8skhFEBTwy4bWVPa/M2zgRBtsZQAc8slQGC5bTx
 oJ8tr1xQtW8cyefnriaXBbUCl0HXtO38R2ZJUkvsKvnlIVD6Iuox0+ygytnk248nYhJR
 Ur2c/FMdTl9HrIW3J/TBXMG9Ydba/HJU+sqivt4cwY7z6zUAj+sf/PllHZGuNURMiMMS
 RnrUibcA1hlovnjw4agDPFB2pjDBpf3IiTgpTZd1dS7DHRLT5VW/NetvC8hq7SCWVQXK
 XFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776260134; x=1776864934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/LWM0XH+w9Th+O2oAJaXQO5PwnUtriZnxXEiyxgAhAY=;
 b=qXgjz7CJQeLF3KJQJ8Y+ua97f7nhiNJwxDiksuTW2muFc2+KJhfJlELQ8Mufe/XBiu
 nFJC0rHopB/q+pwhDcgwrItNlFR58CXoW/sk7rzbUrItNveQcqtPBOetM3j+wggqlEV7
 4RzyULmUFkCvLca9voPmIIM6fr6kbK+n4HmNY2X2UblVF0BdQsCkQ+YqrASjlXrLGPdN
 kw1TZmSHDpD1EHXMmUS5yMIcJLa72bu3u1zkjhWGs1ytAOhhkcow8W8A9HnsqeWPolY/
 M6VbYTvr1EyS1lMU/JSbJN2t+DPzpKTSTFzCcBB1eGpYe9Hzs8OOymJ0d0SKhs2D/UX6
 O6pg==
X-Gm-Message-State: AOJu0YwI9lhoEBNiUhUuPEl03ihXJy+CJ+gRajmqSvyHThakZx9VotK4
 QG+O8cZsLtwCbM6fsEs/ctR3G1ZqZp7AKS5kdVe6PTjbuny1gtjR7fzHh0JuDeExjxiyREDFgTb
 v/sYti9dygs2eZsR0zS2ma14FhYnXdi5SGs+HuVVRwiXRloEZw1vUzFWE84fXgB+WMcdaYG5GN1
 LWELdbDPJ5dfF1209vf0T5R0w3DycPPFc=
X-Gm-Gg: AeBDievVDrJiev/julGM//S7UPRMK+M2+8HGfKUtp2MYQyh3+YIJUA/QenFgx4adxfu
 ncvPbbm9Oycx3TpUUPGr93llXBXjnWmbHWQ0b7yjSw5VkCwLC+aHSGzlpgAa8qS8TIXvvfiwcMg
 gVi+zJlSe3Jkd8amwyCTRg/DDEaVxtJkcENNCfmhk5IUIbIRdQbTYY6wMAXWXjIqyYxW+7Cj/Y3
 MuwhUkp9Hk2Q0W4iTPpGLR4R70wloQzINkld8caMiWGQQ==
X-Received: by 2002:a05:6820:2fc2:b0:68e:58ef:c9b9 with SMTP id
 006d021491bc7-68e58efe2edmr6417928eaf.36.1776260134454; 
 Wed, 15 Apr 2026 06:35:34 -0700 (PDT)
X-Received: by 2002:a05:6820:2fc2:b0:68e:58ef:c9b9 with SMTP id
 006d021491bc7-68e58efe2edmr6417909eaf.36.1776260133995; Wed, 15 Apr 2026
 06:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260406141735.25844-1-armenon@redhat.com>
 <20260406141735.25844-4-armenon@redhat.com>
 <CAMxuvayywHuA4X8G8gfuOnW9MTP5BLuNayOTJq_k423pdFDKGg@mail.gmail.com>
In-Reply-To: <CAMxuvayywHuA4X8G8gfuOnW9MTP5BLuNayOTJq_k423pdFDKGg@mail.gmail.com>
From: Arun Menon <armenon@redhat.com>
Date: Wed, 15 Apr 2026 19:04:55 +0530
X-Gm-Features: AQROBzBLmyvOzYA6bMjjIf3LuV5Il3qp0jvaVC1C-x67oSmF4tjyOYAr-TOnUTc
Message-ID: <CAE_eyq-rb6c6E2F=DerkHDzEgvCNeUQbEo5CcSnx-KPCDPE+=w@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] hw/tpm: Add internal buffer state for chunking
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 07, 2026 at 11:56:58AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> On Mon, Apr 6, 2026 at 6:18=E2=80=AFPM Arun Menon <armenon@redhat.com> wr=
ote:
> >
> > From: Arun Menon <armenon@redhat.com>
> >
> > - Introduce GByteArray buffers to hold the command request and response
> >   data during chunked TPM CRB transactions.
> > - Add helper function to clean them.
> >
> > Signed-off-by: Arun Menon <armenon@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> > ---
> >  hw/tpm/tpm_crb.c | 34 ++++++++++++++++++++++++++++++----
> >  1 file changed, 30 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > index bc55908786..d65b3e2cc1 100644
> > --- a/hw/tpm/tpm_crb.c
> > +++ b/hw/tpm/tpm_crb.c
> > @@ -38,10 +38,13 @@ struct CRBState {
> >      TPMBackend *tpmbe;
> >      TPMBackendCmd cmd;
> >      uint32_t regs[TPM_CRB_R_MAX];
> > +    size_t be_buffer_size;
> >      MemoryRegion mmio;
> >      MemoryRegion cmdmem;
> >
> > -    size_t be_buffer_size;
> > +    GByteArray *command_buffer;
> > +    GByteArray *response_buffer;
> > +    uint32_t response_offset;
> >
> >      bool ppi_enabled;
> >      TPMPPI ppi;
> > @@ -85,6 +88,13 @@ enum crb_cancel {
> >
> >  #define TPM_CRB_NO_LOCALITY 0xff
> >
> > +static void tpm_crb_clear_internal_buffers(CRBState *s)
> > +{
> > +    g_byte_array_set_size(s->response_buffer, 0);
> > +    g_byte_array_set_size(s->command_buffer, 0);
> > +    s->response_offset =3D 0;
> > +}
> > +
> >  static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
> >                                    unsigned size)
> >  {
> > @@ -134,9 +144,11 @@ static void tpm_crb_mmio_write(void *opaque, hwadd=
r addr,
> >          }
> >          break;
> >      case A_CRB_CTRL_CANCEL:
> > -        if (val =3D=3D CRB_CANCEL_INVOKE &&
> > -            s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
> > -            tpm_backend_cancel_cmd(s->tpmbe);
> > +        if (val =3D=3D CRB_CANCEL_INVOKE) {
> > +            if (s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
> > +                tpm_backend_cancel_cmd(s->tpmbe);
> > +            }
> > +            tpm_crb_clear_internal_buffers(s);
> >          }
> >          break;
> >      case A_CRB_CTRL_START:
> > @@ -240,6 +252,7 @@ static void tpm_crb_reset(void *dev)
> >          tpm_ppi_reset(&s->ppi);
> >      }
> >      tpm_backend_reset(s->tpmbe);
> > +    tpm_crb_clear_internal_buffers(s);
> >
> >      memset(s->regs, 0, sizeof(s->regs));
> >
> > @@ -306,6 +319,9 @@ static void tpm_crb_realize(DeviceState *dev, Error=
 **errp)
> >      memory_region_add_subregion(get_system_memory(),
> >          TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
> >
> > +    s->command_buffer =3D g_byte_array_new();
> > +    s->response_buffer =3D g_byte_array_new();
> > +
> >      if (s->ppi_enabled) {
> >          tpm_ppi_init(&s->ppi, get_system_memory(),
> >                       TPM_PPI_ADDR_BASE, OBJECT(s));
> > @@ -318,12 +334,22 @@ static void tpm_crb_realize(DeviceState *dev, Err=
or **errp)
> >      }
> >  }
> >
> > +static void tpm_crb_unrealize(DeviceState *dev)
> > +{
> > +    CRBState *s =3D CRB(dev);
> > +
> > +    g_byte_array_unref(s->command_buffer);
> > +    g_byte_array_unref(s->response_buffer);
>
> I have a preference for g_clear_pointer(&ptr, g_byte_array_unref), it
> is safer, but unrealize() should only be called once after realize()
> so ok.

Thanks for the tip. I have updated it to use g_clear_pointer in the next
revision.

>
> > +
> > +}
> > +
> >  static void tpm_crb_class_init(ObjectClass *klass, const void *data)
> >  {
> >      DeviceClass *dc =3D DEVICE_CLASS(klass);
> >      TPMIfClass *tc =3D TPM_IF_CLASS(klass);
> >
> >      dc->realize =3D tpm_crb_realize;
> > +    dc->unrealize =3D tpm_crb_unrealize;
> >      device_class_set_props(dc, tpm_crb_properties);
> >      dc->vmsd  =3D &vmstate_tpm_crb;
> >      dc->user_creatable =3D true;
> > --
> > 2.53.0
> >
>

Regards,
Arun Menon


