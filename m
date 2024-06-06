Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649A5C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFEYs-0005Ar-FJ; Thu, 06 Jun 2024 10:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1sFEYq-0005AR-S3
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmaglion@redhat.com>)
 id 1sFEYo-0005sl-9d
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717685868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fzUt+S5hDlo86Yu90rcSQisSsmUqsfIZO8Gph++Q8I=;
 b=BGEU9Vr/QWanGyQs2z9zIrTC5hYF5eG9Pgy/6bIuVELL3EmW8HV0xbSEasCttckTFS+NsQ
 EOWE1rl/PSUNkF8Q74bfk9kKKiYLxejYpA7HhmQ1Dzr8AzusxN/s0K+kCBF5bsVEQRBICr
 ppCGgvHwGJ+ZBRyU0tg2Nk+JweWsS4o=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-J_3ynPwYMNKaRPTpSZSvkQ-1; Thu, 06 Jun 2024 10:56:40 -0400
X-MC-Unique: J_3ynPwYMNKaRPTpSZSvkQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2eab2099bbfso2498121fa.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 07:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717685799; x=1718290599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fzUt+S5hDlo86Yu90rcSQisSsmUqsfIZO8Gph++Q8I=;
 b=pQB9Q9hcxclXN/aGYK7zu3tWlCY3TucjsJksCr+7rUfCgZ9Ky4Mwem6v4emgl82O22
 BONU5a6EfLbugp8Kpjc5Qw6Hs/YP633eIg2hKXoMGJ70y7afs2aLpG5K9AxObWUVmWPV
 zN3/eEGpH2HpBj/LQm0aTtmw0dFvodfDmStNGEGHdNqVHXH+6vv1a15HKZzpjbqKfOY6
 XCRODP7IkgYp7x5NYft4mNxluqIhyb51nkmR6cI9gEYI3+2b6mq4MrADqSADPM1R5wrF
 b6LXL5tWSdU09ZP15Tr1iOf2N1WSEFJSeRPChmtmuKwMjNG7IFXeE7/IvSMUJ7U8zSPk
 YVBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP/iw40eHzfiW2w/b6SqxyLAfGYhXyVvWhaQcxx5qgH36wm9jxFg6LC/vLCBgzDvfBpsGW2Ce7DvqAHL7cJxv6kHKFXFw=
X-Gm-Message-State: AOJu0YyhAN9tZU9l66vyUad8MJrkP+K2SawHi3Qmds2s1kDGaTENqeGL
 GFfZFgUrLNAFwfMBnTzKcfQXgkEoENzgQv01489RvwutRYEK2qVKUlV5Ycrh0A1mjlMhxCVW4Xw
 +RqNHHYMgWzDX7F14ZFmK7S7GZtZ6HaobeOs65VoGNJ+luP03acJTHML84CKwdQ2+y/myBVFUdb
 G0M4cW0VwVMqW+OCnoAZF2sydqfFY=
X-Received: by 2002:a05:6512:6d1:b0:528:21dc:5364 with SMTP id
 2adb3069b0e04-52bab4ca10amr373699e87.1.1717685798809; 
 Thu, 06 Jun 2024 07:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOm2YLwZIoufD5PEQ7Xe5V5www38khB6TuAE/tOUZ/LEKwaiISIhDa6f7CU28eeWx4BqOXWoS67PXzorIlFJc=
X-Received: by 2002:a05:6512:6d1:b0:528:21dc:5364 with SMTP id
 2adb3069b0e04-52bab4ca10amr373674e87.1.1717685798370; Thu, 06 Jun 2024
 07:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAOssrKeJbfjhZ1rkL=Tj+zQaYxQLQmwLYYT22Cu8nYnY8nriYA@mail.gmail.com>
In-Reply-To: <CAOssrKeJbfjhZ1rkL=Tj+zQaYxQLQmwLYYT22Cu8nYnY8nriYA@mail.gmail.com>
From: German Maglione <gmaglione@redhat.com>
Date: Thu, 6 Jun 2024 16:56:01 +0200
Message-ID: <CAJh=p+6cieh6XUzuf_be4zu+t01WETdLbP-9p2gonVyTRWx22Q@mail.gmail.com>
Subject: Re: kvm crash with virtiofs
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: virtio-fs@lists.linux.dev, QEMU Developers <qemu-devel@nongnu.org>, 
 Eric Sandeen <sandeen@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gmaglion@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 6, 2024 at 10:40=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Hi,
>
> I get the below crash when running virtio-fs on fedora 39.
>
> Note: weirdly this makes chrome running on the host also crash.
>
> Eric Sandeen also reported some bad behavior of virtio-fs on fc39,
> which might be related.
>
> Versions:
> kernel-6.8.4-200.fc39.x86_64
> qemu-kvm-8.1.3-5.fc39.x86_64
> virtiofsd-1.10.1-1.fc39.x86_64
>
> Thanks,
> Miklos
>
> /usr/libexec/virtiofsd --socket-path=3D/tmp/vhostqemu --shared-dir /home =
&
>
> qemu-system-x86_64 -enable-kvm -s -serial none -parallel none -kernel
> /home/mszeredi/git/linux/arch/x86_64/boot/bzImage -drive
> format=3Draw,file=3D/home/mszeredi/root_fs,index=3D0,if=3Dvirtio -drive
> format=3Draw,file=3D/home/mszeredi/images/ubd1,index=3D1,if=3Dvirtio -cha=
rdev
> stdio,id=3Dvirtiocon0,signal=3Doff -device virtio-serial -device
> virtconsole,chardev=3Dvirtiocon0 -cpu host -m 16G -smp 8 -object
> memory-backend-file,id=3Dmem,size=3D16G,mem-path=3D/dev/shm,share=3Don -n=
uma
> node,memdev=3Dmem -net user -net nic,model=3Dvirtio-net-pci -fsdev
> local,security_model=3Dnone,id=3Dfsdev0,path=3D/home -device virtio-rng-p=
ci
> -chardev socket,id=3Dchar0,path=3D/tmp/vhostqemu -device
> vhost-user-fs-pci,queue-size=3D1024,chardev=3Dchar0,tag=3Dmyfs -device
> virtio-9p-pci,fsdev=3Dfsdev0,mount_tag=3Dhostshare -append "root=3D/dev/v=
da
> console=3Dhvc0 "

are you running virtiofsd inside a container?, could you try

-object memory-backend-memfd,id=3Dmem,size=3D16G,share=3Don

instead of "-object memory-backend-file..."

> [...]
> root@kvm:~# time md5sum /host/mszeredi/images/ubd1
> error: kvm run failed Bad address
> RAX=3D0000000000000000 RBX=3Dffff888100044240 RCX=3D0000000000000000
> RDX=3Dffff888420c59ff0
> RSI=3D0000000000000020 RDI=3Dffff888420c59ff8 RBP=3D0000000000000000
> RSP=3Dffffc900016d3898
> R8 =3Dffff888420c59da8 R9 =3D0000000000000040 R10=3D0000000000036140
> R11=3D0000000000000005
> R12=3Dffff888420c59ff0 R13=3D000000000000000d R14=3Dffffea0010831600
> R15=3Dffff888420c59da8
> RIP=3Dffffffff82168d80 RFL=3D00010046 [---Z-P-] CPL=3D0 II=3D0 A20=3D1 SM=
M=3D0 HLT=3D0
> ES =3D0000 0000000000000000 ffffffff 00c00000
> CS =3D0010 0000000000000000 ffffffff 00a09b00 DPL=3D0 CS64 [-RA]
> SS =3D0018 0000000000000000 ffffffff 00c09300 DPL=3D0 DS   [-WA]
> DS =3D0000 0000000000000000 ffffffff 00c00000
> FS =3D0000 00007fb83cea8740 ffffffff 00c00000
> GS =3D0000 ffff88842fd40000 ffffffff 00c00000
> LDT=3D0000 0000000000000000 ffffffff 00c00000
> TR =3D0040 fffffe000012a000 00004087 00008b00 DPL=3D0 TSS64-busy
> GDT=3D     fffffe0000128000 0000007f
> IDT=3D     fffffe0000000000 00000fff
> CR0=3D80050033 CR2=3D00007f2d3bd9b0f0 CR3=3D00000001036ee005 CR4=3D00770e=
f0
> DR0=3D0000000000000000 DR1=3D0000000000000000 DR2=3D0000000000000000
> DR3=3D0000000000000000
> DR6=3D00000000ffff0ff0 DR7=3D0000000000000400
> EFER=3D0000000000000d01
> Code=3D90 90 90 90 48 c7 07 00 00 00 00 48 89 fa 48 8d 7f 08 31 c0 <48>
> c7 87 30 02 00 00 00 00 00 00 48 89 d1 48 83 e7 f8 48 29 f9 81 c1 40
> 02 00 00 c1 e9 03
>
>


--=20
German


