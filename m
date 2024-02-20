Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1625DC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 20:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcX9f-0007HK-G2; Tue, 20 Feb 2024 15:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rcX9d-0007H5-MR
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:55:53 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faiqueali.109@gmail.com>)
 id 1rcX9b-00060n-Gs
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:55:53 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so9938992a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 12:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708462549; x=1709067349; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8RcxmYkH/690RycPhKMqwIPFzJAzn5wfWpLyv3zhFvs=;
 b=k0fT90d1T0TYsHRcpkr+doxkGxnzTFIbopCwFEQHC9H0qFCE8UygioXmqls+Jsb+wN
 QZ3+9wp0DMfXFI8oaV3Z+Ar/FNO6LJxWF4HkhCs01E7+24BpicdNZO2btfTHVpoDl5Qj
 RKee8kpuqklNHRtR7Wm/bqoWn4QnDmH2zzPiZDRfvJxAW2rd8QkQzrVjzN56PIi4QRDE
 FqWvsqoayOtbjqGYuOQkbrUwP18Tcynr+Y/nAUN6318vKp+7NJe+4FGK8nT06jHBtrfW
 DdJXKzMIIbDdpFZSF26WBWMP/SQ9PUVR2Qm6zYhA4K+ZCdVRhqj/OMf4nZmWtyo6P6pW
 Kl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708462549; x=1709067349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8RcxmYkH/690RycPhKMqwIPFzJAzn5wfWpLyv3zhFvs=;
 b=OhCjWqOPqlzTBVoyKp2w5y3j0wJG3kVt+jSnUpvQmEGjCQrJN+36g71Y2PJymqxCAb
 /Na4LCqahhhKgbZWS4tmuNTyJdO90E9x+6A7NxeJF/d0KSaVqh0OuHkkvbHwpZPYeWpT
 3kBBFKJ9m81nStkQI5gAi/N83PYY4uJx5NBWVmo2FMuOIfsJ89lhSN+ie9eexHZElhXC
 GSD34z9pLhNBCn+jJ3vbPMRuNqtkz8PHJ/333Yd8Pkg9XdtV6cqHmcTaO/vlerecODPz
 63X0NLwY4rCMb/pRarOOeKWqvzfj0AqzqVboBrkxDCNjslIKq/VJdCKAL4FVXvMRA9xc
 eIJA==
X-Gm-Message-State: AOJu0Ywh+Gk+7b2hksCp+73WGMDg68nDXlBts95/ljrOC5Tpwl6fqzJQ
 jIaKeCt20/CdHpnCBpFSD+bucnnS2x51Ntt+WOBuAbWjgWal7ntEWBNHc9bajQjmXseLx3CoDSR
 XvBsMWapDTweNoKzDePenw1P2wFsNquEf
X-Google-Smtp-Source: AGHT+IG/w1swZcoXO+5n2nKCad9QX/Xx0WE1kGLZya+VkHDqS41DqBd3ZJQptmiG2s88z4ngz7mG7BBNSaX/iz5b+4c=
X-Received: by 2002:aa7:d44c:0:b0:55f:4bd7:6a6f with SMTP id
 q12-20020aa7d44c000000b0055f4bd76a6fmr10398429edr.29.1708462549188; Tue, 20
 Feb 2024 12:55:49 -0800 (PST)
MIME-Version: 1.0
References: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
 <87a5nvci5n.fsf@draig.linaro.org>
 <CAOpGCnLxVGhbJuAq+K+DNZBESEGGkSr8Sa0_cHsfMR7S-_ahkQ@mail.gmail.com>
 <87y1bfawik.fsf@draig.linaro.org>
In-Reply-To: <87y1bfawik.fsf@draig.linaro.org>
From: Faiq Ali Sayed <faiqueali.109@gmail.com>
Date: Tue, 20 Feb 2024 21:55:37 +0100
Message-ID: <CAOpGCn+_=5Uxi9mt-C1V3pguNT0OUJura-H3SwBOsJnW5tyJ4g@mail.gmail.com>
Subject: Re: QNX VM hang on Qemu
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000005b456a0611d66feb"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=faiqueali.109@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000005b456a0611d66feb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The image I am using is currently in use for real hardware, and I
received it from a third party/vendor.
Could you please suggest to me what I can do now?


br!
Faiq


On Tue, Feb 20, 2024 at 6:14=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Faiq Ali Sayed <faiqueali.109@gmail.com> writes:
>
> > Alex thanks for the reply,
> >
> > I don't know what the debug symbol is, but my target system is QNX
> aarch64
> > below are the configuration of GDB,
> >
> > (gdb) show configuration
> > This GDB was configured as follows:
> >    configure --host=3Dx86_64-pc-linux-gnu
> --target=3Daarch64-unknown-nto-qnx7.1.0
> >              --with-auto-load-dir=3D$debugdir:$datadir/auto-load
> >              --with-auto-load-safe-path=3D$debugdir:$datadir/auto-load
> >              --without-expat
> >
> --with-gdb-datadir=3D/opt/qnx710/host/linux/x86_64/usr/share/gdb (relocat=
able)
> >
> --with-jit-reader-dir=3D/opt/qnx710/host/linux/x86_64/usr/lib/gdb
> (relocatable)
> >              --without-libunwind-ia64
> >              --without-lzma
> >              --without-babeltrace
> >              --without-intel-pt
> >              --disable-libmcheck
> >              --without-mpfr
> >              --with-python=3D/opt/qnx710/host/linux/x86_64/usr
> (relocatable)
> >              --without-guile
> >
> --with-separate-debug-dir=3D/opt/qnx710/host/linux/x86_64/usr/lib/debug
> (relocatable)
> >              --with-sysroot=3D/opt/qnx710/target/qnx7/aarch64
> >
> > while I got the below result, after executing the x/10i $pc
> >
> > (gdb) x/10i $pc
> > =3D> 0x100000: .inst 0x5371242b ; undefined
> >    0x100004: fcmla v21.8h, v3.8h, v16.h[1], #270
> >    0x100008: .inst 0x64657472 ; undefined
> >    0x10000c: ldnp d26, d27, [x9, #-176]
> >    0x100010: .inst 0x72706974 ; undefined
> >    0x100014: .inst 0x7365636f ; undefined
> >    0x100018: .inst 0x733b2b73 ; undefined
> >    0x10001c: fnmls z23.h, p0/m, z19.h, z18.h
> >    0x100020: .inst 0x3b2b6b61 ; undefined
> >    0x100024: .inst 0x72627768 ; undefined
> >
> > Can you please let me know how I can step in ?
>
> step-instruction in gdb, however...
>
> It very much looks like the image you have built doesn't have any
> instructions in the correct starting place. It's unsurprising that it
> hangs running random undefined instructions.
>
> > When I press c it does not execute further and hangs..
> >
> > Faiq
> >
> > On Tue, Feb 20, 2024 at 3:41=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org>
> wrote:
> >
> >  Faiq Ali Sayed <faiqueali.109@gmail.com> writes:
> >
> >  > Hi everyone,
> >  > I am facing an issue during booting QNX VM using Qemu,
> >  > I have an image to Boot the VM. and when I trigger a Qemu command to
> create a VM it is stuck.
> >  > I also used a debugger to investigate but I can not see any result b=
y
> GDB.
> >  >
> >  > Here is the output of first windows
> >  >
> >  > qemu-system-aarch64 -M xlnx-zcu102 -m 16G -serial mon:stdio -display
> none -device
> >  > loader,file=3DQNX-IFS,addr=3D0x00100000,cpu-num=3D0 -drive
> >  >
> file=3D/home/faiq/Downloads/install/BootSD/qemu-boot_sd.img,if=3Dsd,forma=
t=3Draw,index=3D1
> -boot mode=3D5 -net
> >  > nic,model=3Dcadence_gem -net nic,model=3Dcadence_gem -net
> nic,model=3Dcadence_gem -net
> >  > nic,model=3Dcadence_gem,netdev=3Dxzynq0 -netdev
> user,id=3Dxzynq0,tftp=3D/tftpboot  -nographic -global
> >  > xlnx,zynqmp-boot.cpu-num=3D0 -global 'xlnx,zynqmp-boot.use-pmufw=3Dt=
rue'
> -s -S
> >  >
> >  > qemu-system-aarch64: warning: hub 0 is not connected to host network
> >
> >  Is this QNX VM image built for the xlnx-zcu102 board?
> >
> >  > on the other hand, here is the output of GDB:
> >  >
> >  > (gdb) target remote :1234
> >  > Remote debugging using :1234
> >  > warning: No executable has been specified and target does not suppor=
t
> >  > determining executable automatically.  Try using the "file" command.
> >  > 0x0000000000100000 in ?? ()
> >  > (gdb) c
> >  > Continuing.
> >
> >  You'll either want the debug symbols for your image or tell GDB what t=
he
> >  target arch is. Check you are somewhere sane by doing:
> >
> >    x/10i $pc
> >
> >  and step through the instructions and see where it goes. If you hit
> >  Ctrl-C are you executing nonsense instructions or in a tight loop
> >  hanging?
> >
> >  --
> >  Alex Benn=C3=A9e
> >  Virtualisation Tech Lead @ Linaro
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>


--=20
Kind Regard-
Faiq Ali Sayed

--0000000000005b456a0611d66feb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The image I am using is currently=C2=A0in use for real har=
dware, and I received=C2=A0it from a third party/vendor.=C2=A0<div>Could yo=
u please suggest to me what I can do now?</div><div><br></div><div><br></di=
v><div>br!</div><div>Faiq</div><div><br></div></div><br><div class=3D"gmail=
_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Feb 20, 2024 at 6:14=
=E2=80=AFPM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">=
alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">Faiq Ali Sayed &lt;<a href=3D"mailto:faiqueali.109@gm=
ail.com" target=3D"_blank">faiqueali.109@gmail.com</a>&gt; writes:<br>
<br>
&gt; Alex thanks for the reply,<br>
&gt;<br>
&gt; I don&#39;t know what the debug symbol is, but my target system is QNX=
 aarch64 <br>
&gt; below are the configuration of GDB,<br>
&gt;<br>
&gt; (gdb) show configuration<br>
&gt; This GDB was configured as follows:<br>
&gt;=C2=A0 =C2=A0 configure --host=3Dx86_64-pc-linux-gnu --target=3Daarch64=
-unknown-nto-qnx7.1.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --with-auto-load-dir=
=3D$debugdir:$datadir/auto-load<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --with-auto-load-safe-=
path=3D$debugdir:$datadir/auto-load<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --without-expat<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --with-gdb-datadir=3D/=
opt/qnx710/host/linux/x86_64/usr/share/gdb (relocatable)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --with-jit-reader-dir=
=3D/opt/qnx710/host/linux/x86_64/usr/lib/gdb (relocatable)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --without-libunwind-ia=
64<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --without-lzma<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --without-babeltrace<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --without-intel-pt<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --disable-libmcheck<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --without-mpfr<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --with-python=3D/opt/q=
nx710/host/linux/x86_64/usr (relocatable)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --without-guile<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --with-separate-debug-=
dir=3D/opt/qnx710/host/linux/x86_64/usr/lib/debug (relocatable)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --with-sysroot=3D/opt/=
qnx710/target/qnx7/aarch64<br>
&gt;<br>
&gt; while I got the below result, after executing the x/10i $pc <br>
&gt;<br>
&gt; (gdb) x/10i $pc<br>
&gt; =3D&gt; 0x100000: .inst 0x5371242b ; undefined<br>
&gt;=C2=A0 =C2=A0 0x100004: fcmla v21.8h, v3.8h, v16.h[1], #270<br>
&gt;=C2=A0 =C2=A0 0x100008: .inst 0x64657472 ; undefined<br>
&gt;=C2=A0 =C2=A0 0x10000c: ldnp d26, d27, [x9, #-176]<br>
&gt;=C2=A0 =C2=A0 0x100010: .inst 0x72706974 ; undefined<br>
&gt;=C2=A0 =C2=A0 0x100014: .inst 0x7365636f ; undefined<br>
&gt;=C2=A0 =C2=A0 0x100018: .inst 0x733b2b73 ; undefined<br>
&gt;=C2=A0 =C2=A0 0x10001c: fnmls z23.h, p0/m, z19.h, z18.h<br>
&gt;=C2=A0 =C2=A0 0x100020: .inst 0x3b2b6b61 ; undefined<br>
&gt;=C2=A0 =C2=A0 0x100024: .inst 0x72627768 ; undefined<br>
&gt;<br>
&gt; Can you please let me know how I can step in ?<br>
<br>
step-instruction in gdb, however...<br>
<br>
It very much looks like the image you have built doesn&#39;t have any<br>
instructions in the correct starting place. It&#39;s unsurprising that it<b=
r>
hangs running random undefined instructions. <br>
<br>
&gt; When I press c it does not execute further and hangs..<br>
&gt;<br>
&gt; Faiq<br>
&gt;<br>
&gt; On Tue, Feb 20, 2024 at 3:41=E2=80=AFPM Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org=
</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Faiq Ali Sayed &lt;<a href=3D"mailto:faiqueali.109@gmail.com" ta=
rget=3D"_blank">faiqueali.109@gmail.com</a>&gt; writes:<br>
&gt;<br>
&gt;=C2=A0 &gt; Hi everyone, <br>
&gt;=C2=A0 &gt; I am facing an issue during booting QNX VM using Qemu,<br>
&gt;=C2=A0 &gt; I have an image to Boot the VM. and when I trigger a Qemu c=
ommand to create a VM it is stuck.<br>
&gt;=C2=A0 &gt; I also used a debugger to investigate but I can not see any=
 result by GDB.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; Here is the output of first windows<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; qemu-system-aarch64 -M xlnx-zcu102 -m 16G -serial mon:stdio=
 -display none -device<br>
&gt;=C2=A0 &gt; loader,file=3DQNX-IFS,addr=3D0x00100000,cpu-num=3D0 -drive<=
br>
&gt;=C2=A0 &gt; file=3D/home/faiq/Downloads/install/BootSD/qemu-boot_sd.img=
,if=3Dsd,format=3Draw,index=3D1 -boot mode=3D5 -net<br>
&gt;=C2=A0 &gt; nic,model=3Dcadence_gem -net nic,model=3Dcadence_gem -net n=
ic,model=3Dcadence_gem -net<br>
&gt;=C2=A0 &gt; nic,model=3Dcadence_gem,netdev=3Dxzynq0 -netdev user,id=3Dx=
zynq0,tftp=3D/tftpboot=C2=A0 -nographic -global<br>
&gt;=C2=A0 &gt; xlnx,zynqmp-boot.cpu-num=3D0 -global &#39;xlnx,zynqmp-boot.=
use-pmufw=3Dtrue&#39; -s -S<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; qemu-system-aarch64: warning: hub 0 is not connected to hos=
t network<br>
&gt;<br>
&gt;=C2=A0 Is this QNX VM image built for the xlnx-zcu102 board?<br>
&gt;<br>
&gt;=C2=A0 &gt; on the other hand, here is the output of GDB:<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; (gdb) target remote :1234<br>
&gt;=C2=A0 &gt; Remote debugging using :1234<br>
&gt;=C2=A0 &gt; warning: No executable has been specified and target does n=
ot support<br>
&gt;=C2=A0 &gt; determining executable automatically.=C2=A0 Try using the &=
quot;file&quot; command.<br>
&gt;=C2=A0 &gt; 0x0000000000100000 in ?? ()<br>
&gt;=C2=A0 &gt; (gdb) c<br>
&gt;=C2=A0 &gt; Continuing.<br>
&gt;<br>
&gt;=C2=A0 You&#39;ll either want the debug symbols for your image or tell =
GDB what the<br>
&gt;=C2=A0 target arch is. Check you are somewhere sane by doing:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 x/10i $pc<br>
&gt;<br>
&gt;=C2=A0 and step through the instructions and see where it goes. If you =
hit<br>
&gt;=C2=A0 Ctrl-C are you executing nonsense instructions or in a tight loo=
p<br>
&gt;=C2=A0 hanging?<br>
&gt;<br>
&gt;=C2=A0 -- <br>
&gt;=C2=A0 Alex Benn=C3=A9e<br>
&gt;=C2=A0 Virtualisation Tech Lead @ Linaro<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div dir=3D"ltr">
<div><span style=3D"color:rgb(34,34,34)">Kind Regard-</span><br style=3D"co=
lor:rgb(34,34,34)"><div dir=3D"ltr" style=3D"color:rgb(34,34,34)"><div dir=
=3D"ltr"><div dir=3D"ltr"><font color=3D"#073763">Faiq Ali Sayed</font></di=
v></div></div></div>
<div><font style=3D"background-color:rgb(255,255,255)" size=3D"1"><br></fon=
t></div><br></div></div></div>

--0000000000005b456a0611d66feb--

