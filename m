Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61047CD3423
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 07:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJnQ5-0007UG-1w; Mon, 04 May 2026 03:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wJnQ3-0007Tx-WC
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wJnQ2-0007GE-6K
 for qemu-devel@nongnu.org; Mon, 04 May 2026 03:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777878519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DLnMP+u7Qpvva5c4wSGN32Osa42hgV/+HcTc1frecvc=;
 b=Zf+S3YbH88UBcsdF83/cgmqf44AeRYjEAuVkGXJ37gNEVGU3Im9a8gR/nGZmYZcEg1O6LQ
 k4Oav61PLhIiDOWRyG3I3OrzqGF5xVT7+LjOsJBjd5jVAgTOK8SerjqTpS/k3MPg0BiMBl
 u4pEq2k1ja+/wCAQAeBk66Cb+yb1LWA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-riUQ2o94OBGgARjfwz8CVg-1; Mon, 04 May 2026 03:08:38 -0400
X-MC-Unique: riUQ2o94OBGgARjfwz8CVg-1
X-Mimecast-MFC-AGG-ID: riUQ2o94OBGgARjfwz8CVg_1777878517
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4891f97aef0so22481865e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 00:08:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777878517; cv=none;
 d=google.com; s=arc-20240605;
 b=Ov6fHQPlevsuhjYAxjImUqjmJO5pk3tu7EMW8I49lDfY0WfxYmjSES6Nn/x4kjMj/l
 niFZm6uiJ1mD/8AQ6B8IIf9T+J1ZOShMF0iij9zqWWkLLXp2LL81aNvf9RI1uklFdMtY
 yXIJfAFzM2AZZHBKqapgxybMCuCtSZ4ishGYoxXlVUSBjCVywkJHVrlWbCqj0DZx/SFw
 Ies2+5ZmUdnMF7QQVjAzyPvzZNZr8lE+gn26nwvGAouaQY0o3aeXeMr3nDL65dWyWuwn
 QHweZrmuyexWTH8pxiQjS1EB5BngaIhFWwhKmDdQPtuOOmG7s5itt4C0LODpUXiUhLVy
 U1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DLnMP+u7Qpvva5c4wSGN32Osa42hgV/+HcTc1frecvc=;
 fh=IAr358B+xlheH8+YMcgGApL1BpAm0jBEe8/MNK8gXYM=;
 b=KnfPfBWzXoRR6P6/CnoxQKMSQiowvYY5tnUxhPihZ7q7TQx9d/z8i9q0P3ysoJD2zD
 M3O8V7F5Algoj+F8twx+7iZbpxDLsLNy2qHoGfhJX+2BGQVQxjZYJTcXe+gHDaqwtgpR
 BcQJTuuQbJaKSDnKlc7hnhvP039qgVDDftCpqmMhScD2l06AmH0QGRoVOWiglIHMO+5R
 nOwmlwciOeAc1VN9RTsjiq5Y88+Qudu4/gBDcOYXCdxBxEb7EMcJjoaojwrXLfCc+coG
 I22i/dYnWAxSaA5RjuYhGtyg1e9V2gMs6Yu7LNpd4vuC42pgkdxqmlR+hzoctarSYkGn
 ZD2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777878517; x=1778483317; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DLnMP+u7Qpvva5c4wSGN32Osa42hgV/+HcTc1frecvc=;
 b=JIJVrOteXgqvgNFtYGyz+n9hyFv0TITH6DAN+CfvAgg/Av5Gouue1G3lX26ubgI8ma
 /4Sb/8+DuUUcu+OFhnpvdk+SylEry3FRDj0YGcLJHpqNuUycYvmra2RqsM6HP7TsZdFi
 yv6u3n2Hc54hOPlxrn5ErZlFzaSAAlUDVZpYc2uQ2aaYThiDVZHNJKEKI0KmJp6GLVBM
 LUi6p+e2LfIav3JNMxibOZPjxpSlMnb+hKuu3w39vDyVSVsUK63bwMm1eu4NbIXhUoNW
 6zKuLO0nYlYdAZgaBRhoMtqAfIiqoHLGk1tjn0z9IYLdUnAMZAW0ABqO3oD/inEsKXLg
 6DGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777878517; x=1778483317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DLnMP+u7Qpvva5c4wSGN32Osa42hgV/+HcTc1frecvc=;
 b=fztXx5krDSWFnV8mNdoRqwdbKwZMHzcZvtm/PfsHLSa2xNHRJ3l3En8bwpzNFBVv1A
 ZfFsxjeU1U0xuSdoOBJb4eFTzNo/YtF3ohwn+/sHIC2uJM5o4m7BUOGkDs8IZwfo+A7W
 Ryu9RpwS0fBkp6rSgNEH/AYygRNpx5xLBn5HTSpPT+w1ZskYJty1zg6c22lmbE/7q6dr
 hfsI18Rp1Z98yjrZt6Bgio3d9QC47GVgGNQ5paZIsW/K5p1ph3YAc6KxWzyg4D+ql8mM
 AIh9kLPmvt0BF3eDfVKfLZD7AbDsY6QkAuFNOpsCUx/TYgT/JHg6IhNVBrIHEbMoiwxh
 crdQ==
X-Gm-Message-State: AOJu0Yx808oZJPMTho8NMlqqe6j/cgc+Pkc/Z5vGPphkoXYE4Zw4K8Ka
 MqtXAcsknqeh/kDeCdnZeJ91xxWyOmXIBG2MvONhafuX9IHQoGNOH+dB2j2uvTf1ZcMFSydqKnZ
 2dWp3LdGfBxC+IWtp8a/YnTob8mSvlr7gXo6UuuMotIuExodVkvgk0QeCWFaT6W2mKagV7KlWFg
 iK9aa5xvi6X8HlrtARJaGqytt2WiXaHJA=
X-Gm-Gg: AeBDiev+B5++3o2nNWKr98DBbgWnw51NsL0JzGOfR7waeo1J1jgd4AXC/t5m1jkg59b
 mcCBTKtEOQhDDxOUEu+Nb/fE7tp/28j7Cw2NwbHhLxdeIeZkdqAGDm+hGgmYCnTBfCUy+mdYMxl
 NVsd2sHCxntqs5YlrX+qYynbYq5oE2784vDJ/KnwQABpq08XFdnG9DNXEl0XsUo2i+SbDF/sJVk
 k8niWpt7CCoaIGAZLs5DqsLrutJqKxZ6IW3EC2aRi7ZMkAJ5DNkDKaZT2HxezMMfZKDawsEWBXR
 /r2dzCu2mhEyvyo=
X-Received: by 2002:a05:600c:1c15:b0:48a:554d:b9a2 with SMTP id
 5b1f17b1804b1-48a9852f593mr136858405e9.6.1777878516847; 
 Mon, 04 May 2026 00:08:36 -0700 (PDT)
X-Received: by 2002:a05:600c:1c15:b0:48a:554d:b9a2 with SMTP id
 5b1f17b1804b1-48a9852f593mr136857875e9.6.1777878516410; Mon, 04 May 2026
 00:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260430172204.1006673-1-pbonzini@redhat.com>
 <20260430172204.1006673-7-pbonzini@redhat.com>
 <09b2ec62-4b67-41da-893d-aaccf011537c@linaro.org>
In-Reply-To: <09b2ec62-4b67-41da-893d-aaccf011537c@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 4 May 2026 09:08:26 +0200
X-Gm-Features: AVHnY4K5Wf1PSIi4NpEzDQoE3VsBFgsAaatz_QCz6FAFdV2SE3iAFNNFw56hy88
Message-ID: <CABgObfZU_r-xF_iUR+DVA_GkcvzFv878CRAcBh5go864aD_Jqg@mail.gmail.com>
Subject: Re: [PULL 06/58] kconfig: remove duplicate declaration of
 CONFIG_MIPS_BOSTON_AIA
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: multipart/alternative; boundary="0000000000006cbe530650f8992e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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

--0000000000006cbe530650f8992e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 4 mag 2026, 08:28 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> ha
scritto:

> On 30/4/26 19:21, Paolo Bonzini wrote:
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> This was not reviewed by Marc-Andr=C3=A9 (at least not publically on
> the list) but by Alistair and myself:
>
> https://lore.kernel.org/qemu-devel/20260430090534.841894-3-pbonzini@redha=
t.com/


He did for the whole series, and then I sent out the pull request (having
had reviews) before receiving the messages from you and Alistair.

Paolo


> Not a big deal, it just shows this email workflow limits, as
> reviewers might wonder what the point of doing public review if
> being ignored.
>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   hw/misc/Kconfig  | 8 --------
> >   hw/riscv/Kconfig | 4 ++++
> >   2 files changed, 4 insertions(+), 8 deletions(-)
>
>

--0000000000006cbe530650f8992e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 4 mag 2026, 08:28 Philipp=
e Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro=
.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 30/4/26 19:21, Paolo Bonzini wrote:<br>
&gt; Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lu=
reau@redhat.com" target=3D"_blank" rel=3D"noreferrer">marcandre.lureau@redh=
at.com</a>&gt;<br>
<br>
This was not reviewed by Marc-Andr=C3=A9 (at least not publically on<br>
the list) but by Alistair and myself:<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20260430090534.841894-3-pbonz=
ini@redhat.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lo=
re.kernel.org/qemu-devel/20260430090534.841894-3-pbonzini@redhat.com/</a></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">He did=
 for the whole series, and then I sent out the pull request (having had rev=
iews) before receiving the messages from you and Alistair.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br>
Not a big deal, it just shows this email workflow limits, as<br>
reviewers might wonder what the point of doing public review if<br>
being ignored.<br>
<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/misc/Kconfig=C2=A0 | 8 --------<br>
&gt;=C2=A0 =C2=A0hw/riscv/Kconfig | 4 ++++<br>
&gt;=C2=A0 =C2=A02 files changed, 4 insertions(+), 8 deletions(-)<br>
<br>
</blockquote></div></div></div>

--0000000000006cbe530650f8992e--


