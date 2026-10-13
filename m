Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35861CC6B0E
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfhl-0000ro-D9; Tue, 13 Oct 2026 12:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGfhj-0000r7-Ga
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:50:20 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGfhh-0000Ye-JD
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:50:19 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-885cf67963eso25010387b3.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791910216; cv=none;
 d=google.com; s=arc-20260327;
 b=A/Dbe977N7Kx1ghCtsVUDDVOWoeBLkWOCCIDOMo0G8lIK0e/U2Ga73/jkVTyx7rlSG
 /b5HMW6wwqhMBk+UCrqVBXQ5OZkEMLpl2BZ4zVgZGJcF2tnyhHF1Lre7RM1VbKDQ6H/y
 MVkqPzbUl+U73ycR5vwwejdm7+h42a1BjbqrdbDeOKQe7IWyFtXS6i8vrHNcDXafqsFn
 wGk1SeFdjDYD/e1UhxLCIvarytFcXy/OfiDYtLWdzZuYVNptcuHRml9yzSRRFlCpXr5f
 PW2Ycd1G35Fa8V1XQN1Yah9Q3ZejE0B8jABLuidcwNK2l9jHjy4Goq2SLKbF5HuviGTM
 WrSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PIzUdYY4W2ouyygmVnyaVLbSOVBNraxuMdBlCjFXaJU=;
 fh=STFjNyXLj0lfgNvlZzFLUS1rWfs5JAUbmS2H0sDlju8=;
 b=edVP90i6hB+loZjsatEWHegtP2NiVL79buD+50HaLYfuU2s/BeTapv/lgiXKHyjtt4
 9kN0MMJow9MPucJRjqjFBtFdgGVG5Z5J+nIpmoD4fY40X0fInFeu/ZGJ6A0I0ZK7McPE
 tBIAX81NrKa+j/pcHV18n26ANbYU4aB1JI4tM3mkyJLXDBrVZ8OrYgQJRwM8PlIO3Hds
 6mk6q6LR7PY3i4ngMC4QbBr35g/3Mnm80KnOfvvieibXQMrN6QtYnEUcCpGTHcdUmiIT
 Tw4PQKA0WJUQJXLcDFd0yQjmuKrWxZ0p8IAQROuBHtgoARRS7Yp1WRG7fzm7pB6EBgcZ
 pbmw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791910216; x=1792515016; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PIzUdYY4W2ouyygmVnyaVLbSOVBNraxuMdBlCjFXaJU=;
 b=FpmfOCtAdg0FJ81uss7O2foxLLVb0J4mNt4XtRgF3sjSlqP515l0Vdp0UVQKA6fNs0
 lsw3QjmanS1Y29d+yj8zfMLq5aZqFfvuh+gDf3RRMD2yfCdUHBBPbhnuadWcV5YIEI3D
 YddPw6AYfaoQqBT7sZa6hBr0H0Jpi2QQhykGTWwf/tBVgd+GtEfaW+FVhsyb6cP56yb9
 YGCg+IPht1V15hhrbrbqxyqFEwQ6bZFX1dP0d3glSQVV30QSWeO7IT8SfUqP525+4xhu
 H7s7DoXCUF9IDUG7vtWQLMm6vU9sfJ2Bdj3hbJk9y6/ICNUZv+wCGI50IC3qsnbNYwpY
 cvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791910216; x=1792515016;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PIzUdYY4W2ouyygmVnyaVLbSOVBNraxuMdBlCjFXaJU=;
 b=vNXExr7EbX1jMBJMypBmBW93zuY7Txa5PP+UjoCGZTks0yi96u0CRTRGozHOu6kv9z
 XejzWMHZjb+0E0LtCLG/BnnfgF3tmsGLKJT3YSh3+ds/4pEuadDOjhef97zSJuGmyKGn
 XyPWT0yDL21wgUd3cghiqZtbp9W5yMDSzjVNpGdkzf8HXrykAF9DtxDNYAmVjExyLeWh
 dgUAcE7X+a/sXZiNMTrsuSXiCiWVlXbSqV59dHwhdTW/wBfnSy7+GjP6nRm9rvCrlPmk
 ikMn/t/KkOgCQOfFWWZyz7FCvePfIbW9vV0ZAtfmff/v9LxYpJycepN/cThKp7tN+qWi
 0C8g==
X-Gm-Message-State: AFq9FYLBeuLbvQjMP7644p5REQgdiyADLfwRvIcQXO7iyZHdltxrNxSi
 IuLxabWpiibtVUEo1vHb3nHp7unbV36YxOpjOGoDHgiAwStlz4xqG48zHMZPuScQs173/iOnliG
 Myb6+I8BofiKBK+yhi+m5hfYw/qyweex+OLZh0XAz8w==
X-Gm-Gg: AYBFou3FEre1XwNXkPhTUOVJDCebr0eEyWW5+i9ySwTFgzBgFXWXnfiBXAcrzw8FItj
 rKxCXLtMq//8pqAsLJO6SWCeb0+ulrIHh8mQWjmaj+DknMlhdaeDvahCP4oOPQUFmTeyFiuXywN
 LDrIAaXFRaqcvjX7tb/8eg1mOywCSOGikQrAriTpBmZWEcOI5NSWfTTanDIb6KTDhtpwpZDBtTj
 8HUkWdCd4+Qsbcmu7aNK7V7/qWBRdmwQtGEcNXEx9j4fESGTvyT+y0nuz2z3+9SImBvU9/ZKVSh
 GPKQjdGkoTYtv4VJ7oajsfORlVMBtz+DaSBS9cWnuwKjFu8HslBJ8L+f9I3evJW+qcdX5kcw3If
 tJa+gRSvNYnsZrnGGMIAGHgpsvHpmY1A85AEzJn8=
X-Received: by 2002:a05:690c:4d81:b0:8aa:fbe8:8926 with SMTP id
 00721157ae682-8b07eebd73cmr52433707b3.69.1791910214804; Tue, 13 Oct 2026
 09:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-11-aefe5e76a0e3@linux.microsoft.com>
In-Reply-To: <20261001-mshv_accel_arm64_supp-v6-11-aefe5e76a0e3@linux.microsoft.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Oct 2026 17:50:03 +0100
X-Gm-Features: AclHuK_Io2BTarONqqWtYxaBJWwxe3rnQ5jHfWC3nmKtuvEs7aIE4FfWSMISC1g
Message-ID: <CAFEAcA9xPn2MRjC_d9Gdb=d4-GHmcXPpsLP+WUOgCUhaPbZ2BQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/14] target/arm/mshv: add vCPU run loop
To: Aastha Rawat <aastharawat@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, qemu-arm@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 1 Oct 2026 at 11:52, Aastha Rawat
<aastharawat@linux.microsoft.com> wrote:
>
> From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
>
> Add the main vCPU run loop for MSHV using the MSHV_RUN_VP_IOCTL.
>
> Handle MMIO exits by emulating the instruction using the syndrome
> information from ESR_EL2.
>
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  include/hw/hyperv/hvgdk_mini.h |  44 +++++++++++++++++
>  target/arm/mshv/mshv-all.c     | 107 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 151 insertions(+)
>
> diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
> index 33c9e4f3e0..53dc58813e 100644
> --- a/include/hw/hyperv/hvgdk_mini.h
> +++ b/include/hw/hyperv/hvgdk_mini.h
> @@ -896,6 +896,50 @@ struct hv_x64_memory_intercept_message {
>      uint8_t instruction_bytes[16];
>  } QEMU_PACKED;
>
> +union hv_arm64_vp_execution_state {
> +    uint16_t as_uint16;
> +    struct {
> +        uint16_t cpl:2;
> +        uint16_t debug_active:1;
> +        uint16_t interruption_pending:1;
> +        uint16_t vtl:4;
> +        uint16_t virtualization_fault_active:1;
> +        uint16_t reserved:7;
> +    };
> +};

This is an mshv specific file, but I would still recommend against
bitfields-in-a-union as generally bad style.

thanks
-- PMM

