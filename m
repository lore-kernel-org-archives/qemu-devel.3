Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C8ECF9C6B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 14:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stStO-0007HF-KH; Wed, 25 Sep 2024 10:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rj2814288312@gmail.com>)
 id 1stStL-0007E3-0I; Wed, 25 Sep 2024 10:21:19 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rj2814288312@gmail.com>)
 id 1stStI-0002Rb-Nf; Wed, 25 Sep 2024 10:21:18 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-710d5d9aac1so2861478a34.3; 
 Wed, 25 Sep 2024 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727274073; x=1727878873; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BF+R0dx+V8ZnGCKdmzHNqA4mFqf5aSYDUv8g/700G+A=;
 b=VvNhPp/RrkpAB+0o64cxXk7f+uKO5ynfw012slxGxDz6HlY+ygwEvxFOtsoTDmUVEw
 3rv8nVtSYK4RfzNpiybXCzp3Wnvriue9+gFQtLyVjBTNs1fZKxdAULkIO+sV+QVkblAk
 0mUHlXS4nCfOa8lGvGTTA8BlGkEyrVdj1UCNNO5JDICBR9P77vbG2KUZJOUAVpLRB4zV
 taI2PA9jmeY1KN31vqa/5OaFWY1BDtwxSM6K8S8aAYiUeEtWd+nIegZ9HbENmcbFPCVu
 FAGiInrTiT+J0HU8TNqM7NCtpZsegzD1cSe4PSPw7JW7TrC/g6aaZy7/AXq2mWQOsNeP
 Pb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727274073; x=1727878873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BF+R0dx+V8ZnGCKdmzHNqA4mFqf5aSYDUv8g/700G+A=;
 b=mbaelJoJJXhxXfohCCBhlhktiKTo0Si6C05ZEYgaMsIw2NYHKCNmdaVeuhVEBK75bU
 lHS1pr1AgPCJhDnXgcBWs1ik6+VQK/XkgxoXjcT312UGAoi7L59CB/4APj2sWW1qfk8L
 k7rz/k2veHDYf1iOe0cxr7HHDu1EwNI7c9wRkKPROlvYQ74wMV/Ps/nW1SdaIkpn1x7b
 fxscOiuqwXfuBmIMsgqtMctiCEjzV2GpG+VwK2ys6nry3XEr2tffeDvE6VTNs2kIaw2u
 lloc6pb82MA1EpcQCB2AdEENXDXFuMH4a4ETr3sGViSA7oHYfhiUW9wn5ENXRirvQ22Y
 zi5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW7ACjmKKdLaKRJYc3RsI6lHuA0lP13yCCtAudYXohAVomB27UysNqGKi7bhK0sEXr7ajxioG3/BwNRHql@nongnu.org,
 AJvYcCVypnLEYVj/nMv15Bjw7uyuxFBSWfWrwvfSsuP4VrHZYN7NVTxwKrnXbNyt4VrEGysI8KngTHjeBzL2@nongnu.org
X-Gm-Message-State: AOJu0Yzz0SFLZG8sVOzr7oa6WFu/fnmfI0MNmginsC4wZQq8a2zY88oX
 lxTehYueEon/mnZ/z8ZfIjEWhlmlKZmx3vWpniRNzMaNz3Pi5GEBFBz4cd+dSPjwvQN3K94/M+o
 r2+KNcrVQFLP3bJ8S4zASPCNw0M4=
X-Google-Smtp-Source: AGHT+IHEj6u1+NpR7P4KSrNrXTcx+ofHwJ9PpNBhYIUuGMzSSo+iX+hkC+ipX4PVGdMG5oK6itz6S0rb6tfgq1QIetI=
X-Received: by 2002:a05:6358:7e94:b0:1bc:45bc:81fd with SMTP id
 e5c5f4694b2df-1bea860af1cmr137786655d.19.1727274072800; Wed, 25 Sep 2024
 07:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAAsTPeaOec5UcWJOApsHxzs+-ZYotHLhiPhaWBXT9bw=Z9zjkg@mail.gmail.com>
 <c4ee581b0fcff6006ba8613ebc69bd35933bc40a.camel@de.ibm.com>
In-Reply-To: <c4ee581b0fcff6006ba8613ebc69bd35933bc40a.camel@de.ibm.com>
From: jie ren <rj2814288312@gmail.com>
Date: Wed, 25 Sep 2024 22:21:00 +0800
Message-ID: <CAAsTPeZLGopejmcGHKgFciRhO-Aa2sjesryjNUTy0gq_5sEpdA@mail.gmail.com>
Subject: Re: Using ubuntu24.4 system qemu-system-aarch64 +gdb-multiarch to
 debug the kernel, setting breakpoints cannot be stopped
To: Ilya Leoshkevich <iii@de.ibm.com>
Cc: "gdb@sourceware.org" <gdb@sourceware.org>,
 "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000008a06180622f25511"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=rj2814288312@gmail.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000008a06180622f25511
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you very much. Adding kaslr successfully solved the problem.

Ilya Leoshkevich <iii@de.ibm.com> =E4=BA=8E2024=E5=B9=B49=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=BA=8C 00:34=E5=86=99=E9=81=93=EF=BC=9A

> On Mon, 2024-09-23 at 22:36 +0800, jie ren wrote:
> > Hi, I have a question for help
> >     I recently  Using ubuntu24.4 system qemu-system-aarch64 +gdb-
> > multiarch to debug the kernel, setting breakpoints cannot be stopped.
> >    system information:
> >         ubuntu version: 22.04
> >         Debug kernel version:  5.0.0
> >         qemu version:
> > =C2=B7 qemu-system-aarch64 --version
> > =C2=B7 QEMU emulator version 8.2.2 (Debian 1:8.2.2+ds-0ubuntu1.2)
> > =C2=B7 Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project
> > developers
> >
> >
> >
> > gdb version:
> > =C2=B7 gdb-multiarch --version
> > =C2=B7 GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.20240403-git
> > =C2=B7 Copyright (C) 2024 Free Software Foundation, Inc.
> > =C2=B7 License GPLv3+: GNU GPL version 3 or later
> > <http://gnu.org/licenses/gpl.html>
> > =C2=B7 This is free software: you are free to change and redistribute i=
t.
> > =C2=B7 There is NO WARRANTY, to the extent permitted by law.
> >
> > Steps to reproduce:
> >     1. Boot the system using qemu:
> > 1. qemu-system-aarch64 -machine virt -cpu cortex-a57 -machine
> > type=3Dvirt -m 1024 -smp 4 -kernel arch/arm64/boot/Image --append
> > "noinitrd root=3D/dev/vda rw console=3DttyAMA0 loglevel=3D8" -nographic=
 -
> > drive if=3Dnone,file=3Drootfs_ext4.img,id=3Dhd0 -device virtio-blk-
> > device,drive=3Dhd0 --fsdev
> > local,id=3Dkmod_dev,path=3D$PWD/kmodules,security_model=3Dnone -device
> > virtio-9p-device,fsdev=3Dkmod_dev,mount_tag=3Dkmod_mount -S -s
> >
> >
> > Use gdb-multiarch to connect and debug:
> >
> >
> > gdb-multiarch vmlinux
> > (gdb) target remote localhost:1234
> > Remote debugging using localhost:1234
> > 0x0000000040000000 in ?? ()
> > (gdb) b start_kernel
> > Breakpoint 1 at 0xffff2000126704ec: file init/main.c, line 538.
> > (gdb) c
> > Continuing.
>
> I would try using the "nokaslr" kernel option:
>
> $ qemu-system-aarch64 -kernel ./Image.custom -M virt -cpu cortex-a57 -
> append "console=3DttyAMA0 nokaslr" -s -S -nographic
>
> $ gdb-multiarch -ex 'target remote :1234' vmlinux
>
> Remote debugging using :1234
> 0x0000000040000000 in ?? ()
> (gdb) b start_kernel
> Breakpoint 1 at 0xffff8000811e0968: file init/main.c, line 905.
> (gdb) c
> Continuing.
>
> Breakpoint 1, start_kernel () at init/main.c:905
> 905             char *command_line;
>
>

--0000000000008a06180622f25511
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you very much. Adding kaslr successfully solved the =
problem.<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">Ilya Leoshkevich &lt;<a href=3D"mailto:iii@de.ibm.com">iii@de.i=
bm.com</a>&gt; =E4=BA=8E2024=E5=B9=B49=E6=9C=8824=E6=97=A5=E5=91=A8=E4=BA=
=8C 00:34=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">On Mon, 2024-09-23 at 22:36 +0800, jie ren wrote:<br>
&gt; Hi, I have a question for help<br>
&gt; =C2=A0=C2=A0=C2=A0 I recently=C2=A0 Using ubuntu24.4 system qemu-syste=
m-aarch64 +gdb-<br>
&gt; multiarch to debug the kernel, setting breakpoints cannot be stopped.<=
br>
&gt; =C2=A0=C2=A0 system information:<br>
&gt; =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ubuntu version: 22.04<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Debug kernel version:=C2=A0=
 5.0.0<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu version:=C2=A0 <br>
&gt; =C2=B7=C2=A0qemu-system-aarch64 --version<br>
&gt; =C2=B7=C2=A0QEMU emulator version 8.2.2 (Debian 1:8.2.2+ds-0ubuntu1.2)=
<br>
&gt; =C2=B7=C2=A0Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Proje=
ct<br>
&gt; developers<br>
&gt; =C2=A0<br>
&gt; <br>
&gt; =C2=A0<br>
&gt; gdb version:<br>
&gt; =C2=B7=C2=A0gdb-multiarch --version<br>
&gt; =C2=B7=C2=A0GNU gdb (Ubuntu 15.0.50.20240403-0ubuntu1) 15.0.50.2024040=
3-git<br>
&gt; =C2=B7=C2=A0Copyright (C) 2024 Free Software Foundation, Inc.<br>
&gt; =C2=B7=C2=A0License GPLv3+: GNU GPL version 3 or later<br>
&gt; &lt;<a href=3D"http://gnu.org/licenses/gpl.html" rel=3D"noreferrer" ta=
rget=3D"_blank">http://gnu.org/licenses/gpl.html</a>&gt;<br>
&gt; =C2=B7=C2=A0This is free software: you are free to change and redistri=
bute it.<br>
&gt; =C2=B7=C2=A0There is NO WARRANTY, to the extent permitted by law.<br>
&gt; <br>
&gt; Steps to reproduce:<br>
&gt; =C2=A0 =C2=A0 1. Boot the system using qemu:=C2=A0=C2=A0 <br>
&gt; 1.=C2=A0qemu-system-aarch64 -machine virt -cpu cortex-a57 -machine<br>
&gt; type=3Dvirt -m 1024 -smp 4 -kernel arch/arm64/boot/Image --append<br>
&gt; &quot;noinitrd root=3D/dev/vda rw console=3DttyAMA0 loglevel=3D8&quot;=
 -nographic -<br>
&gt; drive if=3Dnone,file=3Drootfs_ext4.img,id=3Dhd0 -device virtio-blk-<br=
>
&gt; device,drive=3Dhd0 --fsdev<br>
&gt; local,id=3Dkmod_dev,path=3D$PWD/kmodules,security_model=3Dnone -device=
<br>
&gt; virtio-9p-device,fsdev=3Dkmod_dev,mount_tag=3Dkmod_mount -S -s<br>
&gt; =C2=A0<br>
&gt; <br>
&gt; Use gdb-multiarch to connect and debug:<br>
&gt; <br>
&gt; =C2=A0<br>
&gt; gdb-multiarch vmlinux<br>
&gt; (gdb) target remote localhost:1234<br>
&gt; Remote debugging using localhost:1234<br>
&gt; 0x0000000040000000 in ?? ()<br>
&gt; (gdb) b start_kernel<br>
&gt; Breakpoint 1 at 0xffff2000126704ec: file init/main.c, line 538.<br>
&gt; (gdb) c<br>
&gt; Continuing.<br>
<br>
I would try using the &quot;nokaslr&quot; kernel option:<br>
<br>
$ qemu-system-aarch64 -kernel ./Image.custom -M virt -cpu cortex-a57 -<br>
append &quot;console=3DttyAMA0 nokaslr&quot; -s -S -nographic<br>
<br>
$ gdb-multiarch -ex &#39;target remote :1234&#39; vmlinux<br>
<br>
Remote debugging using :1234<br>
0x0000000040000000 in ?? ()<br>
(gdb) b start_kernel<br>
Breakpoint 1 at 0xffff8000811e0968: file init/main.c, line 905.<br>
(gdb) c<br>
Continuing.<br>
<br>
Breakpoint 1, start_kernel () at init/main.c:905<br>
905=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char *command_line;<br>
<br>
</blockquote></div>

--0000000000008a06180622f25511--

