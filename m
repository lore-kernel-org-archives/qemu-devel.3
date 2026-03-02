Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1085CEA4E04
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 14:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx4bL-00077A-Fm; Mon, 02 Mar 2026 09:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avi@scylladb.com>) id 1vx4bF-00074m-Gu
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:50:24 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <avi@scylladb.com>) id 1vx4bD-0002FT-LL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 09:50:21 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-94acf3fa688so1232261241.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 06:50:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772463018; cv=none;
 d=google.com; s=arc-20240605;
 b=SipdxiUj+KOOMh5SOb1SXf23BCVm8MkHKRjLIBKeNRj53VIEupav+BFLel0nS2kp6i
 wVQJkfoL7sYSGhjjLjvAiiPJkm59pz+qgk0YCM3Zo3BxZmAgamKxMcJIb4w9vzF8Lwlr
 UoeW/eHDip7W8y/3h+G4Kh6T4fNxS4x7Lc9kPTRebvqfsb0Xz8opv0X75nj1XlhFrUeX
 aIX4Bj2xPR7nW/2vKgBNkRe9OKhBg11ULBiZ7BF3wsLf7A0sdotwjedmCCdoTehsYjYi
 ekbxTA3tlpHK8X7j4eQE++MVOtPqBiEODK4Z+rxaOYd2ofhW7+GGDnQ+SEF/t9jI66kf
 bE3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lDNX+LbD4JhTMgJ/LhRzpJttxrLJTFNyhYA+XExzQvo=;
 fh=Qpl77bHkcE0bYSjiKXT9vs9obKUyn+uhBwvH7ERnfRM=;
 b=DVRHBZDSIksSzoAWmp/sBJW8g225cTp7i+kHroODBBvrT9Duo3RFvv4VUi6sw8nAjH
 ITpDlAcz+rVGX9bVDUXOxYs3QAXGeUr/lE7PZBWVKQ/DtfiY3Is4mOmdZxAJ92Rbv3D/
 YBXPKSnR2RrdJGTMc2ZSkcnIDacz6TvJpqQtMQRv85mvwdMOHEG4WiBHRyw/UmODFx6N
 yk/cF/vr/R/7rx4zve2N56U3zdelFHIHZsSxkj+kqJppqqacOEUdPlxlwj5kMjd+zR+y
 fhatD9dVhPEQTBPoDW0vZMlPEPHzQOY3lXOOfisiMtoqNSuVCAEJ+cWFw2kpCiopri6b
 mFPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=scylladb.com; s=google; t=1772463018; x=1773067818; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lDNX+LbD4JhTMgJ/LhRzpJttxrLJTFNyhYA+XExzQvo=;
 b=nzzGZpMY+uEDDw4A1mEO/OAALEaHtXszqTCwcQmTLyXaHO+kF+AEj4sseAWdnaoxIt
 sskL9hyfv/9vWSj2U1ANc0iLSCvXkyeO6ALgJPIt9hMuL17rU2pPrOHugV3ql2pjj7Gy
 J63tTJQsCpkXCNAwj9Qn0EKVAiAGonKETRUb9PKmc7Hf2QoMzrRgTV/JaEyx6a0ZKirS
 QL815VEo/m3NSWmPzFZGXN3nwhxtgk9u90IjZ/6tS1rm8KyT8/fZKkgAP66K4ZtNlVDQ
 ML4sJ0WkZzdrXw4Ji/fqjR5OZiasId1XKb0VSTF7TAM+eEAj/ui3vDCUysuEi5uHZkko
 UTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772463018; x=1773067818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDNX+LbD4JhTMgJ/LhRzpJttxrLJTFNyhYA+XExzQvo=;
 b=bbiyB6e42EOuAIrpkT6LtBUqIGGOhjabu0t9ibOVAbsbXNU2+7Xl6Y0Y0T+ahwjUau
 PpKLorcxpmy4Jy+1vFsJJPurJY6DEXdd4xaRbHc2WIrrW/EKz7j2xaBKn2+163QLVVwV
 WB0aOyFv7GuZgQ8p7yg4SNJezHJxcqFJpTQul7AWAgx0wiLT4NDvhzvswsiGc276mnEf
 HgmHPGy8iD+LcPeypVLK4si9J0BZoSTqsJJRyxjq9YNZ1s+Zt/jPLLAH63Hl4FvFmV9r
 BVoQxtuCLTSn8tf1rvNR6PxZK6Pir4XBPIhW0iFz8z6ESi8SLCWvs8EjF0usEtLnCJnV
 l6sA==
X-Gm-Message-State: AOJu0Yxbx2KkqT4EhsWR+7SAOu9glrGLOgx3Sh/af9MNFY+jAVOeQaS+
 FW3B6T0CKU4afU9nwcRqHqUPxNis0crpWxZBDCihHIW4iYm/qKKDC0dk64DTExDqNPTXSfqKrYk
 ekGEAy9rbk3sO7eU3ubSIv6ennphIX1Zog7x+w7v4OubmW+H6s3/jiM5LFB4khoJZrBhZTxwxes
 NcN4UQAbu5+3pXK3yG2pbW9PN+LxeQ2M4lYzN1VF8bkXIAUgnMQ/+k+f83wFo1K5UK3KUGr4oCh
 Nwydhdqg9f9q13oXQgEifANUrWOFsRxSfdcmpvOfbcf66ZLBhFl2qNxXFP8aeCBFz+4YTKps3M0
 AylkaHxxhSDZN46gJdcnyX1oJhh2ygawts+w8P44z+ImXYexHfhD0kAsyIXlbWIfMjaWDNEltd1
 tPdPmFfL9dA==
X-Gm-Gg: ATEYQzzXLZlur3QGu7pkTLZVleM/K0Ogf+hWmmSQlbKOopFaIUre/Px4RWdUfdCdLXy
 dDNl2bhPEtW8M/9RrZHOi6S6cvnd26qIljsdj4bT/tArVZ2n4T436392hBsTr0q9WOGzum/Jmtc
 +8PI0X2LPgufNUOoaaePbE9sP238CSBToNBA2WhH7MHQk8BVyOwuUSnbi2TxbbLHJ27nGgAnIbT
 A1M3oCGJc4v0jyh2cge5azttGP2l4/lTaPbMKXXlWDnslUjl+8aGMVrYcMy81deIiwFAP6CZqOA
 Y0O3xFY=
X-Received: by 2002:a05:6102:38cf:b0:5ee:a12d:55b7 with SMTP id
 ada2fe7eead31-5ff3250c298mr5094778137.29.1772463017870; Mon, 02 Mar 2026
 06:50:17 -0800 (PST)
MIME-Version: 1.0
References: <20260302142831.1269291-1-avi@scylladb.com>
 <aaWhHEI4QaDINc8K@redhat.com>
In-Reply-To: <aaWhHEI4QaDINc8K@redhat.com>
From: Avi Kivity <avi@scylladb.com>
Date: Mon, 2 Mar 2026 16:50:05 +0200
X-Gm-Features: AaiRm52NTf4hKHJpmlP3AYihRe5tU4FDp2vILc_tvqGUTXbVPpZlFOJHX65JVGQ
Message-ID: <CAF950WLOB1BXkJ+rmRea3nWuLRZG=O3gDas9HUhM1LMsmrnffA@mail.gmail.com>
Subject: Re: [PATCH] hw/nvme: add `model` parameter
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000008ee244064c0bb4d1"
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
Received-SPF: permerror client-ip=2607:f8b0:4864:20::931;
 envelope-from=avi@scylladb.com; helo=mail-ua1-x931.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

--0000000000008ee244064c0bb4d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 4:39=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Mon, Mar 02, 2026 at 04:27:48PM +0200, Avi Kivity wrote:
> > Add a `model` parameter, readable with nvme-cli. This allows
> > impersonating other disk manufacturers or hypervisors, similar
> > to the the -smbios option.
> >
> > Signed-off-by: Avi Kivity <avi@scylladb.com>
> > ---
> >
> > Disclosure: prepared with AI assistance. I believe it to be of good
> > quality.
>
> Can you clarify how AI was involved,


I asked an LLM (Claude) to add a model parameter to the nvme code, which it
did, then I asked it to documented it, which it also did.


> as QEMU's policy is to decline
> any contributions where AI was involing in an authoring role:
>

Very unfortunate. It would have taken me an hour or two to re-orient myself
in the code base, for something that took me a couple of minutes with AI.



>
>
> https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-gen=
erated-content
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--0000000000008ee244064c0bb4d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 2, =
2026 at 4:39=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berra=
nge@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Mon, Mar 02, 2026 at 04:27:48PM +0200=
, Avi Kivity wrote:<br>
&gt; Add a `model` parameter, readable with nvme-cli. This allows<br>
&gt; impersonating other disk manufacturers or hypervisors, similar<br>
&gt; to the the -smbios option.<br>
&gt; <br>
&gt; Signed-off-by: Avi Kivity &lt;<a href=3D"mailto:avi@scylladb.com" targ=
et=3D"_blank">avi@scylladb.com</a>&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; Disclosure: prepared with AI assistance. I believe it to be of good<br=
>
&gt; quality.<br>
<br>
Can you clarify how AI was involved, </blockquote><div><br></div><div>I ask=
ed an LLM (Claude) to add a model parameter to the nvme code, which it did,=
 then I asked it to documented it, which it also did.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">as QEMU&#39;s policy is =
to decline<br>
any contributions where AI was involing in an authoring role:<br></blockquo=
te><div><br></div><div>Very unfortunate. It would have taken me an hour or =
two to re-orient myself in the code base, for something that took me a coup=
le of minutes with AI.</div><div><br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 <a href=3D"https://www.qemu.org/docs/master/devel/code-provenance.ht=
ml#use-of-ai-generated-content" rel=3D"noreferrer" target=3D"_blank">https:=
//www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-generated-c=
ontent</a><br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div>

--0000000000008ee244064c0bb4d1--

