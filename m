Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF84FCCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8f8M-000159-6h; Tue, 14 Oct 2025 09:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8f81-0000sv-1C
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:31:51 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8f7p-000091-F3
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:31:48 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-63d0692136bso2062244d50.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760448689; x=1761053489; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XW2a6gWYcC1WnuVYDBcLoYUBaoDqPbQydJ7nhuEJsDs=;
 b=mHKcHCMUf0599uox6Hoh98RkOPKGhBA1Nf7RL9pWeddhsXJy6zfjB4JQvtAg5/aFOy
 ghYfRGeBiBmBqrWpkOtpmu+q4qXQlJ3uuMScKITmHY7wVWu4zokq3ro9CpPMYtQSYd0M
 mUcOvlZDDs8rAqkm9xzMegLSdcg9pIP8oKq9hk36TJjTXQ/xB4Ii1eCMtOaqWlNV6diM
 I1qyUjCXrhG2yV+W5EkxIRdWkSyMmCYPHl7/DE63L3r1g2l2QCqe7hWFrsHOduzPCN8G
 3HDzkgrBCDoFafvXNVqWMbaHksod3Er6WYkvrSKaVjsXMiou+mrLxEUneVdrQyzLOUh5
 RlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760448689; x=1761053489;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XW2a6gWYcC1WnuVYDBcLoYUBaoDqPbQydJ7nhuEJsDs=;
 b=H6y7Lk0jYbl0ZsjQjatZDsYQYvnBiX6cpmjKkmEJMHpqTpe3s1kAv8blMvaAYK0pYQ
 rR2gQdaRXRPejXrb1YqjFmo5rDFE4p4YQUc/6ZtkHLl95b0QOaqOYQJl3VMXvixp9+bR
 Rd9CBHLmZTpB1NoJayz1XQvj1MEmUKxIAiQD5V7+SLjqQriDRoFypYOpMd+iUwAZqLnZ
 Y0Nki1v3qNUMVYhNrVWIy+Sdtx+yxa77ubckvUgKe6xt3Zabsh4d91FIABclPr/nfThX
 kGP1YcQKRK1vTiXQ5O6UQQrAd3YM7Ic58wDQL+5WHTwTZ9LGLL9s9XL42ibpZ+VeAgo/
 JJ1A==
X-Gm-Message-State: AOJu0YzvBitbJkICwedIwwblGsozfLSpWvZvX/EN0N7mhYKsA5HnU+Yt
 MFCbSdayoANmfwVBauzXhgiMwatB1u2uuZODCPr51FyyOdTrClIOfTBAh5lvyIdPOjAwwFqDTkr
 DNJC+1gvITKiglhCfrLeQht59Fu6lUidqGXcjtXaW2w==
X-Gm-Gg: ASbGncv+JQ7sYu6sFm7lChjvEIyvftHIXnpFgU098WFB0Z1f9fDFPP6wyN/O2kKBhxu
 VDSPMskbZuFwtEG+fAPts4sbfRAZm43UyCBtP/FEDHLBlkrTwj8eGewM/XFSjjH1/D1Jqgkrc9X
 HWKkJVd3dcu7NcKW2Kldt36qklyg49WkoQorlbBHTpxT/aiL8ub3uOpNjGYlrpd/KitZKVuAclG
 +qmlpQYzA1P7sd2iaI6qtGQNOkLerNs/zasOXNBRw==
X-Google-Smtp-Source: AGHT+IEmyPGxtge0re7VgCuoIgBKV0sLz1T8rwJqNuZtnBXV2zeslWnPCFlW7jeaXybg/p3Urk8skZ87Lq2+dqsei5w=
X-Received: by 2002:a05:690e:86:b0:636:e0b:7bd5 with SMTP id
 956f58d0204a3-63ccb8dbd91mr17704290d50.31.1760448688975; Tue, 14 Oct 2025
 06:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
 <eebfcb04afc2498d8969d96fcbcf0926@huawei.com>
In-Reply-To: <eebfcb04afc2498d8969d96fcbcf0926@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 14:31:16 +0100
X-Gm-Features: AS18NWBvhznq6zUD_XVLQ_IUpAw3cv5PhmbCn__9oxabrlS2vbbX88_BH59uhg4
Message-ID: <CAFEAcA_MZu4stZ4MY4zdpM0zy-gNBA3yj4dkuWL3d-FLFZC6rg@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Salil Mehta <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 14 Oct 2025 at 14:23, Salil Mehta <salil.mehta@huawei.com> wrote:
>
> Hi Peter,
>
> > From: qemu-devel-bounces+salil.mehta=huawei.com@nongnu.org <qemu-
> > devel-bounces+salil.mehta=huawei.com@nongnu.org> On Behalf Of Salil
> > Mehta via
> > Sent: Tuesday, October 14, 2025 11:41 AM
> > To: Peter Maydell <peter.maydell@linaro.org>; qemu-devel@nongnu.org
> >
> > Hi Peter,
> >
> > > From: qemu-devel-bounces+salil.mehta=huawei.com@nongnu.org
> > <qemu-
> > > devel-bounces+salil.mehta=huawei.com@nongnu.org> On Behalf Of Peter
> > > Maydell
> > > Sent: Tuesday, October 14, 2025 11:25 AM
> > > To: qemu-devel@nongnu.org
> > >
> > > Currently in arm_gicv3_icc_reset() we read the kernel's value of
> > > ICC_CTLR_EL1 as part of resetting the CPU interface.  This mostly
> > > works, but we're actually breaking an assumption the kernel makes that
> > > userspace only accesses the in-kernel GIC data when the VM is totally
> > > paused, which may not be the case if a single vCPU is being reset.
> > > The effect is that it's possible that the read attempt returns EBUSY.
> > >
> > > Avoid this by reading the kernel's value of the reset ICC_CTLR_EL1
> > > once in device realize. This brings ICC_CTLR_EL1 into line with the
> > > other cpuif registers, where we assume we know what the kernel is
> > > resetting them to and just update QEMU's data structures in
> > arm_gicv3_icc_reset().
> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > > I've only tested this fairly lightly, but it seems to work.
> > > Salil, does this fix the EBUSY issues you were seeing ?
> >
> >
> > Let me try this and get back to you.  Also, just to let you know that -EBUSY
> > can return from other places as well. Please check  my reply in the other mail-
> > chain.
>
>
> Got this.
>
> (gdb) handle SIGUSR1 nostop noprint pass
> Signal        Stop      Print   Pass to program Description
> SIGUSR1       No        No      Yes             User defined signal 1
> (gdb) run
> Starting program:
> /opt/workspace/code/qemu/qemu/build/qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3 -cpu host -smp cpus=2,disabledcpus=2 -m 300M -kernel /opt/workspace/code/linux/linux/arch/arm64/boot/Image
> -initrd /opt/workspace/code/filesystem/rootfs.cpio.gz -append console=ttyAMA0\ root=/dev/ram\ earlycon\ rdinit=/init\ maxcpus=1\ acpi=force -nographic -bios /opt/workspace/code/uefi/edk2/Build/ArmVirtQemu-AARCH64/RELEASE_GCC5/FV/QEMU_EFI.fd
> [Thread debugging using libthread_db enabled] Using host libthread_db library "/lib/aarch64-linux-gnu/libthread_db.so.1".
> [New Thread 0xfffff5b5eb40 (LWP 31994)]
> [New Thread 0xfffff4e88b40 (LWP 31996)]
> [New Thread 0xffffd4dfeb40 (LWP 31997)]
> Unexpected error in kvm_device_access() at ../accel/kvm/kvm-all.c:3475:
> qemu-system-aarch64: KVM_GET_DEVICE_ATTR failed: Group 6 attr
> 0x000000000000c664: Inappropriate ioctl for device

Does it do this consistently, or only sometimes? What
host kernel version are you running? And what QEMU
commit (plus this patch)?

I'm guessing from that "disabledcpus=2" part that you're
running some not-yet-upstream set of QEMU patches. Please
drop those, and test only with this, to rule out the
possibility of some bug/unexpected interaction with those.

thanks
-- PMM

