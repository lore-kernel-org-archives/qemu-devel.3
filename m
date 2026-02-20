Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B614C54F5F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 06:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtKFA-0000oU-O1; Fri, 20 Feb 2026 01:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vtKF9-0000oM-Ck
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 01:44:03 -0500
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vtKF6-0005MC-VZ
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 01:44:03 -0500
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8954a050c19so21264326d6.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 22:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771569840; x=1772174640; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IeL/h3q0xFKOJbLr/HDReueIN840huWo8F+fzoRQdT4=;
 b=MV0Vd2+GmN9eAlyfuGucFqZABLZDKxh/wsxT+qgBcnZZwZCnKbRWO7XMuk35epvxDa
 gixwFoViwOCYz2Jzrnlq/CX8jMbFDiSce0aDe2cHqmJpsjNZ0B9uqBkAI+xMElZI9sxO
 3X6Cg86CiiN09OypZT5c1+xtKABx18AduMkSbgpv9Q/jN8y+d50zrMkEWeITE+cYgxy/
 w1cVl1Qe4R0+4xO459vgIRZuNtEq7D4d0ECq8OZW+UDvPpnLR16MlcJCMuqaZ+TOBY2R
 q6dEyap0Jnjo4CzCTlZMR2IW4EiavG70/bLYZ8G4fkFqxPMbSlnhBDjwyYXcb9XsFdqt
 06Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771569840; x=1772174640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IeL/h3q0xFKOJbLr/HDReueIN840huWo8F+fzoRQdT4=;
 b=Oqqluokzpie/ZV8KgQv/PG75CHwOciONpJ+YENEdurfH9TS/WAW2Hdc/E3gqLAqups
 uXo1DrG3goRg6l7ggIT2T6M8IeZMGwUJuVwCoVovZPGZj/nLHBPb+RCD4OhMinf4ik3N
 gL4k109TwCdU07wQbuj8Zf0J5yc+/md2vShB/ieCy7KNfoLQqhZ3dLHmZ3BDQ/4yPWoW
 QvH0x5GmCfUneq2Rs7JAh7M5EYS7KKO5Yb8ZagiFvA+VGXGn0TF/JoEYKlaw/LBMzn6q
 rApozVEAS2Pr1uyCFMVbrAyTegTaq+yb86PosF+asDRwxt3ijE2zm3MX9KOberhlX+8h
 3Mpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlLXjxgtducfF94yztR7VpsdXJ152jlmpYqT+AZRH6iVbYFP2W9tj5HwkVy8O3wYU06Z8jC4Swktda@nongnu.org
X-Gm-Message-State: AOJu0Yz3m9xFSaaeWeHTiVVPiRjTnYLXW8AyjLsdJdQmLUUgrQ3otA1l
 mU8VYHGVJRWWwB64hp3C8cQjH+MzUzQrKDRlHGIXt5ngLfoPcrdJ8a71U/tQYhB/dd4=
X-Gm-Gg: AZuq6aKzwVgerSEpAP8Y/8OTigL1l+Wc21wLA6DBaId/6KY1XzQr3muntb7Vb2B0C7/
 3/B+Rc6lI3oIB2qhoIjtVaMf2N2kCEsqnUYOsAczfYVjuEw14Y56M9JpUEqxQNyNoRhK7HrlsNa
 lGz0yOgOkJhImZQEwSEF7n5fwpZCvbYVViQfRgM44CVeubae5Xnv6xi7T0WZfFtW+brK0jNfr7/
 BY325H+YVUovCOZMXkXvEhiETu3yZjundJValLvmpQCxlP6zD63pV9X8SoCKrm9gFvfiz7QxRv8
 xxLm+wTJj/z3hIta4sNWE6GSrDeMnJsNmvd3iIk2B1CsqZIlWqSwuT5Kont+b9xZg69GdtbJjvZ
 ekSbTIa9LykPfyko2K3/tj7rM4dlA6b4rrRmRY03vmjBZ8xpvSAqUUv0bw/PHP/qnHY+O9DeCOI
 tpMsaPnREphwIFgLAm8f9HGY4yDNh/DKjvU6zj3QiKqTqWejSJHxJ3sQQsApw8OT8sVZAM4enOM
 nyNMw4Pitii1I3SS+LR5MTHXOcOjMpf7T5BfRDYVQ==
X-Received: by 2002:a05:7022:6629:b0:123:330b:3b5 with SMTP id
 a92af1059eb24-1276608097emr240796c88.30.1771569224801; 
 Thu, 19 Feb 2026 22:33:44 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12742cad9desm22997294c88.11.2026.02.19.22.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 22:33:42 -0800 (PST)
Date: Fri, 20 Feb 2026 14:33:07 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
	qemu-devel@nongnu.org
Subject: Re: [PATCH v4 8/9] fpu: Add conversion routines for OCP FP8 E4M3
Message-ID: <aZf-LVVwnzJ4RSiD@ZEVORN-PC.localdomain>
References: <20260205111622.461497-1-richard.henderson@linaro.org>
 <20260205111622.461497-9-richard.henderson@linaro.org>
 <aZKVxean7S9fkHHn@sifive.com>
 <695ae1da-8ca6-4966-87fa-5cd712cda59a@linaro.org>
 <aZfli2koayS41FRS@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZfli2koayS41FRS@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f41;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qv1-xf41.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Feb 20, 2026 at 01:44:27PM +0800, Max Chou wrote:
> On 2026-02-16 15:30, Richard Henderson wrote:
> > It doesn't feel right doing this here, because true overflow is handled
> > elsewhere.  This is re-packing a FloatParts for a given FloatFmt.
> > 
> > Perhaps parts64_float_to_float() would be the proper place for this, as
> > that's the conversion operation, and recognizing this overflow feels like
> > part of a conversion.
> 
> Hmm, I agree with you. Maybe we could add a new float_to_e5m2 similar to
> float_to_ahp and replacing the parts_float_to_float calls in
> float32_to_float8_e5m2/bfloat16_to_float8_e5m2.
> 
> +static void parts_float_to_e5m2(FloatParts64 *a, float_status *s,
> +                                bool saturate)
> +{
> +    switch (a->cls) {
> +    case float_class_snan:
> +    case float_class_qnan:
> +        parts_return_nan(a, s);
> +        break;
> +    case float_class_inf:
> +        if (saturate) {
> +            float_raise(float_flag_invalid, s);
> +            a->cls = float_class_normal;
> +            a->exp = float8_e5m2_params.exp_max - 1;
> +            a->frac = MAKE_64BIT_MASK(float8_e5m2_params.frac_shift,
> +                                      float8_e5m2_params.frac_size + 1);
> +        }
> +        break;
> +    case float_class_denormal:
> +        float_raise(float_flag_input_denormal_used, s);
> +        break;
> +    case float_class_normal:
> +    case float_class_zero:
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> 
Hi rnax,

This approach looks good to me. Adding a dedicated parts_float_to_e5m2
following the float_to_ahp pattern makes sense -- it keeps the infinity
saturation logic in the conversion path where it belongs, rather than in
the generic uncanon_sat repacking.

Thanks,
Chao

> Thanks for the feedbacks,
> rnax
> 

