Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90911C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x63CY-0007Xn-Sj; Mon, 14 Sep 2026 05:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x63CX-0007XQ-K2
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x63CU-0001wf-4z
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789378929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d6nuhTASwdygZ16yZhgzGNK1vUOSqCwBBNrAtFcc5FE=;
 b=JejpvbDMql5tirkqKzla7BA7mvlqHby52m4H3UkSjzH9DYw4OWuwR/R8AEjizjEIv4st+7
 pp8qe+5FDjj91UB0WRrqqE3wxYhG40V3jksdOHCIC32h2uUl72kXf8VYHVbNAXgNZ+fGKg
 qUVffF6p0gn3gS5vpXlb97DoA5lOn5w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-A2L27yWaOrqKHloqw_n5ww-1; Mon, 14 Sep 2026 05:42:06 -0400
X-MC-Unique: A2L27yWaOrqKHloqw_n5ww-1
X-Mimecast-MFC-AGG-ID: A2L27yWaOrqKHloqw_n5ww_1789378925
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39533bb224cso3797414a91.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 02:42:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789378925; cv=none;
 d=google.com; s=arc-20260327;
 b=iXdoiq86nejzlQtZuAgKBgytxuJjNZtws+wdOBOGKa6fbkpcwfCR37je7ZdMroTw07
 h8jHY4MTQlIPhTzhv5pw00mDKzurMD9Pfq92BMCH0nbxsdQQiOd9CPzs5msVM0W3Fbf1
 YP+zpGM+jw40Hb9yM69g5HVRpi/xoJ9TX27tjHP1sVmbuRTCQxf0KwwSbYe9PsmoV0l7
 Kn284jvdxAA9T4SuoxGtZVwJQyN7PKvqxvDRj2VxMpeG2ypvt9H9qeeebacGQvVxXEDI
 chkR3gdlP9gXehi/d42cj6J4ak/tcK+82u8GlzCLoV108WP3guBdkMLjCd0jRxCq5+Zh
 elvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d6nuhTASwdygZ16yZhgzGNK1vUOSqCwBBNrAtFcc5FE=;
 fh=GHRgIo4Mqr9cM90OZATk98gtxn7Fy4MWEZN1Jlm5aso=;
 b=jp55NT49Uz306EJgpGE9c8mXH3Zaib9aFW4TzfZ5GyhkghJPJQ+M901TpVglvv06Hm
 EpfAWc4Wo+WiA2cSVEcDvlbrOnHRvndz9s/rMuLVs8CtL22PCALgm0kYQMVISligC8I/
 GpsGwb1mjSxk/nCAoiR+rE0fHX9Ke7YnlxyRGIpCP4rL2ITOZ/dOkVnadcWbizct72Xf
 9eA7G9ipg74rpMQqx9CGalGPefMjk/f+XrU8FtHJ9Ss8SQDC5L01QDPuCM4nl20E7ATO
 T+I5U1qKQLfcG4I56vQ7tCSYjwx5XIQI5t2Ap+mEJfw6oEIxfMFBlkm7cdnTktL2JsSU
 Yu4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789378925; x=1789983725; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=d6nuhTASwdygZ16yZhgzGNK1vUOSqCwBBNrAtFcc5FE=;
 b=j4XOqtHGn0Bj9/kCmbuM4QWRO+hXmNQfLryOIai3Yhsl29OUFp3b8GjdlrrnQyP01h
 +oTQHK9zHV1ZRc9pfzapaYISaWvAhSmj2ZBPOZJwogeNtRJek2NfpUasu8IaSNvPAtd4
 Yf30fDyWL3A3KHdibc7Z+1K29hswGhY0fEw/h6JPXKeO42cNKJzQz2e41yJTeZXLeB9o
 fk0pzSRNlq57d4Ex7ysjswdpGmhwH4CK9Tdtt/2WDhePqqOfd2qHggi2YHykQbMhiwHV
 RsjRebnEVcHWTEsWKyFgi1yDuUQuKwqL3sLAHL6ZkjrxgOMDwFVcRpL4Z+vS6X5+H2bq
 AvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789378925; x=1789983725;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d6nuhTASwdygZ16yZhgzGNK1vUOSqCwBBNrAtFcc5FE=;
 b=ay2V5nilKk5KIJ7cq6YHJxC+ZRtfRzpD+9duSWQ1ns2Pzb8ecLhMkscEr8oOGVjM3/
 JfzBzp0s4ZusKaooGManBJCrJll36HIAhgYKhpHR/eqdbor6xKCII19LQWeGXw5+QhVx
 wEjMYiM8FnutN/YPRqZ2AAOvrewyRasWjWsCD4DT6f1Zgz8Y00BjJsFQ0gSgAi14XT/d
 kiu7HmicXNK8JBeK5Pv9S0fr8SS7Brg4ncS/ti7IUsSwXOaeLWofPhqIn4TX07bJ53zZ
 nk+WnKJGiDs2WUEpCa9MUaSspXMoE/efr2stBvmy8ZTHeNmw6xDiTvh96XMo1Alkwbhe
 T7hQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz44LBVFjQ6LL4Rl3Sbk54V3Yns+9PkRuFhYEEB3G9yKQ5fkqHjLzPRwOlIzanYX+7DyjuU1HXHUp1d@nongnu.org
X-Gm-Message-State: AFuF++nSihxBv+7FBC30hejU13IWTJdS6Mq1Q9o3SR8l1L/mn/uU/cls
 o2K/9dyip7H03xlUEprUwYsA/4pUyphYilWmInxZ7bRIu/q9UXSeT4KmzI+JPu0x69iu+skpLEe
 IZlq97s3PXkEEl/7s45GpAhmZZsQKDGJAw9Hiz3Lz0WmqD6c1PIYd3pAESBNtfkdHXNf4j97aqb
 tVnfSgoZuCnMS2T4HXQFVOhtFiivl7BM0=
X-Gm-Gg: AYBFou21fPIi9W6nV/zlvAqA/mgJfeBmJL2CASObEwgHMp/hE5167FamDl26KBvhVzM
 mdUaL9fbujoE3rmLOn7EoDeGs1m0fbFTfSPwVk2V40czUrDZ9A7jQLog5Jgc9ducj5V8NoGm9s8
 X58fLmtuL6XkGddMVTIcdf+oFZmlhBpT/wag9NhdvkIxqk9itx/Cfa6n+AJA25iK8uGZigIO/uL
 Z1/YdNoU7UfYMhFinU7ULC5StUpcUEZR9qikO74sB7r6aAWzLNwqOmvCGByaA==
X-Received: by 2002:a17:90b:28d0:b0:396:4c63:7193 with SMTP id
 98e67ed59e1d1-39debfb7ae5mr4144435a91.11.1789378924863; 
 Mon, 14 Sep 2026 02:42:04 -0700 (PDT)
X-Received: by 2002:a17:90b:28d0:b0:396:4c63:7193 with SMTP id
 98e67ed59e1d1-39debfb7ae5mr4144390a91.11.1789378924464; Mon, 14 Sep 2026
 02:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
In-Reply-To: <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 14 Sep 2026 11:41:51 +0200
X-Gm-Features: AcwNN1UVP8i5D9Ke_xJ8bZl2HAlapz_XFL-bI0e625VuH0G-01IjPA1zjRpoHxM
Message-ID: <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Farman <farman@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Aniket Sahu <asahu1x@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, 
 Zhuoying Cai <zycai@linux.ibm.com>, Joshua Daley <jdaley@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000296248065b6e3f95"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
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

--000000000000296248065b6e3f95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 14 set 2026, 07:54 Pierrick Bouvier <
pierrick.bouvier@oss.qualcomm.com> ha scritto:

> On 9/13/26 9:57 PM, Paolo Bonzini wrote:
> >
> >
> > Il ven 11 set 2026, 19:49 Alex Benn=C3=A9e <alex.bennee@linaro.org
> > <mailto:alex.bennee@linaro.org>> ha scritto:
> >
> >     Thanks for pointing this out. I hadn't noticed the issue as I guess
> we
> >     don't build firmware in the CI. That said on my current tree:
> >
> >       cd /home/alex/lsrc/qemu.git/builds/all/pc-bios/s390-ccw
> >       make
> >       -Wno-stringop-overflow detected
> >       -fno-stack-protector detected
> >       -Wno-array-bounds detected
> >       -Wno-gnu detected
> >       -march=3Dz900 detected
> >       Assembling start.o
> >       Compiling main.o
> >       Compiling bootmap.o
> >       Compiling jump2ipl.o
> >       Compiling sclp.o
> >       Compiling menu.o
> >       Compiling netmain.o
> >       Compiling virtio.o
> >       Compiling virtio-net.o
> >       Compiling virtio-scsi.o
> >       Compiling virtio-blkdev.o
> >       Compiling cio.o
> >       Compiling dasd-ipl.o
> >       Compiling virtio-ccw.o
> >       Compiling clp.o
> >       Compiling pci.o
> >       Compiling virtio-pci.o
> >       Compiling secure-ipl.o
> >       Linking s390-ccw.elf
> >       Stripping s390-ccw.elf into s390-ccw.img
> >
> >     So it seems to be working. How do you usually invoke the build?
> >
> >      > Fearing the worst, I started converting to use meson directly
> (which
> >      > is probably a noble goal anyway). I still don't have a workable
> >     image,
> >      > as inheriting the common meson cc/ld flags exposes a bunch of
> other
> >      > problems. Will keep poking, but I'd like to know if there's an
> >      > easier/better option here?
> >
> >     I suspect the easiest way would be to move the rom specific cross
> >     compiler detection into a configure script within pc-bios. Paolo
> wdyt?
> >
> >
> > I would prefer to revert this and load the config file from meson
> instead.
> >
> > Paolo
> >
>
> I would be happy to see only the related part reverted if possible, and
> not all the patch. That said, no strong opinion, just a preference to
> avoid seeing people start depending on this config file for other
> things, instead of doing things properly in meson.
>

This is documented as a task for configure, so I don't think it's a problem
not to do it in meson. In fact creating containers is not done by meson
(it's done by make) so there is no real reason to do it outside configure.

Having firmware have its own configure script is also bad, since you end up
having code duplication.

Overall, I don't see the big issue in reverting this patch.

Paolo

--000000000000296248065b6e3f95
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 14 set 2026, 07:54 Pierri=
ck Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@oss.qualcomm.com">pierric=
k.bouvier@oss.qualcomm.com</a>&gt; ha scritto:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">On 9/13/26 9:57 PM, Paolo Bonzini wrote:<b=
r>
&gt; <br>
&gt; <br>
&gt; Il ven 11 set 2026, 19:49 Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.=
bennee@linaro.org" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linaro.=
org</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank"=
 rel=3D"noreferrer">alex.bennee@linaro.org</a>&gt;&gt; ha scritto:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Thanks for pointing this out. I hadn&#39;t noticed =
the issue as I guess we<br>
&gt;=C2=A0 =C2=A0 =C2=A0don&#39;t build firmware in the CI. That said on my=
 current tree:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0cd /home/alex/lsrc/qemu.git/builds/all/pc-bi=
os/s390-ccw<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0make<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-stringop-overflow detected<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-fno-stack-protector detected<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-array-bounds detected<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-Wno-gnu detected<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-march=3Dz900 detected<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Assembling start.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling main.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling bootmap.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling jump2ipl.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling sclp.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling menu.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling netmain.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling virtio.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling virtio-net.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling virtio-scsi.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling virtio-blkdev.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling cio.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling dasd-ipl.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling virtio-ccw.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling clp.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling pci.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling virtio-pci.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Compiling secure-ipl.o<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Linking s390-ccw.elf<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0Stripping s390-ccw.elf into s390-ccw.img<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0So it seems to be working. How do you usually invok=
e the build?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Fearing the worst, I started converting to us=
e meson directly (which<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; is probably a noble goal anyway). I still don=
&#39;t have a workable<br>
&gt;=C2=A0 =C2=A0 =C2=A0image,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; as inheriting the common meson cc/ld flags ex=
poses a bunch of other<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; problems. Will keep poking, but I&#39;d like =
to know if there&#39;s an<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; easier/better option here?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I suspect the easiest way would be to move the rom =
specific cross<br>
&gt;=C2=A0 =C2=A0 =C2=A0compiler detection into a configure script within p=
c-bios. Paolo wdyt?<br>
&gt; <br>
&gt; <br>
&gt; I would prefer to revert this and load the config file from meson inst=
ead.<br>
&gt; <br>
&gt; Paolo<br>
&gt;<br>
<br>
I would be happy to see only the related part reverted if possible, and <br=
>
not all the patch. That said, no strong opinion, just a preference to <br>
avoid seeing people start depending on this config file for other <br>
things, instead of doing things properly in meson.<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">This is documented as a t=
ask for configure, so I don&#39;t think it&#39;s a problem not to do it in =
meson. In fact creating containers is not done by meson (it&#39;s done by m=
ake) so there is no real reason to do it outside configure.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Having firmware have its own configur=
e script is also bad, since you end up having code duplication.</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Overall, I don&#39;t see the big is=
sue in reverting this patch.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Paolo</div></div>

--000000000000296248065b6e3f95--


