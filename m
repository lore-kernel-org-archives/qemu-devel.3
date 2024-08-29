Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C019C83F2D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 15:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjhSY-0002GV-Jo; Thu, 29 Aug 2024 11:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjhSX-0002FQ-Et
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 11:53:17 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjhSV-0002d0-HU
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 11:53:17 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c07eebf29eso395683a12.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724946793; x=1725551593; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=McawBfqRY/ikDHmMAVLzXkGHHa+mdW6v+TRFQwiw2w4=;
 b=I+mOcSwlvhd0dYULPplX+3XNgIEnsNspLOA8ylosk5ksqDXGKcbIE0cVXWgIQo2OhE
 8BIE/2AGRJCyOZ+GuPR4hV/eOEvUe1/FrWjeylBI/iy8m/VRmWgdtylioRW5+TDFr9EI
 Ek1lWiDnLovXZFJsx4mTlZ6Lege4ooYD2IjYWbmBPRYFOqwdQha68NC0sY3EHIEhM49K
 pxQx/zpAos7YP5y0a2TssnR1fu+G+hyUl0YjZwaA7kviujuWTn1HZfIBWOwl9psqIvAh
 J1q12vWcWxeZEgQCeL8m8jPUDLMwe0J1Yplr1Yc9XLnAndz2ZMuIRlrHQpAvRTmaOmlb
 bMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724946793; x=1725551593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=McawBfqRY/ikDHmMAVLzXkGHHa+mdW6v+TRFQwiw2w4=;
 b=jSdNAMQ7IqJtNAAP6gNfvY6F4KSNXqzWcO1MA5geEqlYjfyIj0kfDKPPkL2bIT+K5o
 NmHk92//642Ji8i9qQSCwbsfjH1a6Ir1vhm1O5gDD9eb5zhY+rHuvtyzQq8fMVy1vI9U
 tMoSMc+Wg/80Q9bL7W7e4X1DdQJtIMzUIyjIwepDwL16N0LBEQjGQVJFYIJ5t4u+/oRU
 Xa9uRmQb4Ltvy7aesZibDT8r3ILgKSiGyhAVm5vSQ5eKlEZoQAmovjfEaZtk8Qvnj1Df
 7jFfOxmLW9Z7S501kEWfPqDOOeeubI6vEGqF8amUHeSVLGvSgt7pvyAjt0/j1VdwmgOP
 wzuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNSLbYdqiT45LbqOY0/qU8uUhYlpjyCxUXs9cPPqPDy9j1J+LYer7EK22iV49hNlkrCXynGJmaGLrA@nongnu.org
X-Gm-Message-State: AOJu0Yz9T7dKGVX6UVpMqOs+faguUL/4U3X9Q8zQlDIBbUqaDpZUsTP0
 pFNE09SQm1AkbrG5a7yEI2dJPkBvhOBwiC5RPYMj5z40A8hLikKfXuj3dKg4UbL9+WYBT5i6YLc
 1J5wmfc4GXafx6Vwbs1VP2rm+Sj2+/blwacbgFg==
X-Google-Smtp-Source: AGHT+IELWfEmDqstFZYAgfBK7egFvQR/iynp0xEehtWhA4pZOtqyX8HQQ2hUDsmagwIkfnpPj9kSavV+/27WG/kUyyM=
X-Received: by 2002:a05:6402:40ce:b0:58b:1a5e:c0e7 with SMTP id
 4fb4d7f45d1cf-5c21eda0d11mr4408482a12.35.1724946793246; Thu, 29 Aug 2024
 08:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
 <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
 <8050216dbbdd0762347d8e14f17d030ff8874283.camel@linux.ibm.com>
 <172467410002.31767.12365606864399178508@t14-nrb.local>
 <172483282308.162301.11735420619446380771@t14-nrb.local>
In-Reply-To: <172483282308.162301.11735420619446380771@t14-nrb.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Aug 2024 16:53:02 +0100
Message-ID: <CAFEAcA9c1pAE7gttju5ib470ZhEMjd1=UMjLuhS+gXohnLs=Xw@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw, cpu to
 three-phase reset, and followup cleanup
To: Nico Boehr <nrb@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Michael Mueller <mimu@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Wed, 28 Aug 2024 at 09:13, Nico Boehr <nrb@linux.ibm.com> wrote:
>
> Quoting Nico Boehr (2024-08-26 14:08:20)
> > There was a little hickup without the fixup to patch 2, but after Nina
> > pushed the fixup, we did not observe any failures related to your
> > changes in our CI. Thanks!
>
> Peter, after a few CI runs, we unfortunately did find some issues with your
> patch :-(
>
> Rebooting a guest in a loop sometimes fails. Michael was able to bisect it
> to your series.
>
> The problem is intermittent. The guest is unable to load its initramfs:
>
>   [    0.560674] rootfs image is not initramfs (no cpio magic); looks like an initrd
>   [    0.588605] Freeing initrd memory: 95680K
>   [    0.593143] md: Waiting for all devices to be available before autodetect
>   [    0.593144] md: If you don't use raid, use raid=noautodetect
>   [    0.593145] md: Autodetecting RAID arrays.
>   [    0.593146] md: autorun ...
>   [    0.593147] md: ... autorun DONE.
>   [    0.593156] RAMDISK: gzip image found at block 0
>   [    0.609110] RAMDISK: incomplete write (29120 != 32768)
>   [    0.609113] write error
>
> ...and then a panic because the kernel doesn't find a rootfs.

I repro'd *something*, but it wasn't quite this. I got:


[    4.691853] clk: Disabling unused clocks
[    4.695419] Freeing unused kernel image (initmem) memory: 6520K
[    4.695430] Write protected read-only-after-init data: 144k
[    4.695834] Checked W+X mappings: passed, no unexpected W+X pages found
[    4.695849] Run /init as init process
/init: error while loading shared libraries: libgcc_s.so.1: cannot
open shared object file: No such file or directory
[    4.697009] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00007f00
[    4.697030] CPU: 0 PID: 1 Comm: init Not tainted 6.8.5-301.fc40.s390x #1
[    4.697035] Hardware name: IBM 8561 LT1 400 (KVM/Linux)
[    4.697040] Call Trace:
[    4.697047]  [<000000007ab6ae36>] dump_stack_lvl+0x66/0x88
[    4.697081]  [<0000000079e17c2a>] panic+0x312/0x328
[    4.697096]  [<0000000079e1de84>] do_exit+0x8a4/0xae8
[    4.697101]  [<0000000079e1e2e0>] do_group_exit+0x40/0xb8
[    4.697103]  [<0000000079e1e386>] __s390x_sys_exit_group+0x2e/0x30
[    4.697105]  [<000000007ab9526a>] __do_syscall+0x252/0x2c0
[    4.697113]  [<000000007aba8840>] system_call+0x70/0x98

Which I guess could be caused by a different corruption
of the initramfs ?

thanks
-- PMM

