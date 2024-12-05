Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC88E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 18:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJGQp-0003lq-8B; Thu, 05 Dec 2024 13:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJGQn-0003lX-PI
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:18:29 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJGQm-0003aD-5y
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:18:29 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-29e61fcc3d2so1191511fac.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 10:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733422707; x=1734027507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OvW+AoLKv7khBYjogVRnXYPZ9+tLmE67smJq3+Ckyxw=;
 b=QPln7iUGCaTPpe7N/+MzURrGLp1sArE4eZGdFf+Fy0ilYACXTmHM5ft+vIkCxYAvKG
 0bN+VuAJZjPrzdBSJ5CEef5iH0YGIyEUwxtH/FiaRl2vF1B3hLqACUlRR4+j5iWWhMh1
 LZwYyQCfJERmkwUOelZt8NLYioGkT4X3Lj6ilKxDugK2ml5gOzTwuNCNUP0j8ljkBi6k
 ukgSsB8UgunsVbYsjTr5URofGZvsiUR3NnTweZq8o4DcP17vxIUuKnADmqmfcPKuhUtC
 +w5hUH5f3cNc098hnlVzFw37fvK9becSVSnAy3nMRDH+PLHG9gm44yr3E83G7dyqlzR1
 ObTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733422707; x=1734027507;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OvW+AoLKv7khBYjogVRnXYPZ9+tLmE67smJq3+Ckyxw=;
 b=J/ceg0IKMzftEbGxM5nmSb/Qf0o74c4zAJBHqUu/c9KZ+g0dPKCdkI2qiFZE+kMMZ6
 JStA2PN/4/CRGlYvZ6l8uuphh9XHn8UZ3vGIpRH+P5c6ZCXIpegevfvl+OXNFlg6aqM5
 i08eW5e0Inu5qICIVQeRvFs6fn+eAejr4f1qHuO+RaQB2uZrFa+H/K/nLptiVSZ1r/CH
 9yBJPy59etXkYuT1SrbQ5a2T9WJgg3FMJBy8gbMw43+MTrbdp3o6220BI3AgRiM4+Mk6
 tdPAYIaL+knV1Y1BxZaB/fUomiwYovdjl3jkkBPz3t7w5nhUKPFYN4Nwp6J84nOUzJIe
 REug==
X-Gm-Message-State: AOJu0YyFjwJBXP7p5XubGyF0en23rbj/T9d04ruS+/CPtZRwo83oDriu
 tBL4g6ZgiaXtGDGt3rXLrKPihP2CsEqqe07BBvchMjJ68pYCwnSXbJYmLDk3LJ0=
X-Gm-Gg: ASbGncv0vWAkdiaZbiFMofqXG2RKG6wOE6y0u8JSdj5Slhiz3k+WO4XVs3xfZTL49EE
 M0I+Fuop951rUAcQfbD29MDj10XegvUNSRdJc4UpU/nh/ynxrZetHXgDdPGTOKFzVA9twPTu60w
 WqxF76eH2GapZHY0M+WGTFflrux59BZvzdDh+LkXPuB+3fIDYz686JmLKtgGQ+Oj49Ta+hpXeq4
 p2+nj0fl+pzKcM14iJ2H60DQSXCCHWraKyPDQ+9b/wVCpb8x/DL4x7iv9kpyCgrleUHWXxUcP3/
 pNSljbl6lW9klui33xphdJ/9gAS2
X-Google-Smtp-Source: AGHT+IH6hz6vVkAApltL6NLxWhz4VChjsDF15qLCj4QcuhLmWYDlnnHc+SLTuk592+nw+jE+rSzZ4w==
X-Received: by 2002:a05:6808:1482:b0:3e6:5792:2fb1 with SMTP id
 5614622812f47-3eae4f2f567mr13867097b6e.10.1733422706758; 
 Thu, 05 Dec 2024 10:18:26 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb077f4235sm398319b6e.34.2024.12.05.10.18.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 10:18:26 -0800 (PST)
Message-ID: <cc6cc13d-ec95-45d2-8722-e12f3b82ff92@linaro.org>
Date: Thu, 5 Dec 2024 12:18:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 07/13] rust: add bindings for timer
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-8-zhao1.liu@intel.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241205060714.256270-8-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

On 12/5/24 00:07, Zhao Liu wrote:
> The bindgen supports `static inline` function binding since v0.64.0 as
> an experimental feature (`--wrap-static-fns`), and stabilizes it after
> v0.70.0.
> 
> But the oldest version of bindgen supported by QEMU is v0.60.1, so
> there's no way to generate the bindings for timer_new() and its variants
> which are `static inline` (in include/qemu/timer.h).
> 
> Manually implement bindings to help create new timers in Rust.
> Additionally, wrap timer_mod(), timer_del() and
> qemu_clock_get_virtual_ns() as safe functions to make timer interfaces
> more Rust-idiomatic.
> 
> In addition, for timer_new() and its variants, to convert the idiomatic
> Rust callback into a C-style callback QEMUTimerCB, introduce a trait
> QEMUTimerImpl. For any object needs to initialize a new timer, it needs
> to implement QEMUTimerImpl trait and define a handler.

It might be cleaner to move all of those static inline into timer.c.
I don't see anything performance sensitive there...


r~

