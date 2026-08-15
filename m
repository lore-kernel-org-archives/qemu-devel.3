Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF59BC5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 14:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvFka-0007yQ-Mc; Sat, 15 Aug 2026 10:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvFkX-0007y4-C6
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:52:41 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvFkV-00077k-6u
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 10:52:40 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-836cd7310f4so28981907b3.2
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 07:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786805555; cv=none;
 d=google.com; s=arc-20260327;
 b=SPCv5j9sVogOgGD/f8QrGiE2WZRUffGiujPXhKmR10xXtI0X4VSq9lpG/BdiNt3oze
 a+wPgggEhX6pePoXEUal9YDCqj+rpNJdL+WsMPJ1oE/BBzUZJ7dAz1C3WCu+w2lvLe+x
 fq7b68h9eJyKAMK/jb4DAiYSJ50f2lzZMJ1dsjrA7MkUMAN4qCEZjdUAqpU7E/oInm4g
 4B7PXLIBoIvIkWUDE/61eC0BKrU3Onxp3KN0nGNgP8CbqF0Y/Gk8Qj7/X6VN7UYPPnXA
 KDgTzxoaVQysFdgqr+J/HFkJ8R646Auwufl7t9Y+ib6vfug+CcJ0fgeG5rGI3Ek8BWkY
 sVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/9w4J8FONwnQfziILi382EWPo/uUwicBt+DKZkBiozM=;
 fh=XtBGW/VyvE63GThaZ7ifB4zEv4I6SKtzcqxYHMbJry4=;
 b=pxSmitiQ4AIiUjO6V321S8P7D7i4Ewm2TwTIrPqvuur51dfFUjAK9/S2Ts+oMsFGGi
 Ujf3Y0QAjvot/xIPjd43qtCZNP890OyA6bo2rqQpT1AgHa66B2oJNjuCfczK8mFylZ92
 PCPqpn4sbePJpTa7sMDpeXeH6omI7BrBQNW3pcBSaqw25CrlLGn5ayEpB4uLbmLMTpcQ
 1xDflYFGGiPbJQJvGaUch1kH8bQwr7H0Ld8EXG5HQ2k2tgki4b8pK3YW2nZlRoqf6ykk
 g1VFD9zB4+Q8zdp0gV/TfmH4efhFa7AaQRM6PwPlOro3mv9AF+p4L+BSKLIopTW3o4Q+
 Cj0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786805555; x=1787410355; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/9w4J8FONwnQfziILi382EWPo/uUwicBt+DKZkBiozM=;
 b=wOJZ5EQPsJGdi0jO6NYR2btMJta+BYlgwAWBlp4yoRSTTsSEdzddflkg5WnLil+y5U
 hb9A8It+mBZQja9fTeBvmq/l2Ex32VF3tkFA5MebvQVNrJ5cxeMMApgNBj5ES6vyB7N4
 QbxEAbs8ZNGMVGcirqOGhtCCBGj0JTXTi+dHPLM//bCaSQibx2FVFBjdRYNOWDfg+8nN
 jvu+pWTpAyKYai1/530EOXJ2HXaz9438YHO1G0KeW3cC34NKm4S8bQGhHhp9dDu1p7OX
 ZY8x1J3/A5rHCCdRGKF+R7rT6vQraUUyqBCojd4DfkCWNGuF41cLgBGBtTIODIW7JAj2
 in6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786805555; x=1787410355;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/9w4J8FONwnQfziILi382EWPo/uUwicBt+DKZkBiozM=;
 b=gKH1/LrFkDZqeJARSlp+9qpK2Ib01PlawWmNFKVgO5sEjohLEBCB9JldxQYZWJGpUI
 DZ/G0x9A8fmOPlrbfktRyqppiHR/Je2+PWvQlQ3sGxw7+uhCP9igXUy+dO/o9za9gysF
 lXBRurrQ8awYlKMfqau9DMo86ssravmBSlvaTq5EmLXVZEG2YFdiku7Ewx3rvdP9dGhR
 iOxAtKCzbD+2JM1h3jZNCFi//P4bIYQ8586B7aRQsHpJI6C9xaa7fId6sMCEX2qr3Xgw
 RznGDarJmM7DEJX8oz97pqQPjSFvLC0kgdVxEFUD+4KqW1eGU4MpwFEaJ8HaevowRtwi
 /g9Q==
X-Gm-Message-State: AOJu0Yx8GqmP22WtFrKh5iVi6dsc1rxR7ac7BoJdAx2ggKkGjw4teobi
 e2G6mlEB7vKZWk/ZUizeLKdkviUPEwiM1tV1xE5bnVGTeeUqYDY6dlygOTSalkNjIJac65G7Jck
 //eNU6v1KwAdRhdH7XXjURdHAh/rWdXK3sqRYUd6RCA==
X-Gm-Gg: AR+sD100wzuNJRzE+/QUJz3kWlkkZvcGfNEvT90Uv1VyNWRQou5mGwf4aBi3BWB/BNt
 THOW964JCQZ28w+SNgTyAcRtYUsjxjDCBKL3NnCX0imNMPu6jMoxK3MBhM4DBKJfRIGUG6t8Ixz
 G2WepVVMtnGH3CP8IXrk/nvS+c5noFG2YvQHneYm3BBtF7j5PzycYAQltlv4/p+ms/3OoX+BzjO
 ntB9ulVLJWPrJjf+4GsdCR420+ttyj4ZTiBzeNKxCiwjKXVIgQGSF6mOIXrFjOiz/tZGPz80XTT
 9EWnpdrr0Vx9IH95jdis3Rh9oQhuvo/DdneuURkapQt2JZLHEPH5vzqasUmVxXoAnaogcSyuvcl
 nQvKdVCh0JGDrFib8oogNAmGfbqpmnszb75fMj+v5
X-Received: by 2002:a05:690c:c58c:b0:833:801:f715 with SMTP id
 00721157ae682-8371125d0cbmr38983667b3.18.1786805554653; Sat, 15 Aug 2026
 07:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260812200308.289238-1-richard.henderson@linaro.org>
 <ae5c387b-a12c-4a13-b3d3-7ce1a91d81d3@linaro.org>
In-Reply-To: <ae5c387b-a12c-4a13-b3d3-7ce1a91d81d3@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 15 Aug 2026 15:52:23 +0100
X-Gm-Features: AcwNN1XfWsjLOT30DnEj4meMi3CNGrpRWCy9ISRKB1F6K3V_99wEx5TXFoCTZQE
Message-ID: <CAFEAcA9qKQ9405fZRjDG4Ji2=Zw7ZsG35UuEV3vwmKTNKMSWqg@mail.gmail.com>
Subject: Re: [PATCH] hw/intc: Fix arm kvm gicv3 selection
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 12 Aug 2026 at 21:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/12/26 13:03, Richard Henderson wrote:
> > While 39a8c3941e may have fixed WHPX, it certainly didn't help KVM:
> >
> >    $ QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/arm-cpu-features
> >    ...
> >    qemu-system-aarch64: unknown type 'kvm-arm-gicv3'
> >
> > That patch did remove a test for TARGET_AARCH64, which is fine because
> > it has been a long time since we supported KVM for AArch32.
> >
> > Fixes: 39a8c3941e ("hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM / WHPX")
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >   hw/intc/meson.build | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> > index a1401cb521..faf63a0145 100644
> > --- a/hw/intc/meson.build
> > +++ b/hw/intc/meson.build
> > @@ -48,7 +48,7 @@ specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.c'))
> >   specific_ss.add(when: ['CONFIG_WHPX', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_whpx.c'))
> >   specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_hvf.c'))
> >   stub_ss.add(files('arm_gicv3_hvf_stub.c'))
> > -specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'CONFIG_ARM_GICV3'], if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
> > +specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
> >   arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'))
> >   specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
> >   specific_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
>
> Alternately, we need to adjust
>
> config ARM_GIC
>      bool
>      select ARM_GICV3 if TCG
>      select ARM_GIC_KVM if KVM
>      select MSI_NONBROKEN
>
> Though I'm not sure how ARM_GICV3 + WHPX would ever get selected?
>
> Alternately, given the very tight connection between all GIC revisions and the cpu, how
> does it make sense for any version of GIC to be non-selected?  Just remove all the GIC
> configury and include it with just TARGET_AARCH64 (not vs TARGET_ARM, but vs any other
> valid virtualization host).

I think the rationale behind the kconfig handling here is that for a
KVM-only build we would prefer not to compile in all the emulated GICv3
code (only the base class and the KVM subclass), so that in that
more security-sensitive configuration a user/distro/etc can be
confident that all that emulation code is not in the binary at all.

thanks
-- PMM

