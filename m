Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727A8D4977B
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 18:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHosy-0000LW-5a; Sun, 01 Dec 2024 13:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tHosu-0000L1-Cx
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 13:41:32 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tHosq-0005q2-Bc
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 13:41:30 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-51532deb867so730001e0c.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 10:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733078486; x=1733683286;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MvlyvbHT3p72WD9hYAfRiva3dqGd6ecZPtG56Rj/bQA=;
 b=bcXxCTDDBYK2QEnqup+3nrb+Jz9wM5p+oXREtLQ1NA88O+pUxh2Ohe/SqGuFmVjcbo
 wfCknTT8dkds2cR9O79vKh13urEqDDQgE0JFz+4BflqFMNeJc84M/Fo5x0D82QtxctbV
 Ot9lM6GOkudBx7mYO9eLDkSEhhmbLUIxoz1EV+Evk5dJ2+PPXsAm9nfyoFp2umPQq2ix
 n6+FN+lD+Azs/K45H3os/yReCV8oITfOSxLnrfmOkz44Gq8bmcoOsNiw21GMT4N/VKPP
 YjycHJxdUGqzgi0bg9ru3oYRYc4PhrmvSjqIxn13k+YV7P8hv/6lCXb7Fg93G2y+KKGA
 Hg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733078486; x=1733683286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MvlyvbHT3p72WD9hYAfRiva3dqGd6ecZPtG56Rj/bQA=;
 b=JNI9j5N2+VVor21R5aDm0L7j0exMAqxlWGa8gXcZQ77H1Y/RhVtQzGFKuVd7ZZUFEr
 SNjVtjA0nx1sxupf+RRcTEnTwxAABxb4n3mw7CWKyaxWRsKuRwCZ3J7OQ1TcbNzjghHr
 H35nr//1W9sB+5GU0hBBqtjImcw2g+LFPAAyU38778y08alKdGhaLLStFLPv6k9r2Xgg
 NUwPnbyBwXqUxIYcOd8+etQcjXTNb49zAnRGp2hCJrG3D/gfRgmA254HGAJttGrjOhPK
 8ad1LIyvcGLSZYIQmruRJyGf41kahmBRlqQprTeLCQZAVBoB8Y4JjwwFGLBROMcOQVy2
 xXpA==
X-Gm-Message-State: AOJu0Yz71qddTyCGOiBfMRaeNtCrXVHxawmFAkppnxqp9U0t3GXHMfCO
 +fLjriaI/zGTBN/KQKZ+6KpORHFDNgsOH2Osg3LgNH2z4nR9g7sPhHoAmEcJJVCJtmlSqKGwx87
 +APQPFmj3K555WcQeHvjEkYzx1cNwAdSvY+wy
X-Gm-Gg: ASbGncvnWWbUT8UmBJLmT5Kau4TLJ91gusm4mJSFahJ+fGqJlkAgAqUhxj05EOYCUc9
 dGPDcMZ6jF+ptxZYTEtMiXa7FCTE2ucg=
X-Google-Smtp-Source: AGHT+IEiiCqGRJfUBtrjziq9sxxhbeDZ3r3sFfBHbrqiwSfIAUqhCxNdYrtikZQZPMSDGAkqG2iMpS23nJvScv4X4A4=
X-Received: by 2002:a05:6102:374e:b0:4af:958:97d5 with SMTP id
 ada2fe7eead31-4af44a69739mr22032458137.25.1733078485652; Sun, 01 Dec 2024
 10:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20241129152506.59390-1-phil@philjordan.eu>
 <20241129152506.59390-16-phil@philjordan.eu>
 <aa724c83-df51-48a4-a697-586b90ed3f0e@daynix.com>
In-Reply-To: <aa724c83-df51-48a4-a697-586b90ed3f0e@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sun, 1 Dec 2024 19:41:15 +0100
Message-ID: <CAAibmn0hssDfmG19d7qxww=Ko9VWy6SugPUe7j9mOZkzenbuWQ@mail.gmail.com>
Subject: Re: [PATCH v12 15/15] hw/vmapple/vmapple: Add vmapple machine type
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000817144062839c7c8"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=phil@philjordan.eu; helo=mail-vk1-xa2e.google.com
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

--000000000000817144062839c7c8
Content-Type: text/plain; charset="UTF-8"

Thanks for testing, and thank you for putting all that effort into repeated
reviews!

I now also have a solution for the keyboard/mouse/USB issue in case you
want to re-test with that applied on top.
https://patchew.org/QEMU/20241201160316.96121-1-phil@philjordan.eu/

All the best,
Phil

On Sat, 30 Nov 2024 at 07:33, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

> On 2024/11/30 0:25, Phil Dennis-Jordan wrote:
> > From: Alexander Graf <graf@amazon.com>
> >
> > Apple defines a new "vmapple" machine type as part of its proprietary
> > macOS Virtualization.Framework vmm. This machine type is similar to the
> > virt one, but with subtle differences in base devices, a few special
> > vmapple device additions and a vastly different boot chain.
> >
> > This patch reimplements this machine type in QEMU. To use it, you
> > have to have a readily installed version of macOS for VMApple,
> > run on macOS with -accel hvf, pass the Virtualization.Framework
> > boot rom (AVPBooter) in via -bios, pass the aux and root volume as pflash
> > and pass aux and root volume as virtio drives. In addition, you also
> > need to find the machine UUID and pass that as -M vmapple,uuid=
> parameter:
> >
> > $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=0x1234 -m 4G \
> >      -bios
> /System/Library/Frameworks/Virtualization.framework/Versions/A/Resources/AVPBooter.vmapple2.bin
> >      -drive file=aux,if=pflash,format=raw \
> >      -drive file=root,if=pflash,format=raw \
> >      -drive file=aux,if=none,id=aux,format=raw \
> >      -device vmapple-virtio-aux,drive=aux \
> >      -drive file=root,if=none,id=root,format=raw \
> >      -device vmapple-virtio-root,drive=root
> >
> > With all these in place, you should be able to see macOS booting
> > successfully.
> >
> > Known issues:
> >   - Keyboard and mouse/tablet input is laggy. The reason for this is
> >     either that macOS's XHCI driver is broken when the device/platform
> >     does not support MSI/MSI-X, or there's some unfortunate interplay
> >     with Qemu's XHCI implementation in this scenario.
> >   - Currently only macOS 12 guests are supported. The boot process for
> >     13+ will need further investigation and adjustment.
> >
> > Signed-off-by: Alexander Graf <graf@amazon.com>
> > Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>
> Finally I confirmed macOS 12 boots on M2 MacBook Air. Thank you for
> keeping working on this series!
>
> Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>

--000000000000817144062839c7c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks for testing, and thank you for putting all tha=
t effort into repeated reviews!</div><div><br></div><div>I now also have a =
solution for the keyboard/mouse/USB issue in case you want to re-test with =
that applied on top.</div><div><a href=3D"https://patchew.org/QEMU/20241201=
160316.96121-1-phil@philjordan.eu/" target=3D"_blank">https://patchew.org/Q=
EMU/20241201160316.96121-1-phil@philjordan.eu/</a></div><div><br></div><div=
>All the best,</div><div>Phil<br></div></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Sat, 30 Nov 2024 at 07:33, Akihik=
o Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" target=3D"_blank">a=
kihiko.odaki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On 2024/11/30 0:25, Phil Dennis-Jordan wrote:<br>
&gt; From: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" target=3D"=
_blank">graf@amazon.com</a>&gt;<br>
&gt; <br>
&gt; Apple defines a new &quot;vmapple&quot; machine type as part of its pr=
oprietary<br>
&gt; macOS Virtualization.Framework vmm. This machine type is similar to th=
e<br>
&gt; virt one, but with subtle differences in base devices, a few special<b=
r>
&gt; vmapple device additions and a vastly different boot chain.<br>
&gt; <br>
&gt; This patch reimplements this machine type in QEMU. To use it, you<br>
&gt; have to have a readily installed version of macOS for VMApple,<br>
&gt; run on macOS with -accel hvf, pass the Virtualization.Framework<br>
&gt; boot rom (AVPBooter) in via -bios, pass the aux and root volume as pfl=
ash<br>
&gt; and pass aux and root volume as virtio drives. In addition, you also<b=
r>
&gt; need to find the machine UUID and pass that as -M vmapple,uuid=3D para=
meter:<br>
&gt; <br>
&gt; $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=3D0x1234 -m 4G \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -bios /System/Library/Frameworks/Virtualization.fr=
amework/Versions/A/Resources/AVPBooter.vmapple2.bin<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Daux,if=3Dpflash,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Droot,if=3Dpflash,format=3Draw \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Daux,if=3Dnone,id=3Daux,format=3Draw =
\<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -device vmapple-virtio-aux,drive=3Daux \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -drive file=3Droot,if=3Dnone,id=3Droot,format=3Dra=
w \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 -device vmapple-virtio-root,drive=3Droot<br>
&gt; <br>
&gt; With all these in place, you should be able to see macOS booting<br>
&gt; successfully.<br>
&gt; <br>
&gt; Known issues:<br>
&gt;=C2=A0 =C2=A0- Keyboard and mouse/tablet input is laggy. The reason for=
 this is<br>
&gt;=C2=A0 =C2=A0 =C2=A0either that macOS&#39;s XHCI driver is broken when =
the device/platform<br>
&gt;=C2=A0 =C2=A0 =C2=A0does not support MSI/MSI-X, or there&#39;s some unf=
ortunate interplay<br>
&gt;=C2=A0 =C2=A0 =C2=A0with Qemu&#39;s XHCI implementation in this scenari=
o.<br>
&gt;=C2=A0 =C2=A0- Currently only macOS 12 guests are supported. The boot p=
rocess for<br>
&gt;=C2=A0 =C2=A0 =C2=A013+ will need further investigation and adjustment.=
<br>
&gt; <br>
&gt; Signed-off-by: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" t=
arget=3D"_blank">graf@amazon.com</a>&gt;<br>
&gt; Co-authored-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjord=
an.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; Reviewed-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.=
com" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
<br>
Finally I confirmed macOS 12 boots on M2 MacBook Air. Thank you for <br>
keeping working on this series!<br>
<br>
Tested-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com" ta=
rget=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br>
</blockquote></div>

--000000000000817144062839c7c8--

