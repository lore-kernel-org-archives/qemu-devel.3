Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9361DC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 17:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDvh-0006Wc-Lv; Tue, 21 Jul 2026 13:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wmDvY-0006Pz-9a
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:06:44 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wmDvW-0007A7-J9
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 13:06:43 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7dbcb505578so78904547b3.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784653601; cv=none;
 d=google.com; s=arc-20260327;
 b=R2Imf7GaRGkUbVozBqRiuWS6LReIra8Eq7qp5h4KBgwpwdV12wEhP59YE9R/CANwgd
 akvuCXUyOCRCQTKRBY0iJcUvbxzZRgvk9OiuIdvUm6TNofnt1DyWpH7uxy6iCdWz0xZR
 KE3h+d25TBYge6hnBGHhwpxUjPa5Pw9S/zkEtis2wB0V0PeB3BythukO2355ciJKo9SY
 tCyQrkhDj9+xtKQp/SJo3R66+XByHURJtpMGbQWKTsNWD5ZxdQNXiy600PbRpONZ/4es
 UCwkk5Vm1/wlEVrC7h0X65bkTpfjPJPJ9yArGtllJJrgwrYr5T7tdtSjxX/YxoifSVVm
 2fog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XtkjHDGP4VqW6uAKM9RtzqKztCoLcgR5T3hFp5AdI0g=;
 fh=SqoUJT2B5IxldjjUFCOeJt1lQj0U4YA9iTmsEfj5fag=;
 b=jCtzRLMmAD7oDisYeIMmmkZFw07/o8sFJcStxpgDP0eHlGw0/ioWxa10aP5EdrM20M
 ADeF1P1TnWErGTGNeKoFlStat2lh+vhIWnCyiU19qufXemrjgf2nuBxXt+HLiSyytzeW
 IdTIrp+zYciF6zQeiBBuH3G3hSBetNcjG3gEgW6R+agL5OkdINC6bzD6l1wuz1r/dWZn
 FRotls1lPsq2VLz+rrJJBQgAMPW5VMBqfN/nWdw314qxYO8Vgei2ypw7HlfnmdN1wxVT
 r4qmbqM5oNJbcSSt95AWBRkneCUaEhrUOnZVEsmsiVa77EALbTjkV2M5h9BmNohFqose
 VXSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784653601; x=1785258401; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XtkjHDGP4VqW6uAKM9RtzqKztCoLcgR5T3hFp5AdI0g=;
 b=ICPsuDLTlrMbIFhGUtEbFsadhvxEauc3yT7YU+8bJNda3gEaYRi4H9m7JjGjlj0yRm
 pIdvKhO4LH4gjHfz6HbpmEsCrtAGzrK+bJHsxPMe+g7iGuv+FHhLeuz2crURJiwwH1zW
 wPIwSzJNHhEASPUQUPecVQ9GrPLMMrxkl6iQQG7Z+6vOIdRVMlCjiZuaLrVlLXuhOfUI
 oIRWsmspmbph+pys7vz7U4SA+mnGcpBi0TFoHNTqaRtOaoxVogB3GOk7NjAeEd1iNbQc
 fp8Dj3RZPZTkIQ3VZyMJmA7wRKhKqQKBTHBo/V38kkkg8yMfuIriTBMhrOyfJyxe6GsW
 H3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784653601; x=1785258401;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XtkjHDGP4VqW6uAKM9RtzqKztCoLcgR5T3hFp5AdI0g=;
 b=Lh2askDyyJNXq5m3MRoGIUO41yM1FfK96uMSvfZUGEyn50vDAwPpK2/p3njUUdukO/
 7jzTm16sD6ETDeB+WK+c4aeUZQaelGrhf2OfsP+vfuBfb4rdTolE8p0lhPQ1dD2s0jrJ
 xumMyFa1E3g1+Pu2F7LD6y4FBbP4xgmx5Rpa0zWWvSYflEER3a6B0I/nZ/LO3SAkscjI
 4ybK/+DTlPHOvNbx7dlrAIX/Vl0E9WRl1F5a+nKhr+m4LhCZrjEm0Z61KxxVi1baPhc9
 m7QFPkEPbcNccYgG4GESrOqooz6ULCYEQfxkEbaiJxPtqvo+i3KezpZlySUvpyNtq9EP
 DUhw==
X-Gm-Message-State: AOJu0YxO+q58GOJ8bzViQelkraiQxrBoBK6gpXUbzFUoK0H9gBQ+WVcJ
 0Ere3r4harhlpu+NYKUENr9KimBp7HgMUaeUc/OWHOQA0+beOJooA0NV+FbqGhxycbXiBpazlrh
 N29axWguOvvRgMI5/GNCjlx4oHHE579GegUVBUzYgIplH+QnLM8Am5xw=
X-Gm-Gg: AR+sD11RwidKMaL8YBGSxw39lwT3OptpVKZ/4emD+hcN/uCnWJV5+M9TRxOYDEiNggL
 7lNlH+dVeB8yqDn+lfhVFGHBDpkyZJhiR+cnFrU0DNgHC50aMJv2imwh7+XSXxytgnRVg1XtBl+
 /AvgjSN8wDdzpUK0DjbbzJKffQetQSn/HVO729wBEOwDYDuRVCn6Ub9OWHgJ+kGshIHVU2qBfov
 l17sfobyDyGgAEt/4yMv2kKx+jWq3YewjdA8BxL8sE10I8SRDZGoQsIohh+O1qGx9mypY3BDht6
 HqnJd7MsfkoQnSj7U1Df6pWVIy/dr9U+DMxizPn4Z0aqPw==
X-Received: by 2002:a05:690c:60c5:b0:81e:6a10:f904 with SMTP id
 00721157ae682-81ef25d5b74mr57867207b3.45.1784653601138; Tue, 21 Jul 2026
 10:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
 <20260610161202.2235298-21-peter.maydell@linaro.org>
In-Reply-To: <20260610161202.2235298-21-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2026 18:06:29 +0100
X-Gm-Features: AUfX_mxPOmmyajARpzaberaxHNAc4f02NOUYibfSzKYe3S7qbDBrBgkbebbyNcs
Message-ID: <CAFEAcA99VL1B57MsZ=WRjEw-vyPcxh_bw0Xj2DWQTydihWMyNg@mail.gmail.com>
Subject: Re: [PULL 20/71] target/arm: teach arm_cpu_has_work about halting
 reasons
To: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

cc: to qemu-stable as a late "could we backport this (plus the
commit fixing a bug in this)" request...

On Wed, 10 Jun 2026 at 17:12, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> With the advent of WFE and WFI we need to pay closer attention to the
> reason why the vCPU may be sleeping to figure out if we should wake
> it up.
>
> Create env->halt_reason to track this and then re-order the tests so
> we:
>
>   - ignore everything is the vCPU is powered off
>   - wake up if the event_register is set and we were in a WFE
>   - otherwise any IRQ event does wake the vCPU up.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-id: 20260529082948.363931-3-alex.bennee@linaro.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I didn't realize at the time, but this is actually fixing a bug,
which was just reported via the qemu-discuss list:
https://lists.gnu.org/archive/html/qemu-discuss/2026-07/msg00000.html

For M-profile, we already added SEV/WFE support, and that's in the
11.0 release, but arm_cpu_has_work() incorrectly checks for the
event register before it checks whether the CPU is powered off.
This only affects M-profile machines with multiple CPUs, and
the effect is that a SEV on core 0 incorrectly starts core 1
when it's powered down.

Could we backport this change (commit 6fd2fcdc61b70) plus the
bugfix followup (commit c2804566f654 "target/arm: do not clear
halting reason in has_work helper") to the 11.0.x branch, please?

(Earlier branches don't have SEV wake anything up so don't need
a backport.)

thanks
-- PMM

