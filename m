Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26954C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kkA-0000ip-78; Thu, 10 Sep 2026 15:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4khp-0000Au-5K
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:45:21 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x4khL-0008KW-Ng
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:44:43 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-39b2ad862bdso137923a91.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789069464; x=1789674264; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n+dJEKORJhIMxt95me6KAeOxHeKg6m7y2A3xNtesxlg=;
 b=jJLgSQ2m6wE0gaorWn3jWlRUf2qwLzZyT4xYjU/rb94jSzQDe3Ld3qTj1vI8Z7x10q
 wFZld35yI1Pd8LGuySXGXm+VJMPu9C9C16Klhlcr5QTiXmkieItBzs8mxSFHVCJxkcJD
 tzSbf+ewvfjLkQlKBdjFDbUK0W4YIobQ+5cBN+3AMaGRYsegJ7RxarO/dLeCWdkGA1SK
 F2rShyNuMAsilkujoHB9TVUQTqk2Z1neTF+if7WcXu5WUIgiXrg0o5QKyVK1h6gcprcA
 BhX4uyp6pv0YJuqOkaGv+1DwIOgSJZUzP/us//Q3HPTuecaz65TFggtPrhpLUDnhJHX0
 GdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789069464; x=1789674264;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n+dJEKORJhIMxt95me6KAeOxHeKg6m7y2A3xNtesxlg=;
 b=hNyksJMlsRRrcYqBp8ijMHdsmOt7uXhDvHyWvJcNZ4zlxwRHcoOQlXrGYIeXntb9Mb
 Vv4+qHlf2bdg9KXusglMbE6hAtmOA+0ZJAp0XabIhKAYQALXSL0HLGVleE3PmvtzuDcQ
 kHaXUYQ9Vwj8QEvGWZ0Rz22ZKA27KjCzr0s9t9zqF27hB9pjutWPZIsGHKbIqKwi6if3
 2Eyg4rXF+Fd868xFe8SCb+UbGi28CDdcvGE7wwHJexQjI5xo70EShQBCaRLMt6M/kuZ6
 o/S4wC3px3pJVsopQ3Vyusd3t34LELlLHRyMAAPzxJj6uVcjjbCmVtA+HLZ6Yyws6KBs
 rIiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEpDimJsbOwyxDbAcvom/EQho/9pZSiQGInUqfCuG9S1rZZEjhfntSaseKRtcGeMx6U7aO4VeJ/HIx@nongnu.org
X-Gm-Message-State: AFuF++kNxFf+7V5Hg7EpQh/wtme8Ar3MCq+1dZ35vuv7zsibxSdPEFdF
 rnyuJ184cpKxdrPpIFfD1vlAWIITQlaxGUV6g0sik4H9/0UJPivi5ddYSih6L/3DqzE=
X-Gm-Gg: AYBFou2LLTDhaDhuc9oPfV86z2oLGmfW6o7sLHEK7zZ7NS2dUbSL8VJbOlzW6k/jBU1
 8BNn/EW727u3vGiRTWprB9r47sl9IADHadqpPkb1cl2+DUFonPNPHTO8dsasXdYK0a/45Jg+sUj
 RkvRZibh5qUTJRfLpNX092kZ9zVdTKPMgY1iDyeqbONFCyhbemIQ0YINpWqKZ+69Uf6ehRmvugv
 LT86Ol+0Tr8J9oj4Pp++I4quA4Nz5a+fN1I6US8gI9LEFYFYQGvrwBfddHtUMJl3BSKdGeplmzu
 yhBzA6+XZDGjo9xZEW9ecliO3gmIlYI1rfPgHPGRyLzweGhBgBD9WDrpJuyzxdwTtP/60fHXE+D
 HKQ/+dmQtUEJHCD/HCjd6BipEOz2Nk1ee6FuKdCVwuqeMwuEiS7G5Hkgylchc7LaRwFteXMW5T6
 aofQVqVYzntJxCiM8cBLCQAjLJmB5SfgO4KoWk3JoD0xUAKtT3S8CmLj4YGClASATqcM2Ov0UVi
 me3A9cdiCzSv30=
X-Received: by 2002:a17:90b:1d46:b0:38e:fea2:df53 with SMTP id
 98e67ed59e1d1-39d9bbdc30dmr530821a91.4.1789069464507; 
 Thu, 10 Sep 2026 12:44:24 -0700 (PDT)
Received: from [10.171.0.227] ([98.155.112.169])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f5833fsm323646eec.23.2026.09.10.12.44.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2026 12:44:24 -0700 (PDT)
Message-ID: <711ce570-2c09-44ac-8e0a-59da60f7a39d@linaro.org>
Date: Thu, 10 Sep 2026 09:44:20 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/21] target/arm: Constify CPUARMState for various
 cpu_*() getters
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
 <20260901095229.72018-7-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260901095229.72018-7-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 8/31/26 23:52, Philippe Mathieu-Daudé wrote:
> Add the const qualifier to CPUARMState when the
> argument is accessed without modification.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
> Ignoring one checkpatch.pl warning:
> 
>    WARNING: line over 80 characters
>    #116: FILE: target/arm/cpu.h:2277:
>    +static inline ARMSecuritySpace arm_security_space_below_el3(const CPUARMState *env)
> 
>    total: 0 errors, 1 warnings, 789 lines checked
> ---
>   target/arm/cpu.h           | 55 ++++++++++++++++----------------
>   target/arm/internals.h     | 65 +++++++++++++++++++-------------------
>   target/arm/helper.c        | 41 ++++++++++++------------
>   target/arm/tcg/debug.c     | 18 +++++------
>   target/arm/tcg/hflags.c    | 35 ++++++++++----------
>   target/arm/tcg/m_helper.c  |  8 ++---
>   target/arm/tcg/op_helper.c |  2 +-
>   7 files changed, 114 insertions(+), 110 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



