Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A6EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 18:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwnWM-0005lh-Rc; Tue, 16 Apr 2024 14:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sameer.kp.in@gmail.com>)
 id 1rwnW7-0005jK-QT; Tue, 16 Apr 2024 14:26:52 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sameer.kp.in@gmail.com>)
 id 1rwnW5-0008EO-DI; Tue, 16 Apr 2024 14:26:51 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dbed179f0faso27045276.1; 
 Tue, 16 Apr 2024 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713292007; x=1713896807; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LFTof1Wg7no12PiAsRLVMCl4MBNOxk9HANIk+soz1l0=;
 b=YUiUlpDjgw17L5sjjsZ5w2K1v+Mbvs0c8DIq3Vk3Q/YR3FMb8oYFRgTxz1hJu38fXk
 G0Wg/35lC/H4FQXduj6ViR4fAUg2l7oE66gDx27HxFWyuRUwPn9FbEdBvCSZt7mOtj6Z
 62u7aanxIr+IiAW3iAjoOEckZJYnJZ9TAhDzqoLlUWgFad49tcI0IXXk9lfp/tnueXEt
 EaUdFL+sMweYnsQGUo05fn59LTVZnOG0SRQes82Kgi6mhM0o1rX5DWOidDe9sE5Bw+0z
 BnA08SqHfF3fzBfq6as8RxrAZKL085yiwJERwRA+C/FcWgg1loEjwfb3XoIlO16uPc8Q
 8GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713292007; x=1713896807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LFTof1Wg7no12PiAsRLVMCl4MBNOxk9HANIk+soz1l0=;
 b=Atk0otJiTxIA3zUbjr8iXfC6hos8zkMtm7RTSXyjaRFF83PhYLqqYp/CHp1i9nMN+R
 keL8MftGCaBbziyMFK5o5zPWijJMfTg+0AIILSFxaZB8f6jdmKxG7BaKMStCnbG1JQ2V
 3zVbZKAbNNFv24eJ7pNZQ2xMYF0vJJ+K84ZlUm3kPawCkzYG7NNxlN8W4g3otRsnrlFh
 qsjZ03lZ1i7P5V9IxB+aoBjAzc2GCr3QU89EUeFQzKatWg4pv48z8HZ7YeegqSpKmEMo
 b0cPVYaNZJ60yWPOtS2QI6FPIexD8Y1kuEny5eYSv89Gr9vubZ3+tfSu81SnRhke+xR6
 wZRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdQimUa+UQ8cq5bntHzPvGNL14RghWSvDPBQC7ycYZQK0jAfnxRMw3/VC5mbC3FH+ZScXJvTD65q5RGsF97Mz8cEpaZcj6/k6KkSPMGE8wmjqA156X7CV/3jiZNkrY
X-Gm-Message-State: AOJu0Ywsm9x9oAcrpxi0R411pHydrAK2ohyVpP4Xik7Rq9DYt+raikex
 JJJI48gr0RANAjGhqUlD8/B7ywvoL4hbM5NHOvNxKzI8ITwAsX10bCk7CEaZEO6KiXorcTyurjX
 /87JUGbcg/+iNUS6VShLcVhUTh+4=
X-Google-Smtp-Source: AGHT+IH5y8vrx7N4qCnYfgz+h+XOGrV0W8h+bGl/kYmUKr0cNAENlr2ebijU0a9loKSmVuexfiaKz1F/JIcTsEPqrGY=
X-Received: by 2002:a25:aaf4:0:b0:dc2:2f3f:2148 with SMTP id
 t107-20020a25aaf4000000b00dc22f3f2148mr2201572ybi.29.1713292006874; Tue, 16
 Apr 2024 11:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAAA2AK8p=RtqeNZXfnqprw+kqEBTvrQo1Va81+ctfYAT6k6jnA@mail.gmail.com>
 <07e79630-7171-4cb5-829d-a87a8165adc5@linaro.org>
 <gqzmd4roytmeq3hbtb4b4frhomqtcn4aje4wja7bwmbrvb5dfh@oumkvbg3uah3>
In-Reply-To: <gqzmd4roytmeq3hbtb4b4frhomqtcn4aje4wja7bwmbrvb5dfh@oumkvbg3uah3>
From: Sameer Kalliadan Poyil <sameer.kp.in@gmail.com>
Date: Tue, 16 Apr 2024 14:26:10 -0400
Message-ID: <CAAA2AK-tMmG079EAuqmZ7QNWiP1yXNbCfk+4FW8ypgB4hmeDsw@mail.gmail.com>
Subject: Re: Qemu for TC377
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-discuss@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000077655806163ae12c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=sameer.kp.in@gmail.com; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000077655806163ae12c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastian,

Thanks for the information. I thought that I can do some prototyping before
the HW arrives. :)

 Yes I am interested for your bare metal program boot_to_main run it on
TSIM.
Is Infineon TSIM free? I searched it and I didn't find any download link.
Could you please give a link for that if it is from Infineon?

s it(TSIM)  trace32 simulator ? *https://repo.lauterbach.com/download_demo.=
html
<https://repo.lauterbach.com/download_demo.html> *?

This page *https://wiki.qemu.org/Documentation/Platforms/TriCore
<https://wiki.qemu.org/Documentation/Platforms/TriCore>* shows SCU is under
development.

Could you let me know who is developing it ? is  it possible to take an
existing SCU and modify according to AURIX data sheet? I see that UART is
possible to for Tricore like the one developed for ARM versatile platform

Here is the link
*https://mail.gnu.org/archive/html/qemu-devel/2016-10/msg04514.htm
<https://mail.gnu.org/archive/html/qemu-devel/2016-10/msg04514.htm>*l

I have aurix development trial version and able to compile a UART
project using Tasking compiler and tried to run it on qemu, but I don't see
any logs in the qemu terminal as you said there is no peripherals
implemented

qemu-system-tricore -machine KIT_AURIX_TC277_TRB -cpu tc27x -m 6M
-nographic -kernel ASCLIN_Shell_UART_1_KIT_TC277_TFT.elf  -serial stdio
-append "console=3DttyAMA0 console=3DttyS0"


Also do you know if there is a virtual UART framework to communicate
between two Qemu instances or two TSIM instances running similar OS or
different OS? I need to do prototype testing RPMSg communication between
MCU and SOC using external physical UART/SPI which can be tested using
vritual UART using two qemu instances.



Regards,
Sameer

On Mon, Apr 15, 2024 at 7:51=E2=80=AFAM Bastian Koppelmann <
kbastian@mail.uni-paderborn.de> wrote:

> Hi Sameer,
> On Sun, Apr 14, 2024 at 06:15:56PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi Sameer,
> >
> > On 13/4/24 14:52, Sameer Kalliadan Poyil wrote:
> > > Hello All,
> > > I see that Latest qemu supports for tricore TC277 and TC377
> > > image.png
> > > But when I downloaded source code and checked for TC377 related file =
,
> I
> > > didn't find anything
> > >
> > > I want to run RTOS/bare metal code on TC377 . could you please let me
> > > know how to start qemu on TC377 ?
> > > Here is the latest version of qemu i have , I didn't download 9.0
> >
> > $ qemu-system-tricore -cpu help
> > Available CPUs:
> >   tc1796
> >   tc1797
> >   tc27x
> >   tc37x
> > $
> >
> > Try 'qemu-system-tricore -machine KIT_AURIX_TC277_TRB -cpu tc37x',
> > this should start a TC377 SoC on an AURIX board (~KIT_A2G_TC377_TRB).
>
> This is the closest you will get to TC377 board.
>
> I'm not sure if QEMU is the best choice for you, if you want run a RTOS, =
as
> qemu-system-tricore is lacking:
>
> - peripherals like SCU, SystemTimer that are a bare minimum to run a RTOS
>
> - Simulation of time: When your RTOS runs periodic tasks you might get
> wrong
>   results, as QEMU does not simulate time accurately. The real CPU would
>   see time pass differently than QEMU. We make a best guess using the wal=
l
> time.
>
> I think for now Infineons TSIM is a better choice, as it does not lack th=
e
> points above. However it has significantly less performance compared to
> QEMU.
>
> If you are only interested in running bare metal software, check out my
> 'boot_to_main' test [1]. The Makefile [2] shows you how to build it using
> tricore-gcc [3] and how to run it in QEMU. Also tricore-gdb [4] might be
> interesting for you.
>
> If you have further questions, feel free to ask me.
>
> Cheers,
> Bastian
>
> [1]
> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/tcg/tricore/c/te=
st_boot_to_main.c?ref_type=3Dheads
> [2]
> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/tcg/tricore/Make=
file.softmmu-target?ref_type=3Dheads
> [3] https://github.com/bkoppelmann/package_494
> [4] https://github.com/volumit/gdb-tricore
>

--00000000000077655806163ae12c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Bastian,<br><br>Thanks for the information. I thought t=
hat I can do some prototyping before the HW arrives. :)<br><br>=C2=A0Yes I =
am interested for your bare metal program=C2=A0boot_to_main run it on TSIM.=
=C2=A0=C2=A0<br>Is Infineon TSIM free? I searched it and=C2=A0I didn&#39;t =
find any download link. Could you please give a link for that if it is from=
 Infineon?<br><div><br></div><div>s it(TSIM)=C2=A0 trace32 simulator ? <b><=
a href=3D"https://repo.lauterbach.com/download_demo.html">https://repo.laut=
erbach.com/download_demo.html</a> </b>? <br><br>This page=C2=A0<b><a href=
=3D"https://wiki.qemu.org/Documentation/Platforms/TriCore">https://wiki.qem=
u.org/Documentation/Platforms/TriCore</a></b> shows SCU is under developmen=
t.</div><div><br>Could you let me know who is developing=C2=A0it ?=C2=A0is=
=C2=A0 it possible to take an existing SCU and modify according to AURIX da=
ta sheet? I see that UART is possible to for Tricore like the one developed=
 for ARM versatile platform<br><br>Here is the link <b><a href=3D"https://m=
ail.gnu.org/archive/html/qemu-devel/2016-10/msg04514.htm">https://mail.gnu.=
org/archive/html/qemu-devel/2016-10/msg04514.htm</a></b>l<br><br>I have aur=
ix development=C2=A0trial version and able to compile a UART project=C2=A0u=
sing Tasking compiler and tried to run it on qemu, but I don&#39;t see any =
logs in the qemu terminal=C2=A0as you said there is no peripherals implemen=
ted <br><br>qemu-system-tricore -machine KIT_AURIX_TC277_TRB -cpu tc27x -m =
6M -nographic -kernel ASCLIN_Shell_UART_1_KIT_TC277_TFT.elf =C2=A0-serial s=
tdio -append &quot;console=3DttyAMA0 console=3DttyS0&quot;<br><br></div><di=
v><br></div><div>Also do you know if there is a virtual UART framework to c=
ommunicate between two Qemu instances or two TSIM instances=C2=A0running si=
milar OS or different OS? I need to do prototype testing RPMSg communicatio=
n between=C2=A0 MCU and SOC using external physical UART/SPI which can be t=
ested using vritual=C2=A0UART using two qemu instances.=C2=A0<br><br><br><b=
r>Regards,<br>Sameer<br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Apr 15, 2024 at 7:51=E2=80=AFAM Basti=
an Koppelmann &lt;<a href=3D"mailto:kbastian@mail.uni-paderborn.de" target=
=3D"_blank">kbastian@mail.uni-paderborn.de</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">Hi Sameer,<br>
On Sun, Apr 14, 2024 at 06:15:56PM +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:<br>
&gt; Hi Sameer,<br>
&gt; <br>
&gt; On 13/4/24 14:52, Sameer Kalliadan Poyil wrote:<br>
&gt; &gt; Hello All,<br>
&gt; &gt; I see that Latest qemu supports for tricore TC277 and TC377<br>
&gt; &gt; image.png<br>
&gt; &gt; But when I downloaded source code and checked for TC377 related f=
ile , I<br>
&gt; &gt; didn&#39;t find anything<br>
&gt; &gt; <br>
&gt; &gt; I want to run RTOS/bare metal code on TC377 . could you please le=
t me<br>
&gt; &gt; know how to start qemu on TC377 ?<br>
&gt; &gt; Here is the latest version of qemu i have , I didn&#39;t download=
=C2=A09.0<br>
&gt; <br>
&gt; $ qemu-system-tricore -cpu help<br>
&gt; Available CPUs:<br>
&gt;=C2=A0 =C2=A0tc1796<br>
&gt;=C2=A0 =C2=A0tc1797<br>
&gt;=C2=A0 =C2=A0tc27x<br>
&gt;=C2=A0 =C2=A0tc37x<br>
&gt; $<br>
&gt; <br>
&gt; Try &#39;qemu-system-tricore -machine KIT_AURIX_TC277_TRB -cpu tc37x&#=
39;,<br>
&gt; this should start a TC377 SoC on an AURIX board (~KIT_A2G_TC377_TRB).<=
br>
<br>
This is the closest you will get to TC377 board. <br>
<br>
I&#39;m not sure if QEMU is the best choice for you, if you want run a RTOS=
, as<br>
qemu-system-tricore is lacking:<br>
<br>
- peripherals like SCU, SystemTimer that are a bare minimum to run a RTOS<b=
r>
<br>
- Simulation of time: When your RTOS runs periodic tasks you might get wron=
g<br>
=C2=A0 results, as QEMU does not simulate time accurately. The real CPU wou=
ld<br>
=C2=A0 see time pass differently than QEMU. We make a best guess using the =
wall time.<br>
<br>
I think for now Infineons TSIM is a better choice, as it does not lack the<=
br>
points above. However it has significantly less performance compared to QEM=
U.<br>
<br>
If you are only interested in running bare metal software, check out my<br>
&#39;boot_to_main&#39; test [1]. The Makefile [2] shows you how to build it=
 using<br>
tricore-gcc [3] and how to run it in QEMU. Also tricore-gdb [4] might be<br=
>
interesting for you.<br>
<br>
If you have further questions, feel free to ask me.<br>
<br>
Cheers,<br>
Bastian<br>
<br>
[1] <a href=3D"https://gitlab.com/qemu-project/qemu/-/blob/master/tests/tcg=
/tricore/c/test_boot_to_main.c?ref_type=3Dheads" rel=3D"noreferrer" target=
=3D"_blank">https://gitlab.com/qemu-project/qemu/-/blob/master/tests/tcg/tr=
icore/c/test_boot_to_main.c?ref_type=3Dheads</a><br>
[2] <a href=3D"https://gitlab.com/qemu-project/qemu/-/blob/master/tests/tcg=
/tricore/Makefile.softmmu-target?ref_type=3Dheads" rel=3D"noreferrer" targe=
t=3D"_blank">https://gitlab.com/qemu-project/qemu/-/blob/master/tests/tcg/t=
ricore/Makefile.softmmu-target?ref_type=3Dheads</a><br>
[3] <a href=3D"https://github.com/bkoppelmann/package_494" rel=3D"noreferre=
r" target=3D"_blank">https://github.com/bkoppelmann/package_494</a><br>
[4] <a href=3D"https://github.com/volumit/gdb-tricore" rel=3D"noreferrer" t=
arget=3D"_blank">https://github.com/volumit/gdb-tricore</a><br>
</blockquote></div>

--00000000000077655806163ae12c--

