Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CC5CD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWcHP-0006Px-Va; Mon, 08 Jun 2026 11:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcHO-0006Pn-C7
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:52:46 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWcHM-0001rr-54
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:52:46 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66077e888b2so4680956d50.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 08:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780933962; cv=none;
 d=google.com; s=arc-20240605;
 b=cE3I+PlJS5DXbCws7YLC7vjtvgN3wVsx0mPdCrVNtGutH0xKC7HlfITlARACM0PX4i
 xYjzAi3xFuBnLlVVmLfpTi/9P/wvbIwQcMbbXHWiOWsN8ChUEWyhOajk40Dg6ZZXCaYB
 41LWHBuLaT7OUmmwJvw6jeZKZ3ZHFPrG376pfwED4S+wIMIx89oAZduh/Gh5p9HFKTY9
 rT2ObguKnc+Mw2Io83TvT++fnFzv2M/w1XOnX4BT67paCeVXQIzOcL3PolXOPJXfM+iS
 Rup2N5WSKUNwXyiqQLuJzblsm9noqVOkpECOyW1z3WRJIEJhprpFLr8N++4RS6aVtvy4
 ijaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2A/ODXUqcCzumdmhUofAw2RO0jI4B/EtNgbML1DrBSw=;
 fh=0rHSq3ueJB9m76HtRwk2RJEWDps4JZB4/EJOcuFp00U=;
 b=SmgSPbDHujIv4/ZLXQi005L+nI63psv6saNDOBybh4rWxL2wXuyTZgKG3wPXx3sz0x
 AZHkDJojAN0DK5yyXqaAeXyBfNxDSKigG7wu/xdYUsrrnjPZ6cJj1nnCH4Nd3pNg/s84
 8ffpuHfl1iiKatcWTj6EHOsVBf9FZ8tEIX3/ljddog7MBVggcG31mKFJ0FX5LXQKChuY
 YvNaml3yjYpWtdZ2ITwbP8YOfMU0HmbA3z1LXE1rGc4VMTE51secujIBxaVhWu7orEKn
 Stv7saLNNjBw3d0iXuuRNVRtgU+iFUIxuQsDhZ1drSPKxk1HSl8+1meHwk8V5WP5lSKH
 2vBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780933962; x=1781538762; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2A/ODXUqcCzumdmhUofAw2RO0jI4B/EtNgbML1DrBSw=;
 b=GowoZcjfmta3V8ilSXTNSRG1n/CYLArMRfOPnPUNBYHmxHZ4PzBZrIBy+5IXBf3ZfZ
 GQQeJptuqj4NfhQL8DuV8NL2Yh7Bg0NlB92cI33FFmQ1m6RpS/viYGLHrrlM22UxBkt2
 +jW4zsHE/fgwhAeyd00dYz7ZVHEaoh/ZryYR5BoYSXKk9LRLklGGPNmBr5PFOP6HnGjq
 Xvv5EdorwOsIH+JQs9jegHxKqUf92JXkByGyRQvLOBYyA54VU7W5fKRQtcADUFql4/ce
 qEmRkS6524KycNrRTOq18WTSF4Zs8Y8gltfp+a6bm4Ca+WhJqK+AtoLQ2M3U9WQF9FS8
 ydDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780933962; x=1781538762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2A/ODXUqcCzumdmhUofAw2RO0jI4B/EtNgbML1DrBSw=;
 b=Hxr+W4qLUEdECaUiBMG0mHdI0sFui1MgbMhDAxpmrCy1LWEYueiQJPr2pHi0xTpIeU
 SeWtIE8GvH4UkC4obLz7L9NzpL/W7ItHPRU7I8C5fhukw//DfgOox+LYqPcrB8K7h2Wf
 L5S/Tfm1ZCiw3Y8Y5+mD0qKeSrjrXweUYHZkpT+ughDMDZg1M9KNnRef9CjTzT2l0Xpv
 GbiOt0p4qVV2pUL9NlOPpqE05c62szbOP4i0HRXPSdSX3An4xtI4tRANmRTHoQFHEtHR
 ut6qjadY+pIMAwcPx4cfFZIEvg8yNI8UejF+8UZXpIkkCXCcDsGFMHcOMtxvOocef1fm
 LPIA==
X-Gm-Message-State: AOJu0Yx1FS7PdQfcJZMB5VDLLbo8tvpdjPZv7ah86L843L4NVA8VcDOx
 knXq30hh28l4aCplkQGEfkKJYzh1zBuEGcI/CKu7mWCoz3M9iK5MUdkHYTQyHfXa1iExGrxh94c
 CjIhyrXZ+rOLxdl/zLonbjlg/lSemapguO5pBGv6Vcg==
X-Gm-Gg: Acq92OFyT6UD+ZH3ykJftJRUpmiK+6VN9Qhs7G8u87JtIqd+iQlt9W9F9hAQ8QtKAFC
 G9jhSYlAyMm+Lu3e3YDc9vFQTzHDP9sxtQM4jPjkDaLnjLcNjpZHCorbPtoF7uUnArRYSJtI7Sk
 m/PxG3UehyRsH/oJKuRSwVo8OBPxiaJzkug7Ai4qQYdDPOu6JSXq5wcmUYY4LEGr+LV/g/3TioK
 rDvwXFqivq5OcauZ/YzLC5WHwwPewoMLglvF3S3kqRrKPLc48CYG4Z1zNNZW8njESx6xzga/pE+
 DYeThfmeKdmdUVnGKY4hBFFsf813G4xdp6BGri+0H28YHqmht0ecyf6pUp1lUlPC/ZQqNfBy7WP
 d2gk8Xk7CKmOR
X-Received: by 2002:a05:690e:484c:b0:660:eff6:fe03 with SMTP id
 956f58d0204a3-66106dea10dmr9651452d50.9.1780933961913; Mon, 08 Jun 2026
 08:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260529082948.363931-1-alex.bennee@linaro.org>
 <20260529082948.363931-6-alex.bennee@linaro.org>
In-Reply-To: <20260529082948.363931-6-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 16:52:29 +0100
X-Gm-Features: AVVi8CcfaFhhN8VRcMbz6ELw1ChZd3Iu7P5Ocma_mwVS19e4rwVGcVZwIp4S5Dg
Message-ID: <CAFEAcA-cHPNPbWopCy0jrRZmMnMNp7g+oy_m5OjNFiShQbAhDQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] target/arm: implements SEV/SEVL for all modes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Fri, 29 May 2026 at 09:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Remove the restrictions that make this a M-profile only operation and
> enable the instructions for all Arm profiles.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v2
>   - fix alignment in a32.decode
>   - set bool directly, defend with QEMU_BUILD_BUG_ON
>   - s/instructions/profiles/
>   - share get_event_reg between translate/translate-a64

> diff --git a/target/arm/tcg/a32.decode b/target/arm/tcg/a32.decode
> index f2ca4809495..547aa2b1490 100644
> --- a/target/arm/tcg/a32.decode
> +++ b/target/arm/tcg/a32.decode
> @@ -192,9 +192,8 @@ SMULTT           .... 0001 0110 .... 0000 .... 1110 .=
...      @rd0mn
>        WFE        ---- 0011 0010 0000 1111 ---- 0000 0010
>        WFI        ---- 0011 0010 0000 1111 ---- 0000 0011
>
> -      # TODO: Implement SEV, SEVL; may help SMP performance.
> -      # SEV      ---- 0011 0010 0000 1111 ---- 0000 0100
> -      # SEVL     ---- 0011 0010 0000 1111 ---- 0000 0101
> +      SEV        ---- 0011 0010 0000 1111 ---- 0000 0100
> +      SEVL       ---- 0011 0010 0000 1111 ---- 0000 0101
>
>        ESB        ---- 0011 0010 0000 1111 ---- 0001 0000
>      ]

> diff --git a/target/arm/tcg/t16.decode b/target/arm/tcg/t16.decode
> index 778fbf16275..9a8f89538ac 100644
> --- a/target/arm/tcg/t16.decode
> +++ b/target/arm/tcg/t16.decode
> @@ -228,10 +228,8 @@ REVSH           1011 1010 11 ... ...            @rdm
>      WFE         1011 1111 0010 0000
>      WFI         1011 1111 0011 0000
>
> -    # M-profile SEV is implemented.
> -    # TODO: Implement SEV for other profiles, and SEVL for all profiles;=
 may help SMP performance.
>      SEV         1011 1111 0100 0000
> -    # SEVL      1011 1111 0101 0000
> +    SEVL        1011 1111 0101 0000
>      # The canonical nop has the second nibble as 0000, but the whole of =
the
>      # rest of the space is a reserved hint, behaves as nop.
> diff --git a/target/arm/tcg/t32.decode b/target/arm/tcg/t32.decode
> index 49b8d0037ec..8ae277fe112 100644
> --- a/target/arm/tcg/t32.decode
> +++ b/target/arm/tcg/t32.decode
> @@ -369,10 +369,8 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 =
....      @rdm
>          WFE      1111 0011 1010 1111 1000 0000 0000 0010
>          WFI      1111 0011 1010 1111 1000 0000 0000 0011
>
> -        # M-profile SEV is implemented.
> -        # TODO: Implement SEV for other profiles, and SEVL for all profi=
les; may help SMP performance.
>          SEV      1111 0011 1010 1111 1000 0000 0000 0100
> -        # SEVL   1111 0011 1010 1111 1000 0000 0000 0101
> +        SEVL     1111 0011 1010 1111 1000 0000 0000 0101
>          ESB      1111 0011 1010 1111 1000 0000 0001 0000
>        ]

> diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
> index c744b163453..e1e5539f571 100644
> --- a/target/arm/tcg/translate.c
> +++ b/target/arm/tcg/translate.c
> @@ -3246,17 +3246,20 @@ static bool trans_YIELD(DisasContext *s, arg_YIEL=
D *a)
>  static bool trans_SEV(DisasContext *s, arg_SEV *a)
>  {
>      /*
> -     * Currently SEV is a NOP for non-M-profile and in user-mode emulati=
on.
> -     * For system-mode M-profile, it sets the event register.
> +     * SEV is a NOP for user-mode emulation.
>       */
>  #ifndef CONFIG_USER_ONLY
> -    if (arm_dc_feature(s, ARM_FEATURE_M)) {
> -        gen_helper_sev(tcg_env);
> -    }
> +    gen_helper_sev(tcg_env);
>  #endif

The AArch32 SEV encodings are only SEV for M-profile and for
Armv7A and above -- for v6T2 and earlier they are NOP hints.
We need a feature-check here.

>      return true;
>  }
>
> +static bool trans_SEVL(DisasContext *s, arg_SEV *a)
> +{
> +    gen_event_reg();
> +    return true;

The SEVL encodings only exist for v8A -- they are unallocated
must-NOP hints for M-profile and v7A and earlier. We need a
feature-check here.

> +}
> +
>  static bool trans_WFE(DisasContext *s, arg_WFE *a)

thanks
-- PMM

