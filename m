Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD20C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16kL-0000O3-3j; Mon, 31 Aug 2026 14:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x16kJ-0000Nc-FI
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:28:39 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1x16kH-00017w-GU
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:28:39 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c20e70a0962so506062866b.2
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788200915; cv=none;
 d=google.com; s=arc-20260327;
 b=EJOhI3jAvwml9YlzD5NN8LaVaqkGvSUTd7zjUi8Djva48ddY18w0zp/VGJi10Nyxcg
 UQs9ePGgj2qFts96Ih8wHsTyWdHBmb39+RE0EhIw5PUfSxgd/AAoCfomo+pPb83WiapK
 ZVk/zlAQ2O6jsgslG7QQjjbqkTmE6ACfApN/+vZ0gcHn3GgcZ9CFJNdL8zd4qD4yYzz4
 jHX4PoYaMX9ghRu/i3FozX1STuNBQ0uOnv+6BRtSjkkZ/BkYQ5UggJWSrX1yUMG1hWih
 VXgUG1FYw9zjcNuSVI9Yrc3uIYy5605xCx1L+d77+BlFVn9PyUpN6+pGQPoC4ekNUY67
 EEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WZeh7YRDMd6x/MDcm+yBpsoleJjrisCON/xSER/1DBg=;
 fh=n/zNZN9dqTCusjQvNYBOdRBkhvSzYyORfWIx175mIms=;
 b=RkLBgDB7O1oG1RmsfzDjTd4kvJ0o+OoQveOy/yXGPCkcXyyu6tWXagpDPryCaIa8Vq
 llxH/N1BdFMaaiqLTOWobae8z1t0nc6k9GBzkC1jskX/b3oN9m6Q8SFGWCVWdJhNPoo+
 khaNbk9x/eRkgPcOZyiSoWk8EUwGX5fknMwMhsg5USJMIkL72ARbXwXDH8tXSFFuPUz9
 CPBsF6TA7p+GAoAZzBzs9NMgWJlUQTsPXBd2NzpjIq6x9FXl+EnNGkP7D/9AQGna0peW
 9gXQ0WO3y148iOgNKyizBGsUlGUpOe4K7KoJBrApUgM8fBgsi3UatewgLK7If/Y5t/+4
 lHQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788200915; x=1788805715; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WZeh7YRDMd6x/MDcm+yBpsoleJjrisCON/xSER/1DBg=;
 b=oSG9tigvQkVaf3Exot6X+bOQ9HsyvYJJs+dmxbIKfaJF9ask8MAoqE/CQ1ypXwpUDM
 eRx8WWUHilCVSit/72L/IHdmjDMXFb1NYABSvzkLWFXuP1sX3fcbX1YuWBvFezjEB5NQ
 0SyFdTMBNc6v+wDGvkFWRkmSmAePcqzaOiYhdaAzt6ewqF1Poo2VKruLnjGC0UGm/ccA
 B2k8pfcGXiB8f5blrKD7RWmiijES/+MXszy8GaCXz5ec/Vu4mSCDZ/30sztcoELEEsSv
 geXMkCnZdcnpgF4PQDJYABjTUzwUrDn4exAmKRE+eROCU4WN/6izyGePvd96KlwdbQ3r
 nTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788200915; x=1788805715;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WZeh7YRDMd6x/MDcm+yBpsoleJjrisCON/xSER/1DBg=;
 b=aDYnPnE0sFthyoqxCTiw8EadoGt0NwQWBk37oRWrQxb0mEyfP5aiTnh64ZYDkLTRVk
 GFImCF+3LabqtTw/tZvu/jYji4RQrt+KEKDsRMR/CyqIDePQx+p38XlNo9/6Uwy6mSfG
 2el1opZIluXbYKE+iWzrAMdElSUwultk002Mc/0M3xHCMLBrPn+wh3b+o8oQSfcYsgKx
 3BCbYAD9DZ3aTVi+BL+r9W8k/OBUizb0zOoA9o8vGg9DhePQ7hDpfuuxDiJPeQKHQh4I
 rZcxWtkjgCo6M06iXDheLFbqq2fEAblc0g8F4yjZg373kA7TcHtOyoi83AM1k71EE3kw
 4UVQ==
X-Gm-Message-State: AFuF++lUjuE5c87jeCHKaxbHslB2YtncARnlybxpY2PXkCIKXn9jv9xo
 Y+fUhBZ106F0F1DpwV/XfWLTgkHECJCaxB0zyDSLu0vpvdwib+FP5j4WhxOj1Atu8LK9lmHnWIr
 simFWympd5pCQShT12xJNS/+fK6V5QNk=
X-Gm-Gg: AR+sD12zDbZ8oK9RdgiQXT5yXiKDQyBP5rGZ0pww2MVromgvFVrdPb70yWVtqNH9+wx
 S108X+XxF+cS8syFIfXxiTJd8iXSmA1PXcdwsEvwVkLr/8rVTRiTSnpn4imM5HMf1suiORdGo0E
 rxKmNGwFj5+F6iLM/4pLeliJCu32T7BwhqnLQuy3A+C8dSU5b4mpADeNqO7OL4sAfdUtPZashx6
 TyxBIRLEUhAYRqGTwbG0w5HIXeL/aVV40AbmfiPpIaYo7yD9wUGw8AjaHnxT+BY3qsv/JMI49UM
 J21Rmu6MgmddQLBhxiSLJ6u/AJyoeDLdM6Xidx30g57g
X-Received: by 2002:a17:907:73cd:b0:c24:b11a:470f with SMTP id
 a640c23a62f3a-c25b39d698cmr177537966b.0.1788200915448; Mon, 31 Aug 2026
 11:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-23-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE_HU9RO-pQVmrAv76k-oJshpNEgNE64fWb7AN+-eySvdg@mail.gmail.com>
 <99f45844-4ef4-4b46-8ba4-21593a0cad29@oss.qualcomm.com>
In-Reply-To: <99f45844-4ef4-4b46-8ba4-21593a0cad29@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 1 Sep 2026 02:28:23 +0800
X-Gm-Features: AcwNN1Wk8DkcNiHLYWqrVeHQmitjCi8DhOTd0cpN3tt8pE97pKvkB-lK4gQt9AY
Message-ID: <CAE2XoE9Z=KkX+G06ye=vU4b7D+2WdwgHRueMaUkLVLLUnPTUHw@mail.gmail.com>
Subject: Re: [PATCH 22/47] hw/riscv: remove machines-qom.h
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-level <qemu-devel@nongnu.org>, Anton Johansson <anjo@rev.ng>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005a369d065a5bf88b"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ej1-x62e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000005a369d065a5bf88b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> =E4=BA=8E 2026=E5=B9=
=B49=E6=9C=881=E6=97=A5=E5=91=A8=E4=BA=8C 01:58=E5=86=99=E9=81=93=EF=BC=9A

> On 8/31/2026 5:36 AM, Yonggang Luo wrote:
> > The changes to DEFINE_MACHINE_* is too much and redundant
> >
> > They can be simplified by preserving DEFINE_MACHINE_RISCV32
> > DEFINE_MACHINE_RISCV64 DEFINE_MACHINE_RISCV32_64, along with ARM relate=
d
> > macros.
> >
> > For example: for riscv we can do this, we can do the same for arm and
> > other arch when use  DEFINE_MACHINE_*.
> >
>
> We went down this way, mostly because Richard asked us to factorize
> interfaces array to not create static data duplication.
> Now we don't need this anymore, this is questionable to keep this.
>
> Since it requires to duplicate those macros/header for *all*
> architectures, IMHO, it would be better to not do this. That's why
> current series removes this.
>
> > Pierrick
> >
> > I've reworked the commits at https://github.com/lygstate/qemu/tree/
> > s11.1-riscv-arm-tmp1.0.1 <https://github.com/lygstate/qemu/tree/s11.1-
> > riscv-arm-tmp1.0.1>, you can check the commits there, I do not post
> > patches to mail-list to avoid review burden.
> >
>
> Be careful to not do extra work for nothing. We first need to agree on
> current filtering approach, before dealing with details on the
> single-binary itself.
>

These patches are better,  great job, I like these patches. I ask to
preserve these enum because that would makes the patches smaller, we can
wait others
accept  this direction first.



>
> ...
>
> Regards,
> Pierrick
>

--0000000000005a369d065a5bf88b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto"><div><div><br></div><div><br></div><div=
 data-smartmail=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=
=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=
=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div><br><div class=3D"gmail_quot=
e gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Pierrick Bou=
vier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierrick.bouv=
ier@oss.qualcomm.com</a>&gt; =E4=BA=8E 2026=E5=B9=B49=E6=9C=881=E6=97=A5=E5=
=91=A8=E4=BA=8C 01:58=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">On 8/31/2026 5:36 AM, Yonggang Luo wrote:<br>
&gt; The changes to DEFINE_MACHINE_* is too much and redundant<br>
&gt; <br>
&gt; They can be simplified by preserving DEFINE_MACHINE_RISCV32<br>
&gt; DEFINE_MACHINE_RISCV64 DEFINE_MACHINE_RISCV32_64, along with ARM relat=
ed<br>
&gt; macros.<br>
&gt; <br>
&gt; For example: for riscv we can do this, we can do the same for arm and<=
br>
&gt; other arch when use=C2=A0 DEFINE_MACHINE_*.<br>
&gt;<br>
<br>
We went down this way, mostly because Richard asked us to factorize<br>
interfaces array to not create static data duplication.<br>
Now we don&#39;t need this anymore, this is questionable to keep this.<br>
<br>
Since it requires to duplicate those macros/header for *all*<br>
architectures, IMHO, it would be better to not do this. That&#39;s why<br>
current series removes this.<br>
<br>
&gt; Pierrick<br>
&gt; <br>
&gt; I&#39;ve reworked the commits at <a href=3D"https://github.com/lygstat=
e/qemu/tree/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://githu=
b.com/lygstate/qemu/tree/</a><br>
&gt; s11.1-riscv-arm-tmp1.0.1 &lt;<a href=3D"https://github.com/lygstate/qe=
mu/tree/s11.1-" rel=3D"noreferrer noreferrer" target=3D"_blank">https://git=
hub.com/lygstate/qemu/tree/s11.1-</a><br>
&gt; riscv-arm-tmp1.0.1&gt;, you can check the commits there, I do not post=
<br>
&gt; patches to mail-list to avoid review burden.<br>
&gt;<br>
<br>
Be careful to not do extra work for nothing. We first need to agree on<br>
current filtering approach, before dealing with details on the<br>
single-binary itself.<br></blockquote></div></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">These patches are better,=C2=A0 great job, I lik=
e these patches. I ask to preserve these enum because that would makes the =
patches smaller, we can wait others</div><div dir=3D"auto">accept=C2=A0 thi=
s direction first.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><div><div class=3D"gmail_quote gmail_quote_container=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
<br><br>
...<br>
<br>
Regards,<br>
Pierrick<br>
</blockquote></div></div></div><br><br></div>

--0000000000005a369d065a5bf88b--

