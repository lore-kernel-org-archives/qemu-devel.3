Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF5EC3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0uV-0002kt-Ku; Mon, 05 May 2025 14:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0uT-0002k3-40
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:51:25 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0uR-0007C4-Bt
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:51:24 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2240b4de12bso77597455ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746471081; x=1747075881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DAxYYa+f57aHAbvNw+rs3kNliEbilY3GCs1FN1ZlFHk=;
 b=uuVmpXWgxknq5FfVuyL9rSOkeHDjkV0bqFBbjCmiBzLE9E9qlsO2Se7ov6mbfFUcRe
 T6G7OShJFylL5K8DcR++rM4e2V4V8yHBfrEH8D+2DupI1uY6k+0i08JSjYDrtienR0+Z
 t3jxeZqOlDICHhITVW+caHhwtccLyO94mE86QXdLyvxbOCj5rnj2o8t08OmkAmL2vb/e
 qtX8L8pvf1KrN7q8MYmN6F4Lj9B2oXxtPe2YTO0HFGIDbNNFnAC+eJRF0ZDQ8iLYM0SE
 tU+uVwGf3Fv0SbVSmTXMLxNqw1Fcltns7WRAncmI3vu/pLuCbHUkU/lC0e+7UrKe2pmz
 HgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746471081; x=1747075881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DAxYYa+f57aHAbvNw+rs3kNliEbilY3GCs1FN1ZlFHk=;
 b=WuUAlIGu3v+ndaTgUAAcwb2M94ChdB18r6HxlT8SFE1EhV2zQnXOvLED3TVhrEJgfV
 IbjHSZiwIT6SMzoHnhoU1dFxjA/ME+TYhJ8kKQOABwywrNIyENJi90XOZZfeI9b8IPBg
 u9EyuXzNGO5COOA60vFW2YRBskGl/PlWO63h0J1upn4RgImOoTnvxoYb/0BpyPhTJNW9
 JtPslQXmZPklPiEYMPuhWJ8w2rdC3vGBDga8i4hDcsM4KTFmOjagTtIuudoGsDi2rNAQ
 9zAcNrB5Xb3b1o0SLCOQw/7stGyb0cdhpY2ycYA8Z/SGBAgsuToYQdiBE+FXrI2SK8Vp
 ZxeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2K9uziBPY/bZF8vmMk+sJljd7g1J4dQgk1h1KDUIAP5FKwdPkz6I+jDd/xKOe+jC6L6IEcon34I1g@nongnu.org
X-Gm-Message-State: AOJu0YxuGWd4UamiiNBDgAd7jBlql47bR3UVVUvdtkiBRtI+0H0rf7dG
 cjT/RjTH0k9XGG19iyiXidg44I4E5wZ4PiWjIRhCurwnpxYOWi70M8bcZDRO9RQ=
X-Gm-Gg: ASbGncujl5VbVbNEArsZT5TssyIxAMELHbD908I/8tFqt5PQ/E3Je9Q8Ke537V0C/2P
 vzDBw10t0MiP0tOjpIS+7imxWL6hZs9D3C+tYQ7QEvzC3ZLuYzbb+SwNnhyyZaODr5uhijPPYUn
 YVnLhNCXYVixsGRbHkUw6K4JyrJsnd8d2SF0v+KxPkSV68mOifVvMl4GtbFN0SGIE8P+THgzsOR
 DzCMsQlUxgu6TxN6rhKdSekxrKs2Rdzwu4Ll2Kp0w1QLRJFdOUT5488lUxe/nqC6EveKGIhEMO3
 YHfx3YMblkjBsJKArBrXiJm6ffhrlnTcmQRdCs/IJNpWR6NQe9d7W5DxccYj1z3mHY92C8iJoGX
 5hCgGO5c=
X-Google-Smtp-Source: AGHT+IH+lsN7TStKXBftqejfHAZR2ZE9pmBQGgu41g9SizVP17mMAL4qD/r2wuGLYimKJYKg/Xf2bQ==
X-Received: by 2002:a17:903:2447:b0:223:f9a4:3fb6 with SMTP id
 d9443c01a7336-22e328a3394mr7213785ad.11.1746471081585; 
 Mon, 05 May 2025 11:51:21 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522952csm58581155ad.185.2025.05.05.11.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:51:21 -0700 (PDT)
Message-ID: <c67c4a79-7855-4d15-8064-b2f448ac9a42@linaro.org>
Date: Mon, 5 May 2025 11:51:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 41/48] target/arm/tcg/crypto_helper: compile file twice
 (system, user)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-42-pierrick.bouvier@linaro.org>
 <79916f8d-2793-40a7-b769-ee109c52ef63@linaro.org>
 <f33fa744-1557-4c01-ba49-e64b4d3b6368@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f33fa744-1557-4c01-ba49-e64b4d3b6368@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 5/5/25 11:47, Pierrick Bouvier wrote:
> On 5/5/25 11:38 AM, Richard Henderson wrote:
>> On 5/4/25 18:52, Pierrick Bouvier wrote:
>>> --- a/target/arm/tcg/meson.build
>>> +++ b/target/arm/tcg/meson.build
>>> @@ -30,7 +30,6 @@ arm_ss.add(files(
>>>      'translate-mve.c',
>>>      'translate-neon.c',
>>>      'translate-vfp.c',
>>> -  'crypto_helper.c',
>>>      'hflags.c',
>>>      'iwmmxt_helper.c',
>>>      'm_helper.c',
>>> @@ -63,3 +62,10 @@ arm_system_ss.add(files(
>>>    arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
>>>    arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
>>> +
>>> +arm_common_system_ss.add(files(
>>> +  'crypto_helper.c',
>>> +))
>>> +arm_user_ss.add(files(
>>> +  'crypto_helper.c',
>>> +))
>>
>> Could this use arm_common_ss?  I don't see anything that needs to be built user/system in
>> this file...
>>
> 
> It needs vec_internal.h (clear_tail), which needs CPUARMState, which pulls cpu.h, which 
> uses CONFIG_USER_ONLY.

Ah, right.  I didn't see that coming.  :-)

> I'll take a look to break this dependency, so it can be built only once, and for other 
> files as well.

Thanks.  Building twice is still an improvement, so for this set,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

