Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D28C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 16:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcRgH-0005cX-1r; Mon, 27 Jan 2025 11:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcRg8-0005ZG-U5
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 11:09:37 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcRg6-0000tM-He
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 11:09:36 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21631789fcdso74700835ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 08:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737994172; x=1738598972; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f3QTHmPAhowMukrsYcWPYxiCfkmRNsHsmavbE0w8Arg=;
 b=WXE9xiGlqbgHQuoLIqfBc6FXXxKhpFcGgJ8LHoXbkvbQXo+j6Xc1F7KkoTTk98xmda
 3w95Xpaatp8kPKucUIvEwq8MgEa1eJsTVsbTpTmk8PK7J5cTYYzoXgWgdTK+rRVKTJno
 mg9+wzq4iQ+qpQkl/FPzDay3iMRw73xsNmL14xuamnmZCDAmgInwW35G59VeIIYGGvsH
 HaJUf1/oDDpt8Por73XdmYOw9J2Ic8qE8LnqMuMOrhY+z5G8pRwJxLRJe8RABXyMk5ab
 3I5ltI5Xa5Dc6F1nx0A0KM/WfdLu/331TtVxg2Fi1ufYIUZZSia8zNIw3yXBcew3yJjO
 xOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737994172; x=1738598972;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f3QTHmPAhowMukrsYcWPYxiCfkmRNsHsmavbE0w8Arg=;
 b=QdbzNr1+rSLEzoGuSjafjdEkVvToJf+5KwOekTXiocVIKfgV4tMFgq5fVinh1g7/Cz
 BQXPMAIaNeNKFxs/sbvUY+Hwm5/Icu1AeIXMFtWrTemOJ+ReIc09rEmqxr+I0SbKndHj
 tWr06cudU8vNtY2feCbizQtguw1jrD9RVGZEmn7Ro7mkxoQihHiWbngKjMJI/9VHD0LF
 5Gg4xRCSfhSoGSMBRsWn/u6obB1TarNdOhqzX18QFcrN1fy6qttzmChBaTDukqlIi8Yd
 ueaq6KOfvHYQbX8nCthBGQ988kz9CsbNtjikOd+XrEeVdZjVTh/f7lRZxykA6V8QZDP3
 kC/A==
X-Gm-Message-State: AOJu0Yz6FbFivXSEMI/3doZ4NA3KfdA21ncRyii9uAXx1h5PgjAZ07W2
 1hITdQ/hLUKtftTpLY/rioaAVyTBBG2NAsiSVjsE7l3WcKV9yJPpsZ7vH9Fwrfk=
X-Gm-Gg: ASbGncvtwCZX3dDkXCyusWKT/Y5Cv+NMCwTkYne6xf/TfhrUS7IQfd7EotM/ppPbO6H
 H5R2TGvwGn6RDTeF5cg7fFantJnLYrp1jgPNh4FQn0NfaOt/2hVwaAw1m+U4LVcFKQlINwu7Odj
 fYG1S3S9ctYr/q/zf875dtxo9NqLmVfcp9iIAPYA1JvMLlwI3vxu+4cGvWdKHjzJK+geu4LHelu
 qD6kh2+7P7OXoDlYcbWrE0slGaUO3H45VrLO2s52JcFFiwnMs0g3y1C9zjJ6oW1W5HZeFvC72Ji
 4XDRJuhsEPv1roAU1fFYWu+mzIetNd3il/+5rHdDkiSV29c=
X-Google-Smtp-Source: AGHT+IEb+2o+9dPoLqHZ6B/dzd+3YkEkCZaN0lP/gtxLxADkynX7e3CIzhtSaJW6bzgXQqDdrF6fmw==
X-Received: by 2002:a05:6a21:1fc5:b0:1e2:2e4:6893 with SMTP id
 adf61e73a8af0-1eb696e1108mr28962898637.9.1737994172333; 
 Mon, 27 Jan 2025 08:09:32 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a78f317sm7508936b3a.176.2025.01.27.08.09.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jan 2025 08:09:31 -0800 (PST)
Message-ID: <2f7fc713-2e56-4d68-80c4-99db8f6aa9e7@linaro.org>
Date: Mon, 27 Jan 2025 08:09:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/76] fpu: allow flushing of output denormals to be after
 rounding
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-25-peter.maydell@linaro.org>
 <d8d04708-ddc2-476e-9e17-8493f573d7a5@linaro.org>
 <CAFEAcA9c2WKA+z8d=Hp6Jp+3PYqQ5wuCxWL_fGzQxRfJKn+jEQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9c2WKA+z8d=Hp6Jp+3PYqQ5wuCxWL_fGzQxRfJKn+jEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/27/25 02:01, Peter Maydell wrote:
> On Sat, 25 Jan 2025 at 16:42, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 1/24/25 08:27, Peter Maydell wrote:
>>> Currently we handle flushing of output denormals in uncanon_normal
>>> always before we deal with rounding.  This works for architectures
>>> that detect tininess before rounding, but is usually not the right
>>> place when the architecture detects tininess after rounding.  For
>>> example, for x86 the SDM states that the MXCSR FTZ control bit causes
>>> outputs to be flushed to zero "when it detects a floating-point
>>> underflow condition".  This means that we mustn't flush to zero if
>>> the input is such that after rounding it is no longer tiny.
>>>
>>> At least one of our guest architectures does underflow detection
>>> after rounding but flushing of denormals before rounding (MIPS MSA);
>>
>> Whacky, but yes, I see that in the msa docs.
>>
>>> Add an ftz_detection flag.  For consistency with
>>> tininess_before_rounding, we make it default to "detect ftz after
>>> rounding"; this means that we need to explicitly set the flag to
>>> "detect ftz before rounding" on every existing architecture that sets
>>> flush_to_zero, so that this commit has no behaviour change.
>>> (This means more code change here but for the long term a less
>>> confusing API.)
>>
>> Do we really want flush_to_zero to be separate from ftz_detection?
>>
>> E.g.
>>
>> enum {
>>     float_ftz_disabled,
>>     float_ftz_after_rounding,
>>     float_ftz_before_rounding,
>> }
> 
> I did consider that, but on almost all targets the "before
> or after rounding" setting is constant for the life of the
> emulation, whereas turning ftz on and off via a status register
> bit is common. I preferred to leave it so that you could continue
> to write:
>   set_flush_to_zero((vscr >> VSCR_NJ) & 1, &env->vec_status)
> or whatever, rather than having to switch to
>    (vscr >> VSCR_NJ) ? float_ftz_before_rounding : float_ftz_disabled.
> which in addition to being more longwinded also means that the
> "is this architecture ftz before or after rounding" setting is
> scattered in multiple places, wherever it turns FTZ on or off.

Fair.

> And for Arm it gets more awkward, because the FZ bit is
> "turn FTZ on or off, whatever its current semantics are", so
> you end up needing "FZ ? AH ? after_rounding : before_rounding : disabled".

Ah, yes.


r~

