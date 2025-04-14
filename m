Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EF9C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 16:53:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4N3D-0000m5-KO; Mon, 14 Apr 2025 12:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1u4N3B-0000lm-FX
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:52:49 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1u4N37-0000Kg-Ve
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:52:48 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6fece18b3c8so43279477b3.3
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 09:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744649562; x=1745254362; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X/Lgh4hAs4+5AIw7g07yLu2dtfLPZQjYViU8643LlS0=;
 b=W7r2a3PsSFsF9vy1oxSdE6MlliHi3w4JhcdF17yFlfrJHE7yaHp284f2DQUV/1Rdtk
 wJWGF/MN0ECa7duirgVzsB5arJtX1yWZnTVl2LdMnzD+QDqwN8QElmwPZ9oE/W9SAc5E
 R0h7i8k0+boye4s7QqLEfOEN3WVu3/qY/QVetGPwPMDuDMRtESMDAwkMAMeq5NEAHkrZ
 cdTLsYFBDG+bIgcp80r5ZAKxc1+tXVsYw21cKZ1mtiX0Huz+2lFeVrKJjSVkGjwLmStm
 raeP3ocDNFzxin768O7yoMFx4WPS2OPFxdPjesjR6F4Zs439gDng3jYJl/n64BpcaF0K
 Ecdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744649562; x=1745254362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X/Lgh4hAs4+5AIw7g07yLu2dtfLPZQjYViU8643LlS0=;
 b=MefpPMTZSlLpQkdX8KtyaalQzrLZ+97Q52cPCwZ9k2GFgkJ0jYt5yyjJ6ojOQQrQLj
 AAMGKrEN9/wIYckricHlvjf4aGbYi8HKazvfuXNLS1Zf68/pidTsDom2T2gGYMt6mNvm
 zgjDTP0QET+nttTZqvHq/YiX3niAlED86Zye8muOQ76p4N01sCQrQNSMND8zQG+VAfcF
 HBop24TjVlXMDDzMN9Ukr2WOWa0DXbR+Mo6FVnGNgb8I0ocOzeG0Kx2G79DD6x8vlBSe
 sasAMbTlZZbsMCliDTt3GY3YOPo5YSPsldJcTIf32uA/sTG6MHSiXwEOniDMSR3zB3zu
 2M5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXbPaTi2jeGF/o1REhiAA2u889nU9PM8eZna6Mkco+JmfgWWRzqrzpjx+4rkjuljjOc+ZzVGtkgyUM@nongnu.org
X-Gm-Message-State: AOJu0YzQhqo03aLkf+9hSm9fgfUwH7JbRjSgHgyq7CQWkK53jsIIho1a
 CcsqXVM+5iWmVYUzAE1gS64jybh1Amdc/l1Na0LFg1NRCQ0ogbK/8ydEZDH2vmAmnkXgker7cQf
 AqExdySPn5UoFOPo4jj1qL2+Vy0E=
X-Gm-Gg: ASbGncuE5mBJiZzDuPXnD6ITGjhKuVBY9WWihsdKWC7IxFAXG3Hm+oKd11C4m7Ph09d
 RoVWYOWp6ul9OkVZHGMoP7opU7nrYBXJs5QTTPfNaPiETNkJmdydBLZbpRXcTPVk6hTgLEhVXWq
 qtyJJE7XNWDavOskLZ8ETGxFCnW+V9S5Zf
X-Google-Smtp-Source: AGHT+IEZVvUtc5XlUFMy7InQBMlipa5t5WcSNa9LRZ4iRE1ydc0eTOy/MQkmcwVaO/5JwuBao/9EF1JagL/HFqYTDYI=
X-Received: by 2002:a81:be19:0:b0:705:5ab0:ea07 with SMTP id
 00721157ae682-7055ab0eaf0mr185652877b3.2.1744649562103; Mon, 14 Apr 2025
 09:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-3-anisa.su887@gmail.com>
 <20250318155624.00006410@huawei.com>
 <Z-rvRZUTUpT2Kv-S@deb-101020-bm01.eng.stellus.in>
In-Reply-To: <Z-rvRZUTUpT2Kv-S@deb-101020-bm01.eng.stellus.in>
From: Anisa Su <anisa.su887@gmail.com>
Date: Mon, 14 Apr 2025 09:52:31 -0700
X-Gm-Features: ATxdqUHt8uipDFcrABnDmnOcHfPJ9PPDwjJPN2wtmBkQ5__9CsZAsZ3uFM6T_QM
Message-ID: <CA+1mjcmnsXhtwpPop3TaB=UiYM-9qFZSuT5iXTaodhodsVVmrQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
To: Anisa Su <anisa.su@samsung.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, linux-cxl@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000682a650632bfe10e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=anisa.su887@gmail.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000682a650632bfe10e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Any update on this?

Thanks,
Anisa

On Mon, Mar 31, 2025 at 12:38=E2=80=AFPM Anisa Su <anisa.su@samsung.com> wr=
ote:

> On Tue, Mar 18, 2025 at 03:56:24PM +0000, Jonathan Cameron wrote:
> > On Mon, 17 Mar 2025 16:31:29 +0000
> > anisa.su887@gmail.com wrote:
> >
> > > From: Anisa Su <anisa.su@samsung.com>
> > >
> > > FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section
> 7.6.7.6.1
> > >
> > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > --- a/hw/cxl/i2c_mctp_cxl.c
> > > +++ b/hw/cxl/i2c_mctp_cxl.c
> > > @@ -46,6 +46,9 @@
> > >  /* Implementation choice - may make this configurable */
> > >  #define MCTP_CXL_MAILBOX_BYTES 512
> > >
> > > +/* Supported FMAPI Cmds */
> > > +#define FMAPI_CMD_MAX_OPCODE 0x57
> > > +
> > >  typedef struct CXLMCTPMessage {
> > >      /*
> > >       * DSP0236 (MCTP Base) Integrity Check + Message Type
> > > @@ -200,7 +203,8 @@ static void
> i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
> > >          if (!(msg->message_type =3D=3D MCTP_MT_CXL_TYPE3 &&
> > >                msg->command_set < 0x51) &&
> > >              !(msg->message_type =3D=3D MCTP_MT_CXL_FMAPI &&
> > > -              msg->command_set >=3D 0x51 && msg->command_set < 0x56)=
) {
> > > +              msg->command_set >=3D 0x51 &&
> > > +              msg->command_set < FMAPI_CMD_MAX_OPCODE)) {
> >
> > Hmm. There is a visibility problem here we should address but probably
> not
> > by introducing a new define.  Maybe we should move the enum from
> > cxl-mailbox-utils.c in a precursor patch.
> >
> > Jonathan
> Thanks for the feedback and review Jonathan.
>
> According to the comment above this condition, "Any command forming part
> of the CXL FM-API command set... is valid only with the CXL Fabric
> Manager API over MCTP binding (DSP0234)."
>
> From my understanding, this check is to ensure that any message
> sent from the FM API command set (0x51 - 0x59) has the MCTP_MT_CXL_FMAPI
> binding and all other commands (opcode < 0x51) are are sent with the
> MCTP_MT_CXL_TYPE3 binding.
>
> Although I see from r3.2 Table 8-230 CXL Defined FM API Command Opcodes
> that commands from sets 0x57-0x59 are prohibited from being implemented
> in the MCTP CCI, would it be more correct to change the condition for
> FMAPI commands  to msg->command_set < 0x59? Then if/when commands from se=
ts
> 0x57-0x59 are implemented, if they are implemented according to the spec,
> they
> should not be added to the FM MCTP CCI.
>
> Please correct my understanding if this is incorrect.
>
> Regarding the visibility problem, I intend to move the enum defining all
> the
> opcodes in cxl-mailbox.utils.c to cxl-mailbox.h and including cxl-mailbox=
.h
> in i2c_mctp_cxl.c
>
> Let me know if that is what you intended.
>
> Other than that, I have removed the extraneous TO-DO's from the other
> patches and plan to send out v2 with relevant corrections soon.
> Hopefully that makes the remaining patches easier for you to review.
>
> Thanks,
> Anisa
>
>
> >
> >
> > >              buf->rc =3D CXL_MBOX_UNSUPPORTED;
> > >              st24_le_p(buf->pl_length, len_out);
> > >              s->len =3D s->pos;
> >
>

--000000000000682a650632bfe10e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jonathan,<div><br></div><div>Any update on=C2=A0this?</=
div><div><br></div><div>Thanks,</div><div>Anisa</div></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Mon, Mar 31, 2025 at 12:38=E2=80=AFPM Anisa Su &lt;<a href=3D"mailto:a=
nisa.su@samsung.com">anisa.su@samsung.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On Tue, Mar 18, 2025 at 03:56:24PM=
 +0000, Jonathan Cameron wrote:<br>
&gt; On Mon, 17 Mar 2025 16:31:29 +0000<br>
&gt; <a href=3D"mailto:anisa.su887@gmail.com" target=3D"_blank">anisa.su887=
@gmail.com</a> wrote:<br>
&gt; <br>
&gt; &gt; From: Anisa Su &lt;<a href=3D"mailto:anisa.su@samsung.com" target=
=3D"_blank">anisa.su@samsung.com</a>&gt;<br>
&gt; &gt; <br>
&gt; &gt; FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Sec=
tion 7.6.7.6.1<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Anisa Su &lt;<a href=3D"mailto:anisa.su@samsung.co=
m" target=3D"_blank">anisa.su@samsung.com</a>&gt;<br>
&gt; &gt; --- a/hw/cxl/i2c_mctp_cxl.c<br>
&gt; &gt; +++ b/hw/cxl/i2c_mctp_cxl.c<br>
&gt; &gt; @@ -46,6 +46,9 @@<br>
&gt; &gt;=C2=A0 /* Implementation choice - may make this configurable */<br=
>
&gt; &gt;=C2=A0 #define MCTP_CXL_MAILBOX_BYTES 512<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; +/* Supported FMAPI Cmds */<br>
&gt; &gt; +#define FMAPI_CMD_MAX_OPCODE 0x57<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 typedef struct CXLMCTPMessage {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0* DSP0236 (MCTP Base) Integrity Check +=
 Message Type<br>
&gt; &gt; @@ -200,7 +203,8 @@ static void i2c_mctp_cxl_handle_message(MCTPI=
2CEndpoint *mctp)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(msg-&gt;message_type =3D=
=3D MCTP_MT_CXL_TYPE3 &amp;&amp;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg-&gt;co=
mmand_set &lt; 0x51) &amp;&amp;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !(msg-&gt;message=
_type =3D=3D MCTP_MT_CXL_FMAPI &amp;&amp;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg-&gt;command=
_set &gt;=3D 0x51 &amp;&amp; msg-&gt;command_set &lt; 0x56)) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg-&gt;command=
_set &gt;=3D 0x51 &amp;&amp;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg-&gt;command=
_set &lt; FMAPI_CMD_MAX_OPCODE)) {<br>
&gt; <br>
&gt; Hmm. There is a visibility problem here we should address but probably=
 not<br>
&gt; by introducing a new define.=C2=A0 Maybe we should move the enum from<=
br>
&gt; cxl-mailbox-utils.c in a precursor patch.<br>
&gt; <br>
&gt; Jonathan<br>
Thanks for the feedback and review Jonathan.<br>
<br>
According to the comment above this condition, &quot;Any command forming pa=
rt<br>
of the CXL FM-API command set... is valid only with the CXL Fabric<br>
Manager API over MCTP binding (DSP0234).&quot;<br>
<br>
From my understanding, this check is to ensure that any message<br>
sent from the FM API command set (0x51 - 0x59) has the MCTP_MT_CXL_FMAPI<br=
>
binding and all other commands (opcode &lt; 0x51) are are sent with the<br>
MCTP_MT_CXL_TYPE3 binding.<br>
<br>
Although I see from r3.2 Table 8-230 CXL Defined FM API Command Opcodes<br>
that commands from sets 0x57-0x59 are prohibited from being implemented<br>
in the MCTP CCI, would it be more correct to change the condition for<br>
FMAPI commands=C2=A0 to msg-&gt;command_set &lt; 0x59? Then if/when command=
s from sets<br>
0x57-0x59 are implemented, if they are implemented according to the spec, t=
hey<br>
should not be added to the FM MCTP CCI.<br>
<br>
Please correct my understanding if this is incorrect.<br>
<br>
Regarding the visibility problem, I intend to move the enum defining all th=
e<br>
opcodes in cxl-mailbox.utils.c to cxl-mailbox.h and including cxl-mailbox.h=
<br>
in i2c_mctp_cxl.c<br>
<br>
Let me know if that is what you intended.<br>
<br>
Other than that, I have removed the extraneous TO-DO&#39;s from the other<b=
r>
patches and plan to send out v2 with relevant corrections soon.<br>
Hopefully that makes the remaining patches easier for you to review.<br>
<br>
Thanks,<br>
Anisa<br>
<br>
<br>
&gt; <br>
&gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf-&gt;rc =3D CX=
L_MBOX_UNSUPPORTED;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 st24_le_p(buf-&gt=
;pl_length, len_out);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;len =3D s-&=
gt;pos;<br>
&gt; <br>
</blockquote></div>

--000000000000682a650632bfe10e--

