Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A55C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 17:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyugw-0003nG-Ln; Tue, 25 Aug 2026 13:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wyugv-0003mG-BM
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 13:12:05 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wyugs-0001gL-62
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 13:12:05 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-836c8bdac50so68605537b3.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 10:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787677921; cv=none;
 d=google.com; s=arc-20260327;
 b=gimpUs49I5Gn56rVCS4UWKw3FHG3dAys21exfsPR+JzUsr9eN42ENCu9zHDUG6DuvC
 MjLidh1Y7IE0PgZkTmHMYpXumk39jXIHKx4aOjo1Pa/5/sSVdjBrd5roK3wcwDiIgWpj
 rTsJpnwHYXiaptIO/ifkf5JMNlkhx7sER7tnIvZAPM2w0QDT5PNLkZvwpVzOGR8cVTgO
 ABpRiHqvIvqMAk2nbzsfRqMYB48HxcyA/S+mQpJO94O4FT8d8W6ECbfNwWQxIaZuE+va
 IYBf/1bmfilGyOSpI7AP5U8jmTHOv7OlZoL1fMZs64uRRY7Bc5ok9Yjc6iXdSJuGJKwl
 gqlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aLrwkN2hpeFMupH+bxDa1e3NGhRfPpCK+VUOuYRo6l4=;
 fh=H+NDqK5G0NiN38mVV0dYIBigLFnDDn5Om11Gwu6V+aY=;
 b=HdIgpiZyNRtFU+jvbIOw2OMVYNUcigUR5Ysf17IJrzMsIIREdJiYWMhP25SezKZ+oB
 MKXYlIScxdREkvZuA8j5sEHDiuhmSRbwdo8PyxbUr6Ll8pgpd0maN1w4jujuGa/0qwPc
 lje6VdfdMKAT2TA9tFmL1BgtlT9f9veGrHondLCj2hYzKIbZMBdPgrw7meGrFzCW3b/b
 3rZBqggB/J5kTuaz6ydwjdz6RnN3/I3hB2dpBnEebv96lfdIzUIfSTczpVRX6WI9tsTL
 9NmUoO+QMy5/GiZIrx8euhVWRn5Ck4duSRtLlD4ns6JkL/YTLF7nORJp/tkPS2mRlVXY
 7Ong==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787677921; x=1788282721; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aLrwkN2hpeFMupH+bxDa1e3NGhRfPpCK+VUOuYRo6l4=;
 b=ZvzPECkQqnHgJmUBIIkiho69Nqg+7HV/pb1nfkaEDZEoU95VheTxMUucmx7J6C0gn7
 lBPFkSmcQEBG+3vzwShj8ry0FCLRQv7vWhN83aW7ugQOuePvnjAdavbaW449aH6GpuLZ
 DK6duT39/VFfyLBfoUrrBAEOdpEScDImlZ/Yzez4E9Ia4n3ovJTsQorbURXwR7gbWM84
 FrjAlCcdS5sBJnHTSAjgGJp0grLlQcAGBgKP8v4JCUbnUbUri62YgBsme8QB0b1+RLTP
 UEbFUp9rTbIWCgZIeNUNbxzqX5HLXk49mpVMC3CUnIrnimi5bu5qmlTic32mKe4oJpwn
 dfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787677921; x=1788282721;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aLrwkN2hpeFMupH+bxDa1e3NGhRfPpCK+VUOuYRo6l4=;
 b=n4vlJ3iiZC56woTOJPUtkUYaKdaIbXU4+WFQ/GrL6q2oVhjqoceabs0ejqpKvDtKfG
 1Vn6piR7gABhrl/RYoOcxc0Ssi+EJFdnsytHq1Lh0K/pzSvXpZNUuHdQM45GmmDr20tj
 nbbfnYZnc0/XpbkoWbhiz4eRRJR4h+Lyqw8xp7MZy0dxJG7K5q/9i0Shnw8nwpc27eZJ
 xbakzDnEzS+P+FeRJKzJbXMwgPYhwdFu7M7YG3mW71CedqzHqiwxDoWbG427SiMETgmD
 vMtQbxnrHO2vMiWHLscw04XMEfZjQbUAXjwVHWIgeMt//7IXkanR7CiM7gy0G/iP9L9C
 K23w==
X-Gm-Message-State: AFuF++kmC9GBCc0JNst4uvowCYXvUR+tkCJXjt5R1Xu1mNS2GaHd/QYw
 cw8F3I+d4QUuKM8wEcFRjFKn/q3oXg08oKQPwuTgqnCSEXbuTR7g7dtWlxQr1qUuBSxfoe7eRJi
 TbFUrR+snSxiNWYfBlxVkpEVmA/hn4EQ=
X-Gm-Gg: AR+sD12rnwyGFdep1iaRzICUxb5Eic8nuqVF9ee/KXAGKvzoP9W8umkzKl7gwqeaUtm
 APcgkyf+jzkq8cG3zsE7jr3JUek/tnaLvqaN8zZIsh0iNIr660nxZ+U2CrjZs8LA7Jx029DFZ58
 qSYVANhqPr/TeWAuakWhNEKxcAD5T0ozhY6Kx7l2vXphB7mJ5bn+zjwT80Lq/xQiE8AD5veWfFc
 sA+N+5W7bin0GSapRbXNlhOT9fkjidnuG5HBpZXpTQ9WoUtFZ/bW/gYQn4KoiHOloMEwb3wui42
 oz29aOByTJ5Tt9Z/ml7ofTGmrTZJjaXMB9z9wRQC84lV
X-Received: by 2002:a05:690c:a701:b0:81e:c736:acce with SMTP id
 00721157ae682-8574173375fmr1148707b3.32.1787677920679; Tue, 25 Aug 2026
 10:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <ao235Hm8Uovrk0ON@redhat.com>
In-Reply-To: <ao235Hm8Uovrk0ON@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 26 Aug 2026 01:11:46 +0800
X-Gm-Features: AcwNN1W7IegOOQAdYSNJRFaa-idk915Db0vwA2saIsvqm3MO8VJAnZIhPjlE8MI
Message-ID: <CAE2XoE-Y==KCjy8i9yUmivHs6J-zdVmpbCNRs66R-OsOEdhU=g@mail.gmail.com>
Subject: Re: [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>, 
 Alistair Francis <alistair.francis@wdc.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-s390x@nongnu.org, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Fabiano Rosas <farosas@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>, 
 Darren Kenny <darren.kenny@oracle.com>
Content-Type: multipart/alternative; boundary="0000000000006f5cae0659e2333c"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=luoyonggang@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000006f5cae0659e2333c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The github branch I built locally

https://github.com/lygstate/qemu/tree/s11.1-riscv-arm

On Tue, Aug 25, 2026 at 11:42=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com>
wrote:
>
> On Sun, Aug 23, 2026 at 11:07:18PM +0800, Yonggang Luo wrote:
> > This series produces one qemu-system binary that can run ARM (32 and 64=
)
> > and RISC-V (32 and 64, little- and big-endian TargetInfo). It follows
> > Pierrick Bouvier's merged series "single-binary: implement dynamic
> > filtering for machine types":
> >
> >
https://patchew.org/QEMU/20260724000948.234657-1-pierrick.bouvier@oss.qualc=
omm.com/
>
> Do you have a public git branch somewhere with this series ? I'm
> having trouble getting either this series or Pierrick's to cleanly
> apply at any point to test it.
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000006f5cae0659e2333c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The github branch I built locally=C2=A0<div><br></div><div=
><a href=3D"https://github.com/lygstate/qemu/tree/s11.1-riscv-arm">https://=
github.com/lygstate/qemu/tree/s11.1-riscv-arm</a><br><br>On Tue, Aug 25, 20=
26 at 11:42=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berran=
ge@redhat.com">berrange@redhat.com</a>&gt; wrote:<br>&gt;<br>&gt; On Sun, A=
ug 23, 2026 at 11:07:18PM +0800, Yonggang Luo wrote:<br>&gt; &gt; This seri=
es produces one qemu-system binary that can run ARM (32 and 64)<br>&gt; &gt=
; and RISC-V (32 and 64, little- and big-endian TargetInfo). It follows<br>=
&gt; &gt; Pierrick Bouvier&#39;s merged series &quot;single-binary: impleme=
nt dynamic<br>&gt; &gt; filtering for machine types&quot;:<br>&gt; &gt;<br>=
&gt; &gt; =C2=A0 <a href=3D"https://patchew.org/QEMU/20260724000948.234657-=
1-pierrick.bouvier@oss.qualcomm.com/">https://patchew.org/QEMU/202607240009=
48.234657-1-pierrick.bouvier@oss.qualcomm.com/</a><br>&gt;<br>&gt; Do you h=
ave a public git branch somewhere with this series ? I&#39;m<br>&gt; having=
 trouble getting either this series or Pierrick&#39;s to cleanly<br>&gt; ap=
ply at any point to test it.<br>&gt;<br>&gt;<br>&gt; With regards,<br>&gt; =
Daniel<br>&gt; --<br>&gt; |: <a href=3D"https://berrange.com">https://berra=
nge.com</a> =C2=A0 =C2=A0 =C2=A0 ~~ =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"h=
ttps://hachyderm.io/@berrange">https://hachyderm.io/@berrange</a> :|<br>&gt=
; |: <a href=3D"https://libvirt.org">https://libvirt.org</a> =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0~~ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"https:/=
/entangle-photo.org">https://entangle-photo.org</a> :|<br>&gt; |: <a href=
=3D"https://pixelfed.art/berrange">https://pixelfed.art/berrange</a> =C2=A0=
 ~~ =C2=A0 =C2=A0<a href=3D"https://fstop138.berrange.com">https://fstop138=
.berrange.com</a> :|<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>You=
rs<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--0000000000006f5cae0659e2333c--

