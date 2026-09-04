Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75374C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 09:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Pz7-00042g-Vv; Fri, 04 Sep 2026 05:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2Pz6-00042X-Cv
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 05:13:20 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x2Pz4-0001NX-P3
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 05:13:20 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-86cba60d4f2so6259957b3.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 02:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788513197; cv=none;
 d=google.com; s=arc-20260327;
 b=M69cXz31oxLd3odQ5yUJMna8O3+iyfQIP3XP/yoKY0ZWp6McPvL/01qBnANE89SdSm
 GhoSpR0UEx4WuJptbsHpJhWHlwRl5P68S/dn9D4j3nMATE2IHUIykJMmlvXnKOI6BtSq
 +Iu7LNo48XdGZ97rKsKhKN0nBe/s0uV6MGF8VPdgbi8hsPpdgEmTnp61MAv6i+tsgyfy
 u8rN7AGKADAfsSYamcl5Qz/ivSlnzkUgEp1Z7Q4kIlCWaDxNTNNtdHCAFtgtHUBI2hGV
 QpCo3LOfIGfVGf6H0bvlEfi3kcOclWYQiUzg+sVQUQIsK+J+k4O4mqej5qu+lvVnrAp4
 1ERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3KuK0/xWyWPUJ2VCeGrtwr9i7CdySMxdX8kDLswsz2Y=;
 fh=Gyq1ovar2/YxNGobqN7DG5oTV9TSGpWfDbqzBhZWdQs=;
 b=G5kvnTEep9MGcpOzT0RXLibcgAXyIxsGsA8A+Mk0BqxZLxvsNLwSUE4qELrq/sX86b
 UlXCcyUg8mzwG3//mFklw/BVi04McQnWPQQ7krjTnGhmprQ5WnGVoLZwT31VYgtThe5C
 ndR7IyjIBuCVN6+j9eRaRfe/YADJMXBpKYw7J3bCNXcHnvb/RB3x3t69LkBorLmkvD7A
 wscX3PlU/KgRvvwP1DwwkopYYOlThYHsMao9gRFNRVxF6/RuSUKb//YBkwAZKrGuUPJB
 56Em8nT3rzEbVbP0I3DJi1SX5efKJRQJ2Op/XjKC6YKW4dLlNoNIcDW4m40utmWDOCmp
 6RGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788513197; x=1789117997; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3KuK0/xWyWPUJ2VCeGrtwr9i7CdySMxdX8kDLswsz2Y=;
 b=WlYCTgkarW6IzdqX2jb8xWDccZoPRnzpGNMeDf0N2TgRHhRIQYYAqtSZd0I0HX+0KP
 3BbWDZBgB24jLk15LaiQsENsw8+9Krg+OjP5Kw0bjDMX1nrwYp8NZxDXNYAmrQCXuecW
 jbatIEBvdZ1CZjbyrn8JPS5eZZ1w/ONuNQU3/7iLCYcjPxLNu6fmN0Zk9vZ8ara5GRZ2
 2SXfxUX1Xbvl07Wa15r7fmugAS9erbgSvFA9RAJCRQtOVgthQCv7BVSbrCY8+Ao4iPq3
 NoHdKpB22zTGQfoSUFnGPaFVdEQM19M3FY4KBeke8BgbMKB/gVP2Psgh3nyHops5UdBZ
 UHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788513197; x=1789117997;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3KuK0/xWyWPUJ2VCeGrtwr9i7CdySMxdX8kDLswsz2Y=;
 b=BvYenZeXD+z4sXTFBfspBrjZXpTndi5EvBHQQnYEuWW3HVPlksuqlRycxiQ6eV0Hg+
 zyIArfCtvxgwyCkh2EN6RYzpDX3BeoBiPApgLsXS5l2mqmgjcfga1kqaNMwccMBxSJii
 aKu1lDSTKU84hLpJkNGr/HH36z3wZciCvSty2r/KJrQnuzcbhD2Kn4De0iORn3YFUPt2
 XQdJ+F408mVbL+mbaHPwg2vBwk3zELj7SNV/ytW4k2IczxGAC0xVzSiAHm49PlJ2ZGrt
 yzsYD5yl852ts5YB3CTFnzz6cH0PcQOErC+r5iWtzRWBohIjzhXFm6uUtCfkXK7EDcUz
 2JJA==
X-Forwarded-Encrypted: i=1;
 AKwUvByLXeC2BSENsWeAQQuqbeRA/T5oiyqfnDYNdUQulFgtNdaj7CtPycb8DTOfgQTlSoQDMHo7soll2b+H@nongnu.org
X-Gm-Message-State: AFuF++mgRpsEClcrM4Hhk4IqjyvCBY2DRXGQGAfPDImNxB5s5CdhJfyA
 XD15Qw9gR7DRvggDK/X7w+9PsSOhvgWBcJsUP0TnX0xOXrYbVZIzhPkfZedw3LMklS8Vv9j/HBJ
 dwpdV2+9uVqc3NCFgzXxd8KihZnHRZrd6Q4oDxfjjWw==
X-Gm-Gg: AYBFou1Wg/MFOVrWvtJVHNYoXCYxgr8dHPKTtNnQJ1l3PcIWkswkJ6xpecdifcgkwzR
 hvTMUjtMdnpIuAle9fUu0vc6GuyLkt2ygxLbNuZreqr4CBWgRIlrd/7IAr0FVQNqw7aAiZAycIc
 JqEJfuepazEZK7gdvJksu9WgEzXr3NdGVjA+YYH3Dq9OkiDkaRl7K4E+pIZo0uVbKSvYS3Jda8f
 C4v5fSuGRQfVtEmDAF23nozLPCjFZneqUwDg2cSgltG2P32eEnWBXq0UgokcUU9/pgLTaSUlisA
 XlYUJ4eXUd+YLIZdr+SfqkbZe2sSpPgILdROO6zgWMD7N652vod1SmSqW2oILEUuKj8j++IcaXJ
 wnI5Dr8eyMGF9/68ntW7eDFj4Wl5o
X-Received: by 2002:a05:690c:d84:b0:870:96e4:6709 with SMTP id
 00721157ae682-87122985ba4mr23809717b3.9.1788513196798; Fri, 04 Sep 2026
 02:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
 <app_CnHimOrOymMH@redhat.com>
 <CAE2XoE9A1WzOe43-qd1v9i6K9kSru4R2kEE1-2TrztoM=8NZJw@mail.gmail.com>
In-Reply-To: <CAE2XoE9A1WzOe43-qd1v9i6K9kSru4R2kEE1-2TrztoM=8NZJw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Sep 2026 10:13:04 +0100
X-Gm-Features: AcwNN1XmMtsZbPKNLMAbCn124Kkx6he4vS7eYTsGhVUqGR0-gXPjlR9nOIFqeeI
Message-ID: <CAFEAcA_4TZxYhFbHfJZCas7bvh_KZjNp2aKzx3LPaXTQFuoQYQ@mail.gmail.com>
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for QOM
 types
To: luoyonggang@gmail.com
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Fri, 4 Sept 2026 at 09:58, Yonggang Luo <luoyonggang@gmail.com> wrote:
> On Fri, Sep 4, 2026 at 4:19=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> > I'm still not clear on why we need to filter the devices at all for
> > a new "qemu-system" binary ?
> >
> > Looking at the device delta listed in your other mail, a large number
> > of those are PCI based. The microblaze machine types don't expose a
> > PCI controller, so those PCI devices are redundant / won't be used
> > with microblaze machines, which is why existing qemu-system-microblaze
> > doesn't link to those devices.
> >
> > The same is true of many of the arm machines too though. Only a subset
> > of arm machines have PCI, but the qemu-system-arm binary still includes
> > and lists all these PCI devices. Users simply can't create a PCI device
> > for the arm machines that lack a PCI controller, or they'll receive an
> > error.
> >
> > Why doesn't this approach extend into the future qemu-system binary ?
> > List everything, and if the user tries to add a device that's not
> > compatible with a machine, then it will simply result in an error.
>
> Device filtering would be complicated, I guess, as there is so much CONFI=
G_* for devices. Another approach is to just place devices under an meson "=
enable_modules "  (in *.so/*.dll/*.dylib), so it won't be listed(memory con=
sumption will also be reduced when it's not needed).
>
> But machine listings still need the filtering, considering virt is presen=
t for many different arches(riscv/arm/i686). so machine listing is still a =
thing.

I was wondering if maybe one way to approach that is some
"disambiguation" syntax on the machine name; so one could write
"-machine aarch64:virt" vs "-machine riscv64:virt" (or whatever) to
disambiguate when just "-machine virt" would be ambiguous; but if
there's only one machine of that name then just "-machine foo" would
work. That extends nicely to truly heterogenous machine names:
"-machine my-mixed-machine" wouldn't need the user to explicitly
give it a -target option or otherwise say that it includes aarch64
and microblaze CPUs. (We'd probably need to put something in to
prevent future machine name clashes across targets, so that the
only clashes are our existing legacy ones.)

This rests on the assumption that the only thing we need to
disambiguate is machine names, i.e. there aren't multiple
targets with user-facing (i.e. not easily renameable) device
names that are shared.

-- PMM

