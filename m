Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106E7CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY4sR-0006E4-85; Fri, 12 Jun 2026 12:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wY4sO-0006Co-TD
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:37:00 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wY4sM-00010g-E2
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:37:00 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66077e90382so1069503d50.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 09:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781282214; cv=none;
 d=google.com; s=arc-20240605;
 b=KPD/HciZNmYZB8b2HGPdwdB2Q+JuvjCl2OJjATqHgfFd6xvA6Ygf20vpCAv057EBKd
 1v8SUVWpqNdv5W94uFgGZ8CQyVKLenPo0/EtEwea2IVTPtgCaMN4h0+I30geD7FWfk4m
 nxmdqKT1MaW2/CDpq8MZ/g4nPAigRrCk+dyqY8MPVqr/GxNUUFfD0v/PRsrSTGHaWCro
 U4muOnLRlP+GU+VUm28kAgfoBumdU72LBGU7OJIRmK7UgLpZ8OPsFqOnLvXf+lDLMyVG
 7nx/2H7Rs6QFnAh/mGtPPela7jC8qkKe1kkatQoeFhLoNtsaUQoRutpiUEpNIaofjLeO
 DM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zwXYwFMmWcXDkYRzgXTSPi/0vzhQdUkmxVByW2NUFQg=;
 fh=Eg8x1WyjqL0q/IaDrW/ejocW3XPmdMUVZlOOJFJ3ANU=;
 b=JH7pHNz+yls4q+z5mE8fYAk2R8/yI9aK4eBQymkRgx+iv/9cVYv0HDH2sI4/HS4MQp
 OdnUo63nj7o4fXOrzKzDeUk3RA4XHOl1c/1kVwxP5rE4jNRf8iRvxDK/C77IHoi9GEoO
 dxhI6D61PdzKsrxwObR/2ExuMrpRoJG04GTDtI+SufdACy6PEn2ac8HryV5Kq4RbxxI4
 3g8G2erTeLgrBYC74xj2bCydKtKDs0ZjCfy9fC3lz6FUs8wchk6KvPKHU891XUjepDsP
 UTedwjoiJWRVnDsEmCfxe205CVJvzoVUaQD7Qeehzxwzs+fISyJ5+d6rKoy7s3L0MNwe
 EDWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781282214; x=1781887014; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zwXYwFMmWcXDkYRzgXTSPi/0vzhQdUkmxVByW2NUFQg=;
 b=stIBaXpyvSOdPPtgdZdfSs1K3A+XQkWcb7eEDLQ4aVRMACPQV8hm13B8peqEBZUlC7
 oYSv9ZyV7HHvCsc/Z28Z6430G3nk+TyoinLBOrmS+LkNaLZ1INfEsL6CEcJqUv21KNc5
 MaZx9WmW5cuLl9jAEnv3CMd1BYA7+TQXt7+vNvoB9EVPQKF4DQfisOYx7VUsr0F/9fnV
 jMQ44b2ndk9pIBP/sPriZd0IpDIzaOAHIslcuK5vlUh++qUbLUUt2LhCRO3xYaKwCUmN
 Dt1Wjt4Im4IUPE5LXA9g3MrUDVGnuiBjQwPtTn2RGbbWPaT7ZnEsT50nFP/d4NCR9Vdw
 QxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781282214; x=1781887014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwXYwFMmWcXDkYRzgXTSPi/0vzhQdUkmxVByW2NUFQg=;
 b=CdC81HlsXM3+cLSBN+/w/7XGVcdbOU/DirZT8FvHZtsSwO62qwdp/i+kL8G/2MWTQn
 ielwT5pN40K9W1yDfJfUod3uME0RpI+i8PL7GOkw82CFSojCBEG3OXbBkwp1YYljqJMf
 fqty74yg7ucuaOt6Ezt4y/mo1mcQEDZgSuUJPSAadin5lBUlhKZ8y4f7dQDNpGMoaWrA
 kzFxXDO6iTmbdkGTsFNK3w2pU+osMTvUU6CMYoRUcXaWS+pa7vIG4ctIdfLIpp8/z/iG
 rGDg80j9HY56fCFiee7MAIYBdVESl0G2HTS41FElVouYqF5GmSb/LRt2EsXDLbRU8bR+
 pA+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kD48Ym4ECaD5sOFagSgzv9SZDUS2fdDPToao27oxHYq6GkZQxu1ex7W2KwaxGleeex8l78TNpEioh@nongnu.org
X-Gm-Message-State: AOJu0Yw6hVK2xIt2NxcW0IfOc+625N/anSgl+YY4P60qogfwO2QwGVqt
 M86ix6pKl0ytO/gRN4Qkl/VkRezwzl7VJXsRnUCbMJt5JeInNLpsoukNLqlf4Lpl7HrXtdYkIGI
 0d/L0hlk8BLHDvMIaw52OBdJEwygcnmwg7q4tyRzWHw==
X-Gm-Gg: Acq92OFBEHFfveCCAghXA/xGqSW6Z/2aYuqrxzpbRsInNVxCB2HM/6xN5PU1dAU9XCD
 PtXOOKyEdz5CtsjgIyh+X3I5jXS4tNLK8b6SMNJbe4jj6E5KrPdxqAC3j0LQ3+pDeKQ0gS08U2z
 NLVY3ZC3kxkCFFRz2YdUtUknOzRyWzAaVbPZz4Nn93pM59Fwqooxm9qyPQsC3meGBX8AiViiQXD
 LDT4PQ1FmC5CwzWaOk7CpgJUah75Zy3XNIL8bOWWJMoATrVVbdUPj1P5bkqzld9vMc8sY7+3nt3
 6GkURK94yvU8F8nP+7j77toFElWZjrdYWnH657Vo7sRiG575cXc5GO2OaTaXogWtGQc=
X-Received: by 2002:a05:690e:4194:b0:660:3b5c:69f8 with SMTP id
 956f58d0204a3-66278365e0dmr3046602d50.59.1781282214471; Fri, 12 Jun 2026
 09:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260612110307.1264798-1-gshan@redhat.com>
 <20260612110307.1264798-2-gshan@redhat.com>
 <223f5f94-b9b7-46b0-8466-5be655203a0e@linaro.org>
In-Reply-To: <223f5f94-b9b7-46b0-8466-5be655203a0e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jun 2026 17:36:42 +0100
X-Gm-Features: AVVi8CdMu-7uYvT4bAX8tK5C71T05n1JYXUMFvRcSVuF3kTgZjpRWZEMgAwuw5A
Message-ID: <CAFEAcA-TgP_BM0WQo3rysZmvhNN17Gc_nrSYB6pXn-mvs5w13g@mail.gmail.com>
Subject: Re: [PATCH 1/2] system/memory: Use __builtin_mem{cpy, move} in
 accessors of ram device region
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 peterx@redhat.com, mst@redhat.com, berrange@redhat.com, david@kernel.org, 
 alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com, philmd@mailo.com, 
 phrdina@redhat.com, jugraham@redhat.com, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 12 Jun 2026 at 16:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/12/26 04:03, Gavin Shan wrote:
> > This replaces mem{cpy, move} with __builtin_mem{cpy, move} in the memory
> > accessors to ram device memory region, preparatory work to make ram device
> > region directly accessible and bypass the bounce buffer in the DMA path
> > in next patch.
>
> memcpy/memmove *always* compile to __builtin_memcpy/memmove, and the compiler later
> decides whether or not to expand inline.

Yes, but if you pass it a fixed small integer, then it is likely
to expand it inline, whereas if you pass it a variable then it
is likely not to... The patch is attempting to persuade the
compiler to definitely do an inline access for 1, 2, 4, 8
byte access.

> So, this doesn't do what you think it does.
> My real question is: what are you attempting to achieve?
>
> (1) is the problem unaligned access to a mapped physical device?
> (2) is the problem vector access to a mapped physical device?
> (3) something else?

I think there are two problems we're trying to fix here:

(1) If a device does e.g. a pci_dma_write() with size 1, we want
this to turn into exactly 1 byte write into guest memory, for the
normal case where the guest memory is real host RAM.
This deals with the e1000 bug where the pci_dma_write() turns into
a call to glibc memmove() with size 1 and glibc's implementation
turns that into 3 writes of the byte to the same address,
and then a guest write/read might interleave badly with
the extra writes.[*] Similarly some devices specify that they
do definitely do DMA accesses in a particular way (e.g. the
Arm SMMU spec says that the SMMU reads 64-bit page table entries
as single-copy atomic accesses).

(2) If a vCPU (emulated or KVM) does a 4 byte access to an
address which is in the PCI BAR of a vfio-passthrough device,
we want this to turn into exactly a 4-byte access to the
mmap()ed memory which is the BAR of the host device. This
is because that address might be a real hardware device
register, so it's important to access it exactly the way
the guest vCPU asked for, and not do multiple accesses or
misaligned accesses or whatever.

(The reason we make pass-through BARs not "direct access"
but instead go via the bounce buffer is that we were working
around (2).)

[*] I have not fully investigated the e1000 situation so it's
possible that there is some other issue also there, e.g.
guest or device model getting barrier semantics wrong. But
writing the byte with the "done with this descriptor" bit
3 times rather than once seems like asking for trouble.

thanks
-- PMM

