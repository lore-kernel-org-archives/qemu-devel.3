Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93219CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 19:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3fyn-0003Zd-V7; Tue, 30 Sep 2025 15:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yubinz@google.com>) id 1v3fyk-0003ZK-Rc
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 15:25:39 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yubinz@google.com>) id 1v3fyc-0001hi-Tg
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 15:25:38 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-62faa04afd9so2085a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 12:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1759260324; x=1759865124; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qqHguemmuaBeQjOcMdhjoGD+aUF1ah3HFfnAophTSMA=;
 b=R05y+ScPkEQ1wABP2piO+fLhAT4tSuwlOPho8aCSj1zktFTnYHJ9oEdz28pHieUk4g
 HMD4o/uNkX60BCkQuehjK2GOZVQlcrovVDMAYo9IVXrVvbKponA9G07qPjTq0mQWcBIW
 PW5yuXjii/rTnzgWjAxYbgnMGdg8ZQu4d33CurF3TrMioWKbAG54fTmp5Lw8uxnOipUk
 ZAq8gkhJnO9USufHSSnQuhpEQvEloe0Lfcl0IJd352PJJr4cPliMASMi363QwVJxpGTq
 5hPVr770+9G2JZpOzvSgsUf2OL1TAkt5nfVKWDOJ6FhxMgWwO92onjO0OAD8HnWYMJSX
 7DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759260324; x=1759865124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qqHguemmuaBeQjOcMdhjoGD+aUF1ah3HFfnAophTSMA=;
 b=JiUB6nbbXqMV0Z4g65XchDGdq8rrjjqHOm8NgGwnvBO2vhNriKdePVnTfqKXuZyJod
 ampnbCsFd2T4SMYglj9v5Wj2I0mmMhzOMEAnbvcnS1wYQSl//73+VlQD1EacI7iKv02I
 BrLkrrwbXKQFxODKYnV6jC28ukipcb50Y2t2TzY3w9IyZMjtiUrahD5TvhR9JgXQWU5c
 +Vb04BrGXLQ6l87tQlbT4Ke2kqAuegaygJP/yvql399TlC8qSx0mxA6xd/FaiSO4gtjs
 hLNjP2NSg3693ORWWkefDwVLuk815CUJsYc3tW60Pn2l6c+mFRrnQWkfRzRKkOgjqXJg
 CD0A==
X-Gm-Message-State: AOJu0YxHxv+Jj9hITACi9ZF49THCf3SuM0XLz4uIKbZoDYaeDBgg07dY
 6RRN0q0enctVZN3TTbRIsmHvCU41JR1zbAxialZTTS1+Uf9/utxJv9qMKpmqN+vc16u3xT5Cw0q
 znvN//PadI7SQhfjPuY4XYNI50CXrTa/NyWDZxpp4
X-Gm-Gg: ASbGncuLZ8MZx5wvisGBJyjtVxtF6xf71LR/oSKBkht03qzsDxm6YT9usEvblbb+NSC
 O7AW/xpF52Jkb2q03+FdXgyr3JHjCYN6NbqcSnnp9GN3/gRzyjoIU5ehCgTbiialqw/N1t5Vhmd
 6RJK5ssH1u2DpTApsR/5JR4syyFJQQHRBz1zFfNAR73clphRJ2Wg/xjzx4o3Htaldt3WcA7vi3U
 d9DY5EP+kVG/cW3bq/pkFBaHNTfU2Sjyigc25Hb7iwtlqZw2XIPcVMnCDf3hfnHxvhZDkpjHxpp
 1HWsHYFsV14UQA==
X-Google-Smtp-Source: AGHT+IElC65yuE1FPh777GW8WfCXG4ndzs5Yvw4PZgZ4AhcT5KljZt1UGhG/UqbQxEPi8otB90zT+USiiyIaz1OUY9g=
X-Received: by 2002:a50:d71d:0:b0:62f:9f43:2117 with SMTP id
 4fb4d7f45d1cf-6367a952f6dmr24978a12.0.1759260323966; Tue, 30 Sep 2025
 12:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250916-quanta-q71l-eeproms-v1-0-3648692cc441@google.com>
 <20250916-quanta-q71l-eeproms-v1-1-3648692cc441@google.com>
 <37f60533-8e6b-496c-850b-16aff7fb7be3@kaod.org>
In-Reply-To: <37f60533-8e6b-496c-850b-16aff7fb7be3@kaod.org>
From: Yubin Zou <yubinz@google.com>
Date: Tue, 30 Sep 2025 12:25:12 -0700
X-Gm-Features: AS18NWCD9QzUrrvcVyrkfIdxIG61t1M-VFNsCVekM-H58-VFbJc7sA3bq6oHSd0
Message-ID: <CABU_6B+PVUAxc8HLNvP8ym=hRM27StXjhJcc+e1j6i8OkEDwxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/arm: add eeproms to quanta-q7l1 board
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 Patrick Venture <venture@google.com>
Content-Type: multipart/alternative; boundary="000000000000ae476d064009b66a"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=yubinz@google.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

--000000000000ae476d064009b66a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cedric

Could you clarify what functional test you are referring to?

Thanks
Yubin

On Tue, Sep 16, 2025 at 11:10=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.or=
g> wrote:

> Hi,
>
> On 9/16/25 19:50, Yubin Zou wrote:
> > From: Patrick Venture <venture@google.com>
> >
> > Adds eeprom init for aspeed helper method and adds 24c64 eeproms to the
> > quanta-q71l bmc board.
> >
> > Tested: Booted quanta-q71l bmc firmware to userspace.
>
> Could you please provide a FW image and functional test for the
> quanta-q7l1 board ?
>
> Thanks,
>
> C.
>
>
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
> >   hw/arm/aspeed.c | 15 ++++++++++-----
> >   1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> > index
> c31bbe7701381f6980e874f9fca51805ff9fb9b4..bae59ae7394882e3fc93863049a37ff=
5a8737ff8
> 100644
> > --- a/hw/arm/aspeed.c
> > +++ b/hw/arm/aspeed.c
> > @@ -561,14 +561,17 @@ static void
> quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
> >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1),
> "tmp105", 0x4e);
> >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 1),
> "tmp105", 0x4f);
> >
> > -    /* TODO: i2c-1: Add baseboard FRU eeprom@54 24c64 */
> > -    /* TODO: i2c-1: Add Frontpanel FRU eeprom@57 24c64 */
> > +    /* Baseboard FRU */
> > +    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x54, 8192);
> > +    /* Frontpanel FRU */
> > +    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 1), 0x57, 8192);
> >       /* TODO: Add Memory Riser i2c mux and eeproms. */
> >
> >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> "pca9546", 0x74);
> >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
> "pca9548", 0x77);
> >
> > -    /* TODO: i2c-3: Add BIOS FRU eeprom@56 24c64 */
> > +    /* Add BIOS FRU */
> > +    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 3), 0x56, 8192);
> >
> >       /* i2c-7 */
> >       i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
> "pca9546", 0x70);
> > @@ -577,8 +580,10 @@ static void
> quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
> >       /*        - i2c@2: pmbus@58 */
> >       /*        - i2c@3: pmbus@59 */
> >
> > -    /* TODO: i2c-7: Add PDB FRU eeprom@52 */
> > -    /* TODO: i2c-8: Add BMC FRU eeprom@50 */
> > +    /* PDB FRU */
> > +    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 7), 0x52, 8192);
> > +    /* BMC FRU */
> > +    at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 8), 0x50, 8192);
> >   }
> >
> >   static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
> >
>
>

--000000000000ae476d064009b66a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Cedric</div><div=
><br></div><div>Could you clarify what functional test you=C2=A0are referri=
ng to?</div><div><br></div><div>Thanks</div><div>Yubin</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 16, 2025=
 at 11:10=E2=80=AFPM C=C3=A9dric Le Goater &lt;<a href=3D"mailto:clg@kaod.o=
rg" target=3D"_blank">clg@kaod.org</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On 9/16/25 19:50, Yubin Zou wrote:<br>
&gt; From: Patrick Venture &lt;<a href=3D"mailto:venture@google.com" target=
=3D"_blank">venture@google.com</a>&gt;<br>
&gt; <br>
&gt; Adds eeprom init for aspeed helper method and adds 24c64 eeproms to th=
e<br>
&gt; quanta-q71l bmc board.<br>
&gt; <br>
&gt; Tested: Booted quanta-q71l bmc firmware to userspace.<br>
<br>
Could you please provide a FW image and functional test for the<br>
quanta-q7l1 board ?<br>
<br>
Thanks,<br>
<br>
C.<br>
<br>
<br>
&gt; Signed-off-by: Patrick Venture &lt;<a href=3D"mailto:venture@google.co=
m" target=3D"_blank">venture@google.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/arm/aspeed.c | 15 ++++++++++-----<br>
&gt;=C2=A0 =C2=A01 file changed, 10 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c<br>
&gt; index c31bbe7701381f6980e874f9fca51805ff9fb9b4..bae59ae7394882e3fc9386=
3049a37ff5a8737ff8 100644<br>
&gt; --- a/hw/arm/aspeed.c<br>
&gt; +++ b/hw/arm/aspeed.c<br>
&gt; @@ -561,14 +561,17 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachi=
neState *bmc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_slave_create_simple(aspeed_i2c_get_bus(&=
amp;soc-&gt;i2c, 1), &quot;tmp105&quot;, 0x4e);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_slave_create_simple(aspeed_i2c_get_bus(&=
amp;soc-&gt;i2c, 1), &quot;tmp105&quot;, 0x4f);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 /* TODO: i2c-1: Add baseboard FRU eeprom@54 24c64 */<br=
>
&gt; -=C2=A0 =C2=A0 /* TODO: i2c-1: Add Frontpanel FRU eeprom@57 24c64 */<b=
r>
&gt; +=C2=A0 =C2=A0 /* Baseboard FRU */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
1), 0x54, 8192);<br>
&gt; +=C2=A0 =C2=A0 /* Frontpanel FRU */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
1), 0x57, 8192);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* TODO: Add Memory Riser i2c mux and eeprom=
s. */<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_slave_create_simple(aspeed_i2c_get_bus(&=
amp;soc-&gt;i2c, 2), &quot;pca9546&quot;, 0x74);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_slave_create_simple(aspeed_i2c_get_bus(&=
amp;soc-&gt;i2c, 2), &quot;pca9548&quot;, 0x77);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 /* TODO: i2c-3: Add BIOS FRU eeprom@56 24c64 */<br>
&gt; +=C2=A0 =C2=A0 /* Add BIOS FRU */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
3), 0x56, 8192);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* i2c-7 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0i2c_slave_create_simple(aspeed_i2c_get_bus(&=
amp;soc-&gt;i2c, 7), &quot;pca9546&quot;, 0x70);<br>
&gt; @@ -577,8 +580,10 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachin=
eState *bmc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 =C2=A0 =C2=A0 =C2=A0 - i2c@2: pmbus=
@58 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 =C2=A0 =C2=A0 =C2=A0 - i2c@3: pmbus=
@59 */<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 /* TODO: i2c-7: Add PDB FRU eeprom@52 */<br>
&gt; -=C2=A0 =C2=A0 /* TODO: i2c-8: Add BMC FRU eeprom@50 */<br>
&gt; +=C2=A0 =C2=A0 /* PDB FRU */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
7), 0x52, 8192);<br>
&gt; +=C2=A0 =C2=A0 /* BMC FRU */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(aspeed_i2c_get_bus(&amp;soc-&gt;i2c, =
8), 0x50, 8192);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void ast2500_evb_i2c_init(AspeedMachineState *bmc)<=
br>
&gt; <br>
<br>
</blockquote></div></div>
</div>
</div>

--000000000000ae476d064009b66a--

