Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0263C1099B34
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 18:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3eZS-0001AH-HW; Fri, 20 Mar 2026 14:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3eZR-00019z-8z
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3eZO-0005Er-LJ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774031257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7rJQcHhFkQ1ErBki5Ozl4OV33CmUYX3dZFPyjMkseKw=;
 b=LxL0eR0SyI9fJ2GMAckG7weaHKl6iDnCMMxLq96psiH86Vez9WdNsxYnc6PEd2d8tosjn6
 XZmDhlPExo/9dwS+LYv1yEzyLGU+aNBzvIPFWMuMmbuVqyhQMD+9VcsDBPL0whM8a534Sa
 cCT1b82uYSwmBjdzZlciUSJn2rK/p70=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-ujqmdynFM1iopopUfNNNPg-1; Fri, 20 Mar 2026 14:27:36 -0400
X-MC-Unique: ujqmdynFM1iopopUfNNNPg-1
X-Mimecast-MFC-AGG-ID: ujqmdynFM1iopopUfNNNPg_1774031256
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cfbfac0e05so1394701385a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 11:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774031256; cv=none;
 d=google.com; s=arc-20240605;
 b=Wnc3N5VZHWf+xBA41HN94Ug6CoY+pHJCAqGdS2Y2wKPycBB54gX8xE6aes8RTIhkJo
 QU7kxqne91uG9pI9Jzt9bXrsWNmzYht4442pPYGUaPTrHTdBI/onK3ElmPip5Sq2+ECd
 v28/CcRtyQPif8DsqFdRLTXJvTsBZDbdwAfRsQTqLJ8qEF2aepTj6Efuwm1fyLEzWIte
 bmJRQh0HLhL6MhZg3VGhy2D+O/r62IRgKhskduwg2w4lHrql/5Z/wiEWMQUxpLVDtaLA
 tEl8+eILSt0jv1xrJtma6Yd2dahUtTVOddxq74PhaVlJD9CDZghHtfkqslNDHpcQD+rP
 36kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7rJQcHhFkQ1ErBki5Ozl4OV33CmUYX3dZFPyjMkseKw=;
 fh=ITVUHrDuK24wfFWcPHAMT7QsL3mgm65a7A/rtIt/55A=;
 b=a0sQicd8WUAzqrRj7rSZF+IYHSOUj8jseMcCUAB9wyXS2EidHdVqNIgXHhpUGGckoL
 few6h9Rv/+w1qRxYUz69VTmXssQ7+ksN0AR7/GsFgcYjYeptFodNMSilOuK28qpPXA9U
 0FEJtvN906QvoV6GBwE0CcuPSWLt4VUxY8mcqwJqyLKfP25yUOcxk5UEP1a6d6gP3RiF
 OtvYEyb+aZAyDhsYxCU59iAwEXLrEwMAW2Nzgoeo+gChygdkMu96oc3uTfyi6uqhJJX9
 nv4v2USqX/GIQoXncEjD4xBVhV+0mJ3OaqW3hr8MeCooHOR4uUxaUUDt+8lJrykJZlqU
 3f7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774031256; x=1774636056; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7rJQcHhFkQ1ErBki5Ozl4OV33CmUYX3dZFPyjMkseKw=;
 b=P/zmpdd0mlk/+ArhLwHZANRnvsvaN7Jv2tFTZI3em3uaWE5RwXIXEe5MD4mg1Qe8+d
 siV9v8o8uholwTOTf2KV8Zwpm9geOBkR1+yJchXawJBPveHp7jP5bKOT9/e/KI9aWX7S
 IPs5iWsCSc4YDCP7PcuQQH58wuUI8Wu9xnq6FG+zSTEQhZ5B9jEuzxZogAQxnDepTlzC
 Ink/FyLBV43I9GGmw7rTlFJXx408wqiCMB3gSzheBqjoo9/ZIyf3pqRNoae/+7X6b8xQ
 OLfATGi4XDSrDWOPnVpa7Ilc9LFrOFnLlj+yKo4K8qsshFRECdhtuP6gyM0sInp/3AXt
 7a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774031256; x=1774636056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7rJQcHhFkQ1ErBki5Ozl4OV33CmUYX3dZFPyjMkseKw=;
 b=lgb96Kr7jzo7duU5OCRzjY1++sFVW3BqNT3GrlAk+w/Zuo8odiIXoA5NqxkTNkxTyY
 j1yVXitBZ8i+lSMNX5Hbi501hEwtkL/iRCZXuKJxqLnYZtH1KmMn+0PsNzSRuCOmP4II
 6ljqrus08XbknaRg2H9dgzqQmOTRWjhT6HUwgSbUmJQS4hZBkyZwjBz4f2A5/utrfCya
 A1BwkQw6EBpbP+uyPe66k+qdlOcoe83kNi7N6WxgCDoteDM91/7hz5ur+eQV/ll07SKA
 NyxmrzOEHr1PP2ibkhZuUkrjXCE28+twaaIUeMe0sm/ab1cA8f04df2gNAExkg3OeM7w
 rHCA==
X-Gm-Message-State: AOJu0Yz1/wObmu7D+fIdPIxnA0Cvs9kFPngx/4pH5KfF8b4bNoeTR6Bf
 DYsou8J4CRru9UhbxCfmL55wEYi03ocMjP7saj6KN5igi809nEA7IhiPsEbqg1+ztYcseUdl8Tg
 4nasfPAWACydllepRIEXMDg84j2yPVZTBNZd6ek5gixQl21edHX7UBbzJ9ZQv2uB4pnST0mZ0kE
 lmPdu2w+FNfoK83IMbzcjJbn2ov1WiBe4=
X-Gm-Gg: ATEYQzztVUoqA2kjh13hVbTHZiA1NZ30n0y/zl/nnlIqycIFvdB2XhMqyV6ijjVqZ7u
 PYRf410BqHf9nCWDor7DFwkS/YEStzlQ3cKpvYcaUTuAdkz1JoVoegLHvmvcYH2sle+hSAbyCC0
 2dbRsa+2WgXFMgSvU/wwiQAFzfoNLnJKhExZ3KI6ltEWbTuFtjMur6aymdUDBRg/8ZChxVKNOqe
 f43Z0OU/Tknq4meJC2oOVvx9xpEroqw+JcIHw==
X-Received: by 2002:a05:620a:ac1b:b0:8cd:7e2d:df27 with SMTP id
 af79cd13be357-8cfb9e4b30bmr962381185a.21.1774031255846; 
 Fri, 20 Mar 2026 11:27:35 -0700 (PDT)
X-Received: by 2002:a05:620a:ac1b:b0:8cd:7e2d:df27 with SMTP id
 af79cd13be357-8cfb9e4b30bmr962376385a.21.1774031255405; Fri, 20 Mar 2026
 11:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-6-jsnow@redhat.com>
 <878qbm616n.fsf@pond.sub.org>
In-Reply-To: <878qbm616n.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 20 Mar 2026 14:27:24 -0400
X-Gm-Features: AaiRm51OVBuIwQlScSWPIr5moAliU_O-N4q3uCIG4q3NCN0eHRwtWQRMaVvNWoo
Message-ID: <CAFn=p-bSpzDZ3+9mhXYdyukKCmv+Qr17+xt8dDn15FApBoEz7g@mail.gmail.com>
Subject: Re: [PATCH 5/8] qapi: re-order QAPI doc block sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Lukas Straub <lukasstraub2@web.de>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cc9c14064d78d620"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--000000000000cc9c14064d78d620
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026, 10:11=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > A forthcoming patch will enforce a rigid source order of QAPI Doc block
> > sections:
> >
> > (1) Intro
> > (2) Members
> > (3) Returns
> > (4) Errors
> > (5) Features
> > (6) Details
> > (7) Since
> >
> > This patch specifically ensures the source ordering of items #1-6, with
> > the positioning of "Since:" left for the following patch as it is a muc=
h
> > bigger patch.
>
> It's actually the one after next.  Suggest "left for a later patch".
>

:)


> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
>

--000000000000cc9c14064d78d620
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 20, 2026, 10:11=E2=
=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@=
redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Sno=
w &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferr=
er">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; A forthcoming patch will enforce a rigid source order of QAPI Doc bloc=
k<br>
&gt; sections:<br>
&gt;<br>
&gt; (1) Intro<br>
&gt; (2) Members<br>
&gt; (3) Returns<br>
&gt; (4) Errors<br>
&gt; (5) Features<br>
&gt; (6) Details<br>
&gt; (7) Since<br>
&gt;<br>
&gt; This patch specifically ensures the source ordering of items #1-6, wit=
h<br>
&gt; the positioning of &quot;Since:&quot; left for the following patch as =
it is a much<br>
&gt; bigger patch.<br>
<br>
It&#39;s actually the one after next.=C2=A0 Suggest &quot;left for a later =
patch&quot;.<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex"></blockquote></div></div><div dir=3D"auto"></div><div dir=
=3D"auto">:)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000cc9c14064d78d620--


