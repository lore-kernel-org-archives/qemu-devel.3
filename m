Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C9CC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 11:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6xI-0005cw-Kg; Wed, 12 Aug 2026 07:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu6wT-0005aV-S5
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 07:16:18 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu6wP-0003ja-Ef
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 07:16:17 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-80dc4a68e4aso9050777b3.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 04:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786533372; cv=none;
 d=google.com; s=arc-20260327;
 b=dQXfZyjVvjZcMsjfmzP4iBNSVMiv1Aq8Nj4Km3ShXVdb+jgnTPW/VuaJijrXuHpmEp
 Ax3vz8gDlRRONsAGP1g49rFFHTrmdBZwtgo1FRUPwAcVrP9nQUl52Tu2dISS8/cgNhyR
 ZUnHsZWp00knDKVpOpK2HDs3hlLsjOP72zOopsGyZpKhiXU71Im+8CYsuTeOcRvsQmgq
 A+pPl7hLvkTrrgTR7LK6NyoIMmf6ac/i/acAtDXwEd0+K0oXMjYx4QQQTUiI3kveFSQo
 elpV7BTtSG/XHweqLmiLDi+jvIZGMeNKwI9xTOCaeJrrhzwGB6/KqWXxfkTSZhVqh3DA
 a5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OjWcQUJKDi7jq2I4AWhV+OpD+ESWrsN8UirciFn/lyE=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=IHJ2hyE6Xya65UXUx1s4/yTE/JQZXfm0f1CiGYAGLWK/4mmJ5890a65dZUzM+w/5ik
 LgOUmvBz6xcSm79RgQjYJq7Frq2qHUoqFvKUgrrtxK4TxzlvX/MsIdOQD4ZqAMjeMCa4
 As+OcWQILBl2tJR0I5Kvszj72LSfL55heKqiXLMMTSNNBWpBGc3V0REwOBjtP1IgSpnw
 CVMki3iKBlnM1+/kX4JvDttFVFrO4gFFFhd92ojTJAmNdsuTYXYdK1z1mlUrk16JEIHB
 xQiHx9+NdXNZskmhUVOPe54esvzOrI6miMfrfsViRA0y+N9QQ+2Bi4Fpa/EDsqWC4pe5
 hppQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786533372; x=1787138172; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OjWcQUJKDi7jq2I4AWhV+OpD+ESWrsN8UirciFn/lyE=;
 b=kixkMeLGgEzWS4rOnn3lH+aczPa64LfIx5WbPHkoZSIK+W3oQoFUj99q8Kvtp3Zfat
 bCHgpbgTB4hw/5TYNaToqmSueuiPnxTJ/WRbj/6WekxxqEUwUJLzEU7TqG3kReEkal90
 ODyd7N5g2LCRrR2ItgNhvU22rGymEML2VcPepnqoJXjPT46DfQTnsTP49HANESSVSTi7
 yxXiHu+kAktcpUUMuKfJXPb5R88eFtjlEiUNC2Whw3nw8Xbz4zPH2Ryv4Nf6hdwRxYpC
 QQjqBBuaoLHYIUHFox9RVR8A2phUZHM4khitn+FaVWx136dnWs94M+ie6vXCMGOeV/+6
 NMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786533372; x=1787138172;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OjWcQUJKDi7jq2I4AWhV+OpD+ESWrsN8UirciFn/lyE=;
 b=M7vHdObOG5lG9exNS0DCmBwuK0vn8FHNoyFcu9XhKR3ugvix/HQRxByrFflQO++xuD
 WfSSULJNztvR+Gk+Jvy0V8JvKJlrxe1z0GE7f2cKitkyFrEBoR+fm4+Uj/NqxRfwLgpj
 sEdRmkwRN5KNKNgr9X+MrrGw5aamjMDnuMw9SbZZ2SBr54kuuvaRMBKSv1R4quxjA7aH
 socmqXzCG1hxv0UVtC9CUFrw4kNLFIorsJ1kNkQ8d8eiYqe9/G5sT8wA6M7WNkf2EzQG
 oVsDeLUsTHw9HrZAx7PEFr+vhrQowbaxWULB13tPO248Txect160xQY6tfIk4oXHmgDL
 TmGQ==
X-Gm-Message-State: AOJu0YxwVF7WGcowSPqL0MBppFXM7mCq38ZU7NnCFTK+kyv9a9D9tqUT
 jAS+uYGhk2tTG8eKsnfc1fiKnGVFDOrMZFzqWBrnTV03ABF+fgnpwC6UaXt3dIHjbDcAh5/18e7
 hkOEaO/dDa4P4Qljnpkw3nE7ej3vwukVkUgBl1Ybb5A==
X-Gm-Gg: AR+sD13NVUBifk71hz2E5PV2dvY249p8l4Xdc/HaN4KfY/0yeeUy0V2zKhia1pluqO7
 +Yp5tCn3Q3zgmREe21IqMl6gvAnrQSPF2G4ooYeG2qUtwXdYwH4I6Fidtx4S/hiecmw7GdrzIAi
 gj6CllL85sSuoLjxdKxS8F4f9khovQOEE/kLAVJ9yRO5qoyII8HI8MhP+pEPmFRVYBOlaCdZ3Br
 BRcyhXlW1iFr1yLYPa6LFJeb2wIyJdmS6rNHGx96evx4esgZVLb2HSEsTSY/3G+s/a11vtjdcJy
 6K45fBard0UsjANslpx1Z9XzLs2umCQtDT6bB3HQ2u5K5AIr34DpxJR3iq0juLKrSZ10QiKox4y
 zAfgn+lpb0aWRTlaIiOblwPLfXhQT7g==
X-Received: by 2002:a05:690c:3746:b0:7dc:aa85:5c67 with SMTP id
 00721157ae682-83107542990mr25218167b3.11.1786533371673; Wed, 12 Aug 2026
 04:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260806163939.328201-1-richard.henderson@linaro.org>
 <CAFEAcA8stJZ6JZW1un++6zj+CDwkR-zTpA4G9ksTetO-xOn01w@mail.gmail.com>
In-Reply-To: <CAFEAcA8stJZ6JZW1un++6zj+CDwkR-zTpA4G9ksTetO-xOn01w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Aug 2026 12:15:58 +0100
X-Gm-Features: AUfX_mzON05yEI6YGaZeENZTFRmfXETFaJMzdj2Q53bqbNlsUwJvbDPEEBYn1Bg
Message-ID: <CAFEAcA_KTrt1=PstjYvtkatvWqhUYaSNwX1kq6NB5j-NxGcOwQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] target/arm: Introduce cpu types max-v8 and max-v9
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 12 Aug 2026 at 11:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 6 Aug 2026 at 17:41, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > This is something that we've talked about for quite some time,
> > having separate "max" cpu types for Armv{8,9}, because Armv9
> > prohibits some deprecated Armv8 features.  Retaining all features
> > simultaneously has the potential to cause confusion.
> >
> > r~
> >
> > Richard Henderson (7):
> >   target/arm: Tidy cpu_max_initfn
> >   target/arm: Pass ARMCPU to aarch64_aa32_a57_init
> >   target/arm: Pass aarch64_enabled to aarch64_aa32_a57_init
> >   target/arm: Sink aarch64_aa32_a57_init into aarch64_max_tcg_initfn
>
> I've taken these first four cleanup patches into target-arm.next.

Turns out the first patch causes the cross-arm-kvm-only and
cross-arm-xen-only builds to fail:

/usr/lib/gcc-cross/aarch64-linux-gnu/14/../../../../aarch64-linux-gnu/bin/ld:
libsystem_arm.a.p/target_arm_cpu-max.c.o: in function
`cpu_max_initfn':
/builds/pm215/qemu/build/../target/arm/cpu-max.c:223:(.text+0x4c0):
undefined reference to `aarch64_max_tcg_initfn'

I think this is because we used to have the call to
aarch64_max_tcg_initfn() inside an "if (tcg_enabled())"
block, so the compiler was able to eliminate it in the
TCG-disabled config. Now we've dropped that, the call
is still present and the link fails.

I've dropped the series from target-arm.next.

-- PMM

