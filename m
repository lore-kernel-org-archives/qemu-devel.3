Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DEEC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjlpc-00015O-9f; Mon, 11 Mar 2024 16:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbagley@ventanamicro.com>)
 id 1rjlpM-0000oG-7P
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:01:01 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbagley@ventanamicro.com>)
 id 1rjlpE-0000sv-Av
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:00:51 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d29111272eso77541161fa.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 13:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710187242; x=1710792042; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l+yO87h2Ei1vz2fQlzVyep68f9aqisqvE95jng9eQho=;
 b=ixKFG6ja2ndu1qINNOY6uqiwCW3aVBjLY3bWLcbzGBNQkWTLbgZjG4zR/NddDlcC1F
 B7t/5dRed9TJhgHTxDvpGRYn15Cdfyssgvhd00hjpT+Z8iG3RZSMI0kZWNuChkc2J3zK
 GUM1PjJzRK/+JHgSxKVTV+vtunMduJiZHW1jIE+wAfH1/PoPxfidxrG1n0BxIoD5vGbq
 ANoD/jhpLIGFCFBLEu7uMyYny4ZPthDU1taWibdoSlUVApaSMRlhwRyYTSj8Yeat6Dqx
 fFWeTSUJfiIawdnxqrog2G2uVLNuuRQqbYAgeHwIywUtjGvPQti1rGV4GFaW/ou4d94j
 UI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710187242; x=1710792042;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l+yO87h2Ei1vz2fQlzVyep68f9aqisqvE95jng9eQho=;
 b=feHSufc9A3QB+ZJmkdVwTjhi5RRZseQm0p0R8lal1EnXc4KTKo2QgUPZn8kv5DagBJ
 NychBKu5Q3ydtNQq67A/eRtBFVv/0MnIWhlWaTxTIVrwlBZm3P2bOk3VUJPXJdgprlii
 x8pTsxjsqvTiZmJ0uH/+lD+DD6El599tX/TuzeJCPWtMmKramZFgtUeaonRcspVpjSPs
 qHW87AV4e4TlkEIwijYrvKDeuzNfnYWgq8BvPlnmBvxJWXGIP7R5aRMt2d5ZHQ1jLMgw
 AqlPcMHyZlGSv4kfgtZ9aky4o0otiLtzv9J9/AbHDdFP7gU5x+Jwk5vNcBxxoUqrCCDq
 25Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4DGNiYo4UH9zsgEMShLYQ9mZc5rjiM5yU4uijIhhRL/37+nXa4cjbCoV9+P7HDjKPYkD5k6TyR/tTjjn2bqmzsSvXupI=
X-Gm-Message-State: AOJu0Yz9OksKHgLn72t0Rcp5/21lpi2jQBCcHB3/pUhnNZHcylVsbynT
 4Npk8jwcKZZA/sq9DLCh90vUISq33n10NiiCwVgnO4KjIWoxVtvs3tseZf8ZPHRZmccIdeYn0gt
 tXIUtzzFTFsE11iwkSXI3/S20msKagbHaFiBzjg==
X-Google-Smtp-Source: AGHT+IEkWW72t3AM1ZSb0xM6OpIyO+NIXf2g7lSGAHzHxFOpDr+G0OqrycTsCYyVtOfKLhea4p6L4WHxmOi0+3zof5I=
X-Received: by 2002:ac2:528a:0:b0:513:3f24:28d8 with SMTP id
 q10-20020ac2528a000000b005133f2428d8mr4538449lfm.34.1710187241603; Mon, 11
 Mar 2024 13:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230810-c9e1f2783168b48bc07a1aa2@orel>
 <mhng-a6344a0c-8820-41b5-a015-b82b261b463d@palmer-ri-x1c9>
 <20230810-e160f9edae60ded9d2606b8b@orel>
 <20230811-bc15b48d336b79d9ec1f0936@orel>
 <20230811-52e2c90dc3b91e108eb5e4e8@orel>
 <CAARkPA-P1U7xyLpdx+XD1M3Ji2NUfTb+88+GKUk8R2aFsOCMRw@mail.gmail.com>
 <CAARkPA-dOxOWsR0VS+S8p4fDmNR5X5Jjmo5pQTaurWLYsc9vsw@mail.gmail.com>
 <20240309-ee813e971e7c5850d652b295@orel>
 <CAARkPA_8zSZK-4oOTcJO2KinWSadxZYZztwRP-UvNNkDjmyexw@mail.gmail.com>
In-Reply-To: <CAARkPA_8zSZK-4oOTcJO2KinWSadxZYZztwRP-UvNNkDjmyexw@mail.gmail.com>
From: Richard Bagley <rbagley@ventanamicro.com>
Date: Mon, 11 Mar 2024 13:00:28 -0700
Message-ID: <CAARkPA_fYPQ2KXMe3nNcaKi+fTz36gTrF88-RkK7ha5vXNLgcA@mail.gmail.com>
Subject: Re: [PATCH] disas/riscv: Further correction to LUI disassembly
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, 
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com
Content-Type: multipart/alternative; boundary="000000000000092cb2061367ff3e"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=rbagley@ventanamicro.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

--000000000000092cb2061367ff3e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LUI and AUIPC would naturally be used to build an address.
If you want to supply a signed decimal number to build an immediate, there
is always the pseudo-instruction LI.

On Mon, Mar 11, 2024 at 11:56=E2=80=AFAM Richard Bagley <rbagley@ventanamic=
ro.com>
wrote:

> I have realized that *the patch is indeed a fix*, not a workaround.
>
> In fact, the argument to LUI and AUIPC in assembly *must* be a number
> between [0x0, 0xfffff].
> RISC-V Assembly Programmer's Manual : Load Upper Immediate's Immediate
> <https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv-asm.=
md#load-upper-immediates-immediate>
> Signed decimal numbers are programmed as their two's complement.
>
> I checked: neither GCC nor LLVM will assemble
>
>> lui x1, -4
>
> The LLVM compiled models the arguments to LUI and AUIPC as UIMM (unsigned
> immediate) or UIMM20 (20 bit unsigned immediate).
>
> I should have checked this from the start. I jumped to the conclusion tha=
t
> both formats (signed decimal, two's complement) for negative arguments
> should be supported, and that I was encountering a bug.
> I apologize to all for the unnecessary back-and-forth.
>
> I don't yet see a reason why llvm and gcc could not support a signed
> number in decimal format, perhaps requiring a pseudo-instruction.
> This might be desirable, if only in support of assembly programming.
> On the other hand, it is easy to make the conversion to a two's-complemen=
t
> number.
>
> Richard
>
> On Sat, Mar 9, 2024 at 4:01=E2=80=AFAM Andrew Jones <ajones@ventanamicro.=
com>
> wrote:
>
>> On Fri, Mar 08, 2024 at 08:22:01PM -0800, Richard Bagley wrote:
>> > post-nack, one further comment:
>> >
>> > One could argue that this change also aligns QEMU with supporting tool=
s
>> (as
>> > Andrew observed), and it makes sense to merge this change into QEMU
>> until
>> > those tools update to supporting signed decimal numbers with immediate=
s.
>> >
>> > As it is, both GNU assembler and the LLVM integrated assembler (or
>> llvm-mc)
>> > throws an error with examples such as
>> > auipc s0, -17
>> >
>> > On the other hand, I have only seen this problem with the output of th=
e
>> > COLLECT plug-in, not (as yet) with QEMU execution proper.
>> > If the problem is confined to COLLECT, perhaps the argument for aligni=
ng
>> > with other tools is not as strong.
>> >
>> > In the meantime, I have adjusted my change locally to include AUIPC, a=
nd
>> > written a substantive, and I hope, clear commit description.
>> > If you would like me to resubmit a patch with this updated change,
>> please
>> > let me know.
>>
>> Since the patch is ready for posting, then it might as well be posted
>> (even if it may not get merged right away). If the issue arises again,
>> then we can refer to the latest proposed patch, which will be preserved
>> in the mail archives.
>>
>> Thanks,
>> drew
>>
>

--000000000000092cb2061367ff3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">LUI and AUIPC would naturally be used to build an address.=
<br>If you want to supply a signed decimal number to build an immediate, th=
ere is always the pseudo-instruction LI.</div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 11, 2024 at 11:56=E2=80=
=AFAM Richard Bagley &lt;<a href=3D"mailto:rbagley@ventanamicro.com">rbagle=
y@ventanamicro.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div dir=3D"ltr"><font face=3D"verdana, sans-serif">I hav=
e realized that <b>the patch is indeed a fix</b>, not a workaround.</font><=
div><font face=3D"verdana, sans-serif"><br>In fact, the argument to LUI and=
 AUIPC in assembly=C2=A0<b>must</b>=C2=A0be a number between=C2=A0<span sty=
le=3D"color:rgb(31,35,40)">[0x0, 0xfffff]</span><span style=3D"color:rgb(31=
,35,40);font-size:16px">.</span><br><a href=3D"https://github.com/riscv-non=
-isa/riscv-asm-manual/blob/master/riscv-asm.md#load-upper-immediates-immedi=
ate" target=3D"_blank">RISC-V Assembly Programmer&#39;s Manual : Load Upper=
 Immediate&#39;s Immediate</a><br>Signed decimal numbers are programmed as =
their two&#39;s complement.</font></div><div><span style=3D"font-family:ver=
dana,sans-serif"><br></span></div><div><span style=3D"font-family:verdana,s=
ans-serif">I checked: neither GCC nor LLVM will assemble <br></span><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><span style=3D"font-family:verda=
na,sans-serif">lui x1, -4</span></blockquote><font face=3D"verdana, sans-se=
rif">The LLVM compiled models the arguments to=C2=A0LUI and AUIPC as UIMM (=
unsigned immediate) or UIMM20 (20 bit unsigned immediate).<br><br>I should =
have checked this from the start. I jumped to the conclusion that both form=
ats (signed decimal, two&#39;s complement) for negative arguments should be=
 supported, and that I was encountering=C2=A0a bug.</font></div><div><font =
face=3D"verdana, sans-serif">I apologize to all for the unnecessary back-an=
d-forth.<br><br>I don&#39;t yet see a=C2=A0reason why llvm and gcc could no=
t support a signed number in decimal format, perhaps requiring a pseudo-ins=
truction. <br>This might be desirable, if only in support of assembly progr=
amming. <br>On the other hand, it is easy to make the conversion to a two&#=
39;s-complement number.<br><br>Richard</font></div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Mar 9, 2024 at 4=
:01=E2=80=AFAM Andrew Jones &lt;<a href=3D"mailto:ajones@ventanamicro.com" =
target=3D"_blank">ajones@ventanamicro.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On Fri, Mar 08, 2024 at 08:22:01PM=
 -0800, Richard Bagley wrote:<br>
&gt; post-nack, one further comment:<br>
&gt; <br>
&gt; One could argue that this change also aligns QEMU with supporting tool=
s (as<br>
&gt; Andrew observed), and it makes sense to merge this change into QEMU un=
til<br>
&gt; those tools update to supporting signed decimal numbers with immediate=
s.<br>
&gt; <br>
&gt; As it is, both GNU assembler and the LLVM integrated assembler (or llv=
m-mc)<br>
&gt; throws an error with examples such as<br>
&gt; auipc s0, -17<br>
&gt; <br>
&gt; On the other hand, I have only seen this problem with the output of th=
e<br>
&gt; COLLECT plug-in, not (as yet) with QEMU execution proper.<br>
&gt; If the problem is confined to COLLECT, perhaps the argument for aligni=
ng<br>
&gt; with other tools is not as strong.<br>
&gt; <br>
&gt; In the meantime, I have adjusted my change locally to include AUIPC, a=
nd<br>
&gt; written a substantive, and I hope, clear commit description.<br>
&gt; If you would like me to resubmit a patch with this updated change, ple=
ase<br>
&gt; let me know.<br>
<br>
Since the patch is ready for posting, then it might as well be posted<br>
(even if it may not get merged right away). If the issue arises again,<br>
then we can refer to the latest proposed patch, which will be preserved<br>
in the mail archives.<br>
<br>
Thanks,<br>
drew<br>
</blockquote></div>
</blockquote></div>

--000000000000092cb2061367ff3e--

