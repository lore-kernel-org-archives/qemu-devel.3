Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15150C55172
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 12:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wq8Z4-0005k3-DW; Sat, 01 Aug 2026 08:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wq8Z2-0005jj-JT
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 08:11:40 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wq8Z0-0007C8-Ti
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 08:11:40 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6689402c7bfso2126464d50.1
 for <qemu-devel@nongnu.org>; Sat, 01 Aug 2026 05:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785586297; cv=none;
 d=google.com; s=arc-20260327;
 b=MgHGJIRqnpGosXomwJj/Zd/JO4LdqsODo/Bv/7n5tJ4XgTDxg8wQoIq03HbY/uF2IU
 SWk+nm+gP9iqOYJA14YJ9sVODN0Cc7hnG5XeajA/oEJzSEyvuI4QJvwYARm4tcaVq18C
 fsVAUUiYamd9iWxDmfOz7AHwBjMwLL4S8AbzZ24coXziS45TWMtwao/nCmOn1+wq5RQX
 76aGgIPmM4dDFzurW8w8+cJaz00SyLlqghJ/Wt9Eb4XTmqpjqx8hUGvY+MvAFqe8N770
 jVLiidnp9RCbJIAHOh/fjj1AZnZADx8j7gxoxowAzAIG1ZL9A8NEh0N0ijYChFdf3MP/
 8Bxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UgjMXdi8cONATIG/iFrROZJif2ZP+tde7p50i4hrn2c=;
 fh=s870vv0EBWm78XykxktPTJCvLP2dEvc6/lYXeGp6vUI=;
 b=Q7PYDHXMwle0rmFMmaI+Lx//fMuvU5YAqvRv9LuSlB0xTe0Xn31qxgnAVv5f33xNJT
 0BFnCEsHtd1szR80y1SAztFSEfmwRgY3+LN4VU3m0MclTcNOnpe+CIgSNQVtnjp5cEXd
 v0PUGmNpv4EWk/qVEsw4+I14UgbA+DFEDhEHDAv9s9Kqfz55LefsPmDzEdrmFziE1WWn
 f7PvaVABK7EnTx9s1VH8FBaeZpAPeBzPQufuqafEq7RbCsU3BQarXeou289uLCKigjz7
 1y7i5iZSSlzcZTK7NSaFv2ThDt0nyFno+jI9XawrRGe+IAE81TDo9bQrISGJ+DEQzLBb
 punw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785586297; x=1786191097; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UgjMXdi8cONATIG/iFrROZJif2ZP+tde7p50i4hrn2c=;
 b=MQNUQk9Ur/pPMTP/zsNOQ1TdO7bKu72KCFmll1y8g+90FzCrktMnGlrUA4VAcMNgfZ
 me16P5qZWYThYBuAHES3XTQqmaIH39cbk70FldNpvnRx03VQAzG3vrFRik19WeAlt0Ee
 HHCLEiovE1qA3LVXjIgKtyVsRLZNd7Do+EFvXKzkDsLdQmgaZ8HHUqKtp3YpeIb+VGfk
 1cxpfEOQWFOpf+XoJ/ZkNLm4JsQ2+AUlVIgD9imwglNO+Rftsem9RLVbg+OgGDdshGvx
 o7UcAWPHgMZr7L1eQ1r681TZIHzUVZd8fdsLtEEAmMXBAHXpHrKCqdBZWAo4wcGl/+oF
 KrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785586297; x=1786191097;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UgjMXdi8cONATIG/iFrROZJif2ZP+tde7p50i4hrn2c=;
 b=L3ny5cxspOxJF/bfxM/uQPqBm2Nbcyk9U64au2as/34kI6zPaVT19CXp/SlzCFQTQQ
 pte+6/XBVE1dfeMqp+x4DBSUgdwywXMP74pqz6MB2GPMD98wZjisvpopURFxdDv2hfPn
 jcUdymCyI6NRbm1D0j+HSz3eRMVRUncamXbZD6J3Ir2dDC+SPPVE9z/89DAtNZAKYqMy
 IrBhPxHtGMQWaVKKbWDic8EtDUhieNvyB0gAj76nx+Sq3bwpgUvBnNwZvsGL4UiDEHaP
 zPJIy8gX0zzwqmWVTDHF0ha63YEz6QCNtSqFT2nCd9+cFsgMh7I3H1bA2oaMBWeH11uP
 Cb1A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIUY0+ETGhC0+evMNWIxMZP51jKijkRS0gb0VDg09ygMaBCyLD32LzH1AFzDXLZFpqb8/byFpXTMYI@nongnu.org
X-Gm-Message-State: AOJu0YxChD4Vq9ahtC08+Mn3NF7TxuuYZNDq2R8MDOBaihVbiM6AzgCz
 oM5zrWk8ZOt0Omwjui1b7DlqSaM5cp+d47fia4y16dH419QSFD3KUtfBq9MaAvbpeUCmsvWAKw+
 wMtBmqvt99DVbaMV/MQGolglBqa1F7RUFyZjsvj4i3A==
X-Gm-Gg: AR+sD12zAxC6JXxVom3QQw9yQ5RI3U4hrQ3HU6Q5X9BBQ/P4VR8ekgmepp585tqRFuk
 93uccs1oxzm7Ks/eoFoL+LnpAXm90hofJoRW1YFvXKWnhaqgJ9pa9cxAXZPGLRVPyL02lETfz4x
 me0mbfZwR4J4MfoqO7IWeAyL68weQi2acRf2g2TW0raTPqZmD9Qnkw76CnOAh+vUtTeecRsQKVF
 16B1gtc9o84fAlp6lQLKk87G4aalmqoZrAIoA/o4meKS4/hjcGuHsMYVosBvBCf1jFqmpnUumS5
 F2EWupg5vXdcxniVUZr6gH4QYKwFfx7rg2lwwmK4GicOm7D8eRZaNwbXdBIqTrjpZG3vNKeCY+5
 +pYT5ewjAQKy3vw3DgLX2CNAPBiyZ
X-Received: by 2002:a05:690e:1b68:b0:664:e8ac:21ce with SMTP id
 956f58d0204a3-6694f0eafeamr3915501d50.24.1785586297098; Sat, 01 Aug 2026
 05:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260728192913.61279-1-deller@kernel.org>
 <CAFEAcA_8o2A8FDsJKacde+pdj4HzA5c7aTw=k7tmONYXD4=c_w@mail.gmail.com>
 <244987da-f6d8-47a8-ac4a-16a71c660e36@gmx.de>
In-Reply-To: <244987da-f6d8-47a8-ac4a-16a71c660e36@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 1 Aug 2026 13:11:25 +0100
X-Gm-Features: AUfX_mw6FMB1j47_BSEB6mE72Q92qufkdI8m2ML_DxyrqcsjEj2266zwiq3eM6I
Message-ID: <CAFEAcA9F8rauUNc2NAqbnf1f7-0O_ivft1XOftwt1hW0YWeeJw@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Fix msqid_ds struct wrt 32-bit big endian
 architectures
To: Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
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

On Fri, 31 Jul 2026 at 20:36, Helge Deller <deller@gmx.de> wrote:
>
> Hello Peter,
>
> On 7/31/26 20:05, Peter Maydell wrote:
> > On Tue, 28 Jul 2026 at 20:32, Helge Deller <deller@kernel.org> wrote:
> >>
> >> From: Helge Deller <deller@gmx.de>
> >>
> >> Make sure that the time entries (msg_stime, msg_rtime and msg_ctime)
> >> are defined as 64-bit time_t values, since the userspace may access
> >> the whole 64-bit value. By this change we fix the word ordering for
> >> 32-bit big endian architectures as well.
> >>
> >> This fixes the msgctl01 LTP testcase on hppa32.
> >>
> >> Signed-off-by: Helge Deller <deller@gmx.de>
> >> ---
> >>   linux-user/syscall.c | 30 ++++++++++++------------------
> >>   1 file changed, 12 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> >> index 740142825d..c93b770ced 100644
> >> --- a/linux-user/syscall.c
> >> +++ b/linux-user/syscall.c
> >> @@ -4216,21 +4216,15 @@ static inline abi_long do_semtimedop(int semid,
> >>   }
> >>   #endif
> >
> > I see this has already gone into git, but some late review
> > comments. I suspect this is mostly me being confused rather
> > than actual problems.
> >
> >>
> >> +#define target_time64_t         abi_ullong
> >> +#define target_swap_time64(x)   tswap64(x)
> >> +
> >>   struct target_msqid_ds
> >
> > Is this the kernel's "struct msqid_ds" (which it calls "Obsolete, used
> > only for backwards compatibility and libc5 compiles") or its msqid64_ds?
>
> Yes, it's msqid64_ds.
>
> > The layout matches msqid64_ds, which makes our struct a bit
> > confusingly named.
>
> True.
> In a follow-up patch this better should be renamed to target_msqid64_ds.
>
> >>   {
> >>       struct target_ipc_perm msg_perm;
> >> -    abi_ulong msg_stime;
> >> -#if TARGET_ABI_BITS == 32
> >> -    abi_ulong __unused1;
> >> -#endif
> >> -    abi_ulong msg_rtime;
> >> -#if TARGET_ABI_BITS == 32
> >> -    abi_ulong __unused2;
> >> -#endif
> >> -    abi_ulong msg_ctime;
> >> -#if TARGET_ABI_BITS == 32
> >> -    abi_ulong __unused3;
> >> -#endif
> >> +    target_time64_t msg_stime;
> >> +    target_time64_t msg_rtime;
> >> +    target_time64_t msg_ctime;
> >
> > Assuming msqid64_ds, the kernel version of this struct has a comment:
> >   * 64 bit architectures use a 64-bit long time field here, while
> >   * 32 bit architectures have a pair of unsigned long values.
> >   * On big-endian systems, the lower half is in the wrong place.
>
> Those comments are from the generic header:
> include/uapi/asm-generic/msgbuf.h
> and I think the last sentence about big-endian systems is wrong, as
> most platforms provide an own architecture-specific header file, e.g:
> arch/xtensa/include/uapi/asm/msgbuf.h
> and the big-endian platforms seem to have their high-word first.

The comment is correct for any bigendian 32-bit system that
uses the kernel's asm-generic structure. Maybe there just aren't
any of those that we care about?

> > That would make tswap64() not the right swap for 32-bit big
> > endian guests.
>
> I did my testing on the 32-bit hppa/parisc platform, and with my patch
> the results in qemu were correct and were the same as on physical machines.
>
> I just tried in a 32-bit powerpc chroot and the msgctl01 now succeeds there as well.
> So, I think my patch is generally ok.

Yeah, 32-bit powerpc also provides its own structure definition.

I think it's worth having a comment about this, at least, because
otherwise the obvious assumption is that our struct which has
no target-specific ifdefs is supposed to match the kernel's
asm-generic struct.

We could alternatively follow the kernel more closely in having our
generic struct match the kernel's and then having the archs which
have custom versions override that, but that would be a bunch of
extra work to get to the same place in the end.

thanks
-- PMM

