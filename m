Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A69103E2E8
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 22:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0RyM-0005DJ-Pv; Wed, 11 Mar 2026 18:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0RyL-0005Ca-Ej
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 18:24:09 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w0RyJ-00072j-R6
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 18:24:09 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-8cd8576a512so155563485a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773267846; x=1773872646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xuVOSGMFCt+MSxA46iiqDcqmlQbYvK5jCiLGJ/N5wEY=;
 b=k1F0YCqXqQAgoi6DsVVm2P8yJtyfZOa7K7g71iyMbEatdlH+NrS8EEHvjR1pB8HFd2
 zwNmMktDJQ5JOcH8tUoR+FBRaf3hM5JLpoyO4h2TNctMxp9o5Su0lB5K2T0k5JDCa7fW
 nVuywWTMFfbvg2moJ2xilLqlPT4RjfnGjAVHvMqEOta+vsViH+9VhGMMPBvhedUeQ+/K
 bJRWhwXQQMbGzME/gWwq9brJaQeRrpq/yUE9ucl8IUuZ64CXryEFuieJxd5eIL9qY+Cy
 0vyRm3YMsBRnyVZSSg9apiPSN06ozavB1pL8Op4nrdz6pP1sx2q0V4Vj05UlLpJa/usD
 sF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773267846; x=1773872646;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xuVOSGMFCt+MSxA46iiqDcqmlQbYvK5jCiLGJ/N5wEY=;
 b=vUnpBdvibIH+w+XBz6SvnFMbP1Le1R4inGmlzqoojTkHp+6ezwPPWs+vwfSL/swjB2
 8EIJgCLJhbi0ew4qyXh6zhpfQtq5g4HjOJ06GqJ1DsbyAfsSLIO2kkPrqwB5QfsgY902
 BP9KulQToWCbIsHT5DUSsb81Go3xfbiHO49s2IW3pCRw77SjS94gWY3suDlwndsnjHl0
 DU0b1kAGB4rI5POstb7HHagodQHmc6EgUDuo4y4exK+ju0LIZ1XmBAkEeHytkF0gq8qW
 dUZRyuba9fN7zLa4kPBUFx+qZRX5Y2vRk5LDjdKmYA5IVrGsN5yYQZK3YrrwlZdoPaJn
 OrSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhIFhvbYLflvlnI6RBOohJMf+F5o7AUcaQFZRQQ6q3zzIQKYJaKI8A9L5tPFd0muP6JY4I4o78Ys88@nongnu.org
X-Gm-Message-State: AOJu0YzLTRCtG8PKBSGSrCiJRKDrxjjatlzDH/c3Smq3g6k9ozSZK8Bb
 +DlFoYVdTuZzfFPAiUOB92fpxkBduOLaI3/8u2082MZLojF4uM9+DAPTekybk9xBZg4=
X-Gm-Gg: ATEYQzzUvNxJivBwKGJrgXI6UnY8fTZZctoGuzSorwh+kdtoRK4D9JLEx5yJ7ui0YTU
 AivZdxamSbBuYbMbEvFt+OiMBiCO81puRHlRiANAdRmw5RVwhtaeLuTXBiltqa17nSWFJqbgjK4
 Uz9+efF1pJ6PND7TypbqcrCJnlpyUkaQFVt9272ao0C/plsiAbO21oejBrcnVLFqmNepgpVtgjJ
 dpiPnSdOg6yQNSGSDqcf3dXtWoOE40nLrOaBHqfr8krcN8Yz8FA0wEgfCuQmI73BAM2yyDgd/6Z
 2A2WKuzjhPZnjjCPi7SMmec8RDa0hhEastxNe2iKzGp85KGiP23nlosgRVd+sn/EPFNMGFkUYL/
 SkoM9r3qQffcUkYU+a3USais5QwH6jbXwMrZnUmIleVWx6Z7MPYKpWcG/jW7prWNC3L1DVB316b
 VvXXA3+LKRD44bHh9JG+kbqa1xKUnPeGsgtLUrWAcrsRRhuNHBs3+aUbGE+kiUFR6ijECH
X-Received: by 2002:a05:622a:50d:b0:509:1342:b213 with SMTP id
 d75a77b69052e-509471bf32bmr18536351cf.12.1773267846274; 
 Wed, 11 Mar 2026 15:24:06 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50939ec5017sm20351841cf.8.2026.03.11.15.24.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 15:24:05 -0700 (PDT)
Message-ID: <0b4976f9-cf83-47b4-8f00-cc68c9cf47fd@linaro.org>
Date: Wed, 11 Mar 2026 15:24:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/virt: add serial-debug-level property for EDK2
 firmware
Content-Language: en-US
To: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Oliver Steffen <osteffen@redhat.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260311-edk2_arm_serial-v1-1-c25e237116f3@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260311-edk2_arm_serial-v1-1-c25e237116f3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-qk1-x736.google.com
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

Hi Luigi,

On 3/11/26 6:43 AM, Luigi Leonardi wrote:
> Add a machine property to pass a debug level to EDK2 firmware via the
> device tree. The value is set as an "edk2,debug-level" property on all
> pl011 UART nodes.
> 
> This is to create a runtime parameter to set the verbosity of the debug
> log on the serial ports in edk2. Currently, the only way to set the
> verbosity is a compile-time option.
> 
> DT is used because the fw_cfg interface is not yet initialized in early
> boot phases.
> 
> Corresponding edk2 PR: https://github.com/tianocore/edk2/pull/12277
> 
> Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
>   docs/system/arm/virt.rst |  6 ++++++
>   hw/arm/virt.c            | 38 ++++++++++++++++++++++++++++++++++++++
>   include/hw/arm/virt.h    |  2 ++
>   3 files changed, 46 insertions(+)
> 

I am not sure if maintainer want to have bootloader specific options in 
machine code.

Alternatively, it's possible to dump virt dtb, modify it, and pass it.
$ ./build/qemu-system-aarch64 -M virt,dtb=file.dtb
$ ... modify dt ...
$ ./build/qemu-system-aarch64 -M virt,dtb=file.dtb

It has the advantage to be extensible to any other kind of options you 
want to pass through dtb without needing modification on QEMU itself, 
the downside being that it's less convenient than a command line option.

Regards,
Pierrick

