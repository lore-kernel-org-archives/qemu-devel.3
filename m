Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134E2C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl2Et-0000Lv-9H; Thu, 20 Feb 2025 03:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2Er-0000HG-IB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:48:57 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2Ep-0004QE-7z
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:48:57 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4398ec2abc2so5648185e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 00:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740041333; x=1740646133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KMdT22wl6/m6S0cbqq4n3jiUIKMnwPR+UXhM2b4J4YA=;
 b=lnDT05oIyWIxqJA2l/RpVZ4rX8kfEzlomhVZzya1MKbqfK8WsoL3GPOz9GfybBGP12
 42njd2Mw4oga3JVVjzjLfyZ7yKbdGgpc84HRY5jgyOo1CPxLX0ZxXR6BHsq7SX91xctG
 aMbx51UqAkHzPPrh3fmemkDYRBGXBL5DpLNjdw5btsEyVjU45lBlg/WzFbcQnxe478dX
 L+3dXzARUjIzN8f0TXllR1wmfiIjShRIDDn5hcpYmPu5jzgRiAz+UEv9fmfvZOxNS6Lp
 88sHZnpB0g3qfW6JuCcBlJqL5wdzLMeV4s7omAcZz+V+PFqR2IyhCKw8EOdt9ZiOvY1w
 F7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740041333; x=1740646133;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KMdT22wl6/m6S0cbqq4n3jiUIKMnwPR+UXhM2b4J4YA=;
 b=mubwca6OdTmYWkyoGcMX1411R5l02iuSIGCKFxqQXTtz/TBCQ0jKYotblZ7H0sqld9
 9TdBpKj1ENjFg5MV4AlH3C4aUxiWkI76/YP7AJ3hnKkBt0k8lLqa3imKlYmK4E0U81nb
 uu/RHP4+hgPp8J80tss7s1ykcCpN7XAW+Job1RxDuH2T2EXyess0i20zBFZ0UR6W1fbP
 J96iBpqshXyQ/65qojYRONlWD01NxRNUbA282j0+OF+Zuj24qyKej4qcGxreU8CYIAcO
 9Ye2VYxvj5tj45TgfApO7Sd5SgXm3jq4XK+a9T66slemFz/HTmAuw1+cV/41RiswmewR
 UjGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV09nkQ3GMnq2ASL9E303wj3lF0XZ0DPCcppeCTNE/dxzYgy7qGGHl+MNZwnCB5Kpls2brDDDCByCgt@nongnu.org
X-Gm-Message-State: AOJu0YxJwlfbTJ3Fq3tg7VTeuMf2Mm+PPoXy65Xa/cxNduVWRwB9g7Gz
 dP+x6JfmYAyViRaEbe9QJN84cBPxCwIYtkJ/9dI1S+HVOL/tO8obOa6gRBewDXI=
X-Gm-Gg: ASbGncuHfKJQj1awEFVRvmpUZtNBazvfzc64A7lNRhcGvMV+v951KhrEJwcc/f61LF7
 2DC01AstVTnRcvSl86OBsHjpNYU7mMux0/w9TgXBpROqcxUJBVKPGDc7B+tnD577ZiViuNFNMqB
 P27jvoxl+vx54Cj6D/Q4Mri/W9Lehlsui9KNTnCtme/78D6zLmEsYN4pkG4kE6ZvORrDXSqqETE
 fV4NGq6c3/5ohrUfmN0CgiRvmMZw55ez+bW0VfkV7/IspTTjCK4psGFyGiI3DJXaiySj6yLdYei
 MknTwj5E3HRBFxCzSUTsYqjfhfCgnf2TYqRd4qFM5ZB8qahFCHWXz4Ws01A=
X-Google-Smtp-Source: AGHT+IH9lFyRW0nYJVXCCrxMW4LSEsYVII3Dc5ktyIb1r+PoWuCUyTLlv7XBKC+VrluApZwXhlsWIw==
X-Received: by 2002:a05:600c:4590:b0:439:6101:5440 with SMTP id
 5b1f17b1804b1-43999d8aa16mr63232555e9.8.1740041333300; 
 Thu, 20 Feb 2025 00:48:53 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398c9deb59sm90981635e9.32.2025.02.20.00.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 00:48:52 -0800 (PST)
Message-ID: <d71e392b-d828-42ca-8f9a-0661701653d5@linaro.org>
Date: Thu, 20 Feb 2025 09:48:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] fpu: Remove remaining target ifdefs and build only
 once
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>
References: <20250217125055.160887-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250217125055.160887-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 17/2/25 13:50, Peter Maydell wrote:
> The work I needed to do to make various softfloat emulation behaviours
> runtime-selectable for Arm FEAT_AFP has left the fpu code with very
> few remaning target ifdefs. So this series turns the last remaning
> ones into runtime behaviour choices and switches the fpu code into
> "build once" rather than "build per target". The main driver of this
> is that we're going to want to do this for the "multiple targets in
> one binary" work.

Indeed the following 332 symbols are now removed for each target:

     bfloat16_add
     bfloat16_compare
     bfloat16_compare_quiet
     bfloat16_default_nan
     bfloat16_div
     bfloat16_is_quiet_nan
     bfloat16_is_signaling_nan
     bfloat16_max
     bfloat16_maximum_number
     bfloat16_maxnum
     bfloat16_maxnummag
     bfloat16_min
     bfloat16_minimum_number
     bfloat16_minnum
     bfloat16_minnummag
     bfloat16_mul
     bfloat16_muladd
     bfloat16_round_to_int
     bfloat16_scalbn
     bfloat16_silence_nan
     bfloat16_sqrt
     bfloat16_squash_input_denormal
     bfloat16_sub
     bfloat16_to_float32
     bfloat16_to_float64
     bfloat16_to_int16
     bfloat16_to_int16_round_to_zero
     bfloat16_to_int16_scalbn
     bfloat16_to_int32
     bfloat16_to_int32_round_to_zero
     bfloat16_to_int32_scalbn
     bfloat16_to_int64
     bfloat16_to_int64_round_to_zero
     bfloat16_to_int64_scalbn
     bfloat16_to_int8
     bfloat16_to_int8_round_to_zero
     bfloat16_to_int8_scalbn
     bfloat16_to_uint16
     bfloat16_to_uint16_round_to_zero
     bfloat16_to_uint16_scalbn
     bfloat16_to_uint32
     bfloat16_to_uint32_round_to_zero
     bfloat16_to_uint32_scalbn
     bfloat16_to_uint64
     bfloat16_to_uint64_round_to_zero
     bfloat16_to_uint64_scalbn
     bfloat16_to_uint8
     bfloat16_to_uint8_round_to_zero
     bfloat16_to_uint8_scalbn
     float128_add
     float128_compare
     float128_compare_quiet
     float128_default_nan
     float128_div
     float128_is_quiet_nan
     float128_is_signaling_nan
     float128_max
     float128_maximum_number
     float128_maxnum
     float128_maxnummag
     float128_min
     float128_minimum_number
     float128_minnum
     float128_minnummag
     float128_mul
     float128_muladd
     float128_rem
     float128_round_to_int
     float128_scalbn
     float128_silence_nan
     float128_sqrt
     float128_sub
     float128_to_float32
     float128_to_float64
     float128_to_floatx80
     float128_to_int128
     float128_to_int128_round_to_zero
     float128_to_int32
     float128_to_int32_round_to_zero
     float128_to_int64
     float128_to_int64_round_to_zero
     float128_to_uint128
     float128_to_uint128_round_to_zero
     float128_to_uint32
     float128_to_uint32_round_to_zero
     float128_to_uint64
     float128_to_uint64_round_to_zero
     float16_add
     float16_compare
     float16_compare_quiet
     float16_default_nan
     float16_div
     float16_is_quiet_nan
     float16_is_signaling_nan
     float16_max
     float16_maximum_number
     float16_maxnum
     float16_maxnummag
     float16_min
     float16_minimum_number
     float16_minnum
     float16_minnummag
     float16_mul
     float16_muladd
     float16_muladd_scalbn
     float16_round_to_int
     float16_scalbn
     float16_silence_nan
     float16_sqrt
     float16_squash_input_denormal
     float16_sub
     float16_to_float32
     float16_to_float64
     float16_to_int16
     float16_to_int16_round_to_zero
     float16_to_int16_scalbn
     float16_to_int32
     float16_to_int32_round_to_zero
     float16_to_int32_scalbn
     float16_to_int64
     float16_to_int64_round_to_zero
     float16_to_int64_scalbn
     float16_to_int8
     float16_to_int8_scalbn
     float16_to_uint16
     float16_to_uint16_round_to_zero
     float16_to_uint16_scalbn
     float16_to_uint32
     float16_to_uint32_round_to_zero
     float16_to_uint32_scalbn
     float16_to_uint64
     float16_to_uint64_round_to_zero
     float16_to_uint64_scalbn
     float16_to_uint8
     float16_to_uint8_scalbn
     float32_add
     float32_compare
     float32_compare_quiet
     float32_default_nan
     float32_div
     float32_exp2
     float32_is_quiet_nan
     float32_is_signaling_nan
     float32_log2
     float32_max
     float32_maximum_number
     float32_maxnum
     float32_maxnummag
     float32_min
     float32_minimum_number
     float32_minnum
     float32_minnummag
     float32_mul
     float32_muladd
     float32_muladd_scalbn
     float32_rem
     float32_round_to_int
     float32_scalbn
     float32_silence_nan
     float32_sqrt
     float32_squash_input_denormal
     float32_sub
     float32_to_bfloat16
     float32_to_float128
     float32_to_float16
     float32_to_float64
     float32_to_floatx80
     float32_to_int16
     float32_to_int16_round_to_zero
     float32_to_int16_scalbn
     float32_to_int32
     float32_to_int32_round_to_zero
     float32_to_int32_scalbn
     float32_to_int64
     float32_to_int64_round_to_zero
     float32_to_int64_scalbn
     float32_to_uint16
     float32_to_uint16_round_to_zero
     float32_to_uint16_scalbn
     float32_to_uint32
     float32_to_uint32_round_to_zero
     float32_to_uint32_scalbn
     float32_to_uint64
     float32_to_uint64_round_to_zero
     float32_to_uint64_scalbn
     float64_add
     float64_compare
     float64_compare_quiet
     float64_default_nan
     float64_div
     float64_is_quiet_nan
     float64_is_signaling_nan
     float64_log2
     float64_max
     float64_maximum_number
     float64_maxnum
     float64_maxnummag
     float64_min
     float64_minimum_number
     float64_minnum
     float64_minnummag
     float64_mul
     float64_muladd
     float64_muladd_scalbn
     float64_rem
     float64_round_to_int
     float64_scalbn
     float64_silence_nan
     float64_sqrt
     float64_squash_input_denormal
     float64_sub
     float64_to_bfloat16
     float64_to_float128
     float64_to_float16
     float64_to_float32
     float64_to_floatx80
     float64_to_int16
     float64_to_int16_round_to_zero
     float64_to_int16_scalbn
     float64_to_int32
     float64_to_int32_modulo
     float64_to_int32_round_to_zero
     float64_to_int32_scalbn
     float64_to_int64
     float64_to_int64_modulo
     float64_to_int64_round_to_zero
     float64_to_int64_scalbn
     float64_to_uint16
     float64_to_uint16_round_to_zero
     float64_to_uint16_scalbn
     float64_to_uint32
     float64_to_uint32_round_to_zero
     float64_to_uint32_scalbn
     float64_to_uint64
     float64_to_uint64_round_to_zero
     float64_to_uint64_scalbn
     float64r32_add
     float64r32_div
     float64r32_mul
     float64r32_muladd
     float64r32_sqrt
     float64r32_sub
     floatx80_add
     floatx80_compare
     floatx80_compare_quiet
     floatx80_default_nan
     floatx80_div
     floatx80_infinity
     floatx80_is_quiet_nan
     floatx80_is_signaling_nan
     floatx80_mod
     floatx80_modrem
     floatx80_mul
     floatx80_rem
     floatx80_round
     floatx80_round_to_int
     floatx80_scalbn
     floatx80_silence_nan
     floatx80_sqrt
     floatx80_sub
     floatx80_to_float128
     floatx80_to_float32
     floatx80_to_float64
     floatx80_to_int32
     floatx80_to_int32_round_to_zero
     floatx80_to_int64
     floatx80_to_int64_round_to_zero
     int128_to_float128
     int16_to_bfloat16
     int16_to_bfloat16_scalbn
     int16_to_float16
     int16_to_float16_scalbn
     int16_to_float32
     int16_to_float32_scalbn
     int16_to_float64
     int16_to_float64_scalbn
     int32_to_bfloat16
     int32_to_bfloat16_scalbn
     int32_to_float128
     int32_to_float16
     int32_to_float16_scalbn
     int32_to_float32
     int32_to_float32_scalbn
     int32_to_float64
     int32_to_float64_scalbn
     int32_to_floatx80
     int64_to_bfloat16
     int64_to_bfloat16_scalbn
     int64_to_float128
     int64_to_float16
     int64_to_float16_scalbn
     int64_to_float32
     int64_to_float32_scalbn
     int64_to_float64
     int64_to_float64_scalbn
     int64_to_floatx80
     int8_to_bfloat16
     int8_to_bfloat16_scalbn
     int8_to_float16
     normalizeFloatx80Subnormal
     normalizeRoundAndPackFloatx80
     propagateFloatx80NaN
     roundAndPackFloatx80
     uint128_to_float128
     uint16_to_bfloat16
     uint16_to_bfloat16_scalbn
     uint16_to_float16
     uint16_to_float16_scalbn
     uint16_to_float32
     uint16_to_float32_scalbn
     uint16_to_float64
     uint16_to_float64_scalbn
     uint32_to_bfloat16
     uint32_to_bfloat16_scalbn
     uint32_to_float16
     uint32_to_float16_scalbn
     uint32_to_float32
     uint32_to_float32_scalbn
     uint32_to_float64
     uint32_to_float64_scalbn
     uint64_to_bfloat16
     uint64_to_bfloat16_scalbn
     uint64_to_float128
     uint64_to_float16
     uint64_to_float16_scalbn
     uint64_to_float32
     uint64_to_float32_scalbn
     uint64_to_float64
     uint64_to_float64_scalbn
     uint8_to_bfloat16
     uint8_to_bfloat16_scalbn
     uint8_to_float16

and my single binary duplicate symbols list drastically reduced:

-ld: 1759 duplicate symbols
+ld: 1427 duplicate symbols

Thank you a lot for this huge help! :)

FWIW:
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


