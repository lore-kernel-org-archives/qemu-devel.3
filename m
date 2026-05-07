Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C89CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 14:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKzJZ-0004YJ-2h; Thu, 07 May 2026 10:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wKzJD-0004Th-LK
 for qemu-devel@nongnu.org; Thu, 07 May 2026 10:02:35 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wKzJB-0007ga-Sk
 for qemu-devel@nongnu.org; Thu, 07 May 2026 10:02:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso8048245e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 07:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778162550; cv=none;
 d=google.com; s=arc-20240605;
 b=T4gQlN9OLe8M39OgjzBaMBNMuZ7wYTfLZwN+MKhhjGRcfvfvYBA0OzVX7Sc6EEpt3c
 SknOQWcce8n0hqXhps3eD6BCFQzJ8TsojRO16fckNb5OmbPowIjpUqDtE/o++ajgBjvQ
 zwItEHno52wlYOq6shIM7ZlrFdyOnCjtz7fs7jn9ZZFoXGjAQM0LivJeNi+RsNwjn7eE
 3WKXgBWMDkQpfv+w93Z5quus6fMHs92hAjBG0bXgOT96BGdwfQOBZlwVlJttwKIVlg45
 lZkPg8TCo6Fiq/9Mk8+ju7Kbfxlk1guBiSwIStVyG+jyGAVRgQ3ZajC6nvLuKtG0TiKa
 zfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kcYoS7iDnWCSuGS9NNa2Nr9l+Es5VwNe8YSURL9XLdk=;
 fh=8XBdEAFyXQGEtPPft7I0ewrEsdzPuDqX8rbOTd4SFB8=;
 b=Sp36kLNkFu01hR5KQBTPIU9h1nAiq5DPmmQOjVMIfwXmVKnyB+bZh01VPvrlwNyOLR
 OCCE5gFm7REyan/3ysYnzOT8LBDvRPNoch4wj5vnOE7wDIwy20qdRUejVwkULs9goDFI
 158LiZhr2W61WWYmQ92f9akuxmy5ofDH7616eYGDYBHZ1pfYYBJDWFgF+a6Rh/Y/Kfqm
 KH76EgH4xBokcSB0ttNE8XATyO1HGQACBwcs5EmNvDQMehuuiD8/v/CAekRIUyMy1f9n
 w41ADgEQAx5Vzh6NbSL6d1ZSU1cmNvhA9IYWHNhIo+cZnOvrCaQtdLLR7LwRqMGYFzfx
 Am/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778162550; x=1778767350; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcYoS7iDnWCSuGS9NNa2Nr9l+Es5VwNe8YSURL9XLdk=;
 b=b6wFWo3JCIVvmiY5DkIbOIUegC76e5cCREyVZiEQOJ6ZMRg79KxNhWrIUWIVLPPNGC
 zx2EypUNKVADKX3/YKF1QG9jQX0ShCfwfWsXLWs0b+JGSCSd1D5i9e5RgI/4Wtdm0/XH
 0OvP8lFQGjnNHr/u/ypdH6kaKOTAz56iEkK6MC3LuyVq/HHQBea0M3oM3p/llL+cLe6I
 /Eqe3iHFO7epqAmwUxRnt2RRJwZqE071RIPuy/4YM/xUhA4hdlXJeBOK3BlUgm2ecdMi
 WVlyeIXJgH3aoKUu9XNhTIV95hI+VBXQkQvgd+TwWnsBoVX701Trcu24GbXB18rqYfAk
 CNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778162550; x=1778767350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kcYoS7iDnWCSuGS9NNa2Nr9l+Es5VwNe8YSURL9XLdk=;
 b=geQZFyy6q8v4IVwvtikfIgWRPPd1C/r2mCiKpPmRiqJ3QpvEqld4k7vaV56AnYJQAj
 Nj07VPnPqMqyhv2jAv2dzLYM3LTNKNyFAp1yXpJh0GTEyWOj1AVluO8hw/LEov6cFOty
 9veK3JdICFeK4VsGsyeBKKYlMjP5bzwOn4PzYuTx9sgH91wJmBgAfwxrAbGj+zx39DM/
 hyIRYgqoHHm0i1oAtvS9omPVnRCTd389Nd9TE0wSgRCPOJ/Hw4D8ElIjGIo2nQJG1WX8
 aPkIXJvW5BuI4Tl3cnHOis3mOW/mc9TQHYwllU7L9UYD2ep4WzbcQiDBtjaYtMgQsqzc
 eeHw==
X-Gm-Message-State: AOJu0YxfZDxv8xDeC4uqfraIXRjm8y67PwTv8Eb1j/qhLJx68JS1uOsj
 VgNOYF6n5YPFaJOFlwNd8LmtJPCF6C7Kpqbr8d2kKMmJa0UPBmrzxW8zm2ntLPdeD+x/1STbVn2
 83VsJTXzKY7c3riK2V2gq7AS83vxaUnKWVWZ6QQepNA==
X-Gm-Gg: AeBDiestwDPsZOEY8WUGd4EE16WDjFGsxU7VoCoYHVSA/9BKVdA402OCJf+bIq0ZRfw
 YUxSknxmankX4AovskKbcto5WQpbnozpcXIuHPxDU+REwJB9PV1k4wTzKJfKgXN6PCAegF9zbJ9
 IaktKPOHNk5dpLt7xS8DSXi5Aw65MRaHVM9nCPSfeH3tFFlc6UQNyDqNxBteXB72MZNn3xUItqh
 Y5SeRY33apV9vtuXQozaCLnQt88fY100Ap2COY5XibyXjWRV1uXGBlXjS3ZMd0B4CZ4seO6WkBW
 3UumF2+wvLbwqsaz5HyNGIcM35NTnYkbgSKrs+yVMhy+uHj8ilFasTjBnXPR
X-Received: by 2002:a05:600c:8485:b0:487:55c:e0c1 with SMTP id
 5b1f17b1804b1-48e51f2f853mr142220085e9.14.1778162549731; Thu, 07 May 2026
 07:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260507135816.71171-1-philmd@linaro.org>
In-Reply-To: <20260507135816.71171-1-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 7 May 2026 17:02:03 +0300
X-Gm-Features: AVHnY4K93owjtKHnushYsimnrxVqYWeMKGAQGtDKMelg5FNJR4ybRvL5pI9ZmuM
Message-ID: <CAAjaMXb2biOk7wZDVAfkb+qJm3_-HJeCdepfAFyr6pJe_sHztg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Build ARM/HVF GICv3 stub once
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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

On Thu, May 7, 2026 at 4:58=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Move arm_gicv3_hvf_stub.c, introduced in commit 48396ad6ce9
> ("hw/intc: arm_gicv3_hvf: save/restore Apple GIC state"), to
> the global stub_ss[] source set which holds stub files being
> built once for all binaries, instead of one time per system
> binary. This prevents symbol clash when trying to build a
> single QEMU system binary:
>
>   clang: error: linker command failed with exit code 1 (use -v to see inv=
ocation)
>   duplicate symbol '_vmstate_gicv3_hvf' in:
>       libqemu-aarch64-softmmu.a.p/hw_intc_arm_gicv3_hvf_stub.c.o
>       libqemu-arm-softmmu.a.p/hw_intc_arm_gicv3_hvf_stub.c.o
>   ld: 1 duplicate symbols
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  hw/intc/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/meson.build b/hw/intc/meson.build
> index c6de2d9d00c..25a4144c83e 100644
> --- a/hw/intc/meson.build
> +++ b/hw/intc/meson.build
> @@ -43,7 +43,7 @@ arm_common_ss.add(when: 'CONFIG_ARM_GICV3', if_true: fi=
les('arm_gicv3_cpuif.c'))
>  specific_ss.add(when: 'CONFIG_ARM_GIC_KVM', if_true: files('arm_gic_kvm.=
c'))
>  specific_ss.add(when: ['CONFIG_WHPX', 'TARGET_AARCH64'], if_true: files(=
'arm_gicv3_whpx.c'))
>  specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_true: files=
('arm_gicv3_hvf.c'))
> -specific_ss.add(when: ['CONFIG_HVF', 'CONFIG_ARM_GICV3'], if_false: file=
s('arm_gicv3_hvf_stub.c'))
> +stub_ss.add(files('arm_gicv3_hvf_stub.c'))
>  specific_ss.add(when: ['CONFIG_ARM_GIC_KVM', 'TARGET_AARCH64'], if_true:=
 files('arm_gicv3_kvm.c', 'arm_gicv3_its_kvm.c'))
>  arm_common_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_nvic.c'=
))
>  specific_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_irqmp.c'))
> --
> 2.53.0
>

