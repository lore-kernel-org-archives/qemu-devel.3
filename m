Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71767C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3yOf-0007RQ-E7; Tue, 08 Sep 2026 12:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3yOe-0007OA-2r
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:10:08 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3yOa-0003Gn-UK
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:10:07 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8630c1503f2so39143047b3.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 09:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788883803; cv=none;
 d=google.com; s=arc-20260327;
 b=Xco5o8XsIbQ7GV+D2zyFJ358yDjmuQel4p572WsfIdzwaD1DYqtE+fcH2fMPZSsXIw
 w9nHf3nuIRjtVVm4dsrF8CYw6AR+GuBvF1Xmer6BFv7kwY0ay+vgO991/5OmrN3sKPBh
 v+Kz3Xwr0KzfATD5NZGtmmOn2Qp4IErI6zi88iuGx8hOtpMh4ko1N2a6LmPo19q90Xs1
 7NyxZZZm4g2e0JQAadrt+ueL86S6+kYHE+AVHMS67adDB1K8wH65FdKlMUC6WhS/PMIr
 kW6H5MwenauIr4e08XhUju5wZrnd6m1HA256vyD7KEDk5BYm+jILbMEcz7CkWBTVKiXd
 T4rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vAEuw08maigOcy72eNyfJe9xbcSK+2Att5GuaQphA+c=;
 fh=CKGv7PpI7GuseLo3IyfferWYLuL7PC/ovF0PN+PD6ds=;
 b=hfdj9KF5CqU7D9cYx3m/xClwFdKeLPMpjS0+QHJQmkcnTsxoTi77AmsGgCA8S3onM4
 pa7ZOY4O5C62a42wdfHWvyMvH8neqqh4KEzbWNNUBtG/Xii3yMxNUsjjAYMhQ1jMClOU
 k6QDJigDmjPlF27C+zTKjN9AFTIHnP2bICB7jJuM9vkxeABHg9iBVWS0Ls6gBU938qbz
 2zkuR6UYzPOn/d6xUMD+rPn9NZIYIURX62hjp4NVe0sr6GDam/ZJKPcEllToj2Q8UPsD
 zyqZbSxOcMMOMCwPtvAO3Djn8rtxgQAc7vr68kqiyu64ZQvTbh3Eda3ftumEU4RDhNWB
 1nsg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788883803; x=1789488603; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vAEuw08maigOcy72eNyfJe9xbcSK+2Att5GuaQphA+c=;
 b=T7/zERxy5oBE4iE8xlUpY3qx8zWek/4l1rk3/x8zO/qcpbNJik0Bk/wLqzxNZ6J5Fm
 vCD8E9tCg5o8UhTixHpLkfxFgFtBLqYi6kso4hcBtMzDcWBtUO7i0iVq8PS9zyUGTDaM
 QAwfbnFX2Y6rJrECTlRMwxgw/h2qb7Po7NkwBLByygyiPlPdRWOVxkhbm7rxljZbhSqm
 sRXryUh6WIaymb0hXhWRIhMpUK/fajzIhoeZAVrnIj9SoU3/UDT36391VRm2oY69QV5s
 +/1JdfcpCX+HPPQ9xSBG6acb8v6KYycOoXZrp59dGMt7P5U8TF1zjL8NgXlYz4Ulp4xs
 zbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788883803; x=1789488603;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vAEuw08maigOcy72eNyfJe9xbcSK+2Att5GuaQphA+c=;
 b=Ij6XS9HREHvSV+ot3KHZzaG45Dl7FV88sIZ+czeF97T2HOKvuDVSU9hF9DmT93GpFz
 DLpckIs67i4juHSZZNboOiGPh/Hb5fNt0PC6HSPAty1G2KFBxknj6wfbIFpUgZkCe+vT
 5Mu1z40tz9RJjxNHUjPDZKvjpCOeih4a2jsk9+NbCTiid4rpp0C7vZYXzRCO4+TVyjXd
 wF4zQf1UAeybuFUotkfyk6t8D2O0Aj25q7ZcITe5sHQMUpjFduSQnhry8LzG91xSXsK7
 3rfxEoYdBpH6/c1XyXTePuSYIicqQagLlQ1IAqzMQ4eF+VjBbt8q1r70m488WO0J45nF
 wU2w==
X-Gm-Message-State: AFuF++kWOcqEC0+EmWKKhX9zuWkow6eNhFZ37o8cSz+pfLKT/1EHWcSh
 fadsGIKuZ0IkOViQ6U/F99vGCrutlghUTsV9iI9lKGowI269hqkhwUIMKe9D2wAkrQ4kcYUStP7
 AAnbxPxUlMtczzOhNupY+erMN/ZxSSvgbxLB9+JPePA==
X-Gm-Gg: AYBFou0/buHa02KKYRZZXVLAgxjiG1/1aw3XJOVlE2yUYfLL++SzoLcy50QHPTZdXtw
 499LJ8EiexN/rm1ywhQs9+1gmleiOerCGI76d6fcicKc8juZmsxF62i2FB26he6DwBVBNHaXcv4
 nI0dtcs11aUXr0ICNWSiOiYJbxVMlNnNFmZLE5xprp7DNCer3hkUPJ39QJSX1Ckkw8GTFSSvA0d
 xLegq0iQdvow8f/hxhUJ3czJ8Q1TOVwCoscrKqXVikiS7pOYj5ton8hqjAtul8P/bpHJFKw8W6Q
 LPar/K8rt0cMTp3M6t1QgO+OYGNB04rVMrwklOHalLf88yR4vHp+k0RNaLLmC2E4jurfTK5qvX4
 1igFvmjAprhVabsTpKfjapTh47/fo
X-Received: by 2002:a05:690c:e1d8:20b0:87d:b776:c659 with SMTP id
 00721157ae682-87db776c69cmr15832277b3.11.1788883803340; Tue, 08 Sep 2026
 09:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-2-philmd@oss.qualcomm.com>
In-Reply-To: <20260902152044.31291-2-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 17:09:51 +0100
X-Gm-Features: AcwNN1XCnvRaYc8V1KAeF9JjDhyphbZh4b-jEOM8h43oC1OOMB17y_un4hbb4bU
Message-ID: <CAFEAcA-w24c71SHh1Sr7JkO5RTVK7THH8GP_ixVvnWiBXWQMdg@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] target/arm: Call arm*_cpu_do_interrupt directly
 instead of via TCGCPUOps
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-riscv@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Wed, 2 Sept 2026 at 16:20, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> The TCGCPUOps.do_interrupt handler is a target-specific
> callback installed for use by target-agnostic TCG core methods.
> Target-specific code should not dispatch through this indirection;
> call the ARM implementation directly instead.
>
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  target/arm/cpu-irq.c     | 2 +-
>  target/arm/tcg/cpu-v7m.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/cpu-irq.c b/target/arm/cpu-irq.c
> index 883e8a176c3..e8a6520e5ca 100644
> --- a/target/arm/cpu-irq.c
> +++ b/target/arm/cpu-irq.c
> @@ -270,7 +270,7 @@ bool arm_cpu_exec_interrupt(CPUState *cs, int interru=
pt_request)
>   found:
>      cs->exception_index =3D excp_idx;
>      env->exception.target_el =3D target_el;
> -    cs->cc->tcg_ops->do_interrupt(cs);
> +    arm_cpu_do_interrupt(cs);
>      return true;
>  }
>  #endif /* CONFIG_TCG */
> diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
> index 48b31d5eac8..502998dbd1c 100644
> --- a/target/arm/tcg/cpu-v7m.c
> +++ b/target/arm/tcg/cpu-v7m.c
> @@ -34,7 +34,7 @@ static bool arm_v7m_cpu_exec_interrupt(CPUState *cs, in=
t interrupt_request)
>      if (interrupt_request & CPU_INTERRUPT_HARD
>          && (armv7m_nvic_can_take_pending_exception(env->nvic))) {
>          cs->exception_index =3D EXCP_IRQ;
> -        cs->cc->tcg_ops->do_interrupt(cs);
> +        arm_v7m_cpu_do_interrupt(cs);
>          ret =3D true;
>      }

This works because we have separate cpu_exec_interrupt
methods for M-profile and A/R-profile, so we can drop the
indirection. If we had anywhere where we were trying to
do "call the appropriate do_interrupt function" from
code that's agnostic to M vs A/R this wouldn't work, but
happily we don't.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

