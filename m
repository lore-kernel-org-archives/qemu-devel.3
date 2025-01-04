Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF830E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 11:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tU2KX-0007BR-RH; Sat, 04 Jan 2025 06:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tU2KV-0007B4-9M
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 06:28:31 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tU2KS-0007cg-72
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 06:28:31 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21675fd60feso240894585ad.2
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2025 03:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1735990105; x=1736594905;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kPdAOm0ZmThBPJ2LaHVrje4bu2CEF6SRz25ziHv5/pE=;
 b=fxil4jEm/TM/Nx5WbmnmStSAzseNFbg7bZJvbY5Jasw7rX3BxQ4mmlzJldS97yw54q
 OoTe6WZF/BhMZ1OY9ng6QHuEkEZfhGQ1jqB2TsPkNNCBD5fbYZlPlCYdEOF7H/mWX8cN
 DxGOKDenFG7eeonpEGHu6hZWcHlnN4Xgla4R+9cJQcO3eYWQVW2gS/fznvoFELkW4xk0
 jYyQzXRfbk4PYAgm0aCfPReINazR0wn+KiChEbdoVJqdAZKmFDxWtjlUx/5A3mvcFn6f
 /pKwA+u2SkjWRfCRjsRbn43jz1GnbSQqfyKOkix691hf9sBIfUOOBS4U5G9IMoF9W2p0
 Qvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735990105; x=1736594905;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kPdAOm0ZmThBPJ2LaHVrje4bu2CEF6SRz25ziHv5/pE=;
 b=T/Cnr7sPhPnUzBItGkTlypqGRvbMfsnbpohJFUvm68ZDpgfwiv77RruB1I5mz8C040
 JU73DARJmU7eu02Wj9Vo/TEgDbZxDfiIxtk8U6VhEdDx/Z6wmZl0nCMCzLRf3qUSJLC7
 V1andXJ2HQcb85NgZdKZV2+w6b14Sj5jQ0Mat9frT1dnw6YPus65vgY9zOud6qhSTjKH
 pKPuJRv5FGiLJtYsFsi86gIaEbIM2ATTAT9ltUlflMD8mI7ZhgdJVDpCIsYUaMxKmZjC
 /3Eso+NO3TCv18BzzIBpT8SUfCCQ99eawYdQ2pBBB/dRNr+lmTWxES3rcBsKo51/Nn7P
 Saig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxknCPGzYYwJnlLiV7syiB2B4vpnkMd4YaZQCtzlKn1d+95//rnY6yiDLFnurE+jts5fA1F7JjBZSz@nongnu.org
X-Gm-Message-State: AOJu0Yxgb+qxFrrMKlk5bVR4PhNioG81OUmWqWT5RMEdBouO9EwjzO7q
 ggBHDb72SC0uLnUPjx/B7xSRW+INJvJTPu1VhWx3RePqyB4y8ilY1hZYvxiyggXQFi9FN3+q2Hw
 sB4qhN2JX4U9w2uwoDJKTr6wPiApwlQvS89Ai
X-Gm-Gg: ASbGncsiCEY3gsADCzBFMMMjNchZvZp51C4dGuSsTBZ7mv1x2gzXLE1QRlGk496RrnD
 GFB0RLn3icuA+p1N6A62ND6yTJtNWbrZjsuEMSw==
X-Google-Smtp-Source: AGHT+IGwLCvAxanjPFHdv2qEZJzu8nU/WjVDFWNqRbQGkJ1dBQHsIa7tCDOagQVAOxLFoVNEvevYcj5vuqSYpkly9f4=
X-Received: by 2002:a05:6a00:1311:b0:728:e81c:2bf4 with SMTP id
 d2e1a72fcca58-72abddb1958mr68201774b3a.11.1735990105056; Sat, 04 Jan 2025
 03:28:25 -0800 (PST)
MIME-Version: 1.0
References: <20250103150558.1473-1-philmd@linaro.org>
 <Z3f--qO8x45MpiXQ@redhat.com>
In-Reply-To: <Z3f--qO8x45MpiXQ@redhat.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Sat, 4 Jan 2025 12:28:14 +0100
Message-ID: <CAGCz3vtSUD-8pG7GVUAjx0ydOKAh-YxvWDUpcECef7ch7dbeGg@mail.gmail.com>
Subject: Re: [PATCH] system: Try hardware accelerators (KVM, HVF) before
 software one (TCG)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008bc20a062adfb1d5"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::62c;
 envelope-from=lists@philjordan.eu; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000008bc20a062adfb1d5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Jan 2025 at 16:16, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:

> On Fri, Jan 03, 2025 at 04:05:58PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > As Daniel suggested [*]:
> >
> > > We should consider to rank HVF above TCG, on the basis
> > > that HW acceleration is faster and should provide a
> > > host<->guest security boundary that we don't claim for TCG
> >
> > [*] https://lore.kernel.org/qemu-devel/Z07YASl2Pd3CPtjE@redhat.com/
>
> Note, my statement above was on the basis that HVF passes all our
> functional tests, thus indicating a decent level of confidence
> in the correctness of the HVF impl.
>
> If anyone knows any show stopper problems with HVF that would
> justify blocking its promotion ahead of TCG.... say now.
>

I don't know about showstoppers, but:

1. As far as I'm aware there are/were problems with the virtual IOMMU
devices in HVF. It's been a while (~half a year?) since I tried them, but I
had problems getting guests booted with intel_iommu etc.

2. I think there might also be a few remaining edge cases where the x86
instruction emulation on fault/trap is incomplete. Most notably, MMIO using
SSE/AVX/etc. instructions will, I think, fail. In practice this is a fairly
obscure use case - I'm not aware of any guest OS that actually performs
MMIO using these instructions. I have a patch kicking around that adds
support for missing 64-bit variants of common scalar arithmetic
instructions with memory operands. I can dig that up and post it - do we
have a good way of adding tests for this kind of thing?

3. As far as I'm aware, there's no CI happening on HVF? Or has that
changed? macOS is notoriously a pain in the rear in terms of CI thanks to
its licensing, and the big cloud CI platforms tend to run it in a VM which
in turn typically doesn't support nested HVF. I've been working on an
on-prem solution to provisioning bare-metal Macs to run clean-slate OS
images for CI. This has been a side project though and I haven't had the
resources to focus on that project to see it through. It might be possible
to do this in the cloud on Amazon's EC2 Mac Minis as well, but those aren't
exactly cheap.



> > Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >  system/vl.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>
>

--0000000000008bc20a062adfb1d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 3 Jan 2=
025 at 16:16, Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat=
.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On Fri, Jan 03, 2025 at 04:05:58PM +0100, Philippe=
 Mathieu-Daud=C3=A9 wrote:<br>
&gt; As Daniel suggested [*]:<br>
&gt; <br>
&gt; &gt; We should consider to rank HVF above TCG, on the basis<br>
&gt; &gt; that HW acceleration is faster and should provide a<br>
&gt; &gt; host&lt;-&gt;guest security boundary that we don&#39;t claim for =
TCG<br>
&gt; <br>
&gt; [*] <a href=3D"https://lore.kernel.org/qemu-devel/Z07YASl2Pd3CPtjE@red=
hat.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/qemu=
-devel/Z07YASl2Pd3CPtjE@redhat.com/</a><br>
<br>
Note, my statement above was on the basis that HVF passes all our<br>
functional tests, thus indicating a decent level of confidence<br>
in the correctness of the HVF impl.<br>
<br>
If anyone knows any show stopper problems with HVF that would<br>
justify blocking its promotion ahead of TCG.... say now.<br></blockquote><d=
iv><br></div><div>I don&#39;t know about showstoppers, but:</div><div><br><=
/div><div>1. As far as I&#39;m aware there are/were problems with the virtu=
al IOMMU devices in HVF. It&#39;s been a while (~half a year?) since I trie=
d them, but I had problems getting guests booted with intel_iommu etc.<br><=
/div><div><br></div><div>2. I think there might also be a few remaining edg=
e cases where the x86 instruction emulation on fault/trap is incomplete. Mo=
st notably, MMIO using SSE/AVX/etc. instructions will, I think, fail. In pr=
actice this is a fairly obscure use case - I&#39;m not aware of any guest O=
S that actually performs MMIO using these instructions. I have a patch kick=
ing around that adds support for  missing 64-bit variants of common scalar =
arithmetic instructions with memory operands. I can dig that up and post it=
 - do we have a good way of adding tests for this kind of thing?</div><div>=
<br></div><div>3. As far as I&#39;m aware, there&#39;s no CI happening on H=
VF? Or has that changed? macOS is notoriously a pain in the rear in terms o=
f CI thanks to its licensing, and the big cloud CI platforms tend to run it=
 in a VM which in turn typically doesn&#39;t support nested HVF. I&#39;ve b=
een working on an on-prem solution to provisioning bare-metal Macs to run c=
lean-slate OS images for CI. This has been a side project though and I have=
n&#39;t had the resources to focus on that project to see it through. It mi=
ght be possible to do this in the cloud on Amazon&#39;s EC2 Mac Minis as we=
ll, but those aren&#39;t exactly cheap.<br></div><div><br></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Suggested-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@r=
edhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 system/vl.c | 5 ++---<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 3 deletions(-)<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
<br>
</blockquote></div></div>

--0000000000008bc20a062adfb1d5--

