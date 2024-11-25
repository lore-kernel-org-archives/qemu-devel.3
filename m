Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA7BD3B7E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 07:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFT58-0007O5-Md; Mon, 25 Nov 2024 02:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFT51-0007MT-LE
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 02:00:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFT4y-0006Yz-Ef
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 02:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732518012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=07HcakVChWGda56kqCXSe9WUPbcKa0aStTsqSjw/Cgs=;
 b=Soj2D/aj6z8mfQK2aemO/98TJG05z9jqPL1enQa8+4+3jiMmKT+Ake8d1eZHs5YMFxMORB
 c4QWN0h52xUt4VvXmMmfZJ0sXdvxblhNaUEmp+T34vW1f9NNio8sIh2o8D6ZQqp+xvvT4i
 j5xHIYUkYhlFaQpSWdwhqBaRuVIM79U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-TzN256LMOTuFlm2zHaoV9A-1; Mon, 25 Nov 2024 02:00:11 -0500
X-MC-Unique: TzN256LMOTuFlm2zHaoV9A-1
X-Mimecast-MFC-AGG-ID: TzN256LMOTuFlm2zHaoV9A
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4349cda1899so7895895e9.0
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2024 23:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732518008; x=1733122808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07HcakVChWGda56kqCXSe9WUPbcKa0aStTsqSjw/Cgs=;
 b=cd6h2ldpKUqD89PEi2ktiggYzbpd/MWnXHKiJvsbcjoQgHarDuviOJCitmvb3Sr4bY
 TJNdqt1EqxmrwodKJNTViPpzFxzVxuE8wef+THgGnQUZZHoozN2bReiz7IViPLLvunrH
 iH9Un1O4MOVMtNbDf/zK1M4ux3re/66igyURE7Vud63tg/C/K9u4YWYWisOtnrJbSyiA
 jlXPyJbQ4NDU/efD1JelI46jUxEiUg1l4bY4kXFvGu0uLAz+P4wmtex3y5KJhJfNBSIy
 nxBQmw/EqFDasRE6XZsawI3kQuzfVoN+4q2H78sReDZQcF2EkHRcsejcB5BbHwgDYh2e
 RrFw==
X-Gm-Message-State: AOJu0YwQJpI0BDcB3qB9WuNVdmAQtE0P68pUw8PycIYjFbsYix21BcZO
 98FB+Ygb3OOcAJd5MRLlVZSkHCgRhl3zGHksjwCFMkiTv+VmOSs72Xt1SxLXZtjnpfBz1m5Bm3P
 AjyCwGcHVRrxNOjSpaUKb56W2akwrc8AO+g1HjXBemlf77YJ5rCUBlnLYmzHafMnYHPEkMezA/T
 a2irxGMLtE6imUS9VYeWED/Jzkqpo=
X-Gm-Gg: ASbGncs3kuwsaIJrFT3HaUSaZ0GGioxcQ/QFTHt87kV/6Bb8cNTSCCaI4RKWPY8/5x5
 +KylWdXur64RidDFkl0k29aQAcdtoQdBS
X-Received: by 2002:a05:600c:3150:b0:42f:310f:de9 with SMTP id
 5b1f17b1804b1-433ce434707mr111165665e9.15.1732518007972; 
 Sun, 24 Nov 2024 23:00:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXys4A+KtxGd4eB8n/G2i2yPyLG2Lce4s4GiM+9D7i9hhdBSJYgvrXkwQDZY7wOxpuuP7HeMxZUPDzuTYhZiI=
X-Received: by 2002:a05:600c:3150:b0:42f:310f:de9 with SMTP id
 5b1f17b1804b1-433ce434707mr111165355e9.15.1732518007628; Sun, 24 Nov 2024
 23:00:07 -0800 (PST)
MIME-Version: 1.0
References: <66c346de-7e20-4831-b3eb-1cda83240af9@linaro.org>
 <b045c676-4722-4fb9-a800-27c92d832347@redhat.com>
 <c8ec9243-f489-4b91-946e-2c6ff7e36f71@linaro.org>
In-Reply-To: <c8ec9243-f489-4b91-946e-2c6ff7e36f71@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 25 Nov 2024 08:00:00 +0100
Message-ID: <CABgObfbpEEHbLYNNXoNUwD0VNPiNAYB-9REqgEFhRz3QQKTZYw@mail.gmail.com>
Subject: Re: Supporting clang on windows
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Nov 24, 2024 at 9:23=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
> > This one unfortunately shows why the global change is wrong.  The size
> > of _GIOChannel must match between glib and QEMU, otherwise you have an
> > ABI mismatch.
>
> In the codebase, we always use this type as an opaque type (through
> pointer, using library functions to interact with it and never use it's
> size). So the fact we see a different layout is *not* an issue for QEMU.
> I don't see it as a counter example that this does not work.

_GIOChannel is just an example, and in principle macros could be
relying on the layout of GIOChannel. My point is that compiling a
program with a different ABI than the rest of the system is a ticking
time bomb, and therefore compiling QEMU with -mno-ms-bitfields is not
a solution.

This is also explained at
https://github.com/GNOME/glib/blob/main/docs/win32-build.md: "You
should link to GLib using the -mms-bitfields GCC flag. This flag means
that the struct layout rules are identical to those used by MSVC. This
is essential if the same DLLs are to be usable both from gcc- and
MSVC-compiled code".

> -mms-bitfields is already the (silent) gcc default on windows, to mimic
> MSVC behaviour. Yes, it would be preferable to use this default and
> gcc_struct attribute, but right now, it does not work with clang. So the
> whole point is to accept a compromise for this.
> I don't understand the strong pushback against clang support on windows.
> Because of a "theoretical" problem, that was proved here we don't have
> currently, we are stuck with gcc_struct attribute.

I think you are unnecessarily pessimistic:

* there is no need for a compromise, eliminating gcc_struct is the
best solution but it needs proof that it introduces no guest-visible
changes

* there is no pushback against clang support, there is pushback
against asking for a change without understanding the problem

On the other hand, the problem is very real even though we might not
have it *now*; it's not hard to find out when and why the option was
introduced. If you do "git log -Sgcc_struct", and then Google for the
commit subject "Add new macro QEMU_PACKED for packed C structures",
you'll quickly find one of these two links:

https://patchwork.ozlabs.org/project/qemu-devel/patch/1314564200-6872-2-git=
-send-email-weil@mail.berlios.de/
https://lists.gnu.org/archive/html/qemu-devel/2011-08/msg01877.html

As an aside, at https://github.com/msys2/MINGW-packages/pull/21540 you
said "I think too it's more a FUD argument than a real problem", which
is a bit too dismissive. If anything it's a case of "once bitten,
twice shy".

Anyway, the problem is *not* that QEMU uses gcc_struct. Rather, the
rare but real problem is that there is, in some cases involving
bitfields, incompatible struct layout between Linux and Windows
compilers.

gcc_struct is *one* solution to that problem, and the one that QEMU is
currently using. It has the advantage that it cannot go wrong, and the
disadvantage that clang doesn't support it. Note that it's perfectly
possible that there are no such cases in QEMU, i.e. that the attribute
has no effect now. But it's been there for 13 years and it was
introduced because of a bug whose cause was MSVC bitfield layout.
People *should* be wary of removing it.

clang's lack of support for gcc_struct is stupid, but we have to work
around it and we can, without introducing potential ABI breaks. Just
verify that gcc_struct still has any effect. Initially I mentioned
checking sizeof() but actually it's possible to do the same using
debug info, similar to your scripts.

For example, I tried doing another kind of analysis based on
llvm-dwarfdump. This will give the list of source files with bitfields
in them:

find . -name "*.c.o" | xargs llvm-dwarfdump|\
  grep -we DW_AT_data_bit_offset -e DW_AT_bit_size -e DW_AT_decl_file|\
  grep -B1 _bit_ | grep decl_file | sort -u

Restricting the list of files further to those that have QEMU_PACKED
in them, the list becomes just:

hw/nvme/ctrl.c
hw/pci/pcie_doe.c
net/util.h
include/hw/cxl/cxl_device.h
include/hw/hyperv/dynmem-proto.h
include/hw/i386/intel_iommu.h
include/hw/i386/x86-iommu.h
include/net/eth.h

Looking at these eight files, in some of them the bitfields are
defined via registers.h. In others the bitfields:
- have the same type within a word
- don't span multiple words
- use the smallest integer type that fits them (e.g. uint8_t in net/util.h)
- always have a nonzero width

So it *should* be fine to remove gcc_struct from QEMU even without
-mms-bitfields. But we need to be *sure* that it is, hence the next
part of the email...

> > However, your script lets you do the opposite experiment: remove
> > gcc_struct QEMU_PACKED and check if anything changes, i.e. whether ther=
e
> > are any QEMU_PACKED structs that do rely on the gcc_struct attribute.
> > If there are any, then it should be possible to change the definition
> > and fix them.
>
> It does not only remove gcc_struct attribute, it replaces it with an
> option that does the same thing globally for all packed structs.

I understand that, and I'm asking you to do another experiment. Do not
change the compile-time options. Instead, change QEMU_PACKED to just

#define QEMU_PACKED __attribute__((packed))

and see if any struct definitions (which will all follow the ms_struct
rules) change. If there are changes, let's examine what they are and
why my analysis above was incorrect. Fix those cases, add
QEMU_BUILD_BUG_ON checks only to the affected structs, and once you've
addressed any differences (if they exist), you can proceed with
dropping gcc_struct since there will be concrete evidence proving it's
safe.

Paolo


