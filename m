Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73C2CF2597
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 08:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLdBK-0004LK-1E; Wed, 19 Nov 2025 03:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLdB2-0004JN-RJ
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:04:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLdB0-0005YB-Vx
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763539468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nXd3N3aRhbfLudV8p7M5Fd3Hz1daiTpnUijtmY+qwBQ=;
 b=fJhCgmRzzBjpYkl1YBHdct5Gd72u2exMJhr9iUfKvr6KRkGRwsXp04xm1WwD23RQbCfG8H
 CqeWqCYA1sJyEwZT7WJrDsLqCd1lRL1K/sVKNHOwjDNWXsmXEQUiHaIpO/MhMw8iVGVYJu
 xCNwsf8wWTIurniriSlAytblqGmGLVs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-8rBIlHKKP0qUACStbNAVwA-1; Wed, 19 Nov 2025 03:04:26 -0500
X-MC-Unique: 8rBIlHKKP0qUACStbNAVwA-1
X-Mimecast-MFC-AGG-ID: 8rBIlHKKP0qUACStbNAVwA_1763539465
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477a027877eso34800025e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 00:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763539465; x=1764144265; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nXd3N3aRhbfLudV8p7M5Fd3Hz1daiTpnUijtmY+qwBQ=;
 b=THSGwW0t5zMKr5at4yYi1Zi/FdYd4vNhhFMwQIbJRy1t3DPlXT16RHajiIu/Gxkw4y
 i/GV7dHUyh0thCT8WVDk/3XbLKrgt89B8JYOQz1GZzwLyr9Ei6Bmq5e+RNjTyEORoZt0
 Qr8IsqLpO0EuUIF5yqG4SKfb0UK0EiaUKGAQWU9Urt9QrYe26aiJYQhUjXBiDnsYcBzw
 kpZP6A9wogh0ds+whI4Z5jO1C76jQVDXHTNHcaxDjSHkKfuFVSBolx83Kz1dMuwe8XLD
 tDoxqQs988Ee1VcKSOO36MKc+k+SVKsmqYaWrHUdVcQfV5UgSyucerxNCI8TLPFKLXJY
 R5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763539465; x=1764144265;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nXd3N3aRhbfLudV8p7M5Fd3Hz1daiTpnUijtmY+qwBQ=;
 b=I8V84ZHXUjHoZoQN9B/HLuap5mYv+gV3wBha8vRor8/8vm9jvVkso+lpHJavw681A/
 CCy4iJNj8QD3E94lBTj5rYzp7Pd+3D4FEeX7lgaVhEg0KcyQ0v1Vg13raHT3E8IkIW1C
 wAD98DhO3mBkiIJ2bF6k5xWUsojP1qanCrswrjH2KTiOgPa3770cxb/lso5+njtScOwA
 ELje3RY0wYv1eWmacEPyPWxH5rUeKABk8MF3Q+iNERWLhOaHB/2E0burEEb+fBm62CEh
 llsIjKZyAXziTcPagLmEFJ/S4Fw1esjW+M8nOaXSHylr+6atDYFK7Gpifu6u/8CjYCFr
 g0nw==
X-Gm-Message-State: AOJu0YxVadDZW4eUMhJezpVDb/XOYy11Fo0ZIm657kTR24RKDIgNWO5p
 gULkDy3FCzi6YJirDF2wJ1uqUHGEgXW84ikz9oXkJA9MCbSI74hyt8Uw9RmJrTFJK+/vYuSsHFI
 QZBDitK89xrwAJLS6xBCJ6eoKvadDjDrFBAXaY9lVB87ijJcZ+xbxEn/9QLc20PNOXB9eVST716
 ubpMrN3i1YbhcW5a2zfS0zbJBsUaa168M=
X-Gm-Gg: ASbGncsUQmLl6D2QrkXpaeA8pOIipc55ZMOK1OS5aYnn/umaoeTkC0022UjYKBPdcS8
 kZH/oW4cXs9olBSOseri5HN+2psfDS20j3/91eZPgJJiedkzmcQ7XqcrFhFbObPPlwdwsMeoJzs
 HG7oJY00h0K37DegvBRLmB90ptil1wd/U8P383+Fr8YUUFB9sljGWZl2G/lJRY0e/qUSjLVE2w0
 qOxgWZiEsx/xnp1k40dqTZwYsCxZa/7sh6/Jpy3pnOxtmSRt7hiBzfBWvtGprnpRvpq1YE=
X-Received: by 2002:a05:600c:c493:b0:477:7b9a:bb07 with SMTP id
 5b1f17b1804b1-4778feabc40mr181111005e9.35.1763539465238; 
 Wed, 19 Nov 2025 00:04:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8tHxkUcbw4OnWV4mVRP0eaSkGJxLRK6z1lmTeIo2jqwW1Pp09QcAiFgevEjnJA9JgvTKAFKeonMXmkbYn9Is=
X-Received: by 2002:a05:600c:c493:b0:477:7b9a:bb07 with SMTP id
 5b1f17b1804b1-4778feabc40mr181110505e9.35.1763539464718; Wed, 19 Nov 2025
 00:04:24 -0800 (PST)
MIME-Version: 1.0
References: <20251118065817.835017-1-zhao1.liu@intel.com>
 <20251118065817.835017-5-zhao1.liu@intel.com>
 <CABgObfZfGrx3TvT7iR=JGDvMcLzkEDndj7jb5ZVV3G3rK54Feg@mail.gmail.com>
 <aR1zIb4GHh9FrK31@intel.com>
In-Reply-To: <aR1zIb4GHh9FrK31@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Nov 2025 09:04:14 +0100
X-Gm-Features: AWmQ_bnWrzCxa2M_6rUnFZnZZhTmpIDeVi6FBl3lqAYnoc-4bBLlilESk9zhlc0
Message-ID: <CABgObfaOBD5QUi7XqRPsiimtgj1TSrO_bgXjZQmdZyiwr-aOtw@mail.gmail.com>
Subject: Re: [PATCH 4/5] i386/cpu: Support APX CPUIDs
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 "Chang S . Bae" <chang.seok.bae@intel.com>, Zide Chen <zide.chen@intel.com>, 
 Xudong Hao <xudong.hao@intel.com>, Peter Fang <peter.fang@intel.com>
Content-Type: multipart/alternative; boundary="00000000000057a7a00643ee0785"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--00000000000057a7a00643ee0785
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 19 nov 2025, 08:12 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> > > Note, APX_NCI_NDD_NF is documented as always enabled for Intel
> > > processors since APX spec (revision v7.0). Now any Intel processor
> > > that enumerates support for APX_F (CPUID.(EAX=3D0x7, ECX=3D1).EDX[21]=
)
> > > will also enumerate support for APX_NCI_NDD_NF.
>
> This sentence (from APX spec rev.7) emphasizes the =E2=80=9CIntel=E2=80=
=9D vendor,
> and its primary goal was to address and explain compatibility concern
> for pre-enabling work based on APX spec v6. Prior to v7, APX included
> NCI_NDD_NF by default, but this feature has now been separated from
> basic APX and requires explicit checking CPUID bit.
>
> x86 ecosystem advisory group has aligned on APX so it may be possible
> for other x86 vendors to implement APX without NCI_NDD_NF and this still
> match with the APX spec.
>

Oh, I was not aware of that. It is really ugly but I guess that's not our
choice. :/ If QEMU ever implements APX emulation it will have NC/NDD/NF
though...

Paolo


> If we default to setting this NCI_NDD_NF bit for APX, then in the future
> when we run into other vendors that don't support this feature, we'll not
> only have to make it optional again, but we'll also need to do fixes
> similar to the ARCH_CAPABILITIES situation - checking vendors, fixing
> compatibility issues, and all that stuff.
>
> Therefore, compared to default setting to constant, I think the optional
> NCI_NDD_NF now not only aligns with arch spec but also prevents future
> compatibility issues. :)
>
> Thanks,
> Zhao
>
>

--00000000000057a7a00643ee0785
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 19 nov 2025, 08:12 Zhao L=
iu &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; =
&gt; Note, APX_NCI_NDD_NF is documented as always enabled for Intel<br>
&gt; &gt; processors since APX spec (revision v7.0). Now any Intel processo=
r<br>
&gt; &gt; that enumerates support for APX_F (CPUID.(EAX=3D0x7, ECX=3D1).EDX=
[21])<br>
&gt; &gt; will also enumerate support for APX_NCI_NDD_NF.<br>
<br>
This sentence (from APX spec rev.7) emphasizes the =E2=80=9CIntel=E2=80=9D =
vendor,<br>
and its primary goal was to address and explain compatibility concern<br>
for pre-enabling work based on APX spec v6. Prior to v7, APX included<br>
NCI_NDD_NF by default, but this feature has now been separated from<br>
basic APX and requires explicit checking CPUID bit.<br>
<br>
x86 ecosystem advisory group has aligned on APX so it may be possible<br>
for other x86 vendors to implement APX without NCI_NDD_NF and this still<br=
>
match with the APX spec.<br></blockquote></div></div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Oh, I was not aware of that. It is really ugly but =
I guess that&#39;s not our choice. :/ If QEMU ever implements APX emulation=
 it will have NC/NDD/NF though...</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
If we default to setting this NCI_NDD_NF bit for APX, then in the future<br=
>
when we run into other vendors that don&#39;t support this feature, we&#39;=
ll not<br>
only have to make it optional again, but we&#39;ll also need to do fixes<br=
>
similar to the ARCH_CAPABILITIES situation - checking vendors, fixing<br>
compatibility issues, and all that stuff.<br>
<br>
Therefore, compared to default setting to constant, I think the optional<br=
>
NCI_NDD_NF now not only aligns with arch spec but also prevents future<br>
compatibility issues. :)<br>
<br>
Thanks,<br>
Zhao<br>
<br>
</blockquote></div></div></div>

--00000000000057a7a00643ee0785--


