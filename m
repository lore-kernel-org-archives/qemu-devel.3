Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3293C88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 04:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5ylI-00029y-Av; Mon, 14 Sep 2026 00:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x5ylD-00029d-QG
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 00:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x5ylB-0005lf-BV
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 00:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789361859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ul77X7GFFEAOI0e8pOYpCa/zrVeQtoo1OGbx5y4OHJ8=;
 b=KYI0WwJ/EoCmVLLaOCAYgWHOrVwSDpebmqbTxLWnObe4QYaqqNn62ezj8vFYkG4VuY5z87
 KB/lY2SiH1GyrzMh9yN51222TkXFlprj0fyMx5qYC8nDDkEUGBfpS/6nOAGvVPzWelwyN5
 wBjp0z5ElKwc2Ve47Xc93fI7OIy0jok=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-Wif5g4vhP7Gq9ZCJHNW2pQ-1; Mon, 14 Sep 2026 00:57:37 -0400
X-MC-Unique: Wif5g4vhP7Gq9ZCJHNW2pQ-1
X-Mimecast-MFC-AGG-ID: Wif5g4vhP7Gq9ZCJHNW2pQ_1789361856
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48701f7ecb9so145492f8f.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 21:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789361856; cv=none;
 d=google.com; s=arc-20260327;
 b=V8zjIUqYFHQGC6S/4RgmA35Dy5a3tq3Uk+mECJ46RuTxP8gETjbyetmTwFiX9VMW7/
 r/jDWoK78+50CLwSR5b8jYLPHJH9QFXUIl9GwWHKiv9GAYHvtf8IXPZoKgYUpsUqEY4z
 7PSZfQqIEgxdqHOP6acFy3sCvQ7rGNI1Wb08vdLFe3lozTZ/J6Kqv/rXr7bhUUVe8d7C
 s0Gmmbxax4tJ8I5nbnMBqqCyUhIQhZkJ/G86VmY04Gyno6dHQcJ38j2zW2dG8auQVdGd
 E4kcUc1rXk5ZyVgq9czk7xVpJaJMOIxe6sgfH4k9Y+FkfON8vG8L3HXXGYEeOfFWjsaT
 9ESA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ul77X7GFFEAOI0e8pOYpCa/zrVeQtoo1OGbx5y4OHJ8=;
 fh=zyyal1DvfdiWXfWXUYYB9y2jLL6FErCwjKVHpePzbxM=;
 b=aPWIhdme0knck64P2Gtthx8nPZrGjIJ3mfoRaSmNIJMIjHAybmrF1QRPSfPDQ9SoC4
 LfEX3gR2PMpKSDCzIFLqm/p+8J/rwT2O+/m5WJebmnOAeo27m/eQOYNc+xeX/bgi4MZT
 li4JHbQiLVXWQ0R18ZVrwP7+B8dI9n31k66bug3thJ4z07HKXirefnEi0N9zfKlbhIHE
 yPo5v2nBOKAL9d37YE/MvxCmBJ4/AjR8ntzhlGL8g9XaKAr741UQiZmLpVtCuXsIUr86
 fEgruuCFsMo+qIH0+dnrcCB40RUtxKND9NVlOABxeUpo4Z5IGfNlWZ35yF6mQE4c+pq0
 ykeg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789361856; x=1789966656; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ul77X7GFFEAOI0e8pOYpCa/zrVeQtoo1OGbx5y4OHJ8=;
 b=D3XTVCUOBNvFD6DymnqWhEYRHH3+wRi+GEpoAHr4xmxCzvBVAS5X1tiTaFRN7oE9w1
 vb6oBvMiP8mp3CY1E62CWn1NYAOrwSn22yVdyvdFq8BTq6bnGYmcfouF4knO3MjPt48l
 t59R+ZpkEsq779PLhWiLfKgUfEu6iTLSbflmyjozhUCx79y1PEqBNhC2KCGAebt5AKe6
 aOJ35cLSQJdDv7kupW+1PhiN4t9ezWfoQXOOEUb0TKfFMtmpR6MLNAMI+f/oNwnVBlMC
 9FQ3chro3rscliuLWSMaNlerxrZWIBG6k3zpoNdWZcPdVw/JB0SeCb+VTX8PsX7PxGTW
 w1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789361856; x=1789966656;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ul77X7GFFEAOI0e8pOYpCa/zrVeQtoo1OGbx5y4OHJ8=;
 b=ngQbFVH+iZIayrf0gehUM9q8ZoGvk06+GO22eAr18IYuOV/fOLgbiPVXaBMWpFbR6+
 Q4eYjFmdLJwE6oNXMnjkT+0fZXT5nBKFOXlRjEhjPWdjkNftDJYJIjIjYjrvUPRIebd8
 XuNPW5V21B7/EfRpC8K2QSYKrflZCQd1zTrcgdg2gpB1V9LnuBwBSCi2bZtwnPBnyc0Y
 KhGJugF2LTs/4/lSPlIO6gKfxOBddGGhfma/pcshL79pJliexjdBH5GpgEbVd2U0ccUy
 oMICQvWPA2sI2xRjbBTsVG5dHbaUzhx6CygzFYuF7vNT0EueiKaEfzCOAhmOogKPcSWE
 fQUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBJYh6hSd8z5E186t0sagg2fVnziHjtDXMdCzi/9zkZpE3cDQc7/ajTt0k1e0fMUAWafehBfMmos+X@nongnu.org
X-Gm-Message-State: AFuF++kY6PkbfBHkuLqUy+j0JqH8QN8Vz6bXpVKvs4Bw+HpMv1EIsfqz
 vf3F2GOIuNT8l88IMpRrEFGyvdb2BpuAD6OaF2tdTpAwP0qAaTmtsfaay9tiRUNwUy2i/2aTC4e
 +He5NaQWpHtWtfW2+KnaOacLe1tsW7c6DC/1afWmMkVxfY/2icDfvAoWgCLOIkV95XcmuIqFtH4
 7Oir1kDWpZHxDMbJ+WuOrbhy/269u/JN4=
X-Gm-Gg: AYBFou1r6Q7kKjYT6wuIdVYhwQfq0jYDB8L6Qs06Px8VuKjdL4nZeEhrKbvhnOuk2Mw
 Ss1IOfgyw7ANfsVYeT5sFb/aVy5/++rQp1SbtT6lKOYj0RP5iP6Lzzksk/Wswwt5a4VrYrjtX+M
 oImCOGyvWCP7p1adLUUDEtzM+xVdnov1s8qdbzSpPOEWfpu/HrsJGwjMIVpfnoz5FY0YxfAffdh
 WHeWWw23ktT9lCRdehzIqQncFAGQmo7y1c+A2lLf1nwOxcUYhqpUwSEOdT7ww==
X-Received: by 2002:a05:6000:41c3:b0:487:cd:f1ad with SMTP id
 ffacd0b85a97d-48702b6a54bmr757205f8f.45.1789361855934; 
 Sun, 13 Sep 2026 21:57:35 -0700 (PDT)
X-Received: by 2002:a05:6000:41c3:b0:487:cd:f1ad with SMTP id
 ffacd0b85a97d-48702b6a54bmr757188f8f.45.1789361855633; Sun, 13 Sep 2026
 21:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
In-Reply-To: <87a4pn8yra.fsf@draig.linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 14 Sep 2026 06:57:23 +0200
X-Gm-Features: AcwNN1X-pqQ532TeF7jisOK7o6mvV3ZwcOeE2K417cmV6-EqxII1YrZ9GsFGHX4
Message-ID: <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Eric Farman <farman@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>, 
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>, 
 Joshua Daley <jdaley@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>
Content-Type: multipart/alternative; boundary="000000000000c7acad065b6a45af"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000c7acad065b6a45af
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 11 set 2026, 19:49 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha scri=
tto:

> Thanks for pointing this out. I hadn't noticed the issue as I guess we
> don't build firmware in the CI. That said on my current tree:
>
>  cd /home/alex/lsrc/qemu.git/builds/all/pc-bios/s390-ccw
>  make
>  -Wno-stringop-overflow detected
>  -fno-stack-protector detected
>  -Wno-array-bounds detected
>  -Wno-gnu detected
>  -march=3Dz900 detected
>  Assembling start.o
>  Compiling main.o
>  Compiling bootmap.o
>  Compiling jump2ipl.o
>  Compiling sclp.o
>  Compiling menu.o
>  Compiling netmain.o
>  Compiling virtio.o
>  Compiling virtio-net.o
>  Compiling virtio-scsi.o
>  Compiling virtio-blkdev.o
>  Compiling cio.o
>  Compiling dasd-ipl.o
>  Compiling virtio-ccw.o
>  Compiling clp.o
>  Compiling pci.o
>  Compiling virtio-pci.o
>  Compiling secure-ipl.o
>  Linking s390-ccw.elf
>  Stripping s390-ccw.elf into s390-ccw.img
>
> So it seems to be working. How do you usually invoke the build?
>
> > Fearing the worst, I started converting to use meson directly (which
> > is probably a noble goal anyway). I still don't have a workable image,
> > as inheriting the common meson cc/ld flags exposes a bunch of other
> > problems. Will keep poking, but I'd like to know if there's an
> > easier/better option here?
>
> I suspect the easiest way would be to move the rom specific cross
> compiler detection into a configure script within pc-bios. Paolo wdyt?
>

I would prefer to revert this and load the config file from meson instead.

Paolo


>
> >
> > Thanks,
> > Eric
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>
>

--000000000000c7acad065b6a45af
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 11 set 2026, 19:49 Alex B=
enn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro=
.org</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
Thanks for pointing this out. I hadn&#39;t noticed the issue as I guess we<=
br>
don&#39;t build firmware in the CI. That said on my current tree:<br>
<br>
=C2=A0cd /home/alex/lsrc/qemu.git/builds/all/pc-bios/s390-ccw<br>
=C2=A0make<br>
=C2=A0-Wno-stringop-overflow detected<br>
=C2=A0-fno-stack-protector detected<br>
=C2=A0-Wno-array-bounds detected<br>
=C2=A0-Wno-gnu detected<br>
=C2=A0-march=3Dz900 detected<br>
=C2=A0Assembling start.o<br>
=C2=A0Compiling main.o<br>
=C2=A0Compiling bootmap.o<br>
=C2=A0Compiling jump2ipl.o<br>
=C2=A0Compiling sclp.o<br>
=C2=A0Compiling menu.o<br>
=C2=A0Compiling netmain.o<br>
=C2=A0Compiling virtio.o<br>
=C2=A0Compiling virtio-net.o<br>
=C2=A0Compiling virtio-scsi.o<br>
=C2=A0Compiling virtio-blkdev.o<br>
=C2=A0Compiling cio.o<br>
=C2=A0Compiling dasd-ipl.o<br>
=C2=A0Compiling virtio-ccw.o<br>
=C2=A0Compiling clp.o<br>
=C2=A0Compiling pci.o<br>
=C2=A0Compiling virtio-pci.o<br>
=C2=A0Compiling secure-ipl.o<br>
=C2=A0Linking s390-ccw.elf<br>
=C2=A0Stripping s390-ccw.elf into s390-ccw.img<br>
<br>
So it seems to be working. How do you usually invoke the build?<br>
<br>
&gt; Fearing the worst, I started converting to use meson directly (which<b=
r>
&gt; is probably a noble goal anyway). I still don&#39;t have a workable im=
age,<br>
&gt; as inheriting the common meson cc/ld flags exposes a bunch of other<br=
>
&gt; problems. Will keep poking, but I&#39;d like to know if there&#39;s an=
<br>
&gt; easier/better option here?<br>
<br>
I suspect the easiest way would be to move the rom specific cross<br>
compiler detection into a configure script within pc-bios. Paolo wdyt?<br><=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I wou=
ld prefer to revert this and load the config file from meson instead.=C2=A0=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_con=
tainer"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Eric<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
<br>
</blockquote></div></div></div>

--000000000000c7acad065b6a45af--


