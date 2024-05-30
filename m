Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FD5C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCe7i-0003v3-KS; Thu, 30 May 2024 07:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1sCe7h-0003uZ-Eh
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1sCe7f-0005Vf-Ob
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717069146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T0TUfAj4RJNZ65zxbfyezHxgJFqsR/bnexD8OH+b0z4=;
 b=BqiWDNjrKO1l5HFN8mLhi0nu3MpLM59jZuNzmyuKieVgl9p8Y5UwnMeu8Th+vcxT1s2KBz
 n83L+fWI3qIeDWoSKvOqijRliyii9p7tHFeqmwM3AcVbn9ir2bBM+yBKQqmzdFOFhtsRU/
 GKvS3UimO9dB+ZbZk8eEkiX+Y/qB/WU=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-EUlgg_56OJ-_U18Aoz-7LQ-1; Thu, 30 May 2024 07:37:59 -0400
X-MC-Unique: EUlgg_56OJ-_U18Aoz-7LQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3d1ca4ed5a3so939404b6e.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 04:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717069079; x=1717673879;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T0TUfAj4RJNZ65zxbfyezHxgJFqsR/bnexD8OH+b0z4=;
 b=bwlE5bipVruiYMAxu3UpUVrOhMuw5HCw4JJNP1zNPpyxaxKXQZYdGaxMUjrWgL5VnM
 AoYCaV5X7+C9zG6MJ4MXJP4OPqx/YjwGVgC7N4boDpfJeW55FA+Rs8sVoXYa1Y6DWmtP
 jVutczCGQlRwypIa/qWRMRq9YJiMWvyN3JC9lWfD/HghATlt5B1s6+PUZ3KXKsa5op2R
 lK70JK4OtplDMzemMjDp5Bhc3c4blBs2P7StbZrs6QbavB0Ja+3S2Y5w8k8JLVm3qKup
 CsFhUFdtshWWoN+JmWge9pIz6AtfJZlboemOCkP3ycGaOhn8ZSLZ5C1UYzU5hUvdYKQy
 X9OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9HBmJbRQaDdyfYKOUb8hpkYul9IkNZRYuPyvHnqSkkOo1r0edis1TY8aKQLanpzY7hjVgQR0N5C9H1gABZMErbm0i4dI=
X-Gm-Message-State: AOJu0YwBulvwoFVO0baY5MNy4c4gpaeD4DLaVKDZsyWFyznKhSN1iGo0
 YIXjRS28gRAqiGNfnFNzn2HI6bnXW9+8272bZBhEHPqrJ7X1jDm0gf/LOcXZsEUQPGJvVDce0pr
 6eqXu74LUVsdJ3T3WD7x58crXAu/wzPtYK1FJD9Tx3NZu9YhHcPwWitkmfqvTun+G+/EVU7/iMy
 9J7mfbAHOMMSHdq7poUPaVj7Yemzg=
X-Received: by 2002:a05:6808:201b:b0:3c9:63d1:6fde with SMTP id
 5614622812f47-3d1dcd0ee0dmr2080564b6e.37.1717069078757; 
 Thu, 30 May 2024 04:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpzjKbIlP4EgyyykFL1/BAKFfqGjBbycm565mhwk02jxBYySFqWmflWQlQF1flrkCRAf+hpU0iqasKwA0FsGw=
X-Received: by 2002:a05:6808:201b:b0:3c9:63d1:6fde with SMTP id
 5614622812f47-3d1dcd0ee0dmr2080550b6e.37.1717069078389; Thu, 30 May 2024
 04:37:58 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 May 2024 04:37:56 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20230525164803.17992-1-sunilvl@ventanamicro.com>
 <CABJz62MFZzx3jBgW6TtGFD9emY+DAbbftSybD8ZouC65n3-auA@mail.gmail.com>
 <20230526-b0d8b56e9688dea7ae9d00d5@orel>
 <CABJz62Nk-U+qHQjn6G2-bN8i9RcMEZWdYTyi7wqC=7BVjDSBWQ@mail.gmail.com>
 <20230526-e398cfda73f326653323ea68@orel>
 <CABJz62PXvVNEwpqUz0dUUYTAGjmNU4h0NtFf664oubaJmKxwKw@mail.gmail.com>
 <20230526-cbbe3fe3734dc64264a2ad83@orel>
 <CABJz62N3tBpCtLmQmnYzLHnUNRZcxOxn2iLzPu=V3THVpp698g@mail.gmail.com>
 <ZVtu44sFAQeWxGjO@sunil-laptop>
MIME-Version: 1.0
In-Reply-To: <ZVtu44sFAQeWxGjO@sunil-laptop>
Date: Thu, 30 May 2024 04:37:56 -0700
Message-ID: <CABJz62PXn7g+Qa5kUsrYYAO3_pqVHwpk0z2DLpgq2pspBA4biQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] hw/riscv/virt: pflash improvements
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Mon, Nov 20, 2023 at 08:06:19PM GMT, Sunil V L wrote:
> On Mon, Nov 20, 2023 at 02:29:28PM +0000, Andrea Bolognani wrote:
> > On Fri, May 26, 2023 at 11:10:12AM +0200, Andrew Jones wrote:
> > > > > > So, are edk2 users the only ones who would (temporarily) need to
> > > > > > manually turn ACPI off if virt-manager started enabling it by
> > > > > > default?
> > > > >
> > > > > I assume so, but I'm not tracking firmware status. If the firmware
> > > > > doesn't extract the ACPI tables from QEMU and present them to the
> > > > > guest (afaik only edk2 does that), then the guest kernel falls back
> > > > > to DT, which is why it's working for you.
> > > > >
> > > > > I suppose we should wait until Linux merges the ACPI patches, before
> > > > > adding RISC-V to the libvirt capabilities ACPI list.
> > > >
> > > > That sounds reasonable to me, but note that 1) the libvirt change
> > > > might take a while to propagate to distros and 2) someone will have
> > > > to remind me to prepare such a patch when the time comes ;)
> > >
> > > Initial ACPI support will probably be merged for 6.4. So maybe it is
> > > time to get the libvirt side of things going.
> >
> > Randomly remembered about this. Did ACPI support make it into 6.4
> > after all? Is now a good time to change libvirt?
>
> Hi Andrea,
>
> Not yet. While basic ACPI changes are merged, the interrupt controller
> support is still going on. Looks like it will take few merge windows to
> get ACPI fully supported. So, we still need to wait for libvirt change.

Hey,

I've been working on making RISC-V support a bit smoother across the
virtualization stack recently, and I just so happened to remember
that this topic was still pending.

I've tried manually switching ACPI on for an existing Fedora RISC-V
guest running under TCG and booting via UEFI, which promptly made it
stop working, so I assume the necessary bits haven't made it into the
kernel yet.

Is anyone actually tracking that work? We've been waiting for it to
land for a fairly long time at this point...

Thanks.

-- 
Andrea Bolognani / Red Hat / Virtualization


