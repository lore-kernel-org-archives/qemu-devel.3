Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C698CFDEE20
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 16:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFwcZ-0005f8-9a; Thu, 23 Apr 2026 12:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFwcU-0005eX-K1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:09:39 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFwcS-00021z-RL
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:09:38 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-79ea87af213so111513777b3.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 09:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776960576; cv=none;
 d=google.com; s=arc-20240605;
 b=kyRc7tCcm1YW059b8kZB6gxqDXV9WZGPHQOcBEG28PFrD+5B4C7vGUOxJieMFW+deS
 3oVUXubwU5cgK2FkTEoAJT2KLBF7us1OSvca/h2gwTdRzaSD2Wu/p8YPhFp6mE143BLS
 beiAoRc37leJbG5aMWdqjk1TMBxFyGynQa7st0AlU703HQlSFSuGCQ47QsNqDd9CRw07
 B/HmwzZBx6+GAdbY4rZfo1FbyD79dNTUoneAmV4YaYBh/5QCDZxe+9MOJArdGkUr6tfz
 a5U5Fh4EnyZrhFsVL3AIb1scEh2iC2V3ExMaR/slk807T5nC+poWZ1pJhkY/W3DhK+gG
 wZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Oyrb+VFTX1y1h7u/ZrXpLyEo9eukCNW5hPY4wJZwLUA=;
 fh=OYgHMKSCnXMKvNxsn8EtC8PbHXVBVskpY6rZsSCNpu8=;
 b=YB1ECm39vIFVv4zGDtmGZXoS3A3XD5cky+4MsO+9qm0HWAjaKwUKXFIil27yEoP64g
 EtKIIhwT1vT+FCwLRiCgGSbl3tIob8HcZy5u3ikUxLY7/l0DTbfiFUos0IXFgJ3s/DHK
 8vV9HHrFUYvOmkbWN6QYw8N0LduCHEDBoF7NdgqnylnDRtQgzYvwVSKCMeboUUphrzba
 DLT58S91sXx59BxbHdbj/4tG3wTcHOpuYk+aY97DtLr32eaWgMXMCektP6QxYwShMgUU
 jnQ+d+1phENN8Zt6k2LWT8iOheGU6E7j1Ul6DEWtKn2U/jp/rG72vQahG22ybcDHjLML
 4KDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776960576; x=1777565376; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oyrb+VFTX1y1h7u/ZrXpLyEo9eukCNW5hPY4wJZwLUA=;
 b=Zfq83CaqyeTMjsYzoRMg10Hd/Pc0ymyOJh6nbXCKUow5umf5ixlcWB0Rqj90/W9lYx
 8QHGKdAzkF9vsaS55ziL5C9Itu9s3v6+xBZ0l8k2dUQR2+sloFuA3MvsKqZLnRTjAQmc
 9U/XT+PJ5087qxBEbaPlmngPs0kZfQqjPadgPs1ku6c03jS+pYP9zJ5gfZSlScldfGDy
 VdFE+ettcTzK82abnRsAqSrCDineHwsh49KDgcSHktnO/KyX4SDzqCvq6277ZckaRVPV
 Byt8hzkt3P5ZPd91+ISml8kCcjygrdnCzEq8a2iFjSlW2SnWWS4CmYjekMacBpYqRkpe
 RkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776960576; x=1777565376;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Oyrb+VFTX1y1h7u/ZrXpLyEo9eukCNW5hPY4wJZwLUA=;
 b=HVPzL4D6f/GktS+Cz08H9ksh1EjS7dFKT+YGq5jTsxDEJkNB9PUFJj5/Xp5EmB2OmH
 cLGcWiDvzm25xiz77+QWW01LKSrEqDzW+TY39xsu8UW7/U5wu0vZGX4SCoQp40IDseSq
 afE6nq/gN6fL4NPUXHzYyV60mmTJKj89r4KANGBR/ddytWvzSKJLmmsOl6vG+8Hxv/kC
 tK6gEq5gxIcSfZU+QC7ypAnzj1ypxndRtMBmiCD2BbH8EI6G3gk5B32fASiliUAHdrmU
 6L4VC0nQ/fp62Glt9M2OZiFz0RrD4brGAC54OVlghrs3bdjGMfftmkoWK0Hba4MrKMqy
 gsIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cPjuQ3Ko3o+bbL8HjBM0/aU7mczAzUcQJaxrceN8e31yZpKU1PN9/dBqfjnnLVbWtELRtGN3LC6yk@nongnu.org
X-Gm-Message-State: AOJu0Yw8ZZ5gXz9CYYlnd0Fn/g8mKBJnPAttRzKL92hvPlfVc5kpwHLl
 220CIT3+EFxBcMSTZV6Rj74N4fBWrcn1hwLuiQcO+a9PJ/2UenebNbH288WgmbR1x6il2JDyE9J
 zhaUuUozSc1bKpVMcC3WzDTaZcUhCviev8eubmY9V5A==
X-Gm-Gg: AeBDievS+Cof2enSKn3WHIqtsljf9a4YHs9MON1XyKlANjK9R3kNAFYqR/zoX/tGZ1u
 4n61feEV8HzLaYvI1TjJzGydNmFVDgKYNt1xqKXlJ87cl7gV4jsLC3r6r9MZmgzaCIQN3lj3iq8
 R5iLi8Cx35aw1y4VWE1uP3Nu7ze8Yubap/JQpO47ELXVm9Cv4Q2UR1OX88aohIl4H3Cr7MQgoma
 jqHpLFbRanLnXsONkhiFA7w63/OULCWH463YZYW1pOSbd3Xln2/h2tRkK1WrPXcvrD9J0/8LGA4
 5zsbVLrbSnOh6ieLOUNGPDDFQZo6jpDx9kiY2LffOBGl67+d+Dnk1MSNauwVu0Tw11oEydyAV1J
 dBw==
X-Received: by 2002:a53:5a04:0:b0:654:3fdc:7b3d with SMTP id
 956f58d0204a3-6543fdc80e1mr6513728d50.29.1776960575416; Thu, 23 Apr 2026
 09:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAFsMJvCLRw2Q=4muDNG1Ojj3oL+UgTrVzpYM6VULRvdFxgR=KA@mail.gmail.com>
 <df1c484f-bc30-49d5-9928-de6e17dd2816@linaro.org>
 <CAFsMJvDWFmMx2t+9JXmBsWP+8r0XZDP+LRm6bN9k8wF5b6CSLQ@mail.gmail.com>
 <d56c0dd2-720a-2973-865d-c9d16b90b69f@loongson.cn>
 <CAFsMJvBKkLf=F=g=6H5_-FX4wJAzC6MhweoapqVTPx+7V9e9bw@mail.gmail.com>
 <CAAhV-H6tAdv9BwrkgPTLWKpy35jJx+aG0xHGK2=CWdx5cUeiPg@mail.gmail.com>
 <CAFsMJvAhdCdXEAFC27JJceA4Mc2Y3fADC7ASHBPitqeLgHMJKA@mail.gmail.com>
 <73b6b6c0-81ee-b054-ad59-3067a718b492@loongson.cn>
 <CAFsMJvAj9Kp_ZP188QnuAzsPv90Y9Gb0x4twuiamo4OG8Kvc6w@mail.gmail.com>
 <ff06a5b1-f36f-ccc9-3d8d-90f3fed1320c@loongson.cn>
 <CAFsMJvDO8CPt1xAYMBc9JWEE6FPsvNZjwAtWEAsQjVoMneTUNw@mail.gmail.com>
 <23e33b6a-acca-4e01-aa3e-d702aa45ea4c@gmx.de>
In-Reply-To: <23e33b6a-acca-4e01-aa3e-d702aa45ea4c@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Apr 2026 17:09:23 +0100
X-Gm-Features: AQROBzCg6gyLXygE-_Oj7GX-VZ_st8gYbTZSbCGbjTfleHV_4Hk-6NRpBNK2p0c
Message-ID: <CAFEAcA_SdysnnbwVt0SLLA3=sjzNxKwxUgE7Eue3XPea8od4wA@mail.gmail.com>
Subject: Re: [PATCH] linux-user: fix usage of struct target_stat64 for
 TARGET_LOONGARCH64 in syscall_defs.h
To: Helge Deller <deller@gmx.de>
Cc: Gyorgy Tamasi <gyorgy.tamasi@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, laurent@vivier.eu,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 bibo mao <maobibo@loongson.cn>, 
 xianglai li <lixianglai@loongson.cn>, pierrick.bouvier@posteo.net, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 gaosong <gaosong@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Thu, 23 Apr 2026 at 16:36, Helge Deller <deller@gmx.de> wrote:
>
> On 4/16/26 21:14, Gyorgy Tamasi wrote:
> > Hi Peter,
> >
> > Your analysis cleared some things related to this older changeset:
> > https://github.com/qemu/qemu/commit/c52e405968341b1d10c618f23bdbb841e39=
f9255
> >
> > Before this syscall-NR 79 & 80 (newfstatat & fstat) was not enumerated
> > in the old/deleted (non-generated)
> > linux-user/loongarch64/syscall_nr.h=E2=80=8E...but these appeared again=
 in the
> > newly created linux-user/loongarch64/syscall.tbl=E2=80=8E.
> >
> > I can recall that I was getting "Unknown syscall" messages for 79 &
> > 80, when I tried to run qemu-user 8.x.x even with the simplest ABI 1.0
> > executable, because even the shared-lib loading phase failed on these
> > missing syscalls 79 & 80 (used by the old glibc env of that ABI 1.0
> > exe). So in the case of that older qemu-user 8.x.x it was obvious that
> > it is not compatible with ABI 1.0.
>
> I've applied this patch to the linux-user for-next git tree at:
> https://gitlab.com/hdeller/qemu/-/commits/linux-user-next?ref_type=3Dhead=
s
>
> I've added the comments from Peter to the commit message.
> Peter suggested to adjust the commit message.
> Gyorgy: If you want to resend the patch with a rephrased commit message, =
I'm happy to take it.

That's more conversational than we usually are for commit messages. Here's
my suggestion:

=3D=3D=3Dbegin=3D=3D=3D
linux-user: Don't define target_stat64 struct for loongarch64

The kernel defines 'struct stat64' only if
__BITS_PER_LONG !=3D 64 || defined(__ARCH_WANT_STAT64).
loongarch64 doesn't set __ARCH_WANT_STAT64, and it isn't 32-bit,
so it won't get this struct.

QEMU incorrectly does define a target_stat64 struct. However this
isn't causing any guest-visible problems, because defining the
target_stat64 struct and TARGET_HAS_STRUCT_STAT64 affects these
syscalls:
 TARGET_NR_stat64
 TARGET_NR_lstat64
 TARGET_NR_fstat64
 TARGET_NR_fstatat64
 TARGET_NR_newfstatat

For loongarch64 the only one of those we provide is newfstatat,
and that is actually a separate QEMU bug, because the kernel does
not provide that syscall for this architecture. No real guest
code will be using a syscall that doesn't exist in the ABI.

(Some of these syscalls are present in the loongarch64 "ABI1.0",
but that ABI was never accepted in the upstream kernel, and
QEMU does not model that ABI, only the "ABI2.0".)

Stop defining TARGET_HAS_STRUCT_STAT64 anyway, for consistency
with the kernel and to avoid confusion.
=3D=3D=3Dendit=3D=3D=3D

As there's no guest-visible symptoms, I wouldn't bother cc'ing stable,
though it is a harmless change.

-- PMM

