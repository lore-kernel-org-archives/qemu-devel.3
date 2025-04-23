Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FFEC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 14:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7agl-0008OM-8c; Wed, 23 Apr 2025 10:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7agi-0008NB-8v
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 10:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u7age-00070K-FJ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 10:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745416966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dmde6222cFgAKhSQtACGe2YpbOe2HQ7ONpMZDtRR7n4=;
 b=FGBBhNLccfNboj4y6BJ9PLo043hI+73vQq1Aq4Xs/lAFvAUB+rmnrVHN2xm0tLbe+aG9eW
 nMu2nDNiw2C5xmsdxGrHMBEMksFTZN3pR1VvEcmCU5OWarbm/fiJyeHjUFJsPxgXSd4GLF
 W0N2wWHiaKwr81xmYK/Dn2w6GiEfm80=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-Vzm0_MqVP0u8z-hRDI8jXg-1; Wed, 23 Apr 2025 10:02:39 -0400
X-MC-Unique: Vzm0_MqVP0u8z-hRDI8jXg-1
X-Mimecast-MFC-AGG-ID: Vzm0_MqVP0u8z-hRDI8jXg_1745416958
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso36518675e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 07:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745416958; x=1746021758;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dmde6222cFgAKhSQtACGe2YpbOe2HQ7ONpMZDtRR7n4=;
 b=sQeEAeQl9Zk3CoczNddpWK4QxIuvNW5zKsmyfbLE0VEBGUnpxXQDGf7y4kUzvbXrFn
 0cCQhSfRqM2DFsOgWODAH1PsIdQePEmjxLYO8qkrUeGikjXUXogPKdjDEPdA1cMx3ssg
 h69PDzT8ztnei8FlqoqCDm8R166JxwXdtP9mlSnnU3QXYsTBn4w6pCI3elFUvPQp6w0f
 B1Kp57/+sq991UxRLVg8/fYvCH2Id1moIJxUv3bcIt8umAUuz0CEmNR/40FZgb4pqXVh
 tMKkUms5hZjbwVzbyWoOLqJQDgJvNU6AtYf52t27ENFIJFDyNU7duagsWRGj9tluD7Yz
 TUCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJ+trp3bJFsGagoeVvCF35WrgCw2f75rEQvNvuqZT7CvMGAvuxfPjnY6pIWdSzqQKMWiowvMSRBP6M@nongnu.org
X-Gm-Message-State: AOJu0YzPRV7kyYVefmVyxdJ5rX6rmHo4VkHkzGl1DjBxXdDcsmCfTu5Q
 RsyhLV46OfBipJES0TENvVyzLXSR+smWlK0WkZjmh4fuoOKTRHyKO7Xkn+VUlWz32lmxoq0M5Ww
 fZQgjQ+6rlejb66R6AIRIkSLbAaREp3bggpUZ4h54kKsW11kKUzOsxzaGH+2S3Z2s/qpjHUvanV
 ykPQsjUYBbyhgC52pIGXfPKciYPhM=
X-Gm-Gg: ASbGncun+F/TlsnCgm/Y7ZHnvsk8ZjV1ablQpES+WmbNVK/FjJNyRQ5evs6Y6fCyg//
 1I65aYO/vZqP9yEHvNIKZUsW0bLpGcRI2O2ONXREkRIu/uDoGUt561cloJmeKfTYkQJhz6A==
X-Received: by 2002:a05:600c:4690:b0:43d:17f1:2640 with SMTP id
 5b1f17b1804b1-4406ac0ed7emr160624425e9.26.1745416957654; 
 Wed, 23 Apr 2025 07:02:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYebq++udcG39wAHr8+DRjVNNUkKP66/tk8qIiqSBWgT+E67IxSwktYmXYW0xWM5aa8PmI7QYr09Lwa60pW/k=
X-Received: by 2002:a05:600c:4690:b0:43d:17f1:2640 with SMTP id
 5b1f17b1804b1-4406ac0ed7emr160622395e9.26.1745416955580; Wed, 23 Apr 2025
 07:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250423100949.2047161-1-ben.dooks@codethink.co.uk>
 <275dd8a6-c4f7-47de-ac45-64612e14b8a7@redhat.com>
 <ee7e6775-9dd7-48b4-a5f3-9189b1386deb@codethink.co.uk>
In-Reply-To: <ee7e6775-9dd7-48b4-a5f3-9189b1386deb@codethink.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 23 Apr 2025 16:02:23 +0200
X-Gm-Features: ATxdqUFLzn0NKCyrCjhBBVA_N-b7QxsqYrQIfTMZHLryyfVCAsIKfEB-Z7gK2VI
Message-ID: <CABgObfay=FyP=nQKGReCRZgVL4HaDF4Lb8Gan9OACtJ4bVDbog@mail.gmail.com>
Subject: Re: [RFC PATCH] tcg: allow tb_flags to be larger than 32bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 "Maydell, Peter" <peter.maydell@linaro.org>, Michael Rolnik <mrolnik@gmail.com>,
 brian.cain@oss.qualcomm.com, Helge Deller <deller@gmx.de>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>, 
 "Iglesias, Edgar" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Jarno, Aurelien" <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, 
 "zmta06.collab.prod.int.phx2.redhat.com, list@suse.de" <qemu-ppc@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, 
 qemu-s390x <qemu-s390x@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000009f72940633728dbf"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000009f72940633728dbf
Content-Type: text/plain; charset="UTF-8"

Il mer 23 apr 2025, 15:54 Ben Dooks <ben.dooks@codethink.co.uk> ha scritto:

> > Leaving aside your patch I think you can improve the density of the
> > tbflags a bit too:
> >
> > - PM_MASK_ENABLED, PM_BASE_ENABLED and AXL are unused, which gives you
> > back 4 bits.
>
> Hmm, the PM_MASK_ENABLED, PM_BASE_ENABLED are also used by VMA and VTA
>

Ah, indeed they were reused without removing the old ones. So those are
out...

> - VLMUL == 4 is invalid, and you can use that to get rid of VILL

> - SEW reserves 3 bits, but TCG only supports 8/16/32/64; that could be
> > one more bit if you can live with the limitation
>

... and any of these two is the easiest in the short term if you need to
recoup one bit.

Paolo

> This is already 6 bits, but for FS and VS it may be efficient enough to
> > have just one bit (dirty vs. everything else): for all cases other than
> > dirty, REQUIRE_FPU and require_rv* can call a helper to look at the
> > actual MSTATUS and generate the exception if the extension is disabled;
> > then the caller always proceeds with translation into TCG ops(*).  The
> > overhead for the DISABLED/INITIAL/CLEAN cases is minimal and it gives
> > back 2 more bits.
> >
> > Finally, in many cases it makes sense to do a full TB flush when CSRs
> > change.  However I am not sure if this could be done for RISC-V, maybe
> > for the CFI enabled bits?
>
> I'll have a look at those, but for now I'm going back to 9.1
>
>
> > Thanks,
> >
> > Paolo
> >
> > (*) that is:
> >
> > static bool require_rvv(DisasContext *s)
> > {
> >      REQUIRE_EXT(s, RVV);
> >      if (!s->mstatus_vs_dirty) {
> >          gen_helper_require_rvv(tcg_env);
> >      }
> >      return true;
> > }
> >
> > static bool require_rvf(DisasContext *s)
> > {
> >      switch (s->sew) {
> >      case MO_16:
> >          if (!s->cfg_ptr->ext_zvfh) {
> >              return false;
> >          }
> >          break;
> >      case MO_32:
> >          if (s->cfg_ptr->ext_zve32f) {
> >              return false;
> >          }
> >          break;
> >      case MO_64:
> >          if (s->cfg_ptr->ext_zve64d) {
> >              return false;
> >          }
> >          break;
> >      default:
> >          return false;
> >      }
> >
> >      if (!s->mstatus_fs_dirty) {
> >          gen_helper_require_rvf(tcg_env);
> >      }
> >      return true;
> > }
> >
> >
>
>
> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
>
> https://www.codethink.co.uk/privacy.html
>
>

--0000000000009f72940633728dbf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 23 apr 2025, 15:54 Ben Do=
oks &lt;<a href=3D"mailto:ben.dooks@codethink.co.uk">ben.dooks@codethink.co=
.uk</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">&gt; Leaving aside your patch I think you can improve the density o=
f the <br>
&gt; tbflags a bit too:<br>
&gt; <br>
&gt; - PM_MASK_ENABLED, PM_BASE_ENABLED and AXL are unused, which gives you=
 <br>
&gt; back 4 bits.<br>
<br>
Hmm, the PM_MASK_ENABLED, PM_BASE_ENABLED are also used by VMA and VTA<br><=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Ah, i=
ndeed they were reused without removing the old ones. So those are out...</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
 gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; - VLMUL =3D=3D 4 is invalid, and you can use that to get rid of VILL</=
blockquote></div></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_qu=
ote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; - SEW reserves 3 bits, but TCG only supports 8/16/32/64; that could be=
 <br>
&gt; one more bit if you can live with the limitation<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">... and any of these t=
wo is the easiest in the short term if you need to recoup one bit.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br=
></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
&gt; This is already 6 bits, but for FS and VS it may be efficient enough t=
o <br>
&gt; have just one bit (dirty vs. everything else): for all cases other tha=
n <br>
&gt; dirty, REQUIRE_FPU and require_rv* can call a helper to look at the <b=
r>
&gt; actual MSTATUS and generate the exception if the extension is disabled=
; <br>
&gt; then the caller always proceeds with translation into TCG ops(*).=C2=
=A0 The <br>
&gt; overhead for the DISABLED/INITIAL/CLEAN cases is minimal and it gives =
<br>
&gt; back 2 more bits.<br>
&gt; <br>
&gt; Finally, in many cases it makes sense to do a full TB flush when CSRs<=
br>
&gt; change.=C2=A0 However I am not sure if this could be done for RISC-V, =
maybe <br>
&gt; for the CFI enabled bits?<br>
<br>
I&#39;ll have a look at those, but for now I&#39;m going back to 9.1<br>
<br>
<br>
&gt; Thanks,<br>
&gt; <br>
&gt; Paolo<br>
&gt; <br>
&gt; (*) that is:<br>
&gt; <br>
&gt; static bool require_rvv(DisasContext *s)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 REQUIRE_EXT(s, RVV);<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 if (!s-&gt;mstatus_vs_dirty) {<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_require_rv=
v(tcg_env);<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 return true;<br>
&gt; }<br>
&gt; <br>
&gt; static bool require_rvf(DisasContext *s)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 switch (s-&gt;sew) {<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 case MO_16:<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s-&gt;cfg_ptr-&g=
t;ext_zvfh) {<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return false;<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 case MO_32:<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s-&gt;cfg_ptr-&gt=
;ext_zve32f) {<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return false;<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 case MO_64:<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s-&gt;cfg_ptr-&gt=
;ext_zve64d) {<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return false;<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 default:<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 if (!s-&gt;mstatus_fs_dirty) {<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gen_helper_require_rv=
f(tcg_env);<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 }<br>
&gt;=C2=A0 =C2=A0=C2=A0=C2=A0 return true;<br>
&gt; }<br>
&gt; <br>
&gt; <br>
<br>
<br>
-- <br>
Ben Dooks=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://www.codethin=
k.co.uk/" rel=3D"noreferrer noreferrer" target=3D"_blank">http://www.codeth=
ink.co.uk/</a><br>
Senior Engineer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Codethink - Providing Genius<br>
<br>
<a href=3D"https://www.codethink.co.uk/privacy.html" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">https://www.codethink.co.uk/privacy.html</a><br>
<br>
</blockquote></div></div></div>

--0000000000009f72940633728dbf--


