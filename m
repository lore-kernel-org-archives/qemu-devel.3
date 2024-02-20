Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92404C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 17:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcThD-0007XB-Dq; Tue, 20 Feb 2024 12:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcThB-0007Wx-3Z
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:14:17 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcTh8-0008SE-Bx
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 12:14:16 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33d754746c3so2631f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 09:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708449252; x=1709054052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rIotRBMJDdojLGe7c7DobXwW4fudM83dTH19dMIhKkE=;
 b=c9e2GQlqMZKWWFKYEYB8sqLtVLsoUpwWU/YBiEFnBV+oWBlHTMT4FCu6bfuOxr7hqG
 VXFOach+9TVeXQ/5v5jHM0JDEj6V/z1b5V+Ti+wr2D6EsLYMvXuXbkya3aj6offc017b
 4I/n/cvUWrIhc4X46O2B06bkLIX0pmTGyHljD87SSY9peLBo8jJAsLOHmtc5WkrPWTK7
 LdFaWCaiWBmp7AVOtSMsECpo/QUCShBcPZSk1+CeM+fRX1UFvC0dUyCp0C3BZlJKUCxb
 +o7z0TuyacSzAiiQBb8Chnf4plwzjomi8eDQ4pRxY9OqLqsxMxDdSA3wHKNikLE5yyRT
 qJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708449252; x=1709054052;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rIotRBMJDdojLGe7c7DobXwW4fudM83dTH19dMIhKkE=;
 b=fpnWFcuIflmhx4DRxUQSXHS8EiiW6AmSMZEW/TAGXJT9XqRe6fOdSdMk0uSJG2W2d6
 /2wGHQ/Yto2ZdBH3f5WjgcGvGd1nJt28674vNUvWdVMFFao+Sj276KGXHtezSnzm1CM1
 a2EbiNw6Yj6fjcD0VjF/0b8/JMntMkyXLFOBDey9iZtyH1E23X05z8xsR8GeuArVNLaU
 d+bvMu/vNU1NCsZChBeufzTx3GU+gX8n67E2JnXqMmrG/AcAWCDTWfYVqjMK+At0dSe+
 A3NRgBqqXPrbgu1IFlPBL2XLNYEUtHnUO4mXGpdydu+o5lU4g8zqdL6TINrNCly0hWOo
 oekQ==
X-Gm-Message-State: AOJu0YwOyWryOHzcRWcx0eJG1NFFW6t8p/aDO+T3MefOVUjT50VC50jh
 /JphJIjnAfyCV2cbLVtIntPIdZLOzCxXVlOmq3FswxewsrbIvu4l/wLijPdqBf3v6+HvbsMTILU
 g
X-Google-Smtp-Source: AGHT+IG0IeXWMxapq/RBENfXqIxTR5aTCMq8IPDpO6qrllIGBNjmfeuzcu0h60gtfEQVE9ko57X1rw==
X-Received: by 2002:adf:ea02:0:b0:33d:74f2:820e with SMTP id
 q2-20020adfea02000000b0033d74f2820emr101145wrm.30.1708449252368; 
 Tue, 20 Feb 2024 09:14:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ck4-20020a5d5e84000000b0033d3f0eee9dsm8814006wrb.27.2024.02.20.09.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 09:14:12 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B7E305F85F;
 Tue, 20 Feb 2024 17:14:11 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Faiq Ali Sayed <faiqueali.109@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: QNX VM hang on Qemu
In-Reply-To: <CAOpGCnLxVGhbJuAq+K+DNZBESEGGkSr8Sa0_cHsfMR7S-_ahkQ@mail.gmail.com>
 (Faiq Ali Sayed's message of "Tue, 20 Feb 2024 17:33:25 +0100")
References: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
 <87a5nvci5n.fsf@draig.linaro.org>
 <CAOpGCnLxVGhbJuAq+K+DNZBESEGGkSr8Sa0_cHsfMR7S-_ahkQ@mail.gmail.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Tue, 20 Feb 2024 17:14:11 +0000
Message-ID: <87y1bfawik.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Faiq Ali Sayed <faiqueali.109@gmail.com> writes:

> Alex thanks for the reply,
>
> I don't know what the debug symbol is, but my target system is QNX aarch6=
4=20
> below are the configuration of GDB,
>
> (gdb) show configuration
> This GDB was configured as follows:
>    configure --host=3Dx86_64-pc-linux-gnu --target=3Daarch64-unknown-nto-=
qnx7.1.0
>              --with-auto-load-dir=3D$debugdir:$datadir/auto-load
>              --with-auto-load-safe-path=3D$debugdir:$datadir/auto-load
>              --without-expat
>              --with-gdb-datadir=3D/opt/qnx710/host/linux/x86_64/usr/share=
/gdb (relocatable)
>              --with-jit-reader-dir=3D/opt/qnx710/host/linux/x86_64/usr/li=
b/gdb (relocatable)
>              --without-libunwind-ia64
>              --without-lzma
>              --without-babeltrace
>              --without-intel-pt
>              --disable-libmcheck
>              --without-mpfr
>              --with-python=3D/opt/qnx710/host/linux/x86_64/usr (relocatab=
le)
>              --without-guile
>              --with-separate-debug-dir=3D/opt/qnx710/host/linux/x86_64/us=
r/lib/debug (relocatable)
>              --with-sysroot=3D/opt/qnx710/target/qnx7/aarch64
>
> while I got the below result, after executing the x/10i $pc=20
>
> (gdb) x/10i $pc
> =3D> 0x100000: .inst 0x5371242b ; undefined
>    0x100004: fcmla v21.8h, v3.8h, v16.h[1], #270
>    0x100008: .inst 0x64657472 ; undefined
>    0x10000c: ldnp d26, d27, [x9, #-176]
>    0x100010: .inst 0x72706974 ; undefined
>    0x100014: .inst 0x7365636f ; undefined
>    0x100018: .inst 0x733b2b73 ; undefined
>    0x10001c: fnmls z23.h, p0/m, z19.h, z18.h
>    0x100020: .inst 0x3b2b6b61 ; undefined
>    0x100024: .inst 0x72627768 ; undefined
>
> Can you please let me know how I can step in ?

step-instruction in gdb, however...

It very much looks like the image you have built doesn't have any
instructions in the correct starting place. It's unsurprising that it
hangs running random undefined instructions.=20

> When I press c it does not execute further and hangs..
>
> Faiq
>
> On Tue, Feb 20, 2024 at 3:41=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>
>  Faiq Ali Sayed <faiqueali.109@gmail.com> writes:
>
>  > Hi everyone,=20
>  > I am facing an issue during booting QNX VM using Qemu,
>  > I have an image to Boot the VM. and when I trigger a Qemu command to c=
reate a VM it is stuck.
>  > I also used a debugger to investigate but I can not see any result by =
GDB.
>  >
>  > Here is the output of first windows
>  >
>  > qemu-system-aarch64 -M xlnx-zcu102 -m 16G -serial mon:stdio -display n=
one -device
>  > loader,file=3DQNX-IFS,addr=3D0x00100000,cpu-num=3D0 -drive
>  > file=3D/home/faiq/Downloads/install/BootSD/qemu-boot_sd.img,if=3Dsd,fo=
rmat=3Draw,index=3D1 -boot mode=3D5 -net
>  > nic,model=3Dcadence_gem -net nic,model=3Dcadence_gem -net nic,model=3D=
cadence_gem -net
>  > nic,model=3Dcadence_gem,netdev=3Dxzynq0 -netdev user,id=3Dxzynq0,tftp=
=3D/tftpboot  -nographic -global
>  > xlnx,zynqmp-boot.cpu-num=3D0 -global 'xlnx,zynqmp-boot.use-pmufw=3Dtru=
e' -s -S
>  >
>  > qemu-system-aarch64: warning: hub 0 is not connected to host network
>
>  Is this QNX VM image built for the xlnx-zcu102 board?
>
>  > on the other hand, here is the output of GDB:
>  >
>  > (gdb) target remote :1234
>  > Remote debugging using :1234
>  > warning: No executable has been specified and target does not support
>  > determining executable automatically.  Try using the "file" command.
>  > 0x0000000000100000 in ?? ()
>  > (gdb) c
>  > Continuing.
>
>  You'll either want the debug symbols for your image or tell GDB what the
>  target arch is. Check you are somewhere sane by doing:
>
>    x/10i $pc
>
>  and step through the instructions and see where it goes. If you hit
>  Ctrl-C are you executing nonsense instructions or in a tight loop
>  hanging?
>
>  --=20
>  Alex Benn=C3=A9e
>  Virtualisation Tech Lead @ Linaro

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

