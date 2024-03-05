Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFF4C48BF6
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 03:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhLCF-0008ES-08; Mon, 04 Mar 2024 22:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmattson@google.com>)
 id 1rhLCC-0008Dy-IK
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 22:10:24 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jmattson@google.com>)
 id 1rhLCA-0003BD-GK
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 22:10:24 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-412d84ffbfaso42715e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 19:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709608218; x=1710213018; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvn3MANUj/EZDfhu91vd14pnU3eGW+Y5/g+sIiJa3c8=;
 b=nCauqDe43heIRQ4cs1OI2FeUDl218MX4R/cUJio44f1b8bwpzYD75HXDxG5mCE2l6n
 LyxyR5y7pvm/v7SUHaePuWxv5I+VVtde9w/72gly6VRB1nDOAS9Y+9zDUMZlPvbl/tOc
 +1rYlT2I3VfHV+73bdRz68VJsWCijTKA3AjC/1vntbzOmEbkpmFeEfZknqOGqSvMLM1d
 qMNg2hsAI9LCsOXMrZ4rclniaXJgKcxQPPeQNn/YWeDDY/8Q8DGGdL+xUz2nVCKb5X5C
 cSIhfjsY/wq3YpDwYkeAsxEVtiUkhG0WXukI0DkL8p6Ta4sgTCJL8HiupqTzRNBf3d4U
 zNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709608218; x=1710213018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gvn3MANUj/EZDfhu91vd14pnU3eGW+Y5/g+sIiJa3c8=;
 b=vk9kF1MisW820E9NqebyMrHmXGATs+hX2qwW38hQ2Ishu9qzOas2Z3o52pTYnlKVSr
 pPI5ogwoeVX533LpH//UDjHmCyLF+6eM50P1GffQNuypAzveUIAzk3kUclHFgogkhyNb
 pbjJ8YEiLcru//b7R/O2aDSKZfAdJOMNDYWIbPHBecjms4EoNe5O2ZwmnzTwNkFQ2KuU
 RMm8HPl8cbLvNDYz1OtrDLyZ3cxuNk91tHV/WxMvG7nOixHM22i4Sqny70oQ3RoEz4Fs
 Y2qfLjdGllpsx1PwhUbOPmLepXl87rvqsdI1fTGi7/NkX57nd8YSM1yXRuTetnn3FfFX
 acOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLPn7dApe/2xh7lxCCNfyDx1RMErzjp8/DHIWNF8cyrDR3t16BusdfmsVjDkhkx89d4FsbUBF1UktGzxfXIoCPdxHwnjE=
X-Gm-Message-State: AOJu0YxtgYT7Ery/x4TaV3yMDd117XnBybLojFqExosFZXOn89CkQpsA
 2Bx5SVJtHDwwAAkx7nLEH5FixwSQ7TQLiSxQ7o3UR6dxYg+si8pAXWiSN0okYI7BGxnzJcgsvNO
 1PZy7RC50wni7j/arivWAKBFRRUIHNh3iBvLO
X-Google-Smtp-Source: AGHT+IHZdBV4XvLVjH2kYHplMlzfwvFzrZsluNZicC+ljUyG4+mrtZOBsCtDakMRE5TO1oiZkqqfMbCk0kJfLUeMUAE=
X-Received: by 2002:a05:600c:4c11:b0:412:e4fc:b10 with SMTP id
 d17-20020a05600c4c1100b00412e4fc0b10mr13995wmp.3.1709608218354; Mon, 04 Mar
 2024 19:10:18 -0800 (PST)
MIME-Version: 1.0
References: <39E9DB13-5FA3-4D1A-A573-7D58BA83B35C@fb.com>
 <20240304145932.4e685a38.alex.williamson@redhat.com>
 <51e57a7c-c8a1-4a18-a08b-d2c8fd5b35b3@redhat.com>
 <383DC340-967F-454A-B298-C59B3F70B63C@fb.com>
In-Reply-To: <383DC340-967F-454A-B298-C59B3F70B63C@fb.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 4 Mar 2024 19:10:04 -0800
Message-ID: <CALMp9eRwTEMUy+u-03U8Y20ez5_nyD=XA6Hs=OJYN2Pe80ms9A@mail.gmail.com>
Subject: Re: Why does the vmovdqu works for passthrough device but crashes for
 emulated device with "illegal operand" error (in x86_64 QEMU,
 -accel = kvm) ?
To: Xu Liu <liuxu@meta.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>, 
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=jmattson@google.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Mon, Mar 4, 2024 at 6:11=E2=80=AFPM Xu Liu <liuxu@meta.com> wrote:
>
> Hey Alex and Paolo,
>
> I saw there is some code related to AVX  https://elixir.bootlin.com/linux=
/latest/source/arch/x86/kvm/emulate.c#L668
>
> Does that mean in some special cases, kvm supports AVX instructions ?
> I didn=E2=80=99t really know the big picture, so just guess what it is do=
ing .

The Avx bit was added in commit 1c11b37669a5 ("KVM: x86 emulator: add
support for vector alignment"). It is not used.

> Thanks,
> Xu
>
> > On Mar 4, 2024, at 6:39=E2=80=AFPM, Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> >
> > !-------------------------------------------------------------------|
> > This Message Is From an External Sender
> >
> > |-------------------------------------------------------------------!
> >
> > On 3/4/24 22:59, Alex Williamson wrote:
> >> Since you're not seeing a KVM_EXIT_MMIO I'd guess this is more of a KV=
M
> >> issue than QEMU (Cc kvm list).  Possibly KVM doesn't emulate vmovdqu
> >> relative to an MMIO access, but honestly I'm not positive that AVX
> >> instructions are meant to work on MMIO space.  I'll let x86 KVM expert=
s
> >> more familiar with specific opcode semantics weigh in on that.
> >
> > Indeed, KVM's instruction emulator supports some SSE MOV instructions b=
ut not the corresponding AVX instructions.
> >
> > Vector instructions however do work on MMIO space, and they are used oc=
casionally especially in combination with write-combining memory.  SSE supp=
ort was added to KVM because some operating systems used SSE instructions t=
o read and write to VRAM.  However, so far we've never received any reports=
 of OSes using AVX instructions on devices that QEMU can emulate (as oppose=
d to, for example, GPU VRAM that is passed through).
> >
> > Thanks,
> >
> > Paolo
> >
> >> Is your "program" just doing a memcpy() with an mmap() of the PCI BAR
> >> acquired through pci-sysfs or a userspace vfio-pci driver within the
> >> guest?
> >> In QEMU 4a2e242bbb30 ("memory: Don't use memcpy for ram_device
> >> regions") we resolved an issue[1] where QEMU itself was doing a memcpy=
()
> >> to assigned device MMIO space resulting in breaking functionality of
> >> the device.  IIRC memcpy() was using an SSE instruction that didn't
> >> fault, but didn't work correctly relative to MMIO space either.
> >> So I also wouldn't rule out that the program isn't inherently
> >> misbehaving by using memcpy() and thereby ignoring the nature of the
> >> device MMIO access semantics.  Thanks,
> >> Alex
> >> [1]https://bugs.launchpad.net/qemu/+bug/1384892
> >
>

