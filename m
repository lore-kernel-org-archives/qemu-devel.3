Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1170CD5BD2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRoXO-00089H-0r; Tue, 26 May 2026 05:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRoXM-00088p-2F
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRoXJ-0000L5-N7
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779789439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bAu+U5kkRzrmOyjkRMylztHYAIieUgvGS4iZwsiHIis=;
 b=e1s07xUfN025eiMOnjwOQx0PhTwS9lmd6jyBsMIYLZU5ltXlEnCYkBT33NhX1zTudLovPl
 3KjpTA4ZC3xMeVmhfJKUNCIXAP0Lyl9X3N6K+q3Na4D2j3eDU/fwYyBona5+pkiik7NVzp
 jPSof8hEjCiboXzxDGFAOLh4vOUdKt8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-xZLUoBYaOaSzJt9CxzeSow-1; Tue, 26 May 2026 05:57:17 -0400
X-MC-Unique: xZLUoBYaOaSzJt9CxzeSow-1
X-Mimecast-MFC-AGG-ID: xZLUoBYaOaSzJt9CxzeSow_1779789436
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-449b2a183d3so6643022f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779789436; cv=none;
 d=google.com; s=arc-20240605;
 b=TA32xj6NnmfNFGzVsDpN6I2+5YMCl1wbKTaXelpH1ZkvLGTDHxv/ike1n0EuH/G8xX
 9T1nGUqCRxG0Z2sa/YuD1rV0FDI4nx8xirWrfg+VETdMwAZFonjaseoSWrpPyTl88LZ2
 ISf6epN9unRV0RzOL0adJTrFWeLDUE3eonrNWuKX7OFOM8ZLCBf2SOpZBBYfh2g/DkGZ
 9syQOeABBT+Hk4RorihLOl8zwLEUeWfG9cWiHppd0QSl7llu4QUzTEYLduBLbp8HSiue
 x6fUe03QR9iwx5am8zRPnMXa1oRNzU9g1QwmlmXUWv7L0ym9APsgc78Nt8STyTQdE15W
 U+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bAu+U5kkRzrmOyjkRMylztHYAIieUgvGS4iZwsiHIis=;
 fh=D0ZPAicSSf23vZ/u3sqI+e1Akl3kuZ2QrzwxV3fOPZg=;
 b=Vjrty7aOWdGPpR1mYSppgymq+MC1kAaeS9UIKJgR5b2DQrYHqwjKbQ8sxhLbotMgIr
 C7n8p3nWGWeJx4LWusqWAEcqc9gcOUiFOfj9aWme+inpuUIpR2uFNkAg/35dUXFbLyu3
 srTBC9M5N/CUkCJEoX7W8MJ5N5RhtnbBu8cFWRilK4fsYId/dTzZEr76QwBV9710QHpF
 M1mFR3ME8mJcYevTN9zKzWNy9IB70HQM1T4saBI6VBSILqCkff9M/TZZL5yAIuzFXVkn
 2LwceXUh1rSWhzWkD4dOl1UOdFut/NisI6c40oOJ1XVxFHNLcGc2A7atnInXU4XTSK2A
 Bf+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779789436; x=1780394236; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bAu+U5kkRzrmOyjkRMylztHYAIieUgvGS4iZwsiHIis=;
 b=UugMQDDxTfb9ZMAa+eTPOFMOKc2uTplDJ79gBsW9IhZkR8a+HhMIskJkBhtX7c2dMe
 b36EUv7sLmgwpKlAigGlzFQ9ckfxtt0YeULbrpKm59LSk22ASeTCFvCrcF5tEx3mX1Oz
 zZt7Hltw5EfLEaTPCGwC2IAnl7ZZX7XtvoXk6PSV41S836tTYPa0KeVds9o2BURf77p8
 x4vhGh5ddrMCBzTbRUgIat/DtKQ9DNLFcFTHYma1ZehGXKZ2pHIjzkVcUb1VfZWI/6Sf
 HeEMdQbzVDtYhQ18KWRWxGr0MVvnuM0JW4yRGgYjr4C0iYXpMYuSG7jrFJCfWOztviwO
 UVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779789436; x=1780394236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bAu+U5kkRzrmOyjkRMylztHYAIieUgvGS4iZwsiHIis=;
 b=DCFayZDIRTJgvb971NFugIojGvnaqtVITztysbMCofYWvyKLmfbjsuL/PgJPtGUBwd
 2DL7wVTQqc99tKueH4CNuqkSoTW3ln5IV90IcGRY1jGP7ssDoti2bL+DqNbxoLmNV7Wx
 5oXkw5Grx4bQpEDDgZQZPRHuOXQ23zUT0EQ0OiVgKQ8Kmypzg4SSTjDSN1ZnrLfunPG3
 NejNh8gLiC+Zs2Gmulbk9EcVh/f5MBn8tHrfkAAyEpA8+3bPjuB4syL7pdtvY2MLNNEc
 XH7eUUR/68jrYd7q+IQp2QNv7ozlAP+eYvOwf5bRqcqnpI1gduPVqN9QOXDsCHpzhixc
 HM7Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QtRymVf6tlOb25IApDAe+Y8rqz11jNjUM3cy6EmdS46n//ifmyLhl72pEJb0lGQh4isZXH8sRnIGt@nongnu.org
X-Gm-Message-State: AOJu0YwaXUeBr3tJde3kInDQ5+dPlJzJVMoFw33eHrPm2ymbkSlUqGSM
 rvJD7J4lYCHagji89rguwrcJlzN/jpZhXClR1+W19fBtEFWlJx0nhUExfHaA9SGuh99Hfe9ZnV9
 tQoFWcOrBhYs6hkjOl4OEnfeBTRqG387Mc+Do5bwX1IlNmPCLpQvOFhWex8+WA3OP+00LrRwZJn
 OjGroUF1vQSCQMNpfj8twum7hrkqAxVm4=
X-Gm-Gg: Acq92OHtjGsrTvZmdVN81fPTqwIrL/Jy6gpxMs53UkB2nMY4jkjHZps8hawEtV7KDOT
 HllvnAFRmtTxqxVDmTrnly9iMFjDL1mYBtk7uklY93vJQuqlEWW6Gsfle3OoU/jPtzQitsfW0Nj
 zl3wQWwBJXa6tdtRb0TXoPHfyDbrmnhvNLtDuGzwnkvhv9UoM64AbZEWQGS1Vd9fBPSmUQOMeGa
 FlBhZENgZHeJzsELZOKBHbUonudQDtcKj+gBGOG05DE+TOuOvIo+2Z98sAz7mZgMuwptktzsQMW
 Q4YNS3yY4ev5pY11Fw==
X-Received: by 2002:a05:6000:1a85:b0:45b:d872:592d with SMTP id
 ffacd0b85a97d-45eb3123c54mr26569199f8f.10.1779789436075; 
 Tue, 26 May 2026 02:57:16 -0700 (PDT)
X-Received: by 2002:a05:6000:1a85:b0:45b:d872:592d with SMTP id
 ffacd0b85a97d-45eb3123c54mr26569157f8f.10.1779789435690; Tue, 26 May 2026
 02:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
 <CAFEAcA9wMRFJWrjGHcd2nfhgXovyuS=dDJvCXWZkgmD_eez27A@mail.gmail.com>
In-Reply-To: <CAFEAcA9wMRFJWrjGHcd2nfhgXovyuS=dDJvCXWZkgmD_eez27A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 26 May 2026 11:57:05 +0200
X-Gm-Features: AVHnY4JTW8zXpkbZQPNgTrscJj2c2douEXaryFznJxCXR90Dm0U5znHvQvwGMzc
Message-ID: <CABgObfYSy-sctHcUW3hPxQZ8ZGOYHLi3HaW+FrEQ9kKitMAVZg@mail.gmail.com>
Subject: Re: on ai generated and code provenance
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 "Hajnoczi, Stefan" <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000016fcf10652b5854b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000016fcf10652b5854b
Content-Type: text/plain; charset="UTF-8"

Il mar 26 mag 2026, 10:23 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> > Personally I think QEMU's
> > policy is fine but we should start introducing exceptions, possibly
> > including large contributions with pre-authorization (but not
> > pre-approval) from the maintainer.
>
> I want to note that [...] while we were essentially in the "blanket ban"
> state anyway, there was no particular need to have the discussion about
> other reasons we might also want to be restrictive or cautious about AI
> contributions, but those other reasons and viewpoints don't go away
> automatically with the legal one.
>
> I have quite a lot of sympathy with the rationale behind the Zig policy,
> for instance: https://kristoff.it/blog/contributor-poker-and-ai/ I spend
> quite a lot of time reviewing patches for things which are features I don't
> necessarily personally care about. I'm happy with doing that for other
> people who are hopefully learning and gaining something from the process;
> I'm much less interested in reviewing a mountain of LLM-generated patches.
>

I agree and that's a good argument for pre-discussion with the maintainers.
It would anyway be the right thing to do for large contributions, but it's
even more important with AI given the different balance between contributor
and reviewer.

Paolo


thanks
> -- PMM
>
>

--00000000000016fcf10652b5854b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 26 mag 2026, 10:23 Peter =
Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linar=
o.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&gt; Personally I think QEMU&#39;s<br>
&gt; policy is fine but we should start introducing exceptions, possibly<br=
>
&gt; including large contributions with pre-authorization (but not<br>
&gt; pre-approval) from the maintainer.<br>
<br>I want to note that [...] while we were essentially in the &quot;blanke=
t ban&quot; state anyway, there was no particular need to have the discussi=
on about other reasons we might also want to be restrictive or cautious abo=
ut AI contributions, but those other reasons and viewpoints don&#39;t go aw=
ay automatically with the legal one.<br>
<br>
I have quite a lot of sympathy with the rationale behind the Zig policy, fo=
r instance:=C2=A0<a href=3D"https://kristoff.it/blog/contributor-poker-and-=
ai/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://kristoff.it/bl=
og/contributor-poker-and-ai/</a>=C2=A0I spend quite a lot of time reviewing=
 patches for things which are features I don&#39;t necessarily personally c=
are about. I&#39;m happy with doing that for other people who are hopefully=
 learning and gaining something from the process; I&#39;m much less interes=
ted in reviewing a mountain of LLM-generated patches.<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">I agree and that&#39;s=
 a good argument for pre-discussion with the maintainers. It would anyway b=
e the right thing to do for large contributions, but it&#39;s even more imp=
ortant with AI given the different balance between contributor and reviewer=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--00000000000016fcf10652b5854b--


