Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A140EC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 07:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJptm-0003GN-MZ; Wed, 19 Jun 2024 03:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJptk-0003Fv-LO; Wed, 19 Jun 2024 03:38:28 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJpti-0003dw-L0; Wed, 19 Jun 2024 03:38:28 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a6efae34c83so762447466b.0; 
 Wed, 19 Jun 2024 00:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718782705; x=1719387505; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jF8YKmJky0ligZq+RqcjWXXMsYLR2HbkDS/UDSAExK0=;
 b=P5iCibzLLbtltYNauInainLA2MFEXxExfRNcw0hHrj08Ppq+vs+xaY21RwaB5twWlJ
 /w92WLP/yvHMMzkvacwysf+CmY5VeUFT3AnWrpCoubIa0tf4KZOGRl4peHAJtzKzJCw5
 Z5oCpNqCSlbO+Vl9sVucyQZclqBl6pshnrOBbUswtTJFnDMERsuvaY5NMrt8rsw9URKj
 Ey+es+qcjlbEdV8vZDPTDwHWHjAIWVaa3YrwIoM/dUNXTP68f0bttq+kDoIkHCIR/LZI
 tC4wszn64VJ/2NXum1Cv5ui4G8h0r0u9pg9stGiyvm6h1esE6Bjq/WBUaf4tKzpRRf1S
 Ejtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718782705; x=1719387505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jF8YKmJky0ligZq+RqcjWXXMsYLR2HbkDS/UDSAExK0=;
 b=nkK9oP9NWqGvqinRbr4NilB31WpHU9s6swHIPqlTcTDfXaq1NgqemTbtfJ2IOCvBkf
 2FAg2OToJVj4SwN1ms1F07rWVfhIegEq8XZGMlBM4OPm+n5CmhTS2/HvZ9+/W1vsKgeM
 M6Pudv/KyVfjCB06yZ0CReeNRsoF7f80EX+bpdp6Wfd1PWxWq8aZ2syC8/PYC5cyElpP
 Mu5s70pmAjbCk1YSccoUKnwBZ5fbpKV53iNTQzSqtcQZEMXF3lnpxiZpNJgpaT7hIBAW
 +9VTzRPXeGwiH1C87T12J1jdcxwT/stWSfzPFq0X+iIVq993nJmiCtvb14GNDZQ5Tz2f
 FY6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKD8JBXxLjbiUpu4a30I78aut/Q6tv5Z+GCU6QCThIGAkU0rfNT6MiEJQS6a6IyyzQ/5EjA71RfSigNLvSJOcWHcrhztaeHIE4NyTt64hGFGYjodwkOiqcreC10A==
X-Gm-Message-State: AOJu0YwMH6aOb8Po+lr81jXrJ4XBy0JYxTFbdk3G/tJDIpwE+jHQnCK6
 VZLIw6Bizsk0nSBtBj6BerjLVfT9sk0jelRIOIPDrdEiIp7DtXoTPW+DlaTvpdU8izu+RYhuD9I
 TNICgATu9VlCfyqmerovFI3iSzQ==
X-Google-Smtp-Source: AGHT+IGSPz563xfjLne2RLDqm8vIeoTIgb0D6hZ2gtkvKLzx8rrF+263Il4o1zABfVX/jblS152bVmVAYRToMHI+oFw=
X-Received: by 2002:a17:907:590:b0:a6f:b717:cb6 with SMTP id
 a640c23a62f3a-a6fb7171592mr17234066b.53.1718782704482; Wed, 19 Jun 2024
 00:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240618152328.3163680-1-zheyuma97@gmail.com>
 <896bbf08-7a3d-4a2c-b7f7-b260073255cb@linaro.org>
 <CAMhUBjmpYLFuRfsHACUjGvwfydEU7R89AEWToLAyo-0kQ-B41A@mail.gmail.com>
 <8feeec5d-4287-42f4-97a8-5d9cf9df4a72@linaro.org>
In-Reply-To: <8feeec5d-4287-42f4-97a8-5d9cf9df4a72@linaro.org>
From: Zheyu Ma <zheyuma97@gmail.com>
Date: Wed, 19 Jun 2024 09:38:13 +0200
Message-ID: <CAMhUBjnR6G=b_Mp9379FoWwTUVhXTKqY4hZLdMqwGRpjFLdURQ@mail.gmail.com>
Subject: Re: [PATCH] block: m25p80: Fix heap-buffer-overflow in flash_erase
 function
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008bfeef061b394845"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=zheyuma97@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000008bfeef061b394845
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Tue, Jun 18, 2024 at 10:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> On 18/6/24 21:11, Zheyu Ma wrote:
> > Thanks for your useful advice!
> >
> > So how about report the issue and return:
>
> We might report the issue to the user, but there should
> be a way the hardware report the issue to the guest software
> running. Usually signaled as error condition, irq, ...
> We need to figure out what check wasn't properly done.
> The spec is the source of truth.
>

Sure.
Although I'm unfamiliar with the device, I'll try to figure it out.

Zheyu

>
> > diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> > index 8dec134832..2121b43708 100644
> > --- a/hw/block/m25p80.c
> > +++ b/hw/block/m25p80.c
> > @@ -617,6 +617,12 @@ static void flash_erase(Flash *s, int offset,
> > FlashCMD cmd)
> >           abort();
> >       }
> >
> > +    if (offset + len > s->size) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "M25P80: Erase operation exceeds storage size\n"=
);
> > +        return;
> > +    }
> > +
> >       trace_m25p80_flash_erase(s, offset, len);
> >
> >       if ((s->pi->flags & capa_to_assert) !=3D capa_to_assert) {
> >
> > regards,
> > Zheyu
> >
> > On Tue, Jun 18, 2024 at 5:35=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> >
> >     Hi Zheyu,
> >
> >     On 18/6/24 17:23, Zheyu Ma wrote:
> >      > This patch fixes a heap-buffer-overflow issue in the flash_erase
> >     function
> >      > of the m25p80 flash memory emulation. The overflow occurs when t=
he
> >      > combination of offset and length exceeds the allocated memory fo=
r
> the
> >      > storage. The patch adds a check to ensure that the erase length
> >     does not
> >      > exceed the storage size and adjusts the length accordingly if
> >     necessary.
> >      >
> >      > Reproducer:
> >      > cat << EOF | qemu-system-aarch64 -display none \
> >      > -machine accel=3Dqtest, -m 512M -machine kudo-bmc -qtest stdio
> >      > writeq 0xc0000010 0x6
> >      > writel 0xc000000c 0x9
> >      > writeq 0xc0000010 0xf27f9412
> >      > writeq 0xc000000f 0x2b5cdc26
> >      > writeq 0xc000000c 0xffffffffffffffff
> >      > writeq 0xc000000c 0xffffffffffffffff
> >      > writeq 0xc000000c 0xffffffffffffffff
> >      > writel 0xc000000c 0x9
> >      > writeq 0xc000000c 0x9
> >      > EOF
> >      >
> >      > ASan log:
> >      > =3D=3D2614308=3D=3DERROR: AddressSanitizer: heap-buffer-overflow=
 on
> >     address 0x7fd3fb7fc000 at pc 0x55aa77a442dc bp 0x7fffaa155900 sp
> >     0x7fffaa1550c8
> >      > WRITE of size 65536 at 0x7fd3fb7fc000 thread T0
> >      >      #0 0x55aa77a442db in __asan_memset
> >     llvm/compiler-rt/lib/asan/asan_interceptors_memintrinsics.cpp:26:3
> >      >      #1 0x55aa77e7e6b3 in flash_erase hw/block/m25p80.c:631:5
> >      >      #2 0x55aa77e6f8b1 in complete_collecting_data
> >     hw/block/m25p80.c:773:9
> >      >      #3 0x55aa77e6aaa9 in m25p80_transfer8
> hw/block/m25p80.c:1550:13
> >      >      #4 0x55aa78e9a691 in ssi_transfer_raw_default
> hw/ssi/ssi.c:92:16
> >      >      #5 0x55aa78e996c0 in ssi_transfer hw/ssi/ssi.c:165:14
> >      >      #6 0x55aa78e8d76a in npcm7xx_fiu_uma_transaction
> >     hw/ssi/npcm7xx_fiu.c:336:9
> >      >      #7 0x55aa78e8be4b in npcm7xx_fiu_ctrl_write
> >     hw/ssi/npcm7xx_fiu.c:428:13
> >      >
> >      > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com
> >     <mailto:zheyuma97@gmail.com>>
> >      > ---
> >      >   hw/block/m25p80.c | 6 ++++++
> >      >   1 file changed, 6 insertions(+)
> >      >
> >      > diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> >      > index 8dec134832..e9a59f6616 100644
> >      > --- a/hw/block/m25p80.c
> >      > +++ b/hw/block/m25p80.c
> >      > @@ -617,6 +617,12 @@ static void flash_erase(Flash *s, int
> >     offset, FlashCMD cmd)
> >      >           abort();
> >      >       }
> >      >
> >      > +    if (offset + len > s->size) {
> >      > +        qemu_log_mask(LOG_GUEST_ERROR,
> >      > +                      "M25P80: Erase exceeds storage size,
> >     adjusting length\n");
> >
> >     Usually hardware doesn't "adjust" but report error earlier.
> >
> >      > +        len =3D s->size - offset;
> >      > +    }
> >      > +
> >      >       trace_m25p80_flash_erase(s, offset, len);
> >      >
> >      >       if ((s->pi->flags & capa_to_assert) !=3D capa_to_assert) {
> >
>
>

--0000000000008bfeef061b394845
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi=C2=A0Philippe,</div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 18, 2024 at =
10:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@l=
inaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">On 18/6/24 21:11, Zheyu Ma wrote:<br>
&gt; Thanks for your useful advice!<br>
&gt; <br>
&gt; So how about report the issue and return:<br>
<br>
We might report the issue to the user, but there should<br>
be a way the hardware report the issue to the guest software<br>
running. Usually signaled as error condition, irq, ...<br>
We need to figure out what check wasn&#39;t properly done.<br>
The spec is the source of truth.<br></blockquote><div><br>Sure.</div><div>A=
lthough I&#39;m unfamiliar with the device, I&#39;ll try to figure=C2=A0it =
out.<br><br>Zheyu</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c<br>
&gt; index 8dec134832..2121b43708 100644<br>
&gt; --- a/hw/block/m25p80.c<br>
&gt; +++ b/hw/block/m25p80.c<br>
&gt; @@ -617,6 +617,12 @@ static void flash_erase(Flash *s, int offset, <br=
>
&gt; FlashCMD cmd)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abort();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; + =C2=A0 =C2=A0if (offset + len &gt; s-&gt;size) {<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST_ERROR,<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;M25P80: Erase operation exceeds storage size\n&quot;);<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; + =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_m25p80_flash_erase(s, offset, len);<br=
>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt;pi-&gt;flags &amp; capa_to_assert=
) !=3D capa_to_assert) {<br>
&gt; <br>
&gt; regards,<br>
&gt; Zheyu<br>
&gt; <br>
&gt; On Tue, Jun 18, 2024 at 5:35=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <b=
r>
&gt; &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@lina=
ro.org</a> &lt;mailto:<a href=3D"mailto:philmd@linaro.org" target=3D"_blank=
">philmd@linaro.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi Zheyu,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On 18/6/24 17:23, Zheyu Ma wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; This patch fixes a heap-buffer-overflow issue=
 in the flash_erase<br>
&gt;=C2=A0 =C2=A0 =C2=A0function<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; of the m25p80 flash memory emulation. The ove=
rflow occurs when the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; combination of offset and length exceeds the =
allocated memory for the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; storage. The patch adds a check to ensure tha=
t the erase length<br>
&gt;=C2=A0 =C2=A0 =C2=A0does not<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; exceed the storage size and adjusts the lengt=
h accordingly if<br>
&gt;=C2=A0 =C2=A0 =C2=A0necessary.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Reproducer:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; cat &lt;&lt; EOF | qemu-system-aarch64 -displ=
ay none \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; -machine accel=3Dqtest, -m 512M -machine kudo=
-bmc -qtest stdio<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; writeq 0xc0000010 0x6<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; writel 0xc000000c 0x9<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; writeq 0xc0000010 0xf27f9412<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; writeq 0xc000000f 0x2b5cdc26<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; writeq 0xc000000c 0xffffffffffffffff<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; writeq 0xc000000c 0xffffffffffffffff<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; writeq 0xc000000c 0xffffffffffffffff<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; writel 0xc000000c 0x9<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; writeq 0xc000000c 0x9<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; EOF<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ASan log:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; =3D=3D2614308=3D=3DERROR: AddressSanitizer: h=
eap-buffer-overflow on<br>
&gt;=C2=A0 =C2=A0 =C2=A0address 0x7fd3fb7fc000 at pc 0x55aa77a442dc bp 0x7f=
ffaa155900 sp<br>
&gt;=C2=A0 =C2=A0 =C2=A00x7fffaa1550c8<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; WRITE of size 65536 at 0x7fd3fb7fc000 thread =
T0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 #0 0x55aa77a442db in __as=
an_memset<br>
&gt;=C2=A0 =C2=A0 =C2=A0llvm/compiler-rt/lib/asan/asan_interceptors_memintr=
insics.cpp:26:3<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 #1 0x55aa77e7e6b3 in flas=
h_erase hw/block/m25p80.c:631:5<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 #2 0x55aa77e6f8b1 in comp=
lete_collecting_data<br>
&gt;=C2=A0 =C2=A0 =C2=A0hw/block/m25p80.c:773:9<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 #3 0x55aa77e6aaa9 in m25p=
80_transfer8 hw/block/m25p80.c:1550:13<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 #4 0x55aa78e9a691 in ssi_=
transfer_raw_default hw/ssi/ssi.c:92:16<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 #5 0x55aa78e996c0 in ssi_=
transfer hw/ssi/ssi.c:165:14<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 #6 0x55aa78e8d76a in npcm=
7xx_fiu_uma_transaction<br>
&gt;=C2=A0 =C2=A0 =C2=A0hw/ssi/npcm7xx_fiu.c:336:9<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 #7 0x55aa78e8be4b in npcm=
7xx_fiu_ctrl_write<br>
&gt;=C2=A0 =C2=A0 =C2=A0hw/ssi/npcm7xx_fiu.c:428:13<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Signed-off-by: Zheyu Ma &lt;<a href=3D"mailto=
:zheyuma97@gmail.com" target=3D"_blank">zheyuma97@gmail.com</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:zheyuma97@gmail.com" t=
arget=3D"_blank">zheyuma97@gmail.com</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; ---<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0hw/block/m25p80.c | 6 ++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A01 file changed, 6 insertions(+)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; diff --git a/hw/block/m25p80.c b/hw/block/m25=
p80.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; index 8dec134832..e9a59f6616 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; --- a/hw/block/m25p80.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +++ b/hw/block/m25p80.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; @@ -617,6 +617,12 @@ static void flash_erase(=
Flash *s, int<br>
&gt;=C2=A0 =C2=A0 =C2=A0offset, FlashCMD cmd)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abort=
();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (offset + len &gt; s-&gt;si=
ze) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LO=
G_GUEST_ERROR,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;M25P80: Erase exceeds storage size=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0adjusting length\n&quot;);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Usually hardware doesn&#39;t &quot;adjust&quot; but=
 report error earlier.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D s-&gt;si=
ze - offset;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_m25p80_flash_=
erase(s, offset, len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt;pi-&gt;f=
lags &amp; capa_to_assert) !=3D capa_to_assert) {<br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000008bfeef061b394845--

