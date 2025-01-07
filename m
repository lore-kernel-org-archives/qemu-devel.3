Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE70BE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 17:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVDQN-0003tV-I9; Tue, 07 Jan 2025 12:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tVDQF-0003sN-Ie
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 12:31:19 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tVDQB-0002v9-Ty
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 12:31:18 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso13451433f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 09:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736271074; x=1736875874; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ESrXcS4CyR34nc2MA3Yc3tYjqpuUJbG5oTiHQj66O1w=;
 b=lyhjLdezeu/0HSRDUKDEJIov8UBl71rLdz4Md28BEBbikdIjGIcRnWG5MZnMtchwKy
 OlULnipGygfBl1fq1/aKC7hAArANHCB5/b+bQHI5Qr2QSKivHon8u5h3wmMv3vcnd5pi
 LbZD6Wk1M4fX75Z+Mq9hkxhJI+FE13IvWZUV6si5+bjrS4CshCqdzNmy14MM0uYm2TkC
 XaFsmYWLKNjvtoCuvFvOmZbdDyb2hEyPacmMJIK7u3w8sKZIraphh5cuaB0JdpXL6feI
 aLYJqVe78Xq7SVQbx60vpHEFUbT/O2NYwzeYQ7fexznltvZUxKKPX2WEKgKp7qhutBpC
 v41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736271074; x=1736875874;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ESrXcS4CyR34nc2MA3Yc3tYjqpuUJbG5oTiHQj66O1w=;
 b=Xl0c/owYgcydxcmXiaOsewQam3TJZc/dcj5iceHpGSUcoXyrp2+oUuRo6WWzgvbvZR
 E3WEIMFZBNg04BSUN4SAysIUXhXr1eylUpUqXaxpVXzWXqC0jGiRDlh8AbhPqFS6m9So
 Fv+mwG787wPFmJgOUrNBsCeRxl9aUs1/OJVZiCKs3LoMGgUKQheCTDJT6g9MFxQb9zj/
 6rReiKt5TM2BaHdL7LrSb+W5YKFUXT/9Jz52x119qiiUZy1N32k8jmLvbS38gkWWc34m
 Qse9yg/7bNB0dxottmcVFokfXfSkcAdZn2ulpUWGvXWQ0SklO6l1KqMiVFzQJ/F+tu/G
 3vTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrjVY7Xx5YrVbcSgg1wVZ/PfSSNOF81Zm2+4SEdru1QMIIxU2rFqOK4XFmz6YAtroL6yqulDRFcwPy@nongnu.org
X-Gm-Message-State: AOJu0Ywlj9TxAi1mqSxuPf2oVnXCB8BGQXPup4mGLHPamxAycLwxIvFE
 zVuzCFwY0h+35CjFKlUZqV0IPZ3p/ifx+3+sy0mK9xU7ckAk7rWu
X-Gm-Gg: ASbGncvT7A0s7V4izJNeii8sVyQ5pn5GdDzhchItJKyynRvwaH1sU5yMXRYDNO/+nsB
 G+W4sxao26qRPoFNGZ/3OrMV4pOf0CZTvWSlXCuFRJ3pdMIV8w5/kZePBNYjafCoNdOgVZ/Mj7x
 KXs+PDCFZ4HSKPt2XuQHre1x3tqIHx/W66JVPBKXZyK4M2LKNjLk5VooiHXS+yqIE51qQqxs0Lv
 r8R5/N+hkvflZIJItX6edEKg9T+0VoiL2kfNqBwQO8rp5U/ZHTRqAFX4zobAAhevjIDVP7lt/bK
 ivhfubEZLs0IFCHT1//J
X-Google-Smtp-Source: AGHT+IFLkrufmByFsBIalSOdTV4+sXe+2QS2kCKfrBBQZdwM5Mihg1mCSw6uXtDG3JUd8UNtdsfnlw==
X-Received: by 2002:a5d:5986:0:b0:385:d143:138b with SMTP id
 ffacd0b85a97d-38a223ff407mr51287114f8f.51.1736271073656; 
 Tue, 07 Jan 2025 09:31:13 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a6e19sm50665188f8f.100.2025.01.07.09.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 09:31:12 -0800 (PST)
Date: Tue, 7 Jan 2025 17:31:11 +0000
From: Stafford Horne <shorne@gmail.com>
To: Rob Landley <rob@landley.net>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
Subject: Re: or1k -M virt -hda and net.
Message-ID: <Z31k3zNN3pOdGWWK@antec>
References: <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec>
 <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec>
 <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec>
 <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec>
 <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
 <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net>
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 07, 2025 at 05:56:52AM -0600, Rob Landley wrote:
> On 12/31/24 19:19, Rob Landley wrote:
> > On 12/23/24 07:05, Stafford Horne wrote:
> > > > The kernel config looks like it should have virt block device
> > > > support, but
> ...
> > >    -device virtio-blk-device,drive=d0 -drive
> > > file=${DISK},id=d0,if=none,format=qcow2
> > 
> > -drive file=file.img,format=raw,id=hd0 -device virtio-blk-device,drive=hd0
> > 
> > My -device looks similar but -drive is file=file.img,format=raw,id=hd0
> > 
> > No idea what if= does? I haven't seemed to need it...
> ...
> > Thanks, I think this target is good for release. Now to figure out why
> > sh2eb network isn't working after the restore (it used to!). Nor is
> > microblaze's network...
> 
> My test harness appends -hda filename.img to the qemu command line, which
> works for all the other targets, and is awkward to turn into
> -device lots-of-stuff,file-filename.img,more-stuff inside a shell script.
> (At best it's a special case parsing and rewriting qemu command line
> plumbing to turn "generic" into an architecture-specific workaround.)

Hi Rob,

Sorry, from the laat email I was under the impression that you had everything
working as expected.

> In THEORY I should be able to do something like:
> 
> root/or1k/run-qemu.sh -netdev user,id=net0 -device
> virtio-net-device,netdev=net0 -device virtio-blk-device,drive=sd0 -hda
> README
> 
> And just have extra arch setup that then accepts the generic appended to it.
> But in practice that says:
> 
> qemu-system-or1k: -device virtio-blk-device,drive=sd0: Device needs media,
> but drive is empty
> 
> Putting the -hda before the -device doesn't help. (And even if it did, the
> result would barf if run _without_ -hda, which should also work.)
> 
> Having -hda by itself is accepted by qemu, but I don't know what bus/driver
> gets added as a result (or1k kernel does not find it).

I am having a hard time understanding the use case.

As you know I use the following to wire in the buildroot image which I turned
into a qcow2 disk using my tool:

  https://github.com/stffrdhrn/or1k-utils/blob/master/scripts/qemu-or1k-mkimg

  -device virtio-blk-device,drive=d0 -drive file=${DISK},id=d0,format=qcow2

But I think you want to use:

  -device virtio-blk-device,drive=sd0 -hda XYZ

I have not used -hda before, do you have it working with other targets?

According to the qemu docs in qemu-options.hx. I see:

    Use file as hard disk 0, 1, 2 or 3 image on the default bus of the
    emulated machine (this is for example the IDE bus on most x86 machines,
    but it can also be SCSI, virtio or something else on other target
    architectures). See also the :ref:`disk images` chapter in the System
    Emulation Users Guide.

I think, since we don't have a "default" bus in openrisc this doesn't work so we
need to specify the -drive explictly.

I checked the x86 machine code and confirm it seems to work like this.  There is
code in the system setup to look for hd* drives and wire them into IDE.  There
is no such code in openrisc.

-Stafford

